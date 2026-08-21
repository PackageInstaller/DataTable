local SysErrCsv = require("csvdata.sys_codes")
local heroRes = "ui/hero/"
local actId = "107"
local bossIdx = 1
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
local NewWorldBossFormLayer = class("NewWorldBossFormLayer", UIBase)

function NewWorldBossFormLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function NewWorldBossFormLayer:init(params)
  if UIHelper.isiPhoneX() then
    UIHelper.fitForiPhoneX(self.mainBg)
    UIHelper.fitForiPhoneX(self.downBar)
    UIHelper.fitForiPhoneX(self.up, true)
    self.btnsBg:setPositionX(self.btnsBg:getPositionX() - 75)
    self.btnBattle:setPositionX(self.btnBattle:getPositionX() + 125)
  end
  self.callback = params.callback or nil
  self.heroList = {}
  self.bossIdx = params.bossIdx or 1
  self.formatInfo = game.role.activityStatus[actId][tostring(self.bossIdx)].formation or {
    list = {},
    pos = {}
  }
  self.formatInfo.list = self.formatInfo.list or {}
  self.formatInfo.pos = self.formatInfo.pos or {}
  self.topbarTitle = params.title or "出战编队"
  self:showTopbar()
  TopBar:showAnimation(true)
  UIHelper.MoveToDown({
    node = self.up
  })
  self.btnBattle:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#722c02"), 1)
  self.btnBattle:setTouchScale()
  self.backBtn = UIHelper.extend(ccui.Button:create())
  self.backBtn:setImages("ui/global/", {
    "btn_back_normal.png",
    "btn_back_selected.png"
  })
  self.backBtn:center(TopBar:getBackBtn()):addTo(TopBar:getBackBtn()):name("heroListBack")
  self.backBtn:setCallback(function(sender)
    if self.callback then
      self.callback(self.formatInfo)
    end
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

function NewWorldBossFormLayer:showData(params)
  self:showFormation(selected)
end

function NewWorldBossFormLayer:showFormation(index)
  index = 1
  self.move = false
  self.ori:removeAllChildren()
  local formationData = self.formatInfo
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

function NewWorldBossFormLayer:addHero(index, slot, heroId)
  local orginIndex = index
  self.backBtn:hide()
  
  local function rule(_hero)
    for _, hero_id in pairs(self.formatInfo.list) do
      local hero = game.role.heros[hero_id]
      if hero and hero.type == _hero.type then
        return true
      end
    end
    local targetIndex = 0
    if self.bossIdx == 1 then
      targetIndex = 2
    elseif self.bossIdx == 2 then
      targetIndex = 1
    end
    local targetFormatInfo = game.role.activityStatus[actId][tostring(targetIndex)].formation or {
      list = {},
      pos = {}
    }
    for _, hero_id in pairs(targetFormatInfo.list) do
      local hero = game.role.heros[hero_id]
      if hero and hero.id == _hero.id then
        return true
      end
    end
    local targetHeros = game.role.activityStatus[actId][tostring(targetIndex)].heros or {}
    for hero_id, _ in pairs(targetHeros) do
      local hero = game.role.heros[tonumber(hero_id)]
      if hero and hero.id == _hero.id then
        return true
      end
    end
    return false
  end
  
  local layer = game:createView("worldboss.NewWorldBossSelectHeroLayer", {
    heroId = heroId,
    rule = rule,
    max = 5,
    choosed = self.heroList,
    callback = function(choose)
      if type(choose) == "table" then
        local list = {}
        for index, data in pairs(choose) do
          local hero = game.role.heros[data.id]
          if hero then
            list[tostring(data.slot)] = data.id
          end
        end
        game:sendData(actionCodes.Activity_newWorldBossFormatQuickRpc, MsgPack.pack({
          formation = list,
          bossIdx = self.bossIdx
        }))
        UIHelper.showWaiting()
        game:addResponseHandler(actionCodes.Activity_newWorldBossFormatQuickRpc, function(event)
          UIHelper.removeWaiting()
          self.formatInfo = game.role.activityStatus[actId][tostring(self.bossIdx)].formation
          self:showFormation(self.selected)
        end)
      else
        game:sendData(actionCodes.Activity_newWorldBossChangeFormatRpc, MsgPack.pack({
          bossIdx = self.bossIdx,
          slot = slot,
          heroId = choose
        }))
        UIHelper.showWaiting()
        game:addResponseHandler(actionCodes.Activity_newWorldBossChangeFormatRpc, function(event)
          UIHelper.removeWaiting()
          self.formatInfo = game.role.activityStatus[actId][tostring(self.bossIdx)].formation
          self:showFormation(self.selected)
        end)
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

function NewWorldBossFormLayer:checkFormationCaptain()
  local function checkCaptain(formation)
    if formation and table.nums(formation.list or {}) ~= 0 then
      return formation.list[tostring(1)]
    else
      return true
    end
  end
  
  local formation = self.formatInfo
  local result = checkCaptain(formation)
  if not result then
    return 1
  end
  return 0
end

function NewWorldBossFormLayer:InfoPanel(index, formation)
  local fixbtn = UIHelper.extend(ccui.Button:create())
  fixbtn:setImages("ui/global/", {
    "btn_common_green.png",
    "btn_common_green.png"
  })
  fixbtn:pos(1070, 65):addTo(self):name("fixBtn")
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
      skip = true,
      bossIdx = self.bossIdx,
      battleType = "newWorldBoss"
    })
    BackManager:push(function()
      layer:close()
      self:show()
      self.backBtn:show()
      self:showTopbar()
      self:showData({
        selected = self.selected
      })
    end)
  end)
end

function NewWorldBossFormLayer:showInfo(index)
  for _, data in pairs(self.card) do
    data.card:showInfo(index)
  end
end

function NewWorldBossFormLayer:cardAnimation(card, slot)
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

function NewWorldBossFormLayer:onTouchBegan(sender)
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

function NewWorldBossFormLayer:onTouchMoved(sender)
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

function NewWorldBossFormLayer:onTouchEnded(sender)
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
  game:sendData(actionCodes.Activity_newWorldBossChangeFormatRpc, MsgPack.pack({
    bossIdx = self.bossIdx,
    slot = endSlot,
    heroId = heroId
  }))
  UIHelper.showWaiting()
  game:addResponseHandler(actionCodes.Activity_newWorldBossChangeFormatRpc, function(event)
    UIHelper.removeWaiting()
    self.formatInfo = game.role.activityStatus[actId][tostring(self.bossIdx)].formation
    self:runAction(transition.sequence({
      cc.DelayTime:create(0.1),
      cc.CallFunc:create(function()
        self:showFormation(self.selected)
      end)
    }))
  end)
end

function NewWorldBossFormLayer:findBeganCard(pos)
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

function NewWorldBossFormLayer:findEndCard(pos)
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

function NewWorldBossFormLayer:checkHeroState(heroId, hideError)
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

function NewWorldBossFormLayer:onExit()
  if self.backBtn and not tolua.isnull(self.backBtn) then
    self.backBtn:removeSelf()
  end
end

function NewWorldBossFormLayer:showTopbar()
  TopBar:show(TopBarType.full, self.topbarTitle)
end

return NewWorldBossFormLayer
