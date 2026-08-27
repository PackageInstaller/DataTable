local UICommonMask = class("UICommonMask", UIBaseWindow)
local base = UIBaseWindow

function UICommonMask:InitCommonMask(bgColor)
  self.ui.bgImage.color = bgColor
  return self
end

function UICommonMask:CommonMaskFadeIn(time, callback)
  self.__permanent = true
  local tween = self.ui.bgImage:DOFade(0, time):From()
  
  function tween.onComplete()
    if callback ~= nil then
      callback()
    end
    self.__permanent = false
  end
  
  return self
end

function UICommonMask:CommonMaskFadeOut(time, callback)
  self.__permanent = true
  local tween = self.ui.bgImage:DOFade(0, time)
  
  function tween.onComplete()
    if callback ~= nil then
      callback()
    end
    self.__permanent = false
  end
  
  return self
end

function UICommonMask:CommonMaskDOKill(isDoCompelete)
  self.ui.bgImage:DOKill(isDoCompelete)
end

return UICommonMask
