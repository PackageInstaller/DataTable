local PenguinCardQuestCellCtrl = class("PenguinCardQuestCellCtrl", BaseCtrl)
local LayoutRebuilder = CS.UnityEngine.UI.LayoutRebuilder
PenguinCardQuestCellCtrl._mapNodeConfig = {
  rtReward = {
    sCtrlName = "Game.UI.TemplateEx.TemplateItemCtrl"
  },
  btnReward = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Reward"
  },
  rtTitle = {
    sComponentName = "RectTransform"
  },
  btnGrid = {},
  TMPTitle = {sComponentName = "TMP_Text"},
  btnReceive = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_GetReward"
  },
  txtBtnReceive = {
    sComponentName = "TMP_Text",
    sLanguageId = "PenguinCard_Btn_Receive"
  },
  go_UnComplete = {
    sNodeName = "TMPUncomplete"
  },
  TMPUncomplete = {
    sComponentName = "TMP_Text",
    sLanguageId = "PenguinCard_Quest_UnComplete"
  },
  imgComplete = {},
  imgCompleteMask = {},
  txt_process = {sComponentName = "TMP_Text"},
  imgBarFill = {
    sComponentName = "RectTransform"
  }
}
PenguinCardQuestCellCtrl._mapEventConfig = {}
PenguinCardQuestCellCtrl._mapRedDotConfig = {}

function PenguinCardQuestCellCtrl:OnEnable()
  self._mapNode.btnGrid:SetActive(false)
  
  local function waitOpen()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    if self._mapNode == nil then
      return
    end
    self._mapNode.btnGrid:SetActive(true)
    LayoutRebuilder.ForceRebuildLayoutImmediate(self._mapNode.rtTitle)
  end
  
  cs_coroutine.start(waitOpen)
end

function PenguinCardQuestCellCtrl:Refresh(nActId, mapQuest)
  self.nActId = nActId
  self.mapQuest = mapQuest
  self.actData = PlayerData.Activity:GetActivityDataById(self.nActId)
  local mapCfg = ConfigTable.GetData("ActivityPenguinCardQuest", self.mapQuest.nId)
  if mapCfg == nil then
    return
  end
  NovaAPI.SetTMPText(self._mapNode.TMPTitle, mapCfg.Desc)
  if mapQuest.nMax > 0 then
    local nLen = mapQuest.nCur / mapQuest.nMax * 508
    if nLen < 60 and 0 < nLen then
      nLen = 60
    end
    self._mapNode.imgBarFill.sizeDelta = Vector2(nLen, 27)
  else
    self._mapNode.imgBarFill.sizeDelta = Vector2(508, 27)
  end
  NovaAPI.SetTMPText(self._mapNode.txt_process, mapQuest.nCur .. "/" .. mapQuest.nMax)
  self._mapNode.imgComplete:SetActive(self.mapQuest.nStatus == AllEnum.ActQuestStatus.Received)
  self._mapNode.imgCompleteMask:SetActive(self.mapQuest.nStatus == AllEnum.ActQuestStatus.Received)
  self._mapNode.go_UnComplete:SetActive(self.mapQuest.nStatus == AllEnum.ActQuestStatus.UnComplete)
  self._mapNode.btnReceive.gameObject:SetActive(self.mapQuest.nStatus == AllEnum.ActQuestStatus.Complete)
  if 0 < mapCfg.Item1 then
    self._mapNode.btnReward.gameObject:SetActive(true)
    self._mapNode.rtReward:SetItem(mapCfg.Item1, nil, mapCfg.Qty1, nil, self.mapQuest.nStatus == AllEnum.ActQuestStatus.Received)
  else
    self._mapNode.btnReward.gameObject:SetActive(false)
  end
  LayoutRebuilder.ForceRebuildLayoutImmediate(self._mapNode.rtTitle)
end

function PenguinCardQuestCellCtrl:OnBtnClick_GetReward()
  if self.mapQuest == nil then
    return
  end
  
  local function callback()
    EventManager.Hit("PenguinCardRefreshQuest")
  end
  
  self.actData:SendActivityPenguinCardQuestReceiveReq(self.mapQuest.nId, 0, callback)
end

function PenguinCardQuestCellCtrl:OnBtnClick_Reward(btn)
  local mapCfg = ConfigTable.GetData("ActivityPenguinCardQuest", self.mapQuest.nId)
  if mapCfg == nil then
    return
  end
  if mapCfg.Item1 > 0 then
    UTILS.ClickItemGridWithTips(mapCfg.Item1, btn, true, true, false)
  end
end

return PenguinCardQuestCellCtrl
