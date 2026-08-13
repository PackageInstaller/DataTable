class = var_0_10000

local var_0_0 = var_0_10000("LaunchBallEnemy")
local var_0_1 = {}
local var_0_2 = 0.35
local var_0_3 = 70
local var_0_4 = 100
local var_0_5 = 80
local var_0_6 = 80
local var_0_7 = 50
local var_0_8 = {
	{
		0,
		60
	},
	{
		60,
		70
	},
	{
		120,
		80
	},
	{
		180,
		90
	},
	{
		240,
		100
	}
}
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
		ctor = function(arg_2_0)
			arg_2_0._tf = arg_1_0
			GetComponent = var_1
			findTF = var_2_10002

			local var_2_0 = var_2_10002(arg_2_0._tf, "ad/anim")

			typeof = var_3
			Animator = var_4
			arg_2_0._animator = var_1(var_2_0, var_3(var_4))
			findTF = var_1
			arg_2_0.angleTf = var_1(arg_2_0._tf, "ad/angle")
			GetComponent = var_1
			findTF = var_2

			local var_2_1 = var_2(arg_2_0._tf, "ad/angle/left")

			typeof = var_3

			local var_2_2 = var_1(var_2_1, var_3("UnityEngine.PolygonCollider2D"))

			arg_2_0.leftBoundPoints = var_1.ToTable(var_2_2)
			GetComponent = var_1
			findTF = var_2_2

			local var_2_3 = var_2_2(arg_2_0._tf, "ad/angle/right")

			typeof = var_3

			local var_2_4 = var_1(var_2_3, var_3("UnityEngine.PolygonCollider2D"))

			arg_2_0.rightBoundPoints = var_1.ToTable(var_2_4)
			Vector3 = var_1
			arg_2_0.localRotation = var_1(0, 0, 0)
			findTF = var_1
			arg_2_0.circlePos = var_1(arg_2_0._tf, "ad/angle/circle").anchoredPosition

			if not arg_2_0.buffIcon then
				findTF = var_1
				arg_2_0.buffIcon = var_1(arg_2_0._tf, "ad/iconEffect")
			end

			findTF = var_1
			arg_2_0._effectTf = var_1(arg_2_0._tf, "ad/effect")
			arg_2_0._playEffects = {}

			return
		end,
		setData = function(arg_3_0, arg_3_1, arg_3_2)
			arg_3_0:clear()

			arg_3_0.enemyIndex = arg_3_1
			arg_3_0._animator.runtimeAnimatorController = arg_3_2.animator
			arg_3_0.data = arg_3_2
			arg_3_0.hp = arg_3_2.data.hp
			arg_3_0.overSplitFlag = false

			for iter_3_0 = 0, arg_3_0.buffIcon.childCount - 1 do
				local var_3_0 = arg_3_0.buffIcon

				var_2_10007 = var_2_10007.GetChild(var_3_0, iter_3_0)
				setActive = var_3_0

				var_3_0(var_2_10007, false)
			end

			for iter_3_1 = #arg_3_0._playEffects, 1, -1 do
				setActive = var_2_10007

				var_2_10007(arg_3_0._playEffects[iter_3_1].tf, false)

				table = var_2_10007

				var_2_10007.remove(arg_3_0._playEffects, iter_3_1)
			end

			arg_3_0:stopAnim(false)

			return
		end,
		setBuff = function(arg_4_0, arg_4_1)
			arg_4_0.buffType = arg_4_1

			if arg_4_0.buffType then
				LaunchBallGameConst = var_2

				local var_4_0 = var_2.enemy_buff_data[arg_4_0.buffType].tpl

				for iter_4_0 = 0, arg_4_0.buffIcon.childCount - 1 do
					local var_4_1 = arg_4_0.buffIcon
					local var_4_2 = var_7.GetChild(var_4_1, iter_4_0)

					setActive = var_4_1

					var_4_1(var_4_2, var_4_2.name == var_4_0)
				end
			else
				for iter_4_1 = 0, arg_4_0.buffIcon.childCount - 1 do
					local var_4_3 = arg_4_0.buffIcon
					local var_4_4 = var_6.GetChild(var_4_3, iter_4_1)

					setActive = var_4_3

					var_4_3(var_4_4, false)
				end
			end

			return
		end,
		getBuff = function(arg_5_0)
			return arg_5_0.buffType
		end,
		setPoints = function(arg_6_0, arg_6_1)
			arg_6_0.points = arg_6_1

			return
		end,
		hit = function(arg_7_0)
			if arg_7_0.buffType then
				local var_7_0 = arg_7_0.buffType

				LaunchBallGameConst = var_2_10002

				if var_7_0 == var_2_10002.enemy_buff_streng then
					arg_7_0:setBuff(nil)

					return
				end
			end

			arg_7_0.hp = arg_7_0.hp - 1

			if arg_7_0.hp <= 0 then
				arg_7_0:setTimeRemove()
			end

			return
		end,
		getTf = function(arg_8_0)
			return arg_8_0._tf
		end,
		playAnimation = function(arg_9_0, arg_9_1)
			local var_9_0 = arg_9_0._animator

			var_2.Play(var_9_0, arg_9_1)

			return
		end,
		setActive = function(arg_10_0, arg_10_1)
			setActive = var_2_10002

			var_2_10002(arg_10_0._tf, arg_10_1)

			return
		end,
		getColor = function(arg_11_0)
			return arg_11_0.data.data.color
		end,
		getSplitFlag = function(arg_12_0)
			return arg_12_0.splitFlag
		end,
		setSplitFlag = function(arg_13_0, arg_13_1)
			arg_13_0.splitFlag = arg_13_1

			return
		end,
		step = function(arg_14_0)
			if arg_14_0.timeToRemove then
				local var_14_0 = arg_14_0.timeToRemove

				if 0 < var_14_0 then
					local var_14_1 = arg_14_0.timeToRemove

					LaunchBallGameVo = var_2
					arg_14_0.timeToRemove = var_14_1 - var_2.deltaTime

					if arg_14_0.timeToRemove <= 0 then
						arg_14_0.timeToRemove = nil
						arg_14_0.removeFlag = true
					end
				end
			end

			if #arg_14_0._playEffects > 0 then
				for iter_14_0 = #arg_14_0._playEffects, 1, -1 do
					if arg_14_0._playEffects[iter_14_0].time then
						local var_14_2 = var_5.time

						LaunchBallGameVo = var_2_10007
						var_5.time = var_14_2 - var_2_10007.deltaTime
					end

					if var_5.time and var_5.time <= 0 then
						setActive = var_6

						var_6(var_5.tf, false)

						table = var_6

						var_6.remove(arg_14_0._playEffects, iter_14_0)
					end
				end
			end

			return
		end,
		move = function(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4)
			if arg_15_1 == 0 then
				return
			end

			var_0_0.moveCount = var_0_0.moveCount + 1
			arg_15_0.distance = arg_15_0.distance + arg_15_1

			if arg_15_0.distance < 0 then
				arg_15_0.distance = 0
			end

			if arg_15_2 and arg_15_3 and arg_15_4 then
				arg_15_0._tf.anchoredPosition = arg_15_2
				arg_15_0.pointIndex = arg_15_3
				arg_15_0.localRotation = arg_15_4
				arg_15_0.angleTf.localEulerAngles = arg_15_0.localRotation
			else
				local var_15_0 = arg_15_0:getPosByDistance(arg_15_0.distance)
				local var_15_1 = arg_15_0._tf.anchoredPosition

				var_15_1.x = var_15_0.x
				var_15_1.y = var_15_0.y
				arg_15_0._tf.anchoredPosition = var_15_1
				arg_15_0.pointIndex = var_15_0.index
				arg_15_0.localRotation.z = arg_15_0.points[arg_15_0.pointIndex].angle
				arg_15_0.angleTf.localEulerAngles = arg_15_0.localRotation
			end

			return
		end,
		getPosition = function(arg_16_0)
			return arg_16_0._tf.anchoredPosition
		end,
		getPointIndex = function(arg_17_0)
			return arg_17_0.pointIndex
		end,
		getLocalRotation = function(arg_18_0)
			return arg_18_0.localRotation
		end,
		stopAnim = function(arg_19_0, arg_19_1)
			if arg_19_1 then
				arg_19_0._animator.speed = 0
			else
				arg_19_0._animator.speed = 1
			end

			return
		end,
		checkWorldInCircle = function(arg_20_0, arg_20_1)
			local var_20_0 = arg_20_0.angleTf
			local var_20_1 = var_2.InverseTransformPoint(var_20_0, arg_20_1)

			math = var_20_0

			local var_20_2 = var_20_0.abs(var_20_1.x - arg_20_0.circlePos.x)

			if not (150 <= var_20_2) then
				math = var_20_2

				local var_20_3 = var_20_2.abs(var_20_1.y - arg_20_0.circlePos.y)

				if var_0_5 * 2 <= var_20_3 then
					return false
				end

				local var_20_4 = 0

				math = var_4

				local var_20_5 = var_4.sqrt

				math = var_5

				local var_20_6 = var_5.pow(var_20_1.x - arg_20_0.circlePos.x, 2)

				math = var_6

				if var_20_5(var_20_6 + var_6.pow(var_20_1.y - arg_20_0.circlePos.y, 2)) < var_0_5 then
					return true
				end

				return false
			end
		end,
		checkWorldInRect = function(arg_21_0, arg_21_1)
			local var_21_0 = arg_21_0.angleTf
			local var_21_1 = var_2.InverseTransformPoint(var_21_0, arg_21_1)
			local var_21_2 = 0

			math = var_4

			local var_21_3 = var_4.sqrt

			math = var_2_10005

			local var_21_4 = var_2_10005.pow(var_21_1.x - arg_21_0.circlePos.x, 2)

			math = var_6

			local var_21_5 = var_21_3(var_21_4 + var_6.pow(var_21_1.y - arg_21_0.circlePos.y, 2))

			if var_0_3 < var_21_5 then
				return var_21_2, nil
			end

			LaunchBallGameVo = var_5

			if var_5.PointInRect(var_21_1, arg_21_0.leftBoundPoints[1], arg_21_0.leftBoundPoints[2], arg_21_0.leftBoundPoints[3], arg_21_0.leftBoundPoints[4]) then
				var_21_2 = -1
			else
				LaunchBallGameVo = var_5

				if var_5.PointInRect(var_21_1, arg_21_0.rightBoundPoints[1], arg_21_0.rightBoundPoints[2], arg_21_0.rightBoundPoints[3], arg_21_0.rightBoundPoints[4]) then
					var_21_2 = 1
				end
			end

			return var_21_2, var_21_5
		end,
		getPosByDistance = function(arg_22_0, arg_22_1)
			math = var_2_10002

			local var_22_0 = var_2_10002.floor(arg_22_1 * 2)

			if var_0_0.EnemyDistanceData[arg_22_0.enemyIndex][var_22_0] then
				return var_0_0.EnemyDistanceData[arg_22_0.enemyIndex][var_22_0]
			end

			local var_22_1 = var_22_0 / 2

			if not arg_22_0.distancePosResult then
				Vector2 = var_4
				arg_22_0.distancePosResult = var_4(0, 0)
			end

			local var_22_2 = 1
			local var_22_3 = 0

			for iter_22_0 = 1, #arg_22_0.points do
				if var_22_1 >= arg_22_0.points[iter_22_0].distance then
					var_22_2 = iter_22_0

					if iter_22_0 < #arg_22_0.points then
						var_22_3 = var_22_1 - var_10.distance
						arg_22_0.distancePosResult.x = var_10.pos.x
						arg_22_0.distancePosResult.y = var_10.pos.y
					else
						arg_22_0.distancePosResult.x = var_10.pos.x
						arg_22_0.distancePosResult.y = var_10.pos.y
						var_22_3 = 0
					end
				else
					break
				end
			end

			if var_22_3 ~= 0 then
				local var_22_4 = arg_22_0.points[var_22_2].move

				arg_22_0.distancePosResult.x = arg_22_0.distancePosResult.x + var_22_4.x * var_22_3
				arg_22_0.distancePosResult.y = arg_22_0.distancePosResult.y + var_22_4.y * var_22_3
			end

			local var_22_5 = {
				x = arg_22_0.distancePosResult.x,
				y = arg_22_0.distancePosResult.y,
				index = var_22_2
			}

			var_0_0.EnemyDistanceData[arg_22_0.enemyIndex][var_22_0] = var_22_5

			return var_22_5
		end,
		setTimeRemove = function(arg_23_0)
			if arg_23_0.hp > 0 then
				arg_23_0.hp = 0
			end

			pg = var_1

			local var_23_0 = var_1.CriMgr.GetInstance()
			local var_23_1 = var_1.PlaySoundEffect_V3

			LaunchBallGameVo = var_2_10003

			var_23_1(var_23_0, var_2_10003.SFX_ENEMY_REMOVE)

			local var_23_2 = arg_23_0
			local var_23_3 = arg_23_0.getBuff

			LaunchBallGameConst = var_3

			if var_23_3(var_23_2, var_3.enemy_buff_boom) then
				local var_23_4 = arg_23_0:getColor()
				local var_23_5 = var_0_15[var_23_4].anim_name

				arg_23_0:playEffectAnim("Bomb", var_23_5, 0.2)
			end

			arg_23_0:stopAnim(false)
			arg_23_0:playAnimation("Remove")

			arg_23_0.timeToRemove = var_0_2

			return
		end,
		playEffectAnim = function(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
			findTF = var_2_10004

			local var_24_0 = var_2_10004(arg_24_0._effectTf, arg_24_1)

			setActive = var_5

			var_5(var_24_0, true)

			GetComponent = var_5

			local var_24_1 = var_24_0

			typeof = var_7
			Animator = var_2_10008

			local var_24_2 = var_5(var_24_1, var_7(var_2_10008))

			var_5.Play(var_24_2, arg_24_2)

			table = var_6

			var_6.insert(arg_24_0._playEffects, {
				tf = var_24_0,
				time = arg_24_3
			})

			return
		end,
		getTimeRemove = function(arg_25_0)
			return arg_25_0.timeToRemove
		end,
		setPosIndex = function(arg_26_0, arg_26_1)
			arg_26_0._tf.anchoredPosition = arg_26_0.points[arg_26_1].pos
			arg_26_0.pointIndex = arg_26_1
			arg_26_0.distance = arg_26_0.points[arg_26_1].distance

			return
		end,
		setDistance = function(arg_27_0, arg_27_1)
			arg_27_0.distance = arg_27_1
			arg_27_0._tf.anchoredPosition = arg_27_0:getPosByDistance(arg_27_0.distance)

			return
		end,
		getDistance = function(arg_28_0)
			return arg_28_0.distance
		end,
		getRemoveFlag = function(arg_29_0)
			return arg_29_0.removeFlag
		end,
		setLastLayer = function(arg_30_0, arg_30_1)
			local var_30_0 = arg_30_0._tf

			return var_2.SetSiblingIndex(var_30_0, arg_30_1)
		end,
		getFinish = function(arg_31_0)
			return arg_31_0.distance >= arg_31_0.points[#arg_31_0.points].distance
		end,
		clear = function(arg_32_0)
			arg_32_0.finalFlag = false
			arg_32_0.removeFlag = false
			arg_32_0.timeToRemove = nil
			arg_32_0.buffType = nil

			return
		end
	}

	var_2.ctor(var_1_0)

	return var_2
end

var_0_0.EnemyDistanceData = {}

function var_0_0.Ctor(arg_33_0, arg_33_1, arg_33_2, arg_33_3, arg_33_4)
	arg_33_0._enemyContent = arg_33_1
	arg_33_0._lineContent = arg_33_2
	arg_33_0._tpl = arg_33_3
	arg_33_0._eventCall = arg_33_4
	findTF = var_1_10005
	arg_33_0._enemyTpl = var_1_10005(arg_33_0._tpl, "Enemy")
	arg_33_0.enemyDatas = {}
	pairs = var_5
	LaunchBallGameConst = var_6

	for iter_33_0, iter_33_1 in var_5(var_6.enemy_data) do
		LoadAny = var_1_10010
		LaunchBallGameVo = var_1_10011
		var_1_10011 = var_1_10011.ui_atlas

		local var_33_0 = iter_33_1.name

		typeof = var_1_10013
		RuntimeAnimatorController = var_1_10014
		var_1_10010 = var_1_10010(var_1_10011, var_33_0, var_1_10013(var_1_10014))
		table = var_1_10011

		var_1_10011.insert(arg_33_0.enemyDatas, {
			animator = var_1_10010,
			data = iter_33_1
		})
	end

	Clone = var_5
	LaunchBallGameConst = var_6
	arg_33_0.enemyRule = var_5(var_6.enemy_create_rule)
	arg_33_0.enemysList = {}
	arg_33_0.enemyPool = {}
	findTF = var_5
	arg_33_0.colliderTestTf = var_5(arg_33_0._enemyContent, "colliderTest")
	setActive = var_5

	var_5(arg_33_0.colliderTestTf, false)

	return
end

function var_0_0.start(arg_34_0)
	LaunchBallGameVo = var_1_10001
	arg_34_0.moveSpeed = var_1_10001.gameRoundData.speed

	local var_34_0 = var_0_0

	var_34_0.EnemyDistanceData = {}
	LaunchBallGameVo = var_34_0
	arg_34_0.gameRoundData = var_34_0.gameRoundData

	local var_34_1 = arg_34_0._enemyContent

	LaunchBallGameConst = var_2
	var_34_1.sizeDelta = var_2.enemy_round_bound[arg_34_0.gameRoundData.round_bound]
	Clone = var_34_1
	LaunchBallGameConst = var_2
	arg_34_0.roundDatas = var_34_1(var_2.round_enemy[arg_34_0.gameRoundData.round_enemy])
	Clone = var_1
	LaunchBallGameConst = var_2
	arg_34_0.lineData = var_1(var_2.map_data[arg_34_0.gameRoundData.map])
	Clone = var_1
	LaunchBallGameConst = var_2
	arg_34_0.enemyBuffs = var_1(var_2.enemy_round_buff[arg_34_0.gameRoundData.enemy_buff])

	arg_34_0:createRoundData()

	arg_34_0.currentEnemyRule = arg_34_0:getEnemyRule()

	if arg_34_0.lineTf then
		setActive = var_1

		var_1(arg_34_0.lineTf, false)
	end

	findTF = var_1
	arg_34_0.lineTf = var_1(arg_34_0._lineContent, arg_34_0.lineData.line)
	setActive = var_1

	var_1(arg_34_0.lineTf, true)

	ipairs = var_1

	for iter_34_0, iter_34_1 in var_1(arg_34_0.enemysList) do
		for iter_34_2 = #iter_34_1, 1, -1 do
			local var_34_2 = arg_34_0
			local var_34_3 = arg_34_0.returnEnemy

			table = var_1_10012

			var_34_3(var_34_2, var_1_10012.remove(iter_34_1, iter_34_2))
		end
	end

	arg_34_0.pointsList = {}
	arg_34_0.enemysList = {}
	findTF = var_1

	local var_34_5

	if var_1(arg_34_0.lineTf, "ad/points") then
		local var_34_4 = arg_34_0

		var_34_5 = arg_34_0.createPoints(var_34_4, var_1)
		table = var_34_4

		var_34_4.insert(arg_34_0.pointsList, var_34_5)

		table = var_3

		var_3.insert(arg_34_0.enemysList, {})

		var_0_0.EnemyDistanceData[1] = {}
	end

	findTF = var_34_5

	if var_34_5(arg_34_0.lineTf, "ad/points1") then
		local var_34_6 = arg_34_0
		local var_34_7 = arg_34_0.createPoints(var_34_6, var_2)

		table = var_34_6

		var_34_6.insert(arg_34_0.pointsList, var_34_7)

		table = var_4

		var_4.insert(arg_34_0.enemysList, {})

		var_0_0.EnemyDistanceData[2] = {}
	end

	for iter_34_3 = 1, #arg_34_0.pointsList do
		arg_34_0:createRandomEnemy(iter_34_3, arg_34_0.pointsList[iter_34_3], arg_34_0.enemysList[iter_34_3], 1, 0, true)
	end

	arg_34_0.backEnemyFlag = false
	arg_34_0.backEnemyTime = nil
	arg_34_0.seriesCount = 1
	arg_34_0.lastPointDistance = nil

	return
end

var_0_0.moveCount = 0

function var_0_0.step(arg_35_0)
	var_0_0.moveCount = 0

	arg_35_0:checkEnemyRuleUpdate()
	arg_35_0:checkEnemyDataUpdate()
	arg_35_0:checkCreateEnemy()
	arg_35_0:checkRemoveEnemy()
	arg_35_0:moveEnmey()
	arg_35_0:checkEnemyQuick()
	arg_35_0:checkEnemyBack()
	arg_35_0:updateEnemyRemoveFlag()
	arg_35_0:checkEnemySplit()
	arg_35_0:updateEnemyVo()
	arg_35_0:checkEnemyFinal()
	arg_35_0:updateEnemyData()

	return
end

function var_0_0.updateEnemyData(arg_36_0)
	if not arg_36_0.lastPointDistance then
		arg_36_0.lastPointDistance = {}

		for iter_36_0 = 1, #arg_36_0.pointsList do
			local var_36_0 = arg_36_0.pointsList[iter_36_0]

			table = var_1_10006

			var_1_10006.insert(arg_36_0.lastPointDistance, var_36_0[#var_36_0].distance)
		end
	end

	local var_36_1 = {}
	local var_36_2 = 0

	for iter_36_1 = 1, #arg_36_0.enemysList do
		if arg_36_0.enemysList[iter_36_1] and #var_7 > 0 then
			local var_36_3 = var_7[#var_7]
			local var_36_4 = var_8.getDistance(var_36_3)

			table = var_36_3

			local var_36_5 = var_36_3.insert
			local var_36_6 = var_36_1

			math = var_1_10011

			var_36_5(var_36_6, var_1_10011.floor(var_36_4 / arg_36_0.lastPointDistance[iter_36_1] * 10))
		end
	end

	LaunchBallGameVo = var_3
	var_3.enemyToEndRate = var_36_1

	return
end

function var_0_0.checkEnemyDataUpdate(arg_37_0)
	if arg_37_0.currentEnemyRule == nil then
		arg_37_0.currentEnemyRule = arg_37_0:getEnemyRule()
	end

	return
end

function var_0_0.checkTargetScore(arg_38_0)
	LaunchBallGameVo = var_1_10001

	if var_1_10001.gameRoundData.target then
		LaunchBallGameVo = var_1

		local var_38_0 = var_1.scoreNum

		LaunchBallGameVo = var_1_10002

		if var_38_0 >= var_1_10002.gameRoundData.target then
			return true
		end
	end

	return false
end

function var_0_0.checkCreateEnemy(arg_39_0)
	if arg_39_0:checkTargetScore() then
		return
	end

	local var_39_0 = 1

	for iter_39_0 = 1, #arg_39_0.enemysList do
		local var_39_1 = arg_39_0.enemysList[iter_39_0]
		local var_39_2 = arg_39_0.pointsList[iter_39_0]

		if #var_39_1 > 0 then
			local var_39_3 = var_39_1[1]

			if var_8.getDistance(var_39_3) > var_0_6 then
				arg_39_0:createRandomEnemy(iter_39_0, var_39_2, var_39_1, 1, 0, true)

				break
			end
		else
			arg_39_0:createRandomEnemy(iter_39_0, var_39_2, var_39_1, 1, 0, true)

			break
		end
	end

	return
end

function var_0_0.checkRemoveEnemy(arg_40_0)
	ipairs = var_1_10001

	for iter_40_0, iter_40_1 in var_1_10001(arg_40_0.enemysList) do
		local var_40_0 = false

		for iter_40_2 = #iter_40_1, 1, -1 do
			local var_40_1 = iter_40_1[iter_40_2]

			var_11.step(var_40_1)

			local var_40_2 = iter_40_1[iter_40_2]

			if var_11.getRemoveFlag(var_40_2) then
				local var_40_3 = iter_40_1[iter_40_2]

				if var_11.getBuff(var_40_3) then
					arg_40_0:appearEnemyBuff(var_11, iter_40_2, iter_40_1[iter_40_2], iter_40_1)
				end

				local var_40_4 = arg_40_0
				local var_40_5 = arg_40_0.returnEnemy

				table = var_1_10014

				var_40_5(var_40_4, var_1_10014.remove(iter_40_1, iter_40_2))

				local var_40_6 = true
			end
		end
	end

	if arg_40_0.timeRemoveAll then
		local var_40_7 = arg_40_0.timeRemoveAll

		if 0 < var_40_7 then
			local var_40_8 = arg_40_0.timeRemoveAll

			LaunchBallGameVo = var_2
			arg_40_0.timeRemoveAll = var_40_8 - var_2.deltaTime

			if arg_40_0.timeRemoveAll <= 0 then
				local var_40_9 = 0

				ipairs = var_2

				for iter_40_3, iter_40_4 in var_2(arg_40_0.enemysList) do
					for iter_40_5 = #iter_40_4, 1, -1 do
						local var_40_10 = iter_40_4[iter_40_5]

						if not var_11.getRemoveFlag(var_40_10) then
							var_11:setTimeRemove()

							var_40_9 = var_40_9 + 1
							LaunchBallGameVo = var_12

							local var_40_11 = var_12.GetScore(1, 1)
							local var_40_12 = arg_40_0._eventCall

							LaunchBallGameScene = var_14

							var_40_12(var_14.SPILT_ENEMY_SCORE, {
								num = var_40_11
							})
						end
					end
				end

				LaunchBallGameVo = var_2

				local var_40_13 = var_2.UpdateGameResultData

				LaunchBallGameVo = var_3

				var_40_13(var_3.result_skill_count, var_40_9)

				arg_40_0.timeRemoveAll = nil
			end
		end
	end

	return
end

function var_0_0.appearEnemyBuff(arg_41_0, arg_41_1, arg_41_2, arg_41_3, arg_41_4)
	LaunchBallGameConst = var_1_10005

	local var_41_0 = var_1_10005.enemy_buff_data[arg_41_1]

	LaunchBallGameConst = var_1_10006

	local var_41_1

	if arg_41_1 == var_1_10006.enemy_buff_slow then
		arg_41_0.slowTime = var_41_0.time
		LaunchBallGameVo = var_41_1
		var_41_1 = var_41_1.GetBuff
		LaunchBallPlayerControl = var_1_10007

		if var_41_1(var_1_10007.buff_time_max) then
			arg_41_0.slowTime = arg_41_0.slowTime * 1.5
			LaunchBallGameVo = var_41_1
			var_41_1 = var_41_1.AddGameResultData
			LaunchBallGameVo = var_1_10007

			var_41_1(var_1_10007.result_use_pass_skill, 1)

			if arg_41_0.enemyStopTime then
				var_41_1 = arg_41_0.enemyStopTime

				if 0 < var_41_1 then
					arg_41_0.enemyStopTime = arg_41_0.enemyStopTime + 3
				end
			end
		end
	else
		LaunchBallGameConst = var_41_1

		local var_41_2

		if arg_41_1 == var_41_1.enemy_buff_back then
			arg_41_0.backEnemyTime = var_41_0.time
			arg_41_0.backSpeed = var_0_10
			arg_41_0.moveBackIndex = #arg_41_4
			LaunchBallGameVo = var_41_2
			var_41_2 = var_41_2.GetBuff
			LaunchBallPlayerControl = var_1_10007

			if var_41_2(var_1_10007.buff_time_max) then
				arg_41_0.backEnemyTime = arg_41_0.backEnemyTime * 1.3
				LaunchBallGameVo = var_41_2
				var_41_2 = var_41_2.AddGameResultData
				LaunchBallGameVo = var_1_10007

				var_41_2(var_1_10007.result_use_pass_skill, 1)
			end
		else
			LaunchBallGameConst = var_41_2

			local var_41_3

			if arg_41_1 == var_41_2.enemy_buff_boom then
				var_1_10007 = arg_41_3
				var_41_3 = arg_41_3.getDistance(var_1_10007)
				var_1_10007 = var_41_0.distance

				for iter_41_0 = 1, #arg_41_4 do
					local var_41_4 = arg_41_4[iter_41_0]

					if not var_12.getRemoveFlag(var_41_4) then
						math = var_12

						local var_41_5 = var_12.abs
						local var_41_6 = arg_41_4[iter_41_0]

						if var_1_10007 >= var_41_5(var_13.getDistance(var_41_6) - var_41_3) then
							local var_41_7 = arg_41_4[iter_41_0]

							var_13.setTimeRemove(var_41_7)

							LaunchBallGameVo = var_13

							local var_41_8 = var_13.GetScore(1, 1)
							local var_41_9 = arg_41_0._eventCall

							LaunchBallGameScene = var_15

							var_41_9(var_15.SPILT_ENEMY_SCORE, {
								num = var_41_8
							})
						end
					end
				end
			else
				LaunchBallGameConst = var_41_3

				if arg_41_1 == var_41_3.enemy_buff_concentrate then
					local var_41_10 = arg_41_0._eventCall

					LaunchBallGameScene = var_1_10007

					var_41_10(var_1_10007.CONCENTRATE_TRIGGER, var_41_0)
				end
			end
		end
	end

	return
end

function var_0_0.moveEnmey(arg_42_0)
	local var_42_0

	if arg_42_0.enemyStopTime then
		local var_42_1 = arg_42_0.enemyStopTime

		if 0 < var_42_1 then
			local var_42_2 = arg_42_0.enemyStopTime

			LaunchBallGameVo = var_1_10003
			arg_42_0.enemyStopTime = var_42_2 - var_1_10003.deltaTime

			if arg_42_0.enemyStopTime <= 0 then
				arg_42_0.enemyStopTime = nil
				var_1_10003 = arg_42_0

				arg_42_0.stopEnemysAnim(var_1_10003, false)
			end

			LaunchBallGameVo = var_2
			var_2.enemyStopTime = arg_42_0.enemyStopTime
		end
	end

	if arg_42_0.enemyStopTime then
		local var_42_3 = arg_42_0.enemyStopTime

		if 0 < var_42_3 then
			return
		end
	end

	if arg_42_0.backEnemyTime then
		local var_42_4 = arg_42_0.backEnemyTime

		if 0 < var_42_4 then
			local var_42_5 = arg_42_0.backEnemyTime

			LaunchBallGameVo = var_1_10003
			arg_42_0.backEnemyTime = var_42_5 - var_1_10003.deltaTime

			if arg_42_0.backEnemyTime <= 0 then
				arg_42_0.backEnemyTime = nil
			end

			local var_42_6 = arg_42_0.backSpeed

			LaunchBallGameVo = var_1_10003
			var_42_0 = var_42_6 * var_1_10003.deltaTime

			goto label_42_0
		end
	end

	do
		local var_42_7 = arg_42_0.moveSpeed

		LaunchBallGameVo = var_1_10003
		var_42_0 = var_42_7 * var_1_10003.deltaTime
	end

	::label_42_0::

	if arg_42_0.slowTime then
		local var_42_8 = arg_42_0.slowTime

		if 0 < var_42_8 then
			var_42_0 = var_42_0 / 3

			local var_42_9 = arg_42_0.slowTime

			LaunchBallGameVo = var_1_10003
			arg_42_0.slowTime = var_42_9 - var_1_10003.deltaTime

			if arg_42_0.slowTime < 0 then
				arg_42_0.slowTime = nil
			end
		end
	end

	local var_42_10 = {}

	ipairs = var_1_10003

	for iter_42_0, iter_42_1 in var_1_10003(arg_42_0.enemysList) do
		local var_42_11 = 0

		if var_42_0 > 0 then
			for iter_42_2 = 1, #iter_42_1 do
				local var_42_12 = false

				if iter_42_2 < #iter_42_1 then
					local var_42_13 = iter_42_1[iter_42_2]

					if var_14.getDistance(var_42_13) < var_0_6 then
						local var_42_14 = iter_42_1[iter_42_2 + 1]

						if var_14.getDistance(var_42_14) < var_0_6 then
							var_42_12 = true
						end
					end
				end

				if iter_42_2 > 1 and var_42_11 == 0 then
					local var_42_15 = iter_42_1[iter_42_2]
					local var_42_16 = var_14.getDistance(var_42_15)
					local var_42_17 = iter_42_1[iter_42_2 - 1]

					if var_42_16 - var_15.getDistance(var_42_17) > var_0_6 then
						var_42_11 = iter_42_2
						var_42_12 = true
					else
						local var_42_18 = iter_42_1[iter_42_2]

						if var_14.getRemoveFlag(var_42_18) then
							var_42_11 = iter_42_2
							var_42_12 = true
						end
					end
				elseif var_42_11 ~= 0 and var_42_11 <= iter_42_2 then
					var_42_12 = true
				end

				if not var_42_12 then
					local var_42_19 = iter_42_1[iter_42_2]

					var_14.move(var_42_19, var_42_0)
				end
			end
		end

		if var_42_0 < 0 then
			for iter_42_3 = #iter_42_1, 1, -1 do
				local var_42_20 = false

				if iter_42_3 <= arg_42_0.moveBackIndex and var_42_11 == 0 then
					if iter_42_3 > 1 then
						local var_42_21 = iter_42_1[iter_42_3]
						local var_42_22 = var_14.getDistance(var_42_21)
						local var_42_23 = iter_42_1[iter_42_3 - 1]

						if var_42_22 - var_15.getDistance(var_42_23) > var_0_6 + var_0_14 then
							var_42_11 = iter_42_3 - 1
						end
					end
				else
					var_42_20 = var_42_11 ~= 0 and iter_42_3 <= var_42_11 and true or true
				end

				if not var_42_20 then
					local var_42_24 = iter_42_1[iter_42_3]

					var_14.move(var_42_24, var_42_0)
				end
			end
		end
	end

	return
end

function var_0_0.checkEnemyQuick(arg_43_0)
	if arg_43_0.backFlag then
		return
	end

	arg_43_0.quickFlag = false
	ipairs = var_1

	for iter_43_0, iter_43_1 in var_1(arg_43_0.enemysList) do
		local var_43_0 = 0

		for iter_43_2 = 1, #iter_43_1 do
			local var_43_1 = iter_43_1[iter_43_2]

			if iter_43_2 <= #iter_43_1 - 1 then
				local var_43_2 = iter_43_1[iter_43_2 + 1]

				if var_12.getDistance(var_43_2) > var_0_6 then
					local var_43_3 = var_12:getDistance()

					var_1_10015 = var_43_1

					if var_43_3 - var_43_1.getDistance(var_1_10015) < var_0_6 - var_0_14 then
						var_43_0 = iter_43_2 + 1
						arg_43_0.quickFlag = true

						break
					end
				end
			end
		end

		if var_43_0 ~= 0 then
			for iter_43_3 = 1, #iter_43_1 do
				if var_43_0 <= iter_43_3 then
					local var_43_4 = iter_43_1[iter_43_3 - 1]
					local var_43_5 = iter_43_1[iter_43_3]

					if var_12.getDistance(var_43_5) - var_43_4:getDistance() < var_0_6 - var_0_14 then
						local var_43_6 = iter_43_1[iter_43_3]
						local var_43_7 = var_12.move
						local var_43_8 = var_0_12

						LaunchBallGameVo = var_1_10015

						var_43_7(var_43_6, var_43_8 * var_1_10015.deltaTime)
					else
						break
					end
				end
			end
		end
	end

	return
end

function var_0_0.checkEnemyBack(arg_44_0)
	arg_44_0.backFlag = false

	if not arg_44_0.quickFlag then
		ipairs = var_1

		for iter_44_0, iter_44_1 in var_1(arg_44_0.enemysList) do
			local var_44_0 = 0

			for iter_44_2 = 1, #iter_44_1 do
				if iter_44_2 > 1 and var_44_0 == 0 then
					local var_44_1 = iter_44_1[iter_44_2]
					local var_44_2 = var_11.getDistance(var_44_1)
					local var_44_3 = iter_44_1[iter_44_2 - 1]

					if var_44_2 - var_12.getDistance(var_44_3) > var_0_6 + var_0_14 then
						local var_44_4 = iter_44_1[iter_44_2]

						if var_11.getSplitFlag(var_44_4) then
							local var_44_5 = iter_44_1[iter_44_2]
							local var_44_6 = var_11.getColor(var_44_5)
							local var_44_7 = iter_44_1[iter_44_2 - 1]

							if var_44_6 == var_12.getColor(var_44_7) then
								var_44_0 = iter_44_2

								if not arg_44_0.backEnemyFlag then
									arg_44_0.backEnemyFlag = true
								end
							end
						end
					end
				end
			end

			if var_44_0 ~= 0 then
				arg_44_0.backFlag = true
				arg_44_0.moveBackIndex = 0

				for iter_44_3 = 1, #iter_44_1 do
					if iter_44_3 == var_44_0 then
						arg_44_0.moveBackIndex = iter_44_3

						local var_44_8 = iter_44_1[iter_44_3]
						local var_44_9 = var_11.move
						local var_44_10 = var_0_13

						LaunchBallGameVo = var_1_10014

						var_44_9(var_44_8, var_44_10 * var_1_10014.deltaTime)
					elseif var_44_0 < iter_44_3 then
						local var_44_11 = iter_44_1[iter_44_3]
						local var_44_12 = var_11.getDistance(var_44_11)
						local var_44_13 = iter_44_1[iter_44_3 - 1]

						if var_44_12 - var_12.getDistance(var_44_13) < var_0_6 + var_0_14 then
							local var_44_14 = iter_44_1[iter_44_3]
							local var_44_15 = var_11.move
							local var_44_16 = var_0_13

							LaunchBallGameVo = var_1_10014

							var_44_15(var_44_14, var_44_16 * var_1_10014.deltaTime)

							arg_44_0.moveBackIndex = iter_44_3
						else
							break
						end
					end
				end
			end
		end
	end

	if arg_44_0.backFlag and arg_44_0.backEnemyFlag then
		arg_44_0.backEnemyFlag = false
		arg_44_0.backEnemyTime = var_0_11
		arg_44_0.backSpeed = var_0_9
	end

	return
end

function var_0_0.updateEnemyRemoveFlag(arg_45_0)
	arg_45_0.enemyTimeRemoveFlag = false
	ipairs = var_1

	for iter_45_0, iter_45_1 in var_1(arg_45_0.enemysList) do
		local var_45_0 = 0

		for iter_45_2 = 1, #iter_45_1 do
			local var_45_1 = iter_45_1[iter_45_2]

			if var_11.getTimeRemove(var_45_1) then
				arg_45_0.enemyTimeRemoveFlag = true
			end
		end
	end

	return
end

function var_0_0.checkEnemySplit(arg_46_0)
	if not arg_46_0.enemyTimeRemoveFlag and not arg_46_0.backFlag and not arg_46_0.quickFlag and not arg_46_0.backEnemyFlag then
		ipairs = var_1_10002

		for iter_46_0, iter_46_1 in var_1_10002(arg_46_0.enemysList) do
			local var_46_0 = 0

			for iter_46_2 = 1, #iter_46_1 do
				local var_46_1 = iter_46_1[iter_46_2]

				if var_12.getSplitFlag(var_46_1) then
					local var_46_2 = iter_46_2
					local var_46_3, var_46_4, var_46_5 = arg_46_0:checkSplit(var_46_2, iter_46_1)
					local var_46_6 = var_12

					var_12.setSplitFlag(var_46_6, false)

					if var_46_3 >= 3 or var_46_4 then
						arg_46_0.seriesCount = arg_46_0.seriesCount + 1

						if arg_46_0.splitFireIndex then
							local var_46_7 = arg_46_0.splitFireIndex + 1

							if arg_46_0.fireIndex <= var_46_7 then
								LaunchBallGameVo = var_46_7

								local var_46_8 = var_46_7.AddGameResultData

								LaunchBallGameVo = var_46_6

								var_46_8(var_46_6.result_series_count, 1)

								if not arg_46_0.seriesCombat then
									arg_46_0.seriesCombat = 1
								else
									arg_46_0.seriesCombat = arg_46_0.seriesCombat + 1
								end

								goto label_46_0
							end
						end

						arg_46_0.seriesCombat = 0

						::label_46_0::

						if arg_46_0.amuletOverFlag then
							LaunchBallGameVo = var_17

							local var_46_9 = var_17.AddGameResultData

							LaunchBallGameVo = var_46_6

							var_46_9(var_46_6.result_over_count, 1)
						end

						arg_46_0.splitFireIndex = arg_46_0.fireIndex

						break
					end

					arg_46_0.seriesCount = 1
					arg_46_0.seriesCombat = 0

					break
				end
			end
		end
	end

	return
end

function var_0_0.checkEnemyFinal(arg_47_0)
	local var_47_0 = arg_47_0
	local var_47_1

	if arg_47_0.checkTargetScore(var_47_0) then
		var_47_1 = 0
		ipairs = var_47_0

		for iter_47_0, iter_47_1 in var_47_0(arg_47_0.enemysList) do
			var_47_1 = var_47_1 + #iter_47_1
		end

		if var_47_1 == 0 then
			local var_47_2 = arg_47_0._eventCall

			LaunchBallGameScene = var_3

			var_47_2(var_3.ENEMY_FINISH)

			return
		end
	end

	ipairs = var_47_1

	for iter_47_2, iter_47_3 in var_47_1(arg_47_0.enemysList) do
		if iter_47_3 and #iter_47_3 > 0 then
			local var_47_3 = iter_47_3[#iter_47_3]

			if var_6.getFinish(var_47_3) then
				local var_47_4 = arg_47_0._eventCall

				LaunchBallGameScene = var_47_3

				var_47_4(var_47_3.ENEMY_FINISH)

				return
			end
		end
	end

	return
end

function var_0_0.updateEnemyVo(arg_48_0)
	local var_48_0 = {}

	ipairs = var_1_10002

	for iter_48_0, iter_48_1 in var_1_10002(arg_48_0.enemysList) do
		for iter_48_2 = 1, #iter_48_1 do
			local var_48_1 = iter_48_1[iter_48_2]
			local var_48_2 = var_11.getColor(var_48_1)

			table = var_48_1

			if not var_48_1.contains(var_48_0, var_48_2) then
				table = var_12

				var_12.insert(var_48_0, var_48_2)

				local var_48_3 = #var_48_0

				LaunchBallGameConst = var_13

				if var_48_3 >= var_13.color_total then
					LaunchBallGameVo = var_48_3
					var_48_3.enemyColors = var_48_0

					return
				end
			end
		end
	end

	LaunchBallGameVo = var_2
	var_2.enemyColors = var_48_0

	return
end

function var_0_0.updateGameResultSplitCount(arg_49_0, arg_49_1, arg_49_2)
	LaunchBallGameVo = var_1_10003

	local var_49_0 = var_1_10003.AddGameResultData

	LaunchBallGameVo = var_1_10004

	var_49_0(var_1_10004.result_split_count, 1)

	if 1 < arg_49_2 then
		LaunchBallGameVo = var_3

		local var_49_1 = var_3.AddGameResultData

		LaunchBallGameVo = var_4

		var_49_1(var_4.result_series_count, 1)

		LaunchBallGameVo = var_49_1

		local var_49_2 = var_49_1.AddGameResultData

		LaunchBallGameVo = var_4

		var_49_2(var_4.result_mix_count, 1)
	end

	if 3 < arg_49_1 then
		LaunchBallGameVo = var_3

		local var_49_3 = var_3.AddGameResultData

		LaunchBallGameVo = var_4

		var_49_3(var_4.result_many_count, 1)
	end

	return
end

function var_0_0.checkSplit(arg_50_0, arg_50_1, arg_50_2)
	local var_50_0 = arg_50_2[arg_50_1]
	local var_50_1 = var_3.getColor(var_50_0)
	local var_50_2 = 1
	local var_50_3 = {
		arg_50_2[arg_50_1]
	}
	local var_50_4 = false
	local var_50_5 = 0
	local var_50_6 = 0

	if arg_50_1 > 1 then
		for iter_50_0 = arg_50_1 - 1, 1, -1 do
			local var_50_7 = arg_50_2[iter_50_0]

			if var_13.getColor(var_50_7) == var_50_1 then
				table = var_13

				var_13.insert(var_50_3, arg_50_2[iter_50_0])

				var_50_2 = var_50_2 + 1
				var_50_6 = var_50_6 + 1
			else
				break
			end
		end
	end

	local var_50_8

	if arg_50_1 < #arg_50_2 then
		for iter_50_1 = arg_50_1 + 1, #arg_50_2 do
			local var_50_9 = arg_50_2[iter_50_1]

			if var_14.getColor(var_50_9) == var_50_1 then
				table = var_14

				var_14.insert(var_50_3, arg_50_2[iter_50_1])

				var_50_2 = var_50_2 + 1
				var_50_5 = var_50_5 + 1
			else
				var_50_8 = arg_50_2[iter_50_1]

				break
			end
		end
	end

	if var_50_2 >= 3 then
		var_50_4 = true
	end

	if 3 <= var_50_2 and not var_50_4 then
		print = var_10

		var_10("")
	end

	if var_50_4 and var_50_8 then
		var_50_8:setSplitFlag(true)
	end

	if var_50_4 then
		for iter_50_2 = 1, #var_50_3 do
			local var_50_10 = var_50_3[iter_50_2]

			var_14.hit(var_50_10)
		end

		if arg_50_0._eventCall then
			LaunchBallGameVo = var_10

			local var_50_11 = var_10.GetScore(var_50_2, arg_50_0.seriesCount, arg_50_0.amuletOverFlag)
			local var_50_12 = arg_50_0._eventCall

			LaunchBallGameScene = var_12

			var_50_12(var_12.SPILT_ENEMY_SCORE, {
				split = true,
				num = var_50_11,
				count = var_50_2
			})

			LaunchBallGameVo = var_50_12

			local var_50_13 = var_50_12.GetBuff

			LaunchBallPlayerControl = var_12

			if var_50_13(var_12.buff_time_max) and arg_50_0.enemyStopTime then
				local var_50_14 = arg_50_0.enemyStopTime

				if 0 < var_50_14 then
					LaunchBallGameVo = var_50_14

					local var_50_15 = var_50_14.AddGameResultData

					LaunchBallGameVo = var_12

					var_50_15(var_12.result_skill_count, var_50_2)
				end
			end
		end

		arg_50_0:updateGameResultSplitCount(var_50_2, arg_50_0.seriesCount)

		if not var_50_8 then
			arg_50_0.seriesCount = 0
		end
	end

	return var_50_2, var_50_4
end

function var_0_0.createPoints(arg_51_0, arg_51_1)
	local var_51_0 = {}
	local var_51_1 = 0

	GetComponent = var_1_10004

	local var_51_2 = var_1_10004(arg_51_1, "EdgeCollider2D").points
	local var_51_3 = var_5.ToTable(var_51_2)

	ipairs = var_51_2

	for iter_51_0, iter_51_1 in var_51_2(var_51_3) do
		Vector2 = var_1_10011
		var_1_10011 = var_1_10011(0, 0)
		Vector2 = var_12

		local var_51_4 = var_12(0, 0)
		local var_51_5 = 0
		local var_51_6 = 0

		if iter_51_0 > 1 then
			local var_51_7 = var_51_3[iter_51_0 - 1]
			local var_51_8 = var_51_3[iter_51_0]

			math = var_1_10017
			var_1_10017 = var_1_10017.sqrt
			math = var_1_10018
			var_1_10018 = var_1_10018.pow(var_51_8.x - var_51_7.x, 2)
			math = var_19
			var_51_1 = var_51_1 + var_1_10017(var_1_10018 + var_19.pow(var_51_8.y - var_51_7.y, 2))
		end

		local var_51_9

		if iter_51_0 < #var_51_3 then
			var_51_9 = var_51_3[iter_51_0]

			local var_51_10 = var_51_3[iter_51_0 + 1]

			math = var_1_10017
			var_1_10017 = var_1_10017.atan
			math = var_1_10018
			var_1_10018 = var_1_10018.abs(var_51_10.y - var_51_9.y)
			math = var_19

			local var_51_11 = var_1_10017(var_1_10018 / var_19.abs(var_51_10.x - var_51_9.x))

			math = var_1_10017
			var_1_10017 = var_1_10017.atan2(var_51_10.y - var_51_9.y, var_51_10.x - var_51_9.x)
			math = var_1_10018
			var_51_6 = var_1_10017 * var_1_10018.rad2Deg
			var_1_10017 = var_51_10.x
			var_1_10017 = var_51_9.x < var_1_10017 and 1 or -1
			var_1_10018 = var_51_10.y
			var_1_10018 = var_51_9.y < var_1_10018 and 1 or -1
			var_51_4.x = var_1_10017
			var_51_4.y = var_1_10018
			math = var_19
			var_1_10011.x = var_19.cos(var_51_11) * var_1_10017
			math = var_19
			var_1_10011.y = var_19.sin(var_51_11) * var_1_10018
		elseif iter_51_0 == #var_51_3 then
			var_51_9 = var_51_3[iter_51_0 - 1]

			local var_51_12 = var_51_3[iter_51_0]

			math = var_1_10017
			var_1_10017 = var_1_10017.atan
			math = var_1_10018
			var_1_10018 = var_1_10018.abs(var_51_12.y - var_51_9.y)
			math = var_19

			local var_51_13 = var_1_10017(var_1_10018 / var_19.abs(var_51_12.x - var_51_9.x))

			math = var_1_10017
			var_1_10017 = var_1_10017.atan2(var_51_12.y - var_51_9.y, var_51_12.x - var_51_9.x)
			math = var_1_10018
			var_51_6 = var_1_10017 * var_1_10018.rad2Deg
			var_1_10017 = var_51_12.x
			var_1_10017 = var_51_9.x < var_1_10017 and 1 or -1
			var_1_10018 = var_51_12.y
			var_1_10018 = var_51_9.y < var_1_10018 and 1 or -1
			var_51_4.x = var_1_10017
			var_51_4.y = var_1_10018
			math = var_19
			var_1_10011.x = var_19.cos(var_51_13) * var_1_10017
			math = var_19
			var_1_10011.y = var_19.sin(var_51_13) * var_1_10018
		end

		table = var_51_9

		var_51_9.insert(var_51_0, {
			pos = iter_51_1,
			distance = var_51_1,
			move = var_1_10011,
			direct = var_51_4,
			angle = var_51_6
		})
	end

	return var_51_0
end

function var_0_0.createEnemy(arg_52_0, arg_52_1, arg_52_2, arg_52_3, arg_52_4, arg_52_5)
	local var_52_0 = arg_52_0:getOrCreateEnemy()

	var_6.setData(var_52_0, arg_52_1, arg_52_2)
	var_6:setPoints(arg_52_3)
	var_6:setActive(true)
	var_6:setSplitFlag(false)

	if arg_52_5 then
		var_6:setDistance(arg_52_5)
	else
		var_6:setDistance(0)
	end

	table = var_7

	var_7.insert(arg_52_4, var_6)
	arg_52_0:sortEnemys(arg_52_4)

	return var_6
end

function var_0_0.createRandomEnemy(arg_53_0, arg_53_1, arg_53_2, arg_53_3, arg_53_4, arg_53_5, arg_53_6)
	if not arg_53_0:getEnemyDataByRule() then
		return
	end

	local var_53_0 = arg_53_0:getOrCreateEnemy()
	local var_53_1 = arg_53_0:getEnemyBuff()

	var_53_0:setData(arg_53_1, var_7)
	var_53_0:setBuff(var_53_1)
	var_53_0:setPoints(arg_53_2)
	var_53_0:setActive(true)

	if arg_53_4 and arg_53_4 ~= 0 then
		var_53_0:setPosIndex(arg_53_4)
	elseif arg_53_5 then
		var_53_0:setDistance(arg_53_5)
	end

	table = var_10

	var_10.insert(arg_53_3, var_53_0)
	arg_53_0:sortEnemys(arg_53_3)

	return var_53_0
end

function var_0_0.getEnemyBuff(arg_54_0)
	local var_54_0 = {}

	for iter_54_0 = 1, #arg_54_0.enemyBuffs.buffs do
		local var_54_1 = arg_54_0.enemyBuffs.buffs[iter_54_0]
		local var_54_2 = true
		local var_54_3 = var_54_1.type

		LaunchBallGameConst = var_1_10009

		if var_54_3 == var_1_10009.enemy_buff_back then
			var_1_10009 = arg_54_0

			local var_54_4 = arg_54_0.getEnemyByBuff

			LaunchBallGameConst = var_1_10010

			if var_54_4(var_1_10009, var_1_10010.enemy_buff_slow) then
				var_54_2 = false
			end
		else
			local var_54_5 = var_54_1.type

			LaunchBallGameConst = var_1_10009

			if var_54_5 == var_1_10009.enemy_buff_slow then
				var_1_10009 = arg_54_0

				local var_54_6 = arg_54_0.getEnemyByBuff

				LaunchBallGameConst = var_1_10010

				if var_54_6(var_1_10009, var_1_10010.enemy_buff_back) then
					var_54_2 = false
				end
			end
		end

		if var_54_2 then
			var_1_10009 = var_54_1.rate[1]
			LaunchBallGameVo = var_1_10010
			var_1_10010 = var_1_10010.GetBuff
			LaunchBallPlayerControl = var_1_10011

			if var_1_10010(var_1_10011.buff_time_max) then
				var_1_10010 = var_54_1.type
				LaunchBallGameConst = var_1_10011

				if var_1_10010 == var_1_10011.enemy_buff_slow then
					var_1_10009 = var_1_10009 + 2
				else
					var_1_10010 = var_54_1.type
					LaunchBallGameConst = var_1_10011

					if var_1_10010 == var_1_10011.enemy_buff_back then
						var_1_10009 = var_1_10009 + 2
					end
				end
			end

			math = var_1_10010

			if var_1_10010.random(1, var_8[2]) <= var_1_10009 then
				table = var_1_10011

				var_1_10011.insert(var_54_0, var_54_1.type)
			end
		end
	end

	if #var_54_0 > 0 then
		math = var_2

		return var_54_0[var_2.random(1, #var_54_0)]
	end

	return nil
end

function var_0_0.getEnemyByBuff(arg_55_0, arg_55_1)
	for iter_55_0 = 1, #arg_55_0.enemysList do
		local var_55_0 = arg_55_0.pointsList[iter_55_0]

		for iter_55_1 = #arg_55_0.enemysList[iter_55_0], 1, -1 do
			local var_55_1 = var_7[iter_55_1]

			if var_12.getBuff(var_55_1) == arg_55_1 then
				return var_12
			end
		end
	end

	return nil
end

function var_0_0.getOrCreateEnemy(arg_56_0)
	local var_56_0
	local var_56_1 = #arg_56_0.enemyPool

	if 0 < var_56_1 then
		table = var_56_1
		var_56_0 = var_56_1.remove(arg_56_0.enemyPool, 1)
	else
		tf = var_56_1
		instantiate = var_3

		local var_56_2 = var_56_1(var_3(arg_56_0._enemyTpl))

		setParent = var_3

		var_3(var_56_2, arg_56_0._enemyContent)

		var_56_0 = var_0_16(var_56_2)
	end

	return var_56_0
end

function var_0_0.sortEnemys(arg_57_0, arg_57_1)
	table = var_1_10002

	var_1_10002.sort(arg_57_1, function(arg_58_0, arg_58_1)
		return arg_58_0:getDistance() < arg_58_1:getDistance()
	end)

	for iter_57_0 = 1, #arg_57_1 do
		local var_57_0 = arg_57_1[iter_57_0]

		var_6.setLastLayer(var_57_0, iter_57_0 - 1)
	end

	return
end

function var_0_0.returnEnemy(arg_59_0, arg_59_1)
	arg_59_1:setActive(false)

	table = var_2

	var_2.insert(arg_59_0.enemyPool, arg_59_1)

	return
end

function var_0_0.getEnemyDataByRule(arg_60_0)
	if not arg_60_0.currentEnemyRule then
		arg_60_0.currentEnemyRule = arg_60_0:getEnemyRule()
	end

	if #var_0_1 > 0 then
		local var_60_0 = arg_60_0
		local var_60_1 = arg_60_0.getEnemyById

		table = var_1_10003

		return var_60_1(var_60_0, var_1_10003.remove(var_0_1, 1))
	end

	if arg_60_0.currentEnemyRule then
		local var_60_2

		if arg_60_0.currentEnemyRule.single then
			var_60_2 = arg_60_0.currentEnemyRule.singleId
		else
			local var_60_3 = arg_60_0.currentEnemyRule.enemys

			math = var_1_10003
			var_60_2 = var_60_3[var_1_10003.random(1, #arg_60_0.currentEnemyRule.enemys)]
		end

		arg_60_0.currentEnemyRule.count = arg_60_0.currentEnemyRule.count - 1

		if arg_60_0.currentEnemyRule.count <= 0 then
			arg_60_0.currentEnemyRule = nil
		end

		return arg_60_0:getEnemyById(var_60_2)
	end

	return nil
end

function var_0_0.getEnemyById(arg_61_0, arg_61_1)
	for iter_61_0 = 1, #arg_61_0.enemyDatas do
		if arg_61_0.enemyDatas[iter_61_0].data.id == arg_61_1 then
			return arg_61_0.enemyDatas[iter_61_0]
		end
	end

	print = var_2

	var_2("找不到id = " .. arg_61_1 .. "的怪物")

	return nil
end

function var_0_0.checkEnemyRuleUpdate(arg_62_0)
	local var_62_0 = false

	for iter_62_0 = 1, #arg_62_0.rounds do
		LaunchBallGameVo = var_1_10006

		if var_1_10006.gameStepTime >= arg_62_0.rounds[iter_62_0].time[2] then
			var_62_0 = true
		end
	end

	if var_62_0 then
		arg_62_0:createRoundData()
	end

	return
end

function var_0_0.getEnemysInBounds(arg_63_0, arg_63_1, arg_63_2)
	local var_63_0 = arg_63_0._enemyContent
	local var_63_1 = var_3.InverseTransformPoint(var_63_0, arg_63_1)
	local var_63_2 = arg_63_0._enemyContent
	local var_63_3 = var_4.InverseTransformPoint(var_63_2, arg_63_2)

	arg_63_0.colliderTestTf.anchoredPosition = var_63_3

	local var_63_4 = {}

	for iter_63_0 = 1, #arg_63_0.enemysList do
		local var_63_5 = arg_63_0.pointsList[iter_63_0]

		for iter_63_1 = #arg_63_0.enemysList[iter_63_0], 1, -1 do
			local var_63_6 = var_11[iter_63_1]

			if var_16.getTf(var_63_6).anchoredPosition.x > var_63_1.x and var_16.x < var_63_3.x and var_16.y > var_63_1.y and var_16.y < var_63_3.y then
				table = var_17

				var_17.insert(var_63_4, var_11[iter_63_1])
			end
		end
	end

	return var_63_4
end

function var_0_0.getEnemyRule(arg_64_0)
	local var_64_0

	math = var_1_10002

	local var_64_1 = var_1_10002.random(0, arg_64_0.maxWeight)
	local var_64_2

	for iter_64_0 = 1, #arg_64_0.rounds do
		if not var_64_2 and var_64_1 <= arg_64_0.rounds[iter_64_0].maxWeight then
			var_64_2 = arg_64_0.rounds[iter_64_0].createId
		end
	end

	if var_64_2 then
		if not arg_64_0.enemyRule[var_64_2] then
			print = var_4

			var_4("create id not exit " .. var_64_2)
		end

		local var_64_3 = arg_64_0.enemyRule[var_64_2].id
		local var_64_4 = var_4.enemy_create.count
		local var_64_5 = var_4.enemy_create.enemys
		local var_64_6 = var_4.enemy_create.single
		local var_64_7

		if var_64_6 then
			math = var_1_10010
			var_64_7 = var_64_5[var_1_10010.random(1, #var_64_5)]
		end

		var_64_0 = {
			id = var_64_3,
			count = var_64_4,
			enemys = var_64_5,
			single = var_64_6,
			singleId = var_64_7
		}
	end

	return var_64_0
end

function var_0_0.createRoundData(arg_65_0)
	local var_65_0 = 0

	arg_65_0.rounds = {}
	LaunchBallGameVo = var_2

	local var_65_1 = var_2.gameStepTime

	for iter_65_0 = 1, #arg_65_0.roundDatas do
		local var_65_2 = arg_65_0.roundDatas[iter_65_0].weight
		local var_65_3 = var_7.time
		local var_65_4 = var_7.create_id

		if var_65_1 >= var_65_3[1] and var_65_1 <= var_65_3[2] then
			var_65_0 = var_65_0 + var_65_2
			table = var_11

			var_11.insert(arg_65_0.rounds, {
				time = var_65_3,
				weight = var_65_2,
				maxWeight = var_65_0,
				createId = var_65_4
			})
		end
	end

	arg_65_0.maxWeight = var_65_0

	return
end

function var_0_0.checkAmulet(arg_66_0, arg_66_1)
	local var_66_0 = arg_66_1.tf.position

	arg_66_0.fireIndex = arg_66_1.fireIndex

	local var_66_1 = arg_66_1.color

	for iter_66_0 = 1, #arg_66_0.enemysList do
		local var_66_2 = arg_66_0.pointsList[iter_66_0]

		for iter_66_1 = #arg_66_0.enemysList[iter_66_0], 1, -1 do
			local var_66_3 = var_9[iter_66_1]
			local var_66_4 = var_9[iter_66_1]
			local var_66_5, var_66_6 = var_15.checkWorldInRect(var_66_4, var_66_0)

			if var_66_6 and var_66_6 < var_0_4 then
				arg_66_1.overCount = arg_66_1.overCount + 1
			end

			if var_66_5 ~= 0 then
				arg_66_0.amuletOverFlag = false

				if arg_66_1.concentrate then
					local var_66_7 = var_9[iter_66_1]

					if not var_17.getTimeRemove(var_66_7) then
						local var_66_8 = var_9[iter_66_1]

						var_17.setTimeRemove(var_66_8)

						local var_66_9

						if arg_66_0._eventCall then
							LaunchBallGameVo = var_66_9
							var_66_9 = var_66_9.GetScore(1, 1)
							var_66_8 = arg_66_0._eventCall
							LaunchBallGameScene = var_19

							var_66_8(var_19.SPILT_ENEMY_SCORE, {
								num = var_66_9
							})
						end

						LaunchBallGameVo = var_66_9

						local var_66_10 = var_66_9.GetBuff

						LaunchBallPlayerControl = var_66_8

						if var_66_10(var_66_8.buff_time_max) and arg_66_0.enemyStopTime then
							local var_66_11 = arg_66_0.enemyStopTime

							if 0 < var_66_11 then
								LaunchBallGameVo = var_66_11

								local var_66_12 = var_66_11.AddGameResultData

								LaunchBallGameVo = var_18

								var_66_12(var_18.result_skill_count, 1)
							end
						end
					end

					return false
				else
					local var_66_13 = var_66_3:getDistance()

					if var_66_5 == 1 then
						var_66_13 = var_66_13 + var_0_7
					else
						var_66_13 = var_66_13 - var_0_7
					end

					if arg_66_1.overCount >= 2 then
						arg_66_0.amuletOverFlag = true
					end

					local var_66_14 = arg_66_0:getEnemyByColor(arg_66_1.color, true)
					local var_66_15 = arg_66_0:createEnemy(iter_66_0, var_66_14, arg_66_0.pointsList[iter_66_0], arg_66_0.enemysList[iter_66_0], var_66_13)

					var_19.setSplitFlag(var_66_15, true)
					var_19:playAnimation("Spawn")

					local var_66_16 = arg_66_0
					local var_66_17 = arg_66_0.getBackBuff(var_66_16)

					LaunchBallGameConst = var_66_16

					local var_66_18 = arg_66_1[var_66_16.amulet_buff_back]

					if var_66_17 or var_66_18 then
						local var_66_19 = arg_66_0
						local var_66_20 = arg_66_0.setBackTime

						LaunchBallPlayerControl = var_24

						var_66_20(var_66_19, var_24.buff_amulet_back_time, #var_9, var_0_9)
					end

					return true
				end
			end
		end
	end

	return false
end

function var_0_0.checkPositionIn(arg_67_0, arg_67_1)
	for iter_67_0 = 1, #arg_67_0.enemysList do
		local var_67_0 = arg_67_0.pointsList[iter_67_0]

		for iter_67_1 = #arg_67_0.enemysList[iter_67_0], 1, -1 do
			local var_67_1 = var_7[iter_67_1]
			local var_67_2 = var_7[iter_67_1]

			if var_13.checkWorldInRect(var_67_2, arg_67_1) ~= 0 then
				return var_67_1
			end
		end
	end

	return false
end

function var_0_0.checkWorldInEnemy(arg_68_0, arg_68_1)
	for iter_68_0 = 1, #arg_68_0.enemysList do
		local var_68_0 = arg_68_0.pointsList[iter_68_0]

		for iter_68_1 = #arg_68_0.enemysList[iter_68_0], 1, -1 do
			local var_68_1 = var_7[iter_68_1]
			local var_68_2 = var_7[iter_68_1]

			if var_13.checkWorldInCircle(var_68_2, arg_68_1) then
				return true
			end
		end
	end

	return false
end

function var_0_0.getBackBuff(arg_69_0)
	LaunchBallGameVo = var_1_10001

	local var_69_0 = var_1_10001.buffs

	for iter_69_0 = 1, #var_69_0 do
		local var_69_1 = var_69_0[iter_69_0].data.type

		LaunchBallPlayerControl = var_1_10007

		if var_69_1 == var_1_10007.buff_amulet_back then
			return true
		end
	end

	return false
end

function var_0_0.getEnemyByColor(arg_70_0, arg_70_1, arg_70_2)
	for iter_70_0 = 1, #arg_70_0.enemyDatas do
		if arg_70_0.enemyDatas[iter_70_0].data.color == arg_70_1 and arg_70_0.enemyDatas[iter_70_0].data.player == arg_70_2 then
			return arg_70_0.enemyDatas[iter_70_0]
		end
	end

	return
end

function var_0_0.setBackTime(arg_71_0, arg_71_1, arg_71_2, arg_71_3)
	arg_71_0.backEnemyTime = arg_71_1
	arg_71_0.moveBackIndex = arg_71_2
	arg_71_0.backSpeed = arg_71_3 or var_0_9

	return
end

function var_0_0.eventCall(arg_72_0, arg_72_1, arg_72_2)
	LaunchBallGameScene = var_1_10003

	if arg_72_1 == var_1_10003.PLAYING_CHANGE then
		-- block empty
	else
		LaunchBallGameScene = var_3

		if arg_72_1 == var_3.FIRE_AMULET then
			-- block empty
		else
			LaunchBallGameScene = var_3

			local var_72_0

			if arg_72_1 == var_3.SPLIT_ALL_ENEMYS then
				var_72_0 = arg_72_2.time

				local var_72_1 = arg_72_2.effect

				arg_72_0.timeRemoveAll = var_72_0
			else
				LaunchBallGameScene = var_72_0

				if arg_72_1 == var_72_0.STOP_ENEMY_TIME then
					arg_72_0.enemyStopTime = arg_72_2.time

					arg_72_0:stopEnemysAnim(true)
				else
					LaunchBallGameScene = var_3

					if arg_72_1 == var_3.SLASH_ENEMY then
						local var_72_2 = arg_72_2.bound
					end
				end
			end
		end
	end

	return
end

function var_0_0.stopEnemysAnim(arg_73_0, arg_73_1)
	for iter_73_0 = 1, #arg_73_0.enemysList do
		local var_73_0 = arg_73_0.pointsList[iter_73_0]

		for iter_73_1 = #arg_73_0.enemysList[iter_73_0], 1, -1 do
			local var_73_1 = var_7[iter_73_1]

			var_12.stopAnim(var_73_1, arg_73_1)
		end
	end

	return
end

function var_0_0.press(arg_74_0, arg_74_1)
	KeyCode = var_1_10002

	if arg_74_1 == var_1_10002.J then
		-- block empty
	end

	return
end

function var_0_0.clear(arg_75_0)
	return
end

return var_0_0
