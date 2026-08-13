class = var_0_10000

local var_0_0 = var_0_10000("BeachGuardSceneMgr")

local function var_0_1(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = {
		Ctor = function(arg_2_0)
			arg_2_0._tf = arg_1_0
			arg_2_0._charTpl = arg_1_1
			arg_2_0._event = arg_1_2
			arg_2_0.chars = {}
			arg_2_0.charPool = {}
			arg_2_0.gridChars = {}
			arg_2_0.enemys = {}
			arg_2_0.enemysPool = {}
			findTF = var_1
			arg_2_0.content = var_1(arg_2_0._tf, "sceneContainer/scene/content")

			return
		end,
		changeRecycles = function(arg_3_0, arg_3_1)
			arg_3_0.recycle = arg_3_1

			for iter_3_0 = #arg_3_0.chars, 1, -1 do
				local var_3_0 = arg_3_0.chars[iter_3_0]

				var_6.setRecycleFlag(var_3_0, arg_3_1)
			end

			return
		end,
		setGridChar = function(arg_4_0, arg_4_1, arg_4_2)
			local var_4_0 = arg_4_2:getPos()
			local var_4_1 = arg_4_0:createChar(arg_4_1)
			local var_4_2 = arg_4_0.content
			local var_4_3 = var_5.InverseTransformPoint(var_4_2, var_4_0.position)

			var_4_1:prepareData()
			var_4_1:setParent(arg_4_0.content, true, var_4_3)
			var_4_1:setLineIndex(arg_4_2:getLineIndex())
			var_4_1:setGridIndex(arg_4_2:getIndex())
			var_4_1:setCamp(1)
			var_4_1:setRaycast(true)

			table = var_6

			var_6.insert(arg_4_0.chars, var_4_1)

			return var_4_1
		end,
		createChar = function(arg_5_0, arg_5_1)
			local var_5_0 = arg_5_0
			local var_5_3

			if not arg_5_0.getCharFromPool(var_5_0, arg_5_1) then
				BeachGuardConst = var_5_0

				local var_5_1 = var_5_0.chars[arg_5_1]

				BeachGuardChar = var_4

				local var_5_2 = var_4.New

				tf = var_2_10005
				instantiate = var_2_10006
				var_5_3 = var_5_2(var_2_10005(var_2_10006(arg_5_0._charTpl)), var_5_1, arg_5_0._event)
			end

			return var_5_3
		end,
		getCharFromPool = function(arg_6_0, arg_6_1)
			for iter_6_0 = #arg_6_0.charPool, 1, -1 do
				local var_6_0 = arg_6_0.charPool[iter_6_0]

				if var_6.getId(var_6_0) == arg_6_1 then
					table = var_6

					return var_6.remove(arg_6_0.charPool, iter_6_0)
				end
			end

			return nil
		end,
		removeChar = function(arg_7_0, arg_7_1)
			for iter_7_0 = #arg_7_0.chars, 1, -1 do
				if arg_7_0.chars[iter_7_0] == arg_7_1 then
					table = var_6

					local var_7_0 = var_6.remove(arg_7_0.chars, iter_7_0)

					var_6.clear(var_7_0)

					table = var_7

					var_7.insert(arg_7_0.charPool, var_6)
				else
					local var_7_1 = arg_7_0.chars[iter_7_0]

					if var_6.getTarget(var_7_1) == arg_7_1 then
						local var_7_2 = arg_7_0.chars[iter_7_0]

						var_6.setTarget(var_7_2, nil)
					end
				end
			end

			for iter_7_1 = #arg_7_0.enemys, 1, -1 do
				if arg_7_0.enemys[iter_7_1] == arg_7_1 then
					table = var_6

					local var_7_3 = var_6.remove(arg_7_0.enemys, iter_7_1)

					var_6.clear(var_7_3)

					table = var_7

					var_7.insert(arg_7_0.charPool, var_6)
				else
					local var_7_4 = arg_7_0.enemys[iter_7_1]

					if var_6.getTarget(var_7_4) == arg_7_1 then
						local var_7_5 = arg_7_0.enemys[iter_7_1]

						var_6.setTarget(var_7_5, nil)
					end
				end
			end

			return
		end,
		clear = function(arg_8_0)
			for iter_8_0 = #arg_8_0.chars, 1, -1 do
				table = var_2_10005

				local var_8_0 = var_2_10005.remove(arg_8_0.chars, iter_8_0)

				var_2_10005.clear(var_8_0)

				table = var_6

				var_6.insert(arg_8_0.charPool, var_2_10005)
			end

			for iter_8_1 = #arg_8_0.enemys, 1, -1 do
				table = var_2_10005

				local var_8_1 = var_2_10005.remove(arg_8_0.enemys, iter_8_1)

				var_2_10005.clear(var_8_1)

				table = var_6

				var_6.insert(arg_8_0.charPool, var_2_10005)
			end

			return
		end,
		start = function(arg_9_0)
			for iter_9_0 = #arg_9_0.chars, 1, -1 do
				local var_9_0 = arg_9_0.chars[iter_9_0]

				var_5.start(var_9_0)
			end

			arg_9_0.recycle = false

			return
		end,
		step = function(arg_10_0, arg_10_1)
			for iter_10_0 = #arg_10_0.chars, 1, -1 do
				local var_10_0 = arg_10_0.chars[iter_10_0]

				var_6.step(var_10_0, arg_10_1)
			end

			for iter_10_1 = #arg_10_0.enemys, 1, -1 do
				local var_10_1 = arg_10_0.enemys[iter_10_1]

				var_6.step(var_10_1, arg_10_1)
			end

			arg_10_0.enemyOver = false

			for iter_10_2 = #arg_10_0.enemys, 1, -1 do
				local var_10_2 = arg_10_0.enemys[iter_10_2]

				if not var_6.getTarget(var_10_2) then
					local var_10_3 = var_6:getLineIndex()
					local var_10_4 = var_6:getPointWorld()
					local var_10_5 = var_6:getPos()
					local var_10_6 = arg_10_0:getCharLine(var_10_3)
					local var_10_7 = false

					ipairs = var_12

					for iter_10_3, iter_10_4 in var_12(var_10_6) do
						if iter_10_4:checkCollider(var_10_4, var_10_5) and (not var_10_7 or true) then
							var_10_7 = true

							var_6:setTarget(iter_10_4)
						end
					end
				end

				local var_10_8 = var_6
				local var_10_9 = var_6.getPos(var_10_8).x

				BeachGuardConst = var_10_8

				if var_10_9 < var_10_8.enemy_over_width then
					arg_10_0.enemyOver = true
				end
			end

			for iter_10_5 = 1, #arg_10_0.chars do
				local var_10_10 = arg_10_0.chars[iter_10_5]
				local var_10_11 = var_6.getSkillDistance(var_10_10)

				BeachGuardConst = var_10_10

				local var_10_12 = var_10_11 * var_10_10.part_width
				local var_10_13 = arg_10_0
				local var_10_14 = arg_10_0.getCanHitChar(var_10_13, var_6:getLineIndex(), var_6:getCamp())

				ipairs = var_10_13

				for iter_10_6, iter_10_7 in var_10_13(var_10_14) do
					if iter_10_7:getPos().x - var_6:getPos().x > 0 and var_14 < var_10_12 then
						var_6:setTarget(iter_10_7)
					end
				end
			end

			arg_10_0:sortChar()

			return
		end,
		stop = function(arg_11_0)
			for iter_11_0 = #arg_11_0.chars, 1, -1 do
				local var_11_0 = arg_11_0.chars[iter_11_0]

				var_5.stop(var_11_0)
			end

			return
		end,
		getLineCampChars = function(arg_12_0, arg_12_1, arg_12_2)
			local var_12_0 = {}
			local var_12_1 = {}

			if arg_12_2 == 1 then
				var_12_1 = arg_12_0.chars
			elseif arg_12_2 == 2 then
				var_12_1 = arg_12_0.enemys
			end

			for iter_12_0 = 1, #var_12_1 do
				local var_12_2 = var_12_1[iter_12_0]

				table = var_2_10010

				if var_2_10010.contains(arg_12_1, var_12_2:getLineIndex()) then
					table = var_2_10010

					var_2_10010.insert(var_12_0, var_12_2)
				end
			end

			return var_12_0
		end,
		getCharByCamp = function(arg_13_0, arg_13_1)
			local var_13_0 = {}

			if arg_13_1 == 1 then
				var_13_0 = arg_13_0.chars
			elseif arg_13_1 == 2 then
				var_13_0 = arg_13_0.enemys
			end

			return var_13_0
		end,
		getEnemyOver = function(arg_14_0)
			return arg_14_0.enemyOver
		end,
		getCanHitChar = function(arg_15_0, arg_15_1, arg_15_2)
			local var_15_0 = {}
			local var_15_1 = {}

			if arg_15_2 == 1 then
				var_15_1 = arg_15_0.enemys
			elseif arg_15_2 == 2 then
				var_15_1 = arg_15_0.chars
			end

			for iter_15_0 = 1, #var_15_1 do
				local var_15_2 = var_15_1[iter_15_0]

				if var_9.getLineIndex(var_15_2) == arg_15_1 and var_9:inBulletBound() then
					table = var_10

					var_10.insert(var_15_0, var_9)
				end
			end

			return var_15_0
		end,
		getChars = function(arg_16_0)
			return arg_16_0.chars
		end,
		getEnemys = function(arg_17_0)
			return arg_17_0.enemys
		end,
		getCharLine = function(arg_18_0, arg_18_1)
			local var_18_0 = {}

			for iter_18_0 = 1, #arg_18_0.chars do
				local var_18_1 = arg_18_0.chars[iter_18_0]

				if var_7.getLineIndex(var_18_1) == arg_18_1 then
					table = var_8

					var_8.insert(var_18_0, var_7)
				end
			end

			return var_18_0
		end,
		addEnemyChar = function(arg_19_0, arg_19_1, arg_19_2)
			local var_19_0 = arg_19_1
			local var_19_1 = arg_19_0:createChar(var_19_0)

			var_4.prepareData(var_19_1)
			var_4:setLineIndex(arg_19_2.index)

			local var_19_2 = arg_19_0.content
			local var_19_3 = var_5.InverseTransformPoint(var_19_2, arg_19_2.position)

			math = var_19_2

			local var_19_4 = var_19_2.random

			BeachGuardConst = var_7

			local var_19_5 = var_7.enemy_pos[1]

			BeachGuardConst = var_2_10008

			local var_19_6 = var_19_4(var_19_5, var_2_10008.enemy_pos[2])
			local var_19_7 = var_4
			local var_19_8 = var_4.setParent
			local var_19_9 = arg_19_0.content
			local var_19_10 = false

			Vector2 = var_2_10011

			local var_19_11 = var_19_6 + var_19_3.x
			local var_19_12 = var_19_3.y

			BeachGuardConst = var_2_10014

			var_19_8(var_19_7, var_19_9, var_19_10, var_2_10011(var_19_11, var_19_12 + var_2_10014.enemy_offset_y))
			var_4:setCamp(2)
			var_4:setRaycast(false)

			table = var_7

			var_7.insert(arg_19_0.enemys, var_4)

			return
		end,
		sortChar = function(arg_20_0)
			local var_20_0 = #arg_20_0.chars + #arg_20_0.enemys

			if not arg_20_0.sorts or #arg_20_0.sorts ~= var_20_0 then
				arg_20_0.sorts = {}

				for iter_20_0 = 1, #arg_20_0.chars do
					table = var_2_10006

					var_2_10006.insert(arg_20_0.sorts, arg_20_0.chars[iter_20_0])
				end

				for iter_20_1 = 1, #arg_20_0.enemys do
					table = var_2_10006

					var_2_10006.insert(arg_20_0.sorts, arg_20_0.enemys[iter_20_1])
				end

				table = var_2

				var_2.sort(arg_20_0.sorts, function(arg_21_0, arg_21_1)
					local var_21_0 = arg_21_0:getPos()
					local var_21_1 = arg_21_1:getPos()

					if var_21_0.y > var_21_1.y then
						return true
					elseif var_21_0.y < var_21_1.y then
						return false
					end

					if var_21_0.x > var_21_1.x then
						return true
					elseif var_21_0.x < var_21_1.x then
						return false
					end

					return
				end)

				for iter_20_2 = 1, #arg_20_0.sorts do
					local var_20_1 = arg_20_0.sorts[iter_20_2]

					var_6.SetSiblingIndex(var_20_1, iter_20_2)
				end
			end

			return
		end
	}

	var_3.Ctor(var_1_0)

	return var_3
end

local function var_0_2(arg_22_0, arg_22_1)
	local var_22_0 = {
		Ctor = function(arg_23_0)
			arg_23_0._tf = arg_22_0
			arg_23_0._event = arg_22_1
			findTF = var_1
			arg_23_0.lineTpl = var_1(arg_23_0._tf, "sceneContainer/scene/classes/lineTpl")
			findTF = var_1
			arg_23_0.gridTpl = var_1(arg_23_0._tf, "sceneContainer/scene/classes/gridTpl")
			arg_23_0.lines = {}
			findTF = var_1
			arg_23_0.content = var_1(arg_23_0._tf, "sceneContainer/scene/content")

			local var_23_0 = 1

			BeachGuardConst = var_2

			for iter_23_0 = var_23_0, var_2.line_num do
				findTF = var_2_10005
				var_2_10005 = var_2_10005(arg_23_0._tf, "sceneContainer/scene/linePos/" .. iter_23_0)
				tf = var_6
				instantiate = var_7

				local var_23_1 = var_6(var_7(arg_23_0.lineTpl))

				Vector2 = var_7
				var_23_1.anchoredPosition = var_7(0, 0)
				setParent = var_7

				var_7(var_23_1, var_2_10005)

				BeachGuardLine = var_7

				local var_23_2 = var_7.New(var_23_1, arg_23_0.gridTpl, arg_23_0._event)

				var_7.setIndex(var_23_2, iter_23_0)

				table = var_8

				var_8.insert(arg_23_0.lines, var_7)
			end

			return
		end,
		setMapData = function(arg_24_0, arg_24_1)
			local var_24_0 = arg_24_1.line

			arg_24_0.activeLines = {}

			for iter_24_0 = 1, #arg_24_0.lines do
				local var_24_1 = arg_24_0.lines[iter_24_0]

				table = var_2_10008

				if var_2_10008.contains(var_24_0, var_24_1:getIndex()) then
					var_24_1:active(true)

					table = var_2_10008

					var_2_10008.insert(arg_24_0.activeLines, var_24_1)
				else
					var_24_1:active(false)
				end
			end

			return
		end,
		getGridByIndex = function(arg_25_0, arg_25_1, arg_25_2)
			for iter_25_0 = 1, #arg_25_0.activeLines do
				local var_25_0 = arg_25_0.activeLines[iter_25_0]

				if var_7.getIndex(var_25_0) == arg_25_1 then
					return var_7:getGridByIndex(arg_25_2)
				end
			end

			return nil
		end,
		setDrag = function(arg_26_0, arg_26_1)
			arg_26_0.dragData = arg_26_1

			return
		end,
		start = function(arg_27_0)
			for iter_27_0 = 1, #arg_27_0.lines do
				local var_27_0 = arg_27_0.lines[iter_27_0]
				local var_27_1 = var_5.start(var_27_0)
			end

			return
		end,
		step = function(arg_28_0, arg_28_1)
			for iter_28_0 = 1, #arg_28_0.lines do
				local var_28_0 = arg_28_0.lines[iter_28_0]
				local var_28_1 = var_6.step(var_28_0, arg_28_1)
			end

			return
		end,
		clear = function(arg_29_0)
			arg_29_0:clearPre()

			for iter_29_0 = 1, #arg_29_0.lines do
				local var_29_0 = arg_29_0.lines[iter_29_0]

				var_5.clear(var_29_0)
			end

			return
		end,
		onTimer = function(arg_30_0)
			if not arg_30_0.dragData then
				return
			end

			if arg_30_0.dragData.flag ~= true or not arg_30_0.dragData.pos then
				if arg_30_0.preCharGrid then
					local var_30_0 = arg_30_0._event
					local var_30_1 = var_1.emit

					BeachGuardGameView = var_2_10003

					local var_30_2 = var_2_10003.PULL_CHAR
					local var_30_3 = {
						card_id = arg_30_0.preCardID
					}
					local var_30_4 = arg_30_0.preCharGrid

					var_30_3.line_index = var_5.getLineIndex(var_30_4)

					local var_30_5 = arg_30_0.preCharGrid

					var_30_3.grid_index = var_5.getIndex(var_30_5)

					var_30_1(var_30_0, var_30_2, var_30_3)
				end

				arg_30_0:clearPre()

				return
			end

			local var_30_6 = arg_30_0.dragData.pos

			if arg_30_0:getGridByWorld(var_30_6) and var_2:isEmpty() then
				local var_30_7 = arg_30_0.dragData.config.char_id
				local var_30_8 = var_3.id

				if arg_30_0.preCharGrid == var_2 and arg_30_0.preCardID == var_30_8 then
					return
				end

				arg_30_0:clearPre()

				arg_30_0.preCharGrid = var_2
				arg_30_0.preCardID = var_30_8

				local var_30_9 = arg_30_0.preCharGrid

				var_6.prechar(var_30_9, var_30_7)

				local var_30_10 = arg_30_0.preCharGrid
				local var_30_11 = var_6.getLineIndex(var_30_10)
				local var_30_12 = arg_30_0.preCharGrid
				local var_30_13 = var_7.getIndex(var_30_12)

				if var_30_11 and var_30_13 then
					BeachGuardConst = var_30_12

					local var_30_14 = var_30_12.chars[var_30_7].distance

					for iter_30_0 = 1, var_30_14 do
						if arg_30_0:getGridByIndex(var_30_11, var_30_13 + iter_30_0) then
							var_13:preDistance()

							table = var_14

							var_14.insert(arg_30_0.preDistanceGrids, var_13)
						end
					end
				end
			else
				arg_30_0:clearPre()
			end

			return
		end,
		clearPre = function(arg_31_0)
			if arg_31_0.preCharGrid then
				local var_31_0 = arg_31_0.preCharGrid

				var_1.unPreChar(var_31_0)

				arg_31_0.preCharGrid = nil
			end

			if arg_31_0.preDistanceGrids and #arg_31_0.preDistanceGrids > 0 then
				for iter_31_0 = 1, #arg_31_0.preDistanceGrids do
					local var_31_1 = arg_31_0.preDistanceGrids[iter_31_0]

					var_5.unPreDistance(var_31_1)
				end
			end

			arg_31_0.preDistanceGrids = {}

			return
		end,
		removeGridChar = function(arg_32_0, arg_32_1)
			if arg_32_0:getGridByChar(arg_32_1) then
				var_2:removeChar()

				return true
			end

			return
		end,
		getGridByWorld = function(arg_33_0, arg_33_1)
			for iter_33_0 = 1, #arg_33_0.activeLines do
				local var_33_0 = arg_33_0.activeLines[iter_33_0]

				if var_6.getGridWorld(var_33_0, arg_33_1) then
					return var_6
				end
			end

			return nil
		end,
		getGridByChar = function(arg_34_0, arg_34_1)
			for iter_34_0 = 1, #arg_34_0.lines do
				local var_34_0 = arg_34_0.lines[iter_34_0]
				local var_34_1 = var_6.getGrids(var_34_0)

				ipairs = var_34_0

				for iter_34_1, iter_34_2 in var_34_0(var_34_1) do
					if iter_34_2:getChar() == arg_34_1 then
						return iter_34_2
					end
				end
			end

			return nil
		end,
		getAbleLinePos = function(arg_35_0, arg_35_1)
			local var_35_0 = {}

			for iter_35_0 = 1, #arg_35_0.activeLines do
				local var_35_1 = arg_35_0.activeLines[iter_35_0]
				local var_35_2 = var_7.getIndex(var_35_1)

				table = var_35_1

				if var_35_1.contains(arg_35_1, var_35_2) then
					table = var_8

					local var_35_3 = var_8.insert
					local var_35_4 = var_35_0
					local var_35_5 = {}
					local var_35_6 = arg_35_0.activeLines[iter_35_0]

					var_35_5.position = var_11.getPosition(var_35_6)
					var_35_5.index = var_35_2

					var_35_3(var_35_4, var_35_5)
				end
			end

			math = var_3

			return var_35_0[var_3.random(1, #var_35_0)]
		end
	}

	var_2.Ctor(var_22_0)

	return var_2
end

local function var_0_3(arg_36_0, arg_36_1)
	local var_36_0 = {
		Ctor = function(arg_37_0)
			arg_37_0._tf = arg_36_0
			arg_37_0._event = arg_36_1
			findTF = var_1
			arg_37_0.content = var_1(arg_37_0._tf, "sceneContainer/scene/content")
			arg_37_0.bullets = {}
			arg_37_0.bulletPool = {}

			return
		end,
		useSkill = function(arg_38_0, arg_38_1)
			local var_38_0 = arg_38_1.skill.type

			BeachGuardConst = var_2_10004

			local var_38_1

			if var_38_0 == var_2_10004.skill_craft then
				var_38_1 = arg_38_0._event

				local var_38_2 = var_3.emit

				BeachGuardGameView = var_2_10005

				var_38_2(var_38_1, var_2_10005.ADD_CRAFT, {
					num = var_2.num
				})
			else
				local var_38_3 = var_2.type

				BeachGuardConst = var_38_1

				if var_38_3 == var_38_1.skill_bullet then
					local var_38_4 = var_2.bullet_id

					ipairs = var_4

					for iter_38_0, iter_38_1 in var_4(var_38_4) do
						arg_38_0:pullBullet(iter_38_1, arg_38_1)
					end
				else
					local var_38_5 = var_2.type

					BeachGuardConst = var_4

					if var_38_5 == var_4.skill_melee then
						local var_38_6 = arg_38_1.damage
						local var_38_7 = arg_38_1.target
						local var_38_8 = arg_38_1.position
						local var_38_9 = arg_38_0._event
						local var_38_10 = var_6.emit

						BeachGuardGameView = iter_38_1

						var_38_10(var_38_9, iter_38_1.CREATE_CHAR_DAMAGE, {
							damage = var_38_6,
							position = var_38_8,
							target = var_38_7,
							useData = arg_38_1
						})
					end
				end
			end

			return
		end,
		pullBullet = function(arg_39_0, arg_39_1, arg_39_2)
			local var_39_0 = arg_39_0:getOrCreateBullet(arg_39_1)
			local var_39_1 = arg_39_2.position
			local var_39_2 = arg_39_2.distanceVec
			local var_39_3 = var_39_0.config.offset
			local var_39_4 = var_39_0.tf
			local var_39_5 = arg_39_0.content

			var_39_4.anchoredPosition = var_8.InverseTransformPoint(var_39_5, var_39_1)

			if var_39_3 then
				var_39_4 = var_39_0.tf
				Vector2 = var_8
				var_39_4.anchoredPosition = var_8(var_39_0.tf.anchoredPosition.x + var_39_3.x, var_39_0.tf.anchoredPosition.y + var_39_3.y)
			end

			setActive = var_39_4

			var_39_4(var_39_0.tf, true)

			var_39_0.distanceVec = var_39_2
			Vector2 = var_39_4
			var_39_0.speed = var_39_4(var_39_0.config.speed[1], var_39_0.config.speed[2])
			var_39_0.direct = arg_39_2.direct
			var_39_0.hit = false
			var_39_0.useData = arg_39_2

			local var_39_6

			if var_39_0.config.point_able then
				var_39_0.life = nil
			else
				local var_39_7

				if var_39_0.config.speed_high and var_39_0.config.speed_high ~= 0 then
					var_39_6 = arg_39_2.target
					var_39_7 = var_39_7.getPos(var_39_6)
					math = var_39_6
					var_39_6 = var_39_6.random(-10, 5)

					local var_39_8 = var_39_7.x + 5

					math = var_10
					var_39_7.x = var_39_8 - var_10.random() * 15

					local var_39_9 = arg_39_2.useChar
					local var_39_10 = var_9.getPos(var_39_9)

					if var_39_7 and var_39_10 then
						math = var_39_9
						var_39_9 = var_39_9.abs(var_39_7.x - var_39_10.x)
						math = var_11
						var_39_0.life = var_39_9 / var_11.abs(var_39_0.speed.x)
					else
						math = var_39_9

						local var_39_11 = var_39_9.abs(var_39_0.distanceVec.x)

						math = var_11
						var_39_0.life = var_39_11 / var_11.abs(var_39_0.speed.x)
					end
				else
					math = var_39_7

					local var_39_12 = var_39_7.abs(var_39_0.distanceVec.x)

					math = var_39_6
					var_39_0.life = var_39_12 / var_39_6.abs(var_39_0.speed.x)
				end
			end

			var_39_0.gravity = 0

			local var_39_13

			if var_39_0.config.speed_high and var_39_0.config.speed_high ~= 0 then
				var_39_13 = -(var_39_0.config.speed_high * 2)
				math = var_39_6
				var_39_13 = var_39_13 / var_39_6.pow(var_39_0.life / 2, 2)

				local var_39_14 = var_39_0.speed

				math = var_9
				var_39_14.y = var_9.abs(var_39_13) * (var_39_0.life / 2)
				var_39_0.gravity = var_39_13
			end

			table = var_39_13

			var_39_13.insert(arg_39_0.bullets, var_39_0)

			return
		end,
		getBullets = function(arg_40_0)
			return arg_40_0.bullets
		end,
		getOrCreateBullet = function(arg_41_0, arg_41_1)
			local var_41_0 = arg_41_0
			local var_41_3

			if not arg_41_0.getBulletFromPool(var_41_0, arg_41_1) then
				BeachGuardConst = var_41_0

				local var_41_1 = var_41_0.bullet[arg_41_1]

				BeachGuardAsset = var_4

				local var_41_2 = var_4.getBullet(var_41_1.name)

				setParent = var_5

				var_5(var_41_2, arg_41_0.content)

				var_41_3 = {
					tf = var_41_2,
					config = var_41_1
				}
			end

			return var_41_3
		end,
		getBulletFromPool = function(arg_42_0, arg_42_1)
			for iter_42_0 = #arg_42_0.bulletPool, 1, -1 do
				if arg_42_0.bulletPool[iter_42_0].config.id == arg_42_1 then
					table = var_6

					return var_6.remove(arg_42_0.bulletPool, iter_42_0)
				end
			end

			return nil
		end,
		finishBullet = function(arg_43_0, arg_43_1)
			local var_43_0 = arg_43_1.config.damage

			setActive = var_2_10003

			var_2_10003(arg_43_1.tf, false)

			local var_43_1 = arg_43_1.tf.anchoredPosition

			return
		end,
		start = function(arg_44_0)
			return
		end,
		step = function(arg_45_0, arg_45_1)
			for iter_45_0 = #arg_45_0.bullets, 1, -1 do
				local var_45_0 = arg_45_0.bullets[iter_45_0].speed
				local var_45_1 = var_6.gravity
				local var_45_2 = var_6.direct
				local var_45_3 = var_6.tf

				Vector2 = var_2_10011
				var_45_3.anchoredPosition = var_2_10011(var_6.tf.anchoredPosition.x + var_45_0.x * arg_45_1 * var_45_2, var_6.tf.anchoredPosition.y + var_45_0.y * arg_45_1)
				var_6.speed.y = var_6.speed.y + var_6.gravity * arg_45_1

				if var_6.life then
					var_6.life = var_6.life - arg_45_1

					if var_6.life <= 0 then
						local var_45_4

						if var_6.config.speed_high and var_6.config.speed_high ~= 0 and not var_6.hit then
							var_45_4 = var_6.config.damage
							var_2_10011 = var_6.useData
							var_2_10011.target = nil

							local var_45_5 = arg_45_0._event

							var_2_10011 = var_2_10011.emit
							BeachGuardGameView = var_13

							var_2_10011(var_45_5, var_13.BULLET_DAMAGE, {
								damage = var_45_4,
								position = var_6.tf.position,
								useData = var_6.useData
							})
						end

						table = var_45_4

						local var_45_6 = var_45_4.remove(arg_45_0.bullets, iter_45_0)

						arg_45_0:finishBullet(var_45_6)

						table = var_2_10011

						var_2_10011.insert(arg_45_0.bulletPool, var_45_6)
					elseif var_6.hit then
						table = var_10

						local var_45_7 = var_10.remove(arg_45_0.bullets, iter_45_0)

						arg_45_0:finishBullet(var_45_7)

						table = var_2_10011

						var_2_10011.insert(arg_45_0.bulletPool, var_45_7)
					end
				end
			end

			return
		end,
		stop = function(arg_46_0)
			return
		end,
		clear = function(arg_47_0)
			for iter_47_0 = #arg_47_0.bullets, 1, -1 do
				table = var_2_10005
				var_2_10005 = var_2_10005.remove(arg_47_0.bullets, iter_47_0)
				setActive = var_6

				var_6(var_2_10005.tf, false)

				var_2_10005.distanceVec = nil
				table = var_6

				var_6.insert(arg_47_0.bulletPool, var_2_10005)
			end

			return
		end
	}

	var_2.Ctor(var_36_0)

	return var_2
end

local function var_0_4(arg_48_0, arg_48_1)
	local var_48_0 = {
		Ctor = function(arg_49_0)
			arg_49_0._tf = arg_48_0
			arg_49_0._event = arg_48_1

			return
		end,
		setData = function(arg_50_0, arg_50_1)
			arg_50_0._data = arg_50_1
			arg_50_0._chapterId = arg_50_0._data.id

			return
		end,
		start = function(arg_51_0)
			arg_51_0:clear()

			Clone = var_1
			arg_51_0._chapterDatas = var_1(arg_51_0._data.data)

			return
		end,
		step = function(arg_52_0, arg_52_1)
			arg_52_0._overTime = arg_52_0._overTime + arg_52_1

			for iter_52_0 = #arg_52_0._chapterDatas, 1, -1 do
				if arg_52_0._chapterDatas[iter_52_0].time < arg_52_0._overTime then
					local var_52_0 = arg_52_0
					local var_52_1 = arg_52_0.createData

					table = var_2_10010

					local var_52_2 = var_52_1(var_52_0, var_2_10010.remove(arg_52_0._chapterDatas, iter_52_0))

					table = var_52_0

					var_52_0.insert(arg_52_0.enemyDatas, var_52_2)
				end
			end

			for iter_52_1 = #arg_52_0.enemyDatas, 1, -1 do
				if arg_52_0.enemyDatas[iter_52_1].loop then
					var_6.stepTime = var_6.stepTime - arg_52_1

					if var_6.stepTime <= 0 then
						local var_52_3 = var_6.step

						math = var_8
						var_6.stepTime = var_8.random() * (var_52_3[2] - var_52_3[1]) + var_52_3[1]

						arg_52_0:addEnemyData(var_6)
					end

					if arg_52_0._overTime > var_6.stop then
						table = var_7

						var_7.remove(arg_52_0.enemyDatas, iter_52_1)
					end
				else
					arg_52_0:addEnemyData(var_6)

					table = var_7

					var_7.remove(arg_52_0.enemyDatas, iter_52_1)
				end
			end

			if not arg_52_0.addEnemyTime then
				arg_52_0.addEnemyTime = 1
			end

			arg_52_0.addEnemyTime = arg_52_0.addEnemyTime - arg_52_1

			if #arg_52_0.enemyList > 0 and arg_52_0.addEnemyTime <= 0 then
				table = var_2

				local var_52_4 = var_2.remove(arg_52_0.enemyList, #arg_52_0.enemyList)
				local var_52_5 = arg_52_0._event
				local var_52_6 = var_3.emit

				BeachGuardGameView = iter_52_1

				var_52_6(var_52_5, iter_52_1.ADD_ENEMY, var_52_4)
			end

			if #arg_52_0.enemyDatas == 0 and #arg_52_0._chapterDatas == 0 and #arg_52_0.enemyList == 0 then
				arg_52_0.finishCreate = true
			end

			return
		end,
		getFinishCreate = function(arg_53_0)
			return arg_53_0.finishCreate
		end,
		createData = function(arg_54_0, arg_54_1)
			local var_54_0 = {}
			local var_54_1 = arg_54_1.create
			local var_54_2 = arg_54_1.time
			local var_54_3 = arg_54_1.stop
			local var_54_4 = arg_54_1.step
			local var_54_5 = arg_54_1.comming

			if var_54_4 then
				var_54_0.loop = true
				var_54_0.stepTime = 0
			else
				var_54_0.loop = false
			end

			var_54_0.create = var_54_1
			var_54_0.time = var_54_2
			var_54_0.stop = var_54_3
			var_54_0.step = var_54_4
			var_54_0.comming = var_54_5

			return var_54_0
		end,
		addEnemyData = function(arg_55_0, arg_55_1)
			local var_55_0 = arg_55_1.create
			local var_55_1

			if not arg_55_1.comming then
				var_55_1 = false
			end

			if var_55_1 then
				arg_55_1.comming = false

				local var_55_2 = arg_55_0._event

				var_2_10004 = var_2_10004.emit
				BeachGuardGameView = var_2_10006

				var_2_10004(var_55_2, var_2_10006.ENEMY_COMMING)
			end

			BeachGuardConst = var_2_10004

			local var_55_3 = var_2_10004.create_enemy[var_55_0]

			for iter_55_0 = 1, var_55_3.num do
				local var_55_4 = var_55_3.enemy

				math = var_2_10010

				local var_55_5 = var_55_4[var_2_10010.random(1, #var_55_3.enemy)]

				var_2_10010 = var_55_3.line
				table = var_11

				var_11.insert(arg_55_0.enemyList, {
					id = var_55_5,
					lines = var_2_10010
				})
			end

			return
		end,
		stop = function(arg_56_0)
			return
		end,
		clear = function(arg_57_0)
			arg_57_0._overTime = 0
			arg_57_0._chapterDatas = {}
			arg_57_0.enemyDatas = {}
			arg_57_0.enemyList = {}
			arg_57_0.finishCreate = false

			return
		end
	}

	var_2.Ctor(var_48_0)

	return var_2
end

local function var_0_5(arg_58_0, arg_58_1)
	local var_58_0 = {
		Ctor = function(arg_59_0)
			arg_59_0._tf = arg_58_0
			arg_59_0._event = arg_58_1
			findTF = var_1
			arg_59_0.effectBackTf = var_1(arg_59_0._tf, "sceneContainer/scene/effect_back")
			findTF = var_1
			arg_59_0.effectFrontTf = var_1(arg_59_0._tf, "sceneContainer/scene/effect_front")
			findTF = var_1
			arg_59_0.content = var_1(arg_59_0._tf, "sceneContainer/scene/content")
			arg_59_0.effects = {}
			arg_59_0.effectPool = {}

			return
		end,
		setCharCtrl = function(arg_60_0, arg_60_1)
			arg_60_0.charCtrl = arg_60_1

			return
		end,
		setSkillCtrl = function(arg_61_0, arg_61_1)
			arg_61_0.skillCtrl = arg_61_1

			return
		end,
		craeteCharDamage = function(arg_62_0, arg_62_1)
			arg_62_0:createDamage(arg_62_1)

			return
		end,
		bulletDamage = function(arg_63_0, arg_63_1)
			arg_63_0:createDamage(arg_63_1)

			return
		end,
		createDamage = function(arg_64_0, arg_64_1)
			local var_64_0 = arg_64_1.damage
			local var_64_1 = arg_64_1.position
			local var_64_2 = arg_64_1.useData.target
			local var_64_3 = var_4.line
			local var_64_4 = var_4.camp

			if not var_64_0 then
				-- block empty
			end

			BeachGuardConst = var_2_10008

			local var_64_5 = var_2_10008.damage[var_64_0]

			if var_64_2 then
				local var_64_6

				if not var_4.atkRate then
					var_64_6 = 1
				end

				var_64_2:damage(var_64_5.damage * var_64_6)
			end

			local var_64_7 = var_64_5.type

			BeachGuardConst = var_2_10010

			local var_64_8

			if var_64_7 == var_2_10010.bullet_type_range then
				var_64_8 = var_64_5.config.next

				local var_64_9 = var_9.range
				local var_64_10 = var_64_4 == 1 and 2 or 1

				var_2_10014 = arg_64_0.charCtrl

				local var_64_11 = var_13.getLineCampChars(var_2_10014, {
					var_64_3 + 1,
					var_64_3 - 1,
					var_64_3
				}, var_64_10)

				var_2_10014 = nil

				if var_4.target then
					local var_64_12 = var_4.target

					var_2_10014 = var_15.getPos(var_64_12)
				else
					local var_64_13 = arg_64_0.effectFrontTf

					var_2_10014 = var_15.InverseTransformPoint(var_64_13, var_64_1)
				end

				if var_64_11 and #var_64_11 > 0 then
					BeachGuardConst = var_15

					local var_64_14 = var_64_9 * var_15.part_width

					for iter_64_0 = 1, #var_64_11 do
						var_2_10020 = var_64_11[iter_64_0]

						if not var_4.target or var_4.target ~= var_2_10020 then
							math = var_21

							if var_64_14 > var_21.abs(var_2_10014.x - var_2_10020:getPos().x) then
								local var_64_15 = var_2_10020
								local var_64_16 = var_2_10020.getWorldPos(var_64_15)

								Clone = var_64_15

								local var_64_17 = var_64_15(var_4)

								var_64_17.target = var_2_10020

								arg_64_0:createDamage({
									damage = var_9.next,
									position = var_64_16,
									useData = var_64_17
								})
							end
						end
					end
				end
			else
				local var_64_18 = var_64_5.type

				BeachGuardConst = var_64_8

				if var_64_18 == var_64_8.bullet_type_disperse then
					local var_64_19 = var_64_5.config.up
					local var_64_20 = var_9.down
					local var_64_21 = var_64_4 == 1 and 2 or 1

					var_2_10014 = arg_64_0

					arg_64_0.addDamageByDisperse(var_2_10014, {
						var_64_3 - 1
					}, var_9.range, var_64_21, var_64_19, var_4)

					var_2_10014 = arg_64_0

					arg_64_0.addDamageByDisperse(var_2_10014, {
						var_64_3 + 1
					}, var_9.range, var_64_21, var_64_20, var_4)
				end
			end

			if var_64_5.buff and #var_64_5.buff > 0 then
				for iter_64_1 = 1, #var_64_5.buff do
					local var_64_22 = var_64_5.buff[iter_64_1]

					BeachGuardConst = var_2_10014

					local var_64_23 = var_2_10014.buff[var_64_22].type
					local var_64_24 = var_2_10014.trigger
					local var_64_25 = var_2_10014.bound
					local var_64_26 = var_4.useChar
					local var_64_27 = var_4.target

					BeachGuardConst = var_2_10020

					if var_64_24 == var_2_10020.buff_trigger_other then
						var_64_27:addBuff(var_2_10014)
					else
						BeachGuardConst = var_2_10020

						if var_64_24 == var_2_10020.buff_trigger_self then
							var_64_26:addBuff(var_2_10014)

							if var_64_25 and var_64_25 ~= nil then
								local var_64_28 = var_4.useChar

								var_2_10020 = var_2_10020.getCamp(var_64_28)

								local var_64_29 = var_4.useChar
								local var_64_30 = var_21.getLineIndex(var_64_29)
								local var_64_31 = var_4.useChar
								local var_64_32 = var_22.getGridIndex(var_64_31)

								if var_64_30 and var_64_32 then
									local var_64_33 = arg_64_0.charCtrl
									local var_64_34 = var_23.getCharByCamp(var_64_33, var_2_10020)

									ipairs = var_64_33

									for iter_64_2, iter_64_3 in var_64_33(var_64_34) do
										if iter_64_3 ~= var_64_26 then
											local var_64_35 = iter_64_3:getGridIndex()
											local var_64_36 = iter_64_3
											local var_64_37 = iter_64_3.getLineIndex(var_64_36)

											math = var_64_36

											if var_64_36.abs(var_64_35 - var_64_32) <= var_64_25[1] then
												math = var_31

												if var_31.abs(var_64_37 - var_64_30) <= var_64_25[2] then
													iter_64_3:addBuff(var_2_10014)
												end
											end
										end
									end
								end
							end
						end
					end
				end
			end

			if var_64_5.effect and #var_64_5.effect > 0 then
				arg_64_0:createEffect(var_64_5.effect, var_64_1)
			end

			return
		end,
		addDamageByDisperse = function(arg_65_0, arg_65_1, arg_65_2, arg_65_3, arg_65_4, arg_65_5)
			local var_65_0 = arg_65_0.charCtrl

			if var_6.getLineCampChars(var_65_0, arg_65_1, arg_65_3) and #var_6 > 0 then
				BeachGuardConst = var_7

				local var_65_1 = arg_65_2 * var_7.part_width
				local var_65_2 = arg_65_5.target
				local var_65_3 = var_8.getPos(var_65_2)

				for iter_65_0 = 1, #var_6 do
					local var_65_4 = var_6[iter_65_0]
					local var_65_5 = var_13.getPos(var_65_4)

					math = var_65_4

					if var_65_1 > var_65_4.abs(var_65_3.x - var_65_5.x) then
						local var_65_6 = var_13
						local var_65_7 = var_13.getWorldPos(var_65_6)

						Clone = var_65_6

						local var_65_8 = var_65_6(arg_65_5)

						var_65_8.target = var_13

						arg_65_0:createDamage({
							damage = arg_65_4,
							position = var_65_7,
							useData = var_65_8
						})
					end
				end
			end

			return
		end,
		createEffect = function(arg_66_0, arg_66_1, arg_66_2)
			if not arg_66_0:getEffect(arg_66_1[1]) then
				-- block empty
			end

			if not var_3 then
				return
			end

			local var_66_0 = var_3.tf
			local var_66_1 = arg_66_0.effectFrontTf

			var_66_0.anchoredPosition = var_5.InverseTransformPoint(var_66_1, arg_66_2)
			setActive = var_66_0

			var_66_0(var_3.tf, true)

			var_3.time = var_3.config.time
			table = var_4

			var_4.insert(arg_66_0.effects, var_3)

			return
		end,
		getEffect = function(arg_67_0, arg_67_1)
			local var_67_0
			local var_67_1 = #arg_67_0.effectPool

			if 0 < var_67_1 then
				for iter_67_0 = #arg_67_0.effectPool, 1, -1 do
					if arg_67_0.effectPool[iter_67_0].config.id == arg_67_1 then
						table = var_7

						return (var_7.remove(arg_67_0.effectPool, iter_67_0))
					end
				end
			end

			BeachGuardConst = var_67_1

			local var_67_2 = var_67_1.effect[arg_67_1]

			BeachGuardAsset = var_4

			local var_67_3 = var_4.getEffect(var_67_2.name)

			setParent = var_5

			var_5(var_67_3, arg_67_0.effectFrontTf)

			return {
				tf = var_67_3,
				config = var_67_2
			}
		end,
		start = function(arg_68_0)
			return
		end,
		step = function(arg_69_0, arg_69_1)
			local var_69_0 = arg_69_0.skillCtrl
			local var_69_1 = var_2.getBullets(var_69_0)

			for iter_69_0 = 1, #var_69_1 do
				local var_69_2 = var_69_1[iter_69_0].useData.line
				local var_69_3 = var_8.camp
				local var_69_4 = var_7.tf.position
				local var_69_5 = arg_69_0.charCtrl
				local var_69_6 = var_12.getCanHitChar(var_69_5, var_69_2, var_69_3)
				local var_69_7 = false

				ipairs = var_14

				for iter_69_1, iter_69_2 in var_14(var_69_6) do
					if not var_69_7 and iter_69_2:inBulletBound() and iter_69_2:checkBulletCollider(var_69_4) then
						local var_69_8 = var_7.config.damage

						var_69_7 = true
						var_7.hit = true
						var_8.target = iter_69_2

						local var_69_9 = arg_69_0
						local var_69_10 = arg_69_0.createDamage
						local var_69_11 = {
							damage = var_69_8
						}
						local var_69_12 = var_8.target

						var_69_11.position = var_23.getAnimPos(var_69_12)
						var_69_11.useData = var_7.useData

						var_69_10(var_69_9, var_69_11)
					end
				end
			end

			for iter_69_3 = #arg_69_0.effects, 1, -1 do
				if arg_69_0.effects[iter_69_3].time and var_7.time > 0 then
					var_7.time = var_7.time - arg_69_1

					if var_7.time <= 0 then
						var_7.time = 0
						setActive = var_8

						var_8(var_7.tf, false)

						table = var_8

						local var_69_13 = var_8.remove(arg_69_0.effects, iter_69_3)

						table = var_9

						var_9.insert(arg_69_0.effectPool, var_69_13)
					end
				end
			end

			return
		end,
		stop = function(arg_70_0)
			return
		end,
		clear = function(arg_71_0)
			for iter_71_0 = #arg_71_0.effects, 1, -1 do
				setActive = var_2_10005

				var_2_10005(arg_71_0.effects[iter_71_0].tf, false)

				table = var_2_10005
				var_2_10005 = var_2_10005.insert

				local var_71_0 = arg_71_0.effectPool

				table = var_7

				var_2_10005(var_71_0, var_7.remove(arg_71_0.effects, iter_71_0))
			end

			return
		end
	}

	var_2.Ctor(var_58_0)

	return var_2
end

function var_0_0.Ctor(arg_72_0, arg_72_1, arg_72_2, arg_72_3)
	arg_72_0._tf = arg_72_1
	arg_72_0._event = arg_72_3
	arg_72_0._gameData = arg_72_2
	arg_72_0.asset = arg_72_0._gameData.asset
	Timer = var_4
	arg_72_0.timer = var_4.New(function()
		local var_73_0 = arg_72_0

		var_0.onTimer(var_73_0)

		return
	end, 0.03333333333333333, -1)

	arg_72_0:init()

	return
end

function var_0_0.init(arg_74_0)
	findTF = var_1_10001
	arg_74_0.charTpl = var_1_10001(arg_74_0._tf, "sceneContainer/scene/classes/charTpl")
	arg_74_0.charCtrl = var_0_1(arg_74_0._tf, arg_74_0.charTpl, arg_74_0._event)
	arg_74_0.lineCtrl = var_0_2(arg_74_0._tf, arg_74_0._event)
	arg_74_0.skillCtrl = var_0_3(arg_74_0._tf, arg_74_0._event)
	arg_74_0.enemyCtrl = var_0_4(arg_74_0._tf, arg_74_0._event)
	arg_74_0.damageCtrl = var_0_5(arg_74_0._tf, arg_74_0._event)

	local var_74_0 = arg_74_0.damageCtrl

	var_1.setCharCtrl(var_74_0, arg_74_0.charCtrl)

	local var_74_1 = arg_74_0.damageCtrl

	var_1.setSkillCtrl(var_74_1, arg_74_0.skillCtrl)

	local var_74_2 = arg_74_0.timer

	var_1.Start(var_74_2)

	return
end

function var_0_0.onTimer(arg_75_0)
	local var_75_0 = arg_75_0.lineCtrl

	var_1.onTimer(var_75_0)

	return
end

function var_0_0.setData(arg_76_0, arg_76_1)
	arg_76_0._runningData = arg_76_1

	local var_76_0 = arg_76_0._runningData.chapter

	BeachGuardConst = var_1_10003

	local var_76_1 = var_1_10003.chapter_data[var_76_0]

	BeachGuardConst = var_1_10004

	local var_76_2 = var_1_10004.map_data[var_76_1.map]

	BeachGuardConst = var_5

	local var_76_3 = var_5.chapater_enemy[var_76_0]
	local var_76_4 = arg_76_0.lineCtrl

	var_6.setMapData(var_76_4, var_76_2)

	local var_76_5 = arg_76_0.enemyCtrl

	var_6.setData(var_76_5, var_76_3)

	if arg_76_1.fog then
		setActive = var_76_5
		findTF = var_8

		var_76_5(var_8(arg_76_0._tf, "sceneContainer/scene_front/fog"), true)
	else
		setActive = var_76_5
		findTF = var_8

		var_76_5(var_8(arg_76_0._tf, "sceneContainer/scene_front/fog"), false)
	end

	GetComponent = var_76_5
	findTF = var_8

	local var_76_6 = var_8(arg_76_0._tf, "sceneBg/map")

	typeof = var_9
	Image = var_10

	local var_76_7 = var_76_5(var_76_6, var_9(var_10))

	BeachGuardAsset = var_76_6
	var_76_7.sprite = var_76_6.getBeachMap(var_76_2.pic)

	var_76_7:SetNativeSize()

	return
end

function var_0_0.start(arg_77_0)
	local var_77_0 = arg_77_0.charCtrl

	var_1.start(var_77_0)

	local var_77_1 = arg_77_0.skillCtrl

	var_1.start(var_77_1)

	local var_77_2 = arg_77_0.enemyCtrl

	var_1.start(var_77_2)

	local var_77_3 = arg_77_0.damageCtrl

	var_1.start(var_77_3)

	local var_77_4 = arg_77_0.lineCtrl

	var_1.start(var_77_4)

	return
end

function var_0_0.step(arg_78_0)
	local var_78_0 = arg_78_0._runningData.deltaTime
	local var_78_1 = arg_78_0.charCtrl

	var_2.step(var_78_1, var_78_0)

	local var_78_2 = arg_78_0.skillCtrl

	var_2.step(var_78_2, var_78_0)

	local var_78_3 = arg_78_0.enemyCtrl

	var_2.step(var_78_3, var_78_0)

	local var_78_4 = arg_78_0.damageCtrl

	var_2.step(var_78_4, var_78_0)

	local var_78_5 = arg_78_0.lineCtrl

	var_2.step(var_78_5, var_78_0)

	local var_78_6 = arg_78_0.charCtrl

	if var_2.getEnemyOver(var_78_6) then
		local var_78_7 = arg_78_0._event
		local var_78_8 = var_2.emit

		BeachGuardGameView = var_4

		var_78_8(var_78_7, var_4.GAME_OVER)
	else
		local var_78_9 = arg_78_0.charCtrl

		if #var_2.getEnemys(var_78_9) == 0 then
			local var_78_10 = arg_78_0.enemyCtrl

			if var_2.getFinishCreate(var_78_10) then
				local var_78_11 = arg_78_0._event
				local var_78_12 = var_2.emit

				BeachGuardGameView = var_4

				var_78_12(var_78_11, var_4.GAME_OVER)
			end
		end
	end

	return
end

function var_0_0.stop(arg_79_0)
	local var_79_0 = arg_79_0.charCtrl

	var_1.stop(var_79_0)

	local var_79_1 = arg_79_0.skillCtrl

	var_1.stop(var_79_1)

	local var_79_2 = arg_79_0.enemyCtrl

	var_1.stop(var_79_2)

	local var_79_3 = arg_79_0.damageCtrl

	var_1.stop(var_79_3)

	return
end

function var_0_0.clear(arg_80_0)
	local var_80_0 = arg_80_0.charCtrl

	var_1.clear(var_80_0)

	local var_80_1 = arg_80_0.lineCtrl

	var_1.clear(var_80_1)

	local var_80_2 = arg_80_0.skillCtrl

	var_1.clear(var_80_2)

	local var_80_3 = arg_80_0.enemyCtrl

	var_1.clear(var_80_3)

	local var_80_4 = arg_80_0.damageCtrl

	var_1.clear(var_80_4)

	return
end

function var_0_0.changeRecycles(arg_81_0, arg_81_1)
	local var_81_0 = arg_81_0.charCtrl

	var_2.changeRecycles(var_81_0, arg_81_1)

	return
end

function var_0_0.pullChar(arg_82_0, arg_82_1, arg_82_2, arg_82_3)
	local var_82_0 = arg_82_0.lineCtrl

	if var_4.getGridByIndex(var_82_0, arg_82_2, arg_82_3) and var_4:isEmpty() then
		local var_82_1 = arg_82_0.charCtrl
		local var_82_2 = var_5.setGridChar(var_82_1, arg_82_1, var_4)

		var_4:setChar(var_82_2)

		return true
	end

	return false
end

function var_0_0.setDrag(arg_83_0, arg_83_1)
	local var_83_0 = arg_83_0.lineCtrl

	var_2.setDrag(var_83_0, arg_83_1)

	return
end

function var_0_0.useSkill(arg_84_0, arg_84_1)
	local var_84_0 = arg_84_0.skillCtrl

	var_2.useSkill(var_84_0, arg_84_1)

	return
end

function var_0_0.addEnemy(arg_85_0, arg_85_1)
	local var_85_0 = arg_85_0.lineCtrl
	local var_85_1 = var_2.getAbleLinePos(var_85_0, arg_85_1.lines)
	local var_85_2 = arg_85_0.charCtrl

	var_3.addEnemyChar(var_85_2, arg_85_1.id, var_85_1)

	return
end

function var_0_0.craeteCharDamage(arg_86_0, arg_86_1)
	local var_86_0 = arg_86_0.damageCtrl

	var_2.craeteCharDamage(var_86_0, arg_86_1)

	return
end

function var_0_0.removeChar(arg_87_0, arg_87_1)
	local var_87_0 = arg_87_0.charCtrl

	var_2.removeChar(var_87_0, arg_87_1)

	local var_87_1 = arg_87_0.lineCtrl

	var_2.removeGridChar(var_87_1, arg_87_1)

	return
end

function var_0_0.bulletDamage(arg_88_0, arg_88_1)
	local var_88_0 = arg_88_0.damageCtrl

	var_2.bulletDamage(var_88_0, arg_88_1)

	return
end

function var_0_0.dispose(arg_89_0)
	if arg_89_0.timer then
		local var_89_0 = arg_89_0.timer

		var_1.Stop(var_89_0)

		arg_89_0.timer = nil
	end

	return
end

return var_0_0
