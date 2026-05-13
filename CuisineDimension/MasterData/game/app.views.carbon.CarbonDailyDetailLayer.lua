local DailyBattleCsv = require("csvdata.mijing_battle")
local DailyRes = "ui/carbon/daily/"
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
local CarbonDailyDetailLayer = class("CarbonDailyDetailLayer", UIBase)

function CarbonDailyDetailLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function CarbonDailyDetailLayer:init(params)
  TopBar:show(TopBarType.full, "战斗")
  game:playMusic(3)
  TopBar:showAnimation(true)
  self.enough = true
  self.indexType = params.indexType
  self.selectId = params.selectId or 1
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
  self.count:hide()
  self.btnMode:setImage(DailyRes .. "btn_mode_image.png")
  display.newTTFLabel({text = "出发", size = 38}):enableOutline(UIHelper.hex2rgb("#641f08"), 2):pos(150, 34):addTo(self.btnBattle)
  display.newTTFLabel({
    text = "限时副本",
    size = 36
  }):anch(0, 0.5):pos(40, 31):addTo(self.btnMode)
  if self.indexType < 4 then
    local btnInfo = UIHelper.extend(ccui.Button:create())
    btnInfo:setImages("ui/pvp/main/", {
      "btn_rule.png",
      "btn_rule.png"
    })
    btnInfo:pos(522, 30):addTo(self.btnMode)
    btnInfo:setTouchScale()
    btnInfo:setCallback(function()
      game:createView("global.RuleLayer", {
        res = DailyRes .. string.format("rule_%d.png", self.indexType)
      })
    end)
  end
  if UIHelper.isiPhoneX() then
    UIHelper.fitForiPhoneX(self.mainBg)
  end
  self.btnBattle:setTouchScale()
  self.btnBattle:setCallback(function()
    local open, count = self:getOpen()
    if not open then
      SysError(SYS_ERR_CAEBON_BOSS_NOT_OPEN)
      return
    end
    if self.indexType == 4 then
      local battleInfo = json.decode(game.role.bossCarbonInfo) or {}
      battleInfo.status = battleInfo.status or ""
      if count <= battleInfo.status:getv(self.indexType, 0) then
        SysError(SYS_ERR_CAEBON_BOSS_COUNT_USE_OUT)
        return
      end
    end
    if not self.enough then
      SysError(SYS_ERR_CAEBON_HAPPY_SOURCE_NOT_ENOUGH)
      return
    end
    local layer = game:createView("hero.BattleListLayer", {
      battleType = BattleType.MJ,
      battle = "召唤",
      callback = function(choose)
        local format = game.role.formation[tostring(choose)]
        if not format then
          return
        end
        local state = game.role:getFormationState(choose)
        if state[1] then
          SysError(SYS_ERR_HERO_LOCKED_CURE_FIGHT)
          return
        end
        game:sendData(actionCodes.Carbon_bossBeginGameRpc, MsgPack.pack({
          bossType = self.indexType,
          bossDegree = self.selectId
        }))
        UIHelper.showWaiting()
        game:addResponseHandler(actionCodes.Carbon_bossBeginGameRpc, function(event)
          UIHelper.removeWaiting()
          game:enterScene("BattleScene", {
            type = BattleType.MJ,
            bossType = self.indexType,
            bossDegree = self.selectId,
            format = choose,
            leftInfo = game.role:getMJAttrs(choose)
          })
        end)
        return true
      end
    })
    BackManager:push(function()
      layer:close()
      TopBar:show(TopBarType.full, "战斗")
    end)
  end)
  self:refreshLeftCount()
end

function CarbonDailyDetailLayer:showData(params)
  self.sortData = {}
  self.sortData = DailyBattleCsv[self.indexType]
  self:showCells()
end

function CarbonDailyDetailLayer:showCells()
  self.listView:removeAllChildren()
  self.selectId = self.selectId or self.sortData[1].degree
  local size = display.newSprite(DailyRes .. "cell_normal.png"):getContentSize()
  local delay = 0.3
  for index, data in ipairs(self.sortData) do
    local viewNode = ccui.Widget:create()
    viewNode:setContentSize(size.width + 4, size.height + 8):addTo(self.listView)
    local state = data.degree == self.selectId and "select" or "normal"
    local cell = UIHelper.newImageView(DailyRes .. string.format("cell_%s.png", state)):center(viewNode):addTo(viewNode)
    display.newSprite(DailyRes .. string.format("circle_image_%d.png", self.indexType)):pos(58, 60):addTo(cell)
    display.newSprite(DailyRes .. "title_circle.png"):pos(58, 60):addTo(cell)
    display.newTTFLabel({
      text = data.name,
      size = 36,
      color = display.COLOR_WHITE
    }):enableOutline(UIHelper.hex2rgb("#000000"), 1):anch(0, 0):pos(170, 48):addTo(cell)
    display.newTTFLabel({
      text = "推荐美味度:" .. data.enterPower,
      size = 20,
      color = display.COLOR_WHITE
    }):enableOutline(UIHelper.hex2rgb("#000000"), 1):anch(0, 0):pos(380, 17):addTo(cell)
    cell:setCallback(function()
      self:showCarbonDetail(data, cell)
    end)
    if data.degree == self.selectId then
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
      self.listView:scrollToItem(self.selectId - 1, cc.p(0, 0.5), cc.p(0, 0))
    end)
  }))
end

function CarbonDailyDetailLayer:showCarbonDetail(data, cell)
  if self.selectCell then
    self.selectCell:setImage(DailyRes .. "cell_normal.png")
  end
  cell:setImage(DailyRes .. "cell_select.png")
  self.selectId = data.degree
  self.selectCell = cell
  self.itemNode:removeAllChildren()
  self.node:removeAllChildren()
  local giftStr = data.gift2see
  if self.indexType ~= 4 then
    local open, count = self:getOpen()
    local battleInfo = json.decode(game.role.bossCarbonInfo) or {}
    if count <= (battleInfo.status or ""):getv(self.indexType, 0) then
      giftStr = data.gift2see2
    end
  end
  local xPos, yPos, interval = 0, 0, 95
  for index, itemId in ipairs(giftStr:toArray("=", true)) do
    local icon = ItemIcon.new({type = itemId, showTip = true}):scale(0.85):pos(xPos, yPos):addTo(self.itemNode)
    xPos = xPos + interval
    if index == 5 then
      xPos = 0
      yPos = yPos - 85
    end
  end
  xPos, yPos, interval = 20, 0, 95
  for _, set in ipairs(data.cost:toTableArray()) do
    local bg = display.newSprite("ui/carbon/happy/cost_bg.png"):pos(xPos, yPos):addTo(self.node)
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

function CarbonDailyDetailLayer:refreshLeftCount()
  self.countBg:removeAllChildren()
  if self.indexType == 4 then
    display.newSprite("ui/carbon/happy/btn_add.png"):pos(185, 18):addTo(self.countBg)
    self.countBg:setCallback(function()
      local layer = game:createView("carbon.CarbonBuyHappyCountLayer", {
        costId = 190,
        callback = function()
          self:refreshLeftCount()
        end
      })
      BackManager:push(function()
        layer:close()
      end)
    end)
  end
  local open, count = self:getOpen()
  local str = self.indexType == 4 and "本周剩余次数:" or "特殊奖励掉落剩余:"
  if not open then
    display.newTTFLabel({
      text = str .. 0,
      size = 18,
      color = UIHelper.hex2rgb("#F0B259")
    }):anch(0, 0.5):pos(22, 20):addTo(self.countBg)
    return
  end
  local battleInfo = json.decode(game.role.bossCarbonInfo) or {}
  battleInfo.status = battleInfo.status or ""
  display.newTTFLabel({
    text = str .. math.max(0, count - battleInfo.status:getv(self.indexType, 0)),
    size = 18,
    color = UIHelper.hex2rgb("#F0B259")
  }):anch(0, 0.5):pos(18, 20):addTo(self.countBg)
end

function CarbonDailyDetailLayer:getOpen()
  if self.indexType == 4 then
    return true, globalCsv.ManTouRefresh
  end
  local limit = globalCsv["bosscarbonOpentime" .. self.indexType]
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

return CarbonDailyDetailLayer
