local WU, DB, REF = require("Common/WindowUtil")(this)

function UninitWindow()
  WU.RemoveAllChild(REF.WindowSize)
end

function AddGameObject(obj, worldPos)
  local obj = CS.UnityEngine.GameObject.Instantiate(obj, REF.WindowSize.transform)
  local ref = _ENV["$"](obj)
  ref.root.transform.position = worldPos
  return ref
end
