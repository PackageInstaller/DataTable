require("base_ins_r")
_class("PlaySpineInstruction", BaseInstruction)
PlaySpineInstruction = PlaySpineInstruction

function PlaySpineInstruction:Constructor(paramList)
  self._spineName = paramList.spineName
  self._spineLength = tonumber(paramList.spineLength)
  self._waitSpineTime = tonumber(paramList.waitSpineTime)
  self._spineResRequest = nil
end

function PlaySpineInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local battleRenderConfigCmpt = world:BattleRenderConfig()
  local canPlayCG = battleRenderConfigCmpt:GetCanPlaySkillSpineInBattle(self._spineName)
  if not canPlayCG then
    return
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ShowUltraSkillSpine, self._spineName)
  self._waitSpineTimerEvent = GameGlobal.Timer():AddEvent(self._spineLength, function()
    GameGlobal.EventDispatcher():Dispatch(GameEventType.StopUltraSkillSpine, self._spineName)
    self._waitSpineTimerEvent = nil
    self._spineResRequest:Dispose()
    self._spineResRequest = nil
  end)
  YIELD(TT, self._waitSpineTime)
end

function PlaySpineInstruction:Prepare(TT, casterEntity)
  self._spineResRequest = ResourceManager:GetInstance():AsyncLoadAsset(TT, self._spineName .. ".prefab", LoadType.GameObject)
end
