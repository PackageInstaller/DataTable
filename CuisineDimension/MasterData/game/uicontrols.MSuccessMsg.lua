local MSuccessMsg = {
  messages = {}
}
SuccessMsg = {
  normal = 1,
  pvp = 2,
  merge = 3
}
local HeroRes = "ui/hero/"
local PvpRes = "ui/pvp/"
local CarbonRes = "ui/carbon/chooseHero"
local MSuccessTag = 20150511

function MSuccessMsg:show(params)
  local bgColor = params.bgColor or cc.c3b(0, 0, 0)
  local opacity = params.opacity or 150
  local size = params.size or cc.size(450, 350)
  local type = params.type or SuccessMsg.normal
  local layer = UIHelper.extend(ccui.Layout:create())
  layer:size(display.width, display.height)
  layer:setBackGroundColor(bgColor)
  layer:setBackGroundColorType(1)
  layer:setBackGroundColorOpacity(opacity)
  layer:setCallback(function(sender)
    layer:removeFromParent()
    self:pop()
  end)
  local bg = display.newScale9Sprite(HeroRes .. "success_bg.png", 0, 0, size)
  bg:anch(0.5, 0.5):pos(display.cx, display.cy - 40):addTo(layer, 0, 0)
  display.newSprite(HeroRes .. "new_light.png"):pos(size.width / 2, size.height + 30):addTo(bg)
  local titleBg = display.newSprite(HeroRes .. "success_sunshine.png"):pos(size.width / 2, size.height + 30):addTo(bg)
  if not params.heroId then
    display.newSprite(HeroRes .. "common_suc.png"):center(titleBg):addTo(titleBg)
  else
    display.newSprite(HeroRes .. "common_suc.png"):center(titleBg):addTo(titleBg)
    SmallCard:create({
      heroId = params.heroId
    }):anch(0.5, 0.5):pos(size.width / 2, size.height / 2 + 30):addTo(bg)
  end
  local btn = UIHelper.extend(ccui.Button:create())
  btn:setImages(CarbonRes, {
    "zhunbei_botton1_1.png",
    "zhunbei_botton1_2.png"
  })
  btn:setString({
    text = "确定",
    size = 30,
    color = UIHelper.hex2rgb("#ffffff")
  })
  btn:anch(0.5, 0.5):pos(size.width / 2, 40):addTo(bg)
  btn:setCallback(function()
    layer:removeFromParent()
    self:pop()
  end)
  if type == SuccessMsg.normal then
    self:initNormalType(bg, params)
  elseif type == SuccessMsg.pvp then
  end
  self:push(layer)
end

function MSuccessMsg:initNormalType(content, params)
  local size = content:getContentSize()
  display.newSprite(PvpRes .. "pvp_kuang2.png"):anch(0.5, 0.5):pos(size.width / 2, size.height / 2):addTo(content)
  display.newTTFLabel({
    text = params.text,
    size = 40,
    color = UIHelper.hex2rgb("#ffcf73")
  }):enableOutline(UIHelper.hex2rgb("#391400"), 2):anch(0.5, 0.5):pos(size.width / 2, size.height / 2 + 3):addTo(content)
end

function MSuccessMsg:initPvpType(content, params)
  local oldLevel = params.oldLevel
  local newLevel = params.newLevel
  local PvpCsv = require("csvdata.pvp_part")
  local size = content:getContentSize()
  display.newSprite(PvpRes .. string.format("dengji_%d.png", oldLevel)):anch(0.5, 0.5):pos(size.width / 2, 245):addTo(content)
  display.newSprite(PvpRes .. "pvp_kuang2.png"):anch(0.5, 0.5):pos(size.width / 2, 143):addTo(content)
  display.newTTFLabel({
    text = PvpCsv[oldLevel].name,
    size = 24,
    color = UIHelper.hex2rgb("#ffcf73")
  }):enableOutline(UIHelper.hex2rgb("#391400"), 2):anch(0, 0.5):pos(150, 143):addTo(content)
  display.newTTFLabel({
    text = PvpCsv[newLevel].name,
    size = 24,
    color = UIHelper.hex2rgb("#ffcf73")
  }):enableOutline(UIHelper.hex2rgb("#391400"), 2):anch(0, 0.5):pos(260, 143):addTo(content)
  display.newSprite(HeroRes .. "jinhua_arrow_small.png"):anch(0.5, 0.5):pos(223, 143):addTo(content)
  display.newSprite(HeroRes .. "jinhua_arrow_small.png"):anch(0.5, 0.5):pos(233, 143):addTo(content)
  display.newTTFLabel({
    text = params.text,
    size = 20,
    color = UIHelper.hex2rgb("#ffffff")
  }):anch(0.5, 0.5):pos(size.width / 2, 93):addTo(content)
end

function MSuccessMsg:push(layer)
  layer:retain()
  table.insert(self.messages, layer)
  if not display.getRunningScene():getChildByTag(MSuccessTag) then
    self:pop()
  end
end

function MSuccessMsg:pop()
  local layer = self.messages[1]
  if layer then
    layer:addTo(display.getRunningScene(), 0, MSuccessTag)
    self:actions(layer)
    layer:release()
    table.remove(self.messages, 1)
  end
end

function MSuccessMsg:actions(layer)
  local content = layer:getChildByTag(0)
  content:setScale(0)
  local actions = {}
  actions[#actions + 1] = cc.EaseInOut:create(cc.ScaleTo:create(0.5, 1), 10)
  actions[#actions + 1] = cc.DelayTime:create(3)
  actions[#actions + 1] = cc.CallFunc:create(function()
    layer:removeFromParent()
    self:pop()
  end)
  content:runAction(transition.sequence(actions))
end

return MSuccessMsg
