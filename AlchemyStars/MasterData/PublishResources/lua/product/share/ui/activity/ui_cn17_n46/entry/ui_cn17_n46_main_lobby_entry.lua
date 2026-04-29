require("ui_main_lobby_main_campaign_base")
_class("UICN17N46MainLobbyEntry", UIMainLobbyMainCampaignBase)
UICN17N46MainLobbyEntry = UICN17N46MainLobbyEntry

function UICN17N46MainLobbyEntry:GetComponent()
  self._redGo = self:GetGameObject("red")
  self._newGo = self:GetGameObject("new")
  self._diffOpenGo = self:GetGameObject("diffOpen")
  self._shopOpenGo = self:GetGameObject("shopOpen")
end

function UICN17N46MainLobbyEntry:RefreshView()
  self:RedAndNew()
  self:DiffOpen()
end

function UICN17N46MainLobbyEntry:BtnOnClick()
  UICN17N46MainLobbyEntry.super.BtnOnClick(self)
  GameGlobal.UIStateManager():SwitchState(UIStateType.UICN17N46MainController)
end

function UICN17N46MainLobbyEntry:RedAndNew()
  local new = false
  local mainNewVal = UICN17N46Helper.LocalDB_Has("main", "New")
  if not mainNewVal then
    new = true
  end
  local mainNew = false
  local blackNew = false
  local blackNewVal = not UICN17N46Helper.LocalDB_Has("black", "New")
  local blackOpen = self.sampleInfo.m_is_component_open >> ECampaignCN17ComponentID.ECAMPAIGN_N17_HEIXIA & 1 == 1
  if blackOpen and blackNewVal then
    blackNew = true
  end
  mainNew = new or blackNew
  local mainRed = false
  local shopRed = self.sampleInfo:IsCompRed(ECampaignCN17ComponentID.ECAMPAIGN_N17_SHOP)
  local blackKey = UICN17N46Helper._LocalDB_GetKey("black", "Red")
  local blackRed = self.sampleInfo:IsCompRed(ECampaignCN17ComponentID.ECAMPAIGN_N17_HEIXIA) and not UIActivityHelper.HasCmptRedViewed(blackKey)
  local lineKey = UICN17N46Helper._LocalDB_GetKey("line", "Red")
  local lineRed = self.sampleInfo:IsCompRed(ECampaignCN17ComponentID.ECAMPAIGN_N17_LINE_MISSION) and not UIActivityHelper.HasCmptRedViewed(lineKey)
  local signRed = self.sampleInfo:IsCompRed(ECampaignCN17ComponentID.ECAMPAIGN_N17_CUMULATIVE_LOGIN)
  mainRed = shopRed or blackRed or lineRed or signRed
  self._newGo:SetActive(mainNew)
  self._redGo:SetActive(mainRed and not mainNew)
end

function UICN17N46MainLobbyEntry:DiffOpen()
  local battleFieldOpen = self.sampleInfo.m_is_component_open >> ECampaignCN17ComponentID.ECAMPAIGN_N17_HEIXIA & 1 == 1
  self._diffOpenGo:SetActive(battleFieldOpen)
  self._shopOpenGo:SetActive(not battleFieldOpen)
end
