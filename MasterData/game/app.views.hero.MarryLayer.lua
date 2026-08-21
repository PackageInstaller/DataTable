local LoveCsv = require("csvdata.love_effect")
local PlusCsv = require("csvdata.love_plus")
local MarryRes = "ui/hero/marry/"
local uiData = {
  csbFile = "ui/hero/MarryLayer.csb",
  mask = true,
  popup = true,
  maskClick = true,
  widgets = {
    mainBg = "mainBg",
    maskNode = "maskNode",
    heroNode = "mainBg/heroNode",
    descNode = "mainBg/descNode",
    conditionBg1 = "mainBg/conditionBg1",
    conditionBg2 = "mainBg/conditionBg2",
    btnNode = "mainBg/btnNode"
  }
}
local MarryLayer = class("MarryLayer", UIBase)

function MarryLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function MarryLayer:init(params)
  self.callback = params.callback
  self.hero = game.role.heros[params.heroId]
  HeroBigCard.new({
    heroId = self.hero.id,
    quality = self.hero.quality
  }):scale(0.8):anch(0.5, 0.5):pos(230, 70):addTo(self.heroNode)
  self.canMarry = true
  self:initCondition()
end

function MarryLayer:initCondition()
  local heart = UIHelper.newImageView("ui/global/heart.png"):pos(25, 29):addTo(self.conditionBg1)
  display.newTTFLabel({
    text = 4,
    size = 24,
    color = UIHelper.hex2rgb("#5b0a15")
  }):enableOutline(UIHelper.hex2rgb("#ffffff"), 2):pos(20, 21):addTo(heart)
  display.newSprite(MarryRes .. "image_icon_1.png"):pos(25, 30):addTo(self.conditionBg2)
  if self.hero.loveBreak >= 5 then
    display.newSprite(MarryRes .. "image_able.png"):pos(200, 30):addTo(self.conditionBg1)
    display.newSprite(MarryRes .. "image_able.png"):pos(200, 30):addTo(self.conditionBg2)
    display.newTTFLabel({
      text = string.format("%d/%d", LoveCsv[4].fullValue, LoveCsv[4].fullValue),
      size = 20,
      color = UIHelper.hex2rgb("#7f4e03")
    }):enableOutline(UIHelper.hex2rgb("#ffffff"), 2):pos(111, 30):addTo(self.conditionBg1)
    display.newTTFLabel({
      text = "1/1",
      size = 20,
      color = UIHelper.hex2rgb("#7f4e03")
    }):enableOutline(UIHelper.hex2rgb("#ffffff"), 2):pos(111, 30):addTo(self.conditionBg2)
    return
  end
  display.newSprite(MarryRes .. (self.hero.love >= LoveCsv[4].fullValue and "image_able.png" or "image_unable.png")):pos(200, 30):addTo(self.conditionBg1)
  display.newSprite(MarryRes .. ((game.role.items[10] or 0) >= 1 and "image_able.png" or "image_unable.png")):pos(200, 30):addTo(self.conditionBg2)
  display.newTTFLabel({
    text = string.format("%d/%d", math.floor(self.hero.love), LoveCsv[4].fullValue),
    size = 20,
    color = UIHelper.hex2rgb("#7f4e03")
  }):enableOutline(UIHelper.hex2rgb("#ffffff"), 2):pos(111, 30):addTo(self.conditionBg1)
  display.newTTFLabel({
    text = string.format("%d/%d", game.role.items[10] or 0, 1),
    size = 20,
    color = UIHelper.hex2rgb("#7f4e03")
  }):enableOutline(UIHelper.hex2rgb("#ffffff"), 2):pos(111, 30):addTo(self.conditionBg2)
  if self.hero.love < LoveCsv[4].fullValue or (game.role.items[10] or 0) < 1 then
    self.canMarry = false
  end
end

function MarryLayer:showData(params)
  self.btnNode:removeAllChildren()
  self.descNode:removeAllChildren()
  display.newSprite(MarryRes .. "image_heart.png"):pos(10, -100):addTo(self.descNode)
  display.newSprite(MarryRes .. "image_heart.png"):pos(180, -100):addTo(self.descNode)
  display.newSprite(MarryRes .. "image_role.png"):pos(25, -90):addTo(self.descNode)
  display.newSprite(MarryRes .. "image_hero.png"):pos(210, -90):addTo(self.descNode)
  display.newTTFLabel({
    text = game.role.name,
    size = 22,
    color = UIHelper.hex2rgb("#815b21")
  }):anch(0, 0.5):pos(0, -120):addTo(self.descNode)
  display.newTTFLabel({
    text = self.hero:getName(),
    size = 22,
    color = UIHelper.hex2rgb("#815b21")
  }):anch(0, 0.5):pos(185, -120):addTo(self.descNode)
  if self.hero.loveBreak >= 5 then
    MRichText.new({
      text = PlusCsv[self.hero.type].afterMarrige,
      size = 20,
      color = UIHelper.hex2rgb("#815b21"),
      maxWidth = 300
    }):anch(0, 1):pos(0, 0):addTo(self.descNode)
    display.newSprite(MarryRes .. "image_done.png"):pos(5, 15):addTo(self.btnNode)
    display.newSprite(MarryRes .. "time_bg.png"):pos(180, -150):addTo(self.descNode)
    local tab = CommonHelper.date(self.hero.marryTime, nil, nil)
    display.newTTFLabel({
      text = string.format("誓约日:%d年%02d月%02d日", tab.year, tab.month, tab.day),
      size = 16,
      color = UIHelper.hex2rgb("#a97e3c")
    }):pos(180, -150):addTo(self.descNode)
    return
  end
  MRichText.new({
    text = PlusCsv[self.hero.type].beforeMarrige,
    size = 20,
    color = UIHelper.hex2rgb("#815b21"),
    maxWidth = 300
  }):anch(0, 1):pos(0, 0):addTo(self.descNode)
  display.newSprite(MarryRes .. "image_desc_down.png"):pos(155, -150):addTo(self.descNode)
  if self.canMarry then
    local btn = UIHelper.extend(ccui.Button:create())
    btn:setImages(MarryRes, {"btn_a.png", "btn_a.png"})
    btn:setTouchScale()
    btn:pos(0, 6):addTo(self.btnNode)
    btn:setCallback(function()
      game:sendData(actionCodes.Hero_finishLoveTaskRpc, MsgPack.pack({
        heroId = self.hero.id
      }))
      UIHelper.showWaiting()
      game:addResponseHandler(actionCodes.Hero_finishLoveTaskRpc, function(event)
        UIHelper.removeWaiting()
        self:showMarry()
      end)
    end)
    return
  end
  UIHelper.newImageView(MarryRes .. "btn_b.png"):pos(0, 6):addTo(self.btnNode)
end

function MarryLayer:showMarry()
  local mask = UIHelper.extend(ccui.Layout:create())
  mask:size(display.width * 2, display.height)
  mask:setBackGroundColorType(1)
  mask:setBackGroundColor(cc.c3b(0, 0, 0))
  mask:setTouchEnabled(true)
  mask:setSwallowTouches(true)
  mask:setBackGroundColorOpacity(191)
  mask:anch(0.5, 0.5):pos(0, 0):addTo(self.maskNode)
  game:playMusic(24)
  local spine = UIHelper.createSpineNodeByRes(MarryRes .. "marry")
  spine:pos(0, 0):addTo(self.maskNode)
  spine:setAnimation(0, "bg", false)
  if UIHelper.isiPhoneX() then
    UIHelper.fitForiPhoneX(spine, true)
  end
  self.maskNode:runAction(transition.sequence({
    cc.DelayTime:create(12),
    cc.CallFunc:create(function()
      game:createView("talk.PlotTalkLayer", {
        scene = self,
        reward = true,
        talkId = PlusCsv[self.hero.type].marryStory,
        csvNo = PlusCsv[self.hero.type].readcsv or 0,
        hideSkip = true,
        onComplete = function()
          spine:setAnimation(0, "hand", false)
          self.maskNode:runAction(transition.sequence({
            cc.DelayTime:create(8),
            cc.CallFunc:create(function()
              mask:setCallback(function()
                self:showData()
                CommonHelper.playHomeBGM()
                self.maskNode:removeAllChildren()
              end)
            end)
          }))
        end
      })
    end)
  }))
end

function MarryLayer:onExit()
  if self.callback then
    self.callback()
  end
end

return MarryLayer
