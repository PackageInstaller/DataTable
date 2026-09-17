local this = class("moduleIllustratedCharacter", G_UIModuleBase)
local sConcat = string.concat
local _formationTpl = L_GameTpl:getFormationTpl()
local _heroTpl = L_GameTpl:getHeroTpl()
local _elementTpl = L_GameTpl:getElementTypeTpl()
local _nationsTpl = L_GameTpl:getGroupsTpl()
local _charDataTpl = L_GameTpl:getCharDataTpl()
local PageCount = 5

function this.bind()
  return {
    go_heroModelImg = true,
    go_heroPictureImg = true,
    img_heroPicture = "",
    go_shrink = true,
    list_hero_shrink = {
      moduleName = "pages/illustratedCharacter/cellIllustratedCharacterUnit"
    },
    module_sortFilter_shrink = L_Const.ModuleInfo.SortFilterModule,
    txt_name = "",
    txt_nation = "",
    txt_nameDesc = "",
    img_nationBig = "BSCommon/tex_icon_nation_01",
    go_nation = true,
    go_nationOther = false,
    img_nationIcon = "",
    txt_resume = "",
    txt_modelBtn = "",
    txt_ownedNum = "",
    txt_ownedStatus = "",
    go_showUIBtn = false,
    go_expand = false,
    list_hero_expand = {
      moduleName = "pages/illustratedCharacter/cellIllustratedCharacterUnit"
    },
    go_changePageTab = false,
    go_lastBtn = false,
    go_nextBtn = false,
    list_tab = {
      moduleName = "pages/formation/formationModule/cellQuickFormationPageTab"
    },
    selectId_pageTab = 0,
    module_sortFilter_expand = L_Const.ModuleInfo.SortFilterModule,
    go_dragModel = true
  }
end

function this.methods()
  return {
    onClick_expand = function(self)
      self._isExpand = true
      self.bind.go_expand = true
      self:refreshContent()
    end,
    onClick_closeExpand = function(self)
      self._isExpand = false
      self.bind.go_expand = false
      self:refreshContent()
    end,
    onClick_3DTypeChange = function(self)
      if self._in3dType then
        self._in3dType = false
      else
        self._in3dType = true
      end
      self:refresh3DType()
    end,
    onClick_ShowDetail = function(self)
      local list = {}
      table.insert(list, self.selectId)
      L_UI:open("pageHero", {
        heroIdList = list,
        pageType = L_Const.heroPageType.HandBookMode
      })
    end,
    onClick_ShowDetailExpand = function(self)
      local list = {}
      table.insert(list, self.selectId)
      L_UI:open("pageHero", {
        heroIdList = list,
        pageType = L_Const.heroPageType.HandBookMode
      })
    end,
    onClick_hideUI = function(self)
      self._hideUI = true
      self:refreshUIShow()
      C_IntegrateMgr.TopBarModule:SetTopBarVisible(false)
    end,
    onclick_showUI = function(self)
      self._hideUI = false
      self:refreshUIShow()
      C_IntegrateMgr.TopBarModule:SetTopBarVisible(true)
    end,
    onClick_lastPage = function(self)
      self:changePageIndex(-1)
    end,
    onClick_nextPage = function(self)
      self:changePageIndex(1)
    end,
    dragBegin = function(self, pos)
      self.deltaX = 0
      self.modEuler = L_Vector3.new(0, self.modEuler.y + self.deltaX, 0)
      self:setSceneHeroRot(self.modEuler)
      self.oldDragX = pos.x
    end,
    drag = function(self, pos)
      self.deltaX = (self.oldDragX - pos.x) * 0.3
      self.modEuler = L_Vector3.new(0, self.modEuler.y + self.deltaX, 0)
      self:setSceneHeroRot(self.modEuler)
      self.oldDragX = pos.x
    end,
    dragEnd = function(self, pos)
      self.deltaX = (self.oldDragX - pos.x) * 0.3
      self.modEuler = L_Vector3.new(0, self.modEuler.y + self.deltaX, 0)
      self:setSceneHeroRot(self.modEuler)
      self.oldDragX = pos.x
    end
  }
end

function this:changePageIndex(delta)
  self._heroPageIndex = math.clamp(self._heroPageIndex + delta, 1, self._heroTotalPageNum)
  self:refreshCurPageHero_expand()
  self:refreshPageTabInfo()
end

function this:refreshPageTabInfo(isInit)
  local totalPage, curPage
  totalPage = math.ceil(#self._heroTotalDataList / PageCount)
  curPage = self._heroPageIndex
  local needShowTab = 1 < totalPage
  self.bind.go_changePageTab = needShowTab
  if needShowTab then
    self.bind.go_lastBtn = 1 < curPage
    self.bind.go_nextBtn = totalPage > curPage
    if isInit then
      local temp = {}
      for i = 1, totalPage do
        table.insert(temp, {id_tabItem = i})
      end
      self.bind.list_tab:clear()
      self.bind.list_tab:insert_array(temp)
    end
    self.bind.selectId_pageTab = curPage
  end
end

function this:preOpen(options)
  this.super.preOpen(self, options)
end

function this:open()
  self._selectHeroHandler = handler(self, self.selectHero)
  self.modEuler = L_Vector3.zero
  self.deltaX = 0
  self.oldDragX = 0
end

function this:setSceneHeroRot(rot)
  L_Vector3.setLocalRot(self.modelRootTrans, rot)
end

function this:initPage(sceneGo)
  self.sceneGo = sceneGo
  local sceneTrans = self.sceneGo.transform
  self.modelRootTrans = sceneTrans:Find("ModelRoot")
  self._in3dType = true
  self:refresh3DType()
  self:initSortFilterModule()
  self:initHeroList()
  self:refreshContent()
  self:refreshHeroInfo()
  self:OnSelectedHeroChanged(self.selectId)
  self._hideUI = false
  self:refreshUIShow()
end

function this:setCloseFunc(closeFunc)
  self.closeFunc = closeFunc
end

function this:initSortFilterModule()
  self._sortFilter = L_SortFilterManager:createSortFilter(L_SystemConst.enum.characterIllustration, function()
    self._heroPageIndex = 1
    self:initHeroList()
    self:refreshContent()
    if self.selectId ~= nil then
      self:setListSelect(self.selectId)
    end
  end, function()
  end)
end

function this:initHeroList()
  local unlockNum = 0
  self._heroTotalDataList = {}
  local now = L_TimeUtil:getServerTime()
  for _, v in pairs(_heroTpl.data) do
    if v.isCollect == 1 then
      local unlockTime = L_TimeUtil.getDateTimeStamp(v.timetag)
      if now > unlockTime then
        local data = {
          itemType = L_Const.resType.heroEncyclopedia,
          itemId = v.id,
          guid = 0
        }
        table.insert(self._heroTotalDataList, data)
        if L_HeroStore:getHasHero(v.id) then
          unlockNum = unlockNum + 1
        end
      end
    end
  end
  self.bind.txt_ownedNum = unlockNum .. "/" .. #self._heroTotalDataList
  self._heroTotalPageNum = math.ceil(#self._heroTotalDataList / PageCount)
  self._sortFilter:sortFilterList(self._heroTotalDataList)
  if self.selectId == nil then
    self.selectId = self._heroTotalDataList[1].itemId
  end
end

function this:refreshContent()
  if self._isExpand then
    if self.modules.module_sortFilter_expand ~= nil then
      self._sortFilter:bindModule(self.modules.module_sortFilter_expand)
    end
    self:refreshCurPageHero_expand()
    self:refreshPageTabInfo(true)
  else
    if self.modules.module_sortFilter_shrink ~= nil then
      self._sortFilter:bindModule(self.modules.module_sortFilter_shrink)
    end
    self:refreshCurPageHero_shrink()
  end
end

function this:refreshHeroInfo()
  local heroTpl = _heroTpl:getTplById(self.selectId)
  self.bind.txt_name = _heroTpl:getName(heroTpl)
  self.bind.txt_nameDesc = _heroTpl:getEnglishName(heroTpl)
  local nationId = _heroTpl:getNations(heroTpl)
  local groupsTpl = L_GameTpl:getGroupsTpl()
  local iconPath = groupsTpl:getIcon(groupsTpl:getTplById(nationId), L_Const.nationTextureIndex.nationLarge)
  if not string.isEmpty(iconPath) then
    self.bind.img_nationBig = iconPath
  end
  self.bind.txt_nation = _nationsTpl:getName(_nationsTpl:getTplById(nationId))
  self.bind.go_nation = nationId ~= L_Const.nations.other
  self.bind.go_nationOther = nationId == L_Const.nations.other
  if nationId ~= L_Const.nations.other then
    local heroNationIconPath = groupsTpl:getIcon(groupsTpl:getTplById(nationId), L_Const.nationTextureIndex.heroNation)
    self.bind.img_nationIcon = heroNationIconPath
  end
  local charDataTpl = _charDataTpl:getTplById(self.selectId) or _charDataTpl:getTplById(101003)
  self.bind.txt_resume = _charDataTpl:getIntroduction(charDataTpl)
  local heroClothingTpl = L_GameTpl:getHeroClothingTpl()
  self.bind.img_heroPicture = heroClothingTpl:getAvatarTexture(heroClothingTpl:getTplById(self.selectId), 6)
end

function this:refresh3DType()
  if self._in3dType then
    self.bind.txt_modelBtn = "2D"
    self.bind.go_heroModelImg = true
    self.bind.go_heroPictureImg = false
    self.bind.go_dragModel = true
  else
    self.bind.txt_modelBtn = "3D"
    self.bind.go_heroModelImg = false
    self.bind.go_heroPictureImg = true
    self.bind.go_dragModel = false
  end
end

function this:selectHero(cell)
  local heroConfigId = cell.bind.configId
  local hasHero = L_HeroStore:getHasHero(heroConfigId)
  if hasHero then
    local heroGuid = L_HeroStore:getGuidByConfigId(heroConfigId)
    L_ReddotManager:clearNew(L_ReddotManager.DotDef.HandBook_Character_New_Item, heroGuid)
  end
  if self.selectId == heroConfigId then
    return
  end
  self.selectId = heroConfigId
  self:setListSelect(heroConfigId)
  self:refreshHeroInfo()
  self:OnSelectedHeroChanged(heroConfigId)
end

function this:OnSelectedHeroChanged(heroConfigId)
  if L_CommonUtil.isValid(self.heroObj) then
    C_GameObject.Destroy(self.heroObj)
  end
  self:_fetchHeroModelAsync(heroConfigId, function(entity, heroObj)
    if entity == nil then
      return
    end
    local heroTpl = _heroTpl:getTplById(heroConfigId)
    self.heroObj = heroObj
    local heroTrans = heroObj.transform
    heroTrans:SetParent(self.modelRootTrans)
    local scale = _heroTpl:getHandbookHeroScale(heroTpl)
    L_Vector3.setSize(heroTrans, scale)
    local pos = _heroTpl:getHandbookHeroPositionOffset(heroTpl)
    L_Vector3.setLocalPos(heroTrans, pos)
    local rot = _heroTpl:getHandbookHeroRotation(heroTpl)
    L_Vector3.setLocalRot(heroTrans, rot)
    self:setHeroAdmission(entity, heroConfigId, function()
      entity.playableAnimator:Play("FormationIdle")
    end)
  end)
end

function this:_fetchHeroModelAsync(heroConfigId, callback)
  local isPlayerHero = false
  local unitId = L_GameUtil.getUnitIdByRole(heroConfigId, L_Const.roleType.hero)
  local heroModelPath = ""
  if unitId then
    heroModelPath = L_GameUtil.getAvatarModelPathByUnitId(unitId, L_Const.avatarModelIndex.UnitModel)
  end
  local entity
  local id = C_UIMgr.uiLoader:SpawnAsync(heroModelPath, function(uid, obj)
    if not L_CommonUtil.isValid(obj) then
      callback(nil, nil)
      errorf("cant load asset from " .. heroModelPath)
      return
    end
    obj.name = sConcat("hero_", heroConfigId)
    obj:SetActive(false)
    C_MJLog.LogInfo(string.format("开始异步加载编队UI角色Entity heroConfigId:%d path:%s", heroConfigId, heroModelPath), C_ELogModule.FormationUI)
    local needAnimaList = {
      "FormationIdle",
      "FormationAdmission",
      "Personal1"
    }
    L_EntityManager:generateSimpleHeroAsync(heroConfigId, obj, isPlayerHero, nil, function(heroEntity)
      entity = heroEntity
      if not L_CommonUtil.isValid(obj) then
        C_MJLog.LogInfo(string.format("编队UI角色entity创建完成时界面已关闭，销毁角色 heroConfigId:%d", heroConfigId), C_ELogModule.FormationUI)
        C_PrefabManager:RecycleByLoader(obj)
        entity:onDestroy()
        callback(nil, nil)
        return
      end
      C_MJLog.LogInfo(string.format("编队UI角色entity创建完成 heroConfigId:%d entityId:%d", heroConfigId, entity.entityId), C_ELogModule.FormationUI)
      obj:SetActive(true)
      if heroEntity.biologyData then
        heroEntity.biologyData.magicaClothActive = false
      end
      heroEntity.playableAnimator:Play("FormationIdle")
      callback(entity, entity.gameObject)
    end, needAnimaList, C_EEntityEntranceType.IllustratedCharacter)
  end, nil, true, C_EAssetOperationModule.Lua, C_AssetLoadPriority.GetPriority(C_AssetLoadPriority.UI_Page))
end

function this:setHeroAdmission(heroEntity, heroConfigId, callback)
  local entity = heroEntity
  local heroGameObject = entity:getGameObject()
  local animator = L_CommonUtil.getModComponent(typeof(C_PlayableAnimator), heroGameObject)
  animator:CrossFade("FormationAdmission", 0, -1, 0, 0)
  if callback then
    local aniState = animator:GetState("FormationAdmission")
    if aniState then
      L_TimerManager:newOrResetTimer(self, "hero_ani_callback", callback, aniState.length)
    else
      callback()
    end
  end
  self:_fetchEffectModel(heroConfigId, heroGameObject)
end

function this:setHeroPersonal()
  local heroGameObject = self.heroObj
  local animator = L_CommonUtil.getModComponent(typeof(C_PlayableAnimator), heroGameObject)
  local aniState = animator:GetState("Personal1")
  if aniState then
    animator:CrossFade("Personal1", 0, -1, 0, 0)
    L_TimerManager:newOrResetTimer(self, "hero_ani_Personal1_callback", function()
      animator:Play("FormationIdle")
    end, aniState.length)
  end
end

function this:_fetchEffectModel(heroConfigId, heroGameObject)
  local tpl = _heroTpl:getTplById(heroConfigId)
  local elementId = _heroTpl:getElement(tpl)
  local tpl_ele = _elementTpl:getTplById(elementId)
  local path = _elementTpl:getAdmissioneffects(tpl_ele)
  local effectObj = L_ResPool:syncGameObject(path)
  effectObj.transform:SetParent(heroGameObject.transform:GetChild(0))
  L_Vector3.setLocalPos(effectObj.transform, L_Vector3.zero)
  effectObj:ActiveTrans(true)
end

function this:moveToPage()
  if math.isEmpty(self._moveToId) then
    return
  end
  for i, v in ipairs(self._heroTotalDataList) do
    if v.guid == self._moveToId then
      self._heroPageIndex = math.ceil(i / PageCount)
      break
    end
  end
  self._moveToId = nil
end

function this:refreshCurPageHero_expand()
  self:moveToPage()
  self._heroPageIndex = self._heroPageIndex or 1
  local curPageData = {}
  for i = (self._heroPageIndex - 1) * PageCount + 1, self._heroPageIndex * PageCount do
    if not self._heroTotalDataList[i] then
      break
    end
    table.insert(curPageData, {
      itemType = L_Const.resType.hero,
      configId = self._heroTotalDataList[i].itemId,
      callback = self._selectHeroHandler,
      selectId = self.selectId
    })
  end
  if #self.bind.list_hero_expand == #curPageData then
    for i, v in pairs(curPageData) do
      self.bind.list_hero_expand:change(i, v)
    end
  else
    self.bind.list_hero_expand:clear()
    self.bind.list_hero_expand:insert_array(curPageData)
  end
end

function this:refreshCurPageHero_shrink()
  local temp = {}
  for _, v in ipairs(self._heroTotalDataList) do
    table.insert(temp, {
      itemType = L_Const.resType.hero,
      configId = v.itemId,
      callback = self._selectHeroHandler,
      selectId = self.selectId
    })
  end
  self.bind.list_hero_shrink:clear()
  self.bind.list_hero_shrink:insert_array(temp)
end

function this:setListSelect(selectId)
  for i, v in pairs(self.modules.list_hero_shrink) do
    local cell = v
    cell:setSelectState(selectId)
  end
  for i, v in pairs(self.modules.list_hero_expand) do
    local cell = v
    cell:setSelectState(selectId)
  end
end

function this:refreshUIShow()
  if self._hideUI then
    self.bind.go_shrink = false
    self.bind.go_showUIBtn = true
  else
    self.bind.go_shrink = true
    self.bind.go_showUIBtn = false
  end
end

function this:BeforeClose()
  local heros = L_HeroStore:getAllNormalHero()
  for _, hero in pairs(heros) do
    if L_ReddotManager:haveNew(L_ReddotManager.DotDef.HandBook_Character_New_Item, L_HeroStore:getHeroGuid(hero)) then
      L_ReddotManager:clearNew(L_ReddotManager.DotDef.HandBook_Character_New_Item, L_HeroStore:getHeroGuid(hero))
    end
  end
  if L_ReddotManager:haveNew(L_ReddotManager.DotDef.HandBook_Character_New, "") then
    L_ReddotManager:clearNew(L_ReddotManager.DotDef.HandBook_Character_New, "")
  end
end

return this
