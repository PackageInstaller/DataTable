local heroRes = "ui/hero/"
local treatRes = "ui/treat/"
local uiData = {
  csbFile = "ui/hero/BattleListLayer.csb",
  mask = true,
  widgets = {
    btnList = "btnList",
    content = "content",
    btnOther = "btnOther",
    exitBtn = "exitBtn",
    top_bar_angle = "top_bar_angle"
  }
}
local BattleListLayer = class("BattleListLayer", UIBase)

function BattleListLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function BattleListLayer:init(params)
  self.battle = params.battle
  self.battleCallback = params.callback
  self.num = params.num
  self.cancelCall = params.cancelCall
  self.battleType = params.battleType
  self.heroInfo = params.heroInfo
  self.specialHero = params.specialHero or {}
  self.cureCall = params.cureCall or function()
  end
  if UIHelper.isiPhoneX() then
    self.top_bar_angle:setPositionX(self.top_bar_angle:getPositionX() + UIHelper.getMoveXForX())
  end
  self.group = MRadioGroup:create()
  local btnSize = display.newSprite(heroRes .. "taocan_1.png"):getContentSize()
  local battleInfo = json.decode(game.role.battleInfo)
  local delay = 0.4
  for index = 1, game.role.teamMaxNum do
    local needShow = true
    if self.battle == "确定" or self.battle == "补给" then
      if index == params.index then
        self.selected = index
      else
        needShow = false
      end
    end
    if self.battle == "召唤" then
      if not game.role.formation[tostring(index)] or not game.role.formation[tostring(index)].list["1"] then
        needShow = false
      end
      local status = game.role:getFormationState(index)
      if status[2] or status[3] then
        needShow = false
      end
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
  self.exitBtn:setCallback(function()
    BackManager:pop()
  end)
end

function BattleListLayer:showData(params)
  local selected = params.selected or self.selected
  if selected then
    self.group:chooseByName(string.format("套餐%d", selected))
  end
  self:showFormation(selected)
end

function BattleListLayer:showFormation(index)
  self.content:removeAllChildren()
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
      local hpPercent
      if self.battleType == BattleType.Paradise then
        hpPercent = self.heroInfo[tostring(heroId)] or 1000
      elseif self.battleType == BattleType.MJ or self.battleType == BattleType.EJ or self.battleType == BattleType.Worldboss then
        hpPercent = 1000
      elseif self.battleType == BattleType.ShenYuan then
        hpPercent = 1000
      end
      card = TeamHeroCard.new({
        heroId = heroId,
        captain = slot == 1,
        hpPercent = hpPercent,
        isSpecial = self.specialHero[hero.type],
        detail = function()
          local layer = game:createView("hero.HeroDetailLayer", {heroId = heroId})
          self:hide()
          BackManager:push(function()
            self:show()
            layer:close()
            TopBar:show(TopBarType.full)
            self:showFormation(self.selected)
          end)
        end
      }):pos(xPos + (slot - 1) * interval, 10):addTo(self.content)
    else
      card = UIHelper.newImageView(heroRes .. "add_bg.png"):pos(xPos + (slot - 1) * interval, 10):addTo(self.content)
      display.newSprite(heroRes .. "show.png"):pos(78, 275):addTo(card)
    end
    self:cardAnimation(card, slot, xPos + (slot - 1) * interval)
  end
  self:InfoPanel(totalBattle, index)
end

function BattleListLayer:showDes(ma1, ma2)
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

function BattleListLayer:InfoPanel(value, index)
  local bg = UIHelper.newImageView(heroRes .. "info_bar_1.png"):pos(808, -40):name("info"):addTo(self.content)
  display.newTTFLabel({
    text = value,
    size = 30,
    color = UIHelper.hex2rgb("#ffffff")
  }):pos(bg:getContentSize().width / 2, 222):addTo(bg)
  if UIHelper.isiPhoneX() then
    bg:setPositionX(bg:getPositionX() + UIHelper.getMoveXForX())
  end
  if not self.firstShow then
    bg:setOpacity(0)
    bg:setCascadeOpacityEnabled(true)
    UIHelper.MoveToLeft({
      node = bg,
      delay = 0.4,
      time = 0.18
    })
    self.firstShow = 0
  end
  if self.battle == "召唤" then
    local fixbtn = UIHelper.extend(ccui.Button:create()):setCascadeOpacityEnabled(true)
    fixbtn:setImages("ui/global/", {
      "btn_common_green.png",
      "btn_common_green.png"
    })
    fixbtn:pos(bg:getContentSize().width / 2 + 3, 15):addTo(bg):name("battleListBtn")
    fixbtn:setTouchScale()
    UIHelper.newText({
      text = self.battle,
      size = 32,
      color = UIHelper.hex2rgb("#ffffff")
    }):enableOutline(UIHelper.hex2rgb("#07552a"), 1):pos(76, 34):addTo(fixbtn)
    fixbtn:setCallback(function()
      if game.role:getFormationState(self.selected)[1] then
        SysError(SYS_ERR_HERO_LOCKED_CURE_FIGHT)
        return
      end
      if (self.battleType == BattleType.PvE or self.battleType == BattleType.Moon or self.battleType == BattleType.Paradise) and game.role.autoStatus:getv(1, 1) == 0 then
        local formationData = game.role.formation[tostring(self.selected)] or {
          list = {}
        }
        for _, heroId in pairs(formationData.list or {}) do
          local hero = game.role.heros[heroId]
          if 0 >= hero.material1 or 0 >= hero.material2 then
            SysError(SYS_ERR_TEAM_HERO_MATERIAL_NOT_ENOUGH)
            return
          end
        end
      end
      if self.battleCallback(self.selected) then
        BackManager:pop()
      end
    end)
  end
  local btn1 = UIHelper.extend(ccui.Button:create())
  btn1:setImages(heroRes, {
    "btns_1.png",
    "btns_1.png",
    "btns_3.png"
  })
  btn1:pos(bg:getContentSize().width / 2 + 3, 155):addTo(bg)
  btn1:setString({text = "撤退", size = 22})
  btn1:setCallback(self.cancelCall)
  btn1:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#000000"), 1)
  local btn2 = UIHelper.extend(ccui.Button:create())
  btn2:setImages(heroRes, {
    "btns_2.png",
    "btns_2.png",
    "btns_3.png"
  })
  btn2:pos(bg:getContentSize().width / 2 + 3, 105):addTo(bg)
  btn2:setString({text = "补给", size = 22})
  btn2:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#000000"), 1)
  if self.battleType == BattleType.Paradise or self.battleType == BattleType.MJ or self.battleType == BattleType.EJ or self.battleType == BattleType.Worldboss or self.battleType == BattleType.ShenYuan or self.battleType == BattleType.ActCarbon then
    btn2:hide()
  end
  if self.battle == "召唤" then
    if self.battleType == BattleType.Paradise or self.battleType == BattleType.MJ or self.battleType == BattleType.EJ or self.battleType == BattleType.Worldboss or self.battleType == BattleType.ShenYuan or self.battleType == BattleType.ActCarbon then
      btn1:hide()
    else
      btn1:setString({
        text = "快速治疗",
        size = 22
      })
      btn1:setCallback(function()
        game:createView("treat.TreatQuickCostLayer", {
          index = index,
          callback = function(heroIds)
            if not next(heroIds) then
              return
            end
            game:sendData(actionCodes.Hero_quickTreatRpc, MsgPack.pack({ids = heroIds}))
            UIHelper.showWaiting()
            game:addResponseHandler(actionCodes.Hero_quickTreatRpc, function(event)
              UIHelper.removeWaiting()
              local result = MsgPack.unpack(event.data)
              local count = 1
              for slot, data in pairs(result) do
                game.role:dispatchEvent({
                  name = "hero_cure",
                  heroId = data.heroId
                })
              end
              SysError(SYS_ERR_TREAT_SUCCESS)
              self:showFormation(self.selected)
              self.cureCall(self.selected)
            end)
          end
        })
      end)
      btn2:setString({
        text = "战前补给",
        size = 22
      })
      btn2:setCallback(function()
        self.cancelCall(self.selected, self)
      end)
      btn1:setImages(heroRes, {
        "btns_2.png",
        "btns_2.png",
        "btns_3.png"
      })
      btn2:setImages(treatRes, {
        "anniu_2.png",
        "anniu_2.png"
      })
      btn2:loadTextureDisabled(heroRes .. "btns_3.png", btn2.texType)
      local formationData = game.role.formation[tostring(index)] or {
        list = {},
        pos = {}
      }
      local haveHurt = false
      for slot = 1, 5 do
        local heroId = formationData.list[tostring(slot)]
        if heroId then
          local hero = game.role.heros[heroId]
          if hero.hpPercent < 1000 then
            haveHurt = true
            break
          end
        end
      end
      if not haveHurt then
        btn1:setEnabled(false)
      end
    end
  end
  if self.battle == "补给" then
    if 1 > self.num then
      btn1:setEnabled(false)
      UIHelper.newImageView(heroRes .. "suo.png"):pos(23, 20):addTo(btn1)
    end
    btn2:setCallback(self.battleCallback)
  end
  if self.battle == "确定" then
    if 1 > self.num then
      btn1:setEnabled(false)
      UIHelper.newImageView(heroRes .. "suo.png"):pos(23, 20):addTo(btn1)
    end
    btn2:setEnabled(false)
    UIHelper.newImageView(heroRes .. "suo.png"):pos(23, 20):addTo(btn2)
  end
end

function BattleListLayer:cardAnimation(card, slot, xPos)
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

return BattleListLayer
