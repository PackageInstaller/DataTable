local ChapterBattleCsv = require("csvdata.chapter_battle")
local MonsterCsv = require("csvdata.monster")
local TalkCsv = require("csvdata.talk")
local ItemCsv = require("csvdata.item")
local BattleRes = "ui/carbon/battleresult/"
local CarbonRes = "ui/carbon/carbonresult/"
local uiData = {
  csbFile = "ui/carbon/CarbonResultLayer.csb",
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
    move4 = "center/move4",
    point = "move1/node",
    m1 = "center/move2/m1",
    m2 = "center/move2/m2",
    m3 = "center/move2/m3",
    m4 = "center/move2/m4",
    m5 = "center/move2/m5",
    m6 = "center/move2/m6",
    textNode = "center/move3/node",
    text1 = "center/move3/text1",
    text2 = "center/move3/text2",
    text3 = "center/move3/text3",
    desc = "center/move4/desc"
  }
}
local Time
local CarbonResultLayer = class("CarbonResultLayer", UIBase)

function CarbonResultLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function CarbonResultLayer:init(params)
  self.result = params.endResult
  self.carbonId = params.carbonId
  self.formatId = params.id
  self.progress = params.progress
  self.center:setCallback(function()
    if Time then
      Time = nil
      self:showItems()
    else
      Time = 0
    end
  end)
end

local monsterName = {
  [1] = "Boss",
  [2] = "突击怪",
  [3] = "制造者",
  [4] = "渣滓",
  [5] = "吞噬者"
}

function CarbonResultLayer:showData()
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
      for index = 1, 4 do
        self["move" .. index]:runAction(transition.sequence({
          cc.MoveBy:create(Time or delay, cc.p(328, 0)),
          cc.CallFunc:create(function()
            if index == 1 then
              self:moveDetail1()
            elseif index == 2 then
              self:moveDetail2()
            elseif index == 3 then
              self:moveDetail3()
            else
              self:moveDetail4()
            end
          end)
        }))
        delay = delay + 0.3
      end
    end)
  }))
end

function CarbonResultLayer:moveDetail1()
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

function CarbonResultLayer:moveDetail2()
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

function CarbonResultLayer:moveDetail3()
  local function detail()
    local mapId = math.floor(self.carbonId / 100)
    
    local chapterData = ChapterBattleCsv[self.carbonId]
    for cond = 1, 3 do
      local str = chapterData["con" .. cond .. "Desc"]
      local achiev = self.result.achievement[cond] and 1 or 0
      self["text" .. cond]:setString(str)
      UIHelper.newImageView(CarbonRes .. string.format("aim%d.png", achiev)):pos(-20, 10):addTo(self["text" .. cond])
    end
  end
  
  self.textNode:runAction(transition.sequence({
    cc.DelayTime:create(Time or 0.5),
    cc.CallFunc:create(function()
      detail()
    end)
  }))
end

function CarbonResultLayer:moveDetail4()
  local desc
  if self.result.energy == -1 then
    desc = "净化失败，未能获得线索"
  elseif self.result.energy == 0 then
    desc = "运气不好，没有获得异变线索"
  elseif self.result.energy == 100 then
    desc = "线索已满，请先净化异变食灵"
  else
    desc = "异变线索 +" .. self.result.energy
  end
  if not CommonHelper.funcOpen("ghost") then
    desc = "未开启搜索异变食灵功能"
  end
  self.desc:runAction(transition.sequence({
    cc.DelayTime:create(Time or 0.5),
    cc.CallFunc:create(function()
      display.newTTFLabel({
        text = desc,
        size = 18,
        color = UIHelper.hex2rgb("#2ee909")
      }):anch(0, 0.5):addTo(self.desc)
    end)
  }))
end

function CarbonResultLayer:showItems()
  if table.nums(self.result.dropItems) > 0 then
    MedalRewardLayer.new({
      items = self.result.dropItems,
      check = true,
      bShow = true,
      callback = function()
        self.result.dropItems = {}
        self:showItems()
      end
    })
  else
    Time = nil
    if self.result.trade then
      local layer = game:createView("trade.TradeSellLayer", {
        items = game.role.tradeItems
      })
      BackManager:push(function()
        layer:close()
        BackManager:pop()
      end)
    else
      BackManager:pop()
    end
  end
end

function CarbonResultLayer:onExit()
end

return CarbonResultLayer
