local ChapterInfoCsv = require("csvdata.chapter_info")
local ChapterBattleCsv = require("csvdata.chapter_battle")
local AutoBattleCsv = require("csvdata.auto_battle")
local ChapterDropCsv = require("csvdata.loop_activity.chapter_drop")
local MonsterCsv = require("csvdata.monster")
local BossCsv = require("csvdata.ghost")
local MagicRes = "ui/activity/23/"
local MainRes = "ui/carbon/main/"
local DetailRes = "ui/carbon/detail/"
local HappyRes = "ui/carbon/happy/"
local MapRes = "map/"
local uiData = {
  csbFile = "ui/carbon/CarbonDetailLayer.csb",
  mask = true,
  widgets = {
    mainBg = "mainBg",
    up = "up",
    listView = "listView",
    desc1 = "detailBg/desc1",
    desc2 = "detailBg/desc2",
    desc3 = "detailBg/desc3",
    mask1 = "detailBg/mask1",
    mask2 = "detailBg/mask2",
    mask3 = "detailBg/mask3",
    autoBtn = "detailBg/autoBtn",
    btnBattle = "btnBattle",
    itemNode = "detailBg/itemNode",
    btnMode = "detailBg/btnMode",
    btnList = "detailBg/btnList",
    detailBg = "detailBg",
    countBg = "countBg",
    count = "countBg/count",
    node = "detailBg/node"
  }
}
local CarbonDetailLayer = class("CarbonDetailLayer", UIBase)

function CarbonDetailLayer:ctor(params)
  self.mapId = params.mapId
  self.mapIndex = self.mapId % 100
  UIBase.ctor(self, uiData, params)
end

function CarbonDetailLayer:init(params)
  game:playMusic(3)
  TopBar:showAnimation(true)
  if UIHelper.isiPhoneX() then
    UIHelper.fitForiPhoneX(self.mainBg)
  end
  UIHelper.MoveToUp({
    node = self.countBg,
    delay = 0.4,
    time = 0.3
  })
  UIHelper.MoveToLeft({
    node = self.detailBg,
    delay = 0.4,
    time = 0.3
  })
  UIHelper.MoveToUp({
    node = self.btnBattle,
    delay = 0.4,
    time = 0.3
  })
  UIHelper.MoveToDown({
    node = self.up
  })
  UIHelper.newImageView(DetailRes .. "mask.png"):anch(0, 0):pos(0, 40):addTo(self)
  self.isAuto = game.role.showAutoBattle
  self.autoBattleCarbonId = 0
  if self.isAuto then
    self.autoBattleCarbonId = game.role.showAutoBattle
    params.carbonId = self.isAuto
  end
  game.role.showAutoBattle = nil
  self:autoBtnClick(params)
  self:initBattleData(params)
end

function CarbonDetailLayer:autoBtnClick(params)
  local btn = UIHelper.extend(ccui.Button:create())
  local btnPath = self.isAuto and "btnHand.png" or "btnAuto.png"
  btn:setImages(MainRes, {btnPath, btnPath})
  btn:scale(0.8)
  btn:center(self.autoBtn):addTo(self.autoBtn)
  btn:setCallback(function()
    if not self.isAuto then
      self.isAuto = true
      btn:setImages(MainRes, {
        "btnHand.png",
        "btnHand.png"
      })
      self.detailBg:setTexture("ui/carbon/happy/detail_bg.png")
      self:initBattleData(params)
      self:showBattleData()
    else
      self.isAuto = false
      btn:setImages(MainRes, {
        "btnAuto.png",
        "btnAuto.png"
      })
      self.detailBg:setTexture("ui/carbon/detail/detail_bg.png")
      self:initBattleData(params)
      self:showBattleData()
    end
  end)
end

function CarbonDetailLayer:showDelayTime(callback)
  local time = 5
  local bgbtn = UIHelper.extend(ccui.Button:create())
  bgbtn:setImages("ui/battle/", {"autobg.png", "autobg.png"})
  bgbtn:pos(568, 320):opacity(102):addTo(self)
  bgbtn:setLocalZOrder(1000)
  local label = display.newTTFLabel({
    text = string.format("%d秒后自动开始", time),
    size = 20
  }):enableOutline(UIHelper.hex2rgb("#000000"), 1):pos(568, 320):addTo(bgbtn)
  local label1 = display.newTTFLabel({
    text = string.format("点击屏幕关闭自动战斗", time),
    size = 16
  }):enableOutline(UIHelper.hex2rgb("#000000"), 1):pos(568, 30):addTo(bgbtn)
  bgbtn:setCallback(function()
    bgbtn:removeSelf()
  end)
  
  local function timeTick()
    bgbtn:runAction(transition.sequence({
      cc.DelayTime:create(1),
      cc.CallFunc:create(function()
        if 0 < time then
          label:setString(string.format("%d秒后自动开始", time))
          time = time - 1
          timeTick()
        else
          callback()
          bgbtn:removeSelf()
        end
      end)
    }))
  end
  
  timeTick()
end

function CarbonDetailLayer:initBattleData(params)
  local carbonStr = game.role.carbonDouble or ""
  self.carbons = carbonStr:toArray("=", true)
  self.btnBattle:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#641f08"), 2)
  self.btnBattle:setTouchScale()
  self.btnBattle:setMusicId(1009)
  self.forwardId = params.carbonId
  local carbonId = 0
  self.battleInfo = json.decode(game.role.battleInfo)
  self.battleInfo.carbonId = self.battleInfo.carbonId or 0
  self.extraInfo = json.decode(game.role.extraBattle)
  self.extraInfo.carbonId = self.extraInfo.carbonId or 0
  self.autoBattleId = game.role:getAutoBattleId()
  if self:checkMapId(self.battleInfo.carbonId) then
    carbonId = self.battleInfo.carbonId
  elseif self.autoBattleId and self.isAuto then
    carbonId = self.autoBattleId
  else
    local nextCarbonId = game.role.lastCarbonInfo[self.mapIndex]
    print("nexcarbonId:", nextCarbonId, self.mapIndex)
    if nextCarbonId then
      if game.role.carbons[nextCarbonId] then
        carbonId = nextCarbonId
      else
        carbonId = nextCarbonId - 1
      end
    end
  end
  if params.carbonId then
    carbonId = params.carbonId
  end
  if not carbonId or carbonId == 0 then
    carbonId = self:getMaxCarbon()
    self.modeType = self.mapId > 200 and (self.mapId > 300 and 3 or 2) or 1
  else
    self.modeType = 200 < carbonId / 100 and (300 < carbonId / 100 and 3 or 2) or 1
  end
  self.selectCarbon = carbonId
  
  local function enterFunc()
    if not self.carbonId then
      return
    end
    local nextCarbonId = self.carbonId + 1
    if game.role.carbons[nextCarbonId] then
      nextCarbonId = self.carbonId
    end
    game.role.lastCarbonInfo[self.mapIndex] = nextCarbonId
    game:enterScene("CarbonScene", {
      carbonId = self.carbonId,
      modeType = self.modeType
    })
  end
  
  local function enterAuto()
    local autoIdxs = game.role.autoBattle.idxs:toArray("=", true)
    local enemyIndex, teamIndex = autoIdxs[2], autoIdxs[3]
    local enemys = AutoBattleCsv[self.carbonId].monsterSet:toArray("=", true)
    local outTeams = game.role.autoBattle.teams:toArray("=", true)
    if teamIndex and teamIndex ~= 0 then
      if self.carbonId ~= autoIdxs[1] then
        SysError(SYS_ERR_HERO_LOCKED_FIGHT_RECYCLE)
        return
      end
      local enemyData
      for i, id in ipairs(enemys) do
        if enemyIndex == i then
          enemyData = MonsterCsv[id]
        end
      end
      if not enemyData or not next(enemyData) then
        return
      end
      local enterTeam = outTeams[teamIndex]
      if not enterTeam then
        SysError(SYS_ERR_NOT_ENOUGH_HEROS)
        return
      end
      game:enterScene("BattleScene", {
        type = BattleType.PvE,
        modeType = self.modeType,
        carbonId = self.carbonId,
        masterId = enemyData.id,
        leftInfo = game.role:getBattleAttrs(enterTeam, BattleType.PvE),
        format = enterTeam,
        energy = 0,
        buff = {},
        bossId = 0,
        weatherFactor = enemyData.type == MonsterType.Dregs,
        battleKey = game.role.autoBattle.key or "zhaolu",
        activityBuff = {},
        autoBattle = true
      })
    end
  end
  
  local function startBattle()
    if self.isAuto then
      if self.battleInfo.carbonId ~= 0 then
        SysError(SYS_ERR_CARBON_MAIN_ON_BATTLE)
        return
      end
      if next(json.decode(game.role.moonBattleInfo) or {}) then
        SysError(SYS_ERR_CARBON_ACTIVITY_ON_BATTLE)
        return
      end
      if next(json.decode(game.role.paradiseBattleInfo) or {}) then
        SysError(SYS_ERR_CARBON_HAPPY_ON_BATTLE)
        return
      end
      if self.battleInfo.carbonId == 0 and game.role:isMaxHero() then
        UIHelper.showExtraTip({type = 1, parent = self})
        return
      end
      if game.role:isMaxEquip() then
        UIHelper.showExtraTip({type = 2, parent = self})
        return
      end
      if self.autoBattleId then
        enterAuto()
        return
      end
      local cakeDone = (game.role.carbons[self.carbonId].achievement or ""):toNumMap()
      for idx = 1, 3 do
        if not cakeDone[idx] then
          SysError(SYS_ERR_CARBON_NOT_PASS)
          return
        end
      end
      local layer = game:createView("hero.AutoBattleListLayer", {
        battleType = BattleType.PvE,
        modeType = self.modeType,
        carbonId = self.carbonId,
        isAuto = self.isAuto,
        callback = function()
          BackManager:pop()
          enterAuto()
        end
      })
      BackManager:push(function()
        TopBar:show(TopBarType.full, "战斗")
        layer:close()
      end)
      return
    end
    if self.autoBattleId then
      MFlashMsg:show({
        text = "主厨的队伍正在自动战斗中"
      })
      return
    end
    local carbon = game.role.carbons[self.carbonId]
    if not carbon then
      local limitS = ChapterBattleCsv[self.carbonId].prepose
      if limitS == "" then
        SysError(SYS_ERR_CARBON_NOT_OPEN)
      else
        local limit = limitS:toArray("=", true)
        local str = "请先净化 "
        for index, carbonId in ipairs(limit) do
          local data = ChapterBattleCsv[carbonId]
          local hard = 20000 < carbonId and (30000 < carbonId and "噩梦" or "重度") or "轻度"
          str = str .. string.format("%s污染%s", hard, data.name)
          if index == 1 and 1 < #limit then
            str = str .. " 和 "
          end
        end
        MFlashMsg:show({text = str})
      end
      return
    end
    if self.battleInfo.carbonId ~= 0 and self.battleInfo.carbonId ~= self.carbonId then
      SysError(SYS_ERR_CARBON_MAIN_ON_BATTLE)
      return
    end
    if next(json.decode(game.role.moonBattleInfo) or {}) then
      SysError(SYS_ERR_CARBON_ACTIVITY_ON_BATTLE)
      return
    end
    if next(json.decode(game.role.paradiseBattleInfo) or {}) then
      SysError(SYS_ERR_CARBON_HAPPY_ON_BATTLE)
      return
    end
    if self.battleInfo.carbonId == 0 and game.role:isMaxHero() then
      UIHelper.showExtraTip({type = 1, parent = self})
      return
    end
    if game.role:isMaxEquip() then
      UIHelper.showExtraTip({type = 2, parent = self})
      return
    end
    if 0 > carbon.score then
      local need = true
      local battleInfo = json.decode(game.role.battleInfo)
      if battleInfo and battleInfo.carbonId == self.carbonId then
        need = false
      end
      local chapterData = ChapterBattleCsv[self.carbonId]
      if need and chapterData.story1 ~= 0 then
        game:createView("talk.PlotTalkLayer", {
          talkId = chapterData.story1,
          csvNo = chapterData.readcsv or 0,
          music = 4,
          onComplete = function()
            enterFunc()
          end
        })
        return
      end
    end
    enterFunc()
  end
  
  if self.autoBattleCarbonId ~= 0 and self.isAuto and not game.role.cancelAutoBattle and UserData.autoBattleLoop == 1 then
    self:showDelayTime(function()
      startBattle()
    end)
  end
  if game.role.cancelAutoBattle then
    game.role.cancelAutoBattle = false
  end
  self.btnBattle:setCallback(function()
    startBattle()
  end)
  display.newSprite(DetailRes .. "tree_item.png"):anch(0, 0.5):pos(5, 50):addTo(self.countBg)
  self.count:setString(string.format("今日掉落次数剩余:%d/%d", globalCsv.treedropLimit - game.role.treeDropCount, globalCsv.treedropLimit))
  local btnsData = {
    [1] = {
      index = 1,
      name = "普通",
      image = "btn_normal.png"
    },
    [2] = {
      index = 2,
      name = "重度",
      image = "btn_special.png"
    },
    [3] = {
      index = 3,
      name = "噩梦",
      image = "btn_nightmare.png"
    }
  }
  self.modeBtns = {}
  
  local function btnClick(index)
    for i, sender in pairs(self.modeBtns) do
      if i == index then
        local bg = sender:getChildByName("btnBg")
        bg:setOpacity(255)
      else
        local bg = sender:getChildByName("btnBg")
        bg:setOpacity(1)
      end
    end
  end
  
  local function selectOne(index)
    game:playMusic(1010)
    self.modeType = index
    btnClick(index)
    self.mapId = self.mapIndex + self.modeType * 100
    self.selectCarbon = self:getSeletCarbon()
    if params.carbonId then
      self.selectCarbon = params.carbonId
    end
    self:showBattleData()
  end
  
  self.selectGroupIndex = self.modeType
  self.btnList:removeAllChildren()
  for index, data in ipairs(btnsData) do
    local viewNode = ccui.Widget:create()
    viewNode:setContentSize(cc.size(85, 50)):addTo(self.btnList)
    local btn = UIHelper.extend(ccui.Button:create()):opacity(0.001)
    btn:setImages(DetailRes, {"btn_bg.png", "btn_bg.png"})
    btn:center(viewNode):addTo(viewNode)
    display.newSprite(DetailRes .. "btn_bg.png"):center(btn):addTo(btn):name("btnBg")
    display.newSprite(DetailRes .. data.image):center(btn):addTo(btn)
    if not self.selectGroupIndex then
      self.selectGroupIndex = index
    end
    btn:setCallback(function()
      local mapId = self.mapIndex + index * 100
      if globalCsv.emengOpenMapIds[mapId] ~= 1 and 3 <= index then
        SysError(SYS_ERR_CARBON_OPEN_STATUS)
        return
      end
      if self.selectGroupIndex == data.index then
        return
      end
      self.selectGroupIndex = index
      selectOne(self.selectGroupIndex)
    end)
    self.modeBtns[index] = btn
  end
  selectOne(self.selectGroupIndex)
  self.btnList:doLayout()
  local btnInfo = UIHelper.extend(ccui.Button:create())
  btnInfo:setImages(MagicRes, {
    "btn_info.png",
    "btn_info.png"
  })
  btnInfo:pos(75, 0):addTo(self.autoBtn):setTouchScale()
  btnInfo:setCallback(function()
    game:createView("global.RuleLayer", {typeStr = "autoBattle"})
  end)
end

function CarbonDetailLayer:showBattleData()
  self.bNormal = self.modeType == 1
  self.btnMode:setImage(DetailRes .. string.format("btn_mode_bg_%d.png", self.modeType))
  self.selectCell = nil
  self:refreshList()
end

function CarbonDetailLayer:refreshList()
  self.listView:removeAllChildren()
  self.btnMode:removeAllChildren()
  local nodeSize = display.newSprite(DetailRes .. "cell_normal_unlock.png"):getContentSize()
  local cellPng = self.bNormal and "cell_normal_unlock.png" or self.modeType == 3 and "cell_nightmare_unlock.png" or "cell_special_unlock.png"
  local mapId = self.mapIndex + self.modeType * 100
  local mapSet = ChapterInfoCsv[mapId]
  if self:checkMapId(self.extraInfo.carbonId) and math.floor(self.extraInfo.carbonId / 100) ~= mapId then
    local posx = 320
    if math.floor(self.extraInfo.carbonId / 100) < 200 and (self.modeType == 2 or self.modeType == 3) then
      posx = 320
    elseif math.floor(self.extraInfo.carbonId / 100) < 300 and (self.modeType == 1 or self.modeType == 3) then
      posx = 400
    end
    display.newSprite(DetailRes .. "boss_tip.png"):pos(posx, 80):addTo(self.btnMode)
  end
  local selectIndex = 0
  local delay = 0.3
  for index = 1, mapSet.dungeonNum do
    local carbonId = mapId * 100 + index
    local carbon = game.role.carbons[carbonId]
    local carbonSet = ChapterBattleCsv[carbonId]
    local autoCarbonSet = AutoBattleCsv[carbonId]
    local lockPng = self.bNormal and "cell_normal_lock.png" or self.modeType == 3 and "cell_nightmare_lock.png" or "cell_special_lock.png"
    local viewNode = ccui.Widget:create()
    viewNode:size(nodeSize):addTo(self.listView)
    local content = UIHelper.newImageView(DetailRes .. (carbon and cellPng or lockPng)):center(viewNode):addTo(viewNode):name("carbon" .. carbonId)
    display.newTTFLabel({
      text = carbonSet.name,
      size = 36,
      color = display.COLOR_WHITE
    }):enableOutline(UIHelper.hex2rgb("#000000"), 1):anch(0, 0):pos(170, 48):addTo(content)
    local tipLabel = display.newTTFLabel({
      text = string.format("推荐美味度:%d", carbonSet.enterPower),
      size = 20,
      color = display.COLOR_WHITE
    }):enableOutline(UIHelper.hex2rgb("#000000"), 1):anch(0, 0):pos(390, 50):addTo(content)
    UIHelper.setMaxWidth(tipLabel, 155)
    if carbonId == 10107 or carbonId == 10207 or carbonId == 10307 or carbonId == 10407 or carbonId == 10507 or carbonId == 10607 or carbonId == 10709 or carbonId == 10809 or carbonId == 10909 then
      local num = game.role.dailyExNum or 0
      local offNum = math.max(globalCsv.EXUpNum - num, 0)
      local tipLabel = display.newTTFLabel({
        text = string.format("今日高额奖励次数：%d/%d", offNum, globalCsv.EXUpNum),
        size = 20,
        color = UIHelper.hex2rgb("#ff6347")
      }):enableOutline(UIHelper.hex2rgb("#000000"), 1):anch(0, 0):pos(170, 16):addTo(content)
    end
    if self.extraInfo.carbonId == carbonId and not self.isAuto then
      local bg = UIHelper.newImageView("ui/carbon/main/boss_table.png"):pos(content:getContentSize().width - 110, content:getContentSize().height - 25):addTo(content)
      local bossData = BossCsv[self.extraInfo.bossId]
      display.newTTFLabel({
        text = bossData.name,
        size = 18,
        color = UIHelper.hex2rgb("#5dff51")
      }):enableOutline(UIHelper.hex2rgb("#000000"), 2):pos(bg:getContentSize().width / 2 + 15, bg:getContentSize().height / 2 + 1):addTo(bg)
    end
    if self:getIsDouble(carbonId) then
      display.newSprite(DetailRes .. "image_more.png"):anch(0, 0.5):pos(7, 15):addTo(content)
    end
    if carbon then
      local result = display.newSprite(DetailRes .. "unlock.png"):pos(62, 65):addTo(content)
      if 0 <= carbon.score then
        result:setTexture(DetailRes .. string.format("star%d.png", carbon.starNum))
        result:pos(64, 60)
      end
      local xPos, interval = 460, 30
      for star = 1, carbon.starNum do
        display.newSprite(DetailRes .. "cake1.png"):pos(xPos + (star - 1) * interval, 22):addTo(content)
      end
      for star = carbon.starNum + 1, 3 do
        display.newSprite(DetailRes .. "cake0.png"):pos(xPos + (star - 1) * interval, 22):addTo(content)
      end
    else
      local xPos, interval = 460, 30
      display.newSprite(DetailRes .. "lock.png"):pos(62, 65):addTo(content)
      for star = 1, 3 do
        display.newSprite(DetailRes .. "cake0.png"):pos(xPos + (star - 1) * interval, 22):addTo(content)
      end
    end
    content:setCallback(function()
      self:showDetail(carbonSet, content, autoCarbonSet)
    end)
    if self.battleInfo.carbonId == carbonId then
      self:showBattle(content, carbonId)
    end
    if self.autoBattleId == carbonId then
      local battleBg = display.newSprite(DetailRes .. "status_bg.png"):anch(0, 0):pos(227, 6):addTo(content)
      display.newTTFLabel({
        text = "自动战斗中",
        size = 30,
        color = display.COLOR_WHITE
      }):pos(130, 22):addTo(battleBg)
    end
    UIHelper.MoveToRight({
      node = content,
      delay = delay,
      time = 0.2
    })
    delay = delay + 0.06
    if carbonId == self.selectCarbon then
      self:showDetail(carbonSet, content, autoCarbonSet)
    end
  end
  self.listView:doLayout()
  self.listView:runAction(transition.sequence({
    cc.DelayTime:create(0.1),
    cc.CallFunc:create(function()
      self.listView:scrollToItem(self.carbonId % 100 - 1, cc.p(0, 0.5), cc.p(0, 0))
    end)
  }))
end

function CarbonDetailLayer:showDetail(carbonSet, cell, autoCarbonSet)
  local bNormal = self.bNormal and "cell_normal_" or self.modeType == 3 and "cell_nightmare_" or "cell_special_"
  if self.selectCell then
    local carbon = game.role.carbons[self.carbonId]
    local bLock = carbon and "unlock" or "lock"
    self.selectCell:setImage(DetailRes .. bNormal .. bLock .. ".png")
  end
  self.selectCell = cell
  self.carbonId = carbonSet.id
  print("showDetail:", self.carbonId)
  local chooseSet = self.isAuto and autoCarbonSet or carbonSet
  local carbon = game.role.carbons[self.carbonId]
  local bLock = carbon and "unlock" or "lock"
  cell:setImage(DetailRes .. bNormal .. bLock .. "_select.png")
  local xPos, yPos, interval, idx = 0, 0, 95, 1
  self.itemNode:removeAllChildren()
  local limits = {}
  for _, itemId in pairs((chooseSet.special2see or carbonSet.special2see):toArray("=", true)) do
    limits[itemId] = true
  end
  for _, itemId in ipairs((chooseSet.gift2see or carbonSet.gift2see):toArray("=", true)) do
    local icon = ItemIcon.new({type = itemId, showTip = true}):scale(0.85):pos(xPos, yPos):addTo(self.itemNode)
    if limits[itemId] then
      display.newSprite(DetailRes .. "limit.png"):pos(73, 73):addTo(icon)
    end
    xPos = xPos + interval
    if idx % 5 == 0 then
      xPos = 0
      yPos = yPos - 85
    end
    idx = idx + 1
  end
  self.countBg:setVisible((chooseSet.tree1drop or carbonSet.tree1drop) ~= "")
  for _, set in ipairs((chooseSet.tree1drop or carbonSet.tree1drop):toTableArray()) do
    local icon = ItemIcon.new({
      type = tonumber(set[1]),
      showTip = true
    }):scale(0.85):pos(xPos, yPos):addTo(self.itemNode)
    display.newSprite(DetailRes .. "drop.png"):pos(46, 13):addTo(icon)
    xPos = xPos + interval
    if idx % 5 == 0 then
      xPos = 0
      yPos = yPos - 85
    end
    idx = idx + 1
  end
  if game.role:activityIsOpen(53) then
    for group, groupData in ipairs(ChapterDropCsv) do
      local dropData = groupData[carbonSet.id]
      if dropData and dropData.gift then
        local gift = dropData.gift:toTableArray()
        for _, one in ipairs(gift) do
          local icon = ItemIcon.new({
            type = tonumber(one[1]),
            showTip = true
          }):scale(0.85):pos(xPos, yPos):addTo(self.itemNode)
          xPos = xPos + interval
          if idx % 5 == 0 then
            xPos = 0
            yPos = yPos - 85
          end
          idx = idx + 1
        end
      end
    end
  end
  local active = carbon and carbon.achievement:toNumMap() or {}
  local score = carbon and carbon.score or -2
  for index = 1, 3 do
    self["mask" .. index]:removeAllChildren()
    self["desc" .. index]:setString("")
    self.node:removeAllChildren()
    if self.isAuto then
      self.enough = true
      xPos, yPos, interval = 20, 0, 95
      for _, set in ipairs(autoCarbonSet.cost:toTableArray()) do
        local bg = display.newSprite(HappyRes .. "cost_bg.png"):pos(xPos, yPos):addTo(self.node)
        bg:setCascadeOpacityEnabled(true)
        display.newSprite(string.format("ui/global/base_%s.png", set[1])):pos(2, 15):addTo(bg)
        display.newTTFLabel({
          text = set[2],
          size = 24
        }):pos(35, 16):addTo(bg)
        if game.role["material" .. set[1]] < tonumber(set[2]) then
          self.enough = false
        end
        xPos = xPos + interval
      end
    else
      local condition = carbonSet["con" .. index .. "Desc"]
      self["desc" .. index]:setString(condition)
      local cake, color = "cake0.png", "#ffffff"
      if -2 < score then
        if active[index] then
          cake = "cake1.png"
        else
          color = "#ff3f30"
        end
      end
      display.newSprite(DetailRes .. cake):addTo(self["mask" .. index])
      self["desc" .. index]:setColor(UIHelper.hex2rgb(color))
    end
  end
end

function CarbonDetailLayer:showBattle(cell, carbonId)
  local battleBg = display.newSprite(DetailRes .. "status_bg.png"):anch(0, 0):pos(227, 6):addTo(cell)
  display.newTTFLabel({
    text = "战斗中",
    size = 30,
    color = display.COLOR_WHITE
  }):pos(82, 22):addTo(battleBg)
  display.newTTFLabel({
    text = string.format("天数:%d", self.battleInfo.day),
    size = 16,
    color = display.COLOR_WHITE
  }):anch(0, 0):pos(165, 23):addTo(battleBg)
  display.newTTFLabel({
    text = "时间剩余:",
    size = 16,
    color = display.COLOR_WHITE
  }):anch(0, 0):pos(165, 4):addTo(battleBg)
  local timeLabel = display.newTTFLabel({
    text = "",
    size = 16,
    color = display.COLOR_WHITE
  }):anch(0, 0):pos(240, 4):addTo(battleBg)
  local setTime
  
  function setTime()
    local leftTime = self.battleInfo.moveTime - game:nowTime()
    if 0 <= leftTime then
      timeLabel:setString(UIHelper.getTimeStr(leftTime))
      timeLabel:runAction(transition.sequence({
        cc.DelayTime:create(1),
        cc.CallFunc:create(setTime)
      }))
    else
      timeLabel:setString("00:00")
    end
  end
  
  setTime()
end

function CarbonDetailLayer:getMaxCarbon()
  local mapSet = ChapterInfoCsv[self.mapId]
  local maxId = 0
  for index = 1, mapSet.dungeonNum do
    local carbonId = self.mapId * 100 + index
    local carbon = game.role.carbons[carbonId]
    if carbon then
      maxId = carbonId
    end
  end
  return maxId == 0 and self.mapId * 100 + 1 or maxId
end

function CarbonDetailLayer:getSeletCarbon()
  local carbonId = 0
  if self:checkInMapId(self.battleInfo.carbonId) then
    carbonId = self.battleInfo.carbonId
  else
    local nextCarbonId = game.role.lastCarbonInfo[self.mapIndex]
    if nextCarbonId and self:checkInMapId(nextCarbonId) then
      if game.role.carbons[nextCarbonId] then
        carbonId = nextCarbonId
      else
        carbonId = nextCarbonId - 1
      end
    end
  end
  if carbonId == 0 then
    carbonId = self:getMaxCarbon()
  end
  return carbonId
end

function CarbonDetailLayer:checkMapId(carbonId)
  local mapId = math.floor(carbonId / 100)
  local mapIndex = mapId % 100
  return mapIndex == self.mapIndex
end

function CarbonDetailLayer:checkInMapId(carbonId)
  local mapId = math.floor(carbonId / 100)
  return mapId == self.mapId
end

function CarbonDetailLayer:getIsDouble(tempId)
  if not globalCsv.carbonIsDouble then
    return false
  end
  for _, carbonId in pairs(self.carbons) do
    if tempId == carbonId then
      return true
    end
  end
  return false
end

return CarbonDetailLayer
