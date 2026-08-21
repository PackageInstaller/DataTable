---@class LoginResetPasswordPanel : LoginResetPasswordPanel_Generate
---##################### 【LoginResetPasswordPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【LoginResetPasswordPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local LoginResetPasswordPanel = require "LoginResetPasswordPanel_Generate"

function LoginResetPasswordPanel:InitLogic(data)
    self.WaitSecond = 60
end

--function LoginResetPasswordPanel:StartCreating(time)
--
--end

--function LoginResetPasswordPanel:StartEnter(time)
--
--end

--function LoginResetPasswordPanel:StartRemoving(time)
--
--end

--function LoginResetPasswordPanel:StartExit(time)
--
--end

function LoginResetPasswordPanel:OnOpen(data, initiative)

end

--function LoginResetPasswordPanel:OnClose(initiative)
--
--end

--function LoginResetPasswordPanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function LoginResetPasswordPanel:OnRefresh(data)
--
--end

--[[
/MaskBg onClick 
--]]
function LoginResetPasswordPanel:maskBg_Button_onClick(maskBg)

end

--[[
/PanelBg/PhoneInput onEndEdit 
--]]
function LoginResetPasswordPanel:phoneInput_InputField_onEndEdit(phoneInput,content)

end

--[[
/PanelBg/PhoneInput onValueChanged 
--]]
function LoginResetPasswordPanel:phoneInput_InputField_onValueChanged(phoneInput,content)

end

--[[
/PanelBg/CodeInput onEndEdit 
--]]
function LoginResetPasswordPanel:codeInput_InputField_onEndEdit(codeInput,content)

end

--[[
/PanelBg/CodeInput onValueChanged 
--]]
function LoginResetPasswordPanel:codeInput_InputField_onValueChanged(codeInput,content)

end

--[[
/PanelBg/NewPasswordInput onEndEdit 
--]]
function LoginResetPasswordPanel:newPasswordInput_InputField_onEndEdit(newPasswordInput,content)

end

--[[
/PanelBg/NewPasswordInput onValueChanged 
--]]
function LoginResetPasswordPanel:newPasswordInput_InputField_onValueChanged(newPasswordInput,content)

end

--[[
/PanelBg/CheakPasswordInput onEndEdit 
--]]
function LoginResetPasswordPanel:cheakPasswordInput_InputField_onEndEdit(cheakPasswordInput,content)

end

--[[
/PanelBg/CheakPasswordInput onValueChanged 
--]]
function LoginResetPasswordPanel:cheakPasswordInput_InputField_onValueChanged(cheakPasswordInput,content)

end

--[[
/PanelBg/SendCodeBtn onClick 
--]]
function LoginResetPasswordPanel:sendCodeBtn_ScaleButton_onClick(sendCodeBtn)

end

--[[
/PanelBg/OkBtn onClick 
--]]
function LoginResetPasswordPanel:okBtn_ScaleButton_onClick(okBtn)
    self:OkBtnOnClick()
end

return LoginResetPasswordPanel
