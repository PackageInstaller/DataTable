require("base_ins_r")
_class("PlayCollectEffectInstruction", BaseInstruction)
PlayCollectEffectInstruction = PlayCollectEffectInstruction

function PlayCollectEffectInstruction:Constructor(paramList)
end

function PlayCollectEffectInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local arrResult = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.AddCollectDropNum)
  if not arrResult or not casterEntity:View() then
    return
  end
  local configService = world:GetService("Config")
  local levelConfigData = configService:GetLevelConfigData()
  local maxCollect = levelConfigData:GetLevelCollectItem()
  for index, value in ipairs(arrResult) do
    local dropWorldPos = casterEntity:View():GetGameObject().transform.position
    local dropUIWorldPos = self:_CalcUIWorldPos(world, dropWorldPos + Vector3(0, 0.5, 0))
    world:EventDispatcher():Dispatch(GameEventType.ShowCollectDropInfo, dropUIWorldPos)
  end
end

function PlayCollectEffectInstruction:_CalcUIWorldPos(world, dropPos)
  local camera = world:MainCamera():Camera()
  local screenPos = camera:WorldToScreenPoint(dropPos)
  local uiCam = GameGlobal.UIStateManager():GetControllerCamera("UIBattle")
  local UIWorldPos = uiCam:ScreenToWorldPoint(screenPos)
  return Vector2(UIWorldPos.x, UIWorldPos.y)
end
