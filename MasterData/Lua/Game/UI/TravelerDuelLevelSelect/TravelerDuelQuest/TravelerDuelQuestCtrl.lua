local TravelerDuelQuestCtrl = class("TravelerDuelQuestCtrl", BaseCtrl)
TravelerDuelQuestCtrl._mapNodeConfig = {
  TopBar = {
    sNodeName = "TopBarPanel",
    sCtrlName = "Game.UI.TopBarEx.TopBarCtrl"
  },
  togCtrl = {
    sNodeName = "tog",
    nCount = 2,
    sCtrlName = "Game.UI.TemplateEx.TemplateToggleCtrl"
  },
  tog = {
    sComponentName = "UIButton",
    nCount = 2,
    callback = "OnBtnClick_Tog"
  },
  rtQuestSeason = {
    sCtrlName = "Game.UI.TravelerDuelLevelSelect.TravelerDuelQuest.TravelerDuelQuestSeasonCtrl"
  },
  rtQuestNormal = {
    sCtrlName = "Game.UI.TravelerDuelLevelSelect.TravelerDuelQuest.TravelerDuelQuestNormalCtrl"
  },
  redDotTog = {nCount = 2}
}
TravelerDuelQuestCtrl._mapEventConfig = {
  [EventId.TRChallengeQusetReceived] = "OnEvent_ChallengeQusetReceived",
  [EventId.TRNormalQusetReceived] = "OnEvent_NormalQusetReceived"
}

function TravelerDuelQuestCtrl:RegisterRedDot()
  RedDotManager.RegisterNode(RedDotDefine.Task_Season, nil, self._mapNode.redDotTog[1])
  RedDotManager.RegisterNode(RedDotDefine.Task_Duel, nil, self._mapNode.redDotTog[2])
end

function TravelerDuelQuestCtrl:Awake()
  self.tbSheet = {
    [1] = self._mapNode.rtQuestSeason,
    [2] = self._mapNode.rtQuestNormal
  }
end

function TravelerDuelQuestCtrl:FadeIn()
end

function TravelerDuelQuestCtrl:FadeOut()
end

function TravelerDuelQuestCtrl:OnEnable()
  self:RegisterRedDot()
  local mapNormal, mapSeason = PlayerData.Quest:GetTravelerDuelQuestData()
  local mapChallenge = PlayerData.TravelerDuel:GetTravelerDuelChallenge()
  local bUnlockLevel, sLock = PlayerData.TravelerDuel:GetTravelerChallengeUnlock()
  local bUnlock = bUnlockLevel and mapChallenge.bUnlock
  if mapSeason == nil or mapChallenge.nIdx == 0 or not bUnlock then
    self.nCurSheet = 2
    self._mapNode.togCtrl[1]:SetText(ConfigTable.GetUIText("TDQuest_Season"))
    self._mapNode.togCtrl[2]:SetText(ConfigTable.GetUIText("TDQuest_Normal"))
    self._mapNode.togCtrl[1]:SetDefault(false)
    self._mapNode.togCtrl[2]:SetDefault(true)
    self._mapNode.togCtrl[1].gameObject:SetActive(false)
    self._mapNode.rtQuestSeason.gameObject:SetActive(false)
    self._mapNode.rtQuestNormal.gameObject:SetActive(true)
    self._mapNode.rtQuestNormal:Refresh(mapNormal)
  else
    local mapDuelChallenge = PlayerData.TravelerDuel:GetTravelerDuelChallenge()
    self._mapNode.rtQuestSeason.gameObject:SetActive(true)
    self._mapNode.rtQuestNormal.gameObject:SetActive(false)
    self._mapNode.rtQuestSeason:Refresh(mapSeason, mapDuelChallenge)
    self._mapNode.rtQuestNormal:Refresh(mapNormal)
    self._mapNode.togCtrl[1].gameObject:SetActive(true)
    self.nCurSheet = 1
    self._mapNode.togCtrl[1]:SetText(ConfigTable.GetUIText("TDQuest_Season"))
    self._mapNode.togCtrl[2]:SetText(ConfigTable.GetUIText("TDQuest_Normal"))
    self._mapNode.togCtrl[1]:SetDefault(true)
    self._mapNode.togCtrl[2]:SetDefault(false)
  end
end

function TravelerDuelQuestCtrl:OnDisable()
end

function TravelerDuelQuestCtrl:OnDestroy()
end

function TravelerDuelQuestCtrl:OnRelease()
end

function TravelerDuelQuestCtrl:OnBtnClick_Tog(btn, nIndex)
  if self.nCurSheet == nIndex then
    return
  end
  self._mapNode.togCtrl[self.nCurSheet]:SetTrigger(false)
  self._mapNode.togCtrl[nIndex]:SetTrigger(true)
  self.tbSheet[self.nCurSheet].gameObject:SetActive(false)
  self.tbSheet[nIndex].gameObject:SetActive(true)
  self.nCurSheet = nIndex
end

function TravelerDuelQuestCtrl:OnEvent_ChallengeQusetReceived(QuestRewards, tbReceivedId, mapChangeInfo)
  UTILS.OpenReceiveByDisplayItem(QuestRewards, mapChangeInfo)
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    local mapNormal, mapSeason = PlayerData.Quest:GetTravelerDuelQuestData()
    local mapDuelChallenge = PlayerData.TravelerDuel:GetTravelerDuelChallenge()
    self._mapNode.rtQuestSeason:Refresh(mapSeason, mapDuelChallenge)
  end
  
  cs_coroutine.start(wait)
end

function TravelerDuelQuestCtrl:OnEvent_NormalQusetReceived(QuestRewards, tbReceivedId, mapChangeInfo)
  UTILS.OpenReceiveByDisplayItem(QuestRewards, mapChangeInfo)
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    local mapNormal, mapSeason = PlayerData.Quest:GetTravelerDuelQuestData()
    self._mapNode.rtQuestNormal:Refresh(mapNormal)
  end
  
  cs_coroutine.start(wait)
end

return TravelerDuelQuestCtrl
