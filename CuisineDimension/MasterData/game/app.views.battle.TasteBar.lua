local SkillRes = "ui/battle/skill/"
local BattleRes = "ui/battle/"
local GlobalRes = "ui/global/"
local TasteCsv = require("csvdata.fightmode")
local TasteBar = class("TasteBar", function()
  return UIHelper.newImageView(SkillRes .. "taste_pot.png")
end)

function TasteBar:ctor(params)
  self.battle = params.battle
  self.selected = 0
  self:initElements()
  self:setSelected()
end

function TasteBar:initElements()
  self:enableNodeEvents()
  self:anch(0, 0)
  self:setCascadeOpacityEnabled(true)
  self.soup = display.newNode():pos(146, 0):addTo(self, -1)
  self.tasteNode = display.newNode():pos(146, 0):addTo(self)
  self:showTastes()
end

function TasteBar:showTastes()
  self.tasteNode:removeAllChildren()
  local status = {
    {-86, 31},
    {-42, 86},
    {42, 86},
    {86, 31}
  }
  local interval = 60
  for index = 1, 4 do
    local tasteId = index
    if tasteId == self.selected then
      tasteId = 0
    end
    local position = status[index]
    local taste = UIHelper.newImageView(SkillRes .. string.format("taste_%d.png", tasteId)):pos(position[1], position[2]):addTo(self.tasteNode):name("taste" .. index)
    taste:setCallback(function()
      local curId = self.selected
      self.selected = tasteId
      self:setSelected()
      self:showTastes()
      game:playMusic(1600)
      local btnEff = UIHelper.loadAnimation(SkillRes, "btn_eff", 14, 14, true)
      btnEff.sprite:pos(position[1], position[2]):addTo(self.tasteNode)
      btnEff.sprite:playAnimationOnce(btnEff.animation, true)
      local yanEff = UIHelper.loadAnimation(SkillRes, "yan", 23, 23, true)
      yanEff.sprite:anch(0.5, 0):addTo(self.tasteNode, -1)
      yanEff.sprite:playAnimationOnce(yanEff.animation, true)
    end)
  end
end

local tasteEffs = {
  "suan",
  "tian",
  "xian",
  "la"
}

function TasteBar:setSelected()
  self.soup:removeAllChildren()
  display.newSprite(SkillRes .. string.format("soup_%d.png", self.selected)):anch(0.5, 0):addTo(self.soup)
  if tasteEffs[self.selected] then
    local eff = UIHelper.loadAnimation(SkillRes, tasteEffs[self.selected], 45, 30, true)
    eff.sprite:anch(0.5, 0):addTo(self.soup)
    eff.sprite:playAnimationForever(eff.animation)
  end
  self.battle:setTaste(self.selected)
end

function TasteBar:onExit()
end

return TasteBar
