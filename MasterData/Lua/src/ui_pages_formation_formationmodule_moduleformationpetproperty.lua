local this = class("moduleFormationPetProperty", G_UIModuleBase)
local petBreakSkill = L_GameConstTpl:getData("PET_BREAKSKILLLIST", L_Const.GameTplType.int)
local petLearningEnumTpl = L_GameTpl:getPetLearingEnumTpl()
local battleInfoTpl = L_GameTpl:getBattleInfoTpl()
local petGradeTpl = L_GameTpl:getPetGradeTpl()
local _rectangleContainsScreenPoint = Unity.RectTransformUtility.RectangleContainsScreenPoint
local orignalPosition_detailContent = L_Vector3.new(803, 0, 0)
local petTpl = L_GameTpl:getPetTpl()
local PropertyModulePosY = L_DeviceTpl:getIsPc() and 295 or 295
local PropertyModuleArrowPosY = -9.8

function this.bind()
  return {
    go_content = false,
    modulePetBoxRating = {
      moduleName = "pages/pet/new/modulePetBoxRating"
    },
    txt_petFavorLv = "",
    list_attribute = {
      moduleName = "pages/pet/cellAttrItem"
    },
    list_cellSkillItem = {
      moduleName = "pages/pet/new/cellPetNewSkill"
    },
    list_cellPetGene = {
      moduleName = "pages/pet/new/cellPetNewGene"
    },
    arrowActive = true,
    txt_petName = "",
    go_battleSkillDetailBtn = false,
    go_geneSkillDetailBtn = false,
    go_detailContent = false,
    go_battleSkillDetail = false,
    go_geneSkillDetail = false,
    go_geneSkillDetailArrow = false,
    alpha_geneSkillDetail = 1,
    battleSkill = {
      moduleName = "pages/pet/new/modulePetSkillTips"
    },
    list_tipGeneList = {
      moduleName = "pages/pet/new/cellPetTipsGene"
    },
    tog_battleSkillDetail = nil,
    tog_GeneDetail = nil,
    localPosition_propertyModule = nil,
    localPosition_propertyModuleArrow = nil,
    localEulerAngles_propertyModuleArrow = nil,
    go_onCloseBg = false,
    go_moduleTagInfos = false,
    module_petSkillTagInfo = {
      moduleName = "pages/pet/new/modulePetSkillTagInfo"
    },
    modulePetBoxAttrInfo = {
      moduleName = "pages/pet/new/modulePetBoxAttrInfo"
    },
    txt_petSkillTipTitle = "",
    go_petSkillDetail = false,
    list_petSkillShowTags = {
      moduleName = "pages/petDuel/cellPetDuel_tagTipItem"
    }
  }
end

function this.methods()
  return {
    onClickClose = function(self)
      self:showModuleInfo(false)
    end,
    onPointEnter_content = function(self)
      if not self.enableDetailBtn or L_DeviceTpl:getIsMobile() or C_InputManager.IsEnableGamePad or self.isKiboDuelFormation then
        return
      end
      self.hover = true
      self:onPointerIn()
    end,
    onPointExit_content = function(self)
      if not self.enableDetailBtn or L_DeviceTpl:getIsMobile() or C_InputManager.IsEnableGamePad or self.isKiboDuelFormation then
        return
      end
      self.hover = false
      self.bind.go_content = false
      self:HideBattleSkillDetail()
      self:HideGeneSkillDetail()
      self:HidePetSkillTagInfo()
    end,
    onClick_battleSkillDetail = function(self)
      self:ShowBattleSkillDetail()
    end,
    onClick_geneSkillDetail = function(self)
      self:ShowGeneSkillDetail()
    end,
    onClick_battleSkillDetail_small = function(self)
      self:ShowBattleSkillDetail()
    end,
    onClick_geneSkillDetail_small = function(self)
      self:ShowGeneSkillDetail()
    end,
    onValueChanged_skillDetail = function(self, isOn)
      self:showSkillDetailSp(isOn)
      L_PetStore:setShowPetSkillDetail(isOn)
    end,
    onValueChanged_geneDetail = function(self, isOn)
      self:showGeneDetailSp(isOn)
      self:checkTipsHeight(false, true)
      L_PetStore:setShowPetSkillDetail(isOn)
    end
  }
end

function this:Init(data)
  self.bind.go_content = data.isShow
  self.bind.arrowActive = data.arrowActive
  self:initInfo(data.guid)
  self.hover = false
  self.enableDetailBtn = false
  self.showPetSkillTagDetail = false
  self.isShow = data.isShow
end

function this:initInfo(guid, isdue)
  local pet = L_PetStore:getPetItem(guid)
  self.pet = pet
  self:refreshTagInfos(pet, isdue)
  local property
  if not math.isEmpty(pet.hero_id) then
    property = L_PetStore:getPetProperty(pet)
  else
    property = L_PetStore:getPetOriginalProperty(pet)
  end
  if self.bindComponents.rootAnim and not isdue then
    self.bindComponents.rootAnim:Play("anim_formation_pet_detail_show")
  end
  self.bind.txt_petName = pet:getPetName()
  self.modules.modulePetBoxRating:setGuid(guid)
  if self.isKiboDuelFormation then
    self.modules.modulePetBoxAttrInfo:setGuid(guid, true)
  end
  local list = L_PetStore:getPetSkills(pet, false, false, true)
  local skillInfoList
  if isdue then
    skillInfoList = L_PetStore:getPetKiboDuelSkills(pet)
  else
    skillInfoList = list
  end
  for i, v in pairs(skillInfoList) do
    v.skillLv = string.gsub(v.skillLv, "Lv.", "")
  end
  self.bind.list_cellSkillItem:clear()
  self.bind.list_cellSkillItem:insert_array(skillInfoList)
  local tipsData = {}
  for i, v in ipairs(skillInfoList) do
    table.insert(tipsData, {kiboInfo = v})
  end
  self.tipsData = {}
  for i, v in ipairs(tipsData) do
    table.insert(self.tipsData, v)
  end
  local topRankComprehension = L_PetStore:getRangeValueComprehension(false, 8, pet.comprehension)
  local propertyData = {}
  local all_Attribute = petLearningEnumTpl:getAllEnum(true)
  for i, v in ipairs(all_Attribute) do
    local enumId = petLearningEnumTpl:getEnumNum(v)
    local id = 0
    for n, k in pairs(topRankComprehension) do
      if k.attr_id == enumId then
        id = k.rankId
        break
      end
    end
    table.insert(propertyData, {
      attrIcon = petLearningEnumTpl:getNewIcon(petLearningEnumTpl:getTplByEnumId(enumId)),
      value = battleInfoTpl:getShowTxtComma(enumId, L_PetStore:getPetAttFinalValue(property, enumId, guid)),
      name = petLearningEnumTpl:getName(petLearningEnumTpl:getTplByEnumId(enumId)),
      attrId = id
    })
  end
  self.bind.list_attribute:clear()
  self.bind.list_attribute:insert_array(propertyData)
  local genelist = L_PetStore:getPetSkills(pet, true, true, false, isdue)
  table.sort(genelist, function(a, b)
    return a.genePos < b.genePos
  end)
  for k, gene in ipairs(genelist) do
    gene.index = k
  end
  self.bind.list_cellPetGene:clear()
  self.bind.list_cellPetGene:insert_array(genelist)
  self.geneData = genelist
  self.bind.txt_petFavorLv = tostring(pet:petFavorLv())
  if self.enableDetailBtn then
    self:setDetailPanelPos()
    self:buildTipContent(isdue)
  end
  if self.bind.txt_petSkillTipTitle then
    self.bind.txt_petSkillTipTitle = L_WordsTpl:getValue("ui_kibo_info_text_3")
  end
  if self.modules.module_petSkillTagInfo then
    self.modules.module_petSkillTagInfo:setClickCallback(handler(self, self.onSwitchPetSkillTagInfo))
  end
end

function this:registerShortCut()
end

function this:unregisterShortCut()
end

function this:showModuleInfo(isShow, guid, isdue, gesture)
  if self.modules.battleSkill:checkIsToggleAnim() then
    return
  end
  self.isShow = isShow
  if self.enableDetailBtn then
    if isShow == false then
      L_TimerManager:newOrResetTimer(self, "delayHide", function()
        if self.hover then
          return
        end
        if L_DeviceTpl:getIsMobile() and gesture ~= nil then
          local pos = gesture.position
          if self:checkMobileHover(pos) then
            return
          end
        end
        self.bind.go_content = false
        self:HideBattleSkillDetail()
        self:HideGeneSkillDetail()
        self:HidePetSkillTagInfo()
      end, 0.1)
      return
    else
      L_TimerManager:stopTimer(self, "delayHide")
    end
  end
  self.bind.go_content = isShow
  if isShow then
    self:initInfo(guid, isdue)
  end
end

function this:showModuleInfoDirect(isShow)
  self.bind.go_content = isShow
  self.isShow = isShow
end

function this:isShowModuleInfo()
  return self.bind.go_content and self.isShow
end

function this:isShowModuleInfoDetail()
  return self.bind.go_geneSkillDetail or self.bind.go_battleSkillDetail
end

function this:getArrowContentRect()
  return self.bindComponents.rect_bg
end

function this:getOriginalTipPosition()
  orignalPosition_detailContent = self.bindComponents.localPosition_detailContent.localPosition
end

function this:openDetailBtn()
  self.enableDetailBtn = true
  local isPc = L_DeviceTpl:getIsPc()
  self.bind.go_battleSkillDetailBtn = isPc
  self.bind.go_geneSkillDetailBtn = isPc
  self.bind.go_detailContent = true
end

function this:open()
  self.checkHoverHandle = handler(self, self.checkHover)
  self:getOriginalTipPosition()
  self:registerShortCut()
  if self.modules and self.modules.battleSkill then
    self.modules.battleSkill:SetParentScript(self)
  end
end

function this:close()
  L_TimerManager:clearTimer(self)
  if self.checkHoverHandle then
    C_UpdateSource.RemoveUpdateEventHandler(self.checkHoverHandle)
    self.checkHoverHandle = nil
  end
end

function this:ShowBattleSkillDetail()
  if self.modules.battleSkill:checkIsToggleAnim() then
    return
  end
  self:setDetailPanelPos()
  self:HideGeneSkillDetail()
  self:HidePetSkillTagInfo()
  local show = not self.bind.go_battleSkillDetail
  self.bind.go_battleSkillDetail = show
  if show and self.modules and self.modules.battleSkill ~= nil then
    self.modules.battleSkill:refreshLayout()
    self.modules.battleSkill:resetToggleAnimState()
  end
  self.bind.tog_battleSkillDetail = L_PetStore:isShowPetSkillDetail()
  if self.bind.tog_battleSkillDetail == true then
    self:showSkillDetailSp(true)
  end
  self.bindComponents.anim_battleskill:Stop()
  if self.left and self.bind.go_battleSkillDetail then
    self.bindComponents.anim_battleskill:Play("anim_formation_pet_detail_battle_left")
  else
    self.bindComponents.anim_battleskill:Play("anim_formation_pet_detail_battle_right")
  end
end

function this:ShowGeneSkillDetail()
  if self.modules.battleSkill:checkIsToggleAnim() then
    return
  end
  self:setDetailPanelPos()
  self:HideBattleSkillDetail()
  self:HidePetSkillTagInfo()
  self.bind.go_geneSkillDetail = not self.bind.go_geneSkillDetail
  self.bind.tog_GeneDetail = L_PetStore:isShowPetSkillDetail()
  self:showGeneDetailSp(self.bind.tog_GeneDetail)
  self.bindComponents.anim_geneskill:Stop()
  if self.left and self.bind.go_geneSkillDetail then
    self.bindComponents.anim_geneskill:Play("anim_formation_pet_detail_gene_left")
  else
    self.bindComponents.anim_geneskill:Play("anim_formation_pet_detail_gene_right")
  end
end

function this:HideBattleSkillDetail()
  self.bind.go_battleSkillDetail = false
end

function this:HideGeneSkillDetail()
  self.bind.go_geneSkillDetail = false
  self.remHeight = nil
end

function this:HidePetSkillTagInfo()
  self.showPetSkillTagDetail = false
  if self.bind.go_petSkillDetail then
    self.bind.go_petSkillDetail = self.showPetSkillTagDetail
  end
end

function this:buildTipContent(isDue)
  self.modules.battleSkill:buildModuleList(self.tipsData, self.pet, true, isDue)
  self.bind.list_tipGeneList:clear()
  self.bind.list_tipGeneList:insert_array(self.geneData)
  for i, v in pairs(self.modules.list_tipGeneList) do
    v:setIsKiboArenaTip(isDue)
  end
  self:checkTipsHeight()
end

function this:checkTipsHeight(canScroll, hasActive)
  self.bind.go_geneSkillDetail = true
  L_GameUtil.forceRebuildLayout(self.bindComponents.geneSkillDetailContent)
  local currentHeight = self.bindComponents.geneSkillDetailContent.sizeDelta.y
  local maxHeight = 907.51
  local orignalY = -907.511
  if currentHeight >= maxHeight then
    self.bindComponents.gene_rectTransformMoveNode:SetParent(self.bindComponents.gene_rectTransformScrollView)
    self.bindComponents.gene_rectTransformMoveNode:SetSiblingIndex(0)
    self.bindComponents.gene_rectTransformMoveNode.anchoredPosition = C_Vector2(0, 0)
    self.bindComponents.gene_rectTransformMoveNode.sizeDelta = C_Vector2(0, 0)
    self.bindComponents.gene_rectMaskViewPort.padding = C_Vector4(-10, 70, -10, 10)
    self.bind.go_geneSkillDetailArrow = true
    self.bindComponents.geneSkillDetailContent.anchoredPosition = C_Vector2(self.bindComponents.geneSkillDetailContent.anchoredPosition.x, -self.bindComponents.geneSkillDetailContent.sizeDelta.y)
    self.bindComponents.gene_lScrollView.enabled = true
  else
    self.bindComponents.gene_rectTransformMoveNode:SetParent(self.bindComponents.gene_rectTransformIgnoreNode)
    self.bindComponents.gene_rectTransformMoveNode:SetSiblingIndex(0)
    self.bindComponents.gene_rectTransformMoveNode.anchoredPosition = C_Vector2(0, 0)
    self.bindComponents.gene_rectTransformMoveNode.sizeDelta = C_Vector2(0, 0)
    self.bindComponents.gene_rectMaskViewPort.padding = C_Vector4(-10, -10, -10, 0)
    self.bind.go_geneSkillDetailArrow = false
    self.bindComponents.geneSkillDetailContent.anchoredPosition = C_Vector2(self.bindComponents.geneSkillDetailContent.anchoredPosition.x, orignalY)
    self.bindComponents.gene_lScrollView.enabled = false
  end
  if hasActive then
    self.bind.go_geneSkillDetail = true
  else
    self.bind.go_geneSkillDetail = false
  end
  if canScroll then
    self.bindComponents.gene_lScrollView.enabled = true
  end
end

function this:showSkillDetailSp(isOn)
  self.modules.battleSkill:showDetail(isOn)
end

function this:showGeneDetailSp(isOn)
  for i, v in pairs(self.modules.list_tipGeneList) do
    v:showDetail(isOn)
  end
  Unity.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.bindComponents.geneContentRect)
  if isOn then
    self.remHeight = self.bindComponents.geneContentRect:GetComponent("VerticalLayoutGroup").preferredHeight
    self.bindComponents.geneHoverContent:SetSizeWithCurrentAnchors(1, self.remHeight)
  elseif self.remHeight then
    self.bindComponents.geneHoverContent:SetSizeWithCurrentAnchors(1, self.remHeight)
  else
    self.bindComponents.geneHoverContent:SetSizeWithCurrentAnchors(1, self.bindComponents.geneContentRect.rect.size.y)
  end
end

function this:onPointerIn()
  if L_DeviceTpl:getIsPc() then
    C_UpdateSource.AddUpdateEventHandler(self.checkHoverHandle, "moduleFormationPetProperty.update")
  end
end

function this:checkHover()
  local mainRect = self.bindComponents.moduleFormation
  local skillRect = self.bindComponents.skillHoverContent
  local geneRect = self.bindComponents.geneHoverContent
  local uiCamera = C_CameraManager.uiCamera
  local screenPos = C_Vector2(Unity.Input.mousePosition.x, Unity.Input.mousePosition.y)
  local isIn = _rectangleContainsScreenPoint(mainRect, screenPos, uiCamera)
  if self.bind.go_battleSkillDetail then
    local isInSkill = _rectangleContainsScreenPoint(skillRect, screenPos, uiCamera)
    isIn = isIn or isInSkill
  end
  if self.bind.go_geneSkillDetail then
    local isInGene = _rectangleContainsScreenPoint(geneRect, screenPos, uiCamera)
    isIn = isIn or isInGene
  end
  if not isIn then
    if not self.enableDetailBtn then
      return
    end
    if not self.isKiboDuelFormation then
      self.bind.go_content = false
      self:HideBattleSkillDetail()
      self:HideGeneSkillDetail()
      self:HidePetSkillTagInfo()
    end
    self.hover = false
    if self.checkHoverHandle then
      C_UpdateSource.RemoveUpdateEventHandler(self.checkHoverHandle)
    end
  end
end

function this:checkMobileHover(screenPos)
  local mainRect = self.bindComponents.moduleFormation
  local skillRect = self.bindComponents.skillHoverContent
  local geneRect = self.bindComponents.geneHoverContent
  local uiCamera = C_CameraManager.uiCamera
  local isIn = _rectangleContainsScreenPoint(mainRect, screenPos, uiCamera)
  if self.bind.go_battleSkillDetail then
    local isInSkill = _rectangleContainsScreenPoint(skillRect, screenPos, uiCamera)
    isIn = isIn or isInSkill
  end
  if self.bind.go_geneSkillDetail then
    local isInGene = _rectangleContainsScreenPoint(geneRect, screenPos, uiCamera)
    isIn = isIn or isInGene
  end
  return isIn
end

function this:setKiboFormationState()
  self.isKiboDuelFormation = true
  self.bind.go_onCloseBg = false
  self.modules.module_petSkillTagInfo:setKiboFormationState()
end

function this:onSwitchPetSkillTagInfo()
  if self.modules.battleSkill:checkIsToggleAnim() then
    return
  end
  self:HideBattleSkillDetail()
  self:HideGeneSkillDetail()
  self.showPetSkillTagDetail = not self.showPetSkillTagDetail and true
  self.bind.go_petSkillDetail = self.showPetSkillTagDetail
end

function this:onSwitchPetSkillDetail()
  self.modules.battleSkill:SwitchSkillTip()
end

function this:setLocalPosAndArrowInRect(targetPosX, targetPosY, parentRect, go)
  local moduleRect = self.bindComponents.rect_moduleFormationPetProperty
  local bgRect = self.bindComponents.rect_bg
  local arrowContentRect = self:getArrowContentRect()
  if moduleRect == nil or parentRect == nil or go == nil or arrowContentRect == nil or bgRect == nil then
    return
  end
  C_Canvas.ForceUpdateCanvases()
  Unity.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(bgRect)
  local panelHalfWidth = bgRect.rect.width * 0.5
  local bgHeight = bgRect.rect.height
  local bgOffset = bgRect.anchoredPosition.y
  local parentHalfWidth = parentRect.rect.width * 0.5
  local parentHalfHeight = parentRect.rect.height * 0.5
  local minX = -parentHalfWidth + panelHalfWidth
  local maxX = parentHalfWidth - panelHalfWidth
  local finalX = math.clamp(targetPosX, minX, maxX)
  local bgVisualBottom = bgOffset
  local bgVisualTop = bgOffset + bgHeight
  local gap = PropertyModulePosY + bgOffset
  local goHalfHeight = 0
  local goRect = go:GetComponent("RectTransform")
  if goRect then
    goHalfHeight = goRect.rect.height * 0.5
  end
  local upY = targetPosY + gap - bgVisualBottom + goHalfHeight
  local downY = targetPosY - gap - bgVisualTop - goHalfHeight
  local canUp = parentHalfHeight >= upY + bgVisualTop and upY + bgVisualBottom >= -parentHalfHeight
  local canDown = parentHalfHeight >= downY + bgVisualTop and downY + bgVisualBottom >= -parentHalfHeight
  local finalY, arrowPosY, arrowDir
  if canUp then
    finalY = upY
    arrowPosY = PropertyModuleArrowPosY
    arrowDir = -90
  elseif canDown then
    finalY = downY
    arrowPosY = bgHeight - PropertyModuleArrowPosY
    arrowDir = 90
  else
    finalY = math.clamp(upY, -parentHalfHeight - bgVisualBottom, parentHalfHeight - bgVisualTop)
    if targetPosY <= finalY then
      arrowPosY = PropertyModuleArrowPosY
      arrowDir = -90
    else
      arrowPosY = bgHeight - PropertyModuleArrowPosY
      arrowDir = 90
    end
  end
  self.bind.localPosition_propertyModule = L_Vector3.new(finalX, finalY, 0)
  local targetPosArrowX = arrowContentRect.transform:InverseTransformPoint(go.transform.position).x
  local arrowMargin = 10
  local minArrowX = -panelHalfWidth + arrowMargin
  local maxArrowX = panelHalfWidth - arrowMargin
  targetPosArrowX = math.clamp(targetPosArrowX, minArrowX, maxArrowX)
  self.bind.localPosition_propertyModuleArrow = L_Vector3.new(targetPosArrowX, arrowPosY, 0)
  self.bind.localEulerAngles_propertyModuleArrow = L_Vector3.new(0, 0, arrowDir)
end

function this:setLocalPosAndArrow(targetPosX, halfScreenWidth, go)
  local halfWidth = self.bindComponents.rect_moduleFormationPetProperty.sizeDelta.x * 0.9 * 0.5
  if halfScreenWidth < targetPosX + halfWidth then
    targetPosX = halfScreenWidth - halfWidth
  elseif halfScreenWidth < halfWidth - targetPosX then
    targetPosX = halfWidth - halfScreenWidth
  end
  self.bind.localPosition_propertyModule = L_Vector3.new(targetPosX, PropertyModulePosY, 0)
  local targetPosArrowX = self:getArrowContentRect().transform:InverseTransformPoint(go.transform.position).x
  self.bind.localPosition_propertyModuleArrow = L_Vector3.new(targetPosArrowX, PropertyModuleArrowPosY, 0)
end

function this:setDetailPanelPos()
  local moduleFormationPosX = self.bindComponents.moduleFormation.localPosition.x
  if moduleFormationPosX < 0 then
    self.bindComponents.localPosition_detailContent.localPosition = L_Vector3.new(orignalPosition_detailContent.x, 0, 0)
    self.left = true
  else
    self.bindComponents.localPosition_detailContent.localPosition = L_Vector3.new(-orignalPosition_detailContent.x, 0, 0)
    self.left = false
  end
end

function this:playToggleAnim()
  if self.bindComponents and self.bindComponents.toggleAnimation and not self.isKiboDuelFormation then
    self.bindComponents.toggleAnimation:PlayMapChangeAnimation()
  end
end

function this:playToggleAnimation()
  self:playToggleAnim()
end

function this:refreshTagInfos(pet, isdue)
  if isdue then
    local petId = pet.id
    local tpl = petTpl:getTplById(petId)
    local tags = petTpl:getKiboDuelTag(tpl)
    local data = {}
    for _, id in ipairs(tags) do
      table.insert(data, {tagId = id})
    end
    self.bind.go_moduleTagInfos = true
    self.modules.module_petSkillTagInfo:setSwitchShowCallback(nil)
    self.modules.module_petSkillTagInfo:refreshTagList(pet)
    if self.bind.list_petSkillShowTags ~= nil then
      self.bind.list_petSkillShowTags:clear()
      self.bind.list_petSkillShowTags:insert_array(data)
    end
  else
    self.bind.go_moduleTagInfos = false
  end
end

return this
