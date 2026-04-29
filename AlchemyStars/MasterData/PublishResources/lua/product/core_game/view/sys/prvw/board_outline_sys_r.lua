require("reactive_system")
_class("BoardOutlineSystem_Render", ReactiveSystem)
BoardOutlineSystem_Render = BoardOutlineSystem_Render

function BoardOutlineSystem_Render:Constructor(world)
  self._world = world
end

function BoardOutlineSystem_Render:GetTrigger(world)
  local group = world:GetGroup(world.BW_WEMatchers.BoardOutline)
  local c = Collector:New({group}, {"Added"})
  return c
end

function BoardOutlineSystem_Render:Filter(entity)
  return entity:HasView()
end

function BoardOutlineSystem_Render:ExecuteEntities(entities)
  local e = entities[1]
  local go = e:View().ViewWrapper.GameObject
  if not go then
    Log.error("board out line not have gameobject")
    return
  end
  local animation = go:GetComponent(typeof(UnityEngine.Animation))
  local clip = "eff_hhqh_bq_2"
  local turn = e:BoardOutline():IsPlayerTurn()
  if not turn then
    clip = "eff_hhqh_bq_1"
  end
  animation:Play(clip, UnityEngine.PlayMode.StopAll)
end
