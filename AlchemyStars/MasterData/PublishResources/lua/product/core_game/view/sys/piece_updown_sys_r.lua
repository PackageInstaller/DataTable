_class("PieceUpdownSystem_Render", ReactiveSystem)
PieceUpdownSystem_Render = PieceUpdownSystem_Render

function PieceUpdownSystem_Render:Constructor(world)
  self._world = world
  self._pieceMaterials = {
    [PieceType.Any] = ResourceManager:GetInstance():SyncLoadAsset("eff_gezi_xiachen_Rainbow.mat", LoadType.Mat),
    [PieceType.Blue] = ResourceManager:GetInstance():SyncLoadAsset("eff_gezi_xiachen_Blue.mat", LoadType.Mat),
    [PieceType.Green] = ResourceManager:GetInstance():SyncLoadAsset("eff_gezi_xiachen_Green.mat", LoadType.Mat),
    [PieceType.Red] = ResourceManager:GetInstance():SyncLoadAsset("eff_gezi_xiachen_Red.mat", LoadType.Mat),
    [PieceType.Yellow] = ResourceManager:GetInstance():SyncLoadAsset("eff_gezi_xiachen_Yellow.mat", LoadType.Mat)
  }
end

function PieceUpdownSystem_Render:GetTrigger(world)
  local c = Collector:New({
    world:GetGroup(world.BW_WEMatchers.PieceUpdown)
  }, {"Added"})
  return c
end

function PieceUpdownSystem_Render:Filter(entity)
  return entity:HasView()
end

function PieceUpdownSystem_Render:ExecuteEntities(entities)
  for i = 1, #entities do
    self:Apply(entities[i])
  end
end

function PieceUpdownSystem_Render:Apply(e)
  local pos = e:PieceUpdown():GetPos()
  local utilData = self._world:GetService("UtilData")
  local pieceType = utilData:FindPieceElement(pos)
  local mat = self._pieceMaterials[pieceType]
  if not mat then
    Log.error("PieceUpdownSystem_Render not find piece type material type=", pieceType)
    return
  end
  local isdown = e:PieceUpdown():IsDown()
  local go = e:View().ViewWrapper.GameObject
  local render = go:GetComponentInChildren(typeof(UnityEngine.MeshRenderer))
  render.sharedMaterials = {
    mat.Obj
  }
  local anim = go:GetComponent(typeof(UnityEngine.Animation))
  if isdown then
    anim:Play("eff_gezi_xiachen", UnityEngine.PlayMode.StopAll)
  else
    anim:Play("eff_gezi_shangsheng", UnityEngine.PlayMode.StopAll)
  end
end
