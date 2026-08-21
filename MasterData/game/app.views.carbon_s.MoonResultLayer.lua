local ChapterBattleCsv = require("csvdata.moon_chapter_battle")
local MonsterCsv = require("csvdata.monster")
local TalkCsv = require("csvdata.talk")
local ItemCsv = require("csvdata.item")
local BattleRes = "ui/carbon/battleresult/"
local CarbonRes = "ui/carbon/carbonresult/"
local uiData = {
  csbFile = "ui/autumn/MoonResultLayer.csb",
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
    move3 = "center/move3",
    point = "move1/node",
    m1 = "center/move2/m1",
    m2 = "center/move2/m2",
    m3 = "center/move2/m3",
    m4 = "center/move2/m4",
    m5 = "center/move2/m5",
    m6 = "center/move2/m6",
    textNode = "center/move3/node"
  }
}
local Time
local MoonResultLayer = class("MoonResultLayer", UIBase)

function MoonResultLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function MoonResultLayer:init(params)
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
      for itemId, count in pairs(self.result.dropItems) do
        local item = ItemCsv[itemId]
        if item.type ~= ItemType.Hero then
          self.result.dropItems[itemId] = nil
        end
      end
      self:showItems()
    end
  end)
end

function MoonResultLayer:showData()
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
      for index = 1, 3 do
        self["move" .. index]:runAction(transition.sequence({
          cc.MoveBy:create(Time or delay, cc.p(328, 0)),
          cc.CallFunc:create(function()
            if index == 1 then
              self:moveDetail1()
            elseif index == 2 then
              self:moveDetail2()
            else
              self:moveDetail3()
            end
          end)
        }))
        delay = delay + 0.3
      end
    end)
  }))
end

function MoonResultLayer:moveDetail1()
  local function battleLevel()
    local signSprite = UIHelper.newImageView(BattleRes .. string.format("point%d.png", self.result.assess)):scale(1.5):pos(90, -15):addTo(self.point)
    
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

function MoonResultLayer:moveDetail2()
  local chapterData = ChapterBattleCsv[self.carbonId]
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

function MoonResultLayer:moveDetail3()
  local x = 0
  for id, count in pairs(self.result.dropItems) do
    if tonumber(count) ~= 0 then
      local icon = ItemIcon.new({
        type = tonumber(id),
        count = tonumber(count),
        showTip = true
      }):scale(0.83)
      if x < 3 then
        icon:pos(x * 90, 0):addTo(self.textNode)
      else
        icon:pos((x - 3) * 90, -90):addTo(self.textNode)
      end
      x = x + 1
    end
  end
end

function MoonResultLayer:showItems()
  if table.nums(self.result.dropItems) > 0 then
    CommonHelper.stopCV()
    for id, count in pairs(self.result.dropItems) do
      self.result.dropItems[id] = nil
      HeroRewardLayer.new({
        type = id - ItemStartId.hero,
        callback = function()
          self:showItems()
        end
      })
      break
    end
  else
    Time = nil
    BackManager:pop()
  end
end

return MoonResultLayer
