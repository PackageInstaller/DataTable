require("ui_main_lobby_main_campaign_base")
_class("UICN22N51MainLobbyEntry", UIMainLobbyMainCampaignBase)
UICN22N51MainLobbyEntry = UICN22N51MainLobbyEntry

function UICN22N51MainLobbyEntry:GetComponent()
  self._redGo = self:GetGameObject("red")
  self._newGo = self:GetGameObject("new")
  self._diffOpenGo = self:GetGameObject("diffOpen")
  self._shopOpenGo = self:GetGameObject("shopOpen")
end

function UICN22N51MainLobbyEntry:RefreshView()
  self:RedAndNew()
  self:DiffOpen()
end

function UICN22N51MainLobbyEntry:BtnOnClick()
  UICN22N51MainLobbyEntry.super.BtnOnClick(self)
  GameGlobal.UIStateManager():SwitchState(UIStateType.UICN22N51MainController, true)
end

function UICN22N51MainLobbyEntry:RedAndNew()
  local new = false
  local mainNewVal = UICN22N51Helper.LocalDB_Has("main", "New")
  if not mainNewVal then
    new = true
  end
  local mainNew = false
  local blackNew = false
  local blackNewVal = not UICN22N51Helper.LocalDB_Has("black", "New")
  local blackOpen = self.sampleInfo.m_is_component_open >> UICN22N51Helper.GetComponentId("black") & 1 == 1
  if blackOpen and blackNewVal then
    blackNew = true
  end
  mainNew = new or blackNew
  local mainRed = false
  local shopRed = self.sampleInfo:IsCompRed(UICN22N51Helper.GetComponentId("exchange"))
  local blackKey = UICN22N51Helper._LocalDB_GetKey("black", "Red")
  local blackRed = self.sampleInfo:IsCompRed(UICN22N51Helper.GetComponentId("black")) and not UIActivityHelper.HasCmptRedViewed(blackKey)
  local lineKey = UICN22N51Helper._LocalDB_GetKey("line", "Red")
  local lineRed = self.sampleInfo:IsCompRed(UICN22N51Helper.GetComponentId("line")) and not UIActivityHelper.HasCmptRedViewed(lineKey)
  local signRed = self.sampleInfo:IsCompRed(UICN22N51Helper.GetComponentId("login"))
  mainRed = shopRed or blackRed or lineRed or signRed
  self._newGo:SetActive(mainNew)
  self._redGo:SetActive(mainRed and not mainNew)
end

function UICN22N51MainLobbyEntry:DiffOpen()
  local battleFieldOpen = self.sampleInfo.m_is_component_open >> UICN22N51Helper.GetComponentId("black") & 1 == 1
  self._diffOpenGo:SetActive(battleFieldOpen)
  self._shopOpenGo:SetActive(not battleFieldOpen)
end
