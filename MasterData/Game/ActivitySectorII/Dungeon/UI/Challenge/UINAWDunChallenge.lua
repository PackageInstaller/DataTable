local UINAWDunChallenge = class("UINAWDunChallenge", UIBaseNode)
local base = UIBaseNode
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")

function UINAWDunChallenge:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_rewardInfo, self, self._OnClickRewardInfo)
  UIUtil.AddButtonListener(self.ui.btn_Root, self, self._OnClickRoot)
  self.rewardItemPool = UIItemPool.New(UINBaseItemWithCount, self.ui.uINBaseItemWithCount, false)
  self.ui.emptyReward:SetActive(false)
  self.emptyRewardGoDic = {
    [3] = self.ui.emptyReward
  }
  self.__OnSettleFunc = BindCallback(self, self._OnSettle)
  MsgCenter:AddListener(eMsgEventId.WinterChallengeSettle, self.__OnSettleFunc)
end

function UINAWDunChallenge:InitAWDunChallenge(sectorIIData, clickFunc)
  self.clickFunc = clickFunc
  self.sectorIIData = sectorIIData
  local chanllegeDgData = sectorIIData:GetActvWinChallengeDgData()
  self.chanllegeDgData = chanllegeDgData
  local pos = chanllegeDgData:GetSectorIIChallengeLvPos()
  self.transform.anchoredPosition = pos
  local unlock = chanllegeDgData:GetIsLevelUnlock()
  self.ui.scoreNode:SetActive(unlock)
  self.ui.img_Locked:SetActive(not unlock)
  if unlock then
    self:_UpdateScore()
    self:_UpdCompleteState()
  else
    local unlockList = CheckCondition.GetUnlockAndInfoList(chanllegeDgData:GetLevelUnlockConditionCfg())
    for k, v in ipairs(unlockList) do
      if not v.unlock then
        self.ui.tex_Unlock.text = v.lockReason
        break
      end
    end
  end
end

function UINAWDunChallenge:_UpdateScore()
  local maxScore = self.chanllegeDgData:GetSctIIChallengeDgMaxScore()
  local maxHisScore = self.chanllegeDgData:GetSctIIChallengeDgHisMaxScore()
  local realMaxScore = math.max(maxScore, maxHisScore)
  self.ui.tex_CurPoint.text = tostring(maxScore)
  local rewardListCfg = self.chanllegeDgData:GetSectorIIChallengeRewardListCfg()
  self.rewardListCfg = rewardListCfg
  local curPhase = 0
  for k, v in ipairs(rewardListCfg) do
    if realMaxScore >= v.need_point then
      curPhase = k
    else
      break
    end
  end
  self.curPhase = curPhase
  local maxPhase = #rewardListCfg
  local nextPhase = math.min(curPhase + 1, maxPhase)
  self.ui.tex_Stage.text = tostring(nextPhase) .. "/" .. tostring(maxPhase)
  local isMaxStage = curPhase >= maxPhase
  if isMaxStage then
    self.ui.tex_Point:SetIndex(1)
  else
    local stageScore = 0
    local rewardCfg = rewardListCfg[nextPhase]
    if rewardCfg ~= nil then
      stageScore = rewardCfg.need_point
    end
    self.ui.tex_Point:SetIndex(0, tostring(stageScore))
    self.rewardItemPool:HideAll()
    for i = 1, 3 do
      local rewardId = rewardCfg.rewardIds[i]
      local rewardNum = rewardCfg.rewardNums[i]
      if rewardId == nil then
        local emptyGo = self.emptyRewardGoDic[i]
        if emptyGo == nil then
          emptyGo = self.ui.emptyReward:Instantiate()
          self.emptyRewardGoDic[i] = emptyGo
        end
        emptyGo:SetActive(true)
        emptyGo.transform:SetAsLastSibling()
      else
        local rewardItem = self.rewardItemPool:GetOne()
        local itemCfg = ConfigData.item[rewardId]
        rewardItem:InitItemWithCount(itemCfg, rewardNum)
        if self.emptyRewardGoDic[i] ~= nil then
          self.emptyRewardGoDic[i]:SetActive(false)
        end
      end
    end
  end
  self.ui.obj_ReceivedAll:SetActive(isMaxStage)
end

function UINAWDunChallenge:_OnSettle()
  self:_UpdateScore()
  self:_UpdCompleteState()
end

function UINAWDunChallenge:_UpdCompleteState()
  local isFinish, inDungeon = self.chanllegeDgData:GetSctIIChallengeDgStage()
  self.ui.img_Continue:SetActive(inDungeon)
end

function UINAWDunChallenge:_OnClickRewardInfo()
  UIManager:ShowWindowAsync(UIWindowTypeID.StageRewardPreview, function(win)
    if win == nil then
    end
    win:InitUIStageRewardPreview(self.rewardListCfg, self.curPhase)
  end)
end

function UINAWDunChallenge:_OnClickRoot()
  local challengeDgData = self.sectorIIData:GetActvWinChallengeDgData()
  if self.clickFunc ~= nil then
    self.clickFunc(self, challengeDgData)
  end
end

function UINAWDunChallenge:OnDelete()
  self.rewardItemPool:DeleteAll()
  MsgCenter:RemoveListener(eMsgEventId.WinterChallengeSettle, self.__OnSettleFunc)
  base.OnDelete(self)
end

return UINAWDunChallenge
