require("base_service")
_class("SpawnPieceServiceRender", BaseService)
SpawnPieceServiceRender = SpawnPieceServiceRender

function SpawnPieceServiceRender:Constructor(world)
end

function SpawnPieceServiceRender:PlayBoardShow(TT, waveBoard)
  local configService = self._world:GetService("Config")
  local levelConfigData = configService:GetLevelConfigData()
  local isMultiBoardLevel = levelConfigData:IsMultiBoardLevel()
  local isSpliceBoardLevel = levelConfigData:IsSpliceBoardLevel()
  local isPushBoardLevel = levelConfigData:IsPushBoardLevel()
  if not waveBoard then
    self:_OnClipBoard(TT)
  end
  local spreadTaskID = GameGlobal.TaskManager():CoreGameStartTask(function(TT)
    if isMultiBoardLevel then
      self:_PlayPieceSpreadEffectNoAnim(TT)
      self:_PlayMultiPieceSpreadEffect(TT)
    elseif isSpliceBoardLevel then
      self:_PlayPieceSpreadEffectNoAnim(TT)
      self:_PlayPieceFakeSpreadEffectNoAnim(TT)
    elseif isPushBoardLevel then
      self:_PlayPieceSpreadEffectNoAnim(TT)
      self:_PlayPushBoardPieceFakeSpreadEffectNoAnim(TT)
    else
      self:_PlayBoardLineEffect(TT)
      self:_PlayPieceSpreadEffect(TT, waveBoard)
    end
  end)
  while not TaskHelper:GetInstance():IsTaskFinished(spreadTaskID) do
    YIELD(TT)
  end
end

function SpawnPieceServiceRender:_OnClipBoard(TT)
  local configService = self._world:GetService("Config")
  local levelConfigData = configService:GetLevelConfigData()
  local gridGenID = levelConfigData:GetGridGenID()
  local boardConfig = Cfg.cfg_board[gridGenID]
  if boardConfig.CellClip then
    UnityEngine.Shader.EnableKeyword("_CELL_CLIP")
    local H3DGZ_ClipParam = UnityEngine.Shader.PropertyToID("_H3DGZ_ClipParams")
    local clipParam = Vector4(boardConfig.CellClip[1], boardConfig.CellClip[2] * -1, boardConfig.CellClip[3], boardConfig.CellClip[4] * -1)
    UnityEngine.Shader.SetGlobalVector(H3DGZ_ClipParam, clipParam)
  end
end

function SpawnPieceServiceRender:_PlayBoardLineEffect(TT)
  local sEffect = self._world:GetService("Effect")
  local utilDataSvc = self._world:GetService("UtilData")
  local posCenter = utilDataSvc:GetBoardCenterPos()
  sEffect:CreateWorldPositionEffect(GameResourceConst.EffBoardShowLine, posCenter, true)
end

function SpawnPieceServiceRender:_PlayPieceSpreadEffect(TT, waveBoard)
  local boardServiceRender = self._world:GetService("BoardRender")
  local teamEntity = self._world:Player():GetLocalTeamEntity()
  local posCenter = Vector2(4, 2)
  if teamEntity then
    local teamLeader = teamEntity:GetTeamLeaderPetEntity()
    posCenter = boardServiceRender:GetRealEntityGridPos(teamLeader)
  end
  local internal = 0.1
  local utilDataSvc = self._world:GetService("UtilData")
  local posList = utilDataSvc:GetCloneBoardGridPos()
  if posList == nil then
    return
  end
  local arrPos = {}
  for _, pos in ipairs(posList) do
    local dis = Vector2.Distance(posCenter, pos)
    dis = math.floor(dis + 0.4) + 1
    if not arrPos[dis] then
      arrPos[dis] = {}
    end
    table.insert(arrPos[dis], pos)
  end
  local sEffect = self._world:GetService("Effect")
  local pieceSvc = self._world:GetService("Piece")
  local tConvertInfo = {}
  local taskIDList = {}
  for dis, arrDis in pairs(arrPos) do
    local randomSortArr = self:_Shuffle(arrDis)
    for _, pos in ipairs(randomSortArr) do
      local ePiece = pieceSvc:FindPieceEntity(pos)
      if ePiece then
        local internal = 0
        if 1 < dis then
          internal = math.random(BattleConst.BoardShowPieceRandomRange.min, BattleConst.BoardShowPieceRandomRange.max)
        end
        local pieceType
        local playBirth = false
        if waveBoard and waveBoard[pos.x] and waveBoard[pos.x][pos.y] then
          pieceType = waveBoard[pos.x][pos.y]
          ePiece = boardServiceRender:ReCreateGridEntity(pieceType, pos)
          local oldColor = utilDataSvc:FindPieceElement(pos)
          local convertInfo = NTGridConvert_ConvertInfo:New(pos, oldColor, pieceType)
          table.insert(tConvertInfo, convertInfo)
          playBirth = true
        elseif not waveBoard then
          playBirth = true
        end
        if playBirth then
          local go = ePiece:View():GetGameObject()
          local taskID = GameGlobal.TaskManager():CoreGameStartTask(self._PlayBirthAnimation, self, go, internal, pos)
          taskIDList[#taskIDList + 1] = taskID
        end
      end
    end
    YIELD(TT, BattleConst.BoardShowPieceGroupInternal)
  end
  while not TaskHelper:GetInstance():IsAllTaskFinished(taskIDList) do
    YIELD(TT)
  end
  if waveBoard then
    local svcPlayBuff = self._world:GetService("PlayBuff")
    if 0 < #tConvertInfo then
      local renderBoardEntity = self._world:GetRenderBoardEntity()
      local notify = NTGridConvert:New(renderBoardEntity, tConvertInfo)
      notify.__attackPosMatchRequired = true
      svcPlayBuff:PlayBuffView(TT, notify)
    end
  else
    self:_PlayBrillantGridLine()
  end
end

function SpawnPieceServiceRender:_PlayBirthNoAnimation(TT, go)
  local curPos = go.transform.position
  curPos.y = 0
  go.transform.position = curPos
end

function SpawnPieceServiceRender:_PlayBirthAnimation(TT, go, internal, pos)
  YIELD(TT, internal)
  self:_PlayBirthNoAnimation(TT, go)
  local pieceSvc = self._world:GetService("Piece")
  pieceSvc:SetPieceAnimBirth(pos)
end

function SpawnPieceServiceRender:_Shuffle(t)
  if type(t) ~= "table" then
    return
  end
  local tab = {}
  local index = 1
  while #t ~= 0 do
    local n = math.random(0, #t)
    if t[n] ~= nil then
      tab[index] = t[n]
      table.remove(t, n)
      index = index + 1
    end
  end
  return tab
end

function SpawnPieceServiceRender:_PlayBrillantGridLine()
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local renderBoardCmpt = renderBoardEntity:RenderBoard()
  local brillantLineObj = renderBoardCmpt:GetBrillantGridObj()
  local lineExtendParam = renderBoardCmpt:GetBrillantGridLineExtendParam()
  if brillantLineObj == nil then
    return
  end
  brillantLineObj:SetActive(true)
  local pieceSvc = self._world:GetService("Piece")
  pieceSvc:SetHasGridLineWithBoardMode(true)
  local levelID = self._world.BW_WorldInfo.level_id
  local levelConfig = Cfg.cfg_level[levelID]
  local themeID = levelConfig.Theme
  local cfgThemeData = Cfg.cfg_theme[themeID]
  local lineParam = cfgThemeData.BrillantWhiteLineParam
  local widthMin = lineParam and lineParam.WidthMin or BattleConst.Wangge_WidthMin
  local widthMax = lineParam and lineParam.WidthMax or BattleConst.Wangge_WidthMax
  local globalWidth = lineParam and lineParam.GlobalWidth or BattleConst.Wangge_GlobalWidth
  local heightMin = lineParam and lineParam.HeightMin or BattleConst.Wangge_HeightMin
  local heightMax = lineParam and lineParam.HeightMax or BattleConst.Wangge_HeightMax
  local globalHeight = lineParam and lineParam.GlobalHeight or BattleConst.Wangge_GlobalHeight
  local renderTransform = GameObjectHelper.FindChild(brillantLineObj.transform, "gezi_wangge")
  local meshRenderCmpt = renderTransform.gameObject:GetComponent(typeof(UnityEngine.MeshRenderer))
  local wanggeMaterial = meshRenderCmpt.material
  wanggeMaterial:SetFloat("_WidthMin", widthMin)
  wanggeMaterial:SetFloat("_WidthMax", widthMax)
  wanggeMaterial:SetFloat("_GlobalWidth", globalWidth)
  wanggeMaterial:SetFloat("_HeightMin", heightMin)
  wanggeMaterial:SetFloat("_HeightMax", heightMax)
  wanggeMaterial:SetFloat("_GlobalHeight", globalHeight)
end

function SpawnPieceServiceRender:InitializeCellRender()
  local piecePosList = {}
  local boardRenderService = self._world:GetService("BoardRender")
  local utilData = self._world:GetService("UtilData")
  local gridEntityData = utilData:GetReplicaGridEntityData()
  if gridEntityData then
    for pos, pieceType in pairs(gridEntityData) do
      if pos.x > 9 or 9 < pos.y then
        local renderPos = boardRenderService:GridPos2RenderPos(pos)
        table.insert(piecePosList, renderPos)
      else
        local renderPos = boardRenderService:GridPos2RenderPos(pos)
        table.insert(piecePosList, renderPos)
      end
    end
  end
  CellRenderManager.DrawRangeImmediate(piecePosList)
end

function SpawnPieceServiceRender:_PlayPieceSpreadEffectNoAnim(TT)
  local utilDataSvc = self._world:GetService("UtilData")
  local posList = utilDataSvc:GetCloneBoardGridPos()
  if posList == nil then
    return
  end
  local pieceSvc = self._world:GetService("Piece")
  pieceSvc:SetHasGridLineWithBoardMode(false)
  local taskIDList = {}
  for _, pos in ipairs(posList) do
    local ePiece = pieceSvc:FindPieceEntity(pos)
    if ePiece then
      local go = ePiece:View():GetGameObject()
      local taskID = GameGlobal.TaskManager():CoreGameStartTask(self._PlayBirthNoAnimation, self, go)
      taskIDList[#taskIDList + 1] = taskID
    end
  end
  while not TaskHelper:GetInstance():IsAllTaskFinished(taskIDList) do
    YIELD(TT)
  end
end

function SpawnPieceServiceRender:_PlayPieceFakeSpreadEffectNoAnim(TT)
  local utilDataSvc = self._world:GetService("UtilData")
  local posList = utilDataSvc:GetCloneBoardSpliceGridPos()
  if posList == nil or table.count(posList) == 0 then
    return
  end
  local pieceSvc = self._world:GetService("Piece")
  local taskIDList = {}
  for _, pos in ipairs(posList) do
    local ePiece = pieceSvc:FindPieceFakeEntity(pos)
    if ePiece then
      local go = ePiece:View():GetGameObject()
      local taskID = GameGlobal.TaskManager():CoreGameStartTask(self._PlayBirthNoAnimation, self, go)
      taskIDList[#taskIDList + 1] = taskID
    end
  end
  while not TaskHelper:GetInstance():IsAllTaskFinished(taskIDList) do
    YIELD(TT)
  end
end

function SpawnPieceServiceRender:_PlayMultiPieceSpreadEffect(TT)
  local utilDataSvc = self._world:GetService("UtilData")
  local multiBoardPieceList = utilDataSvc:GetCloneMultiBoardGridPos()
  if multiBoardPieceList == nil then
    return
  end
  local pieceSvc = self._world:GetService("PieceMulti")
  local taskIDList = {}
  for boardIndex, posList in pairs(multiBoardPieceList) do
    for _, pos in ipairs(posList) do
      local ePiece = pieceSvc:FindPieceEntity(boardIndex, pos)
      local go = ePiece:View():GetGameObject()
      ePiece:SetDirection(Vector3(0, 0, 0))
      local taskID = GameGlobal.TaskManager():CoreGameStartTask(self._PlayMultiBoardShow, self, go)
      taskIDList[#taskIDList + 1] = taskID
    end
  end
  while not TaskHelper:GetInstance():IsAllTaskFinished(taskIDList) do
    YIELD(TT)
  end
end

function SpawnPieceServiceRender:_PlayMultiBoardShow(TT, go)
  local tran = GameObjectHelper.FindChild(go.transform, "gezi")
  go.transform.localEulerAngles = Vector3(0, 0, 0)
end

function SpawnPieceServiceRender:_PlayPushBoardPieceFakeSpreadEffectNoAnim(TT)
  local utilDataSvc = self._world:GetService("UtilData")
  local posList = utilDataSvc:GetCloneBoardPushGridPos()
  if posList == nil or table.count(posList) == 0 then
    return
  end
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local cmpt = renderBoardEntity:RenderBoardPush()
  local taskIDList = {}
  for _, pos in ipairs(posList) do
    local ePiece = cmpt:GetGridRenderEntity(pos)
    if ePiece then
      local go = ePiece:View():GetGameObject()
      local taskID = GameGlobal.TaskManager():CoreGameStartTask(self._PlayBirthNoAnimation, self, go)
      taskIDList[#taskIDList + 1] = taskID
    end
  end
  while not TaskHelper:GetInstance():IsAllTaskFinished(taskIDList) do
    YIELD(TT)
  end
end
