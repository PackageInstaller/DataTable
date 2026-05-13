local BattleCsv = require("csvdata.lty.lty_battle")
local MonsterCsv = require("csvdata.lty.lty_monster")
local ItemCsv = require("csvdata.item")
local TowerRes = "ui/tower/main/"
local CarbonRes = "ui/lty/carbon/"
local uiData = {
  csbFile = "ui/lty/LtyCarbonLayer.csb",
  widgets = {
    mainBg = "mainBg",
    up = "up",
    touch = "touch",
    node = "node",
    numBg1 = "numBg1",
    numBg2 = "numBg2",
    herosBg = "herosBg",
    animat1 = "animat1",
    animat2 = "animat2",
    heroNode = "herosBg/heroNode",
    tip = "herosBg/tip",
    btnOver = "herosBg/btnOver",
    btnForamt = "herosBg/btnFormat",
    btnCure = "herosBg/btnCure",
    btnBattle = "herosBg/btnBattle",
    num1 = "numBg1/num1",
    num2 = "numBg2/num2",
    btnReward = "btnReward"
  }
}
local LtyCarbonLayer = class("LtyCarbonLayer", UIBase)

function LtyCarbonLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function LtyCarbonLayer:init(params)
  self.mainBg:setTexture(CarbonRes .. "bj.png")
  TopBar:show(TopBarType.full, LtyTitleName)
  TopBar:showAnimation(true)
  if UIHelper.isiPhoneX() then
    UIHelper.fitForiPhoneX(self.mainBg)
    self.btnReward:setPositionX(self.btnReward:getPositionX() + UIHelper.getMoveXForX())
  end
  UIHelper.MoveToDown({
    node = self.up
  })
  self.handlers = {}
  self.timerHandler = scheduler.scheduleGlobal(function()
    if next(game.role.redDirty) then
      for field, _ in pairs(game.role.redDirty) do
        game.role:checkRedPoint(field)
      end
      game.role.redDirty = {}
    end
  end, 1)
  table.insert(self.handlers, game.role:addEventListener("notifyNewMessage", function(event)
    if event.type == "lty" then
      local bShow = checkbool(next(game.role.redPoints.lty or {}))
      UIHelper.showRedPoint(self.btnReward, bShow, cc.p(-3, 2), 0.5)
    end
  end))
  local bShow = checkbool(next(game.role.redPoints.lty or {}))
  UIHelper.showRedPoint(self.btnReward, bShow, cc.p(-3, 2), 0.5)
  local curBattle = game.role.ltyCurBattle:toArray("=", true)
  if curBattle[1] ~= 0 then
    params.chapterId = curBattle[1]
    params.index = curBattle[2]
  end
  self.carbon = BattleCsv[params.chapterId]
  game.role.ltyLastCarbon = params.chapterId
  self.index = params.index or 0
  self.minPosX = -1136
  self.dalte = 186
  self.originX = 1 < self.index and (1 - self.index) * self.dalte or 0
  self.success = params.success or false
  self.autoBattle = UserData.ltyAutoBattleLoop11 == 1 and not game.role.ltyBattleFail
  if game.role.ltyBattleFail then
    game.role.ltyBattleFail = false
  end
  self.heros = {}
  self.herosInfo = {}
  self.btnReward:setTouchScale()
  self.btnReward:setCallback(function()
    self:closeAuto()
    local layer = game:createView("lty.LtyGiftLayer", {
      selected = self.carbon.type
    })
    BackManager:push(function()
      TopBar:show(TopBarType.full, LtyTitleName)
      layer:close()
    end)
  end)
  self.btnBattle:setCallback(function()
    self:goBattle()
  end)
  if self.autoBattle then
    self.timeLabel = self:ShowAutoTime(self.btnBattle, self.btnBattle, "秒后开始战斗", function()
      self:goBattle()
    end)
  end
  self.btnOver:setCallback(function()
    self:closeAuto()
    self:showGiveUp()
  end)
  self.btnForamt:setCallback(function()
    self:closeAuto()
    self:showFormat()
  end)
  self.btnCure:setCallback(function()
    self:closeAuto()
    self:showCure()
  end)
  self.numBg1:setCallback(function()
    MTip:show({
      type = MTipType.path,
      node = self.numBg1,
      itemType = 166,
      itemData = ItemCsv[166]
    })
  end)
  self.numBg2:setCallback(function()
    MTip:show({
      type = MTipType.path,
      node = self.numBg2,
      itemType = 167,
      itemData = ItemCsv[167]
    })
  end)
  self.touch:setTouchEnabled(true)
  self.touch:setSwallowTouches(true)
  self.touch:enableNodeEvents()
  local touchEvent = {
    [ccui.TouchEventType.began] = handler(self, self.onTouchBegan),
    [ccui.TouchEventType.moved] = handler(self, self.onTouchMoved),
    [ccui.TouchEventType.ended] = handler(self, self.onTouchEnded),
    [ccui.TouchEventType.canceled] = handler(self, self.onTouchCancelled)
  }
  self.touch:addTouchEventListener(function(sender, type)
    touchEvent[type](sender)
  end)
end

function LtyCarbonLayer:closeAuto()
  self.btnBattle:stopAllActions()
  if self.timeLabel then
    self.timeLabel:removeSelf()
    self.timeLabel = nil
  end
end

function LtyCarbonLayer:goBattle()
  if not next(self.herosInfo) then
    SysError(SYS_ERR_TOWER_TEAM_NEED_HREO)
    return
  end
  if not self:checkCanChallenge() then
    if self.autoBattle then
      self:showCure()
    else
      SysError(SYS_ERR_TOWER_TEAM_NEED_CURE)
    end
    return
  end
  local boss = game.role.ltyEnemyList:toArray("=", true)
  local leftInfo = game.role:getTowerAttrs(json.decode(game.role.ltyFormatInfo) or {}, self.herosInfo)
  local params = {
    type = BattleType.Lty,
    leftInfo = leftInfo,
    battleId = self.carbon.id,
    monsterId = boss[self.index + 1]
  }
  game:sendData(actionCodes.Activity_ltyBeginGameRpc, MsgPack.pack(""))
  UIHelper.showWaiting()
  game:addResponseHandler(actionCodes.Activity_ltyBeginGameRpc, function(event)
    UIHelper.removeWaiting()
    local msg = MsgPack.unpack(event.data)
    game.role.__battleKey = msg.battleKey
    game:enterScene("BattleScene", params)
  end)
end

function LtyCarbonLayer:ShowAutoTime(node, btn, text, callBack)
  local time = 5
  local label = display.newTTFLabel({
    text = time .. text,
    size = 18
  }):enableOutline(UIHelper.hex2rgb("#000000"), 1):pos(node:getContentSize().width / 2 + 100, 32):addTo(node)
  
  local function timeTick()
    btn:runAction(transition.sequence({
      cc.DelayTime:create(1),
      cc.CallFunc:create(function()
        if 0 < time then
          if self.timeLabel then
            label:setString(time .. text)
          end
          time = time - 1
          timeTick()
        else
          if type(callBack) == "function" then
            callBack()
          end
          label:removeSelf()
          self.timeLabel = nil
        end
      end)
    }))
  end
  
  timeTick()
  return label
end

function LtyCarbonLayer:showData(params)
  self:initMonster()
  self:initHeros()
  self:updateIconNum()
end

function LtyCarbonLayer:initMonster()
  local xPos = 115
  local boss = game.role.ltyEnemyList:toArray("=", true)
  local stages = self.carbon.stage:toArray("=", true)
  self.minPosX = (1 - #boss) * self.dalte
  for index, bossId in ipairs(boss) do
    local monster = MonsterCsv[bossId]
    if monster then
      local stage = UIHelper.newImageView(CarbonRes .. string.format("stage_%d.png", stages[index] or 1)):anch(0.5, 0):pos(xPos, -30):addTo(self.node)
      if index ~= #boss then
      end
      if index <= self.index then
        local image = display.newSprite(CarbonRes .. "image_success.png"):anch(0.5, 0):pos(45, 60):addTo(stage)
      elseif index == self.index + 1 then
        local spine = UIHelper.createSpineNode(monster.unitId)
        spine:setAnimation(0, "idle", true)
        spine:scale(1.2):pos(95, 50):addTo(stage)
      else
        display.newSprite(CarbonRes .. "mask.png"):anch(0.5, 0):pos(103, 50):addTo(stage)
      end
      xPos = xPos + self.dalte
    end
  end
  self.node:setPositionX(self.originX)
end

function LtyCarbonLayer:initHeros()
  self.heroNode:removeAllChildren()
  self.heros = {}
  self.herosInfo = {}
  local Info = json.decode(game.role.ltyFormatInfo)
  Info.list = Info.list or {}
  local heros = json.decode(game.role.ltyHerosInfo)
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
      }):enableOutline(UIHelper.hex2rgb("#000000"), 1):pos(xPos, -44):addTo(self.heroNode)
      icon:setCallback(function()
        self:closeAuto()
        self:addHero(slot, heroId)
      end)
      self.heros[heroId] = slot
      self.herosInfo[heroId] = heros[tostring(heroId)]
    else
      local card = UIHelper.newImageView(CarbonRes .. "btn_add.png"):pos(xPos, 0):addTo(self.heroNode)
      card:setCascadeOpacityEnabled(true)
      display.newTTFLabel({
        text = "添加食灵",
        size = 16,
        color = UIHelper.hex2rgb("#ffffff")
      }):pos(45, 15):addTo(card)
      card:setCallback(function()
        self:addHero(slot, heroId)
      end)
    end
    xPos = xPos + 109
  end
  self.tip:setString(string.format("累计出战食灵:%d/%d", table.nums(heros), globalCsv.ltyLimit))
end

function LtyCarbonLayer:addHero(slot, heroId)
  if self.timeLabel then
    self.timeLabel:removeSelf()
    self.timeLabel = nil
  end
  local layer = game:createView("lty.ChooseLtyHeroLayer", {
    heroId = heroId,
    max = 5,
    callback = function(choose)
      if self:checkChangeCountFull(choose) then
        SysError(SYS_ERR_LTY_HREOS_IS_LIMIT)
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
        game:sendData(actionCodes.Activity_ltyFormatQuickRpc, MsgPack.pack({formation = list}))
        UIHelper.showWaiting()
        game:addResponseHandler(actionCodes.Activity_ltyFormatQuickRpc, function(event)
          UIHelper.removeWaiting()
          self:initHeros()
        end)
      elseif self:checkFormationSameHero(choose, slot) then
        SysError(SYS_ERR_TEAM_SAME_HERO)
        return true
      else
        game:sendData(actionCodes.Activity_ltyChangeFormatRpc, MsgPack.pack({slot = slot, heroId = choose}))
        UIHelper.showWaiting()
        game:addResponseHandler(actionCodes.Activity_ltyChangeFormatRpc, function(event)
          UIHelper.removeWaiting()
          self:initHeros()
        end)
      end
    end
  })
  self:hide()
  BackManager:push(function()
    TopBar:show(TopBarType.full, LtyTitleName)
    layer:close()
    self:show()
  end)
end

function LtyCarbonLayer:checkChangeCountFull(list)
  local heros = json.decode(game.role.ltyHerosInfo)
  local cur = table.nums(heros)
  if type(list) == "table" then
    for index, data in pairs(list) do
      if not heros[tostring(data.id)] then
        cur = cur + 1
      end
    end
  elseif list ~= 0 and not heros[tostring(list)] then
    cur = cur + 1
  end
  return cur > globalCsv.ltyLimit
end

function LtyCarbonLayer:checkFormationSameHero(choose, slot)
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

function LtyCarbonLayer:checkCanChallenge()
  for heroId, hp in pairs(self.herosInfo) do
    if hp == 0 then
      return false
    end
  end
  return true
end

function LtyCarbonLayer:getHeroHp(heroId, heros)
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

function LtyCarbonLayer:showGiveUp()
  MDialog:double({
    title = "放弃",
    text = "主厨，放弃挑战将会丢失本次进度\n确定要放弃吗？",
    okCallback = function()
      game:sendData(actionCodes.Activity_ltyAbandonChallengeRpc, MsgPack.pack(""))
      UIHelper.showWaiting()
      game:addResponseHandler(actionCodes.Activity_ltyAbandonChallengeRpc, function(event)
        UIHelper.removeWaiting()
        SysError(SYS_ERR_LTY_CARBON_GIVE_UP)
        BackManager:pop()
      end)
      return true
    end,
    cancelCallback = function()
      return true
    end
  })
end

function LtyCarbonLayer:showFormat()
  if not next(self.herosInfo) then
    SysError(SYS_ERR_TOWER_TEAM_NEED_HREO)
    return
  end
  local layer = game:createView("hero.FormationPresetLayer", {skip = true, battleType = "lty"})
  self:hide()
  BackManager:push(function()
    self:show()
    layer:close()
    TopBar:show(TopBarType.full, LtyTitleName)
  end)
end

function LtyCarbonLayer:showCure()
  local formatInfo = json.decode(game.role.ltyFormatInfo) or {}
  local herosInfo = json.decode(game.role.ltyHerosInfo) or {}
  formatInfo.list = formatInfo.list or {}
  local isHave = false
  for slot, id in pairs(formatInfo.list) do
    if id and herosInfo[tostring(id)] < 1000 then
      isHave = true
      break
    end
  end
  if isHave then
    game:createView("lty.LtyCureLayer", {
      autoBattle = self.autoBattle,
      callback = function(heroIds)
        if not next(heroIds) then
          return
        end
        game:sendData(actionCodes.Activity_ltyCureRpc, MsgPack.pack({ids = heroIds}))
        UIHelper.showWaiting()
        game:addResponseHandler(actionCodes.Activity_ltyCureRpc, function(event)
          UIHelper.removeWaiting()
          local result = MsgPack.unpack(event.data)
          SysError(SYS_ERR_TREAT_SUCCESS)
          self:initHeros()
          if self.autoBattle then
            self.timeLabel = self:ShowAutoTime(self.btnBattle, self.btnBattle, "秒后开始战斗", function()
              self:goBattle()
            end)
          end
        end)
      end
    })
  else
    SysError(SYS_ERR_TREAT_NO_HERO_NEEDED)
  end
end

function LtyCarbonLayer:onTouchBegan(sender)
  self.beginPos = sender:getTouchBeganPosition()
end

function LtyCarbonLayer:onTouchMoved(sender)
  local pos = sender:getTouchMovePosition()
  self:updateNodePos(pos)
end

function LtyCarbonLayer:onTouchEnded(sender)
  self.originX = self.node:getPositionX()
end

function LtyCarbonLayer:onTouchCancelled(sender)
  self:onTouchEnded(sender)
end

function LtyCarbonLayer:updateNodePos(pos)
  local tempX = self.beginPos.x - pos.x
  local endX = self.originX - tempX
  if 0 < endX then
    return
  end
  if endX < self.minPosX then
    return
  end
  self.node:setPositionX(endX)
end

function LtyCarbonLayer:updateIconNum()
  self.num1:setString(game.role.items[166] or 0)
  self.num2:setString(game.role.items[167] or 0)
end

function LtyCarbonLayer:onExit()
  for _, tag in pairs(self.handlers) do
    game.role:removeEventListener(tag)
  end
  if self.timerHandler then
    scheduler.unscheduleGlobal(self.timerHandler)
  end
end

return LtyCarbonLayer
