require("base_ins_r")
_class("PlayCameraMoveTargetPosInstruction", BaseInstruction)
PlayCameraMoveTargetPosInstruction = PlayCameraMoveTargetPosInstruction

function PlayCameraMoveTargetPosInstruction:Constructor(paramList)
  self._time = tonumber(paramList.time)
  local strPos = paramList.pos
  if strPos then
    local arr = string.split(strPos, "|")
    self._pos = Vector3(tonumber(arr[1]), tonumber(arr[2]), tonumber(arr[3]))
  else
    self._pos = Vector3.zero
  end
  self._block = tonumber(paramList.block)
  self._boardCenter = nil
  local strBoardCenter = paramList.boardCenter
  if strBoardCenter then
    local arr = string.split(strBoardCenter, "|")
    self._boardCenter = Vector3(tonumber(arr[1]), tonumber(arr[2]), tonumber(arr[3]))
  end
end

function PlayCameraMoveTargetPosInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local mainCameraCmpt = world:MainCamera()
  local mainCamera = mainCameraCmpt:Camera()
  local cameraTran = mainCamera.transform
  cameraTran:DOMove(self._pos, self._time / 1000.0, false)
  local monsterGroup = world:GetGroup(world.BW_WEMatchers.HP)
  for _, e in ipairs(monsterGroup:GetEntities()) do
    local hpComponent = e:HP()
    if e:IsViewVisible() and hpComponent then
      hpComponent:SetShowHPSliderState(false)
      e:ReplaceHPComponent()
    end
  end
  if self._block == 1 then
    YIELD(TT, self._time)
    self:SetCameraAndHpSlider(world)
  else
    GameGlobal.TaskManager():CoreGameStartTask(function(TT)
      YIELD(TT, self._time)
      self:SetCameraAndHpSlider(world)
    end)
  end
end

function PlayCameraMoveTargetPosInstruction:SetCameraAndHpSlider(world)
  local mainCameraCmpt = world:MainCamera()
  mainCameraCmpt:SetCameraPos(self._pos)
  if self._boardCenter then
    local battleRenderCmpt = world:BattleRenderConfig()
    battleRenderCmpt:SetCurWaveBoardCenter(self._boardCenter)
  end
  local monsterGroup = world:GetGroup(world.BW_WEMatchers.HP)
  for _, e in ipairs(monsterGroup:GetEntities()) do
    local hpComponent = e:HP()
    if e:IsViewVisible() and hpComponent then
      hpComponent:SetShowHPSliderState(true)
      e:ReplaceHPComponent()
      hpComponent:SetHPPosDirty(true)
    end
  end
end
