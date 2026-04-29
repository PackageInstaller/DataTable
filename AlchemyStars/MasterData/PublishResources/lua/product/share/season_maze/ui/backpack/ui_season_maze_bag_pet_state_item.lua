_class("UISeasonMazeBagPetStateItem", UICustomWidget)
UISeasonMazeBagPetStateItem = UISeasonMazeBagPetStateItem

function UISeasonMazeBagPetStateItem:OnShow(uiParams)
  self:InitWidget()
  self._module = self:GetModule(MissionModule)
  self._ctx = self._module:TeamCtx()
  self.team = self._ctx:GetSeasonMazeTeam()
end

function UISeasonMazeBagPetStateItem:InitWidget()
  self.root = self:GetGameObject("root")
  self.info = self:GetUIComponent("UISelectObjectPath", "info")
  self.noinfo = self:GetGameObject("noinfo")
  self.bg = self:GetUIComponent("Image", "bg")
  self.btn = self:GetGameObject("btn")
  self.helppet = self:GetGameObject("helppet")
  self.zzrk = self:GetUIComponent("Image", "zzrk")
  self.wfzz = self:GetUIComponent("Image", "wfzz")
  self.lostLand = self:GetGameObject("lostLand")
  self.recommend = self:GetGameObject("recommend")
  self.noinfotext = self:GetUIComponent("UILocalizationText", "noinfotext")
  self.binderPet = self:GetGameObject("binderPet")
  self.binderPetTex = self:GetUIComponent("RollingText", "binderPetTex")
  self.diffGo = self:GetGameObject("diffGo")
  self.fastTeam = self:GetGameObject("fastTeam")
  self.enhanceFlagArea = self:GetUIComponent("UISelectObjectPath", "EnhanceFlagArea")
  self.eightFightDisable = self:GetGameObject("eightFightDisable")
  self.eightFightDisableTxt = self:GetUIComponent("UILocalizationText", "eightFightDisableTxt")
  self.fastTeamObj = self:GetGameObject("fastTeam")
  self.fastTeamObj:SetActive(false)
  self.memberIDTxt = self:GetUIComponent("UILocalizationText", "memberID")
  self.dispatch = self:GetGameObject("dispatch")
  self.dispatchText = self:GetUIComponent("UILocalizationText", "dispatchText")
  self.anim = self:GetUIComponent("Animation", "anim")
  self.anim.gameObject:SetActive(false)
end

function UISeasonMazeBagPetStateItem:SetData(config, clickCB, realbool, firstIn, teamOpenerType, petSkinEffectPath, index)
  self._hide = nil
  local heart = self.info:SpawnObject("UIHeartItem")
  self.heartItem = heart
  self.clickCB = clickCB
  self.config = config
  self.heartItem:SetData(self.config, function(id)
    self.clickCB(id)
  end, false, false, teamOpenerType, petSkinEffectPath, false, false, true)
  self.fastTeamObj:SetActive(false)
  if #self.team.list > 0 then
    local tmpTeam = self.team.list[1]:Clone()
    local pets = tmpTeam:GetPets()
    for i = 1, #pets do
      local pet = pets[i]
      if pet == config:GetPstID() then
        self.fastTeamObj:SetActive(true)
        self.memberIDTxt:SetText("" .. i)
      end
    end
  end
  local module = GameGlobal.GetModule(SeasonMazeModule)
  local dispatch = module:GetPetDispatchData(config:GetTemplateID())
  if dispatch then
    self.dispatch:SetActive(true)
    local dispatch = module:GetPetDispatchData(config:GetTemplateID())
    if dispatch then
      self.dispatchText:SetText(dispatch.residue_round)
    else
      Log.exception("pet has dispatched but has no server data")
    end
  else
    self.dispatch:SetActive(false)
  end
  if index then
    local delta = math.ceil(index / 5)
    delta = delta * 50
    if delta == 0 then
      self.anim.gameObject:SetActive(true)
    else
      local timerEvent = GameGlobal.Timer():AddEventTimes(delta, TimerTriggerCount.Once, function()
        if not self._hide then
          self.anim.gameObject:SetActive(true)
          self.anim:Play("uieffanim_UISeasonMazeBagPetStateItem_in")
        end
      end)
    end
  else
    self.anim.gameObject:SetActive(true)
  end
end

function UISeasonMazeBagPetStateItem:SetInVisible()
  self._hide = true
end

function UISeasonMazeBagPetStateItem:PlayFadeInAnim()
end

function UISeasonMazeBagPetStateItem:ResetInAnim()
end

function UISeasonMazeBagPetStateItem:ShowRedPoint()
end

function UISeasonMazeBagPetStateItem:BgOnClick(go)
  local id = self.config:GetPstID()
  self.clickCB(id)
end

function UISeasonMazeBagPetStateItem:RecommendBtnOnClick(go)
end
