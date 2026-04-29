_class("UIS5Title", UICustomWidget)
UIS5Title = UIS5Title

function UIS5Title:OnShow()
end

function UIS5Title:_SetTexture(targetWidget, srcName)
  local test = self:_LoadAsset(srcName, LoadType.Mat)
  if test then
    local srcMat = self:GetAsset(srcName, LoadType.Mat)
    local eftImg = self:GetUIComponent("RawImage", targetWidget)
    eftImg.material:SetTexture("_MainTex", srcMat.mainTexture)
  end
end

function UIS5Title:_LoadAsset(name, type)
  local req = ResourceManager:GetInstance():SyncLoadAsset(name, type)
  if req == nil or req.Obj == nil then
    Log.info("UIS5Title:_LoadAsset() name =", name, "type =", type)
    return
  end
  return req.Obj
end
