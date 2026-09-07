local CastleGameScore = class("CastleGameScore")
local var_0_1 = 180

function CastleGameScore:Ctor(arg_1_1, arg_1_2)
	self._scoreTpl = arg_1_1
	self._event = arg_1_2
	self.scorePool = {}
	self.scores = {}

	return
end

function CastleGameScore:setContent(arg_2_1)
	if not arg_2_1 then
		print("地板的容器不能为nil")

		return
	end

	self._content = arg_2_1

	return
end

function CastleGameScore:setFloor(arg_3_1)
	self.floorIndexs = {}

	for iter_3_0 = 1, #arg_3_1 do
		if not arg_3_1[iter_3_0].fall then
			table.insert(self.floorIndexs, arg_3_1[iter_3_0].index)
		end
	end

	return
end

function CastleGameScore:start()
	self.prepareScores = {}

	for iter_4_0 = #self.scores, 1, -1 do
		self:returnScore((table.remove(self.scores, iter_4_0)))
	end

	self.createTime = CastleGameVo.roundData.score_time
	self.scoreIndexs = {}
	self.floorIndexs = {}

	return
end

function CastleGameScore:step()
	for iter_5_0 = #self.createTime, 1, -1 do
		if CastleGameVo.gameStepTime > self.createTime[iter_5_0].time then
			self.prepareScores = {}

			for iter_5_1, iter_5_2 in pairs(table.remove(self.createTime, iter_5_0).score) do
				for iter_5_3 = 1, iter_5_2 do
					table.insert(self.prepareScores, iter_5_1)
				end
			end

			self:createScore(#self.prepareScores)
		end
	end

	for iter_5_4 = #self.scores, 1, -1 do
		if self.scores[iter_5_4].ready and self.scores[iter_5_4].ready > 0 then
			self.scores[iter_5_4].ready = self.scores[iter_5_4].ready - CastleGameVo.deltaTime

			if self.scores[iter_5_4].ready <= 0 then
				self.scores[iter_5_4].ready = 0
			end
		end

		if self.scores[iter_5_4].removeTime and self.scores[iter_5_4].removeTime > 0 then
			self.scores[iter_5_4].removeTime = self.scores[iter_5_4].removeTime - CastleGameVo.deltaTime

			if self.scores[iter_5_4].removeTime <= 0 then
				self.scores[iter_5_4].ready = 0
				self.scores[iter_5_4].removeTime = 0
			end
		end

		if not table.contains(self.floorIndexs, self.scores[iter_5_4].index) then
			self.scores[iter_5_4].ready = 0
			self.scores[iter_5_4].removeTime = 0
		end

		if self.scores[iter_5_4].removeTime and self.scores[iter_5_4].removeTime == 0 then
			self.scores[iter_5_4].ready = 0

			table.remove(self.scores, iter_5_4)
			self:returnScore(self.scores[iter_5_4])
		end
	end

	return
end

function CastleGameScore:createScore(arg_6_1)
	for iter_6_0 = 1, arg_6_1 do
		if #self.prepareScores <= 0 then
			return
		end

		local var_6_0 = self:getCreateAbleIndex()

		if not var_6_0 then
			return
		end

		local var_6_1

		if #self.scorePool > 0 then
			var_6_1 = table.remove(self.scorePool, 1)
		else
			local var_6_2 = tf(instantiate(self._scoreTpl))
			local var_6_3 = findTF(var_6_2, "zPos/anim")
			local var_6_4 = GetComponent(var_6_3, typeof(Animator))
			local var_6_5 = GetComponent(findTF(var_6_2, "zPos/collider"), typeof(BoxCollider2D))

			setParent(var_6_2, self._content)

			var_6_1 = {
				tf = var_6_2,
				bound = var_6_5,
				bmin = var_6_2:InverseTransformPoint(var_6_5.bounds.min),
				bmax = var_6_2:InverseTransformPoint(var_6_5.bounds.max),
				animTf = var_6_3
			}
		end

		local var_6_6 = table.remove(self.prepareScores, math.random(1, #self.prepareScores))
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
		table.insert(self.scoreIndexs, var_6_0)
		table.insert(self.scores, var_6_1)

		if self.itemChangeCallback then
			self.itemChangeCallback(var_6_1, true)
		end
	end

	return
end

function CastleGameScore:getCreateAbleIndex()
	local var_7_0 = {}

	for iter_7_0 = 1, #self.floorIndexs do
		if not table.contains(self.scoreIndexs, self.floorIndexs[iter_7_0]) then
			table.insert(var_7_0, self.floorIndexs[iter_7_0])
		end
	end

	if #var_7_0 > 0 then
		return var_7_0[math.random(1, #var_7_0)]
	else
		return nil
	end

	return
end

function CastleGameScore:getScores()
	return self.scores
end

function CastleGameScore:setItemChange(arg_9_1)
	self.itemChangeCallback = arg_9_1

	return
end

function CastleGameScore:hitScore(arg_10_1)
	for iter_10_0 = #self.scores, 1, -1 do
		if self.scores[iter_10_0] == arg_10_1 then
			self:returnScore((table.remove(self.scores, iter_10_0)))

			return
		end
	end

	return
end

function CastleGameScore:returnScore(arg_11_1)
	for iter_11_0 = #self.scoreIndexs, 1, -1 do
		if self.scoreIndexs[iter_11_0] == arg_11_1.index then
			table.remove(self.scoreIndexs, iter_11_0)
		end
	end

	if self.itemChangeCallback then
		self.itemChangeCallback(arg_11_1, false)
	end

	setActive(arg_11_1.tf, false)
	table.insert(self.scorePool, arg_11_1)

	return
end

function CastleGameScore:clear()
	return
end

return CastleGameScore
