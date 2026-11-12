local EventReminderCtrl = class("EventReminderCtrl", BaseCtrl)
EventReminderCtrl._mapNodeConfig = {
  Topbar = {
    sNodeName = "TopBarPanel",
    sCtrlName = "Game.UI.TopBarEx.TopBarCtrl"
  },
  templateItem = {
    sNodeName = "rtList",
    sComponentName = "RectTransform"
  },
  waitingList = {
    sComponentName = "RectTransform"
  },
  finishList = {
    sComponentName = "RectTransform"
  },
  destroyRoot = {
    sComponentName = "RectTransform"
  },
  txtWaitingTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "EventReminder_Waiting_Title"
  },
  txtFinishTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "EventReminder_Finish_Title"
  }
}
EventReminderCtrl._mapEventConfig = {}
EventReminderCtrl._mapRedDotConfig = {}

function EventReminderCtrl:OnEnable()
  self:RefreshList()
end

function EventReminderCtrl:OnDisable()
  self:ClearList()
end

function EventReminderCtrl:RefreshList()
  self:ClearList()
  PlayerData.EventReminder:UpdateAllData()
  local tbEventReminderDataList, tbFinishList = PlayerData.EventReminder:GetEventReminderDataList()
  for _, v in ipairs(tbEventReminderDataList) do
    local go = instantiate(self._mapNode.templateItem, self._mapNode.waitingList)
    local ctrl = self:BindCtrlByNode(go, "Game.UI.EventReminder.EventReminderCellCtrl")
    table.insert(self.tbCellCtrl, ctrl)
    ctrl:SetData(v)
    go.gameObject:SetActive(true)
  end
  for _, v in ipairs(tbFinishList) do
    local go = instantiate(self._mapNode.templateItem, self._mapNode.finishList)
    local ctrl = self:BindCtrlByNode(go, "Game.UI.EventReminder.EventReminderCellCtrl")
    table.insert(self.tbCellCtrl, ctrl)
    ctrl:SetData(v)
    go.gameObject:SetActive(true)
  end
  self._mapNode.waitingList.gameObject:SetActive(0 < #tbEventReminderDataList)
  self._mapNode.finishList.gameObject:SetActive(0 < #tbFinishList)
end

function EventReminderCtrl:ClearList()
  if self.tbCellCtrl ~= nil then
    for _, v in ipairs(self.tbCellCtrl) do
      self:UnbindCtrlByNode(v)
    end
  end
  self.tbCellCtrl = {}
  if self._mapNode.waitingList.childCount > 1 then
    for i = self._mapNode.waitingList.childCount, 2, -1 do
      local tr = self._mapNode.waitingList:GetChild(i - 1)
      tr.gameObject:SetActive(false)
      tr:SetParent(self._mapNode.destroyRoot)
    end
  end
  if 1 < self._mapNode.finishList.childCount then
    for i = self._mapNode.finishList.childCount, 2, -1 do
      local tr = self._mapNode.finishList:GetChild(i - 1)
      tr.gameObject:SetActive(false)
      tr:SetParent(self._mapNode.destroyRoot)
    end
  end
  delChildren(self._mapNode.destroyRoot)
end

return EventReminderCtrl
