local TalkCsv = require("csvdata.talk")
local ItemCsv = require("csvdata.item")
local BattleRes = "ui/carbon/battleresult/"
local CarbonRes = "ui/carbon/carbonresult/"
local uiData = {
  csbFile = "ui/carbon/CarbonHappyResultLayer.csb",
  mask = true,
  widgets = {
    center = "center",
    mainBg = "mainBg",
    titleBg = "titleBg",
    heroNode = "heroNode",
    say = "say",
    text = "say/text",
    move1 = "center/move1",
    move2 = "center/move2",
    point = "move1/node",
    m1 = "center/move2/m1",
    m2 = "center/move2/m2",
    m3 = "center/move2/m3",
    m4 = "center/move2/m4",
    m5 = "center/move2/m5",
    m6 = "center/move2/m6"
  }
}
local Time
local CarbonHappyResultLayer = class("CarbonHappyResultLayer", UIBase)

function CarbonHappyResultLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function CarbonHappyResultLayer:init(params)
  self.result = params.endResult
  self.carbonId = params.carbonId
  self.formatId = params.id
  self.progress = params.progress
  for itemId, count in pairs(self.result.dropItems) do
    if count == 0 then
      self.result.dropItems[itemId] = nil
    end
  end
  self.center:setCallback(function()
    if not Time then
      Time = 0
    else
      self:showItems()
    end
  end)
end

function CarbonHappyResultLayer:showData()
  TopBar:show(TopBarType.hide)
  local heroId = game.role.formation[tostring(self.formatId)].list["1"]
  local hero = game.role.heros[heroId]
  local cap = HeroBigCard.new({
    heroId = heroId,
    quality = hero.quality
  }):addTo(self.heroNode)
  cap:setOpacity(0)
  if self.result.win then
    CommonHelper.playCV(game.role.heros[heroId].unit.type, "victory")
    self.text:setString(TalkCsv[game.role.heros[heroId].unit.type].victory)
    self.text:setOpacity(0)
  else
    self.say:hide()
  end
  cap:runAction(cc.FadeIn:create(Time or 0.3))
  self.text:runAction(cc.FadeIn:create(Time or 0.3))
  self.titleBg:runAction(cc.MoveBy:create(Time or 0.3, cc.p(332, 0)))
  self.mainBg:runAction(transition.sequence({
    cc.MoveBy:create(Time or 0.3, cc.p(512, 0)),
    cc.CallFunc:create(function()
      local delay = 0.2
      for index = 1, 2 do
        self["move" .. index]:runAction(transition.sequence({
          cc.MoveBy:create(Time or delay, cc.p(328, 0)),
          cc.CallFunc:create(function()
            if index == 1 then
              self:moveDetail1()
            else
              self:moveDetail2()
            end
          end)
        }))
        delay = delay + 0.3
      end
    end)
  }))
end

function CarbonHappyResultLayer:moveDetail1()
  local function battleLevel()
    local score = self.result.win and 3 or 0
    
    local signSprite = UIHelper.newImageView(BattleRes .. string.format("point%d.png", score)):scale(1.5):pos(90, -15):addTo(self.point)
    game:playMusic(1700)
    local actions = {}
    actions[#actions + 1] = cc.MoveTo:create(Time or 0.4, cc.p(0, 0))
    actions[#actions + 1] = cc.ScaleTo:create(Time or 0.4, 1)
    signSprite:runAction(cc.Spawn:create(actions[1], actions[2]))
  end
  
  self.point:runAction(transition.sequence({
    cc.DelayTime:create(Time or 1),
    cc.CallFunc:create(function()
      battleLevel()
      Time = 0
    end)
  }))
end

function CarbonHappyResultLayer:moveDetail2()
  local kills = {}
  for day, data in pairs(self.result.kill) do
    for id, num in pairs(data) do
      kills[tonumber(id)] = (kills[tonumber(id)] or 0) + num
    end
  end
  for index = 1, 6 do
    local num = kills[index] or 0
    UIHelper.newImageView(CarbonRes .. string.format("monster%d.png", index)):addTo(self["m" .. index])
    local label = display.newTTFLabel({
      text = "x 0",
      size = 18,
      color = UIHelper.hex2rgb("#f5d090")
    }):pos(40, 0):addTo(self["m" .. index])
    UIHelper.numVaryEffect({
      node = label,
      repeatTimes = 5,
      stringFormat = "x %d",
      endNum = num,
      effectTime = Time or 0.5
    })
  end
end

function CarbonHappyResultLayer:showItems()
  Time = nil
  if next(self.result.dropItems) then
    MedalRewardLayer.new({
      items = self.result.dropItems,
      callback = function()
        BackManager:pop()
      end
    })
  else
    BackManager:pop()
  end
end

return CarbonHappyResultLayer
