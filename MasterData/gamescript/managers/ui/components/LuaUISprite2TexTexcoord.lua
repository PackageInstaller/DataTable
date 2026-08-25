local LuaUISprite2TexTexcoord = NewClass("LuaUISprite2TexTexcoord")
local Sprite2TexTexcoordTag = CS.UnityEngine.Shader.PropertyToID("_Sprite2TexTexcoord")
local T_Image = typeof(CS.UnityEngine.UI.Image)
local FullRectCoord = CS.UnityEngine.Vector4(0, 0, 1, 1)
local TEMP_VEC4 = CS.UnityEngine.Vector4(0, 0, 1, 1)

function LuaUISprite2TexTexcoord:ctor(container)
  self.container = container
  self.image = container:GetComponent(T_Image)
end

function LuaUISprite2TexTexcoord:OnEnable()
  self.forUpdateImage = false
  self:_CreateMaterial()
end

function LuaUISprite2TexTexcoord:_CreateMaterial()
  if not self.materialModifier and self.image and self.image.material then
    self.materialModifier = Instantiate(self.image.material)
    if self.materialModifier then
      self.image.material = self.materialModifier
    end
  end
end

function LuaUISprite2TexTexcoord:Update()
  self:_CreateMaterial()
  if not self.image or not self.materialModifier then
    return
  end
  if not self.image.sprite or self._useFullRectCoord then
    self.materialModifier:SetVector(Sprite2TexTexcoordTag, FullRectCoord)
    return
  end
  if self.image.sprite then
    local rect = self.image.sprite.textureRect
    local texWidth = self.image.sprite.texture.width
    local texHeight = self.image.sprite.texture.height
    local minx = rect.x / texWidth
    local miny = rect.y / texHeight
    local width = rect.width / texWidth
    local height = rect.height / texHeight
    TEMP_VEC4.x = minx
    TEMP_VEC4.y = miny
    TEMP_VEC4.z = width
    TEMP_VEC4.w = height
    self.materialModifier:SetVector(Sprite2TexTexcoordTag, TEMP_VEC4)
    if not self.forUpdateImage then
      self.forUpdateImage = true
      self.image.enabled = false
      self.image.enabled = true
    end
  end
end

function LuaUISprite2TexTexcoord:OnDestroy()
  if self.materialModifier then
    Destroy(self.materialModifier)
    self.materialModifier = nil
  end
end

return LuaUISprite2TexTexcoord
