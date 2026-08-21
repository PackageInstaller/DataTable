---@class LoginResetPasswordPanel_Generate_okBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class LoginResetPasswordPanel_Generate_sendCodeTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class LoginResetPasswordPanel_Generate_sendCodeBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class LoginResetPasswordPanel_Generate_cheakPasswordInput
---@field public gameObject UnityEngine.GameObject
---@field public inputField UnityEngine.UI.InputField

---@class LoginResetPasswordPanel_Generate_newPasswordInput
---@field public gameObject UnityEngine.GameObject
---@field public inputField UnityEngine.UI.InputField

---@class LoginResetPasswordPanel_Generate_codeInput
---@field public gameObject UnityEngine.GameObject
---@field public inputField UnityEngine.UI.InputField

---@class LoginResetPasswordPanel_Generate_phoneInput
---@field public gameObject UnityEngine.GameObject
---@field public inputField UnityEngine.UI.InputField

---@class LoginResetPasswordPanel_Generate_titleTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class LoginResetPasswordPanel_Generate_maskBg
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button

---@class LoginResetPasswordPanel_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public animator UnityEngine.Animator
---@field public animOverCallBack AnimOverCallBack
---@field public maskBg LoginResetPasswordPanel_Generate_maskBg
---@field public titleTxt LoginResetPasswordPanel_Generate_titleTxt
---@field public phoneInput LoginResetPasswordPanel_Generate_phoneInput
---@field public codeInput LoginResetPasswordPanel_Generate_codeInput
---@field public newPasswordInput LoginResetPasswordPanel_Generate_newPasswordInput
---@field public cheakPasswordInput LoginResetPasswordPanel_Generate_cheakPasswordInput
---@field public sendCodeBtn LoginResetPasswordPanel_Generate_sendCodeBtn
---@field public sendCodeTxt LoginResetPasswordPanel_Generate_sendCodeTxt
---@field public okBtn LoginResetPasswordPanel_Generate_okBtn
local LoginResetPasswordPanel = class("LoginResetPasswordPanel", require("WndBase"))

function LoginResetPasswordPanel:ctor(data)
end

---@private
function LoginResetPasswordPanel:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("LoginResetPasswordPanel")

	local Root = self.transform 
	local tmp

	self:InitGenerate__1(Root,data)
	self:InitGenerate__2(Root,data)
	self:InitGenerate__3(Root,data)
	self:InitGenerate__4(Root,data)
	self:InitGenerate__5(Root,data)
	self:InitGenerate__6(Root,data)
	self:InitGenerate__7(Root,data)
	self:InitGenerate__8(Root,data)
	self:InitGenerate__9(Root,data)
	self:InitGenerate__10(Root,data)

	self:SetLocalizedText(Root)


	self:InitLogic(data)

end

---@private
function LoginResetPasswordPanel:InitGenerate__1(Root, data)
--[[
	Root
--]]

	self.animator = Root:GetComponent(TypeInfo.Animator)

	self.animOverCallBack = Root:GetComponent(TypeInfo.AnimOverCallBack)


end

---@private
function LoginResetPasswordPanel:InitGenerate__2(Root, data)
--[[
	MaskBg
--]]
	local tmp = Root:Find("MaskBg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.maskBg = tmp

	tmp.button = tmp:GetComponent(TypeInfo.Button)
	tmp.button.onClick:RemoveAllListeners()
	tmp.button.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("LoginResetPasswordPanel_maskBg")
			if self.maskBg_Button_onClick then
				self:maskBg_Button_onClick(self.maskBg)
			end
		end)


end

---@private
function LoginResetPasswordPanel:InitGenerate__3(Root, data)
--[[
	PanelBg/TitleBg/TitleTxt
--]]
	local tmp = Root:Find("PanelBg/TitleBg/TitleTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.titleTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function LoginResetPasswordPanel:InitGenerate__4(Root, data)
--[[
	PanelBg/PhoneInput
--]]
	local tmp = Root:Find("PanelBg/PhoneInput").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.phoneInput = tmp

	tmp.inputField = tmp:GetComponent(TypeInfo.InputField)
	tmp.inputField.onEndEdit:RemoveAllListeners()
	tmp.inputField.onEndEdit:AddListener(function (content)
			if self.phoneInput_InputField_onEndEdit then
				self:phoneInput_InputField_onEndEdit(self.phoneInput,content)
			end
		end)
	tmp.inputField.onValueChanged:RemoveAllListeners()
	tmp.inputField.onValueChanged:AddListener(function (content)
			if self.phoneInput_InputField_onValueChanged then
				self:phoneInput_InputField_onValueChanged(self.phoneInput,content)
			end
		end)


end

---@private
function LoginResetPasswordPanel:InitGenerate__5(Root, data)
--[[
	PanelBg/CodeInput
--]]
	local tmp = Root:Find("PanelBg/CodeInput").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.codeInput = tmp

	tmp.inputField = tmp:GetComponent(TypeInfo.InputField)
	tmp.inputField.onEndEdit:RemoveAllListeners()
	tmp.inputField.onEndEdit:AddListener(function (content)
			if self.codeInput_InputField_onEndEdit then
				self:codeInput_InputField_onEndEdit(self.codeInput,content)
			end
		end)
	tmp.inputField.onValueChanged:RemoveAllListeners()
	tmp.inputField.onValueChanged:AddListener(function (content)
			if self.codeInput_InputField_onValueChanged then
				self:codeInput_InputField_onValueChanged(self.codeInput,content)
			end
		end)


end

---@private
function LoginResetPasswordPanel:InitGenerate__6(Root, data)
--[[
	PanelBg/NewPasswordInput
--]]
	local tmp = Root:Find("PanelBg/NewPasswordInput").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.newPasswordInput = tmp

	tmp.inputField = tmp:GetComponent(TypeInfo.InputField)
	tmp.inputField.onEndEdit:RemoveAllListeners()
	tmp.inputField.onEndEdit:AddListener(function (content)
			if self.newPasswordInput_InputField_onEndEdit then
				self:newPasswordInput_InputField_onEndEdit(self.newPasswordInput,content)
			end
		end)
	tmp.inputField.onValueChanged:RemoveAllListeners()
	tmp.inputField.onValueChanged:AddListener(function (content)
			if self.newPasswordInput_InputField_onValueChanged then
				self:newPasswordInput_InputField_onValueChanged(self.newPasswordInput,content)
			end
		end)


end

---@private
function LoginResetPasswordPanel:InitGenerate__7(Root, data)
--[[
	PanelBg/CheakPasswordInput
--]]
	local tmp = Root:Find("PanelBg/CheakPasswordInput").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.cheakPasswordInput = tmp

	tmp.inputField = tmp:GetComponent(TypeInfo.InputField)
	tmp.inputField.onEndEdit:RemoveAllListeners()
	tmp.inputField.onEndEdit:AddListener(function (content)
			if self.cheakPasswordInput_InputField_onEndEdit then
				self:cheakPasswordInput_InputField_onEndEdit(self.cheakPasswordInput,content)
			end
		end)
	tmp.inputField.onValueChanged:RemoveAllListeners()
	tmp.inputField.onValueChanged:AddListener(function (content)
			if self.cheakPasswordInput_InputField_onValueChanged then
				self:cheakPasswordInput_InputField_onValueChanged(self.cheakPasswordInput,content)
			end
		end)


end

---@private
function LoginResetPasswordPanel:InitGenerate__8(Root, data)
--[[
	PanelBg/SendCodeBtn
--]]
	local tmp = Root:Find("PanelBg/SendCodeBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.sendCodeBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("LoginResetPasswordPanel_sendCodeBtn")
			if self.sendCodeBtn_ScaleButton_onClick then
				self:sendCodeBtn_ScaleButton_onClick(self.sendCodeBtn)
			end
		end)


end

---@private
function LoginResetPasswordPanel:InitGenerate__9(Root, data)
--[[
	PanelBg/SendCodeBtn/SendCodeTxt
--]]
	local tmp = Root:Find("PanelBg/SendCodeBtn/SendCodeTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.sendCodeTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function LoginResetPasswordPanel:InitGenerate__10(Root, data)
--[[
	PanelBg/OkBtn
--]]
	local tmp = Root:Find("PanelBg/OkBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.okBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("LoginResetPasswordPanel_okBtn")
			if self.okBtn_ScaleButton_onClick then
				self:okBtn_ScaleButton_onClick(self.okBtn)
			end
		end)


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function LoginResetPasswordPanel:SetLocalizedText(Root)

    local locObj_LoginResetPasswordPanel_Placeholder = Root:Find("PanelBg/PhoneInput/Placeholder")
    if locObj_LoginResetPasswordPanel_Placeholder then
        locObj_LoginResetPasswordPanel_Placeholder.gameObject:GetComponent(TypeInfo.Text).text = UILanguageEnum.LoginResetPasswordPanel_Placeholder
    end

    local locObj_LoginResetPasswordPanel_Ct_Placeholder = Root:Find("PanelBg/CodeInput/Placeholder")
    if locObj_LoginResetPasswordPanel_Ct_Placeholder then
        locObj_LoginResetPasswordPanel_Ct_Placeholder.gameObject:GetComponent(TypeInfo.Text).text = UILanguageEnum.LoginResetPasswordPanel_Ct_Placeholder
    end

    local locObj_LoginResetPasswordPanel_Nt_Placeholder = Root:Find("PanelBg/NewPasswordInput/Placeholder")
    if locObj_LoginResetPasswordPanel_Nt_Placeholder then
        locObj_LoginResetPasswordPanel_Nt_Placeholder.gameObject:GetComponent(TypeInfo.Text).text = UILanguageEnum.LoginResetPasswordPanel_Nt_Placeholder
    end

    local locObj_LoginResetPasswordPanel_Pg_Ct_Placeholder = Root:Find("PanelBg/CheakPasswordInput/Placeholder")
    if locObj_LoginResetPasswordPanel_Pg_Ct_Placeholder then
        locObj_LoginResetPasswordPanel_Pg_Ct_Placeholder.gameObject:GetComponent(TypeInfo.Text).text = UILanguageEnum.LoginResetPasswordPanel_Pg_Ct_Placeholder
    end

    local locObj_LoginResetPasswordPanel_Text = Root:Find("PanelBg/OkBtn/Text")
    if locObj_LoginResetPasswordPanel_Text then
        locObj_LoginResetPasswordPanel_Text.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.LoginResetPasswordPanel_Text
    end

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return LoginResetPasswordPanel