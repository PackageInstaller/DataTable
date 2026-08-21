local var_0_0 = class("CastleGameScore")
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
		print("地板的容器不能为nil")

		return
	end

	arg_2_0._content = arg_2_1

	return
end

function var_0_0.setFloor(arg_3_0, arg_3_1)
	arg_3_0.floorIndexs = {}

	for iter_3_0 = 1, #arg_3_1 do
		if not arg_3_1[iter_3_0].fall then
			table.insert(arg_3_0.floorIndexs, arg_3_1[iter_3_0].index)
		end
	end

	return
end

function var_0_0.start(arg_4_0)
	arg_4_0.prepareScores = {}

	for iter_4_0 = #arg_4_0.scores, 1, -1 do
		arg_4_0:returnScore((table.remove(arg_4_0.scores, iter_4_0)))
	end

	arg_4_0.createTime = CastleGameVo.roundData.score_time
	arg_4_0.scoreIndexs = {}
	arg_4_0.floorIndexs = {}

	return
end

function var_0_0.step(arg_5_0)
	for iter_5_0 = #arg_5_0.createTime, 1, -1 do
		if CastleGameVo.gameStepTime > arg_5_0.createTime[iter_5_0].time then
			local var_5_0 = table.remove(arg_5_0.createTime, iter_5_0)

			arg_5_0.prepareScores = {}

			for iter_5_1, iter_5_2 in pairs(var_5_0.score) do
				for iter_5_3 = 1, iter_5_2 do
					table.insert(arg_5_0.prepareScores, iter_5_1)
				end
			end

			arg_5_0:createScore(#arg_5_0.prepareScores)
		end
	end

	for iter_5_4 = #arg_5_0.scores, 1, -1 do
		if arg_5_0.scores[iter_5_4].ready and arg_5_0.scores[iter_5_4].ready > 0 then
			arg_5_0.scores[iter_5_4].ready = arg_5_0.scores[iter_5_4].ready - CastleGameVo.deltaTime

			if arg_5_0.scores[iter_5_4].ready <= 0 then
				arg_5_0.scores[iter_5_4].ready = 0
			end
		end

		if arg_5_0.scores[iter_5_4].removeTime and arg_5_0.scores[iter_5_4].removeTime > 0 then
			arg_5_0.scores[iter_5_4].removeTime = arg_5_0.scores[iter_5_4].removeTime - CastleGameVo.deltaTime

			if arg_5_0.scores[iter_5_4].removeTime <= 0 then
				arg_5_0.scores[iter_5_4].ready = 0
				arg_5_0.scores[iter_5_4].removeTime = 0
			end
		end

		if not table.contains(arg_5_0.floorIndexs, arg_5_0.scores[iter_5_4].index) then
			arg_5_0.scores[iter_5_4].ready = 0
			arg_5_0.scores[iter_5_4].removeTime = 0
		end

		if arg_5_0.scores[iter_5_4].removeTime and arg_5_0.scores[iter_5_4].removeTime == 0 then
			arg_5_0.scores[iter_5_4].ready = 0

			table.remove(arg_5_0.scores, iter_5_4)
			arg_5_0:returnScore(arg_5_0.scores[iter_5_4])
		end
	end

	return
end

function var_0_0.createScore(arg_6_0, arg_6_1)
	for iter_6_0 = 1, arg_6_1 do
		if #arg_6_0.prepareScores <= 0 then
			return
		end

		local var_6_0 = arg_6_0:getCreateAbleIndex()

		if not var_6_0 then
			return
		end

		local var_6_1

		if #arg_6_0.scorePool > 0 then
			var_6_1 = table.remove(arg_6_0.scorePool, 1)
		else
			local var_6_2 = tf(instantiate(arg_6_0._scoreTpl))
			local var_6_3 = findTF(var_6_2, "zPos/anim")
			local var_6_4 = GetComponent(var_6_3, typeof(Animator))
			local var_6_5 = GetComponent(findTF(var_6_2, "zPos/collider"), typeof(BoxCollider2D))

			setParent(var_6_2, arg_6_0._content)

			var_6_1 = {
				tf = var_6_2,
				bound = var_6_5,
				bmin = var_6_2:InverseTransformPoint(var_6_5.bounds.min),
				bmax = var_6_2:InverseTransformPoint(var_6_5.bounds.max),
				animTf = var_6_3
			}
		end

		local var_6_6 = table.remove(arg_6_0.prepareScores, math.random(1, #arg_6_0.prepareScores))
		local var_6_7 = Clone(CastleGameVo.score_data[var_6_6])

		var_6_1.data = var_6_7
		var_6_1.id = var_6_6

		for iter_6_1 = 0, var_6_1.animTf.childCount - 1 do
			setActive(var_6_1.animTf:GetChild(iter_6_1), false)
		end

		setActive(findTF(var_6_1.animTf, var_6_7.tpl), true)

		local var_6_8 = CastleGameVo.GetRotationPosByWH(var_6_0 % CastleGameVo.w_count, (math.floor(var_6_0 / CastleGameVo.w_count)))

		var_6_8.y = var_6_8.y + var_0_1
		var_6_1.tf.anchoredPosition = var_6_8
		var_6_1.index = var_6_0
		var_6_1.ready = 0.5
		var_6_1.removeTime = CastleGameVo.score_remove_time

		setActive(var_6_1.tf, true)
		table.insert(arg_6_0.scoreIndexs, var_6_0)
		table.insert(arg_6_0.scores, var_6_1)

		if arg_6_0.itemChangeCallback then
			arg_6_0.itemChangeCallback(var_6_1, true)
		end
	end

	return
end

function var_0_0.getCreateAbleIndex(arg_7_0)
	for iter_7_0 = 1, #arg_7_0.floorIndexs do
		if not table.contains(arg_7_0.scoreIndexs, arg_7_0.floorIndexs[iter_7_0]) then
			table.insert({}, arg_7_0.floorIndexs[iter_7_0])
		end
	end

	if #{} > 0 then
		return ({})[math.random(1, #{})]
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
			arg_10_0:returnScore((table.remove(arg_10_0.scores, iter_10_0)))

			return
		end
	end

	return
end

function var_0_0.returnScore(arg_11_0, arg_11_1)
	for iter_11_0 = #arg_11_0.scoreIndexs, 1, -1 do
		if arg_11_0.scoreIndexs[iter_11_0] == arg_11_1.index then
			table.remove(arg_11_0.scoreIndexs, iter_11_0)
		end
	end

	if arg_11_0.itemChangeCallback then
		arg_11_0.itemChangeCallback(arg_11_1, false)
	end

	setActive(arg_11_1.tf, false)
	table.insert(arg_11_0.scorePool, arg_11_1)

	return
end

function var_0_0.clear(arg_12_0)
	return
end

return var_0_0
