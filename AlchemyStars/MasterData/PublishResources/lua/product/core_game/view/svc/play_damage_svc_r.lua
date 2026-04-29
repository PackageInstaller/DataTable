DamageShowType = {Single = 1, Grid = 2}
require("battle_svc_l")
require("play_skill_svc_r")
_class("PlayDamageService", BaseService)
PlayDamageService = PlayDamageService

function PlayDamageService:Constructor(world)
  self._damageType2EntityID = {
    [DamageType.Normal] = EntityConfigIDRender.NormalDamage,
    [DamageType.Real] = EntityConfigIDRender.RealDamage,
    [DamageType.RealReflexive] = EntityConfigIDRender.RealDamage,
    [DamageType.RealDead] = EntityConfigIDRender.RealDamage,
    [DamageType.Recover] = EntityConfigIDRender.RecoverDamage,
    [DamageType.Guard] = EntityConfigIDRender.GuardDamage,
    [DamageType.Miss] = EntityConfigIDRender.MissDamage,
    [DamageType.Burn] = EntityConfigIDRender.DeBuffDamage,
    [DamageType.Poison] = EntityConfigIDRender.DeBuffDamage,
    [DamageType.Bleed] = EntityConfigIDRender.DeBuffDamage,
    [DamageType.Explode] = EntityConfigIDRender.DeBuffDamage,
    [DamageType.Critical] = EntityConfigIDRender.CriticalDamage,
    [DamageType.NoElementNormal] = EntityConfigIDRender.NormalDamage,
    [DamageType.RealTransmit] = EntityConfigIDRender.RealDamage,
    [DamageType.RecoverTransmit] = EntityConfigIDRender.RecoverDamage
  }
  self._damageElementType = {
    [ElementType.ElementType_Blue] = "water",
    [ElementType.ElementType_Red] = "fire",
    [ElementType.ElementType_Green] = "wood",
    [ElementType.ElementType_Yellow] = "thunder",
    [ElementType.ElementType_AnyNone] = "none"
  }
  self._deBuffElementType = {
    [DamageType.Real] = "real",
    [DamageType.Burn] = "burn",
    [DamageType.Poison] = "poison",
    [DamageType.Bleed] = "bleed",
    [DamageType.Explode] = "bleed"
  }
  self._isDamageTypeNoFigure = {
    [DamageType.Guard] = true,
    [DamageType.Miss] = true
  }
  self.__NTMonsterHPCChangeCount = 0
  self._cheatHideDamageDisplay = false
end

function PlayDamageService:PlayDamageSyncEffect(TT, lineEffectID, attacker, defender)
  local effectSvc = self._world:GetService("Effect")
  local effectHolderCmpt = attacker:EffectHolder()
  if not effectHolderCmpt then
    attacker:AddEffectHolder()
    effectHolderCmpt = attacker:EffectHolder()
  end
  if lineEffectID then
    local effectEntityIdList = effectHolderCmpt:GetEffectIDEntityDic()[lineEffectID]
    local effect
    if effectEntityIdList then
      effect = self._world:GetEntityByID(effectEntityIdList[1])
    end
    if not effect then
      effect = effectSvc:CreateEffect(lineEffectID, attacker, false)
      effectHolderCmpt:AttachPermanentEffect(effect:GetID())
      local go = effect:View():GetGameObject()
      go:SetActive(false)
    end
    local go = effect:View():GetGameObject()
    local renderers = go:GetComponentsInChildren(typeof(UnityEngine.LineRenderer), true)
    local attackerViewRoot = attacker:View().ViewWrapper.GameObject.transform
    local attackRoot = GameObjectHelper.FindChild(attackerViewRoot, "Hit")
    attackRoot = attackRoot or GameObjectHelper.FindChild(attackerViewRoot, "Root")
    local defenderViewRoot = defender:View().ViewWrapper.GameObject.transform
    local defenderRoot = GameObjectHelper.FindChild(defenderViewRoot, "Hit")
    defenderRoot = defenderRoot or GameObjectHelper.FindChild(defenderViewRoot, "Root")
    for i = 0, renderers.Length - 1 do
      local line = renderers[i]
      if line then
        line:SetPosition(0, attackRoot.position)
        line:SetPosition(1, defenderRoot.position)
      end
    end
    go:SetActive(true)
    local anim = go:GetComponentInChildren(typeof(UnityEngine.Animation))
    anim:Play()
  end
end

function PlayDamageService:AsyncUpdateHPAndDisplayDamage(defenderEntity, damageInfo)
  if defenderEntity:MonsterID() and defenderEntity:MonsterID():GetDamageSyncMonsterID() then
    local utilDataSvc = self._world:GetService("UtilData")
    local damageSyncEntityList = utilDataSvc:FindSyncMonsterTargetList(defenderEntity)
    local effectID = defenderEntity:MonsterID():GetDamageSyncEffect()
    for i, entity in ipairs(damageSyncEntityList) do
      local pos = entity:GetRenderGridPosition()
      local damageInfoList = damageInfo:GetSyncDamageInfo()
      for _, newInfo in ipairs(damageInfoList) do
        if newInfo:GetTargetEntityID() == entity:GetID() then
          newInfo:SetShowPosition(pos)
          newInfo:SetRenderGridPos(pos)
          self:AsyncUpdateHPAndDisplayDamage(entity, newInfo)
        end
      end
    end
  end
  return GameGlobal.TaskManager():CoreGameStartTask(function(TT)
    self:UpdateTargetHPBar(TT, defenderEntity, damageInfo)
    self:_OnHpChangeNotifyBuff(TT, defenderEntity, damageInfo:GetChangeHP(), damageInfo)
    self:DisplayDamage(TT, defenderEntity, damageInfo)
  end)
end

function PlayDamageService:AsyncUpdateHPAndDisplayDamageMultiStage(defenderEntity, damageInfoList, damageStageValueList, intervalTime, isSyncDamage)
  if defenderEntity:MonsterID() and defenderEntity:MonsterID():GetDamageSyncMonsterID() then
    local utilDataSvc = self._world:GetService("UtilData")
    local damageSyncEntityList = utilDataSvc:FindSyncMonsterTargetList(defenderEntity)
    local effectID = defenderEntity:MonsterID():GetDamageSyncEffect()
    for i, entity in ipairs(damageSyncEntityList) do
      local pos = entity:GetRenderGridPosition()
      local newDamageInfoList = {}
      for i, info in ipairs(damageInfoList) do
        local damageInfoList = info:GetSyncDamageInfo()
        for i, newInfo in ipairs(damageInfoList) do
          if newInfo:GetTargetEntityID() == entity:GetID() then
            newInfo:SetShowPosition(pos)
            newInfo:SetRenderGridPos(pos)
            table.insert(newDamageInfoList, newInfo)
          end
        end
      end
      self:AsyncUpdateHPAndDisplayDamageMultiStage(entity, newDamageInfoList, damageStageValueList, intervalTime, true)
    end
  end
  GameGlobal.TaskManager():CoreGameStartTask(function(TT)
    self:DisplayDamage(TT, defenderEntity, damageInfoList[#damageInfoList], damageStageValueList, intervalTime)
    if isSyncDamage then
      self:UpdateTargetHPBar(TT, defenderEntity, damageInfoList[#damageInfoList])
    end
  end)
end

function PlayDamageService:UpdateTargetHPBarMultiStage(TT, defenderEntity, damageInfoList, intervalTime, damageStageValueList)
  for i = 1, table.count(damageStageValueList) - 1 do
    YIELD(TT, intervalTime)
  end
  self:UpdateTargetHPBar(TT, defenderEntity, damageInfoList[#damageInfoList])
end

function PlayDamageService:UpdateTargetHPBar(TT, defenderEntity, damageInfo)
  self:_RefreshHudHpBar(TT, defenderEntity, damageInfo)
  self:_RefreshBossHP(TT, defenderEntity, damageInfo)
  self:_RefreshTeamHP(TT, defenderEntity, damageInfo)
end

function PlayDamageService:_OnHpChangeNotifyBuff(TT, defenderEntity, changeHP, damageInfo)
  local svcPlayBuff = self._world:GetService("PlayBuff")
  local hp_cmpt = defenderEntity:HP()
  local maxhp = hp_cmpt:GetMaxHP()
  local redhp = hp_cmpt:GetRedHP()
  local attackerID = damageInfo:GetAttackerEntityID()
  if defenderEntity:PetPstID() or defenderEntity:HasTeam() then
    local nt = NTPlayerHPChange:New(defenderEntity, redhp, maxhp, nil, changeHP, attackerID)
    nt:SetAttackPos(damageInfo:GetAttackPos())
    nt:SetDamageInfo(damageInfo)
    svcPlayBuff:PlayBuffView(TT, nt)
  elseif defenderEntity:HasMonsterID() then
    local nt = NTMonsterHPCChange:New(defenderEntity, redhp, maxhp, self.__NTMonsterHPCChangeCount)
    nt:SetChangeHP(changeHP)
    nt:SetDamageSrcEntityID(attackerID)
    nt:SetAttackPos(damageInfo:GetAttackPos())
    nt:SetDamageInfo(damageInfo)
    svcPlayBuff:PlayBuffView(TT, nt)
    self.__NTMonsterHPCChangeCount = self.__NTMonsterHPCChangeCount + 1
  elseif defenderEntity:HasTrapID() then
    local nt = NTTrapHpChange:New(defenderEntity, redhp, maxhp)
    nt:SetChangeHP(changeHP)
    nt:SetDamageSrcEntityID(attackerID)
    nt:SetAttackPos(damageInfo:GetAttackPos())
    nt:SetDamageInfo(damageInfo)
    svcPlayBuff:PlayBuffView(TT, nt)
  elseif defenderEntity:HasChessPet() then
    local nt = NTChessHPChange:New(defenderEntity, redhp, maxhp)
    nt:SetChangeHP(changeHP)
    nt:SetDamageSrcEntityID(attackerID)
    nt:SetAttackPos(damageInfo:GetAttackPos())
    nt:SetDamageInfo(damageInfo)
    svcPlayBuff:PlayBuffView(TT, nt)
  end
end

function PlayDamageService:_RefreshHudHpBar(TT, defenderEntity, damageInfo)
  if defenderEntity:PetPstID() then
    defenderEntity = defenderEntity:Pet():GetOwnerTeamEntity()
  end
  if defenderEntity:MonsterID() and defenderEntity:MonsterID():IsWorldBoss() then
    self:_RefreshWorldBossHP(defenderEntity, damageInfo)
    return
  end
  local hp_cmpt = defenderEntity:HP()
  if hp_cmpt == nil then
    Log.fatal("UpdateTargetHPBar() hp cmpt is nil defenderEntity=", defenderEntity:GetID())
    return
  end
  local svcPlayBuff = self._world:GetService("PlayBuff")
  local damageType = damageInfo:GetDamageType()
  local maxhp = hp_cmpt:GetMaxHP()
  local changeHP = damageInfo:GetChangeHP()
  local redhp = hp_cmpt:GetRedHP()
  if defenderEntity:HasMonsterID() and defenderEntity:MonsterID():IsMultiHPMonster() and redhp + changeHP <= 0 and defenderEntity:HP():HasNextMultiStageHPData() then
    local maxHP, curHP, newMultiHPStage, switchCount = defenderEntity:HP():GetNextMultiStageHPData(redhp + changeHP)
    damageInfo:SetMultiHPSwitch(true)
    damageInfo:SetNewMultiHPStage(newMultiHPStage)
    damageInfo:SetMultiHPFinalHP(curHP)
    damageInfo:SetMultiHPCurMaxHP(maxHP)
    damageInfo:SetMultiHPSwitchCount(switchCount)
    redhp = curHP
    defenderEntity:ReplaceMultiHPSwitchStage(newMultiHPStage, redhp)
    Log.fatal("UI Switch Per:", curHP / maxHP, "RedHP:", curHP, "MaxHP:", maxHP, "NewMultiHPStage:", newMultiHPStage, "SwitchCount:", switchCount)
  else
    redhp = math.floor(math.max(math.min(redhp + changeHP, maxhp), 0))
    defenderEntity:ReplaceRedHPAndWhitHP(redhp)
    Log.debug("UpdateTargetHPBar() entityID=", defenderEntity:GetID(), "Per:", redhp / maxhp, " changeHP=", changeHP, " redhp=", redhp)
  end
  local curShield = damageInfo:GetHPShield()
  if curShield then
    local shieldDelta = damageInfo:GetHPShieldDelta()
    if shieldDelta then
      local newShieldValue = hp_cmpt:GetShieldValue() + shieldDelta
      hp_cmpt:SetShieldValue(newShieldValue)
    else
      hp_cmpt:SetShieldValue(curShield)
    end
  end
  local curCurseHp = damageInfo:GetCurseHp()
  if curCurseHp then
    local curseHpDelta = damageInfo:GetCurseHpDelta()
    if curseHpDelta then
      local newCurseHpValue = hp_cmpt:GetCurseHpValue() + curseHpDelta
      hp_cmpt:SetCurseHpValue(newCurseHpValue)
    else
      hp_cmpt:SetCurseHpValue(curCurseHp)
    end
  end
  local percent = defenderEntity:BuffView():GetBuffValue("SecKillHPPercent")
  if redhp == 0 and percent or damageType == DamageType.RealDead then
    self._world:EventDispatcher():Dispatch(GameEventType.HPSliderBroken, defenderEntity:GetID())
  end
  if damageInfo:IsTriggerHPLock() then
    local utilDataSvc = self._world:GetService("UtilData")
    utilDataSvc:UpdateRenderHPLockInfoByLogic(defenderEntity)
    local nt = NTHPLock:New()
    nt:SetNotifyEntity(defenderEntity)
    svcPlayBuff:PlayBuffView(TT, nt)
  end
  if damageType == DamageType.Guard then
    if defenderEntity:HasTrapID() and defenderEntity:TrapRender():GetTrapType() == TrapType.Protected then
      self:GetService("Effect"):CreateEffect(BattleConst.AircraftHitShieldEffect, defenderEntity)
    end
    if damageInfo:GetShieldLayer() then
      svcPlayBuff:PlayBuffView(TT, NTReduceShieldLayer:New(defenderEntity, damageInfo:GetShieldLayer()))
    end
  end
end

function PlayDamageService:_RefreshWorldBossHP(defenderEntity, damageInfo)
  local hp = defenderEntity:HP()
  local damageType = damageInfo:GetDamageType()
  local changeHP = damageInfo:GetChangeHP()
  if damageType == DamageType.RealDead and EDITOR then
    Log.exception("WorldBoss  DamageType Is RealDead ")
  end
  local damage = changeHP * -1
  local changeInfoList = {}
  while changeHP < 0 do
    local curStageHP = hp:GetCurStageHP()
    local changeStage = false
    local newHP = curStageHP + changeHP
    if newHP < 0 then
      changeStage = true
      hp:SwitchStage()
      local redImageID = hp:GetCurStageImage()
      local yellowImageID = hp:GetPreStageImage()
      table.insert(changeInfoList, {
        redHP = 0,
        whiteHP = 0,
        changeStage = true,
        redImageID = redImageID,
        yellowImageID = yellowImageID
      })
    else
      hp:SetStageHP(newHP)
      local hpPercent = 1 - hp:GetCurStageHPPercent()
      table.insert(changeInfoList, {
        redHP = hpPercent,
        whiteHP = hpPercent,
        changeStage = false
      })
    end
    changeHP = curStageHP + changeHP
  end
  local stage = hp:GetCurStage()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.UpdateWorldBossHP, defenderEntity:GetID(), changeInfoList, damage, stage)
end

function PlayDamageService:_RefreshBossHP(TT, defenderEntity, damageInfo)
  local hasBoss = defenderEntity:HasBoss()
  local curShowBossHP = defenderEntity:BuffView():HasBuffEffect(BuffEffectType.CurShowBossHP)
  if (hasBoss or curShowBossHP) and not defenderEntity:MonsterID():IsWorldBoss() then
    local maxhp = defenderEntity:HP():GetMaxHP()
    local redhp = defenderEntity:HP():GetRedHP()
    local hpPercent = redhp / maxhp
    if 0 < redhp and hpPercent < 0.01 then
      hpPercent = 0.01
    end
    local curShield = defenderEntity:HP():GetShieldValue()
    if damageInfo:IsMultiHPSwitch() then
      local switchCount = damageInfo:GetMultiHPSwitchCount()
      maxhp = damageInfo:GetMultiHPCurMaxHP()
      redhp = damageInfo:GetMultiHPFinalHP()
      hpPercent = redhp / maxhp
      if 0 < redhp and hpPercent < 0.01 then
        hpPercent = 0.01
      end
      local svcPlayBuff = self._world:GetService("PlayBuff")
      for i = 1, switchCount do
        svcPlayBuff:PlayBuffView(TT, NTMultiHPSwitch:New(i))
      end
      local newMultiHPStage = damageInfo:GetNewMultiHPStage()
      GameGlobal.EventDispatcher():Dispatch(GameEventType.BossSwitchMultiHP, defenderEntity:GetID(), hpPercent, switchCount, newMultiHPStage)
    else
      GameGlobal.EventDispatcher():Dispatch(GameEventType.UpdateBossRedHp, defenderEntity:GetID(), hpPercent, redhp, maxhp)
      GameGlobal.EventDispatcher():Dispatch(GameEventType.UpdateBossWhiteHp, defenderEntity:GetID(), hpPercent, redhp, maxhp)
    end
    GameGlobal.EventDispatcher():Dispatch(GameEventType.UpdateBossShield, defenderEntity:GetID(), curShield, redhp, maxhp, damageInfo:IsInitShield())
    local greyVal = defenderEntity:HP():GetGreyHP()
    GameGlobal.EventDispatcher():Dispatch(GameEventType.UpdateBossGreyHP, defenderEntity:GetID(), greyVal, redhp, maxhp)
    local showCurseHp = defenderEntity:HP():GetShowCurseHp()
    local curseHpValue = defenderEntity:HP():GetCurseHpValue()
    GameGlobal.EventDispatcher():Dispatch(GameEventType.UpdateBossCurseHP, defenderEntity:GetID(), showCurseHp, curseHpValue, redhp, maxhp)
  end
end

function PlayDamageService:_RefreshTeamHP(TT, entity, damageInfo)
  local teamEntity
  if entity:HasPetPstID() then
    teamEntity = entity:Pet():GetOwnerTeamEntity()
  else
    teamEntity = entity
  end
  if teamEntity:HasTeam() then
    local hpCmpt = teamEntity:HP()
    GameGlobal.EventDispatcher():Dispatch(GameEventType.TeamHPChange, {
      isLocalTeam = self._world:Player():IsLocalTeamEntity(teamEntity),
      currentHP = hpCmpt:GetRedHP(),
      maxHP = hpCmpt:GetMaxHP(),
      hitpoint = hpCmpt:GetWhiteHP(),
      shield = hpCmpt:GetShieldValue(),
      entityID = teamEntity:GetID(),
      showCurseHp = hpCmpt:GetShowCurseHp(),
      curseHpVal = hpCmpt:GetCurseHpValue()
    })
  end
end

function PlayDamageService:DisplayDamage(TT, defenderEntity, damageInfo, damageStageValueList, intervalTime)
  if self._cheatHideDamageDisplay then
    return
  end
  local trapRenderCmpt = defenderEntity:TrapRender()
  if trapRenderCmpt and trapRenderCmpt:GetTrapType() ~= TrapType.Protected then
    return
  end
  local beAttackPos = damageInfo:GetShowPosition()
  local boardServiceRender = self._world:GetService("BoardRender")
  local beAttackRenderPos
  if damageInfo:GetShowType() == DamageShowType.Single then
    local gridPos = defenderEntity:GetDamageCenter()
    if not gridPos then
      Log.fatal("PlayDamageService displayDamage defenderEntity has no damage center ", defenderEntity:GetID())
      return
    end
    local tmpPos = boardServiceRender:GridPos2RenderPos(gridPos)
    beAttackRenderPos = Vector3(tmpPos.x, tmpPos.y + BattleConst.SingleDamageNumberShowHeight, tmpPos.z)
  else
    local gridPos = damageInfo:GetRenderGridPos()
    if not gridPos then
      gridPos = defenderEntity:GetDamageCenter()
      Log.debug("SkillDamageNoPos")
    end
    if not gridPos then
      Log.fatal("PlayDamageService displayDamage defenderEntity has no damage center ", defenderEntity:GetID())
      return
    end
    local tmpPos = boardServiceRender:GridPos2RenderPos(gridPos)
    beAttackRenderPos = Vector3(tmpPos.x, tmpPos.y + BattleConst.GridDamageNumberShowHeight, tmpPos.z)
  end
  local eAvatar
  if defenderEntity:HasTeam() then
    local eTeamLeader = defenderEntity:Team():GetTeamLeaderEntity()
    local cEffectHolder = eTeamLeader:EffectHolder()
    if cEffectHolder then
      local tAvatar = cEffectHolder:GetEffectList("BuffViewShowHidePetRoot") or {}
      eAvatar = tAvatar[1]
    end
  else
    local cEffectHolder = defenderEntity:EffectHolder()
    if cEffectHolder then
      local tAvatar = cEffectHolder:GetEffectList("BuffViewShowHidePetRoot") or {}
      eAvatar = tAvatar[1]
    end
  end
  if eAvatar then
    local damageCenter = eAvatar:GetDamageCenter()
    local tmpPos = boardServiceRender:GridPos2RenderPos(damageCenter)
    beAttackRenderPos = Vector3.New(tmpPos.x, tmpPos.y + BattleConst.GridDamageNumberShowHeight, tmpPos.z)
  end
  damageInfo:SetShowPosition(beAttackRenderPos)
  self:_DisposeDamageValue(defenderEntity, damageInfo)
  if not GameGlobal.GetModule(SkillPerfModule):IsBeginPerf() then
    if not damageStageValueList then
      GameGlobal.TaskManager():CoreGameStartTask(self._ShowDamageTask, self, damageInfo)
    else
      GameGlobal.TaskManager():CoreGameStartTask(self._ShowDamageTaskMultiStage, self, damageInfo, damageStageValueList, intervalTime)
    end
  end
  local playSkillService = self._world:GetService("PlaySkill")
  if damageInfo and damageInfo:GetDropAssetList() then
    local beAttackPos = boardServiceRender:BoardRenderPos2GridPos(beAttackRenderPos)
    playSkillService:DoDropAnimation(damageInfo:GetDropAssetList(), beAttackPos)
  end
end

function PlayDamageService:_DisposeDamageValue(defenderEntity, damageInfo)
end

function PlayDamageService:SingleOrGrid(skillID)
  if not skillID then
    return DamageShowType.Grid
  end
  local skillConfigData = self._configService:GetSkillConfigData(skillID)
  local selectMode = skillConfigData:GetTargetSelectionModeConfig()
  if selectMode and selectMode == SkillTargetSelectionMode.Entity then
    return DamageShowType.Single
  else
    return DamageShowType.Grid
  end
end

function PlayDamageService:_ShowDamageTask(TT, damageInfo)
  if damageInfo:GetDamageType() == DamageType.RealDead and damageInfo:GetDamageValue() == 0 then
    return
  end
  local hudEntity, uiview, viewObj = self:_PlayHudDamageCreate(TT, damageInfo)
  local damagePos = damageInfo:GetShowPosition()
  damagePos = damagePos or hudEntity:Location().Position
  local renderBattleService = self._world:GetService("RenderBattle")
  local pos = renderBattleService:GridRenderPos2HudWorldPos(damagePos)
  pos.z = 0
  viewObj.transform.position = pos
  YIELD(TT)
  YIELD(TT)
  viewObj.transform:DOScale(Vector3(1, 1, 1), 0.16)
  if not self._damageCount then
    self._damageCount = 0
  end
  if self._damageCount == 1000 * #BattleConst.DamageHighestPointList then
    self._damageCount = 0
  end
  self._damageCount = self._damageCount + 1
  local damagePosIndex = self._damageCount % #BattleConst.DamageHighestPointList + 1
  local damagePos = BattleConst.DamageHighestPointList[damagePosIndex]
  damagePos = Vector3(viewObj.transform.position.x + damagePos.x, damagePos.y + viewObj.transform.position.y, viewObj.transform.position.z)
  viewObj.transform:DOMove(damagePos, 0.16)
  YIELD(TT, 160)
  self:_PlayHudDamageDisappear(TT, uiview, hudEntity)
end

function PlayDamageService:_ShowDamageTaskMultiStage(TT, damageInfo, damageStageValueList, intervalTime)
  local hudEntity, uiview, viewObj = self:_PlayHudDamageCreate(TT, damageInfo)
  local damagePos = damageInfo:GetShowPosition()
  damagePos = damagePos or hudEntity:Location().Position
  damagePos = damagePos + Vector3(-0.5, 0.5, 0)
  local renderBattleService = self._world:GetService("RenderBattle")
  local pos = renderBattleService:GridRenderPos2HudWorldPos(damagePos)
  pos.z = 0
  viewObj.transform.position = pos
  YIELD(TT)
  YIELD(TT)
  local damageType = damageInfo:GetDamageType()
  if not self._isDamageTypeNoFigure[damageType] then
    local textCtrl = uiview:GetUIComponent("UILocalizationText", "Text")
    for i = 1, #damageStageValueList do
      textCtrl:SetText(tostring(damageStageValueList[i]))
      viewObj.transform.position = pos
      local moveToPos = pos + Vector3(0, 0.1, 0)
      local tweenerMove = viewObj.transform:DOMove(moveToPos, intervalTime / 1000)
      viewObj.transform.localScale = Vector3(1, 1, 1)
      local tweenerScale = viewObj.transform:DOScale(Vector3(1.5, 1.5, 1), intervalTime / 1000)
      YIELD(TT, intervalTime)
      tweenerMove:Kill()
      tweenerScale:Kill()
    end
  end
  YIELD(TT, 160)
  self:_PlayHudDamageDisappear(TT, uiview, hudEntity)
end

function PlayDamageService:_PlayHudDamageCreate(TT, damageInfo)
  local damageType = damageInfo:GetDamageType()
  local entityID = self._damageType2EntityID[damageType]
  local entityService = self._world:GetService("RenderEntity")
  local hudEntity = entityService:CreateRenderEntity(entityID, true)
  local viewCmpt = hudEntity:View()
  local viewObj = viewCmpt:GetGameObject()
  viewObj.transform.localScale = Vector3(2, 2, 1)
  viewCmpt.ViewWrapper:SetVisible(true)
  local uiview = viewObj:GetComponent("UIView")
  local textCtrl, elementImage
  elementImage = uiview:GetUIComponent("Image", "elementIcon")
  if not self._isDamageTypeNoFigure[damageType] then
    textCtrl = uiview:GetUIComponent("UILocalizationText", "Text")
    if textCtrl then
      textCtrl:SetText(tostring(math.floor(damageInfo:GetDamageValue())))
      textCtrl.color = Color(1, 1, 1, 1)
    end
    elementImage.color = Color(1, 1, 1, 1)
    if damageType ~= DamageType.Recover then
      local elementIconName
      if damageType == DamageType.Normal then
        elementIconName = self._damageElementType[damageInfo:GetElementType()]
      else
        elementIconName = self._deBuffElementType[damageType]
      end
      if elementIconName ~= nil then
        elementImage.sprite = InnerGameHelperRender:GetInstance():GetImageFromInnerUI(elementIconName)
        elementImage.color = Color(1, 1, 1, 1)
      end
      if damageType == DamageType.NoElementNormal then
        elementImage.gameObject:SetActive(false)
      end
    end
  end
  return hudEntity, uiview, viewObj
end

function PlayDamageService:_PlayHudDamageDisappear(TT, uiview, hudEntity)
  local textCtrl = uiview:GetUIComponent("UILocalizationText", "Text")
  local elementImage = uiview:GetUIComponent("Image", "elementIcon")
  local frame = 1
  local fadeFrame = 20
  while frame <= fadeFrame do
    if textCtrl then
      textCtrl.color = Color(1, 1, 1, (fadeFrame - frame) / fadeFrame)
    end
    if elementImage then
      elementImage.color = Color(1, 1, 1, (fadeFrame - frame) / fadeFrame)
    end
    frame = frame + 1
    YIELD(TT)
  end
  if textCtrl then
    textCtrl.color = Color(1, 1, 1, 0)
  end
  if elementImage then
    elementImage.color = Color(1, 1, 1, 0)
  end
  self._world:DestroyEntity(hudEntity)
end

function PlayDamageService:TTUpdateHPAndDisplayDamage(TT, defenderEntity, damageInfo)
  if defenderEntity:MonsterID() and defenderEntity:MonsterID():GetDamageSyncMonsterID() then
    local utilDataSvc = self._world:GetService("UtilData")
    local damageSyncEntityList = utilDataSvc:FindSyncMonsterTargetList(defenderEntity)
    for i, entity in ipairs(damageSyncEntityList) do
      local pos = entity:GetRenderGridPosition()
      local newDamageInfo = DamageInfo:New()
      newDamageInfo:Clone(damageInfo)
      newDamageInfo:SetShowPosition(pos)
      newDamageInfo:SetRenderGridPos(pos)
      newDamageInfo:SetTargetEntityID(entity:GetID())
      self:TTUpdateHPAndDisplayDamage(TT, entity, newDamageInfo)
    end
  end
  self:UpdateTargetHPBar(TT, defenderEntity, damageInfo)
  self:_OnHpChangeNotifyBuff(TT, defenderEntity, damageInfo:GetChangeHP(), damageInfo)
  self:DisplayDamage(TT, defenderEntity, damageInfo)
end

function PlayDamageService:CheatHideDamageDisplay(bHide)
  self._cheatHideDamageDisplay = bHide
end

function PlayDamageService:OnTeamOrderChangeRefresh()
end
