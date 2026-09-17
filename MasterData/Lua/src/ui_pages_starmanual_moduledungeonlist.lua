local this = class("moduleDungeonList", G_UIModuleBase)
local starManualTpl = L_GameTpl:getStarManualTpl()
local starManualLevelTpl = L_GameTpl:getStarManualLevelTpl()
local systemUnlockTpl = L_GameTpl:getSystemUnlockTpl()

function this:ctor(...)
  this.super.ctor(self, ...)
  self.data = {id = nil}
end

function this.bind()
  return {
    bossList = {
      moduleName = "pages/StarManual/cellBossItem"
    },
    resList = {
      moduleName = "pages/StarManual/cellResourceItem"
    },
    breakList = {
      moduleName = "pages/StarManual/cellEquipmentItem"
    },
    show_timeFresh = false,
    time_fresh = "",
    show_resList = false,
    show_bossList = false,
    show_breakList = false,
    show_shop = false
  }
end

function this.methods()
  return {
    bossList = {
      onClick_goto = function(self, data)
        self:jumpTo(data)
      end
    },
    breakList = {
      onClick_goto = function(self, data)
        self:jumpTo(data)
      end
    },
    resList = {
      onClick_goto = function(self, data)
        self:jumpTo(data)
      end
    },
    bossOrBreaklist = {
      onClick_goto = function(self, data)
        self:jumpTo(data)
      end
    },
    onClick_gotoShop = function(self)
      local tpl = starManualTpl:getTplById(self.starManualId)
      if tpl then
        local shopId = starManualTpl:getShopId(tpl)
        if not math.isEmpty(shopId) then
          L_SystemBreakManager:jumpTo(shopId)
        end
      end
    end
  }
end

function this:open()
  self.starManualId = nil
end

function this:close()
  self:disposeTimer()
end

function this:initPage(data)
  if data == nil then
    return
  end
  self.starManualId = data.id
  local tpl = starManualTpl:getTplById(self.starManualId)
  if tpl then
    local shopId = starManualTpl:getShopId(tpl)
    self.bind.show_shop = not math.isEmpty(shopId) and true or false
  end
  local groupData = starManualLevelTpl:getGroupData(self.starManualId)
  local uiType = starManualLevelTpl:getUiType(groupData[1])
  if uiType < 1 or 3 < uiType then
    return
  end
  local list
  if uiType == 1 then
    list = self.bind.resList
    self.bind.show_bossList = false
    self.bind.show_resList = true
    self.bind.show_breakList = false
  elseif uiType == 2 then
    list = self.bind.breakList
    self.bind.show_bossList = false
    self.bind.show_resList = false
    self.bind.show_breakList = true
  else
    list = self.bind.bossList
    self.bind.show_bossList = true
    self.bind.show_resList = false
    self.bind.show_breakList = false
  end
  local tmp = {}
  local openList = {}
  local lockList = {}
  for i, v in ipairs(groupData) do
    local dungeonData = L_StarManualManager:parseItem(v)
    local systemId = starManualLevelTpl:getSystem(starManualLevelTpl:getTplById(v.id))
    local is_lock = not C_IntegrateMgr.SystemUnlockModule:getSystemIsOpen(systemId)
    local lockTips = is_lock == true and systemUnlockTpl:getLockTips(systemUnlockTpl:getTplById(systemId)) or L_WordsTpl:getValue("notice_moduleDungeonList_02")
    if string.isEmpty(lockTips) then
      lockTips = L_WordsTpl:getValue("notice_moduleDungeonList_02")
    end
    local tmpList = is_lock == true and lockList or openList
    table.insert(tmpList, {
      id = v.id,
      openTime = dungeonData.openTime,
      name = dungeonData.name,
      desc = dungeonData.desc,
      cost = dungeonData.cost,
      icon = dungeonData.icon,
      show_lock = is_lock,
      itemList = dungeonData.itemList,
      is_lock = is_lock == true and 1 or 0,
      close_reason = is_lock == true and lockTips or L_WordsTpl:getValue("notice_moduleDungeonList_03"),
      show_close = is_lock == true and true or dungeonData.show_close,
      limit_label = dungeonData.limit_label,
      show_limit = dungeonData.show_limit,
      up_status = dungeonData.up_status
    })
  end
  table.sort(openList, function(a, b)
    if a.show_close == b.show_close then
      return a.id < b.id
    elseif a.show_close == false then
      return true
    else
      return false
    end
  end)
  table.sort(lockList, function(a, b)
    if a.is_lock == b.is_lock then
      return a.id < b.id
    else
      return a.is_lock < b.is_lock
    end
  end)
  for i, v in ipairs(openList) do
    table.insert(tmp, v)
  end
  for i, v in ipairs(lockList) do
    table.insert(tmp, v)
  end
  local index = 5 - #tmp
  for i, v in ipairs(tmp) do
    index = index + 1
    v.index = index
  end
  self.bindComponents.content.pivot = C_Vector2(0.5 - (5 - #tmp) * 0.08, 0.5)
  list:clear()
  list:insert_array(tmp)
end

function this:startDateTimer(limitType)
  self:disposeTimer()
  local freshFunc
  if limitType == 1 then
    function freshFunc()
      return L_TimeUtil.getLeftDayRefreshTime()
    end
  elseif limitType == 2 then
    function freshFunc()
      return L_TimeUtil.getLeftWeekRefreshTime()
    end
  elseif limitType == 3 then
    function freshFunc()
      return L_TimeUtil.getLeftWeekRefreshTime()
    end
  end
  self.bind.time_fresh = L_WordsTpl:getValue("notice_moduleDungeonList_01") .. freshFunc()
  self.timer = Timer.repeated(1, function()
    self.bind.time_fresh = L_WordsTpl:getValue("notice_moduleDungeonList_01") .. freshFunc()
  end, self, self.gameObject)
end

function this:disposeTimer()
  if self.timer ~= nil then
    Timer.remove(self.timer)
    self.timer = nil
  end
end

function this:jumpTo(data)
  if data.is_lock == true or data.show_close == true then
    return
  end
  L_StarManualManager:dungeonJumpTo(data.id)
end

return this
