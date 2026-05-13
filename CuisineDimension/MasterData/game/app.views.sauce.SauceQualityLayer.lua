local ItemCsv = require("csvdata.item")
local AdvanceCsv = require("csvdata.sauce_advance")
local SkillPassiveCsv = require("csvdata.skill_passive")
local QualityRes = "ui/sauce/quality/"
local uiData = {
  csbFile = "ui/sauce/SauceQualityLayer.csb",
  widgets = {
    leftPanel = "leftPanel",
    circleBg = "leftPanel/circleBg",
    bigCircle = "leftPanel/bigCircle",
    heroNode = "leftPanel/heroNode",
    imageR = "leftPanel/imageR",
    imageL = "leftPanel/imageL",
    rightPanel = "rightPanel",
    circle = "rightPanel/circle",
    sauceNode = "rightPanel/rightBg/sauceNode",
    itemNode = "rightPanel/rightBg/itemNode",
    descList = "rightPanel/rightBg/descList",
    numNode = "rightPanel/rightBg/numNode",
    evoBtn = "rightPanel/rightBg/evoBtn",
    desc1 = "rightPanel/rightBg/desc1",
    descPanel = "descPanel",
    level = "descPanel/level",
    buttom = "buttom",
    angel1 = "angel1",
    angel2 = "angel2"
  }
}
local SauceQualityLayer = class("SauceQualityLayer", UIBase)

function SauceQualityLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function SauceQualityLayer:init(params)
  if UIHelper.isiPhoneX() then
    UIHelper.fitForiPhoneX(self.buttom)
    self.rightPanel:setPositionX(self.rightPanel:getPositionX() + 160)
    self.angel2:setPositionX(self.angel2:getPositionX() + 200)
  end
  self.bigCircle:runAction(cc.RepeatForever:create(cc.RotateBy:create(30, -360)))
  self.circle:runAction(cc.RepeatForever:create(cc.RotateBy:create(20, 360)))
  self.action = false
  self.imageR:hide()
  self.imageL:hide()
  self:showMainHero()
  self:showRightPanel()
  self.descPanel:hide()
  UIHelper.MoveToRight({
    node = self.leftPanel
  })
  UIHelper.MoveToLeft({
    node = self.rightPanel
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
  self.evoBtn:setTouchScale()
  self.evoBtn:hide()
  self.evoBtn:setCallback(function()
    if self.action then
      return
    end
    if not self.sauce then
      SysError(SYS_ERR_QUALITY_SAUCE_CHOOSE)
      return
    end
    if self.sauce.advanceL >= #AdvanceCsv[self.sauce.type] then
      SysError(SYS_ERR_QUALITY_SAUCE_ADVANCE_MAX)
      return
    end
    if not self.costEnouth then
      SysError(SYS_ERR_QUALITY_SAUCE_COUNT_NOT_ENOUGH)
      return
    end
    self.action = true
    game:sendData(actionCodes.Sauce_advanceRpc, MsgPack.pack({
      sauceId = self.sauce.id
    }))
    UIHelper.showWaiting()
    game:addResponseHandler(actionCodes.Sauce_advanceRpc, function(event)
      UIHelper.removeWaiting()
      game:playMusic(1102)
      self:showBigCardAnimation()
    end)
  end)
end

function SauceQualityLayer:showMainHero(action)
  self.heroNode:removeAllChildren()
  if self.sauce then
    local card = self:createSauceCard()
    if action then
      card:pos(0, -30):addTo(self.heroNode)
      card:setCascadeOpacityEnabled(true)
      card:setOpacity(0)
      card:runAction(cc.Spawn:create(cc.MoveBy:create(0.2, cc.p(0, 30)), cc.FadeIn:create(0.2)))
    else
      card:addTo(self.heroNode)
    end
    display.newTTFLabel({
      text = "Lv" .. self.sauce.breakL,
      size = 26
    }):enableOutline(UIHelper.hex2rgb("#000000"), 1):pos(0, -90):addTo(self.heroNode)
    for i = 1, #AdvanceCsv[self.sauce.type] do
      display.newSprite("ui/sauce/card/special_gray.png"):pos(-78 + (i - 1) * 32, -110):addTo(self.heroNode)
      if i <= self.sauce.advanceL then
        display.newSprite("ui/sauce/card/special_green.png"):pos(-78 + (i - 1) * 32, -110):addTo(self.heroNode)
      end
    end
    card:name("card")
    card:setCallback(function()
      if self.action then
        return
      end
      self:showChooseHero()
    end)
  else
    display.newTTFLabel({
      text = "添加酱料",
      size = 22,
      color = UIHelper.hex2rgb("#b4f730")
    }):pos(-2, -40):addTo(self.heroNode)
    local btn = UIHelper.newImageView("ui/equip/reforge/add.png"):pos(0, 16):addTo(self.heroNode)
    btn:setCallback(function()
      self:showChooseHero()
    end)
  end
end

function SauceQualityLayer:createSauceCard()
  display.newSprite(string.format("ui/sauce/card/special_card_bg_%d.png", ItemCsv[self.sauce:getItemId()].star)):addTo(self.heroNode)
  local card = UIHelper.newImageView(self.sauce:getBigImg()):anch(0.5, 0.5):scale(0.6)
  return card
end

function SauceQualityLayer:showChooseHero()
  local function rule(sauce)
    if self.sauce and sauce.id == self.sauce.id then
      return true
    end
    if sauce.advanceL >= #AdvanceCsv[sauce.type] then
      return true
    end
    if sauce.masterId and sauce.masterId ~= 0 then
      local hero = game.role.heros[sauce.masterId]
      if hero then
        local states = hero:getState()
        if states[1] or states[2] or states[2] then
          return true
        end
      end
    end
    return false
  end
  
  local layer = game:createView("sauce.ChooseSauceLayer", {
    rule = rule,
    type = 3,
    callback = function(choose)
      self.sauce = game.role.sauces[choose]
      self.evoBtn:show()
      self:showMainHero(true)
      self:showRightPanel()
    end
  })
  BackManager:push(function()
    layer:close()
    TopBar:show(TopBarType.full, "酱料")
  end)
end

function SauceQualityLayer:showRightPanel()
  self.sauceNode:removeAllChildren()
  self.numNode:removeAllChildren()
  self.descList:removeAllChildren()
  self.itemNode:removeAllChildren()
  self.costEnouth = true
  local items = "191=0 192=0"
  local showLevel
  if self.sauce then
    self.evoBtn:show()
    if self.sauce.advanceL < #AdvanceCsv[self.sauce.type] then
      display.newSprite(self.sauce:getBigImg(1)):scale(0.6):anch(0.5, 0):pos(-20, -40):addTo(self.sauceNode)
      showLevel = self.sauce.advanceL + 1
      items = AdvanceCsv[self.sauce.type][self.sauce.advanceL].require
      self.desc1:setString(string.format("阶段%s解锁", UIHelper.translateNum(self.sauce.advanceL + 1)))
      local AdvanceBuffKV = {
        [1] = "生命+%d",
        [2] = "攻击+%d",
        [3] = "防御+%d",
        [4] = "命中+%d",
        [5] = "闪避+%d",
        [6] = "暴击+%d",
        [7] = "暴伤+%d",
        [8] = "攻速+%d",
        [9] = "料理技等级+%d",
        [10] = "固有技等级+%d",
        [11] = "造成的全伤害提高%0.1f%%",
        [12] = "受到的全伤害降低%0.1f%%"
      }
      for _, one in pairs(AdvanceCsv[self.sauce.type][showLevel].saucetype:toArray()) do
        local temp = one:toArray("=", true)
        if AdvanceBuffKV[temp[1]] then
          local lab = MRichText.new({
            text = string.format(AdvanceBuffKV[temp[1]], math.abs(temp[2])),
            size = 16,
            color = UIHelper.hex2rgb("#713802"),
            maxWidth = 146
          })
          local viewNode = ccui.Widget:create()
          viewNode:setContentSize(cc.size(170, math.max(lab:getContentSize().height + 2), 32)):addTo(self.descList)
          lab:anch(0, 0.5):pos(20, lab:getContentSize().height / 2):addTo(viewNode)
          display.newSprite(QualityRes .. "image_block.png"):pos(11, lab:getContentSize().height / 2):addTo(viewNode)
        else
          local lab = MRichText.new({
            text = SkillPassiveCsv[temp[2]].name,
            size = 16,
            color = UIHelper.hex2rgb("#713802"),
            maxWidth = 160
          })
          local viewNode = ccui.Widget:create()
          viewNode:setContentSize(cc.size(170, math.max(lab:getContentSize().height + 2), 32)):addTo(self.descList)
          lab:anch(0, 0.5):pos(3, lab:getContentSize().height / 2):addTo(viewNode)
        end
      end
    else
      display.newSprite(self.sauce:getBigImg()):scale(0.6):anch(0.5, 0):pos(-20, -40):addTo(self.sauceNode)
      showLevel = #AdvanceCsv[self.sauce.type]
      self.evoBtn:hide()
      self.desc1:setString(string.format("酱料已达到满阶", UIHelper.translateNum(self.sauce.advanceL)))
    end
    display.newSprite(QualityRes .. "num_bg.png"):addTo(self.numNode)
    display.newTTFLabel({
      text = showLevel,
      size = 68,
      color = UIHelper.hex2rgb("#713802")
    }):setRotation(-30):pos(-3, 2):addTo(self.numNode)
    display.newTTFLabel({
      text = "阶段",
      size = 20,
      color = UIHelper.hex2rgb("#713802")
    }):anch(0, 0.5):setRotation(-30):pos(-72, -46):addTo(self.numNode)
  else
    self.evoBtn:hide()
    for idx, str in ipairs({"攻击 ?", "防御 ?"}) do
      local viewNode = ccui.Widget:create()
      viewNode:setContentSize(cc.size(170, 32)):addTo(self.descList)
      display.newSprite(QualityRes .. "image_block.png"):pos(11, 15):addTo(viewNode)
      display.newTTFLabel({
        text = str,
        size = 16,
        color = UIHelper.hex2rgb("#713802")
      }):anch(0, 0.5):pos(20, 15):addTo(viewNode)
      for i = 1, 4 do
        display.newSprite("ui/kitchen/quality/arrow.png"):pos(95 + (i - 1) * 6, 15):addTo(viewNode)
      end
      display.newTTFLabel({
        text = "?",
        size = 16,
        color = UIHelper.hex2rgb("#713802")
      }):anch(0, 0.5):pos(140, 15):addTo(viewNode)
    end
    display.newSprite(QualityRes .. "sauce_nomal.png"):anch(0.5, 0):pos(0, 0):addTo(self.sauceNode)
    self.desc1:setString("酱料新属性")
  end
  self.descList:requestDoLayout()
  for idx, data in ipairs(items:toTableArray()) do
    ItemIcon.new({
      type = tonumber(data[1]),
      showTip = true
    }):scale(0.86):pos((idx - 1) * 90, 0):addTo(self.itemNode)
    if 0 < tonumber(data[2]) then
      local cur = game.role.items[tonumber(data[1])] or 0
      local color = cur >= tonumber(data[2]) and "#2a9a10" or "#ec4e10"
      self.costEnouth = self.costEnouth and cur >= tonumber(data[2])
      display.newTTFLabel({
        text = string.format("%s/%s", cur, data[2]),
        size = 20,
        color = UIHelper.hex2rgb(color)
      }):pos((idx - 1) * 90, -50):addTo(self.itemNode)
    else
      self.costEnouth = false
    end
  end
end

function SauceQualityLayer:showSmallCardAnimation()
  for index, card in ipairs(self.cards) do
    local effect = UIHelper.loadAnimation("ui/kitchen/quality/", "quality_smallbox", 14, 30)
    effect.sprite:center(card):addTo(card)
    effect.sprite:playAnimationOnce(effect.animation, true)
  end
end

function SauceQualityLayer:showBigCardAnimation()
  self:ImagesAnimatHide()
  local magic = UIHelper.loadAnimation("ui/kitchen/quality/", "quality_magic", 28, 30)
  magic.sprite:center(self.circleBg):addTo(self.circleBg)
  magic.sprite:playAnimationOnce(magic.animation, false)
  local card = self.heroNode:getChildByName("card")
  self.circleBg:runAction(transition.sequence({
    cc.DelayTime:create(1),
    cc.CallFunc:create(function()
      local spine = UIHelper.createSpineNodeByRes(QualityRes .. "ck")
      spine:setAnimation(0, "animation", false)
      spine:anch(0.5, 0.5):pos(0, 0):addTo(self.heroNode)
      self.circleBg:removeAllChildren()
    end),
    cc.DelayTime:create(0.5),
    cc.CallFunc:create(function()
      self:showMainHero()
      self:showRightPanel()
      self.action = false
    end)
  }))
end

function SauceQualityLayer:ImagesAnimatHide()
end

function SauceQualityLayer:ImagesAnimatShow()
end

return SauceQualityLayer
