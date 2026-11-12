local InfinityTowerRollMsg = class("InfinityTowerRollMsg", BaseCtrl)
InfinityTowerRollMsg._mapNodeConfig = {
  texTitle = {sComponentName = "TMP_Text"},
  texMsg = {sComponentName = "TMP_Text"}
}

function InfinityTowerRollMsg:InitRoll(nType, nIndex)
  self.type = nType
  self.Index = nIndex
  if nType == 1 then
    NovaAPI.SetTMPText(self._mapNode.texTitle, ConfigTable.GetUIText("InfinityTower_Bottom_Tips_Title_Daily"))
  elseif nType == 2 then
    NovaAPI.SetTMPText(self._mapNode.texTitle, ConfigTable.GetUIText("InfinityTower_Bottom_Tips_Title_Breakout"))
  elseif nType == 3 then
    NovaAPI.SetTMPText(self._mapNode.texTitle, ConfigTable.GetUIText("InfinityTower_Bottom_Tips_Title_News"))
  end
end

function InfinityTowerRollMsg:SetMsg()
  local mgsId = PlayerData.InfinityTower:GetBottomMsgId(self.type, self.Index)
  if mgsId then
    NovaAPI.SetTMPText(self._mapNode.texMsg, ConfigTable.GetData("InfinityTowerMsg", mgsId).Content)
    self.gameObject:SetActive(true)
  else
    self.gameObject:SetActive(false)
  end
end

return InfinityTowerRollMsg
