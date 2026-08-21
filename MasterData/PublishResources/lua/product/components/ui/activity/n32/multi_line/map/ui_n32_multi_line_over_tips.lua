_class("UIN32MultiLineOverTips", UIController)
UIN32MultiLineOverTips = UIN32MultiLineOverTips

function UIN32MultiLineOverTips:LoadDataOnEnter(TT, res)
  res:SetSucc(true)
end

function UIN32MultiLineOverTips:OnShow(uiParams)
  self:InitWidget()
  local unPassNum = uiParams[1]
  local roleModule = self:GetModule(RoleModule)
  local name = roleModule:GetName()
  self.desc:SetText(StringTable.Get("str_n32_multiline_branch_tips", name, unPassNum))
end

function UIN32MultiLineOverTips:InitWidget()
  self.desc = self:GetUIComponent("UILocalizationText", "desc")
  self.animation = self:GetUIComponent("Animation", "animation")
end

function UIN32MultiLineOverTips:BtnConformOnClick(go)
  self:StartTask(function(TT)
    local lockName = "UIN32MultiLineOverTips:ExitAni"
    self:Lock(lockName)
    self.animation:Play("uieff_UIN32MultiLineOverTips_out")
    YIELD(TT, 200)
    self:CloseDialog()
    self:UnLock(lockName)
  end)
end
