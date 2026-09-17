local this = class("cellFrameImagePetUseItemEffect", G_UIModuleBase)
local _battleInfoTpl = L_GameTpl:getBattleInfoTpl()

function this.bind()
  return {
    active_frameImage_petUseItemEffect = false,
    textureName_frameImage_petUseItemEffect = "",
    frameCountPerRow_frameImage_petUseItemEffect = nil,
    frameCountPerCol_frameImage_petUseItemEffect = nil,
    frameCount_frameImage_petUseItemEffect = nil,
    frameAnimParamsComplete_frameImage_petUseItemEffect = false,
    rect_FrameImage = C_Vector2(0, 0)
  }
end

function this.methods()
  return {}
end

function this:refresh()
  self.bind.rect_FrameImage = self.bind.pos
  local battleInfoTpl = _battleInfoTpl:getTplById(self.bind.attrId)
  local petFruitPixelEffectPathInfo = _battleInfoTpl:getPetFruitPixelEffectPathInfo(battleInfoTpl)
  local frameTextureConfigInfos = _battleInfoTpl:getPixelEffectFrameTextureConfigInfos(battleInfoTpl)
  local frontPixelEffectPath = petFruitPixelEffectPathInfo.frontPixelEffectPath
  local frontFrameTextureConfigInfo = frameTextureConfigInfos.frontFrameTextureConfigInfo
  self.bind.textureName_frameImage_petUseItemEffect = frontPixelEffectPath
  self.bind.frameCountPerRow_frameImage_petUseItemEffect = frontFrameTextureConfigInfo.colNum
  self.bind.frameCountPerCol_frameImage_petUseItemEffect = frontFrameTextureConfigInfo.rowNum
  self.bind.frameCount_frameImage_petUseItemEffect = frontFrameTextureConfigInfo.iconNum
  self.bind.frameAnimParamsComplete_frameImage_petUseItemEffect = true
  self.bind.active_frameImage_petUseItemEffect = true
  L_TimerManager:newOrResetTimer(self, "playPetFeedItemEffect", function()
    self:updatePetFeedItemEffect()
  end, 0.05, -1)
  self:updatePetFeedItemEffect()
end

function this:updatePetFeedItemEffect()
  self.frameCountHasPlayed2AlphaOfImgGlow = self.frameCountHasPlayed2AlphaOfImgGlow or {
    [1] = 0.25,
    [2] = 0.5,
    [3] = 1
  }
  self.frontFrameImage = self.frontFrameImage or self.bindComponents.frameImage_petUseItemEffect
  local curFrameIndex = self.frontFrameImage.curFrameIndex
  if curFrameIndex == self.bind.frameCount_frameImage_petUseItemEffect - 1 then
    L_TimerManager:stopTimer(self, "playPetFeedItemEffect")
    self.bind.active_frameImage_petUseItemEffect = false
  end
end

function this:close()
  L_TimerManager:stopTimer(self, "playPetFeedItemEffect")
end

return this
