class = var_0_10000

local var_0_0 = var_0_10000("CastleGameScore")
local var_0_1 = 180

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._scoreTpl = arg_1_1
	arg_1_0._event = arg_1_2
	arg_1_0.scorePool = {}
	arg_1_0.scores = {}

	return
end

function var_0_0.setContent(arg_2_0, arg_2_1)
	if not arg_2_1 then
		print = var_1_10002

		var_1_10002("地板的容器不能为nil")

		return
	end

	arg_2_0._content = arg_2_1

	return
end

function var_0_0.setFloor(arg_3_0, arg_3_1)
	arg_3_0.floorIndexs = {}

	for iter_3_0 = 1, #arg_3_1 do
		if not arg_3_1[iter_3_0].fall then
			table = var_6

			var_6.insert(arg_3_0.floorIndexs, arg_3_1[iter_3_0].index)
		end
	end

	return
end

function var_0_0.start(arg_4_0)
	arg_4_0.prepareScores = {}

	for iter_4_0 = #arg_4_0.scores, 1, -1 do
		table = var_1_10005
		var_1_10005 = var_1_10005.remove(arg_4_0.scores, iter_4_0)

		arg_4_0:returnScore(var_1_10005)
	end

	CastleGameVo = var_1
	arg_4_0.createTime = var_1.roundData.score_time
	arg_4_0.scoreIndexs = {}
	arg_4_0.floorIndexs = {}

	return
end

function var_0_0.step(arg_5_0)
	for iter_5_0 = #arg_5_0.createTime, 1, -1 do
		CastleGameVo = var_1_10005

		if var_1_10005.gameStepTime > arg_5_0.createTime[iter_5_0].time then
			table = var_1_10005

			local var_5_0 = var_1_10005.remove(arg_5_0.createTime, iter_5_0).num

			arg_5_0.prepareScores = {}

			local var_5_1 = var_1_10005.score

			pairs = var_1_10008

			for iter_5_1, iter_5_2 in var_1_10008(var_5_1) do
				for iter_5_3 = 1, iter_5_2 do
					table = var_1_10017

					var_1_10017.insert(arg_5_0.prepareScores, iter_5_1)
				end
			end

			arg_5_0:createScore(#arg_5_0.prepareScores)
		end
	end

	for iter_5_4 = #arg_5_0.scores, 1, -1 do
		if arg_5_0.scores[iter_5_4].ready then
			local var_5_2 = var_5.ready

			if 0 < var_5_2 then
				local var_5_3 = var_5.ready

				CastleGameVo = var_7
				var_5.ready = var_5_3 - var_7.deltaTime

				if var_5.ready <= 0 then
					var_5.ready = 0
				end
			end
		end

		local var_5_4

		if var_5.removeTime then
			var_5_4 = var_5.removeTime

			if 0 < var_5_4 then
				var_5_4 = var_5.removeTime
				CastleGameVo = var_7
				var_5.removeTime = var_5_4 - var_7.deltaTime

				if var_5.removeTime <= 0 then
					var_5.ready = 0
					var_5.removeTime = 0
				end
			end
		end

		table = var_5_4

		if not var_5_4.contains(arg_5_0.floorIndexs, var_5.index) then
			var_5.ready = 0
			var_5.removeTime = 0
		end

		if var_5.removeTime and var_5.removeTime == 0 then
			var_5.ready = 0
			table = var_6

			var_6.remove(arg_5_0.scores, iter_5_4)
			arg_5_0:returnScore(var_5)
		end
	end

	return
end

function var_0_0.createScore(arg_6_0, arg_6_1)
	for iter_6_0 = 1, arg_6_1 do
		if #arg_6_0.prepareScores <= 0 then
			return
		end

		if not arg_6_0:getCreateAbleIndex() then
			return
		end

		local var_6_0
		local var_6_1 = #arg_6_0.scorePool

		if 0 < var_6_1 then
			table = var_6_1
			var_6_0 = var_6_1.remove(arg_6_0.scorePool, 1)
		else
			tf = var_6_1
			instantiate = var_9
			var_6_1 = var_6_1(var_9(arg_6_0._scoreTpl))
			findTF = var_9

			local var_6_2 = var_9(var_6_1, "zPos/anim")

			GetComponent = var_1_10010

			local var_6_3 = var_6_2

			typeof = var_1_10012
			Animator = var_1_10013
			var_1_10010 = var_1_10010(var_6_3, var_1_10012(var_1_10013))
			GetComponent = var_6_3
			findTF = var_1_10012
			var_1_10012 = var_1_10012(var_6_1, "zPos/collider")
			typeof = var_1_10013
			BoxCollider2D = var_14

			local var_6_4 = var_6_3(var_1_10012, var_1_10013(var_14))

			setParent = var_1_10012

			var_1_10012(var_6_1, arg_6_0._content)

			var_1_10013 = var_6_1
			var_1_10012 = var_6_1.InverseTransformPoint(var_1_10013, var_6_4.bounds.min)
			var_1_10013 = var_6_1:InverseTransformPoint(var_6_4.bounds.max)
			var_6_0 = {
				tf = var_6_1,
				bound = var_6_4,
				bmin = var_1_10012,
				bmax = var_1_10013,
				animTf = var_6_2
			}
		end

		table = var_6_1

		local var_6_5 = var_6_1.remove
		local var_6_6 = arg_6_0.prepareScores

		math = var_1_10010

		local var_6_7 = var_6_5(var_6_6, var_1_10010.random(1, #arg_6_0.prepareScores))

		Clone = var_6_6
		CastleGameVo = var_1_10010
		var_6_0.data = var_6_6(var_1_10010.score_data[var_6_7])
		var_6_0.id = var_6_7
		var_1_10010 = var_9.tpl

		local var_6_8 = var_6_0.animTf.childCount

		for iter_6_1 = 0, var_6_8 - 1 do
			setActive = var_1_10016

			local var_6_9 = var_6_0.animTf

			var_1_10016(var_17.GetChild(var_6_9, iter_6_1), false)
		end

		setActive = var_1_10012
		findTF = var_1_10013

		var_1_10012(var_1_10013(var_6_0.animTf, var_1_10010), true)

		CastleGameVo = var_1_10012
		var_1_10012 = var_6 % var_1_10012.w_count
		math = var_1_10013
		var_1_10013 = var_1_10013.floor
		CastleGameVo = var_14
		var_1_10013 = var_1_10013(var_6 / var_14.w_count)
		CastleGameVo = var_14
		var_14.y = var_14.GetRotationPosByWH(var_1_10012, var_1_10013).y + var_0_1
		var_6_0.tf.anchoredPosition = var_14
		var_6_0.index = var_6
		var_6_0.ready = 0.5
		CastleGameVo = var_15
		var_6_0.removeTime = var_15.score_remove_time
		setActive = var_15

		var_15(var_6_0.tf, true)

		table = var_15

		var_15.insert(arg_6_0.scoreIndexs, var_6)

		table = var_15

		var_15.insert(arg_6_0.scores, var_6_0)

		if arg_6_0.itemChangeCallback then
			arg_6_0.itemChangeCallback(var_6_0, true)
		end
	end

	return
end

function var_0_0.getCreateAbleIndex(arg_7_0)
	local var_7_0 = {}

	for iter_7_0 = 1, #arg_7_0.floorIndexs do
		table = var_1_10006

		if not var_1_10006.contains(arg_7_0.scoreIndexs, arg_7_0.floorIndexs[iter_7_0]) then
			table = var_1_10006

			var_1_10006.insert(var_7_0, arg_7_0.floorIndexs[iter_7_0])
		end
	end

	if #var_7_0 > 0 then
		math = var_2

		return var_7_0[var_2.random(1, #var_7_0)]
	else
		return nil
	end

	return
end

function var_0_0.getScores(arg_8_0)
	return arg_8_0.scores
end

function var_0_0.setItemChange(arg_9_0, arg_9_1)
	arg_9_0.itemChangeCallback = arg_9_1

	return
end

function var_0_0.hitScore(arg_10_0, arg_10_1)
	for iter_10_0 = #arg_10_0.scores, 1, -1 do
		if arg_10_0.scores[iter_10_0] == arg_10_1 then
			table = var_6

			local var_10_0 = var_6.remove(arg_10_0.scores, iter_10_0)

			arg_10_0:returnScore(var_10_0)

			return
		end
	end

	return
end

function var_0_0.returnScore(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_1.index

	for iter_11_0 = #arg_11_0.scoreIndexs, 1, -1 do
		if arg_11_0.scoreIndexs[iter_11_0] == var_11_0 then
			table = var_7

			var_7.remove(arg_11_0.scoreIndexs, iter_11_0)
		end
	end

	if arg_11_0.itemChangeCallback then
		arg_11_0.itemChangeCallback(arg_11_1, false)
	end

	setActive = var_3

	var_3(arg_11_1.tf, false)

	table = var_3

	var_3.insert(arg_11_0.scorePool, arg_11_1)

	return
end

function var_0_0.clear(arg_12_0)
	return
end

return var_0_0
