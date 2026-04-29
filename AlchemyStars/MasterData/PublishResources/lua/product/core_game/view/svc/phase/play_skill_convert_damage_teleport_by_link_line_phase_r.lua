require("play_skill_phase_base_r")
_class("PlaySkillConvertDamageTeleportByLinkLinePhase", PlaySkillPhaseBase)
PlaySkillConvertDamageTeleportByLinkLinePhase = PlaySkillConvertDamageTeleportByLinkLinePhase

function PlaySkillConvertDamageTeleportByLinkLinePhase:PlayFlight(TT, casterEntity, phaseParam)
  local param = phaseParam
  local resultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local skillResult = resultContainer:GetEffectResultByArray(SkillEffectType.ConvertAndDamageByLinkLine)
  if not skillResult then
    return
  end
  self._skillID = resultContainer:GetSkillID()
  self._chainPath = skillResult:GetChainPath()
  self._teleportResult = skillResult:GetTeleportResult()
  self._convertResult = skillResult:GetConvertResult()
  self._damageResult = skillResult:GetDamageResult()
  self:_PlayOpening(param)
  local beginDelayTime = param:GetBeginDelayTime()
  if 0 < beginDelayTime then
    YIELD(TT, beginDelayTime)
  end
  self._convertInfoList = {}
  if #self._chainPath > 1 then
    self:_DoWalk(TT, casterEntity, param)
  end
  self:_DestroyLinkLine()
  if self._damageResult then
    self:_DoDamage(TT, casterEntity, param)
  else
    self:_DoBack(TT, casterEntity, param)
  end
  if self._teleportResult then
    self:_DoTeleport(TT, casterEntity)
  end
  local playBuffSvc = self._world:GetService("PlayBuff")
  local nt = NTGridConvert:New(casterEntity, self._convertInfoList)
  nt:SetConvertEffectType(SkillEffectType.ConvertAndDamageByLinkLine)
  playBuffSvc:PlayBuffView(TT, nt)
  self:_PlayEnding(TT, param)
end

function PlaySkillConvertDamageTeleportByLinkLinePhase:_PlayOpening(param)
  local cameraEffID = param:GetCameraEffID()
  if cameraEffID and 0 < cameraEffID then
    self._cameraEff = self._effectService:CreateScreenEffPointEffect(cameraEffID)
  end
  local sceneEffID = param:GetSceneEffID()
  local sceneEffPos = param:GetSceneEffPos()
  if sceneEffID and 0 < sceneEffID then
    self._sceneEff = self._effectService:CreateWorldPositionEffect(sceneEffID, sceneEffPos)
  end
  local animNames = {
    param:GetSceneEffAnimIn(),
    param:GetSceneEffAnimIdle()
  }
  self:_PlayAnimation(self._sceneEff, animNames)
  AudioHelperController.PlayInnerGameSfx(param:GetStartAudioID())
end

function PlaySkillConvertDamageTeleportByLinkLinePhase:_DoWalk(TT, casterEntity, param)
  local moveTime = param:GetMoveSpeedTime() / 1000
  local moveSpeed = 1 / moveTime
  local hasWalkPoint = false
  if #self._chainPath > 0 then
    hasWalkPoint = true
  end
  local walkAnim = param:GetMoveAnim()
  if hasWalkPoint then
    self:_StartMoveAnimation(casterEntity, walkAnim, true)
    local moveTrailEffect = param:GetMoveTrailEffect()
    self:_PlayMoveTrailEffect(casterEntity, moveTrailEffect)
  end
  self._convertEffList = {}
  local boardServiceRender = self._world:GetService("BoardRender")
  local pathLength = #self._chainPath
  local hasAttack = self._damageResult ~= nil
  for index, walkPos in ipairs(self._chainPath) do
    local curPos = boardServiceRender:GetRealEntityGridPos(casterEntity)
    if index ~= 1 then
      casterEntity:AddGridMove(moveSpeed, walkPos, curPos)
      local walkDir = walkPos - curPos
      casterEntity:SetDirection(walkDir)
      while casterEntity:HasGridMove() do
        YIELD(TT)
      end
    end
    local convertEff = self:_PlayConvertEff(index, pathLength, walkPos, hasAttack, param)
    if convertEff then
      table.insert(self._convertEffList, convertEff)
      AudioHelperController.PlayInnerGameSfx(param:GetConvertAudioID())
    end
    local pos, pieceType = self:_GetConvertPosAndType(index, pathLength, walkPos, hasAttack)
    if pos and pieceType then
      self:_PlayConvert(TT, pos, pieceType)
    end
    self:_DestroyLinkLine(walkPos)
  end
  if hasWalkPoint then
    self:_StartMoveAnimation(casterEntity, walkAnim, false)
    self:_PlayMoveTrailEffect(casterEntity)
  end
end

function PlaySkillConvertDamageTeleportByLinkLinePhase:_StartMoveAnimation(casterEntity, anim, isMove)
  local curVal = casterEntity:GetAnimatorControllerBoolsData(anim)
  if curVal ~= isMove then
    local statTable = {}
    statTable[anim] = isMove
    casterEntity:SetAnimatorControllerBools(statTable)
  end
end

function PlaySkillConvertDamageTeleportByLinkLinePhase:_PlayMoveTrailEffect(casterEntity, trailEffect)
  if casterEntity and casterEntity:HasView() then
    local go = casterEntity:View():GetGameObject()
    local rootTF = go.transform:Find("Root")
    local trailEffectExCmpt = rootTF.gameObject:GetComponent(typeof(TrailsFX.TrailEffectEx))
    if trailEffectExCmpt then
      UnityEngine.Object.Destroy(trailEffectExCmpt)
    end
    casterEntity:RemoveTrailEffectEx()
    if trailEffect then
      trailEffectExCmpt = rootTF.gameObject:AddComponent(typeof(TrailsFX.TrailEffectEx))
      local resServ = self._world.BW_Services.ResourcesPool
      local containerTrailEffect = resServ:LoadAsset(trailEffect)
      if not containerTrailEffect then
        resServ:CacheAsset(trailEffect, 1)
        containerTrailEffect = resServ:LoadAsset(trailEffect)
      end
      assert(containerTrailEffect)
      casterEntity:AddTrailEffectEx(containerTrailEffect, trailEffectExCmpt)
    end
  end
end

function PlaySkillConvertDamageTeleportByLinkLinePhase:_PlayConvertEff(index, maxCount, pos, hasAttack, param)
  local needConvertEff = false
  if hasAttack then
    if index ~= maxCount then
      needConvertEff = true
    end
  elseif index ~= 1 then
    needConvertEff = true
  end
  if not needConvertEff then
    return
  end
  local convertEffID = param:GetConvertEffID()
  if convertEffID and 0 < convertEffID then
    local convertEff = self._effectService:CreateWorldPositionEffect(convertEffID, pos)
    return convertEff
  end
end

function PlaySkillConvertDamageTeleportByLinkLinePhase:_GetConvertPosAndType(index, maxCount, pos, hasAttack)
  if hasAttack then
    if not self._teleportResult then
      return
    end
    if index == 1 then
      return self._teleportResult:GetPosOld(), self._teleportResult:GetColorOld()
    elseif index == maxCount then
      return self._teleportResult:GetPosNew(), self._teleportResult:GetColorNew()
    end
  end
  if self._convertResult then
    local convertPosList = self._convertResult:GetTargetGridArray()
    local convertType = self._convertResult:GetTargetElementType()
    for _, convertPos in ipairs(convertPosList) do
      if convertPos == pos then
        return pos, convertType
      end
    end
  end
end

function PlaySkillConvertDamageTeleportByLinkLinePhase:_PlayConvert(TT, pos, pieceType)
  local oldGridType = PieceType.None
  local pieceSvc = self._world:GetService("Piece")
  local gridEntity = pieceSvc:FindPieceEntity(pos)
  local pieceCmpt = gridEntity:Piece()
  if pieceCmpt then
    oldGridType = pieceCmpt:GetPieceType()
  end
  local convertInfo = NTGridConvert_ConvertInfo:New(pos, oldGridType, pieceType)
  table.insert(self._convertInfoList, convertInfo)
  local boardService = self._world:GetService("BoardRender")
  boardService:ReCreateGridEntity(pieceType, pos, false)
  local piece_service = self._world:GetService("Piece")
  if piece_service then
    piece_service:SetPieceAnimNormal(pos)
  end
end

function PlaySkillConvertDamageTeleportByLinkLinePhase:_DestroyLinkLine(moveInPos)
  local reBoard = self._world:GetRenderBoardEntity()
  local linkRendererDataCmpt = reBoard:LinkRendererData()
  local allEntities = linkRendererDataCmpt:GetLinkLineEntityList()
  local removeList = {}
  local boardServiceRender = self._world:GetService("BoardRender")
  for _, linkLineEntity in ipairs(allEntities) do
    local pos = boardServiceRender:GetRealEntityGridPos(linkLineEntity)
    if not moveInPos or pos == moveInPos then
      table.insert(removeList, linkLineEntity)
    end
  end
  local linkageRenderService = self._world:GetService("LinkageRender")
  for _, e in ipairs(removeList) do
    linkageRenderService:DestroyLinkLine(e)
  end
end

function PlaySkillConvertDamageTeleportByLinkLinePhase:_DoDamage(TT, casterEntity, param)
  local boardServiceRender = self._world:GetService("BoardRender")
  local targetPos = self._damageResult:GetGridPos()
  local curPos = boardServiceRender:GetRealEntityGridPos(casterEntity)
  local attackDir = targetPos - curPos
  casterEntity:SetDirection(attackDir)
  local attackAnim = param:GetAttackAnim()
  casterEntity:SetAnimatorControllerTriggers({attackAnim})
  AudioHelperController.PlayInnerGameSfx(param:GetAttackAudioID())
  local gatherEffIDList = param:GetGatherEffIDList()
  if gatherEffIDList then
    for _, effID in ipairs(gatherEffIDList) do
      self._effectService:CreateEffect(effID, casterEntity)
    end
  end
  local attackEffDelayTime = param:GetAttackEffDelayTime()
  if attackEffDelayTime then
    YIELD(TT, attackEffDelayTime)
  end
  local attackEffID = param:GetAttackEffID()
  if attackEffID and 0 < attackEffID then
    self._effectService:CreateEffect(attackEffID, casterEntity)
  end
  local hitDelayTime = param:GetHitDelayTime()
  if hitDelayTime then
    hitDelayTime = hitDelayTime - attackEffDelayTime
    if 0 < hitDelayTime then
      YIELD(TT, hitDelayTime)
    end
  end
  local targetID = self._damageResult:GetTargetID()
  local targetEntity = self._world:GetEntityByID(targetID)
  local damageInfo = self._damageResult:GetDamageInfo(1)
  local hitAnimName = param:GetHitAnim()
  local skillID = self._skillID
  local beHitParam = HandleBeHitParam:New():SetHandleBeHitParam_CasterEntity(casterEntity):SetHandleBeHitParam_TargetEntity(targetEntity):SetHandleBeHitParam_HitAnimName(hitAnimName):SetHandleBeHitParam_DamageInfo(damageInfo):SetHandleBeHitParam_DamagePos(targetPos):SetHandleBeHitParam_DeathClear(false):SetHandleBeHitParam_IsFinalHit(false):SetHandleBeHitParam_SkillID(skillID)
  self._skillService:HandleBeHit(TT, beHitParam)
  local attackEffTime = param:GetAttackEffTime()
  if attackEffTime then
    local delayTime = attackEffTime - hitDelayTime
    YIELD(TT, delayTime)
  end
end

function PlaySkillConvertDamageTeleportByLinkLinePhase:_DoBack(TT, casterEntity, param)
  local teleportDelayTime = param:GetTeleportDelayTime()
  if teleportDelayTime then
    YIELD(TT, teleportDelayTime)
  end
  AudioHelperController.PlayInnerGameSfx(param:GetTeleportAudioID())
  local boardServiceRender = self._world:GetService("BoardRender")
  local curPos = boardServiceRender:GetRealEntityGridPos(casterEntity)
  if #self._chainPath == 0 then
    return
  end
  local targetPos = self._chainPath[1]
  self:_RoleShow(casterEntity, false, false)
  local disappearEffID = param:GetDisappearEffID()
  if disappearEffID and 0 < disappearEffID then
    self._effectService:CreateWorldPositionEffect(disappearEffID, curPos)
  end
  local disappearTime = param:GetDisappearTime()
  if disappearTime then
    YIELD(TT, disappearTime)
  end
  local appearEffID = param:GetAppearEffID()
  if appearEffID and 0 < appearEffID then
    self._effectService:CreateWorldPositionEffect(appearEffID, targetPos)
  end
  local appearDelayTime = param:GetAppearDelayTime()
  if appearDelayTime then
    YIELD(TT, appearDelayTime)
  end
  casterEntity:SetPosition(targetPos)
  self:_RoleShow(casterEntity, true, true)
end

function PlaySkillConvertDamageTeleportByLinkLinePhase:_RoleShow(entity, showRole, showBloodSlider)
  entity:SetViewVisible(showRole)
  local sliderEntityID = 0
  if entity:HasPetPstID() then
    local captainEntity = entity:Pet():GetOwnerTeamEntity()
    sliderEntityID = captainEntity:HP():GetHPSliderEntityID()
  else
    sliderEntityID = entity:HP():GetHPSliderEntityID()
  end
  local sliderEntity = self._world:GetEntityByID(sliderEntityID)
  if sliderEntity then
    sliderEntity:SetViewVisible(showBloodSlider)
  end
end

function PlaySkillConvertDamageTeleportByLinkLinePhase:_DoTeleport(TT, casterEntity)
  local newDir = self._teleportResult:GetDirNew()
  local newPos = self._teleportResult:GetPosNew()
  local oldPos = self._teleportResult:GetPosOld()
  local trapServiceRender = self._world:GetService("TrapRender")
  local pieceService = self._world:GetService("Piece")
  if casterEntity:HasPetPstID() then
    trapServiceRender:ShowHideTrapAtPos(newPos, false)
    local teamEntity = casterEntity:Pet():GetOwnerTeamEntity()
    local teamLeaderEntity = teamEntity:Team():GetTeamLeaderEntity()
    local pets = teamEntity:Team():GetTeamPetEntities()
    for _, petEntity in ipairs(pets) do
      petEntity:SetPosition(newPos)
    end
    teamEntity:SetLocation(newPos, newDir)
    teamLeaderEntity:SetLocation(newPos, newDir)
    pieceService:RemovePrismAt(newPos)
  end
  local playBuffSvc = self._world:GetService("PlayBuff")
  local nt = NTTeleport:New(casterEntity, oldPos, newPos)
  playBuffSvc:PlayBuffView(TT, nt)
end

function PlaySkillConvertDamageTeleportByLinkLinePhase:_PlayEnding(TT, param)
  local cameraOutAnim = param:GetCameraEffAnimOut()
  if cameraOutAnim then
    self:_PlayAnimation(self._cameraEff, {cameraOutAnim})
  end
  AudioHelperController.PlayInnerGameSfx(param:GetStartAudioID())
  local sceneOutDelayTime = param:GetSceneOutDelayTime()
  if sceneOutDelayTime then
    YIELD(TT, sceneOutDelayTime)
  end
  local sceneOutAnim = param:GetSceneEffAnimOut()
  if sceneOutAnim then
    self:_PlayAnimation(self._sceneEff, {sceneOutAnim})
  end
  local convertOutAnim = param:GetConvertEffAnimOut()
  if self._convertEffList then
    for _, entity in ipairs(self._convertEffList) do
      self:_PlayAnimation(entity, {convertOutAnim})
    end
  end
  local endDelayTime = param:GetEndDelayTime()
  if endDelayTime then
    YIELD(TT, endDelayTime)
  end
  self._world:DestroyEntity(self._cameraEff)
  self._world:DestroyEntity(self._sceneEff)
  if self._convertEffList then
    for _, entity in ipairs(self._convertEffList) do
      self._world:DestroyEntity(entity)
    end
  end
end

function PlaySkillConvertDamageTeleportByLinkLinePhase:_PlayAnimation(entity, animNames)
  if entity and entity:HasView() then
    local go = entity:View():GetGameObject()
    local anim = go:GetComponentInChildren(typeof(UnityEngine.Animation))
    if anim == nil then
      Log.fatal("Cant play legacy animation, animation not found in ", go.name)
      return
    end
    if table.count(animNames) > 1 then
      anim:Stop()
      for i = 1, #animNames do
        anim:PlayQueued(animNames[i])
      end
    else
      anim:Play(animNames[1])
    end
  end
end
