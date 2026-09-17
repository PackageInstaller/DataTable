local this = class("cellTeamUnitHud", G_UIModuleBase)
local _heroTpl = L_GameTpl:getHeroTpl()
local _petInfoTpl = L_GameTpl:getPetTpl()
local _elementTpl = L_GameTpl:getElementTypeTpl()
local _professionTpl = L_GameTpl:getProfessionTpl()
local _elementTypeTpl = L_GameTpl:getElementTypeTpl()

function this.bind()
  return {
    go_active = false,
    txt_name = "",
    txt_lv = "",
    goPet = false,
    isOn_ChangePos = false,
    go_btn_single = false,
    go_btn_double = false,
    go_btn_single_revert = false,
    go_btn_double_revert = false,
    alpha = 1,
    revert_alpha = 1,
    hud_BtnAlpha = 1,
    hud_NameAlpha = 1,
    activeElement = false,
    activeSingleElement = false,
    activeDoubleElement = false,
    activeProfess = false,
    imgElementBG = "",
    imgMainElementBG = "",
    imgSubElementBG = "",
    imgProfessionIcon = "",
    txtProfession = ""
  }
end

function this.methods()
  return {
    onClick_viewDetail = function(self)
      if self.bind.setTopTabHide then
        self.bind.setTopTabHide(false)
      end
      if self.bind.go_active then
        if self.bind.roleType == L_Const.roleType.hero then
          L_UI:open("pageHero", {
            heroId = self.bind.roleId,
            pageType = L_Const.heroPageType.DetailMode,
            clearStackOnGoToNextStack = false,
            failure_jump = self:GetSourceLuaPageOptions("failure_jump")
          })
        elseif self.bind.roleType == L_Const.roleType.pet then
          L_UI:open("pagePet", {
            petId = self.bind.roleId,
            failure_jump = self:GetSourceLuaPageOptions("failure_jump")
          })
        end
      end
    end,
    onClick_viewDetail_single = function(self)
      if self.bind.setTopTabHide then
        self.bind.setTopTabHide(false)
      end
      if self.bind.go_active then
        if self.bind.roleType == L_Const.roleType.hero then
          L_UI:open("pageHero", {
            heroId = self.bind.roleId,
            pageType = L_Const.heroPageType.DetailMode,
            clearStackOnGoToNextStack = false,
            failure_jump = self:GetSourceLuaPageOptions("failure_jump")
          })
        elseif self.bind.roleType == L_Const.roleType.pet then
          L_UI:open("pagePet", {
            petId = self.bind.roleId,
            failure_jump = self:GetSourceLuaPageOptions("failure_jump")
          })
        end
      end
    end,
    onClick_viewDetail_single_revert = function(self)
      if self.bind.setTopTabHide then
        self.bind.setTopTabHide(false)
      end
      if self.bind.go_active then
        if self.bind.roleType == L_Const.roleType.hero then
          L_UI:open("pageHero", {
            heroId = self.bind.roleId,
            pageType = L_Const.heroPageType.DetailMode,
            clearStackOnGoToNextStack = false,
            failure_jump = self:GetSourceLuaPageOptions("failure_jump")
          })
        elseif self.bind.roleType == L_Const.roleType.pet then
          L_UI:open("pagePet", {
            petId = self.bind.roleId,
            failure_jump = self:GetSourceLuaPageOptions("failure_jump")
          })
        end
      end
    end,
    onClick_viewDetail_revert = function(self)
      if self.bind.setTopTabHide then
        self.bind.setTopTabHide(false)
      end
      if self.bind.go_active then
        if self.bind.roleType == L_Const.roleType.hero then
          L_UI:open("pageHero", {
            heroId = self.bind.roleId,
            pageType = L_Const.heroPageType.DetailMode,
            clearStackOnGoToNextStack = false,
            failure_jump = self:GetSourceLuaPageOptions("failure_jump")
          })
        elseif self.bind.roleType == L_Const.roleType.pet then
          L_UI:open("pagePet", {
            petId = self.bind.roleId,
            failure_jump = self:GetSourceLuaPageOptions("failure_jump")
          })
        end
      end
    end,
    onClick_Down = function(self)
      if self.parent and (self.bind.roleType ~= L_Const.roleType.hero or self:checkCanChangeFormationHero(self.bind.index)) then
        self.bindComponents.anim_hud:Stop()
        self.bindComponents.anim_hud:Play("anim_formation_hud_name_hide")
        L_TimerManager:newOrResetTimer(self, "Down_Remove", function()
          if self.parent.removeHero and self.bind.roleType == L_Const.roleType.hero then
            self.parent:removeHero(self.bind.index)
          elseif self.parent.removePet and self.bind.roleType == L_Const.roleType.pet then
            self.parent:removePet(self.bind.index)
          end
        end, 0.15)
      end
    end,
    onClick_Down_revert = function(self)
      if self.parent and (self.bind.roleType == L_Const.roleType.pet or self:checkCanChangeFormationHero(self.bind.index)) then
        self.bindComponents.anim_hud:Stop()
        self.bindComponents.anim_hud:Play("anim_formation_hud_name_hide")
        L_TimerManager:newOrResetTimer(self, "Down_Remove", function()
          if self.parent.removeHero and self.bind.roleType == L_Const.roleType.hero then
            self.parent:removeHero(self.bind.index)
          elseif self.parent.removePet and self.bind.roleType == L_Const.roleType.pet then
            self.parent:removePet(self.bind.index)
          end
        end, 0.15)
      end
    end,
    onClick_professionIcon = function(self)
      local hero = L_HeroStore:getHero(self.bind.roleId)
      L_UI:open("pageElementalRestraint", {
        heroTplId = L_HeroStore:getHeroConfigId(hero),
        initTab = 1,
        failure_jump = self:GetSourceLuaPageOptions("failure_jump")
      })
    end
  }
end

function this:getIndex()
  return self.bind.index
end

function this:open()
  self:initCell()
end

function this:close()
  L_TimerManager:clearTimer(self)
end

function this:initCell()
  if not self.isBind then
    return
  end
  self.bind.isOn_ChangePos = self.bind.changePosMode == true
  self.bind.go_active = not math.isEmpty(self.bind.roleId)
  if self.bind.go_active then
    if self.bind.roleType == L_Const.roleType.hero then
      self:setHeroData()
    elseif self.bind.roleType == L_Const.roleType.pet then
      self:setPetData()
    end
  end
  self.showBtn = self.parent.pageName == "pageFormationMain" or self.parent.pageName == "pageWearPet"
  if self.bind.hud_BtnAlpha ~= 1 or self.bind.hud_NameAlpha ~= 1 then
    self.bind.hud_BtnAlpha = 1
    self.bind.hud_NameAlpha = 1
  end
end

function this:setHeroData()
  local serverData = L_HeroStore:getHero(self.bind.roleId)
  self._configId = L_HeroStore:getHeroConfigId(serverData)
  self.bind.txt_name = L_HeroManager:getHeroName(self.bind.roleId)
  self.bind.txt_lv = tostring(L_HeroStore:getHeroLevel(serverData))
  self.bind.goPet = false
  self.bind.activeElement = true
  self.bind.activeProfess = true
  local heroTpl = _heroTpl:getTplById(self._configId)
  local mainElementId = _heroTpl:getElement(heroTpl)
  local subElementId = _heroTpl:getSubElement(heroTpl)
  self:refreshElementIcons(mainElementId, subElementId)
  local position = _heroTpl:getPosition(heroTpl)
  local professionTpl = _professionTpl:getTplById(position)
  self.bind.imgProfessionIcon = _professionTpl:getIcon(professionTpl)
  self.bind.txtProfession = _professionTpl:getName(professionTpl)
end

function this:refreshElementIcons(mainElementId, subElementId)
  local mainElementTypeTpl = _elementTypeTpl:getTplById(mainElementId)
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
end

function this:setPetData()
  local serverData = L_PetStore:getPetItem(self.bind.roleId)
  self._configId = serverData.id
  self.bind.txt_name = serverData.pet_name
  self.bind.txt_lv = tostring(serverData.lv)
  self.bind.activeElement = true
  self.bind.goPet = true
  self.bind.activeProfess = false
  local infoTpl = _petInfoTpl:getTplById(serverData.id)
  local element = _petInfoTpl:getElement(infoTpl)
  local mainElementId = element and element[1]
  local subElementId = element and element[2]
  self:refreshElementIcons(mainElementId, subElementId)
end

function this:getRoleType()
  return self.bind.roleType
end

function this:getGuid()
  return self.bind.roleId
end

function this:getUnitId()
  return L_GameUtil.getUnitIdByRole(self._configId, self.bind.roleType)
end

function this:getSelfRect()
  return self.bindComponents.hud
end

function this:getBtnGroup(revert)
  if revert then
    return self.bindComponents.btnGroupRevert
  end
  return self.bindComponents.btnGroup
end

function this:setRevertBtn(revert)
  self.isBtnRevert = revert
  self.bindComponents.btnGroup.gameObject:SetActive(not revert and self.showBtn)
  self.bindComponents.btnGroupRevert.gameObject:SetActive(revert and self.showBtn)
end

function this:isEnable()
  return self.bind.go_active
end

function this:setActive(active)
  self.bind.go_active = active
end

function this:checkCanChangeFormationHero(index)
  local formationType = L_FormationManager:getRuntimeFormationType()
  local formationIndex = L_FormationManager:getRuntimeFormationIndex()
  local posData = L_FormationStore:getFormationPosData(formationType, formationIndex)
  local temp = table.clone(posData)
  temp[index] = 0
  if not L_FormationManager:checkCanChangeFormation() then
    return false
  end
  if formationType == L_FormationManager:getCurFormationType() and formationIndex == L_FormationStore:getUsingTeamIndex(formationType) and not L_FormationManager:checkCanChangeFormationHero(temp) then
    return false
  end
  return true
end

function this:playTeamHud()
  self.bindComponents.anim_hudBtn:Play("anim_formation_hud_name_show")
  self.bindComponents.anim_hud:Play("anim_formation_hud_name_show")
end

function this:setFollow()
  L_FormationManager:setFormationHudScreenPos(self)
end

function this:getAlpha()
  return self.bind.alpha == 0 or self.bind.revert_alpha == 0
end

function this:setAlpha(alpha)
  self.bind.alpha = alpha
  self.bind.revert_alpha = alpha
end

function this:hideEditUI()
  self.bind.go_btn_double_revert = false
  self.bind.go_btn_single_revert = false
  self.bind.go_btn_single = false
  self.bind.go_btn_double = false
end

function this:setUIState(bRevert, bDouble)
  self.bind.go_btn_double_revert = bRevert and bDouble
  self.bind.go_btn_single_revert = bRevert and not bDouble
  self.bind.go_btn_single = not bRevert and not bDouble
  self.bind.go_btn_double = not bRevert and bDouble
end

function this:checkDownBtn(state)
  if not self.showBtn then
    return
  end
  if self.bind.bEdit ~= nil and self.bind.bEdit == false then
    return
  end
  local isHeroEditState = state == L_FormationConst.FormationEditStatus.EditHero
  local isPetEditState = state == L_FormationConst.FormationEditStatus.EditPet
  if self.bind.roleType == L_Const.roleType.hero then
    if self.isBtnRevert then
      self.bind.go_btn_double_revert = isHeroEditState
      self.bind.go_btn_single_revert = not isHeroEditState
      self.bind.go_btn_single = false
      self.bind.go_btn_double = false
    else
      self.bind.go_btn_double_revert = false
      self.bind.go_btn_single_revert = false
      self.bind.go_btn_single = not isHeroEditState
      self.bind.go_btn_double = isHeroEditState
    end
  elseif self.bind.roleType == L_Const.roleType.pet then
    if self.isBtnRevert then
      self.bind.go_btn_double_revert = isPetEditState
      self.bind.go_btn_single_revert = not isPetEditState
      self.bind.go_btn_single = false
      self.bind.go_btn_double = false
    else
      self.bind.go_btn_double_revert = false
      self.bind.go_btn_single_revert = false
      self.bind.go_btn_single = not isPetEditState
      self.bind.go_btn_double = isPetEditState
    end
  elseif self.isBtnRevert then
    self.bind.go_btn_double_revert = true
    self.bind.go_btn_single_revert = false
    self.bind.go_btn_single = false
    self.bind.go_btn_double = false
  else
    self.bind.go_btn_double_revert = false
    self.bind.go_btn_single_revert = false
    self.bind.go_btn_single = false
    self.bind.go_btn_double = true
  end
end

function this:checkPetCanFeed(petGuid)
  local serverData = L_PetStore:getPetItem(petGuid)
  return not serverData:getPetAbilityLimited()
end

return this
