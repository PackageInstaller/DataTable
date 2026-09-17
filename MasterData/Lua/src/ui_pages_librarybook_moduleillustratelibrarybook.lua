local this = class("moduleIllustrateLibraryBook", G_UIModuleBase)
local _libraryBranchTpl = L_GameTpl:getLibraryBranchTpl()
local _librarySeriesTpl = L_GameTpl:getLibrarySeriesTpl()

function this.bind()
  return {
    module_libraryBook = {
      moduleName = "pages/libraryBook/moduleLibraryBookInfo"
    },
    module_subTabList = {
      moduleName = "pages/libraryBook/moduleLibraryBookTab"
    },
    module_sortFilter = L_Const.ModuleInfo.SortFilterModule,
    moduleScrollListBag = {
      moduleName = "pages/libraryBook/cellIconLibraryBook"
    },
    txtProgress = "",
    txtMax = "",
    tfmBookInfo = true,
    tfmBookInfoEmpty = false
  }
end

function this.methods()
  return {}
end

function this:preOpen(options)
  this.super.preOpen(self, options)
end

function this:initPage()
  L_LibraryBookStore:listenCallFunc(L_LibraryBookStore.event.libraryBookChange, self.refreshDataChange, self)
  self:initSortFilterModule()
  self:resetSortFilter()
  self:initData()
  self:refreshData(self._selectSubType)
  self:refreshAll()
  self.isClose = false
  self.closeFunc = nil
end

function this:open()
  self.isClose = false
end

function this:close()
  this.super.close(self)
  L_LibraryBookStore:unListenCallFunc(L_LibraryBookStore.event.libraryBookChange, self.refreshAll)
end

function this:initSortFilterModule()
  local function callback()
    self:refreshData(self._selectSubType)
    
    self:refreshAll()
  end
  
  self.sortFilter = self.sortFilter or L_SortFilterManager:createSortFilter(L_SystemConst.enum.libraryBook, callback, callback)
  local tempModule = self.modules.module_sortFilter
  self.sortFilter:bindModule(tempModule)
end

function this:resetSortFilter()
  self.sortFilter:resetSortFiter(self.modules.module_sortFilter)
end

function this:initData()
  local allBranchList = _libraryBranchTpl:getBranchIdList()
  self._selectSubType = allBranchList[1]
  self.totalFilteredData = self:getScrollViewData()
  self._selectedItemGuid = self:getDefaultSelectGuid()
end

function this:refreshData(subTypeId, seriesId)
  self._selectSubType = subTypeId
  self.totalFilteredData = self:getScrollViewData()
  if seriesId == nil then
    self._selectedItemGuid = self:getDefaultSelectGuid()
  else
    self._selectedItemGuid = seriesId
  end
  self._maxProcessNum = 0
end

function this:getDefaultSelectGuid()
  return self.totalFilteredData[1]
end

function this:getScrollViewData()
  local tempLibraryBranchTpl = _libraryBranchTpl:getTplById(self._selectSubType)
  local totalValue = {}
  local filterDataList = {}
  for k, v in pairs(tempLibraryBranchTpl.seriesId) do
    local tpl = _librarySeriesTpl:getTplById(v)
    if tpl ~= nil then
      local item = {
        itemType = L_Const.resType.accessory,
        itemId = v,
        guid = v
      }
      table.insert(filterDataList, item)
    else
      warn("书籍：地区中的书籍未全部在series中配置" .. v)
    end
  end
  self.sortFilter:sortFilterList(filterDataList)
  for k, v in pairs(filterDataList) do
    table.insert(totalValue, v.itemId)
  end
  table.sort(totalValue, function(a, b)
    local tempTplA = _librarySeriesTpl:getTplById(a)
    local tempTplB = _librarySeriesTpl:getTplById(b)
    local isACollected = false
    local isBCollected = false
    for k2, v2 in pairs(L_LibraryBookStore.data.itemDic) do
      for k, v in pairs(tempTplA.subId) do
        if v == v2.itemId then
          isACollected = true
        end
      end
      for k3, v3 in pairs(tempTplB.subId) do
        if v3 == v2.itemId then
          isBCollected = true
        end
      end
    end
    return isACollected and not isBCollected or isACollected == isBCollected and a < b
  end)
  return totalValue
end

function this:copy_list(orig)
  local new = {}
  for i = 1, #orig do
    new[i] = orig[i]
  end
  return new
end

function this:refreshAll()
  self:initSubTabModule()
  self:refreshBookGroupList()
  self:refreshComInfo()
  self:refreshBookGroupInfo(true)
  local playAnim = self.curSelectedIndex == nil or self.curSelectedIndex ~= 1
  self:refreshCellSelected(playAnim)
  self:refreshTabCellSelected()
end

function this:refreshDataChange()
  if self.modules.moduleScrollListBag == nil then
    return
  end
  for i, v in pairs(self.modules.moduleScrollListBag) do
    v:refreshDataChange()
  end
end

function this:refreshComInfo()
  local tpl = _libraryBranchTpl:getTplById(self._selectSubType)
  local totalNum = 0
  for k, v in pairs(tpl.seriesId) do
    local tempTpl = _librarySeriesTpl:getTplById(v)
    if tempTpl ~= nil then
      totalNum = totalNum + #tempTpl.subId
    else
      warn("书籍：地区中的书籍未全部在series中配置" .. v)
    end
  end
  local collectedNum = 0
  for k, v in pairs(tpl.seriesId) do
    local tempTpl = _librarySeriesTpl:getTplById(v)
    if tempTpl ~= nil then
      for k2, v2 in pairs(tempTpl.subId) do
        for k3, v3 in pairs(L_LibraryBookStore.data.itemDic) do
          if v2 == v3.itemId then
            collectedNum = collectedNum + 1
            break
          end
        end
      end
    else
      warn("书籍：地区中的书籍未全部在series中配置" .. v)
    end
  end
  self.bind.txtProgress = tostring(collectedNum)
  self.bind.txtMax = "/" .. tostring(totalNum)
end

function this:refreshBookGroupInfo(isFirst)
  local isShowBookInfo = self.totalFilteredData ~= nil and #self.totalFilteredData > 0
  self.bind.tfmBookInfo = isShowBookInfo
  self.bind.tfmBookInfoEmpty = not isShowBookInfo
  self.modules.module_libraryBook:refreshDisplay(self._selectedItemGuid, isFirst)
end

function this:refreshBookGroupList()
  local columnsPerRow = 6
  if L_DeviceTpl:getIsPc() then
    columnsPerRow = 6
  elseif L_DeviceTpl:getIsMobile() then
    columnsPerRow = 5
  end
  local tempLibraryBranchTpl = self.totalFilteredData
  local displayTag = {}
  local tag = {}
  for i, v in ipairs(tempLibraryBranchTpl) do
    table.insert(tag, {
      isEmpty = false,
      seriesId = v,
      callback = function(module)
        if module.bind.seriesId == self._selectedItemGuid then
          return
        end
        self:refreshData(self._selectSubType, module.bind.seriesId)
        L_LibraryBookStore:req_bookReadBySeriesId(module.bind.seriesId)
        self:refreshBookGroupInfo(false)
        self:refreshCellSelected(true)
      end
    })
  end
  local minCellRow = 3
  local itemCount = #tag
  local remainder = itemCount % columnsPerRow
  local curRow = itemCount // columnsPerRow + (0 < remainder and 1 or 0)
  local rowOffset = minCellRow <= curRow and 0 or minCellRow - curRow
  local paddingCount = 0
  local columnFill = remainder == 0 and 0 or columnsPerRow - remainder
  paddingCount = columnFill + rowOffset * columnsPerRow
  for i = 1, paddingCount do
    table.insert(tag, {
      isEmpty = true,
      seriesId = nil,
      callback = nil
    })
  end
  self.bind.moduleScrollListBag:clear()
  self.bind.moduleScrollListBag:insert_array(tag)
  FrameScheduler.add(function()
    self.bindComponents.verGridView_bag:ReloadData()
  end)
end

function this:refreshCellSelected(playSelectAnim)
  for i, v in ipairs(self.modules.moduleScrollListBag) do
    local cell = v
    local isSelected = self._selectedItemGuid == v.bind.seriesId
    if isSelected then
      self.curSelectedIndex = i
    end
    cell:setSelected(isSelected, playSelectAnim)
  end
end

function this:initSubTabModule()
  local subTypeList = _libraryBranchTpl:getBranchIdList()
  self.modules.module_subTabList:setData(subTypeList, function(cell)
    if self._selectSubType == cell.bind.id then
      return
    end
    self:refreshData(cell.bind.id)
    self:refreshAll()
  end, self._selectSubType)
end

function this:refreshTabCellSelected()
  self.modules.module_subTabList:setSelected(self._selectSubType)
end

function this:setCloseFunc(closeFunc)
  self.closeFunc = closeFunc
end

function this:closeExpose()
  if self.isClose == true then
    return
  end
  if self.closeFunc then
    self.closeFunc()
  else
    L_UI:close(self.pageName)
  end
  self.isClose = true
end

function this:escHandle()
  self:closeExpose()
end

return this
