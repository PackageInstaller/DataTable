_class("DataListenerServiceRender", BaseService)
DataListenerServiceRender = DataListenerServiceRender

function DataListenerServiceRender:Constructor(world)
  self._world = world
  self._autoBinder = AutoEventBinder:New(self._world:EventDispatcher())
  Log.notice("DataListenerServiceRender start")
  self._autoBinder:BindEvent(GameEventType.DataLogicResult, self, self._OnDataLogicResult)
  self._autoBinder:BindEvent(GameEventType.DataBuffRoundCount, self, self._OnDataBuffRoundCount)
  self._autoBinder:BindEvent(GameEventType.DataBuffMaxRoundCount, self, self._OnDataBuffMaxRoundCount)
  self._autoBinder:BindEvent(GameEventType.DataBuffValue, self, self._OnDataBuffValue)
  self._autoBinder:BindEvent(GameEventType.DataTrapAppearSkill, self, self._OnDataTrapAppearSkill)
  self._autoBinder:BindEvent(GameEventType.DataTrapTriggerSkill, self, self._OnDataTrapTriggerSkill)
  self._autoBinder:BindEvent(GameEventType.DataRenderNTSelectRoundTeamNormalBefore, self, self._OnDataNTSelectRoundTeamNormalBefore)
  self._autoBinder:BindEvent(GameEventType.DataTetrisFeatureRandom, self, self._OnDataTetrisFeatureRandom)
  self._autoBinder:BindEvent(GameEventType.DataTetrisFeatureLock, self, self._OnDataTetrisFeatureLock)
end

function DataListenerServiceRender:Dispose()
  self._autoBinder:UnBindAllEvents()
end

function DataListenerServiceRender:_OnDataLogicResult(logicStep, result)
  if logicStep == 0 then
    local funcname = "_On" .. result._className
    local func = self[funcname]
    if not func then
      Log.fatal("OnDataLogicResult not find handler for ", funcname)
      return
    end
    func(self, result)
    return
  end
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  renderBoardEntity:LogicResult():SetLogicResult(logicStep, result)
end

function DataListenerServiceRender:_OnDataChainPathResult(data)
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local l_role_module = GameGlobal.GetModule(RoleModule)
  if not l_role_module:CheckModuleUnlock(GameModuleID.MD_ForceGuideEnd) then
    local match = GameGlobal.GetModule(MatchModule)
    local enterData = match:GetMatchEnterData()
    if enterData._match_type == MatchType.MT_Mission then
      local l_path = data:GetChainPathResult()
      local l_team = data:GetChainTeamResult()
      local missionID = enterData:GetMissionCreateInfo().mission_id
      local pet_template_id = ""
      local teamEntity = self._world:Player():GetLocalTeamEntity()
      local ePets = teamEntity:Team():GetTeamPetEntities()
      for i, e in ipairs(ePets) do
        local bInTable = table.intable(l_team, e:GetID())
        if bInTable then
          local l_templateId = e:PetPstID():GetTemplateID()
          pet_template_id = pet_template_id .. "," .. l_templateId
        end
      end
      GameGlobal.UAReportForceGuideEvent("FightChainDone", {
        missionID,
        data:GetChainElementResult(),
        l_path and #l_path or 0,
        pet_template_id,
        1
      })
    end
  end
  renderBoardEntity:ReplaceRenderChainPath(data:GetChainPathResult(), data:GetChainElementResult(), data:GetCutChainPathResult(), data:GetPathChainRate())
  renderBoardEntity:ReplaceRenderRoundTeam(data:GetChainTeamResult())
end

function DataListenerServiceRender:_OnDataWaveEnterResult(data)
  local viewDataEntity = self._world:GetRenderBoardEntity()
  local waveDataCmpt = viewDataEntity:WaveData()
  waveDataCmpt:SetWaveIndex(data:GetWaveIndex())
  waveDataCmpt:SetExitWave(data:IsExit())
  waveDataCmpt:SetExitWavePos(data:GetExitPos())
end

function DataListenerServiceRender:_OnDataPetDeadResult(data)
  local deadList = data:DataGetDeadPetEntityIDList()
  for _, v in ipairs(deadList) do
    local petEntity = self._world:GetEntityByID(v)
    if not petEntity:HasPetDeadFlag() then
      petEntity:AddPetDeadFlag()
    end
  end
end

function DataListenerServiceRender:_OnDataAILogicResult(data)
  local aiRecorderCmpt = data:GetAIRecorder()
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  renderBoardEntity:ReplaceAIRecorder(aiRecorderCmpt)
end

function DataListenerServiceRender:_OnDataSkillRoutineResult(data)
  local res = data:GetResult()
  local eid = data:GetEntityID()
  local key = data:GetKey()
  local e = self._world:GetEntityByID(eid)
  e:SkillRoutine():SetResultContainer(res, key)
end

function DataListenerServiceRender:_OnDataTrapCreationResult(data)
  local entityID = data:GetTrapEntityID()
  local trapEntity = self._world:GetEntityByID(entityID)
  local trapRenderCmpt = trapEntity:TrapRender()
  trapRenderCmpt:SetTrapCreationResult(data)
  local trapID = data:GetTrapCreationResult_TrapID()
  local trapConfigData = self._configService:GetTrapConfigData()
  local trapData = trapConfigData:GetTrapData(trapID)
  trapRenderCmpt:SetTrapType(trapData.TrapType)
end

function DataListenerServiceRender:_OnDataAttributeResult(data)
  local entityID = data:GetEntityID()
  local entity = self._world:GetEntityByID(entityID)
  local renderAttrCmpt = entity:RenderAttributes()
  renderAttrCmpt:SetAttribute(data:GetAttrName(), data:GetAttrValue())
end

function DataListenerServiceRender:_OnDataBuffLogicResult(buffResult)
  local logicName = buffResult:GetBuffLogicName()
  local result = buffResult:GetBuffResult()
  local notify = buffResult:GetNotify()
  local seq = buffResult:GetBuffSeq()
  local eid = buffResult:GetEntityID()
  local triggers = buffResult:GetTriggers()
  local entity = self._world:GetEntityByID(eid)
  local viewInstance = entity:BuffView():GetBuffViewInstance(seq)
  if viewInstance then
    viewInstance:AddBuffView(notify, logicName, result, triggers)
  end
end

function DataListenerServiceRender:_OnDataBuffAddResult(data)
  local eid = data:GetEntityID()
  local buffseq = data:GetBuffSeq()
  local buffid = data:GetBuffID()
  local context = data:GetBuffContext()
  local entity = self._world:GetEntityByID(eid)
  local view = BuffViewInstance:New(entity, buffseq, buffid, context)
  entity:BuffView():AddBuffViewInstance(view)
end

function DataListenerServiceRender:_OnDataBuffDelResult(data)
  local eid = data:GetEntityID()
  local buffseq = data:GetBuffSeq()
  local nt = data:GetNotifyType()
  local buffid = data:GetBuffID()
  local entity = self._world:GetEntityByID(eid)
  local viewInstance = entity:BuffView():GetBuffViewInstance(buffseq)
  if viewInstance then
    viewInstance:SetUnload(nt)
  end
end

function DataListenerServiceRender:_OnDataBuffRoundCount(eid, buffseq, roundcount)
  local entity = self._world:GetEntityByID(eid)
  local viewInstance = entity:BuffView():GetBuffViewInstance(buffseq)
  if not viewInstance then
    return
  end
  viewInstance:SetRoundCount(roundcount)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.BuffRoundCountChanged, buffseq, viewInstance:RemainRoundCount(), viewInstance:GetMaxRoundCount() == 0)
end

function DataListenerServiceRender:_OnDataBuffMaxRoundCount(eid, buffseq, roundcount)
  local entity = self._world:GetEntityByID(eid)
  local viewInstance = entity:BuffView():GetBuffViewInstance(buffseq)
  viewInstance:SetMaxRoundCount(roundcount)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.BuffRoundCountChanged, buffseq, viewInstance:RemainRoundCount(), viewInstance:GetMaxRoundCount() == 0)
end

function DataListenerServiceRender:_OnDataBuffValue(eid, key, value)
  local entity = self._world:GetEntityByID(eid)
  entity:BuffView():SetBuffValue(key, value)
end

function DataListenerServiceRender:_OnDataDeadMarkResult(data)
  local list = data:GetDeadEntityIDList()
  for i, id in ipairs(list) do
    local e = self._world:GetEntityByID(id)
    e:AddDeadFlag()
  end
end

function DataListenerServiceRender:_OnDataBoardLogicResult(data)
  local e = self._world:GetPreviewEntity()
  local env = e:PreviewEnv()
  env:ResetPreviewEnv()
  env:ResetPieceTypes(data:GetPieceTypes())
  env:ResetPiecesEffectTypeList(data:GetPiecesEffectTypeList())
  env:ResetPrismEntityIDs(data:GetPrismEntityIDs())
  env:ResetPieceBlocks(data:GetBlockFlags())
  env:ResetPieceTable(data:GetPieceTable())
  env:ResetImmuneHitbacks(data:GetImmuneHitbacks())
  env:ResetPieceEntities(data:GetPieceEntities())
end

function DataListenerServiceRender:_OnDataPieceTypeResult(data)
  local e = self._world:GetPreviewEntity()
  local env = e:PreviewEnv()
  env:ResetPieceTypes(data:GetPieceTypes())
  env:ResetPieceTable(data:GetPieceTable())
  local renderBoard = self._world:GetRenderBoardEntity():RenderBoard()
  local renderBoardSvc = self._world:GetService("BoardRender")
  local utilData = self._world:GetService("UtilData")
  local extraBoardPosList = utilData:GetExtraBoardPosList()
  for posIdx, pieceType in pairs(data:GetPieceTypes()) do
    local pos = Vector2.Index2Pos(posIdx)
    if not table.intable(extraBoardPosList, pos) then
      local e = renderBoard:GetGridRenderEntity(pos)
      if e then
        if e:Piece():GetPieceType() ~= pieceType then
          renderBoardSvc:ReCreateGridEntity(pieceType, pos)
        end
      else
        Log.fatal("_OnDataPieceTypeResult,can not find piece entity,pos:", pos)
      end
    end
  end
end

function DataListenerServiceRender:_OnDataChessPathResult(data)
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local chessPathResult = data:GetChessPathResult()
  local chessPetEntityID = data:GetChessPetEntityID()
  local walkResultList = data:GetChessWalkResultList()
  local pickUpPos = data:GetChessPickUpPos()
  renderBoardEntity:ReplaceRenderChessPath(chessPathResult, chessPetEntityID, walkResultList, pickUpPos)
end

function DataListenerServiceRender:_OnDataSanRoundDecreaseResult(data)
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local renderFeature = renderBoardEntity:RenderFeature()
  if renderFeature then
    renderFeature:SetCurRoundDecreaseSanValue(1, data:GetModifyVal(), data:GetCurVal(), data:GetOldVal(), data:GetDebtVal(), data:GetModifyTimes())
  end
end

function DataListenerServiceRender:_OnDataDayNightRoundChangeResult(data)
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local renderFeature = renderBoardEntity:RenderFeature()
  if renderFeature then
    renderFeature:SetCurRoundDayNightRouncChangeValue(1, data:GetCurState(), data:GetOldState(), data:GetRestRound())
  end
end

function DataListenerServiceRender:_OnDataSyncMovePathResult(data)
  local eid = data:GetEntityID()
  local entity = self._world:GetEntityByID(eid)
  if entity then
    local syncMoveCmptRender = entity:RenderSyncMoveWithTeam()
    if syncMoveCmptRender then
      syncMoveCmptRender:RecordSyncMovePath(data:GetSyncMovePathResult())
    end
  end
end

function DataListenerServiceRender:_OnDataTrapAppearSkill(data)
  local eTrap = data:GetTrapEntity()
  eTrap:TrapRender():SetAppearSkillResultContainer(data:GetResultContainer())
end

function DataListenerServiceRender:_OnDataTrapTriggerSkill(data)
  local eTrap = data:GetTrapEntity()
  local cTrapRender = eTrap:TrapRender()
  cTrapRender:SetTriggerSkillResultContainer(data:GetResultContainer())
  cTrapRender:SetTriggerSkillTriggeredEntity(data:GetTriggerEntity())
end

function DataListenerServiceRender:_OnDataNTSelectRoundTeamNormalBefore(elementType, chainPath)
  local ntSelectRoundTeamNormalBefore = NTSelectRoundTeamNormalBefore:New(elementType, chainPath)
  GameGlobal.TaskManager():CoreGameStartTask(function(TT)
    self._world:GetService("PlayBuff"):PlayBuffView(TT, ntSelectRoundTeamNormalBefore)
  end)
end

function DataListenerServiceRender:_OnDataPickUpComponentResult(data)
end

function DataListenerServiceRender:_OnDataUnscaledCountDownFinish(data)
  local flagID = data:GetFlagID()
  local group = self._world:GetGroup(self._world.BW_WEMatchers.UnscaledCountDownRender)
  for i, e in ipairs(group:GetEntities()) do
    local cmpt = e:UnscaledCountDownRender()
    if flagID == cmpt:GetFlagID() then
      cmpt:SetWaitPlayNotify(true)
      break
    end
  end
end

function DataListenerServiceRender:_OnDataStepPointRoundChangeResult(data)
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local renderFeature = renderBoardEntity:RenderFeature()
  if renderFeature then
    renderFeature:SetCurRoundChangeStepPoint(1, data:GetCurVal(), data:GetOldVal())
  end
end

function DataListenerServiceRender:_OnDataStepPointMoveCostResult(data)
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local renderFeature = renderBoardEntity:RenderFeature()
  if renderFeature then
    renderFeature:SetMoveCostStepPoint(1, data:GetCurVal(), data:GetOldVal())
  end
end

function DataListenerServiceRender:_OnDataColorPaletteResult(data)
  local entity = self._world:GetEntityByID(data:EntityID())
  if entity then
    if not entity:HasColorPaletteRender() then
      entity:AddColorPaletteRender()
    end
    local colorPaletteRenderComponent = entity:ColorPaletteRender()
    colorPaletteRenderComponent:Clear()
  end
end

function DataListenerServiceRender:_OnDataTetrisFeatureRandom(newTetrisIndex, newTetrisType)
  local featureSvcR = self._world:GetService("FeatureRender")
end

function DataListenerServiceRender:_OnDataTetrisFeatureLock(lockState)
end
