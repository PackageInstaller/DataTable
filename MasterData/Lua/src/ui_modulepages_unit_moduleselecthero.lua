local this = class("moduleSelectHero", G_UIModuleBase)
local PageCount = 30

function this.bind()
  return {
    go_expand = false,
    go_shrink = false,
    go_expandFilter = nil,
    go_shrinkFilter = nil,
    list_hero_shrink = L_Const.ModuleInfo.CellIconUnit,
    module_sortFilter_shrink = L_Const.ModuleInfo.SortFilterModule,
    list_hero_expand = L_Const.ModuleInfo.CellIconUnit,
    go_changePageTab = false,
    go_lastBtn = false,
    go_nextBtn = false,
    list_tab = {
      moduleName = "pages/formation/formationModule/cellQuickFormationPageTab"
    },
    selectId_pageTab = 0,
    module_sortFilter_expand = L_Const.ModuleInfo.SortFilterModule
  }
end

function this.methods()
  return {
    onClick_viewDetail = function(self)
    end,
    onClick_lastPage = function(self)
      self:changePageIndex(-1)
    end,
    onClick_nextPage = function(self)
      self:changePageIndex(1)
    end,
    onClick_shrink = function(self)
      if self._isPlayingVFX then
        return
      end
      C_AudioManager.Play("Play_SFX_System_UI_General_Halfscreen_Close")
      self:playShrinkVFX()
      self:refreshContent()
    end,
    onClick_expand = function(self)
      if self._isPlayingVFX then
        return
      end
      C_AudioManager.Play("Play_SFX_System_UI_General_Halfscreen_Open")
      self:playExpandVFX()
      self:refreshContent()
    end,
    onClick_closeExpand = function(self)
      if self._isPlayingVFX then
        return
      end
      self:playShrinkVFX()
      self:refreshContent()
    end,
    onClick_btnBg = function(self)
      self:escHandle()
    end,
    onClick_detail = function(self)
      local posData = L_FormationStore:getFormationPosData(L_FormationManager:getRuntimeFormationType(), L_FormationManager:getRuntimeFormationIndex())
      local heroGuid = posData[L_FormationManager:getFocusIndex()]
      if math.isEmpty(heroGuid) then
        L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("residual_code_moduleselecthero_01"))
        return
      end
      L_UI:open("pageHero", {
        heroId = heroGuid,
        pageType = L_Const.heroPageType.DetailMode,
        clearStackOnGoToNextStack = false,
        callBack = function()
          Timer.once(0.2, function()
            if self.isBind and self.methods then
              self.methods.onClick_expand(self)
            end
          end)
        end
      })
    end
  }
end

function this:open()
  self._selectHeroHandler = handler(self, self.selectHero)
end

function this:close(options)
  L_TimerManager:clearTimer(self)
end

function this:initModule(param)
  self._param = param
  self:initSortFilterModule()
  self.bind.go_shrink = false
  self:playShrinkVFX()
  self:initHeroList()
  self:refreshContent()
end

function this:initSortFilterModule()
  if L_FormationManager:getRuntimeFormationIndex() ~= nil and self._lastEditFormationIndex == L_FormationManager:getRuntimeFormationIndex() then
    return
  end
  self._lastEditFormationIndex = L_FormationManager:getRuntimeFormationIndex()
  self._sortFilter = L_SortFilterManager:createSortFilter(self._param.systemId, function()
    self._heroPageIndex = 1
    self:initHeroList()
    self:refreshContent()
    if self.selectList ~= nil then
      self:setListSelect(self.selectList)
    end
  end, function()
    self._heroPageIndex = 1
    self:initHeroList()
    self:refreshContent()
  end)
end

function this:toBind(uiBinding)
  self.super.toBind(self, uiBinding)
  if self._sortFilter then
    if self._isExpand then
      if self.modules.module_sortFilter_expand then
        self._sortFilter:bindModule(self.modules.module_sortFilter_expand)
      end
    elseif self.modules.module_sortFilter_shrink then
      self._sortFilter:bindModule(self.modules.module_sortFilter_shrink)
    end
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

function this:initHeroList()
  local allHero = L_HeroStore:getAllHero()
  self._heroTotalDataList = {}
  for i, v in pairs(allHero) do
    local data = {
      itemType = L_Const.resType.hero,
      itemId = L_HeroStore:getHeroConfigId(v),
      guid = L_HeroStore:getHeroGuid(v)
    }
    table.insert(self._heroTotalDataList, data)
  end
  self._sortFilter:sortFilterList(self._heroTotalDataList)
end

function this:changePageIndex(delta)
  self._heroPageIndex = math.clamp(self._heroPageIndex + delta, 1, self._heroTotalPageNum)
  self:refreshCurPageHero_expand()
  self:refreshPageTabInfo()
end

function this:refreshCurPageHero_expand()
  self:moveToPage()
  self._heroPageIndex = self._heroPageIndex or 1
  local curPageData = {}
  for i = (self._heroPageIndex - 1) * PageCount + 1, self._heroPageIndex * PageCount do
    if not self._heroTotalDataList[i] then
      break
    end
    local guid = self._heroTotalDataList[i].guid
    local hp = L_FormationStore:getFormationHeroHp(guid)
    table.insert(curPageData, {
      itemType = L_Const.resType.hero,
      itemId = self._heroTotalDataList[i].itemId,
      guid = guid,
      callback = self._selectHeroHandler,
      die = not self._param.ignoreState and hp <= 0 or false,
      systemId = self._param.systemId
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
  for i, v in ipairs(self._heroTotalDataList) do
    local guid = v.guid
    local isMask = self:getisHeroInScene(guid)
    local hp = L_FormationStore:getFormationHeroHp(guid)
    table.insert(temp, {
      itemType = L_Const.resType.hero,
      itemId = v.itemId,
      guid = guid,
      activeAdd = isMask,
      callback = self._selectHeroHandler,
      die = not self._param.ignoreState and hp <= 0 or false,
      systemId = self._param.systemId
    })
  end
  if #self.bind.list_hero_shrink == #temp then
    for i, v in pairs(temp) do
      self.bind.list_hero_shrink:change(i, v)
    end
  else
    self.bind.list_hero_shrink:clear()
    self.bind.list_hero_shrink:insert_array(temp)
  end
end

function this:getisHeroInScene(guid)
  if L_FormationManager.runtimeData == nil then
    return false
  end
  local posData = L_FormationStore:getFormationPosData(L_FormationManager:getRuntimeFormationType(), L_FormationManager:getRuntimeFormationIndex())
  for index = 1, L_FormationConst.FormationPosNum do
    local heroId = posData[index]
    if guid == heroId then
      return true
    end
  end
  return false
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

function this:selectHero(cell)
  self:emit("onClick_selectHero", cell.bind.guid, function()
    local isIn = self:getisHeroInScene(cell.bind.guid)
    self.selectId = cell.bind.guid
    cell.bind.activeAdd = isIn
  end)
  if self.bind.onClickSelectHero then
    self.bind:onClickSelectHero(cell.bind.guid, function()
      local isIn = self:getisHeroInScene(cell.bind.guid)
      self.selectId = cell.bind.guid
      cell.bind.activeAdd = isIn
    end)
  end
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

function this:escHandle()
  if self._isPlayingVFX then
    return true
  end
  if self._isExpand then
    self:playShrinkVFX()
    self:refreshContent()
    return true
  end
end

function this:playExpandVFX()
  if not self.isBind then
    return
  end
  if self.bindComponents.ani_moduleSelectHero then
    self.bindComponents.ani_moduleSelectHero:SetBool("Expand", true)
  end
  self.bind.go_expand = true
  self.bind.go_expandFilter = true
  self.bind.go_shrinkFilter = false
  self._isExpand = true
  self._isPlayingVFX = true
  L_TimerManager:newOrResetTimer(self, "playExpandVFX", function()
    if self.isBind then
      self._isPlayingVFX = false
      self.bind.go_shrink = false
      self.bind.list_hero_shrink:clear()
    end
  end, 0.17)
end

function this:playShrinkVFX()
  if not self.isBind then
    return
  end
  self.bind.go_shrink = true
  self._isExpand = false
  self.bind.go_expandFilter = false
  self.bind.go_shrinkFilter = true
  if L_CommonUtil.isValid(self.bindComponents.ani_moduleSelectHero) then
    self.bindComponents.ani_moduleSelectHero:SetBool("Expand", false)
  end
  self._isPlayingVFX = true
  L_TimerManager:newOrResetTimer(self, "playShrinkVFX", function()
    if self.isBind then
      self.bind.go_expand = false
      self._isPlayingVFX = false
      self.bind.list_hero_expand:clear()
    end
  end, 0.17)
end

function this:playHideVFX()
  if not self.isBind then
    return
  end
  if self.bindComponents.ani_moduleSelectHero then
    self.bindComponents.ani_moduleSelectHero:Play("Hide")
  end
  L_TimerManager:newOrResetTimer(self, "playHideVFX", function()
    if self.bind.onVFXPlayHideCb then
      self.bind:onVFXPlayHideCb()
    end
    self:emit("onVFXPlay_hide")
  end, 0.17)
end

function this:setListSelect(selectDic)
  selectDic = selectDic or {}
  self.selectList = selectDic
  for i, v in pairs(self.modules.list_hero_shrink) do
    local cell = v
    local petParams = selectDic[cell.bind.guid]
    cell:setSelectState((petParams and petParams.isSelect) == true)
    cell:setPosIndex(petParams and petParams.index)
  end
  for i, v in pairs(self.modules.list_hero_expand) do
    local cell = v
    local petParams = selectDic[cell.bind.guid]
    cell:setSelectState((petParams and petParams.isSelect) == true)
    cell:setPosIndex(petParams and petParams.index)
  end
end

return this
