local base = require("Game.ActivityLobby.Ctrl.ActLobbyCtrlBase")
local ActLbEffectCtrl = class("ActLbEffectCtrl", base)
local CameraEffectUtil = require("Game.Exploration.Util.CameraEffectUtil")
local CameraEffectEnum = CameraEffectUtil.CameraEffectEnum
local ActLbUtil = require("Game.ActivityLobby.ActLbUtil")

function ActLbEffectCtrl:ctor(actLbCtrl)
end

function ActLbEffectCtrl:OnActLbSceneEnter(bind)
end

function ActLbEffectCtrl:OpenOldMovieEffect()
  if self.openOldMovieEffect then
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.SteinsGateEffectMask, function(win)
    if win == nil then
      return
    end
    win:ShowOldMovieEffectMask()
  end)
  self.openOldMovieEffect = true
end

function ActLbEffectCtrl:CloseOldMovieEffect()
  if not self.openOldMovieEffect then
    return
  end
  local win = UIManager:GetWindow(UIWindowTypeID.SteinsGateEffectMask)
  if win then
    win:HideOldMovieEffectMask()
  end
  UIManager:DeleteWindow(UIWindowTypeID.SteinsGateEffectMask)
  self.openOldMovieEffect = false
end

function ActLbEffectCtrl:OpenBlackBk()
  if self.openBlackBkEffect then
    return
  end
  local win = UIManager:GetWindow(UIWindowTypeID.ActLobbyMain)
  if win == nil then
    return
  end
  self.openBlackBkEffect = true
  win:SetBlackAdapterShow(true)
end

function ActLbEffectCtrl:CloseBlackBk()
  if not self.openBlackBkEffect then
    return
  end
  self.openBlackBkEffect = false
  local win = UIManager:GetWindow(UIWindowTypeID.ActLobbyMain)
  if win == nil then
    return
  end
  win:SetBlackAdapterShow(false)
end

function ActLbEffectCtrl:SetLbEffectPause(bool)
  if bool then
    self:PauseAllEffect()
    return
  end
  self:ContinueAllEffect()
end

function ActLbEffectCtrl:PauseAllEffect()
  if self.openOldMovieEffect then
    self.openOldMovieEffectPause = true
    self:CloseOldMovieEffect()
  end
  if self.openBlackBkEffect then
    self.openBlackBkEffectPause = true
    self:CloseBlackBk()
  end
end

function ActLbEffectCtrl:ContinueAllEffect()
  if self.openBlackBkEffectPause then
    self.openBlackBkEffectPause = false
    self:OpenBlackBk()
  end
  if self.openOldMovieEffectPause then
    self.openOldMovieEffectPause = false
    self:OpenOldMovieEffect()
  end
end

function ActLbEffectCtrl:Delete()
  self:CloseOldMovieEffect()
  self:CloseBlackBk()
end

return ActLbEffectCtrl
