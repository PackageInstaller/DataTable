_class("UIN34DispatchDialogueOpen", UIController)
UIN34DispatchDialogueOpen = UIN34DispatchDialogueOpen

function UIN34DispatchDialogueOpen:Constructor()
end

function UIN34DispatchDialogueOpen:LoadDataOnEnter(TT, res, uiParams)
  self._archId = uiParams[1]
  self._fnOpen = uiParams[2]
end

function UIN34DispatchDialogueOpen:OnShow(uiParams)
  self:UIWidget()
  self:InAnimation()
end

function UIN34DispatchDialogueOpen:OnHide()
end

function UIN34DispatchDialogueOpen:BtnAnywhereOnClick(go)
end

function UIN34DispatchDialogueOpen:BtnOpenOnClick(go)
  self:OutAnimation(self._fnOpen)
end

function UIN34DispatchDialogueOpen:UIWidget()
  self._loopAnim = self:GetUIComponent("Animation", "loopAnim")
  self._animation = self:GetUIComponent("Animation", "animation")
end

function UIN34DispatchDialogueOpen:InAnimation()
  local lockName = "UIN34DispatchDialogueOpen:InAnimation"
  self:StartTask(function(TT)
    self:Lock(lockName)
    self._animation:Play("uieff_UIN34DispatchDialogueOpen_in")
    YIELD(TT, 430)
    self._loopAnim:Play("uieff_UIN34DispatchDialogueOpen_loop")
    YIELD(TT, 170)
    self:UnLock(lockName)
  end)
end

function UIN34DispatchDialogueOpen:OutAnimation(endCb)
  local lockName = "UIN34DispatchDialogueOpen:OutAnimation"
  self:StartTask(function(TT)
    self:Lock(lockName)
    self._animation:Play("uieff_UIN34DispatchDialogueOpen_out")
    YIELD(TT, 200)
    if endCb ~= nil then
      endCb()
    end
    self:UnLock(lockName)
  end)
end
