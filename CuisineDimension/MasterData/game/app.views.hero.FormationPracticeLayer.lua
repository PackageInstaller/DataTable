local FormationCsv = require("csvdata.formation")
local UnitCsv = require("csvdata.unit")
local SkillSpecialCsv = require("csvdata.skill_special")
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
    effectBg = "effectBg",
    content = "effectBg/content",
    okBtn = "angle/okBtn",
    angle = "angle",
    center = "center",
    downBar = "downBar"
  }
}
local FormationPracticeLayer = class("FormationPracticeLayer", UIBase)

function FormationPracticeLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function FormationPracticeLayer:init(params)
  TopBar:show(TopBarType.full, "装盘训练")
  self.selectId = 1
  self.goal = (params.goal or ""):toTableArray()
  local height = 30
  for _, data in ipairs(self.goal) do
    if tonumber(data[2]) ~= 1 then
      height = height + 60
    else
      height = height + 30
    end
  end
  self.taskBg = display.newScale9Sprite(presetRes .. "task_bg.png", 0, 0, cc.size(310, height)):anch(0, 1):pos(10, 560):addTo(self)
  if UIHelper.isiPhoneX() then
    UIHelper.fitForiPhoneX(self.center)
    UIHelper.fitForiPhoneX(self.downBar)
    self.angle:setPositionX(self.angle:getPositionX() + UIHelper.getMoveXForX())
    self.taskBg:setPositionX(self.taskBg:getPositionX() - 80)
  end
  self.downBar:hide()
  self.okBtn:hide()
  self.sendBtn = UIHelper.extend(ccui.Button:create())
  self.sendBtn:setImages(presetRes, {
    "btn_send.png",
    "btn_send.png"
  })
  self.sendBtn:pos(50, 40):addTo(self.angle)
  self.sendBtn:setTouchScale()
  self.sendBtn:setCallback(function()
    self:sendRequest(params.group, params.id)
  end)
  self.cond = display.newTTFLabel({text = "", size = 16}):anch(0, 0.5):pos(265, 100):addTo(self.effectBg)
  self:createHeros(params.types)
  self:uiLayout()
  if #self.allHeros > 5 then
    local btnChange = UIHelper.extend(ccui.Button:create())
    btnChange:setImages(presetRes, {
      "btn_change.png",
      "btn_change.png"
    })
    btnChange:pos(-65, 40):addTo(self.angle)
    btnChange:setTouchScale()
    btnChange:setCallback(function()
      self:changeHero()
    end)
    display.newTTFLabel({text = "更换", size = 22}):enableOutline(UIHelper.hex2rgb("#a57219"), 1):pos(31, 35):addTo(btnChange)
  end
end

function FormationPracticeLayer:changeHero()
  local function rule(hero)
    for heroId, _ in pairs(self.heros) do
      if heroId == hero.id then
        return true
      end
    end
    return false
  end
  
  local layer = game:createView("hero.ChooseHeroLayer", {
    rule = rule,
    skipDetail = true,
    heros = self.allHeros,
    callback = function(choose)
      if not choose or not self.allHeros[choose] then
        return
      end
      for index, heroId in pairs(self.listData) do
        if heroId == self.selectId then
          self.listData[index] = choose
        end
      end
      self.selectId = choose
      self:uiLayout()
      self:showData()
    end
  })
  BackManager:push(function()
    layer:close()
    TopBar:show(TopBarType.full, "装盘训练")
  end)
end

function FormationPracticeLayer:createHeros(types)
  self.listData = {}
  self.posData = {}
  self.allHeros = {}
  for id, heroType in ipairs(types:toArray("=", true)) do
    self.allHeros[id] = require("app.models.Hero").new({
      id = id,
      type = heroType,
      exp = 0,
      level = 1,
      quality = 0,
      strengthLevel = 0,
      strengthExp = 0,
      love = 0,
      fieldLevel = 1,
      lock = 0,
      formation = 0,
      hpPercent = 1000,
      material1 = 0,
      material2 = 0,
      battleValue = 0,
      loveBreak = 0,
      equips = "",
      dress = 0,
      skillLevel = 0,
      name = "",
      marryTime = 0
    })
    if id <= 5 then
      self.listData[tostring(id)] = id
      self.posData[tostring(id)] = id
    end
  end
end

function FormationPracticeLayer:uiLayout()
  self.heros = {}
  for index, heroId in pairs(self.listData) do
    self.heros[heroId] = {
      pos = self.posData[index]
    }
    if self.posData[index] == self.selectId then
      self:showInfo()
    end
  end
  for index = 1, 13 do
    local node = self["pos" .. index]
    node:removeAllChildren()
    FormatHead.new({}):addTo(node)
  end
  self.formatNode:removeAllChildren()
  for heroId, data in pairs(self.heros) do
    local hero = self.allHeros[heroId]
    local node = self["pos" .. data.pos]
    local head = FormatHead.new({
      type = hero:getDressType(),
      quality = hero.quality
    }):pos(node:getPosition()):addTo(self.formatNode)
    local titleBg = display.newSprite(string.format(globalRes .. "des_bg_%d.png", hero.quality)):pos(29, 69):scale(0.7):addTo(head)
    local str = TitleData[hero.unit.profession]
    if string.len(str) > 7 then
      str = string.sub(str, 1, 7)
    end
    display.newTTFLabel({
      text = str,
      size = 18,
      color = UIHelper.hex2rgb("#ffffff")
    }):enableOutline(UIHelper.hex2rgb("#000000"), 1):pos(10, 23):addTo(titleBg)
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

function FormationPracticeLayer:showData(params)
  params = params or {}
  self.posIds = {}
  for heroId, data in pairs(self.heros) do
    self.posIds[data.pos] = heroId
  end
  self:showEffect(params.skip)
end

function FormationPracticeLayer:onTouchBegan(sender)
  local pos = sender:getBeginPos()
  self.touchId = nil
  local index = self:findIndex(pos)
  local heroId = self:findHero(index)
  if heroId then
    local data = self.heros[heroId]
    self.touchHead = data.head
    self.touchId = heroId
    self.selectId = heroId
    self.touchHead:scale(1.1)
    self.touchHead:zorder(10)
    self:showInfo()
  end
end

function FormationPracticeLayer:onTouchMoved(sender)
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

function FormationPracticeLayer:onTouchEnded(sender)
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
  if curPos ~= targetPos then
    if self.guideNode then
      self.guideNode:removeAllChildren()
    end
    NewGuideLayer.new({step = 10})
  end
end

function FormationPracticeLayer:findHero(index)
  for heroId, data in pairs(self.heros) do
    if data.pos == index then
      return heroId
    end
  end
end

function FormationPracticeLayer:findIndex(pos)
  for index = 1, 13 do
    local node = self["pos" .. index]
    local x, y = node:getPosition()
    if math.abs(x - pos.x) < 50 and 50 > math.abs(y - pos.y) then
      return index
    end
  end
end

function FormationPracticeLayer:showInfo()
  if self.oriId == self.selectId then
    return
  end
  self.oriId = self.selectId
  self.heroNode:removeAllChildren()
  self.content:removeAllChildren()
  self.nameBg:removeAllChildren()
  local hero = self.allHeros[self.selectId]
  local nameLabel = display.newTTFLabel({
    text = hero:getName(),
    size = 20,
    color = UIHelper.hex2rgb("#3e1413")
  }):pos(100, 20):addTo(self.nameBg)
  local proTag = UIHelper.getProfessionTag(hero.unit.profession, hero.quality, 16, hero:showTreeTag()):pos(2, 22):addTo(self.nameBg)
  UIHelper.makeFontClear(nameLabel)
  local forData = FormationCsv[hero.unit.formation][hero.fieldLevel] or {}
  local forName = MRichText.new({
    text = forData.name,
    size = 15,
    color = UIHelper.hex2rgb("#96dd07"),
    maxWidth = 100
  }):anch(0.5, 1):pos(53, 8):addTo(self.content)
  UIHelper.makeFontClear(forName)
  local forName = MRichText.new({
    text = forData.desc,
    color = UIHelper.hex2rgb("#96dd07"),
    size = 15,
    maxWidth = 180
  }):anch(0.5, 1):pos(215, 8):addTo(self.content)
  UIHelper.makeFontClear(forName)
  local forName = MRichText.new({
    text = forData.conDesc,
    size = 15,
    color = UIHelper.hex2rgb("#96dd07"),
    maxWidth = 100
  }):anch(0.5, 1):pos(380, 8):addTo(self.content)
  UIHelper.makeFontClear(forName)
  HeroBigCard.new({
    type = hero:getDressType(),
    quality = hero.quality
  }):pos(160, 0):addTo(self.heroNode)
end

function FormationPracticeLayer:sendRequest(group, id)
  if not self.canSend then
    return
  end
  local format = {}
  for index = 1, 5 do
    local heroId = self.listData[tostring(index)]
    local pos = heroId and self.heros[heroId].pos or 0
    format[index] = string.format("%d=%d", heroId and self.allHeros[heroId].type or 0, pos)
  end
  game:sendData(actionCodes.Activity_formatPracticeRpc, MsgPack.pack({
    group = group,
    id = id,
    format = table.concat(format, " ")
  }))
  UIHelper.showWaiting()
  game:addResponseHandler(actionCodes.Activity_formatPracticeRpc, function(event)
    UIHelper.removeWaiting()
    BackManager:pop()
  end)
end

function FormationPracticeLayer:showEffect(skip)
  local play = false
  local result = FormatLogic.getActiveStatus(self.posIds, self.allHeros)
  for heroId, status in pairs(result) do
    local heroData = self.heros[heroId]
    local head = heroData.head
    if heroId == self.selectId then
      self.cond:setString(result[self.selectId].active and "已触发" or "未触发")
      self.cond:setTextColor(UIHelper.hex2rgb(result[self.selectId].active and "#24AFF0" or "#96dd07"))
    end
    if not status.active then
      if head:getChildByTag(1) then
        head:removeChildByTag(1)
      end
    else
      play = true
      if not head:getChildByTag(1) then
        local yellow = UIHelper.loadAnimation(presetRes, "yellow", 30, 12)
        yellow.sprite:center(head):addTo(head, nil, 1)
        yellow.sprite:runAction(cc.RepeatForever:create(cc.Animate:create(yellow.animation)))
      end
    end
  end
  if play and not skip then
    game:playMusic(1028)
  end
  self:refreshTarget(result, FormatLogic.getActiveEffect(self.posIds, self.allHeros))
end

function FormationPracticeLayer:showFlash(heroId)
  local result = FormatLogic.getActiveStatus(self.posIds, self.allHeros)
  local stauts = result[heroId]
  if stauts and stauts.active then
    local hero = self.allHeros[heroId]
    local formatSet = FormationCsv[hero.unit.formation][hero.fieldLevel]
    for _, data in pairs(self.heros) do
      local blue = data.head:getChildByTag(2)
      if blue then
        blue:removeSelf()
      end
    end
    for _, effect in ipairs(formatSet.effectValue:toTableArray(" ")) do
      local pro = tonumber(effect[2])
      for _heroId, data in pairs(self.heros) do
        local _hero = self.allHeros[_heroId]
        if _hero.unit.profession == pro then
          local blue = UIHelper.loadAnimation(presetRes, "blue", 24, 12)
          blue.sprite:pos(50, 57):addTo(data.head, nil, 2)
          blue.sprite:setBlendFunc(cc.blendFunc(gl.ONE_MINUS_DST_COLOR, gl.ONE))
          blue.sprite:playAnimationOnce(blue.animation, true)
        end
      end
    end
  end
end

function FormationPracticeLayer:refreshTarget(result, effects)
  self.sendBtn:removeAllChildren()
  self.taskBg:removeAllChildren()
  
  local function condTrue(heroType, condType, value)
    local count = ""
    if condType == 1 then
      for heroId, data in pairs(result) do
        if self.allHeros[heroId].type == heroType and data.active then
          return true, ""
        end
      end
      return false, ""
    end
    if condType == 2 then
      count = SkillSpecialCsv[heroType][1].manaCost
      local choose = false
      for heroId, _ in pairs(self.heros) do
        if self.allHeros[heroId].type == heroType then
          choose = true
          break
        end
      end
      for _, data in pairs(effects[0] or {}) do
        if choose and data.type == 1 then
          count = count + data.value
        end
      end
      for _, data in pairs(effects[UnitCsv[heroType].profession] or {}) do
        if choose and data.type == 1 then
          count = count + data.value
        end
      end
      count = math.max(count, 1)
      return count == value, count
    end
    if condType == 3 then
      count = SkillSpecialCsv[heroType][1].numLimit
      local choose = false
      for heroId, _ in pairs(self.heros) do
        if self.allHeros[heroId].type == heroType then
          choose = true
          break
        end
      end
      for _, data in pairs(effects[0] or {}) do
        if choose and data.type == 3 then
          count = count + data.value
        end
      end
      for _, data in pairs(effects[UnitCsv[heroType].profession] or {}) do
        if choose and data.type == 3 then
          count = count + data.value
        end
      end
      return count == value, count
    end
    return false, count
  end
  
  local trueNum = 0
  local taskDesc = {
    "激活%s装盘%s",
    "%s费用变为%s",
    "%s次数变为%s"
  }
  local strDesc = {
    "",
    "现在费用：%s",
    "现在次数：%s"
  }
  local yPos = self.taskBg:getContentSize().height - 30
  for _, data in ipairs(self.goal) do
    local heroType, taskType, value = tonumber(data[1]), tonumber(data[2]), tonumber(data[3])
    local isTrue, temp = condTrue(heroType, taskType, value)
    local color = isTrue and "#96dd0c" or "#edca60"
    trueNum = isTrue and trueNum + 1 or trueNum
    local height = taskType == 1 and 24 or 48
    local bg = display.newScale9Sprite(presetRes .. "row_bg.png", 0, 0, cc.size(308, height)):anch(0.5, 1):pos(155, yPos):addTo(self.taskBg)
    if taskType == 1 then
      display.newTTFLabel({
        text = string.format(taskDesc[taskType], UnitCsv[heroType].name, taskType == 1 and "" or value),
        size = 16,
        color = UIHelper.hex2rgb(color)
      }):enableOutline(UIHelper.hex2rgb("#000000"), 1):anch(0, 0.5):pos(6, 12):addTo(bg)
      yPos = yPos - 30
    else
      display.newTTFLabel({
        text = string.format(taskDesc[taskType], UnitCsv[heroType].name, taskType == 1 and "" or value),
        size = 16,
        color = UIHelper.hex2rgb(color)
      }):enableOutline(UIHelper.hex2rgb("#000000"), 1):anch(0, 0.5):pos(6, 35):addTo(bg)
      display.newTTFLabel({
        text = string.format(strDesc[taskType], temp),
        size = 16,
        color = UIHelper.hex2rgb("#edca60")
      }):enableOutline(UIHelper.hex2rgb("#000000"), 1):anch(0, 0.5):pos(6, 13):addTo(bg)
      yPos = yPos - 60
    end
  end
  display.newTTFLabel({
    text = string.format("任务目标 -- %d/%d", trueNum, #self.goal),
    size = 20,
    color = UIHelper.hex2rgb("#edca60")
  }):enableOutline(UIHelper.hex2rgb("#000000"), 1):anch(0, 0.5):pos(12, self.taskBg:getContentSize().height - 17):addTo(self.taskBg)
  self.canSend = trueNum >= #self.goal
  if not self.canSend then
    local image = UIHelper.newImageView(presetRes .. "btn_send.png"):center(self.sendBtn):addTo(self.sendBtn)
    UIHelper.setImageViewGray(image)
  end
  display.newTTFLabel({text = "完成", size = 20}):enableOutline(UIHelper.hex2rgb("#4c3605"), 1):pos(60, 22):addTo(self.sendBtn)
  self.sendBtn:setTouchEnabled(self.canSend)
end

return FormationPracticeLayer
