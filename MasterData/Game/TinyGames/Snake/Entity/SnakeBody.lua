local SnakeBase = require("Game.TinyGames.Snake.Entity.SnakeBase")
local SnakeBody = class("SnakeBody", SnakeBase)
local cs_MaterialPropertyBlock = CS.UnityEngine.MaterialPropertyBlock
local ScaleAndOffsetNameID = CS.UnityEngine.Shader.PropertyToID("_ScaleAndOffset")
local cs_SkinnedMeshRenderer = CS.UnityEngine.SkinnedMeshRenderer

function SnakeBody:ctor(go, x, z)
end

function SnakeBody:ResetSnakeAnimator()
  self.animator:ResetTrigger("Jump")
  SnakeBase.ResetSnakeAnimator(self)
end

function SnakeBody:PlaySnakeMoveAni(tween)
  self.animator:ResetTrigger("Jump")
  self.animator:SetTrigger("Jump")
end

function SnakeBody:SetSnakeSkin(heroId)
  local offsetX, offsetY = self:__GetLittleManTextureOffset(heroId)
  self:SetLittleManSkin(offsetX, offsetY)
end

function SnakeBody:__GetLittleManTextureOffset(heroId)
  local offset = heroId - 1000 - 1
  local offsetX = math.fmod(offset, 16) * 0.0625
  local offsetY = math.modf(offset / 16) * 0.0625
  return offsetX, offsetY
end

function SnakeBody:SetLittleManSkin(OffsetX, OffsetY)
  if IsNull(self.meshRenderer) and not IsNull(self.gameObject) then
    self.meshRenderer = self.gameObject:GetComponentInChildren(typeof(cs_SkinnedMeshRenderer))
  end
  if not IsNull(self.meshRenderer) then
    local propertyBlock = cs_MaterialPropertyBlock()
    propertyBlock:SetVector(ScaleAndOffsetNameID, Vector4.New(0.0625, 0.0625, OffsetX, OffsetY))
    self.meshRenderer:SetPropertyBlock(propertyBlock)
  end
end

return SnakeBody
