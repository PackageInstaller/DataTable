local ItemCsv = require("csvdata.item")
local SauceCsv = require("csvdata.sauce")
local BreakCsv = require("csvdata.sauce_break")
local heroRes = "ui/hero/"
local strengthRes = "ui/kitchen/strength/"
local uiData = {
  csbFile = "ui/kitchen/StrengthLayer.csb",
  widgets = {
    mainBg1 = "mainBg1",
    list = "mainBg1/list",
    mainBg3 = "mainBg1/mainBg3",
    evoBtn = "mainBg1/evoBtn",
    heroNum = "mainBg1/numBg/heroNum",
    desc = "mainBg1/tipBg/Text",
    mainBg2 = "mainBg2",
    circle = "mainBg2/circle",
    tipText = "mainBg2/desk/tip/text",
    heroNode = "mainBg2/desk/heroNode",
    addBtn = "mainBg2/desk/addBtn",
    desk = "mainBg2/desk",
    panel = "panel",
    barBg = "panel/barBg",
    exp = "panel/exp",
    desc1 = "panel/Text_0",
    buttom = "buttom",
    angel1 = "angel1",
    angel2 = "angel2",
    maskNode = "maskNode"
  }
}
local SauceStrengthLayer = class("SauceStrengthLayer", UIBase)

function SauceStrengthLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function SauceStrengthLayer:init(params)
  if UIHelper.isiPhoneX() then
    UIHelper.fitForiPhoneX(self.buttom)
    self.mainBg1:setPositionX(self.mainBg1:getPositionX() + 200)
    self.angel2:setPositionX(self.angel2:getPositionX() + 200)
  end
  self.list:setDirection(1)
  self.panel:hide()
  self.desc1:hide()
  self.barBg:setPositionY(self.barBg:getPositionY() - 10)
  self.circle:runAction(cc.RepeatForever:create(cc.RotateBy:create(20, 360)))
  self.tipText:setString("点击小人\n添加酱料")
  self.heroNum:setString("酱料: 0")
  self.desc:setString("强化酱料可以获得更强的属性")
  self.eatList = {0}
  self.cards = {}
  self:showList()
  self.addBtn:removeSelf()
  self.addBtn = UIHelper.extend(ccui.Button:create())
  self.addBtn:setImages("ui/sauce/strength/", {
    "btn_add.png",
    "btn_add.png"
  })
  self.addBtn:pos(228, 349):addTo(self.desk, nil, 2)
  self.addBtn:setCallback(function()
    self:showChooseSauce()
  end)
  self.evoBtn:setTouchScale()
  self.evoBtn:setCallback(function()
    local sauceIds = {}
    local showTip = false
    for _, sauceId in ipairs(self.eatList) do
      local sauce = game.role.sauces[sauceId]
      if sauce then
        sauceIds[#sauceIds + 1] = sauceId
        if ItemCsv[sauce:getItemId()].star >= 4 then
          showTip = true
        end
      end
    end
    local bxxq = false
    for _, sauceId in pairs(self.eatList) do
      local sauce = game.role.sauces[sauceId]
      if sauce and (sauce.csvData.type == "" or sauce.csvData.type == "9999") then
        bxxq = true
        break
      end
    end
    if not self.sauceId then
      SysError(SYS_ERR_STRENGTHEN_SAUCE_CHOOSE)
      return
    end
    if #sauceIds == 0 then
      SysError(SYS_ERR_STRENGTHEN_SAUCE_NO_MATERIAL)
      return
    end
    
    local function sendRequest()
      game:sendData(actionCodes.Sauce_breakRpc, MsgPack.pack({
        sauceId = self.sauceId,
        eatSauces = sauceIds
      }))
      UIHelper.showWaiting()
      game:addResponseHandler(actionCodes.Sauce_breakRpc, function(event)
        UIHelper.removeWaiting()
        local msg = MsgPack.unpack(event.data)
        self.eatList = {0}
        self:showAnimation(msg.oldLevel)
      end)
    end
    
    if showTip then
      MDialog:double({
        text = string.format("当前选中的酱料中包含高品质酱料%s，确定要继续强化吗？", bxxq and "和<div color=#ff0000>香香球</div>" or "")
      }, function()
        sendRequest()
      end)
      return
    end
    sendRequest()
  end)
  UIHelper.MoveToRight({
    node = self.mainBg2
  })
  UIHelper.MoveToLeft({
    node = self.mainBg1
  })
  UIHelper.MoveToUp({
    node = self.buttom,
    delay = 0.2
  })
  UIHelper.MoveToUp({
    node = self.angel1,
    delay = 0.3
  })
  UIHelper.MoveToUp({
    node = self.angel2,
    delay = 0.3
  })
end

function SauceStrengthLayer:showMainHero()
  self.heroNode:removeAllChildren()
  self.addBtn:hide()
  local sauce = game.role.sauces[self.sauceId]
  if not sauce then
    return
  end
  self.exp:removeAllChildren()
  self.barBg:removeAllChildren()
  self.panel:show()
  self:showPanel()
  local spineNode = UIHelper.newImageView(sauce:getBigImg()):anch(0.5, 0):scale(0.6):pos(0, -45):addTo(self.heroNode)
  spineNode:setCallback(function()
    self:showChooseSauce()
  end)
  local nameBg = display.newSprite("ui/equip/up/zb_1.png"):pos(0, 240):addTo(self.heroNode)
  local proBg = UIHelper.newImageView(string.format("ui/sauce/card/sauce_pro_bg_%d.png", ItemCsv[sauce:getItemId()].star)):pos(0, 22):addTo(nameBg)
  UIHelper.newImageView(string.format("ui/global/profession_%d.png", sauce.csvData.profession)):center(proBg):addTo(proBg)
  display.newTTFLabel({
    text = sauce:getName(),
    size = 20
  }):enableOutline(UIHelper.hex2rgb("#000000"), 1):anch(0.5, 0.5):pos(115, 22):addTo(nameBg)
  local look = UIHelper.extend(ccui.Button:create())
  look:setImages("ui/global/", {"look.png", "look.png"})
  look:pos(232, 22):addTo(nameBg)
  look:setTouchScale()
  look:setCallback(function()
    local width = display.width
    local moveX = 0
    if UIHelper.isiPhoneX() then
      width = width + UIHelper.getMoveXForX() * 2
      moveX = UIHelper.getMoveXForX()
    end
    local mask = UIHelper.newMask({
      size = cc.size(width, display.height),
      color = "#000000",
      opacity = 120
    })
    mask:pos(-moveX, 0):addTo(display.getRunningScene(), POPUP_LAYER_ORDER)
    mask:setTouchEnabled(true)
    mask:setCallback(function()
      mask:removeSelf()
    end)
    local detailNode = display.newNode():pos(width / 2, 570):addTo(mask)
    game:createView("sauce.SauceDetailLayer", {
      scene = detailNode,
      sauceId = self.sauceId,
      showHero = true,
      showBg = 1
    })
  end)
end

function SauceStrengthLayer:showList()
  self.heroNum:setString(string.format("酱料: %d/20", #self.eatList - 1))
  self.list:removeAllChildren()
  local cellSize = cc.size(520, 156)
  local viewNode
  for index, sauceId in ipairs(self.eatList) do
    local col = index % 4
    if col == 1 then
      viewNode = ccui.Widget:create()
      viewNode:size(cellSize):addTo(self.list)
    end
    col = col == 0 and 4 or col
    if sauceId == 0 then
      local card = UIHelper.newImageView("ui/sauce/card/card_top_bg.png"):anch(0, 0):pos(4 + (col - 1) * 144 * 0.84, 0):addTo(viewNode)
      UIHelper.newImageView("ui/equip/reforge/add.png"):pos(58, 77):addTo(card)
      UIHelper.newText({
        text = "添加酱料",
        size = 20,
        color = UIHelper.hex2rgb("#b5f831")
      }):enableOutline(UIHelper.hex2rgb("#000000"), 1):pos(58, 23):addTo(card)
      card:setCallback(function()
        self:add()
      end)
    else
      local card = SauceSmallCard.new({sauceId = sauceId}):scale(0.84):anch(0, 0):pos(2 + (col - 1) * 144 * 0.84, 0):addTo(viewNode)
      card:setCallback(function()
        table.remove(self.eatList, index)
        self:showList()
        self:showPanel("choose")
      end)
    end
  end
  self.list:requestDoLayout()
end

function SauceStrengthLayer:showPanel(type, up)
  local title = self.exp:getChildByName("title")
  local bar = self.barBg:getChildByName("bar")
  local num = self.barBg:getChildByName("num")
  local progress = self.barBg:getChildByName("progress")
  local sauce = game.role.sauces[self.sauceId]
  local ExpSet = BreakCsv[sauce.type][sauce.breakL]
  local curExp = self:getTempMaxExp()
  local endLevel = self:getCurMaxLevel(curExp)
  local maxLevel = #BreakCsv[sauce.type]
  if type == "choose" then
    local colorT = #self.eatList == 0 and "#3a9721" or "#ff3d72"
    local colorN = #self.eatList == 0 and "#ffffff" or "#ff3d72"
    title:setString(string.format("强化进度 <div color=%s >%d</div><div color=#3a9721 >/%d</div>", colorT, endLevel, maxLevel))
    num:setString(string.format("<div color=%s outline=1,#000000 >%d</div><div color=#ffffff outline=1,#000000 >/%d</div>", colorN, curExp, ExpSet.exp))
    progress:stopAllActions()
    progress:setPercentage(curExp / ExpSet.exp * 100)
    progress:runAction(cc.RepeatForever:create(transition.sequence({
      cc.FadeTo:create(0.5, 100),
      cc.FadeTo:create(0.5, 255)
    })))
  elseif type == "send" then
    ExpSet = BreakCsv[sauce.type][endLevel]
    local action = {}
    if up then
      table.insert(action, cc.ProgressTo:create(0.5, 100))
      table.insert(action, cc.ProgressTo:create(0, 0))
      table.insert(action, cc.CallFunc:create(function()
        progress:setPercentage(sauce.breakE / ExpSet.exp * 100)
      end))
    end
    local str = ""
    if sauce.breakL == maxLevel then
      table.insert(action, cc.ProgressTo:create(0, 100))
      str = "<div color=#ffffff outline=1,#000000 >Max</div>"
    else
      str = string.format("<div color=#ffffff outline=1,#000000 >%d/%d</div>", sauce.breakE, ExpSet.exp)
      table.insert(action, cc.ProgressTo:create(sauce.breakE / ExpSet.exp * 1, sauce.breakE / ExpSet.exp * 100))
    end
    table.insert(action, cc.CallFunc:create(function()
      progress:setPercentage(0)
      num:setString(str)
      title:setString(string.format("强化进度 <div color=#3a9721>%d/%d</div>", sauce.breakL, maxLevel))
      progress:stopAllActions()
    end))
    bar:runAction(cc.Sequence:create(action))
  else
    progress = display.newProgressTimer(strengthRes .. "progress.png", 1):center(self.barBg):addTo(self.barBg):name("progress")
    progress:setMidpoint(cc.p(0, 0.5))
    progress:setBarChangeRate(cc.p(1, 0))
    progress:setPercentage(sauce.breakE / ExpSet.exp * 100)
    bar = display.newProgressTimer(strengthRes .. "bar.png", 1):center(self.barBg):addTo(self.barBg):name("bar")
    bar:setMidpoint(cc.p(0, 0.5))
    bar:setBarChangeRate(cc.p(1, 0))
    if sauce.breakL == maxLevel then
      bar:setPercentage(100)
      num = MRichText.new({
        text = string.format("<div color=#ffffff outline=1,#000000 >%s</div>", "Max"),
        size = 16
      }):anch(0.5, 0.5):pos(125, 10):addTo(self.barBg):name("num")
    else
      bar:setPercentage(sauce.breakE / ExpSet.exp * 100)
      num = MRichText.new({
        text = string.format("<div color=#ffffff outline=1,#000000 >%d/%d</div>", sauce.breakE, ExpSet.exp),
        size = 16
      }):anch(0.5, 0.5):pos(125, 10):addTo(self.barBg):name("num")
    end
    title = MRichText.new({
      text = string.format("强化进度 <div color=#3a9721>%d/%d</div>", sauce.breakL, maxLevel),
      color = UIHelper.hex2rgb("#703902"),
      size = 20
    }):anch(0.5, 0.5):addTo(self.exp):name("title")
  end
end

function SauceStrengthLayer:showChooseSauce()
  local function rule(sauce)
    if sauce.id == self.sauceId then
      return true
    end
    if sauce.breakL >= #BreakCsv[sauce.type] then
      return true
    end
    if sauce.masterId and sauce.masterId ~= 0 then
      local hero = game.role.heros[sauce.masterId]
      if hero then
        local states = hero:getState()
        if states[1] or states[2] or states[3] then
          return true
        end
      end
    end
    return false
  end
  
  local layer = game:createView("sauce.ChooseSauceLayer", {
    rule = rule,
    type = 1,
    callback = function(choose)
      self.barBg:removeAllChildren()
      self.sauceId = choose
      self.eatList = {0}
      self:showMainHero()
      self:showList()
    end
  })
  BackManager:push(function()
    layer:close()
    TopBar:show(TopBarType.full, "酱料")
  end)
end

function SauceStrengthLayer:add()
  if not self.sauceId then
    SysError(SYS_ERR_STRENGTHEN_SAUCE_CHOOSE)
    return
  end
  local sauce = game.role.sauces[self.sauceId]
  if sauce.breakL >= #BreakCsv[sauce.type] then
    SysError(SYS_ERR_STRENGTH_SAUCE_BREAK_MAX)
    return
  end
  
  local function rule(_sauce)
    if _sauce.id == self.sauceId or _sauce.lock == 1 or _sauce.masterId and _sauce.masterId ~= 0 and game.role.heros[_sauce.masterId] then
      return true
    end
  end
  
  local layer = game:createView("sauce.ChooseSauceLayer", {
    choosedList = self.eatList,
    strength = true,
    quickChose = true,
    max = 20,
    mType = sauce.csvData.maintype,
    strengthId = sauce.id,
    multiChoose = true,
    rule = rule,
    type = 2,
    callback = function(chooseList)
      self.eatList = {}
      for id, _ in pairs(chooseList) do
        table.insert(self.eatList, id)
      end
      table.insert(self.eatList, 0)
      self:showPanel("choose")
      self:showList()
    end
  })
  BackManager:push(function()
    layer:close()
    TopBar:show(TopBarType.full, "酱料")
  end)
end

function SauceStrengthLayer:showAnimation(oldLevel)
  local up = oldLevel < game.role.sauces[self.sauceId].breakL
  self.maskNode:removeAllChildren()
  local mask = UIHelper.newMask({
    size = cc.size(1877, 854)
  }):addTo(self.maskNode)
  mask:setCallback(function()
  end)
  self.heroNode:runAction(transition.sequence({
    cc.DelayTime:create(0.3),
    cc.CallFunc:create(function()
      self:showPanel("send", up)
      self:showList()
    end),
    cc.CallFunc:create(function()
      local effect = UIHelper.loadAnimation(strengthRes, "qianghua_kuang", 15, 30)
      effect.sprite:center(self.mainBg3):addTo(self.mainBg3)
      effect.sprite:setBlendFunc(cc.blendFunc(gl.ONE_MINUS_DST_COLOR, gl.ONE))
      effect.sprite:playAnimationOnce(effect.animation, true)
    end),
    cc.DelayTime:create(0.45),
    cc.CallFunc:create(function()
      local effect = UIHelper.loadAnimation(strengthRes, "qianghua_fazhen", 50, 30)
      effect.sprite:anch(1, 0):pos(685, 245):addTo(self.mainBg2)
      effect.sprite:setBlendFunc(cc.blendFunc(gl.ONE_MINUS_DST_COLOR, gl.ONE))
      effect.sprite:playAnimationOnce(effect.animation, true)
    end),
    cc.DelayTime:create(1),
    cc.CallFunc:create(function()
      local effect = UIHelper.loadAnimation(strengthRes, "qianghua_char", 34, 30)
      effect.sprite:scale(0.7):pos(0, 80):addTo(self.heroNode)
      effect.sprite:setBlendFunc(cc.blendFunc(gl.ONE_MINUS_DST_COLOR, gl.ONE))
      effect.sprite:playAnimationOnce(effect.animation, true)
    end),
    cc.DelayTime:create(1),
    cc.CallFunc:create(function()
      if up then
        game:createView("sauce.StrengthUpLevelLayer", {
          id = self.sauceId,
          old = oldLevel
        })
      end
      self.maskNode:removeAllChildren()
    end)
  }))
end

function SauceStrengthLayer:getTempMaxExp()
  local sauce = game.role.sauces[self.sauceId]
  local addExp = sauce.breakE
  for _, id in ipairs(self.eatList) do
    local tempSauce = game.role.sauces[id]
    if tempSauce then
      addExp = addExp + tempSauce.csvData.exp * ((tempSauce.csvData.maintype == sauce.csvData.maintype or tempSauce.csvData.maintype == 0) and globalCsv.sameSauceBreak or 1)
    end
  end
  return addExp
end

function SauceStrengthLayer:getCurMaxLevel(addExp)
  local sauce = game.role.sauces[self.sauceId]
  local curLevel = sauce.breakL
  local maxLevel = #BreakCsv[sauce.type]
  local breakSet = BreakCsv[sauce.type][curLevel]
  local nowExp = addExp
  while nowExp >= breakSet.exp do
    if curLevel >= maxLevel then
      nowExp = 0
      break
    else
      curLevel = curLevel + 1
      nowExp = nowExp - breakSet.exp
      breakSet = BreakCsv[sauce.type][curLevel]
    end
  end
  return curLevel
end

return SauceStrengthLayer
