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
local RewardCsv = require("csvdata.newboss_reward")
local NewWorldBossLayer = class("NewWorldBossLayer", UIBase)
local uiData = {
  csbFile = "ui/worldboss/WorldBossLayer.csb",
  widgets = {
    bg = "bg",
    battleNode = "battleNode",
    rankAndRewardNode = "rankAndRewardNode",
    up = "up"
  }
}
local bossCnt = 2
local currentRightPanel = 0

function NewWorldBossLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function NewWorldBossLayer:init(params)
  if UIHelper.isiPhoneX() then
    UIHelper.fitForiPhoneX(self.bg)
    UIHelper.fitForiPhoneX(self.up, true)
  end
  if params.type then
    self.jumpType = params.type
  end
  TopBar:show(TopBarType.full, "协会副本")
  TopBar:showAnimation(true)
  UIHelper.MoveToDown({
    node = self.up
  })
  self.priceList = globalCsv.WorldBossPrice:toArray("=", true)
  self.refreshShopPrice = globalCsv.WorldBossRefresh
  self.serverHurt = 0
  self.skillStatusList = {}
  self.skills = {}
  self.extraBufflist = {}
  self.bossIndex = 1
  self:_onBossIndexChange()
  self.roleScore = 1000000
  self.unionScore = 20000
  self:initBattleNode()
  self:initRankAndRewardNode()
end

function NewWorldBossLayer:_onBossIndexChange()
  self.formatInfo = game.role.activityStatus["107"][tostring(self.bossIndex)].formation or {
    list = {},
    pos = {}
  }
  self.rewardStatus = game.role.activityStatus["107"][tostring(self.bossIndex)].reward_record or {}
  self:update_title()
end

function NewWorldBossLayer:update_title()
  local titleName = string.format("newboss_title_%d.png", self.bossIndex)
  if self.title then
    self.title:setImage(WorldbossRes .. titleName)
  else
    self.title = UIHelper.newImageView(WorldbossRes .. titleName):pos(179, 560):addTo(self.battleNode)
  end
end

function NewWorldBossLayer:initBattleNode()
  self.battleNum = 10
  self.buyBattleNum = 10
  local bossIcon = UIHelper.newImageView(WorldbossRes .. "newbossCard_" .. self.bossIndex .. ".png"):anch(0.5, 0.5):pos(179, 309):addTo(self.battleNode)
  local prevBtn = UIHelper.extend(ccui.Button:create())
  prevBtn:setImages(WorldbossRes, {
    "btnPrev.png",
    "btnPrev.png"
  })
  prevBtn:pos(20, 200):addTo(bossIcon)
  prevBtn:setCallback(function()
    self.bossIndex = self.bossIndex - 1
    if self.bossIndex < 1 then
      self.bossIndex = bossCnt
    end
    self:_onBossIndexChange()
    bossIcon:setImage(WorldbossRes .. "newbossCard_" .. self.bossIndex .. ".png")
    self:refreshRightPanel()
  end)
  local nextBtn = UIHelper.extend(ccui.Button:create())
  nextBtn:setImages(WorldbossRes, {
    "btnNext.png",
    "btnNext.png"
  })
  nextBtn:pos(288, 200):addTo(bossIcon)
  nextBtn:setCallback(function()
    self.bossIndex = self.bossIndex + 1
    if self.bossIndex > bossCnt then
      self.bossIndex = 1
    end
    self:_onBossIndexChange()
    bossIcon:setImage(WorldbossRes .. "newbossCard_" .. self.bossIndex .. ".png")
    self:refreshRightPanel()
  end)
  local bossInfoBtn = UIHelper.extend(ccui.Button:create())
  bossInfoBtn:setImages(WorldbossRes, {
    "btn_info.png",
    "btn_info.png"
  })
  bossInfoBtn:pos(288, 386):addTo(bossIcon)
  bossInfoBtn:setTouchScale()
  bossInfoBtn:setCallback(function()
    game:createView("global.RuleLayer", {
      typeStr = "newWorldBoss"
    })
  end)
  local selectFormBtn = UIHelper.extend(ccui.Button:create())
  selectFormBtn:setImages(WorldbossRes, {"btn_2.png", "btn_1.png"})
  selectFormBtn:pos(250, 45):addTo(self.battleNode)
  selectFormBtn:setCallback(function()
    local layer = game:createView("worldboss.NewWorldBossFormLayer", {
      battleType = BattleType.Worldboss,
      battle = "召唤",
      bossIdx = self.bossIndex,
      callback = function(formatInfo)
        self.formatInfo = formatInfo
      end
    })
    BackManager:push(function()
      TopBar:show(TopBarType.full, "协会副本")
      layer:close()
    end)
  end)
  display.newTTFLabel({
    text = "选择编队",
    size = 22
  }):enableOutline(UIHelper.hex2rgb("#502801"), 1):pos(72.5, 23):addTo(selectFormBtn)
  local startBtn = UIHelper.extend(ccui.Button:create())
  startBtn:setImages(WorldbossRes, {"btn_2.png", "btn_1.png"})
  startBtn:pos(96.5, 45):addTo(self.battleNode)
  startBtn:setCallback(function()
    if self.bossIndex == 2 and globalCsv.NewWorldBoss2rdDate > game:nowTime() then
      MDialog:single({
        title = "提示",
        text = "boss开启时间：" .. os.date("%Y-%m-%d %H:%M:%S", globalCsv.NewWorldBoss2rdDate)
      })
      return
    end
    if self.formatInfo.list == nil or not next(self.formatInfo.list) then
      MDialog:single({
        title = "提示",
        text = "主厨还没有选择上阵编队哦，请先选择编队"
      }, function()
        local layer = game:createView("worldboss.NewWorldBossFormLayer", {
          battleType = BattleType.Worldboss,
          bossIdx = self.bossIndex,
          battle = "召唤",
          callback = function(formatInfo)
            self.formatInfo = formatInfo
          end
        })
        BackManager:push(function()
          TopBar:show(TopBarType.full, "协会副本")
          layer:close()
        end)
      end)
      return
    end
    game:sendData(actionCodes.Activity_newWorldBossBeginBattleRpc, MsgPack.pack({
      bossIdx = self.bossIndex
    }))
    UIHelper.showWaiting()
    game:addResponseHandler(actionCodes.Activity_newWorldBossBeginBattleRpc, function(event)
      UIHelper.removeWaiting()
      local serverId = game.role.serverId
      local bossHp = globalCsv.WorldBossBattleBlood
      game:enterScene("BattleScene", {
        type = BattleType.NewWorldboss,
        bossIdx = self.bossIndex,
        bossType = serverId,
        bossDegree = 5,
        format = 0,
        leftInfo = game.role:getPvpAttrs(self.formatInfo),
        bossHp = bossHp,
        skills = self.skills,
        buffs = self.extraBufflist
      })
      self:close()
    end)
  end)
  display.newTTFLabel({
    text = "进入战斗",
    size = 22
  }):enableOutline(UIHelper.hex2rgb("#502801"), 1):pos(72.5, 23):addTo(startBtn)
end

function getScoreText(score)
  local temp = score
  local lastWord = ""
  if 10000000000 < score then
    temp = score / 100000000
    lastWord = "亿"
  elseif 1000000 < score then
    temp = score / 10000
    lastWord = "万"
  end
  temp = string.format("%.0f", temp)
  return temp .. lastWord
end

function NewWorldBossLayer:refreshScore()
  self.playerText:setString("个人伤害：" .. getScoreText(self.roleScore))
  self.unionText:setString("协会伤害：" .. getScoreText(self.unionScore))
end

function NewWorldBossLayer:initRankAndRewardNode()
  local playerPt = display.newSprite(WorldbossRes .. "btn_add_bg.png")
  playerPt:anch(0.5, 0.5):pos(505, 555):addTo(self.rankAndRewardNode)
  self.playerText = display.newTTFLabel({
    text = game.role.worldBossHurt,
    size = 28
  }):enableOutline(UIHelper.hex2rgb("#502801"), 1):anch(0, 0.5):pos(10, 30):addTo(playerPt)
  local unionPt = display.newSprite(WorldbossRes .. "btn_add_bg.png")
  unionPt:anch(0.5, 0.5):pos(887, 555):addTo(self.rankAndRewardNode)
  self.unionText = display.newTTFLabel({text = "20", size = 28}):enableOutline(UIHelper.hex2rgb("#502801"), 1):anch(0, 0.5):pos(10, 30):addTo(unionPt)
  self:refreshScore()
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
      name = "个人奖励",
      pos = {721, 492},
      callback = handler(self, self.refreshPlayerReward)
    },
    [4] = {
      name = "协会奖励",
      pos = {873, 492},
      callback = handler(self, self.refreshUnionReward)
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
  self:getPlayerRankData()
end

function NewWorldBossLayer:getPlayerRankData()
  self.jumpType = 1
  self.rankAndRewardContentNode:removeAllChildren()
  game:sendData(actionCodes.Activity_newWorldBossGetRankRpc, MsgPack.pack({
    bossIdx = self.bossIndex,
    msgType = 1
  }))
  UIHelper.showWaiting()
  game:addResponseHandler(actionCodes.Activity_newWorldBossGetRankRpc, function(event)
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
    self.roleScore = math.floor(tonumber(msg.playerScore or 0))
    self.unionScore = math.floor(tonumber(msg.unionScore or 0))
    self:refreshScore()
    self:refreshPlayerRank(ranklist)
  end)
end

function NewWorldBossLayer:refreshPlayerRank(ranklist)
  self.rankAndRewardContentNode:removeAllChildren()
  local list = ccui.ListView:create()
  list:size(cc.size(708, 410))
  list:setInnerContainerSize(cc.size(708, 410))
  list:setClippingEnabled(true)
  list:anch(0.5, 0.5):pos(0, 0):addTo(self.rankAndRewardContentNode)
  local isSelf = false
  self.lastChoose = nil
  for i, playerData in ipairs(ranklist) do
    playerData.count = playerData.score % 100
    local rankColor = isSelf and "#ffe13c" or "#ffffff"
    local cell = UIHelper.newImageView(WorldbossRes .. (isSelf and "playerCellSelf.png" or "playerCell.png")):addTo(list)
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
      
      self.lastChoose = cell
    end)
    display.newTTFLabel({
      text = i,
      size = 40,
      color = UIHelper.hex2rgb(rankColor)
    }):enableOutline(UIHelper.hex2rgb("#000000"), 1):anch(0.5, 0.5):pos(35, 30):addTo(cell)
    local bg = UIHelper.newImageView(PicCsv[tonumber(playerData.head)].res):addTo(cell):pos(94, 30):scale(0.38)
    display.newSprite(FramCsv[tonumber(playerData.headFrame)].res):center(bg):addTo(bg)
    local nameLabel = display.newTTFLabel({
      text = playerData.name,
      size = 20,
      color = UIHelper.hex2rgb("#703802")
    }):anch(0, 0.5):pos(130, 28):addTo(cell)
    display.newTTFLabel({
      text = "协会：" .. playerData.union,
      size = 18,
      color = UIHelper.hex2rgb("#fdfffa")
    }):enableOutline(UIHelper.hex2rgb("#431b05"), 1):anch(0, 0.5):pos(320, 30):addTo(cell)
    local scoreText = getScoreText(playerData.score)
    MRichText.new({
      text = string.format("最高伤害:%s", scoreText),
      size = 20,
      color = UIHelper.hex2rgb("#703802")
    }):anch(0, 0.5):pos(500, 30):addTo(cell)
  end
end

function NewWorldBossLayer:getUnionRankData()
  self.jumpType = 2
  game:sendData(actionCodes.Activity_newWorldBossGetRankRpc, MsgPack.pack({
    bossIdx = self.bossIndex,
    msgType = 2
  }))
  UIHelper.showWaiting()
  game:addResponseHandler(actionCodes.Activity_newWorldBossGetRankRpc, function(event)
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

function NewWorldBossLayer:refreshUnionRank(ranklist)
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

function NewWorldBossLayer:refreshPlayerReward()
  self.jumpType = 3
  self.rankAndRewardContentNode:removeAllChildren()
  local list = ccui.ListView:create()
  list:size(cc.size(700, 410))
  list:setInnerContainerSize(cc.size(700, 410))
  list:setClippingEnabled(true)
  list:anch(0.5, 0.5):pos(0, 0):addTo(self.rankAndRewardContentNode)
  local cellSize = display.newSprite(WorldbossRes .. "rewardCell.png"):getContentSize()
  cellSize.height = cellSize.height + 16
  local rewardCount = #RewardCsv[self.bossIndex][1]
  local row = math.ceil(rewardCount / 5)
  for i = 1, row do
    local viewNode = ccui.Widget:create()
    viewNode:setContentSize(cellSize):addTo(list)
    local cell = display.newSprite(WorldbossRes .. "rewardCell.png"):center(viewNode):addTo(viewNode)
    local xPos, delta = 104, 123
    for col = 1, 5 do
      if rewardCount >= (i - 1) * 5 + col then
        local data = RewardCsv[self.bossIndex][1][(i - 1) * 5 + col]
        local bg = display.newSprite(WorldbossRes .. "rewardItem.png"):pos(xPos, 57):addTo(cell)
        local item = data.rewards:toArray("=", true)
        ItemIcon.new({
          type = item[1],
          count = item[2],
          showTip = true
        }):scale(0.6):pos(47, 50):addTo(bg)
        local conditionText = display.newTTFLabel({
          text = data.condition,
          size = 16
        }):enableOutline(UIHelper.hex2rgb("#793f07"), 1):anch(0.5, 0.5):pos(45, 12):addTo(bg)
        local done = self.rewardStatus and self.rewardStatus[tostring(data.type * 100 + data.rewardId)] or 0
        if self.roleScore >= data.condition then
          local red
          if done == 0 then
            red = display.newSprite(ScoreRes .. "red.png"):pos(47, 45):addTo(bg)
            local touch = UIHelper.extend(ccui.Layout:create())
            touch:setContentSize(cc.size(94, 93)):anch(0.5, 0.5):center(bg):addTo(bg)
            touch:setSwallowTouches(true)
            touch:setCallback(function()
              game:sendData(actionCodes.Activity_newWorldBossGetRewardRpc, MsgPack.pack({
                id = 1,
                bossIdx = self.bossIndex,
                index = data.rewardId
              }))
              UIHelper.showWaiting()
              game:addResponseHandler(actionCodes.Activity_newWorldBossGetRewardRpc, function(event)
                UIHelper.removeWaiting()
                self.rewardStatus = game.role.activityStatus["107"][tostring(self.bossIndex)].reward_record or {}
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

function NewWorldBossLayer:refreshUnionReward()
  self.jumpType = 4
  self.rankAndRewardContentNode:removeAllChildren()
  local list = ccui.ListView:create()
  list:size(cc.size(700, 410))
  list:setInnerContainerSize(cc.size(700, 410))
  list:setClippingEnabled(true)
  list:anch(0.5, 0.5):pos(0, 0):addTo(self.rankAndRewardContentNode)
  local cellSize = display.newSprite(WorldbossRes .. "rewardCell.png"):getContentSize()
  cellSize.height = cellSize.height + 16
  local rewardCount = #RewardCsv[self.bossIndex][2]
  local row = math.ceil(rewardCount / 5)
  for i = 1, row do
    local viewNode = ccui.Widget:create()
    viewNode:setContentSize(cellSize):addTo(list)
    local cell = display.newSprite(WorldbossRes .. "rewardCell.png"):center(viewNode):addTo(viewNode)
    local xPos, delta = 104, 123
    for col = 1, 5 do
      if rewardCount >= (i - 1) * 5 + col then
        local data = RewardCsv[self.bossIndex][2][(i - 1) * 5 + col]
        local bg = display.newSprite(WorldbossRes .. "rewardItem.png"):pos(xPos, 57):addTo(cell)
        local item = data.rewards:toArray("=", true)
        ItemIcon.new({
          type = item[1],
          count = item[2],
          showTip = true
        }):scale(0.6):pos(47, 50):addTo(bg)
        local conditionText = display.newTTFLabel({
          text = data.condition,
          size = 16
        }):enableOutline(UIHelper.hex2rgb("#793f07"), 1):anch(0.5, 0.5):pos(45, 12):addTo(bg)
        local done = self.rewardStatus and self.rewardStatus[tostring(data.type * 100 + data.rewardId)] or 0
        if self.unionScore >= data.condition then
          local red
          if done == 0 then
            red = display.newSprite(ScoreRes .. "red.png"):pos(47, 45):addTo(bg)
            local touch = UIHelper.extend(ccui.Layout:create())
            touch:setContentSize(cc.size(94, 93)):anch(0.5, 0.5):center(bg):addTo(bg)
            touch:setSwallowTouches(true)
            touch:setCallback(function()
              game:sendData(actionCodes.Activity_newWorldBossGetRewardRpc, MsgPack.pack({
                id = 2,
                bossIdx = self.bossIndex,
                index = data.rewardId
              }))
              UIHelper.showWaiting()
              game:addResponseHandler(actionCodes.Activity_newWorldBossGetRewardRpc, function(event)
                UIHelper.removeWaiting()
                self.rewardStatus = game.role.activityStatus["107"][tostring(self.bossIndex)].reward_record or {}
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

function NewWorldBossLayer:createDetail(data)
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

function NewWorldBossLayer:createCell(data)
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
    text = string.format("最高伤害总和:%d", math.floor(temp)) .. lastWord,
    size = 24,
    color = UIHelper.hex2rgb("#703802")
  }):anch(0, 0.5):pos(430, 87):addTo(cell)
end

function NewWorldBossLayer:refreshRightPanel()
  if self.jumpType then
    if self.jumpType == 1 then
      self:getPlayerRankData()
      return
    elseif self.jumpType == 2 then
      self:getUnionRankData()
    elseif self.jumpType == 3 then
      self:refreshPlayerReward()
    elseif self.jumpType == 4 then
      self:refreshUnionReward()
    end
  end
  self:getPlayerRankData()
end

return NewWorldBossLayer
