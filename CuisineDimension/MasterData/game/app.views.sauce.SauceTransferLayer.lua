local ItemCsv = require("csvdata.item")
local AdvanceCsv = require("csvdata.sauce_advance")
local uiData = {
  csbFile = "ui/sauce/SauceTransferLayer.csb",
  widgets = {
    mainBg = "mainBg",
    leftBg = "leftBg",
    leftCircleBg = "leftBg/circleBg",
    leftNode = "leftBg/leftNode",
    leftBigCircle = "leftBg/bigCircle",
    rightBg = "rightBg",
    rightNode = "rightBg/rightNode",
    rightCircleBg = "rightBg/circleBg",
    rightBigCircle = "rightBg/bigCircle",
    arrow = "arrow",
    btnTran = "btnTran",
    btnInfo = "btnInfo",
    buttom = "buttom",
    angel1 = "angel1",
    angel2 = "angel2"
  }
}
local SauceTransferLayer = class("SauceTransferLayer", UIBase)

function SauceTransferLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function SauceTransferLayer:init(params)
  if UIHelper.isiPhoneX() then
    UIHelper.fitForiPhoneX(self.buttom)
    UIHelper.fitForiPhoneX(self.mainBg, true)
    self.angel2:setPositionX(self.angel2:getPositionX() + 200)
    self.btnTran:setPositionX(self.btnTran:getPositionX() + UIHelper.getMoveXForX())
    self.btnInfo:setPositionX(self.btnInfo:getPositionX() + UIHelper.getMoveXForX())
    self.leftBg:setPositionX(self.leftBg:getPositionX() + UIHelper.getMoveXForX())
    self.rightBg:setPositionX(self.rightBg:getPositionX() + UIHelper.getMoveXForX())
    self.mainBg:setPositionX(self.mainBg:getPositionX() + UIHelper.getMoveXForX())
    self.arrow:setPositionX(self.arrow:getPositionX() + UIHelper.getMoveXForX())
  end
  UIHelper.MoveToRight({
    node = self.leftBg
  })
  UIHelper.MoveToLeft({
    node = self.rightBg
  })
  UIHelper.MoveToUp({
    node = self.btnTran,
    delay = 0.2
  })
  UIHelper.MoveToLeft({
    node = self.btnInfo,
    delay = 0.2
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
  self.leftBigCircle:runAction(cc.RepeatForever:create(cc.RotateBy:create(30, -360)))
  self.rightBigCircle:runAction(cc.RepeatForever:create(cc.RotateBy:create(30, -360)))
  self.leftId = 0
  self.rightId = 0
  self.action = false
  self.btnTran:setTouchScale()
  self.btnTran:setCallback(function()
    if self.action then
      return
    end
    if self.rightId == 0 then
      SysError(SYS_ERR_TRANSFER_SAUCE_RIGHT_CHOOSE)
      return
    end
    if self.leftId == 0 then
      SysError(SYS_ERR_TRANSFER_SAUCE_LEFT_CHOOSE)
      return
    end
    game:sendData(actionCodes.Sauce_transferRpc, MsgPack.pack({
      sauceId = self.rightId,
      fromId = self.leftId
    }))
    UIHelper.showWaiting()
    game:addResponseHandler(actionCodes.Sauce_transferRpc, function(event)
      UIHelper.removeWaiting()
      self.action = true
      self:showAnimation()
    end)
  end)
  self.btnInfo:setTouchScale()
  self.btnInfo:setCallback(function()
    UIHelper.showOnleImgTip("ui/sauce/transfer/image_rule.png")
  end)
end

function SauceTransferLayer:showData(params)
  self:reflashNode(1)
  self:reflashNode(2)
end

function SauceTransferLayer:showChooseSauce(dir)
  if self.action then
    return
  end
  if dir == 1 and self.rightId == 0 then
    SysError(SYS_ERR_TRANSFER_SAUCE_RIGHT_CHOOSE)
    return
  end
  local mainType = dir == 1 and game.role.sauces[self.rightId].csvData.maintype or nil
  
  local function rule(sauce)
    if sauce.id == self.leftId or sauce.id == self.rightId then
      return true
    end
    if dir == 1 and (sauce.csvData.maintype ~= mainType or sauce:getAllBrealExp() == 0 and sauce.advanceL <= game.role.sauces[self.rightId].advanceL) then
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
    type = dir == 1 and 5 or 4,
    mType = mainType,
    callback = function(choose)
      if dir == 1 then
        self.leftId = choose
      else
        self.leftId = 0
        self.rightId = choose
      end
      self:showData()
    end
  })
  BackManager:push(function()
    layer:close()
    TopBar:show(TopBarType.full, "酱料")
  end)
end

function SauceTransferLayer:reflashNode(dir)
  local btn
  if dir == 1 then
    self.leftNode:removeAllChildren()
    if self.leftId == 0 then
      display.newTTFLabel({
        text = "被重置酱料",
        size = 22,
        color = UIHelper.hex2rgb("#b4f730")
      }):pos(-2, -40):addTo(self.leftNode)
      btn = UIHelper.newImageView("ui/equip/reforge/add.png"):pos(0, 16):addTo(self.leftNode)
    else
      local sauce = game.role.sauces[self.leftId]
      display.newSprite(string.format("ui/sauce/card/special_card_bg_%d.png", ItemCsv[sauce:getItemId()].star)):addTo(self.leftNode)
      btn = UIHelper.newImageView(sauce:getBigImg()):anch(0.5, 0.5):scale(0.6):pos(0, 0):addTo(self.leftNode)
      display.newTTFLabel({
        text = "Lv" .. sauce.breakL,
        size = 26
      }):enableOutline(UIHelper.hex2rgb("#000000"), 1):pos(0, -90):addTo(self.leftNode)
      for i = 1, #AdvanceCsv[sauce.type] do
        display.newSprite("ui/sauce/card/special_gray.png"):pos(-78 + (i - 1) * 32, -110):addTo(self.leftNode)
        if i <= sauce.advanceL then
          display.newSprite("ui/sauce/card/special_green.png"):pos(-78 + (i - 1) * 32, -110):addTo(self.leftNode)
        end
      end
    end
  else
    self.rightNode:removeAllChildren()
    if self.rightId == 0 then
      display.newTTFLabel({
        text = "接受转移酱料",
        size = 22,
        color = UIHelper.hex2rgb("#b4f730")
      }):pos(-2, -40):addTo(self.rightNode)
      btn = UIHelper.newImageView("ui/equip/reforge/add.png"):pos(0, 16):addTo(self.rightNode)
    else
      local sauce = game.role.sauces[self.rightId]
      display.newSprite(string.format("ui/sauce/card/special_card_bg_%d.png", ItemCsv[sauce:getItemId()].star)):addTo(self.rightNode)
      btn = UIHelper.newImageView(sauce:getBigImg()):anch(0.5, 0.5):scale(0.6):pos(0, 0):addTo(self.rightNode)
      display.newTTFLabel({
        text = "Lv" .. sauce.breakL,
        size = 26
      }):enableOutline(UIHelper.hex2rgb("#000000"), 1):pos(0, -90):addTo(self.rightNode)
      for i = 1, #AdvanceCsv[sauce.type] do
        display.newSprite("ui/sauce/card/special_gray.png"):pos(-78 + (i - 1) * 32, -110):addTo(self.rightNode)
        if i <= sauce.advanceL then
          display.newSprite("ui/sauce/card/special_green.png"):pos(-78 + (i - 1) * 32, -110):addTo(self.rightNode)
        end
      end
    end
  end
  btn:setCallback(function()
    self:showChooseSauce(dir)
  end)
end

function SauceTransferLayer:showAnimation()
  local magic1 = UIHelper.loadAnimation("ui/kitchen/quality/", "quality_magic", 28, 30)
  magic1.sprite:center(self.leftCircleBg):addTo(self.leftCircleBg)
  magic1.sprite:playAnimationOnce(magic1.animation, false)
  local magic2 = UIHelper.loadAnimation("ui/kitchen/quality/", "quality_magic", 28, 30)
  magic2.sprite:center(self.rightCircleBg):addTo(self.rightCircleBg)
  magic2.sprite:playAnimationOnce(magic2.animation, false)
  self.leftBg:runAction(transition.sequence({
    cc.DelayTime:create(1),
    cc.CallFunc:create(function()
      local spine = UIHelper.createSpineNodeByRes("ui/sauce/quality/ck")
      spine:setAnimation(0, "animation", false)
      spine:anch(0.5, 0.5):pos(0, 0):addTo(self.leftNode)
      self.leftCircleBg:removeAllChildren()
    end)
  }))
  self.rightBg:runAction(transition.sequence({
    cc.DelayTime:create(1),
    cc.CallFunc:create(function()
      local spine = UIHelper.createSpineNodeByRes("ui/sauce/quality/ck")
      spine:setAnimation(0, "animation", false)
      spine:anch(0.5, 0.5):pos(0, 0):addTo(self.rightNode)
      self.rightCircleBg:removeAllChildren()
    end),
    cc.DelayTime:create(0.5),
    cc.CallFunc:create(function()
      self.action = false
      self:showData()
      self:showSuccess(self.leftId)
    end)
  }))
end

function SauceTransferLayer:showSuccess(sauceId, finish)
  local cx, cy, width, height = display.cx, display.cy, display.width, display.height
  if UIHelper.isiPhoneX() then
    local movex = UIHelper.getMoveXForX(true)
    cx, cy, width = cx + movex, cy, width + movex * 2
  end
  local mask = UIHelper.newMask({
    size = cc.size(width, height),
    color = "#000000",
    opacity = 110
  })
  mask:anch(0.5, 0.5):pos(cx, cy):addTo(display.getRunningScene(), 100)
  local bg = display.newSprite("ui/sauce/transfer/info_bg.png"):center(mask):addTo(mask)
  local sauce = game.role.sauces[sauceId]
  display.newSprite(sauce:getBigImg()):pos(210, 225):addTo(bg)
  local detailNode = display.newNode():pos(580, 553):addTo(bg)
  game:createView("sauce.SauceDetailLayer", {
    scene = detailNode,
    sauceId = sauceId,
    skipTitle = true,
    showFrame = true
  })
  local node = display.newNode():pos(95, 400):addTo(bg)
  display.newSprite("ui/sauce/quality/num_bg.png"):addTo(node)
  display.newTTFLabel({
    text = sauce.advanceL,
    size = 68,
    color = UIHelper.hex2rgb("#713802")
  }):setRotation(-30):pos(-3, 2):addTo(node)
  display.newTTFLabel({
    text = "阶段",
    size = 20,
    color = UIHelper.hex2rgb("#713802")
  }):anch(0, 0.5):setRotation(-30):pos(-63, -46):addTo(node)
  bg:scale(0.4)
  bg:runAction(cc.EaseElasticOut:create(cc.ScaleTo:create(0.8, 1)))
  mask:setTouchEnabled(true)
  mask:setSwallowTouches(true)
  mask:setCallback(function()
    mask:removeSelf()
    if finish then
      self.leftId = 0
      self.rightId = 0
      self:showData()
    else
      self:showSuccess(self.rightId, true)
    end
  end)
end

return SauceTransferLayer
