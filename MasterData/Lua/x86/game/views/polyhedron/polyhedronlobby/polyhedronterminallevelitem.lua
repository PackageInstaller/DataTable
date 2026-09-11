local PolyhedronTerminalLevelItem = class("PolyhedronTerminalLevelItem", ReduxView)

function PolyhedronTerminalLevelItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function PolyhedronTerminalLevelItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function PolyhedronTerminalLevelItem:InitUI()
	self:BindCfgUI()

	self.stateController = ControllerUtil.GetController(self.transform_, "state")
end

function PolyhedronTerminalLevelItem:AddUIListener()
	return
end

function PolyhedronTerminalLevelItem:SetData(arg_5_1)
	local var_5_0 = PolyhedronTerminalLevelCfg[arg_5_1]

	if arg_5_1 <= PolyhedronData:GetTerminalLevel() then
		self.stateController:SetSelectedIndex(1)
	else
		self.stateController:SetSelectedIndex(0)
	end

	self.m_levelLab.text = arg_5_1
	self.m_des.text = GetI18NText(var_5_0.des)

	local var_5_1

	if var_5_0.point - ((PolyhedronTerminalLevelCfg[arg_5_1 - 1] or nil) and (PolyhedronTerminalLevelCfg[arg_5_1 - 1].point or 0)) ~= 0 then
		var_5_1 = string.format(GetTips("POLYHEDRON_TERMINAL_LEVEL_POINT"), var_5_0.point - ((PolyhedronTerminalLevelCfg[arg_5_1 - 1] or nil) and (PolyhedronTerminalLevelCfg[arg_5_1 - 1].point or 0)))
	end

	if var_5_0.des and var_5_0.des ~= "" then
		if var_5_1 ~= nil then
			var_5_1 = var_5_1 .. " ;"
		end

		var_5_1 = GetI18NText(var_5_1) .. GetI18NText(var_5_0.des)
	end

	self.m_des.text = GetI18NText(var_5_1)
end

function PolyhedronTerminalLevelItem:Dispose()
	PolyhedronTerminalLevelItem.super.Dispose(self)
end

return PolyhedronTerminalLevelItem
