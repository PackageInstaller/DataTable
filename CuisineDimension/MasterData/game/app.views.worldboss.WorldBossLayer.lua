local MainRes = "ui/activity/main/"
local BtnsRes = "ui/activity/btns/"
local CarbonRes = "ui/general/carbon/"
local FormationRes = "ui/activity/62/"
local UnionRes = "ui/union/main/"
local ShopRes = "ui/shop/main/"
local ScoreRes = "ui/autumn/score/"
local RankRes = "ui/tower/rank/"
local WorldbossRes = "ui/activity/worldboss/"
local PicCsv = require("csvdata.head_pic")
local FramCsv = require("csvdata.head_circle")
local UnitCsv = require("csvdata.unit")
local ShopCsv = require("csvdata.worldboss_shop")
local DressCsv = require("csvdata.hero_skin")
local RewardCsv = require("csvdata.worldboss_reward")
local WorldBossLayer = class("WorldBossLayer", UIBase)
local uiData = {
  csbFile = "ui/worldboss/WorldBossLayer.csb",
  widgets = {
    bg = "bg",
    battleNode = "battleNode",
    rankAndRewardNode = "rankAndRewardNode",
    up = "up"
  }
}

function WorldBossLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function WorldBossLayer:init(params)
  if UIHelper.isiPhoneX() then
    UIHelper.fitForiPhoneX(self.bg)
    UIHelper.fitForiPhoneX(self.up, true)
  end
  if params.type then
    self.jumpType = params.type
  end
  TopBar:show(TopBarType.full, "降临之战")
  TopBar:showAnimation(true)
  UIHelper.MoveToDown({
    node = self.up
  })
  self.status = game.role.activityStatus["69"]
  self.battleNum = self.status.extraBattleTimes + self.status.buyTimes - self.status.battleTimes
  self.buyBattleNum = globalCsv.WorldBossTimes - self.status.buyTimes
  self.teamChoose = self.status.team
  self.priceList = globalCsv.WorldBossPrice:toArray("=", true)
  self.refreshShopPrice = globalCsv.WorldBossRefresh
  self.serverHurt = 0
  self.skillStatusList = self.status.buffStr:toNumMap()
  self.skills = {}
  self.extraBufflist = {}
  for i, data in pairs(self.skillStatusList) do
    if data then
      for k = 1, data do
        local skillList = ShopCsv[i].buffget:toArray("=", true)
        for j, data in ipairs(skillList) do
          table.insert(self.skills, tonumber(data))
        end
      end
    end
  end
  self:initBattleNode()
  self:initRankAndRewardNode()
end

function WorldBossLayer:initBattleNode()
  local chooseTeamBtn = UIHelper.extend(ccui.Button:create())
  chooseTeamBtn:setImages(WorldbossRes, {
    "bigButton.png",
    "bigButton.png"
  })
  chooseTeamBtn:pos(179, 555):addTo(self.battleNode)
  chooseTeamBtn:setTouchScale()
  chooseTeamBtn:setCallback(function()
    local layer = game:createView("hero.BattleListLayer", {
      battleType = BattleType.Worldboss,
      battle = "召唤",
      callback = function(choose)
        if not choose or choose == "" then
          return
        end
        game:sendData(actionCodes.World_changeTeamRpc, MsgPack.pack({choose = choose}))
        UIHelper.showWaiting()
        game:addResponseHandler(actionCodes.World_changeTeamRpc, function(event)
          UIHelper.removeWaiting()
          self.teamChoose = choose
          local battleValue = game.role:getTotalBattleValue(self.teamChoose)
          self.extraBufflist = {}
          for i, value in ipairs(globalCsv.WorldBossBuffIndex) do
            if value >= battleValue then
              local buffStr = globalCsv.WorldBossBuffList[value]
              local bufflist = buffStr:toArray("=", true)
              for i, buffId in ipairs(bufflist) do
                table.insert(self.extraBufflist, buffId)
              end
              break
            end
          end
          BackManager:pop()
        end)
      end
    })
    BackManager:push(function()
      TopBar:show(TopBarType.full, "降临之战")
      layer:close()
    end)
  end)
  display.newTTFLabel({
    text = "选择编队",
    size = 24
  }):enableOutline(UIHelper.hex2rgb("#502801"), 1):center(chooseTeamBtn):addTo(chooseTeamBtn)
  local bossIcon = UIHelper.newImageView(WorldbossRes .. "bossCard.png"):anch(0.5, 0.5):pos(179, 309):addTo(self.battleNode)
  local bossInfoBtn = UIHelper.extend(ccui.Button:create())
  bossInfoBtn:setImages(WorldbossRes, {
    "btn_info.png",
    "btn_info.png"
  })
  bossInfoBtn:pos(288, 386):addTo(bossIcon)
  bossInfoBtn:setTouchScale()
  bossInfoBtn:setCallback(function()
    game:createView("global.RuleLayer", {typeStr = "worldBoss"})
  end)
  local startBtn = UIHelper.extend(ccui.Button:create())
  startBtn:setImages(WorldbossRes, {"btn_2.png", "btn_1.png"})
  startBtn:pos(96.5, 45):addTo(self.battleNode)
  startBtn:setCallback(function()
    if self.battleNum <= 0 then
      if 0 >= self.buyBattleNum then
        SysError(SYS_ERR_HALLOWEEN_CANDLE_NOT_ENOUGH)
        return
      else
        MDialog:double({
          title = "提示",
          text = "挑战次数不足，是否购买挑战次数？",
          okCallback = function()
            local layer = game:createView("worldboss.WorldBossBuyCountLayer", {
              maxNum = self.buyBattleNum
            })
            BackManager:push(function()
              layer:close()
              self:refreshBattleNum()
            end)
            return true
          end,
          cancelCallback = function()
            return true
          end
        })
        return
      end
    end
    if self.teamChoose == 0 or self.teamChoose == "" then
      MDialog:single({
        title = "提示",
        text = "主厨还没有选择上阵编队哦，请先选择编队"
      }, function()
        local layer = game:createView("hero.BattleListLayer", {
          battleType = BattleType.Worldboss,
          battle = "召唤",
          callback = function(choose)
            if not choose or choose == "" then
              return
            end
            self.teamChoose = choose
            game:sendData(actionCodes.World_changeTeamRpc, MsgPack.pack({choose = choose}))
            UIHelper.showWaiting()
            game:addResponseHandler(actionCodes.World_changeTeamRpc, function(event)
              UIHelper.removeWaiting()
              self.teamChoose = choose
              BackManager:pop()
            end)
          end
        })
        BackManager:push(function()
          TopBar:show(TopBarType.full, "降临之战")
          layer:close()
        end)
      end)
      return
    end
    local status = game.role:getFormationState(self.teamChoose)
    if status[1] or status[2] or status[3] then
      SysError(SYS_ERR_TEAM_BUSY)
      return
    end
    local battleValue = game.role:getTotalBattleValue(self.teamChoose)
    self.extraBufflist = {}
    for i, value in ipairs(globalCsv.WorldBossBuffIndex) do
      if value >= battleValue then
        local buffStr = globalCsv.WorldBossBuffList[value]
        local bufflist = buffStr:toArray("=", true)
        for i, buffId in ipairs(bufflist) do
          table.insert(self.extraBufflist, buffId)
        end
        break
      end
    end
    game:sendData(actionCodes.World_beginBattleRpc, MsgPack.pack({
      teamChoose = self.teamChoose,
      leftInfo = game.role:getMJAttrs(self.teamChoose)
    }))
    UIHelper.showWaiting()
    game:addResponseHandler(actionCodes.World_beginBattleRpc, function(event)
      UIHelper.removeWaiting()
      local serverId = game.role.serverId
      local bossHp = globalCsv.WorldBossBattleBlood
      game:enterScene("BattleScene", {
        type = BattleType.Worldboss,
        bossType = serverId,
        bossDegree = 5,
        format = self.teamChoose,
        leftInfo = game.role:getMJAttrs(self.teamChoose),
        bossHp = bossHp,
        skills = self.skills,
        buffs = self.extraBufflist
      })
    end)
  end)
  display.newTTFLabel({
    text = "进入战斗",
    size = 22
  }):enableOutline(UIHelper.hex2rgb("#502801"), 1):pos(72.5, 23):addTo(startBtn)
  self.battleNumText = display.newTTFLabel({
    text = "剩余次数:" .. self.battleNum .. "次",
    size = 16,
    color = UIHelper.hex2rgb("#efb625")
  }):pos(72.5, 64):addTo(startBtn)
  self.buyBtn = UIHelper.extend(ccui.Button:create())
  self.buyBtn:setImages(WorldbossRes, {"btn_2.png", "btn_1.png"})
  self.buyBtn:pos(258.5, 45):addTo(self.battleNode)
  self.buyBtn:setCallback(function()
    if self.buyBattleNum <= 0 then
      SysError(SYS_ERR_HALLOWEEN_CANDLE_NOT_ENOUGH)
      return
    elseif game.role.diamond < self.priceList[globalCsv.WorldBossTimes + 1 - self.buyBattleNum] then
      SysError(SYS_ERR_SHOP_ACTIVITY_SCORE_NOT_ENOUGH)
      return
    else
      local layer = game:createView("worldboss.WorldBossBuyCountLayer", {
        maxNum = self.buyBattleNum
      })
      BackManager:push(function()
        layer:close()
        self:refreshBattleNum()
      end)
      return
    end
  end)
  if globalCsv.WorldBossTimes + 1 - self.buyBattleNum > #self.priceList then
    self.buyPriceText = display.newTTFLabel({
      text = "次数不足",
      size = 22
    }):enableOutline(UIHelper.hex2rgb("#502801"), 1):anch(0.5, 0.5):pos(72.5, 23):addTo(self.buyBtn)
    self.buyBtn:setEnabled(false)
  else
    self.buyPriceText = display.newTTFLabel({
      text = self.priceList[globalCsv.WorldBossTimes + 1 - self.buyBattleNum] .. "钻石",
      size = 22
    }):enableOutline(UIHelper.hex2rgb("#502801"), 1):anch(0.5, 0.5):pos(72.5, 23):addTo(self.buyBtn)
  end
  self.buyBattleNumText = display.newTTFLabel({
    text = "剩余购买次数:" .. self.buyBattleNum .. "次",
    size = 16,
    color = UIHelper.hex2rgb("#efb625")
  }):pos(72.5, 64):addTo(self.buyBtn)
end

function WorldBossLayer:initRankAndRewardNode()
  local playerPt = display.newSprite(WorldbossRes .. "btn_add_bg.png")
  playerPt:anch(0.5, 0.5):pos(505, 555):addTo(self.rankAndRewardNode)
  local playerText = display.newTTFLabel({
    text = game.role.worldBossHurt,
    size = 32
  }):enableOutline(UIHelper.hex2rgb("#502801"), 1):pos(180, 30):addTo(playerPt)
  display.newSprite(WorldbossRes .. "fragment.png"):anch(0.5, 0.5):pos(30, 30):addTo(playerPt)
  local unionPt = display.newSprite(WorldbossRes .. "btn_add_bg.png")
  unionPt:anch(0.5, 0.5):pos(887, 555):addTo(self.rankAndRewardNode)
  local globalPT = display.newTTFLabel({text = "20", size = 30}):enableOutline(UIHelper.hex2rgb("#502801"), 1):pos(155, 30):addTo(unionPt)
  game:sendData(actionCodes.World_getRankRpc, MsgPack.pack({msgType = 3}))
  UIHelper.showWaiting()
  game:addResponseHandler(actionCodes.World_getRankRpc, function(event)
    UIHelper.removeWaiting()
    local msg = MsgPack.unpack(event.data)
    if not msg.serverHurt then
      msg.serverHurt = 0
    end
    globalPT:setString("全服进度:" .. msg.serverHurt)
    self.serverHurt = tonumber(msg.serverHurt)
    if self.jumpType then
      if self.jumpType == 1 then
        self:getPlayerRankData()
      elseif self.jumpType == 2 then
        self:getUnionRankData()
      elseif self.jumpType == 3 then
        self:refreshShop()
      elseif self.jumpType == 4 then
        self:refreshPlayerReward()
      else
        self:refreshServerReward()
      end
    else
      self:getPlayerRankData()
    end
  end)
  self.buttonData = {
    [1] = {
      name = "个人排名",
      pos = {417, 492},
      callback = handler(self, self.getPlayerRankData)
    },
    [2] = {
      name = "协会排名",
      pos = {569, 492},
      callback = handler(self, self.getUnionRankData)
    },
    [3] = {
      name = "备战商店",
      pos = {721, 492},
      callback = handler(self, self.refreshShop)
    },
    [4] = {
      name = "个人奖励",
      pos = {873, 492},
      callback = handler(self, self.refreshPlayerReward)
    },
    [5] = {
      name = "全服奖励",
      pos = {1025, 492},
      callback = handler(self, self.refreshServerReward)
    }
  }
  local group1 = MRadioGroup:create({
    chooseCb = function(sender)
      sender:setImages(WorldbossRes, {
        "button2.png",
        "button2.png"
      })
    end,
    unchooseCb = function(sender)
      sender:setImages(WorldbossRes, {
        "button1.png",
        "button1.png"
      })
    end
  })
  for index, data in ipairs(self.buttonData) do
    local btn = UIHelper.extend(ccui.Button:create())
    btn:name("btn" .. index)
    btn:setImages(WorldbossRes, {
      "button1.png",
      "button1.png"
    })
    btn:pos(data.pos[1], data.pos[2]):addTo(self.rankAndRewardNode)
    btn:setCallback(function()
      data.callback(self)
    end)
    display.newTTFLabel({
      text = data.name,
      size = 24
    }):enableOutline(UIHelper.hex2rgb("#502801"), 1):pos(70, 20):addTo(btn)
    btn:setGroup(group1)
  end
  if self.jumpType then
    group1:chooseByName("btn" .. self.jumpType)
  else
    group1:chooseByName("btn" .. 1)
  end
  local rankAndRewardBg = display.newSprite(WorldbossRes .. "rankAndRewardBg.png")
  rankAndRewardBg:anch(0.5, 0.5):pos(721, 244.5):addTo(self.rankAndRewardNode)
  self.rankAndRewardContentNode = cc.Node:create()
  self.rankAndRewardContentNode:pos(721, 244.5):addTo(self.rankAndRewardNode)
end

function WorldBossLayer:getPlayerRankData()
  game:sendData(actionCodes.World_getRankRpc, MsgPack.pack({msgType = 1}))
  UIHelper.showWaiting()
  game:addResponseHandler(actionCodes.World_getRankRpc, function(event)
    UIHelper.removeWaiting()
    local msg = MsgPack.unpack(event.data)
    local ranklist = {}
    for i, data in ipairs(msg.list) do
      local playerData = json.decode(data)
      table.insert(ranklist, playerData)
    end
    table.sort(ranklist, function(a, b)
      return a.score > b.score
    end)
    self:refreshPlayerRank(ranklist)
  end)
end

function WorldBossLayer:refreshPlayerRank(ranklist)
  self.rankAndRewardContentNode:removeAllChildren()
  local list = ccui.ListView:create()
  list:size(cc.size(708, 410))
  list:setInnerContainerSize(cc.size(708, 410))
  list:setClippingEnabled(true)
  list:anch(0.5, 0.5):pos(0, 0):addTo(self.rankAndRewardContentNode)
  local isSelf = false
  self.lastChoose = nil
  for i, playerData in ipairs(ranklist) do
    playerData.pt = math.floor(playerData.score / 100)
    playerData.count = playerData.score % 100
    local rankColor = isSelf and "#ffe13c" or "#ffffff"
    local cell = UIHelper.newImageView(WorldbossRes .. (isSelf and "playerCellSelf.png" or "playerCell.png")):addTo(list)
    display.newSprite(RankRes .. "detail_close.png"):pos(660, 30):addTo(cell):name("tag")
    cell.idx = i
    cell:setCallback(function()
      local oldY = list:getInnerContainerPosition().y
      local oldHeight = list:getInnerContainerSize().height
      
      local function updatePos()
        list:doLayout()
        local newHeight = list:getInnerContainerSize().height
        local newY = oldY - (newHeight - oldHeight)
        if 0 < newY then
          newY = 0
        end
        if newY < list:getContentSize().height - newHeight then
          newY = list:getContentSize().height - newHeight
        end
        list:stopAutoScroll()
        list:setInnerContainerPosition({x = 0, y = newY})
      end
      
      if self.lastChoose then
        list:removeItem(list:getIndex(self.lastChoose) + 1)
        self.lastChoose:getChildByName("tag"):setTexture(RankRes .. "detail_close.png")
        if self.lastChoose.idx == i then
          self.lastChoose = nil
          updatePos()
          return
        end
      end
      list:insertCustomItem(self:createDetail(playerData), i)
      cell:getChildByName("tag"):setTexture(RankRes .. "detail_open.png")
      updatePos()
      self.lastChoose = cell
    end)
    display.newTTFLabel({
      text = i,
      size = 40,
      color = UIHelper.hex2rgb(rankColor)
    }):enableOutline(UIHelper.hex2rgb("#000000"), 1):anch(0.5, 0.5):pos(35, 30):addTo(cell)
    local bg = UIHelper.newImageView(PicCsv[playerData.headIconTag].res):addTo(cell):pos(94, 30):scale(0.38)
    display.newSprite(FramCsv[playerData.headFrameTag].res):center(bg):addTo(bg)
    local nameLabel = display.newTTFLabel({
      text = playerData.name,
      size = 20,
      color = UIHelper.hex2rgb("#703802")
    }):anch(0, 0.5):pos(130, 28):addTo(cell)
    local battleNumLabel = display.newTTFLabel({
      text = string.format("挑战次数: %d次", playerData.count),
      size = 20,
      color = UIHelper.hex2rgb("#703802")
    }):anch(0, 0.5):pos(310, 28):addTo(cell)
    local temp = playerData.pt
    local lastWord = ""
    if playerData.pt > 10000000000 then
      temp = playerData.pt / 100000000
      lastWord = "亿"
    elseif playerData.pt > 1000000 then
      temp = playerData.pt / 10000
      lastWord = "万"
    end
    MRichText.new({
      text = string.format("总伤害:%d", temp) .. lastWord,
      size = 24,
      color = UIHelper.hex2rgb("#703802")
    }):anch(0, 0.5):pos(460, 30):addTo(cell)
  end
end

function WorldBossLayer:getUnionRankData()
  game:sendData(actionCodes.World_getRankRpc, MsgPack.pack({msgType = 2}))
  UIHelper.showWaiting()
  game:addResponseHandler(actionCodes.World_getRankRpc, function(event)
    UIHelper.removeWaiting()
    local msg = MsgPack.unpack(event.data)
    local ranklist = {}
    for i, str in ipairs(msg.list) do
      local data = json.decode(str)
      table.insert(ranklist, data)
    end
    table.sort(ranklist, function(a, b)
      return a.score > b.score
    end)
    self:refreshUnionRank(ranklist)
  end)
end

function WorldBossLayer:refreshUnionRank(ranklist)
  self.rankAndRewardContentNode:removeAllChildren()
  self.unionlist = ccui.ListView:create()
  self.unionlist:size(cc.size(692, 398))
  self.unionlist:setInnerContainerSize(cc.size(692, 398))
  self.unionlist:setClippingEnabled(true)
  self.unionlist:setBounceEnabled(false)
  self.unionlist:anch(0.5, 0.5):pos(0, 0):addTo(self.rankAndRewardContentNode)
  if #ranklist == 0 then
    local bg = display.newSprite("ui/hero/tip_bg.png"):center(self.unionlist):addTo(self.unionlist)
    display.newTTFLabel({
      text = "暂时没有数据",
      size = 26,
      color = UIHelper.hex2rgb("#842c17")
    }):pos(395, 120):addTo(bg)
  else
    for row = 1, math.min(50, #ranklist) do
      local data = ranklist[row]
      if data then
        data.pt = data.score
        self:createCell(data)
      end
    end
  end
end

function WorldBossLayer:refreshShop()
  self.rankAndRewardContentNode:removeAllChildren()
  local shopStatus = self.status.shop:toTableArray()
  local showCsv = {}
  for _, data in pairs(shopStatus) do
    local item = ShopCsv[tonumber(data[1])]
    item.status = tonumber(data[2])
    table.insert(showCsv, item)
  end
  for row = 1, 2 do
    for col = 1, 4 do
      local index = (row - 1) * 4 + col
      local data = showCsv[index]
      if data.status == 0 then
        local cell = UIHelper.newImageView(WorldbossRes .. "shopCell.png"):anch(0, 0):pos(-332 + (col - 1) * 174, 31.5 - (row - 1) * 176):addTo(self.rankAndRewardContentNode)
        display.newSprite(data.icon):scale(0.75):pos(71, 98):addTo(cell)
        display.newTTFLabel({
          text = data.desc,
          size = 18,
          color = UIHelper.hex2rgb("#c44507")
        }):pos(71, 50):addTo(cell)
        display.newSprite("ui/global/" .. data.costId .. ".png"):scale(0.35):pos(50, 24):addTo(cell)
        display.newTTFLabel({
          text = data.cost,
          size = 22,
          color = UIHelper.hex2rgb("#703902")
        }):anch(0, 0.5):pos(70, 25):addTo(cell)
        cell:setCallback(function()
          MDialog:rich({
            title = "提示",
            text = string.format("是否花费<img src='ui/global/%d.png' scale=0.5 />", data.costId) .. data.cost .. "购买道具" .. data.title .. "？\n ",
            type = 2,
            desc = [[

 ]] .. "<div color=#817462>" .. data.detail .. "</div>"
          }, function()
            local temp
            if data.costId == 5 then
              temp = game.role.diamond
            elseif data.costId <= 4 then
              temp = game.role["material" .. data.costId]
            else
              temp = game.role.items[data.costId] or 0
            end
            if temp < data.cost then
              SysError(SYS_ERR_SHOP_ACTIVITY_SCORE_NOT_ENOUGH)
              return
            end
            game:sendData(actionCodes.World_buyItemsRpc, MsgPack.pack({
              id = data.id
            }))
            UIHelper.showWaiting()
            game:addResponseHandler(actionCodes.World_buyItemsRpc, function(event)
              UIHelper.removeWaiting()
              self.status = game.role.activityStatus["69"]
              self.skillStatusList = self.status.buffStr:toNumMap()
              self.skills = {}
              for i, data in pairs(self.skillStatusList) do
                if data then
                  for k = 1, data do
                    local skillList = ShopCsv[i].buffget:toArray("=", true)
                    for j, data in ipairs(skillList) do
                      table.insert(self.skills, tonumber(data))
                    end
                  end
                end
              end
              self:refreshShop()
            end)
            return true
          end, function()
            return true
          end)
        end)
      end
    end
  end
  local haveBoughtBtn = UIHelper.extend(ccui.Button:create())
  haveBoughtBtn:setImages(WorldbossRes, {
    "buffshow_btn.png",
    "buffshow_btn.png"
  })
  haveBoughtBtn:pos(-170, -177):addTo(self.rankAndRewardContentNode)
  haveBoughtBtn:setTouchScale()
  haveBoughtBtn:setCallback(function()
    local temp = ""
    for id, count in pairs(self.skillStatusList) do
      temp = temp .. "x " .. count .. "  " .. ShopCsv[id].detail .. [[

 
]]
    end
    string.sub(temp, 1, -2)
    game:createView("worldboss.WorldBossBuffListLayer", {
      title = "拥有buff",
      contentText = temp,
      size = 18
    })
  end)
  local refreshShopBtn = UIHelper.extend(ccui.Button:create())
  refreshShopBtn:setImages(WorldbossRes, {
    "refreshShop.png",
    "refreshShop.png"
  })
  refreshShopBtn:pos(271, -177):addTo(self.rankAndRewardContentNode)
  refreshShopBtn:setTouchScale()
  refreshShopBtn:setCallback(function()
    MDialog:double({
      title = "提示",
      text = "是否花费" .. self.refreshShopPrice .. "钻刷新商店物品？",
      okCallback = function()
        if game.role.diamond < self.refreshShopPrice then
          SysError(SYS_ERR_SHOP_ACTIVITY_SCORE_NOT_ENOUGH)
          return
        end
        game:sendData(actionCodes.World_refreshRpc, MsgPack.pack({}))
        UIHelper.showWaiting()
        game:addResponseHandler(actionCodes.World_refreshRpc, function(event)
          UIHelper.removeWaiting()
          self.status = game.role.activityStatus["69"]
          self:refreshShop()
        end)
        return true
      end,
      cancelCallback = function()
        return true
      end
    })
  end)
  local shopText = display.newSprite(WorldbossRes .. "shopText.png")
  shopText:pos(78, -177):addTo(self.rankAndRewardContentNode)
end

function WorldBossLayer:refreshPlayerReward()
  self.rankAndRewardContentNode:removeAllChildren()
  local list = ccui.ListView:create()
  list:size(cc.size(700, 410))
  list:setInnerContainerSize(cc.size(700, 410))
  list:setClippingEnabled(true)
  list:anch(0.5, 0.5):pos(0, 0):addTo(self.rankAndRewardContentNode)
  local cellSize = display.newSprite(WorldbossRes .. "rewardCell.png"):getContentSize()
  cellSize.height = cellSize.height + 16
  local rewardCount = #RewardCsv[1]
  local rewardStatus = self.status.reward:toNumMap()
  local row = math.ceil(rewardCount / 5)
  for i = 1, row do
    local viewNode = ccui.Widget:create()
    viewNode:setContentSize(cellSize):addTo(list)
    local cell = display.newSprite(WorldbossRes .. "rewardCell.png"):center(viewNode):addTo(viewNode)
    local xPos, delta = 104, 123
    for col = 1, 5 do
      if rewardCount >= (i - 1) * 5 + col then
        local data = RewardCsv[1][(i - 1) * 5 + col]
        local bg = display.newSprite(WorldbossRes .. "rewardItem.png"):pos(xPos, 57):addTo(cell)
        local item = data.gift:toArray("=", true)
        ItemIcon.new({
          type = item[1],
          count = item[2],
          showTip = true
        }):scale(0.6):pos(47, 50):addTo(bg)
        local conditionText = display.newTTFLabel({
          text = data.condition,
          size = 16
        }):enableOutline(UIHelper.hex2rgb("#793f07"), 1):anch(0.5, 0.5):pos(45, 12):addTo(bg)
        display.newSprite(WorldbossRes .. "fragment.png"):scale(0.35):pos(-15, 7):addTo(conditionText)
        local done = rewardStatus and rewardStatus[data.phase * 1000 + data.id] or 0
        if game.role.worldBossHurt >= data.condition then
          local red
          if done == 0 then
            red = display.newSprite(ScoreRes .. "red.png"):pos(47, 45):addTo(bg)
            local touch = UIHelper.extend(ccui.Layout:create())
            touch:setContentSize(cc.size(94, 93)):anch(0.5, 0.5):center(bg):addTo(bg)
            touch:setSwallowTouches(true)
            touch:setCallback(function()
              game:sendData(actionCodes.World_getRewardRpc, MsgPack.pack({
                id = data.id,
                msgType = 1
              }))
              UIHelper.showWaiting()
              game:addResponseHandler(actionCodes.World_getRewardRpc, function(event)
                UIHelper.removeWaiting()
                self.status = game.role.activityStatus["69"]
                local msg = MsgPack.unpack(event.data)
                red:setTexture(ScoreRes .. "done.png")
                MedalRewardLayer.new({
                  items = msg.reward
                })
                touch:removeSelf()
              end)
            end)
          else
            red = display.newSprite(ScoreRes .. "done.png"):pos(47, 45):addTo(bg)
          end
        end
        xPos = 770 <= xPos and 104 or xPos + delta
      end
    end
  end
end

function WorldBossLayer:refreshServerReward()
  self.rankAndRewardContentNode:removeAllChildren()
  local list = ccui.ListView:create()
  list:size(cc.size(700, 410))
  list:setInnerContainerSize(cc.size(700, 410))
  list:setClippingEnabled(true)
  list:anch(0.5, 0.5):pos(0, 0):addTo(self.rankAndRewardContentNode)
  local cellSize = display.newSprite(WorldbossRes .. "rewardCell.png"):getContentSize()
  cellSize.height = cellSize.height + 16
  local rewardCount = #RewardCsv[2]
  local rewardStatus = self.status.reward:toNumMap()
  local row = math.ceil(rewardCount / 5)
  for i = 1, row do
    local viewNode = ccui.Widget:create()
    viewNode:setContentSize(cellSize):addTo(list)
    local cell = display.newSprite(WorldbossRes .. "rewardCell.png"):center(viewNode):addTo(viewNode)
    local xPos, delta = 104, 123
    for col = 1, 5 do
      if rewardCount >= (i - 1) * 5 + col then
        local data = RewardCsv[2][(i - 1) * 5 + col]
        local bg = display.newSprite(WorldbossRes .. "rewardItem.png"):pos(xPos, 57):addTo(cell)
        local item = data.gift:toArray("=", true)
        ItemIcon.new({
          type = item[1],
          count = item[2],
          showTip = true
        }):scale(0.6):pos(47, 50):addTo(bg)
        display.newTTFLabel({
          text = data.condition,
          size = 16
        }):enableOutline(UIHelper.hex2rgb("#793f07"), 1):anch(0.5, 0.5):pos(45, 12):addTo(bg)
        local done = rewardStatus and rewardStatus[data.phase * 1000 + data.id] or 0
        if self.serverHurt >= data.condition then
          local red
          if done == 0 then
            red = display.newSprite(ScoreRes .. "red.png"):pos(47, 45):addTo(bg)
            local touch = UIHelper.extend(ccui.Layout:create())
            touch:setContentSize(cc.size(94, 93)):anch(0.5, 0.5):center(bg):addTo(bg)
            touch:setSwallowTouches(true)
            touch:setCallback(function()
              game:sendData(actionCodes.World_getRewardRpc, MsgPack.pack({
                id = data.id,
                msgType = 2
              }))
              UIHelper.showWaiting()
              game:addResponseHandler(actionCodes.World_getRewardRpc, function(event)
                UIHelper.removeWaiting()
                self.status = game.role.activityStatus["69"]
                local msg = MsgPack.unpack(event.data)
                red:setTexture(ScoreRes .. "done.png")
                MedalRewardLayer.new({
                  items = msg.reward
                })
                touch:removeSelf()
              end)
            end)
          else
            red = display.newSprite(ScoreRes .. "done.png"):pos(47, 45):addTo(bg)
          end
        end
        xPos = 770 <= xPos and 104 or xPos + delta
      end
    end
  end
end

function WorldBossLayer:refreshBattleNum()
  self.status = game.role.activityStatus["69"]
  self.battleNum = self.status.extraBattleTimes + self.status.buyTimes - self.status.battleTimes
  self.buyBattleNum = globalCsv.WorldBossTimes - self.status.buyTimes
  self.battleNumText:setString("剩余次数:" .. self.battleNum .. "次")
  if globalCsv.WorldBossTimes + 1 - self.buyBattleNum > #self.priceList then
    self.buyPriceText:setString("次数不足")
    self.buyBtn:setEnabled(false)
  else
    self.buyPriceText:setString(self.priceList[globalCsv.WorldBossTimes + 1 - self.buyBattleNum] .. "钻石")
  end
  self.buyBattleNumText:setString("本周剩余购买次数:" .. self.buyBattleNum .. "次")
end

function WorldBossLayer:createDetail(data)
  local di = UIHelper.newImageView(WorldbossRes .. "playerTeam.png")
  local battleValue = (data.battleValue or 0) + CommonHelper.getOtherBattleValue(data.formatData, data.jobExp, data.jobStage)
  display.newTTFLabel({
    text = "美味度: " .. battleValue,
    size = 24,
    color = UIHelper.hex2rgb("#784627")
  }):anch(0.5, 0.5):pos(580, 48):addTo(di)
  
  local function getDressType(type, dress)
    local dressId = type * 10 + dress
    local dressSet = DressCsv[dressId]
    if not dressSet then
      return type
    else
      return dressSet.hero
    end
  end
  
  local xPos, yPos, interval = 77, 48, 85
  local count = 0
  for slot = 1, 5 do
    local heroData = data.formatData[tostring(slot)]
    if heroData then
      HeroHead.new({
        type = getDressType(heroData.type, heroData.dress),
        awake = heroData.awake,
        star = UnitCsv[heroData.type].star,
        treeMax = heroData.treeMax,
        sauceMax = heroData.isBest,
        level = heroData.level,
        quality = heroData.quality,
        loveEffect = true,
        loveBreak = heroData.loveBreak
      }):scale(0.8):pos(xPos + interval * count, yPos):addTo(di)
      count = count + 1
    end
  end
  return di
end

function WorldBossLayer:createCell(data)
  local viewNode = ccui.Widget:create()
  viewNode:setContentSize(cc.size(692, 136)):addTo(self.unionlist)
  local cell = display.newSprite(WorldbossRes .. "unionCell.png"):pos(346, 76):addTo(viewNode)
  local iconBg = display.newSprite(WorldbossRes .. string.format("icon_bg_%d.png", data.headId)):pos(55.5, 62.5):addTo(cell)
  display.newSprite(WorldbossRes .. string.format("icon_%d.png", data.headId)):center(iconBg):addTo(iconBg)
  display.newTTFLabel({
    text = data.name,
    size = 28,
    color = UIHelper.hex2rgb("#fdfffa")
  }):enableOutline(UIHelper.hex2rgb("#431b05"), 1):anch(0, 0.5):pos(150, 86):addTo(cell)
  display.newTTFLabel({
    text = data.desc == "" and "無" or data.desc,
    size = 16,
    color = UIHelper.hex2rgb("#fdfffa"),
    dimensions = cc.size(640, 0)
  }):enableOutline(UIHelper.hex2rgb("#e0b03"), 1):anch(0, 0.5):pos(124, 27):addTo(cell)
  local temp = data.pt
  local lastWord = ""
  if data.pt > 10000000000 then
    temp = data.pt / 100000000
    lastWord = "亿"
  elseif data.pt > 1000000 then
    temp = data.pt / 10000
    lastWord = "万"
  end
  display.newTTFLabel({
    text = string.format("总伤害:%d", temp) .. lastWord,
    size = 24,
    color = UIHelper.hex2rgb("#703802")
  }):anch(0, 0.5):pos(430, 87):addTo(cell)
end

return WorldBossLayer
