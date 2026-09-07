local IslandHudView = class("IslandHudView")

IslandHudView.LuaName2ContainerName = {
	IslandVisitorHudPanel = "visitorContainer",
	IslandNormalHudPanel = "npcInfoContainer",
	IslandCustomerHudPanel = "npcInfoContainer"
}

function IslandHudView:Ctor(arg_1_1)
	self.view = arg_1_1
	self.hudPanelDic = {}

	return
end

function IslandHudView:ShowHud(arg_2_1, arg_2_2)
	if arg_2_1.id == nil or arg_2_1.type == nil then
		return
	end

	if self.hudPanelDic[arg_2_1.type] then
		local var_2_0 = self.hudPanelDic[arg_2_1.type][arg_2_1.id] or nil

		if var_2_0 then
			var_2_0:Show()

			goto label_2_0
		end
	end

	self:CreateNewHud(arg_2_1, arg_2_2)

	::label_2_0::

	return
end

function IslandHudView:RefreshHud(arg_3_1, arg_3_2)
	if arg_3_1.id == nil or arg_3_1.type == nil then
		return
	end

	if self.hudPanelDic[arg_3_1.type] then
		local var_3_0 = self.hudPanelDic[arg_3_1.type][arg_3_1.id] or nil

		if var_3_0 then
			var_3_0:Refresh(arg_3_1)

			goto label_3_0
		end
	end

	self:CreateNewHud(arg_3_1, arg_3_2)

	::label_3_0::

	return
end

function IslandHudView:HideHud(arg_4_1)
	if arg_4_1.id == nil or arg_4_1.type == nil then
		return
	end

	if self.hudPanelDic[arg_4_1.type] then
		local var_4_0 = self.hudPanelDic[arg_4_1.type][arg_4_1.id] or nil

		if var_4_0 then
			var_4_0:Hide()
		end
	end

	return
end

function IslandHudView:CreateNewHud(arg_5_1, arg_5_2)
	local var_5_0 = self:GenUnitData(arg_5_1.id, arg_5_1.type)
	local var_5_1 = _G[arg_5_1.uiLuaName].New(self.view, arg_5_1, arg_5_2)

	var_5_1:Init()

	self.hudPanelDic[arg_5_1.type] = self.hudPanelDic[arg_5_1.type] or {}
	self.hudPanelDic[arg_5_1.type][arg_5_1.id] = var_5_1

	return
end

function IslandHudView:Update()
	for iter_6_0, iter_6_1 in pairs(self.hudPanelDic) do
		for iter_6_2, iter_6_3 in pairs(iter_6_1) do
			iter_6_3:Update()
		end
	end

	return
end

function IslandHudView:LateUpdate()
	for iter_7_0, iter_7_1 in pairs(self.hudPanelDic) do
		for iter_7_2, iter_7_3 in pairs(iter_7_1) do
			iter_7_3:LateUpdate()
		end
	end

	return
end

function IslandHudView:Dispose()
	for iter_8_0, iter_8_1 in pairs(self.hudPanelDic) do
		for iter_8_2, iter_8_3 in pairs(iter_8_1) do
			iter_8_3:Dispose()
		end
	end

	if not IsNil(self._go) then
		Object.Destroy(self._go)
	end

	self._go = nil
	self._tf = nil

	return
end

function IslandHudView:GenUnitData(arg_9_1, arg_9_2)
	return {
		id = arg_9_1,
		type = arg_9_2,
		key = arg_9_2 .. "_" .. arg_9_1
	}
end

function IslandHudView:UpdateAllHud()
	for iter_10_0, iter_10_1 in pairs(self.hudPanelDic) do
		for iter_10_2, iter_10_3 in pairs(iter_10_1) do
			iter_10_3:RefreshHud()
		end
	end

	return
end

return IslandHudView
