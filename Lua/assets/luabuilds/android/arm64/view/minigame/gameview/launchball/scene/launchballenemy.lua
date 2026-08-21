local var_0_0 = class("LaunchBallEnemy")
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
	({
		ctor = function(arg_2_0)
			arg_2_0._tf = arg_1_0
			arg_2_0._animator = GetComponent(findTF(arg_2_0._tf, "ad/anim"), typeof(Animator))
			arg_2_0.angleTf = findTF(arg_2_0._tf, "ad/angle")
			arg_2_0.leftBoundPoints = GetComponent(findTF(arg_2_0._tf, "ad/angle/left"), typeof("UnityEngine.PolygonCollider2D")):ToTable()
			arg_2_0.rightBoundPoints = GetComponent(findTF(arg_2_0._tf, "ad/angle/right"), typeof("UnityEngine.PolygonCollider2D")):ToTable()
			arg_2_0.localRotation = Vector3(0, 0, 0)
			arg_2_0.circlePos = findTF(arg_2_0._tf, "ad/angle/circle").anchoredPosition
			arg_2_0.buffIcon = arg_2_0.buffIcon or findTF(arg_2_0._tf, "ad/iconEffect")
			arg_2_0._effectTf = findTF(arg_2_0._tf, "ad/effect")
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
				setActive(arg_3_0.buffIcon:GetChild(iter_3_0), false)
			end

			for iter_3_1 = #arg_3_0._playEffects, 1, -1 do
				setActive(arg_3_0._playEffects[iter_3_1].tf, false)
				table.remove(arg_3_0._playEffects, iter_3_1)
			end

			arg_3_0:stopAnim(false)

			return
		end,
		setBuff = function(arg_4_0, arg_4_1)
			arg_4_0.buffType = arg_4_1

			if arg_4_0.buffType then
				local var_4_0 = LaunchBallGameConst.enemy_buff_data[arg_4_0.buffType].tpl

				for iter_4_0 = 0, arg_4_0.buffIcon.childCount - 1 do
					local var_4_1 = arg_4_0.buffIcon:GetChild(iter_4_0)

					setActive(var_4_1, var_4_1.name == var_4_0)
				end
			else
				for iter_4_1 = 0, arg_4_0.buffIcon.childCount - 1 do
					setActive(arg_4_0.buffIcon:GetChild(iter_4_1), false)
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
			if arg_7_0.buffType and arg_7_0.buffType == LaunchBallGameConst.enemy_buff_streng then
				arg_7_0:setBuff(nil)

				return
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
			arg_9_0._animator:Play(arg_9_1)

			return
		end,
		setActive = function(arg_10_0, arg_10_1)
			setActive(arg_10_0._tf, arg_10_1)

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
			if arg_14_0.timeToRemove and arg_14_0.timeToRemove > 0 then
				arg_14_0.timeToRemove = arg_14_0.timeToRemove - LaunchBallGameVo.deltaTime

				if arg_14_0.timeToRemove <= 0 then
					arg_14_0.timeToRemove = nil
					arg_14_0.removeFlag = true
				end
			end

			if #arg_14_0._playEffects > 0 then
				for iter_14_0 = #arg_14_0._playEffects, 1, -1 do
					if arg_14_0._playEffects[iter_14_0].time then
						arg_14_0._playEffects[iter_14_0].time = arg_14_0._playEffects[iter_14_0].time - LaunchBallGameVo.deltaTime
					end

					if arg_14_0._playEffects[iter_14_0].time and arg_14_0._playEffects[iter_14_0].time <= 0 then
						setActive(arg_14_0._playEffects[iter_14_0].tf, false)
						table.remove(arg_14_0._playEffects, iter_14_0)
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

				arg_15_0._tf.anchoredPosition.x = var_15_0.x
				arg_15_0._tf.anchoredPosition.y = var_15_0.y
				arg_15_0._tf.anchoredPosition = arg_15_0._tf.anchoredPosition
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
			arg_19_0._animator.speed = arg_19_1 and 0 or 1

			return
		end,
		checkWorldInCircle = function(arg_20_0, arg_20_1)
			local var_20_0 = arg_20_0.angleTf:InverseTransformPoint(arg_20_1)

			if math.abs(var_20_0.x - arg_20_0.circlePos.x) >= 150 or math.abs(var_20_0.y - arg_20_0.circlePos.y) >= var_0_5 * 2 then
				return false
			end

			if math.sqrt(math.pow(var_20_0.x - arg_20_0.circlePos.x, 2) + math.pow(var_20_0.y - arg_20_0.circlePos.y, 2)) < var_0_5 then
				return true
			end

			return false
		end,
		checkWorldInRect = function(arg_21_0, arg_21_1)
			local var_21_0 = arg_21_0.angleTf:InverseTransformPoint(arg_21_1)
			local var_21_1 = 0
			local var_21_2 = math.sqrt(math.pow(var_21_0.x - arg_21_0.circlePos.x, 2) + math.pow(var_21_0.y - arg_21_0.circlePos.y, 2))

			if var_21_2 > var_0_3 then
				return var_21_1, nil
			end

			if LaunchBallGameVo.PointInRect(var_21_0, arg_21_0.leftBoundPoints[1], arg_21_0.leftBoundPoints[2], arg_21_0.leftBoundPoints[3], arg_21_0.leftBoundPoints[4]) then
				var_21_1 = -1
			elseif LaunchBallGameVo.PointInRect(var_21_0, arg_21_0.rightBoundPoints[1], arg_21_0.rightBoundPoints[2], arg_21_0.rightBoundPoints[3], arg_21_0.rightBoundPoints[4]) then
				var_21_1 = 1
			end

			return var_21_1, var_21_2
		end,
		getPosByDistance = function(arg_22_0, arg_22_1)
			local var_22_0 = math.floor(arg_22_1 * 2)

			if var_0_0.EnemyDistanceData[arg_22_0.enemyIndex][var_22_0] then
				return var_0_0.EnemyDistanceData[arg_22_0.enemyIndex][var_22_0]
			end

			local var_22_1 = var_22_0 / 2

			arg_22_0.distancePosResult = arg_22_0.distancePosResult or Vector2(0, 0)

			local var_22_2 = 1
			local var_22_3 = 0

			for iter_22_0 = 1, #arg_22_0.points do
				if var_22_1 >= arg_22_0.points[iter_22_0].distance then
					var_22_2 = iter_22_0

					if iter_22_0 < #arg_22_0.points then
						var_22_3 = var_22_1 - arg_22_0.points[iter_22_0].distance
						arg_22_0.distancePosResult.x = arg_22_0.points[iter_22_0].pos.x
						arg_22_0.distancePosResult.y = arg_22_0.points[iter_22_0].pos.y
					else
						arg_22_0.distancePosResult.x = arg_22_0.points[iter_22_0].pos.x
						arg_22_0.distancePosResult.y = arg_22_0.points[iter_22_0].pos.y
						var_22_3 = 0
					end
				else
					break
				end
			end

			if var_22_3 ~= 0 then
				arg_22_0.distancePosResult.x = arg_22_0.distancePosResult.x + arg_22_0.points[var_22_2].move.x * var_22_3
				arg_22_0.distancePosResult.y = arg_22_0.distancePosResult.y + arg_22_0.points[var_22_2].move.y * var_22_3
			end

			local var_22_4 = {
				x = arg_22_0.distancePosResult.x,
				y = arg_22_0.distancePosResult.y,
				index = var_22_2
			}

			var_0_0.EnemyDistanceData[arg_22_0.enemyIndex][var_22_0] = {
				x = arg_22_0.distancePosResult.x,
				y = arg_22_0.distancePosResult.y,
				index = var_22_2
			}

			return var_22_4
		end,
		setTimeRemove = function(arg_23_0)
			if arg_23_0.hp > 0 then
				arg_23_0.hp = 0
			end

			pg.CriMgr.GetInstance():PlaySoundEffect_V3(LaunchBallGameVo.SFX_ENEMY_REMOVE)

			if arg_23_0:getBuff(LaunchBallGameConst.enemy_buff_boom) then
				arg_23_0:playEffectAnim("Bomb", var_0_15[arg_23_0:getColor()].anim_name, 0.2)
			end

			arg_23_0:stopAnim(false)
			arg_23_0:playAnimation("Remove")

			arg_23_0.timeToRemove = var_0_2

			return
		end,
		playEffectAnim = function(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
			local var_24_0 = findTF(arg_24_0._effectTf, arg_24_1)

			setActive(var_24_0, true)
			GetComponent(var_24_0, typeof(Animator)):Play(arg_24_2)
			table.insert(arg_24_0._playEffects, {
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
			return arg_30_0._tf:SetSiblingIndex(arg_30_1)
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
	}).ctor({
		ctor = function(arg_2_0)
			arg_2_0._tf = arg_1_0
			arg_2_0._animator = GetComponent(findTF(arg_2_0._tf, "ad/anim"), typeof(Animator))
			arg_2_0.angleTf = findTF(arg_2_0._tf, "ad/angle")
			arg_2_0.leftBoundPoints = GetComponent(findTF(arg_2_0._tf, "ad/angle/left"), typeof("UnityEngine.PolygonCollider2D")):ToTable()
			arg_2_0.rightBoundPoints = GetComponent(findTF(arg_2_0._tf, "ad/angle/right"), typeof("UnityEngine.PolygonCollider2D")):ToTable()
			arg_2_0.localRotation = Vector3(0, 0, 0)
			arg_2_0.circlePos = findTF(arg_2_0._tf, "ad/angle/circle").anchoredPosition
			arg_2_0.buffIcon = arg_2_0.buffIcon or findTF(arg_2_0._tf, "ad/iconEffect")
			arg_2_0._effectTf = findTF(arg_2_0._tf, "ad/effect")
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
				setActive(arg_3_0.buffIcon:GetChild(iter_3_0), false)
			end

			for iter_3_1 = #arg_3_0._playEffects, 1, -1 do
				setActive(arg_3_0._playEffects[iter_3_1].tf, false)
				table.remove(arg_3_0._playEffects, iter_3_1)
			end

			arg_3_0:stopAnim(false)

			return
		end,
		setBuff = function(arg_4_0, arg_4_1)
			arg_4_0.buffType = arg_4_1

			if arg_4_0.buffType then
				local var_4_0 = LaunchBallGameConst.enemy_buff_data[arg_4_0.buffType].tpl

				for iter_4_0 = 0, arg_4_0.buffIcon.childCount - 1 do
					local var_4_1 = arg_4_0.buffIcon:GetChild(iter_4_0)

					setActive(var_4_1, var_4_1.name == var_4_0)
				end
			else
				for iter_4_1 = 0, arg_4_0.buffIcon.childCount - 1 do
					setActive(arg_4_0.buffIcon:GetChild(iter_4_1), false)
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
			if arg_7_0.buffType and arg_7_0.buffType == LaunchBallGameConst.enemy_buff_streng then
				arg_7_0:setBuff(nil)

				return
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
			arg_9_0._animator:Play(arg_9_1)

			return
		end,
		setActive = function(arg_10_0, arg_10_1)
			setActive(arg_10_0._tf, arg_10_1)

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
			if arg_14_0.timeToRemove and arg_14_0.timeToRemove > 0 then
				arg_14_0.timeToRemove = arg_14_0.timeToRemove - LaunchBallGameVo.deltaTime

				if arg_14_0.timeToRemove <= 0 then
					arg_14_0.timeToRemove = nil
					arg_14_0.removeFlag = true
				end
			end

			if #arg_14_0._playEffects > 0 then
				for iter_14_0 = #arg_14_0._playEffects, 1, -1 do
					if arg_14_0._playEffects[iter_14_0].time then
						arg_14_0._playEffects[iter_14_0].time = arg_14_0._playEffects[iter_14_0].time - LaunchBallGameVo.deltaTime
					end

					if arg_14_0._playEffects[iter_14_0].time and arg_14_0._playEffects[iter_14_0].time <= 0 then
						setActive(arg_14_0._playEffects[iter_14_0].tf, false)
						table.remove(arg_14_0._playEffects, iter_14_0)
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

				arg_15_0._tf.anchoredPosition.x = var_15_0.x
				arg_15_0._tf.anchoredPosition.y = var_15_0.y
				arg_15_0._tf.anchoredPosition = arg_15_0._tf.anchoredPosition
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
			arg_19_0._animator.speed = arg_19_1 and 0 or 1

			return
		end,
		checkWorldInCircle = function(arg_20_0, arg_20_1)
			local var_20_0 = arg_20_0.angleTf:InverseTransformPoint(arg_20_1)

			if math.abs(var_20_0.x - arg_20_0.circlePos.x) >= 150 or math.abs(var_20_0.y - arg_20_0.circlePos.y) >= var_0_5 * 2 then
				return false
			end

			if math.sqrt(math.pow(var_20_0.x - arg_20_0.circlePos.x, 2) + math.pow(var_20_0.y - arg_20_0.circlePos.y, 2)) < var_0_5 then
				return true
			end

			return false
		end,
		checkWorldInRect = function(arg_21_0, arg_21_1)
			local var_21_0 = arg_21_0.angleTf:InverseTransformPoint(arg_21_1)
			local var_21_1 = 0
			local var_21_2 = math.sqrt(math.pow(var_21_0.x - arg_21_0.circlePos.x, 2) + math.pow(var_21_0.y - arg_21_0.circlePos.y, 2))

			if var_21_2 > var_0_3 then
				return var_21_1, nil
			end

			if LaunchBallGameVo.PointInRect(var_21_0, arg_21_0.leftBoundPoints[1], arg_21_0.leftBoundPoints[2], arg_21_0.leftBoundPoints[3], arg_21_0.leftBoundPoints[4]) then
				var_21_1 = -1
			elseif LaunchBallGameVo.PointInRect(var_21_0, arg_21_0.rightBoundPoints[1], arg_21_0.rightBoundPoints[2], arg_21_0.rightBoundPoints[3], arg_21_0.rightBoundPoints[4]) then
				var_21_1 = 1
			end

			return var_21_1, var_21_2
		end,
		getPosByDistance = function(arg_22_0, arg_22_1)
			local var_22_0 = math.floor(arg_22_1 * 2)

			if var_0_0.EnemyDistanceData[arg_22_0.enemyIndex][var_22_0] then
				return var_0_0.EnemyDistanceData[arg_22_0.enemyIndex][var_22_0]
			end

			local var_22_1 = var_22_0 / 2

			arg_22_0.distancePosResult = arg_22_0.distancePosResult or Vector2(0, 0)

			local var_22_2 = 1
			local var_22_3 = 0

			for iter_22_0 = 1, #arg_22_0.points do
				if var_22_1 >= arg_22_0.points[iter_22_0].distance then
					var_22_2 = iter_22_0

					if iter_22_0 < #arg_22_0.points then
						var_22_3 = var_22_1 - arg_22_0.points[iter_22_0].distance
						arg_22_0.distancePosResult.x = arg_22_0.points[iter_22_0].pos.x
						arg_22_0.distancePosResult.y = arg_22_0.points[iter_22_0].pos.y
					else
						arg_22_0.distancePosResult.x = arg_22_0.points[iter_22_0].pos.x
						arg_22_0.distancePosResult.y = arg_22_0.points[iter_22_0].pos.y
						var_22_3 = 0
					end
				else
					break
				end
			end

			if var_22_3 ~= 0 then
				arg_22_0.distancePosResult.x = arg_22_0.distancePosResult.x + arg_22_0.points[var_22_2].move.x * var_22_3
				arg_22_0.distancePosResult.y = arg_22_0.distancePosResult.y + arg_22_0.points[var_22_2].move.y * var_22_3
			end

			local var_22_4 = {
				x = arg_22_0.distancePosResult.x,
				y = arg_22_0.distancePosResult.y,
				index = var_22_2
			}

			var_0_0.EnemyDistanceData[arg_22_0.enemyIndex][var_22_0] = {
				x = arg_22_0.distancePosResult.x,
				y = arg_22_0.distancePosResult.y,
				index = var_22_2
			}

			return var_22_4
		end,
		setTimeRemove = function(arg_23_0)
			if arg_23_0.hp > 0 then
				arg_23_0.hp = 0
			end

			pg.CriMgr.GetInstance():PlaySoundEffect_V3(LaunchBallGameVo.SFX_ENEMY_REMOVE)

			if arg_23_0:getBuff(LaunchBallGameConst.enemy_buff_boom) then
				arg_23_0:playEffectAnim("Bomb", var_0_15[arg_23_0:getColor()].anim_name, 0.2)
			end

			arg_23_0:stopAnim(false)
			arg_23_0:playAnimation("Remove")

			arg_23_0.timeToRemove = var_0_2

			return
		end,
		playEffectAnim = function(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
			local var_24_0 = findTF(arg_24_0._effectTf, arg_24_1)

			setActive(var_24_0, true)
			GetComponent(var_24_0, typeof(Animator)):Play(arg_24_2)
			table.insert(arg_24_0._playEffects, {
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
			return arg_30_0._tf:SetSiblingIndex(arg_30_1)
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
	})

	return {
		ctor = function(arg_2_0)
			arg_2_0._tf = arg_1_0
			arg_2_0._animator = GetComponent(findTF(arg_2_0._tf, "ad/anim"), typeof(Animator))
			arg_2_0.angleTf = findTF(arg_2_0._tf, "ad/angle")
			arg_2_0.leftBoundPoints = GetComponent(findTF(arg_2_0._tf, "ad/angle/left"), typeof("UnityEngine.PolygonCollider2D")):ToTable()
			arg_2_0.rightBoundPoints = GetComponent(findTF(arg_2_0._tf, "ad/angle/right"), typeof("UnityEngine.PolygonCollider2D")):ToTable()
			arg_2_0.localRotation = Vector3(0, 0, 0)
			arg_2_0.circlePos = findTF(arg_2_0._tf, "ad/angle/circle").anchoredPosition
			arg_2_0.buffIcon = arg_2_0.buffIcon or findTF(arg_2_0._tf, "ad/iconEffect")
			arg_2_0._effectTf = findTF(arg_2_0._tf, "ad/effect")
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
				setActive(arg_3_0.buffIcon:GetChild(iter_3_0), false)
			end

			for iter_3_1 = #arg_3_0._playEffects, 1, -1 do
				setActive(arg_3_0._playEffects[iter_3_1].tf, false)
				table.remove(arg_3_0._playEffects, iter_3_1)
			end

			arg_3_0:stopAnim(false)

			return
		end,
		setBuff = function(arg_4_0, arg_4_1)
			arg_4_0.buffType = arg_4_1

			if arg_4_0.buffType then
				local var_4_0 = LaunchBallGameConst.enemy_buff_data[arg_4_0.buffType].tpl

				for iter_4_0 = 0, arg_4_0.buffIcon.childCount - 1 do
					local var_4_1 = arg_4_0.buffIcon:GetChild(iter_4_0)

					setActive(var_4_1, var_4_1.name == var_4_0)
				end
			else
				for iter_4_1 = 0, arg_4_0.buffIcon.childCount - 1 do
					setActive(arg_4_0.buffIcon:GetChild(iter_4_1), false)
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
			if arg_7_0.buffType and arg_7_0.buffType == LaunchBallGameConst.enemy_buff_streng then
				arg_7_0:setBuff(nil)

				return
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
			arg_9_0._animator:Play(arg_9_1)

			return
		end,
		setActive = function(arg_10_0, arg_10_1)
			setActive(arg_10_0._tf, arg_10_1)

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
			if arg_14_0.timeToRemove and arg_14_0.timeToRemove > 0 then
				arg_14_0.timeToRemove = arg_14_0.timeToRemove - LaunchBallGameVo.deltaTime

				if arg_14_0.timeToRemove <= 0 then
					arg_14_0.timeToRemove = nil
					arg_14_0.removeFlag = true
				end
			end

			if #arg_14_0._playEffects > 0 then
				for iter_14_0 = #arg_14_0._playEffects, 1, -1 do
					if arg_14_0._playEffects[iter_14_0].time then
						arg_14_0._playEffects[iter_14_0].time = arg_14_0._playEffects[iter_14_0].time - LaunchBallGameVo.deltaTime
					end

					if arg_14_0._playEffects[iter_14_0].time and arg_14_0._playEffects[iter_14_0].time <= 0 then
						setActive(arg_14_0._playEffects[iter_14_0].tf, false)
						table.remove(arg_14_0._playEffects, iter_14_0)
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

				arg_15_0._tf.anchoredPosition.x = var_15_0.x
				arg_15_0._tf.anchoredPosition.y = var_15_0.y
				arg_15_0._tf.anchoredPosition = arg_15_0._tf.anchoredPosition
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
			arg_19_0._animator.speed = arg_19_1 and 0 or 1

			return
		end,
		checkWorldInCircle = function(arg_20_0, arg_20_1)
			local var_20_0 = arg_20_0.angleTf:InverseTransformPoint(arg_20_1)

			if math.abs(var_20_0.x - arg_20_0.circlePos.x) >= 150 or math.abs(var_20_0.y - arg_20_0.circlePos.y) >= var_0_5 * 2 then
				return false
			end

			if math.sqrt(math.pow(var_20_0.x - arg_20_0.circlePos.x, 2) + math.pow(var_20_0.y - arg_20_0.circlePos.y, 2)) < var_0_5 then
				return true
			end

			return false
		end,
		checkWorldInRect = function(arg_21_0, arg_21_1)
			local var_21_0 = arg_21_0.angleTf:InverseTransformPoint(arg_21_1)
			local var_21_1 = 0
			local var_21_2 = math.sqrt(math.pow(var_21_0.x - arg_21_0.circlePos.x, 2) + math.pow(var_21_0.y - arg_21_0.circlePos.y, 2))

			if var_21_2 > var_0_3 then
				return var_21_1, nil
			end

			if LaunchBallGameVo.PointInRect(var_21_0, arg_21_0.leftBoundPoints[1], arg_21_0.leftBoundPoints[2], arg_21_0.leftBoundPoints[3], arg_21_0.leftBoundPoints[4]) then
				var_21_1 = -1
			elseif LaunchBallGameVo.PointInRect(var_21_0, arg_21_0.rightBoundPoints[1], arg_21_0.rightBoundPoints[2], arg_21_0.rightBoundPoints[3], arg_21_0.rightBoundPoints[4]) then
				var_21_1 = 1
			end

			return var_21_1, var_21_2
		end,
		getPosByDistance = function(arg_22_0, arg_22_1)
			local var_22_0 = math.floor(arg_22_1 * 2)

			if var_0_0.EnemyDistanceData[arg_22_0.enemyIndex][var_22_0] then
				return var_0_0.EnemyDistanceData[arg_22_0.enemyIndex][var_22_0]
			end

			local var_22_1 = var_22_0 / 2

			arg_22_0.distancePosResult = arg_22_0.distancePosResult or Vector2(0, 0)

			local var_22_2 = 1
			local var_22_3 = 0

			for iter_22_0 = 1, #arg_22_0.points do
				if var_22_1 >= arg_22_0.points[iter_22_0].distance then
					var_22_2 = iter_22_0

					if iter_22_0 < #arg_22_0.points then
						var_22_3 = var_22_1 - arg_22_0.points[iter_22_0].distance
						arg_22_0.distancePosResult.x = arg_22_0.points[iter_22_0].pos.x
						arg_22_0.distancePosResult.y = arg_22_0.points[iter_22_0].pos.y
					else
						arg_22_0.distancePosResult.x = arg_22_0.points[iter_22_0].pos.x
						arg_22_0.distancePosResult.y = arg_22_0.points[iter_22_0].pos.y
						var_22_3 = 0
					end
				else
					break
				end
			end

			if var_22_3 ~= 0 then
				arg_22_0.distancePosResult.x = arg_22_0.distancePosResult.x + arg_22_0.points[var_22_2].move.x * var_22_3
				arg_22_0.distancePosResult.y = arg_22_0.distancePosResult.y + arg_22_0.points[var_22_2].move.y * var_22_3
			end

			local var_22_4 = {
				x = arg_22_0.distancePosResult.x,
				y = arg_22_0.distancePosResult.y,
				index = var_22_2
			}

			var_0_0.EnemyDistanceData[arg_22_0.enemyIndex][var_22_0] = {
				x = arg_22_0.distancePosResult.x,
				y = arg_22_0.distancePosResult.y,
				index = var_22_2
			}

			return var_22_4
		end,
		setTimeRemove = function(arg_23_0)
			if arg_23_0.hp > 0 then
				arg_23_0.hp = 0
			end

			pg.CriMgr.GetInstance():PlaySoundEffect_V3(LaunchBallGameVo.SFX_ENEMY_REMOVE)

			if arg_23_0:getBuff(LaunchBallGameConst.enemy_buff_boom) then
				arg_23_0:playEffectAnim("Bomb", var_0_15[arg_23_0:getColor()].anim_name, 0.2)
			end

			arg_23_0:stopAnim(false)
			arg_23_0:playAnimation("Remove")

			arg_23_0.timeToRemove = var_0_2

			return
		end,
		playEffectAnim = function(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
			local var_24_0 = findTF(arg_24_0._effectTf, arg_24_1)

			setActive(var_24_0, true)
			GetComponent(var_24_0, typeof(Animator)):Play(arg_24_2)
			table.insert(arg_24_0._playEffects, {
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
			return arg_30_0._tf:SetSiblingIndex(arg_30_1)
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
end

var_0_0.EnemyDistanceData = {}

function var_0_0.Ctor(arg_33_0, arg_33_1, arg_33_2, arg_33_3, arg_33_4)
	arg_33_0._enemyContent = arg_33_1
	arg_33_0._lineContent = arg_33_2
	arg_33_0._tpl = arg_33_3
	arg_33_0._eventCall = arg_33_4
	arg_33_0._enemyTpl = findTF(arg_33_0._tpl, "Enemy")
	arg_33_0.enemyDatas = {}

	for iter_33_0, iter_33_1 in pairs(LaunchBallGameConst.enemy_data) do
		table.insert(arg_33_0.enemyDatas, {
			animator = LoadAny(LaunchBallGameVo.ui_atlas, iter_33_1.name, typeof(RuntimeAnimatorController)),
			data = iter_33_1
		})
	end

	arg_33_0.enemyRule = Clone(LaunchBallGameConst.enemy_create_rule)
	arg_33_0.enemysList = {}
	arg_33_0.enemyPool = {}
	arg_33_0.colliderTestTf = findTF(arg_33_0._enemyContent, "colliderTest")

	setActive(arg_33_0.colliderTestTf, false)

	return
end

function var_0_0.start(arg_34_0)
	arg_34_0.moveSpeed = LaunchBallGameVo.gameRoundData.speed
	var_0_0.EnemyDistanceData = {}
	arg_34_0.gameRoundData = LaunchBallGameVo.gameRoundData
	arg_34_0._enemyContent.sizeDelta = LaunchBallGameConst.enemy_round_bound[arg_34_0.gameRoundData.round_bound]
	arg_34_0.roundDatas = Clone(LaunchBallGameConst.round_enemy[arg_34_0.gameRoundData.round_enemy])
	arg_34_0.lineData = Clone(LaunchBallGameConst.map_data[arg_34_0.gameRoundData.map])
	arg_34_0.enemyBuffs = Clone(LaunchBallGameConst.enemy_round_buff[arg_34_0.gameRoundData.enemy_buff])

	arg_34_0:createRoundData()

	arg_34_0.currentEnemyRule = arg_34_0:getEnemyRule()

	if arg_34_0.lineTf then
		setActive(arg_34_0.lineTf, false)
	end

	arg_34_0.lineTf = findTF(arg_34_0._lineContent, arg_34_0.lineData.line)

	setActive(arg_34_0.lineTf, true)

	for iter_34_0, iter_34_1 in ipairs(arg_34_0.enemysList) do
		for iter_34_2 = #iter_34_1, 1, -1 do
			arg_34_0:returnEnemy(table.remove(iter_34_1, iter_34_2))
		end
	end

	arg_34_0.pointsList = {}
	arg_34_0.enemysList = {}

	local var_34_0 = findTF(arg_34_0.lineTf, "ad/points")

	if var_34_0 then
		table.insert(arg_34_0.pointsList, (arg_34_0:createPoints(var_34_0)))
		table.insert(arg_34_0.enemysList, {})

		var_0_0.EnemyDistanceData[1] = {}
	end

	local var_34_1 = findTF(arg_34_0.lineTf, "ad/points1")

	if var_34_1 then
		table.insert(arg_34_0.pointsList, (arg_34_0:createPoints(var_34_1)))
		table.insert(arg_34_0.enemysList, {})

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
			table.insert(arg_36_0.lastPointDistance, arg_36_0.pointsList[iter_36_0][#arg_36_0.pointsList[iter_36_0]].distance)
		end
	end

	local var_36_0 = {}

	for iter_36_1 = 1, #arg_36_0.enemysList do
		if arg_36_0.enemysList[iter_36_1] and #arg_36_0.enemysList[iter_36_1] > 0 then
			table.insert(var_36_0, math.floor(arg_36_0.enemysList[iter_36_1][#arg_36_0.enemysList[iter_36_1]]:getDistance() / arg_36_0.lastPointDistance[iter_36_1] * 10))
		end
	end

	LaunchBallGameVo.enemyToEndRate = var_36_0

	return
end

function var_0_0.checkEnemyDataUpdate(arg_37_0)
	if arg_37_0.currentEnemyRule == nil then
		arg_37_0.currentEnemyRule = arg_37_0:getEnemyRule()
	end

	return
end

function var_0_0.checkTargetScore(arg_38_0)
	if LaunchBallGameVo.gameRoundData.target and LaunchBallGameVo.scoreNum >= LaunchBallGameVo.gameRoundData.target then
		return true
	end

	return false
end

function var_0_0.checkCreateEnemy(arg_39_0)
	if arg_39_0:checkTargetScore() then
		return
	end

	for iter_39_0 = 1, #arg_39_0.enemysList do
		if #arg_39_0.enemysList[iter_39_0] > 0 then
			if arg_39_0.enemysList[iter_39_0][1]:getDistance() > var_0_6 then
				arg_39_0:createRandomEnemy(iter_39_0, arg_39_0.pointsList[iter_39_0], arg_39_0.enemysList[iter_39_0], 1, 0, true)

				break
			end
		else
			arg_39_0:createRandomEnemy(iter_39_0, arg_39_0.pointsList[iter_39_0], arg_39_0.enemysList[iter_39_0], 1, 0, true)

			break
		end
	end

	return
end

function var_0_0.checkRemoveEnemy(arg_40_0)
	for iter_40_0, iter_40_1 in ipairs(arg_40_0.enemysList) do
		for iter_40_2 = #iter_40_1, 1, -1 do
			iter_40_1[iter_40_2]:step()

			if iter_40_1[iter_40_2]:getRemoveFlag() then
				local var_40_1 = iter_40_1[iter_40_2]:getBuff()

				if var_40_1 then
					arg_40_0:appearEnemyBuff(var_40_1, iter_40_2, iter_40_1[iter_40_2], iter_40_1)
				end

				arg_40_0:returnEnemy(table.remove(iter_40_1, iter_40_2))
			end
		end
	end

	if arg_40_0.timeRemoveAll and arg_40_0.timeRemoveAll > 0 then
		arg_40_0.timeRemoveAll = arg_40_0.timeRemoveAll - LaunchBallGameVo.deltaTime

		if arg_40_0.timeRemoveAll <= 0 then
			local var_40_3 = 0

			for iter_40_3, iter_40_4 in ipairs(arg_40_0.enemysList) do
				for iter_40_5 = #iter_40_4, 1, -1 do
					if not iter_40_4[iter_40_5]:getRemoveFlag() then
						iter_40_4[iter_40_5]:setTimeRemove()

						var_40_3 = var_40_3 + 1

						arg_40_0._eventCall(LaunchBallGameScene.SPILT_ENEMY_SCORE, {
							num = LaunchBallGameVo.GetScore(1, 1)
						})
					end
				end
			end

			LaunchBallGameVo.UpdateGameResultData(LaunchBallGameVo.result_skill_count, var_40_3)

			arg_40_0.timeRemoveAll = nil
		end
	end

	return
end

function var_0_0.appearEnemyBuff(arg_41_0, arg_41_1, arg_41_2, arg_41_3, arg_41_4)
	if arg_41_1 == LaunchBallGameConst.enemy_buff_slow then
		arg_41_0.slowTime = LaunchBallGameConst.enemy_buff_data[arg_41_1].time

		if LaunchBallGameVo.GetBuff(LaunchBallPlayerControl.buff_time_max) then
			arg_41_0.slowTime = arg_41_0.slowTime * 1.5

			LaunchBallGameVo.AddGameResultData(LaunchBallGameVo.result_use_pass_skill, 1)

			if arg_41_0.enemyStopTime and arg_41_0.enemyStopTime > 0 then
				arg_41_0.enemyStopTime = arg_41_0.enemyStopTime + 3
			end
		end
	elseif arg_41_1 == LaunchBallGameConst.enemy_buff_back then
		arg_41_0.backEnemyTime = LaunchBallGameConst.enemy_buff_data[arg_41_1].time
		arg_41_0.backSpeed = var_0_10
		arg_41_0.moveBackIndex = #arg_41_4

		if LaunchBallGameVo.GetBuff(LaunchBallPlayerControl.buff_time_max) then
			arg_41_0.backEnemyTime = arg_41_0.backEnemyTime * 1.3

			LaunchBallGameVo.AddGameResultData(LaunchBallGameVo.result_use_pass_skill, 1)
		end
	elseif arg_41_1 == LaunchBallGameConst.enemy_buff_boom then
		local var_41_0 = arg_41_3:getDistance()

		for iter_41_0 = 1, #arg_41_4 do
			if not arg_41_4[iter_41_0]:getRemoveFlag() and LaunchBallGameConst.enemy_buff_data[arg_41_1].distance >= math.abs(arg_41_4[iter_41_0]:getDistance() - var_41_0) then
				arg_41_4[iter_41_0]:setTimeRemove()
				arg_41_0._eventCall(LaunchBallGameScene.SPILT_ENEMY_SCORE, {
					num = LaunchBallGameVo.GetScore(1, 1)
				})
			end
		end
	elseif arg_41_1 == LaunchBallGameConst.enemy_buff_concentrate then
		arg_41_0._eventCall(LaunchBallGameScene.CONCENTRATE_TRIGGER, LaunchBallGameConst.enemy_buff_data[arg_41_1])
	end

	return
end

function var_0_0.moveEnmey(arg_42_0)
	local var_42_0

	if arg_42_0.enemyStopTime and arg_42_0.enemyStopTime > 0 then
		arg_42_0.enemyStopTime = arg_42_0.enemyStopTime - LaunchBallGameVo.deltaTime

		if arg_42_0.enemyStopTime <= 0 then
			arg_42_0.enemyStopTime = nil

			arg_42_0:stopEnemysAnim(false)
		end

		LaunchBallGameVo.enemyStopTime = arg_42_0.enemyStopTime
	end

	if arg_42_0.enemyStopTime and arg_42_0.enemyStopTime > 0 then
		return
	end

	if arg_42_0.backEnemyTime and arg_42_0.backEnemyTime > 0 then
		arg_42_0.backEnemyTime = arg_42_0.backEnemyTime - LaunchBallGameVo.deltaTime

		if arg_42_0.backEnemyTime <= 0 then
			arg_42_0.backEnemyTime = nil
		end

		var_42_0 = arg_42_0.backSpeed * LaunchBallGameVo.deltaTime
	else
		var_42_0 = arg_42_0.moveSpeed * LaunchBallGameVo.deltaTime
	end

	if arg_42_0.slowTime and arg_42_0.slowTime > 0 then
		var_42_0 = var_42_0 / 3
		arg_42_0.slowTime = arg_42_0.slowTime - LaunchBallGameVo.deltaTime

		if arg_42_0.slowTime < 0 then
			arg_42_0.slowTime = nil
		end
	end

	for iter_42_0, iter_42_1 in ipairs(arg_42_0.enemysList) do
		local var_42_2 = 0

		if var_42_0 > 0 then
			for iter_42_2 = 1, #iter_42_1 do
				local var_42_3 = false

				if iter_42_2 < #iter_42_1 and iter_42_1[iter_42_2]:getDistance() < var_0_6 and iter_42_1[iter_42_2 + 1]:getDistance() < var_0_6 then
					var_42_3 = true
				end

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

				if iter_42_3 <= arg_42_0.moveBackIndex and var_42_2 == 0 then
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

function var_0_0.checkEnemyQuick(arg_43_0)
	if arg_43_0.backFlag then
		return
	end

	arg_43_0.quickFlag = false

	for iter_43_0, iter_43_1 in ipairs(arg_43_0.enemysList) do
		local var_43_0 = 0

		for iter_43_2 = 1, #iter_43_1 do
			if iter_43_2 <= #iter_43_1 - 1 then
				if iter_43_1[iter_43_2 + 1]:getDistance() > var_0_6 and iter_43_1[iter_43_2 + 1]:getDistance() - iter_43_1[iter_43_2]:getDistance() < var_0_6 - var_0_14 then
					var_43_0 = iter_43_2 + 1
					arg_43_0.quickFlag = true

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

function var_0_0.checkEnemyBack(arg_44_0)
	arg_44_0.backFlag = false

	if not arg_44_0.quickFlag then
		for iter_44_0, iter_44_1 in ipairs(arg_44_0.enemysList) do
			local var_44_0 = 0

			for iter_44_2 = 1, #iter_44_1 do
				if iter_44_2 > 1 and var_44_0 == 0 and iter_44_1[iter_44_2]:getDistance() - iter_44_1[iter_44_2 - 1]:getDistance() > var_0_6 + var_0_14 and iter_44_1[iter_44_2]:getSplitFlag() and iter_44_1[iter_44_2]:getColor() == iter_44_1[iter_44_2 - 1]:getColor() then
					var_44_0 = iter_44_2
					arg_44_0.backEnemyFlag = arg_44_0.backEnemyFlag or true
				end
			end

			if var_44_0 ~= 0 then
				arg_44_0.backFlag = true
				arg_44_0.moveBackIndex = 0

				for iter_44_3 = 1, #iter_44_1 do
					if iter_44_3 == var_44_0 then
						arg_44_0.moveBackIndex = iter_44_3

						iter_44_1[iter_44_3]:move(var_0_13 * LaunchBallGameVo.deltaTime)
					elseif var_44_0 < iter_44_3 then
						if iter_44_1[iter_44_3]:getDistance() - iter_44_1[iter_44_3 - 1]:getDistance() < var_0_6 + var_0_14 then
							iter_44_1[iter_44_3]:move(var_0_13 * LaunchBallGameVo.deltaTime)

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

	for iter_45_0, iter_45_1 in ipairs(arg_45_0.enemysList) do
		for iter_45_2 = 1, #iter_45_1 do
			if iter_45_1[iter_45_2]:getTimeRemove() then
				arg_45_0.enemyTimeRemoveFlag = true
			end
		end
	end

	return
end

function var_0_0.checkEnemySplit(arg_46_0)
	if not arg_46_0.enemyTimeRemoveFlag and not arg_46_0.backFlag and not arg_46_0.quickFlag and not arg_46_0.backEnemyFlag then
		for iter_46_0, iter_46_1 in ipairs(arg_46_0.enemysList) do
			for iter_46_2 = 1, #iter_46_1 do
				if iter_46_1[iter_46_2]:getSplitFlag() then
					local var_46_1, var_46_2, var_46_3 = arg_46_0:checkSplit(iter_46_2, iter_46_1)

					iter_46_1[iter_46_2]:setSplitFlag(false)

					if var_46_1 >= 3 or var_46_2 then
						arg_46_0.seriesCount = arg_46_0.seriesCount + 1

						if arg_46_0.splitFireIndex and arg_46_0.splitFireIndex + 1 >= arg_46_0.fireIndex then
							LaunchBallGameVo.AddGameResultData(LaunchBallGameVo.result_series_count, 1)

							arg_46_0.seriesCombat = not arg_46_0.seriesCombat and 1 or arg_46_0.seriesCombat + 1
						else
							arg_46_0.seriesCombat = 0
						end

						if arg_46_0.amuletOverFlag then
							LaunchBallGameVo.AddGameResultData(LaunchBallGameVo.result_over_count, 1)
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
	if arg_47_0:checkTargetScore() then
		local var_47_0 = 0

		for iter_47_0, iter_47_1 in ipairs(arg_47_0.enemysList) do
			var_47_0 = var_47_0 + #iter_47_1
		end

		if var_47_0 == 0 then
			arg_47_0._eventCall(LaunchBallGameScene.ENEMY_FINISH)

			return
		end
	end

	for iter_47_2, iter_47_3 in ipairs(arg_47_0.enemysList) do
		if iter_47_3 and #iter_47_3 > 0 and iter_47_3[#iter_47_3]:getFinish() then
			arg_47_0._eventCall(LaunchBallGameScene.ENEMY_FINISH)

			return
		end
	end

	return
end

function var_0_0.updateEnemyVo(arg_48_0)
	for iter_48_0, iter_48_1 in ipairs(arg_48_0.enemysList) do
		for iter_48_2 = 1, #iter_48_1 do
			local var_48_0 = iter_48_1[iter_48_2]:getColor()

			if not table.contains({}, var_48_0) then
				table.insert({}, var_48_0)

				if #{} >= LaunchBallGameConst.color_total then
					LaunchBallGameVo.enemyColors = {}

					return
				end
			end
		end
	end

	LaunchBallGameVo.enemyColors = {}

	return
end

function var_0_0.updateGameResultSplitCount(arg_49_0, arg_49_1, arg_49_2)
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

function var_0_0.checkSplit(arg_50_0, arg_50_1, arg_50_2)
	local var_50_0 = arg_50_2[arg_50_1]:getColor()
	local var_50_1 = 1
	local var_50_2 = false

	if arg_50_1 > 1 then
		for iter_50_0 = arg_50_1 - 1, 1, -1 do
			if arg_50_2[iter_50_0]:getColor() == var_50_0 then
				table.insert({
					arg_50_2[arg_50_1]
				}, arg_50_2[iter_50_0])

				var_50_1 = var_50_1 + 1
			else
				break
			end
		end
	end

	local var_50_3

	if arg_50_1 < #arg_50_2 then
		for iter_50_1 = arg_50_1 + 1, #arg_50_2 do
			if arg_50_2[iter_50_1]:getColor() == var_50_0 then
				table.insert({
					arg_50_2[arg_50_1]
				}, arg_50_2[iter_50_1])

				var_50_1 = var_50_1 + 1
			else
				var_50_3 = arg_50_2[iter_50_1]

				break
			end
		end
	end

	if var_50_1 >= 3 then
		var_50_2 = true
	end

	if var_50_1 >= 3 and not var_50_2 then
		print("")
	end

	if var_50_2 and var_50_3 then
		var_50_3:setSplitFlag(true)
	end

	if var_50_2 then
		for iter_50_2 = 1, #{
			arg_50_2[arg_50_1]
		} do
			({
				arg_50_2[arg_50_1]
			})[iter_50_2]:hit()
		end

		if arg_50_0._eventCall then
			arg_50_0._eventCall(LaunchBallGameScene.SPILT_ENEMY_SCORE, {
				split = true,
				num = LaunchBallGameVo.GetScore(var_50_1, arg_50_0.seriesCount, arg_50_0.amuletOverFlag),
				count = var_50_1
			})

			if LaunchBallGameVo.GetBuff(LaunchBallPlayerControl.buff_time_max) and arg_50_0.enemyStopTime and arg_50_0.enemyStopTime > 0 then
				LaunchBallGameVo.AddGameResultData(LaunchBallGameVo.result_skill_count, var_50_1)
			end
		end

		arg_50_0:updateGameResultSplitCount(var_50_1, arg_50_0.seriesCount)

		if not var_50_3 then
			arg_50_0.seriesCount = 0
		end
	end

	return var_50_1, var_50_2
end

function var_0_0.createPoints(arg_51_0, arg_51_1)
	local var_51_0 = 0
	local var_51_1 = GetComponent(arg_51_1, "EdgeCollider2D").points:ToTable()

	for iter_51_0, iter_51_1 in ipairs(var_51_1) do
		local var_51_2 = Vector2(0, 0)
		local var_51_3 = Vector2(0, 0)
		local var_51_5 = 0

		if iter_51_0 > 1 then
			var_51_0 = var_51_0 + math.sqrt(math.pow(var_51_1[iter_51_0].x - var_51_1[iter_51_0 - 1].x, 2) + math.pow(var_51_1[iter_51_0].y - var_51_1[iter_51_0 - 1].y, 2))
		end

		if iter_51_0 < #var_51_1 then
			local var_51_6 = math.atan(math.abs(var_51_1[iter_51_0 + 1].y - var_51_1[iter_51_0].y) / math.abs(var_51_1[iter_51_0 + 1].x - var_51_1[iter_51_0].x))

			var_51_5 = math.atan2(var_51_1[iter_51_0 + 1].y - var_51_1[iter_51_0].y, var_51_1[iter_51_0 + 1].x - var_51_1[iter_51_0].x) * math.rad2Deg

			local var_51_7 = var_51_1[iter_51_0 + 1].x > var_51_1[iter_51_0].x and 1 or -1
			local var_51_8 = var_51_1[iter_51_0 + 1].y > var_51_1[iter_51_0].y and 1 or -1

			var_51_3.x = var_51_1[iter_51_0 + 1].x > var_51_1[iter_51_0].x and 1 or -1
			var_51_3.y = var_51_8
			var_51_2.x = math.cos(var_51_6) * var_51_7
			var_51_2.y = math.sin(var_51_6) * var_51_8
		elseif iter_51_0 == #var_51_1 then
			local var_51_9 = math.atan(math.abs(var_51_1[iter_51_0].y - var_51_1[iter_51_0 - 1].y) / math.abs(var_51_1[iter_51_0].x - var_51_1[iter_51_0 - 1].x))

			var_51_5 = math.atan2(var_51_1[iter_51_0].y - var_51_1[iter_51_0 - 1].y, var_51_1[iter_51_0].x - var_51_1[iter_51_0 - 1].x) * math.rad2Deg

			local var_51_10 = var_51_1[iter_51_0].x > var_51_1[iter_51_0 - 1].x and 1 or -1
			local var_51_11 = var_51_1[iter_51_0].y > var_51_1[iter_51_0 - 1].y and 1 or -1

			var_51_3.x = var_51_1[iter_51_0].x > var_51_1[iter_51_0 - 1].x and 1 or -1
			var_51_3.y = var_51_11
			var_51_2.x = math.cos(var_51_9) * var_51_10
			var_51_2.y = math.sin(var_51_9) * var_51_11
		end

		table.insert({}, {
			pos = iter_51_1,
			distance = var_51_0,
			move = var_51_2,
			direct = var_51_3,
			angle = var_51_5
		})
	end

	return {}
end

function var_0_0.createEnemy(arg_52_0, arg_52_1, arg_52_2, arg_52_3, arg_52_4, arg_52_5)
	local var_52_0 = arg_52_0:getOrCreateEnemy()

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
	arg_52_0:sortEnemys(arg_52_4)

	return var_52_0
end

function var_0_0.createRandomEnemy(arg_53_0, arg_53_1, arg_53_2, arg_53_3, arg_53_4, arg_53_5, arg_53_6)
	local var_53_0 = arg_53_0:getEnemyDataByRule()

	if not var_53_0 then
		return
	end

	local var_53_1 = arg_53_0:getOrCreateEnemy()

	var_53_1:setData(arg_53_1, var_53_0)
	var_53_1:setBuff((arg_53_0:getEnemyBuff()))
	var_53_1:setPoints(arg_53_2)
	var_53_1:setActive(true)

	if arg_53_4 and arg_53_4 ~= 0 then
		var_53_1:setPosIndex(arg_53_4)
	elseif arg_53_5 then
		var_53_1:setDistance(arg_53_5)
	end

	table.insert(arg_53_3, var_53_1)
	arg_53_0:sortEnemys(arg_53_3)

	return var_53_1
end

function var_0_0.getEnemyBuff(arg_54_0)
	for iter_54_0 = 1, #arg_54_0.enemyBuffs.buffs do
		local var_54_0 = arg_54_0.enemyBuffs.buffs[iter_54_0]
		local var_54_1 = true

		if arg_54_0.enemyBuffs.buffs[iter_54_0].type == LaunchBallGameConst.enemy_buff_back then
			if arg_54_0:getEnemyByBuff(LaunchBallGameConst.enemy_buff_slow) then
				var_54_1 = false
			end
		elseif var_54_0.type == LaunchBallGameConst.enemy_buff_slow and arg_54_0:getEnemyByBuff(LaunchBallGameConst.enemy_buff_back) then
			var_54_1 = false
		end

		if var_54_1 then
			local var_54_2 = var_54_0.rate[1]

			if LaunchBallGameVo.GetBuff(LaunchBallPlayerControl.buff_time_max) then
				if var_54_0.type == LaunchBallGameConst.enemy_buff_slow then
					var_54_2 = var_54_2 + 2
				elseif var_54_0.type == LaunchBallGameConst.enemy_buff_back then
					var_54_2 = var_54_2 + 2
				end
			end

			if var_54_2 >= math.random(1, var_54_0.rate[2]) then
				table.insert({}, var_54_0.type)
			end
		end
	end

	if #{} > 0 then
		return ({})[math.random(1, #{})]
	end

	return nil
end

function var_0_0.getEnemyByBuff(arg_55_0, arg_55_1)
	for iter_55_0 = 1, #arg_55_0.enemysList do
		for iter_55_1 = #arg_55_0.enemysList[iter_55_0], 1, -1 do
			if arg_55_0.enemysList[iter_55_0][iter_55_1]:getBuff() == arg_55_1 then
				return arg_55_0.enemysList[iter_55_0][iter_55_1]
			end
		end
	end

	return nil
end

function var_0_0.getOrCreateEnemy(arg_56_0)
	local var_56_0

	if #arg_56_0.enemyPool > 0 then
		var_56_0 = table.remove(arg_56_0.enemyPool, 1)
	else
		local var_56_1 = tf(instantiate(arg_56_0._enemyTpl))

		setParent(var_56_1, arg_56_0._enemyContent)

		var_56_0 = var_0_16(var_56_1)
	end

	return var_56_0
end

function var_0_0.sortEnemys(arg_57_0, arg_57_1)
	table.sort(arg_57_1, function(arg_58_0, arg_58_1)
		return arg_58_0:getDistance() < arg_58_1:getDistance()
	end)

	for iter_57_0 = 1, #arg_57_1 do
		arg_57_1[iter_57_0]:setLastLayer(iter_57_0 - 1)
	end

	return
end

function var_0_0.returnEnemy(arg_59_0, arg_59_1)
	arg_59_1:setActive(false)
	table.insert(arg_59_0.enemyPool, arg_59_1)

	return
end

function var_0_0.getEnemyDataByRule(arg_60_0)
	arg_60_0.currentEnemyRule = arg_60_0.currentEnemyRule or arg_60_0:getEnemyRule()

	if #var_0_1 > 0 then
		return arg_60_0:getEnemyById(table.remove(var_0_1, 1))
	end

	if arg_60_0.currentEnemyRule then
		local var_60_0 = arg_60_0.currentEnemyRule.single and arg_60_0.currentEnemyRule.singleId or arg_60_0.currentEnemyRule.enemys[math.random(1, #arg_60_0.currentEnemyRule.enemys)]

		arg_60_0.currentEnemyRule.count = arg_60_0.currentEnemyRule.count - 1

		if arg_60_0.currentEnemyRule.count <= 0 then
			arg_60_0.currentEnemyRule = nil
		end

		return arg_60_0:getEnemyById(var_60_0)
	end

	return nil
end

function var_0_0.getEnemyById(arg_61_0, arg_61_1)
	for iter_61_0 = 1, #arg_61_0.enemyDatas do
		if arg_61_0.enemyDatas[iter_61_0].data.id == arg_61_1 then
			return arg_61_0.enemyDatas[iter_61_0]
		end
	end

	print("找不到id = " .. arg_61_1 .. "的怪物")

	return nil
end

function var_0_0.checkEnemyRuleUpdate(arg_62_0)
	local var_62_0 = false

	for iter_62_0 = 1, #arg_62_0.rounds do
		if LaunchBallGameVo.gameStepTime >= arg_62_0.rounds[iter_62_0].time[2] then
			var_62_0 = true
		end
	end

	if var_62_0 then
		arg_62_0:createRoundData()
	end

	return
end

function var_0_0.getEnemysInBounds(arg_63_0, arg_63_1, arg_63_2)
	local var_63_0 = arg_63_0._enemyContent:InverseTransformPoint(arg_63_1)
	local var_63_1 = arg_63_0._enemyContent:InverseTransformPoint(arg_63_2)

	arg_63_0.colliderTestTf.anchoredPosition = var_63_1

	for iter_63_0 = 1, #arg_63_0.enemysList do
		for iter_63_1 = #arg_63_0.enemysList[iter_63_0], 1, -1 do
			local var_63_3 = arg_63_0.enemysList[iter_63_0][iter_63_1]:getTf().anchoredPosition

			if var_63_3.x > var_63_0.x and var_63_3.x < var_63_1.x and var_63_3.y > var_63_0.y and var_63_3.y < var_63_1.y then
				table.insert({}, arg_63_0.enemysList[iter_63_0][iter_63_1])
			end
		end
	end

	return {}
end

function var_0_0.getEnemyRule(arg_64_0)
	local var_64_0
	local var_64_1 = math.random(0, arg_64_0.maxWeight)
	local var_64_2

	for iter_64_0 = 1, #arg_64_0.rounds do
		if not var_64_2 and var_64_1 <= arg_64_0.rounds[iter_64_0].maxWeight then
			var_64_2 = arg_64_0.rounds[iter_64_0].createId
		end
	end

	if var_64_2 then
		if not arg_64_0.enemyRule[var_64_2] then
			print("create id not exit " .. var_64_2)
		end

		local var_64_3 = arg_64_0.enemyRule[var_64_2].enemy_create.single
		local var_64_4

		if arg_64_0.enemyRule[var_64_2].enemy_create.single then
			var_64_4 = arg_64_0.enemyRule[var_64_2].enemy_create.enemys[math.random(1, #arg_64_0.enemyRule[var_64_2].enemy_create.enemys)]
		end

		var_64_0 = {
			id = arg_64_0.enemyRule[var_64_2].id,
			count = arg_64_0.enemyRule[var_64_2].enemy_create.count,
			enemys = arg_64_0.enemyRule[var_64_2].enemy_create.enemys,
			single = var_64_3,
			singleId = var_64_4
		}
	end

	return var_64_0
end

function var_0_0.createRoundData(arg_65_0)
	local var_65_0 = 0

	arg_65_0.rounds = {}

	for iter_65_0 = 1, #arg_65_0.roundDatas do
		if LaunchBallGameVo.gameStepTime >= arg_65_0.roundDatas[iter_65_0].time[1] and LaunchBallGameVo.gameStepTime <= arg_65_0.roundDatas[iter_65_0].time[2] then
			var_65_0 = var_65_0 + arg_65_0.roundDatas[iter_65_0].weight

			table.insert(arg_65_0.rounds, {
				time = arg_65_0.roundDatas[iter_65_0].time,
				weight = arg_65_0.roundDatas[iter_65_0].weight,
				maxWeight = var_65_0,
				createId = arg_65_0.roundDatas[iter_65_0].create_id
			})
		end
	end

	arg_65_0.maxWeight = var_65_0

	return
end

function var_0_0.checkAmulet(arg_66_0, arg_66_1)
	arg_66_0.fireIndex = arg_66_1.fireIndex

	for iter_66_0 = 1, #arg_66_0.enemysList do
		local var_66_2 = arg_66_0.enemysList[iter_66_0]

		for iter_66_1 = #arg_66_0.enemysList[iter_66_0], 1, -1 do
			local var_66_3, var_66_4 = var_66_2[iter_66_1]:checkWorldInRect(arg_66_1.tf.position)

			if var_66_4 and var_66_4 < var_0_4 then
				arg_66_1.overCount = arg_66_1.overCount + 1
			end

			if var_66_3 ~= 0 then
				arg_66_0.amuletOverFlag = false

				if arg_66_1.concentrate then
					if not var_66_2[iter_66_1]:getTimeRemove() then
						var_66_2[iter_66_1]:setTimeRemove()

						if arg_66_0._eventCall then
							arg_66_0._eventCall(LaunchBallGameScene.SPILT_ENEMY_SCORE, {
								num = LaunchBallGameVo.GetScore(1, 1)
							})
						end

						if LaunchBallGameVo.GetBuff(LaunchBallPlayerControl.buff_time_max) and arg_66_0.enemyStopTime and arg_66_0.enemyStopTime > 0 then
							LaunchBallGameVo.AddGameResultData(LaunchBallGameVo.result_skill_count, 1)
						end
					end

					return false
				else
					local var_66_5 = var_66_2[iter_66_1]:getDistance()

					var_66_5 = var_66_3 == 1 and var_66_5 + var_0_7 or var_66_5 - var_0_7

					local var_66_6, var_66_7

					if arg_66_1.overCount >= 2 then
						arg_66_0.amuletOverFlag = true
						var_66_6 = arg_66_0
						var_66_7 = iter_66_0
					end

					local var_66_8 = arg_66_0:createEnemy(iter_66_0, arg_66_0:getEnemyByColor(arg_66_1.color, true), arg_66_0.pointsList[iter_66_0], arg_66_0.enemysList[iter_66_0], var_66_5)

					var_66_8:setSplitFlag(true)
					var_66_8:playAnimation("Spawn")

					if arg_66_0:getBackBuff() or arg_66_1[LaunchBallGameConst.amulet_buff_back] then
						arg_66_0:setBackTime(LaunchBallPlayerControl.buff_amulet_back_time, #var_66_2, var_0_9)
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
		for iter_67_1 = #arg_67_0.enemysList[iter_67_0], 1, -1 do
			if arg_67_0.enemysList[iter_67_0][iter_67_1]:checkWorldInRect(arg_67_1) ~= 0 then
				return arg_67_0.enemysList[iter_67_0][iter_67_1]
			end
		end
	end

	return false
end

function var_0_0.checkWorldInEnemy(arg_68_0, arg_68_1)
	for iter_68_0 = 1, #arg_68_0.enemysList do
		for iter_68_1 = #arg_68_0.enemysList[iter_68_0], 1, -1 do
			if arg_68_0.enemysList[iter_68_0][iter_68_1]:checkWorldInCircle(arg_68_1) then
				return true
			end
		end
	end

	return false
end

function var_0_0.getBackBuff(arg_69_0)
	for iter_69_0 = 1, #LaunchBallGameVo.buffs do
		if LaunchBallGameVo.buffs[iter_69_0].data.type == LaunchBallPlayerControl.buff_amulet_back then
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
	if arg_72_1 == LaunchBallGameScene.PLAYING_CHANGE then
		-- block empty
	elseif arg_72_1 == LaunchBallGameScene.FIRE_AMULET then
		-- block empty
	elseif arg_72_1 == LaunchBallGameScene.SPLIT_ALL_ENEMYS then
		arg_72_0.timeRemoveAll = arg_72_2.time
	elseif arg_72_1 == LaunchBallGameScene.STOP_ENEMY_TIME then
		arg_72_0.enemyStopTime = arg_72_2.time

		arg_72_0:stopEnemysAnim(true)
	elseif arg_72_1 == LaunchBallGameScene.SLASH_ENEMY then
		-- block empty
	end

	return
end

function var_0_0.stopEnemysAnim(arg_73_0, arg_73_1)
	for iter_73_0 = 1, #arg_73_0.enemysList do
		for iter_73_1 = #arg_73_0.enemysList[iter_73_0], 1, -1 do
			arg_73_0.enemysList[iter_73_0][iter_73_1]:stopAnim(arg_73_1)
		end
	end

	return
end

function var_0_0.press(arg_74_0, arg_74_1)
	if arg_74_1 == KeyCode.J then
		-- block empty
	end

	return
end

function var_0_0.clear(arg_75_0)
	return
end

return var_0_0
