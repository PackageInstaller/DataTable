---@class AdapterPanel_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public portraitMask UnityEngine.GameObject
---@field public upMaskImg UnityEngine.GameObject
---@field public downMaskImg UnityEngine.GameObject
---@field public landscapeMask UnityEngine.GameObject
---@field public leftMaskImg UnityEngine.GameObject
---@field public rightMaskImg UnityEngine.GameObject
local AdapterPanel = class("AdapterPanel", require("WndBase"))

function AdapterPanel:ctor(data)
end

---@private
function AdapterPanel:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("AdapterPanel")

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
function AdapterPanel:InitGenerate__1(Root, data)
--[[
	PortraitMask
--]]
	local tmp = Root:Find("PortraitMask").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.portraitMask = tmp


end

---@private
function AdapterPanel:InitGenerate__2(Root, data)
--[[
	PortraitMask/UpMaskImg
--]]
	local tmp = Root:Find("PortraitMask/UpMaskImg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.upMaskImg = tmp


end

---@private
function AdapterPanel:InitGenerate__3(Root, data)
--[[
	PortraitMask/DownMaskImg
--]]
	local tmp = Root:Find("PortraitMask/DownMaskImg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.downMaskImg = tmp


end

---@private
function AdapterPanel:InitGenerate__4(Root, data)
--[[
	LandscapeMask
--]]
	local tmp = Root:Find("LandscapeMask").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.landscapeMask = tmp


end

---@private
function AdapterPanel:InitGenerate__5(Root, data)
--[[
	LandscapeMask/LeftMaskImg
--]]
	local tmp = Root:Find("LandscapeMask/LeftMaskImg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.leftMaskImg = tmp


end

---@private
function AdapterPanel:InitGenerate__6(Root, data)
--[[
	LandscapeMask/RightMaskImg
--]]
	local tmp = Root:Find("LandscapeMask/RightMaskImg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.rightMaskImg = tmp


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function AdapterPanel:SetLocalizedText(Root)

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return AdapterPanel