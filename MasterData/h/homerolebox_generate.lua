---@class HomeRoleBox_Generate_lockState
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform

---@class HomeRoleBox_Generate_emptySeat
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform

---@class HomeRoleBox_Generate_titleName
---@field public gameObject UnityEngine.GameObject
---@field public text UnityEngine.UI.Text

---@class HomeRoleBox_Generate_titleBg
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform

---@class HomeRoleBox_Generate_roleName
---@field public gameObject UnityEngine.GameObject
---@field public text UnityEngine.UI.Text

---@class HomeRoleBox_Generate_nameBg
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform

---@class HomeRoleBox_Generate_headIcon
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class HomeRoleBox_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public scaleButton ScaleButton
---@field public bg UnityEngine.GameObject
---@field public headIcon HomeRoleBox_Generate_headIcon
---@field public nameBg HomeRoleBox_Generate_nameBg
---@field public roleName HomeRoleBox_Generate_roleName
---@field public titleBg HomeRoleBox_Generate_titleBg
---@field public titleName HomeRoleBox_Generate_titleName
---@field public emptySeat HomeRoleBox_Generate_emptySeat
---@field public lockState HomeRoleBox_Generate_lockState
---@field public sel UnityEngine.GameObject
---@field public redPoint UnityEngine.GameObject
local HomeRoleBox = class("HomeRoleBox", require("CommonBase"))

function HomeRoleBox:ctor(data)
end

---@private
function HomeRoleBox:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("HomeRoleBox")

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
function HomeRoleBox:InitGenerate__1(Root, data)
--[[
	Root
--]]

	self.scaleButton = Root:GetComponent(TypeInfo.ScaleButton)
	self.scaleButton.onClick:RemoveAllListeners()
	self.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("HomeRoleBox_scaleButton")
			if self.scaleButton_ScaleButton_onClick then
				self:scaleButton_ScaleButton_onClick(self)
			end
		end)


end

---@private
function HomeRoleBox:InitGenerate__2(Root, data)
--[[
	Bg
--]]
	local tmp = Root:Find("Bg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.bg = tmp


end

---@private
function HomeRoleBox:InitGenerate__3(Root, data)
--[[
	Bg/Mask/HeadIcon
--]]
	local tmp = Root:Find("Bg/Mask/HeadIcon").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.headIcon = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function HomeRoleBox:InitGenerate__4(Root, data)
--[[
	Bg/NameBg
--]]
	local tmp = Root:Find("Bg/NameBg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.nameBg = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)


end

---@private
function HomeRoleBox:InitGenerate__5(Root, data)
--[[
	Bg/NameBg/RoleName
--]]
	local tmp = Root:Find("Bg/NameBg/RoleName").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.roleName = tmp

	tmp.text = tmp:GetComponent(TypeInfo.Text)


end

---@private
function HomeRoleBox:InitGenerate__6(Root, data)
--[[
	Bg/TitleBg
--]]
	local tmp = Root:Find("Bg/TitleBg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.titleBg = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)


end

---@private
function HomeRoleBox:InitGenerate__7(Root, data)
--[[
	Bg/TitleBg/TitleName
--]]
	local tmp = Root:Find("Bg/TitleBg/TitleName").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.titleName = tmp

	tmp.text = tmp:GetComponent(TypeInfo.Text)


end

---@private
function HomeRoleBox:InitGenerate__8(Root, data)
--[[
	EmptySeat
--]]
	local tmp = Root:Find("EmptySeat").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.emptySeat = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)


end

---@private
function HomeRoleBox:InitGenerate__9(Root, data)
--[[
	LockState
--]]
	local tmp = Root:Find("LockState").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.lockState = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)


end

---@private
function HomeRoleBox:InitGenerate__10(Root, data)
--[[
	Sel
--]]
	local tmp = Root:Find("Sel").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.sel = tmp


end

---@private
function HomeRoleBox:InitGenerate__11(Root, data)
--[[
	RedPoint
--]]
	local tmp = Root:Find("RedPoint").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.redPoint = tmp


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function HomeRoleBox:SetLocalizedText(Root)

    local locObj_HomeRoleBox_Text = Root:Find("LockState/Text")
    if locObj_HomeRoleBox_Text then
        locObj_HomeRoleBox_Text.gameObject:GetComponent(TypeInfo.Text).text = UILanguageEnum.HomeRoleBox_Text
    end

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return HomeRoleBox