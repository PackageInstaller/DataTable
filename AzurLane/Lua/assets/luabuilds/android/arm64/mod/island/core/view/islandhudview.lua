local var_0_0 = class("IslandHudView")

var_0_0.LuaName2ContainerName = {
	IslandVisitorHudPanel = "visitorContainer",
	IslandNormalHudPanel = "npcInfoContainer",
	IslandCustomerHudPanel = "npcInfoContainer"
}

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.view = arg_1_1
	arg_1_0.hudPanelDic = {}

	return
end

function var_0_0.ShowHud(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1.id == nil or arg_2_1.type == nil then
		return
	end

	if arg_2_0.hudPanelDic[arg_2_1.type] then
		local var_2_0 = arg_2_0.hudPanelDic[arg_2_1.type][arg_2_1.id] or nil

		if var_2_0 then
			var_2_0:Show()
		else
			arg_2_0:CreateNewHud(arg_2_1, arg_2_2)
		end

		return
	end
end

function var_0_0.RefreshHud(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1.id == nil or arg_3_1.type == nil then
		return
	end

	if arg_3_0.hudPanelDic[arg_3_1.type] then
		local var_3_0 = arg_3_0.hudPanelDic[arg_3_1.type][arg_3_1.id] or nil

		if var_3_0 then
			var_3_0:Refresh(arg_3_1)
		else
			arg_3_0:CreateNewHud(arg_3_1, arg_3_2)
		end

		return
	end
end

function var_0_0.HideHud(arg_4_0, arg_4_1)
	if arg_4_1.id == nil or arg_4_1.type == nil then
		return
	end

	if arg_4_0.hudPanelDic[arg_4_1.type] then
		local var_4_0 = arg_4_0.hudPanelDic[arg_4_1.type][arg_4_1.id] or nil

		if var_4_0 then
			var_4_0:Hide()
		end

		return
	end
end

function var_0_0.CreateNewHud(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0:GenUnitData(arg_5_1.id, arg_5_1.type)
	local var_5_1 = _G[arg_5_1.uiLuaName].New(arg_5_0.view, arg_5_1, arg_5_2)

	var_5_1:Init()

	arg_5_0.hudPanelDic[arg_5_1.type] = arg_5_0.hudPanelDic[arg_5_1.type] or {}
	arg_5_0.hudPanelDic[arg_5_1.type][arg_5_1.id] = var_5_1

	return
end

function var_0_0.Update(arg_6_0)
	for iter_6_0, iter_6_1 in pairs(arg_6_0.hudPanelDic) do
		for iter_6_2, iter_6_3 in pairs(iter_6_1) do
			iter_6_3:Update()
		end
	end

	return
end

function var_0_0.LateUpdate(arg_7_0)
	for iter_7_0, iter_7_1 in pairs(arg_7_0.hudPanelDic) do
		for iter_7_2, iter_7_3 in pairs(iter_7_1) do
			iter_7_3:LateUpdate()
		end
	end

	return
end

function var_0_0.Dispose(arg_8_0)
	for iter_8_0, iter_8_1 in pairs(arg_8_0.hudPanelDic) do
		for iter_8_2, iter_8_3 in pairs(iter_8_1) do
			iter_8_3:Dispose()
		end
	end

	if not IsNil(arg_8_0._go) then
		Object.Destroy(arg_8_0._go)
	end

	arg_8_0._go = nil
	arg_8_0._tf = nil

	return
end

function var_0_0.GenUnitData(arg_9_0, arg_9_1, arg_9_2)
	return {
		id = arg_9_1,
		type = arg_9_2,
		key = arg_9_2 .. "_" .. arg_9_1
	}
end

function var_0_0.UpdateAllHud(arg_10_0)
	for iter_10_0, iter_10_1 in pairs(arg_10_0.hudPanelDic) do
		for iter_10_2, iter_10_3 in pairs(iter_10_1) do
			iter_10_3:RefreshHud()
		end
	end

	return
end

return var_0_0
