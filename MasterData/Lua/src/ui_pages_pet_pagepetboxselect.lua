local page = class("pagePetBoxSelect", G_UIPageBase)
local petTpl = L_GameTpl:getPetTpl()
local _switchHouseAudio = "Play_SFX_System_UI_QiboHouse_House_Click"

function page.bind()
  return {
    scrollLevel = {
      moduleName = "pages/pet/cellBoxItem"
    },
    snapToItemIndex_achievementGroup = 2,
    moveToItemIndex_achievementGroup = 0,
    txt_tips = L_WordsTpl:getValue("ui_pagePetBoxSelect_01"),
    txt_title = "",
    btn_active_change = true,
    btn_active_cancel = false,
    go_curBox = false,
    confirm_txt = L_WordsTpl:getValue("ui_interactiveManager_02"),
    txt_curBox = L_WordsTpl:getValue("ui_pagePetBoxSelect_03")
  }
end

function page.methods()
  return {
    onClick_close = function(self)
      L_UI:close(self.pageName)
    end,
    scrollLevel = {
      onClick = function(self, bind)
        if bind.go_now then
          return
        end
        self.bind.snapToItemIndex_achievementGroup = bind.index
        C_AudioManager.Play(_switchHouseAudio)
      end
    },
    onClick_cancel = function(self)
      self:checkIsFull(self.data.curBox)
    end,
    onClick_change = function(self)
      if self.isClose then
        return
      end
      local isFull, slot = L_PetStore:getPetBoxIsFull(self.data.curBox)
      if not isFull then
        if self.callback then
          self.callback(self.data.curBox)
          L_UI:close(self.pageName)
        else
          local box_id = self.data.curBox * 100 + slot
          L_PetStore:req_CSSetPetBox(self.petGuid, box_id, function()
            L_UI:close(self.pageName)
          end)
        end
      elseif not self.petGuid and self.callback then
        self.callback(self.data.curBox)
        L_UI:close(self.pageName)
      end
    end
  }
end

function page:created(...)
  page.super.created(self, ...)
  self.data = {curBox = nil}
end

function page:preOpen(options)
  page.super.preOpen(self, options)
  self.initBoxIndex = 0
  if options and options.initBoxIndex then
    self.initBoxIndex = options.initBoxIndex
  end
  self.bind.snapToItemIndex_achievementGroup = self.initBoxIndex + 1
  self.ignoreLimit = false
  if options and options.ignoreLimit then
    self.ignoreLimit = options.ignoreLimit
  end
  if options and options.petGuid then
    self.petGuid = options.petGuid
  end
  if options.callback ~= nil then
    self.bind.txt_tips = L_WordsTpl:getValue("ui_pagePetBoxSelect_05")
    self.bind.confirm_txt = L_WordsTpl:getValue("ui_pagePetBoxSelect_04")
    self.callback = options.callback
  end
  self.indexToIdMap = {}
  self:initPointList()
  self.updateTimer = Timer.repeated(0.1, self.updateHander, self)
end

function page:updateHander()
  local loopListViewRoot = self.bindComponents.LoopListViewRoot
  if loopListViewRoot == nil then
    return
  end
  local index = loopListViewRoot.CurSnapNearestItemIndex
  if index == nil then
    return
  end
  if self.indexToIdMap[index] == nil then
    return
  end
  if self.data.curBox == self.indexToIdMap[index] then
    return
  end
  if self.indexToIdMap[index] < 0 then
    return
  end
  self.data.curBox = self.indexToIdMap[index]
  self:refreshPointList()
end

function page:open()
  self.isClose = false
end

function page:show()
end

function page:close()
  page.super.close(self)
  if self.updateTimer then
    Timer.remove(self.updateTimer)
  end
  self.updateTimer = nil
  self.callback = nil
  self.isClose = true
end

function page:OnEvent_SyncPointData(data)
end

function page:getPointList()
  local list = L_PetStore:getPetBoxList()
  local showList = {}
  self.curBoxIndex = 1
  local boxNameIndex = L_PetStore:getPetBoxNameList()
  table.insert(showList, {id = -1, go_content = false})
  table.insert(showList, {id = -1, go_content = false})
  for i, v in ipairs(list) do
    local item = {}
    item.id = i
    item.go_content = true
    item.text_level = boxNameIndex[i]
    local isFull = self:checkIsFull(item.id)
    local isCurrent = self.data.curBox == item.id
    local isSelect = item.id == self.initBoxIndex
    item.go_lock = isFull
    item.go_select = self.initBoxIndex == item.id and not math.isEmpty(self.petGuid)
    if item.go_select == true then
      local petItem = L_PetStore:getPetItem(self.petGuid)
      local petConfigId = petItem.id
      local tpl = petTpl:getTplById(petConfigId)
      local icon = petTpl:getPetBattleIcon(tpl, 1, petItem:isSpecialPet())
      item.petAvatarIcon = icon
    end
    item.go_normal = not isCurrent
    item.go_now = isCurrent
    table.insert(showList, item)
  end
  table.insert(showList, {id = -1, go_content = false})
  table.insert(showList, {id = -1, go_content = false})
  self.indexToIdMap = {}
  for i, v in pairs(showList) do
    v.index = i - 1
    self.indexToIdMap[v.index] = v.id
  end
  return showList
end

function page:initPointList()
  self.bind.scrollLevel:clear()
  local list = self:getPointList()
  self.bind.scrollLevel:insert_array(list)
  self:firstSelect()
end

function page:firstSelect()
  local list = self:getPointList()
  local current = self.initBoxIndex
  if self.data.curBox == nil then
    self.data.curBox = current
  end
  local index, firstIndex
  for i, v in ipairs(list) do
    if v.id > 0 and firstIndex == nil then
      firstIndex = v.index
    end
    if v.id == self.data.curBox and index == nil then
      index = v.index
    end
  end
  if index ~= nil then
    self.bind.moveToItemIndex_achievementGroup = index - 2
  elseif firstIndex ~= nil then
    self.bind.moveToItemIndex_achievementGroup = firstIndex - 2
  end
  local list = self:getPointList()
  for i, v in ipairs(list) do
    self.bind.scrollLevel:change(i, v)
  end
  self:refreshChangeState()
end

function page:refreshPointList()
  local list = self:getPointList()
  for i, v in ipairs(list) do
    local now = self.bind.scrollLevel:getValue(i, "go_now")
    local normal = self.bind.scrollLevel:getValue(i, "go_normal")
    local index = 0
    if now == false and v.go_now == true then
      index = 2
    elseif normal == false and v.go_normal == true then
      index = 1
    end
    self.bind.scrollLevel:change(i, v)
    if v.go_content == true then
      self.bind.scrollLevel:getItemCls(i):playAnim(index)
    end
  end
  self:refreshChangeState()
end

function page:checkIsFull(id)
  local isFull, _ = L_PetStore:getPetBoxIsFull(id)
  return isFull
end

function page:refreshChangeState()
  local canChange = not self:checkIsFull(self.data.curBox)
  if self.ignoreLimit == true then
    canChange = true
  end
  local boxNameIndex = L_PetStore:getPetBoxNameList()
  self.bind.txt_title = boxNameIndex[self.data.curBox]
  local isCurBox = self.data.curBox == self.initBoxIndex
  if canChange and isCurBox then
    canChange = false
  end
  self.bind.btn_active_change = canChange and not isCurBox
  self.bind.btn_active_cancel = not canChange and not isCurBox
  self.bind.go_curBox = isCurBox
  self.bind.txt_curBox = self.petGuid == nil and L_WordsTpl:getValue("ui_pagePetBoxSelect_02") or L_WordsTpl:getValue("ui_pagePetBoxSelect_03")
end

return page
