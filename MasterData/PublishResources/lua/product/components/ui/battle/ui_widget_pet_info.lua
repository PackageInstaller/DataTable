_class("UIWidgetPetInfo", UICustomWidget)
UIWidgetPetInfo = UIWidgetPetInfo

function UIWidgetPetInfo:OnShow()
  self._attackTxt = self:GetUIComponent("UILocalizationText", "AttackText")
  self._defenseTxt = self:GetUIComponent("UILocalizationText", "DefenseText")
  self._hpTxt = self:GetUIComponent("UILocalizationText", "HpText")
  self._localNameTxt = self:GetUIComponent("UILocalizationText", "LocalName")
  self._englishNameTxt = self:GetUIComponent("UILocalizationText", "EnglishName")
  self._Stars = self:GetGameObject("Stars")
  self._StarList = {}
  for i = 1, self._Stars.transform.childCount do
    self._StarList[i] = self._Stars.transform:GetChild(i - 1).gameObject
  end
  self._cg = self:GetUIComponent("RectTransform", "cg")
  self._roleStaticBody = self:GetUIComponent("RawImageLoader", "Role")
  self._skills = self:GetUIComponent("UISelectObjectPath", "grid")
  self._attackStrID = "str_battle_pet_info_attack"
  self._defenseStrID = "str_battle_pet_info_defense"
  self._hpStrID = "str_battle_pet_info_hp"
  self._energyStrID = "str_battle_pet_info_energy"
  self._infoContainerRT = self:GetUIComponent("RectTransform", "InfoContainer")
  local matchEnterData = self:GetModule(MatchModule):GetMatchEnterData()
  if matchEnterData:GetMatchType() == MatchType.MT_PopStar or matchEnterData:GetSubMatchType() == MatchType.MT_PopStar then
    self._goAttributes = self:GetGameObject("Attributes")
    self._goAttributes:SetActive(false)
  end
  self:AttachEvent(GameEventType.UIShowPetInfo, self.HandleUIShowPetInfo)
  self:AttachEvent(GameEventType.ShowGuideStep, self.ShowGuideStep)
end

function UIWidgetPetInfo:CloseBtnOnClick(go)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.UIShowPetInfo, self.petPstID, false)
end

function UIWidgetPetInfo:CloseBgOnClick(go)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.UIShowPetInfo, self.petPstID, false)
end

function UIWidgetPetInfo:Init(pet)
  self._attackTxt:SetText(StringTable.Get(self._attackStrID) .. " " .. string.format("%.0f", pet:GetPetAttack()))
  self._defenseTxt:SetText(StringTable.Get(self._defenseStrID) .. " " .. string.format("%.0f", pet:GetPetDefence()))
  self._hpTxt:SetText(StringTable.Get(self._hpStrID) .. " " .. string.format("%.0f", pet:GetPetHealth()))
  self._localNameTxt:SetText(StringTable.Get(pet:GetPetName()))
  self._englishNameTxt:SetText(StringTable.Get(pet:GetPetEnglishName()))
  local starCount = pet:GetPetStar()
  for i = 1, #self._StarList do
    if i <= starCount then
      self._StarList[i]:SetActive(true)
    else
      self._StarList[i]:SetActive(false)
    end
  end
  local petModule = GameGlobal.GetModule(PetModule)
  local uiModule = petModule.uiModule
  local skillDetailInfos = uiModule:GetSkillDetailInfoBySkillTypeHideExtra(pet)
  local spawnSkillCount = table.count(skillDetailInfos)
  self._skills:SpawnObjects("UIPetSkillItem", spawnSkillCount)
  self._skillsSpawns = self._skills:GetAllSpawnList()
  if self._skillsSpawns then
    for i = 1, spawnSkillCount do
      local item = self._skillsSpawns[i]
      local skill_info = skillDetailInfos[i]
      local skill_list = skill_info.skillList
      item:Flush(i, pet, skill_list, true)
    end
  end
  local staticBody = pet:GetPetStaticBody(PetSkinEffectPath.BODY_INGAME_PREVIEW)
  UICG.SetTransform(self._cg, self:GetName(), staticBody)
  if not GameGlobal.GetModule(SkillPerfModule):IsBeginPerf() then
    self._roleStaticBody:LoadImage(staticBody)
  end
  UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._infoContainerRT)
  GameGlobal.TaskManager():StartTask(self.ForceRebuildInfoContainer, self)
end

function UIWidgetPetInfo:ForceRebuildInfoContainer(TT)
  self._infoContainerRT.gameObject:SetActive(false)
  YIELD(TT)
  self._infoContainerRT.gameObject:SetActive(true)
  UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._infoContainerRT)
end

function UIWidgetPetInfo:OnHide()
  self._infoContainerRT.gameObject:SetActive(false)
  self:Close()
end

function UIWidgetPetInfo:Close()
  local guideModule = GameGlobal.GetModule(GuideModule)
  if guideModule:GuideInProgress() then
    local guides = guideModule:GetCurGuides()
    if guides then
      for _, guide in pairs(guides) do
        local curStep = guide:GetCurStep()
        if curStep and curStep.show then
          local cfg = curStep:GetBtnGuideCfg()
          if cfg and cfg.completeRule == GuideCompleteType.OperationComplete then
            return
          end
        end
      end
    end
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.FinishGuideStep, GuideType.Button)
end

function UIWidgetPetInfo:ShowGuideStep()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.UIShowPetInfo, self.petPstID, false)
end

function UIWidgetPetInfo:HandleUIShowPetInfo(petPstID, isShow)
  if isShow then
    if GuideHelper.IsUIGuideShow() then
      return
    end
    local enterData = GameGlobal.GetModule(MatchModule):GetMatchEnterData()
    local matchPets = InnerGameHelperRender.GetLocalMatchPets()
    local pet = matchPets[petPstID]
    self.petPstID = petPstID
    self:Init(pet)
    self:GetGameObject():SetActive(true)
  elseif self:GetGameObject().activeSelf then
    self:Close()
    self:GetGameObject():SetActive(false)
  end
end
