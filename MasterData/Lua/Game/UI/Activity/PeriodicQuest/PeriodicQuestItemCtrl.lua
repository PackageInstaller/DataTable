local PeriodicQuestItemCtrl = class("PeriodicQuestItemCtrl", BaseCtrl)
local JumpUtil = require("Game.Common.Utils.JumpUtil")
local LayoutRebuilder = CS.UnityEngine.UI.LayoutRebuilder
PeriodicQuestItemCtrl._mapNodeConfig = {
  rtTitle = {
    sComponentName = "RectTransform"
  },
  txtTitle = {sNodeName = "TMPTitle", sComponentName = "TMP_Text"},
  rtBarFill = {
    sComponentName = "RectTransform"
  },
  txtProcess = {sNodeName = "TMPProcess", sComponentName = "TMP_Text"},
  btnReward = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Reward"
  },
  btnReward2 = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Reward2"
  },
  rtReward = {
    sCtrlName = "Game.UI.TemplateEx.TemplateItemCtrl"
  },
  rtReward2 = {
    sCtrlName = "Game.UI.TemplateEx.TemplateItemCtrl"
  },
  btnReceive = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Receive"
  },
  txtBtnReceive = {
    sComponentName = "TMP_Text",
    sLanguageId = "PerActivity_Quest_Receive"
  },
  btnJump = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Jump"
  },
  txtBtnJump = {
    sComponentName = "TMP_Text",
    sLanguageId = "PerActivity_Quest_Jump"
  },
  txtUnComplete = {
    sNodeName = "TMPUncomplete",
    sComponentName = "TMP_Text",
    sLanguageId = "PerActivity_Quest_UnComplete"
  },
  imgComplete = {},
  imgCompleteMask = {},
  imgPoint = {}
}
PeriodicQuestItemCtrl._mapEventConfig = {}
local totalLength = 520
local totalHeight = 37

function PeriodicQuestItemCtrl:SetData(nActId, mapData)
  self.nActId = nActId
  self.nQuestId = mapData.Id
  local nStatus = mapData.nStatus
  local questCfg = ConfigTable.GetData("PeriodicQuest", self.nQuestId)
  if nil ~= questCfg then
    NovaAPI.SetTMPText(self._mapNode.txtTitle, questCfg.Title)
    NovaAPI.SetTMPText(self._mapNode.txtProcess, string.format("%s/%s", mapData.nCurProcess, mapData.nTotalProcess))
    self.nJumpTo = questCfg.JumpTo
    self.rewardId = questCfg.Reward
    self._mapNode.rtReward:SetItem(questCfg.Reward, nil, questCfg.RewardQty, nil, nil, nil, nil, true)
    self.rewardId2 = questCfg.Reward2
    self._mapNode.rtReward2:SetItem(questCfg.Reward2, nil, questCfg.RewardQty2, nil, nil, nil, nil, true)
    self._mapNode.btnReward2.gameObject:SetActive(self.rewardId2 ~= 0)
    self._mapNode.txtUnComplete.gameObject:SetActive(nStatus == AllEnum.ActQuestStatus.UnComplete and questCfg.JumpTo == 0)
    self._mapNode.btnJump.gameObject:SetActive(nStatus == AllEnum.ActQuestStatus.UnComplete and questCfg.JumpTo ~= 0)
    self._mapNode.btnReceive.gameObject:SetActive(nStatus == AllEnum.ActQuestStatus.Complete)
    self._mapNode.imgComplete.gameObject:SetActive(nStatus == AllEnum.ActQuestStatus.Received)
    self._mapNode.imgCompleteMask.gameObject:SetActive(nStatus == AllEnum.ActQuestStatus.Received)
    self._mapNode.imgPoint.gameObject:SetActive(nStatus ~= AllEnum.ActQuestStatus.Received)
    if nStatus == AllEnum.ActQuestStatus.Received then
      NovaAPI.SetTMPText(self._mapNode.txtProcess, ConfigTable.GetUIText("PerActivity_Quest_Complete"))
      self._mapNode.rtBarFill.sizeDelta = Vector2(totalLength, totalHeight)
    else
      self._mapNode.rtBarFill.sizeDelta = Vector2(mapData.nCurProcess / mapData.nTotalProcess * totalLength, totalHeight)
    end
    LayoutRebuilder.ForceRebuildLayoutImmediate(self._mapNode.rtTitle)
  end
end

function PeriodicQuestItemCtrl:Awake()
end

function PeriodicQuestItemCtrl:FadeIn()
end

function PeriodicQuestItemCtrl:FadeOut()
end

function PeriodicQuestItemCtrl:OnEnable()
end

function PeriodicQuestItemCtrl:OnDisable()
end

function PeriodicQuestItemCtrl:OnDestroy()
end

function PeriodicQuestItemCtrl:OnRelease()
end

function PeriodicQuestItemCtrl:OnBtnClick_Reward(btn)
  if nil ~= self.rewardId then
    UTILS.ClickItemGridWithTips(self.rewardId, btn.transform, true, true, true)
  end
end

function PeriodicQuestItemCtrl:OnBtnClick_Reward2(btn)
  if nil ~= self.rewardId2 then
    UTILS.ClickItemGridWithTips(self.rewardId2, btn.transform, true, true, true)
  end
end

function PeriodicQuestItemCtrl:OnBtnClick_Receive()
  local function callback()
    EventManager.Hit("RefreshPeriodicAct", self.nActId)
    
    PlayerData.Base:TryOpenWorldClassUpgrade()
  end
  
  PlayerData.Activity:SendReceivePerQuest(self.nActId, self.nQuestId, callback)
end

function PeriodicQuestItemCtrl:OnBtnClick_Jump()
  if nil ~= self.nJumpTo and 0 ~= self.nJumpTo then
    JumpUtil.JumpTo(self.nJumpTo)
  end
end

return PeriodicQuestItemCtrl
