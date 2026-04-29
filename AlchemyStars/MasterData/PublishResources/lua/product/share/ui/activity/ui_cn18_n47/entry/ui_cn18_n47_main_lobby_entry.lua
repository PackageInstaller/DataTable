require("ui_main_lobby_main_campaign_base")
_class("UICN18N47MainLobbyEntry", UIMainLobbyMainCampaignBase)
UICN18N47MainLobbyEntry = UICN18N47MainLobbyEntry

function UICN18N47MainLobbyEntry:GetComponent()
  self._redGo = self:GetGameObject("red")
  self._newGo = self:GetGameObject("new")
  self._diffOpenGo = self:GetGameObject("diffOpen")
  self._shopOpenGo = self:GetGameObject("shopOpen")
end

function UICN18N47MainLobbyEntry:RefreshView()
  self:RedAndNew()
  self:DiffOpen()
end

function UICN18N47MainLobbyEntry:BtnOnClick()
  UICN18N47MainLobbyEntry.super.BtnOnClick(self)
  GameGlobal.UIStateManager():SwitchState(UIStateType.UICN18N47MainController, true)
end

function UICN18N47MainLobbyEntry:RedAndNew()
  local new = false
  local mainNewVal = UICN18N47Helper.LocalDB_Has("main", "New")
  if not mainNewVal then
    new = true
  end
  local mainNew = false
  local blackNew = false
  local blackNewVal = not UICN18N47Helper.LocalDB_Has("black", "New")
  local blackOpen = self.sampleInfo.m_is_component_open >> UICN18N47Helper.GetComponentId("black") & 1 == 1
  if blackOpen and blackNewVal then
    blackNew = true
  end
  mainNew = new or blackNew
  local mainRed = false
  local shopRed = self.sampleInfo:IsCompRed(UICN18N47Helper.GetComponentId("exchange"))
  local blackKey = UICN18N47Helper._LocalDB_GetKey("black", "Red")
  local blackRed = self.sampleInfo:IsCompRed(UICN18N47Helper.GetComponentId("black")) and not UIActivityHelper.HasCmptRedViewed(blackKey)
  local lineKey = UICN18N47Helper._LocalDB_GetKey("line", "Red")
  local lineRed = self.sampleInfo:IsCompRed(UICN18N47Helper.GetComponentId("line")) and not UIActivityHelper.HasCmptRedViewed(lineKey)
  local signRed = self.sampleInfo:IsCompRed(UICN18N47Helper.GetComponentId("login"))
  mainRed = shopRed or blackRed or lineRed or signRed
  self._newGo:SetActive(mainNew)
  self._redGo:SetActive(mainRed and not mainNew)
end

function UICN18N47MainLobbyEntry:DiffOpen()
  local battleFieldOpen = self.sampleInfo.m_is_component_open >> UICN18N47Helper.GetComponentId("black") & 1 == 1
  self._diffOpenGo:SetActive(battleFieldOpen)
  self._shopOpenGo:SetActive(not battleFieldOpen)
end
