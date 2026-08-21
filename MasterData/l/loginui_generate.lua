---@class LoginUI_Generate_localDevToggle
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform
---@field public toggle UnityEngine.UI.Toggle

---@class LoginUI_Generate_version
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class LoginUI_Generate_ageAdaptBtn
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button
---@field public clickLongPressListener ClickLongPressListener

---@class LoginUI_Generate_noiteBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class LoginUI_Generate_privacyBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class LoginUI_Generate_repairBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class LoginUI_Generate_helperBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class LoginUI_Generate_changeAccountBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class LoginUI_Generate_adjustRoot
---@field public gameObject UnityEngine.GameObject
---@field public autoAdjustCanvasRoot AutoAdjustCanvasRoot

---@class LoginUI_Generate_guideSkipToggle
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform
---@field public toggle UnityEngine.UI.Toggle

---@class LoginUI_Generate_avgIDInputField
---@field public gameObject UnityEngine.GameObject
---@field public inputField UnityEngine.UI.InputField

---@class LoginUI_Generate_avgEditorBtn
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button

---@class LoginUI_Generate_notifyTestBtn
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button

---@class LoginUI_Generate_roleSpineBtn
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button

---@class LoginUI_Generate_plotIDInputField
---@field public gameObject UnityEngine.GameObject
---@field public inputField UnityEngine.UI.InputField

---@class LoginUI_Generate_plotEditorBtn
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button

---@class LoginUI_Generate_toggleFormalPanel
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button
---@field public clickLongPressListener ClickLongPressListener

---@class LoginUI_Generate_tips2
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button

---@class LoginUI_Generate_protoAgreementCheck_agreement2Btn
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button

---@class LoginUI_Generate_protoAgreementCheck_agreement1Btn
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button

---@class LoginUI_Generate_protoAgreementCheck
---@field public gameObject UnityEngine.GameObject
---@field public toggle UnityEngine.UI.Toggle
---@field public agreement1Btn LoginUI_Generate_protoAgreementCheck_agreement1Btn
---@field public agreement2Btn LoginUI_Generate_protoAgreementCheck_agreement2Btn

---@class LoginUI_Generate_deleteAccountBtn_text
---@field public gameObject UnityEngine.GameObject
---@field public text UnityEngine.UI.Text

---@class LoginUI_Generate_deleteAccountBtn
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button
---@field public text LoginUI_Generate_deleteAccountBtn_text

---@class LoginUI_Generate_currServerName
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class LoginUI_Generate_changeServerBtn
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button
---@field public text UnityEngine.GameObject

---@class LoginUI_Generate_beginGameBtn
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button

---@class LoginUI_Generate_standaloneCheck
---@field public gameObject UnityEngine.GameObject
---@field public toggle UnityEngine.UI.Toggle

---@class LoginUI_Generate_loginBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class LoginUI_Generate_registerBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class LoginUI_Generate_passport
---@field public gameObject UnityEngine.GameObject
---@field public inputField UnityEngine.UI.InputField

---@class LoginUI_Generate_account
---@field public gameObject UnityEngine.GameObject
---@field public inputField UnityEngine.UI.InputField

---@class LoginUI_Generate_titleTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class LoginUI_Generate_maskBtn
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button

---@class LoginUI_Generate_kvBg
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform

---@class LoginUI_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public kvBg LoginUI_Generate_kvBg
---@field public devPanel UnityEngine.GameObject
---@field public maskBtn LoginUI_Generate_maskBtn
---@field public titleTxt LoginUI_Generate_titleTxt
---@field public account LoginUI_Generate_account
---@field public passport LoginUI_Generate_passport
---@field public registerBtn LoginUI_Generate_registerBtn
---@field public loginBtn LoginUI_Generate_loginBtn
---@field public standaloneCheck LoginUI_Generate_standaloneCheck
---@field public formalPanel UnityEngine.GameObject
---@field public beginGameBtn LoginUI_Generate_beginGameBtn
---@field public changeServerBtn LoginUI_Generate_changeServerBtn
---@field public currServerName LoginUI_Generate_currServerName
---@field public deleteAccountBtn LoginUI_Generate_deleteAccountBtn
---@field public protoAgreementCheck LoginUI_Generate_protoAgreementCheck
---@field public tips2 LoginUI_Generate_tips2
---@field public toggleFormalPanel LoginUI_Generate_toggleFormalPanel
---@field public editorMode UnityEngine.GameObject
---@field public plotEditorBtn LoginUI_Generate_plotEditorBtn
---@field public plotIDInputField LoginUI_Generate_plotIDInputField
---@field public roleSpineBtn LoginUI_Generate_roleSpineBtn
---@field public notifyTestBtn LoginUI_Generate_notifyTestBtn
---@field public avgEditorBtn LoginUI_Generate_avgEditorBtn
---@field public avgIDInputField LoginUI_Generate_avgIDInputField
---@field public guideSkipToggle LoginUI_Generate_guideSkipToggle
---@field public adjustRoot LoginUI_Generate_adjustRoot
---@field public changeAccountBtn LoginUI_Generate_changeAccountBtn
---@field public helperBtn LoginUI_Generate_helperBtn
---@field public repairBtn LoginUI_Generate_repairBtn
---@field public privacyBtn LoginUI_Generate_privacyBtn
---@field public noiteBtn LoginUI_Generate_noiteBtn
---@field public ageAdaptBtn LoginUI_Generate_ageAdaptBtn
---@field public version LoginUI_Generate_version
---@field public localDevToggle LoginUI_Generate_localDevToggle
local LoginUI = class("LoginUI", require("WndBase"))

function LoginUI:ctor(data)
end

---@private
function LoginUI:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("LoginUI")

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
	self:InitGenerate__11(Root,data)
	self:InitGenerate__12(Root,data)
	self:InitGenerate__13(Root,data)
	self:InitGenerate__14(Root,data)
	self:InitGenerate__15(Root,data)
	self:InitGenerate__16(Root,data)
	self:InitGenerate__17(Root,data)
	self:InitGenerate__18(Root,data)
	self:InitGenerate__19(Root,data)
	self:InitGenerate__20(Root,data)
	self:InitGenerate__21(Root,data)
	self:InitGenerate__22(Root,data)
	self:InitGenerate__23(Root,data)
	self:InitGenerate__24(Root,data)
	self:InitGenerate__25(Root,data)
	self:InitGenerate__26(Root,data)
	self:InitGenerate__27(Root,data)
	self:InitGenerate__28(Root,data)
	self:InitGenerate__29(Root,data)
	self:InitGenerate__30(Root,data)
	self:InitGenerate__31(Root,data)
	self:InitGenerate__32(Root,data)
	self:InitGenerate__33(Root,data)
	self:InitGenerate__34(Root,data)
	self:InitGenerate__35(Root,data)
	self:InitGenerate__36(Root,data)
	self:InitGenerate__37(Root,data)
	self:InitGenerate__38(Root,data)

	self:SetLocalizedText(Root)


	self:InitLogic(data)

end

---@private
function LoginUI:InitGenerate__1(Root, data)
--[[
	KvBg
--]]
	local tmp = Root:Find("KvBg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.kvBg = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)


end

---@private
function LoginUI:InitGenerate__2(Root, data)
--[[
	DevPanel
--]]
	local tmp = Root:Find("DevPanel").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.devPanel = tmp


end

---@private
function LoginUI:InitGenerate__3(Root, data)
--[[
	DevPanel/maskBtn
--]]
	local tmp = Root:Find("DevPanel/maskBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.maskBtn = tmp

	tmp.button = tmp:GetComponent(TypeInfo.Button)
	tmp.button.onClick:RemoveAllListeners()
	tmp.button.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("LoginUI_maskBtn")
			if self.maskBtn_Button_onClick then
				self:maskBtn_Button_onClick(self.maskBtn)
			end
		end)


end

---@private
function LoginUI:InitGenerate__4(Root, data)
--[[
	DevPanel/TitleTxt
--]]
	local tmp = Root:Find("DevPanel/TitleTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.titleTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function LoginUI:InitGenerate__5(Root, data)
--[[
	DevPanel/account
--]]
	local tmp = Root:Find("DevPanel/account").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.account = tmp

	tmp.inputField = tmp:GetComponent(TypeInfo.InputField)


end

---@private
function LoginUI:InitGenerate__6(Root, data)
--[[
	DevPanel/passport
--]]
	local tmp = Root:Find("DevPanel/passport").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.passport = tmp

	tmp.inputField = tmp:GetComponent(TypeInfo.InputField)


end

---@private
function LoginUI:InitGenerate__7(Root, data)
--[[
	DevPanel/RegisterBtn
--]]
	local tmp = Root:Find("DevPanel/RegisterBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.registerBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("LoginUI_registerBtn")
			if self.registerBtn_ScaleButton_onClick then
				self:registerBtn_ScaleButton_onClick(self.registerBtn)
			end
		end)


end

---@private
function LoginUI:InitGenerate__8(Root, data)
--[[
	DevPanel/LoginBtn
--]]
	local tmp = Root:Find("DevPanel/LoginBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.loginBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("LoginUI_loginBtn")
			if self.loginBtn_ScaleButton_onClick then
				self:loginBtn_ScaleButton_onClick(self.loginBtn)
			end
		end)


end

---@private
function LoginUI:InitGenerate__9(Root, data)
--[[
	DevPanel/StandaloneCheck
--]]
	local tmp = Root:Find("DevPanel/StandaloneCheck").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.standaloneCheck = tmp

	tmp.toggle = tmp:GetComponent(TypeInfo.Toggle)
	tmp.toggle.onValueChanged:RemoveAllListeners()
	tmp.toggle.onValueChanged:AddListener(function (isOn)
			if self.standaloneCheck_Toggle_onValueChanged then
				self:standaloneCheck_Toggle_onValueChanged(self.standaloneCheck,isOn)
			end
		end)


end

---@private
function LoginUI:InitGenerate__10(Root, data)
--[[
	FormalPanel
--]]
	local tmp = Root:Find("FormalPanel").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.formalPanel = tmp


end

---@private
function LoginUI:InitGenerate__11(Root, data)
--[[
	FormalPanel/beginGameBtn
--]]
	local tmp = Root:Find("FormalPanel/beginGameBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.beginGameBtn = tmp

	tmp.button = tmp:GetComponent(TypeInfo.Button)
	tmp.button.onClick:RemoveAllListeners()
	tmp.button.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("LoginUI_beginGameBtn")
			if self.beginGameBtn_Button_onClick then
				self:beginGameBtn_Button_onClick(self.beginGameBtn)
			end
		end)


end

---@private
function LoginUI:InitGenerate__12(Root, data)
--[[
	FormalPanel/changeServerBtn
--]]
	local tmp = Root:Find("FormalPanel/changeServerBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.changeServerBtn = tmp

	tmp.button = tmp:GetComponent(TypeInfo.Button)
	tmp.button.onClick:RemoveAllListeners()
	tmp.button.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("LoginUI_changeServerBtn")
			if self.changeServerBtn_Button_onClick then
				self:changeServerBtn_Button_onClick(self.changeServerBtn)
			end
		end)


end

---@private
function LoginUI:InitGenerate__13(Root, data)
--[[
	FormalPanel/changeServerBtn/text
--]]
	local tmp = Root:Find("FormalPanel/changeServerBtn/text").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.changeServerBtn.text = tmp


end

---@private
function LoginUI:InitGenerate__14(Root, data)
--[[
	FormalPanel/changeServerBtn/currServerName
--]]
	local tmp = Root:Find("FormalPanel/changeServerBtn/currServerName").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.currServerName = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function LoginUI:InitGenerate__15(Root, data)
--[[
	FormalPanel/deleteAccountBtn
--]]
	local tmp = Root:Find("FormalPanel/deleteAccountBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.deleteAccountBtn = tmp

	tmp.button = tmp:GetComponent(TypeInfo.Button)
	tmp.button.onClick:RemoveAllListeners()
	tmp.button.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("LoginUI_deleteAccountBtn")
			if self.deleteAccountBtn_Button_onClick then
				self:deleteAccountBtn_Button_onClick(self.deleteAccountBtn)
			end
		end)


end

---@private
function LoginUI:InitGenerate__16(Root, data)
--[[
	FormalPanel/deleteAccountBtn/text
--]]
	local tmp = Root:Find("FormalPanel/deleteAccountBtn/text").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.deleteAccountBtn.text = tmp

	tmp.text = tmp:GetComponent(TypeInfo.Text)


end

---@private
function LoginUI:InitGenerate__17(Root, data)
--[[
	FormalPanel/ProtoAgreementCheck
--]]
	local tmp = Root:Find("FormalPanel/ProtoAgreementCheck").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.protoAgreementCheck = tmp

	tmp.toggle = tmp:GetComponent(TypeInfo.Toggle)
	tmp.toggle.onValueChanged:RemoveAllListeners()
	tmp.toggle.onValueChanged:AddListener(function (isOn)
			if self.protoAgreementCheck_Toggle_onValueChanged then
				self:protoAgreementCheck_Toggle_onValueChanged(self.protoAgreementCheck,isOn)
			end
		end)


end

---@private
function LoginUI:InitGenerate__18(Root, data)
--[[
	FormalPanel/ProtoAgreementCheck/agreement1Btn
--]]
	local tmp = Root:Find("FormalPanel/ProtoAgreementCheck/agreement1Btn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.protoAgreementCheck.agreement1Btn = tmp

	tmp.button = tmp:GetComponent(TypeInfo.Button)
	tmp.button.onClick:RemoveAllListeners()
	tmp.button.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("LoginUI_agreement1Btn")
			if self.agreement1Btn_Button_onClick then
				self:agreement1Btn_Button_onClick(self.protoAgreementCheck.agreement1Btn)
			end
		end)


end

---@private
function LoginUI:InitGenerate__19(Root, data)
--[[
	FormalPanel/ProtoAgreementCheck/agreement2Btn
--]]
	local tmp = Root:Find("FormalPanel/ProtoAgreementCheck/agreement2Btn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.protoAgreementCheck.agreement2Btn = tmp

	tmp.button = tmp:GetComponent(TypeInfo.Button)
	tmp.button.onClick:RemoveAllListeners()
	tmp.button.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("LoginUI_agreement2Btn")
			if self.agreement2Btn_Button_onClick then
				self:agreement2Btn_Button_onClick(self.protoAgreementCheck.agreement2Btn)
			end
		end)


end

---@private
function LoginUI:InitGenerate__20(Root, data)
--[[
	FormalPanel/tips/tips2
--]]
	local tmp = Root:Find("FormalPanel/tips/tips2").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.tips2 = tmp

	tmp.button = tmp:GetComponent(TypeInfo.Button)
	tmp.button.onClick:RemoveAllListeners()
	tmp.button.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("LoginUI_tips2")
			if self.tips2_Button_onClick then
				self:tips2_Button_onClick(self.tips2)
			end
		end)


end

---@private
function LoginUI:InitGenerate__21(Root, data)
--[[
	ToggleFormalPanel
--]]
	local tmp = Root:Find("ToggleFormalPanel").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.toggleFormalPanel = tmp

	tmp.button = tmp:GetComponent(TypeInfo.Button)
	tmp.button.onClick:RemoveAllListeners()
	tmp.button.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("LoginUI_toggleFormalPanel")
			if self.toggleFormalPanel_Button_onClick then
				self:toggleFormalPanel_Button_onClick(self.toggleFormalPanel)
			end
		end)

	tmp.clickLongPressListener = tmp:GetComponent(TypeInfo.ClickLongPressListener)


end

---@private
function LoginUI:InitGenerate__22(Root, data)
--[[
	EditorMode
--]]
	local tmp = Root:Find("EditorMode").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.editorMode = tmp


end

---@private
function LoginUI:InitGenerate__23(Root, data)
--[[
	EditorMode/PlotEditorBtn
--]]
	local tmp = Root:Find("EditorMode/PlotEditorBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.plotEditorBtn = tmp

	tmp.button = tmp:GetComponent(TypeInfo.Button)
	tmp.button.onClick:RemoveAllListeners()
	tmp.button.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("LoginUI_plotEditorBtn")
			if self.plotEditorBtn_Button_onClick then
				self:plotEditorBtn_Button_onClick(self.plotEditorBtn)
			end
		end)


end

---@private
function LoginUI:InitGenerate__24(Root, data)
--[[
	EditorMode/PlotEditorBtn/PlotIDInputField
--]]
	local tmp = Root:Find("EditorMode/PlotEditorBtn/PlotIDInputField").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.plotIDInputField = tmp

	tmp.inputField = tmp:GetComponent(TypeInfo.InputField)
	tmp.inputField.onEndEdit:RemoveAllListeners()
	tmp.inputField.onEndEdit:AddListener(function (content)
			if self.plotIDInputField_InputField_onEndEdit then
				self:plotIDInputField_InputField_onEndEdit(self.plotIDInputField,content)
			end
		end)


end

---@private
function LoginUI:InitGenerate__25(Root, data)
--[[
	EditorMode/RoleSpineBtn
--]]
	local tmp = Root:Find("EditorMode/RoleSpineBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.roleSpineBtn = tmp

	tmp.button = tmp:GetComponent(TypeInfo.Button)
	tmp.button.onClick:RemoveAllListeners()
	tmp.button.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("LoginUI_roleSpineBtn")
			if self.roleSpineBtn_Button_onClick then
				self:roleSpineBtn_Button_onClick(self.roleSpineBtn)
			end
		end)


end

---@private
function LoginUI:InitGenerate__26(Root, data)
--[[
	EditorMode/NotifyTestBtn
--]]
	local tmp = Root:Find("EditorMode/NotifyTestBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.notifyTestBtn = tmp

	tmp.button = tmp:GetComponent(TypeInfo.Button)
	tmp.button.onClick:RemoveAllListeners()
	tmp.button.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("LoginUI_notifyTestBtn")
			if self.notifyTestBtn_Button_onClick then
				self:notifyTestBtn_Button_onClick(self.notifyTestBtn)
			end
		end)


end

---@private
function LoginUI:InitGenerate__27(Root, data)
--[[
	EditorMode/AvgEditorBtn
--]]
	local tmp = Root:Find("EditorMode/AvgEditorBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.avgEditorBtn = tmp

	tmp.button = tmp:GetComponent(TypeInfo.Button)
	tmp.button.onClick:RemoveAllListeners()
	tmp.button.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("LoginUI_avgEditorBtn")
			if self.avgEditorBtn_Button_onClick then
				self:avgEditorBtn_Button_onClick(self.avgEditorBtn)
			end
		end)


end

---@private
function LoginUI:InitGenerate__28(Root, data)
--[[
	EditorMode/AvgEditorBtn/AvgIDInputField
--]]
	local tmp = Root:Find("EditorMode/AvgEditorBtn/AvgIDInputField").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.avgIDInputField = tmp

	tmp.inputField = tmp:GetComponent(TypeInfo.InputField)
	tmp.inputField.onEndEdit:RemoveAllListeners()
	tmp.inputField.onEndEdit:AddListener(function (content)
			if self.avgIDInputField_InputField_onEndEdit then
				self:avgIDInputField_InputField_onEndEdit(self.avgIDInputField,content)
			end
		end)


end

---@private
function LoginUI:InitGenerate__29(Root, data)
--[[
	GuideSkipToggle
--]]
	local tmp = Root:Find("GuideSkipToggle").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.guideSkipToggle = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)

	tmp.toggle = tmp:GetComponent(TypeInfo.Toggle)
	tmp.toggle.onValueChanged:RemoveAllListeners()
	tmp.toggle.onValueChanged:AddListener(function (isOn)
			if self.guideSkipToggle_Toggle_onValueChanged then
				self:guideSkipToggle_Toggle_onValueChanged(self.guideSkipToggle,isOn)
			end
		end)


end

---@private
function LoginUI:InitGenerate__30(Root, data)
--[[
	AdjustRoot
--]]
	local tmp = Root:Find("AdjustRoot").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.adjustRoot = tmp

	tmp.autoAdjustCanvasRoot = tmp:GetComponent(TypeInfo.AutoAdjustCanvasRoot)


end

---@private
function LoginUI:InitGenerate__31(Root, data)
--[[
	AdjustRoot/changeAccountBtn
--]]
	local tmp = Root:Find("AdjustRoot/changeAccountBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.changeAccountBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("LoginUI_changeAccountBtn")
			if self.changeAccountBtn_ScaleButton_onClick then
				self:changeAccountBtn_ScaleButton_onClick(self.changeAccountBtn)
			end
		end)


end

---@private
function LoginUI:InitGenerate__32(Root, data)
--[[
	AdjustRoot/RightPanel/HelperBtn
--]]
	local tmp = Root:Find("AdjustRoot/RightPanel/HelperBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.helperBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("LoginUI_helperBtn")
			if self.helperBtn_ScaleButton_onClick then
				self:helperBtn_ScaleButton_onClick(self.helperBtn)
			end
		end)


end

---@private
function LoginUI:InitGenerate__33(Root, data)
--[[
	AdjustRoot/RightPanel/RepairBtn
--]]
	local tmp = Root:Find("AdjustRoot/RightPanel/RepairBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.repairBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("LoginUI_repairBtn")
			if self.repairBtn_ScaleButton_onClick then
				self:repairBtn_ScaleButton_onClick(self.repairBtn)
			end
		end)


end

---@private
function LoginUI:InitGenerate__34(Root, data)
--[[
	AdjustRoot/RightPanel/PrivacyBtn
--]]
	local tmp = Root:Find("AdjustRoot/RightPanel/PrivacyBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.privacyBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("LoginUI_privacyBtn")
			if self.privacyBtn_ScaleButton_onClick then
				self:privacyBtn_ScaleButton_onClick(self.privacyBtn)
			end
		end)


end

---@private
function LoginUI:InitGenerate__35(Root, data)
--[[
	AdjustRoot/RightPanel/NoiteBtn
--]]
	local tmp = Root:Find("AdjustRoot/RightPanel/NoiteBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.noiteBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("LoginUI_noiteBtn")
			if self.noiteBtn_ScaleButton_onClick then
				self:noiteBtn_ScaleButton_onClick(self.noiteBtn)
			end
		end)


end

---@private
function LoginUI:InitGenerate__36(Root, data)
--[[
	AdjustRoot/ageAdaptBtn
--]]
	local tmp = Root:Find("AdjustRoot/ageAdaptBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.ageAdaptBtn = tmp

	tmp.button = tmp:GetComponent(TypeInfo.Button)
	tmp.button.onClick:RemoveAllListeners()
	tmp.button.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("LoginUI_ageAdaptBtn")
			if self.ageAdaptBtn_Button_onClick then
				self:ageAdaptBtn_Button_onClick(self.ageAdaptBtn)
			end
		end)

	tmp.clickLongPressListener = tmp:GetComponent(TypeInfo.ClickLongPressListener)


end

---@private
function LoginUI:InitGenerate__37(Root, data)
--[[
	AdjustRoot/version
--]]
	local tmp = Root:Find("AdjustRoot/version").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.version = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function LoginUI:InitGenerate__38(Root, data)
--[[
	LocalDevToggle
--]]
	local tmp = Root:Find("LocalDevToggle").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.localDevToggle = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)

	tmp.toggle = tmp:GetComponent(TypeInfo.Toggle)
	tmp.toggle.onValueChanged:RemoveAllListeners()
	tmp.toggle.onValueChanged:AddListener(function (isOn)
			if self.localDevToggle_Toggle_onValueChanged then
				self:localDevToggle_Toggle_onValueChanged(self.localDevToggle,isOn)
			end
		end)


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function LoginUI:SetLocalizedText(Root)

    local locObj_LoginRegister_Placeholder = Root:Find("DevPanel/account/Placeholder")
    if locObj_LoginRegister_Placeholder then
        locObj_LoginRegister_Placeholder.gameObject:GetComponent(TypeInfo.Text).text = UILanguageEnum.LoginRegister_Placeholder
    end

    local locObj_LoginRegister_pt_Placeholder = Root:Find("DevPanel/passport/Placeholder")
    if locObj_LoginRegister_pt_Placeholder then
        locObj_LoginRegister_pt_Placeholder.gameObject:GetComponent(TypeInfo.Text).text = UILanguageEnum.LoginRegister_pt_Placeholder
    end

    local locObj_LoginRegister_txt = Root:Find("DevPanel/RegisterBtn/txt")
    if locObj_LoginRegister_txt then
        locObj_LoginRegister_txt.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.LoginRegister_txt
    end

    local locObj_LoginRegister_Ln_txt = Root:Find("DevPanel/LoginBtn/txt")
    if locObj_LoginRegister_Ln_txt then
        locObj_LoginRegister_Ln_txt.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.LoginRegister_Ln_txt
    end

    local locObj_LoginRegister_Text = Root:Find("DevPanel/WriteBtn/Text")
    if locObj_LoginRegister_Text then
        locObj_LoginRegister_Text.gameObject:GetComponent(TypeInfo.Text).text = UILanguageEnum.LoginRegister_Text
    end

    local locObj_LoginRegister_Rn_Text = Root:Find("DevPanel/ReadBtn/Text")
    if locObj_LoginRegister_Rn_Text then
        locObj_LoginRegister_Rn_Text.gameObject:GetComponent(TypeInfo.Text).text = UILanguageEnum.LoginRegister_Rn_Text
    end

    local locObj_LoginRegister_Label = Root:Find("DevPanel/StandaloneCheck/Label")
    if locObj_LoginRegister_Label then
        locObj_LoginRegister_Label.gameObject:GetComponent(TypeInfo.Text).text = UILanguageEnum.LoginRegister_Label
    end

    local locObj_LoginRegister_Sd_Placeholder = Root:Find("DevPanel/SimDataField/Placeholder")
    if locObj_LoginRegister_Sd_Placeholder then
        locObj_LoginRegister_Sd_Placeholder.gameObject:GetComponent(TypeInfo.Text).text = UILanguageEnum.LoginRegister_Sd_Placeholder
    end

    local locObj_LoginRegister_Dl_Sd_Placeholder = Root:Find("DevPanel/SimFileField/Placeholder")
    if locObj_LoginRegister_Dl_Sd_Placeholder then
        locObj_LoginRegister_Dl_Sd_Placeholder.gameObject:GetComponent(TypeInfo.Text).text = UILanguageEnum.LoginRegister_Dl_Sd_Placeholder
    end

    local locObj_LoginRegister_ClickTxt = Root:Find("FormalPanel/beginGameBtn/StartBg/ClickTxt")
    if locObj_LoginRegister_ClickTxt then
        locObj_LoginRegister_ClickTxt.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.LoginRegister_ClickTxt
    end

    local locObj_LoginRegister_appInfoText = Root:Find("FormalPanel/appInfoText")
    if locObj_LoginRegister_appInfoText then
        locObj_LoginRegister_appInfoText.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.LoginRegister_appInfoText
    end

    local locObj_LoginRegister_text = Root:Find("FormalPanel/changeServerBtn/text")
    if locObj_LoginRegister_text then
        locObj_LoginRegister_text.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.LoginRegister_text
    end

    local locObj_LoginRegister_Pk_Label = Root:Find("FormalPanel/ProtoAgreementCheck/Label")
    if locObj_LoginRegister_Pk_Label then
        locObj_LoginRegister_Pk_Label.gameObject:GetComponent(TypeInfo.Text).text = UILanguageEnum.LoginRegister_Pk_Label
    end

    local locObj_LoginRegister_agreement1Btn = Root:Find("FormalPanel/ProtoAgreementCheck/agreement1Btn")
    if locObj_LoginRegister_agreement1Btn then
        locObj_LoginRegister_agreement1Btn.gameObject:GetComponent(TypeInfo.Text).text = UILanguageEnum.LoginRegister_agreement1Btn
    end

    local locObj_LoginRegister_Label1 = Root:Find("FormalPanel/ProtoAgreementCheck/Label (1)")
    if locObj_LoginRegister_Label1 then
        locObj_LoginRegister_Label1.gameObject:GetComponent(TypeInfo.Text).text = UILanguageEnum.LoginRegister_Label1
    end

    local locObj_LoginRegister_agreement2Btn = Root:Find("FormalPanel/ProtoAgreementCheck/agreement2Btn")
    if locObj_LoginRegister_agreement2Btn then
        locObj_LoginRegister_agreement2Btn.gameObject:GetComponent(TypeInfo.Text).text = UILanguageEnum.LoginRegister_agreement2Btn
    end

    local locObj_LoginRegister_tips = Root:Find("FormalPanel/tips")
    if locObj_LoginRegister_tips then
        locObj_LoginRegister_tips.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.LoginRegister_tips
    end

    local locObj_LoginRegister_tips2 = Root:Find("FormalPanel/tips/tips2")
    if locObj_LoginRegister_tips2 then
        locObj_LoginRegister_tips2.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.LoginRegister_tips2
    end

    local locObj_LoginRegister_tips3 = Root:Find("FormalPanel/tips/tips2/tips3")
    if locObj_LoginRegister_tips3 then
        locObj_LoginRegister_tips3.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.LoginRegister_tips3
    end

    local locObj_LoginRegister_tips1 = Root:Find("FormalPanel/tips/tips1")
    if locObj_LoginRegister_tips1 then
        locObj_LoginRegister_tips1.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.LoginRegister_tips1
    end

    local locObj_LoginRegister_Pn_Text = Root:Find("EditorMode/PlotEditorBtn/Text")
    if locObj_LoginRegister_Pn_Text then
        locObj_LoginRegister_Pn_Text.gameObject:GetComponent(TypeInfo.Text).text = UILanguageEnum.LoginRegister_Pn_Text
    end

    local locObj_LoginRegister_Pd_Placeholder = Root:Find("EditorMode/PlotEditorBtn/PlotIDInputField/Placeholder")
    if locObj_LoginRegister_Pd_Placeholder then
        locObj_LoginRegister_Pd_Placeholder.gameObject:GetComponent(TypeInfo.Text).text = UILanguageEnum.LoginRegister_Pd_Placeholder
    end

    local locObj_LoginRegister_Ee_Rn_Text = Root:Find("EditorMode/RoleSpineBtn/Text")
    if locObj_LoginRegister_Ee_Rn_Text then
        locObj_LoginRegister_Ee_Rn_Text.gameObject:GetComponent(TypeInfo.Text).text = UILanguageEnum.LoginRegister_Ee_Rn_Text
    end

    local locObj_LoginRegister_Nn_Text = Root:Find("EditorMode/NotifyTestBtn/Text")
    if locObj_LoginRegister_Nn_Text then
        locObj_LoginRegister_Nn_Text.gameObject:GetComponent(TypeInfo.Text).text = UILanguageEnum.LoginRegister_Nn_Text
    end

    local locObj_LoginRegister_An_Text = Root:Find("EditorMode/AvgEditorBtn/Text")
    if locObj_LoginRegister_An_Text then
        locObj_LoginRegister_An_Text.gameObject:GetComponent(TypeInfo.Text).text = UILanguageEnum.LoginRegister_An_Text
    end

    local locObj_LoginRegister_Ad_Placeholder = Root:Find("EditorMode/AvgEditorBtn/AvgIDInputField/Placeholder")
    if locObj_LoginRegister_Ad_Placeholder then
        locObj_LoginRegister_Ad_Placeholder.gameObject:GetComponent(TypeInfo.Text).text = UILanguageEnum.LoginRegister_Ad_Placeholder
    end

    local locObj_LoginRegister_Bg_Label = Root:Find("GuideSkipToggle/Bg/Label")
    if locObj_LoginRegister_Bg_Label then
        locObj_LoginRegister_Bg_Label.gameObject:GetComponent(TypeInfo.Text).text = UILanguageEnum.LoginRegister_Bg_Label
    end

    local locObj_LoginRegister_Le_Bg_Label = Root:Find("LocalDevToggle/Bg/Label")
    if locObj_LoginRegister_Le_Bg_Label then
        locObj_LoginRegister_Le_Bg_Label.gameObject:GetComponent(TypeInfo.Text).text = UILanguageEnum.LoginRegister_Le_Bg_Label
    end

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return LoginUI