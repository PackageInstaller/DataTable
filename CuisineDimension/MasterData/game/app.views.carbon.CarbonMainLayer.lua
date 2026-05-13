local ChapterInfoCsv = require("csvdata.chapter_info")
local ChapterBattleCsv = require("csvdata.chapter_battle")
local HappyBattleCsv = require("csvdata.leyuan_battle")
local DailyBattleCsv = require("csvdata.mijing_battle")
local EijiBattleCsv = require("csvdata.awaken_battle")
local ShenYuanBattleCsv = require("csvdata.shenyuan_battle")
local BossCsv = require("csvdata.ghost")
local MainRes = "ui/carbon/main/"
local HappyRes = "ui/carbon/happy/"
local DailyRes = "ui/carbon/daily/"
local EijiRes = "ui/carbon/eiji/"
local ShenYuanRes = "ui/carbon/shenyuan/"
local MapRes = "map/"
local PvpRes = "ui/pvp/main/"
local StoryCsv = require("csvdata.storybook")
local uiData = {
  csbFile = "ui/carbon/CarbonMainLayer.csb",
  mask = true,
  widgets = {
    up = "up",
    mapBg = "mapBg",
    line = "line",
    content = "content",
    btnsBg = "btnsBg",
    btnList = "btnsBg/btnList",
    btnTask = "btnTask",
    btnTravel = "btnTravel",
    btnTower = "btnTower",
    btnSauce = "btnSauce",
    btnHunDun = "btnHunDun",
    cloud1 = "cloud1",
    cloud2 = "cloud2",
    boss_back = "boss_back",
    bossBg = "boss_bg",
    bossMids = "boss_bg/boss_mid",
    bossCenter = "boss_bg/boss_center"
  }
}
local btnDatas = {
  [1] = {
    name = "主线",
    battleInfo = "battleInfo",
    func = function(self)
      self:showMainCarbon()
    end
  },
  [2] = {
    name = "乐园",
    battleInfo = "paradiseBattleInfo",
    func = function(self)
      self:showHappyCarbon()
    end
  },
  [3] = {
    name = "秘境",
    battleInfo = "",
    func = function(self)
      self:showDailyCarbon()
    end
  },
  [4] = {
    name = "异界",
    battleInfo = "",
    func = function(self)
      self:showEijiCarbon()
    end
  },
  [5] = {
    name = "深渊",
    battleInfo = "",
    func = function(self)
      self:showShenYuanCarbon()
    end
  }
}
local CarbonMainLayer = class("CarbonMainLayer", UIBase)

function CarbonMainLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

MAIN_MAP_NUM = 6
EXTRA_MAP_NUM = 5
MAP_INTERVAL = 350
local btns = {
  "btnHunDun",
  "btnSauce",
  "btnTask",
  "btnTower",
  "btnTravel"
}

function CarbonMainLayer:init(params)
  params = params or {}
  game:playMusic(3)
  self.btnsBg:setTouchEnabled(true)
  self.btnsBg:setSwallowTouches(true)
  TopBar:showAnimation(true)
  self.content:setCascadeOpacityEnabled(true)
  UIHelper.MoveToDown({
    node = self.up
  })
  local movex = 255
  local moveTime = 30
  if UIHelper.isiPhoneX() then
    UIHelper.fitForiPhoneX(self.mapBg)
    UIHelper.fitForiPhoneX(self.line)
    UIHelper.fitForiPhoneX(self.up, true)
    self.bossBg:setPositionX(self.bossBg:getPositionX() - UIHelper.getMoveXForX())
    self.btnTask:setPositionX(self.btnTask:getPositionX() + UIHelper.getMoveXForX())
    self.btnTravel:setPositionX(self.btnTravel:getPositionX() + UIHelper.getMoveXForX())
    self.btnTower:setPositionX(self.btnTower:getPositionX() + UIHelper.getMoveXForX())
    self.btnSauce:setPositionX(self.btnSauce:getPositionX() + UIHelper.getMoveXForX())
    self.cloud1:setPositionX(self.cloud1:getPositionX() - UIHelper.getMoveXForX())
    self.cloud2:setPositionX(self.cloud2:getPositionX() + UIHelper.getMoveXForX())
    movex = 255 - UIHelper.getMoveXForX() * 2
    moveTime = 1
  end
  self.cloud1:runAction(cc.RepeatForever:create(transition.sequence({
    cc.MoveBy:create(moveTime, cc.p(-movex, 0)),
    cc.MoveBy:create(moveTime, cc.p(movex, 0))
  })))
  self.cloud2:runAction(cc.RepeatForever:create(transition.sequence({
    cc.MoveBy:create(moveTime, cc.p(movex, 0)),
    cc.MoveBy:create(moveTime, cc.p(-movex, 0))
  })))
  self.bossMids:setLocalZOrder(-1)
  self.bossMid = display.newProgressTimer(MainRes .. "boss_mid.png", display.PROGRESS_TIMER_RADIAL):center(self.bossMids):addTo(self.bossMids)
  self.bossMid:setType(display.PROGRESS_TIMER_RADIAL)
  self.bossMid:setScaleX(1)
  self.bossMid:setRotation(-90)
  self.boss_back:setLocalZOrder(-2)
  self.autoBattleId = game.role:getAutoBattleId()
  self.carbonType = params.carbonType or 1
  self.curMap = 0
  self:initCarbonTypeBtns()
  self:initBottomBtns()
  local effect = UIHelper.createCommonSpine({
    res = MainRes .. "map01_luixing"
  })
  effect:setAnimation(0, "special", true)
  effect:pos(display.width / 2, 0):addTo(self.line)
  effect:runAction(cc.RepeatForever:create(transition.sequence({
    cc.Show:create(),
    cc.DelayTime:create(5),
    cc.Hide:create(),
    cc.DelayTime:create(25)
  })))
  local mask = UIHelper.newMask({
    size = cc.size(display.width, display.height),
    opacity = 0
  })
  mask:anch(0.5, 0.5):pos(display.width / 2, display.height / 2):addTo(display.getRunningScene(), 100)
  mask:setTouchEnabled(true)
  mask:runAction(transition.sequence({
    cc.DelayTime:create(1),
    cc.RemoveSelf:create()
  }))
  self.lastTime = game:nowTime() - 2
  local touchEvent = {
    [ccui.TouchEventType.began] = handler(self, self.onTouchBegan),
    [ccui.TouchEventType.moved] = handler(self, self.onTouchMoved),
    [ccui.TouchEventType.ended] = handler(self, self.onTouchEnded),
    [ccui.TouchEventType.canceled] = handler(self, self.onTouchCancelled)
  }
  self.content:addTouchEventListener(function(sender, type)
    touchEvent[type](sender)
  end)
end

function CarbonMainLayer:initCarbonTypeBtns()
  local group = MRadioGroup:create()
  local size = display.newSprite(MainRes .. "btn_a.png"):getContentSize()
  for index, data in ipairs(btnDatas) do
    local viewNode = ccui.Widget:create()
    viewNode:setContentSize(size.width + 8, size.height + 6):addTo(self.btnList)
    local btn = UIHelper.extend(ccui.Button:create())
    btn:setImages(MainRes, {"btn_a.png", "btn_b.png"})
    btn:center(viewNode):addTo(viewNode):name("btn" .. index)
    btn:setGroup(group)
    btn:setCallback(function()
      self.carbonType = index
      data.func(self)
    end)
    if data.battleInfo ~= "" then
      local info = json.decode(game.role[data.battleInfo]) or {}
      if next(info) or self.autoBattleId and index == 1 then
        display.newSprite("ui/autumn/main/battle.png"):scale(0.75):pos(85, 50):addTo(btn)
      end
    end
    display.newTTFLabel({
      text = data.name,
      size = 20
    }):enableOutline(UIHelper.hex2rgb("#630c07"), 1):pos(50, 30):addTo(btn)
  end
  group:chooseByName("btn" .. self.carbonType)
  if self.carbonType == 1 then
    local battleInfo = json.decode(game.role.battleInfo)
    self.curMap = battleInfo.carbonId and math.floor(battleInfo.carbonId / 100) or math.floor((self.autoBattleId or 0) / 100)
    if self.curMap > 200 then
      self.curMap = self.curMap - 100
    end
    if self.curMap == 0 then
      for chapterId, data in pairs(game.role.carbons) do
        local mapId = math.floor(tonumber(chapterId) / 100)
        if mapId > self.curMap and mapId < 300 then
          self.curMap = mapId
        end
      end
    end
    self:showMainCarbon()
  elseif self.carbonType == 2 then
    self:showHappyCarbon()
  elseif self.carbonType == 3 then
    self:showDailyCarbon()
  elseif self.carbonType == 4 then
    self:showEijiCarbon()
  elseif self.carbonType == 5 then
    self:showShenYuanCarbon()
  end
end

function CarbonMainLayer:initBottomBtns()
  local delay = 0.5
  for index, btnName in ipairs(btns) do
    local btn = self[btnName]
    UIHelper.MoveToUp({
      node = btn,
      delay = delay,
      time = 0.2
    })
    delay = delay + 0.06
    btn:setTouchScale(true)
    btn:setCallback(function()
      if index == 2 and not CommonHelper.funcOpen("sauce") then
        SysError(SYS_ERR_FUNCOPEN_SAUCE_CARBON)
        return
      end
      if index == 4 and not CommonHelper.funcOpen("tower") then
        SysError(SYS_ERR_FUNCOPEN_TOWER)
        return
      end
      if index == 5 and not CommonHelper.funcOpen("pvp") then
        SysError(SYS_ERR_FUNCOPEN_PVP)
        return
      end
      self:showUI(index)
    end)
  end
  self.btnTask:setMusicId(1007)
  self.btnTravel:setMusicId(1008)
  self.btnTower:setMusicId(1031)
end

function CarbonMainLayer:showData(params)
  params = params or {}
  self.isAuto = params.isAuto
  params.selected = params.selected and params.selected + 1 or 0
  if params.selected == 6 then
    params.selected = 1
  end
  if params.selected then
    scheduler.performWithDelayGlobal(function()
      self:showUI(params.selected)
    end, 0.016666666666666666)
  else
    self:showUI(params.selected or 0)
  end
  if self.carbonType == 1 and params.carbonId then
    self:hide()
    local mapId = math.floor(params.carbonId / 100)
    scheduler.performWithDelayGlobal(function()
      self:showMainCarbonDetail(mapId)
    end, 0.016666666666666666)
  elseif self.carbonType == 2 and params.carbonId then
    self:hide()
    self:showBoss()
    scheduler.performWithDelayGlobal(function()
      self:showHappyCarbonDetail(HappyBattleCsv[params.carbonId].type)
    end, 0.016666666666666666)
  elseif self.carbonType == 3 and params.bossType then
    self:hide()
    self:showBoss()
    scheduler.performWithDelayGlobal(function()
      self:showDailyCarbonDetail(params.bossType, params.bossDegree)
    end, 0.016666666666666666)
  elseif self.carbonType == 4 and params.bossType then
    self:hide()
    self:showBoss()
    scheduler.performWithDelayGlobal(function()
      self:showEijiCarbonDetail(params.bossType, params.bossDegree)
    end, 0.016666666666666666)
  elseif self.carbonType == 5 and params.bossType then
    self:hide()
    self:showBoss()
    scheduler.performWithDelayGlobal(function()
      self:showShenYuanCarbonDetail(params.bossType, params.bossDegree)
    end, 0.016666666666666666)
  end
end

function CarbonMainLayer:showUI(index)
  self:showTopbar()
  if index == 3 then
    self:showTaskLayer()
  elseif index == 4 then
    self:showTower()
  elseif index == 5 then
    self:showExplore()
  elseif index == 2 then
    self:showSauce()
  elseif index == 1 then
    self:showHunDun()
  end
end

function CarbonMainLayer:showMainCarbon()
  self.mapBg:removeAllChildren()
  self.content:removeAllChildren()
  self.mapNode = display.newNode():addTo(self.content)
  local battleInfo = json.decode(game.role.battleInfo)
  local tempId = math.floor((battleInfo.carbonId or 0) / 100)
  local extraBattle = json.decode(game.role.extraBattle)
  local autoId = math.floor((self.autoBattleId or 0) / 100)
  local xPos, interval = 230, 350
  for chapterId = 101, 100 + MAIN_MAP_NUM + EXTRA_MAP_NUM do
    local chapterSet = ChapterInfoCsv[chapterId]
    local index = chapterId - 100
    local content = UIHelper.newImageView(MapRes .. string.format("bg_%d.png", chapterId)):pos(xPos, display.height / 2):addTo(self.mapNode):name("chapter" .. chapterId)
    xPos = xPos + interval
    local size = content:getContentSize()
    local map = game.role.maps[chapterId]
    if not map or chapterSet.open == 0 then
      content:setColor(cc.c3b(140, 140, 140))
    end
    local nameBg = UIHelper.newImageView(MainRes .. "name_bg.png"):pos(size.width / 2, 105):addTo(content)
    local nameSize = nameBg:getContentSize()
    UIHelper.newImageView(MapRes .. string.format("name_%d.png", chapterId)):pos(nameSize.width / 2, 23):addTo(nameBg)
    if map then
      local starBg = UIHelper.newImageView(MainRes .. "star_bg.png"):anch(0.5, 1):pos(nameSize.width / 2, 0):addTo(nameBg, -1)
      UIHelper.newImageView(MainRes .. "cake.png"):pos(30, 9):addTo(starBg)
      local cur, total = self:getMapStar(chapterId)
      UIHelper.newText({
        text = string.format("%d/%d", cur, total),
        size = 18,
        color = UIHelper.hex2rgb("db9b4f")
      }):pos(65, 9):addTo(starBg)
    else
      UIHelper.newImageView(MainRes .. "chapter_lock.png"):pos(0, 23):addTo(nameBg)
    end
    if extraBattle.carbonId then
      local extraId = math.floor(extraBattle.carbonId / 100)
      if extraId == chapterId or extraId == chapterId + 100 then
        local bg = UIHelper.newImageView(MainRes .. "boss_table.png"):pos(nameSize.width / 2 - 5, 78):addTo(nameBg)
        local bossData = BossCsv[extraBattle.bossId]
        display.newTTFLabel({
          text = bossData.name,
          size = 18,
          color = UIHelper.hex2rgb("#5dff51")
        }):enableOutline(UIHelper.hex2rgb("#000000"), 1):pos(bg:getContentSize().width / 2 + 10, bg:getContentSize().height / 2 + 2):addTo(bg)
      end
    end
    content:setCallback(function()
      local beginPos = content:getBeginPos()
      local endPos = content:getEndPos()
      if math.abs(beginPos.x - endPos.x) > 20 then
        return
      end
      if chapterSet.open == 0 then
        SysError(SYS_ERR_CARBON_VERSION_NOT_OPEN)
        return
      elseif not map then
        SysError(SYS_ERR_CARBON_MAP_NOT_OPEN)
        return
      end
      self:showMainCarbonDetail(chapterId)
    end)
    content:setSwallowTouches(false)
    if tempId == chapterId or tempId == chapterId + 100 or autoId == chapterId or autoId == chapterId + 100 then
      self:showBattle(content)
    end
  end
  self.mapSize = cc.size(xPos, 0)
  UIHelper.MoveToRight({
    node = self.content,
    time = 0.4
  })
  display.newScale9Sprite(MainRes .. "image_line.png", 0, 0, cc.size(MAP_INTERVAL * MAIN_MAP_NUM, 18)):anch(0, 0.5):pos(100, 555):addTo(self.mapNode)
  display.newScale9Sprite(MainRes .. "image_line.png", 0, 0, cc.size(MAP_INTERVAL * EXTRA_MAP_NUM, 18)):anch(0, 0.5):pos(100 + MAP_INTERVAL * MAIN_MAP_NUM, 555):addTo(self.mapNode)
  self.title1 = display.newSprite(MainRes .. "image_title_1.png"):anch(0, 0.5):pos(120, 563):addTo(self.mapNode)
  self.title2 = display.newSprite(MainRes .. "image_title_2.png"):anch(0, 0.5):pos(120 + MAP_INTERVAL * MAIN_MAP_NUM, 563):addTo(self.mapNode)
  if self.carbonType == 1 and self.curMap > 102 then
    local autoXPos = math.max((self.curMap - 102) * -MAP_INTERVAL, display.width - xPos)
    self.title1:setPositionX(self.title1:getPositionX() - autoXPos)
    self.mapNode:setPositionX(autoXPos)
  end
  self:showBoss()
end

function CarbonMainLayer:showHappyCarbon()
  self.mapBg:removeAllChildren()
  self.content:removeAllChildren()
  self.mapNode = display.newNode():addTo(self.content)
  local battleInfo = json.decode(game.role.paradiseBattleInfo) or {}
  local xPos = 400
  for type = 1, 2 do
    local limit = type == 1 and globalCsv.ExpLeyuanOpentime or globalCsv.CuisineLeyuanOpentime
    local card = UIHelper.newImageView(HappyRes .. string.format("card_%d.png", type)):pos(xPos, 325):addTo(self.mapNode)
    display.newSprite(HappyRes .. string.format("time_%d.png", type)):anch(0, 0):pos(2, 65):addTo(card)
    local open, count = self:getOpen(limit)
    if open then
      local color = type == 1 and "#0e771a" or "#13c5ff"
      local left = count - game.role.paradiseBattleCount:getv(type, 0)
      display.newTTFLabel({
        text = string.format("%d/%d", left, count),
        size = 30,
        color = UIHelper.hex2rgb(color)
      }):pos(52, 30):addTo(card)
    end
    card:setCallback(function()
      local open = self:getOpen(limit)
      if not open then
        SysError(SYS_ERR_CAEBON_HAPPY_NOT_OPEN)
        return
      end
      if battleInfo.carbonId and HappyBattleCsv[battleInfo.carbonId].type ~= type then
        SysError(SYS_ERR_CARBON_HAPPY_ON_BATTLE)
        return
      end
      self:showHappyCarbonDetail(type)
    end)
    if battleInfo.carbonId and HappyBattleCsv[battleInfo.carbonId].type == type then
      display.newSprite("ui/autumn/main/battle.png"):scale(0.75):pos(155, 410):addTo(card)
    end
    xPos = xPos + 430
  end
  local btnInfo = UIHelper.extend(ccui.Button:create())
  btnInfo:setImages("ui/pvp/main/", {
    "btn_rule.png",
    "btn_rule.png"
  })
  btnInfo:pos(1090, 530):addTo(self.mapNode)
  btnInfo:setTouchScale()
  btnInfo:setCallback(function()
    game:loadView("kitchen.CookInfoLayer").new({
      res = MainRes .. "image_rule.png"
    })
  end)
end

function CarbonMainLayer:showDailyCarbon()
  self.mapBg:removeAllChildren()
  self.content:removeAllChildren()
  self.mapNode = display.newNode():addTo(self.content)
  local battleInfo = json.decode(game.role.bossCarbonInfo) or {}
  battleInfo.status = battleInfo.status or ""
  local xPos, yPos = 370, 425
  for type = 1, 4 do
    local limit = globalCsv["bosscarbonOpentime" .. type]
    local card = UIHelper.newImageView(DailyRes .. string.format("type_%d.png", type)):pos(xPos, yPos):addTo(self.mapNode)
    local open, count = self:getOpen(limit)
    if open then
      local left = count - battleInfo.status:getv(type, 0)
      display.newTTFLabel({
        text = string.format("%d/%d", math.max(left, 0), count),
        size = 30
      }):enableOutline(UIHelper.hex2rgb("#000000"), 1):anch(0, 0.5):pos(6, 23):addTo(card)
    end
    card:setCallback(function()
      self:showDailyCarbonDetail(type)
    end)
    xPos = xPos + 465
    if type % 2 == 0 then
      xPos = 370
      yPos = yPos - 225
    end
  end
  local btnInfo = UIHelper.extend(ccui.Button:create())
  btnInfo:setImages("ui/pvp/main/", {
    "btn_rule.png",
    "btn_rule.png"
  })
  btnInfo:pos(1090, 530):addTo(self.mapNode)
  btnInfo:setTouchScale()
  btnInfo:setCallback(function()
    game:loadView("kitchen.CookInfoLayer").new({
      res = DailyRes .. "rule_0.png"
    })
  end)
end

function CarbonMainLayer:showEijiCarbon()
  if not CommonHelper.funcOpen("awake") then
    SysError(SYS_ERR_FUNCOPEN_AWAKE)
    return
  end
  UIHelper.newImageView(EijiRes .. "map.png"):center(self.mapBg):addTo(self.mapBg)
  self.content:removeAllChildren()
  self.mapNode = display.newNode():addTo(self.content)
  local battleInfo = json.decode(game.role.eijiCarbonInfo) or {}
  battleInfo.status = battleInfo.status or ""
  local xPos, yPos = 370, 425
  local pos = {
    [1] = {posx = 283, posy = 485},
    [2] = {posx = 683, posy = 505},
    [3] = {posx = 260, posy = 267},
    [4] = {posx = 900, posy = 340},
    [5] = {posx = 603, posy = 312}
  }
  local openHigh = true
  local pass = battleInfo.pass or ""
  for id, _ in pairs(battleInfo.status:toNumMap()) do
    if battleInfo.status:getv(id, -1) ~= -1 and id ~= 5 and not (0 < pass:getv(id * 100 + #EijiBattleCsv[id], 0)) and not (0 < pass:getv(id * 100 + #EijiBattleCsv[id] - 1, 0)) then
      openHigh = false
    end
  end
  for type = 1, 5 do
    local card = UIHelper.newImageView(EijiRes .. string.format("type_%d.png", type)):pos(pos[type].posx, pos[type].posy):addTo(self.mapNode)
    local count = battleInfo.status:getv(type, -1)
    local imageUnlock = type < 5 and "commonUnlock.png" or "highUnlock.png"
    local unlockPos = type < 5 and {posx = 110, posy = 80} or {posx = 162, posy = 93}
    if count == -1 then
      UIHelper.newImageView(EijiRes .. imageUnlock):pos(unlockPos.posx, unlockPos.posy):addTo(card)
      card:setCallback(function()
        SysError(SYS_ERR_CAEBON_EIJI_NOT_OPEN)
      end)
    elseif type == 5 and not openHigh then
      UIHelper.newImageView(EijiRes .. imageUnlock):pos(unlockPos.posx, unlockPos.posy):addTo(card)
      card:setCallback(function()
        SysError(SYS_ERR_CAEBON_EIJI_NOT_OPEN)
      end)
    else
      local limit = globalCsv.eijiRefresh:getv(type, 0)
      display.newTTFLabel({
        text = string.format("%d/%d", count, limit),
        size = 30
      }):enableOutline(UIHelper.hex2rgb("#000000"), 1):anch(0, 0.5):pos(6, 23):addTo(card)
      card:setCallback(function()
        self:showEijiCarbonDetail(type)
      end)
    end
    xPos = xPos + 465
    if type % 2 == 0 then
      xPos = 370
      yPos = yPos - 225
    end
  end
  local btnInfo = UIHelper.extend(ccui.Button:create())
  btnInfo:setImages("ui/pvp/main/", {
    "btn_rule.png",
    "btn_rule.png"
  })
  btnInfo:pos(1095, 530):addTo(self.mapNode)
  btnInfo:setTouchScale()
  btnInfo:setCallback(function()
    game:loadView("kitchen.CookInfoLayer").new({
      res = EijiRes .. "rule_0.png"
    })
  end)
  local btnShop = UIHelper.extend(ccui.Button:create())
  btnShop:setImages("ui/pvp/main/", {
    "btn_shop.png",
    "btn_shop.png"
  })
  btnShop:pos(1095, 460):addTo(self.mapNode)
  btnShop:setTouchScale()
  btnShop:setCallback(function()
    local layer = game:createView("shop.ShopLayer", {curType = 2, selected = 4})
    BackManager:push(function()
      layer:close()
      TopBar:show(TopBarType.full, "探险")
    end)
  end)
  local btnRank = UIHelper.extend(ccui.Button:create())
  btnRank:setImages("ui/tower/main/", {
    "btn_rank.png",
    "btn_rank.png"
  })
  btnRank:pos(1095, 395):addTo(self.mapNode)
  btnRank:setTouchScale()
  btnRank:setCallback(function()
    local rankList = {}
    NetManager:sendData(actionCodes.Sauce_getEijiRankRpc, MsgPack.pack({}))
    UIHelper.showWaiting()
    NetManager:addResponseHandler(actionCodes.Sauce_getEijiRankRpc, function(event)
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
        NetManager:removeResponseHandler(actionCodes.Sauce_getEijiRankRpc)
        game:createView("sauce.SauceRankLayer", {rankList = rankList, type = "eiji"})
      end
    end, true)
  end)
end

function CarbonMainLayer:showShenYuanCarbon()
  self.mapBg:removeAllChildren()
  self.content:removeAllChildren()
  self.mapNode = display.newNode():addTo(self.content)
  local battleInfo = json.decode(game.role.shenyuanCarbonInfo) or {}
  battleInfo.status = battleInfo.status or ""
  local xPos, yPos = 370, 425
  for type = 1, #ShenYuanBattleCsv do
    local card = UIHelper.newImageView(ShenYuanRes .. string.format("type_%d.png", type)):pos(xPos, yPos):addTo(self.mapNode)
    local open, count = true, globalCsv.ShenYuanRefresh
    if open then
      local left = count - battleInfo.status:getv(type, 0)
      display.newTTFLabel({
        text = string.format("%d/%d", math.max(left, 0), count),
        size = 30
      }):enableOutline(UIHelper.hex2rgb("#000000"), 1):anch(0, 0.5):pos(6, 23):addTo(card)
    end
    card:setCallback(function()
      self:showShenYuanCarbonDetail(type)
    end)
    xPos = xPos + 465
    if type % 2 == 0 then
      xPos = 370
      yPos = yPos - 225
    end
  end
  local btnInfo = UIHelper.extend(ccui.Button:create())
  btnInfo:setImages("ui/pvp/main/", {
    "btn_rule.png",
    "btn_rule.png"
  })
  btnInfo:pos(1090, 530):addTo(self.mapNode)
  btnInfo:setTouchScale()
  btnInfo:setCallback(function()
    game:createView("global.RuleLayer", {
      typeStr = "shenyuan_carbon"
    })
  end)
end

function CarbonMainLayer:showExplore()
  local newTime = CommonHelper.date()
  if newTime.wday == 2 then
    local timeTab = globalCsv.pvpRsetTime:toArray("=", true)
    if newTime.hour >= timeTab[1] / 100 and newTime.hour < timeTab[2] / 100 then
      SysError(SYS_ERR_CAEBON_PVP_CLOSE)
      return
    end
  end
  game:sendData(actionCodes.Pvp_enterPvpRpc, "")
  UIHelper.showWaiting()
  game:addResponseHandler(actionCodes.Pvp_enterPvpRpc, function(event)
    UIHelper.removeWaiting()
    local msg = MsgPack.unpack(event.data)
    game.role.pvpInfo.group = msg.group
    game.role.pvpInfo.rank = msg.rank
    local layer = game:createView("pvp.PvpMainLayer")
    self:hide()
    BackManager:push(function()
      layer:close()
      self:show()
      self:showTopbar()
    end)
  end)
end

function CarbonMainLayer:showHunDun()
  local layer = game:createView("rouge.RouGeMainLayer")
  self:hide()
  BackManager:push(function()
    layer:close()
    self:show()
    self:showTopbar()
  end)
end

function CarbonMainLayer:showTower()
  local layer = game:createView("tower.TowerMainLayer")
  self:hide()
  BackManager:push(function()
    layer:close()
    self:show()
    self:showTopbar()
  end)
end

function CarbonMainLayer:showSauce()
  local layer = game:createView("sauce.SauceCarbonLayer")
  self:hide()
  BackManager:push(function()
    layer:close()
    self:show()
    self:showTopbar()
  end)
end

function CarbonMainLayer:showBoss()
  local extraBattle = json.decode(game.role.extraBattle)
  local time = game.role.progressTime
  time = time == 0 and game:nowTime() or time
  local progress = game.role.progress + (game:nowTime() - time) / (60 * globalCsv.ghostPowerSpeed)
  progress = 100 < progress and 100 or progress
  
  local function ShowTalk(state)
    if not CommonHelper.funcOpen("ghost") then
      return
    end
    if game.role.majorGuideStep <= MAX_MAJOR_STEP then
      return
    end
    local newprogress = game.role.progress + (game:nowTime() - time) / (60 * globalCsv.ghostPowerSpeed)
    newprogress = 100 < newprogress and 100 or newprogress
    local temp = self.bossCenter:getChildByName("dialog")
    if temp then
      temp:stopAllActions()
      temp:removeFromParent()
    end
    local number = self.bossCenter:getChildByName("number")
    if number then
      number:removeFromParent()
    end
    local dialog = UIHelper.newImageView(MainRes .. "talk_bg.png")
    local ttfString = {
      [1] = "异变线索不足\n请前往探险搜寻线索",
      [2] = "异变线索解析完毕\n点击确认异变位置",
      [3] = "异变食灵位置已标记\n请前往净化",
      [4] = "异变食灵净化完成"
    }
    dialog:setCascadeOpacityEnabled(true)
    local str = display.newTTFLabel({
      text = ttfString[state],
      size = 17,
      color = UIHelper.hex2rgb("#3e1700"),
      dimensions = cc.size(170, 40)
    }):pos(90, 36):addTo(dialog)
    dialog:pos(100, 100):name("dialog"):addTo(self.bossCenter)
    if state == 1 then
      dialog:runAction(transition.sequence({
        cc.FadeIn:create(0.3),
        cc.DelayTime:create(3),
        cc.FadeOut:create(1)
      }))
    else
      dialog:runAction(cc.RepeatForever:create(transition.sequence({
        cc.FadeIn:create(0.3),
        cc.DelayTime:create(3),
        cc.FadeOut:create(1),
        cc.DelayTime:create(30)
      })))
    end
    if extraBattle.bossId and extraBattle.bossId > 0 then
    else
      display.newTTFLabel({
        text = string.format("%d/100", newprogress),
        size = 18,
        color = UIHelper.hex2rgb("#ffffff")
      }):enableOutline(UIHelper.hex2rgb("#270000"), 1):pos(36, -15):name("number"):addTo(self.bossCenter)
    end
  end
  
  self.bossCenter:removeAllChildren()
  if extraBattle.bossId and 0 < extraBattle.bossId then
    if extraBattle.carbonId == 0 then
      ShowTalk(4)
    else
      ShowTalk(3)
    end
    self.bossMid:setPercentage(100)
    self.bossCenter:setImages(MainRes, {
      "boss_center.png.png",
      "boss_center.png.png"
    })
    UIHelper.newImageView(MainRes .. "p_center.png"):pos(36, 35):addTo(self.bossCenter)
    local light = UIHelper.newImageView(MainRes .. "p_light.png"):pos(36, 35):addTo(self.bossCenter)
    light:runAction(cc.RepeatForever:create(transition.sequence({
      cc.FadeOut:create(1),
      cc.FadeIn:create(1)
    })))
    self.bossCenter:setCallback(function()
      local book = game.role.storyBook
      local taskId = 0
      local bossData = BossCsv[extraBattle.bossId]
      local killTime = game.role.BossKillStatus:getv(bossData.killTag, 0)
      if killTime == 1 and extraBattle.carbonId == 0 then
        if 0 < bossData.story2 then
          game:createView("talk.PlotTalkLayer", {
            talkId = bossData.story2,
            csvNo = bossData.readcsv or 0,
            onComplete = function()
              local layer = game:createView("carbon.BossDetailLayer")
              BackManager:push(function()
                layer:close()
                self:showBoss()
              end)
            end
          })
        else
          local layer = game:createView("carbon.BossDetailLayer")
          BackManager:push(function()
            layer:close()
            self:showBoss()
          end)
        end
      else
        local layer = game:createView("carbon.BossDetailLayer")
        BackManager:push(function()
          layer:close()
          if self.carbonType == 1 then
            self:showMainCarbon()
          else
            self:showBoss()
          end
        end)
      end
    end)
  else
    local effect = UIHelper.createSpineNodeByRes("spine/ui/battle/boss"):addTo(self.bossCenter)
    self.bossMid:setPercentage(math.floor(progress))
    if progress < 100 then
      effect:pos(36, 37):setAnimation(1, "special2", true)
      ShowTalk(1)
      self.bossCenter:setCallback(function()
        if game:nowTime() - self.lastTime < 3.5 then
          return
        end
        self.lastTime = game:nowTime()
        ShowTalk(1)
      end)
    else
      effect:pos(36, 37):setAnimation(1, "special", true)
      ShowTalk(2)
      self.bossCenter:setCallback(function()
        if game:nowTime() - self.lastTime < 2 then
          return
        end
        self.lastTime = game:nowTime()
        game:sendData(actionCodes.Carbon_generateBoss, MsgPack.pack({}))
        UIHelper.showWaiting()
        game:addResponseHandler(actionCodes.Carbon_generateBoss, function(event)
          UIHelper.removeWaiting()
          game:createView("carbon.BossSearchLayer", {
            func = function()
              if self.carbonType == 1 then
                self:showMainCarbon()
              else
                self:showBoss()
              end
            end
          })
        end)
      end)
    end
  end
  if not CommonHelper.funcOpen("ghost") then
    self.bossCenter:setCallback(function()
      SysError(SYS_ERR_FUNCOPEN_GHOST)
      if game:nowTime() - self.lastTime < 2 then
        return
      end
      self.lastTime = game:nowTime()
    end)
  end
end

function CarbonMainLayer:showBattle(parent, remove)
  local battle = parent:getChildByName("text")
  if battle then
    battle:removeSelf()
  end
  if remove then
    return
  end
  local size = parent:getContentSize()
  local bg = display.newSprite(MainRes .. "text_bg.png"):pos(size.width / 2, 131):addTo(parent):name("text")
  display.newTTFLabel({
    text = "战斗中",
    size = 16,
    color = UIHelper.hex2rgb("#ffffff")
  }):center(bg):addTo(bg)
end

function CarbonMainLayer:showMainCarbonDetail(mapId)
  self:hide()
  local layer = game:createView("carbon.CarbonDetailLayer", {
    mapId = mapId,
    isAutoType = self.isAuto
  })
  BackManager:push(function()
    layer:close()
    self:show()
    self:showTopbar()
  end)
end

function CarbonMainLayer:showHappyCarbonDetail(diffType)
  self:hide()
  local layer = game:createView("carbon.CarbonHappyDetailLayer", {type = diffType})
  BackManager:push(function()
    layer:close()
    self:show()
    self:showTopbar()
  end)
end

function CarbonMainLayer:showDailyCarbonDetail(indexType, bossDegree)
  local limit = globalCsv["bosscarbonOpentime" .. indexType]
  local open = self:getOpen(limit)
  if not open then
    SysError(SYS_ERR_CAEBON_BOSS_NOT_OPEN)
    return
  end
  self:hide()
  local layer = game:createView("carbon.CarbonDailyDetailLayer", {indexType = indexType, selectId = bossDegree})
  BackManager:push(function()
    layer:close()
    self:show()
    self:showTopbar()
  end)
end

function CarbonMainLayer:showEijiCarbonDetail(indexType, bossDegree)
  local layer = game:createView("carbon.EijiDailyDetailLayer", {indexType = indexType, selectId = bossDegree})
  BackManager:push(function()
    layer:close()
    self:show()
    self:showTopbar()
  end)
end

function CarbonMainLayer:showShenYuanCarbonDetail(indexType, bossDegree)
  local layer = game:createView("carbon.ShenYuanDetailLayer", {indexType = indexType, selectId = bossDegree})
  BackManager:push(function()
    layer:close()
    self:show()
    self:showTopbar()
  end)
end

function CarbonMainLayer:getMapStar(mapId)
  local cur, total = 0, 0
  local normalSet = ChapterInfoCsv[mapId]
  for index = 1, normalSet.dungeonNum do
    local carbonId = mapId * 100 + index
    local carbon = game.role.carbons[carbonId]
    cur = cur + (carbon and carbon.starNum or 0)
  end
  total = total + 3 * normalSet.dungeonNum
  mapId = mapId + 100
  local specialSet = ChapterInfoCsv[mapId]
  for index = 1, specialSet.dungeonNum do
    local carbonId = mapId * 100 + index
    local carbon = game.role.carbons[carbonId]
    cur = cur + (carbon and carbon.starNum or 0)
  end
  total = total + 3 * specialSet.dungeonNum
  mapId = mapId + 100
  local specialSet = ChapterInfoCsv[mapId]
  if specialSet then
    for index = 1, specialSet.dungeonNum do
      local carbonId = mapId * 100 + index
      local carbon = game.role.carbons[carbonId]
      cur = cur + (carbon and carbon.starNum or 0)
    end
    total = total + 3 * specialSet.dungeonNum
  end
  return cur, total
end

function CarbonMainLayer:getOpen(limit)
  if not limit then
    return true, globalCsv.ManTouRefresh
  end
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

function CarbonMainLayer:showTopbar()
  TopBar:show(TopBarType.full, "探险")
end

function CarbonMainLayer:showTaskLayer()
  local layer = game:createView("carbon.CarbonTaskLayer")
  self:hide()
  BackManager:push(function()
    layer:close()
    self:show()
    self:showTopbar()
  end)
end

function CarbonMainLayer:onTouchBegan(sender)
  if not self.mapNode or tolua.isnull(self.mapNode) then
    return
  end
  local location = self.content:getBeginPos()
  self.drag = {
    beganTime = socket.gettime(),
    beginX = location.x,
    mapX = self.mapNode:getPositionX()
  }
  return true
end

function CarbonMainLayer:onTouchMoved(sender)
  local location = self.content:getMovePos()
  self:moveOffset(location.x - self.drag.beginX)
end

function CarbonMainLayer:onTouchEnded(sender)
  if not self.mapNode or tolua.isnull(self.mapNode) then
    return
  end
  local location = self.content:getEndPos()
  local elapse = socket.gettime() - self.drag.beganTime
  local speed = (location.x - self.drag.beginX) / 100 / elapse
  if math.abs(speed) >= 20 then
    self.drag.mapX = self.mapNode:getPositionX()
    self:moveOffset(speed * elapse * 100 * 3, true)
  end
end

function CarbonMainLayer:onTouchCancelled(sender)
  self:onTouchEnded(sender)
end

function CarbonMainLayer:moveOffset(offset, animation)
  if self.carbonType ~= 1 then
    return
  end
  
  local function normalOffset(_offset)
    local pos = self.drag.mapX + _offset
    if 0 < pos then
      pos = 0
    elseif pos < display.width - self.mapSize.width then
      pos = display.width - self.mapSize.width
    end
    return pos, pos - self.drag.mapX
  end
  
  local targetX, targetOffset = normalOffset(offset)
  self.mapNode:stopAllActions()
  self.mapNode:unscheduleUpdate()
  if animation then
    self.mapNode:runAction(transition.sequence({
      cc.EaseExponentialOut:create(cc.MoveBy:create(1, cc.p(targetOffset, 0))),
      cc.CallFunc:create(function()
        self.mapNode:unscheduleUpdate()
      end)
    }))
    self.mapNode:scheduleUpdateWithPriorityLua(function()
      self:updateTitleOffset()
    end, 0)
  else
    self.mapNode:pos(targetX, 0)
  end
  self:updateTitleOffset()
end

function CarbonMainLayer:updateTitleOffset(animation)
  local xPos = self.mapNode:getPositionX()
  if xPos <= 0 and xPos >= -(230 + (MAIN_MAP_NUM - 1) * MAP_INTERVAL) then
    local min = math.min((MAIN_MAP_NUM - 1) * MAP_INTERVAL, -xPos)
    self.title1:setPositionX(min + 120)
  end
  if xPos <= -(230 + (MAIN_MAP_NUM - 3) * MAP_INTERVAL) then
    local max = math.max(MAIN_MAP_NUM * MAP_INTERVAL, -xPos)
    self.title2:setPositionX(max + 120)
  end
end

return CarbonMainLayer
