local this = class("modulePetPixelPropertyFrame", G_UIModuleBase)
local attributePerspective = {
  [2] = {
    [1] = {x = 35.44, y = 8.9},
    [2] = {x = -35.44, y = 8.9}
  },
  [3] = {
    [2] = {x = 77.8, y = -24.9},
    [3] = {x = -85.9, y = -24.9}
  },
  [4] = {
    [1] = {x = -107.3, y = -65},
    [2] = {x = 101.9, y = -65},
    [3] = {x = 42.9, y = 9.2},
    [4] = {x = -51.8, y = 9.2}
  }
}

function this.bind()
  return {
    active_frameImage_petUseItemEffect = false,
    textureName_frameImage_petUseItemEffect = "",
    frameCountPerRow_frameImage_petUseItemEffect = nil,
    frameCountPerCol_frameImage_petUseItemEffect = nil,
    frameCount_frameImage_petUseItemEffect = nil,
    frameAnimParamsComplete_frameImage_petUseItemEffect = false,
    list_frameImage = {
      moduleName = "pages/pet/cellFrameImagePetUseItemEffect"
    }
  }
end

function this.methods()
  return {}
end

function this:updatePropertyFrame(attrIdList)
  local attrCount = #attrIdList
  local tempAttrId = {}
  for i = 1, #attrIdList do
    local pos = C_Vector2(0, 0)
    local attrPerspective = attributePerspective[attrCount]
    if attrCount % 2 ~= 0 then
      if i ~= 1 then
        pos = attrPerspective[i]
      else
        pos = {x = -3.1, y = 11}
      end
    else
      pos = attrPerspective[i]
    end
    table.insert(tempAttrId, {
      attrId = attrIdList[i],
      pos = pos
    })
  end
  self.bind.list_frameImage:clear()
  self.bind.list_frameImage:insert_array(tempAttrId)
  self.bind.textureName_frameImage_petUseItemEffect = "UI/Pages/PetFruitEffect/buff_front_pillar.png"
  self.bind.frameCountPerRow_frameImage_petUseItemEffect = 4
  self.bind.frameCountPerCol_frameImage_petUseItemEffect = 3
  self.bind.frameCount_frameImage_petUseItemEffect = 11
  self.imgGlowMaterial = self.imgGlowMaterial or self.parent.bindComponents.img_glow_petUseItemEffect.material
  self.bind.frameAnimParamsComplete_frameImage_petUseItemEffect = true
  self.bind.active_frameImage_petUseItemEffect = true
  self.parent.bind.active_img_glow_petUseItemEffect = true
  L_TimerManager:newOrResetTimer(self, "playPetFeedItemEffect", function()
    self:updatePetFeedItemEffect()
  end, 0.05, -1)
  self:updatePetFeedItemEffect()
end

function this:updatePetFeedItemEffect()
  self.frameCountHasPlayed2AlphaOfImgGlow = self.frameCountHasPlayed2AlphaOfImgGlow or {
    [1] = 0.25,
    [2] = 0.5,
    [3] = 1,
    [4] = 1
  }
  self.frontFrameImage = self.frontFrameImage or self.bindComponents.frameImage_petUseItemEffect
  local curFrameIndex = self.frontFrameImage.curFrameIndex
  local alphaOfImgGlow = self.frameCountHasPlayed2AlphaOfImgGlow[curFrameIndex + 1] or 0
  self.imgGlowMaterial:SetFloat("_Alpha", alphaOfImgGlow)
  if curFrameIndex == self.bind.frameCount_frameImage_petUseItemEffect - 1 then
    self:emit("finishedPlaying")
    self.parent.bind.active_img_glow_petUseItemEffect = false
    L_TimerManager:stopTimer(self, "playPetFeedItemEffect")
    self.bind.list_frameImage:clear()
    self.bind.active_frameImage_petUseItemEffect = false
  end
end

function this:closePetFeedItemEffect()
  L_TimerManager:stopTimer(self, "playPetFeedItemEffect")
  self.bind.list_frameImage:clear()
  self.bind.active_frameImage_petUseItemEffect = false
  self.parent.bind.active_img_glow_petUseItemEffect = false
end

function this:close()
  self:closePetFeedItemEffect()
end

return this
