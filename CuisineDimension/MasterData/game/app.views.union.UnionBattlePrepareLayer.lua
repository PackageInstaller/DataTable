local ItemCsv = require("csvdata.item")
local GlobalRes = "ui/global/"
local UnionBattleRes = "ui/union/battle/"
local uiData = {
  csbFile = "ui/union/UnionBattlePrepareLayer.csb",
  popup = true,
  mask = true,
  maskClick = true,
  widgets = {
    popAction = "popAction",
    timeTitle = "timeTitle",
    timeBody = "timeBody",
    startTitle = "startTitle",
    startBody = "startBody",
    tipTitle = "tipTitle",
    tipBody = "tipBody",
    teamNode = "teamNode",
    changePosBtn = "changePosBtn",
    changeSkillOrderBtn = "changeSkillOrderBtn",
    startBtn = "startBtn",
    closeBtn = "closeBtn",
    finishNode = "finishNode"
  }
}
local UnionBattlePrepareLayer = class("UnionBattlePrepareLayer", UIBase)

function UnionBattlePrepareLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function UnionBattlePrepareLayer:init(params)
  self.layerType = params.layer or ""
  self.formatInfo = game.role.activityStatus["89"].formatInfo or {}
  self.status = game.role.activityStatus["89"].status or 0
  self.timeBody:setString(globalCsv.unionBattleTimeTitle1)
  self.startBody:setString(globalCsv.unionBattleTimeTitle2)
  self.tipBody:setString(globalCsv.unionBattleDesc)
  self:ShowTeam()
  self:showRegistLabel()
  self.startBtn:setCallback(function()
    if self.status == 1 then
      return
    end
    self:ComfirmSignUp()
  end)
  self.changePosBtn:setCallback(function()
    self:ChangePosLayer()
  end)
  self.changeSkillOrderBtn:setCallback(function()
    self:ChangeOrderLayer()
  end)
  self.closeBtn:setCallback(function()
    self:close()
  end)
end

function UnionBattlePrepareLayer:ChangePosLayer()
  if self.status == 1 then
    SysError(SYS_ERR_UNIONBATTLE_SIGNUP_NOTCHANGE)
    return
  end
  local format = self.formatInfo.list or {}
  if not next(format) then
    SysError(SYS_ERR_PVP_TEAM_IS_EMPTY)
    return
  end
  local layer = game:createView("hero.FormationPresetLayer", {skip = true, battleType = "union"})
  self:hide()
  BackManager:push(function()
    layer:close()
    if self.layerType == "union" then
      TopBar:show(TopBarType.full, "协会")
    else
      TopBar:show(TopBarType.money)
    end
    self:show()
  end)
end

function UnionBattlePrepareLayer:ChangeOrderLayer()
  if self.status == 1 then
    SysError(SYS_ERR_UNIONBATTLE_SIGNUP_NOTCHANGE)
    return
  end
  local format = self.formatInfo.list or {}
  if not next(format) then
    SysError(SYS_ERR_PVP_TEAM_IS_EMPTY)
    return
  end
  game:createView("union.UnionBattleSkillOrderLayer", {
    callback = function(result)
      game:sendData(actionCodes.Activity_unionBattleSkillOrderRpc, MsgPack.pack({skillOrder = result}))
      UIHelper.showWaiting()
      game:addResponseHandler(actionCodes.Activity_unionBattleSkillOrderRpc, function(event)
        UIHelper.removeWaiting()
        SysError(SYS_ERR_PVP_SKILL_ORDER_SUCCESS)
        self.formatInfo = game.role.activityStatus["89"].formatInfo
      end)
    end
  })
end

function UnionBattlePrepareLayer:ComfirmSignUp()
  if game.role.level < globalCsv.unionUnlockLevel or game.role.union == 0 then
    SysError(SYS_ERR_UNIONBATTLE_SIGNUP_LIMIT)
    return
  end
  local length = 0
  local list = self.formatInfo.list or {}
  for _ in pairs(list) do
    length = length + 1
  end
  if not (self.formatInfo and list) or length < 1 then
    SysError(SYS_ERR_TEAM_FORMAT_SET_ONE)
    return
  end
  MDialog:double({
    text = "主厨，报名后就不能再修改您的装盘信息了哦！是否确定报名？",
    size = 24,
    color = UIHelper.hex2rgb("#430602"),
    cancelCallback = function()
      return true
    end,
    okCallback = function()
      game:sendData(actionCodes.Activity_unionBattleRegisterRpc, MsgPack.pack({}))
      UIHelper.showWaiting()
      game:addResponseHandler(actionCodes.Activity_unionBattleRegisterRpc, function(event)
        UIHelper.removeWaiting()
        self.status = game.role.activityStatus["89"].status or 0
        self:showRegistLabel()
        SysError(SYS_ERR_UNIONBATTLE_SIGNUP_SUCCESS)
      end)
      return true
    end
  })
end

function UnionBattlePrepareLayer:showRegistLabel()
  if self.status == 1 then
    self.changePosBtn:hide()
    self.startBtn:hide()
    self.changeSkillOrderBtn:hide()
    self.finishNode:show()
  else
    self.changePosBtn:show()
    self.startBtn:show()
    self.changeSkillOrderBtn:show()
    self.finishNode:hide()
  end
end

function UnionBattlePrepareLayer:ShowTeam()
  self.teamNode:removeAllChildren()
  self.heros = {}
  local format = self.formatInfo.list or {}
  local heroType, quality
  local xPos = 0
  local yPos = -15
  for index = 1, 5 do
    local hero = game.role.heros[format[tostring(index)]]
    if hero then
      local card = HeroHead.new({
        heroId = hero.id,
        level = hero.level,
        quality = hero.quality,
        loveEffect = true,
        loveBreak = hero.loveBreak
      }):scale(0.9):pos(xPos, yPos):addTo(self.teamNode)
      card:setCallback(function()
        if self.status == 1 then
          SysError(SYS_ERR_UNIONBATTLE_SIGNUP_NOTCHANGE)
          return
        end
        self:addHero(index, hero.id)
      end)
      heroType = heroType or hero:getDressType()
      quality = quality or hero.quality
      self.heros[hero.id] = index
    else
      local card = UIHelper.newImageView("ui/kitchen/quality/bg_1.png"):scale(0.9):pos(xPos, yPos):addTo(self.teamNode)
      UIHelper.newImageView("ui/global/item_frame.png"):center(card):addTo(card)
      UIHelper.newImageView("ui/global/add.png"):pos(46, 53):addTo(card)
      display.newTTFLabel({
        text = "添加食灵",
        size = 14,
        color = UIHelper.hex2rgb("#b3a27e")
      }):pos(45, 25):addTo(card)
      card:setCallback(function()
        if self.status == 1 then
          SysError(SYS_ERR_UNIONBATTLE_SIGNUP_NOTCHANGE)
          return
        end
        self:addHero(index)
      end)
      card:setCascadeOpacityEnabled(true)
    end
    xPos = xPos + 95
  end
end

function UnionBattlePrepareLayer:addHero(slot, heroId)
  if game.role.level < globalCsv.unionUnlockLevel or game.role.union == 0 then
    SysError(SYS_ERR_UNIONBATTLE_SIGNUP_LIMIT)
    return
  end
  
  local function rule(hero)
    if hero.unit.star >= 5 or hero.unit.type == 540 or hero.unit.type == 638 or hero.unit.type == 639 or hero.unit.type == 336 or hero.unit.type == 138 or hero.unit.type == 237 or hero.unit.type == 438 or hero.unit.type == 541 or hero.unit.type == 542 then
      return true
    end
    return false
  end
  
  local layer = game:createView("union.ChooseUnionHeroLayer", {
    heroId = heroId,
    max = 5,
    rule = rule,
    choosed = self.heros,
    callback = function(choose)
      if type(choose) == "table" then
        local list = {}
        for index, data in pairs(choose) do
          local hero = game.role.heros[data.id]
          if hero then
            list[tostring(data.slot)] = data.id
          end
        end
        game:sendData(actionCodes.Activity_unionBattleFormatQuickRpc, MsgPack.pack({formation = list}))
        UIHelper.showWaiting()
        game:addResponseHandler(actionCodes.Activity_unionBattleFormatQuickRpc, function(event)
          UIHelper.removeWaiting()
          self.formatInfo = game.role.activityStatus["89"].formatInfo
          self:ShowTeam()
        end)
      elseif self:checkFormationSameHero(choose, slot) then
        SysError(SYS_ERR_TEAM_SAME_HERO)
        return true
      else
        game:sendData(actionCodes.Activity_unionBattleChangeFormatRpc, MsgPack.pack({slot = slot, heroId = choose}))
        UIHelper.showWaiting()
        game:addResponseHandler(actionCodes.Activity_unionBattleChangeFormatRpc, function(event)
          UIHelper.removeWaiting()
          self.formatInfo = game.role.activityStatus["89"].formatInfo
          self:ShowTeam()
        end)
      end
    end
  })
  self:hide()
  BackManager:push(function()
    layer:close()
    if self.layerType == "union" then
      TopBar:show(TopBarType.full, "协会")
    else
      TopBar:show(TopBarType.money)
    end
    self:show()
  end)
end

function UnionBattlePrepareLayer:checkFormationSameHero(choose, slot)
  if choose == 0 then
    return false
  end
  local hero = game.role.heros[choose]
  for id, index in pairs(self.heros) do
    local tempHero = game.role.heros[id]
    if tempHero.type == hero.type and choose ~= id then
      return true
    end
  end
  return false
end

function UnionBattlePrepareLayer:changeFormat()
  local format = self.formatInfo.list or {}
  if not next(format) then
    SysError(SYS_ERR_PVP_TEAM_IS_EMPTY)
    return
  end
  local layer = game:createView("hero.FormationPresetLayer", {skip = true, battleType = "union"})
  self:hide()
  BackManager:push(function()
    self:show()
    layer:close()
    self.formatInfo = game.role.activityStatus["89"].formatInfo
  end)
end

return UnionBattlePrepareLayer
