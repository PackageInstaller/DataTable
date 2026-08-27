local UICommonMask = require("Game.CommonUI.UICommonMask")
local UIVowMask = class("UIVowMask", UICommonMask)
local base = UICommonMask

function UIVowMask:CommonMaskFadeIn(time, callback)
  self.__permanent = true
  local tween = self.ui.bgImage:DOFade(0, time):From()
  
  function tween.onComplete()
    if callback ~= nil then
      callback()
    end
  end
  
  return self
end

function UIVowMask:CommonMaskFadeOut(time, callback)
  self.__permanent = true
  local tween = self.ui.bgImage:DOFade(0, time)
  
  function tween.onComplete()
    if callback ~= nil then
      callback()
    end
  end
  
  return self
end

return UIVowMask
