local TalentKeyNodeCtrl = class("TalentKeyNodeCtrl", BaseCtrl)
local NodeState = {
  Lock = 1,
  Ready = 2,
  Active = 3
}
TalentKeyNodeCtrl._mapNodeConfig = {
  goKeyReady = {nCount = 2},
  goKeyOff = {nCount = 2},
  goKeyOn = {nCount = 2},
  redKey = {},
  txtNameReady = {sComponentName = "TMP_Text"},
  txtIndexReady = {sComponentName = "TMP_Text"},
  txtNameOff = {sComponentName = "TMP_Text"},
  txtIndexOff = {sComponentName = "TMP_Text"},
  txtNameOn = {sComponentName = "TMP_Text"},
  txtIndexOn = {sComponentName = "TMP_Text"}
}
TalentKeyNodeCtrl._mapEventConfig = {}

function TalentKeyNodeCtrl:Refresh(nId, nIndex, nState)
  self.nId = nId
  local mapCfg = ConfigTable.GetData("TalentGroup", nId)
  if not mapCfg then
    return
  end
  for i = 1, 2 do
    self._mapNode.goKeyReady[i]:SetActive(nState == NodeState.Ready)
    self._mapNode.goKeyOff[i]:SetActive(nState == NodeState.Lock)
    self._mapNode.goKeyOn[i]:SetActive(nState == NodeState.Active)
  end
  if nState == NodeState.Lock then
    NovaAPI.SetTMPText(self._mapNode.txtIndexOff, ConfigTable.GetUIText("CharTalent_NodeIndex" .. nIndex))
    NovaAPI.SetTMPText(self._mapNode.txtNameOff, mapCfg.Title)
  elseif nState == NodeState.Ready then
    NovaAPI.SetTMPText(self._mapNode.txtIndexReady, ConfigTable.GetUIText("CharTalent_NodeIndex" .. nIndex))
    NovaAPI.SetTMPText(self._mapNode.txtNameReady, mapCfg.Title)
  elseif nState == NodeState.Active then
    NovaAPI.SetTMPText(self._mapNode.txtIndexOn, ConfigTable.GetUIText("CharTalent_NodeIndex" .. nIndex))
    NovaAPI.SetTMPText(self._mapNode.txtNameOn, mapCfg.Title)
  end
  self:RegisterRedDot()
end

function TalentKeyNodeCtrl:RegisterRedDot()
  if self.nId ~= nil then
    RedDotManager.RegisterNode(RedDotDefine.Role_Talent, self._panel.nCharId, self._mapNode.redKey)
  end
end

return TalentKeyNodeCtrl
