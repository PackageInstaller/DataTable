local this = class("pageQuickFormation", G_UIPageBase)
local PageCount = 30
local MaxFrame = 8
local IconPath = "UI/Icon/PetPixelIcon/tex_icon_pet_%s_%d.png"
local _heroTpl = L_GameTpl:getHeroTpl()
local _petTpl = L_GameTpl:getPetTpl()

function this.bind()
  return {
    list_editPos = {
      moduleName = "pages/formation/formationModule/cellQuickFormationEditPos"
    },
    isOn_targetHero = false,
    list_hero = L_Const.ModuleInfo.CellIconUnit,
    txt_boxName = nil,
    txt_boxIndex = nil,
    list_pet = {
      moduleName = "pages/formation/formationModule/cellPixelPetFormation"
    },
    go_changePageTab = false,
    go_lastBtn = false,
    go_nextBtn = false,
    module_pageTabSlider = {
      moduleName = "modulePages/modulePageTabSlider"
    },
    module_sortFilter = L_Const.ModuleInfo.SortFilterModule,
    activeHeroDrag = false,
    activePetDrag = false,
    img_drag_hero = "",
    img_drag_pet = ""
  }
end

function this.methods()
  return {
    onClick_lastPage = function(self)
      self:changePageIndex(-1)
    end,
    onClick_nextPage = function(self)
      self:changePageIndex(1)
    end,
    onClick_detail = function(self)
      if self._editTarget == L_FormationConst.FormationEditTarget.Hero then
        if math.isEmpty(self._selectPosData[self.SelHeroPosIndex].hero_guid) then
          L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("residual_code_pagequickformation_01"))
          return
        end
        local failureJump
        if self.options then
          failureJump = self.options.failure_jump
        end
        L_UI:open("pageHero", {
          heroId = self._selectPosData[self.SelHeroPosIndex].hero_guid,
          pageType = L_Const.heroPageType.DetailMode,
          clearStackOnGoToNextStack = false,
          failure_jump = failureJump
        })
      else
        if math.isEmpty(self._selectPosData[self.SelPetPosIndex].pet_guid) then
          L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("residual_code_pagequickformation_01"))
          return
        end
        local failureJump
        if self.options then
          failureJump = self.options.failure_jump
        end
        L_UI:open("pagePet", {
          petId = self._selectPosData[self.SelPetPosIndex].pet_guid,
          failure_jump = failureJump
        })
      end
    end,
    onClick_confirm = function(self)
      local isEmpty = true
      for i, pos in ipairs(self._selectPosData) do
        if not math.isEmpty(pos.hero_guid) then
          isEmpty = false
          break
        end
      end
      if isEmpty then
        L_FormationManager:showFormationTip(L_FormationConst.FormationTipType.TeamEmpty)
        return
      end
      
      local function _func()
        local function reqQuickChangeGroup()
          L_FormationManager:req_quickChangeGroup(self._formationType, self._teamIndex, self._selectPosData, function()
            if self._vfxCb then
              self._vfxCb(self._selectPosData)
            end
            L_UI:close(self.pageName)
          end)
        end
        
        local usingIndex = L_FormationStore:getUsingTeamIndex(self._formationType)
        if usingIndex == self._teamIndex then
          L_FormationManager:checkPetRuleEnableFormation(self._selectPosData, function()
            reqQuickChangeGroup()
          end)
        else
          reqQuickChangeGroup()
        end
      end
      
      local changedHeroList = self:getChangedPet()
      if L_SettingStore:getSetData(L_Const.settingType.formationPetConfirm) == "true" and 0 < #changedHeroList then
        local heroStr = ""
        for idx, guid in ipairs(changedHeroList) do
          local heroData = _heroTpl:getTplById(L_HeroStore:getHeroConfigId(L_HeroStore:getHero(guid)))
          local heroName = _heroTpl:getName(heroData)
          if idx ~= 1 then
            heroStr = heroStr .. "、"
          end
          heroStr = heroStr .. heroName
        end
        L_GameUtil.showCommonTip({
          txtContent = L_Lang:get(L_WordsTpl:getValue("notice_formation_change_pet"), {
            [0] = heroStr
          }),
          confirmCallback = _func
        })
      else
        _func()
      end
    end,
    onClick_autoFormation = function(self)
      C_AudioManager.Play("Play_SFX_System_UI_Team_AutoDeploy")
      self:autoQuickFormation()
    end,
    list_editPos = {
      onClick_selectHero = function(self, bind)
        self._editTarget = L_FormationConst.FormationEditTarget.Hero
        self._moveToId = bind.hero_guid
        self.SelHeroPosIndex = bind.posIndex
        self:onSelectHero()
      end,
      onClick_selectPet = function(self, bind)
        self._editTarget = L_FormationConst.FormationEditTarget.Pet
        self._moveToId = bind.pet_guid
        self.SelHeroPosIndex = bind.posIndex
        self.SelPetPosIndex = bind.posIndex
        self:initEditTarget()
      end
    }
  }
end

function this:preOpen(options)
  this.super.preOpen(self, options)
  self._formationType = options and options.formationType or L_FormationConst.FormationType.world
  self._teamIndex = options and options.teamIndex or L_FormationStore:getUsingTeamIndex(self._formationType)
  self.SelHeroPosIndex = 1
  self.SelPetPosIndex = -1
  if options and options.vfxCb then
    self._vfxCb = options.vfxCb
  end
  self._selectPosData = {}
  self._initPosData = {}
  printf("QuickFormation", "initPosData")
  local posData = L_FormationStore:getFormationPosData(self._formationType, self._teamIndex)
  for i, guid in ipairs(posData) do
    self._selectPosData[i] = {
      hero_guid = guid,
      pet_guid = L_FormationStore:getFormationPosPetGuid(self._formationType, self._teamIndex, i)
    }
    self._initPosData[i] = {
      hero_guid = guid,
      pet_guid = self._selectPosData[i].pet_guid
    }
  end
  self._editTarget = L_FormationConst.FormationEditTarget.Hero
  for i, pos in ipairs(self._selectPosData) do
    if not math.isEmpty(pos.hero_guid) then
      self._moveToId = pos.hero_guid
      break
    end
  end
  if options and options.heroGuid then
    local index = self:GetHeroIndex(options.heroGuid)
    if 0 < index then
      self.SelHeroPosIndex = index
    end
  end
  self._selectHeroHandler = handler(self, self.selectHero)
  self._selectPetHandler = handler(self, self.selectPet)
  self:initSortFilterModule()
  self:refreshEditPosList(true)
  self:initCommonTopModule()
  self:initEditTarget()
  self:configTouch("+")
  self:ChangeUIStateInMultiTeam(true)
end

function this:configTouch(operator)
  self.onUILongTapStartHandle = self.onUILongTapStartHandle or L_CommonUtil.handle(self.onUI_longTapStartHandle, self)
  self.onUILongTapEndHandle = self.onUILongTapEndHandle or L_CommonUtil.handle(self.onUI_longTapEndHandle, self)
  self.onUIDragStartHandle = self.onUIDragStartHandle or L_CommonUtil.handle(self.onUI_dragStartHandle, self)
  self.onUIDragHandle = self.onUIDragHandle or L_CommonUtil.handle(self.onUI_dragHandle, self)
  self.onUIDragEndHandle = self.onUIDragEndHandle or L_CommonUtil.handle(self.onUI_dragEndHandle, self)
  C_ScreenTouch.OnUI_LongTapStart(operator, self.onUILongTapStartHandle)
  C_ScreenTouch.OnUI_LongTapEnd(operator, self.onUILongTapEndHandle)
  C_ScreenTouch.OnUI_DragStart(operator, self.onUIDragStartHandle)
  C_ScreenTouch.OnUI_Drag(operator, self.onUIDragHandle)
  C_ScreenTouch.OnUI_DragEnd(operator, self.onUIDragEndHandle)
end

function this:onUI_longTapStartHandle(gesture)
  self.dragitem = nil
  local go = gesture:GetCurrentFirstPickedUIElement()
  if self._editTarget == L_FormationConst.FormationEditTarget.Hero then
    self.dragitem = self:getHeroHoldInfo(go) or self:getTopEditHeroHoldInfo(go)
  else
    self.dragitem = self:getPetHoldInfo(go) or self:getTopEditPetHoldInfo(go)
  end
  if table.isEmpty(self.dragitem) then
    return
  end
  L_FlyMsgManager:startLongPress(gesture, 0.5, function()
    if self._editTarget == L_FormationConst.FormationEditTarget.Hero then
      local heroData = L_HeroStore:getHero(self.dragitem.bind.guid)
      if heroData then
        print("========================长按转圈结束 角色")
        local heroConf = L_ItemTplManager:getHeroItem(L_HeroStore:getHeroConfigId(heroData))
        self.bind.activeHeroDrag = true
        if self.dragitem.bind.guid == L_HeroStore:getDefaultHeroGuid() then
          L_PhotoManager:fillMainHead(self, self.bindComponents.Img_drag_hero, nil, L_Const.avatarTextureIndex.head)
        else
          local heroConfigId = L_HeroStore:getHeroConfigId(heroData)
          local clothingId = AzurWorld.heroMgr:GetUsingClothingId(self.dragitem.bind.guid, heroConfigId)
          local heroClothingTpl = L_GameTpl:getHeroClothingTpl()
          self.bind.img_drag_hero = heroClothingTpl:getAvatarTexture(heroClothingTpl:getTplById(clothingId), L_Const.resourceIndexOfAvatarTextureInHeroTpl.mid) or ""
        end
        local touchPos = L_Vector3.screenToLocalInRectangle(self.bindComponents.rect_board, gesture.position)
        L_Vector3.setAnchored(self.bindComponents.rect_dragHeroRoot, touchPos)
        self.bAfterLongPress = true
        self:refreshEditPosList()
      end
    else
      local petData = L_PetStore:getPetItem(self.dragitem.bind.guid)
      if petData then
        print("========================长按转圈结束 宠物")
        local tpl = _petTpl:getTplById(petData.id)
        self.bind.activePetDrag = true
        self.bind.img_drag_pet = _petTpl:getPetPixelIcon(tpl, petData:isSpecialPet())
        local touchPos = L_Vector3.screenToLocalInRectangle(self.bindComponents.rect_board, gesture.position)
        L_Vector3.setAnchored(self.bindComponents.Img_drag_pet, touchPos)
        self.bAfterLongPress = true
        self:refreshEditPosList()
      end
    end
    if self.dragitem then
      self.dragitem.bind.canvas_root = 0.5
    end
  end)
end

function this:onUI_longTapEndHandle()
  self:hideDragInfo()
end

function this:onUI_dragStartHandle(gesture)
  self.fingerId = gesture.fingerId
  if L_UI:currentPage(L_UI.groupKeys.stack) ~= self.pageName then
    return
  end
  if L_FormationManager:getEditStatus() ~= L_FormationConst.FormationEditStatus.Overlook then
    return
  end
end

function this:onUI_dragHandle(gesture)
  if not L_CommonUtil.isValid(gesture.go) then
    return
  end
  if self.bAfterLongPress == false then
    return
  end
  if self._editTarget == L_FormationConst.FormationEditTarget.Hero then
    print("========================拖拽结束 角色")
    local touchPos = L_Vector3.screenToLocalInRectangle(self.bindComponents.rect_board, gesture.position)
    L_Vector3.setAnchored(self.bindComponents.rect_dragHeroRoot, touchPos)
  else
    print("========================拖拽结束 宠物")
    local touchPos = L_Vector3.screenToLocalInRectangle(self.bindComponents.rect_board, gesture.position)
    L_Vector3.setAnchored(self.bindComponents.Img_drag_pet, touchPos)
  end
end

function this:onUI_dragEndHandle(gesture)
  if L_UI:currentPage(L_UI.groupKeys.stack) ~= self.pageName then
    return
  end
  if self.bAfterLongPress == false then
    return
  end
  local go = gesture:GetCurrentFirstPickedUIElement()
  if self._editTarget == L_FormationConst.FormationEditTarget.Hero then
    local item = self:getTopEditHeroHoldInfo(go)
    if not table.isEmpty(item) then
      self.SelHeroPosIndex = item.bind.posIndex
      self:selectHero(self.dragitem)
    end
  else
    local item = self:getTopEditPetHoldInfo(go)
    if not table.isEmpty(item) then
      self.SelPetPosIndex = item.bind.posIndex
      self:selectPet(self.dragitem)
    end
  end
  self:hideDragInfo()
end

function this:hideDragInfo()
  self.bind.activeHeroDrag = false
  self.bind.activePetDrag = false
  self.bind.img_drag_hero = ""
  self.bind.img_drag_pet = ""
  if self.dragitem then
    self.dragitem.bind.canvas_root = 1
    self.dragitem = nil
  end
  self.bAfterLongPress = false
  self:refreshEditPosList()
end

function this:getHeroHoldInfo(go)
  for i, item in ipairs(self.modules.list_hero) do
    if item:getRaycastGo() == go then
      return item
    end
  end
  return nil
end

function this:getPetHoldInfo(go)
  for i, item in ipairs(self.modules.list_pet) do
    if item:getRaycastGo() == go then
      return item
    end
  end
  return nil
end

function this:getTopEditHeroHoldInfo(go)
  for i, item in ipairs(self.modules.list_editPos) do
    if item:getHeroRaycastGo() == go then
      local res = {}
      res.bind = {}
      res.bind.posIndex = item.bind.posIndex
      res.bind.guid = item.bind.hero_guid
      return res
    end
  end
  return nil
end

function this:getTopEditPetHoldInfo(go)
  for i, item in ipairs(self.modules.list_editPos) do
    if item:getPetRaycastGo() == go then
      local res = {}
      res.bind = {}
      res.bind.posIndex = item.bind.posIndex
      res.bind.guid = item.bind.pet_guid
      return res
    end
  end
  return nil
end

function this:close(options)
  self:ChangeUIStateInMultiTeam(false)
  self:configTouch("-")
  this.super.close(self, options)
end

function this:initCommonTopModule()
end

function this:initSortFilterModule()
  self._heroSortFilter = L_SortFilterManager:createSortFilter(L_SystemConst.enum.formationQuickHero, function()
    self._heroPageIndex = 1
    self:refreshEditTargetContent()
  end, function()
    self._heroPageIndex = 1
    self:refreshEditTargetContent()
  end)
  self._petSortFilter = L_SortFilterManager:createSortFilter(L_SystemConst.enum.formationQuickPet, function()
    self._petPageIndex = 1
    self:refreshEditTargetContent()
  end, function()
    self._petPageIndex = 1
    self:refreshEditTargetContent()
  end)
end

function this:initEditTarget()
  local isHero = self._editTarget == L_FormationConst.FormationEditTarget.Hero
  self.bind.isOn_targetHero = isHero
  if isHero then
    self._heroSortFilter:bindModule(self.modules.module_sortFilter)
  else
    self._petSortFilter:bindModule(self.modules.module_sortFilter)
  end
  self:refreshEditPosListTarget()
  self:refreshEditTargetContent()
end

function this:onSelectHero()
  local isHero = self._editTarget == L_FormationConst.FormationEditTarget.Hero
  self.bind.isOn_targetHero = isHero
  if isHero then
    self._heroSortFilter:bindModule(self.modules.module_sortFilter)
  else
    self._petSortFilter:bindModule(self.modules.module_sortFilter)
  end
  self:refreshEditPosListTarget()
  self:setHeroListSelect()
end

function this:refreshEditTargetContent()
  local isHero = self._editTarget == L_FormationConst.FormationEditTarget.Hero
  if isHero then
    self:initHeroList()
    self:refreshCurPageHero()
  else
    self:initPetList()
    self:refreshCurPagePet()
  end
  self:refreshPageTabInfo(true)
end

function this:refreshEditPosList(isInit)
  if isInit then
    local temp = {}
    for i, v in ipairs(self._selectPosData) do
      table.insert(temp, {
        hero_guid = v.hero_guid,
        pet_guid = v.pet_guid,
        posIndex = i
      })
    end
    self.bind.list_editPos:clear()
    self.bind.list_editPos:insert_array(temp)
  else
    for i, v in ipairs(self.modules.list_editPos) do
      local cell = v
      cell:refreshView(self._selectPosData[i])
    end
  end
end

function this:refreshEditPosListTarget()
  for i, v in pairs(self.modules.list_editPos) do
    local cell = v
    cell:setEditTarget(self._editTarget)
  end
end

function this:initHeroList()
  local allHero = L_HeroStore:getAllHero()
  self._heroTotalDataList = {}
  for i, v in pairs(allHero) do
    local hero_id = L_HeroStore:getHeroGuid(v)
    local data = {
      itemType = L_Const.resType.hero,
      itemId = L_HeroStore:getHeroConfigId(v),
      guid = hero_id
    }
    table.insert(self._heroTotalDataList, data)
  end
  self._heroSortFilter:sortFilterList(self._heroTotalDataList)
end

function this:initPetList()
  self._isPetBoxMode = self._petSortFilter.filterKeyDic[L_SortFilterConst.FilterType.QiBoBoxMode] == nil
  if not self._isPetBoxMode then
    local allPet = L_PetStore:getPetList()
    self._petTotalDataList = {}
    for i, v in pairs(allPet) do
      table.insert(self._petTotalDataList, {
        itemType = L_Const.resType.pet,
        itemId = v.id,
        guid = v.guid
      })
    end
    self._petSortFilter:sortFilterList(self._petTotalDataList)
  end
end

function this:changePageIndex(delta)
  if self._editTarget == L_FormationConst.FormationEditTarget.Hero then
    self._heroPageIndex = math.clamp(self._heroPageIndex + delta, 1, self._heroTotalPageNum)
    self:refreshCurPageHero()
  else
    if self._isPetBoxMode then
      self._petBoxIndex = math.clamp(self._petBoxIndex + delta, 1, L_PetStore:getPetBoxNum())
    else
      self._petPageIndex = math.clamp(self._petPageIndex + delta, 1, self._petTotalPageNum)
    end
    self:refreshCurPagePet()
  end
  self:refreshPageTabInfo()
end

function this:refreshCurPageHero()
  self:moveToPage()
  self._heroPageIndex = self._heroPageIndex or 1
  local temp = {}
  for i = (self._heroPageIndex - 1) * PageCount + 1, self._heroPageIndex * PageCount do
    if not self._heroTotalDataList[i] then
      break
    end
    local hero_id = self._heroTotalDataList[i].guid
    local hp = L_FormationStore:getFormationHeroHp(hero_id)
    table.insert(temp, {
      itemType = L_Const.resType.hero,
      itemId = self._heroTotalDataList[i].itemId,
      guid = hero_id,
      callback = self._selectHeroHandler,
      die = hp <= 0,
      type = L_Const.cellIconUnitType.quickTeamUp,
      index = i
    })
  end
  self.bind.list_hero:clear()
  self.bind.list_hero:insert_array(temp)
  self:setHeroListSelect()
end

function this:refreshCurPagePet()
  self:moveToPage()
  local curPageData = {}
  if self._isPetBoxMode then
    self._petBoxIndex = self._petBoxIndex or 1
    local boxData = L_PetStore:getPetBoxList(self._petBoxIndex)
    local temp = {}
    for i, guid in pairs(boxData) do
      if not math.isEmpty(guid) then
        local petData = L_PetStore:getPetItem(guid)
        table.insert(temp, {
          itemType = L_Const.resType.pet,
          itemId = petData.id,
          guid = guid,
          type = L_Const.cellIconUnitType.quickTeamUp,
          callback = self._selectPetHandler
        })
      end
    end
    self._petSortFilter:filterList(temp)
    for i = 1, PageCount do
      table.insert(curPageData, {
        itemType = 0,
        itemId = 0,
        guid = 0,
        callback = nil,
        type = L_Const.cellIconUnitType.quickTeamUp
      })
    end
    for i, cell in pairs(temp) do
      local pet = L_PetStore:getPetItem(cell.guid)
      curPageData[pet.box_id % 100] = cell
    end
  else
    self._petPageIndex = self._petPageIndex or 1
    for i = (self._petPageIndex - 1) * PageCount + 1, self._petPageIndex * PageCount do
      if not self._petTotalDataList[i] then
        break
      end
      table.insert(curPageData, {
        guid = self._petTotalDataList[i].guid,
        type = L_Const.cellIconUnitType.quickTeamUp,
        callback = self._selectPetHandler
      })
    end
  end
  self.bind.txt_boxName = self._isPetBoxMode and L_PetStore:getPetBoxName(self._petBoxIndex) or L_WordsTpl:getValue("ui_moduleSelectPet")
  self.bind.txt_boxIndex = self._isPetBoxMode and string.format("%02d", self._petBoxIndex) or ""
  self.bind.list_pet:clear()
  self.bind.list_pet:insert_array(curPageData)
  self:setPetListSelect()
end

function this:setHeroListSelect()
  for i, v in pairs(self.modules.list_hero) do
    local cell = v
    local node, index = table.ipairsFind(self._selectPosData, function(a)
      return a.hero_guid == cell.bind.guid and not math.isEmpty(cell.bind.guid)
    end)
    cell:setPosIndex(index)
  end
end

function this:setPetListSelect()
  for i, v in pairs(self.modules.list_pet) do
    local cell = v
    local node, index = table.ipairsFind(self._selectPosData, function(a)
      return a.pet_guid == cell.bind.guid and not math.isEmpty(cell.bind.guid)
    end)
    cell:setSelect(index ~= nil)
  end
end

function this:refreshPageTabInfo(isInit)
  local totalPage, curPage
  if self._editTarget == L_FormationConst.FormationEditTarget.Hero then
    totalPage = math.ceil(#self._heroTotalDataList / PageCount)
    curPage = self._heroPageIndex
  elseif self._isPetBoxMode then
    totalPage = L_PetStore:getPetBoxNum()
    curPage = self._petBoxIndex
  else
    totalPage = math.ceil(#self._petTotalDataList / PageCount)
    curPage = self._petPageIndex
  end
  local needShowTab = 1 < totalPage
  self.bind.go_changePageTab = needShowTab
  if needShowTab then
    self.bind.go_lastBtn = 1 < curPage
    self.bind.go_nextBtn = totalPage > curPage
    local modulePageTabSlider = self.modules.module_pageTabSlider
    modulePageTabSlider:setPageIndex(curPage, totalPage)
  end
end

function this:selectHero(cell)
  if cell == nil then
    return
  end
  local isSelect = not math.isEmpty(cell.bind.posIndex)
  if isSelect then
    if cell.bind.posIndex == self.SelHeroPosIndex then
      self._selectPosData[cell.bind.posIndex] = {hero_guid = 0, pet_guid = 0}
    else
      local hero_guid = cell.bind.guid
      local pet_guid = self._selectPosData[cell.bind.posIndex].pet_guid
      self._selectPosData[cell.bind.posIndex] = {
        hero_guid = self._selectPosData[self.SelHeroPosIndex].hero_guid,
        pet_guid = self._selectPosData[self.SelHeroPosIndex].pet_guid
      }
      self._selectPosData[self.SelHeroPosIndex].hero_guid = hero_guid
      self._selectPosData[self.SelHeroPosIndex].pet_guid = pet_guid
    end
  else
    self._selectPosData[self.SelHeroPosIndex].hero_guid = cell.bind.guid
    local containPetGuid = L_HeroStore:getHeroPetGuid(L_HeroStore:getHero(cell.bind.guid))
    for i, v in pairs(self._selectPosData) do
      if v.pet_guid ~= nil and v.pet_guid ~= 0 and v.pet_guid == containPetGuid then
        containPetGuid = 0
      end
    end
    self._selectPosData[self.SelHeroPosIndex].pet_guid = containPetGuid
    local minCanAddIndex = self:getMinCanAddPosIndex()
    if not math.isEmpty(minCanAddIndex) then
      self.SelHeroPosIndex = minCanAddIndex
    end
  end
  self:refreshEditPosList()
  self:setHeroListSelect()
end

function this:selectPet(cell)
  if cell == nil then
    return
  end
  local posIndex = self:GetPetIndex(cell.bind.guid)
  local isSelect = not math.isEmpty(posIndex)
  if isSelect then
    if posIndex == self.SelPetPosIndex then
      self._selectPosData[posIndex].pet_guid = 0
    else
      if math.isEmpty(self._selectPosData[self.SelPetPosIndex].hero_guid) then
        L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("residual_code_pagequickformation_03"))
        return
      end
      local pet_guid = self._selectPosData[posIndex].pet_guid
      self._selectPosData[posIndex].pet_guid = self._selectPosData[self.SelPetPosIndex].pet_guid
      self._selectPosData[self.SelPetPosIndex].pet_guid = pet_guid
    end
  else
    if math.isEmpty(self._selectPosData[self.SelPetPosIndex].hero_guid) then
      L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("residual_code_pagequickformation_03"))
      return
    end
    local petItem = L_PetStore:getPetItem(cell.bind.guid)
    self._selectPosData[self.SelPetPosIndex].pet_guid = cell.bind.guid
    local minCanAddIndex = self:getMinCanAddPosIndex()
    if not math.isEmpty(minCanAddIndex) then
      self.SelPetPosIndex = minCanAddIndex
    end
  end
  self:refreshEditPosList()
  self:setPetListSelect()
end

function this:GetHeroIndex(guid)
  for key, value in pairs(self._selectPosData) do
    if value.hero_guid == guid then
      return key
    end
  end
  return 0
end

function this:GetPetIndex(guid)
  for key, value in pairs(self._selectPosData) do
    if value.pet_guid == guid then
      return key
    end
  end
  return 0
end

function this:getMinCanAddPosIndex()
  for i, v in ipairs(self._selectPosData) do
    if self._editTarget == L_FormationConst.FormationEditTarget.Hero then
      if math.isEmpty(self._selectPosData[i].hero_guid) then
        return i
      end
    elseif math.isEmpty(self._selectPosData[i].pet_guid) and not math.isEmpty(self._selectPosData[i].hero_guid) then
      return i
    end
  end
  return 0
end

function this:moveToPage()
  if math.isEmpty(self._moveToId) then
    return
  end
  if self._editTarget == L_FormationConst.FormationEditTarget.Hero then
    for i, v in ipairs(self._heroTotalDataList) do
      if v.guid == self._moveToId then
        self._heroPageIndex = math.ceil(i / PageCount)
        break
      end
    end
  elseif self._isPetBoxMode then
    self._petBoxIndex = math.floor(L_PetStore:getPetItem(self._moveToId).box_id / 100)
  else
    for i, v in ipairs(self._petTotalDataList) do
      if v.guid == self._moveToId then
        self._petPageIndex = math.ceil(i / PageCount)
        break
      end
    end
  end
  self._moveToId = nil
end

function this:autoQuickFormation()
  L_FormationStore:doAutoQuickFormation(self._selectPosData)
  self:refreshEditPosList()
  self:refreshEditPosListTarget()
  if self._editTarget == L_FormationConst.FormationEditTarget.Hero then
    self:setHeroListSelect()
  else
    self:setPetListSelect()
  end
end

function this:getChangedPet()
  local result = {}
  for i = 1, #self._selectPosData do
    if self._selectPosData[i].pet_guid and self._selectPosData[i].hero_guid > 0 then
      local curGuid = L_HeroStore:getHeroPetGuid(L_HeroStore:getHero(self._selectPosData[i].hero_guid))
      if self._selectPosData[i].pet_guid ~= curGuid and curGuid ~= 0 then
        table.insert(result, self._selectPosData[i].hero_guid)
      end
    end
  end
  return result
end

function this:ChangeUIStateInMultiTeam(isOpen)
  if C_MultiTeam.IsInMultiTeam() == true then
    C_MultiTeam.ChangeUIState(isOpen, 3)
  end
end

return this
