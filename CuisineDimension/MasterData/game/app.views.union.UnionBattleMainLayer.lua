local UnitCsv = require("csvdata.unit")
local FramCsv = require("csvdata.head_circle")
local PicCsv = require("csvdata.head_pic")
local PvpAiCsv = require("csvdata.pvp_ai")
local PvpRandCsv = require("csvdata.pvp_rank")
local DressCsv = require("csvdata.hero_skin")
local unionBattleRewardCsv = require("csvdata.union_battle_reward")
local FilterLogic = import("..friend.FilterFriendLogic")
local PvpRes = "ui/pvp/main/"
local UnionBattleRes = "ui/union/battle/"
local uiData = {
  csbFile = "ui/union/UnionBattleMainLayer.csb",
  widgets = {
    mainBg = "mainBg",
    downP = "downP",
    btnsBg = "btnsBg",
    btnRank = "btnsBg/btnRank",
    btnReward = "btnsBg/btnReward",
    btnRule = "btnsBg/btnRule",
    btnUnionRank = "btnsBg/btnUnionRank",
    btnUnionMembersRank = "btnsBg/btnUnionMembersRank",
    heroname1 = "herobg/heroname1",
    heroname2 = "herobg/heroname2",
    herolevel1 = "herobg/herolevel1",
    herolevel2 = "herobg/herolevel2",
    heroicon1 = "herobg/heroicon1",
    heroicon2 = "herobg/heroicon2",
    btnBattle = "downP/btnBattle",
    changeFormat = "downP/changeFormat",
    changeOrder = "downP/changeOrder",
    battleCount = "downP/battleCount",
    herosBigNode = "herosBigNode"
  }
}
local UnionBattleMainLayer = class("UnionBattleMainLayer", UIBase)

function UnionBattleMainLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function UnionBattleMainLayer:init(params)
  self:setPositionX(0)
  TopBar:show(TopBarType.back)
  TopBar:showAnimation(true)
  if UIHelper.isiPhoneX() then
    UIHelper.fitForiPhoneX(self.mainBg, true)
    self.btnsBg:setPositionX(self.btnsBg:getPositionX() - UIHelper.getMoveXForX() + 50)
    self.changeFormat:setPositionX(self.changeFormat:getPositionX() - UIHelper.getMoveXForX())
    self.changeOrder:setPositionX(self.changeOrder:getPositionX() - UIHelper.getMoveXForX())
    self.changeFormat:setPositionY(self.changeFormat:getPositionY() - 40)
    self.changeOrder:setPositionY(self.changeOrder:getPositionY() - 40)
  end
  self.handlers = {}
  self.formatInfo = game.role.activityStatus["89"].formatInfo or {}
  self.enemyInfo = params.enemyData
  self.enemyLevel = 1
  self.unionScore = 0
  self.friendFilter = FilterLogic.new({sortRule = "levelDesc"})
  self:getRankValue(function(msg)
    self.unionScore = msg.unionScore or 0
  end)
  self:refreshSelf(true)
  self:refreshEnemy()
  UIHelper.MoveToDown({
    node = self.btnsBg,
    time = 0.3
  })
  UIHelper.MoveToUp({
    node = self.downP,
    time = 0.3
  })
  self.timerHandler = scheduler.scheduleGlobal(function()
    game.role:checkRedPoint("unionBattle")
  end, 1)
end

function UnionBattleMainLayer:showData(params)
  local names = {
    "btnBattle",
    "changeFormat",
    "changeOrder",
    "btnRank",
    "btnReward",
    "btnRule",
    "btnUnionRank",
    "btnUnionMembersRank"
  }
  for _, name in pairs(names) do
    self[name]:setTouchScale()
  end
  local count = game.role.activityStatus["89"].battle_count or 0
  self.battleCount:setString(count .. "/" .. globalCsv.unionBattleCount)
  self.btnBattle:setCallback(function()
    local format = self.formatInfo.list or {}
    if not next(format) then
      SysError(SYS_ERR_PVP_TEAM_IS_EMPTY)
      return
    end
    local battleCount = game.role.activityStatus["89"].battle_count or 0
    if battleCount >= globalCsv.unionBattleCount then
      SysError(SYS_ERR_UNIONBATTLE_COUNT_LIMIT)
      return
    end
    game:sendData(actionCodes.Activity_unionBattleBeginBattleRpc, MsgPack.pack({}))
    UIHelper.showWaiting()
    game:addResponseHandler(actionCodes.Activity_unionBattleBeginBattleRpc, function(event)
      UIHelper.removeWaiting()
      local msg = MsgPack.unpack(event.data)
      game:enterScene("BattleScene", {
        type = BattleType.Union,
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
    local layer = game:createView("hero.FormationPresetLayer", {skip = true, battleType = "union"})
    self:hide()
    BackManager:push(function()
      self:show()
      layer:close()
      TopBar:show(TopBarType.back)
      self.formatInfo = game.role.activityStatus["89"].formatInfo
    end)
  end)
  self.changeOrder:setCallback(function()
    local format = self.formatInfo.list or {}
    if not next(format) then
      SysError(SYS_ERR_PVP_TEAM_IS_EMPTY)
      return
    end
    game:createView("union.UnionBattleSkillOrderLayer", {
      callback = function(result)
        game:sendData(actionCodes.Activity_unionBattleSkillOrderRpc, MsgPack.pack({skillOrder = result}))
        UIHelper.showWaiting()
        game:addResponseHandler(actionCodes.Activity_unionBattleSkillOrderRpc, function(event)
          UIHelper.removeWaiting()
          SysError(SYS_ERR_PVP_SKILL_ORDER_SUCCESS)
          self.formatInfo = game.role.activityStatus["89"].formatInfo
        end)
      end
    })
  end)
  self.btnRank:setCallback(function()
    local rank1 = game.UnionRank1 or {}
    local lastTime = cc.UserDefault:getInstance():getIntegerForKey("rank1", 0)
    if lastTime == 0 or game:nowTime() - lastTime > 60 or not next(rank1) then
      cc.UserDefault:getInstance():setIntegerForKey("rank1", game:nowTime())
      game:sendData(actionCodes.Activity_unionBattleGetRankRpc, MsgPack.pack({msgType = 1}))
      UIHelper.showWaiting()
      game:addResponseHandler(actionCodes.Activity_unionBattleGetRankRpc, function(event)
        UIHelper.removeWaiting()
        local msg = MsgPack.unpack(event.data)
        local rlist = {}
        for i, str in ipairs(msg.list) do
          local data = json.decode(str)
          table.insert(rlist, data)
        end
        table.sort(rlist, function(a, b)
          return a.score > b.score
        end)
        game.UnionRank1 = rlist
        game:createView("union.UnionBattleRankLayer", {rankList = rlist, msyType = 1})
      end)
    else
      game:createView("union.UnionBattleRankLayer", {rankList = rank1, msyType = 1})
    end
  end)
  self.btnUnionRank:setCallback(function()
    local rank2 = game.UnionRank2 or {}
    local lastTime = cc.UserDefault:getInstance():getIntegerForKey("rank2", 0)
    if lastTime == 0 or game:nowTime() - lastTime > 60 or not next(rank2) then
      cc.UserDefault:getInstance():setIntegerForKey("rank2", game:nowTime())
      game:sendData(actionCodes.Activity_unionBattleGetRankRpc, MsgPack.pack({msgType = 2}))
      UIHelper.showWaiting()
      game:addResponseHandler(actionCodes.Activity_unionBattleGetRankRpc, function(event)
        UIHelper.removeWaiting()
        local msg = MsgPack.unpack(event.data)
        local rlist = {}
        for i, str in ipairs(msg.list) do
          local data = json.decode(str)
          table.insert(rlist, data)
        end
        table.sort(rlist, function(a, b)
          return a.score > b.score
        end)
        game.UnionRank2 = rlist
        game:createView("union.UnionBattleRankLayer", {rankList = rlist, msyType = 2})
      end)
    else
      game:createView("union.UnionBattleRankLayer", {rankList = rank2, msyType = 2})
    end
  end)
  self.btnUnionMembersRank:setCallback(function()
    local rank3 = game.UnionRank3 or {}
    local lastTime = cc.UserDefault:getInstance():getIntegerForKey("rank3", 0)
    if lastTime == 0 or game:nowTime() - lastTime > 60 or not next(rank3) then
      cc.UserDefault:getInstance():setIntegerForKey("rank3", game:nowTime())
      game:sendData(actionCodes.Activity_unionBattleGetRankRpc, MsgPack.pack({msgType = 3}))
      UIHelper.showWaiting()
      game:addResponseHandler(actionCodes.Activity_unionBattleGetRankRpc, function(event)
        UIHelper.removeWaiting()
        local msg = MsgPack.unpack(event.data)
        msg.list = msg.list or {}
        local rlist = {}
        for i, str in ipairs(msg.list) do
          local data = json.decode(str)
          table.insert(rlist, data)
        end
        table.sort(rlist, function(a, b)
          return a.score > b.score
        end)
        game.UnionRank3 = rlist
        game:createView("union.UnionBattleRankLayer", {rankList = rlist, msyType = 3})
      end)
    else
      game:createView("union.UnionBattleRankLayer", {rankList = rank3, msyType = 3})
    end
  end)
  self.btnReward:setCallback(function()
    self:getRankValue(function(msg)
      game:createView("union.UnionBattleRewardLayer", msg)
    end)
  end)
  self.btnRule:setCallback(function()
    game:createView("global.RuleLayer", {
      typeStr = "union_battle"
    })
  end)
  table.insert(self.handlers, game.role:addEventListener("notifyNewMessage", function(event)
    if event.type == "unionBattle" then
      local bShow = checkbool(game.role.redPoints.unionBattle.reward) or self:checkUnionRewardRed()
      UIHelper.showRedPoint(self.btnReward, bShow, cc.p(0, 0), 0.6)
    end
  end))
end

function UnionBattleMainLayer:checkUnionRewardRed()
  local unionDatas = unionBattleRewardCsv[3]
  local reward_record = game.role.activityStatus["89"].reward_record or {}
  for idx, data in ipairs(unionDatas) do
    local done = next(reward_record) and reward_record[tostring(300 + data.rewardId)]
    local canGet = tonumber(self.unionScore) >= data.condition
    if not done and canGet then
      return true
    end
  end
  return false
end

function UnionBattleMainLayer:getRankValue(callBack)
  game:sendData(actionCodes.Activity_unionBattleQueryRankValueRpc, MsgPack.pack({}))
  UIHelper.showWaiting()
  game:addResponseHandler(actionCodes.Activity_unionBattleQueryRankValueRpc, function(event)
    UIHelper.removeWaiting()
    local msg = MsgPack.unpack(event.data)
    if type(callBack) == "function" then
      callBack(msg)
    end
  end)
end

function UnionBattleMainLayer:createHero(posx, posy, idx, show, hero)
  local viewNode = ccui.Widget:create()
  viewNode:setContentSize(cc.size(200, 476)):pos(posx, posy):addTo(self.herosBigNode)
  local card = UIHelper.newImageView(UnionBattleRes .. "unionbattle_main_hero_bg.png"):pos(100, 238):addTo(viewNode)
  if hero then
    card:setCallback(function()
      self:addHero(idx, hero.id)
    end)
    self.heros[hero.id] = idx
    local clip = UIHelper.getClipNode({
      steRes = UnionBattleRes .. "unionbattle_main_hero_mask.png"
    }):pos(100, 268):addTo(card)
    local bigCard = display.newSprite(UIHelper.getCardRes("list", hero.type, false, hero.quality)):pos(0, -50):scale(1.24):addTo(clip)
    UIHelper.newImageView(UnionBattleRes .. "unionbattle_main_hero_bg2.png"):center(card):addTo(card)
  else
    card:setCallback(function()
      self:addHero(idx)
    end)
    local cardBg = display.newSprite(UnionBattleRes .. "unionbattle_main_bg1.png"):pos(100, 238):addTo(card)
  end
  if show then
    card:hide()
    card:runAction(transition.sequence({
      cc.DelayTime:create((idx - 1) * 0.1),
      cc.CallFunc:create(function()
        card:show()
      end),
      cc.OrbitCamera:create(0.3, 1, 0, 0, 360, 0, 0)
    }))
  end
end

function UnionBattleMainLayer:refreshSelf(show)
  self.herosBigNode:removeAllChildren()
  self.heros = {}
  local format = self.formatInfo.list or {}
  local quality
  local posListX = {
    -400,
    -200,
    0,
    200,
    400
  }
  local posListY = {
    30,
    -10,
    -50,
    -10,
    30
  }
  for index = 1, 5 do
    local hero = game.role.heros[format[tostring(index)]]
    self:createHero(posListX[index], posListY[index], index, show, hero)
  end
  self.heroname1:setString(game.role.name)
  self.herolevel1:setString("等级：" .. (game.role.level or "1"))
  local bg = UIHelper.newImageView(PicCsv[game.role.headIconTag].res):scale(0.5):pos(0, 0):addTo(self.heroicon1)
  display.newSprite(FramCsv[game.role.headFrameTag].res):center(bg):addTo(bg)
end

function UnionBattleMainLayer:refreshEnemy()
  local data = self.enemyInfo
  self.heroname2:setString(data.name)
  self.herolevel2:setString("等级：" .. (data.level or "1"))
  local headIconTag = data.head or 1
  local headFrameTag = data.headFrameTag or 1
  local bg = UIHelper.newImageView(PicCsv[headIconTag].res):scale(0.5):pos(0, 0):addTo(self.heroicon2)
  display.newSprite(FramCsv[headFrameTag].res):center(bg):addTo(bg)
end

function UnionBattleMainLayer:addHero(slot, heroId)
  local function rule(hero)
    if hero.unit.star >= 5 or hero.unit.type == 540 or hero.unit.type == 638 or hero.unit.type == 639 or hero.unit.type == 336 or hero.unit.type == 138 or hero.unit.type == 237 or hero.unit.type == 438 or hero.unit.type == 541 or hero.unit.type == 542 then
      return true
    end
    return false
  end
  
  local layer = game:createView("union.ChooseUnionHeroLayer", {
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
        game:sendData(actionCodes.Activity_unionBattleFormatQuickRpc, MsgPack.pack({formation = list}))
        UIHelper.showWaiting()
        game:addResponseHandler(actionCodes.Activity_unionBattleFormatQuickRpc, function(event)
          UIHelper.removeWaiting()
          self.formatInfo = game.role.activityStatus["89"].formatInfo
          self:refreshSelf(false)
        end)
      elseif self:checkFormationSameHero(choose, slot) then
        SysError(SYS_ERR_TEAM_SAME_HERO)
        return true
      else
        game:sendData(actionCodes.Activity_unionBattleChangeFormatRpc, MsgPack.pack({slot = slot, heroId = choose}))
        UIHelper.showWaiting()
        game:addResponseHandler(actionCodes.Activity_unionBattleChangeFormatRpc, function(event)
          UIHelper.removeWaiting()
          self.formatInfo = game.role.activityStatus["89"].formatInfo
          self:refreshSelf(false)
        end)
      end
    end
  })
  self:hide()
  BackManager:push(function()
    TopBar:show(TopBarType.back)
    layer:close()
    self:show()
  end)
end

function UnionBattleMainLayer:checkFormationSameHero(choose, slot)
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

function UnionBattleMainLayer:foramtTeamInfo()
  local result = {
    heros = {}
  }
  if self.enemyInfo then
    self.enemyLevel = self.enemyInfo.level
    result = game.role:getPvpEnemyAttrs(self.enemyInfo.formatData)
  else
    print("data error")
  end
  return result
end

function UnionBattleMainLayer:getDressType(type, dress)
  local dressId = type * 10 + dress
  local dressSet = DressCsv[dressId]
  if not dressSet then
    return type
  else
    return dressSet.hero
  end
end

function UnionBattleMainLayer:onExit()
  for _, tag in pairs(self.handlers) do
    game.role:removeEventListener(tag)
  end
  if self.timerHandler then
    scheduler.unscheduleGlobal(self.timerHandler)
  end
end

return UnionBattleMainLayer
