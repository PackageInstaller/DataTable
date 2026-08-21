_class("UIS6Title", UICustomWidget)
UIS6Title = UIS6Title

function UIS6Title:OnShow()
end

function UIS6Title:_SetTexture(targetWidget, srcName)
  local test = self:_LoadAsset(srcName, LoadType.Mat)
  if test then
    local srcMat = self:GetAsset(srcName, LoadType.Mat)
    local eftImg = self:GetUIComponent("RawImage", targetWidget)
    eftImg.material:SetTexture("_MainTex", srcMat.mainTexture)
  end
end

function UIS6Title:_LoadAsset(name, type)
  local req = ResourceManager:GetInstance():SyncLoadAsset(name, type)
  if req == nil or req.Obj == nil then
    Log.info("UIS6Title:_LoadAsset() name =", name, "type =", type)
    return
  end
  return req.Obj
end
