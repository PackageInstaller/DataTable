require("ui_main_lobby_main_campaign_base")
_class("UICN16N45MainLobbyEntry", UIMainLobbyMainCampaignBase)
UICN16N45MainLobbyEntry = UICN16N45MainLobbyEntry

function UICN16N45MainLobbyEntry:GetComponent()
  self._redGo = self:GetGameObject("red")
  self._newGo = self:GetGameObject("new")
  self._diffOpenGo = self:GetGameObject("diffOpen")
  self._shopOpenGo = self:GetGameObject("shopOpen")
end

function UICN16N45MainLobbyEntry:RefreshView()
  self:RedAndNew()
  self:DiffOpen()
end

function UICN16N45MainLobbyEntry:BtnOnClick()
  UICN16N45MainLobbyEntry.super.BtnOnClick(self)
  GameGlobal.UIStateManager():SwitchState(UIStateType.UICN16N45MainController)
end

function UICN16N45MainLobbyEntry:RedAndNew()
  local new = false
  local mainNewVal = UICN16N45Helper.LocalDB_Has("main", "New")
  if not mainNewVal then
    new = true
  end
  local mainNew = false
  local blackNew = false
  local blackNewVal = not UICN16N45Helper.LocalDB_Has("black", "New")
  local blackOpen = self.sampleInfo.m_is_component_open >> ECampaignCN16ComponentID.ECAMPAIGN_N16_HEIXIA & 1 == 1
  if blackOpen and blackNewVal then
    blackNew = true
  end
  mainNew = new or blackNew
  local mainRed = false
  local shopRed = self.sampleInfo:IsCompRed(ECampaignCN16ComponentID.ECAMPAIGN_N16_SHOP)
  local blackKey = UICN16N45Helper._LocalDB_GetKey("black", "Red")
  local blackRed = self.sampleInfo:IsCompRed(ECampaignCN16ComponentID.ECAMPAIGN_N16_HEIXIA) and not UIActivityHelper.HasCmptRedViewed(blackKey)
  local lineKey = UICN16N45Helper._LocalDB_GetKey("line", "Red")
  local lineRed = self.sampleInfo:IsCompRed(ECampaignCN16ComponentID.ECAMPAIGN_N16_LINE_MISSION) and not UIActivityHelper.HasCmptRedViewed(lineKey)
  local signRed = self.sampleInfo:IsCompRed(ECampaignCN16ComponentID.ECAMPAIGN_N16_CUMULATIVE_LOGIN)
  mainRed = shopRed or blackRed or lineRed or signRed
  self._newGo:SetActive(mainNew)
  self._redGo:SetActive(mainRed and not mainNew)
end

function UICN16N45MainLobbyEntry:DiffOpen()
  local battleFieldOpen = self.sampleInfo.m_is_component_open >> ECampaignCN16ComponentID.ECAMPAIGN_N16_HEIXIA & 1 == 1
  self._diffOpenGo:SetActive(battleFieldOpen)
  self._shopOpenGo:SetActive(not battleFieldOpen)
end
