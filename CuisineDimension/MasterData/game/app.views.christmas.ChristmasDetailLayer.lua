local BattleCsv = require("csvdata.moon_chapter_battle")
local uiData = {
  popup = true,
  mask = true,
  maskClick = true,
  csbFile = "ui/christmas/ChristmasDetailLayer.csb",
  widgets = {
    mainBg = "mainBg",
    node1 = "node1",
    node2 = "node2",
    node3 = "node3",
    btnStart = "btnStart"
  }
}
local ChristmasDetailLayer = class("ChristmasDetailLayer", UIBase)

function ChristmasDetailLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function ChristmasDetailLayer:init(params)
  self.chapterId = params.id * 10 + 3
  for i = 1, 3 do
    local tempCount = game.role.midBattleCount:getv(params.id * 10 + i, 0)
    if tempCount < 1 then
      self.chapterId = params.id * 10 + i
      break
    end
  end
  if params.resetBg then
    self.chapterId = params.id
    self.mainBg:setTexture(params.resetBg)
  end
  display.newTTFLabel({text = "出发", size = 22}):enableOutline(UIHelper.hex2rgb("#502801"), 1):pos(70, 21):addTo(self.btnStart)
  self.btnStart:setTouchScale()
  self.btnStart:setCallback(function()
    if not game.role:activityIsOpen(54) then
      SysError(SYS_ERR_MOON_CARBON_IS_CLOSED)
      return
    end
    if next(json.decode(game.role.battleInfo) or {}) then
      SysError(SYS_ERR_CARBON_MAIN_ON_BATTLE)
      return
    end
    if next(json.decode(game.role.paradiseBattleInfo) or {}) then
      SysError(SYS_ERR_CARBON_HAPPY_ON_BATTLE)
      return
    end
    if game.role.moonBattle.carbonId and game.role.moonBattle.carbonId ~= params.id then
      SysError(SYS_ERR_CARBON_ACTIVITY_ON_BATTLE)
      return
    end
    if not game.role.moonBattle.carbonId and game.role:isMaxHero() then
      UIHelper.showExtraTip({type = 1, parent = self})
      return
    end
    local chapterData = BattleCsv[self.chapterId]
    if game.role.midBattleCount:getv(self.chapterId, 0) == 0 and not game.role.moonBattle.carbonId and chapterData.story1 ~= 0 then
      local chapterId = self.chapterId
      game:createView("talk.PlotTalkLayer", {
        talkId = chapterData.story1,
        csvNo = chapterData.readcsv or 0,
        onComplete = function()
          game:enterScene("MoonScene", {
            carbonId = game.role.moonBattle.carbonId or chapterId
          })
        end
      })
      self:close()
      return
    end
    game:enterScene("MoonScene", {
      carbonId = game.role.moonBattle.carbonId or self.chapterId
    })
    self:close()
  end)
end

function ChristmasDetailLayer:showData(params)
  local data = BattleCsv[self.chapterId]
  display.newTTFLabel({
    text = data.name,
    size = 30
  }):anch(0, 0.5):addTo(self.node1)
  display.newTTFLabel({
    text = "战斗奖励",
    size = 24
  }):anch(0, 0.5):addTo(self.node2)
  local xPos = 185
  for _, set in ipairs(data.fightGiftRandom:toTableArray()) do
    if tonumber(set[1]) ~= 0 then
      ItemIcon.new({
        type = tonumber(set[1]),
        count = 0,
        showTip = true
      }):scale(0.85):pos(xPos, -31):addTo(self.node2)
      xPos = xPos + 95
      break
    end
  end
  display.newTTFLabel({
    text = "可能掉落",
    size = 24
  }):anch(0, 0.5):addTo(self.node3)
  local xPos, yPos = 185, -31
  for index, id in ipairs(data.gift2see:toArray("=", true)) do
    ItemIcon.new({type = id, showTip = true}):scale(0.85):pos(xPos, yPos):addTo(self.node3)
    xPos = xPos + 95
    if index == 5 then
      xPos = 185
      yPos = -120
    end
  end
end

return ChristmasDetailLayer
