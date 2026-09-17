local module = class("cellTimelineComprehension", G_UIModuleBase)
local petLearingEnumTpl = L_GameTpl:getPetLearingEnumTpl()
local petLearningAblityTpl = L_GameTpl:getPetLearningAblityTpl()
local petGradeTpl = L_GameTpl:getPetGradeTpl()
local battleInfoTpl = L_GameTpl:getBattleInfoTpl()

function module:ctor(...)
  module.super.ctor(self, ...)
  self.data = {
    shiningBg = {
      sss = "Page/PetGet/tex_petget_bg_shux2",
      ss = "Page/PetGet/tex_petget_bg_shux1"
    },
    shiningFrame = {
      sss = "Page/PetGet/tex_petget_frame_shux2",
      ss = "Page/PetGet/tex_petget_frame_shux1"
    },
    topRankColor = {sss = "#C2B1C9", ss = "#D9DB8A"},
    textColorType = {
      [1] = "#4f525d",
      [2] = "#ff7930"
    },
    animationType = {
      sss = "anim_petget_attr_s",
      ss = "anim_petget_attr_a"
    },
    numTextColor = {sss = "#FF6D89", ss = "#e0923e"}
  }
end

function module.bind()
  return {
    show_shiningBg = false,
    shingingBg = "Page/PetGet/tex_petget_bg_shux1",
    attr_icon = "",
    attr_shiningIcon = "",
    shiningIcon_color = CS.UnityEngine.Color(1, 1, 1),
    show_shiningFrame = false,
    shiningFrame = "Page/PetGet/tex_petget_frame_shux1",
    value_1 = "",
    value_2 = "",
    name = "",
    show_s = false,
    show_a = false,
    arrAnchoredPosition = C_Vector2(111, -18.7),
    isNum = false
  }
end

function module.methods()
  return {
    onAnimation_event = function(self)
      self:setAttrValue()
    end
  }
end

function module:open()
  self.isNum = self.bind.isRatio == 1
  self.customCurve = self.bind.curve or Tweening.Ease.InOutCirc
  local width = self.bindComponents.AttrName.preferredWidth
  self.bind.arrAnchoredPosition = C_Vector2(width + 7, -18.7)
end

function module:show()
  self:refreshInfo()
end

function module:refresh()
end

function module:setAttrValue()
  local endValue = self.bind.value - math.ceil(self.bind.value * 0.03)
  self.timer = Timer.once(0, function()
    local function getter()
      return 0
    end
    
    local function setter(v)
      self.bind.value_1 = string.format("+%d", math.ceil(v))
      self.bind.value_2 = string.format("+%d", math.ceil(v))
      self.bind.isNum = self.isNum
    end
    
    self.tween = DOTween.To(getter, setter, endValue, 0.633):SetEase(self.customCurve):OnComplete(function()
      Timer.once(0.05, function()
        self.bind.value_1 = string.format("+%d", self.bind.value)
        self.bind.value_2 = string.format("+%d", self.bind.value)
        self.bind.isNum = self.isNum
      end, self, self.gameObject)
    end)
  end, self, self.gameObject)
end

function module:refreshInfo()
  if not math.isEmpty(self.bind.attrId) then
    local tpl = petLearningAblityTpl:getTplById(self.bind.attrId)
    local level = petLearningAblityTpl:getLevel(tpl)
    printf("shinegframa", level)
    self.bind.show_shiningBg = true
    self.bind.show_shiningFrame = true
    self.bind.shingingBg = self.data.shiningBg[level]
    self.bind.shiningFrame = self.data.shiningFrame[level]
    self:SetNumTextColor(level)
    local showIndex = string.format("show_%s", level)
    self.bind[showIndex] = true
    local rawValue = self.bind.value
  end
end

function module:close()
  self:disposeTimer()
end

function module:disposeTimer()
  if self.timer then
    self.timer:destroy()
    Timer.remove(self.timer)
    self.timer = nil
  end
  if self.tween then
    self.tween:Kill()
    self.tween = nil
  end
end

function module:SetNumTextColor(lev)
  printf("numTextColor", lev)
  if lev and not self.data.numTextColor[lev] then
    return
  end
  local colorkey = self.data.numTextColor[lev]
  local _, color1 = C_ColorUtility.TryParseHtmlString(colorkey)
  local _, color2 = C_ColorUtility.TryParseHtmlString("#4f525d")
  self.bindComponents.numTextColor:SetColorGradient(color2, color2, color1, color1)
end

return module
