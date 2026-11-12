local EventBookTogItemCtrl = class("EventBookTogItemCtrl", BaseCtrl)
EventBookTogItemCtrl._mapNodeConfig = {
  goSelect = {},
  txtSelect = {sComponentName = "TMP_Text"},
  goUnSelect = {},
  txtUnSelect = {sComponentName = "TMP_Text"},
  goLock = {},
  txtLock = {
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Book_Event_Lock"
  },
  redDotTab = {}
}
EventBookTogItemCtrl._mapEventConfig = {}
EventBookTogItemCtrl._mapRedDotConfig = {}

function EventBookTogItemCtrl:InitItem(eventData)
  self.nStatus = eventData.Status
  self.nEventId = eventData.Id
  self._mapNode.goLock.gameObject:SetActive(self.nStatus == AllEnum.BookQuestStatus.UnComplete)
  self._mapNode.goSelect.gameObject:SetActive(false)
  self._mapNode.goUnSelect.gameObject:SetActive(self.nStatus ~= AllEnum.BookQuestStatus.UnComplete)
  NovaAPI.SetTMPText(self._mapNode.txtSelect, eventData.CfgData.Name)
  NovaAPI.SetTMPText(self._mapNode.txtUnSelect, eventData.CfgData.Name)
  if self.nStatus == AllEnum.BookQuestStatus.UnComplete then
    NovaAPI.SetTMPText(self._mapNode.txtSelect, ConfigTable.GetUIText("StarTower_Book_Event_Lock"))
  end
  RedDotManager.RegisterNode(RedDotDefine.StarTowerBook_Event_Reward, self.nEventId, self._mapNode.redDotTab)
end

function EventBookTogItemCtrl:SetSelect(bSelect)
  self._mapNode.goSelect.gameObject:SetActive(bSelect)
  if self.nStatus ~= AllEnum.BookQuestStatus.UnComplete then
    self._mapNode.goLock.gameObject:SetActive(false)
    self._mapNode.goUnSelect.gameObject:SetActive(not bSelect)
  else
    self._mapNode.goLock.gameObject:SetActive(not bSelect)
    self._mapNode.goUnSelect.gameObject:SetActive(false)
  end
end

function EventBookTogItemCtrl:OnDisable()
end

return EventBookTogItemCtrl
