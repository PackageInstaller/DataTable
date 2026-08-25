local BpRewardState = CommonDefine.BpRewardState
local MAX_SHOW_REWARD_NUM = 4
local CompBpRewardGroupItem, Super = NewViewComponent("CompBpRewardGroupItem")

function CompBpRewardGroupItem:ctor(uiNode, view, data)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Passport_Goods_ItemResource(uiNode)
  self.level = data.level
  self.isPreview = data.isPreview
end

function CompBpRewardGroupItem:OnEnterComponent()
  self:_RefresRewards()
end

function CompBpRewardGroupItem:_RefresRewards()
  self:SetText(self.ui.Text_Grade, self:_GetTextGrade())
  self:SetActive(self.ui.Image_Full, self:_CheckIsExtraReward())
  self:SetActive(self.ui.Image_Prohibit, not self:_GetImageCurrentVisiable())
  self:SetActive(self.ui.Image_Current, self:_GetImageCurrentVisiable())
  self:SetActive(self.ui.Image_Finish, self:_GetImageFinishVisiable())
  if self:_CheckIsExtraReward() then
    self:_InitExtraReward()
  else
    self:_InitCommonReward()
  end
end

function CompBpRewardGroupItem:_InitExtraReward()
  for i = 1, MAX_SHOW_REWARD_NUM do
    self:SetActive(self.ui["Image_Goods_" .. i], false)
  end
  local itemObj = self.ui.Reward_5
  local extraRewardNum = BattlePassDataUtils.GetExtraLvAwardNum()
  local extraRewardTid = DT.GetConstant("ExtraBPLvAward")
  
  local function clickFunc()
    if 0 == extraRewardNum then
      ItemDataUtils.ShowItemDetailTips(self.binder, itemObj, 0, extraRewardTid, true)
    else
      BattlePassDataUtils.ReqOnGetExtraAward()
    end
  end
  
  local function redFunc()
    return 0 ~= extraRewardNum and "red" or nil
  end
  
  local viewData = {
    itemTid = extraRewardTid,
    clickFunc = clickFunc,
    itemCount = 0 ~= extraRewardNum and extraRewardNum or nil,
    isShowRing = 0 ~= extraRewardNum,
    redFunc = redFunc
  }
  self:AddViewComponentOnce(itemObj, CompPublicIconItemType2, viewData)
end

function CompBpRewardGroupItem:_InitCommonReward()
  local showLevel = self:_GetShowLevel()
  for i = 1, MAX_SHOW_REWARD_NUM do
    local bpRewardData = BpRewardModel.Instance.bpRwardList[showLevel][i]
    local itemObj = self.ui["Reward_" .. i]
    local itemParentObj = self.ui["Image_Goods_" .. i]
    self:SetActive(itemParentObj, bpRewardData)
    if bpRewardData then
      local state = self:_GetState(bpRewardData)
      local viewData = {
        itemTid = bpRewardData.tid,
        itemCount = bpRewardData.num,
        isGot = state == BpRewardState.HaveReceive,
        isLock = table.contains({
          BpRewardState.LockByLevel,
          BpRewardState.LockByMoney
        }, state),
        isShowRing = table.contains({
          BpRewardState.CanReceive,
          BpRewardState.LockByMoney
        }, state),
        redFunc = function()
          return state == BpRewardState.CanReceive and "red" or nil
        end,
        clickFunc = function()
          if state == BpRewardState.CanReceive then
            local bpGetRewardProtoData = {
              tid = bpRewardData.tid,
              privType = bpRewardData.bpRewardType,
              level = showLevel
            }
            
            local function CheckEnergyOver()
              local energyItemId = DT.GetConstant("EnergyItemTid")
              local energyItemNum = bpRewardData.tid == energyItemId and bpRewardData.num or 0
              if energyItemNum > 0 then
                do return GetEnergyCheckUtils.EnergyIsOverMax end
                return GetEnergyCheckUtils.EnergyIsOverMax, energyItemNum
              else
                return false
              end
            end
            
            local function ReqReceiveRewardSingle()
              BattlePassDataUtils.ReceiveRewardSingle(bpGetRewardProtoData)
            end
            
            if CheckEnergyOver() then
              GetEnergyCheckUtils.TipsShow(ReqReceiveRewardSingle)
            else
              ReqReceiveRewardSingle()
            end
            return
          end
          ItemDataUtils.ShowItemDetailTips(self.binder, itemObj, 0, bpRewardData.tid)
        end
      }
      self:AddViewComponentOnce(itemObj, CompPublicIconItemType2, viewData)
    end
  end
end

function CompBpRewardGroupItem:_GetState(bpRewardData)
  do return BattlePassDataUtils.GetRewardItemState, bpRewardData.unlockLevel, bpRewardData.bpRewardType end
  return BattlePassDataUtils.GetRewardItemState, bpRewardData.unlockLevel, bpRewardData.bpRewardType, bpRewardData.tid
end

function CompBpRewardGroupItem:_GetShowLevel()
  return self.isPreview and BpRewardModel.Instance.nextLargeRewardLevel or self.level
end

function CompBpRewardGroupItem:_GetTextGrade()
  if self:_CheckIsExtraReward() then
    do return LT.Text end
    return LT.Text, "BPExtraLvAwardTxt", nil, nil
  end
  local showVal = self:_GetShowLevel()
  do return string.format, (LT.Text("BattlePassLevel")) end
  return string.format, LT.Text("BattlePassLevel"), showVal
end

function CompBpRewardGroupItem:_GetImageFinishVisiable()
  if self:_CheckIsExtraReward() then
    return BattlePassDataUtils.GetExtraLvAwardNum() > 0
  end
  return not self.isPreview and BpModel.Instance.showLevel == self.level
end

function CompBpRewardGroupItem:_GetImageCurrentVisiable()
  if self:_CheckIsExtraReward() then
    return false
  end
  return self.isPreview
end

function CompBpRewardGroupItem:_CheckIsExtraReward()
  return self.isPreview and BpRewardModel.Instance.isRewardList2Tail
end

return CompBpRewardGroupItem
