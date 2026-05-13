local HeroRes = "ui/hero/"
local FormatRes = "ui/equip/format/"
local SauceRes = "ui/sauce/card/"
local uiData = {
  csbFile = "ui/equip/EquipFormationLayer.csb",
  widgets = {
    down = "down",
    cardNode1 = "card1",
    cardNode2 = "card2",
    cardNode3 = "card3",
    cardNode4 = "card4",
    cardNode5 = "card5"
  }
}
local SauceFormationLayer = class("SauceFormationLayer", UIBase)

function SauceFormationLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function SauceFormationLayer:init(params)
  if UIHelper.isiPhoneX() then
    UIHelper.fitForiPhoneX(self.down)
  end
  self:showBtns()
end

function SauceFormationLayer:showBtns()
  local yPos = math.min(game.role.teamMaxNum, 8) * 50 + 65
  local btnsBg = display.newScale9Sprite(FormatRes .. "btns_bg.png", 0, 0, cc.size(116, yPos)):anch(1, 0):pos(1010, 60):addTo(self)
  local list = ccui.ListView:create()
  list:size(cc.size(120, yPos - 60))
  list:setInnerContainerSize(cc.size(120, yPos - 60))
  list:setClippingEnabled(true)
  list:setBounceEnabled(true)
  list:anch(0.5, 0.5):pos(60, (yPos - 60) / 2 + 3):addTo(btnsBg)
  local textBg = display.newSprite(FormatRes .. "text_bg.png"):pos(53, yPos - 35):addTo(btnsBg)
  display.newTTFLabel({text = "套餐", size = 28}):enableOutline(UIHelper.hex2rgb("#4b2200"), 1):pos(80, 25):addTo(textBg)
  self.group = MRadioGroup:create({
    chooseCb = function(sender)
      sender:removeAllChildren()
      sender:setPositionX(sender:getPositionX() - 10)
      display.newTTFLabel({
        text = "套餐" .. sender:getName(),
        size = 24
      }):enableOutline(UIHelper.hex2rgb("#4c3605"), 1):anch(0, 0.5):pos(20, 23):addTo(sender)
    end,
    unchooseCb = function(sender)
      sender:removeAllChildren()
      sender:setPositionX(sender:getPositionX() + 10)
      display.newTTFLabel({
        text = "套餐" .. sender:getName(),
        size = 18
      }):enableOutline(UIHelper.hex2rgb("#4c3605"), 1):anch(0, 0.5):pos(20, 23):addTo(sender)
    end
  })
  for index = 1, game.role.teamMaxNum do
    local viewNode = ccui.Widget:create()
    viewNode:setContentSize(cc.size(120, 50)):addTo(list)
    local btn = UIHelper.extend(ccui.Button:create())
    btn:setImages(FormatRes, {"btn_a.png", "btn_b.png"})
    btn:setCallback(function()
      self:showFormation(index)
    end)
    btn:setName(string.format("%d", index))
    btn:center(viewNode):addTo(viewNode)
    btn:setGroup(self.group)
  end
  if UIHelper.isiPhoneX() then
    btnsBg:setPositionX(btnsBg:getPositionX() + 200)
  end
end

function SauceFormationLayer:showData(params)
  local selected = params.selected or 1
  self.group:chooseByName(string.format("%d", selected))
  self:showFormation(selected)
end

function SauceFormationLayer:showFormation(index)
  local formationData = game.role.formation[tostring(index)] or {
    list = {},
    lock = {},
    pos = {}
  }
  local xPos, interval = -45, 172
  self.card = {}
  for slot = 1, 5 do
    local card
    local heroId = formationData.list[tostring(slot)]
    local node = self["cardNode" .. slot]
    node:removeAllChildren()
    if heroId then
      local hero = game.role.heros[heroId]
      card = TeamEquipCard.new({
        heroId = heroId,
        captain = slot == 1,
        normal = "sauce",
        callback = function()
        end,
        detail = function()
          local layer = game:createView("hero.HeroDetailLayer", {heroId = heroId})
          self:hide()
          BackManager:push(function()
            self:show()
            card:reflashCard()
            self:showInfo()
            layer:close()
            TopBar:show(TopBarType.full, "酱料")
          end)
        end,
        refresh = function()
          self:showInfo()
        end
      })
      card:addTo(node)
      self.card[slot] = {card = card, id = heroId}
    else
      card = UIHelper.newImageView(HeroRes .. "add_bg.png"):addTo(node)
      UIHelper.newImageView(HeroRes .. "show.png"):pos(80, 275):addTo(card)
    end
    card:name("heroFormat" .. slot)
    self:cardAnimation(card, slot)
  end
end

function SauceFormationLayer:showInfo()
  for _, data in pairs(self.card) do
    data.card:showSauces()
  end
end

function SauceFormationLayer:cardAnimation(card, slot)
  card:hide()
  local node = self["cardNode" .. slot]
  local mask = display.newSprite(HeroRes .. "card_mask.png"):addTo(node)
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

return SauceFormationLayer
