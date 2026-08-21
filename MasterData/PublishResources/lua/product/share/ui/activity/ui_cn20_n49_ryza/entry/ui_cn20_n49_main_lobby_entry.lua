require("ui_main_lobby_main_campaign_base")
_class("UICN20N49MainLobbyEntry", UIMainLobbyMainCampaignBase)
UICN20N49MainLobbyEntry = UICN20N49MainLobbyEntry

function UICN20N49MainLobbyEntry:GetComponent()
  self._redGo = self:GetGameObject("red")
  self._newGo = self:GetGameObject("new")
  self._line_Tips = self:GetUIComponent("UILocalizationText", "line_Tips")
end

function UICN20N49MainLobbyEntry:RefreshView()
  self:LineOpen()
  self:RedAndNew()
end

function UICN20N49MainLobbyEntry:BtnOnClick()
  UICN20N49MainLobbyEntry.super.BtnOnClick(self)
  GameGlobal.UIStateManager():SwitchState(UIStateType.UICN20N49MainController, true)
end

function UICN20N49MainLobbyEntry:RedAndNew()
  local new = false
  local mainNewVal = UICN20N49Helper.LocalDB_Has("main", "New")
  if not mainNewVal then
    new = true
  end
  local mainNew = false
  local talentNew = false
  local alchemyNew = false
  local alchemyShopNew = false
  local talentNewVal = not UICN20N49Helper.LocalDB_Has("talent", "New")
  local talentOpen = self.sampleInfo.m_is_component_open >> UICN20N49Helper.GetComponentId("talent") & 1 == 1
  if talentOpen and talentNewVal then
    talentNew = true
  end
  local alchemyNewVal = not UICN20N49Helper.LocalDB_Has("alchemy", "New")
  local alchemyOpen = self.sampleInfo.m_is_component_open >> UICN20N49Helper.GetComponentId("alchemy") & 1 == 1
  if alchemyOpen and alchemyNewVal then
    alchemyNew = true
  end
  local alchemyShopNewVal = not UICN20N49Helper.LocalDB_Has("alchemyShop", "New")
  local alchemyShopOpen = self.sampleInfo.m_is_component_open >> UICN20N49Helper.GetComponentId("alchemyShop") & 1 == 1
  if alchemyShopOpen and alchemyShopNewVal then
    alchemyShopNew = true
  end
  mainNew = new or talentNew or alchemyNew or alchemyShopNew
  local mainRed = false
  local lineKey = UICN20N49Helper._LocalDB_GetKey("line", "Red")
  local lineRed = self.sampleInfo:IsCompRed(UICN20N49Helper.GetComponentId("line")) and not UIActivityHelper.HasCmptRedViewed(lineKey)
  local loginRed = self.sampleInfo:IsCompRed(UICN20N49Helper.GetComponentId("login"))
  local talentRed = UICN20N49Helper.GetActionPointCount() > 0
  local treeRed = false
  local shopRed = self.sampleInfo:IsCompRed(UICN20N49Helper.GetComponentId("exchange"))
  local alchemyRed = false
  local alchemyShopRed = self.sampleInfo:IsCompRed(UICN20N49Helper.GetComponentId("alchemyShop"))
  mainRed = lineRed or loginRed or talentRed or treeRed or shopRed or alchemyRed or alchemyShopRed
  self._newGo:SetActive(mainNew)
  self._redGo:SetActive(mainRed and not mainNew)
end

function UICN20N49MainLobbyEntry:LineOpen()
  local talentOpen = self.sampleInfo.m_is_component_open >> UICN20N49Helper.GetComponentId("talent") & 1 == 1
  local lineOpen = self.sampleInfo.m_is_component_open >> UICN20N49Helper.GetComponentId("line") & 1 == 1
  if talentOpen then
    local actionPointCount = UICN20N49Helper.GetActionPointCount()
    if 0 < actionPointCount then
      self._line_Tips:SetText(StringTable.Get("str_cn20_n49_line_talent_open_tips"))
    else
      self._line_Tips:SetText("")
    end
  elseif lineOpen then
    self._line_Tips:SetText(StringTable.Get("str_cn20_n49_line_level_open_tips"))
  else
    self._line_Tips:SetText("")
  end
end
