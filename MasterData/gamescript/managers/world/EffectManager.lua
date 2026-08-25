local EffectManager, Super = System.NewClass("EffectManager", Manager)

function EffectManager:ctor()
  Super.ctor(self)
  self.go2path = {}
end

function EffectManager:Awake()
  Super.Awake(self)
end

function EffectManager:PlayEffect(path, parent, pos, rot, scale)
  local obj = ResLoadMgr.LoadAsset(path, self)
  local effectObj = CS.UnityEngine.Object.Instantiate(obj)
  self.go2path[effectObj] = path
  if nil == effectObj then
    Logger.Debug("Effect is nil path == %s", path)
    return
  end
  if parent then
    effectObj.transform:SetParent(parent)
  end
  if pos then
    effectObj.transform.localPosition = pos
  else
    effectObj.transform.localPosition = CS.UnityEngine.Vector3(0, 0, 0)
  end
  if rot then
    effectObj.transform.localEulerAngles = rot
  else
    effectObj.transform.localEulerAngles = CS.UnityEngine.Vector3(0, 0, 0)
  end
  if scale then
    effectObj.transform.localScale = scale
  else
    effectObj.transform.localScale = CS.UnityEngine.Vector3(1, 1, 1)
  end
  return effectObj
end

function EffectManager:DestroyEffect(gameObject)
  if gameObject then
    local path = self.go2path[gameObject]
    self.go2path[gameObject] = nil
    CS.UnityEngine.Object.Destroy(gameObject)
    if path then
      ResLoadMgr.SubRef(path, self, true)
    end
  end
end

function EffectManager:OnDestroy()
  Super.OnDestroy(self)
  ResLoadMgr.UnloadAssetByTarget(self)
end

return EffectManager
