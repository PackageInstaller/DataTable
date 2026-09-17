local this = class("pageTutorialActivity", G_UIPageBase)
local _tutorialActivityTpl = L_GameTpl:getTutorialActivityTpl()
local _guidePicTpl = L_GameTpl:getGuidePicTpl()
local _GameActivityTpl = L_GameTpl:getGameActivityTpl()

function this:ctor(...)
  this.super.ctor(self, ...)
  self.data = {}
end

function this.bind()
  return {
    tutorial_list = {
      moduleName = "pages/tutorialActivity/cellTutorialActivityItem"
    },
    tabList = {
      moduleName = "pages/tutorial/cellTutorialTab"
    },
    tutorialIcon = "",
    tutorialType = "",
    tutorialName = "",
    tutorialDesc = "",
    currentTabId = 0,
    info = false,
    empty = false,
    allPage = false,
    last = true,
    lastDisable = false,
    next = true,
    nextDisable = false,
    curIndex = 0,
    maxIndex = 0,
    show_searchMenu = false,
    show_commonMenu = true,
    show_searchButton = true,
    show_cancelButton = false,
    txt_search = "",
    go_newUp = false,
    go_newDown = false
  }
end

function this.methods()
  return {
    onClick_close = function(self)
      L_UI:close(self.pageName)
    end,
    tutorial_list = {
      onClick = function(self, bind)
        self:refreshTutorialInfo(bind.id, bind.data)
      end
    },
    onClick_next = function(self)
      self.iconIndex = self.iconIndex + 1
      self:refreshIndexStatus(1)
      self:refreshInfoPanel(self.iconIndex)
    end,
    onClick_last = function(self)
      self.iconIndex = self.iconIndex - 1
      self:refreshIndexStatus(-1)
      self:refreshInfoPanel(self.iconIndex)
    end,
    onSelectTab = function(self, tabId)
      self.bind.currentTabId = tabId
      self:initTutorialList(tabId)
    end,
    onClick_input = function(self, value)
      self.searchValue = value
      if string.isEmpty(self.searchValue) then
        self:dealWithButtonActive(true)
        self:initTutorialList(self.bind.currentTabId)
        return
      end
      self:dealWithButtonActive(false)
      self:searchTutorial(self.searchValue)
    end,
    onClick_search = function(self)
      if string.isEmpty(self.searchValue) then
        L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_pageTutorial_02"))
        return
      end
      self:dealWithButtonActive(false)
      self:searchTutorial(self.searchValue)
    end,
    onClick_cancel = function(self)
      self.searchValue = ""
      self.bind.txt_search = ""
      self:dealWithButtonActive(true)
      self:initTutorialList(self.bind.currentTabId)
    end,
    onCellValueChange_tableView = function(self)
      self:updateNotReadNew()
    end
  }
end

function this:check(options, callback)
  local result = C_IntegrateMgr.SystemUnlockModule:CheckAndTip(L_SystemConst.enum.tutorial)
  callback(result)
end

function this:preOpen(options)
  self.showActivities = options.activities
  self:initData()
  self:initMenu()
  self.bind.currentTabId = self.bind.tabList[1].tabId
  self:initTutorialList(self.bind.currentTabId)
  self.searchValue = ""
end

function this:close(options)
  L_TimerManager:clearTimer(self)
  self.searchValue = nil
end

function this:initData()
  self.tutorialData = {}
  self.initData = {}
  self.unlockData = {}
  self.redDotData = {}
  for i, v in ipairs(_tutorialActivityTpl:getInitTutorialData()) do
    for _, value in ipairs(self.showActivities) do
      if value == _tutorialActivityTpl:getTutorialTypeId(v) then
        table.insert(self.initData, v)
      end
    end
  end
  self:_sortTable(self.redDotData)
  self:_sortTable(self.unlockData)
  self:_sortTable(self.initData)
end

function this:initMenu()
  local allActivitiesId = self.showActivities
  local datas = {}
  for i, id in ipairs(allActivitiesId) do
    local tpl = _GameActivityTpl:getTplById(id)
    table.insert(datas, {
      tabId = _GameActivityTpl:getId(tpl),
      order = _GameActivityTpl:getId(tpl),
      txtNameOn = L_Lang:get(_GameActivityTpl:getTutorialName(tpl)),
      txtNameOff = L_Lang:get(_GameActivityTpl:getTutorialName(tpl)),
      txtNameSubOn = "TUTORIALTYPE",
      txtNameSubOff = "TUTORIALTYPE",
      txtIconOn = _GameActivityTpl:getTutorialIcon(tpl),
      txtIconOff = _GameActivityTpl:getTutorialIcon(tpl),
      activeLine = true
    })
  end
  table.sort(datas, function(a, b)
    return a.order < b.order
  end)
  datas[#datas].activeLine = false
  self.bind.tabList:clear()
  self.bind.tabList:insert_array(datas)
end

function this:initTutorialList(tabId)
  local cellList = {}
  for i, tpl in ipairs(self.tutorialData) do
    local reddot = L_ReddotManager:haveNew(L_ReddotManager.DotDef.NewTutorialActivityGuide, _tutorialActivityTpl:getId(tpl)) and true or false
    if not math.isEmpty(tabId) and _tutorialActivityTpl:getTutorialTypeId(tpl) == tabId then
      table.insert(cellList, {
        tutorial_name = _tutorialActivityTpl:getTutorialName(tpl),
        tutorialName_selected = _tutorialActivityTpl:getTutorialName(tpl),
        data = tpl,
        reddotName = reddot and string.format(L_ReddotManager.DotDef.NewTutorialActivityGuide, _tutorialActivityTpl:getId(tpl)) or "",
        id = _tutorialActivityTpl:getId(tpl),
        index = i
      })
    end
  end
  self.bind.tutorial_list:clear()
  self.bind.tutorial_list:insert_array(cellList)
  if 0 < #cellList then
    self:refreshTutorialInfo(cellList[1].id, cellList[1].data, true)
    self.bind.info = true
    if self.bind.empty == true then
      self.bindComponents.listAnim:Stop()
      self.bindComponents.listAnim:Play("anim_tutorial_cell_show")
    end
    self.bind.empty = false
  else
    self.bind.info = false
    self.bind.empty = true
  end
end

function this:refreshTutorialInfo(id, data, isInit)
  self:initInfoPanel(data)
  for i = 1, #self.bind.tutorial_list do
    if self.bind.tutorial_list:getValue(i, "id") == id then
      local isSelect = self.bind.tutorial_list:getValue(i, "select_icon")
      self.bind.tutorial_list:change(i, {select_icon = true})
      if not isSelect and not isInit then
        self.bind.tutorial_list:getItemCls(i):playSelectAnim()
      end
    else
      self.bind.tutorial_list:change(i, {select_icon = false})
    end
  end
end

function this:initInfoPanel(data)
  self.iconList = {}
  self.iconIndex = 1
  local picIds = _tutorialActivityTpl:getGuidePicId(data)
  for i, v in ipairs(picIds) do
    local tpl = _guidePicTpl:getTplById(v)
    if tpl then
      table.insert(self.iconList, {
        title = _guidePicTpl:getTitle(tpl),
        icon = _guidePicTpl:getIcon(tpl),
        desc = _guidePicTpl:getDesc(tpl)
      })
    end
  end
  self:refreshInfoPanel(self.iconIndex)
  self.bind.allPage = #self.iconList > 1 and true or false
  if self.bind.allPage then
    self:refreshIndexStatus()
    self.bind.maxIndex = #self.iconList
  end
end

function this:refreshInfoPanel(index)
  if table.isEmpty(self.iconList) or math.isEmpty(self.iconIndex) or self.iconList[index] == nil then
    return
  end
  self.bind.tutorialIcon = self.iconList[index].icon
  self.bind.tutorialName = self.iconList[index].title
  local desc = self.iconList[index].desc
  desc = string.gsub(desc, "#%w+[^%>]", "#3266b4")
  self.bind.tutorialDesc = desc
end

function this:refreshIndexStatus(aniIndex)
  if self.iconIndex - 1 <= 0 then
    self.iconIndex = 1
    self.bind.lastDisable = true
    self.bind.nextDisable = false
  elseif self.iconIndex >= #self.iconList then
    self.iconIndex = #self.iconList
    self.bind.lastDisable = false
    self.bind.nextDisable = true
  else
    self.bind.lastDisable = false
    self.bind.nextDisable = false
  end
  self.bindComponents.infoAnim:Stop()
  if not math.isEmpty(aniIndex) then
    local ani = aniIndex == 1 and "anim_pageswitch_toNext" or "anim_pageswitch_toPrev"
    self.bindComponents.infoAnim:Play(ani)
    L_TimerManager:newOrResetTimer(self, "infoAnim", function()
      self.bind.curIndex = self.iconIndex
    end, 0.1)
  else
    L_TimerManager:clearTimer(self)
    self.bind.curIndex = self.iconIndex
  end
end

function this:searchTutorial(txt)
  local pattern = txt
  local cellList = {}
  local index = 0
  for i, tpl in ipairs(self.tutorialData) do
    local str = _tutorialActivityTpl:getTutorialName(tpl)
    local start_index, end_index = string.find(str, pattern)
    if not math.isEmpty(start_index) then
      index = index + 1
      local reddot = L_ReddotManager:haveNew(L_ReddotManager.DotDef.NewTutorialActivityGuide, _tutorialActivityTpl:getId(tpl)) and true or false
      table.insert(cellList, {
        tutorial_name = _tutorialActivityTpl:getTutorialName(tpl),
        tutorialName_selected = _tutorialActivityTpl:getTutorialName(tpl),
        data = tpl,
        reddotName = reddot and string.format(L_ReddotManager.DotDef.NewTutorialActivityGuide, _tutorialActivityTpl:getId(tpl)) or "",
        id = _tutorialActivityTpl:getId(tpl),
        index = index
      })
    end
  end
  self.bind.tutorial_list:clear()
  self.bind.tutorial_list:insert_array(cellList)
  if 0 < #cellList then
    self:refreshTutorialInfo(cellList[1].id, cellList[1].data)
    self.bind.info = true
    if self.bind.empty == true then
      self.bindComponents.listAnim:Stop()
      self.bindComponents.listAnim:Play("anim_tutorial_cell_show")
    end
    self.bind.empty = false
    self.bind.show_searchMenu = true
  else
    self.bind.info = false
    self.bind.empty = true
    self.bind.show_searchMenu = false
  end
end

function this:dealWithButtonActive(bool)
  self.bind.show_searchButton = bool
  self.bind.show_cancelButton = not bool
  self.bind.show_searchMenu = not bool
  self.bind.show_commonMenu = bool
end

function this:updateNotReadNew()
  local haveNewBottom, haveNewUp = false, false
  local showMinIndex = math.maxinteger
  local showMaxIndex = math.mininteger
  for i, v in ipairs(self.modules.tutorial_list) do
    if v.isBind then
      showMinIndex = math.min(showMinIndex, v.bind.index)
      showMaxIndex = math.max(showMaxIndex, v.bind.index)
    elseif showMinIndex > v.bind.index then
      if L_ReddotManager:haveNew(L_ReddotManager.DotDef.NewTutorialActivityGuide, v.bind.id) then
        haveNewUp = true
      end
    elseif showMaxIndex < v.bind.index and L_ReddotManager:haveNew(L_ReddotManager.DotDef.NewTutorialActivityGuide, v.bind.id) then
      haveNewBottom = true
    end
  end
  self.bind.go_newUp = haveNewUp
  self.bind.go_newDown = haveNewBottom
end

function this:_sortTable(list)
  if not table.isEmpty(list) then
    if 1 < #list then
      table.sort(list, function(a, b)
        return _tutorialActivityTpl:getId(a) < _tutorialActivityTpl:getId(b)
      end)
    end
    for i, v in ipairs(list) do
      local insert = true
      for _, data in pairs(self.tutorialData) do
        if v.id == data.id then
          insert = false
          break
        end
      end
      if insert then
        table.insert(self.tutorialData, v)
      end
    end
  end
end

return this
