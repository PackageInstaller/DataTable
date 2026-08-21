---@class EquipDelFastPanel_Generate_modeBox_selectModeTxt
---@field public gameObject UnityEngine.GameObject
---@field public text UnityEngine.UI.Text

---@class EquipDelFastPanel_Generate_modeBox
---@field public gameObject UnityEngine.GameObject
---@field public selectModeTxt EquipDelFastPanel_Generate_modeBox_selectModeTxt
---@field public modeList UnityEngine.GameObject

---@class EquipDelFastPanel_Generate_modeBtn_selectNameTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class EquipDelFastPanel_Generate_modeBtn_modeNameTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class EquipDelFastPanel_Generate_modeBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton
---@field public modeNameTxt EquipDelFastPanel_Generate_modeBtn_modeNameTxt
---@field public isSelect UnityEngine.GameObject
---@field public selectNameTxt EquipDelFastPanel_Generate_modeBtn_selectNameTxt

---@class EquipDelFastPanel_Generate_allClearBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class EquipDelFastPanel_Generate_okBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class EquipDelFastPanel_Generate_closeBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class EquipDelFastPanel_Generate_mask
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button

---@class EquipDelFastPanel_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public animator UnityEngine.Animator
---@field public animOverCallBack AnimOverCallBack
---@field public mask EquipDelFastPanel_Generate_mask
---@field public closeBtn EquipDelFastPanel_Generate_closeBtn
---@field public teamList UnityEngine.GameObject
---@field public modeAllList UnityEngine.GameObject
---@field public okBtn EquipDelFastPanel_Generate_okBtn
---@field public allClearBtn EquipDelFastPanel_Generate_allClearBtn
---@field public modeBtn EquipDelFastPanel_Generate_modeBtn
---@field public modeBox EquipDelFastPanel_Generate_modeBox
local EquipDelFastPanel = class("EquipDelFastPanel", require("WndBase"))

function EquipDelFastPanel:ctor(data)
end

---@private
function EquipDelFastPanel:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("EquipDelFastPanel")

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

	self:SetLocalizedText(Root)


	self:InitLogic(data)

end

---@private
function EquipDelFastPanel:InitGenerate__1(Root, data)
--[[
	Root
--]]

	self.animator = Root:GetComponent(TypeInfo.Animator)

	self.animOverCallBack = Root:GetComponent(TypeInfo.AnimOverCallBack)


end

---@private
function EquipDelFastPanel:InitGenerate__2(Root, data)
--[[
	mask
--]]
	local tmp = Root:Find("mask").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.mask = tmp

	tmp.button = tmp:GetComponent(TypeInfo.Button)
	tmp.button.onClick:RemoveAllListeners()
	tmp.button.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("EquipDelFastPanel_mask")
			if self.mask_Button_onClick then
				self:mask_Button_onClick(self.mask)
			end
		end)


end

---@private
function EquipDelFastPanel:InitGenerate__3(Root, data)
--[[
	PanelBg/Art/TitleBg/CloseBtn
--]]
	local tmp = Root:Find("PanelBg/Art/TitleBg/CloseBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.closeBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("EquipDelFastPanel_closeBtn")
			if self.closeBtn_ScaleButton_onClick then
				self:closeBtn_ScaleButton_onClick(self.closeBtn)
			end
		end)


end

---@private
function EquipDelFastPanel:InitGenerate__4(Root, data)
--[[
	PanelBg/Art/TeamList
--]]
	local tmp = Root:Find("PanelBg/Art/TeamList").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.teamList = tmp


end

---@private
function EquipDelFastPanel:InitGenerate__5(Root, data)
--[[
	PanelBg/Scroll View/Viewport/ModeAllList
--]]
	local tmp = Root:Find("PanelBg/Scroll View/Viewport/ModeAllList").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.modeAllList = tmp


end

---@private
function EquipDelFastPanel:InitGenerate__6(Root, data)
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
		UIMgr:SendUiUseMessage("EquipDelFastPanel_okBtn")
			if self.okBtn_ScaleButton_onClick then
				self:okBtn_ScaleButton_onClick(self.okBtn)
			end
		end)


end

---@private
function EquipDelFastPanel:InitGenerate__7(Root, data)
--[[
	PanelBg/AllClearBtn
--]]
	local tmp = Root:Find("PanelBg/AllClearBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.allClearBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("EquipDelFastPanel_allClearBtn")
			if self.allClearBtn_ScaleButton_onClick then
				self:allClearBtn_ScaleButton_onClick(self.allClearBtn)
			end
		end)


end

---@private
function EquipDelFastPanel:InitGenerate__8(Root, data)
--[[
	ModeBtn
--]]
	local tmp = Root:Find("ModeBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.modeBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("EquipDelFastPanel_modeBtn")
			if self.modeBtn_ScaleButton_onClick then
				self:modeBtn_ScaleButton_onClick(self.modeBtn)
			end
		end)


end

---@private
function EquipDelFastPanel:InitGenerate__9(Root, data)
--[[
	ModeBtn/ModeNameTxt
--]]
	local tmp = Root:Find("ModeBtn/ModeNameTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.modeBtn.modeNameTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function EquipDelFastPanel:InitGenerate__10(Root, data)
--[[
	ModeBtn/IsSelect
--]]
	local tmp = Root:Find("ModeBtn/IsSelect").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.modeBtn.isSelect = tmp


end

---@private
function EquipDelFastPanel:InitGenerate__11(Root, data)
--[[
	ModeBtn/IsSelect/SelectNameTxt
--]]
	local tmp = Root:Find("ModeBtn/IsSelect/SelectNameTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.modeBtn.selectNameTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function EquipDelFastPanel:InitGenerate__12(Root, data)
--[[
	ModeBox
--]]
	local tmp = Root:Find("ModeBox").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.modeBox = tmp


end

---@private
function EquipDelFastPanel:InitGenerate__13(Root, data)
--[[
	ModeBox/ModeTitle/SelectModeTxt
--]]
	local tmp = Root:Find("ModeBox/ModeTitle/SelectModeTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.modeBox.selectModeTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.Text)


end

---@private
function EquipDelFastPanel:InitGenerate__14(Root, data)
--[[
	ModeBox/ModeList
--]]
	local tmp = Root:Find("ModeBox/ModeList").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.modeBox.modeList = tmp


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function EquipDelFastPanel:SetLocalizedText(Root)

    local locObj_EquipDelFastPanel_TitleText = Root:Find("PanelBg/Art/TitleBg/TitleText")
    if locObj_EquipDelFastPanel_TitleText then
        locObj_EquipDelFastPanel_TitleText.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.EquipDelFastPanel_TitleText
    end

    local locObj_EquipDelFastPanel_TextTMP = Root:Find("PanelBg/OkBtn/Text (TMP)")
    if locObj_EquipDelFastPanel_TextTMP then
        locObj_EquipDelFastPanel_TextTMP.gameObject:GetComponent(TypeInfo.Text).text = UILanguageEnum.EquipDelFastPanel_TextTMP
    end

    local locObj_EquipDelFastPanel_An_TextTMP = Root:Find("PanelBg/AllClearBtn/Text (TMP)")
    if locObj_EquipDelFastPanel_An_TextTMP then
        locObj_EquipDelFastPanel_An_TextTMP.gameObject:GetComponent(TypeInfo.Text).text = UILanguageEnum.EquipDelFastPanel_An_TextTMP
    end

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return EquipDelFastPanel