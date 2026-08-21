---@class HomeDisposeRoleBox_Generate_pos
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class HomeDisposeRoleBox_Generate_selImg
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform

---@class HomeDisposeRoleBox_Generate_addImg
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform

---@class HomeDisposeRoleBox_Generate_roleName
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class HomeDisposeRoleBox_Generate_role
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class HomeDisposeRoleBox_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public rectTransform UnityEngine.RectTransform
---@field public scaleButton ScaleButton
---@field public role HomeDisposeRoleBox_Generate_role
---@field public roleName HomeDisposeRoleBox_Generate_roleName
---@field public addImg HomeDisposeRoleBox_Generate_addImg
---@field public selImg HomeDisposeRoleBox_Generate_selImg
---@field public pos HomeDisposeRoleBox_Generate_pos
local HomeDisposeRoleBox = class("HomeDisposeRoleBox", require("CommonBase"))

function HomeDisposeRoleBox:ctor(data)
end

---@private
function HomeDisposeRoleBox:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("HomeDisposeRoleBox")

	local Root = self.transform 
	local tmp

	self:InitGenerate__1(Root,data)
	self:InitGenerate__2(Root,data)
	self:InitGenerate__3(Root,data)
	self:InitGenerate__4(Root,data)
	self:InitGenerate__5(Root,data)
	self:InitGenerate__6(Root,data)

	self:SetLocalizedText(Root)


	self:InitLogic(data)

end

---@private
function HomeDisposeRoleBox:InitGenerate__1(Root, data)
--[[
	Root
--]]

	self.rectTransform = Root:GetComponent(TypeInfo.RectTransform)

	self.scaleButton = Root:GetComponent(TypeInfo.ScaleButton)
	self.scaleButton.onClick:RemoveAllListeners()
	self.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("HomeDisposeRoleBox_scaleButton")
			if self.scaleButton_ScaleButton_onClick then
				self:scaleButton_ScaleButton_onClick(self)
			end
		end)


end

---@private
function HomeDisposeRoleBox:InitGenerate__2(Root, data)
--[[
	Role
--]]
	local tmp = Root:Find("Role").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.role = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function HomeDisposeRoleBox:InitGenerate__3(Root, data)
--[[
	Role/NameBg/RoleName
--]]
	local tmp = Root:Find("Role/NameBg/RoleName").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.roleName = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function HomeDisposeRoleBox:InitGenerate__4(Root, data)
--[[
	AddImg
--]]
	local tmp = Root:Find("AddImg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.addImg = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)


end

---@private
function HomeDisposeRoleBox:InitGenerate__5(Root, data)
--[[
	SelImg
--]]
	local tmp = Root:Find("SelImg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.selImg = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)


end

---@private
function HomeDisposeRoleBox:InitGenerate__6(Root, data)
--[[
	Pos
--]]
	local tmp = Root:Find("Pos").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.pos = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function HomeDisposeRoleBox:SetLocalizedText(Root)

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return HomeDisposeRoleBox