local formationCsv = require("csvdata.formation")
local globalRes = "ui/global/"
local presetRes = "ui/hero/preset/"
local uiData = {
  csbFile = "ui/hero/FormationPresetLayer.csb",
  widgets = {
    touchLayer = "touchLayer",
    formatNode = "touchLayer/formatNode",
    pos1 = "pos1",
    pos2 = "pos2",
    pos3 = "pos3",
    pos4 = "pos4",
    pos5 = "pos5",
    pos6 = "pos6",
    pos7 = "pos7",
    pos8 = "pos8",
    pos9 = "pos9",
    pos10 = "pos10",
    pos11 = "pos11",
    pos12 = "pos12",
    pos13 = "pos13",
    nameBg = "nameBg",
    heroNode = "heroNode",
    content = "effectBg/content",
    okBtn = "angle/okBtn",
    angle = "angle",
    center = "center",
    downBar = "downBar"
  }
}
local FormationPresetLayer = class("FormationPresetLayer", UIBase)

function FormationPresetLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function FormationPresetLayer:init(params)
  TopBar:show(TopBarType.full, "装盘")
  if UIHelper.isiPhoneX() then
    UIHelper.fitForiPhoneX(self.center)
    UIHelper.fitForiPhoneX(self.downBar)
    self.angle:setPositionX(self.angle:getPositionX() + UIHelper.getMoveXForX())
  end
  local formationData
  if params.battleType == "tower" then
    formationData = json.decode(game.role.towerData.formatInfo)
    formationData.list = formationData.list or {}
    formationData.pos = formationData.pos or {}
  elseif params.battleType == "pvp" then
    formationData = json.decode(game.role.pvpInfo.formatInfo)
    formationData.list = formationData.list or {}
    formationData.pos = formationData.pos or {}
  elseif params.battleType == "lty" then
    formationData = json.decode(game.role.ltyFormatInfo)
    formationData.list = formationData.list or {}
    formationData.pos = formationData.pos or {}
  elseif params.battleType == "union" then
    formationData = game.role.activityStatus["89"].formatInfo
    formationData.list = formationData.list or {}
    formationData.pos = formationData.pos or {}
  elseif params.battleType == "newWorldBoss" then
    self.bossIdx = params.bossIdx or 1
    formationData = game.role.activityStatus["107"][tostring(self.bossIdx)].formation
    formationData.list = formationData.list or {}
    formationData.pos = formationData.pos or {}
  else
    self.formationId = params.index
    formationData = game.role.formation[tostring(params.index)] or {
      list = {},
      pos = {}
    }
  end
  self.battleType = params.battleType
  self.listData = formationData.list
  self.posData = formationData.pos
  self.heros = {}
  for index, heroId in pairs(self.listData) do
    self.heros[heroId] = {
      pos = self.posData[index]
    }
    if self.posData[index] == 1 then
      self:showInfo(heroId)
    end
  end
  self:uiLayout()
end

function FormationPresetLayer:uiLayout()
  display.newTTFLabel({
    text = "保存",
    size = 24,
    color = UIHelper.hex2rgb("#ffffff")
  }):enableOutline(UIHelper.hex2rgb("#6d2b15"), 1):pos(57, 59):addTo(self.okBtn)
  self.okBtn:setTouchScale()
  self.okBtn:setMusicId(1015)
  self.okBtn:setCallback(function()
    self:sendRequest()
  end)
  for index = 1, 13 do
    local node = self["pos" .. index]
    FormatHead.new({}):addTo(node)
  end
  for heroId, data in pairs(self.heros) do
    local hero = game.role.heros[heroId]
    local node = self["pos" .. data.pos]
    local head = FormatHead.new({
      type = hero:getDressType(),
      quality = hero.quality
    }):pos(node:getPosition()):addTo(self.formatNode)
    local titleBg = display.newSprite(string.format(globalRes .. "des_bg_%d.png", hero.quality)):pos(29, 69):scale(0.7):addTo(head)
    display.newTTFLabel({
      text = TitleData[hero.unit.profession],
      size = 18,
      color = UIHelper.hex2rgb("#ffffff")
    }):enableOutline(UIHelper.hex2rgb("#000000"), 1):pos(11, 24):addTo(titleBg)
    data.head = head
  end
  self.touchLayer:setCallbackTotal(function(sender)
    self:onTouchBegan(sender)
  end, function(sender)
    self:onTouchMoved(sender)
  end, function(sender)
    self:onTouchEnded(sender)
  end, function(sender)
    self:onTouchEnded(sender)
  end)
end

function FormationPresetLayer:showData(params)
  params = params or {}
  self.posIds = {}
  self.tempheros = {}
  for heroId, data in pairs(self.heros) do
    self.posIds[data.pos] = heroId
    local hero = game.role.heros[heroId]
    self.tempheros[heroId] = {
      type = hero:getProperty("type"),
      fieldLevel = hero.fieldLevel,
      formationId = hero:getFormationId()
    }
  end
  self:showEffect(params.skip)
  if not self.guideNode and game.role.majorGuideStep == 10 then
    self.guideNode = display.newNode():addTo(display.getRunningScene(), NEW_GUIDE_LAYER_ORDER)
    local spine = UIHelper.createCommonSpine({
      res = "ui/global/zx_jt"
    })
    spine:pos(870, 285):addTo(self.guideNode)
    if UIHelper.isiPhoneX() then
      spine:setPositionX(spine:getPositionX() + UIHelper.getMoveXForX())
    end
    spine:setAnimation(0, "special", true)
    local scaleX = 1
    if UIHelper.isiPhoneX() then
      scaleX = scaleX * UIHelper.getScaleForX()
    end
    local mask1 = UIHelper.newMask({
      size = cc.size(display.width, 90)
    }):anch(0, 1):pos(0, display.height):addTo(self.guideNode):setTouchEnabled(true)
    local mask2 = UIHelper.newMask({
      size = cc.size(display.width, 120)
    }):anch(0, 0):pos(0, 0):addTo(self.guideNode):setTouchEnabled(true)
    mask1:setScaleX(scaleX)
    mask2:setScaleX(scaleX)
  end
end

function FormationPresetLayer:onTouchBegan(sender)
  local pos = sender:getBeginPos()
  self.touchId = nil
  local index = self:findIndex(pos)
  local heroId = self:findHero(index)
  if heroId then
    local data = self.heros[heroId]
    self.touchHead = data.head
    self.touchId = heroId
    self.touchHead:scale(1.1)
    self.touchHead:zorder(10)
    self:showInfo(heroId)
  end
end

function FormationPresetLayer:onTouchMoved(sender)
  if not self.touchId then
    return
  end
  local pos = sender:getMovePos()
  local size = sender:getContentSize()
  if pos.x < 0 then
    pos.x = 0
  end
  if pos.x > size.width then
    pos.x = size.width
  end
  if 0 > pos.y then
    pos.y = 0
  end
  if pos.y > size.height then
    pos.y = size.height
  end
  self.touchHead:pos(pos.x, pos.y)
end

function FormationPresetLayer:onTouchEnded(sender)
  if not self.touchId then
    return
  end
  local pos = sender:getEndPos()
  local curData = self.heros[self.touchId]
  local curPos = curData.pos
  local index = self:findIndex(pos)
  local targetPos = index
  
  local function reset()
    local node = self["pos" .. curPos]
    self.touchHead:runAction(cc.MoveTo:create(0.2, cc.p(node:getPosition())))
    self.touchHead:zorder(0)
  end
  
  if not index then
    reset()
    return
  end
  local targetId = self:findHero(index)
  if curPos == 1 and not targetId then
    SysError(SYS_ERR_TEAM_FORMATION_CENTER_SET)
    reset()
    return
  end
  if targetId then
    local targetData = self.heros[targetId]
    local targetPos = targetData.pos
    local node = self["pos" .. curPos]
    targetData.head:pos(node:getPosition())
    targetData.pos = curPos
  end
  local node = self["pos" .. targetPos]
  curData.head:pos(node:getPosition())
  curData.pos = targetPos
  self:showData()
  self:showFlash(self.touchId)
  self.touchHead:scale(1)
  self.touchHead:zorder(0)
  if curPos ~= targetPos and targetId then
    if self.guideNode then
      self.guideNode:removeAllChildren()
    end
    NewGuideLayer.new({step = 10})
  end
end

function FormationPresetLayer:findHero(index)
  for heroId, data in pairs(self.heros) do
    if data.pos == index then
      return heroId
    end
  end
end

function FormationPresetLayer:findIndex(pos)
  for index = 1, 13 do
    local node = self["pos" .. index]
    local x, y = node:getPosition()
    if math.abs(x - pos.x) < 50 and 50 > math.abs(y - pos.y) then
      return index
    end
  end
end

function FormationPresetLayer:showInfo(heroId)
  if self.oriId == heroId then
    return
  end
  self.oriId = heroId
  self.heroNode:removeAllChildren()
  self.content:removeAllChildren()
  self.nameBg:removeAllChildren()
  local hero = game.role.heros[heroId]
  local index = self.heros[heroId].pos
  display.newTTFLabel({
    text = hero:getName(),
    size = 20,
    color = UIHelper.hex2rgb("#3e1413")
  }):pos(110, 22):addTo(self.nameBg)
  local proTag = UIHelper.getProfessionTag(hero.unit.profession, hero.quality, 16, hero:showTreeTag()):pos(15, 22):addTo(self.nameBg)
  local forData = formationCsv[hero:getFormationId()][hero.fieldLevel] or {}
  local forName = MRichText.new({
    text = forData.name,
    size = 18,
    color = UIHelper.hex2rgb("#96dd07"),
    maxWidth = 100
  }):anch(0.5, 1):pos(53, 1):addTo(self.content)
  local forName = MRichText.new({
    text = forData.desc,
    color = UIHelper.hex2rgb("#96dd07"),
    size = 18,
    maxWidth = 194
  }):anch(0.5, 1):pos(218, 10):addTo(self.content)
  local forName = MRichText.new({
    text = forData.conDesc,
    size = 18,
    color = UIHelper.hex2rgb("#96dd07"),
    maxWidth = 100
  }):anch(0.5, 1):pos(380, 1):addTo(self.content)
  HeroBigCard.new({
    heroId = heroId,
    quality = hero.quality
  }):addTo(self.heroNode)
end

function FormationPresetLayer:sendRequest()
  local format = {}
  for index = 1, 5 do
    local heroId = self.listData[tostring(index)]
    local pos = heroId and self.heros[heroId].pos or 0
    format[index] = pos
  end
  if self.battleType == "tower" then
    game:sendData(actionCodes.Tower_formationPosRpc, MsgPack.pack({
      formationId = 1,
      pos = table.concat(format, "=")
    }))
    UIHelper.showWaiting()
    game:addResponseHandler(actionCodes.Tower_formationPosRpc, function(event)
      UIHelper.removeWaiting()
      SysError(SYS_ERR_TEAM_FORMATION_SAVE_SUCCESS)
      BackManager:pop()
    end)
  elseif self.battleType == "pvp" then
    game:sendData(actionCodes.Pvp_formationPosRpc, MsgPack.pack({
      formationId = 1,
      pos = table.concat(format, "=")
    }))
    UIHelper.showWaiting()
    game:addResponseHandler(actionCodes.Pvp_formationPosRpc, function(event)
      UIHelper.removeWaiting()
      SysError(SYS_ERR_TEAM_FORMATION_SAVE_SUCCESS)
      BackManager:pop()
    end)
  elseif self.battleType == "lty" then
    game:sendData(actionCodes.Activity_ltyFormationPosRpc, MsgPack.pack({
      formationId = 1,
      pos = table.concat(format, "=")
    }))
    UIHelper.showWaiting()
    game:addResponseHandler(actionCodes.Activity_ltyFormationPosRpc, function(event)
      UIHelper.removeWaiting()
      SysError(SYS_ERR_TEAM_FORMATION_SAVE_SUCCESS)
      BackManager:pop()
    end)
  elseif self.battleType == "union" then
    game:sendData(actionCodes.Activity_unionBattleFormatPosRpc, MsgPack.pack({
      formationId = 1,
      pos = table.concat(format, "=")
    }))
    UIHelper.showWaiting()
    game:addResponseHandler(actionCodes.Activity_unionBattleFormatPosRpc, function(event)
      UIHelper.removeWaiting()
      SysError(SYS_ERR_TEAM_FORMATION_SAVE_SUCCESS)
      BackManager:pop()
    end)
  elseif self.battleType == "newWorldBoss" then
    game:sendData(actionCodes.Activity_newWorldBossFormatPosRpc, MsgPack.pack({
      bossIdx = self.bossIdx,
      pos = table.concat(format, "=")
    }))
    UIHelper.showWaiting()
    game:addResponseHandler(actionCodes.Activity_newWorldBossFormatPosRpc, function(event)
      UIHelper.removeWaiting()
      SysError(SYS_ERR_TEAM_FORMATION_SAVE_SUCCESS)
      BackManager:pop()
    end)
  else
    game:sendData(actionCodes.Role_formationPosRpc, MsgPack.pack({
      formationId = self.formationId,
      pos = table.concat(format, "=")
    }))
    UIHelper.showWaiting()
    game:addResponseHandler(actionCodes.Role_formationPosRpc, function(event)
      UIHelper.removeWaiting()
      SysError(SYS_ERR_TEAM_FORMATION_SAVE_SUCCESS)
      BackManager:pop()
    end)
  end
end

function FormationPresetLayer:showEffect(skip)
  local play = false
  local result = FormatLogic.getActiveStatus(self.posIds, self.tempheros)
  for heroId, status in pairs(result) do
    local heroData = self.heros[heroId]
    local head = heroData.head
    if not status.active then
      head:removeChildByTag(1)
    else
      play = true
      if not head:getChildByTag(1) then
        local yellow = UIHelper.loadAnimation("ui/hero/preset/", "yellow", 30, 12)
        yellow.sprite:center(head):addTo(head, nil, 1)
        yellow.sprite:runAction(cc.RepeatForever:create(cc.Animate:create(yellow.animation)))
      end
    end
  end
  if play and not skip then
    game:playMusic(1028)
  end
end

function FormationPresetLayer:showFlash(heroId)
  local result = FormatLogic.getActiveStatus(self.posIds, self.tempheros)
  local stauts = result[heroId]
  if stauts and stauts.active then
    local hero = self.tempheros[heroId]
    local formatSet = formationCsv[hero.formationId][hero.fieldLevel]
    for _, data in pairs(self.heros) do
      local blue = data.head:getChildByTag(2)
      if blue then
        blue:removeSelf()
      end
    end
    for _, effect in ipairs(formatSet.effectValue:toTableArray(" ")) do
      local pro = tonumber(effect[2])
      for _heroId, data in pairs(self.heros) do
        local _hero = game.role.heros[_heroId]
        if _hero.unit.profession == pro then
          local blue = UIHelper.loadAnimation("ui/hero/preset/", "blue", 24, 12)
          blue.sprite:pos(50, 57):addTo(data.head, nil, 2)
          blue.sprite:setBlendFunc(cc.blendFunc(gl.ONE_MINUS_DST_COLOR, gl.ONE))
          blue.sprite:runAction(cc.Animate:create(blue.animation))
        end
      end
    end
  end
end

return FormationPresetLayer
