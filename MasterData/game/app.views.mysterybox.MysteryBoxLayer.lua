local MysteryRes = "ui/mysterybox/"
local MysteryBoxCsv = require("csvdata.activity_84_diamondblindbox")
local uiData = {
  csbFile = "ui/mysterybox/MysteryBoxLayer.csb",
  mask = true,
  popup = true,
  maskClick = false,
  widgets = {
    mainBg = "mainBg",
    heroBg = "heroBg",
    timeBg = "mainBg/timeBg",
    tipsBtn = "mainBg/tipsBtn",
    exitBtn = "mainBg/exitBtn",
    boxSelectBg = "mainBg/boxSelectBg",
    selectDengBg = "mainBg/selectDengBg",
    boxNode = "mainBg/boxNode",
    bgMask = "mainBg/bgMask",
    btnNode = "mainBg/btnNode",
    select_1 = "mainBg/select_1",
    select_2 = "mainBg/select_2",
    select_3 = "mainBg/select_3",
    select_4 = "mainBg/select_4",
    boxSelectNode = "mainBg/boxSelectNode",
    boxSelect = "mainBg/boxSelectNode/boxSelect"
  }
}
local MysteryBoxLayer = class("MysteryBoxLayer", UIBase)

function MysteryBoxLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function MysteryBoxLayer:init(params)
  self.curStatus = game.role.activityStatus["84"]
  self.select = params.select or 1
  self.runDraw = false
  self:checkBoxRedPoint()
  game.role:checkRedPoint("mysteryBox")
  for i = 1, 4 do
    local selectBtn = self["select_" .. i]
    selectBtn:setCallback(function()
      if self.runDraw then
        return
      end
      print("select:", self.select, "i:", i)
      local lastSelect = self.select
      self.select = i
      self:showData()
      self:showSelectDeng()
      self:showGetBox(false)
      if lastSelect ~= self.select and self.selectBox then
        self.selectBox:removeSelf()
        self.selectBox = nil
      end
    end)
    local bShow = checkbool(game.role.redPoints.mysteryBox["" .. i])
    UIHelper.showRedPoint(self["select_" .. i], bShow, cc.p(12, 6), 0.8)
  end
  self.timeBg:hide()
  self.boxSelectNode:setPositionY(self.boxSelectNode:getPositionY() - 10)
  self.tipsBtn:setTouchScale()
  self.tipsBtn:setCallback(function()
    game:createView("global.RuleLayer", {
      typeStr = "activity_84",
      tableHeightMin = 56
    })
  end)
  self.exitBtn:setTouchScale()
  self.exitBtn:setCallback(function()
    self:onClose()
  end)
  self:showSelectDeng()
  local stars = UIHelper.createSpineNodeByRes("spine/ui/activity/stars")
  stars:setAnimation(0, "special", true)
  stars:pos(0, 0):addTo(self.boxSelectNode):name("stars")
  UIHelper.MoveToLeft({
    node = self.mainBg,
    time = 0.3
  })
  UIHelper.MoveToRight({
    node = self.heroBg,
    time = 0.3
  })
end

function MysteryBoxLayer:showSelectDeng()
  local zonePosY = 124
  local offsetPosY = -81
  local select = self.select
  local posY = 124 + offsetPosY * (select - 1)
  if not self.selectDeng then
    self.selectDeng = UIHelper.createSpineNodeByRes("spine/ui/activity/boxSelectBg")
    self.selectDeng:setAnimation(0, "special", true)
    self.selectDeng:pos(0, posY):addTo(self.selectDengBg):name("boxSelectBg")
  end
  self.selectDeng:setPosition(cc.p(0, posY))
end

function MysteryBoxLayer:showData()
  self.btnNode:removeAllChildren()
  self.boxSelect:removeAllChildren()
  local select = self.select
  local csvData = MysteryBoxCsv[select + 1]
  local isFirst = self.curStatus.freeCount == 1
  if isFirst then
    csvData = MysteryBoxCsv[1]
  end
  
  local function sendMsg(btn)
    if self.selectBox == nil then
      self.selectBox = display.newSprite(MysteryRes .. "mysterybox_select_1.png"):anch(0.5, 0.5):pos(24, 35):addTo(self["select_" .. self.select])
    end
    self:showGetBox(false)
    math.randomseed(os.time())
    local speed = math.random(40, 44)
    local posList = self:getSelectPos(self.selectBox, speed)
    self.runDraw = true
    self:selectRunAction(self.selectBox, posList, 1, function()
      print("canSendMsg")
      self.runDraw = false
      btn:setTouchEnabled(false)
      game:sendData(actionCodes.Activity_mysteryBoxDrawRpc, MsgPack.pack({
        id = self.select,
        diamond = csvData.diamond
      }))
      UIHelper.showWaiting()
      game:addResponseHandler(actionCodes.Activity_mysteryBoxDrawRpc, function(event)
        UIHelper.removeWaiting()
        btn:setTouchEnabled(true)
        local msg = MsgPack.unpack(event.data)
        local layer = game:createView("mysterybox.MysteryGetLayer", {
          mulNum = msg.mulNum,
          select = self.select
        })
        BackManager:push(function()
          layer:close()
          MedalRewardLayer.new({
            items = msg.reward
          })
        end)
        self.curStatus = game.role.activityStatus["84"]
        self:showData()
        self:checkBoxRedPoint()
      end)
    end)
  end
  
  local btn = UIHelper.extend(ccui.Button:create())
  local btnName = "mysterybox_" .. select .. "_btn.png"
  btn:setImages(MysteryRes, {btnName, btnName})
  btn:pos(0, 0):addTo(self.btnNode)
  btn:setTouchScale()
  btn:name("btn" .. select)
  btn:setCallback(function()
    if self.runDraw then
      return
    end
    if false then
      if self.curStatus["drawCount" .. self.select] >= csvData.stage then
        MFlashMsg:show({
          text = "该品质盲盒抽取次数已达上限，可选择其他品质盲盒抽取"
        })
        return true
      end
      game:createView("mysterybox.MysteryDialog", {
        title = "提示",
        text = "主厨的盲盒翻倍次数不足！活动期间\n充值6/30/68/98/168元可获得对应盲盒的翻倍次数",
        cancelText = "确认",
        okText = "前往充值",
        okCallback = function()
          local layer = game:createView("shop.ShopLayer", {curType = 1, selected = 1})
          BackManager:push(function()
            TopBar:show(TopBarType.money)
            layer:close()
          end)
          self:close()
          return true
        end,
        cancelCallback = function()
          return true
        end
      })
    elseif game.role.diamond < csvData.diamond then
      game:createView("mysterybox.MysteryDialog", {
        title = "提示",
        text = "<img src='ui/global/5.png' scale=0.5 />钻石数量不足，是否前往商城购买？",
        cancelText = "取消",
        okText = "确认",
        okCallback = function()
          local layer = game:createView("shop.ShopLayer", {curType = 1, selected = 1})
          BackManager:push(function()
            TopBar:show(TopBarType.money)
            layer:close()
          end)
          self:close()
          return true
        end,
        cancelCallback = function()
          return true
        end
      })
    else
      game:createView("mysterybox.MysteryDialog", {
        title = "提示",
        text = string.format("是否确认投入%s钻石进入盲盒机进行翻倍？", csvData.diamond),
        cancelText = "取消",
        okText = "确认",
        okCallback = function()
          sendMsg(btn)
          return true
        end,
        cancelCallback = function()
          return true
        end
      })
    end
  end)
  local colors = {
    "#ffffff",
    "#ffffff",
    "#ffffff",
    "#ffffff"
  }
  local diamondText = "x" .. csvData.diamond
  display.newTTFLabel({
    text = diamondText,
    size = 14,
    color = UIHelper.hex2rgb(colors[select])
  }):enableOutline(UIHelper.hex2rgb("#000000"), 1):pos(24, 12):addTo(btn)
  display.newSprite(MysteryRes .. "mysterybox_" .. select .. ".png"):anch(0.5, 0.5):center(self.boxSelect):addTo(self.boxSelect)
end

function MysteryBoxLayer:showTimeNum()
  self.timeBg:removeAllChildren()
  local csvData = MysteryBoxCsv[self.select + 1]
  local isFirst = self.curStatus.freeCount == 1
  if isFirst then
    csvData = MysteryBoxCsv[1]
  end
  self.canDrawCount = self.curStatus["recharge" .. self.select] - self.curStatus["drawCount" .. self.select] + self.curStatus.freeCount
  local timeText = string.format("剩余抽取: <div color=#ffff00>%s</div>/%s", self.canDrawCount, csvData.stage - self.curStatus["drawCount" .. self.select])
  if isFirst then
    timeText = string.format("免费次数: <div color=#ffff00>%s</div>/%s", 1, csvData.stage - self.curStatus["drawCount" .. self.select])
  end
  MRichText.new({
    text = timeText,
    size = 13,
    color = UIHelper.hex2rgb("#ffffff")
  }):anch(0.5, 0.5):pos(53.5, 8.5):addTo(self.timeBg)
end

function MysteryBoxLayer:getSelectPos(node, count)
  local x = node:getPositionX()
  local offsetX = 72
  local startPosX = 24
  local endPosX = 312
  local posXlist = {}
  local index = 1
  local lastPosX = x - offsetX
  while count > #posXlist do
    local nextPosX = lastPosX + offsetX
    if endPosX < nextPosX then
      nextPosX = startPosX
    end
    lastPosX = nextPosX
    table.insert(posXlist, {index = index, nextPosX = nextPosX})
    index = index + 1
  end
  table.sort(posXlist, function(a, b)
    return a.index < b.index
  end)
  return posXlist
end

function MysteryBoxLayer:selectRunAction(node, posList, index, callBack)
  if index > #posList then
    if callBack then
      self:showGetBox(true, callBack)
    end
    return
  end
  node:show()
  local delayTime = #posList - index < 10 and 10 - (#posList - index) or 0
  node:setPosition(cc.p(posList[index].nextPosX, 35))
  game:playMusic(1032)
  scheduler.performWithDelayGlobal(function()
    index = index + 1
    self:selectRunAction(node, posList, index, callBack)
  end, 0.03 + delayTime * 0.03)
end

function MysteryBoxLayer:showGetBox(isShow, callBack)
  self.boxNode:removeAllChildren()
  if isShow then
    local boxGet = display.newSprite(MysteryRes .. "mysterybox_" .. self.select .. ".png"):anch(0.5, 0.5):pos(0, 60):addTo(self.boxNode)
    boxGet:setOpacity(0)
    boxGet:runAction(transition.sequence({
      cc.Spawn:create(cc.FadeIn:create(0.1), cc.MoveBy:create(0.2, cc.p(0, -50))),
      cc.RotateBy:create(0.08, 10),
      cc.RotateBy:create(0.16, -20),
      cc.RotateBy:create(0.08, 10),
      cc.CallFunc:create(function()
        callBack()
      end)
    }))
  end
end

function MysteryBoxLayer:checkBoxRedPoint()
  self.timerHandler = scheduler.scheduleGlobal(function()
    game.role:checkRedPoint("mysteryBox")
    for i = 1, 4 do
      local bShow = checkbool(game.role.redPoints.mysteryBox["" .. i])
      UIHelper.showRedPoint(self["select_" .. i], bShow, cc.p(12, 6), 0.8)
    end
  end, 1)
end

function MysteryBoxLayer:onClose()
  if self.timerHandler then
    scheduler.unscheduleGlobal(self.timerHandler)
  end
  self:close()
end

return MysteryBoxLayer
