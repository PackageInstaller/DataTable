local LaunchBallEnemy = class("LaunchBallEnemy")
local var_0_1 = {}
local var_0_2 = 0.35
local var_0_3 = 70
local var_0_4 = 100
local var_0_5 = 80
local var_0_6 = 80
local var_0_7 = 50
local var_0_9 = -300
local var_0_10 = -150
local var_0_11 = 0.5
local var_0_12 = 500
local var_0_13 = -500
local var_0_14 = 10
local var_0_15 = {
	{
		anim_name = "01_Yellow"
	},
	{
		anim_name = "02_Green"
	},
	{
		anim_name = "03_White"
	},
	{
		anim_name = "04_Red"
	},
	{
		anim_name = "05_Blue"
	},
	{
		anim_name = "06_Black"
	},
	{
		anim_name = "07_Purple"
	}
}

local function var_0_16(arg_1_0, arg_1_1)
	local var_1_0 = {
		ctor = function(self)
			self._tf = arg_1_0
			self._animator = GetComponent(findTF(self._tf, "ad/anim"), typeof(Animator))
			self.angleTf = findTF(self._tf, "ad/angle")
			self.leftBoundPoints = GetComponent(findTF(self._tf, "ad/angle/left"), typeof("UnityEngine.PolygonCollider2D")):ToTable()
			self.rightBoundPoints = GetComponent(findTF(self._tf, "ad/angle/right"), typeof("UnityEngine.PolygonCollider2D")):ToTable()
			self.localRotation = Vector3(0, 0, 0)
			self.circlePos = findTF(self._tf, "ad/angle/circle").anchoredPosition
			self.buffIcon = self.buffIcon or findTF(self._tf, "ad/iconEffect")
			self._effectTf = findTF(self._tf, "ad/effect")
			self._playEffects = {}

			return
		end,
		setData = function(self, arg_3_1, arg_3_2)
			self:clear()

			self.enemyIndex = arg_3_1
			self._animator.runtimeAnimatorController = arg_3_2.animator
			self.data = arg_3_2
			self.hp = arg_3_2.data.hp
			self.overSplitFlag = false

			for iter_3_0 = 0, self.buffIcon.childCount - 1 do
				setActive(self.buffIcon:GetChild(iter_3_0), false)
			end

			for iter_3_1 = #self._playEffects, 1, -1 do
				setActive(self._playEffects[iter_3_1].tf, false)
				table.remove(self._playEffects, iter_3_1)
			end

			self:stopAnim(false)

			return
		end,
		setBuff = function(self, arg_4_1)
			self.buffType = arg_4_1

			if self.buffType then
				local var_4_0 = LaunchBallGameConst.enemy_buff_data[self.buffType].tpl

				for iter_4_0 = 0, self.buffIcon.childCount - 1 do
					local var_4_1 = self.buffIcon:GetChild(iter_4_0)

					setActive(var_4_1, var_4_1.name == var_4_0)
				end
			else
				for iter_4_1 = 0, self.buffIcon.childCount - 1 do
					setActive(self.buffIcon:GetChild(iter_4_1), false)
				end
			end

			return
		end,
		getBuff = function(self)
			return self.buffType
		end,
		setPoints = function(arg_6_0, arg_6_1)
			arg_6_0.points = arg_6_1

			return
		end,
		hit = function(self)
			if self.buffType and self.buffType == LaunchBallGameConst.enemy_buff_streng then
				self:setBuff(nil)

				return
			end

			self.hp = self.hp - 1

			if self.hp <= 0 then
				self:setTimeRemove()
			end

			return
		end,
		getTf = function(self)
			return self._tf
		end,
		playAnimation = function(self, arg_9_1)
			self._animator:Play(arg_9_1)

			return
		end,
		setActive = function(self, arg_10_1)
			setActive(self._tf, arg_10_1)

			return
		end,
		getColor = function(self)
			return self.data.data.color
		end,
		getSplitFlag = function(self)
			return self.splitFlag
		end,
		setSplitFlag = function(arg_13_0, arg_13_1)
			arg_13_0.splitFlag = arg_13_1

			return
		end,
		step = function(self)
			if self.timeToRemove and self.timeToRemove > 0 then
				self.timeToRemove = self.timeToRemove - LaunchBallGameVo.deltaTime

				if self.timeToRemove <= 0 then
					self.timeToRemove = nil
					self.removeFlag = true
				end
			end

			if #self._playEffects > 0 then
				for iter_14_0 = #self._playEffects, 1, -1 do
					if self._playEffects[iter_14_0].time then
						self._playEffects[iter_14_0].time = self._playEffects[iter_14_0].time - LaunchBallGameVo.deltaTime
					end

					if self._playEffects[iter_14_0].time and self._playEffects[iter_14_0].time <= 0 then
						setActive(self._playEffects[iter_14_0].tf, false)
						table.remove(self._playEffects, iter_14_0)
					end
				end
			end

			return
		end,
		move = function(self, arg_15_1, arg_15_2, arg_15_3, arg_15_4)
			if arg_15_1 == 0 then
				return
			end

			LaunchBallEnemy.moveCount = LaunchBallEnemy.moveCount + 1
			self.distance = self.distance + arg_15_1

			if self.distance < 0 then
				self.distance = 0
			end

			if arg_15_2 and arg_15_3 and arg_15_4 then
				self._tf.anchoredPosition = arg_15_2
				self.pointIndex = arg_15_3
				self.localRotation = arg_15_4
				self.angleTf.localEulerAngles = self.localRotation
			else
				local var_15_0 = self:getPosByDistance(self.distance)

				self._tf.anchoredPosition.x = var_15_0.x
				self._tf.anchoredPosition.y = var_15_0.y
				self._tf.anchoredPosition = self._tf.anchoredPosition
				self.pointIndex = var_15_0.index
				self.localRotation.z = self.points[self.pointIndex].angle
				self.angleTf.localEulerAngles = self.localRotation
			end

			return
		end,
		getPosition = function(self)
			return self._tf.anchoredPosition
		end,
		getPointIndex = function(self)
			return self.pointIndex
		end,
		getLocalRotation = function(self)
			return self.localRotation
		end,
		stopAnim = function(self, arg_19_1)
			self._animator.speed = arg_19_1 and 0 or 1

			return
		end,
		checkWorldInCircle = function(self, arg_20_1)
			local var_20_0 = self.angleTf:InverseTransformPoint(arg_20_1)

			if math.abs(var_20_0.x - self.circlePos.x) >= 150 or math.abs(var_20_0.y - self.circlePos.y) >= var_0_5 * 2 then
				return false
			end

			if math.sqrt(math.pow(var_20_0.x - self.circlePos.x, 2) + math.pow(var_20_0.y - self.circlePos.y, 2)) < var_0_5 then
				return true
			end

			return false
		end,
		checkWorldInRect = function(self, arg_21_1)
			local var_21_0 = self.angleTf:InverseTransformPoint(arg_21_1)
			local var_21_1 = 0
			local var_21_2 = math.sqrt(math.pow(var_21_0.x - self.circlePos.x, 2) + math.pow(var_21_0.y - self.circlePos.y, 2))

			if var_21_2 > var_0_3 then
				return var_21_1, nil
			end

			if LaunchBallGameVo.PointInRect(var_21_0, self.leftBoundPoints[1], self.leftBoundPoints[2], self.leftBoundPoints[3], self.leftBoundPoints[4]) then
				var_21_1 = -1
			elseif LaunchBallGameVo.PointInRect(var_21_0, self.rightBoundPoints[1], self.rightBoundPoints[2], self.rightBoundPoints[3], self.rightBoundPoints[4]) then
				var_21_1 = 1
			end

			return var_21_1, var_21_2
		end,
		getPosByDistance = function(self, arg_22_1)
			local var_22_0 = math.floor(arg_22_1 * 2)

			if LaunchBallEnemy.EnemyDistanceData[self.enemyIndex][var_22_0] then
				return LaunchBallEnemy.EnemyDistanceData[self.enemyIndex][var_22_0]
			end

			local var_22_1 = var_22_0 / 2

			self.distancePosResult = self.distancePosResult or Vector2(0, 0)

			local var_22_2 = 1
			local var_22_3 = 0

			for iter_22_0 = 1, #self.points do
				if var_22_1 >= self.points[iter_22_0].distance then
					var_22_2 = iter_22_0

					if iter_22_0 < #self.points then
						var_22_3 = var_22_1 - self.points[iter_22_0].distance
						self.distancePosResult.x = self.points[iter_22_0].pos.x
						self.distancePosResult.y = self.points[iter_22_0].pos.y
					else
						self.distancePosResult.x = self.points[iter_22_0].pos.x
						self.distancePosResult.y = self.points[iter_22_0].pos.y
						var_22_3 = 0
					end
				else
					break
				end
			end

			if var_22_3 ~= 0 then
				self.distancePosResult.x = self.distancePosResult.x + self.points[var_22_2].move.x * var_22_3
				self.distancePosResult.y = self.distancePosResult.y + self.points[var_22_2].move.y * var_22_3
			end

			local var_22_4 = {
				x = self.distancePosResult.x,
				y = self.distancePosResult.y,
				index = var_22_2
			}

			LaunchBallEnemy.EnemyDistanceData[self.enemyIndex][var_22_0] = var_22_4

			return var_22_4
		end,
		setTimeRemove = function(self)
			if self.hp > 0 then
				self.hp = 0
			end

			pg.CriMgr.GetInstance():PlaySoundEffect_V3(LaunchBallGameVo.SFX_ENEMY_REMOVE)

			if self:getBuff(LaunchBallGameConst.enemy_buff_boom) then
				self:playEffectAnim("Bomb", var_0_15[self:getColor()].anim_name, 0.2)
			end

			self:stopAnim(false)
			self:playAnimation("Remove")

			self.timeToRemove = var_0_2

			return
		end,
		playEffectAnim = function(self, arg_24_1, arg_24_2, arg_24_3)
			local var_24_0 = findTF(self._effectTf, arg_24_1)

			setActive(var_24_0, true)
			GetComponent(var_24_0, typeof(Animator)):Play(arg_24_2)
			table.insert(self._playEffects, {
				tf = var_24_0,
				time = arg_24_3
			})

			return
		end,
		getTimeRemove = function(self)
			return self.timeToRemove
		end,
		setPosIndex = function(self, arg_26_1)
			self._tf.anchoredPosition = self.points[arg_26_1].pos
			self.pointIndex = arg_26_1
			self.distance = self.points[arg_26_1].distance

			return
		end,
		setDistance = function(self, arg_27_1)
			self.distance = arg_27_1
			self._tf.anchoredPosition = self:getPosByDistance(self.distance)

			return
		end,
		getDistance = function(self)
			return self.distance
		end,
		getRemoveFlag = function(self)
			return self.removeFlag
		end,
		setLastLayer = function(self, arg_30_1)
			return self._tf:SetSiblingIndex(arg_30_1)
		end,
		getFinish = function(self)
			return self.distance >= self.points[#self.points].distance
		end,
		clear = function(arg_32_0)
			arg_32_0.finalFlag = false
			arg_32_0.removeFlag = false
			arg_32_0.timeToRemove = nil
			arg_32_0.buffType = nil

			return
		end
	}

	var_1_0:ctor()

	return var_1_0
end

LaunchBallEnemy.EnemyDistanceData = {}

function LaunchBallEnemy:Ctor(arg_33_1, arg_33_2, arg_33_3, arg_33_4)
	self._enemyContent = arg_33_1
	self._lineContent = arg_33_2
	self._tpl = arg_33_3
	self._eventCall = arg_33_4
	self._enemyTpl = findTF(self._tpl, "Enemy")
	self.enemyDatas = {}

	for iter_33_0, iter_33_1 in pairs(LaunchBallGameConst.enemy_data) do
		table.insert(self.enemyDatas, {
			animator = LoadAny(LaunchBallGameVo.ui_atlas, iter_33_1.name, typeof(RuntimeAnimatorController)),
			data = iter_33_1
		})
	end

	self.enemyRule = Clone(LaunchBallGameConst.enemy_create_rule)
	self.enemysList = {}
	self.enemyPool = {}
	self.colliderTestTf = findTF(self._enemyContent, "colliderTest")

	setActive(self.colliderTestTf, false)

	return
end

function LaunchBallEnemy:start()
	self.moveSpeed = LaunchBallGameVo.gameRoundData.speed
	LaunchBallEnemy.EnemyDistanceData = {}
	self.gameRoundData = LaunchBallGameVo.gameRoundData
	self._enemyContent.sizeDelta = LaunchBallGameConst.enemy_round_bound[self.gameRoundData.round_bound]
	self.roundDatas = Clone(LaunchBallGameConst.round_enemy[self.gameRoundData.round_enemy])
	self.lineData = Clone(LaunchBallGameConst.map_data[self.gameRoundData.map])
	self.enemyBuffs = Clone(LaunchBallGameConst.enemy_round_buff[self.gameRoundData.enemy_buff])

	self:createRoundData()

	self.currentEnemyRule = self:getEnemyRule()

	if self.lineTf then
		setActive(self.lineTf, false)
	end

	self.lineTf = findTF(self._lineContent, self.lineData.line)

	setActive(self.lineTf, true)

	for iter_34_0, iter_34_1 in ipairs(self.enemysList) do
		for iter_34_2 = #iter_34_1, 1, -1 do
			self:returnEnemy(table.remove(iter_34_1, iter_34_2))
		end
	end

	self.pointsList = {}
	self.enemysList = {}

	local var_34_0 = findTF(self.lineTf, "ad/points")

	if var_34_0 then
		table.insert(self.pointsList, (self:createPoints(var_34_0)))
		table.insert(self.enemysList, {})

		LaunchBallEnemy.EnemyDistanceData[1] = {}
	end

	local var_34_1 = findTF(self.lineTf, "ad/points1")

	if var_34_1 then
		table.insert(self.pointsList, (self:createPoints(var_34_1)))
		table.insert(self.enemysList, {})

		LaunchBallEnemy.EnemyDistanceData[2] = {}
	end

	for iter_34_3 = 1, #self.pointsList do
		self:createRandomEnemy(iter_34_3, self.pointsList[iter_34_3], self.enemysList[iter_34_3], 1, 0, true)
	end

	self.backEnemyFlag = false
	self.backEnemyTime = nil
	self.seriesCount = 1
	self.lastPointDistance = nil

	return
end

LaunchBallEnemy.moveCount = 0

function LaunchBallEnemy:step()
	LaunchBallEnemy.moveCount = 0

	self:checkEnemyRuleUpdate()
	self:checkEnemyDataUpdate()
	self:checkCreateEnemy()
	self:checkRemoveEnemy()
	self:moveEnmey()
	self:checkEnemyQuick()
	self:checkEnemyBack()
	self:updateEnemyRemoveFlag()
	self:checkEnemySplit()
	self:updateEnemyVo()
	self:checkEnemyFinal()
	self:updateEnemyData()

	return
end

function LaunchBallEnemy:updateEnemyData()
	if not self.lastPointDistance then
		self.lastPointDistance = {}

		for iter_36_0 = 1, #self.pointsList do
			table.insert(self.lastPointDistance, self.pointsList[iter_36_0][#self.pointsList[iter_36_0]].distance)
		end
	end

	local var_36_0 = {}

	for iter_36_1 = 1, #self.enemysList do
		if self.enemysList[iter_36_1] and #self.enemysList[iter_36_1] > 0 then
			table.insert(var_36_0, math.floor(self.enemysList[iter_36_1][#self.enemysList[iter_36_1]]:getDistance() / self.lastPointDistance[iter_36_1] * 10))
		end
	end

	LaunchBallGameVo.enemyToEndRate = var_36_0

	return
end

function LaunchBallEnemy:checkEnemyDataUpdate()
	if self.currentEnemyRule == nil then
		self.currentEnemyRule = self:getEnemyRule()
	end

	return
end

function LaunchBallEnemy:checkTargetScore()
	if LaunchBallGameVo.gameRoundData.target and LaunchBallGameVo.scoreNum >= LaunchBallGameVo.gameRoundData.target then
		return true
	end

	return false
end

function LaunchBallEnemy:checkCreateEnemy()
	if self:checkTargetScore() then
		return
	end

	for iter_39_0 = 1, #self.enemysList do
		if #self.enemysList[iter_39_0] > 0 then
			if self.enemysList[iter_39_0][1]:getDistance() > var_0_6 then
				self:createRandomEnemy(iter_39_0, self.pointsList[iter_39_0], self.enemysList[iter_39_0], 1, 0, true)

				break
			end
		else
			self:createRandomEnemy(iter_39_0, self.pointsList[iter_39_0], self.enemysList[iter_39_0], 1, 0, true)

			break
		end
	end

	return
end

function LaunchBallEnemy:checkRemoveEnemy()
	for iter_40_0, iter_40_1 in ipairs(self.enemysList) do
		for iter_40_2 = #iter_40_1, 1, -1 do
			iter_40_1[iter_40_2]:step()

			if iter_40_1[iter_40_2]:getRemoveFlag() then
				local var_40_1 = iter_40_1[iter_40_2]:getBuff()

				if var_40_1 then
					self:appearEnemyBuff(var_40_1, iter_40_2, iter_40_1[iter_40_2], iter_40_1)
				end

				self:returnEnemy(table.remove(iter_40_1, iter_40_2))
			end
		end
	end

	if self.timeRemoveAll and self.timeRemoveAll > 0 then
		self.timeRemoveAll = self.timeRemoveAll - LaunchBallGameVo.deltaTime

		if self.timeRemoveAll <= 0 then
			local var_40_3 = 0

			for iter_40_3, iter_40_4 in ipairs(self.enemysList) do
				for iter_40_5 = #iter_40_4, 1, -1 do
					if not iter_40_4[iter_40_5]:getRemoveFlag() then
						iter_40_4[iter_40_5]:setTimeRemove()

						var_40_3 = var_40_3 + 1

						self._eventCall(LaunchBallGameScene.SPILT_ENEMY_SCORE, {
							num = LaunchBallGameVo.GetScore(1, 1)
						})
					end
				end
			end

			LaunchBallGameVo.UpdateGameResultData(LaunchBallGameVo.result_skill_count, var_40_3)

			self.timeRemoveAll = nil
		end
	end

	return
end

function LaunchBallEnemy:appearEnemyBuff(arg_41_1, arg_41_2, arg_41_3, arg_41_4)
	if arg_41_1 == LaunchBallGameConst.enemy_buff_slow then
		self.slowTime = LaunchBallGameConst.enemy_buff_data[arg_41_1].time

		if LaunchBallGameVo.GetBuff(LaunchBallPlayerControl.buff_time_max) then
			self.slowTime = self.slowTime * 1.5

			LaunchBallGameVo.AddGameResultData(LaunchBallGameVo.result_use_pass_skill, 1)

			if self.enemyStopTime and self.enemyStopTime > 0 then
				self.enemyStopTime = self.enemyStopTime + 3
			end
		end
	elseif arg_41_1 == LaunchBallGameConst.enemy_buff_back then
		self.backEnemyTime = LaunchBallGameConst.enemy_buff_data[arg_41_1].time
		self.backSpeed = var_0_10
		self.moveBackIndex = #arg_41_4

		if LaunchBallGameVo.GetBuff(LaunchBallPlayerControl.buff_time_max) then
			self.backEnemyTime = self.backEnemyTime * 1.3

			LaunchBallGameVo.AddGameResultData(LaunchBallGameVo.result_use_pass_skill, 1)
		end
	elseif arg_41_1 == LaunchBallGameConst.enemy_buff_boom then
		local var_41_0 = arg_41_3:getDistance()

		for iter_41_0 = 1, #arg_41_4 do
			if not arg_41_4[iter_41_0]:getRemoveFlag() and LaunchBallGameConst.enemy_buff_data[arg_41_1].distance >= math.abs(arg_41_4[iter_41_0]:getDistance() - var_41_0) then
				arg_41_4[iter_41_0]:setTimeRemove()
				self._eventCall(LaunchBallGameScene.SPILT_ENEMY_SCORE, {
					num = LaunchBallGameVo.GetScore(1, 1)
				})
			end
		end
	elseif arg_41_1 == LaunchBallGameConst.enemy_buff_concentrate then
		self._eventCall(LaunchBallGameScene.CONCENTRATE_TRIGGER, LaunchBallGameConst.enemy_buff_data[arg_41_1])
	end

	return
end

function LaunchBallEnemy:moveEnmey()
	local var_42_0

	if self.enemyStopTime and self.enemyStopTime > 0 then
		self.enemyStopTime = self.enemyStopTime - LaunchBallGameVo.deltaTime

		if self.enemyStopTime <= 0 then
			self.enemyStopTime = nil

			self:stopEnemysAnim(false)
		end

		LaunchBallGameVo.enemyStopTime = self.enemyStopTime
	end

	if self.enemyStopTime and self.enemyStopTime > 0 then
		return
	end

	if self.backEnemyTime and self.backEnemyTime > 0 then
		self.backEnemyTime = self.backEnemyTime - LaunchBallGameVo.deltaTime

		if self.backEnemyTime <= 0 then
			self.backEnemyTime = nil
		end

		var_42_0 = self.backSpeed * LaunchBallGameVo.deltaTime
	else
		var_42_0 = self.moveSpeed * LaunchBallGameVo.deltaTime
	end

	if self.slowTime and self.slowTime > 0 then
		var_42_0 = var_42_0 / 3
		self.slowTime = self.slowTime - LaunchBallGameVo.deltaTime

		if self.slowTime < 0 then
			self.slowTime = nil
		end
	end

	for iter_42_0, iter_42_1 in ipairs(self.enemysList) do
		local var_42_2 = 0

		if var_42_0 > 0 then
			for iter_42_2 = 1, #iter_42_1 do
				local var_42_3 = iter_42_2 < #iter_42_1 and iter_42_1[iter_42_2]:getDistance() < var_0_6 and iter_42_1[iter_42_2 + 1]:getDistance() < var_0_6

				if iter_42_2 > 1 and var_42_2 == 0 then
					if iter_42_1[iter_42_2]:getDistance() - iter_42_1[iter_42_2 - 1]:getDistance() > var_0_6 then
						var_42_2 = iter_42_2
						var_42_3 = true
					elseif iter_42_1[iter_42_2]:getRemoveFlag() then
						var_42_2 = iter_42_2
						var_42_3 = true
					end
				elseif var_42_2 ~= 0 and var_42_2 <= iter_42_2 then
					var_42_3 = true
				end

				if not var_42_3 then
					iter_42_1[iter_42_2]:move(var_42_0)
				end
			end
		end

		if var_42_0 < 0 then
			for iter_42_3 = #iter_42_1, 1, -1 do
				local var_42_4 = false

				if iter_42_3 <= self.moveBackIndex and var_42_2 == 0 then
					if iter_42_3 > 1 and iter_42_1[iter_42_3]:getDistance() - iter_42_1[iter_42_3 - 1]:getDistance() > var_0_6 + var_0_14 then
						var_42_2 = iter_42_3 - 1
					end
				else
					var_42_4 = var_42_2 ~= 0 and iter_42_3 <= var_42_2 and true or true
				end

				if not var_42_4 then
					iter_42_1[iter_42_3]:move(var_42_0)
				end
			end
		end
	end

	return
end

function LaunchBallEnemy:checkEnemyQuick()
	if self.backFlag then
		return
	end

	self.quickFlag = false

	for iter_43_0, iter_43_1 in ipairs(self.enemysList) do
		local var_43_0 = 0

		for iter_43_2 = 1, #iter_43_1 do
			if iter_43_2 <= #iter_43_1 - 1 then
				if iter_43_1[iter_43_2 + 1]:getDistance() > var_0_6 and iter_43_1[iter_43_2 + 1]:getDistance() - iter_43_1[iter_43_2]:getDistance() < var_0_6 - var_0_14 then
					var_43_0 = iter_43_2 + 1
					self.quickFlag = true

					break
				end
			end
		end

		if var_43_0 ~= 0 then
			for iter_43_3 = 1, #iter_43_1 do
				if var_43_0 <= iter_43_3 then
					if iter_43_1[iter_43_3]:getDistance() - iter_43_1[iter_43_3 - 1]:getDistance() < var_0_6 - var_0_14 then
						iter_43_1[iter_43_3]:move(var_0_12 * LaunchBallGameVo.deltaTime)
					else
						break
					end
				end
			end
		end
	end

	return
end

function LaunchBallEnemy:checkEnemyBack()
	self.backFlag = false

	if not self.quickFlag then
		for iter_44_0, iter_44_1 in ipairs(self.enemysList) do
			local var_44_0 = 0

			for iter_44_2 = 1, #iter_44_1 do
				if iter_44_2 > 1 and var_44_0 == 0 and iter_44_1[iter_44_2]:getDistance() - iter_44_1[iter_44_2 - 1]:getDistance() > var_0_6 + var_0_14 and iter_44_1[iter_44_2]:getSplitFlag() and iter_44_1[iter_44_2]:getColor() == iter_44_1[iter_44_2 - 1]:getColor() then
					var_44_0 = iter_44_2
					self.backEnemyFlag = self.backEnemyFlag or true
				end
			end

			if var_44_0 ~= 0 then
				self.backFlag = true
				self.moveBackIndex = 0

				for iter_44_3 = 1, #iter_44_1 do
					if iter_44_3 == var_44_0 then
						self.moveBackIndex = iter_44_3

						iter_44_1[iter_44_3]:move(var_0_13 * LaunchBallGameVo.deltaTime)
					elseif var_44_0 < iter_44_3 then
						if iter_44_1[iter_44_3]:getDistance() - iter_44_1[iter_44_3 - 1]:getDistance() < var_0_6 + var_0_14 then
							iter_44_1[iter_44_3]:move(var_0_13 * LaunchBallGameVo.deltaTime)

							self.moveBackIndex = iter_44_3
						else
							break
						end
					end
				end
			end
		end
	end

	if self.backFlag and self.backEnemyFlag then
		self.backEnemyFlag = false
		self.backEnemyTime = var_0_11
		self.backSpeed = var_0_9
	end

	return
end

function LaunchBallEnemy:updateEnemyRemoveFlag()
	self.enemyTimeRemoveFlag = false

	for iter_45_0, iter_45_1 in ipairs(self.enemysList) do
		for iter_45_2 = 1, #iter_45_1 do
			if iter_45_1[iter_45_2]:getTimeRemove() then
				self.enemyTimeRemoveFlag = true
			end
		end
	end

	return
end

function LaunchBallEnemy:checkEnemySplit()
	if not self.enemyTimeRemoveFlag and not self.backFlag and not self.quickFlag and not self.backEnemyFlag then
		for iter_46_0, iter_46_1 in ipairs(self.enemysList) do
			for iter_46_2 = 1, #iter_46_1 do
				if iter_46_1[iter_46_2]:getSplitFlag() then
					local var_46_1, var_46_2, var_46_3 = self:checkSplit(iter_46_2, iter_46_1)

					iter_46_1[iter_46_2]:setSplitFlag(false)

					if var_46_1 >= 3 or var_46_2 then
						self.seriesCount = self.seriesCount + 1

						if self.splitFireIndex and self.splitFireIndex + 1 >= self.fireIndex then
							LaunchBallGameVo.AddGameResultData(LaunchBallGameVo.result_series_count, 1)

							self.seriesCombat = not self.seriesCombat and 1 or self.seriesCombat + 1
						else
							self.seriesCombat = 0
						end

						if self.amuletOverFlag then
							LaunchBallGameVo.AddGameResultData(LaunchBallGameVo.result_over_count, 1)
						end

						self.splitFireIndex = self.fireIndex

						break
					end

					self.seriesCount = 1
					self.seriesCombat = 0

					break
				end
			end
		end
	end

	return
end

function LaunchBallEnemy:checkEnemyFinal()
	if self:checkTargetScore() then
		local var_47_0 = 0

		for iter_47_0, iter_47_1 in ipairs(self.enemysList) do
			var_47_0 = var_47_0 + #iter_47_1
		end

		if var_47_0 == 0 then
			self._eventCall(LaunchBallGameScene.ENEMY_FINISH)

			return
		end
	end

	for iter_47_2, iter_47_3 in ipairs(self.enemysList) do
		if iter_47_3 and #iter_47_3 > 0 and iter_47_3[#iter_47_3]:getFinish() then
			self._eventCall(LaunchBallGameScene.ENEMY_FINISH)

			return
		end
	end

	return
end

function LaunchBallEnemy:updateEnemyVo()
	local var_48_0 = {}

	for iter_48_0, iter_48_1 in ipairs(self.enemysList) do
		for iter_48_2 = 1, #iter_48_1 do
			local var_48_1 = iter_48_1[iter_48_2]:getColor()

			if not table.contains(var_48_0, var_48_1) then
				table.insert(var_48_0, var_48_1)

				if #var_48_0 >= LaunchBallGameConst.color_total then
					LaunchBallGameVo.enemyColors = var_48_0

					return
				end
			end
		end
	end

	LaunchBallGameVo.enemyColors = var_48_0

	return
end

function LaunchBallEnemy:updateGameResultSplitCount(arg_49_1, arg_49_2)
	LaunchBallGameVo.AddGameResultData(LaunchBallGameVo.result_split_count, 1)

	if arg_49_2 > 1 then
		LaunchBallGameVo.AddGameResultData(LaunchBallGameVo.result_series_count, 1)
		LaunchBallGameVo.AddGameResultData(LaunchBallGameVo.result_mix_count, 1)
	end

	if arg_49_1 > 3 then
		LaunchBallGameVo.AddGameResultData(LaunchBallGameVo.result_many_count, 1)
	end

	return
end

function LaunchBallEnemy:checkSplit(arg_50_1, arg_50_2)
	local var_50_0 = arg_50_2[arg_50_1]:getColor()
	local var_50_1 = 1
	local var_50_2 = {
		arg_50_2[arg_50_1]
	}
	local var_50_3 = false

	if arg_50_1 > 1 then
		for iter_50_0 = arg_50_1 - 1, 1, -1 do
			if arg_50_2[iter_50_0]:getColor() == var_50_0 then
				table.insert(var_50_2, arg_50_2[iter_50_0])

				var_50_1 = var_50_1 + 1
			else
				break
			end
		end
	end

	local var_50_4

	if arg_50_1 < #arg_50_2 then
		for iter_50_1 = arg_50_1 + 1, #arg_50_2 do
			if arg_50_2[iter_50_1]:getColor() == var_50_0 then
				table.insert(var_50_2, arg_50_2[iter_50_1])

				var_50_1 = var_50_1 + 1
			else
				var_50_4 = arg_50_2[iter_50_1]

				break
			end
		end
	end

	if var_50_1 >= 3 then
		var_50_3 = true
	end

	if var_50_1 >= 3 and not var_50_3 then
		print("")
	end

	if var_50_3 and var_50_4 then
		var_50_4:setSplitFlag(true)
	end

	if var_50_3 then
		for iter_50_2 = 1, #var_50_2 do
			var_50_2[iter_50_2]:hit()
		end

		if self._eventCall then
			self._eventCall(LaunchBallGameScene.SPILT_ENEMY_SCORE, {
				split = true,
				num = LaunchBallGameVo.GetScore(var_50_1, self.seriesCount, self.amuletOverFlag),
				count = var_50_1
			})

			if LaunchBallGameVo.GetBuff(LaunchBallPlayerControl.buff_time_max) and self.enemyStopTime and self.enemyStopTime > 0 then
				LaunchBallGameVo.AddGameResultData(LaunchBallGameVo.result_skill_count, var_50_1)
			end
		end

		self:updateGameResultSplitCount(var_50_1, self.seriesCount)

		if not var_50_4 then
			self.seriesCount = 0
		end
	end

	return var_50_1, var_50_3
end

function LaunchBallEnemy:createPoints(arg_51_1)
	local var_51_0 = {}
	local var_51_1 = 0
	local var_51_2 = GetComponent(arg_51_1, "EdgeCollider2D").points:ToTable()

	for iter_51_0, iter_51_1 in ipairs(var_51_2) do
		local var_51_3 = Vector2(0, 0)
		local var_51_4 = Vector2(0, 0)
		local var_51_6 = 0

		if iter_51_0 > 1 then
			var_51_1 = var_51_1 + math.sqrt(math.pow(var_51_2[iter_51_0].x - var_51_2[iter_51_0 - 1].x, 2) + math.pow(var_51_2[iter_51_0].y - var_51_2[iter_51_0 - 1].y, 2))
		end

		if iter_51_0 < #var_51_2 then
			local var_51_7 = math.atan(math.abs(var_51_2[iter_51_0 + 1].y - var_51_2[iter_51_0].y) / math.abs(var_51_2[iter_51_0 + 1].x - var_51_2[iter_51_0].x))

			var_51_6 = math.atan2(var_51_2[iter_51_0 + 1].y - var_51_2[iter_51_0].y, var_51_2[iter_51_0 + 1].x - var_51_2[iter_51_0].x) * math.rad2Deg

			local var_51_8 = var_51_2[iter_51_0 + 1].y > var_51_2[iter_51_0].y and 1 or -1

			var_51_4.x = var_51_2[iter_51_0 + 1].x > var_51_2[iter_51_0].x and 1 or -1
			var_51_4.y = var_51_8
			var_51_3.x = math.cos(var_51_7) * (var_51_2[iter_51_0 + 1].x > var_51_2[iter_51_0].x and 1 or -1)
			var_51_3.y = math.sin(var_51_7) * var_51_8
		elseif iter_51_0 == #var_51_2 then
			local var_51_9 = math.atan(math.abs(var_51_2[iter_51_0].y - var_51_2[iter_51_0 - 1].y) / math.abs(var_51_2[iter_51_0].x - var_51_2[iter_51_0 - 1].x))

			var_51_6 = math.atan2(var_51_2[iter_51_0].y - var_51_2[iter_51_0 - 1].y, var_51_2[iter_51_0].x - var_51_2[iter_51_0 - 1].x) * math.rad2Deg

			local var_51_10 = var_51_2[iter_51_0].y > var_51_2[iter_51_0 - 1].y and 1 or -1

			var_51_4.x = var_51_2[iter_51_0].x > var_51_2[iter_51_0 - 1].x and 1 or -1
			var_51_4.y = var_51_10
			var_51_3.x = math.cos(var_51_9) * (var_51_2[iter_51_0].x > var_51_2[iter_51_0 - 1].x and 1 or -1)
			var_51_3.y = math.sin(var_51_9) * var_51_10
		end

		table.insert(var_51_0, {
			pos = iter_51_1,
			distance = var_51_1,
			move = var_51_3,
			direct = var_51_4,
			angle = var_51_6
		})
	end

	return var_51_0
end

function LaunchBallEnemy:createEnemy(arg_52_1, arg_52_2, arg_52_3, arg_52_4, arg_52_5)
	local var_52_0 = self:getOrCreateEnemy()

	var_52_0:setData(arg_52_1, arg_52_2)
	var_52_0:setPoints(arg_52_3)
	var_52_0:setActive(true)
	var_52_0:setSplitFlag(false)

	if arg_52_5 then
		var_52_0:setDistance(arg_52_5)
	else
		var_52_0:setDistance(0)
	end

	table.insert(arg_52_4, var_52_0)
	self:sortEnemys(arg_52_4)

	return var_52_0
end

function LaunchBallEnemy:createRandomEnemy(arg_53_1, arg_53_2, arg_53_3, arg_53_4, arg_53_5, arg_53_6)
	local var_53_0 = self:getEnemyDataByRule()

	if not var_53_0 then
		return
	end

	local var_53_1 = self:getOrCreateEnemy()

	var_53_1:setData(arg_53_1, var_53_0)
	var_53_1:setBuff((self:getEnemyBuff()))
	var_53_1:setPoints(arg_53_2)
	var_53_1:setActive(true)

	if arg_53_4 and arg_53_4 ~= 0 then
		var_53_1:setPosIndex(arg_53_4)
	elseif arg_53_5 then
		var_53_1:setDistance(arg_53_5)
	end

	table.insert(arg_53_3, var_53_1)
	self:sortEnemys(arg_53_3)

	return var_53_1
end

function LaunchBallEnemy:getEnemyBuff()
	local var_54_0 = {}

	for iter_54_0 = 1, #self.enemyBuffs.buffs do
		local var_54_1 = self.enemyBuffs.buffs[iter_54_0]
		local var_54_2 = true

		if self.enemyBuffs.buffs[iter_54_0].type == LaunchBallGameConst.enemy_buff_back then
			if self:getEnemyByBuff(LaunchBallGameConst.enemy_buff_slow) then
				var_54_2 = false
			end
		elseif var_54_1.type == LaunchBallGameConst.enemy_buff_slow and self:getEnemyByBuff(LaunchBallGameConst.enemy_buff_back) then
			var_54_2 = false
		end

		if var_54_2 then
			local var_54_3 = var_54_1.rate[1]

			if LaunchBallGameVo.GetBuff(LaunchBallPlayerControl.buff_time_max) then
				if var_54_1.type == LaunchBallGameConst.enemy_buff_slow then
					var_54_3 = var_54_3 + 2
				elseif var_54_1.type == LaunchBallGameConst.enemy_buff_back then
					var_54_3 = var_54_3 + 2
				end
			end

			if var_54_3 >= math.random(1, var_54_1.rate[2]) then
				table.insert(var_54_0, var_54_1.type)
			end
		end
	end

	if #var_54_0 > 0 then
		return var_54_0[math.random(1, #var_54_0)]
	end

	return nil
end

function LaunchBallEnemy:getEnemyByBuff(arg_55_1)
	for iter_55_0 = 1, #self.enemysList do
		for iter_55_1 = #self.enemysList[iter_55_0], 1, -1 do
			if self.enemysList[iter_55_0][iter_55_1]:getBuff() == arg_55_1 then
				return self.enemysList[iter_55_0][iter_55_1]
			end
		end
	end

	return nil
end

function LaunchBallEnemy:getOrCreateEnemy()
	local var_56_0

	if #self.enemyPool > 0 then
		var_56_0 = table.remove(self.enemyPool, 1)
	else
		local var_56_1 = tf(instantiate(self._enemyTpl))

		setParent(var_56_1, self._enemyContent)

		var_56_0 = var_0_16(var_56_1)
	end

	return var_56_0
end

function LaunchBallEnemy:sortEnemys(arg_57_1)
	table.sort(arg_57_1, function(arg_58_0, arg_58_1)
		return arg_58_0:getDistance() < arg_58_1:getDistance()
	end)

	for iter_57_0 = 1, #arg_57_1 do
		arg_57_1[iter_57_0]:setLastLayer(iter_57_0 - 1)
	end

	return
end

function LaunchBallEnemy:returnEnemy(arg_59_1)
	arg_59_1:setActive(false)
	table.insert(self.enemyPool, arg_59_1)

	return
end

function LaunchBallEnemy:getEnemyDataByRule()
	self.currentEnemyRule = self.currentEnemyRule or self:getEnemyRule()

	if #var_0_1 > 0 then
		return self:getEnemyById(table.remove(var_0_1, 1))
	end

	if self.currentEnemyRule then
		self.currentEnemyRule.count = self.currentEnemyRule.count - 1

		if self.currentEnemyRule.count <= 0 then
			self.currentEnemyRule = nil
		end

		return self:getEnemyById(self.currentEnemyRule.single and self.currentEnemyRule.singleId or self.currentEnemyRule.enemys[math.random(1, #self.currentEnemyRule.enemys)])
	end

	return nil
end

function LaunchBallEnemy:getEnemyById(arg_61_1)
	for iter_61_0 = 1, #self.enemyDatas do
		if self.enemyDatas[iter_61_0].data.id == arg_61_1 then
			return self.enemyDatas[iter_61_0]
		end
	end

	print("找不到id = " .. arg_61_1 .. "的怪物")

	return nil
end

function LaunchBallEnemy:checkEnemyRuleUpdate()
	local var_62_0 = false

	for iter_62_0 = 1, #self.rounds do
		if LaunchBallGameVo.gameStepTime >= self.rounds[iter_62_0].time[2] then
			var_62_0 = true
		end
	end

	if var_62_0 then
		self:createRoundData()
	end

	return
end

function LaunchBallEnemy:getEnemysInBounds(arg_63_1, arg_63_2)
	local var_63_0 = self._enemyContent:InverseTransformPoint(arg_63_1)
	local var_63_1 = self._enemyContent:InverseTransformPoint(arg_63_2)

	self.colliderTestTf.anchoredPosition = var_63_1

	local var_63_2 = {}

	for iter_63_0 = 1, #self.enemysList do
		for iter_63_1 = #self.enemysList[iter_63_0], 1, -1 do
			local var_63_4 = self.enemysList[iter_63_0][iter_63_1]:getTf().anchoredPosition

			if var_63_4.x > var_63_0.x and var_63_4.x < var_63_1.x and var_63_4.y > var_63_0.y and var_63_4.y < var_63_1.y then
				table.insert(var_63_2, self.enemysList[iter_63_0][iter_63_1])
			end
		end
	end

	return var_63_2
end

function LaunchBallEnemy:getEnemyRule()
	local var_64_0
	local var_64_1 = math.random(0, self.maxWeight)
	local var_64_2

	for iter_64_0 = 1, #self.rounds do
		if not var_64_2 and var_64_1 <= self.rounds[iter_64_0].maxWeight then
			var_64_2 = self.rounds[iter_64_0].createId
		end
	end

	if var_64_2 then
		if not self.enemyRule[var_64_2] then
			print("create id not exit " .. var_64_2)
		end

		local var_64_3 = self.enemyRule[var_64_2].enemy_create.single

		var_64_0 = {
			id = self.enemyRule[var_64_2].id,
			count = self.enemyRule[var_64_2].enemy_create.count,
			enemys = self.enemyRule[var_64_2].enemy_create.enemys,
			single = var_64_3,
			singleId = (self.enemyRule[var_64_2].enemy_create.single or nil) and self.enemyRule[var_64_2].enemy_create.enemys[math.random(1, #self.enemyRule[var_64_2].enemy_create.enemys)]
		}
	end

	return var_64_0
end

function LaunchBallEnemy:createRoundData()
	local var_65_0 = 0

	self.rounds = {}

	for iter_65_0 = 1, #self.roundDatas do
		if LaunchBallGameVo.gameStepTime >= self.roundDatas[iter_65_0].time[1] and LaunchBallGameVo.gameStepTime <= self.roundDatas[iter_65_0].time[2] then
			var_65_0 = var_65_0 + self.roundDatas[iter_65_0].weight

			table.insert(self.rounds, {
				time = self.roundDatas[iter_65_0].time,
				weight = self.roundDatas[iter_65_0].weight,
				maxWeight = var_65_0,
				createId = self.roundDatas[iter_65_0].create_id
			})
		end
	end

	self.maxWeight = var_65_0

	return
end

function LaunchBallEnemy:checkAmulet(arg_66_1)
	self.fireIndex = arg_66_1.fireIndex

	for iter_66_0 = 1, #self.enemysList do
		local var_66_2 = self.enemysList[iter_66_0]

		for iter_66_1 = #self.enemysList[iter_66_0], 1, -1 do
			local var_66_3, var_66_4 = var_66_2[iter_66_1]:checkWorldInRect(arg_66_1.tf.position)

			if var_66_4 and var_66_4 < var_0_4 then
				arg_66_1.overCount = arg_66_1.overCount + 1
			end

			if var_66_3 ~= 0 then
				self.amuletOverFlag = false

				if arg_66_1.concentrate then
					if not var_66_2[iter_66_1]:getTimeRemove() then
						var_66_2[iter_66_1]:setTimeRemove()

						if self._eventCall then
							self._eventCall(LaunchBallGameScene.SPILT_ENEMY_SCORE, {
								num = LaunchBallGameVo.GetScore(1, 1)
							})
						end

						if LaunchBallGameVo.GetBuff(LaunchBallPlayerControl.buff_time_max) and self.enemyStopTime and self.enemyStopTime > 0 then
							LaunchBallGameVo.AddGameResultData(LaunchBallGameVo.result_skill_count, 1)
						end
					end

					return false
				else
					local var_66_5 = var_66_2[iter_66_1]:getDistance()

					var_66_5 = var_66_3 == 1 and var_66_5 + var_0_7 or var_66_5 - var_0_7

					if arg_66_1.overCount >= 2 then
						self.amuletOverFlag = true
					end

					local var_66_7 = self:createEnemy(iter_66_0, self:getEnemyByColor(arg_66_1.color, true), self.pointsList[iter_66_0], self.enemysList[iter_66_0], var_66_5)

					var_66_7:setSplitFlag(true)
					var_66_7:playAnimation("Spawn")

					if self:getBackBuff() or arg_66_1[LaunchBallGameConst.amulet_buff_back] then
						self:setBackTime(LaunchBallPlayerControl.buff_amulet_back_time, #var_66_2, var_0_9)
					end

					return true
				end
			end
		end
	end

	return false
end

function LaunchBallEnemy:checkPositionIn(arg_67_1)
	for iter_67_0 = 1, #self.enemysList do
		for iter_67_1 = #self.enemysList[iter_67_0], 1, -1 do
			if self.enemysList[iter_67_0][iter_67_1]:checkWorldInRect(arg_67_1) ~= 0 then
				return self.enemysList[iter_67_0][iter_67_1]
			end
		end
	end

	return false
end

function LaunchBallEnemy:checkWorldInEnemy(arg_68_1)
	for iter_68_0 = 1, #self.enemysList do
		for iter_68_1 = #self.enemysList[iter_68_0], 1, -1 do
			if self.enemysList[iter_68_0][iter_68_1]:checkWorldInCircle(arg_68_1) then
				return true
			end
		end
	end

	return false
end

function LaunchBallEnemy:getBackBuff()
	for iter_69_0 = 1, #LaunchBallGameVo.buffs do
		if LaunchBallGameVo.buffs[iter_69_0].data.type == LaunchBallPlayerControl.buff_amulet_back then
			return true
		end
	end

	return false
end

function LaunchBallEnemy:getEnemyByColor(arg_70_1, arg_70_2)
	for iter_70_0 = 1, #self.enemyDatas do
		if self.enemyDatas[iter_70_0].data.color == arg_70_1 and self.enemyDatas[iter_70_0].data.player == arg_70_2 then
			return self.enemyDatas[iter_70_0]
		end
	end

	return
end

function LaunchBallEnemy:setBackTime(arg_71_1, arg_71_2, arg_71_3)
	self.backEnemyTime = arg_71_1
	self.moveBackIndex = arg_71_2
	self.backSpeed = arg_71_3 or var_0_9

	return
end

function LaunchBallEnemy:eventCall(arg_72_1, arg_72_2)
	if arg_72_1 == LaunchBallGameScene.PLAYING_CHANGE then
		-- block empty
	elseif arg_72_1 == LaunchBallGameScene.FIRE_AMULET then
		-- block empty
	elseif arg_72_1 == LaunchBallGameScene.SPLIT_ALL_ENEMYS then
		self.timeRemoveAll = arg_72_2.time
	elseif arg_72_1 == LaunchBallGameScene.STOP_ENEMY_TIME then
		self.enemyStopTime = arg_72_2.time

		self:stopEnemysAnim(true)
	elseif arg_72_1 == LaunchBallGameScene.SLASH_ENEMY then
		-- block empty
	end

	return
end

function LaunchBallEnemy:stopEnemysAnim(arg_73_1)
	for iter_73_0 = 1, #self.enemysList do
		for iter_73_1 = #self.enemysList[iter_73_0], 1, -1 do
			self.enemysList[iter_73_0][iter_73_1]:stopAnim(arg_73_1)
		end
	end

	return
end

function LaunchBallEnemy:press(arg_74_1)
	if arg_74_1 == KeyCode.J then
		-- block empty
	end

	return
end

function LaunchBallEnemy:clear()
	return
end

return LaunchBallEnemy
