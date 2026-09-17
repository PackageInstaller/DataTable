local module = class("cellComprehensionItem", G_UIModuleBase)
local petLearningAblityTpl = L_GameTpl:getPetLearningAblityTpl()

function module:ctor(...)
  module.super.ctor(self, ...)
  self.data = {
    shiningImg = {
      sss = "Page/PetGet/tex_petget_word_shux2",
      ss = "Page/PetGet/tex_petget_word_shux1"
    },
    shiningBg = {
      sss = "Page/PetGet/tex_petget_bg_shux2",
      ss = "Page/PetGet/tex_petget_bg_shux1"
    },
    shiningFrame = {
      sss = "Page/PetGet/tex_petget_frame_shux2",
      ss = "Page/PetGet/tex_petget_frame_shux1"
    },
    topRankColor = {sss = "#ebc2d9", ss = "#edb200"},
    textColorType = {
      [1] = "#4f525d",
      [2] = "#ff7930"
    },
    animationType = {
      sss = "anim_petget_attr_s",
      ss = "anim_petget_attr_a"
    }
  }
end

function module.bind()
  return {
    show_shiningBg = false,
    shingingBg = "Page/PetGet/tex_petget_bg_shux1",
    shiningRank = "Page/PetGet/tex_petget_word_shux1",
    attr_icon = "",
    attr_shiningIcon = "",
    shiningIcon_color = CS.UnityEngine.Color(1, 1, 1),
    show_shiningFrame = false,
    shiningFrame = "Page/PetGet/tex_petget_frame_shux1",
    value = ""
  }
end

function module.methods()
  return {}
end

function module:open()
end

function module:show()
  self:refreshInfo()
end

function module:refresh()
end

function module:refreshInfo()
  if self.bind.attrId ~= 0 then
    local tpl = petLearningAblityTpl:getTplById(self.bind.attrId)
    local level = petLearningAblityTpl:getLevel(tpl)
    self.bind.show_shiningBg = true
    self.bind.show_shiningFrame = true
    self.bind.shingingBg = self.data.shiningBg[level]
    self.bind.shiningRank = self.data.shiningImg[level]
    self.bind.shiningFrame = self.data.shiningFrame[level]
    local _, color = C_ColorUtility.TryParseHtmlString(self.data.topRankColor[level])
    self.bind.shiningIcon_color = color
    self.timer = Timer.once(1.7, function()
      self.bindComponents.animation:Play(self.data.animationType[level])
      Timer.once(0.7, function()
        L_AudioUtil.playSound("Play_SFX_System_HUD_General_Reward_Qibo_Talent")
      end)
    end, self, self.gameObject)
  end
end

function module:close()
  self:disposeTimer()
end

function module:hide()
  self:disposeTimer()
end

function module:disposeTimer()
  if self.timer then
    self.timer:destroy()
    Timer.remove(self.timer)
    self.timer = nil
  end
end

return module
