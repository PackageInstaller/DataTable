class = var_0_10000

local var_0_0 = "IslandMainTechnologyBtn"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".IslandMainBaseBtn"))

var_0_1.STATUS = {
	NORMAL = 3,
	STUDYING = 1,
	UNLOCK = 2
}
var_0_1.STATUS2ICON = {
	[var_0_1.STATUS.STUDYING] = "technology_studying",
	[var_0_1.STATUS.UNLOCK] = "technology_unlock",
	[var_0_1.STATUS.NORMAL] = "technology"
}

function var_0_1.Init(arg_1_0)
	local var_1_0 = arg_1_0._tf

	var_1_0.name = arg_1_0.config.btn_name
	onButton = var_1_0

	local var_1_1 = arg_1_0
	local var_1_2 = arg_1_0._tf

	local function var_1_3()
		local var_2_0 = arg_1_0

		var_0.OnClick(var_2_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_0(var_1_1, var_1_2, var_1_3, var_1_10006)

	return
end

function var_0_1.Flush(arg_3_0)
	var_0_1.super.Flush(arg_3_0)
	arg_3_0:StatusCheck()

	return
end

function var_0_1.StatusCheck(arg_4_0)
	local var_4_0 = arg_4_0:GetStatus()

	if not arg_4_0.status or arg_4_0.status ~= var_4_0 then
		arg_4_0.status = var_4_0
		LoadImageSpriteAtlasAsync = var_2

		var_2("island/islandbtnicon", var_0_1.STATUS2ICON[arg_4_0.status], arg_4_0.iconTF, true)
	end

	return
end

function var_0_1.GetStatus(arg_5_0)
	getProxy = var_1_10001
	IslandProxy = var_1_10003

	local var_5_0 = var_1_10001(var_1_10003)
	local var_5_1 = var_1.GetIsland(var_5_0)
	local var_5_2 = var_1.GetTechnologyAgency(var_5_1)
	local var_5_3 = var_1:GetBuildingAgency()
	local var_5_4 = var_3.GetBuilding

	IslandTechnologyAgency = var_1_10006

	local var_5_5 = var_5_4(var_5_3, var_1_10006.PLACE_ID)

	IslandTechnologyAgency = var_5_1

	local var_5_6 = var_5_1.GetSlotIds()

	ipairs = var_5_3

	for iter_5_0, iter_5_1 in var_5_3(var_5_6) do
		if var_5_5:GetDelegationSlotData(iter_5_1) and var_10:GetSlotRoleData() then
			return var_0_1.STATUS.STUDYING
		end
	end

	pairs = var_5

	for iter_5_2, iter_5_3 in var_5(var_5_2:GetTechnologys()) do
		if iter_5_3:IsUnlock() and iter_5_3:GetFinishedCnt() <= 0 then
			return var_0_1.STATUS.UNLOCK
		end
	end

	return var_0_1.STATUS.NORMAL
end

return var_0_1
