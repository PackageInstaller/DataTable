---@class FormationListPanel_Generate_formationListBox_teamName
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class FormationListPanel_Generate_formationListBox
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button
---@field public isSelect UnityEngine.GameObject
---@field public bgImg UnityEngine.GameObject
---@field public dataList UnityEngine.GameObject
---@field public teamName FormationListPanel_Generate_formationListBox_teamName

---@class FormationListPanel_Generate_roleBox_roleHeadBox
---@field public gameObject UnityEngine.GameObject
---@field public roleHeadBox RoleHeadBox

---@class FormationListPanel_Generate_roleBox
---@field public gameObject UnityEngine.GameObject
---@field public emptyImg UnityEngine.GameObject
---@field public roleHeadBox FormationListPanel_Generate_roleBox_roleHeadBox

---@class FormationListPanel_Generate_saveBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class FormationListPanel_Generate_loadBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class FormationListPanel_Generate_nowFormation_teamName
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class FormationListPanel_Generate_nowFormation
---@field public gameObject UnityEngine.GameObject
---@field public isSelect UnityEngine.GameObject
---@field public dataList UnityEngine.GameObject
---@field public teamName FormationListPanel_Generate_nowFormation_teamName

---@class FormationListPanel_Generate_closeBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class FormationListPanel_Generate_titleText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class FormationListPanel_Generate_mask
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button

---@class FormationListPanel_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public animator UnityEngine.Animator
---@field public animOverCallBack AnimOverCallBack
---@field public mask FormationListPanel_Generate_mask
---@field public titleText FormationListPanel_Generate_titleText
---@field public closeBtn FormationListPanel_Generate_closeBtn
---@field public nowFormation FormationListPanel_Generate_nowFormation
---@field public content UnityEngine.GameObject
---@field public loadBtn FormationListPanel_Generate_loadBtn
---@field public saveBtn FormationListPanel_Generate_saveBtn
---@field public roleBox FormationListPanel_Generate_roleBox
---@field public formationListBox FormationListPanel_Generate_formationListBox
local FormationListPanel = class("FormationListPanel", require("WndBase"))

function FormationListPanel:ctor(data)
end

---@private
function FormationListPanel:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("FormationListPanel")

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

	self:SetLocalizedText(Root)


	self:InitLogic(data)

end

---@private
function FormationListPanel:InitGenerate__1(Root, data)
--[[
	Root
--]]

	self.animator = Root:GetComponent(TypeInfo.Animator)

	self.animOverCallBack = Root:GetComponent(TypeInfo.AnimOverCallBack)


end

---@private
function FormationListPanel:InitGenerate__2(Root, data)
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
		UIMgr:SendUiUseMessage("FormationListPanel_mask")
			if self.mask_Button_onClick then
				self:mask_Button_onClick(self.mask)
			end
		end)


end

---@private
function FormationListPanel:InitGenerate__3(Root, data)
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
function FormationListPanel:InitGenerate__4(Root, data)
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
		UIMgr:SendUiUseMessage("FormationListPanel_closeBtn")
			if self.closeBtn_ScaleButton_onClick then
				self:closeBtn_ScaleButton_onClick(self.closeBtn)
			end
		end)


end

---@private
function FormationListPanel:InitGenerate__5(Root, data)
--[[
	BoxBg/NowFormation
--]]
	local tmp = Root:Find("BoxBg/NowFormation").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.nowFormation = tmp


end

---@private
function FormationListPanel:InitGenerate__6(Root, data)
--[[
	BoxBg/NowFormation/IsSelect
--]]
	local tmp = Root:Find("BoxBg/NowFormation/IsSelect").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.nowFormation.isSelect = tmp


end

---@private
function FormationListPanel:InitGenerate__7(Root, data)
--[[
	BoxBg/NowFormation/DataList
--]]
	local tmp = Root:Find("BoxBg/NowFormation/DataList").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.nowFormation.dataList = tmp


end

---@private
function FormationListPanel:InitGenerate__8(Root, data)
--[[
	BoxBg/NowFormation/TeamName
--]]
	local tmp = Root:Find("BoxBg/NowFormation/TeamName").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.nowFormation.teamName = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function FormationListPanel:InitGenerate__9(Root, data)
--[[
	BoxBg/Scroll View/Viewport/Content
--]]
	local tmp = Root:Find("BoxBg/Scroll View/Viewport/Content").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.content = tmp


end

---@private
function FormationListPanel:InitGenerate__10(Root, data)
--[[
	BoxBg/LoadBtn
--]]
	local tmp = Root:Find("BoxBg/LoadBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.loadBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("FormationListPanel_loadBtn")
			if self.loadBtn_ScaleButton_onClick then
				self:loadBtn_ScaleButton_onClick(self.loadBtn)
			end
		end)


end

---@private
function FormationListPanel:InitGenerate__11(Root, data)
--[[
	BoxBg/SaveBtn
--]]
	local tmp = Root:Find("BoxBg/SaveBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.saveBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("FormationListPanel_saveBtn")
			if self.saveBtn_ScaleButton_onClick then
				self:saveBtn_ScaleButton_onClick(self.saveBtn)
			end
		end)


end

---@private
function FormationListPanel:InitGenerate__12(Root, data)
--[[
	RoleBox
--]]
	local tmp = Root:Find("RoleBox").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.roleBox = tmp


end

---@private
function FormationListPanel:InitGenerate__13(Root, data)
--[[
	RoleBox/EmptyImg
--]]
	local tmp = Root:Find("RoleBox/EmptyImg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.roleBox.emptyImg = tmp


end

---@private
function FormationListPanel:InitGenerate__14(Root, data)
--[[
	RoleBox/RoleHeadBox
--]]
	local tmp = Root:Find("RoleBox/RoleHeadBox").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.roleBox.roleHeadBox = tmp

	tmp.roleHeadBox = tmp:AddComponentLua("RoleHeadBox", data)


end

---@private
function FormationListPanel:InitGenerate__15(Root, data)
--[[
	FormationListBox
--]]
	local tmp = Root:Find("FormationListBox").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.formationListBox = tmp

	tmp.button = tmp:GetComponent(TypeInfo.Button)


end

---@private
function FormationListPanel:InitGenerate__16(Root, data)
--[[
	FormationListBox/IsSelect
--]]
	local tmp = Root:Find("FormationListBox/IsSelect").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.formationListBox.isSelect = tmp


end

---@private
function FormationListPanel:InitGenerate__17(Root, data)
--[[
	FormationListBox/BgImg
--]]
	local tmp = Root:Find("FormationListBox/BgImg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.formationListBox.bgImg = tmp


end

---@private
function FormationListPanel:InitGenerate__18(Root, data)
--[[
	FormationListBox/DataList
--]]
	local tmp = Root:Find("FormationListBox/DataList").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.formationListBox.dataList = tmp


end

---@private
function FormationListPanel:InitGenerate__19(Root, data)
--[[
	FormationListBox/TeamName
--]]
	local tmp = Root:Find("FormationListBox/TeamName").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.formationListBox.teamName = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function FormationListPanel:SetLocalizedText(Root)

    local locObj_FormationListPanel_TitleText2 = Root:Find("BoxBg/TitleSideBg/Titlebg/TitleText2")
    if locObj_FormationListPanel_TitleText2 then
        locObj_FormationListPanel_TitleText2.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.FormationListPanel_TitleText2
    end

    local locObj_FormationListPanel_txt = Root:Find("BoxBg/LoadBtn/txt")
    if locObj_FormationListPanel_txt then
        locObj_FormationListPanel_txt.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.FormationListPanel_txt
    end

    local locObj_FormationListPanel_Sn_txt = Root:Find("BoxBg/SaveBtn/txt")
    if locObj_FormationListPanel_Sn_txt then
        locObj_FormationListPanel_Sn_txt.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.FormationListPanel_Sn_txt
    end

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return FormationListPanel