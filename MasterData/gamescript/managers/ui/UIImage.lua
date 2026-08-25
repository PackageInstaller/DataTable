local UIImage = System.NewClass("UIImage")
local Rect = CS.UnityEngine.Rect
local CreateSprite = CS.UnityEngine.Sprite.Create
local SpriteMeshTypeFullRect = CS.UnityEngine.SpriteMeshType.FullRect
local Destroy = CS.UnityEngine.GameObject.Destroy
local Vec2Zero = CS.UnityEngine.Vector2(0, 0)

function UIImage:ctor()
  self.users = nil
  self.sprite = nil
  self.url = nil
  self.width = 0
  self.height = 0
end

function UIImage:Add(imageGo)
  self.users = self.users or {}
  table.insert(self.users, imageGo)
end

function UIImage:Remove(imageGo)
  if not self.users then
    return
  end
  for i = 1, #self.users do
    if self.users[i] == imageGo then
      table.remove(self.users, i)
      break
    end
  end
end

function UIImage:GetSprite()
  if self.sprite then
    return self.sprite
  end
  if self.texture then
    self.sprite = CreateSprite(self.texture, Rect(0, 0, self.texture.width, self.texture.height), Vec2Zero, 100, 0, SpriteMeshTypeFullRect)
    self.needDestroySprite = true
  end
  return self.sprite
end

function UIImage:GetTexture()
  if self.texture then
    return self.texture
  end
  if self.sprite then
    self.texture = self.sprite.texture
  end
  return self.texture
end

function UIImage:Destroy()
  if self.needDestroySprite and not IsNil(self.sprite) then
    Destroy(self.sprite)
  end
  self.sprite = nil
  self.texture = nil
end

return UIImage
