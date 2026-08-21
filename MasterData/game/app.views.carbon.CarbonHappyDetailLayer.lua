local BattleCsv = require("csvdata.leyuan_battle")
local MainBattleCsv = require("csvdata.chapter_battle")
local HappyRes = "ui/carbon/happy/"
local uiData = {
  csbFile = "ui/carbon/CarbonHappyDetailLayer.csb",
  mask = true,
  widgets = {
    mainBg = "mainBg",
    countBg = "countBg",
    up = "up",
    listView = "listView",
    count = "countBg/count",
    node = "detailBg/node",
    btnBattle = "btnBattle",
    itemNode = "detailBg/itemNode",
    btnMode = "detailBg/btnMode",
    detailBg = "detailBg"
  }
}
local CarbonHappyDetailLayer = class("CarbonHappyDetailLayer", UIBase)

function CarbonHappyDetailLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function CarbonHappyDetailLayer:init(params)
  TopBar:show(TopBarType.full, "战斗")
  game:playMusic(3)
  TopBar:showAnimation(true)
  self.enough = true
  self.battleInfo = json.decode(game.role.paradiseBattleInfo) or {}
  self.selectId = params.carbonId or self.battleInfo.carbonId
  self.diffType = params.type or self.selectId and BattleCsv[self.selectId].type or 1
  if UIHelper.isiPhoneX() then
    UIHelper.fitForiPhoneX(self.mainBg)
  end
  UIHelper.MoveToLeft({
    node = self.detailBg,
    delay = 0.4,
    time = 0.3,
    pos = {660, 0}
  })
  UIHelper.MoveToUp({
    node = self.btnBattle,
    delay = 0.4,
    time = 0.3
  })
  UIHelper.MoveToUp({
    node = self.countBg,
    delay = 0.4,
    time = 0.3
  })
  UIHelper.MoveToDown({
    node = self.up
  })
  display.newSprite(HappyRes .. "btn_add.png"):pos(185, 18):addTo(self.countBg)
  display.newTTFLabel({text = "出发", size = 38}):enableOutline(UIHelper.hex2rgb("#641f08"), 2):pos(150, 34):addTo(self.btnBattle)
  display.newTTFLabel({
    text = self.diffType == 1 and "经验乐园简介" or "食灵乐园简介",
    size = 36
  }):anch(0, 0.5):pos(40, 31):addTo(self.btnMode)
  if UIHelper.isiPhoneX() then
    UIHelper.fitForiPhoneX(self.mainBg)
  end
  self.countBg:setCallback(function()
    local layer = game:createView("carbon.CarbonBuyHappyCountLayer", {
      diffType = self.diffType,
      callback = function()
        self:refreshLeftCount()
      end
    })
    BackManager:push(function()
      layer:close()
    end)
  end)
  self.btnBattle:setTouchScale()
  self.btnBattle:setCallback(function()
    local open, count = self:getOpen()
    if not open then
      SysError(SYS_ERR_CAEBON_HAPPY_NOT_OPEN)
      return
    end
    if next(json.decode(game.role.battleInfo) or {}) then
      SysError(SYS_ERR_CARBON_MAIN_ON_BATTLE)
      return
    end
    if next(json.decode(game.role.moonBattleInfo) or {}) then
      SysError(SYS_ERR_CARBON_ACTIVITY_ON_BATTLE)
      return
    end
    if self.battleInfo.carbonId and self.battleInfo.carbonId ~= BattleCsv[self.selectId].id then
      SysError(SYS_ERR_CARBON_HAPPY_ON_BATTLE)
      return
    end
    if count <= game.role.paradiseBattleCount:getv(self.diffType, 0) and self.battleInfo.carbonId ~= self.selectId then
      SysError(SYS_ERR_CAEBON_HAPPY_COUNT_USE_OUT)
      return
    end
    local status, key1, key2 = self:checkStatus(BattleCsv[self.selectId].prepose)
    if not status then
      local hard = 20000 < key1 and (30000 < key1 and "污染源头" or "重度污染") or "轻度污染"
      local str = string.format("请先解锁 %s%s", hard, MainBattleCsv[key1].name)
      if key2 ~= 0 then
        str = str .. string.format(" 并净化 %s", BattleCsv[key2].name)
      end
      MFlashMsg:show({text = str})
      return
    end
    if not self.enough and self.battleInfo.carbonId ~= self.selectId then
      SysError(SYS_ERR_CAEBON_HAPPY_SOURCE_NOT_ENOUGH)
      return
    end
    game:enterScene("ParadiseScene", {
      carbonId = self.selectId
    })
  end)
  self:refreshLeftCount()
end

function CarbonHappyDetailLayer:showData(params)
  self.sortData = {}
  for _, data in pairs(BattleCsv) do
    if data.type == self.diffType then
      local temp = clone(data)
      temp.status = self:checkStatus(data.prepose)
      table.insert(self.sortData, temp)
    end
  end
  table.sort(self.sortData, function(a, b)
    return a.id < b.id
  end)
  self:showCells()
end

function CarbonHappyDetailLayer:showCells()
  self.listView:removeAllChildren()
  self.selectId = self.selectId or self.sortData[1].id
  local selected = 1
  local size = display.newSprite(HappyRes .. "cell_normal_1.png"):getContentSize()
  local delay = 0.3
  for index, data in ipairs(self.sortData) do
    local viewNode = ccui.Widget:create()
    viewNode:setContentSize(size.width + 4, size.height + 8):addTo(self.listView)
    local state = data.id == self.selectId and "select" or "normal"
    local cell = UIHelper.newImageView(HappyRes .. string.format("cell_%s_%d.png", state, self.diffType)):center(viewNode):addTo(viewNode)
    display.newSprite(HappyRes .. string.format("circle_image_%d.png", data.icon)):pos(58, 60):addTo(cell)
    display.newSprite(HappyRes .. string.format("circle_type_%d.png", data.type)):pos(58, 60):addTo(cell)
    display.newTTFLabel({
      text = data.name,
      size = 36,
      color = display.COLOR_WHITE
    }):enableOutline(UIHelper.hex2rgb("#000000"), 1):anch(0, 0):pos(170, 48):addTo(cell)
    local tipLabel = display.newTTFLabel({
      text = "推荐美味度:" .. data.enterPower,
      size = 20,
      color = display.COLOR_WHITE
    }):enableOutline(UIHelper.hex2rgb("#000000"), 1):anch(0, 0):pos(380, 17):addTo(cell)
    UIHelper.setMaxWidth(tipLabel, 155)
    if not data.status then
      display.newSprite(HappyRes .. "lock.png"):pos(58, 60):addTo(cell)
    end
    cell:setCallback(function()
      selected = index
      self:showCarbonDetail(data, cell)
    end)
    if data.id == self.selectId then
      if self.battleInfo.carbonId then
        local battleBg = display.newSprite("ui/carbon/detail/status_bg.png"):anch(0, 0):pos(223, 3):addTo(cell)
        display.newTTFLabel({text = "战斗中", size = 30}):pos(142, 22):addTo(battleBg)
      end
      selected = index
      self:showCarbonDetail(data, cell)
    end
    UIHelper.MoveToRight({
      node = cell,
      delay = delay,
      time = 0.2
    })
    delay = delay + 0.06
  end
  self.listView:doLayout()
  self.listView:runAction(transition.sequence({
    cc.DelayTime:create(0.1),
    cc.CallFunc:create(function()
      self.listView:scrollToItem(selected - 1, cc.p(0, 0.5), cc.p(0, 0))
    end)
  }))
end

function CarbonHappyDetailLayer:showCarbonDetail(data, cell)
  if self.selectCell then
    self.selectCell:setImage(HappyRes .. string.format("cell_normal_%d.png", self.diffType))
  end
  cell:setImage(HappyRes .. string.format("cell_select_%d.png", self.diffType))
  self.selectId = data.id
  self.selectCell = cell
  self.itemNode:removeAllChildren()
  self.node:removeAllChildren()
  display.newTTFLabel({
    text = "战斗经验:" .. data.Exp2see,
    size = 24,
    color = UIHelper.hex2rgb("#ffe200")
  }):anch(0, 0.5):pos(-40, 65):addTo(self.itemNode)
  local limits = {}
  for _, itemId in pairs(data.special2see:toArray("=", true)) do
    limits[itemId] = true
  end
  local xPos, yPos, interval = 0, 0, 95
  for index, itemId in ipairs(data.gift2see:toArray("=", true)) do
    local icon = ItemIcon.new({type = itemId, showTip = true}):scale(0.85):pos(xPos, yPos):addTo(self.itemNode)
    if limits[itemId] then
      display.newSprite("ui/carbon/detail/limit.png"):pos(73, 73):addTo(icon)
    end
    xPos = xPos + interval
    if index == 5 then
      xPos = 0
      yPos = yPos - 85
    end
  end
  self.enough = true
  xPos, yPos, interval = 20, 0, 95
  for _, set in ipairs(data.cost:toTableArray()) do
    local bg = display.newSprite(HappyRes .. "cost_bg.png"):pos(xPos, yPos):addTo(self.node)
    bg:setCascadeOpacityEnabled(true)
    display.newSprite(string.format("ui/global/base_%s.png", set[1])):pos(2, 15):addTo(bg)
    display.newTTFLabel({
      text = set[2],
      size = 24
    }):pos(35, 16):addTo(bg)
    if game.role["material" .. set[1]] < tonumber(set[2]) then
      self.enough = false
    end
    xPos = xPos + interval
  end
end

function CarbonHappyDetailLayer:refreshLeftCount()
  local open, count = self:getOpen()
  if not open then
    self.count:setString("今日剩余次数: 0")
    return
  end
  local left = count - game.role.paradiseBattleCount:getv(self.diffType, 0)
  self.count:setString("今日剩余次数: " .. left)
end

function CarbonHappyDetailLayer:getOpen()
  local limit = self.diffType == 1 and globalCsv.ExpLeyuanOpentime or globalCsv.CuisineLeyuanOpentime
  local date = CommonHelper.date(nil, nil, true)
  date.wday = date.wday - 1
  if date.wday == 0 then
    date.wday = 7
  end
  for wday, count in pairs(limit:toNumMap()) do
    if wday == date.wday then
      return true, count
    end
  end
  return false
end

function CarbonHappyDetailLayer:checkStatus(limit)
  local open = true
  local key1, key2 = limit:match("(%d+)=(%d+)")
  local limit1, limit2 = tonumber(key1), tonumber(key2)
  if not game.role.carbons[limit1] then
    open = false
  end
  if limit2 ~= 0 and 0 > game.role.paradiseBattlePass:getv(limit2, -1) then
    open = false
  end
  return open, limit1, limit2
end

return CarbonHappyDetailLayer
