local var_0_0 = class("VoteShipItem")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0.tf = arg_1_1.transform
	arg_1_0.icon = findTF(arg_1_0.tf, "mask/icon")
	arg_1_0.name = findTF(arg_1_0.tf, "name/Text"):GetComponent("ScrollText")
	arg_1_0.rank = findTF(arg_1_0.tf, "Text"):GetComponent("RichText")
	arg_1_0.riseNext = findTF(arg_1_0.tf, "rise_next")
	arg_1_0.riseResurgence = findTF(arg_1_0.tf, "rise_resurgence")

	ClearTweenItemAlphaAndWhite(arg_1_0.go)

	return
end

function var_0_0.update(arg_2_0, arg_2_1, arg_2_2)
	TweenItemAlphaAndWhite(arg_2_0.go)

	if arg_2_0.voteShip ~= arg_2_1 then
		arg_2_0.voteShip = arg_2_1

		arg_2_0:flush()
	end

	arg_2_0.rank.text = arg_2_0:wrapRankTxt(arg_2_2 and arg_2_2.rank)

	if not IsNil(arg_2_0.riseNext) then
		setActive(arg_2_0.riseNext, arg_2_2 and arg_2_2.riseFlag)
	end

	if not IsNil(arg_2_0.riseResurgence) then
		setActive(arg_2_0.riseResurgence, arg_2_2 and arg_2_2.resurgenceFlag)
	end

	return
end

function var_0_0.flush(arg_3_0)
	LoadSpriteAsync("ShipYardIcon/" .. arg_3_0.voteShip:getPainting(), function(arg_4_0)
		if IsNil(arg_3_0.icon) then
			return
		end

		setImageSprite(arg_3_0.icon, arg_4_0, false)

		return
	end)

	if PLATFORM_CODE == PLATFORM_US then
		arg_3_0.name:SetText(arg_3_0.voteShip:getShipName())
	else
		setText(go(arg_3_0.name), shortenString(arg_3_0.voteShip:getShipName(), 5))
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
		return string.format("<material=gradient from=#FF8c1c to=#ff0000 x=0 y=-1>%s<size=30>%s</size></material>", arg_5_1, var_0_1[arg_5_1])
	else
		return ""
	end

	return
end

function var_0_0.clear(arg_6_0)
	ClearTweenItemAlphaAndWhite(arg_6_0.go)

	return
end

return var_0_0
