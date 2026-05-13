local BossCsv = require("csvdata.ghost")
local BossRes = "ui/carbon/boss/"
local StoryCsv = require("csvdata.storybook")
local uiData = {
  csbFile = "ui/carbon/BossSearchLayer.csb",
  mask = true,
  widgets = {mainBg = "mainBg", frameBg = "frameBg"}
}
local BossSearchLayer = class("BossSearchLayer", UIBase)

function BossSearchLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function BossSearchLayer:init(params)
  self.func = params.func
  TopBar:show(TopBarType.hide)
  local tempArray = {
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10
  }
  local flag = math.randomInt(1, #tempArray)
  self.node = display.newClippingRectangleNode()
  local ccsize = self.mainBg:getContentSize()
  self.node:setClippingRegion(cc.rect(0, 0, ccsize.width, ccsize.height))
  self.node:addTo(self.mainBg, 0)
  local circle = display.newSprite("ui/carbon/boss/search_circle.png"):rotate(20):anch(0, 0):pos(ccsize.width / 2 - 3, ccsize.height / 2 - 1):addTo(self.node, 0)
  local time = 2
  circle:runAction(cc.RepeatForever:create(cc.RotateBy:create(time, 360)))
  local ghostrandom = globalCsv.ghostrandom
  local v = math.randomInt(1, #ghostrandom)
  local poss = ghostrandom[v]:toTableArray()
  local chooseId = math.randomInt(1, #poss)
  self.reds = {}
  
  local function calculAngle(x, y)
    local angel = math.deg(math.atan(math.abs(y / x)))
    if 0 <= x and 0 < y then
      angel = 360 - angel
    elseif x < 0 and y < 0 then
      angel = angel + 90
    elseif x < 0 and 0 <= y then
      angel = angel + 180
    end
    return angel
  end
  
  for index, newData in pairs(poss) do
    local xpos, ypos = tonumber(newData[1]), tonumber(newData[2])
    self.reds[index] = UIHelper.newImageView("ui/carbon/boss/red.png")
    local red = self.reds[index]
    red:scale(1):opacity(0):pos(xpos + ccsize.width / 2, ypos + ccsize.height / 2):name(tostring(index)):addTo(self.mainBg)
    local needTime = 0.5
    local angel = calculAngle(xpos, ypos)
    red:runAction(transition.sequence({
      cc.DelayTime:create(angel / 360 * time + 0.1),
      cc.FadeIn:create(needTime),
      cc.FadeOut:create(needTime),
      cc.DelayTime:create(time - needTime * 2),
      cc.CallFunc:create(function()
        local tempId = tonumber(red:getName())
        if tempId == chooseId then
          for _, tempRed in pairs(self.reds) do
            tempRed:stopAllActions()
            tempRed:hide()
          end
          self:showResultBy(xpos + ccsize.width / 2, ypos + ccsize.height / 2)
        end
      end),
      cc.FadeIn:create(needTime),
      cc.FadeOut:create(needTime)
    }))
  end
  local x, y = tonumber(poss[chooseId][1]), tonumber(poss[chooseId][2])
  local endAngel = calculAngle(x, y)
  local extrTime = endAngel / 360 * time + 0.1
  self.frameBg:runAction(transition.sequence({
    cc.CallFunc:create(function()
      local layer = game:createView("carbon.BossAppearLayer", {
        callback = function()
        end,
        time = 2 + extrTime
      })
      layer:addTo(display.getRunningScene())
    end)
  }))
end

function BossSearchLayer:showBossDetail()
  local layer = game:createView("carbon.BossDetailLayer")
  self:hide()
  BackManager:push(function()
    self:close()
    layer:close()
  end)
end

function BossSearchLayer:showResultBy(xpos, ypos)
  local extraBattle = json.decode(game.role.extraBattle)
  local bossId = extraBattle.bossId
  if not bossId then
    return
  end
  local Spine = UIHelper.createSpineNodeByRes("spine/ui/carbon/radar_boss")
  local bg = UIHelper.newImageView(BossRes .. "dialog_bg.png"):pos(80, 80):addTo(Spine)
  Spine:pos(xpos, ypos):addTo(self.frameBg)
  Spine:setAnimation(1, "special", true)
  local btn = UIHelper.getClipNode({
    steRes = "ui/global/" .. "mask_2.png",
    clipRes = BossCsv[bossId].headPic
  }):scale(0.76):anch(0.5, 0.5):pos(45, 45):addTo(bg)
  UIHelper.newImageView(BossRes .. "dialog_frame.png"):pos(45, 45):addTo(bg)
  bg:hide()
  bg:runAction(transition.sequence({
    cc.CallFunc:create(function()
      self.node:removeSelf()
    end),
    cc.CallFunc:create(function()
      bg:show()
      local circle = UIHelper.loadAnimation("ui/global/", "guide_circle", 12, 12)
      circle.sprite:pos(45, 45):addTo(bg, 1000):playAnimationForever(circle.animation)
      local layer = UIHelper.extend(ccui.Layout:create())
      layer:size(display.width, display.height):addTo(display.getRunningScene())
      layer:setCallback(function()
        local needStroy = false
        local taskId
        local book = game.role.storyBook
        local bossData = BossCsv[extraBattle.bossId]
        local killTime = game.role.BossKillStatus:getv(bossData.killTag, 0)
        if killTime == 0 then
          if 0 < BossCsv[bossId].story1 then
            game:createView("talk.PlotTalkLayer", {
              talkId = BossCsv[bossId].story1,
              csvNo = BossCsv[bossId].readcsv or 0,
              onComplete = function()
                self:showBossDetail()
                layer:removeSelf()
              end
            })
          else
            self:showBossDetail()
            layer:removeSelf()
          end
        else
          self:showBossDetail()
          layer:removeSelf()
        end
      end)
    end)
  }))
end

function BossSearchLayer:onExit()
  if self.func then
    self.func()
  end
  TopBar:show(TopBarType.full, "战斗")
end

function BossSearchLayer:showData()
end

return BossSearchLayer
