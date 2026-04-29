_class("CanMoveArrowService", Object)
CanMoveArrowService = CanMoveArrowService

function CanMoveArrowService:Constructor(world)
  self._world = world
  self._arrowOffsetList = {}
  self._arrowEntityList = {}
  self.autoBinder = AutoEventBinder:New(GameGlobal.EventDispatcher())
  self.autoBinder:BindEvent(GameEventType.ShowCanMoveArrow, self, self.ShowCanMoveArrowCallBack)
  self.autoBinder:BindEvent(GameEventType.HideCanMoveArrow, self, self.HideCanMoveArrowCallBack)
end

function CanMoveArrowService:Dispose()
  self.autoBinder:UnBindAllEvents()
end

function CanMoveArrowService:Initialize()
end

function CanMoveArrowService:InitArrows()
  local upPos = Vector2(0, 1)
  local upDir = Vector2(0, 1)
  local arrowEntity = self:_CreateArrow(upPos, upDir)
  self._arrowOffsetList[#self._arrowOffsetList + 1] = upPos
  self._arrowEntityList[#self._arrowEntityList + 1] = arrowEntity
  local downPos = Vector2(0, -1)
  local downDir = Vector2(0, -1)
  arrowEntity = self:_CreateArrow(downPos, downDir)
  self._arrowOffsetList[#self._arrowOffsetList + 1] = downPos
  self._arrowEntityList[#self._arrowEntityList + 1] = arrowEntity
  local leftPos = Vector2(-1, 0)
  local leftDir = Vector2(-1, 0)
  arrowEntity = self:_CreateArrow(leftPos, leftDir)
  self._arrowOffsetList[#self._arrowOffsetList + 1] = leftPos
  self._arrowEntityList[#self._arrowEntityList + 1] = arrowEntity
  local rightPos = Vector2(1, 0)
  local rightDir = Vector2(1, 0)
  arrowEntity = self:_CreateArrow(rightPos, rightDir)
  self._arrowOffsetList[#self._arrowOffsetList + 1] = rightPos
  self._arrowEntityList[#self._arrowEntityList + 1] = arrowEntity
  local upLeftPos = Vector2(-1, 1)
  local upLeftDir = Vector2(-1, 1)
  arrowEntity = self:_CreateArrow(upLeftPos, upLeftDir)
  self._arrowOffsetList[#self._arrowOffsetList + 1] = upLeftPos
  self._arrowEntityList[#self._arrowEntityList + 1] = arrowEntity
  local upRightPos = Vector2(1, 1)
  local upRightDir = Vector2(1, 1)
  arrowEntity = self:_CreateArrow(upRightPos, upRightDir)
  self._arrowOffsetList[#self._arrowOffsetList + 1] = upRightPos
  self._arrowEntityList[#self._arrowEntityList + 1] = arrowEntity
  local downLeftPos = Vector2(-1, -1)
  local downLeftDir = Vector2(-1, -1)
  arrowEntity = self:_CreateArrow(downLeftPos, downLeftDir)
  self._arrowOffsetList[#self._arrowOffsetList + 1] = downLeftPos
  self._arrowEntityList[#self._arrowEntityList + 1] = arrowEntity
  local downRightPos = Vector2(1, -1)
  local downRightDir = Vector2(1, -1)
  arrowEntity = self:_CreateArrow(downRightPos, downRightDir)
  self._arrowOffsetList[#self._arrowOffsetList + 1] = downRightPos
  self._arrowEntityList[#self._arrowEntityList + 1] = arrowEntity
end

function CanMoveArrowService:ShowCanMoveArrowCallBack()
  self:ShowCanMoveArrow(true)
end

function CanMoveArrowService:HideCanMoveArrowCallBack()
  self:ShowCanMoveArrow(false)
end

function CanMoveArrowService:ShowCanMoveArrow(isShow)
  if self._world:MatchType() == MatchType.MT_PopStar or self._world:MatchType(GetMatchTypeType.NoLinkLine) == MatchType.MT_PopStarPro then
    isShow = false
  end
  if isShow then
    local utilDataSvc = self._world:GetService("UtilData")
    local playerPos = self._world:Player():GetLocalTeamEntity():GetGridPosition()
    for k, arrowEntity in ipairs(self._arrowEntityList) do
      local arrowPos = self._arrowOffsetList[k] + playerPos
      if utilDataSvc:IsValidPiecePos(arrowPos) and not utilDataSvc:IsPosBlockLinkLineForChain(arrowPos) and not utilDataSvc:IsPosBlockMoveForTrapWall(playerPos, arrowPos) then
        self:_ShowArrow(arrowEntity, true)
        arrowEntity:SetPosition(arrowPos)
      else
        self:_ShowArrow(arrowEntity, false)
      end
    end
  else
    for _, arrowEntity in ipairs(self._arrowEntityList) do
      self:_ShowArrow(arrowEntity, false)
    end
  end
end

function CanMoveArrowService:_CreateArrow(pos, dir)
  local sEntity = self._world:GetService("RenderEntity")
  local arrowEntity = sEntity:CreateRenderEntity(EntityConfigIDRender.CanMoveArrow)
  arrowEntity:SetLocation(pos, dir)
  arrowEntity:View():GetGameObject():SetActive(false)
  return arrowEntity
end

function CanMoveArrowService:_ShowArrow(arrowEntity, isShow)
  local viewCmpt = arrowEntity:View()
  if viewCmpt == nil then
    return
  end
  local arrowTransform = viewCmpt:GetGameObject().transform
  if isShow == true then
    arrowEntity:View():GetGameObject():SetActive(true)
  else
    arrowEntity:View():GetGameObject():SetActive(false)
  end
end
