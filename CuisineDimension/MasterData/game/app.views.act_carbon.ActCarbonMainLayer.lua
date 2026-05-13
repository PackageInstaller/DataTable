local ActCarbonRes = "ui/act_carbon/"
local activity108Csv = require("csvdata.activity_108_battle")
local LevelNode = require("app.views.act_carbon.LevelNode")
local RewardNode = require("app.views.act_carbon.RewardNode")
local uiData = {
  csbFile = "ui/act_carbon/ActCarbonMainLayer.csb",
  widgets = {
    mainBg = "Bg",
    Level1Node = "Level1Node",
    Level2Node = "Level2Node",
    Level3Node = "Level3Node",
    Level4Node = "Level4Node",
    RewardList = "RewardList",
    ClearNode = "ClearNode",
    ExchangeNode = "ExchangeNode",
    RootNode = "Root"
  }
}
local activityType = "108"
local topName = "活动关卡"
local ActCarbonMainLayer = class("ActCarbonMainLayer", UIBase)
local nodePos = {
  [1] = cc.p(70, 244),
  [2] = cc.p(300, 98),
  [3] = cc.p(530, 244),
  [4] = cc.p(760, 98)
}

function ActCarbonMainLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function ActCarbonMainLayer:init(params)
  TopBar:show(TopBarType.back, topName)
  TopBar:showAnimation(true)
  self.LevelNodes = {}
  self.RewardNodes = {}
  self.mainBg:setTexture(ActCarbonRes .. "main_bg.png")
end

function ActCarbonMainLayer:showData(params)
  self:refreshActivityStatus()
  self:createLevels()
  self:createExchangeBtn()
  self:createInfoBtn()
  self:createActItemLable()
  self:createClearBtn()
  self:createRewardList()
end

function ActCarbonMainLayer:createLevels()
  for i = 1, 4 do
    self:createLevelNode(i)
  end
end

function ActCarbonMainLayer:getLevelNode(level)
  if level == 1 then
    return self.Level1Node
  elseif level == 2 then
    return self.Level2Node
  elseif level == 3 then
    return self.Level3Node
  elseif level == 4 then
    return self.Level4Node
  else
    return nil
  end
end

function ActCarbonMainLayer:createLevelNode(levelId)
  local levelNode = self:getLevelNode(levelId)
  if not levelNode then
    return
  end
  local pos = nodePos[levelId]
  levelNode:pos(pos.x, pos.y)
  local node = LevelNode.new({
    levelId = levelId,
    parent = levelNode,
    isUnlocked = levelId <= self.curChapterId + 1,
    isCompleted = levelId <= self.curChapterId,
    StoryPosType = levelId % 2 == 0 and LevelNode.StoryPosType.DOWN or LevelNode.StoryPosType.UP,
    callback = function(id)
      self:onLevelClick(id)
    end,
    storyCallback = function(id)
      self:onStoryClick(id)
    end
  })
  node:getNode():addTo(levelNode)
  self.LevelNodes[levelId] = node
end

function ActCarbonMainLayer:onLevelClick(levelId)
  local layer = game:createView("hero.BattleListLayer", {
    battleType = BattleType.ActCarbon,
    battle = "召唤",
    callback = function(choose)
      local format = game.role.formation[tostring(choose)]
      if not format then
        return
      end
      self:beginBattle(levelId, choose)
      return true
    end
  })
  BackManager:push(function()
    layer:close()
    TopBar:show(TopBarType.back, topName)
  end)
end

function ActCarbonMainLayer:onStoryClick(levelId)
  local storyId = activity108Csv[levelId].storyid
  game:createView("talk.PlotTalkLayer", {
    talkId = storyId,
    csvNo = 1,
    reportSkip = true,
    onComplete = function()
      TopBar:show(TopBarType.back, topName)
    end
  })
end

function ActCarbonMainLayer:createActItemLable()
  local actItemBg = UIHelper.extend(ccui.ImageView:create()):setImage(ActCarbonRes .. "item_bg.png"):anch(0, 0):pos(940, 528):addTo(self.RootNode)
  self.actItemLable = MRichText.new({
    text = "",
    size = 20,
    color = UIHelper.hex2rgb("#ffffff")
  }):anch(0.5, 0.5):pos(70, 25):addTo(actItemBg)
  self:updateActItemLable()
end

function ActCarbonMainLayer:updateActItemLable()
  local actItemCount = game.role.items[globalCsv.activity108ItemId] or 0
  self.actItemLable:setString("" .. actItemCount)
end

function ActCarbonMainLayer:createInfoBtn()
  local InfoBtn = UIHelper.extend(ccui.Button:create())
  InfoBtn:setImages(ActCarbonRes, {"info.png", "info.png"})
  InfoBtn:anch(0, 0):pos(59, 528):addTo(self.RootNode)
  InfoBtn:setTouchScale()
  InfoBtn:setCallback(function()
    game:createView("global.RuleLayer", {
      typeStr = "activity_108"
    })
  end)
end

function ActCarbonMainLayer:createExchangeBtn()
  self.ExchangeNode:pos(59, 150)
  local ExchangeBtn = UIHelper.extend(ccui.Button:create())
  ExchangeBtn:setImages(ActCarbonRes, {
    "exchange_btn.png",
    "exchange_btn.png"
  })
  ExchangeBtn:anch(0, 0):pos(0, 0):addTo(self.ExchangeNode)
  ExchangeBtn:setTouchScale()
  ExchangeBtn:setCallback(function()
    local layer = game:createView("shop.ShopLayer", {curType = 2, selected = 5})
    BackManager:push(function()
      TopBar:show(TopBarType.back, topName)
      self:updateActItemLable()
      layer:close()
    end)
  end)
end

function ActCarbonMainLayer:createClearBtn()
  local content = UIHelper.extend(ccui.ImageView:create())
  content:setImage(ActCarbonRes .. "clear_btn.png")
  content:anch(0.5, 0.5):pos(0, 0):addTo(self.ClearNode)
end

function ActCarbonMainLayer:refreshActivityStatus()
  local curStatus = game.role.activityStatus[tostring(activityType)] or {}
  self.curChapterId = curStatus.id or 0
  self.curRecord = curStatus.record or ""
  self.battleKey = curStatus.key or ""
end

function ActCarbonMainLayer:beginBattle(levelId, choose)
  if levelId > self.curChapterId + 1 then
    return
  end
  game:sendData(actionCodes.Activity_act108BeginBattleRpc, MsgPack.pack({chapterId = levelId}))
  UIHelper.showWaiting()
  game:addResponseHandler(actionCodes.Activity_act108BeginBattleRpc, function(event)
    UIHelper.removeWaiting()
    self:refreshActivityStatus()
    game:enterScene("BattleScene", {
      type = BattleType.ActCarbon,
      battleId = levelId,
      format = choose,
      leftInfo = game.role:getMJAttrs(choose)
    })
  end)
end

function ActCarbonMainLayer:endBattle(levelId, isWin)
  game:sendData(actionCodes.Activity_act108EndBattleRpc, MsgPack.pack({
    chapterId = levelId,
    isWin = isWin,
    key = self.battleKey
  }))
  UIHelper.showWaiting()
  game:addResponseHandler(actionCodes.Activity_act108EndBattleRpc, function(event)
    UIHelper.removeWaiting()
    self:refreshActivityStatus()
    self:updateLevelNode()
  end)
end

function ActCarbonMainLayer:getReward(levelId)
  local record = self.curRecord
  if 0 < record:getv(levelId, 0) then
    MFlashMsg:show({
      text = "奖励已领取"
    })
    return
  end
  if levelId > self.curChapterId then
    MFlashMsg:show({
      text = "请先通关第" .. levelId .. "关"
    })
    return
  end
  game:sendData(actionCodes.Activity_act108GetRewardRpc, MsgPack.pack({id = levelId}))
  UIHelper.showWaiting()
  game:addResponseHandler(actionCodes.Activity_act108GetRewardRpc, function(event)
    UIHelper.removeWaiting()
    local msg = MsgPack.unpack(event.data)
    MedalRewardLayer.new({
      items = msg.reward
    })
    self:refreshActivityStatus()
    self:updateRewardNodes()
  end)
end

function ActCarbonMainLayer:updateLevelNode()
  for i = 1, 4 do
    local node = self.LevelNodes[i]
    if node then
      node:setUnlocked(i <= self.curChapterId + 1)
      node:setCompleted(i <= self.curChapterId)
    end
  end
  self:updateRewardNodes()
end

function ActCarbonMainLayer:getRewardState(rewardId)
  local record = self.curRecord or ""
  if 0 < record:getv(rewardId, 0) then
    return RewardNode.State.CLAIMED
  elseif rewardId <= self.curChapterId then
    return RewardNode.State.AVAILABLE
  else
    return RewardNode.State.LOCKED
  end
end

function ActCarbonMainLayer:createRewardList()
  local fontHeight = 3
  self.RewardList:anch(0, 0):pos(160, 42 + fontHeight)
  for i = 1, 4 do
    local reward = globalCsv.activity108Rewards[i] or ""
    local params = string.split(reward, "=")
    if #params == 2 then
      local itemId = tonumber(params[1])
      local itemCount = tonumber(params[2])
      local node = RewardNode.new({
        rewardId = i,
        itemId = itemId,
        itemCount = itemCount,
        state = self:getRewardState(i),
        unlockCondition = "通关1-" .. i,
        callback = function(rewardId, itemId, itemCount)
          self:onRewardClick(rewardId, itemId, itemCount)
        end
      })
      node:getNode():addTo(self.RewardList)
      self.RewardNodes[i] = node
    end
  end
end

function ActCarbonMainLayer:onRewardClick(rewardId, itemId, itemCount)
  self:getReward(rewardId)
end

function ActCarbonMainLayer:updateRewardNodes()
  for i = 1, 4 do
    local rewardNode = self.RewardNodes[i]
    if rewardNode then
      local newState = self:getRewardState(i)
      rewardNode:setState(newState)
    end
  end
end

return ActCarbonMainLayer
