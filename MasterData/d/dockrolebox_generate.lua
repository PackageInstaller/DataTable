---@class DockRoleBox__Generate_isSelect
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class DockRoleBox__Generate_typeIcon
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class DockRoleBox__Generate_starImg
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class DockRoleBox__Generate_nameTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class DockRoleBox__Generate_levelTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class DockRoleBox__Generate_rangeFarme
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class DockRoleBox__Generate_roleImg
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class DockRoleBox__Generate_rangeBg
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class DockRoleBox__Generate_btn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton
---@field public canvasGroup UnityEngine.CanvasGroup

---@class DockRoleBox__Generate
---@field private gameObject UnityEngine.GameObject
---@field private transform UnityEngine.Transform
---@field private uiConfig table
---@field private btn DockRoleBox__Generate_btn
---@field private rangeBg DockRoleBox__Generate_rangeBg
---@field private roleImg DockRoleBox__Generate_roleImg
---@field private rangeFarme DockRoleBox__Generate_rangeFarme
---@field private levelTxt DockRoleBox__Generate_levelTxt
---@field private nameTxt DockRoleBox__Generate_nameTxt
---@field private starImg DockRoleBox__Generate_starImg
---@field private typeIcon DockRoleBox__Generate_typeIcon
---@field private isSelect DockRoleBox__Generate_isSelect
local DockRoleBox = class("DockRoleBox", require("WndBase"))

function DockRoleBox:ctor(data)
end

---@private
function DockRoleBox:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("DockRoleBox")

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

	self:InitLogic(data)

end

---@private
function DockRoleBox:InitGenerate__1(Root, data)
--[[
	Root
--]]


end

---@private
function DockRoleBox:InitGenerate__2(Root, data)
--[[
	Btn
--]]
	local tmp = Root:Find("Btn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.btn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)

	tmp.canvasGroup = tmp:GetComponent(TypeInfo.CanvasGroup)


end

---@private
function DockRoleBox:InitGenerate__3(Root, data)
--[[
	Btn/RangeBg
--]]
	local tmp = Root:Find("Btn/RangeBg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.rangeBg = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function DockRoleBox:InitGenerate__4(Root, data)
--[[
	Btn/RoleMask/RoleImg
--]]
	local tmp = Root:Find("Btn/RoleMask/RoleImg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.roleImg = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function DockRoleBox:InitGenerate__5(Root, data)
--[[
	Btn/RangeFarme
--]]
	local tmp = Root:Find("Btn/RangeFarme").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.rangeFarme = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function DockRoleBox:InitGenerate__6(Root, data)
--[[
	Btn/GroundBg/LevelTxt
--]]
	local tmp = Root:Find("Btn/GroundBg/LevelTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.levelTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function DockRoleBox:InitGenerate__7(Root, data)
--[[
	Btn/NameTxt
--]]
	local tmp = Root:Find("Btn/NameTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.nameTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function DockRoleBox:InitGenerate__8(Root, data)
--[[
	Btn/StarImg
--]]
	local tmp = Root:Find("Btn/StarImg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.starImg = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function DockRoleBox:InitGenerate__9(Root, data)
--[[
	Btn/typeBg/typeIcon
--]]
	local tmp = Root:Find("Btn/typeBg/typeIcon").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.typeIcon = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function DockRoleBox:InitGenerate__10(Root, data)
--[[
	Btn/IsSelect
--]]
	local tmp = Root:Find("Btn/IsSelect").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.isSelect = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

return DockRoleBox