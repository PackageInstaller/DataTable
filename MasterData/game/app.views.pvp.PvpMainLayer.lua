local UnitCsv = require("csvdata.unit")
local FramCsv = require("csvdata.head_circle")
local PicCsv = require("csvdata.head_pic")
local PvpAiCsv = require("csvdata.pvp_ai")
local PvpRandCsv = require("csvdata.pvp_rank")
local DressCsv = require("csvdata.hero_skin")
local FilterLogic = import("..friend.FilterFriendLogic")
local PvpRes = "ui/pvp/main/"
local uiData = {
  csbFile = "ui/pvp/PvpMainLayer.csb",
  widgets = {
    upBar = "upBar",
    mainBg = "mainBg",
    leftTime = "leftTime",
    battleTimes = "battleTimes",
    resetTime = "resetTime",
    heroNode1 = "heroNode1",
    heroNode2 = "heroNode2",
    downBar = "downBar",
    downP = "downP",
    herosNode1 = "downP/herosNode1",
    herosNode2 = "downP/herosNode2",
    changeTimes = "downP/btnBg2/changeTimes",
    btnBattle = "downP/btnBg1/btnBattle",
    changeFormat = "downP/changeFormat",
    changeOrder = "downP/changeOrder",
    changeEnemy = "downP/changeEnemy",
    btnRank = "downP/btnRank",
    btnInfo = "downP/btnInfo",
    btnShop = "btnShop",
    btnRule = "btnRule",
    btnBg2 = "downP/btnBg2",
    btnChange = "btnChange",
    friendNode = "friendNode",
    battleTimesBack = "downP/battleTimesBack"
  }
}
local PvpMainLayer = class("PvpMainLayer", UIBase)

function PvpMainLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function PvpMainLayer:init(params)
  self:setPositionX(0)
  TopBar:show(TopBarType.full, "对阵信息")
  TopBar:showAnimation(true)
  if UIHelper.isiPhoneX() then
    UIHelper.fitForiPhoneX(self.mainBg, true)
    UIHelper.fitForiPhoneX(self.downBar, true)
    UIHelper.fitForiPhoneX(self.upBar, true)
    self.btnChange:setPositionX(self.btnChange:getPositionX() - UIHelper.getMoveXForX() + 50)
    self.btnRule:setPositionX(self.btnRule:getPositionX() - UIHelper.getMoveXForX() + 50)
    self.btnShop:setPositionX(self.btnShop:getPositionX() - UIHelper.getMoveXForX() + 50)
    self.changeFormat:setPositionX(self.changeFormat:getPositionX() - UIHelper.getMoveXForX())
    self.changeOrder:setPositionX(self.changeOrder:getPositionX() - UIHelper.getMoveXForX())
    self.changeFormat:setPositionY(self.changeFormat:getPositionY() - 40)
    self.changeOrder:setPositionY(self.changeOrder:getPositionY() - 40)
    self.heroNode1:setPositionX(self.heroNode1:getPositionX() - UIHelper.getMoveXForX() / 2)
    self.heroNode2:setPositionX(self.heroNode2:getPositionX() + UIHelper.getMoveXForX() / 2)
    self.friendNode:setPositionX(self.friendNode:getPositionX() + UIHelper.getMoveXForX() / 2)
  end
  self.formatInfo = json.decode(game.role.pvpInfo.formatInfo)
  self.enemyInfo = json.decode(game.role.pvpInfo.enemyInfo)
  self.enemyLevel = 1
  self.friendFilter = FilterLogic.new({sortRule = "levelDesc"})
  if game.role.friendChanllage then
    self:changeUI()
  else
    self:initLeader()
  end
  self:refreshLabel()
  UIHelper.MoveToRight({
    node = self.heroNode1,
    time = 0.3,
    pos = {250, 0}
  })
  UIHelper.MoveToRight({
    node = self.btnShop,
    time = 0.2,
    pos = {150, 0}
  })
  UIHelper.MoveToRight({
    node = self.btnRule,
    time = 0.2,
    pos = {150, 0}
  })
  UIHelper.MoveToRight({
    node = self.btnChange,
    time = 0.2,
    pos = {150, 0}
  })
  UIHelper.MoveToLeft({
    node = self.heroNode2,
    time = 0.3,
    pos = {250, 0}
  })
  UIHelper.MoveToUp({
    node = self.friendNode,
    time = 0.3,
    pos = {0, 500}
  })
  UIHelper.MoveToUp({
    node = self.downP,
    time = 0.3
  })
  UIHelper.MoveToUp({
    node = self.downBar,
    time = 0.3
  })
  UIHelper.MoveToDown({
    node = self.upBar
  })
end

function PvpMainLayer:showData(params)
  self.changeTimes:setString(string.format("%d/%d", game.role.dailyPvpReset, globalCsv.pvpChangeEnemy))
  local names = {
    "btnBattle",
    "changeFormat",
    "changeOrder",
    "changeEnemy",
    "btnRank",
    "btnInfo",
    "btnShop",
    "btnRule",
    "btnChange"
  }
  for _, name in pairs(names) do
    self[name]:setTouchScale()
  end
  self.changeEnemy:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#4c3605"), 1)
  self.changeEnemy:setCallback(function()
    if game.role.dailyPvpReset < 1 then
      SysError(SYS_ERR_PVP_CHANGE_ENEMY_TIMES_OUT)
      return
    end
    game:sendData(actionCodes.Pvp_resetRpc, MsgPack.pack({}))
    UIHelper.showWaiting()
    game:addResponseHandler(actionCodes.Pvp_resetRpc, function(event)
      UIHelper.removeWaiting()
      self.enemyInfo = json.decode(game.role.pvpInfo.enemyInfo)
      self.changeTimes:setString(string.format("%d/%d", game.role.dailyPvpReset, globalCsv.pvpChangeEnemy))
      self:initLeader(2)
    end)
  end)
  self.btnBattle:setCallback(function()
    local format = self.formatInfo.list or {}
    if not next(format) then
      SysError(SYS_ERR_PVP_TEAM_IS_EMPTY)
      return
    end
    if game.role.friendChanllage then
      if not (self.enemyInfo[1] and self.enemyInfo[1].player) or not next(self.enemyInfo[1].player.formatData) then
        return
      end
      game:sendData(actionCodes.Friend_battleBeginRpc, MsgPack.pack({}))
      UIHelper.showWaiting()
      game:addResponseHandler(actionCodes.Friend_battleBeginRpc, function(event)
        UIHelper.removeWaiting()
        local newmsg = MsgPack.unpack(event.data)
        game.role.__battleKey = newmsg.battleKey
        game:enterScene("BattleScene", {
          type = BattleType.PvP,
          leftInfo = game.role:getPvpAttrs(self.formatInfo),
          rightInfo = self:foramtTeamInfo(),
          rightLevel = self.enemyLevel
        })
      end)
      return
    end
    if 1 > game.role.pvpInfo.times then
      SysError(SYS_ERR_PVP_BATTLE_TIMES_OUT)
      return
    end
    game:sendData(actionCodes.Pvp_battleBeginRpc, MsgPack.pack({}))
    UIHelper.showWaiting()
    game:addResponseHandler(actionCodes.Pvp_battleBeginRpc, function(event)
      UIHelper.removeWaiting()
      local msg = MsgPack.unpack(event.data)
      game.role.__battleKey = msg.battleKey
      game:enterScene("BattleScene", {
        type = BattleType.PvP,
        leftInfo = game.role:getPvpAttrs(self.formatInfo),
        rightInfo = self:foramtTeamInfo(),
        rightLevel = self.enemyLevel
      })
    end)
  end)
  self.changeFormat:setCallback(function()
    local format = self.formatInfo.list or {}
    if not next(format) then
      SysError(SYS_ERR_PVP_TEAM_IS_EMPTY)
      return
    end
    local layer = game:createView("hero.FormationPresetLayer", {skip = true, battleType = "pvp"})
    self:hide()
    BackManager:push(function()
      self:show()
      layer:close()
      TopBar:show(TopBarType.full, "对阵信息")
      self.formatInfo = json.decode(game.role.pvpInfo.formatInfo)
    end)
  end)
  self.changeOrder:setCallback(function()
    local format = self.formatInfo.list or {}
    if not next(format) then
      SysError(SYS_ERR_PVP_TEAM_IS_EMPTY)
      return
    end
    game:createView("pvp.PvpSkillOrderLayer", {
      callback = function(result)
        game:sendData(actionCodes.Pvp_skillOrderRpc, MsgPack.pack({skillOrder = result}))
        UIHelper.showWaiting()
        game:addResponseHandler(actionCodes.Pvp_skillOrderRpc, function(event)
          UIHelper.removeWaiting()
          SysError(SYS_ERR_PVP_SKILL_ORDER_SUCCESS)
          self.formatInfo = json.decode(game.role.pvpInfo.formatInfo)
        end)
      end
    })
  end)
  local timeTab = globalCsv.pvpRsetTime:toArray("=", true)
  local delay = 0
  local endTime = 0
  local nowTime = game:nowTime()
  local time = CommonHelper.date(nowTime)
  local weekDay = time.wday - 1
  if weekDay == 0 then
    weekDay = 7
  end
  if weekDay ~= 1 or time.hour < timeTab[1] / 100 or time.hour >= timeTab[2] / 100 then
    local temp_time = nowTime + 86400 * (8 - weekDay)
    local temp_date = CommonHelper.date(temp_time)
    endTime = CommonHelper.time({
      year = temp_date.year,
      month = temp_date.month,
      day = temp_date.day,
      hour = timeTab[1] / 100
    })
  end
  
  local function refreshLeftTime()
    self.leftTime:runAction(transition.sequence({
      cc.DelayTime:create(delay),
      cc.CallFunc:create(function()
        local left = (endTime - game:nowTime()) % 604800
        if 0 < left then
          if 86400 < left then
            local day, delta = math.modf(left / 86400)
            local hour = delta * 24
            delay = left % 3600 + 1
            self.leftTime:setString(string.format("%d天%d小时", day, hour))
          else
            delay = 1
            self.leftTime:setString(UIHelper.getTimeStr(left))
          end
          refreshLeftTime()
        else
          self.leftTime:setString("00:00:00")
          self.changeEnemy:setTouchEnabled(false)
          self.btnBattle:setTouchEnabled(false)
        end
      end)
    }))
  end
  
  refreshLeftTime()
  self.btnRank:setCallback(function()
    local rankList = {}
    game.role.pvpInfo.rankListInfo = game.role.pvpInfo.rankListInfo or {}
    if not game.role.pvpInfo.rankListInfo.time or game:nowTime() - game.role.pvpInfo.rankListInfo.time > 60 then
      NetManager:sendData(actionCodes.Pvp_getRankRpc, MsgPack.pack(""))
      UIHelper.showWaiting()
      NetManager:addResponseHandler(actionCodes.Pvp_getRankRpc, function(event)
        UIHelper.removeWaiting()
        local result = MsgPack.unpack(event.data)
        for _, data in ipairs(result.list) do
          table.insert(rankList, data)
        end
        if result.finish then
          game.role.pvpInfo.rankListInfo = {
            time = game:nowTime(),
            list = rankList
          }
          NetManager:removeResponseHandler(actionCodes.Pvp_getRankRpc)
          game:createView("pvp.PvpRankLayer", {rankList = rankList})
        end
      end, true)
    else
      game:createView("pvp.PvpRankLayer", {
        rankList = game.role.pvpInfo.rankListInfo.list
      })
    end
  end)
  self.btnInfo:setCallback(function()
    game:createView("pvp.PvpRankDesLayer")
  end)
  self.btnShop:setCallback(function()
    local layer = game:createView("shop.ShopLayer", {curType = 2, selected = 1})
    BackManager:push(function()
      layer:close()
      TopBar:show(TopBarType.full, "对阵信息")
    end)
  end)
  self.btnRule:setCallback(function()
    game:createView("global.RuleLayer", {
      res = "ui/pvp/main/image_rule.png"
    })
  end)
  self.btnChange:setCallback(function()
    game.role.friendChanllage = not game.role.friendChanllage
    self:changeUI()
  end)
end

function PvpMainLayer:changeUI()
  if game.role.friendChanllage then
    self:friendList()
    self.enemyInfo = {
      {
        player = {
          formatData = {}
        }
      }
    }
  else
    self.friendNode:removeAllChildren()
    self.enemyInfo = json.decode(game.role.pvpInfo.enemyInfo)
  end
  self.btnBg2:setVisible(not game.role.friendChanllage)
  self.battleTimesBack:setVisible(not game.role.friendChanllage)
  self.changeEnemy:setVisible(not game.role.friendChanllage)
  self:initLeader()
end

function PvpMainLayer:initLeader(who)
  if not who then
    self:refreshSelf()
    self:refreshEnemy()
  elseif who == 1 then
    self:refreshSelf()
  else
    self:refreshEnemy()
  end
end

function PvpMainLayer:refreshSelf()
  self.heroNode1:removeAllChildren()
  self.herosNode1:removeAllChildren()
  self.heros = {}
  local format = self.formatInfo.list or {}
  local heroType, quality
  local xPos = 0
  for index = 1, 5 do
    local hero = game.role.heros[format[tostring(index)]]
    if hero then
      local card = HeroHead.new({
        heroId = hero.id,
        level = hero.level,
        quality = hero.quality,
        loveEffect = true,
        loveBreak = hero.loveBreak,
        showTreeTag = hero:showTreeTag()
      }):scale(0.9):pos(xPos, 0):addTo(self.herosNode1)
      card:setCallback(function()
        self:addHero(index, hero.id)
      end)
      heroType = heroType or hero:getDressType()
      quality = quality or hero.quality
      self.heros[hero.id] = index
    else
      local card = UIHelper.newImageView("ui/kitchen/quality/bg_1.png"):scale(0.9):pos(xPos, 0):addTo(self.herosNode1)
      UIHelper.newImageView("ui/global/item_frame.png"):center(card):addTo(card)
      UIHelper.newImageView("ui/global/add.png"):pos(46, 53):addTo(card)
      display.newTTFLabel({
        text = "添加食灵",
        size = 14,
        color = UIHelper.hex2rgb("#b3a27e")
      }):pos(45, 25):addTo(card)
      card:setCallback(function()
        self:addHero(index)
      end)
      card:setCascadeOpacityEnabled(true)
    end
    xPos = xPos + 87
  end
  if heroType then
    HeroBigCard.new({
      type = heroType,
      showPic = true,
      quality = quality
    }):scale(0.8):addTo(self.heroNode1)
  end
  if game.role.friendChanllage then
    return
  end
  local detailBg = display.newSprite(PvpRes .. "detail_bg.png"):pos(-150, 0):addTo(self.heroNode1)
  display.newSprite(PvpRandCsv[game.role.pvpInfo.group or 1].res):pos(40, 75):addTo(detailBg)
  display.newTTFLabel({
    text = PvpRandCsv[game.role.pvpInfo.group or 1].name,
    size = 18,
    color = UIHelper.hex2rgb("#906433")
  }):pos(40, 30):addTo(detailBg)
  display.newTTFLabel({
    text = game.role.name,
    size = 20,
    color = UIHelper.hex2rgb("#906433")
  }):anch(0, 0.5):pos(70, 95):addTo(detailBg)
  display.newTTFLabel({
    text = "学园点数：" .. game.role.pvpInfo.score,
    size = 18,
    color = UIHelper.hex2rgb("#906433")
  }):anch(0, 0.5):pos(70, 70):addTo(detailBg)
  display.newTTFLabel({
    text = "排名：" .. (game.role.pvpInfo.rank or "暂无"),
    size = 18,
    color = UIHelper.hex2rgb("#906433")
  }):anch(0, 0.5):pos(70, 45):addTo(detailBg)
  display.newTTFLabel({
    text = "星星：",
    size = 18,
    color = UIHelper.hex2rgb("#906433")
  }):anch(0, 0.5):pos(70, 20):addTo(detailBg)
  local moneyBg = display.newSprite(PvpRes .. "money_bg.png"):pos(154, 18):addTo(detailBg)
  display.newTTFLabel({
    text = game.role.items[13] or 0,
    size = 20
  }):pos(39, 13):addTo(moneyBg)
  local bg = UIHelper.newImageView(PicCsv[game.role.headIconTag].res):scale(0.5):pos(225, 20):addTo(detailBg)
  display.newSprite(FramCsv[game.role.headFrameTag].res):center(bg):addTo(bg)
end

function PvpMainLayer:refreshEnemy()
  self.heroNode2:removeAllChildren()
  self.herosNode2:removeAllChildren()
  local data, heroType, quality
  local xPos = 0
  if self.enemyInfo[1].ai then
    data = PvpAiCsv[self.enemyInfo[1].ai]
    local teams = data.team:toTableArray(" ")
    for index, heroData in ipairs(teams) do
      local HeroType = tonumber(heroData[1])
      HeroHead.new({type = HeroType, level = 5}):scale(0.9):pos(xPos, 0):addTo(self.herosNode2)
      xPos = xPos + 87
      heroType = heroType or HeroType
      quality = quality or 1
    end
  else
    data = self.enemyInfo[1]
    for index = 1, 5 do
      local heroData = data.player.formatData[tostring(index)]
      if heroData then
        local type = self:getDressType(heroData.type, heroData.dress)
        heroType = heroType or type
        quality = quality or heroData.quality
        HeroHead.new({
          type = type,
          awake = heroData.awake,
          star = UnitCsv[type].star,
          level = heroData.level,
          sauceMax = heroData.isBest,
          quality = heroData.quality,
          loveEffect = true,
          loveBreak = heroData.loveBreak,
          treeMax = heroData.treeMax,
          showTreeTag = heroData.showTreeTag == 1
        }):scale(0.9):pos(xPos, 0):addTo(self.herosNode2)
      else
        local card = UIHelper.newImageView("ui/kitchen/quality/bg_1.png"):scale(0.9):pos(xPos, 0):addTo(self.herosNode2)
        display.newSprite("ui/kitchen/quality/cook.png"):center(card):addTo(card)
        UIHelper.newImageView("ui/global/item_frame.png"):center(card):addTo(card)
        card:setCascadeOpacityEnabled(true)
      end
      xPos = xPos + 87
    end
  end
  if heroType then
    HeroBigCard.new({
      type = heroType,
      showPic = true,
      quality = quality
    }):scale(0.8):addTo(self.heroNode2)
  end
  if game.role.friendChanllage then
    return
  end
  local detailBg = display.newSprite(PvpRes .. "detail_bg.png"):pos(90, 0):addTo(self.heroNode2)
  display.newSprite(PvpRandCsv[data.group or 1].res):pos(40, 75):addTo(detailBg)
  display.newTTFLabel({
    text = PvpRandCsv[data.group or 1].name,
    size = 18,
    color = UIHelper.hex2rgb("#906433")
  }):pos(40, 30):addTo(detailBg)
  display.newTTFLabel({
    text = data.name or data.player.name,
    size = 20,
    color = UIHelper.hex2rgb("#906433")
  }):anch(0, 0.5):pos(70, 85):addTo(detailBg)
  display.newTTFLabel({
    text = "学园点数：" .. data.score,
    size = 18,
    color = UIHelper.hex2rgb("#906433")
  }):anch(0, 0.5):pos(70, 60):addTo(detailBg)
  display.newTTFLabel({
    text = "排名：" .. (data.rank or "暂无"),
    size = 18,
    color = UIHelper.hex2rgb("#906433")
  }):anch(0, 0.5):pos(70, 35):addTo(detailBg)
  local headIconTag = data.player and data.player.headIconTag or data.headIconTag or 1
  local headFrameTag = data.player and data.player.headFrameTag or data.headFrameTag or 1
  local bg = UIHelper.newImageView(PicCsv[headIconTag].res):scale(0.5):pos(225, 20):addTo(detailBg)
  display.newSprite(FramCsv[headFrameTag].res):center(bg):addTo(bg)
end

function PvpMainLayer:refreshLabel()
  self.battleTimes:setString(string.format("对决次数:%d/%d", game.role.pvpInfo.times, globalCsv.pvpStore))
  self.battleTimesBack:setString(string.format("%d/%d", game.role.pvpInfo.times, globalCsv.pvpStore))
  if game.role.pvpInfo.regainTime == 0 then
    self.resetTime:stopAllActions()
    self.resetTime:hide()
    return
  else
    self.resetTime:show()
  end
  local endTime = game.role.pvpInfo.regainTime + globalCsv.pvpRegainTime * 3600
  
  local function update()
    self.resetTime:runAction(transition.sequence({
      cc.DelayTime:create(1),
      cc.CallFunc:create(function()
        local left = endTime - game:nowTime()
        if 0 < left then
          self.resetTime:setString(string.format("(%s后恢复)", UIHelper.getTimeStr(left)))
          update()
        else
          game:sendData(actionCodes.Pvp_enterPvpRpc, MsgPack.pack({}))
          UIHelper.showWaiting()
          game:addResponseHandler(actionCodes.Pvp_enterPvpRpc, function(event)
            UIHelper.removeWaiting()
            local msg = MsgPack.unpack(event.data)
            game.role.pvpInfo.group = msg.group
            game.role.pvpInfo.rank = msg.rank
            self:refreshLabel()
            self:refreshSelf()
          end)
        end
      end)
    }))
  end
  
  update()
end

function PvpMainLayer:addHero(slot, heroId)
  local layer = game:createView("pvp.ChoosePvpHeroLayer", {
    heroId = heroId,
    max = 5,
    rule = rule,
    choosed = self.heros,
    callback = function(choose)
      if type(choose) == "table" then
        local list = {}
        for index, data in pairs(choose) do
          local hero = game.role.heros[data.id]
          if hero then
            list[tostring(data.slot)] = data.id
          end
        end
        game:sendData(actionCodes.Pvp_formatQuickRpc, MsgPack.pack({formation = list}))
        UIHelper.showWaiting()
        game:addResponseHandler(actionCodes.Pvp_formatQuickRpc, function(event)
          UIHelper.removeWaiting()
          self.formatInfo = json.decode(game.role.pvpInfo.formatInfo)
          self:refreshSelf()
        end)
      elseif self:checkFormationSameHero(choose, slot) then
        SysError(SYS_ERR_TEAM_SAME_HERO)
        return true
      else
        game:sendData(actionCodes.Pvp_changeFormatRpc, MsgPack.pack({slot = slot, heroId = choose}))
        UIHelper.showWaiting()
        game:addResponseHandler(actionCodes.Pvp_changeFormatRpc, function(event)
          UIHelper.removeWaiting()
          self.formatInfo = json.decode(game.role.pvpInfo.formatInfo)
          self:refreshSelf()
        end)
      end
    end
  })
  self:hide()
  BackManager:push(function()
    TopBar:show(TopBarType.full, "对阵信息")
    layer:close()
    self:show()
  end)
end

function PvpMainLayer:checkFormationSameHero(choose, slot)
  if choose == 0 then
    return false
  end
  local hero = game.role.heros[choose]
  for id, index in pairs(self.heros) do
    local tempHero = game.role.heros[id]
    if tempHero.type == hero.type and choose ~= id then
      return true
    end
  end
  return false
end

function PvpMainLayer:foramtTeamInfo()
  local result = {
    heros = {}
  }
  if self.enemyInfo[1].player then
    self.enemyLevel = self.enemyInfo[1].player.level
    result = game.role:getPvpEnemyAttrs(self.enemyInfo[1].player.formatData)
  else
    local format = {}
    local tempheros = {}
    local data = PvpAiCsv[self.enemyInfo[1].ai]
    local teams = data.team:toTableArray(" ")
    self.enemyLevel = data.roleLevel or self.enemyLevel
    for slot, types in pairs(teams) do
      local heroInfo = {}
      local heroData = UnitCsv[tonumber(types[1])]
      heroInfo.id = tonumber(slot)
      heroInfo.type = heroData.type
      heroInfo.quality = 0
      heroInfo.fieldLevel = 1
      heroInfo.hp = heroData.hp
      heroInfo.fullHp = heroData.hp
      heroInfo.atk = heroData.atk
      heroInfo.atkSpeed = heroData.atkSpeed
      heroInfo.crit = heroData.crit
      heroInfo.critHurt = heroData.critHurt
      heroInfo.hit = heroData.hit
      heroInfo.miss = heroData.miss
      heroInfo.phyDef = heroData.phyDef
      heroInfo.skillInfo = {}
      heroInfo.pvpSkillOrder = tonumber(slot)
      table.insert(result.heros, heroInfo)
      tempheros[tonumber(slot)] = {
        type = heroData.type,
        fieldLevel = 1
      }
      format[tonumber(slot)] = tonumber(slot)
    end
    result.formatEffect = FormatLogic.getActiveEffect(format, tempheros)
  end
  return result
end

function PvpMainLayer:getDressType(type, dress)
  local dressId = type * 10 + dress
  local dressSet = DressCsv[dressId]
  if not dressSet then
    return type
  else
    return dressSet.hero
  end
end

function PvpMainLayer:friendList()
  local bg = display.newSprite(PvpRes .. "friend_bg.png"):anch(0.5, 1):pos(0, 0):addTo(self.friendNode)
  local list = ccui.ListView:create()
  list:size(cc.size(510, 386))
  list:setInnerContainerSize(cc.size(510, 386))
  list:setClippingEnabled(true)
  list:setBounceEnabled(true)
  list:anch(0, 0):pos(15, 22):addTo(bg)
  self.curRow = 0
  if not self.friends then
    game:sendData(actionCodes.Friend_listRpc, MsgPack.pack({}))
    UIHelper.showWaiting()
    game:addResponseHandler(actionCodes.Friend_listRpc, function(event)
      UIHelper.removeWaiting()
      local msg = MsgPack.unpack(event.data)
      self.friends = msg.list
      self.friendFilter:setSource(self.friends)
      self.shows = self.friendFilter:getResult()
      self.refreshHandler = scheduler.scheduleGlobal(function()
        self:refreshListWithDelay(list)
      end, 0.016666666666666666)
    end)
  else
    self.friendFilter:setSource(self.friends)
    self.shows = self.friendFilter:getResult()
    self.refreshHandler = scheduler.scheduleGlobal(function()
      self:refreshListWithDelay(list)
    end, 0.016666666666666666)
  end
end

function PvpMainLayer:refreshListWithDelay(list)
  for row = self.curRow + 1, self.curRow + 10 do
    if row > #self.shows then
      if self.refreshHandler then
        scheduler.unscheduleGlobal(self.refreshHandler)
        self.refreshHandler = nil
      end
      if not next(self.shows) then
        display.newTTFLabel({
          text = "主厨，您暂时还没有好友哦",
          size = 22,
          color = UIHelper.hex2rgb("#842c17")
        }):center(list):addTo(list)
      end
      list:requestDoLayout()
      return
    end
    local data = self.shows[row]
    local viewNode = UIHelper.extend(ccui.Widget:create())
    viewNode:size(cc.size(510, 78)):addTo(list)
    local cell = display.newSprite(PvpRes .. "friend_cell.png"):center(viewNode):addTo(viewNode)
    local bg = UIHelper.newImageView(PicCsv[data.headIconTag].res):scale(0.6):pos(70, 37):addTo(cell)
    display.newSprite(FramCsv[data.headFrameTag].res):scale(0.8):center(bg):addTo(bg)
    display.newTTFLabel({
      text = "Lv" .. data.level,
      size = 20,
      color = UIHelper.hex2rgb("#ba471a")
    }):anch(0, 0.5):pos(140, 60):addTo(cell)
    local space = game:nowTime() - data.lastLoginTime
    display.newTTFLabel({
      text = "最后上线: " .. UIHelper.getPassTimeDesc(space),
      size = 16,
      color = UIHelper.hex2rgb("#ba471a")
    }):anch(0, 0.5):pos(280, 60):addTo(cell)
    display.newTTFLabel({
      text = data.name,
      size = 24,
      color = UIHelper.hex2rgb("#ba471a")
    }):anch(0, 0.5):pos(130, 30):addTo(cell)
    local btnBattle = UIHelper.extend(ccui.Button:create())
    btnBattle:setImages("ui/friend/main/", {
      "btn_against.png",
      "btn_against.png"
    })
    btnBattle:pos(473, 37):addTo(cell):setTouchScale()
    btnBattle:setCallback(function()
      game:sendData(actionCodes.Friend_battleInfoRpc, MsgPack.pack({
        roleId = data.roleId
      }))
      UIHelper.showWaiting()
      game:addResponseHandler(actionCodes.Friend_battleInfoRpc, function(event)
        UIHelper.removeWaiting()
        local msg = MsgPack.unpack(event.data)
        if msg.result then
          local sysTip = {SYS_ERROR_FRIEND_NO_PLAYER, SYS_ERROR_FRIEND_NO_PVP}
          SysError(sysTip[msg.result])
        else
          self.enemyInfo = msg.enemyInfo
          self:initLeader(2)
        end
      end)
    end)
    display.newTTFLabel({text = "查看", size = 18}):pos(32, 25):addTo(btnBattle)
  end
  self.curRow = self.curRow + 10
end

function PvpMainLayer:onExit()
  if self.refreshHandler then
    scheduler.unscheduleGlobal(self.refreshHandler)
  end
end

return PvpMainLayer
