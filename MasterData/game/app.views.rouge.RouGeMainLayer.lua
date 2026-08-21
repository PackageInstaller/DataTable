local rougeAiCsv = require("csvdata.rouge.rouge_ai")
local rougeBattleCsv = require("csvdata.rouge.rouge_battle")
local rougeShopCsv = require("csvdata.rouge.rouge_shop")
local UnitCsv = require("csvdata.unit")
local RouGeMainRes = "ui/rouge/main/"
local uiData = {
  csbFile = "ui/rouge/RouGeMainLayer.csb",
  widgets = {
    content = "content",
    bg = "content/bg",
    leftNode = "leftNode",
    countLabel1 = "leftNode/item1/countLabel",
    countLabel2 = "leftNode/item2/countLabel",
    curSkillDetail = "leftNode/curSkillDetail",
    detailNode = "leftNode/curSkillDetail/detailNode",
    backBg = "leftNode/curSkillDetail/backBg",
    curSkillList = "leftNode/curSkillList",
    infoBtn = "leftNode/infoBtn",
    allBtn = "leftNode/allBtn",
    midNode = "midNode",
    enterBattle = "midNode/enterBattle",
    midCardNode = "midNode/midCardNode",
    rightNode = "rightNode",
    mapItem1 = "rightNode/mapItemNode/mapItem1",
    mapItem2 = "rightNode/mapItemNode/mapItem2",
    mapItem3 = "rightNode/mapItemNode/mapItem3",
    floorList = "rightNode/floorList",
    backBtn = "rightNode/backBtn",
    rewardBtn = "rightNode/rewardBtn",
    timeLabel = "rightNode/timeLabel"
  }
}
local activityType = "94"
local RouGeMainLayer = class("RouGeMainLayer", UIBase)

function RouGeMainLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function RouGeMainLayer:init(params)
  TopBar:show(TopBarType.hide)
  self.detailShow = false
  self.buySkillList = {}
  self.curSkillDetail:hide()
  self:showCurSkills()
  self:showMidSkills()
  self:showRightView()
  self.countLabel2:setString(game.role.activityStatus[activityType].maxMoney or 0)
  for i = 1, 3 do
    self["mapItem" .. i]:hide()
  end
  self.countLabel1:setString(game.role.activityStatus[activityType].money or 0)
  self.backBtn:setCallback(function()
    BackManager:pop()
  end)
  self.rewardBtn:setCallback(function()
    local layer = game:createView("pass.PassMainLayer", {select = 3})
    BackManager:push(function()
      TopBar:show(TopBarType.hide)
      layer:close()
    end)
  end)
  local text = string.format("<div color=#f2f2f2>当前</div><div color=#e6c971> %d层</div>", (game.role.activityStatus[activityType].curLevel or 0) + 1)
  local richText = MRichText.new({text = text, size = 12}):pos(220, 18):addTo(self.enterBattle)
  self.enterBattle:setCallback(function()
    local curLevel = (game.role.activityStatus[activityType].curLevel or 0) + 1
    self:updateBattleSkills()
    self:startBattle(curLevel)
  end)
  self.infoBtn:setCallback(function()
    game:createView("global.RuleLayer", {typeStr = "rouge", changeBg = true})
  end)
  self.allBtn:setCallback(function()
    local buyRecords = game.role.activityStatus[activityType].buyRecords or {}
    if not next(buyRecords) then
      MFlashMsg:show({
        text = "主厨，你还未购买任何技能哦~"
      })
      return
    end
    local curSkills = self:GetCurSkillDatas()
    game:createView("rouge.RouGeShowAllLayer", {skills = curSkills})
  end)
  self.backBg:setCallback(function()
    if self.detailShow then
      self.curSkillDetail:hide()
    end
  end)
  local timeStr = CommonHelper.calculateDuration(globalCsv.RouGeEndTime)
  self.timerHandler = scheduler.scheduleGlobal(function()
    timeStr = CommonHelper.calculateDuration(globalCsv.RouGeEndTime)
    if self.timeLabel then
      self.timeLabel:setString(timeStr)
    end
  end, 1)
  self.timeLabel:setString(timeStr)
  UIHelper.MoveToRight({
    node = self.leftNode,
    time = 0.2
  })
  UIHelper.MoveToLeft({
    node = self.backBtn,
    time = 0.2
  })
  UIHelper.MoveToLeft({
    node = self.rewardBtn,
    time = 0.2
  })
  UIHelper.MoveToLeft({
    node = self.timeLabel,
    time = 0.2
  })
end

function RouGeMainLayer:showSkillDetail(data)
  self.detailShow = true
  self.curSkillDetail:show()
  self.detailNode:removeAllChildren()
  local mask = UIHelper.getClipNode({
    steRes = RouGeMainRes .. "buySkill_desc_mask.png"
  }):pos(102.5, 275.5):addTo(self.detailNode)
  display.newSprite(data.icon):center(mask):scale(0.706):addTo(mask)
  display.newTTFLabel({
    text = data.title,
    size = 14,
    align = cc.TEXT_ALIGNMENT_CENTER
  }):pos(102.5, 219):addTo(self.detailNode)
  local level = data.passiveLevel
  local xPos, interval = (level - 1) / 2 * -20, 20
  for index = 1, level do
    display.newSprite(RouGeMainRes .. "levelIcon.png"):pos(xPos + (index - 1) * interval + 102.5, 198):scale(0.7):addTo(self.detailNode)
  end
  display.newTTFLabel({
    text = data.detail,
    size = 12,
    color = UIHelper.hex2rgb("#bfbfbf"),
    dimensions = cc.size(133, 120)
  }):anch(0.5, 1):pos(104, 173):addTo(self.detailNode)
end

function RouGeMainLayer:showCurSkills()
  self.curSkillList:removeAllChildren()
  local curDatas = self:GetCurSkillDatas()
  if not next(curDatas) then
    display.newSprite(RouGeMainRes .. "cur_bg.png"):center(self.curSkillList):addTo(self.curSkillList)
  end
  for _, data in pairs(curDatas) do
    local cell = self:createCurCell(data):addTo(self.curSkillList)
  end
  self.curSkillList:doLayout()
end

function RouGeMainLayer:createCurCell(data)
  local viewNode = ccui.Widget:create()
  viewNode:size(cc.size(60, 70))
  local bg = UIHelper.newImageView(RouGeMainRes .. "buyskill_bg.png"):center(viewNode):addTo(viewNode)
  local mask = UIHelper.getClipNode({
    steRes = RouGeMainRes .. "buyskill_mask.png"
  }):pos(27.5, 41.5):addTo(bg)
  display.newSprite(data.icon):center(mask):scale(0.48):addTo(mask)
  local level = data.passiveLevel
  local xPos, interval = (level - 1) / 2 * -12, 12
  for index = 1, level do
    display.newSprite(RouGeMainRes .. "levelIcon.png"):pos(xPos + (index - 1) * interval + 27.5, 8.5):scale(0.4):addTo(bg)
  end
  bg:setCallback(function()
    self:showSkillDetail(data)
  end)
  return viewNode
end

function RouGeMainLayer:showMidSkills()
  self.midCardNode:removeAllChildren()
  local shops = game.role.activityStatus[activityType].curGoods or {}
  local posData = {
    [1] = {-289.5, 2},
    [2] = {-9.5, 2},
    [3] = {268.5, 2}
  }
  for index, id in ipairs(shops) do
    self:createBuyCell(index, id, posData[index])
  end
end

function RouGeMainLayer:createBuyCell(index, id, pos)
  local refreshData = game.role.activityStatus[activityType].refreshData or {}
  local csvData = rougeShopCsv[id]
  local bg = UIHelper.newImageView(RouGeMainRes .. (csvData.type == 1 and "curGood_skill.png" or "curGood_item.png")):pos(pos[1], pos[2]):addTo(self.midCardNode)
  local runBg = display.newSprite(RouGeMainRes .. (csvData.type == 1 and "skill_bg1.png" or "item_bg1.png")):pos(138, 387):addTo(bg)
  local rotateAction = cc.RotateBy:create(100, 360)
  local repeatForeverAction = cc.RepeatForever:create(rotateAction)
  runBg:runAction(repeatForeverAction)
  display.newSprite(RouGeMainRes .. (csvData.type == 1 and "skill_bg2.png" or "item_bg2.png")):pos(138, 387):addTo(bg)
  local mask = UIHelper.getClipNode({
    steRes = RouGeMainRes .. "skill_mask.png"
  }):pos(138, 387):scale(0.97):addTo(bg)
  display.newSprite(csvData.icon):center(mask):addTo(mask)
  if not refreshData[index .. ""] and not self:checkHasBuy(id) then
    local refreshBtn = UIHelper.extend(ccui.Button:create())
    refreshBtn:setImages(RouGeMainRes, {
      "refresh_btn.png",
      "refresh_btn.png"
    })
    refreshBtn:pos(240, 450):addTo(bg):setTouchScale()
    refreshBtn:setCallback(function()
      self:refreshSkill(index, id)
    end)
    local richText = MRichText.new({
      text = "<img src='ui/rouge/main/item_icon1.png' scale=0.15 />" .. globalCsv.RouGeRefreshPrice,
      size = 16
    })
    richText:pos(6, 29):addTo(refreshBtn)
  end
  local titleLabel = display.newTTFLabel({
    text = csvData.title,
    size = 20,
    color = UIHelper.hex2rgb("#ffffff")
  }):pos(138, 301):addTo(bg)
  local level = csvData.passiveLevel
  local xPos, interval = (level - 1) / 2 * -30, 30
  for index = 1, level do
    display.newSprite(RouGeMainRes .. "levelIcon.png"):pos(xPos + (index - 1) * interval + 138, 276):addTo(bg)
  end
  display.newTTFLabel({
    text = csvData.detail,
    size = 16,
    color = UIHelper.hex2rgb("#bfbfbf"),
    dimensions = cc.size(178, 120)
  }):anch(0.5, 1):pos(138, 240):addTo(bg)
  display.newTTFLabel({
    text = csvData.desc,
    size = 14,
    color = UIHelper.hex2rgb("#616161"),
    dimensions = cc.size(178, 40)
  }):anch(0.5, 1):pos(138, 113):addTo(bg)
  if not self:checkHasBuy(id) then
    local richText = MRichText.new({
      text = "<img src='ui/rouge/main/item_icon1.png' scale=0.25 />" .. csvData.cost,
      size = 24
    })
    richText:anch(0.5, 0.5):pos(138, 51.5):addTo(bg)
    bg:setCallback(function()
      self:buySkill(index, id)
    end)
  else
    display.newSprite(RouGeMainRes .. "buy_finish.png"):pos(138, 51.5):addTo(bg)
  end
end

function RouGeMainLayer:refreshSkill(index, id)
  local function sendMsg()
    game:sendData(actionCodes.Activity_refreshRougeGoodsRpc, MsgPack.pack({index = index}))
    
    UIHelper.showWaiting()
    game:addResponseHandler(actionCodes.Activity_refreshRougeGoodsRpc, function(event)
      UIHelper.removeWaiting()
      self:showMidSkills()
      self.countLabel1:setString(game.role.activityStatus[activityType].money or 0)
    end)
  end
  
  local csvData = rougeShopCsv[id]
  local money = game.role.activityStatus[activityType].money or 0
  if money < globalCsv.RouGeRefreshPrice then
    MFlashMsg:show({
      text = "货币数量不足,刷新失败"
    })
    return
  end
  if tonumber(CommonHelper.date(nil, "Ymd", true)) > tonumber(UserData.rougeRefreshSkipTime or 0) then
    game:createView("rouge.RouGeDialog", {
      showRefresh = true,
      data = csvData,
      okCallback = function()
        sendMsg()
        return true
      end,
      cancelCallback = function()
        return true
      end
    })
  else
    sendMsg()
  end
end

function RouGeMainLayer:buySkill(index, id)
  local function sendMsg()
    game:sendData(actionCodes.Activity_buyRougeGoodsRpc, MsgPack.pack({index = index}))
    
    UIHelper.showWaiting()
    game:addResponseHandler(actionCodes.Activity_buyRougeGoodsRpc, function(event)
      UIHelper.removeWaiting()
      self:showMidSkills()
      self:showCurSkills()
      self.countLabel1:setString(game.role.activityStatus[activityType].money or 0)
    end)
  end
  
  local csvData = rougeShopCsv[id]
  local money = game.role.activityStatus[activityType].money or 0
  if money < csvData.cost then
    MFlashMsg:show({
      text = "货币数量不足,无法购买"
    })
    return
  end
  if tonumber(CommonHelper.date(nil, "Ymd", true)) > tonumber(UserData.rougeBuySkipTime or 0) then
    game:createView("rouge.RouGeDialog", {
      showBuy = true,
      data = csvData,
      okCallback = function()
        sendMsg()
        return true
      end,
      cancelCallback = function()
        return true
      end
    })
  else
    sendMsg()
  end
end

function RouGeMainLayer:checkHasBuy(id)
  local buyRecords = game.role.activityStatus[activityType].buyRecords or {}
  local shopData = rougeShopCsv[id]
  return buyRecords[id .. ""] and buyRecords[id .. ""] >= shopData.limit
end

function RouGeMainLayer:showRightView()
  self.floorList:removeAllChildren()
  local posData = {
    [1] = {45, 45},
    [2] = {115, 45}
  }
  local curlevel = game.role.activityStatus[activityType].curLevel or 0
  local maxLevel = #rougeBattleCsv
  local selectIdx = 0
  local temIndex = 0
  if maxLevel < curlevel + 3 then
    for i = 1, 3 do
      temIndex = temIndex + 1
      self:createFloorCell(-1)
    end
  end
  for i = maxLevel, 1, -1 do
    temIndex = temIndex + 1
    if i == curlevel + 1 then
      selectIdx = temIndex
    end
    self:createFloorCell(i, posData[i % 2 == 1 and 1 or 2], curlevel)
  end
  if curlevel < 3 then
    for i = 1, 3 do
      temIndex = temIndex + 1
      self:createFloorCell(-1)
    end
  end
  self.floorList:doLayout()
  self.floorList:scrollToItem(selectIdx - 1, cc.p(0, 0.45), cc.p(0, 0))
end

function RouGeMainLayer:createFloorCell(level, pos, curlevel)
  local viewNode = ccui.Widget:create():size(cc.size(160, 90)):addTo(self.floorList)
  if 0 < level then
    local imageName = level > curlevel + 1 and "floor_bg_2.png" or level == curlevel + 1 and "floor_bg_1.png" or "floor_bg_3.png"
    local labelColor = level == curlevel + 1 and "#f2f2f2" or "#7e808a"
    local bg = UIHelper.newImageView(RouGeMainRes .. imageName):pos(pos[1], pos[2]):addTo(viewNode)
    bg:setCallback(function()
      self:showMapBossSkills(level)
      print("来吧~~展示~~后面再加功能")
    end)
    local levelLabel = display.newTTFLabel({
      text = level,
      size = 32,
      align = cc.TEXT_ALIGNMENT_CENTER,
      color = UIHelper.hex2rgb(labelColor)
    }):pos(41, 42):addTo(bg)
  end
  return viewNode
end

function RouGeMainLayer:getMaxLevel()
  return rougeBattleCsv[#rougeBattleCsv].floor
end

function RouGeMainLayer:showAllCurSkills()
end

function RouGeMainLayer:showMapBossSkills(level)
  game:createView("rouge.RouGeShowBossLayer", {level = level})
end

function RouGeMainLayer:updateBattleSkills()
  self.skills = {}
  local buyRecords = self:GetCurSkillDatas()
  for _, data in pairs(buyRecords) do
    local buffget = data.buffget
    local skillList = buffget:toArray("=", true)
    for i, id in ipairs(skillList) do
      table.insert(self.skills, tonumber(id))
    end
  end
end

function RouGeMainLayer:startBattle(level)
  game:sendData(actionCodes.Activity_startRougeRpc, MsgPack.pack({level = level}))
  UIHelper.showWaiting()
  game:addResponseHandler(actionCodes.Activity_startRougeRpc, function(event)
    UIHelper.removeWaiting()
    local activityStatus = game.role.activityStatus[activityType] or {}
    game:enterScene("BattleScene", {
      type = BattleType.RouGe,
      floorId = level,
      enemyId = self:RandomEnemyId(level),
      leftInfo = self:getRouGeAttrs(),
      skills = self.skills or {},
      buffs = self.extraBufflist or {}
    })
  end)
end

function RouGeMainLayer:GetCurSkillDatas()
  local activityStatus = game.role and game.role.activityStatus or {}
  local activityData = activityStatus[activityType] or {}
  local skills = activityData.buyRecords or {}
  local temTable = {}
  for id, value in pairs(skills) do
    local csvData = rougeShopCsv[tonumber(id)]
    if csvData and csvData.type == 1 then
      local oldData = temTable[csvData.passiveType .. ""]
      if not oldData or oldData and oldData.passiveLevel < csvData.passiveLevel then
        temTable[csvData.passiveType .. ""] = csvData
      end
    end
  end
  return temTable
end

function RouGeMainLayer:RandomEnemyId(floor)
  local floorDatas = rougeBattleCsv[floor]
  local str = ""
  for k, data in pairs(floorDatas) do
    if tonumber(data.condition) == 0 or 0 <= (game.role.items[tonumber(data.condition)] or 0) then
      str = str == "" and str .. data.enemyId .. "=" .. data.weight or str .. " " .. data.enemyId .. "=" .. data.weight
    end
  end
  local ranEnemyId = str:randWeight()
  print("RandomEnemyId:", str, ranEnemyId)
  return ranEnemyId
end

function RouGeMainLayer:getRouGeAttrs()
  local result = {
    heros = {}
  }
  local format = {}
  local tempheros = {}
  local data = rougeAiCsv[globalCsv.RouGeAIId]
  local teams = data.team:toTableArray(" ")
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
    table.insert(result.heros, heroInfo)
    tempheros[tonumber(slot)] = {
      type = heroData.type,
      fieldLevel = 1
    }
    format[tonumber(slot)] = tonumber(slot)
  end
  result.formatEffect = FormatLogic.getActiveEffect(format, tempheros)
  return result
end

function RouGeMainLayer:onExit()
  if self.timerHandler then
    scheduler.unscheduleGlobal(self.timerHandler)
  end
end

return RouGeMainLayer
