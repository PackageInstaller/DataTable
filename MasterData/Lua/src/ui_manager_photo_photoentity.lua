local this = class("photoEntity")
local photoImg

function this:bindGameObject(go)
  if go == self.gameObject then
    return
  end
  self:dispose()
  self.gameObject = go
  if not L_CommonUtil.isValid(go) then
    return
  end
  self.rawImgHead = go:GetComponent(typeof(C_LRawImage))
  self.imgHead = go:GetComponent(typeof(C_LImage))
  self:refreshImg()
end

function this:setImgName(name, callBack)
  if not L_CommonUtil.isValid(self.gameObject) then
    return
  end
  if string.isEmpty(name) then
    return
  end
  self.callBack = callBack
  if self.name == name then
    self:refreshImg()
    return
  end
  if self.texture then
    C_PhotoManager.ReleaseTexture(self.texture)
  end
  self.texture = nil
  self.name = name
  self:setImg()
end

function this:setImg()
  if self.texture == nil then
    self:createTexWithName(self.name)
  else
    self:refreshImg()
  end
end

function this:refreshImg()
  if not L_CommonUtil.isValid(self.gameObject) then
    return
  end
  if self.rawImgHead ~= nil and self.texture ~= nil then
    self.rawImgHead.texture = self.texture
  elseif self.imgHead ~= nil and self.sprite ~= nil then
    self.imgHead:SetSprite(self.sprite)
    self.imgHead.dynamicAtlasPath = nil
  end
  if self.callBack ~= nil then
    self.callBack()
    self.callBack = nil
  end
end

function this:createTexWithName(name)
  L_PhotoManager:loadHeadTex(name, function(tex)
    if tex then
      if self.texture then
        C_PhotoManager.ReleaseTexture(self.texture)
        self.texture = nil
      end
      if not L_CommonUtil.isValid(self.gameObject) then
        C_PhotoManager.ReleaseTexture(tex)
        return
      end
      self.texture = tex
      local rect = C_Rect(0, 0, tex.width, tex.height)
      local pivot = C_Vector2.one * 0.5
      self.sprite = Unity.Sprite.Create(tex, rect, pivot)
      self:refreshImg()
    end
  end)
end

function this:dispose()
  self.gameObject = nil
  self.rawImgHead = nil
  self.imgHead = nil
  self.name = nil
  if self.texture then
    C_PhotoManager.ReleaseTexture(self.texture)
    self.texture = nil
  end
end

return this
