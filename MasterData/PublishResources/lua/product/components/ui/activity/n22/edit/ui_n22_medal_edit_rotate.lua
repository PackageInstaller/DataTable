_class("UIN22MedalEditRotate", UIController)
UIN22MedalEditRotate = UIN22MedalEditRotate

function UIN22MedalEditRotate:Constructor()
  self.rotateAngleStep = Cfg.cfg_global.ui_homeland_build_rotate_step.IntValue or 10
  self.quaternion = Quaternion.identity
  self.quaternionBak = Quaternion.identity
  self.showPosList = {
    Vector2(-600, 0),
    Vector2(600, 0),
    Vector2(600, 0),
    Vector2(-600, 0)
  }
end

function UIN22MedalEditRotate:OnShow(uiParams)
  self.curBoardMedal = uiParams[1]
  self.ui = uiParams[2]
  local rtBoard = self.ui.rtBoard
  self.center = rtBoard.position
  self.ui:FlushRotateTakeInButton(false)
  self.anim = self:GetUIComponent("Animation", "SafeArea")
  self.circle = self:GetUIComponent("RectTransform", "circle")
  self.arrow = self:GetUIComponent("RectTransform", "arrow")
  self.goCircle = self:GetGameObject("circle")
  local etl = UICustomUIEventListener.Get(self.goCircle)
  self:AddUICustomEventListener(etl, UIEvent.BeginDrag, function(ped)
    Log.debug("### BeginDrag")
  end)
  self:AddUICustomEventListener(etl, UIEvent.Drag, function(ped)
    self:CalcAngle()
    self:Rotate()
  end)
  self:AddUICustomEventListener(etl, UIEvent.EndDrag, function(ped)
    Log.debug("### EndDrag")
  end)
  self:AddUICustomEventListener(etl, UIEvent.Click, function(go)
    self:CalcAngle()
    self:Rotate()
  end)
  self.camera = GameGlobal.UIStateManager():GetControllerCamera(self:GetName())
  self.quaternion = self.curBoardMedal:LocalRotation()
  self.quaternionBak = self.quaternion:Clone()
  self:Rotate()
  self:FlushCirclePos()
end

function UIN22MedalEditRotate:OnHide()
  self.ui:FlushRotateTakeInButton(true)
  self.ui:ClampBoardMedalUI(self.curBoardMedal:Id())
end

function UIN22MedalEditRotate:FlushCirclePos()
  local pos = self.curBoardMedal:Position()
  local index = 0
  local isRight = pos.x > self.center.x
  local isUp = pos.y > self.center.y
  if isRight then
    if isUp then
      index = 1
    else
      index = 4
    end
  elseif isUp then
    index = 2
  else
    index = 3
  end
  self.circle.anchoredPosition = self.showPosList[index]
end

function UIN22MedalEditRotate:FlushArrow()
  self.arrow.localRotation = self.quaternion
end

function UIN22MedalEditRotate:BgOnClick(go)
  self:AnimCloseDialog()
end

function UIN22MedalEditRotate:ImgCancelOnClick(go)
  self.quaternion = self.quaternionBak:Clone()
  self:Rotate()
  self:AnimCloseDialog()
end

function UIN22MedalEditRotate:ImgConfirmOnClick(go)
  self:AnimCloseDialog()
end

function UIN22MedalEditRotate:AnimCloseDialog()
  self:PlayAnimOut(function()
    self:CloseDialog()
  end)
end

function UIN22MedalEditRotate:PlayAnimOut(callback)
  self:StartTask(function(TT)
    local key = "uieff_UIN22MedalEditRotate_out"
    self:Lock(key)
    self.anim:Play("uieff_UIN22MedalEditRotate_out")
    YIELD(TT, 767)
    if callback then
      callback()
    end
    self:UnLock(key)
  end, self)
end

function UIN22MedalEditRotate:Rotate()
  self:FlushArrow()
  self.curBoardMedal:FlushRot(self.quaternion)
end

function UIN22MedalEditRotate:CalcAngle()
  local mousePosition = UnityEngine.Input.mousePosition
  local screenPos = Vector2(mousePosition.x, mousePosition.y)
  local pos = UIHelper.ScreenPointToWorldPointInRectangle(self.circle.parent, screenPos, self.camera)
  local v3 = pos - self.circle.position
  local angle = Vector2.Angle(Vector2.up, Vector2(v3.x, v3.y))
  if v3.x < 0 then
    angle = 360 - angle
  end
  angle = self:FormatAngle(angle)
  self.quaternion:SetEuler(0, 0, -angle)
end

function UIN22MedalEditRotate:FormatAngle(angle)
  local div = math.floor((angle + self.rotateAngleStep * 0.5) / self.rotateAngleStep) * self.rotateAngleStep
  return div
end
