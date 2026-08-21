local heroRes = "ui/hero/"
local uiData = {
  csbFile = "ui/hero/HeroListLayer.csb",
  mask = true,
  widgets = {
    mainBg = "mainBg",
    btnList = "btnList",
    content = "content",
    btnBattle = "btnBattle",
    angle = "angle"
  }
}
local TravelListLayer = class("TravelListLayer", UIBase)

function TravelListLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function TravelListLayer:init(params)
  self.requireValue = params.requireValue
  self.callback = params.callback
  self.num = params.num
  self.cancelCall = params.cancelCall
  self.btnBattle:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#722c02"), 1)
  self.group = MRadioGroup:create()
  local btnSize = display.newSprite(heroRes .. "taocan_1.png"):getContentSize()
  local battleInfo = json.decode(game.role.battleInfo)
  local delay = 0.4
  for index = 1, game.role.teamMaxNum do
    local needShow = true
    if not game.role.formation[tostring(index)] or not game.role.formation[tostring(index)].list["1"] then
      needShow = false
    end
    local status = game.role:getFormationState(index)
    if status[2] or status[3] then
      needShow = false
    end
    if needShow then
      if not self.selected then
        self.selected = index
      end
      local viewNode = ccui.Widget:create()
      viewNode:setContentSize(btnSize):addTo(self.btnList):setName(string.format("%d", index))
      local btn = UIHelper.extend(ccui.Button:create())
      btn:setImages(heroRes, {
        "taocan_1.png",
        "taocan_2.png"
      })
      btn:center(viewNode):addTo(viewNode)
      btn:setString({
        text = string.format("套餐%d", index),
        size = 22,
        color = UIHelper.hex2rgb("#ffffff")
      })
      btn:setCallback(function()
        self:showFormation(index)
      end)
      btn:setName(string.format("套餐%d", index))
      btn:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#630c07"), 1)
      btn:setGroup(self.group)
      UIHelper.MoveToRight({
        node = btn,
        delay = delay,
        time = 0.2
      })
      delay = delay + 0.1
    end
  end
  self.btnBattle:setTitleText("确定")
  self.btnBattle:setCallback(function()
    if self.callback(self.selected) then
      BackManager:pop()
    end
  end)
end

function TravelListLayer:showData(params)
  local selected = params.selected or self.selected
  if selected then
    self.group:chooseByName(string.format("套餐%d", selected))
  end
  self:showFormation(selected)
end

function TravelListLayer:showFormation(index)
  self.content:removeAllChildren()
  self.card = {}
  self.selected = index
  local xPos, interval = -45, 172
  local totalBattle = 0
  local formationData = game.role.formation[tostring(index)] or {
    list = {},
    pos = {}
  }
  for slot = 1, 5 do
    local card
    local heroId = formationData.list[tostring(slot)]
    if heroId then
      local hero = game.role.heros[heroId]
      totalBattle = totalBattle + hero:getAllValue()
      card = TeamHeroCard.new({
        heroId = heroId,
        captain = slot == 1,
        detail = function()
          local layer = game:createView("hero.HeroDetailLayer", {heroId = heroId})
          self:hide()
          BackManager:push(function()
            self:show()
            layer:close()
            card:reflashCard()
            local totalValue = game.role:getTotalBattleValue(self.selected)
            self.battleValue:setString(totalValue)
            TopBar:show(TopBarType.full)
            self:showFormation(self.selected)
          end)
        end,
        refresh = function()
          self:effect(2)
          local totalValue = game.role:getTotalBattleValue(self.selected)
          self.battleValue:setString(totalValue)
          local color = totalValue >= self.requireValue and "#0f7d03" or "#642d05"
          self.descBattle:setTextColor(UIHelper.hex2rgb(color))
        end
      })
      card:pos(xPos + (slot - 1) * interval, 10):addTo(self.content)
      table.insert(self.card, card)
    else
      card = UIHelper.newImageView(heroRes .. "add_bg.png"):pos(xPos + (slot - 1) * interval, 10):addTo(self.content)
      display.newSprite(heroRes .. "show.png"):pos(78, 275):addTo(card)
    end
    self:cardAnimation(card, slot, xPos + (slot - 1) * interval)
  end
  self:InfoPanel(totalBattle, index)
end

function TravelListLayer:showDes(ma1, ma2)
  local bg = UIHelper.newImageView("ui/global/top_bar_value.png"):pos(812, -10):name("info"):addTo(self.content)
  UIHelper.newImageView("ui/global/base_1.png"):pos(20, 15):addTo(bg)
  display.newTTFLabel({
    text = tostring(ma1),
    size = 24,
    color = UIHelper.hex2rgb("#ffffff")
  }):pos(65, 15):addTo(bg)
  local bg2 = UIHelper.newImageView("ui/global/top_bar_value.png"):pos(812, -45):name("info"):addTo(self.content)
  UIHelper.newImageView("ui/global/base_2.png"):pos(20, 15):addTo(bg2)
  display.newTTFLabel({
    text = tostring(ma2),
    size = 24,
    color = UIHelper.hex2rgb("#ffffff")
  }):pos(65, 15):addTo(bg2)
  bg:runAction(transition.sequence({
    cc.FadeIn:create(0.5),
    cc.DelayTime:create(1),
    cc.FadeOut:create(0.5),
    cc.RemoveSelf:create()
  }))
  bg2:runAction(transition.sequence({
    cc.FadeIn:create(0.5),
    cc.DelayTime:create(1),
    cc.FadeOut:create(0.5),
    cc.RemoveSelf:create()
  }))
end

function TravelListLayer:InfoPanel(value, index)
  local bg = UIHelper.newImageView(heroRes .. "info_bar.png"):pos(800, 0):name("info"):addTo(self.content)
  display.newTTFLabel({
    text = "美味度",
    size = 20,
    color = UIHelper.hex2rgb("#ffffff")
  }):pos(bg:getContentSize().width / 2, 324):addTo(bg)
  local totalValue = game.role:getTotalBattleValue(index)
  self.battleValue = display.newTTFLabel({
    text = totalValue,
    size = 24,
    color = UIHelper.hex2rgb("#ffffff")
  }):pos(bg:getContentSize().width / 2, 299):addTo(bg)
  if not self.fistShow then
    bg:setOpacity(0)
    bg:setCascadeOpacityEnabled(true)
    UIHelper.MoveToLeft({
      node = bg,
      delay = 0.4,
      time = 0.18
    })
    UIHelper.MoveToLeft({
      node = self.btnBattle,
      delay = 0.4,
      time = 0.18
    })
    UIHelper.MoveToLeft({
      node = self.angle,
      delay = 0.4,
      time = 0.18
    })
    self.fistShow = 0
  end
  local color = totalValue >= self.requireValue and "#0f7d03" or "#642d05"
  local white = UIHelper.newImageView(heroRes .. "entrust_bg.png"):pos(bg:getContentSize().width / 2, 190):addTo(bg)
  display.newTTFLabel({
    text = "游历需求",
    size = 20,
    color = UIHelper.hex2rgb("#a63407")
  }):pos(60, 160):addTo(white)
  self.descBattle = display.newTTFLabel({
    text = "美味度:" .. self.requireValue .. "+",
    size = 18,
    color = UIHelper.hex2rgb(color)
  }):anch(0, 0.5):pos(10, 130):addTo(white)
  if totalValue < self.requireValue then
    local flash = display.newScale9Sprite("ui/hero/card_mask.png", 0, 0, cc.size(132, 338)):center(bg):addTo(bg)
    flash:setOpacity(0)
    flash:runAction(transition.sequence({
      cc.FadeTo:create(0.2, 200),
      cc.FadeTo:create(0.2, 0),
      cc.DelayTime:create(0.2),
      cc.RemoveSelf:create()
    }))
  end
end

function TravelListLayer:cardAnimation(card, slot, xPos)
  card:hide()
  local mask = display.newSprite(heroRes .. "card_mask.png"):pos(xPos, 10):addTo(self.content)
  mask:setOpacity(0)
  mask:runAction(transition.sequence({
    cc.DelayTime:create(0.03 * (slot - 1)),
    cc.MoveBy:create(0, cc.p(-8, -8)),
    cc.Spawn:create(cc.FadeIn:create(0.06), cc.MoveBy:create(0.06, cc.p(8, 8))),
    cc.CallFunc:create(function()
      card:show()
    end),
    cc.FadeOut:create(0.18),
    cc.CallFunc:create(function()
      mask:removeSelf()
    end)
  }))
end

return TravelListLayer
