_class("UIN34DispatchAllOver", UIController)
UIN34DispatchAllOver = UIN34DispatchAllOver

function UIN34DispatchAllOver:Constructor()
end

function UIN34DispatchAllOver:LoadDataOnEnter(TT, res, uiParams)
end

function UIN34DispatchAllOver:OnShow(uiParams)
  self:UIWidget()
  self:InAnimation()
end

function UIN34DispatchAllOver:OnHide()
end

function UIN34DispatchAllOver:BtnCloseOnClick(go)
  self:OutAnimation(function()
    self:CloseDialog()
  end)
end

function UIN34DispatchAllOver:UIWidget()
  self._animation = self:GetUIComponent("Animation", "animation")
end

function UIN34DispatchAllOver:InAnimation()
  local lockName = "UIN34DispatchAllOver:InAnimation"
  self:StartTask(function(TT)
    self:Lock(lockName)
    self._animation:Play("uieff_UIN34DispatchAllOver_in")
    YIELD(TT, 667)
    self:UnLock(lockName)
  end)
end

function UIN34DispatchAllOver:OutAnimation(endCb)
  local lockName = "UIN34DispatchAllOver:OutAnimation"
  self:StartTask(function(TT)
    self:Lock(lockName)
    self._animation:Play("uieff_UIN34DispatchAllOver_out")
    YIELD(TT, 200)
    if endCb ~= nil then
      endCb()
    end
    self:UnLock(lockName)
  end)
end
