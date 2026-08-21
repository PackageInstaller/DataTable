---@class FormationMovePanel_Generate_roleBox_indexText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class FormationMovePanel_Generate_roleBox_roleHeadBox
---@field public gameObject UnityEngine.GameObject
---@field public roleHeadBox RoleHeadBox

---@class FormationMovePanel_Generate_roleBox
---@field public gameObject UnityEngine.GameObject
---@field public dragListener DragListener
---@field public scaleButton ScaleButton
---@field public roleInfo UnityEngine.GameObject
---@field public emptyImg UnityEngine.GameObject
---@field public roleHeadBox FormationMovePanel_Generate_roleBox_roleHeadBox
---@field public indexText FormationMovePanel_Generate_roleBox_indexText
---@field public noLocationImg UnityEngine.GameObject

---@class FormationMovePanel_Generate_tempRoleRoot
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform

---@class FormationMovePanel_Generate_closeBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class FormationMovePanel_Generate_titleText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class FormationMovePanel_Generate_mask
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button

---@class FormationMovePanel_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public animator UnityEngine.Animator
---@field public animOverCallBack AnimOverCallBack
---@field public mask FormationMovePanel_Generate_mask
---@field public titleText FormationMovePanel_Generate_titleText
---@field public closeBtn FormationMovePanel_Generate_closeBtn
---@field public teamList UnityEngine.GameObject
---@field public tempRoleRoot FormationMovePanel_Generate_tempRoleRoot
---@field public roleBox FormationMovePanel_Generate_roleBox
local FormationMovePanel = class("FormationMovePanel", require("WndBase"))

function FormationMovePanel:ctor(data)
end

---@private
function FormationMovePanel:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("FormationMovePanel")

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

	self:SetLocalizedText(Root)


	self:InitLogic(data)

end

---@private
function FormationMovePanel:InitGenerate__1(Root, data)
--[[
	Root
--]]

	self.animator = Root:GetComponent(TypeInfo.Animator)

	self.animOverCallBack = Root:GetComponent(TypeInfo.AnimOverCallBack)


end

---@private
function FormationMovePanel:InitGenerate__2(Root, data)
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
		UIMgr:SendUiUseMessage("FormationMovePanel_mask")
			if self.mask_Button_onClick then
				self:mask_Button_onClick(self.mask)
			end
		end)


end

---@private
function FormationMovePanel:InitGenerate__3(Root, data)
--[[
	BoxBg/TitleSideBg/Titlebg/TitleText
--]]
	local tmp = Root:Find("BoxBg/TitleSideBg/Titlebg/TitleText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.titleText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function FormationMovePanel:InitGenerate__4(Root, data)
--[[
	BoxBg/TitleSideBg/CloseBtn
--]]
	local tmp = Root:Find("BoxBg/TitleSideBg/CloseBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.closeBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("FormationMovePanel_closeBtn")
			if self.closeBtn_ScaleButton_onClick then
				self:closeBtn_ScaleButton_onClick(self.closeBtn)
			end
		end)


end

---@private
function FormationMovePanel:InitGenerate__5(Root, data)
--[[
	BoxBg/TeamList
--]]
	local tmp = Root:Find("BoxBg/TeamList").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.teamList = tmp


end

---@private
function FormationMovePanel:InitGenerate__6(Root, data)
--[[
	TempRoleRoot
--]]
	local tmp = Root:Find("TempRoleRoot").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.tempRoleRoot = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)


end

---@private
function FormationMovePanel:InitGenerate__7(Root, data)
--[[
	RoleBox
--]]
	local tmp = Root:Find("RoleBox").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.roleBox = tmp

	tmp.dragListener = tmp:GetComponent(TypeInfo.DragListener)

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("FormationMovePanel_roleBox")
			if self.roleBox_ScaleButton_onClick then
				self:roleBox_ScaleButton_onClick(self.roleBox)
			end
		end)


end

---@private
function FormationMovePanel:InitGenerate__8(Root, data)
--[[
	RoleBox/RoleInfo
--]]
	local tmp = Root:Find("RoleBox/RoleInfo").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.roleBox.roleInfo = tmp


end

---@private
function FormationMovePanel:InitGenerate__9(Root, data)
--[[
	RoleBox/RoleInfo/EmptyImg
--]]
	local tmp = Root:Find("RoleBox/RoleInfo/EmptyImg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.roleBox.emptyImg = tmp


end

---@private
function FormationMovePanel:InitGenerate__10(Root, data)
--[[
	RoleBox/RoleInfo/RoleHeadBox
--]]
	local tmp = Root:Find("RoleBox/RoleInfo/RoleHeadBox").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.roleBox.roleHeadBox = tmp

	tmp.roleHeadBox = tmp:AddComponentLua("RoleHeadBox", data)


end

---@private
function FormationMovePanel:InitGenerate__11(Root, data)
--[[
	RoleBox/RoleInfo/IndexBg/IndexText
--]]
	local tmp = Root:Find("RoleBox/RoleInfo/IndexBg/IndexText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.roleBox.indexText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function FormationMovePanel:InitGenerate__12(Root, data)
--[[
	RoleBox/NoLocationImg
--]]
	local tmp = Root:Find("RoleBox/NoLocationImg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.roleBox.noLocationImg = tmp


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function FormationMovePanel:SetLocalizedText(Root)

    local locObj_FormationMovePanel_TitleText2 = Root:Find("BoxBg/TitleSideBg/Titlebg/TitleText2")
    if locObj_FormationMovePanel_TitleText2 then
        locObj_FormationMovePanel_TitleText2.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.FormationMovePanel_TitleText2
    end

    local locObj_FormationMovePanel_IndexText = Root:Find("RoleBox/NoLocationImg/IndexText")
    if locObj_FormationMovePanel_IndexText then
        locObj_FormationMovePanel_IndexText.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.FormationMovePanel_IndexText
    end

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return FormationMovePanel