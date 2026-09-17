local this = class("cellPhotoFilter", G_UIModuleBase)
local paramTpl = L_GameTpl:getPhotographParamTpl()

function this.bind()
  return {
    id = 0,
    txtName = "",
    imgIcon = "",
    goSlider = false,
    goNum = false,
    txtNum = "",
    imgBoard = nil,
    imgBlackMask = false,
    bgimg_icon = ""
  }
end

function this:methods()
  return {
    onClick_handle = function(self)
      L_AudioUtil.playSound("Play_SFX_System_UI_Photograph_Choose_Filter_Change")
      self:emit("onClick_handle", self.bind.id, self.bind.txtName)
    end,
    onSliderValueChange = function(self, value)
      self:onValueChanged(value)
    end,
    onSliderBegin = function(self)
      self:beginSlide()
    end,
    onSliderEnd = function(self)
      self:endSlide()
    end
  }
end

function this:open()
  if L_DeviceTpl:getIsMobile() then
    self.bindComponents.txt_ornamental_fontsize.fontSize = 24
    self.bindComponents.txtName_fontsize.fontSize = 22
    self.bind.bgimg_icon = "UI/Page/Photo/tex_photo_bg_03_2.png"
    self.bindComponents.img_bg_size.sizeDelta = C_Vector2(200, 64)
  end
  if L_DeviceTpl:getIsPc() then
    self.bindComponents.img_bg_size.sizeDelta = C_Vector2(98, 40)
    self.bind.bgimg_icon = "UI/Page/Photo/tex_photo_bg_03 1.png"
  end
  self.parent = self.parent
  self:refreshSliderArea(self.bind.id)
end

function this:close()
end

function this:refresh()
  if self.bind.tabGroup and self.bind.tabGroup then
    self.bindComponents.tabItem.Group = self.bind.tabGroup
  end
  self:refreshSliderArea(self.bind.id)
end

function this:clearTabGroup()
  if self.bindComponents and self.bindComponents.tabItem then
    self.bindComponents.tabItem.Group = nil
  end
end

function this:onValueChanged(v)
  if self.initSlider then
    return
  end
  self.parent:setVal(self.bind.id, v)
  if self.sliding then
    self.bind.goNum = self.sliding
  else
    return
  end
  self.bind.txtNum = tostring(math.floor(v * 100))
  self.parent:setInfo(self.bind.txtNum)
end

function this:refreshSelect(sel)
  local tpl = paramTpl:getTplById(self.bind.id)
  self.bind.imgBoard = sel
  local isSlider = paramTpl:getParamType(tpl) == L_Const.photoParamType.range
  self.bind.goSlider = isSlider and sel
  self.bind.goNum = false
end

function this:refreshSliderArea(id)
  local tpl = paramTpl:getTplById(id)
  self.initSlider = true
  local slider = self.bindComponents.slider
  local val = self.parent:getDefaultVal(id)
  slider.minValue = paramTpl:getParamMin(tpl)
  slider.maxValue = paramTpl:getParamMax(tpl)
  slider.minViewValue = slider.minValue
  slider.value = val
  self.initSlider = false
end

function this:beginSlide()
  self.sliding = true
  self.bind.goNum = self.sliding
  self.bindComponents.canvasGroup.ignoreParentGroups = true
  L_PhotoManager:sendEvent(L_PhotoManager.event.changeStartAlpha)
  self.parent:showInfo(true)
  self.bind.imgBlackMask = true
end

function this:endSlide()
  self.sliding = false
  self.bind.goNum = false
  if self.bindComponents and self.bindComponents.canvasGroup then
    self.bindComponents.canvasGroup.ignoreParentGroups = false
  end
  L_PhotoManager:sendEvent(L_PhotoManager.event.changeEndAlpha)
  self.parent:showInfo(false)
  self.bind.imgBlackMask = false
end

return this
