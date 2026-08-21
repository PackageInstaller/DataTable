local GlobalRes = "ui/global/"
local RewardRes = "ui/common/reward/"
local UnitCsv = require("csvdata.unit")
local EquipCsv = require("csvdata.equip")
local channelConfigs = require("sdk.ChannelConfigs")
local config = channelConfigs[CHANNEL_KEY]
local HeroRewardLayer = class("HeroRewardLayer", function()
  return UIHelper.extend(ccui.Layout:create())
end)

function HeroRewardLayer:ctor(params)
  self.params = params or {}
  self.showSkip = params.showSkip or false
  self.bFirst = params.bFirst or false
  self.skipFunc = params.skipFunc or function()
  end
  self.unitData = UnitCsv[params.type]
  self:uiLayout(params)
end

function HeroRewardLayer:uiLayout(params)
  local width = display.width
  if UIHelper.isiPhoneX() then
    width = width + UIHelper.getMoveXForX() * 2
  end
  self:size(cc.size(width, display.height))
  self:setTouchEnabled(true)
  self:addTo(display.getRunningScene(), POPUP_LAYER_ORDER)
  self:showEffect(self.unitData.star)
  if not tolua.isnull(TopBar) then
    self.topbar = {
      TopBar:getShowType()
    }
  end
end

function HeroRewardLayer:showEffect(star)
  local spineStar = star
  if star == 1 then
    spineStar = 2
  end
  local isBlackHero = globalCsv.blackHeroUnitIds[self.unitData.type] == 1
  if isBlackHero then
    spineStar = 7
  end
  local width = display.width
  if UIHelper.isiPhoneX() then
    width = width + UIHelper.getMoveXForX() * 2
  end
  local di = UIHelper.extend(ccui.Layout:create()):size(width, display.height):addTo(self)
  di:setBackGroundColorType(1)
  di:setBackGroundColor(cc.c3b(0, 0, 0))
  self.bg = display.newSprite(RewardRes .. "xingbg" .. spineStar .. ".png"):anch(0.5, 0.5):pos(display.cx, display.cy):addTo(self):hide()
  self.spine = UIHelper.createSpineNodeByRes(RewardRes .. "pengren" .. spineStar .. "xing")
  self.spine:pos(display.width / 2, display.height / 2):addTo(self)
  self.spine:setAnimation(0, "special", false)
  self.spine:addAnimation(0, "special2", true)
  self.spine:registerSpineEventHandler(function(event)
    if event.animation ~= "special" then
      return
    end
    self.bg:show()
  end, sp.EventType.ANIMATION_END)
  if UIHelper.isiPhoneX() then
    width = width + UIHelper.getMoveXForX() * 2
    di:setPositionX(-UIHelper.getMoveXForX(true))
    UIHelper.fitForiPhoneX(self.bg)
    UIHelper.fitForiPhoneX(self.spine)
  end
  if 4 <= star then
    local cycler = cc.ParticleSystemQuad:create(RewardRes .. "cycler.plist")
    cycler:setPositionType(cc.POSITION_TYPE_RELATIVE)
    cycler:pos(display.cx, display.cy):addTo(self)
  end
  if star == 5 then
    local ring = cc.ParticleSystemQuad:create(RewardRes .. "ring.plist")
    ring:setPositionType(cc.POSITION_TYPE_RELATIVE)
    ring:pos(display.cx, display.cy):addTo(self)
  end
  self.nameBg = display.newSprite(RewardRes .. "name_bg_new.png"):anch(0, 0):pos(0, display.height - 160):addTo(self, 0)
  display.newTTFLabel({
    text = self.unitData.name,
    size = 42,
    color = UIHelper.hex2rgb("#000000")
  }):anch(0, 0.5):pos(70, 80):addTo(self.nameBg):enableOutline(UIHelper.hex2rgb("#ffffff"), 3)
  display.newSprite(RewardRes .. string.format("pro%s%d.png", "_", self.unitData.profession)):anch(0, 0.5):pos(10, 80):addTo(self.nameBg)
  local star, xInterval = self.unitData.star, 54
  local temStar = math.min(star, 5)
  local xBegin = 150 - (temStar - 1) * xInterval / 2 + (temStar == 6 and 5 or 0)
  local isMengJing = globalCsv.mengJingHeroUnitIds[self.unitData.type] == 1
  for index = 1, temStar do
    local starSpr = display.newSprite(RewardRes .. (isMengJing and "xing_extra.png" or spineStar == 7 and "xing_3.png" or "xing_1.png")):pos(xBegin + (index - 1) * xInterval, 20):addTo(self.nameBg):scale(0.5):hide()
    starSpr:runAction(transition.sequence({
      cc.DelayTime:create(1.5 + (index - 1) * 0.2),
      cc.CallFunc:create(function()
        starSpr:show()
      end),
      cc.ScaleTo:create(0.2, 2),
      cc.EaseElasticOut:create(cc.ScaleTo:create(0.4, 1))
    }))
  end
  self:runAction(transition.sequence({
    cc.DelayTime:create(0.5),
    cc.CallFunc:create(function()
      self.talk = game:createView("talk.PlotTalkLayer", {
        scene = self,
        talkId = self.unitData.gainStory,
        csvNo = self.unitData.readcsv or 0,
        reward = true,
        onComplete = function()
          self:exit()
        end,
        onMaskShow = function()
          if self.firstTag then
            self.firstTag:removeSelf()
            self.firstTag = nil
          end
        end
      })
      if UIHelper.isiPhoneX() then
        self.talk:setPositionX(self.talk:getPositionX() + UIHelper.getMoveXForX(true))
      end
    end),
    cc.DelayTime:create(1.2),
    cc.CallFunc:create(function()
      local bFirst = self.bFirst or game.role.heroBook[tostring(self.unitData.type)] == 1
      local actionName = game.role.autoStatus:getv(3, 1) == 1 and "special_lock" or "special"
      if bFirst then
        game:playMusic(1027)
        local first = UIHelper.createSpineNodeByRes("ui/common/reward/first"):addTo(self)
        first:pos(571, 350)
        if UIHelper.isiPhoneX() then
          first:setPositionX(first:getPositionX() + UIHelper.getMoveXForX(true))
        end
        first:setLocalZOrder(100)
        first:setAnimation(0, actionName, false)
        first:registerSpineEventHandler(function(e)
          if e.type ~= "end" then
            return
          end
          scheduler.performWithDelayGlobal(function()
            first:removeSelf()
          end, 0.016666666666666666)
        end, sp.EventType.ANIMATION_END)
        self.firstTag = first
      else
        game:playMusic(1003)
      end
      CommonHelper.playCV(self.unitData.type, "gain")
    end)
  }))
  local shareBtn = UIHelper.extend(ccui.Button:create())
  shareBtn:setImages(RewardRes, {
    "share_bt.png",
    "share_bt.png"
  })
  shareBtn:setTouchScale()
  shareBtn:anch(0.5, 0.5):pos(display.width - 50, 70):addTo(self):setLocalZOrder(100):hide():scale(1.2)
  shareBtn:setCallback(function()
    local path = self:getShareScreen()
    local content = "#料理次元#这里是料理的世界，数百种珍馐佳肴的美少女食灵，总有一款适合你！"
    umeng.shareContent({content = content, image = path})
  end)
  shareBtn:runAction(transition.sequence({
    cc.DelayTime:create(1.5),
    cc.CallFunc:create(function()
      if config.showShare then
        shareBtn:show()
      end
    end)
  }))
  self.nameBg:setCascadeOpacityEnabled(true)
  self.nameBg:setOpacity(0)
  self.nameBg:runAction(transition.sequence({
    cc.DelayTime:create(1.5),
    cc.CallFunc:create(function()
      self.nameBg:setOpacity(255)
    end)
  }))
  if UIHelper.isiPhoneX() then
    width = width + UIHelper.getMoveXForX() * 2
    di:setPositionX(-UIHelper.getMoveXForX(true))
    self.nameBg:setPositionX(self.nameBg:getPositionX() - UIHelper.getMoveXForX())
    UIHelper.fitForiPhoneX(self.bg)
    UIHelper.fitForiPhoneX(self.spine)
    for k, child in pairs(self:getChildren()) do
      child:setPositionX(child:getPositionX() + UIHelper.getMoveXForX(true))
    end
  end
  if self.showSkip then
    local btnSkip = UIHelper.newImageView("ui/kitchen/buildResult/btn_skip.png"):pos(display.width - 60, 615):addTo(self):setLocalZOrder(101)
    btnSkip:setCallback(function()
      self.skipFunc()
      self:exit()
    end)
  end
end

function HeroRewardLayer:getShareScreen()
  local path = "shareScreen.png"
  local width = display.width
  if UIHelper.isiPhoneX() then
    width = width + UIHelper.getMoveXForX() * 2
  end
  local renderTexture = cc.RenderTexture:create(width, display.height)
  renderTexture:begin()
  self.bg:visit()
  self.spine:visit()
  self.nameBg:visit()
  if self.talk and next(self.talk.actors) then
    local index, actor = next(self.talk.actors)
    actor.spine:visit()
  end
  local ma = display.newSprite(RewardRes .. "right_info.png"):anch(0, 0):pos(10, 20)
  local info = display.newSprite(RewardRes .. "left_info.png"):anch(0, 0):pos(ma:getContentSize().width, 0):addTo(ma)
  game.serverInfo = game.serverInfo or {}
  display.newTTFLabel({
    text = "服务器: " .. (game.serverInfo.name or ""),
    size = 18,
    color = UIHelper.hex2rgb("#ffffff")
  }):anch(0, 0.5):pos(2, 63):addTo(info):enableOutline(UIHelper.hex2rgb("#000000"), 1)
  display.newTTFLabel({
    text = game.role.level,
    size = 20,
    color = UIHelper.hex2rgb("#ffffff")
  }):anch(0, 0.5):pos(35, 39):addTo(info):enableOutline(UIHelper.hex2rgb("#000000"), 1)
  display.newTTFLabel({
    text = game.role.name,
    size = 20,
    color = UIHelper.hex2rgb("#ffffff")
  }):anch(0, 0.5):pos(2, 17):addTo(info):enableOutline(UIHelper.hex2rgb("#000000"), 1)
  ma:visit()
  if self.params.material then
    local materialText = {
      "食油",
      "魔力",
      "食材",
      "调料"
    }
    local materialNode = display.newNode():pos(width - 210, 90)
    for i = 1, 4 do
      local one = display.newNode():pos(58 * (i - 1), 0):addTo(materialNode)
      local di = display.newSprite("ui/kitchen/cook/circle_white.png"):scale(0.36):addTo(one)
      display.newSprite(GlobalRes .. "base_" .. i .. ".png"):addTo(one)
      display.newTTFLabel({
        text = materialText[i],
        size = 16,
        color = UIHelper.hex2rgb("#ffffff")
      }):anch(0.5, 0):pos(0, 19):addTo(one):enableOutline(UIHelper.hex2rgb("#000000"), 1)
      display.newTTFLabel({
        text = self.params.material[i],
        size = 20,
        color = UIHelper.hex2rgb("#ffffff")
      }):anch(0.5, 0):pos(0, -34):addTo(one):enableOutline(UIHelper.hex2rgb("#000000"), 1)
    end
    local title = UIHelper.newMask({
      size = cc.size(100, 26),
      color = "#000000",
      opacity = 255
    }):anch(1, 0):pos(210, 42):addTo(materialNode)
    display.newTTFLabel({
      text = "烹饪公式",
      size = 20,
      color = UIHelper.hex2rgb("#ffffff")
    }):addTo(title):center(title)
    materialNode:visit()
  end
  renderTexture:endToLua()
  if renderTexture:saveToFile(path, kCCImageFormatPNG) then
    return string.gsub(device.writablePath, "[\\\\/]+$", "") .. device.directorySeparator .. path
  end
end

function HeroRewardLayer:exit()
  CommonHelper.stopCV()
  if self.topbar then
    TopBar:show(self.topbar[1], self.topbar[2], self.topbar[3])
  end
  if self.params.callback then
    self.params.callback()
  end
  self:removeFromParent()
end

return HeroRewardLayer
