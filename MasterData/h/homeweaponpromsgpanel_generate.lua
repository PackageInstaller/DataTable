---@class HomeWeaponProMsgPanel_Generate_skillMsgBox_msgTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class HomeWeaponProMsgPanel_Generate_skillMsgBox
---@field public gameObject UnityEngine.GameObject
---@field public msgTxt HomeWeaponProMsgPanel_Generate_skillMsgBox_msgTxt

---@class HomeWeaponProMsgPanel_Generate_customBox
---@field public gameObject UnityEngine.GameObject
---@field public customBox CustomBox

---@class HomeWeaponProMsgPanel_Generate_closeBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class HomeWeaponProMsgPanel_Generate_msgList
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform

---@class HomeWeaponProMsgPanel_Generate_qualityTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class HomeWeaponProMsgPanel_Generate_accuracyTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class HomeWeaponProMsgPanel_Generate_typeNameTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class HomeWeaponProMsgPanel_Generate_weaponNameTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class HomeWeaponProMsgPanel_Generate_weaponTypeIcon
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class HomeWeaponProMsgPanel_Generate_mask
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button

---@class HomeWeaponProMsgPanel_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public animator UnityEngine.Animator
---@field public animOverCallBack AnimOverCallBack
---@field public mask HomeWeaponProMsgPanel_Generate_mask
---@field public weaponTypeIcon HomeWeaponProMsgPanel_Generate_weaponTypeIcon
---@field public weaponNameTxt HomeWeaponProMsgPanel_Generate_weaponNameTxt
---@field public typeNameTxt HomeWeaponProMsgPanel_Generate_typeNameTxt
---@field public weaponLoadList UnityEngine.GameObject
---@field public weaponLoadBox UnityEngine.GameObject
---@field public accuracyTxt HomeWeaponProMsgPanel_Generate_accuracyTxt
---@field public qualityTxt HomeWeaponProMsgPanel_Generate_qualityTxt
---@field public msgList HomeWeaponProMsgPanel_Generate_msgList
---@field public weaponList UnityEngine.GameObject
---@field public closeBtn HomeWeaponProMsgPanel_Generate_closeBtn
---@field public customBox HomeWeaponProMsgPanel_Generate_customBox
---@field public skillMsgBox HomeWeaponProMsgPanel_Generate_skillMsgBox
local HomeWeaponProMsgPanel = class("HomeWeaponProMsgPanel", require("WndBase"))

function HomeWeaponProMsgPanel:ctor(data)
end

---@private
function HomeWeaponProMsgPanel:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("HomeWeaponProMsgPanel")

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

	self:SetLocalizedText(Root)


	self:InitLogic(data)

end

---@private
function HomeWeaponProMsgPanel:InitGenerate__1(Root, data)
--[[
	Root
--]]

	self.animator = Root:GetComponent(TypeInfo.Animator)

	self.animOverCallBack = Root:GetComponent(TypeInfo.AnimOverCallBack)


end

---@private
function HomeWeaponProMsgPanel:InitGenerate__2(Root, data)
--[[
	Mask
--]]
	local tmp = Root:Find("Mask").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.mask = tmp

	tmp.button = tmp:GetComponent(TypeInfo.Button)
	tmp.button.onClick:RemoveAllListeners()
	tmp.button.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("HomeWeaponProMsgPanel_mask")
			if self.mask_Button_onClick then
				self:mask_Button_onClick(self.mask)
			end
		end)


end

---@private
function HomeWeaponProMsgPanel:InitGenerate__3(Root, data)
--[[
	BoxBg/RightPanel/WeaponTypeIcon
--]]
	local tmp = Root:Find("BoxBg/RightPanel/WeaponTypeIcon").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.weaponTypeIcon = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function HomeWeaponProMsgPanel:InitGenerate__4(Root, data)
--[[
	BoxBg/RightPanel/WeaponNameTxt
--]]
	local tmp = Root:Find("BoxBg/RightPanel/WeaponNameTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.weaponNameTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function HomeWeaponProMsgPanel:InitGenerate__5(Root, data)
--[[
	BoxBg/RightPanel/TypeBg/TypeNameTxt
--]]
	local tmp = Root:Find("BoxBg/RightPanel/TypeBg/TypeNameTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.typeNameTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function HomeWeaponProMsgPanel:InitGenerate__6(Root, data)
--[[
	BoxBg/RightPanel/LoadBg/WeaponLoadList
--]]
	local tmp = Root:Find("BoxBg/RightPanel/LoadBg/WeaponLoadList").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.weaponLoadList = tmp


end

---@private
function HomeWeaponProMsgPanel:InitGenerate__7(Root, data)
--[[
	BoxBg/RightPanel/LoadBg/WeaponLoadBox
--]]
	local tmp = Root:Find("BoxBg/RightPanel/LoadBg/WeaponLoadBox").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.weaponLoadBox = tmp


end

---@private
function HomeWeaponProMsgPanel:InitGenerate__8(Root, data)
--[[
	BoxBg/RightPanel/AccuracyBg/AccuracyTxt
--]]
	local tmp = Root:Find("BoxBg/RightPanel/AccuracyBg/AccuracyTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.accuracyTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function HomeWeaponProMsgPanel:InitGenerate__9(Root, data)
--[[
	BoxBg/RightPanel/QualityBg/QualityTxt
--]]
	local tmp = Root:Find("BoxBg/RightPanel/QualityBg/QualityTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.qualityTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function HomeWeaponProMsgPanel:InitGenerate__10(Root, data)
--[[
	BoxBg/RightPanel/Scroll View/Viewport/MsgList
--]]
	local tmp = Root:Find("BoxBg/RightPanel/Scroll View/Viewport/MsgList").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.msgList = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)


end

---@private
function HomeWeaponProMsgPanel:InitGenerate__11(Root, data)
--[[
	BoxBg/Scroll View/Viewport/WeaponList
--]]
	local tmp = Root:Find("BoxBg/Scroll View/Viewport/WeaponList").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.weaponList = tmp


end

---@private
function HomeWeaponProMsgPanel:InitGenerate__12(Root, data)
--[[
	BoxBg/CloseBtn
--]]
	local tmp = Root:Find("BoxBg/CloseBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.closeBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("HomeWeaponProMsgPanel_closeBtn")
			if self.closeBtn_ScaleButton_onClick then
				self:closeBtn_ScaleButton_onClick(self.closeBtn)
			end
		end)


end

---@private
function HomeWeaponProMsgPanel:InitGenerate__13(Root, data)
--[[
	Custom/CustomBox
--]]
	local tmp = Root:Find("Custom/CustomBox").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.customBox = tmp

	tmp.customBox = tmp:AddComponentLua("CustomBox", data)


end

---@private
function HomeWeaponProMsgPanel:InitGenerate__14(Root, data)
--[[
	Custom/SkillMsgBox
--]]
	local tmp = Root:Find("Custom/SkillMsgBox").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.skillMsgBox = tmp


end

---@private
function HomeWeaponProMsgPanel:InitGenerate__15(Root, data)
--[[
	Custom/SkillMsgBox/MsgTxt
--]]
	local tmp = Root:Find("Custom/SkillMsgBox/MsgTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.skillMsgBox.msgTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function HomeWeaponProMsgPanel:SetLocalizedText(Root)

    local locObj_HomeWeaponProMsgPanel_Text = Root:Find("BoxBg/Title/Text")
    if locObj_HomeWeaponProMsgPanel_Text then
        locObj_HomeWeaponProMsgPanel_Text.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.HomeWeaponProMsgPanel_Text
    end

    local locObj_HomeWeaponProMsgPanel_LoadTxt = Root:Find("BoxBg/RightPanel/LoadBg/LoadTxt")
    if locObj_HomeWeaponProMsgPanel_LoadTxt then
        locObj_HomeWeaponProMsgPanel_LoadTxt.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.HomeWeaponProMsgPanel_LoadTxt
    end

    local locObj_HomeWeaponProMsgPanel_AccuracyTitle = Root:Find("BoxBg/RightPanel/AccuracyBg/AccuracyTitle")
    if locObj_HomeWeaponProMsgPanel_AccuracyTitle then
        locObj_HomeWeaponProMsgPanel_AccuracyTitle.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.HomeWeaponProMsgPanel_AccuracyTitle
    end

    local locObj_HomeWeaponProMsgPanel_QualityTitle = Root:Find("BoxBg/RightPanel/QualityBg/QualityTitle")
    if locObj_HomeWeaponProMsgPanel_QualityTitle then
        locObj_HomeWeaponProMsgPanel_QualityTitle.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.HomeWeaponProMsgPanel_QualityTitle
    end

    local locObj_HomeWeaponProMsgPanel_TextTMP = Root:Find("BoxBg/RightPanel/titleBg/Text (TMP)")
    if locObj_HomeWeaponProMsgPanel_TextTMP then
        locObj_HomeWeaponProMsgPanel_TextTMP.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.HomeWeaponProMsgPanel_TextTMP
    end

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return HomeWeaponProMsgPanel