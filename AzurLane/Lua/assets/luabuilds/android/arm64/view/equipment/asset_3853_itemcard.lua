class = var_0_10000

local var_0_0 = var_0_10000("ItemCard")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	findTF = var_1_10002
	arg_1_0.bg = var_1_10002(arg_1_1, "bg")
	findTF = var_2

	local var_1_0 = var_2(arg_1_1, "bg/icon_bg/count")
	local var_1_1 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	arg_1_0.countTF = var_1_1(var_1_0, var_5(var_1_10007))
	findTF = var_2

	local var_1_2 = var_2(arg_1_1, "bg/name")
	local var_1_3 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	arg_1_0.nameTF = var_1_3(var_1_2, var_5(var_1_10007))
	findTF = var_2
	arg_1_0.timeLimitTag = var_2(arg_1_1, "bg/timeline")
	ClearTweenItemAlphaAndWhite = var_2

	var_2(arg_1_0.go)

	return
end

function var_0_0.update(arg_2_0, arg_2_1)
	arg_2_0.itemVO = arg_2_1
	IsNil = var_1_10002

	local var_2_0

	if not var_1_10002(arg_2_0.timeLimitTag) then
		setActive = var_2
		var_2_0 = arg_2_0.timeLimitTag

		local var_2_1

		if arg_2_1:getConfig("time_limit") ~= 1 then
			Item = var_5
			var_2_1 = var_5.InTimeLimitSkinAssigned(arg_2_1.id)

			if false then
				var_2_1 = false
			end
		else
			var_2_1 = true
		end

		var_2(var_2_0, var_2_1)
	end

	updateItem = var_2
	rtf = var_2_0

	var_2(var_2_0(arg_2_0.bg), arg_2_1)

	TweenItemAlphaAndWhite = var_2

	var_2(arg_2_0.go)

	local var_2_2 = arg_2_0.countTF
	local var_2_3

	if not (arg_2_1.count > 0) or not arg_2_1.count then
		var_2_3 = ""
	end

	var_2_2.text = var_2_3
	arg_2_0.nameTF.text = arg_2_0:ShortenString(arg_2_1:getConfig("name"), 6)

	return
end

function var_0_0.ShortenString(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = 1
	local var_3_1 = 0
	local var_3_2 = 0
	local var_3_3 = #arg_3_1
	local var_3_4 = false

	while var_3_0 <= var_3_3 do
		string = var_1_10008
		var_1_10008 = var_1_10008.byte(arg_3_1, var_3_0)
		GetPerceptualSize = var_1_10009

		local var_3_5

		var_1_10009, var_3_5 = var_1_10009(var_1_10008)
		var_3_0 = var_3_0 + var_1_10009
		var_3_1 = var_3_1 + var_3_5
		math = var_11

		if var_11.ceil(var_3_1) == arg_3_2 - 1 then
			var_3_2 = var_3_0
		elseif arg_3_2 < var_11 then
			var_3_4 = true

			break
		end
	end

	if var_3_2 == 0 or var_3_3 < var_3_2 or not var_3_4 then
		return arg_3_1
	end

	string = var_1_10008

	return var_1_10008.sub(arg_3_1, 1, var_3_2 - 1) .. ".."
end

function var_0_0.clear(arg_4_0)
	ClearTweenItemAlphaAndWhite = var_1_10001

	var_1_10001(arg_4_0.go)

	return
end

function var_0_0.dispose(arg_5_0)
	return
end

return var_0_0
