_class("UIS4Title", UICustomWidget)
UIS4Title = UIS4Title

function UIS4Title:OnShow()
  self:_SetTexture("MainTitle", "s4_zjm_03_01.mat")
end

function UIS4Title:_SetTexture(targetWidget, srcName)
  local test = self:_LoadAsset(srcName, LoadType.Mat)
  if test then
    local srcMat = self:GetAsset(srcName, LoadType.Mat)
    local eftImg = self:GetUIComponent("RawImage", targetWidget)
    eftImg.material:SetTexture("_MainTex", srcMat.mainTexture)
  end
end

function UIS4Title:_LoadAsset(name, type)
  local req = ResourceManager:GetInstance():SyncLoadAsset(name, type)
  if req == nil or req.Obj == nil then
    Log.info("UIS4Title:_LoadAsset() name =", name, "type =", type)
    return
  end
  return req.Obj
end
