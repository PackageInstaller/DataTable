_class("UIS8Title", UICustomWidget)
UIS8Title = UIS8Title

function UIS8Title:OnShow()
  self:_SetTexture("_MainTex", "s8_Title_02.mat")
end

function UIS8Title:_SetTexture(targetWidget, srcName)
  local req = ResourceManager:GetInstance():SyncLoadAsset(srcName, LoadType.Mat)
  if req then
    local srcMat = self:GetAsset(srcName, LoadType.Mat)
    self:GetUIComponent("MeshRenderer", "eff").material:SetTexture(targetWidget, srcMat.mainTexture)
  end
end

function UIS8Title:_LoadAsset(name, type)
  local req = ResourceManager:GetInstance():SyncLoadAsset(name, type)
  if req == nil or req.Obj == nil then
    Log.info("UIS8Title:_LoadAsset() name =", name, "type =", type)
    return
  end
  return req.Obj
end
