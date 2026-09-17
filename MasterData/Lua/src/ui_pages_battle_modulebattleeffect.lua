local this = class("moduleBattleEffect", G_UIModuleBase)
local _buffInfoTpl = L_GameTpl:getBuffInfoTpl()
local _buffDamagetext = L_GameTpl:getBattleDamagetextTpl()
local s_elite_count = 5
local _screenPosToUI = Unity.RectTransformUtility.ScreenPointToLocalPointInRectangle
local _worldToScreen = Unity.RectTransformUtility.WorldToScreenPoint
local PATHE_TABLE = {
  [1] = "UI/Page/Battle/tex_battle_word_msz_gmcx.png",
  [2] = "UI/Page/Battle/tex_battle_word_msz_gmyb.png",
  [3] = "UI/Page/Battle/tex_battle_word_msz_gmcx.png",
  [4] = "UI/Page/Battle/tex_battle_word_msz_gmyb.png"
}
local COLOR_TABLE = {
  [L_Const.battleBuffAttr.attrFire] = "#FF6364",
  [L_Const.battleBuffAttr.attrWind] = "#FFAD6B",
  [L_Const.battleBuffAttr.attrSoil] = "#E3C25D",
  [L_Const.battleBuffAttr.attrWood] = "#82DB84",
  [L_Const.battleBuffAttr.attrIced] = "#A0FAF8",
  [L_Const.battleBuffAttr.attrWater] = "#4BC6FF",
  [L_Const.battleBuffAttr.attrLightning] = "#8088FF",
  [L_Const.battleBuffAttr.attrLight] = "#EFC161",
  [L_Const.battleBuffAttr.attrDark] = "#8E65DA"
}
local COLOR_BG_TABLE = {
  [L_Const.battleBuffAttr.attrFire] = "#FF4647",
  [L_Const.battleBuffAttr.attrWind] = "#FF772D",
  [L_Const.battleBuffAttr.attrSoil] = "#A37908",
  [L_Const.battleBuffAttr.attrWood] = "#209E23",
  [L_Const.battleBuffAttr.attrIced] = "#1C9F9C",
  [L_Const.battleBuffAttr.attrWater] = "#198DC2",
  [L_Const.battleBuffAttr.attrLightning] = "#535BD1",
  [L_Const.battleBuffAttr.attrLight] = "#CF870B",
  [L_Const.battleBuffAttr.attrDark] = "#6D3DC5"
}
local COLOR_WHITE = "#FFFFFF"

function this.bind()
  return {
    moduleBattleBossTip = {
      moduleName = "pages/battle/moduleBattleBossTip"
    },
    moduleBattleBossSkill = {
      moduleName = "pages/battle/moduleBattleBossSkill"
    },
    moduleCountermeasuresEft = {
      moduleName = "pages/battle/moduleCountermeasuresEft"
    },
    goWeak = false,
    moduleBattleEliteList = {
      moduleName = "pages/battle/moduleBattleEliteCell"
    },
    go_effect = false,
    go_counter = false,
    goLookAtBoss = false,
    img_titleIcon = "",
    img_buffType = "",
    img_buffAnima1 = "",
    img_buffAnima2 = "",
    img_buffAnima3 = "",
    color_bg = C_Color(1, 1, 1, 1),
    color_textA = C_Color(1, 1, 1, 1),
    color_textB = C_Color(1, 1, 1, 1)
  }
end

function this:open(...)
  this.super.open(self, ...)
  L_BattleDataManager:addListener(L_BattleDataManager.event.weakBreakNotice, self.onEvent_weak, self)
  L_BattleDataManager:addListener(L_BattleDataManager.event.cameraLookAtNotice, self.onEvent_cameraLookAt, self)
  L_EntityManager:addListener(L_EntityManager.event.triggerStack, self.onEvent_stack, self)
  L_BattleDataManager:addListener(L_BattleDataManager.event.onCastSkill, self.onEvent_onCastSkill, self)
  L_BattleDataManager:addListener(L_BattleDataManager.event.skillNotice, self.onEvent_skillNotice, self)
  L_BattleDataManager:addListener(L_BattleDataManager.event.bossShowSkillProcessBar, self.onEvent_bossShowSkillProcessBar, self)
  L_BattleDataManager:addListener(L_BattleDataManager.event.onStopSkill, self.onEvent_onStopSkill, self)
  self.bind.moduleBattleEliteList:clear()
  local array = {}
  for i = 1, s_elite_count do
    table.insert(array, {})
  end
  self.bind.moduleBattleEliteList:insert_array(array)
end

function this:close()
  L_BattleDataManager:removeListener(L_BattleDataManager.event.weakBreakNotice, self.onEvent_weak)
  L_BattleDataManager:removeListener(L_BattleDataManager.event.cameraLookAtNotice, self.onEvent_cameraLookAt)
  L_EntityManager:removeListener(L_EntityManager.event.triggerStack, self.onEvent_stack)
  L_BattleDataManager:removeListener(L_BattleDataManager.event.onCastSkill, self.onEvent_onCastSkill)
  L_BattleDataManager:removeListener(L_BattleDataManager.event.skillNotice, self.onEvent_skillNotice)
  L_BattleDataManager:removeListener(L_BattleDataManager.event.bossShowSkillProcessBar, self.onEvent_bossShowSkillProcessBar, self)
  L_BattleDataManager:removeListener(L_BattleDataManager.event.onStopSkill, self.onEvent_onStopSkill, self)
  self:resetWeakTimer()
  self:resetEffectTimer()
  self:resetCounterTimer()
  self.currentEliteCount = 0
  self.bind.goLookAtBoss = false
  self.bind.go_effect = false
  self.bind.goWeak = false
  self:removeUpdateHandle()
end

function this:onEvent_weak(args)
  if args.monsterType == L_Const.enemyType.boss then
    self:resetWeakTimer()
    self.bind.goWeak = true
    self.weakTimer = Timer.once(3, function()
      self.bind.goWeak = false
      self.weakTimer = nil
    end, self)
  else
    for i = 1, s_elite_count do
      local eliteCell = self.bind.moduleBattleEliteList:getItemCls(i)
      if eliteCell:canUse() then
        eliteCell:showEffect(args.vfxCentralPosX, args.vfxCentralPosY)
        return
      end
    end
  end
end

function this:onEvent_cameraLookAt(args)
  self.bind.goLookAtBoss = args.isLookAt
  if args.isLookAt then
    self:addUpdateHandle()
    local entity_ = C_EntityManager.GetEntity(args.entityId)
    if entity_ ~= nil then
      self.bindComponents.lookCameraAnim:Stop()
      self.bindComponents.lookCameraAnim:Play("anim_lookat_show_v2")
      local modControl = entity_.model.gameObject:GetComponent(typeof(C_ModelControl))
      local bone_ = modControl:GetTransByName(args.lockBoneName)
      self.bossBindBone = bone_
    end
  else
    self:removeUpdateHandle()
  end
end

function this:addUpdateHandle()
  if self.updateHandle then
    self:removeUpdateHandle()
  end
  self.updateHandle = handler(self, self.effectUpdate)
  C_UpdateSource.AddUpdateEventHandler(self.updateHandle, "moduleBattleEffect.update")
end

function this:effectUpdate()
  if self.bossBindBone then
    local worldPosition = L_Vector3.getPos(self.bossBindBone)
    local screenPosition = _worldToScreen(C_CameraManager.mainCamera, worldPosition)
    local _, uiPos = _screenPosToUI(self.bindComponents.lockBossCamera.parent, screenPosition, C_CameraManager.uiCamera)
    L_Vector3.setAnchored(self.bindComponents.lockBossCamera, uiPos)
  end
end

function this:removeUpdateHandle()
  if self.updateHandle then
    C_UpdateSource.RemoveUpdateEventHandler(self.updateHandle)
    self.updateHandle = nil
  end
end

function this:onEvent_onCastSkill(args)
  local skillId = args.intArg
  local mainHero = AzurWorld.playerMgr.myPlayerData:GetPlayerMainControl(false)
  local skill = mainHero.data.skillProperty:GetSkillBySlot(L_Const.C_ESkillSlotType.EvadeBoostAttack)
  if skill and skill.id == skillId then
    if self:checkSafeTime() then
      return
    end
    self:showCounterEffect({isCounter = true})
  end
end

function this:onEvent_stack(data)
  if data == nil or data.type == 0 then
    return
  end
  if self:checkSafeTime() then
    return
  end
  self:showBuffEffect(data)
end

function this:onEvent_skillNotice(args)
  self.modules.moduleBattleBossTip:showSkill(args.skillId, args.time)
end

function this:onEvent_bossShowSkillProcessBar(args)
  self.modules.moduleBattleBossSkill:showBossSkill(args.curSkillId, args.process, args.entityId)
end

function this:onEvent_onStopSkill(args)
  self.modules.moduleBattleBossSkill:stopSkill(args.intArg, args.entityId)
end

function this:hideEffect()
  if self.modules.moduleBattleBossTip ~= nil then
    self.modules.moduleBattleBossTip:hideContent()
  end
  if self.modules.moduleBattleBossSkill ~= nil then
    self.modules.moduleBattleBossSkill:hideContent()
  end
end

function this:resetWeakTimer()
  if self.weakTimer then
    Timer.remove(self.weakTimer)
    self.weakTimer = nil
  end
end

function this:resetEffectTimer()
  if self.effectTimer then
    Timer.remove(self.effectTimer)
    self.effectTimer = nil
  end
end

function this:showBuffEffect(args)
  if args.elementId ~= nil then
    local buffId = args.elementId
    local tpl = _buffInfoTpl:getTplById(buffId)
    if not tpl then
      errorf("buffInfo表不存在该Id = " .. tostring(buffId))
      return
    end
    local dTpl = _buffDamagetext:getTplById(buffId)
    if not dTpl then
      errorf("BattleDamagetext表不存在该Id = " .. tostring(buffId))
      return
    end
    self.bind.img_titleIcon = _buffInfoTpl:getAttrIcon(tpl)
    local mainHero = AzurWorld.playerMgr.myPlayerData:GetPlayerMainControl(false)
    if args.type == 1 or args.type == 3 then
      C_MediaPackUtility.CustomMediaPackPlay(mainHero, CS.Lens.Gameplay.Modules.BigWorld.EMediaPackBattleEvent.ElementOverMaximum)
    elseif args.type == 2 or args.type == 4 then
      C_MediaPackUtility.CustomMediaPackPlay(mainHero, CS.Lens.Gameplay.Modules.BigWorld.EMediaPackBattleEvent.ElementBomb)
    end
    local nameText = PATHE_TABLE[args.type]
    self.bind.img_buffType = nameText
    self.bind.img_buffAnima1 = nameText
    self.bind.img_buffAnima2 = nameText
    self.bind.img_buffAnima3 = nameText
    self.bindComponents.buffTextImage:SetNativeSize()
    local paramType = _buffDamagetext:getElement(dTpl)
    local _, colorWhite = C_ColorUtility.TryParseHtmlString(COLOR_WHITE)
    local _, color = C_ColorUtility.TryParseHtmlString(COLOR_TABLE[paramType])
    local _, bgColor = C_ColorUtility.TryParseHtmlString(COLOR_BG_TABLE[paramType])
    local _, colorHDR = C_CustomColorUtility.TryParseHDRHtmlString(COLOR_TABLE[paramType], 1.5)
    local gradient = C_CustomColorUtility.GenerateGradientLinear(color, 1, 0, colorWhite, 1, 1)
    local minMaxGradient = C_CustomColorUtility.ColorTransitionMinMaxGradient(color)
    self.bind.color_bg = bgColor
    self.bind.color_textA = color
    self.bind.color_textB = color
    self.bindComponents.buffTextColor.LinearGradient = gradient
    self.bindComponents.line1.main.startColor = minMaxGradient
    self.bindComponents.line.main.startColor = minMaxGradient
    self.bindComponents.glow.sharedMaterial:SetColor("_MainColor", colorHDR)
    self.bindComponents.glow3.sharedMaterial:SetColor("_MainColor", colorHDR)
    self.bindComponents.glow4.sharedMaterial:SetColor("_MainColor", color)
    local colorWithAlphaNewpar3 = color
    colorWithAlphaNewpar3.a = self.bindComponents.newpar3.main.startColor.color.a
    local minMaxGradientNewpar3 = C_CustomColorUtility.ColorTransitionMinMaxGradient(colorWithAlphaNewpar3)
    self.bindComponents.newpar3.main.startColor = minMaxGradientNewpar3
    self.bindComponents.newpar5.main.startColor = minMaxGradient
    self.bindComponents.newpar6.main.startColor = minMaxGradient
    self.bindComponents.newpar_star.main.startColor = minMaxGradient
    self:resetEffectTimer()
    self.bind.go_effect = true
    self.bind.go_counter = false
    self.bindComponents.buffAnime:Stop()
    self.bindComponents.buffAnime:Play("anim_battle_buffeffect_in")
    self.effectTimer = Timer.once(3, function()
      self.bind.go_effect = false
      self.effectTimer = nil
    end, self)
  end
end

function this:resetCounterTimer()
  if self.counterTimer then
    Timer.remove(self.counterTimer)
    self.counterTimer = nil
  end
end

function this:showCounterEffect(args)
  if args.isCounter then
    self:resetCounterTimer()
    self.bind.go_counter = true
    self.bind.go_effect = false
    self.bindComponents.counterAnime:Stop()
    self.bindComponents.counterAnime:Play("anim_battle_counter_in")
    self.counterTimer = Timer.once(3, function()
      self.bind.go_counter = false
      self.counterTimer = nil
    end, self)
  end
end

function this:checkSafeTime()
  if self.safeTime then
    return true
  end
  local gameTpl = L_GameTpl:getGameConstTpl()
  local time = gameTpl:getData("BATTLE_WEAKBREAK_SAFETIME", L_Const.GameTplType.float, 0.2)
  self.safeTime = Timer.once(time, function()
    self.safeTime = nil
  end, self)
  return false
end

function this:show(options)
  self:showModules()
end

function this:hide(options)
  self:hideEffect()
  self:hideModules()
end

function this:activate()
  self:open()
  self:openModules()
  self:show()
  self:showModules()
end

function this:deActivate()
  self:hide()
  self:hideModules()
  self:close()
  self:closeModules()
end

return this
