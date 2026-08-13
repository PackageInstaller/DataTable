class = var_0_10000

local var_0_0 = "VoteFinalsRaceShipsPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("....base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "FinalsRaceShips"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.num1TF = var_1.Find(var_2_0, "content/head/num1")

	local var_2_1 = arg_2_0._tf

	arg_2_0.num2TF = var_1.Find(var_2_1, "content/head/num2")

	local var_2_2 = arg_2_0._tf

	arg_2_0.num3TF = var_1.Find(var_2_2, "content/head/num3")
	UIItemList = var_1

	local var_2_3 = var_1.New
	local var_2_4 = arg_2_0._tf
	local var_2_5 = var_2.Find(var_2_4, "content/ships")
	local var_2_6 = arg_2_0._tf

	arg_2_0.UIlist = var_2_3(var_2_5, var_3.Find(var_2_6, "content/ships/ship_tpl"))

	return
end

function var_0_1.SetCallBack(arg_3_0, arg_3_1)
	arg_3_0.CallBack = arg_3_1

	return
end

function var_0_1.Update(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	arg_4_0.voteGroup = arg_4_1
	arg_4_0.count = arg_4_3
	arg_4_0.phase = arg_4_1:GetStage()
	arg_4_0.displays = {}
	arg_4_0.topList = {}

	local var_4_0 = arg_4_1
	local var_4_1 = arg_4_1.GetRankList(var_4_0)

	ipairs = var_4_0

	for iter_4_0, iter_4_1 in var_4_0(arg_4_2) do
		if iter_4_1.group == var_4_1[1].group or iter_4_1.group == var_4_1[2].group or iter_4_1.group == var_4_1[3].group then
			table = var_10

			var_10.insert(arg_4_0.topList, iter_4_1)
		else
			table = var_10

			var_10.insert(arg_4_0.displays, iter_4_1)
		end
	end

	arg_4_0:UpdateTop3(var_4_1[1], var_4_1[2], var_4_1[3])
	arg_4_0:UpdateShips()
	arg_4_0:Show()

	return
end

function var_0_1.UpdateTop3(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	arg_5_0:UpdateVoteShip(arg_5_0.num1TF, arg_5_1)
	arg_5_0:UpdateVoteShip(arg_5_0.num2TF, arg_5_2)
	arg_5_0:UpdateVoteShip(arg_5_0.num3TF, arg_5_3)

	setActive = var_4

	local var_5_0 = arg_5_0.num1TF

	_ = var_6

	var_4(var_5_0, var_6.any(arg_5_0.topList, function(arg_6_0)
		return arg_6_0.group == arg_5_1.group
	end))

	setActive = var_4

	local var_5_1 = arg_5_0.num2TF

	_ = var_6

	var_4(var_5_1, var_6.any(arg_5_0.topList, function(arg_7_0)
		return arg_7_0.group == arg_5_2.group
	end))

	setActive = var_4

	local var_5_2 = arg_5_0.num3TF

	_ = var_6

	var_4(var_5_2, var_6.any(arg_5_0.topList, function(arg_8_0)
		return arg_8_0.group == arg_5_3.group
	end))

	return
end

function var_0_1.UpdateShips(arg_9_0)
	local var_9_0 = arg_9_0.UIlist

	var_1.make(var_9_0, function(arg_10_0, arg_10_1, arg_10_2)
		UIItemList = var_2_10003

		if arg_10_0 == var_2_10003.EventUpdate then
			local var_10_0 = arg_9_0.displays[arg_10_1 + 1]

			VoteShipItem = var_4

			local var_10_1 = var_4.New(arg_10_2)

			var_4.update(var_10_1, var_10_0)

			onButton = var_5

			local var_10_2 = arg_9_0
			local var_10_3 = var_4.go

			local function var_10_4()
				if arg_9_0.CallBack then
					local var_11_0 = arg_9_0.phase

					VoteGroup = var_3_10001

					if var_11_0 == var_3_10001.VOTE_STAGE then
						arg_9_0.CallBack(var_0, var_0.voteShip.votes)
					end
				end

				return
			end

			SFX_PANEL = var_2_10009

			var_5(var_10_2, var_10_3, var_10_4, var_2_10009)
		end

		return
	end)

	local var_9_1 = arg_9_0.UIlist
	local var_9_2 = var_1.align

	math = var_3

	var_9_2(var_9_1, var_3.max(#arg_9_0.displays, 0))

	return
end

function var_0_1.contains(arg_12_0, arg_12_1, arg_12_2)
	_ = var_1_10003

	return var_1_10003.any(arg_12_1, function(arg_13_0)
		return arg_13_0.group == arg_12_2.group
	end)
end

function var_0_1.UpdateVoteShip(arg_14_0, arg_14_1, arg_14_2)
	if not arg_14_2 then
		setActive = var_1_10003

		var_1_10003(arg_14_1, false)

		return
	end

	setText = var_1_10003

	local var_14_0 = arg_14_1
	local var_14_1 = arg_14_1.Find(var_14_0, "name")

	shortenString = var_14_0

	var_1_10003(var_14_1, var_14_0(arg_14_2:getShipName(), 5))

	local var_14_2 = arg_14_2:getPainting()

	arg_14_0:LoadPainting(arg_14_1:Find("mask"), var_14_2)

	onButton = var_4

	local var_14_3 = arg_14_0
	local var_14_4 = arg_14_1

	local function var_14_5()
		if arg_14_0.CallBack then
			local var_15_0 = arg_14_0.phase

			VoteGroup = var_2_10001

			if var_15_0 == var_2_10001.VOTE_STAGE then
				arg_14_0.CallBack({
					voteShip = arg_14_2
				}, arg_14_2.votes)
			end
		end

		return
	end

	SFX_PANEL = var_8

	var_4(var_14_3, var_14_4, var_14_5, var_8)

	return
end

function var_0_1.LoadPainting(arg_16_0, arg_16_1, arg_16_2)
	LoadSpriteAsync = var_1_10003

	var_1_10003("VoteShips/" .. arg_16_2, function(arg_17_0)
		setImageSprite = var_2_10001

		local var_17_0 = arg_16_1

		var_2_10001(var_2.Find(var_17_0, "icon"), arg_17_0, false)

		return
	end)

	return
end

function var_0_1.OnDestroy(arg_18_0)
	return
end

return var_0_1
