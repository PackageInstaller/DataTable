local this = class("moduleStarManualBoss", G_UIModuleBase)
local starManualTpl = L_GameTpl:getStarManualTpl()
local starManualLevelTpl = L_GameTpl:getStarManualLevelTpl()

function this:ctor(...)
  this.super.ctor(self, ...)
  self.data = {
    itemList = {}
  }
end

function this.bind()
  return {
    scrollList_reward = {
      moduleName = "pages/starManual/cellStarmanualReward"
    },
    freshTime = "",
    canRewardCount = "2/2",
    show_up = false,
    upNum = "X2",
    show_bonuns = false,
    openTime = "",
    type = "",
    listPoint = {
      moduleName = "pages/Main/cellActivityPoint"
    }
  }
end

function this.methods()
  return {
    onClick_gotoShop = function(self)
      local tpl = starManualTpl:getTplById(self.starManualId)
      if tpl then
        local shopId = starManualTpl:getShopId(tpl)
        if not math.isEmpty(shopId) then
          L_SystemBreakManager:jumpTo(shopId)
        end
      end
    end,
    onClick_gotoBoss = function(self)
      if not self.currentBoss then
        return
      end
      L_StarManualManager:dungeonJumpTo(self.currentBoss.id)
    end
  }
end

function this:open()
  self:configTouch("+")
end

function this:close()
  self:configTouch("-")
  self:disposeTimer()
end

function this:initPage(data)
  self.starManualId = data.id
  local tpl = starManualTpl:getTplById(data.id)
  if tpl then
    local desc = starManualTpl:getDesc(tpl)
    if not string.isEmpty(desc) then
      self.bind.show_bonuns = true
      self.bind.bonusTxt = desc
    end
    local param = starManualTpl:getLimitParam(tpl)
    self.bind.canRewardCount = L_WordsTpl:getValue("ui_moduleStarManualBoss", {
      [0] = param,
      [1] = param
    })
  end
  local groupData = starManualLevelTpl:getGroupData(data.id)
  self.bossData = {}
  for i, v in pairs(groupData) do
    local dungeonData = L_StarManualManager:parseItem(v)
    table.insert(self.bossData, {
      id = v.id,
      openTime = dungeonData.openTime,
      name = dungeonData.name,
      desc = dungeonData.desc,
      cost = dungeonData.cost,
      icon = dungeonData.icon,
      order = starManualLevelTpl:getOrder(v),
      itemList = dungeonData.itemList or {},
      up_status = dungeonData.up_status
    })
  end
  if 1 < #self.bossData then
    table.sort(self.bossData, function(a, b)
      return a.order < b.order
    end)
  end
  self:initBossInfo(self.bossData[1])
  self.currentBoss = self.bossData[1]
  self.index = 1
  self.maxIndex = #self.bossData
  self:initPointList()
  self:startDateTimer()
end

function this:initBossInfo(bossInfo)
  self.bind.openTime = bossInfo.openTime
  self.bind.show_up = bossInfo.up_status
  self.bind.type = bossInfo.desc
  self:initRewardList(bossInfo.itemList)
end

function this:initRewardList(itemList)
  local tmp = {}
  local items = {}
  for i, v in pairs(itemList) do
    table.insert(items, {
      itemType = v[1],
      itemId = v[2],
      itemNum = v[3]
    })
  end
  for _, v in pairs(items) do
    local tplData = L_ItemTplManager:getItemConfig(v.itemType, v.itemId)
    table.insert(tmp, {
      type = v.itemType,
      id = v.itemId,
      img_icon = tplData.icon,
      txt_num = 1 >= v.itemNum and "" or tostring(v.itemNum),
      img_frame = L_RarityTpl:getIconByType(tplData.quality, L_Const.qualityPathType.cell1_frame),
      img_bg = L_RarityTpl:getIconByType(tplData.quality, L_Const.qualityPathType.cell1_bg)
    })
  end
  self.bind.scrollList_reward:clear()
  self.bind.scrollList_reward:insert_array(tmp)
end

function this:initPointList()
  local tmp = {}
  for i = 1, #self.bossData do
    table.insert(tmp, {})
  end
  self.bind.listPoint:clear()
  self.bind.listPoint:insert_array(tmp)
  self:setPointListActive()
end

function this:setPointListActive(itemIndex)
  self.index = itemIndex or 1
  for i = 1, #self.bind.listPoint do
    local active = i == self.index
    if math.isEmpty(itemIndex) then
      self.bind.listPoint:change(i, {
        go_active = active,
        go_normal = not active
      })
    else
      local cur_state = self.bind.listPoint:getValue(i, "go_active")
      if active ~= cur_state then
        self.bind.listPoint:change(i, {
          go_active = active,
          go_normal = not active
        })
      end
    end
  end
end

function this:startDateTimer()
  self:disposeTimer()
  self:forceFreshTime()
  self.timer = Timer.repeated(1, function()
    self:forceFreshTime()
  end, self, self.gameObject)
end

function this:forceFreshTime()
  self.bind.freshTime = L_TimeUtil.getLeftWeekRefreshTime(true)
  L_GameUtil.forceRebuildLayout(self.bindComponents.limitTrans)
end

function this:disposeTimer()
  if self.timer ~= nil then
    self.timer:stop()
    Timer.remove(self.timer)
    self.timer = nil
  end
  self:killTimer()
end

function this:configTouch(operator)
  self.onUIDragStartHandle = self.onUIDragStartHandle or L_CommonUtil.handle(self.onUI_dragStartHandle, self)
  self.onUIDragHandle = self.onUIDragHandle or L_CommonUtil.handle(self.onUI_dragHandle, self)
  self.onUIDragEndHandle = self.onUIDragEndHandle or L_CommonUtil.handle(self.onUI_dragEndHandle, self)
  C_ScreenTouch.OnUI_DragStart(operator, self.onUIDragStartHandle)
  C_ScreenTouch.OnUI_Drag(operator, self.onUIDragHandle)
  C_ScreenTouch.OnUI_DragEnd(operator, self.onUIDragEndHandle)
end

function this:onUI_dragHandle(gesture)
  if gesture.go ~= self.parent.bindComponents.bg_1.gameObject and gesture.go ~= self.parent.bindComponents.bg_2.gameObject then
    return
  end
  local deltaPos = gesture.deltaPosition
  self:setDragDirection(deltaPos)
end

function this:onUI_dragStartHandle(gesture)
end

function this:onUI_dragEndHandle(gesture)
  if self.canSwitch then
    self:initBossInfo(self.bossData[self.index])
    self:setPointListActive(self.index)
    if not math.isEmpty(self.direction) then
      self:killTimer()
      self:doAnimation(self.direction)
    end
  end
  self.canSwitch = false
  self.direction = 0
end

function this:setDragDirection(deltaPos)
  if self.canSwitch == true then
    return
  end
  if deltaPos.x <= -25 then
    if self.index >= self.maxIndex then
      return
    else
      self.index = self.index + 1
      self.direction = 1
    end
  elseif deltaPos.x >= 25 then
    if self.index <= 1 then
      return
    else
      self.index = self.index - 1
      self.direction = 2
    end
  end
  self.canSwitch = true
end

function this:doAnimation(type)
  if type == 1 then
    self.bindComponents.boardAnim:Play("anim_starmanual_boss_right_out")
    self.aniTimer = Timer.once(0.2, function()
      self.bindComponents.boardAnim:Stop()
      self.bindComponents.boardAnim:Play("anim_starmanual_boss_right_in")
    end, self, self.gameObject)
  elseif type == 2 then
    self.bindComponents.boardAnim:Play("anim_starmanual_boss_left_out")
    self.aniTimer = Timer.once(0.2, function()
      self.bindComponents.boardAnim:Stop()
      self.bindComponents.boardAnim:Play("anim_starmanual_boss_left_in")
    end, self, self.gameObject)
  end
end

function this:killTimer()
  if self.aniTimer then
    Timer.remove(self.aniTimer)
    self.aniTimer = nil
  end
end

return this
