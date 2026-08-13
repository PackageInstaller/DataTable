class = var_0_10000

local var_0_0 = var_0_10000("IslandHudView")

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

	local var_2_0

	if not arg_2_0.hudPanelDic[arg_2_1.type] or not arg_2_0.hudPanelDic[arg_2_1.type][arg_2_1.id] then
		var_2_0 = nil
	end

	if var_2_0 then
		var_2_0:Show()
	else
		arg_2_0:CreateNewHud(arg_2_1, arg_2_2)
	end

	return
end

function var_0_0.RefreshHud(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1.id == nil or arg_3_1.type == nil then
		return
	end

	local var_3_0

	if not arg_3_0.hudPanelDic[arg_3_1.type] or not arg_3_0.hudPanelDic[arg_3_1.type][arg_3_1.id] then
		var_3_0 = nil
	end

	if var_3_0 then
		var_3_0:Refresh(arg_3_1)
	else
		arg_3_0:CreateNewHud(arg_3_1, arg_3_2)
	end

	return
end

function var_0_0.HideHud(arg_4_0, arg_4_1)
	if arg_4_1.id == nil or arg_4_1.type == nil then
		return
	end

	local var_4_0

	if not arg_4_0.hudPanelDic[arg_4_1.type] or not arg_4_0.hudPanelDic[arg_4_1.type][arg_4_1.id] then
		var_4_0 = nil
	end

	if var_4_0 then
		var_4_0:Hide()
	end

	return
end

function var_0_0.CreateNewHud(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0:GenUnitData(arg_5_1.id, arg_5_1.type)

	_G = var_1_10004

	local var_5_1 = var_1_10004[arg_5_1.uiLuaName].New(arg_5_0.view, arg_5_1, arg_5_2)

	var_4.Init(var_5_1)

	if not arg_5_0.hudPanelDic[arg_5_1.type] then
		arg_5_0.hudPanelDic[arg_5_1.type] = {}
	end

	arg_5_0.hudPanelDic[arg_5_1.type][arg_5_1.id] = var_4

	return
end

function var_0_0.Update(arg_6_0)
	pairs = var_1_10001

	for iter_6_0, iter_6_1 in var_1_10001(arg_6_0.hudPanelDic) do
		pairs = var_1_10006

		for iter_6_2, iter_6_3 in var_1_10006(iter_6_1) do
			iter_6_3:Update()
		end
	end

	return
end

function var_0_0.LateUpdate(arg_7_0)
	pairs = var_1_10001

	for iter_7_0, iter_7_1 in var_1_10001(arg_7_0.hudPanelDic) do
		pairs = var_1_10006

		for iter_7_2, iter_7_3 in var_1_10006(iter_7_1) do
			iter_7_3:LateUpdate()
		end
	end

	return
end

function var_0_0.Dispose(arg_8_0)
	pairs = var_1_10001

	for iter_8_0, iter_8_1 in var_1_10001(arg_8_0.hudPanelDic) do
		pairs = var_1_10006

		for iter_8_2, iter_8_3 in var_1_10006(iter_8_1) do
			iter_8_3:Dispose()
		end
	end

	IsNil = var_1

	if not var_1(arg_8_0._go) then
		Object = var_1

		var_1.Destroy(arg_8_0._go)
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
	pairs = var_1_10001

	for iter_10_0, iter_10_1 in var_1_10001(arg_10_0.hudPanelDic) do
		pairs = var_1_10006

		for iter_10_2, iter_10_3 in var_1_10006(iter_10_1) do
			iter_10_3:RefreshHud()
		end
	end

	return
end

return var_0_0
