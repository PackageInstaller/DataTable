require("base_ins_r")
_class("PlayRubikCubeInstruction", BaseInstruction)
PlayRubikCubeInstruction = PlayRubikCubeInstruction

function PlayRubikCubeInstruction:Constructor(paramList)
  self._rotateRootName = "RubikCubeRotateRoot"
  self._rotateRootPos = Vector3(-1, -3.5, 0)
  self._rotateTime = tonumber(paramList.rotateTime) or 3000
  self._startWaitTime = tonumber(paramList.startWaitTime) or 0
  self._startEffectID = tonumber(paramList.startEffectID)
  self._rotateEffectID = tonumber(paramList.rotateEffectID)
  self._completeEffectID = tonumber(paramList.completeEffectID)
  self._glowEffectID1 = tonumber(paramList.glowEffectID1)
  self._glowEffectID2 = tonumber(paramList.glowEffectID2)
end

function PlayRubikCubeInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local resultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.RubikCube)
  if resultArray == nil then
    Log.fatal("PlayRubikCubeInstruction, result is nil.")
    return
  end
  local playSkillInstructionService = world:GetService("PlaySkillInstruction")
  local pieceService = world:GetService("Piece")
  local PieceMultiService = world:GetService("PieceMulti")
  local boardServiceRender = world:GetService("BoardRender")
  local boardMultiServiceRender = world:GetService("BoardMultiRender")
  local trapSvc = world:GetService("TrapRender")
  local renderEntityService = world:GetService("RenderEntity")
  local effectService = world:GetService("Effect")
  local renderBoardEntity = world:GetRenderBoardEntity()
  local renderBoardComponent = renderBoardEntity:RenderBoard()
  local renderMultiBoardComponent = renderBoardEntity:RenderMultiBoard()
  local rotateRoot = UnityEngine.GameObject.Find(self._rotateRootName)
  rotateRoot = rotateRoot or UnityEngine.GameObject:New(self._rotateRootName)
  rotateRoot.transform.position = self._rotateRootPos
  rotateRoot.transform.localEulerAngles = Vector3.zero
  local rubikModle = UnityEngine.GameObject.Find("mfro_pfb_magiccube")
  local rubikRotateModle = UnityEngine.GameObject.Find("mfro_mod_magiccube_01")
  local sceneEffectScale = Vector3(0.998, 0.998, 0.998)
  for moveIndex, v in ipairs(resultArray) do
    local targetAngle = v:GetRubikCubeTargetAngle()
    local arrPiece = {}
    local allEntity = {}
    local entityResult = v:GetRubikCubeEntities()
    local prismResult = v:GetRubikCubePrisms()
    local convertResult = v:GetConvertColors()
    local trapDestoryList = v:GetTrapDestroyList()
    for i, r in ipairs(convertResult) do
      local oldPos, newPos, oldPieceType, newPieceType, fromBoard, toBoard = r[1], r[2], r[3], r[4], r[5], r[6]
      local pieceEntity
      if fromBoard == 1 then
        pieceEntity = pieceService:FindPieceEntity(oldPos)
      else
        pieceEntity = PieceMultiService:FindPieceEntity(fromBoard, oldPos)
      end
      if pieceEntity then
        local t = {
          pieceEntity,
          oldPos,
          newPos,
          fromBoard,
          toBoard
        }
        allEntity[#allEntity + 1] = t
      end
    end
    for i, r in ipairs(entityResult) do
      local eid, oldPos, newPos, fromBoard, toBoard = table.unpack(r)
      local e = world:GetEntityByID(eid)
      if e then
        local t = {
          e,
          oldPos,
          newPos,
          fromBoard,
          toBoard
        }
        allEntity[#allEntity + 1] = t
      end
    end
    for i, v in ipairs(allEntity) do
      local e = v[1]
      local oldPos = v[2]
      local newPos = v[3]
      local fromBoard = v[4]
      local toBoard = v[5]
      if e:HasView() then
        local entityTransform = e:View():GetGameObject().transform
        entityTransform.parent = rotateRoot.transform
      end
      if e:MonsterID() then
        self:_ShowMonsterHPBar(e, false)
        if fromBoard == 1 then
          renderEntityService:DestroyMonsterAreaOutLineEntity(e)
          local curPos = boardServiceRender:GetRealEntityGridPos(e)
          local pos = curPos - e:GridLocation():GetGridOffset()
          local bodyArea = e:BodyArea():GetArea()
          for _, area in ipairs(bodyArea) do
            local workPos = area + pos
            local curPieceAnim = pieceService:GetPieceAnimation(workPos)
            if curPieceAnim == "Down" then
              pieceService:SetPieceAnimUp(workPos)
            end
          end
        end
      end
    end
    local cutPos = Vector3(0, 0, 0)
    local cutAngle = Vector3(0, 0, 0)
    local glowAngle = Vector3(0, 0, 0)
    local aloneBoardID = v:GetAloneBoard()
    if aloneBoardID == 6 then
      rubikModle.transform.localEulerAngles = Vector3(0, 0, 0)
      cutPos = Vector3(-1, -3.5, 0.5)
      cutAngle = Vector3(0, 90, 0)
      glowAngle = Vector3(0, 270, 0)
    elseif aloneBoardID == 5 then
      rubikModle.transform.localEulerAngles = Vector3(0, 180, 0)
      cutPos = Vector3(-1, -3.5, -0.5)
      cutAngle = Vector3(0, 90, 0)
      glowAngle = Vector3(0, 90, 0)
    elseif aloneBoardID == 2 then
      rubikModle.transform.localEulerAngles = Vector3(0, 90, 0)
      cutPos = Vector3(-0.5, -3.5, 0)
      cutAngle = Vector3(0, 0, 0)
      glowAngle = Vector3(0, 0, 0)
    elseif aloneBoardID == 4 then
      rubikModle.transform.localEulerAngles = Vector3(0, 270, 0)
      cutPos = Vector3(-1.5, -3.5, 0)
      cutAngle = Vector3(0, 0, 0)
      glowAngle = Vector3(0, 180, 0)
    end
    local startEffect = effectService:CreateWorldPositionEffect(self._startEffectID, cutPos)
    local startEffectObj = startEffect:View():GetGameObject()
    startEffectObj.transform.localEulerAngles = cutAngle
    startEffectObj.transform.localScale = sceneEffectScale
    YIELD(TT, self._startWaitTime)
    local glowEffect1 = effectService:CreateWorldPositionEffect(self._glowEffectID1, self._rotateRootPos)
    local glowEffectObj1 = glowEffect1:View():GetGameObject()
    local glowEffect2 = effectService:CreateWorldPositionEffect(self._glowEffectID2, self._rotateRootPos)
    local glowEffectObj2 = glowEffect2:View():GetGameObject()
    glowEffectObj2.transform.parent = rotateRoot.transform
    glowEffectObj1.transform.localEulerAngles = glowAngle
    glowEffectObj1.transform.localScale = sceneEffectScale
    glowEffectObj2.transform.localEulerAngles = glowAngle
    glowEffectObj2.transform.localScale = sceneEffectScale
    local rotateEffect = effectService:CreateWorldPositionEffect(self._rotateEffectID, cutPos)
    local rotateEffectObj = rotateEffect:View():GetGameObject()
    rotateEffectObj.transform.parent = rotateRoot.transform
    rotateEffectObj.transform.localEulerAngles = cutAngle
    rotateEffectObj.transform.localScale = sceneEffectScale
    rubikRotateModle.transform.parent = rotateRoot.transform
    rotateRoot.transform:DORotate(targetAngle, self._rotateTime / 1000)
    local completeEffect = effectService:CreateWorldPositionEffect(self._completeEffectID, cutPos)
    local completeEffectObj = completeEffect:View():GetGameObject()
    completeEffectObj.transform.localEulerAngles = cutAngle
    completeEffectObj.transform.localScale = sceneEffectScale
    YIELD(TT, self._rotateTime)
    rubikRotateModle.transform.parent = rubikModle.transform
    rubikRotateModle.transform.localEulerAngles = Vector3(0, 0, 0)
    rubikRotateModle.transform.localPosition = Vector3(0, 0, 0)
    rubikModle.transform.localEulerAngles = Vector3(0, 0, 0)
    for i, r in ipairs(entityResult) do
      local eid, oldPos, newPos, fromBoard, toBoard = table.unpack(r)
      local e = world:GetEntityByID(eid)
      if e then
        if e:HasView() then
          local entityTransform = e:View():GetGameObject().transform
          if toBoard == 1 then
            entityTransform.parent = nil
          else
            local boardRoot = renderMultiBoardComponent:GetMultiBoardRootGameObject(toBoard)
            entityTransform.parent = boardRoot.transform
          end
        end
        if e:MonsterID() and toBoard == 1 then
          self:_ShowMonsterHPBar(e, true)
        end
        local locationComponent = e:Location()
        if locationComponent then
          e:SetPosition(newPos)
        end
      end
    end
    for i, r in ipairs(convertResult) do
      local oldPos, newPos, oldPieceType, newPieceType, fromBoard, toBoard = r[1], r[2], r[3], r[4], r[5], r[6]
      local pieceEntity
      if fromBoard == 1 then
        pieceEntity = pieceService:FindPieceEntity(oldPos)
      else
        pieceEntity = PieceMultiService:FindPieceEntity(fromBoard, oldPos)
      end
      if pieceEntity then
        if pieceEntity:HasView() then
          local entityTransform = pieceEntity:View():GetGameObject().transform
          if fromBoard == 1 then
            entityTransform.parent = nil
          else
            local boardRoot = renderMultiBoardComponent:GetMultiBoardRootGameObject(fromBoard)
            entityTransform.parent = boardRoot.transform
          end
        end
        local locationComponent = pieceEntity:Location()
        if locationComponent then
          pieceEntity:SetPosition(oldPos)
        end
      end
    end
    local notRefreshPrism = true
    for _, r in ipairs(convertResult) do
      local oldPos, newPos, oldPieceType, newPieceType, fromBoard, toBoard = r[1], r[2], r[3], r[4], r[5], r[6]
      local newGridEntity
      if toBoard == 1 then
        newGridEntity = boardServiceRender:ReCreateGridEntity(newPieceType, newPos, false, false, notRefreshPrism)
      else
        newGridEntity = boardMultiServiceRender:ReCreateGridEntity(toBoard, newPieceType, newPos, false, false)
        PieceMultiService:SetPieceAnimUp(toBoard, newPos)
        PieceMultiService:SetPieceAnimDown(toBoard, newPos)
      end
    end
    for i, r in ipairs(convertResult) do
      local oldPos, newPos, oldPieceType, newPieceType, fromBoard, toBoard = r[1], r[2], r[3], r[4], r[5], r[6]
      local pieceEntity
      if fromBoard == 1 then
        pieceEntity = pieceService:FindPieceEntity(oldPos)
      else
        pieceEntity = PieceMultiService:FindPieceEntity(fromBoard, oldPos)
      end
      if pieceEntity and pieceEntity:HasView() then
        local entityTransform = pieceEntity:View():GetGameObject().transform
        if fromBoard == 1 then
          if entityTransform.parent ~= nil then
            entityTransform.parent = nil
          end
        else
          local boardRoot = renderMultiBoardComponent:GetMultiBoardRootGameObject(fromBoard)
          if entityTransform.parent ~= boardRoot.transform then
            entityTransform.parent = boardRoot.transform
          end
        end
        local locationComponent = pieceEntity:Location()
        if locationComponent then
          pieceEntity:SetPosition(oldPos)
        end
        local go = pieceEntity:View():GetGameObject()
        go.transform.localEulerAngles = Vector3(0, 0, 0)
        local pieceComponent = pieceEntity:Piece()
        local curPiecePrefabObj = pieceComponent:GetBaseLayerObj()
        if curPiecePrefabObj then
          curPiecePrefabObj.transform.localEulerAngles = Vector3(0, 0, 0)
        end
      end
    end
    for _, r in pairs(prismResult) do
      local oldPos, newPos, fromBoard, toBoard, pieceEffectType = r[1], r[2], r[3], r[4], r[5]
      if fromBoard == 1 then
        pieceService:SetPieceRenderEffect(oldPos, PieceEffectType.Normal)
      else
        PieceMultiService:SetPieceRenderEffect(fromBoard, oldPos, PieceEffectType.Normal)
      end
      if toBoard == 1 then
        pieceService:SetPieceRenderEffect(newPos, pieceEffectType)
      else
        PieceMultiService:SetPieceRenderEffect(toBoard, newPos, pieceEffectType)
      end
    end
    local donotPlayDie = true
    for _, entityID in ipairs(trapDestoryList) do
      local entity = world:GetEntityByID(entityID)
      trapSvc:PlayTrapDieSkill(TT, {entity}, donotPlayDie)
    end
  end
  YIELD(TT)
  pieceService:RefreshPieceAnim()
  pieceService:RefreshMonsterAreaOutLine(TT)
end

function PlayRubikCubeInstruction:_ShowMonsterHPBar(monsterEntity, isShow)
  local cHP = monsterEntity:HP()
  if not cHP then
    return
  end
  cHP:SetShowHPSliderState(isShow)
  monsterEntity:ReplaceHPComponent()
end
