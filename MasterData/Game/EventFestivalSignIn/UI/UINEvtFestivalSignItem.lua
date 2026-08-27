local UINEvtFestivalSignItem = class("UINEvtFestivalSignItem", UIBaseNode)
local base = UIBaseNode
local TaskEnum = require("Game.Task.TaskEnum")
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")
local CommonRewardData = require("Game.CommonUI.CommonRewardData")

function UINEvtFestivalSignItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.Btn_IsCompleted, self, self._OnClickPickReward)
  self.ui.uINBaseItemWithCount:SetActive(false)
  self.rewardItemPool = UIItemPool.New(UINBaseItemWithCount, self.ui.uINBaseItemWithCount)
end

function UINEvtFestivalSignItem:InitFestivalSignItem(signData, signAwardCfg)
  self.signData = signData
  self.signAwardCfg = signAwardCfg
  self.ui.img_Day:SetIndex(signAwardCfg.day - 1)
  self.rewardItemPool:HideAll()
  for k, awardId in ipairs(signAwardCfg.awardIds) do
    local awardNum = signAwardCfg.awardCounts[k]
    local itemCfg = ConfigData.item[awardId]
    if itemCfg == nil then
      error("Cant get itemCfg, id:" .. tostring(awardId))
    else
      local rewardItem = self.rewardItemPool:GetOne()
      rewardItem:SetNotNeedAnyJump(true)
      rewardItem:InitItemWithCount(itemCfg, awardNum)
    end
  end
  self:UpdUIFestivalSignInItem()
  local pickRewardBgColor = signData:GetEvtSignPickRewardBgColor()
  if pickRewardBgColor ~= nil then
    self.ui.img_isCompleted.color = pickRewardBgColor
  end
end

function UINEvtFestivalSignItem:UpdUIFestivalSignInItem()
  local state = self.signData:GetReceiveState(self.signAwardCfg.day)
  local canPick = state == TaskEnum.eTaskState.Completed
  self.ui.Btn_IsCompleted.gameObject:SetActive(canPick)
  local picked = state == TaskEnum.eTaskState.Picked
  self.ui.isPicked:SetActive(picked)
  self.ui.pickedMask:SetActive(picked)
  if picked then
    for k, item in ipairs(self.rewardItemPool.listItem) do
      item:CloseGreatRewardLoopFx()
    end
  end
  local cantPick = not canPick and not picked
  self.ui.isNormal:SetActive(cantPick)
end

function UINEvtFestivalSignItem:_OnClickPickReward()
  if not self.signData:IsActivityOpen() then
    local signWin = UIManager:GetWindow(UIWindowTypeID.EventFestivalSignIn)
    if signWin ~= nil then
      signWin:FestivalSignOutOfDate()
    end
    return
  end
  if self.signData:GetReceiveState(self.signAwardCfg.day) ~= TaskEnum.eTaskState.Completed then
    return
  end
  self._OnPickCompleteFunc = self._OnPickCompleteFunc or BindCallback(self, self._OnPickComplete)
  NetworkManager:GetNetwork(NetworkTypeID.EventNoviceSign):CS_SIGNACTIVITY_Pick(self.signData.id, self._OnPickCompleteFunc)
end

function UINEvtFestivalSignItem:_OnPickComplete(objList)
  self:UpdUIFestivalSignInItem()
  if objList.Count == 0 then
    error("objList.Count == 0")
    return
  end
  local rewardDic = objList[0]
  local rewardIdList = {}
  local rewardNumList = {}
  for k, v in pairs(rewardDic) do
    table.insert(rewardIdList, k)
    table.insert(rewardNumList, v)
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
    if window ~= nil then
      local CRData = CommonRewardData.CreateCRDataUseList(rewardIdList, rewardNumList)
      window:AddAndTryShowReward(CRData)
    end
  end)
end

function UINEvtFestivalSignItem:OnDelete()
  self.rewardItemPool:DeleteAll()
  base.OnDelete(self)
end

return UINEvtFestivalSignItem
