local BattleCsv = require("csvdata.tower_battle")
local TowerRes = "ui/tower/main/"
local uiData = {
  csbFile = "ui/tower/TowerMainLayer.csb",
  widgets = {
    up = "up",
    upBar = "upBar",
    upP = "upP",
    upLine = "upLine",
    list = "list",
    center = "center",
    sideBg2 = "sideBg2",
    sideBg1 = "sideBg1",
    btnInfo = "btnInfo",
    btnRank = "btnRank",
    btnReset = "btnReset",
    herosBg = "herosBg",
    heroNode = "herosBg/heroNode",
    btnTreat = "herosBg/btnTreat",
    btnFormat = "herosBg/btnFormat",
    btnChallenge = "herosBg/btnChallenge",
    btnCross = "herosBg/btnCross",
    text = "herosBg/textBg/text",
    textBg = "textBg",
    downBar = "downBar"
  }
}
local TowerMainLayer = class("TowerMainLayer", UIBase)

function TowerMainLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function TowerMainLayer:init(params)
  TopBar:show(TopBarType.full, "道场")
  if UIHelper.isiPhoneX() then
    UIHelper.fitForiPhoneX(self.center)
    UIHelper.fitForiPhoneX(self.up, true)
    UIHelper.fitForiPhoneX(self.upLine, true)
    UIHelper.fitForiPhoneX(self.upBar, true)
    UIHelper.fitForiPhoneX(self.downBar, true)
  end
  self.heros = {}
  self.herosInfo = {}
  local names = {
    "btnInfo",
    "btnRank",
    "btnReset",
    "btnTreat",
    "btnChallenge",
    "btnCross",
    "btnFormat"
  }
  for _, name in pairs(names) do
    self[name]:setTouchScale()
  end
  display.newTTFLabel({
    text = "快速治疗",
    size = 18
  }):enableOutline(UIHelper.hex2rgb("#19540c"), 1):pos(48, 19):addTo(self.btnTreat)
  display.newTTFLabel({
    text = "装盘修改",
    size = 18
  }):enableOutline(UIHelper.hex2rgb("#19540c"), 1):pos(48, 19):addTo(self.btnFormat)
  display.newTTFLabel({
    text = "挑战",
    size = 26,
    color = UIHelper.hex2rgb("#FFECCB")
  }):enableOutline(UIHelper.hex2rgb("#722c02"), 1):pos(40, 43):addTo(self.btnChallenge)
  display.newTTFLabel({
    text = "突破",
    size = 26,
    color = UIHelper.hex2rgb("#FFECCB")
  }):enableOutline(UIHelper.hex2rgb("#722c02"), 1):pos(40, 43):addTo(self.btnCross):name("lab")
  self.btnInfo:setCallback(function()
    game:createView("global.RuleLayer", {
      res = "ui/tower/main/image_info.png"
    })
  end)
  self.btnRank:setCallback(function()
    local rankList = {}
    NetManager:sendData(actionCodes.Tower_getRankRpc, MsgPack.pack(""))
    UIHelper.showWaiting()
    NetManager:addResponseHandler(actionCodes.Tower_getRankRpc, function(event)
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
        NetManager:removeResponseHandler(actionCodes.Tower_getRankRpc)
        game:createView("tower.TowerRankLayer", {rankList = rankList})
      end
    end, true)
  end)
  self.btnReset:setCallback(function()
    if game.role.dailyTowerReset > 0 then
      SysError(SYS_ERR_TOWER_RESET_NOT_ENOUGH)
      return
    end
    MDialog:double({
      title = "重置",
      text = "主厨，每日只可重置1次哦。重置后，将会重新开始挑战。\n确定要重置吗？",
      okCallback = function()
        game:sendData(actionCodes.Tower_resetRpc, MsgPack.pack({}))
        UIHelper.showWaiting()
        game:addResponseHandler(actionCodes.Tower_resetRpc, function(event)
          UIHelper.removeWaiting()
          self:showData({flash = true})
        end)
        return true
      end,
      cancelCallback = function()
        return true
      end
    })
  end)
  self.btnTreat:setCallback(function()
    local formatInfo = json.decode(game.role.towerData.formatInfo) or {}
    local herosInfo = json.decode(game.role.towerData.herosInfo) or {}
    formatInfo.list = formatInfo.list or {}
    local isHave = false
    for slot, id in pairs(formatInfo.list) do
      if id and herosInfo[tostring(id)] < 1000 then
        isHave = true
        break
      end
    end
    if isHave then
      game:createView("tower.TowerCureLayer", {
        callback = function(heroIds)
          if not next(heroIds) then
            return
          end
          game:sendData(actionCodes.Tower_cureRpc, MsgPack.pack({ids = heroIds}))
          UIHelper.showWaiting()
          game:addResponseHandler(actionCodes.Tower_cureRpc, function(event)
            UIHelper.removeWaiting()
            local result = MsgPack.unpack(event.data)
            SysError(SYS_ERR_TREAT_SUCCESS)
            self:showHeros()
          end)
        end
      })
    else
      SysError(SYS_ERR_TREAT_NO_HERO_NEEDED)
    end
  end)
  self.btnFormat:setCallback(function()
    if not next(self.herosInfo) then
      SysError(SYS_ERR_TOWER_TEAM_NEED_HREO)
      return
    end
    local layer = game:createView("hero.FormationPresetLayer", {skip = true, battleType = "tower"})
    self:hide()
    BackManager:push(function()
      self:show()
      layer:close()
      TopBar:show(TopBarType.full, "道场")
    end)
  end)
  self.btnChallenge:setCallback(function()
    if game.role:isMaxEquip() then
      UIHelper.showExtraTip({type = 2, parent = self})
      return
    end
    if not next(self.herosInfo) then
      SysError(SYS_ERR_TOWER_TEAM_NEED_HREO)
      return
    end
    if not self:checkCanChallenge() then
      SysError(SYS_ERR_TOWER_TEAM_NEED_CURE)
      return
    end
    local curFloor = game.role.towerData.floorId
    local floorsData = json.decode(game.role.towerData.floorInfo)
    local leftInfo = game.role:getTowerAttrs(json.decode(game.role.towerData.formatInfo) or {}, self.herosInfo)
    local params = {
      type = BattleType.Tower,
      leftInfo = leftInfo,
      floorId = curFloor,
      floorInfo = floorsData[curFloor]
    }
    game:sendData(actionCodes.Tower_battleBeginRpc, MsgPack.pack(""))
    UIHelper.showWaiting()
    game:addResponseHandler(actionCodes.Tower_battleBeginRpc, function(event)
      UIHelper.removeWaiting()
      local msg = MsgPack.unpack(event.data)
      game.role.__battleKey = msg.battleKey
      game:enterScene("BattleScene", params)
    end)
  end)
  self.btnCross:setCallback(function()
    if game.role.towerData.maxFloorId < 20 then
      SysError(SYS_ERR_TOWER_BREAK_SHORT)
      return
    end
    if game.role.towerData.maxFloorId - game.role.towerData.floorId < 10 then
      SysError(SYS_ERR_TOWER_BREAK_OUT)
      return
    end
    if game.role:isMaxEquip() then
      UIHelper.showExtraTip({type = 2, parent = self})
      return
    end
    if not next(self.herosInfo) then
      SysError(SYS_ERR_TOWER_TEAM_NEED_HREO)
      return
    end
    if not self:checkCanChallenge() then
      SysError(SYS_ERR_TOWER_TEAM_NEED_CURE)
      return
    end
    if (game.role.items[globalCsv.quickRepair] or 0) < 5 then
      UIHelper.showCookTip({type = 5, parent = self})
      return
    end
    MDialog:double({
      title = "突破",
      text = "可突破至" .. game.role.towerData.maxFloorId - globalCsv.tower_break_level .. "关。并领取" .. game.role.towerData.maxFloorId - globalCsv.tower_break_level .. "关之前的所有奖励\n \n需要消耗<img src='ui/global/icon_quick2.png' scale=0.5 />x5,是否突破？",
      size = 26,
      okCallback = function()
        game:sendData(actionCodes.Tower_breakRpc, MsgPack.pack({}))
        UIHelper.showWaiting()
        game:addResponseHandler(actionCodes.Tower_breakRpc, function(event)
          UIHelper.removeWaiting()
          local msg = MsgPack.unpack(event.data)
          self:showData()
          MedalRewardLayer.new({
            items = msg.reward
          })
        end)
        return true
      end,
      cancelCallback = function()
        return true
      end
    })
  end)
  TopBar:showAnimation(true)
  UIHelper.MoveToDown({
    node = self.up
  })
  UIHelper.MoveToRight({
    node = self.sideBg1,
    time = 0.2
  })
  UIHelper.MoveToLeft({
    node = self.list,
    time = 0.3,
    pos = {300, 0}
  })
  UIHelper.MoveToLeft({
    node = self.sideBg2,
    time = 0.2
  })
  UIHelper.MoveToUp({
    node = self.downBar,
    time = 0.2
  })
  UIHelper.MoveToUp({
    node = self.herosBg,
    time = 0.2,
    delay = 0.2,
    pos = {0, 220}
  })
  UIHelper.MoveToUp({
    node = self.textBg,
    time = 0.2,
    delay = 0.2,
    pos = {0, 170}
  })
  UIHelper.MoveToDown({
    node = self.upBar,
    time = 0.3,
    delay = 0.2
  })
  UIHelper.MoveToDown({
    node = self.upP,
    time = 0.3,
    delay = 0.2
  })
end

function TowerMainLayer:showData(params)
  local bFlash = params and params.flash
  self.list:removeAllChildren()
  local floorsData = json.decode(game.role.towerData.floorInfo)
  local size = display.newSprite(TowerRes .. "btn_4.png"):getContentSize()
  for floor, Set in ipairs(floorsData) do
    local data = BattleCsv[floor]
    local viewNode = ccui.Widget:create()
    viewNode:size(size):addTo(self.list)
    local btn = UIHelper.createTowerFloor(Set, floor):anch(0.5, 1):pos(size.width / 2, size.height):addTo(viewNode)
    if bFlash and floor < 15 then
      self:btnFlash(btn, floor)
    end
    if floor >= game.role.towerData.floorId then
      local items = data.gift2see:toTableArray()
      if 1 < #items then
        local gift = UIHelper.newImageView("ui/carbon/chooseTravel/box_6.png"):pos(54, 0):addTo(btn)
        gift:setCallback(function()
          ItemRewardLayer.new({
            items = data.gift2see:toTableArray(),
            preView = true,
            ignore = true
          })
        end)
      else
        ItemIcon.new({
          type = tonumber(items[1][1]),
          count = tonumber(items[1][2]),
          showTip = true
        }):scale(0.7):pos(54, 12):addTo(btn)
      end
    end
  end
  self.list:forceDoLayout()
  if not bFlash then
    self.list:scrollToItem(game.role.towerData.floorId - 1, cc.p(1 / #floorsData, 0), cc.p(0, 0))
  end
  if game.role.towerData.floorId > #floorsData then
    self.btnChallenge:hide()
  else
    self.btnChallenge:show()
  end
  if game.role.towerData.maxFloorId < 20 or game.role.towerData.maxFloorId - game.role.towerData.floorId < 10 then
    self.btnCross:setBright(false)
    self.btnCross:getChildByName("lab"):setTextColor(UIHelper.hex2rgb("#FFFFFF"))
    self.btnCross:getChildByName("lab"):enableOutline(UIHelper.hex2rgb("#444444"), 1)
  else
    self.btnCross:setBright(true)
    self.btnCross:getChildByName("lab"):setTextColor(UIHelper.hex2rgb("#FFECCB"))
    self.btnCross:getChildByName("lab"):enableOutline(UIHelper.hex2rgb("#722c02"), 1)
  end
  self:showHeros()
end

function TowerMainLayer:showHeros()
  self.heroNode:removeAllChildren()
  self.heros = {}
  self.herosInfo = {}
  local Info = json.decode(game.role.towerData.formatInfo)
  Info.list = Info.list or {}
  local heros = json.decode(game.role.towerData.herosInfo)
  local xPos = 0
  for slot = 1, 5 do
    local heroId = Info.list[tostring(slot)]
    if heroId then
      local icon = HeroHead.new({heroId = heroId, loveEffect = true}):pos(xPos, 10):addTo(self.heroNode)
      local cur, all, percent = self:getHeroHp(heroId, heros)
      local card = display.newSprite(TowerRes .. "hp_bar_bg.png"):pos(xPos, -45):addTo(self.heroNode)
      local hpBar = display.newProgressTimer(TowerRes .. "hp_bar.png", 1):center(card):addTo(card)
      hpBar:setMidpoint(cc.p(0, 0.5))
      hpBar:setBarChangeRate(cc.p(1, 0))
      hpBar:setPercentage(percent)
      display.newTTFLabel({
        text = string.format("%d/%d", cur, all),
        size = 14
      }):enableOutline(UIHelper.hex2rgb("#000000"), 1):pos(xPos, -58):addTo(self.heroNode)
      icon:setCallback(function()
        self:addHero(slot, heroId)
      end)
      self.heros[heroId] = slot
      self.herosInfo[heroId] = heros[tostring(heroId)]
    else
      local card = UIHelper.newImageView("ui/kitchen/quality/bg_1.png"):pos(xPos, 0):addTo(self.heroNode)
      card:setCascadeOpacityEnabled(true)
      UIHelper.newImageView("ui/global/item_frame.png"):center(card):addTo(card)
      UIHelper.newImageView("ui/global/add.png"):pos(46, 53):addTo(card)
      display.newTTFLabel({
        text = "添加食灵",
        size = 14,
        color = UIHelper.hex2rgb("#b3a27e")
      }):pos(45, 25):addTo(card)
      card:setCallback(function()
        self:addHero(slot, heroId)
      end)
    end
    xPos = xPos + 110
  end
  self.text:setString(string.format("累计上阵食灵：%d/%d", game.role.towerData.heroCount, globalCsv.tower_cure_player_limit))
end

function TowerMainLayer:addHero(slot, heroId)
  local layer = game:createView("tower.ChooseTowerHeroLayer", {
    heroId = heroId,
    max = 5,
    rule = rule,
    tower = true,
    callback = function(choose)
      if self:checkChangeCountFull(choose) then
        SysError(SYS_ERR_TOWER_CHOOSE_IS_FULL)
        return true
      end
      if type(choose) == "table" then
        local list = {}
        for index, data in pairs(choose) do
          local hero = game.role.heros[data.id]
          if hero then
            list[tostring(data.slot)] = data.id
          end
        end
        game:sendData(actionCodes.Tower_formatQuickRpc, MsgPack.pack({formation = list}))
        UIHelper.showWaiting()
        game:addResponseHandler(actionCodes.Tower_formatQuickRpc, function(event)
          UIHelper.removeWaiting()
          self:showHeros()
        end)
      elseif self:checkFormationSameHero(choose, slot) then
        SysError(SYS_ERR_TEAM_SAME_HERO)
        return true
      else
        game:sendData(actionCodes.Tower_changeFormatRpc, MsgPack.pack({slot = slot, heroId = choose}))
        UIHelper.showWaiting()
        game:addResponseHandler(actionCodes.Tower_changeFormatRpc, function(event)
          UIHelper.removeWaiting()
          self:showHeros()
        end)
      end
    end
  })
  self:hide()
  BackManager:push(function()
    TopBar:show(TopBarType.full, "道场")
    layer:close()
    self:show()
  end)
end

function TowerMainLayer:checkCanChallenge()
  for heroId, hp in pairs(self.herosInfo) do
    if hp == 0 then
      return false
    end
  end
  return true
end

function TowerMainLayer:getHeroHp(heroId, heros)
  local hero = game.role.heros[heroId]
  if not hero then
    return 0, 0, 0
  end
  local attrs = hero:getTotalAttrValues()
  local cur = heros[tostring(heroId)]
  if cur then
    local hp = 500 < cur and math.floor(attrs.hp * cur / 1000) or math.ceil(attrs.hp * cur / 1000)
    return hp, attrs.hp, cur / 10
  end
  return attrs.hp, attrs.hp, 100
end

function TowerMainLayer:btnFlash(btn, floor)
  btn:hide()
  local root = btn:getParent()
  local mask = display.newSprite(TowerRes .. "btn_flash.png"):anch(0.5, 1):pos(btn:getPosition()):addTo(root)
  mask:setOpacity(0)
  mask:runAction(transition.sequence({
    cc.DelayTime:create(0.03 * (floor - 1)),
    cc.MoveBy:create(0, cc.p(-8, -8)),
    cc.Spawn:create(cc.FadeIn:create(0.06), cc.MoveBy:create(0.06, cc.p(8, 8))),
    cc.CallFunc:create(function()
      btn:show()
    end),
    cc.FadeOut:create(0.18),
    cc.CallFunc:create(function()
      mask:removeSelf()
    end)
  }))
end

function TowerMainLayer:checkFormationSameHero(choose, slot)
  if choose == 0 then
    return false
  end
  local hero = game.role.heros[choose]
  for id, index in pairs(self.heros) do
    local tempHero = game.role.heros[id]
    if tempHero.type == hero.type and index ~= slot then
      return true
    end
  end
  return false
end

function TowerMainLayer:checkChangeCountFull(list)
  local cur = game.role.towerData.heroCount
  local heros = json.decode(game.role.towerData.herosInfo)
  if type(list) == "table" then
    for index, data in pairs(list) do
      if not heros[tostring(data.id)] then
        cur = cur + 1
      end
    end
  elseif list ~= 0 and not heros[tostring(list)] then
    cur = cur + 1
  end
  return cur > globalCsv.tower_cure_player_limit
end

return TowerMainLayer
