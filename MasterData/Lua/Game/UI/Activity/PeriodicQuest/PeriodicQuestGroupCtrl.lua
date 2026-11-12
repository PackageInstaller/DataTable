local PeriodicQuestGroupCtrl = class("PeriodicQuestGroupCtrl", BaseCtrl)
PeriodicQuestGroupCtrl._mapNodeConfig = {
  goNormal = {},
  goSelect = {},
  goLock = {},
  txt_Group = {sComponentName = "TMP_Text", nCount = 3},
  goTime = {},
  txtOpenTime = {sComponentName = "TMP_Text"},
  redDotGroup = {},
  imgComplete = {}
}
PeriodicQuestGroupCtrl._mapEventConfig = {}

function PeriodicQuestGroupCtrl:Init(nActId, nGroup, nCurGroup)
  self.nActId = nActId
  self.nGroup = nGroup
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
  self._mapNode.goNormal.gameObject:SetActive(nGroup <= nCurGroup)
  self._mapNode.goLock.gameObject:SetActive(nCurGroup < nGroup)
  self:RegisterRedDot()
end

function PeriodicQuestGroupCtrl:RegisterRedDot()
  RedDotManager.RegisterNode(RedDotDefine.Activity_Periodic_Quest_Group, {
    self.nActId,
    self.nGroup
  }, self._mapNode.redDotGroup)
end

function PeriodicQuestGroupCtrl:SetTime(sTime)
  self._mapNode.goTime.gameObject:SetActive(true)
  NovaAPI.SetTMPText(self._mapNode.txtOpenTime, sTime)
end

function PeriodicQuestGroupCtrl:SetSelect(bSelect)
  self.bSelect = bSelect
  self._mapNode.goNormal.gameObject:SetActive(not self.bSelect)
  self._mapNode.goSelect.gameObject:SetActive(self.bSelect)
end

function PeriodicQuestGroupCtrl:RefreshStatus(bAllReceived)
  self._mapNode.imgComplete.gameObject:SetActive(bAllReceived and self.bUnlock)
end

function PeriodicQuestGroupCtrl:Awake()
end

function PeriodicQuestGroupCtrl:OnDisable()
end

function PeriodicQuestGroupCtrl:OnDestroy()
end

function PeriodicQuestGroupCtrl:OnRelease()
end

return PeriodicQuestGroupCtrl
