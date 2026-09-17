local this = class("pagePetPreview", G_UIPageBase)
local wordsTpl = L_GameTpl:getWordsTpl()
local _homeBuildingTpl = L_GameTpl:getHomeBuildingTpl()
local petInfoTpl = L_GameTpl:getPetTpl()
local _petCustomizedTpl = L_GameTpl:getPetCustomizedTpl()

function this:ctor(...)
  this.super.ctor(self, ...)
end

function this.bind()
  return {
    toggleInfo = true,
    toggleModuleBar = {
      type = "toggleModule",
      modulePetDetail = {
        assetName = "UI/Pages/Pet/modulePetDetail",
        moduleName = "pages/pet/modulePetDetail"
      },
      moduleRankUpPreviewPet = {
        assetName = "UI/Pages/Pet/moduleRankUpPreviewPet",
        moduleName = "pages/Pet/moduleRankUpPreviewPet"
      }
    },
    toggleModuleName = "",
    modulePetSceneMod = {
      type = "toggleModule",
      modulePetSceneMod = {
        assetName = "UI/Pages/Pet/modulePetSceneMod",
        moduleName = "pages/Pet/modulePetSceneMod"
      }
    },
    modulePetSceneModName = ""
  }
end

function this.methods()
  return {
    toggleInfoBtn = function(self)
      self:returnToDefaultModule()
    end,
    toggleRankUp = function(self)
      local result = C_IntegrateMgr.SystemUnlockModule:CheckAndTip(L_SystemConst.enum.petRankUp)
      if not result then
        return
      end
      self.bind.toggleModuleName = "moduleRankUpPreviewPet"
      if self.itemType == L_Const.resType.petCustomized then
        local petCustomizedTpl = _petCustomizedTpl:getTplById(self.petCustomizedId)
        local specialParam = _petCustomizedTpl:getColorParam(petCustomizedTpl)
        self.modules.toggleModuleBar.moduleRankUpPreviewPet:infoRefresh(self.petConfigId, specialParam)
      else
        self.modules.toggleModuleBar.moduleRankUpPreviewPet:infoRefresh(self.petConfigId)
      end
    end
  }
end

function this:check(options, callback)
  local result = C_IntegrateMgr.SystemUnlockModule:CheckAndTip(L_SystemConst.enum.pet)
  callback(result)
end

function this:preOpen(options)
  this.super.preOpen(self, options)
  self.itemType = options.itemType
  L_AudioUtil.playSound("Play_SFX_System_UI_General_Frame_Open")
  if self.itemType == L_Const.resType.petCustomized then
    self.petCustomizedId = options.configId
    local tpl = _petCustomizedTpl:getTplById(self.petCustomizedId)
    self.petConfigId = _petCustomizedTpl:getPetId(tpl)
    self:initCustomizedPetData(self.petConfigId, self.petCustomizedId)
  else
    self.petConfigId = options.configId
    self:initData(self.petConfigId)
  end
  local tpl = petInfoTpl:getTplById(self.petConfigId)
  local customSceneId = petInfoTpl:getHouseType(tpl)
  L_PetManager:loadPetDetailScene(customSceneId)
  self.bind.modulePetSceneModName = "modulePetSceneMod"
  if self.itemType == L_Const.resType.petCustomized then
    self:refreshSpecialPetMod()
  else
    self:refreshPetMod()
  end
  self.closeCurPageFunc = nil
  C_CameraManager.SetBrainBlendStyle(L_Const.blendStyle.cut)
  local brain = C_CameraManager.GetMainCameraBrain()
  brain.m_CustomBlends = nil
end

function this:onTopBarRefresh()
  C_IntegrateMgr.TopBarModule:SetTopBarBackName(L_WordsTpl:getValue("ui_pagePetPreview"))
  C_IntegrateMgr.TopBarModule:SetTopBarCloseFunc(function()
    if self.closeCurPageFunc then
      self.closeCurPageFunc()
      self.closeCurPageFunc = nil
      C_IntegrateMgr.TopBarModule:SetTopBarBackName(L_WordsTpl:getValue("ui_pagePetPreview"))
      return
    end
    L_UI:close(self.pageName)
  end)
end

function this:setCommonTopData(func, name)
  self.closeCurPageFunc = func
  C_IntegrateMgr.TopBarModule:SetTopBarBackName(name)
end

function this:close(options)
  this.super.close(self, options)
  self:disableAllModule()
  L_PetManager:removePetScene()
end

function this:initData(petConfigId)
  if not math.isEmpty(petConfigId) then
    self.petConfigId = petConfigId
    self.bind.toggleModuleName = "modulePetDetail"
    L_PetStore:playPetVoiceSound(self.petConfigId, L_PetConst.PetSystemVoiceType.PropertyDetail)
    self.modules.toggleModuleBar.modulePetDetail:infoRefresh(self.petConfigId)
  end
end

function this:initCustomizedPetData(petConfigId, petCustomizedId)
  if not math.isEmpty(petConfigId) then
    self.petConfigId = petConfigId
    self.petCustomizedId = petCustomizedId
    self.bind.toggleModuleName = "modulePetDetail"
    L_PetStore:playPetVoiceSound(self.petConfigId, L_PetConst.PetSystemVoiceType.PropertyDetail)
    self.modules.toggleModuleBar.modulePetDetail:infoRefreshCustomized(self.petConfigId, self.petCustomizedId)
  end
end

function this:refreshPetMod()
  if self.petConfigId then
    self.modules.modulePetSceneMod.modulePetSceneMod:refreshPetMod(self.petConfigId, 0, false)
  else
    self.modules.modulePetSceneMod.modulePetSceneMod:disableMod()
  end
end

function this:refreshSpecialPetMod()
  if self.petCustomizedId then
    local tpl = _petCustomizedTpl:getTplById(self.petCustomizedId)
    local isSpecial = _petCustomizedTpl:getColorParam(tpl)
    local isLight = _petCustomizedTpl:getLightParam(tpl) > 0
    self.modules.modulePetSceneMod.modulePetSceneMod:refreshPetMod(self.petConfigId, isSpecial, isLight)
  else
    self.modules.modulePetSceneMod.modulePetSceneMod:disableMod()
  end
end

function this:disableAllModule()
  self.bind.toggleModuleName = ""
end

function this:returnToDefaultModule()
  local petConfigId = self.petConfigId
  if not math.isEmpty(petConfigId) then
    self.bind.toggleModuleName = "modulePetDetail"
    self.bind.toggleInfo = true
    if self.itemType == L_Const.resType.petCustomized then
      self:initCustomizedPetData(self.petConfigId, self.petCustomizedId)
    else
      self:initData(petConfigId)
    end
  end
end

function this:closePetAdvance()
  self:returnToDefaultModule()
end

return this
