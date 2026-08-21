---@class AuditingPanel_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public healthText UnityEngine.GameObject
local AuditingPanel = class("AuditingPanel", require("WndBase"))

function AuditingPanel:ctor(data)
end

---@private
function AuditingPanel:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("AuditingPanel")

	local Root = self.transform 
	local tmp

	self:InitGenerate__1(Root,data)

	self:InitLogic(data)

end

---@private
function AuditingPanel:InitGenerate__1(Root, data)
--[[
	healthText
--]]
	local tmp = Root:Find("healthText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.healthText = tmp


end

return AuditingPanel