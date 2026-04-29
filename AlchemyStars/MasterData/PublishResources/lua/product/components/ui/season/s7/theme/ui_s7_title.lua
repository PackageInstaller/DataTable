_class("UIS7Title", UICustomWidget)
UIS7Title = UIS7Title

function UIS7Title:OnShow()
end

function UIS7Title:_SetTexture(targetWidget, srcName)
  local test = self:_LoadAsset(srcName, LoadType.Mat)
  if test then
    local srcMat = self:GetAsset(srcName, LoadType.Mat)
    local eftImg = self:GetUIComponent("RawImage", targetWidget)
    eftImg.material:SetTexture("_MainTex", srcMat.mainTexture)
  end
end

function UIS7Title:_LoadAsset(name, type)
  local req = ResourceManager:GetInstance():SyncLoadAsset(name, type)
  if req == nil or req.Obj == nil then
    Log.info("UIS7Title:_LoadAsset() name =", name, "type =", type)
    return
  end
  return req.Obj
end
