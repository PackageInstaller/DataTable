local UIEpPlayerPos = class("UIEpPlayerPos", UIBaseNode)
local base = UIBaseNode

function UIEpPlayerPos:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UIEpPlayerPos:SetPlayerPos(position)
  self.transform.position = position
end

function UIEpPlayerPos:ShowPlayerPosSmall(show, withTween, callBack)
  self:__KillTween_SmallFade()
  if withTween then
    if show then
      self.ui.smallNode.alpha = 0
      self.__smallFadeTween = self.ui.smallNode:DOFade(1, ConfigData.buildinConfig.EpMapCursorShowDuration):OnComplete(callBack)
    else
      self.ui.smallNode.alpha = 1
      self.__smallFadeTween = self.ui.smallNode:DOFade(0, ConfigData.buildinConfig.EpMapCursorFadeDuration):OnComplete(callBack)
    end
  elseif show then
    self.ui.smallNode.alpha = 1
  else
    self.ui.smallNode.alpha = 0
  end
  if show then
    self:ShowPlayerPosLarge(false)
  end
  self.smallIsShow = show
end

function UIEpPlayerPos:ShowPlayerPosLarge(show, withTween, callBack)
  self:__KillTween_LargeFade()
  if withTween then
    if show then
      self.ui.largeNode.alpha = 0
      self.__largeFadeTween = self.ui.largeNode:DOFade(1, ConfigData.buildinConfig.EpMapCursorShowDuration):OnComplete(callBack)
    else
      self.ui.largeNode.alpha = 1
      self.__largeFadeTween = self.ui.largeNode:DOFade(0, ConfigData.buildinConfig.EpMapCursorFadeDuration):OnComplete(callBack)
    end
  elseif show then
    self.ui.largeNode.alpha = 1
  else
    self.ui.largeNode.alpha = 0
  end
  if show then
    self:ShowPlayerPosSmall(false)
  end
  self.largeIsShow = show
end

function UIEpPlayerPos:__KillTween_SmallFade()
  if self.__smallFadeTween ~= nil then
    self.__smallFadeTween:Kill()
    self.__smallFadeTween = nil
  end
end

function UIEpPlayerPos:__KillTween_LargeFade()
  if self.__largeFadeTween ~= nil then
    self.__largeFadeTween:Kill()
    self.__largeFadeTween = nil
  end
end

function UIEpPlayerPos:PlayerPosIsShowSmall()
  return self.smallIsShow
end

function UIEpPlayerPos:PlayerPosIsShowLarge()
  return self.largeIsShow
end

function UIEpPlayerPos:OnDelete()
  self:__KillTween_SmallFade()
  self:__KillTween_LargeFade()
  base.OnDelete(self)
end

return UIEpPlayerPos
