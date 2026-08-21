require("ui_main_lobby_main_campaign_base")
_class("UICN21N50MainLobbyEntry", UIMainLobbyMainCampaignBase)
UICN21N50MainLobbyEntry = UICN21N50MainLobbyEntry

function UICN21N50MainLobbyEntry:GetComponent()
  self._redGo = self:GetGameObject("red")
  self._newGo = self:GetGameObject("new")
  self._diffOpenGo = self:GetGameObject("diffOpen")
  self._shopOpenGo = self:GetGameObject("shopOpen")
end

function UICN21N50MainLobbyEntry:RefreshView()
  self:RedAndNew()
  self:DiffOpen()
end

function UICN21N50MainLobbyEntry:BtnOnClick()
  UICN21N50MainLobbyEntry.super.BtnOnClick(self)
  GameGlobal.UIStateManager():SwitchState(UIStateType.UICN21N50MainController, true)
end

function UICN21N50MainLobbyEntry:RedAndNew()
  local new = false
  local mainNewVal = UICN21N50Helper.LocalDB_Has("main", "New")
  if not mainNewVal then
    new = true
  end
  local mainNew = false
  local blackNew = false
  local blackNewVal = not UICN21N50Helper.LocalDB_Has("black", "New")
  local blackOpen = self.sampleInfo.m_is_component_open >> UICN21N50Helper.GetComponentId("black") & 1 == 1
  if blackOpen and blackNewVal then
    blackNew = true
  end
  mainNew = new or blackNew
  local mainRed = false
  local shopRed = self.sampleInfo:IsCompRed(UICN21N50Helper.GetComponentId("exchange"))
  local blackKey = UICN21N50Helper._LocalDB_GetKey("black", "Red")
  local blackRed = self.sampleInfo:IsCompRed(UICN21N50Helper.GetComponentId("black")) and not UIActivityHelper.HasCmptRedViewed(blackKey)
  local lineKey = UICN21N50Helper._LocalDB_GetKey("line", "Red")
  local lineRed = self.sampleInfo:IsCompRed(UICN21N50Helper.GetComponentId("line")) and not UIActivityHelper.HasCmptRedViewed(lineKey)
  local signRed = self.sampleInfo:IsCompRed(UICN21N50Helper.GetComponentId("login"))
  mainRed = shopRed or blackRed or lineRed or signRed
  self._newGo:SetActive(mainNew)
  self._redGo:SetActive(mainRed and not mainNew)
end

function UICN21N50MainLobbyEntry:DiffOpen()
  local battleFieldOpen = self.sampleInfo.m_is_component_open >> UICN21N50Helper.GetComponentId("black") & 1 == 1
  self._diffOpenGo:SetActive(battleFieldOpen)
  self._shopOpenGo:SetActive(not battleFieldOpen)
end
