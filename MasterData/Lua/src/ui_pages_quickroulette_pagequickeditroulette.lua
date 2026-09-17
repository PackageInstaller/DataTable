local this = class("pageQuickEditRoulette", G_UIPageBase)
local _commonItemTpl = L_GameTpl:getCommonItemTpl()
local rouletteTabTpl = L_GameTpl:getRouletteTabTpl()
local columnNum = 4
local minLineNum = 5
this.btnType = {
  type1 = 1,
  type2 = 2,
  type3 = 3
}

function this:ctor(...)
  this.super.ctor(self, ...)
end

function this.bind()
  return {
    module_quickRoulette = {
      moduleName = "pages/quickRoulette/moduleQuickRoulette"
    },
    scrollList = {
      moduleName = "pages/quickRoulette/cellRouletteBag"
    },
    module_setBtn = {
      moduleName = "modulePages/moduleButton"
    },
    module_tabView = {
      moduleName = "pages/quickRoulette/moduleRouletteGroupMenu"
    },
    module_bagTip = {
      moduleName = "pages/bag/moduleBagTip"
    },
    activeTips = true,
    activeTipsEmpty = false
  }
end

function this.methods()
  return {
    onClick_close = function(self)
      L_UI:close(self.pageName)
    end,
    module_quickRoulette = {
      onClick_cell = function(self, index)
        self:setRouletteModuleSelectIndex(index)
        self:refreshTabGroup()
        self:onSelectChange(true)
        C_AudioManager.Play("Play_SFX_System_UI_MountRoulette_Edit_Tab_Slide")
      end
    }
  }
end

function this:check(options, callback)
  local result = C_IntegrateMgr.SystemUnlockModule:getSystemIsOpen(L_SystemConst.enum.quickRoulette)
  callback(result)
end

function this:created(...)
  this.super.created(self, ...)
end

function this:preOpen(options)
  this.super.preOpen(self, options)
  options = options or {}
  self._callback = options.callback
  L_QuickRouletteStore:listenCallFunc(L_QuickRouletteStore.event.rouletteDataUpdate, self.onEvent_rouletteDataUpdate, self)
  self:initData()
  self:initRouletteModule()
  self:initBagTips()
  self:initItemList()
  self:refreshTabGroup()
  self:onSelectChange()
end

function this:close()
  this.super.close(self)
  L_QuickRouletteStore:unListenCallFunc(L_QuickRouletteStore.event.rouletteDataUpdate, self.onEvent_rouletteDataUpdate, self)
  L_QuickRouletteStore:reqSaveRouletteInfo(self._type)
  if self._callback then
    self._callback()
  end
end

function this:refreshTabGroup()
  self.modules.module_tabView:setData({
    index = self.tabIndex,
    onTabIndexChangeCb = function(index)
      self.tabIndex = index
      self.selectedItemIndex = 1
      self:onSelectChange(true)
    end
  })
end

function this:initBagTips()
  self._bagTipModule = self.modules.module_bagTip
  self._bagTipModule.bind.styleType = 2
  self._bagTipModule:setQualityBgFunc(function(quality)
    return string.format("UI/Atlas/BagTips/tex_quickroulette_rarity_color_%s.png", quality)
  end)
end

function this:initRouletteModule(initIndex)
  self._rouletteModule = self.modules.module_quickRoulette
  self._rouletteModule:setData_rouletteEdit(self._type)
  self:setRouletteModuleSelectIndex(initIndex)
end

function this:setRouletteModuleSelectIndex(index)
  self._selectIndex = index or self.initSelcetIndex
  self._rouletteModule:setSelectIndex(self._selectIndex)
  self:recalcTabIndex(self._selectIndex)
end

function this:initData()
  self._type = L_Const.quickRouletteType.normal
  L_QuickRouletteStore:setCurSelectType(self._type)
  self.initSelcetIndex = 1
end

function this:recalcTabIndex(selcetIndex)
  local guid = L_QuickRouletteStore:getGuidByIndex(selcetIndex, self._type)
  if guid and 0 < guid then
    local itemCfg = _commonItemTpl:getTplById(guid)
    local tabIndex = _commonItemTpl:getRouletteTab(itemCfg)
    local cfgList = L_QuickRouletteStore:getItemCfgList(self._type, tabIndex)
    local index = 0
    for i, v in ipairs(cfgList or table.empty) do
      local num = C_BagMgr:getItemNumByItemId(v.id)
      if num and 0 < num then
        index = index + 1
      end
      if v.id == guid then
        break
      end
    end
    self.tabIndex = tabIndex
    self.selectedItemIndex = index
  end
  if not self.tabIndex or not self.selectedItemIndex then
    self.tabIndex = 1
    self.selectedItemIndex = 1
  end
end

function this:initItemDataList()
  local cfgList = L_QuickRouletteStore:getItemCfgList(self._type, self.tabIndex)
  local dataList = {}
  
  local function clickCb(cell)
    self.selectedItemIndex = cell.bind.index
    self.selectItemId = cell._itemId
    self:onSelectChange()
  end
  
  self.selectItemId = 0
  local count = 0
  for i, v in ipairs(cfgList or table.empty) do
    local num = C_BagMgr:getItemNumByItemId(v.id)
    if num and 0 < num then
      count = count + 1
      local rouletteIndex = L_QuickRouletteStore:getIndexByGuid(v.id, self._type)
      table.insert(dataList, {
        index = count,
        itemType = L_Const.resType.commonItem,
        itemId = v.id,
        guid = v.guid,
        itemNumTxt = tostring(num),
        noReddot = true,
        noTip = true,
        go_active = count == self.selectedItemIndex,
        callback = clickCb,
        activeTips = rouletteIndex and 0 < rouletteIndex,
        tipsNum = tostring(rouletteIndex)
      })
      if count == self.selectedItemIndex then
        self.selectItemId = v.id
      end
    end
  end
  local isEmpty = table.isEmpty(dataList)
  local lineNum
  if not isEmpty then
    lineNum = math.ceil(#dataList / columnNum)
    lineNum = math.max(minLineNum, lineNum)
    self.bindComponents.verGridView_mount.disableScroll = lineNum <= minLineNum
  end
  local dataListCount = #dataList
  for i = 1, (lineNum or minLineNum) * columnNum - dataListCount do
    table.insert(dataList, {})
  end
  self.itemDataListIsEmpty = isEmpty
  self.itemDataList = dataList
end

function this:initItemList()
  self:initItemDataList()
  self.bind.scrollList:clear()
  self.bind.scrollList:insert_array(self.itemDataList)
end

function this:refreshItemList()
  for i, v in pairs(self.modules.scrollList) do
    local cell = v
    if not math.isEmpty(cell._itemId) then
      local isSelect = self.selectedItemIndex == cell.bind.index
      cell:setActive(isSelect)
      cell:showTips(L_QuickRouletteStore:getIndexByGuid(cell._itemId, self._type))
      if isSelect then
        self.selectItemId = cell._itemId
      end
    end
  end
end

function this:refreshBtnInfo()
  if not self._moduleSetBtn then
    self._moduleSetBtn = self.modules.module_setBtn
    self.setBtnParams = {activeBg = false, nameTxtColor = "#000000"}
  end
  self.curBtnType = this.btnType.type1
  local str = L_WordsTpl:getValue("ui_pageQui_ckEditRoulette_02")
  local isEmpty = L_QuickRouletteStore:checkIsEmpty(self._selectIndex, self._type)
  local oldSetIndex = L_QuickRouletteStore:getIndexByGuid(self.selectItemId, self._type)
  if self.itemDataListIsEmpty then
    local tpl = rouletteTabTpl:getTplById(self.tabIndex)
    if tpl then
      local param = rouletteTabTpl:getName(tpl) or ""
      str = L_WordsTpl:getValue("ui_pageQui_ckEditRoulette_01", {
        [0] = param
      })
    end
  elseif oldSetIndex then
    if oldSetIndex ~= self._selectIndex then
      str = L_WordsTpl:getValue("ui_pageQui_ckEditRoulette_03")
      self.curBtnType = this.btnType.type2
    elseif not isEmpty then
      str = L_WordsTpl:getValue("ui_pageQui_ckEditRoulette_04")
      self.curBtnType = this.btnType.type3
    end
  end
  local activeBg = self.selectItemId and self.selectItemId > 0
  self.setBtnParams.activeBg = activeBg
  self.setBtnParams.nameTxtColor = not activeBg and "#000000" or nil
  self.setBtnParams.nameTxtAlpha = activeBg and 1 or 0.5
  self.setBtnParams.btnInteractable = not self.itemDataListIsEmpty
  self._moduleSetBtn:setData(2, str, handler(self, self.onclickSetBtn), self.setBtnParams)
end

function this:onclickSetBtn()
  local oldSetIndex = L_QuickRouletteStore:getIndexByGuid(self.selectItemId, self._type)
  local isSetItem = oldSetIndex and oldSetIndex == self._selectIndex
  local itemId = not isSetItem and self.selectItemId or nil
  L_QuickRouletteStore:setRouletteData(self._selectIndex, itemId, self._type)
end

function this:refreshBagTips()
  if not self.bagTipsParam then
    self.bagTipsParam = {hideCollectBtn = true, hideFuncBtn = true}
  end
  local showTips = self.selectItemId and self.selectItemId > 0
  if showTips then
    local tpl = _commonItemTpl:getTplById(self.selectItemId)
    local bagType = _commonItemTpl:getBagType(tpl)
    self._bagTipModule:reset()
    self._bagTipModule:setData(bagType, self.selectItemId, self.bagTipsParam)
  else
    self._bagTipModule:setEmpty()
  end
  showTips = L_CommonUtil.toBoolean(showTips)
  self.bind.activeTips = showTips
  self.bind.activeTipsEmpty = not showTips
end

function this:onEvent_rouletteDataUpdate()
  self:onSelectChange()
end

function this:onSelectChange(resetList)
  if resetList then
    self:initItemList()
  else
    self:refreshItemList()
  end
  self:refreshBtnInfo()
  self:refreshBagTips()
end

return this
