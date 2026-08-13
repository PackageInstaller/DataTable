class = var_0_10000

local var_0_0 = "VotePreRaceShipPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("....base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "PreRaceShips"
end

function var_0_1.OnInit(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.scrollRect = var_1.GetComponent(var_2_0, "LScrollRect")
	arg_2_0.voteItems = {}

	function arg_2_0.scrollRect.onInitItem(arg_3_0)
		local var_3_0 = arg_2_0

		var_1.onInitItem(var_3_0, arg_3_0)

		return
	end

	function arg_2_0.scrollRect.onUpdateItem(arg_4_0, arg_4_1)
		local var_4_0 = arg_2_0

		var_2.onUpdateItem(var_4_0, arg_4_0, arg_4_1)

		return
	end

	function arg_2_0.scrollRect.onReturnItem(arg_5_0, arg_5_1)
		local var_5_0 = arg_2_0

		var_2.onReturnItem(var_5_0, arg_5_0, arg_5_1)

		return
	end

	local var_2_1 = arg_2_0._tf

	var_1.SetAsFirstSibling(var_2_1)

	return
end

function var_0_1.onInitItem(arg_6_0, arg_6_1)
	VoteShipItem = var_1_10002

	local var_6_0 = var_1_10002.New(arg_6_1)

	onButton = var_3

	local var_6_1 = arg_6_0
	local var_6_2 = var_6_0.go

	local function var_6_3()
		local var_7_0 = arg_6_0.phase

		VoteGroup = var_2_10001

		if var_7_0 == var_2_10001.VOTE_STAGE then
			arg_6_0.CallBack(var_6_0)
		end

		return
	end

	SFX_PANEL = var_1_10007

	var_3(var_6_1, var_6_2, var_6_3, var_1_10007)

	arg_6_0.voteItems[arg_6_1] = var_6_0

	return
end

function var_0_1.SetCallBack(arg_8_0, arg_8_1)
	arg_8_0.CallBack = arg_8_1

	return
end

function var_0_1.onUpdateItem(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0

	if not arg_9_0.voteItems[arg_9_2] then
		arg_9_0:onInitItem(arg_9_2)

		var_9_0 = arg_9_0.voteItems[arg_9_2]
	end

	local var_9_1 = arg_9_0.displays[arg_9_1 + 1]

	arg_9_0:UpdateShip(arg_9_1, var_9_0, var_9_1)

	return
end

function var_0_1.UpdateShip(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = arg_10_0.phase

	VoteGroup = var_1_10005

	if var_10_0 ~= var_1_10005.VOTE_STAGE then
		local var_10_1 = arg_10_0.voteGroup
		local var_10_2 = var_4.GetRank(var_10_1, arg_10_3)
		local var_10_3 = arg_10_0.voteGroup
		local var_10_4, var_10_5 = var_5.CanRankToNextTurn(var_10_3, var_10_2)

		arg_10_2:update(arg_10_3, {
			rank = var_10_2,
			riseFlag = var_10_4,
			resurgenceFlag = var_10_5
		})
	else
		arg_10_2:update(arg_10_3, nil)
	end

	return
end

function var_0_1.onReturnItem(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_0.exited then
		return
	end

	if arg_11_0.voteItems[arg_11_2] then
		var_3:clear()
	end

	return
end

function var_0_1.Update(arg_12_0, arg_12_1, arg_12_2)
	arg_12_0.voteGroup = arg_12_1
	arg_12_0.phase = arg_12_1:GetStage()
	arg_12_0.displays = arg_12_2

	arg_12_0:UpdateShips()
	arg_12_0:Show()

	return
end

function var_0_1.UpdateShips(arg_13_0)
	local var_13_0 = arg_13_0.phase

	VoteGroup = var_1_10002

	if var_13_0 == var_1_10002.VOTE_STAGE then
		shuffle = var_13_0

		var_13_0(arg_13_0.displays)
	end

	local var_13_1 = arg_13_0.scrollRect

	var_1.SetTotalCount(var_13_1, #arg_13_0.displays)

	return
end

function var_0_1.OnDestroy(arg_14_0)
	return
end

return var_0_1
