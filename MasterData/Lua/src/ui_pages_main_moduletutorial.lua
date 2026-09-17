local this = class("moduleTutorial", G_UIModuleBase)
local tutorialTpl = L_GameTpl:getTutorialTpl()
local tutorialTypeTpl = L_GameTpl:getTutorialTypeTpl()

function this.bind()
  return {
    tutorialActive = false,
    icon = "",
    go_key = false,
    go_progressMobile = false,
    go_progressPC = false,
    progressMobile = 1,
    progressPC = 1,
    txt_name = "",
    go_gamepadKey = false
  }
end

function this.methods()
  return {
    onClick_tutorialNode = function(self)
      L_GuideManager:internalSendEvent(G_GuideClasses.GuideEvent.TutotialGuideEnd)
    end
  }
end

function this:open()
  self.isPlatformPC = L_DeviceTpl:getIsPc()
  self.onEvent_controlSchemeChangeHandle = self.onEvent_controlSchemeChangeHandle or handler(self, self.onEvent_controlSchemeChange)
  C_ExternalManager.AddEvent(C_EExternalEventType.ControlSchemeChange, self.onEvent_controlSchemeChangeHandle)
  self:init()
end

function this:close()
  self:disposeTween()
  if self.timer then
    Timer.remove(self.timer)
    self.timer = nil
  end
  local openMapAction = self:getaction(L_Const.settingType.openMap)
  if openMapAction then
    openMapAction:Enable()
  end
  C_ExternalManager.RemoveEvent(C_EExternalEventType.ControlSchemeChange, self.onEvent_controlSchemeChangeHandle)
  L_ShortCutManager:clearShortKeyFlag(self)
end

function this:getaction(settingType)
  local cfg = L_Const.settingKey[settingType]
  if cfg == nil then
    return
  end
  local actionName = cfg[1]
  if actionName == nil then
    return
  end
  return C_InputManager.GetAction(actionName)
end

function this:onEvent_controlSchemeChange(args)
  self.bind.go_key = self.isPlatformPC and not C_InputManager.IsEnableGamePad
  L_ShortCutManager:addShortKeyFlag(self, "MainTutorial", L_Const.AnchorType.Middle, self.bindComponents.keyGamepadRect)
  self.bind.go_gamepadKey = C_InputManager.IsEnableGamePad
  local tutorialAction = self:getaction(L_Const.settingType.tutorial)
  local openMapAction = self:getaction(L_Const.settingType.openMap)
  if tutorialAction == nil or openMapAction == nil then
    return
  end
  tutorialAction:Enable()
  if C_InputManager.IsEnableGamePad then
    openMapAction:Disable()
  else
    openMapAction:Enable()
  end
end

function this:init()
  self.bind.go_progressPC = self.isPlatformPC
  self.bind.go_progressMobile = not self.isPlatformPC
  self:onEvent_controlSchemeChange()
end

function this:show(options)
  if options ~= nil then
    self:onTutotialGuideStart(options.luaTable)
  end
end

function this:onTutotialGuideEnd()
  self:disposeTween()
  self.bindComponents.tutorialNodeAnim:Play("anim_guide_tutorialbtn_done")
  self.timer = Timer.once(0.733, function()
    if self.bind ~= nil then
      self.bind.tutorialActive = false
    end
  end, self)
end

function this:onTutotialGuideStart(info)
  local tutorialConfig = tutorialTpl:getTplById(info.tutorialId)
  local tutorialType = tutorialTpl:getTutorialTypeId(tutorialConfig)
  local typeTpl = tutorialTypeTpl:getTplById(tutorialType)
  self.bind.icon = tutorialTypeTpl:getIcon(typeTpl)
  self.bind.txt_name = tutorialTpl:getTutorialName(tutorialConfig)
  self.bind.tutorialActive = true
  self.bindComponents.tutorialNodeAnim:Play("anim_guide_tutorialbtn_show")
  if self.timer then
    Timer.remove(self.timer)
    self.timer = nil
  end
  self.bind.progressMobile = 1
  self.bind.progressPC = 1
  
  local function getter()
    if self.isPlatformPC then
      return self.bind.progressPC
    else
      return self.bind.progressMobile
    end
  end
  
  local starMobileRect = self.bindComponents.starM
  local starPCRect = self.bindComponents.starP
  local progressMobileRect = self.bindComponents.progressMobileRect
  local progressPCRect = self.bindComponents.progressPCRect
  
  local function setter(r)
    if self.bind == nil then
      return
    end
    if type(self.bind) ~= "table" then
      return
    end
    if self.isPlatformPC then
      local offset = r * 0.908
      self.bind.progressPC = offset
      if offset < 0.03 then
        return
      end
      starPCRect.anchoredPosition = self:CalculatePointOnCircle(offset * 360, progressPCRect.sizeDelta.x / 2)
      starPCRect.localRotation = self:CalculateTangentOnCircle(progressPCRect.anchoredPosition, starPCRect.anchoredPosition)
    else
      self.bind.progressMobile = r
      starMobileRect.anchoredPosition = self:CalculatePointOnCircle(r * 360, progressMobileRect.sizeDelta.x / 2)
      starMobileRect.localRotation = self:CalculateTangentOnCircle(progressMobileRect.anchoredPosition, starMobileRect.anchoredPosition)
    end
  end
  
  self:disposeTween()
  self.tween = DOTween.To(getter, setter, 0, info.showTime):SetEase(Tweening.Ease.Linear):OnComplete(function()
    self.bindComponents.tutorialNodeAnim:Play("anim_guide_tutorialbtn_hide")
    self:disposeTween()
    self.timer = Timer.once(0.233, function()
      self.bind.tutorialActive = false
    end, self)
  end)
end

function this:CalculatePointOnCircle(angleDegrees, radius)
  local angleRadians = angleDegrees * (Mathf.PI / 180)
  local x = Mathf.Cos(angleRadians + Mathf.PI / 2 + Mathf.PI / 20) * radius
  local y = Mathf.Sin(angleRadians + Mathf.PI / 2 + Mathf.PI / 20) * radius * -1
  return C_Vector2(x, y)
end

function this:CalculateTangentOnCircle(circleCenter, selfPos)
  local direction = (selfPos - circleCenter).normalized
  local angle = Mathf.Atan2(direction.y, direction.x) * Mathf.Rad2Deg
  return C_Quaternion.Euler(0, 0, angle)
end

function this:disposeTween()
  if L_CommonUtil.isValid(self.tween) then
    self.tween:Kill()
    self.tween = nil
  end
end

function this:activate()
  self:open()
  self:openModules()
  self:show()
  self:showModules()
end

function this:deActivate()
  self:hide()
  self:hideModules()
  self:close()
  self:closeModules()
end

return this
