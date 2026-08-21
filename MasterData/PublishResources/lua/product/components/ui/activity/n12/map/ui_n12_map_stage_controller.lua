require("ui_n12_map_controller")
_class("UIN12MapStageController", UIN12MapController)
UIN12MapStageController = UIN12MapStageController

function UIN12MapStageController:GetComponents()
  self._enemyPool = self:GetUIComponent("UISelectObjectPath", "enemyPool")
  self._enemyObj = self._enemyPool:SpawnObject("UIStageEnemy")
  self._btnTex = self:GetUIComponent("UILocalizedTMP", "btnTex")
  self._passGo = self:GetGameObject("pass")
  self._alpha = self:GetUIComponent("CanvasGroup", "btnTex")
  self._btnImg = self:GetUIComponent("Image", "btn")
  self._btn = self:GetUIComponent("Button", "btn")
  self._contentSizeFitter = self:GetUIComponent("ContentSizeFitter", "btnTex")
  self._btnTexRect = self:GetUIComponent("RectTransform", "btnTex")
  self._atlas = self:GetAsset("UIN12_Entrust.spriteatlas", LoadType.SpriteAtlas)
end

function UIN12MapStageController:OnValue()
  local cfg = self:Cfg()
  self._missionid = cfg.MissionID
  local cfg_campaign_mission = Cfg.cfg_campaign_mission[self._missionid]
  if not cfg_campaign_mission then
    Log.error("###[UIN12MapStageController] cfg_campaign_mission is nil ! id --> ", self._missionid)
  end
  local missionType = cfg_campaign_mission.Type
  local recommendAwaken = cfg_campaign_mission.RecommendAwaken
  local recommendLV = cfg_campaign_mission.RecommendLV
  local fightLevel = cfg_campaign_mission.FightLevel
  local color = Color(1, 1, 1)
  self._enemyObj:Flush(recommendAwaken, recommendLV, fightLevel, color)
  self:SetPass()
  local title
  if self._pass then
    title = StringTable.Get("str_n12_map_stage_fight_again")
  else
    title = StringTable.Get("str_n12_map_stage_fight")
  end
  self:SetTextMat()
  self._btnTex:SetText(title)
  self:ChangeTextWidth(self._btnTex)
end

function UIN12MapStageController:btnOnClick(go)
  local module = self:GetModule(MissionModule)
  local ctx = module:TeamCtx()
  ctx:Init(TeamOpenerType.Campaign, {
    self._missionid,
    self._component:GetCampaignMissionComponentId(),
    self._component:GetCampaignMissionParamKeyMap()
  })
  self:Lock("DoEnterTeam")
  ctx:ShowDialogUITeams()
end
