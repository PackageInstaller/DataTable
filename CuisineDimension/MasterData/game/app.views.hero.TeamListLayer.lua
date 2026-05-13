local SysErrCsv = require("csvdata.sys_codes")
local heroRes = "ui/hero/"
local uiData = {
  csbFile = "ui/hero/TeamListLayer.csb",
  mask = true,
  widgets = {
    up = "up",
    mainBg = "mainBg",
    btnsBg = "btnsBg",
    downBar = "downBar",
    btnBattle = "btnBattle",
    btnList = "btnsBg/btnList",
    ori = "touch/ori",
    touch = "touch",
    cardNode1 = "touch/card1",
    cardNode2 = "touch/card2",
    cardNode3 = "touch/card3",
    cardNode4 = "touch/card4",
    cardNode5 = "touch/card5"
  }
}
local TeamListLayer = class("TeamListLayer", UIBase)

function TeamListLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function TeamListLayer:init(params)
  if UIHelper.isiPhoneX() then
    UIHelper.fitForiPhoneX(self.mainBg)
    UIHelper.fitForiPhoneX(self.downBar)
    UIHelper.fitForiPhoneX(self.up, true)
    self.btnsBg:setPositionX(self.btnsBg:getPositionX() - 75)
    self.btnBattle:setPositionX(self.btnBattle:getPositionX() + 125)
  end
  self.topbarTitle = params.title or "食灵编队"
  self:showTopbar()
  TopBar:showAnimation(true)
  UIHelper.MoveToDown({
    node = self.up
  })
  self.btnBattle:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#722c02"), 1)
  self.btnBattle:setTouchScale()
  self:showBtns()
  self.backBtn = UIHelper.extend(ccui.Button:create())
  self.backBtn:setImages("ui/global/", {
    "btn_back_normal.png",
    "btn_back_selected.png"
  })
  self.backBtn:center(TopBar:getBackBtn()):addTo(TopBar:getBackBtn()):name("heroListBack")
  self.backBtn:setCallback(function(sender)
    local index = self:checkFormationCaptain()
    if index == 0 then
      BackManager:pop()
    else
      local content = SysErrCsv[SYS_ERR_TEAM_NO_LEADER].content
      MFlashMsg:show({
        text = string.format(content, index)
      })
    end
  end)
  self.backBtn:hide()
  self.mainBg:runAction(transition.sequence({
    cc.DelayTime:create(0.5),
    cc.CallFunc:create(function()
      self.backBtn:show()
    end)
  }))
  self.cardNodes = {}
  for i = 1, 5 do
    self.cardNodes[i] = self["cardNode" .. i]
  end
  self.touch:setCallbackTotal(function(sender)
    self:onTouchBegan(sender)
  end, function(sender)
    self:onTouchMoved(sender)
  end, function(sender)
    self:onTouchEnded(sender)
  end, function(sender)
    self:onTouchEnded(sender)
  end)
  self.btnBattle:hide()
end

function TeamListLayer:showBtns(select)
  self.btnList:removeAllChildren()
  if self.group then
    self.group = nil
  end
  self.group = MRadioGroup:create()
  local btnSize = display.newSprite(heroRes .. "taocan_1.png"):getContentSize()
  btnSize.height = btnSize.height + 4
  local delay = 0.4
  local temp = game.role.teamMaxNum
  for index = 1, globalCsv.teamNumMax do
    local viewNode = ccui.Widget:create()
    viewNode:setContentSize(btnSize):addTo(self.btnList)
    local btn = UIHelper.extend(ccui.Button:create())
    if index <= game.role.teamMaxNum then
      btn:setImages(heroRes, {
        "taocan_1.png",
        "taocan_2.png"
      })
      btn:setString({
        text = string.format("套餐%d", index),
        size = 22,
        color = UIHelper.hex2rgb("#ffffff")
      })
      btn:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#630c07"), 1)
      btn:setCallback(function()
        self:showFormation(index)
      end)
      btn:setName(string.format("list%d", index))
      btn:setGroup(self.group)
    else
      btn:setImages(heroRes, {
        "taocan_4.png",
        "taocan_4.png"
      })
      btn:setCallback(function()
        MDialog:double({
          title = "套餐扩展",
          text = "这个套餐尚未开启，是否前往商城扩展套餐？",
          okCallback = function()
            local layer = game:createView("shop.ShopLayer", {curType = 1, selected = 4})
            BackManager:push(function()
              layer:close()
              if temp ~= game.role.teamMaxNum then
                self:showBtns(index)
                self:showData({selected = index})
              end
            end)
            return true
          end,
          cancelCallback = function()
            return true
          end
        })
      end)
    end
    btn:center(viewNode):addTo(viewNode)
    UIHelper.MoveToRight({
      node = btn,
      delay = delay,
      time = 0.2
    })
    delay = delay + 0.1
  end
end

function TeamListLayer:showData(params)
  local selected = self.first or params.selected or 1
  self.group:chooseByName(string.format("list%d", selected))
  self:showFormation(selected)
end

function TeamListLayer:showFormation(index)
  self.move = false
  self.ori:removeAllChildren()
  local formationData = game.role.formation[tostring(index)] or {
    list = {},
    pos = {}
  }
  local singleFresh
  if self.selected and self.selected == index then
    singleFresh = {}
    for index = 1, 5 do
      local oldId = self.selectedFormat.list[tostring(index)] or 0
      local curId = formationData.list[tostring(index)] or 0
      if oldId ~= curId then
        singleFresh[index] = true
      end
    end
  end
  local xPos, interval = -45, 172
  self.card = {}
  self.nilCard = {}
  for slot = 1, 5 do
    local card
    local heroId = formationData.list[tostring(slot)]
    local node = self["cardNode" .. slot]
    if heroId then
      local hero = game.role.heros[heroId]
      card = TeamHeroCard.new({
        heroId = heroId,
        captain = slot == 1,
        callback = function()
          if not self:checkHeroState(heroId, true) then
            return
          end
          if self.move then
            return
          end
          self:addHero(index, slot, heroId)
        end,
        detail = function()
          local layer = game:createView("hero.HeroDetailLayer", {heroId = heroId})
          self.backBtn:hide()
          self:hide()
          BackManager:push(function()
            self:show()
            layer:close()
            card:reflashCard()
            local totalValue = game.role:getTotalBattleValue(self.selected)
            self.battleValue:setString(totalValue)
            self.backBtn:show()
            self:showTopbar()
          end)
        end,
        refresh = function()
          self:showInfo()
          local totalValue = game.role:getTotalBattleValue(self.selected)
          self.battleValue:setString(totalValue)
        end
      })
      card:pos(node:getPosition()):addTo(self.ori)
      self.card[slot] = {card = card, id = heroId}
    else
      card = UIHelper.newImageView(heroRes .. "add_bg.png"):pos(node:getPosition()):addTo(self.ori)
      UIHelper.newImageView(heroRes .. "add.png"):pos(78, 275):addTo(card)
      UIHelper.newText({
        text = "选择食灵",
        size = 16,
        color = UIHelper.hex2rgb("#bf9a77")
      }):pos(78, 236):addTo(card)
      card:setCallback(function()
        if formationData.lock and formationData.lock.carbon then
          SysError(SYS_ERR_HERO_LOCKED_FIGHT_TEAMMEMBER)
          return
        elseif formationData.lock and formationData.lock.entrust then
          SysError(SYS_ERR_HERO_LOCKED_CONSIGATION_TEAMMEMBER)
          return
        end
        self:addHero(index, slot)
      end)
      self.nilCard[slot] = {card = card}
    end
    card:name("heroFormat" .. slot)
    if not singleFresh or singleFresh[slot] then
      self:cardAnimation(card, slot)
    end
  end
  self.selected = index
  self:InfoPanel(index, formationData)
  self.selectedFormat = clone(formationData)
end

function TeamListLayer:addHero(index, slot, heroId)
  local orginIndex = index
  self.backBtn:hide()
  
  local function rule(_hero)
    return false
  end
  
  local layer = game:createView("hero.ChooseHeroLayer", {
    heroId = heroId,
    rule = rule,
    type = 6,
    format = orginIndex,
    callback = function(choose)
      if type(choose) == "table" then
        local list = {}
        for index, data in pairs(choose) do
          local hero = game.role.heros[data.id]
          if hero then
            list[tostring(data.slot)] = data.id
          end
        end
        game:sendData(actionCodes.Role_formationQuickRpc, MsgPack.pack({id = orginIndex, formation = list}))
        UIHelper.showWaiting()
        game:addResponseHandler(actionCodes.Role_formationQuickRpc, function(event)
          UIHelper.removeWaiting()
          self:showFormation(orginIndex)
          self:checkGuide()
        end)
      else
        if choose == 0 then
          index = 0
          slot = 0
          choose = heroId
        end
        if self:checkFormationSameHero(index, choose, slot, heroId) then
          SysError(SYS_ERR_TEAM_SAME_HERO)
          return true
        else
          game:sendData(actionCodes.Role_changeFormationRpc, MsgPack.pack({
            formationId = index,
            slot = slot,
            heroId = choose
          }))
          UIHelper.showWaiting()
          game:addResponseHandler(actionCodes.Role_changeFormationRpc, function(event)
            UIHelper.removeWaiting()
            self:showFormation(orginIndex)
            self:checkGuide()
          end)
        end
      end
    end
  })
  self:hide()
  BackManager:push(function()
    self:showTopbar()
    layer:close()
    self.backBtn:show()
    self:show()
  end)
end

function TeamListLayer:checkFormationCaptain()
  local function checkCaptain(formation)
    if formation and table.nums(formation.list or {}) ~= 0 then
      return formation.list[tostring(1)]
    else
      return true
    end
  end
  
  for index = 1, game.role.teamMaxNum do
    local formation = game.role.formation[tostring(index)]
    local result = checkCaptain(formation)
    if not result then
      return index
    end
  end
  return 0
end

function TeamListLayer:checkFormationSameHero(formId, choose, slot, heroId)
  if formId == 0 then
    return false
  end
  local hero = game.role.heros[choose]
  local formation = game.role.formation
  local formationData = formation[tostring(formId)] or {
    list = {},
    lock = {},
    pos = {}
  }
  for key, id in pairs(formationData.list) do
    local tempHero = game.role.heros[id]
    if tempHero.type == hero.type and key ~= tostring(slot) and hero.formation ~= formId then
      return true
    end
  end
  return false
end

function TeamListLayer:InfoPanel(index, formation)
  local bg = display.newScale9Sprite(heroRes .. "info_bar_1.png", 0, 0, cc.size(136, 354)):pos(936, 225):name("info"):addTo(self.ori)
  if UIHelper.isiPhoneX() then
    bg:setPositionX(bg:getPositionX() + 125)
  end
  local totalValue = game.role:getTotalBattleValue(self.selected)
  self.battleValue = display.newTTFLabel({
    text = totalValue,
    size = 30,
    color = UIHelper.hex2rgb("#ffffff")
  }):pos(bg:getContentSize().width / 2, 270):addTo(bg)
  if not self.fistShow then
    bg:setOpacity(0)
    bg:setCascadeOpacityEnabled(true)
    UIHelper.MoveToLeft({
      node = bg,
      delay = 0.4,
      time = 0.18
    })
    self.fistShow = 0
  end
  local fixbtn = UIHelper.extend(ccui.Button:create())
  fixbtn:setImages("ui/global/", {
    "btn_common_green.png",
    "btn_common_green.png"
  })
  fixbtn:pos(bg:getContentSize().width / 2 + 9, 15):addTo(bg):name("fixBtn")
  fixbtn:setTouchScale()
  fixbtn:setMusicId(1005)
  display.newTTFLabel({
    text = "装盘修改",
    size = 22,
    color = UIHelper.hex2rgb("#ffffff")
  }):enableOutline(UIHelper.hex2rgb("#07552a"), 1):center(fixbtn):addTo(fixbtn)
  fixbtn:setCallback(function()
    if not formation or table.nums(formation.list) == 0 then
      SysError(SYS_ERR_TEAM_CURRENT_NO_HERO)
      return
    end
    if not formation.list[tostring(1)] then
      SysError(SYS_ERR_TEAM_CURRENT_NO_LEADER)
      return
    end
    if game.role:getFormationState(index)[2] then
      SysError(SYS_ERR_HERO_LOCKED_FIGHT_FORMATION)
      return
    end
    self.backBtn:hide()
    self:hide()
    local layer = game:createView("hero.FormationPresetLayer", {
      index = self.selected,
      skip = true
    })
    BackManager:push(function()
      layer:close()
      self:show()
      self.backBtn:show()
      self:showTopbar()
      self:showData({
        selected = self.selected
      })
      self:checkGuide()
    end)
  end)
  local selected = 0
  local group = MRadioGroup:create()
  local btns = {
    "info_format",
    "info_equip",
    "info_attr",
    "info_sauce"
  }
  local titles = {
    "装盘预览",
    "装备预览",
    "属性预览",
    "酱料预览"
  }
  local yPos = 225
  for index, btnName in ipairs(btns) do
    local btn = UIHelper.extend(ccui.Button:create())
    btn:setImages(heroRes, {"btn_3.png", "btn_2.png"})
    btn:setString({
      text = titles[index],
      size = 18
    })
    btn:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#4c3605"), 1)
    btn:pos(bg:getContentSize().width / 2 + 18, yPos):addTo(bg):name(btnName)
    btn:setGroup(group)
    btn:setCallback(function()
      if not formation or table.nums(formation.list) == 0 then
        SysError(SYS_ERR_TEAM_CURRENT_NO_HERO)
        return
      end
      if selected == index then
        group:unchooseByName(btns[selected])
        self:showInfo(0)
        selected = 0
        return
      end
      selected = index
      group:chooseByName(btns[selected])
      self:showInfo(selected)
      btn:setTouchEnabled(true)
    end)
    yPos = yPos - 50
  end
end

function TeamListLayer:showInfo(index)
  for _, data in pairs(self.card) do
    data.card:showInfo(index)
  end
end

function TeamListLayer:cardAnimation(card, slot)
  card:hide()
  local mask = display.newSprite(heroRes .. "card_mask.png"):pos(self["cardNode" .. slot]:getPosition()):addTo(self.ori)
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

function TeamListLayer:onTouchBegan(sender)
  local pos = sender:getBeginPos()
  self.beganPos = pos
  if self.move then
    return
  end
  self.beganCard, self.beganSlot = self:findBeganCard(pos)
  if self.beganCard then
    self.beganCard:setLocalZOrder(20)
  end
  return true
end

function TeamListLayer:onTouchMoved(sender)
  if not self.beganCard then
    return
  end
  if not self.beganPos then
    return
  end
  local pos = sender:getMovePos()
  local oriX, oriY = self.beganPos.x, self.beganPos.y
  local size = sender:getContentSize()
  if math.abs(oriX - pos.x) > 15 or math.abs(oriY - pos.y) > 15 then
    self.move = true
  end
  if not self.move then
    return
  end
  if pos.x < 80 then
    pos.x = 80
  end
  if pos.x > size.width - 80 then
    pos.x = size.width - 80
  end
  if pos.y < 230 then
    pos.y = 230
  end
  if pos.y > size.height - 230 then
    pos.y = size.height - 230
  end
  self.beganCard:pos(pos.x, pos.y)
end

function TeamListLayer:onTouchEnded(sender)
  if not self.beganCard then
    return
  end
  local pos = sender:getEndPos()
  local endCard, endSlot = self:findEndCard(pos)
  if not endCard or self.beganCard == endCard then
    local node = self.cardNodes[self.beganSlot]
    self.beganCard:setLocalZOrder(self.beganSlot)
    self.beganCard:runAction(transition.sequence({
      cc.MoveTo:create(0.2, cc.p(node:getPosition())),
      cc.CallFunc:create(function()
        self.move = false
      end)
    }))
    self.beganSlot = nil
    self.beganCard = nil
    return
  end
  local beginSlot = self.beganSlot
  local node1 = self.cardNodes[self.beganSlot]
  local node2 = self.cardNodes[endSlot]
  self.beganCard:pos(node2:getPosition())
  self.beganCard:setLocalZOrder(endSlot)
  endCard:setLocalZOrder(10)
  endCard:runAction(transition.sequence({
    cc.MoveTo:create(0.15, cc.p(node1:getPosition())),
    cc.CallFunc:create(function()
      endCard:setLocalZOrder(beginSlot)
    end)
  }))
  local heroId = self.card[self.beganSlot].id
  self.beganCard = nil
  self.beganSlot = nil
  game:sendData(actionCodes.Role_changeFormationRpc, MsgPack.pack({
    formationId = self.selected,
    slot = endSlot,
    heroId = heroId
  }))
  UIHelper.showWaiting()
  game:addResponseHandler(actionCodes.Role_changeFormationRpc, function(event)
    UIHelper.removeWaiting()
    self:runAction(transition.sequence({
      cc.DelayTime:create(0.1),
      cc.CallFunc:create(function()
        self:showFormation(self.selected)
      end)
    }))
  end)
end

function TeamListLayer:findBeganCard(pos)
  for index, node in pairs(self.cardNodes) do
    local x, y = node:getPosition()
    if math.abs(pos.x - x) < 65 and math.abs(pos.y - y) < 200 then
      local data = self.card[index] or {}
      if data.card and self:checkHeroState(data.id) then
        return data.card, index
      end
    end
  end
  return
end

function TeamListLayer:findEndCard(pos)
  for index, node in pairs(self.cardNodes) do
    local x, y = node:getPosition()
    if math.abs(pos.x - x) < 85 and math.abs(pos.y - y) < 100 then
      local data = self.card[index] or self.nilCard[index]
      if data.card then
        return data.card, index
      end
    end
  end
  return
end

function TeamListLayer:checkHeroState(heroId, hideError)
  hideError = hideError or false
  local hero = game.role.heros[heroId]
  if not hero then
    return
  end
  local result = hero:getState()
  if result[2] then
    if not hideError then
      SysError(SYS_ERR_HERO_LOCKED_FIGHT_TEAMMEMBER)
    end
    return
  elseif result[3] then
    if not hideError then
      SysError(SYS_ERR_HERO_LOCKED_CONSIGATION_TEAMMEMBER)
    end
    return
  end
  return true
end

function TeamListLayer:checkGuide()
  NewGuideLayer.new({step = 10})
  if game.role.majorGuideStep == 15 then
    game.role.minorGuideStep = 6
    NewGuideLayer.new({
      step = 15,
      callback = function()
        game:enterScene("MainScene")
      end
    })
  end
end

function TeamListLayer:onExit()
  if self.backBtn and not tolua.isnull(self.backBtn) then
    self.backBtn:removeSelf()
  end
end

function TeamListLayer:showTopbar()
  TopBar:show(TopBarType.full, self.topbarTitle)
end

return TeamListLayer
