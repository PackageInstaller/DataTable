local ReengagementQuestItemCtrl = class("ReengagementQuestItemCtrl", BaseCtrl)
local JumpUtil = require("Game.Common.Utils.JumpUtil")
local LayoutRebuilder = CS.UnityEngine.UI.LayoutRebuilder
ReengagementQuestItemCtrl._mapNodeConfig = {
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
  rtReward = {
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
ReengagementQuestItemCtrl._mapEventConfig = {}
local totalLength = 520
local totalHeight = 37

function ReengagementQuestItemCtrl:SetData(nActId, mapData)
  self.nActId = nActId
  self.nQuestId = mapData.Id
  local tbQuest = PlayerData.Reengagement:GetQuestDataById(self.nQuestId)
  if tbQuest == nil then
    tbQuest = {
      nStatus = 0,
      Progress = {Cur = 0, Max = 1}
    }
  end
  local nStatus = tbQuest.nStatus
  local questCfg = PlayerData.Reengagement:GetQuestConfigDataById(self.nQuestId)
  self.nGroupId = questCfg.GroupId
  if nil ~= questCfg then
    NovaAPI.SetTMPText(self._mapNode.txtTitle, questCfg.Title)
    NovaAPI.SetTMPText(self._mapNode.txtProcess, string.format("%s/%s", tbQuest.Progress.Cur, tbQuest.Progress.Max))
    self.nJumpTo = questCfg.JumpTo
    self.rewardId = questCfg.Reward1Tid
    self._mapNode.rtReward:SetItem(questCfg.Reward1Tid, nil, questCfg.Reward1Qty, nil, nil, nil, nil, true)
    self._mapNode.txtUnComplete.gameObject:SetActive(nStatus == 0 and questCfg.JumpTo == 0)
    self._mapNode.btnJump.gameObject:SetActive(nStatus == 0 and questCfg.JumpTo ~= 0)
    self._mapNode.btnReceive.gameObject:SetActive(nStatus == 1)
    self._mapNode.imgComplete.gameObject:SetActive(nStatus == 2)
    self._mapNode.imgCompleteMask.gameObject:SetActive(nStatus == 2)
    self._mapNode.imgPoint.gameObject:SetActive(nStatus ~= 2)
    if nStatus == 2 then
      NovaAPI.SetTMPText(self._mapNode.txtProcess, ConfigTable.GetUIText("PerActivity_Quest_Complete"))
      self._mapNode.rtBarFill.sizeDelta = Vector2(totalLength, totalHeight)
    else
      self._mapNode.rtBarFill.sizeDelta = Vector2(tbQuest.Progress.Cur / tbQuest.Progress.Max * totalLength, totalHeight)
    end
    LayoutRebuilder.ForceRebuildLayoutImmediate(self._mapNode.rtTitle)
  end
end

function ReengagementQuestItemCtrl:Awake()
end

function ReengagementQuestItemCtrl:FadeIn()
end

function ReengagementQuestItemCtrl:FadeOut()
end

function ReengagementQuestItemCtrl:OnEnable()
end

function ReengagementQuestItemCtrl:OnDisable()
end

function ReengagementQuestItemCtrl:OnDestroy()
end

function ReengagementQuestItemCtrl:OnRelease()
end

function ReengagementQuestItemCtrl:OnBtnClick_Reward(btn)
  if nil ~= self.rewardId then
    UTILS.ClickItemGridWithTips(self.rewardId, btn.transform, true, true, true)
  end
end

function ReengagementQuestItemCtrl:OnBtnClick_Receive()
  PlayerData.Reengagement:RequestReceiveQuestReward(self.nQuestId, self.nGroupId)
end

function ReengagementQuestItemCtrl:OnBtnClick_Jump()
  if nil ~= self.nJumpTo and 0 ~= self.nJumpTo then
    JumpUtil.JumpTo(self.nJumpTo)
  end
end

return ReengagementQuestItemCtrl
