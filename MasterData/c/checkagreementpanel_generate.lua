---@class CheckAgreementPanel_Generate_enterBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class CheckAgreementPanel_Generate_refuseBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class CheckAgreementPanel_Generate_okBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class CheckAgreementPanel_Generate_label
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI
---@field public textLink TextLink

---@class CheckAgreementPanel_Generate_cheakToggle
---@field public gameObject UnityEngine.GameObject
---@field public toggle UnityEngine.UI.Toggle

---@class CheckAgreementPanel_Generate_scrollbar
---@field public gameObject UnityEngine.GameObject
---@field public scrollbar UnityEngine.UI.Scrollbar

---@class CheckAgreementPanel_Generate_noticeTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class CheckAgreementPanel_Generate_titleTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class CheckAgreementPanel_Generate_maskBg
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button

---@class CheckAgreementPanel_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public animator UnityEngine.Animator
---@field public animOverCallBack AnimOverCallBack
---@field public maskBg CheckAgreementPanel_Generate_maskBg
---@field public titleTxt CheckAgreementPanel_Generate_titleTxt
---@field public noticeTxt CheckAgreementPanel_Generate_noticeTxt
---@field public scrollbar CheckAgreementPanel_Generate_scrollbar
---@field public cheakPanel UnityEngine.GameObject
---@field public cheakToggle CheckAgreementPanel_Generate_cheakToggle
---@field public label CheckAgreementPanel_Generate_label
---@field public okBtn CheckAgreementPanel_Generate_okBtn
---@field public refuseBtn CheckAgreementPanel_Generate_refuseBtn
---@field public enterBtn CheckAgreementPanel_Generate_enterBtn
local CheckAgreementPanel = class("CheckAgreementPanel", require("WndBase"))

function CheckAgreementPanel:ctor(data)
end

---@private
function CheckAgreementPanel:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("CheckAgreementPanel")

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

	self:SetLocalizedText(Root)


	self:InitLogic(data)

end

---@private
function CheckAgreementPanel:InitGenerate__1(Root, data)
--[[
	Root
--]]

	self.animator = Root:GetComponent(TypeInfo.Animator)

	self.animOverCallBack = Root:GetComponent(TypeInfo.AnimOverCallBack)


end

---@private
function CheckAgreementPanel:InitGenerate__2(Root, data)
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
		UIMgr:SendUiUseMessage("CheckAgreementPanel_maskBg")
			if self.maskBg_Button_onClick then
				self:maskBg_Button_onClick(self.maskBg)
			end
		end)


end

---@private
function CheckAgreementPanel:InitGenerate__3(Root, data)
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
function CheckAgreementPanel:InitGenerate__4(Root, data)
--[[
	PanelBg/Scroll View/Viewport/NoticeTxt
--]]
	local tmp = Root:Find("PanelBg/Scroll View/Viewport/NoticeTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.noticeTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function CheckAgreementPanel:InitGenerate__5(Root, data)
--[[
	PanelBg/Scroll View/Scrollbar
--]]
	local tmp = Root:Find("PanelBg/Scroll View/Scrollbar").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.scrollbar = tmp

	tmp.scrollbar = tmp:GetComponent(TypeInfo.Scrollbar)
	tmp.scrollbar.onValueChanged:RemoveAllListeners()
	tmp.scrollbar.onValueChanged:AddListener(function (value)
			if self.scrollbar_Scrollbar_onValueChanged then
				self:scrollbar_Scrollbar_onValueChanged(self.scrollbar,value)
			end
		end)


end

---@private
function CheckAgreementPanel:InitGenerate__6(Root, data)
--[[
	PanelBg/CheakPanel
--]]
	local tmp = Root:Find("PanelBg/CheakPanel").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.cheakPanel = tmp


end

---@private
function CheckAgreementPanel:InitGenerate__7(Root, data)
--[[
	PanelBg/CheakPanel/CheakToggle
--]]
	local tmp = Root:Find("PanelBg/CheakPanel/CheakToggle").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.cheakToggle = tmp

	tmp.toggle = tmp:GetComponent(TypeInfo.Toggle)
	tmp.toggle.onValueChanged:RemoveAllListeners()
	tmp.toggle.onValueChanged:AddListener(function (isOn)
			if self.cheakToggle_Toggle_onValueChanged then
				self:cheakToggle_Toggle_onValueChanged(self.cheakToggle,isOn)
			end
		end)


end

---@private
function CheckAgreementPanel:InitGenerate__8(Root, data)
--[[
	PanelBg/CheakPanel/Label
--]]
	local tmp = Root:Find("PanelBg/CheakPanel/Label").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.label = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)

	tmp.textLink = tmp:GetComponent(TypeInfo.TextLink)


end

---@private
function CheckAgreementPanel:InitGenerate__9(Root, data)
--[[
	PanelBg/CheakPanel/OkBtn
--]]
	local tmp = Root:Find("PanelBg/CheakPanel/OkBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.okBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("CheckAgreementPanel_okBtn")
			if self.okBtn_ScaleButton_onClick then
				self:okBtn_ScaleButton_onClick(self.okBtn)
			end
		end)


end

---@private
function CheckAgreementPanel:InitGenerate__10(Root, data)
--[[
	PanelBg/CheakPanel/RefuseBtn
--]]
	local tmp = Root:Find("PanelBg/CheakPanel/RefuseBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.refuseBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("CheckAgreementPanel_refuseBtn")
			if self.refuseBtn_ScaleButton_onClick then
				self:refuseBtn_ScaleButton_onClick(self.refuseBtn)
			end
		end)


end

---@private
function CheckAgreementPanel:InitGenerate__11(Root, data)
--[[
	PanelBg/EnterBtn
--]]
	local tmp = Root:Find("PanelBg/EnterBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.enterBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("CheckAgreementPanel_enterBtn")
			if self.enterBtn_ScaleButton_onClick then
				self:enterBtn_ScaleButton_onClick(self.enterBtn)
			end
		end)


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function CheckAgreementPanel:SetLocalizedText(Root)

    local locObj_CheckAgreementPanel_text = Root:Find("PanelBg/CheakPanel/OkBtn/text")
    if locObj_CheckAgreementPanel_text then
        locObj_CheckAgreementPanel_text.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.CheckAgreementPanel_text
    end

    local locObj_CheckAgreementPanel_Rn_text = Root:Find("PanelBg/CheakPanel/RefuseBtn/text")
    if locObj_CheckAgreementPanel_Rn_text then
        locObj_CheckAgreementPanel_Rn_text.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.CheckAgreementPanel_Rn_text
    end

    local locObj_CheckAgreementPanel_En_text = Root:Find("PanelBg/EnterBtn/text")
    if locObj_CheckAgreementPanel_En_text then
        locObj_CheckAgreementPanel_En_text.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.CheckAgreementPanel_En_text
    end

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return CheckAgreementPanel