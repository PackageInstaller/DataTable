local NcShowHud = class("NcShowHud", import("..base.NodeCanvasBaseTask"))

function NcShowHud:OnExecute()
	local var_1_0 = self:GetAgent().gameObject:GetComponent(typeof(WorldObjectItem))
	local var_1_1 = self:GetStringArg("viewLuaName")

	if self:GetBoolArg("show") then
		self:SendEvent(ISLAND_EVT.SHOW_HUD, {
			id = tonumber(var_1_0.id),
			type = tonumber(var_1_0.type),
			unitTransform = self:GetAgent().transform,
			viewLuaName = var_1_1,
			uiLuaName = self:GetStringArg("uiLuaName"),
			positionX = tonumber((self:GetStringArg("positionX"))),
			positionY = tonumber((self:GetStringArg("positionY"))),
			param1 = self:GetStringArg("param1"),
			param2 = self:GetStringArg("param2"),
			param3 = self:GetStringArg("param3")
		})
	else
		self:SendEvent(ISLAND_EVT.HIDE_HUD, {
			id = tonumber(var_1_0.id),
			type = tonumber(var_1_0.type),
			viewLuaName = var_1_1
		})
	end

	self:EndAction()

	return
end

return NcShowHud
