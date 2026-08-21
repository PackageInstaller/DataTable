local BattleCsv = require("csvdata.sauce_battle")
local CarbonRes = "ui/sauce/carbon/"
local uiData = {
  csbFile = "ui/sauce/SauceCarbonLayer.csb",
  mask = true,
  widgets = {
    mainBg = "mainBg",
    up = "up",
    detailBg = "detailBg",
    btnMode = "detailBg/btnMode",
    node1 = "detailBg/node1",
    node2 = "detailBg/node2",
    countBg = "countBg",
    listBg = "listBg",
    list = "listBg/list",
    btnBattle = "btnBattle",
    btnInfo = "btnInfo",
    btnRank = "btnRank",
    btnUp = "btnUp",
    btnShop = "btnShop"
  }
}
local SauceCarbonLayer = class("SauceCarbonLayer", UIBase)

function SauceCarbonLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function SauceCarbonLayer:init(params)
  TopBar:show(TopBarType.full, "深渊探索")
  TopBar:showAnimation(true)
  if UIHelper.isiPhoneX() then
    UIHelper.fitForiPhoneX(self.mainBg, true)
    self.btnInfo:setPositionX(self.btnInfo:getPositionX() - 75)
    self.btnRank:setPositionX(self.btnRank:getPositionX() - 75)
    self.btnUp:setPositionX(self.btnUp:getPositionX() - 75)
    self.btnShop:setPositionX(self.btnShop:getPositionX() - 75)
    self.btnBattle:setPositionX(self.btnBattle:getPositionX() + 20)
  end
  UIHelper.MoveToDown({
    node = self.up
  })
  UIHelper.MoveToUp({
    node = self.countBg,
    delay = 0.4,
    time = 0.3
  })
  UIHelper.MoveToUp({
    node = self.btnBattle,
    delay = 0.4,
    time = 0.3
  })
  UIHelper.MoveToLeft({
    node = self.detailBg,
    delay = 0.4,
    time = 0.3,
    pos = {630, 0}
  })
  UIHelper.MoveToRight({
    node = self.listBg,
    delay = 0.4,
    time = 0.3,
    pos = {600, 0}
  })
  UIHelper.MoveToRight({
    node = self.btnInfo,
    delay = 0.4,
    time = 0.3
  })
  UIHelper.MoveToRight({
    node = self.btnRank,
    delay = 0.4,
    time = 0.3
  })
  UIHelper.MoveToRight({
    node = self.btnUp,
    delay = 0.4,
    time = 0.3
  })
  UIHelper.MoveToRight({
    node = self.btnShop,
    delay = 0.4,
    time = 0.3
  })
  self.btnBattle:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#641f08"), 2)
  self.sauceBossInfo = json.decode(game.role.sauceBossInfo or "[]")
  self.curId = game.role.sauceCarbon or 1
  for _, btnName in pairs({
    "btnBattle",
    "btnInfo",
    "btnRank",
    "btnUp",
    "btnShop"
  }) do
    self[btnName]:setTouchScale()
  end
  self.btnInfo:setCallback(function()
    game:createView("global.RuleLayer", {
      res = CarbonRes .. "image_rule.png"
    })
  end)
  self.btnRank:setCallback(function()
    local rankList = {}
    NetManager:sendData(actionCodes.Sauce_getBossRankRpc, MsgPack.pack({}))
    UIHelper.showWaiting()
    NetManager:addResponseHandler(actionCodes.Sauce_getBossRankRpc, function(event)
      UIHelper.removeWaiting()
      local result = MsgPack.unpack(event.data)
      if not result.finish then
        for _, data in pairs(result.list) do
          table.insert(rankList, data)
        end
      else
        for _, data in pairs(result.list) do
          table.insert(rankList, data)
        end
        NetManager:removeResponseHandler(actionCodes.Sauce_getBossRankRpc)
        game:createView("sauce.SauceRankLayer", {rankList = rankList})
      end
    end, true)
  end)
  self.btnBattle:setCallback(function()
    if self.sauceBossInfo.times < 1 then
      SysError(SYS_ERR_SAUCE_CARBON_COUNT_USE_OUT)
      return
    end
    local layer = game:createView("hero.BattleListLayer", {
      battleType = BattleType.MJ,
      battle = "召唤",
      specialHero = game.role:getBuffHero().heros,
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
        game:sendData(actionCodes.Sauce_bossBeginGameRpc, MsgPack.pack({
          bossId = self.curId
        }))
        UIHelper.showWaiting()
        game:addResponseHandler(actionCodes.Sauce_bossBeginGameRpc, function(event)
          UIHelper.removeWaiting()
          game.role.sauceCarbon = self.curId
          game:enterScene("BattleScene", {
            type = BattleType.Sauce,
            bossId = self.curId,
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
      TopBar:show(TopBarType.full, "深渊探索")
    end)
  end)
  self.countBg:setCallback(function()
    if self.sauceBossInfo.buyCount >= #globalCsv.sauceExtraCost then
      SysError(SYS_ERR_SAUCE_CARBON_BUY_MAX)
      return
    end
    local layer = game:createView("sauce.SauceCarbonBuyCountLayer", {
      buy = self.sauceBossInfo.buyCount,
      callback = function()
        self.sauceBossInfo = json.decode(game.role.sauceBossInfo or "[]")
        self:upDateTimes()
      end
    })
    BackManager:push(function()
      layer:close()
    end)
  end)
  self.btnUp:setCallback(function()
    local cx, cy, width, height = display.cx, display.cy, display.width, display.height
    if UIHelper.isiPhoneX() then
      local movex = UIHelper.getMoveXForX(true)
      cx, cy, width = cx + movex, cy, width + movex * 2
    end
    local mask = UIHelper.newMask({
      size = cc.size(width, height),
      color = "#000000",
      opacity = 110
    })
    mask:anch(0.5, 0.5):pos(cx, cy):addTo(display.getRunningScene(), 100)
    local bg = display.newSprite("ui/global/dialog_bg.png"):center(mask):addTo(mask)
    display.newTTFLabel({
      text = "本周UP食灵",
      size = 22
    }):pos(175, 273):addTo(bg)
    if DEBUG > 0 then
      display.newTTFLabel({
        text = "第" .. game.role:getBuffHero().id .. "周",
        size = 22,
        color = UIHelper.hex2rgb("#0000ff")
      }):pos(425, 260):addTo(bg)
    end
    local result = game.role:getBuffHero()
    local xPos, yPos = 135, 185
    local index = 1
    for heroType, _ in pairs(result.heros) do
      ItemIcon.new({
        type = ItemStartId.hero + heroType,
        showTip = true
      }):pos(xPos, yPos):addTo(bg)
      index = index + 1
      xPos = xPos + 100
      if index == 6 then
        xPos = 135
        yPos = yPos - 100
      end
    end
    mask:setTouchEnabled(true)
    mask:setCallback(function()
      mask:removeSelf()
    end)
  end)
  self.btnShop:setCallback(function()
    local layer = game:createView("shop.ShopLayer", {curType = 2, selected = 2})
    BackManager:push(function()
      TopBar:show(TopBarType.full, "深渊探索")
      layer:close()
    end)
  end)
  self:upDateTimes()
end

function SauceCarbonLayer:showData(params)
  local special = self.sauceBossInfo.special or {}
  local rows = math.ceil(#BattleCsv[1] / 2)
  local Height = rows * 194
  local viewNode = ccui.Widget:create()
  viewNode:setContentSize(cc.size(444, Height)):addTo(self.list)
  self.list:forceDoLayout()
  for row = 1, rows do
    display.newSprite(CarbonRes .. "cell.png"):pos(222, 97 + (row - 1) * 194):addTo(viewNode)
  end
  local selectRow = 1
  for row = 1, rows do
    for col = 1, 2 do
      local data = BattleCsv[1][(row - 1) * 2 + col]
      if not data then
        break
      end
      local temp = special.cur == data.id and BattleCsv[special.to][special.cur] or data
      local btn = UIHelper.newImageView(CarbonRes .. "btn_normal.png"):pos(col == 1 and 355 or 77, col == 1 and Height - 85 or Height - 155):addTo(viewNode)
      btn:setCallback(function()
        self:showDetail(temp, btn, data.enterPower)
      end)
      display.newTTFLabel({
        text = string.format("第%s层", data.id),
        size = 18
      }):enableOutline(UIHelper.hex2rgb("#15323c"), 1):center(btn):addTo(btn)
      if data.id == self.curId then
        selectRow = row
        self:showDetail(temp, btn, data.enterPower)
      end
      if special.cur == data.id then
        local light = UIHelper.createSpineNodeByRes(CarbonRes .. "fg")
        light:center(btn):addTo(btn)
        light:setAnimation(0, "special", true)
      end
    end
    Height = Height - 194
  end
  selectRow = selectRow > rows - 2 and rows - 2 + 0.35 or selectRow
  self.list:setInnerContainerPosition({
    x = 0,
    y = (selectRow - rows + 1) * 194 + 126
  })
end

function SauceCarbonLayer:showDetail(data, btn, power)
  if self.lastBtn == btn then
    return
  end
  self.btnMode:removeAllChildren()
  self.node1:removeAllChildren()
  self.node2:removeAllChildren()
  if self.lastBtn then
    self.lastBtn:setImage(CarbonRes .. "btn_normal.png")
  end
  btn:setImage(CarbonRes .. "btn_select.png")
  self.lastBtn = btn
  self.curId = data.id
  local mapData = require(data.scene)
  for idx, temp in ipairs(mapData[1]) do
    MonsterHead.new({
      type = ItemStartId.monster + temp.unitType,
      showTip = true
    }):scale(0.9):pos((idx - 1) * 95, 0):addTo(self.node1)
  end
  for idx, Type in ipairs(data.gift2see:toArray("=", true)) do
    ItemIcon.new({type = Type, showTip = true}):scale(0.9):pos((idx - 1) * 95, 0):addTo(self.node2)
  end
  display.newTTFLabel({
    text = data.name,
    size = 32
  }):anch(0, 0.5):pos(28, 29):addTo(self.btnMode)
  display.newTTFLabel({
    text = string.format("推荐战力:%s", power),
    size = 26
  }):anch(1, 0.5):pos(518, 29):addTo(self.btnMode)
end

function SauceCarbonLayer:upDateTimes()
  self.countBg:removeAllChildren()
  display.newTTFLabel({
    text = string.format("今日剩余次数:%d", self.sauceBossInfo.times),
    size = 18,
    color = UIHelper.hex2rgb("#F0B259")
  }):anch(0, 0.5):pos(22, 20):addTo(self.countBg)
  display.newSprite("ui/carbon/happy/btn_add.png"):pos(185, 18):addTo(self.countBg)
end

return SauceCarbonLayer
