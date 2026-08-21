require("ui_main_lobby_main_campaign_base")
_class("UIN39MainEnter", UIMainLobbyMainCampaignBase)
UIN39MainEnter = UIN39MainEnter

function UIN39MainEnter:GetComponent()
  self._redGo = self:GetGameObject("redGo")
  self._newGo = self:GetGameObject("newGo")
  self._tips = self:GetUIComponent("RollingText", "tipsText")
  self._ny_campaign = UIActivityCampaign:New()
  self._ny_campaign:LoadCampaignInfo_Local(ECampaignType.CAMPAIGN_TYPE_N25_NEW_YEAR)
end

function UIN39MainEnter:RefreshView()
  local new = self:CheckNew()
  local red = self:CheckRed()
  self._newGo:SetActive(new)
  self._redGo:SetActive(red and not new)
  self:BlackOpen()
end

function UIN39MainEnter:CheckNew()
  local mainNew = UIN39Helper.CheckNew("main")
  local loginNew = self:CheckComNew("login")
  local exchangeNew = self:CheckComNew("exchange")
  local lineNew = self:CheckComNew("line")
  local hardNew = self:CheckComNew("hard")
  local blackNew = self:CheckComNew("black")
  local ny_new = self._ny_campaign:CheckCampaignOpen() and UIN39Helper.CheckNew("ny_login")
  return mainNew or loginNew or exchangeNew or lineNew or hardNew or blackNew or ny_new
end

function UIN39MainEnter:CheckRed()
  local loginRed = self:CheckComRed("login")
  local exchangeRed = self:CheckComRed("exchange")
  local lineRed = self:CheckComRed("line")
  local hardRed = self:CheckComRed("hard")
  local blackRed = self:CheckComRed("black")
  local ny_red = self._ny_campaign:CheckCampaignRed()
  return loginRed or exchangeRed or lineRed or hardRed or blackRed or ny_red
end

function UIN39MainEnter:CheckComRed(comTag)
  local open = self:CheckComOpen(comTag)
  local red = self:CheckComRedWithTime(comTag)
  return open and red
end

function UIN39MainEnter:CheckComRedWithTime(comTag)
  local timePass = true
  if comTag == "line" or comTag == "hard" or comTag == "black" then
    timePass = UIN39Helper.CheckComRedTime(comTag)
  end
  local comid = UIN39Helper.GetComponentId(comTag)
  local red = self.sampleInfo.m_components_step >> comid & 1 == 1
  return timePass and red
end

function UIN39MainEnter:CheckComNew(comTag)
  local open = self:CheckComOpen(comTag)
  local new = UIN39Helper.CheckNew(comTag)
  return open and new
end

function UIN39MainEnter:CheckComOpen(comTag)
  local comid = UIN39Helper.GetComponentId(comTag)
  local open = self.sampleInfo.m_is_component_open >> comid & 1 == 1
  return open
end

function UIN39MainEnter:BlackOpen()
  local blackOpen = self:CheckComOpen("black")
  local tex
  if blackOpen then
    tex = "str_n39_main_entry_tips3"
  else
    local diffOpen = self:CheckComOpen("hard")
    if diffOpen then
      tex = "str_n39_main_entry_tips2"
    else
      tex = "str_n39_main_entry_tips1"
    end
  end
  self._tips:RefreshText(StringTable.Get(tex))
end

function UIN39MainEnter:BtnOnClick()
  UIN39MainEnter.super.BtnOnClick(self)
  if self.ctl then
    self.ctl._screenShot.OwnerCamera = GameGlobal.UIStateManager():GetControllerCamera(self.ctl:GetName())
    local rt = self.ctl._screenShot:RefreshBlurTexture()
    local cache_rt = UnityEngine.RenderTexture:New(UnityEngine.Screen.width, UnityEngine.Screen.height, 16)
    self:StartTask(function(TT)
      YIELD(TT)
      UnityEngine.Graphics.Blit(rt, cache_rt)
      self:SwitchState(UIStateType.UIN39MainController, false, cache_rt)
    end)
  else
    self:SwitchState(UIStateType.UIN39MainController, false)
  end
end
