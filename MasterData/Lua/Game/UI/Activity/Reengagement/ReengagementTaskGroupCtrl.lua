local ReengagementTaskGroupCtrl = class("ReengagementTaskGroupCtrl", BaseCtrl)
ReengagementTaskGroupCtrl._mapNodeConfig = {
  goNormal = {},
  goSelect = {},
  goLock = {},
  txt_Group = {sComponentName = "TMP_Text", nCount = 3},
  goTime = {},
  txtOpenTime = {sComponentName = "TMP_Text"},
  redDotGroup = {},
  imgComplete = {}
}
ReengagementTaskGroupCtrl._mapEventConfig = {}

function ReengagementTaskGroupCtrl:Init(nActId, nGroup, nCurGroup, bAllReceived)
  self.nActId = nActId
  self.nGroup = nGroup
  self.nGroupId = 100 < nGroup and nGroup or nGroup + 100
  for _, v in ipairs(self._mapNode.txt_Group) do
    NovaAPI.SetTMPText(v, self.nGroup)
  end
  self._mapNode.goNormal.gameObject:SetActive(true)
  self._mapNode.goSelect.gameObject:SetActive(false)
  self._mapNode.goLock.gameObject:SetActive(false)
  self._mapNode.goTime.gameObject:SetActive(false)
  self._mapNode.redDotGroup.gameObject:SetActive(false)
  self.bUnlock = nGroup <= nCurGroup
  self:SetSelect(false)
  self._mapNode.imgComplete.gameObject:SetActive(bAllReceived)
  self._mapNode.goNormal.gameObject:SetActive(nGroup <= nCurGroup)
  self._mapNode.goLock.gameObject:SetActive(nCurGroup < nGroup)
  if nGroup <= nCurGroup then
    self:RegisterRedDot()
  end
end

function ReengagementTaskGroupCtrl:RegisterRedDot()
  RedDotManager.RegisterNode(RedDotDefine.Activity_Reengagement_Task_Group, {
    self.nActId,
    self.nGroupId
  }, self._mapNode.redDotGroup)
end

function ReengagementTaskGroupCtrl:SetTime(sTime)
  self._mapNode.goTime.gameObject:SetActive(true)
  NovaAPI.SetTMPText(self._mapNode.txtOpenTime, sTime)
end

function ReengagementTaskGroupCtrl:SetSelect(bSelect)
  self.bSelect = bSelect
  self._mapNode.goNormal.gameObject:SetActive(not self.bSelect)
  self._mapNode.goSelect.gameObject:SetActive(self.bSelect)
end

function ReengagementTaskGroupCtrl:RefreshStatus(bAllReceived)
  self._mapNode.imgComplete.gameObject:SetActive(bAllReceived)
end

function ReengagementTaskGroupCtrl:Awake()
end

function ReengagementTaskGroupCtrl:OnDisable()
end

function ReengagementTaskGroupCtrl:OnDestroy()
end

function ReengagementTaskGroupCtrl:OnRelease()
end

return ReengagementTaskGroupCtrl
