_class("UIN0CookMakeFailedController", UIController)
UIN0CookMakeFailedController = UIN0CookMakeFailedController

function UIN0CookMakeFailedController:LoadDataOnEnter(TT, res)
  res:SetSucc(true)
end

function UIN0CookMakeFailedController:OnShow(uiParams)
  self:InitWidget()
  local name = uiParams[1]
  local tips = uiParams[2]
  local petIcon = uiParams[3]
  self.name1:SetText(StringTable.Get(name))
  self.tips:SetText(StringTable.Get("str_n0_food_false_tishi", tips))
  self.head:LoadImage(petIcon)
end

function UIN0CookMakeFailedController:InitWidget()
  self.name1 = self:GetUIComponent("UILocalizationText", "name1")
  self.tips = self:GetUIComponent("UILocalizationText", "tips")
  self.head = self:GetUIComponent("RawImageLoader", "head")
  self.animation = self:GetUIComponent("Animation", "animation")
end

function UIN0CookMakeFailedController:MaskOnClick(go)
  self:StartTask(function(TT)
    local lockName = "UIN0CookMakeFailedController:MaskOnClick"
    self:Lock(lockName)
    self.animation:Play("uieff_N0_CookMakeFailedController_out")
    YIELD(TT, 160)
    self:CloseDialog()
    self:UnLock(lockName)
  end)
end
