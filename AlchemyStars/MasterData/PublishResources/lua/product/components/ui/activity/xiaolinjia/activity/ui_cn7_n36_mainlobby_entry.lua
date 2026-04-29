require("ui_main_lobby_main_campaign_base")
_class("UICN7N36MainLobbyEntry", UIMainLobbyMainCampaignBase)
UICN7N36MainLobbyEntry = UICN7N36MainLobbyEntry

function UICN7N36MainLobbyEntry:GetComponent()
  self._redGo = self:GetGameObject("RedPoint")
  self._newGo = self:GetGameObject("NewFlag")
  self._tipspanel1 = self:GetGameObject("tipspanel1")
  self._tipspanel2 = self:GetGameObject("tipspanel2")
  self._tipspanel3 = self:GetGameObject("tipspanel3")
  self._activityConst = UIActivityCustomConst:New(self:GetCampaignType(), self:GetComponentIds())
end

function UICN7N36MainLobbyEntry:RequestCampaign()
  self:StartTask(function(TT)
    local lockName = "UICN7N36MainLobbyEntryRequestCampaign"
    self:Lock(lockName)
    local res = AsyncRequestRes:New()
    res:SetSucc(true)
    self._activityConst:LoadData(TT, res)
    self:RedAndNew()
    self:Flush()
    self:UnLock(lockName)
  end, self)
end

function UICN7N36MainLobbyEntry:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_INLAND_N7
end

function UICN7N36MainLobbyEntry:GetComponentIds()
  local componentIds = {}
  componentIds[#componentIds + 1] = ECampaignCN7ComponentID.ECAMPAIGN_N7_LINE_MISSION
  componentIds[#componentIds + 1] = ECampaignCN7ComponentID.ECAMPAIGN_N7_LOTTERY
  componentIds[#componentIds + 1] = ECampaignCN7ComponentID.ECAMPAIGN_N7_TACIT_TEST
  return componentIds
end

function UICN7N36MainLobbyEntry:RefreshView()
  self:RequestCampaign()
end

function UICN7N36MainLobbyEntry:BtnOnClick()
  UICN7N36MainLobbyEntry.super.BtnOnClick(self)
  GameGlobal.UIStateManager():ShowDialog(UIStateType.UICN7N36MainController)
end

function UICN7N36MainLobbyEntry:RedAndNew()
  local red = self.sampleInfo:GetStepStatus(ECampaignStep.CAMPAIGN_STEP_RED)
  self.campaign = self._activityConst:GetCampaign()
  self._localProcess = self.campaign:GetLocalProcess()
  local new = self:CheckNew()
  local OtherRed = self:CheckRed()
  red = red or OtherRed
  self._newGo:SetActive(new)
  self._redGo:SetActive(red and not new)
end

function UICN7N36MainLobbyEntry:CheckRed()
  local shopRed = self._localProcess:ShopRedPoint()
  local loginRed = self._localProcess:AccumulateLoginReddot()
  local questHasRed = self.campaign:CheckComponentRed(ECampaignCN7ComponentID.ECAMPAIGN_N7_QUEST)
  local red = shopRed or loginRed or questHasRed
  return red
end

function UICN7N36MainLobbyEntry:CheckNew()
  local roleModule = GameGlobal.GetModule(RoleModule)
  local pstid = roleModule:GetPstId()
  local save_key = {}
  save_key[1] = pstid .. "UICN7N36MainLobbyEntry_LineNew"
  save_key[2] = pstid .. "UICN7N36MainLobbyEntry_ShopNew"
  save_key[3] = pstid .. "UICN7N36MainLobbyEntry_GamesNew"
  local lineOpen = self.campaign:CheckComponentOpen(ECampaignCN7ComponentID.ECAMPAIGN_N7_LINE_MISSION)
  local gameOpen = self.campaign:CheckComponentOpen(ECampaignCN7ComponentID.ECAMPAIGN_N7_TACIT_TEST)
  local lineNew, shopNew, gameNew
  if LocalDB.HasKey(save_key[1]) then
    lineNew = false
  elseif lineOpen then
    lineNew = true
  end
  if LocalDB.HasKey(save_key[2]) then
    shopNew = false
  else
    shopNew = true
  end
  if LocalDB.HasKey(save_key[3]) then
    gameNew = false
  elseif gameOpen then
    gameNew = true
  end
  return lineNew or shopNew or gameNew
end

function UICN7N36MainLobbyEntry:Flush()
  local status, time
  status, time = self._activityConst:GetComponentStatus(ECampaignCN7ComponentID.ECAMPAIGN_N7_TACIT_TEST)
  if status == ActivityComponentStatus.Open then
    self._tipspanel1:SetActive(true)
    return
  else
    self._tipspanel1:SetActive(false)
  end
end
