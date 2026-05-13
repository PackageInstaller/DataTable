local BattleCsv = require("csvdata.lty.lty_battle")
local ItemCsv = require("csvdata.item")
local LtyRes = "ui/lty/main/"
local uiData = {
  csbFile = "ui/lty/LtyMainLayer.csb",
  widgets = {
    mainBg = "mainBg",
    up = "up",
    numBg1 = "numBg1",
    numBg2 = "numBg2",
    mainFrame = "mainFrame",
    list = "mainFrame/list",
    node1 = "mainFrame/node1",
    node2 = "mainFrame/node2",
    btn1 = "mainFrame/btn1",
    btn2 = "mainFrame/btn2",
    num1 = "numBg1/num1",
    num2 = "numBg2/num2",
    btnInfo = "btnInfo",
    btnReward = "btnReward"
  }
}
local chooseTextColor = "#8a3f0d"
local unchooseTextColor = "#186596"
local LtyMainLayer = class("LtyMainLayer", UIBase)

function LtyMainLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function LtyMainLayer:init(params)
  TopBar:show(TopBarType.full, LtyTitleName)
  TopBar:showAnimation(true)
  if UIHelper.isiPhoneX() then
    UIHelper.fitForiPhoneX(self.mainBg)
  end
  UIHelper.MoveToDown({
    node = self.up
  })
  self.handlers = {}
  self.goMainLayer = params.goMainLayer or false
  self.easyData = {}
  self.selectAutoBattleId = 0
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
      UIHelper.showRedPoint(self.btnReward, bShow, cc.p(-3, 2), 0.8)
    end
  end))
  local bShow = checkbool(next(game.role.redPoints.lty or {}))
  UIHelper.showRedPoint(self.btnReward, bShow, cc.p(-3, 2), 0.8)
  local temp = json.decode(game.role.activityBackStatus)
  local timeData = temp["29"]
  self.openType = {}
  local now = game:nowTime()
  for _, data in pairs(BattleCsv) do
    if not self.openType[data.type] then
      local mid = timeData.start + data.openTime * 86400
      if now >= mid and now <= timeData.close then
        self.openType[data.type] = {open = true, time = mid}
      else
        self.openType[data.type] = {open = false, time = mid}
      end
    end
  end
  self.curBattle = game.role.ltyCurBattle:toArray("=", true)
  local temp = game.role.ltyLastCarbon and BattleCsv[game.role.ltyLastCarbon].type or 1
  self.selectType = BattleCsv[self.curBattle[1]] and BattleCsv[self.curBattle[1]].type or temp
  self.sortData = {}
  local names = {"上半场", "下半场"}
  self.group = MRadioGroup:create({
    chooseCb = function(sender)
      local text1 = sender:getChildByName("1")
      text1:enableOutline(UIHelper.hex2rgb(chooseTextColor), 2)
      local text2 = sender:getChildByName("2")
      if text2 then
        text2:enableOutline(UIHelper.hex2rgb(chooseTextColor), 1)
      end
    end,
    unchooseCb = function(sender)
      local text1 = sender:getChildByName("1")
      text1:enableOutline(UIHelper.hex2rgb(unchooseTextColor), 2)
      local text2 = sender:getChildByName("2")
      if text2 then
        text2:enableOutline(UIHelper.hex2rgb(unchooseTextColor), 1)
      end
    end
  })
  for index, name in ipairs(names) do
    local btn = self["btn" .. index]
    display.newTTFLabel({text = name, size = 26}):pos(52, 27):addTo(btn):name("1")
    if not self.openType[index].open then
      local date = CommonHelper.date(self.openType[index].time - 86400, nil, true)
      display.newTTFLabel({
        text = string.format("%d/%02d开启", date.month, date.day),
        size = 16
      }):pos(52, 6):addTo(btn):name("2")
    end
    btn:name("btn" .. index)
    btn:setGroup(self.group)
    btn:setCallback(function()
      if not self.openType[index].open then
        SysError(SYS_ERR_LTY_CARBON_NOT_OPEN)
        self.group:chooseByName("btn" .. self.selectType)
        return
      end
      self.mainFrame:setTexture(LtyRes .. string.format("main_frame_%d.png", index))
      self.selectType = index
      self:showCarbons()
      self.node2:removeAllChildren()
      local heroCard = HeroBigCard.new({
        type = globalCsv["ltyHeroCardID" .. index]
      }):scale(0.83):pos(0, 220):addTo(self.node2)
    end)
  end
  self.mainFrame:setTexture(LtyRes .. string.format("main_frame_%d.png", self.selectType))
  self.btnInfo:setTouchScale()
  self.btnInfo:setCallback(function()
    game:createView("global.RuleLayer", {typeStr = "lty"})
  end)
  self.btnReward:setTouchScale()
  self.btnReward:setCallback(function()
    local layer = game:createView("lty.LtyGiftLayer", {
      selected = self.selectType
    })
    BackManager:push(function()
      TopBar:show(TopBarType.full, LtyTitleName)
      layer:close()
    end)
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
  local heroCard = HeroBigCard.new({
    type = globalCsv.ltyHeroCardID1
  }):scale(0.83):pos(0, 220):addTo(self.node2)
end

function LtyMainLayer:showData(params)
  self.group:chooseByName("btn" .. self.selectType)
  self:showCarbons()
  self:updateIconNum()
  self:showAutoSelect()
end

function LtyMainLayer:showCarbons()
  self.sortData = {}
  local easy = {}
  local normal = {}
  for _, data in pairs(BattleCsv) do
    if data.type == self.selectType then
      local count = game.role.ltyFightCount:getv(data.id, 0)
      local temp = clone(data)
      temp.count = count
      if data.challenge == 1 then
        if count <= 0 then
          table.insert(easy, temp)
        end
      else
        table.insert(normal, temp)
      end
    end
  end
  if next(easy) then
    self.sortData = easy
  else
    self.sortData = normal
  end
  self.easyData = easy
  table.sort(self.sortData, function(a, b)
    local factorA = self.curBattle[1] == a.id and -10000 or a.id
    local factorB = self.curBattle[1] == b.id and -10000 or b.id
    return factorA < factorB
  end)
  self:showCell()
end

function LtyMainLayer:showCell()
  self.list:removeAllChildren()
  local selected
  local size = display.newSprite(LtyRes .. "cell_1.png"):getContentSize()
  for index, cellData in ipairs(self.sortData) do
    local viewNode = ccui.Widget:create()
    viewNode:size(size.width + 10, size.height + 6):addTo(self.list)
    local cell = self:createCell(cellData)
    cell:center(viewNode):addTo(viewNode)
    if game.role.ltyLastCarbon == cellData.id then
      selected = index
    end
  end
  self.list:stopAutoScroll()
  self.list:forceDoLayout()
  if selected then
    self.list:scrollToItem(selected - 1, cc.p(0, 0.5), cc.p(0, -0.5))
  end
end

local posX = {
  0,
  0,
  -1,
  0
}

function LtyMainLayer:createCell(data)
  local image = data.challenge == 1 and "cell_3.png" or string.format("cell_%d.png", data.type)
  local color = data.challenge == 1 and "#7a7a7a" or data.type == 1 and "#93522b" or "#92193f"
  local cell = UIHelper.newImageView(LtyRes .. image)
  display.newTTFLabel({
    text = data.name,
    size = 22
  }):enableOutline(UIHelper.hex2rgb(color), 1):anch(0, 0.5):pos(15, 99):addTo(cell)
  display.newTTFLabel({
    text = "推荐美味度: " .. data.enterPower,
    size = 18
  }):enableOutline(UIHelper.hex2rgb(color), 1):anch(0, 0.5):pos(15, 77):addTo(cell)
  display.newTTFLabel({
    text = "通关总奖励:",
    size = 18
  }):enableOutline(UIHelper.hex2rgb(color), 1):anch(0, 0.5):pos(15, 57):addTo(cell)
  if self.curBattle[1] == data.id then
    display.newSprite(LtyRes .. "battle.png"):anch(0, 0.5):pos(231, 64):addTo(cell)
  end
  if data.challenge == 1 then
    display.newSprite(LtyRes .. "limit.png"):pos(282, 94):addTo(cell)
  end
  local set = data.levelGift:toArray("=", true)
  display.newSprite(ItemCsv[set[1]].icon):scale(0.4):pos(125, 55):addTo(cell)
  display.newTTFLabel({
    text = set[2] + data.gift2see,
    size = 18
  }):enableOutline(UIHelper.hex2rgb(color), 1):anch(0, 0.5):pos(140, 57):addTo(cell)
  set = data.cost:toArray("=", true)
  local xPos = -38
  for index, count in ipairs(set) do
    xPos = xPos + 81 + posX[index]
    display.newTTFLabel({
      text = count,
      size = 20,
      color = UIHelper.hex2rgb(color)
    }):anch(0, 0.5):pos(xPos, 25):addTo(cell)
  end
  
  local function StartBattle()
    if self.curBattle[1] ~= 0 then
      if self.curBattle[1] ~= data.id then
        SysError(SYS_ERR_LTY_CARBON_IS_BATTLING)
        return
      end
      local layer = game:createView("lty.LtyCarbonLayer", {
        chapterId = data.id
      })
      self:hide()
      BackManager:push(function()
        self.curBattle = game.role.ltyCurBattle:toArray("=", true)
        self:show()
        self:showData()
        layer:close()
      end)
      return
    end
    local enough = true
    for index, count in ipairs(set) do
      if count > (game.role["material" .. index] or 0) then
        enough = false
      end
    end
    if data.challenge == 1 and 0 < data.count then
      SysError(SYS_ERR_LTY_CARBON_TIMES_USE_OUT)
      return
    end
    if not enough then
      SysError(SYS_ERR_LTY_SOURCE_NOT_ENOUGH)
      return
    end
    
    local function makeSure()
      game:sendData(actionCodes.Activity_ltyStartChallengeRpc, MsgPack.pack({
        id = data.id
      }))
      UIHelper.showWaiting()
      game:addResponseHandler(actionCodes.Activity_ltyStartChallengeRpc, function(event)
        UIHelper.removeWaiting()
        game.role.ltyLastCarbon = data.id
        
        local function enterCarbon()
          self.curBattle = game.role.ltyCurBattle:toArray("=", true)
          local layer = game:createView("lty.LtyCarbonLayer", {
            chapterId = data.id
          })
          self:hide()
          BackManager:push(function()
            self:show()
            self.curBattle = game.role.ltyCurBattle:toArray("=", true)
            self:showData()
            layer:close()
          end)
        end
        
        if self.curBattle[1] == 0 and data.story1 and data.story1 ~= 0 then
          game:createView("talk.PlotTalkLayer", {
            talkId = data.story1,
            csvNo = data.readcsv or 0,
            reportSkip = true,
            onComplete = function()
              enterCarbon()
            end
          })
        else
          enterCarbon()
        end
      end)
      return true
    end
    
    if game.role.ltyLastCarbon == data.id and UserData.ltyAutoBattleLoop11 == 1 and not next(self.easyData) and not self.goMainLayer then
      makeSure()
      return
    end
    MDialog:double({
      title = "提示",
      text = "主厨，确定要消耗相应资源进行挑战吗？",
      okCallback = function()
        makeSure()
        return true
      end,
      cancelCallback = function()
        return true
      end
    })
  end
  
  cell:setCallback(function()
    StartBattle()
  end)
  if UserData.ltyAutoBattleLoop11 == 1 and not next(self.easyData) and game.role.ltyLastCarbon == data.id and not self.goMainLayer then
    self:showAutoDelay(function()
      StartBattle()
    end)
  end
  local preData = BattleCsv[data.id - 1]
  if preData and preData.challenge == 1 and game.role.ltyFightCount:getv(preData.id, 0) == 0 then
    cell:setTouchEnabled(false)
    UIHelper.setImageViewGray(cell)
  end
  return cell
end

function LtyMainLayer:showAutoDelay(callback)
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

function LtyMainLayer:showAutoSelect()
  local label = display.newTTFLabel({
    text = "自动战斗",
    size = 18
  }):pos(100, 40):addTo(self.mainFrame):enableOutline(UIHelper.hex2rgb("#000000"), 1)
  local blockBg = UIHelper.extend(ccui.Button:create())
  blockBg:setImages(LtyRes, {
    "block_bg.png",
    "block_bg.png"
  })
  blockBg:pos(160, 40):anch(0.5, 0.5):addTo(self.mainFrame)
  blockBg:setScale(0.8)
  
  local function showYes()
    if UserData.ltyAutoBattleLoop11 == 1 then
      UIHelper.newImageView(LtyRes .. "yes.png"):center(blockBg):addTo(blockBg)
    else
      blockBg:removeAllChildren()
    end
  end
  
  blockBg:setCallback(function()
    if next(self.easyData) then
      SysError(SYS_ERR_EASY_NOT_FINISHED)
      return
    end
    UserData.ltyAutoBattleLoop11 = (not UserData.ltyAutoBattleLoop11 or UserData.ltyAutoBattleLoop11 == 0) and 1 or 0
    GameState.save(UserData)
    showYes()
  end)
  showYes()
end

function LtyMainLayer:updateIconNum()
  self.num1:setString(game.role.items[166] or 0)
  self.num2:setString(game.role.items[167] or 0)
end

function LtyMainLayer:onExit()
  for _, tag in pairs(self.handlers) do
    game.role:removeEventListener(tag)
  end
  if self.timerHandler then
    scheduler.unscheduleGlobal(self.timerHandler)
  end
  game.role.ltyLastCarbon = nil
end

return LtyMainLayer
