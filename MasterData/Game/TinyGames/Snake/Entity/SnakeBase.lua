local SnakeBase = class("SnakeBase")
local SnakeGameConfig = require("Game.TinyGames.Snake.Config.SnakeGameConfig")

function SnakeBase:ctor(go, x, z)
  self.gameObject = go
  self.transform = go.transform
  self.animator = self.gameObject:FindComponent(eUnityComponentID.Animator)
  self.x = x
  self.z = z
  self._pos = Vector3.New(0, 0, 0)
  self._aniSpeed = 1
  if x ~= nil then
    self._pos:Set(-x, 0, z)
    self.transform.localPosition = self._pos
  end
end

function SnakeBase:DirectSetSnakePosDir(x, z, dir)
  self.x = x
  self.z = z
  self._pos:Set(-x, 0, z)
  self.transform.localPosition = self._pos
  self.esdir = dir
  self.transform.localEulerAngles = SnakeGameConfig.DirRorate[dir]
end

function SnakeBase:SetSnakeActive(active)
  self.gameObject:SetActive(active)
  if not active then
    self.transform:DOKill()
  end
end

function SnakeBase:ResetSnakeAnimator()
  self.animator.speed = 1
  self._aniSpeed = 1
  self.animator:ResetTrigger("Dead")
  self.animator:SetBool("Start", false)
  self.animator:SetTrigger("Reset")
end

function SnakeBase:PlaySnakeStartAni()
  self.animator:SetBool("Start", true)
end

function SnakeBase:PlaySnakeMoveAni(tween)
end

function SnakeBase:SnakeEntityDead()
  self.animator.speed = 1
  self.animator:SetTrigger("Dead")
end

function SnakeBase:SetSnakeAniSpeed(speed)
  self._aniSpeed = speed
  self.animator.speed = speed
end

function SnakeBase:ResetSnakeFastForward()
  self.transform:DOKill()
  self.animator.speed = self._aniSpeed
  self._pos:Set(-self.x, 0, self.z)
  self.transform.localPosition = self._pos
end

function SnakeBase:SetSnakeQuick(timeScale)
  if self._moveTween ~= nil then
    self._moveTween.timeScale = timeScale
    self.animator.speed = self._aniSpeed * timeScale
  end
end

function SnakeBase:MoveSnakeEntity(x, z, time)
  self.x = x
  self.z = z
  self._pos:Set(-x, 0, z)
  self._moveTween = self.transform:DOLocalMove(self._pos, time):SetLink(self.gameObject)
  self:PlaySnakeMoveAni(self._moveTween)
end

function SnakeBase:RotateSnakeDir(dir, time)
  if self.esdir == dir then
    return
  end
  self.esdir = dir
  local rot = SnakeGameConfig.DirRorate[dir]
  self.transform:DORotate(rot, SnakeGameConfig.RotateAniRatio * time):SetLink(self.gameObject)
end

return SnakeBase
