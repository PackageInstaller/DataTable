class = var_0_10000

local var_0_0 = var_0_10000("VoteShipItem")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0.tf = arg_1_1.transform
	findTF = var_2
	arg_1_0.icon = var_2(arg_1_0.tf, "mask/icon")
	findTF = var_2

	local var_1_0 = var_2(arg_1_0.tf, "name/Text")

	arg_1_0.name = var_2.GetComponent(var_1_0, "ScrollText")
	findTF = var_2

	local var_1_1 = var_2(arg_1_0.tf, "Text")

	arg_1_0.rank = var_2.GetComponent(var_1_1, "RichText")
	findTF = var_2
	arg_1_0.riseNext = var_2(arg_1_0.tf, "rise_next")
	findTF = var_2
	arg_1_0.riseResurgence = var_2(arg_1_0.tf, "rise_resurgence")
	ClearTweenItemAlphaAndWhite = var_2

	var_2(arg_1_0.go)

	return
end

function var_0_0.update(arg_2_0, arg_2_1, arg_2_2)
	TweenItemAlphaAndWhite = var_1_10003

	var_1_10003(arg_2_0.go)

	if arg_2_0.voteShip ~= arg_2_1 then
		arg_2_0.voteShip = arg_2_1

		arg_2_0:flush()
	end

	local var_2_0 = arg_2_0.rank

	var_2_0.text = arg_2_0:wrapRankTxt(arg_2_2 and arg_2_2.rank)
	IsNil = var_2_0

	if not var_2_0(arg_2_0.riseNext) then
		setActive = var_3

		var_3(arg_2_0.riseNext, arg_2_2 and arg_2_2.riseFlag)
	end

	IsNil = var_3

	if not var_3(arg_2_0.riseResurgence) then
		setActive = var_3

		var_3(arg_2_0.riseResurgence, arg_2_2 and arg_2_2.resurgenceFlag)
	end

	return
end

function var_0_0.flush(arg_3_0)
	LoadSpriteAsync = var_1_10001

	local var_3_0 = "ShipYardIcon/"
	local var_3_1 = arg_3_0.voteShip

	var_1_10001(var_3_0 .. var_3.getPainting(var_3_1), function(arg_4_0)
		IsNil = var_2_10001

		if var_2_10001(arg_3_0.icon) then
			return
		end

		setImageSprite = var_1

		var_1(arg_3_0.icon, arg_4_0, false)

		return
	end)

	PLATFORM_CODE = var_1_10001
	PLATFORM_US = var_3_2

	local var_3_2

	if var_1_10001 == var_3_2 then
		var_3_2 = arg_3_0.name
		var_1_10001 = var_1_10001.SetText

		local var_3_3 = arg_3_0.voteShip

		var_1_10001(var_3_2, var_3.getShipName(var_3_3))
	else
		setText = var_1_10001
		go = var_3_2

		local var_3_4 = var_3_2(arg_3_0.name)

		shortenString = var_3

		local var_3_5 = arg_3_0.voteShip

		var_1_10001(var_3_4, var_3(var_4.getShipName(var_3_5), 5))
	end

	return
end

local var_0_1 = {
	"st",
	"nd",
	"rd"
}

function var_0_0.wrapRankTxt(arg_5_0, arg_5_1)
	if arg_5_1 and arg_5_1 <= 3 then
		local var_5_0 = var_0_1[arg_5_1]

		string = var_1_10003

		return var_1_10003.format("<material=gradient from=#FF8c1c to=#ff0000 x=0 y=-1>%s<size=30>%s</size></material>", arg_5_1, var_5_0)
	else
		return ""
	end

	return
end

function var_0_0.clear(arg_6_0)
	ClearTweenItemAlphaAndWhite = var_1_10001

	var_1_10001(arg_6_0.go)

	return
end

return var_0_0
