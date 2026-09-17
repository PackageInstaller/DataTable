local this = class("cellQuickFormationEditPos", G_UIModuleBase)
local _heroTpl = L_GameTpl:getHeroTpl()
local _professionTpl = L_GameTpl:getProfessionTpl()
local _elementTypeTpl = L_GameTpl:getElementTypeTpl()
local IsPc = L_DeviceTpl:getIsPc()

function this.bind()
  return {
    txt_posIndex = nil,
    isOn_heroEmpty = false,
    isOn_petEmpty = false,
    img_hero = nil,
    txt_heroLevel = nil,
    list_heroStar = {},
    img_heroQuality_normal = nil,
    img_heroQuality = nil,
    img_heroQuality_round = nil,
    module_cellPixelPet = {
      moduleName = "pages/formation/formationModule/cellFormationPet"
    },
    isOn_editHero = false,
    isOn_editHeroEmpty = false,
    is_OnEditPet = false,
    isOn_editPetEmpty = false,
    img_hero_Sel_round = false,
    img_HeroSel = false,
    img_Pet_Sel = false,
    activeElement = false,
    activeSingleElement = false,
    activeDoubleElement = false,
    imgElementBG = "",
    imgMainElementBG = "",
    imgSubElementBG = "",
    imgProfessionIcon = "",
    txtProfession = "",
    txt_name = ""
  }
end

function this.methods()
  return {
    onClick_selectHero = function(self)
      self.parent.SelHeroPosIndex = self.bind.posIndex
      self:emit("onClick_selectHero", self.bind)
    end,
    onClick_selectPet = function(self)
      self.parent.SelPetPosIndex = self.bind.posIndex
      self:emit("onClick_selectPet", self.bind)
    end,
    onPointEnter_hero = function(self)
      if not IsPc then
        return
      end
      if self.parent and self.parent.bAfterLongPress and self.parent._editTarget == L_FormationConst.FormationEditTarget.Hero then
        self.bind.img_HeroSel = true
      end
    end,
    onPointExit_hero = function(self)
      if not IsPc then
        return
      end
      if self.parent.bAfterLongPress and self.parent._editTarget == L_FormationConst.FormationEditTarget.Hero then
        self.bind.img_HeroSel = false
      end
    end,
    onPointEnter_pet = function(self)
      if self.parent.bAfterLongPress and self.parent._editTarget == L_FormationConst.FormationEditTarget.Pet then
        self.bind.img_Pet_Sel = true
      end
    end,
    onPointExit_pet = function(self)
      if self.parent.bAfterLongPress and self.parent._editTarget == L_FormationConst.FormationEditTarget.Pet then
        self.bind.img_Pet_Sel = false
      end
    end,
    onClick_professionIcon = function(self)
      local hero = L_HeroStore:getHero(self.bind.hero_guid)
      L_UI:open("pageElementalRestraint", {
        heroTplId = L_HeroStore:getHeroConfigId(hero),
        initTab = 1
      })
    end
  }
end

function this:open()
  self:refreshView(self.bind)
  self._ESyncHeroServerDataHandler = handler(self, self.onEvent_refreshHero)
  AzurWorld.heroMgr:RegisterEvent(C_EHeroEvent.ESyncHeroServerData, self._ESyncHeroServerDataHandler)
end

function this:close()
  if self._ESyncHeroServerDataHandler then
    AzurWorld.heroMgr:UnregisterEvent(C_EHeroEvent.ESyncHeroServerData, self._ESyncHeroServerDataHandler)
    self._ESyncHeroServerDataHandler = nil
  end
end

function this:unBind()
  self.super.unBind(self)
  L_PhotoManager:clearPhotoEntity(self)
end

function this:refreshView(pos)
  if not self.isBind then
    return
  end
  self.posData = pos
  self.bind.hero_guid = pos.hero_guid
  self.bind.pet_guid = pos.pet_guid
  self.bind.txt_posIndex = tostring(self.bind.posIndex)
  self.bind.isOn_heroEmpty = math.isEmpty(pos.hero_guid)
  self.bind.isOn_petEmpty = math.isEmpty(pos.pet_guid)
  if not self.bind.isOn_heroEmpty then
    local heroData = L_HeroStore:getHero(pos.hero_guid)
    local heroConfigId = L_HeroStore:getHeroConfigId(heroData)
    local tpl_hero = _heroTpl:getTplById(heroConfigId)
    self.bind.txt_name = L_HeroManager:getHeroName(pos.hero_guid)
    self:refreshElementIcons(heroConfigId)
    if pos.hero_guid == L_HeroStore:getDefaultHeroGuid() then
      if not self.isLoadedMain then
        self.bind.img_hero = ""
        L_PhotoManager:newOrBindPhotoEntity(self, self.bindComponents.rect_img_hero, L_PlayerStore:getPlayerModHalfBodyName())
      end
      self.isLoadedMain = true
    else
      self.bind.img_hero = ""
      local clothingId = AzurWorld.heroMgr:GetUsingClothingId(pos.hero_guid, heroConfigId)
      local heroClothingTpl = L_GameTpl:getHeroClothingTpl()
      self.bind.img_hero = heroClothingTpl:getAvatarTexture(heroClothingTpl:getTplById(clothingId), L_Const.resourceIndexOfAvatarTextureInHeroTpl.headBig)
      L_PhotoManager:clearPhotoEntity(self)
      self.isLoadedMain = false
    end
    self.bind.txt_heroLevel = tostring(L_HeroStore:getHeroLevel(heroData))
    local heroQuality = _heroTpl:getRarity(tpl_hero)
    self.bind.img_heroQuality_round = string.format("UI/Atlas/FormationPage/tex_formation_bg_quality%s_round.png", heroQuality)
    self.bind.img_heroQuality_normal = string.format("UI/Atlas/FormationPage/tex_formation_bg_quality%s_normal.png", heroQuality)
    self.bind.img_heroQuality = string.format("UI/Atlas/FormationPage/tex_formation_bg_quality%s.png", heroQuality)
    self:_setStars(heroQuality + 1)
  end
  if not self.bind.isOn_petEmpty then
    local modulePixelPet = self.modules.module_cellPixelPet
    modulePixelPet:setPetDataContent(pos.pet_guid, {
      filterType = L_PetConst.filterPetBox.level,
      outlineShow = true
    })
  end
  self:refreshSel()
end

function this:_setStars(num)
  if not self.isBind then
    return
  end
  local stars = {}
  for i = 1, num do
    table.insert(stars, {})
  end
  self.bind.list_heroStar:clear()
  self.bind.list_heroStar:insert_array(stars)
end

function this:setEditTarget(target)
  local isHero = target == L_FormationConst.FormationEditTarget.Hero
  self:refreshSel()
end

function this:refreshSel()
  if self.parent._editTarget == L_FormationConst.FormationEditTarget.Hero then
    if self.parent.bAfterLongPress then
      self.bind.isOn_editHero = true
      self.bind.isOn_editHeroEmpty = true
      self.bind.img_hero_Sel_round = true
      self.bind.img_HeroSel = false
    elseif self.bind and self.bind.posIndex == self.parent.SelHeroPosIndex then
      self.bind.img_HeroSel = true
      self.bind.img_hero_Sel_round = true
      if self.bind.isOn_heroEmpty then
        self.bind.isOn_editHeroEmpty = true
      else
        self.bind.isOn_editHero = true
      end
    else
      self:clearHeroSel()
    end
    self:clearPetSel()
  else
    if self.parent.bAfterLongPress then
      if self.bind.isOn_petEmpty then
        self.bind.isOn_editPetEmpty = true
      else
        self.bind.is_OnEditPet = true
      end
      self.bind.img_Pet_Sel = false
    elseif self.bind and self.bind.posIndex == self.parent.SelPetPosIndex then
      self.bind.img_Pet_Sel = true
      if self.bind.isOn_petEmpty then
        self.bind.isOn_editPetEmpty = true
      else
        self.bind.is_OnEditPet = true
      end
    else
      self:clearPetSel()
    end
    self:clearHeroSel()
  end
end

function this:clearHeroSel()
  self.bind.img_HeroSel = false
  self.bind.img_hero_Sel_round = false
  self.bind.isOn_editHeroEmpty = false
  self.bind.isOn_editHero = false
end

function this:clearPetSel()
  self.bind.img_Pet_Sel = false
  self.bind.isOn_editPetEmpty = false
  self.bind.is_OnEditPet = false
end

function this:getHeroRaycastGo()
  if self.isBind then
    return self.bindComponents.hero.gameObject
  end
end

function this:getPetRaycastGo()
  if self.isBind then
    return self.bindComponents.pet.gameObject
  end
end

function this:onEvent_refreshHero(enum, varList)
  local hero = varList:GetObject(0)
  if self.isBind and self.bind.hero_guid == L_HeroStore:getHeroGuid(hero) and self.posData then
    self:refreshView(self.posData)
  end
end

function this:refreshElementIcons(heroConfigId)
  if not heroConfigId then
    return
  end
  self.bind.activeElement = true
  local heroTpl = _heroTpl:getTplById(heroConfigId)
  local mainElementId = _heroTpl:getElement(heroTpl)
  local mainElementTypeTpl = _elementTypeTpl:getTplById(mainElementId)
  local subElementId = _heroTpl:getSubElement(heroTpl)
  if subElementId ~= nil and 0 < subElementId then
    self.bind.activeSingleElement = false
    self.bind.activeDoubleElement = true
    local subElementTypeTpl = _elementTypeTpl:getTplById(subElementId)
    self.bind.imgMainElementBG = _elementTypeTpl:getElementIcon(mainElementTypeTpl, L_Const.elementIconType.single)
    self.bind.imgSubElementBG = _elementTypeTpl:getElementIcon(subElementTypeTpl, L_Const.elementIconType.single)
  else
    self.bind.activeSingleElement = true
    self.bind.activeDoubleElement = false
    self.bind.imgElementBG = _elementTypeTpl:getElementIcon(mainElementTypeTpl, L_Const.elementIconType.single)
  end
  local position = _heroTpl:getPosition(heroTpl)
  local professionTpl = _professionTpl:getTplById(position)
  self.bind.imgProfessionIcon = _professionTpl:getIcon(professionTpl)
  self.bind.txtProfession = _professionTpl:getName(professionTpl)
end

return this
