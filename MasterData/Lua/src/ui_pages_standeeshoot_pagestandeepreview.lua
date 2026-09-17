local this = class("pageStandeePreview", G_UIPageBase)

function this:bind()
  return {isActive_img = false}
end

function this:methods()
  return {
    onClick_btnSave = function(self)
      self:saveCapture()
    end,
    onClick_btnShoot = function(self)
      L_UI:close(self.pageName)
    end
  }
end

function this:created(obj, pageConfig)
  this.super.created(self, obj, pageConfig)
end

function this:open(options)
  self.bind.isActive_img = true
  self.tex = options.tex
  self.slotId = options.slotId
  self.heroConfigId = options.heroConfigId
  self.actionId = options.actionId
  self.bindComponents.heroimg.texture = self.tex
  self.bindComponents.RawImage.texture = self.tex
  self.bindComponents.shadow.texture = self.tex
  self:setOutline()
  self.bindComponents.RawImage:SetNativeSize()
  self.bindComponents.heroimg:SetNativeSize()
  self.bindComponents.shadow:SetNativeSize()
  self.bindComponents.trans_heroImg.localScale = C_Vector3(1.25, 1.25, 1.25)
end

function this:saveCapture()
  if self.uploading then
    return
  end
  self.uploading = true
  self:uploadCapture()
end

function this:uploadCapture()
  local tex = self.tex
  local bytes = Unity.ImageConversion.EncodeToPNG(self.tex)
  local uploadKey = {
    L_PhotoStore.path.imgStandeeHeroCDNPath,
    L_PlayerStore:getPlayerId(),
    "_",
    self.slotId,
    "_",
    self.heroConfigId,
    "_",
    self.actionId,
    "_",
    tostring(C_HttpManager.ConvertDataTime())
  }
  uploadKey = table.concat(uploadKey)
  
  local function onSucc(key)
    local strArr = string.split(key, "/")
    key = strArr[#strArr]
    local path = L_PlayerDisplayStore:getTexFilePath(key, L_PlayerStore:getPlayerId())
    C_PhotoManager.SaveTexture2DByPath(path, tex, false)
    L_PlayerDisplayStore:req_setCustomHeroSlot({
      config = self.slotId,
      url = uploadKey
    }, function()
      L_PlayerDisplayStore:updateCaptureInfo(self.slotId, uploadKey)
      L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_player_card_customed_plates_saved"))
      L_UI:close(self.pageName)
      L_UI:close("pageStandeeShoot")
    end)
  end
  
  C_CDNManager.TransferUploadBytes(bytes, uploadKey, onSucc, function()
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_pageStandeePreview"))
    self.uploading = false
  end)
end

function this:setOutline()
  local SDFGenorateToShader = self.bindComponents.SDFGenorateToShader
  SDFGenorateToShader.inputTexture = self.tex
  local rt = SDFGenorateToShader:GenerateSDFWithJFA()
  self.sdf = rt
end

function this:close(options)
  if self.tex then
    CS.Azur.Gameplay.Core.Asset.AssetManager.Instance:DestroyNewAsset(self.tex)
    self.tex = nil
  end
  if self.sdf then
    self.bindComponents.SDFGenorateToShader:DestoryAssets()
    self.sdf = nil
  end
end

function this:destroy(options)
  if self.tex then
    CS.Azur.Gameplay.Core.Asset.AssetManager.Instance:DestroyNewAsset(self.tex)
    self.tex = nil
  end
  if self.sdf then
    self.bindComponents.SDFGenorateToShader:DestoryAssets()
    self.sdf = nil
  end
end

return this
