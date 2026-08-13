class = var_0_10000

local var_0_0 = "HideSeekGameView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..BaseMiniGameView"))
local var_0_2 = "bar-soft"
local var_0_3 = "event:/ui/ddldaoshu2"
local var_0_4 = "event:/ui/break_out_full"
local var_0_5 = "hideseekgameui_atlas"
local var_0_6 = 60
local var_0_7 = {
	{
		25,
		0.8,
		1
	},
	{
		45,
		1.2,
		1.4
	},
	{
		60,
		1.6,
		1.8
	}
}
local var_0_8 = 100
local var_0_9 = 2
local var_0_10 = 50
local var_0_11 = 400
local var_0_12 = 400
local var_0_13 = "on_touch_furniture"
local var_0_14 = 1
local var_0_15 = 2
local var_0_16 = 3
local var_0_17 = 4
local var_0_18 = "HideSeekBath"
local var_0_19 = "HideSeekBed"
local var_0_20 = "HideSeekFridge"
local var_0_21 = "HideSeekHakoCL"
local var_0_22 = "HideSeekHakoCR"
local var_0_23 = "HideSeekUpR"
local var_0_24 = "HideSeekUpL"
local var_0_25 = "HideSeekDeskUnder"
local var_0_26 = "HideSeekSofaS"
local var_0_27 = "HideSeekSofaL"
local var_0_28 = "HideSeekHakoSL"
local var_0_29 = "HideSeekHakoSR"
local var_0_30 = "HideSeekHakoML"
local var_0_31 = "HideSeekHakoMR"
local var_0_32 = "HideSeekDeskSR"
local var_0_33 = "HideSeekDeskSL"
local var_0_34 = "HideSeekDeskStudyL"
local var_0_35 = "HideSeekDeskStudyR"
local var_0_36 = "HideSeekCushion"
local var_0_37 = "ui/minigameui/hideseek"
local var_0_38 = 3
local var_0_39 = {
	0,
	1,
	2,
	3,
	4,
	5,
	6,
	7,
	8
}
local var_0_40 = {
	{
		name = "furniture_bath",
		pos_data_list = {
			{
				pos_name = "posBath",
				anim_name = var_0_18
			}
		},
		type = var_0_14
	},
	{
		name = "furniture_bed",
		weight = 0.2,
		pos_data_list = {
			{
				pos_name = "posBed",
				anim_name = var_0_19
			}
		},
		type = var_0_15
	},
	{
		defaut_char_index = 9,
		name = "furniture_Fridge",
		time = 3,
		defaut_trigger = true,
		weight = 0.15,
		pos_data_list = {
			{
				pos_name = "posFridge",
				anim_name = var_0_20
			}
		},
		type = var_0_16
	},
	{
		hide = true,
		name = "furniture_Hako_L1",
		time = 4,
		pos_data_list = {
			{
				pos_name = "posHakoCL",
				anim_name = var_0_21
			}
		},
		type = var_0_14
	},
	{
		hide = true,
		name = "furniture_Cook",
		time = 4,
		pos_data_list = {
			{
				pos_name = "posUpR",
				anim_name = var_0_23
			}
		},
		type = var_0_14
	},
	{
		hide = true,
		name = "furniture_Desk_Dining",
		time = 4,
		pos_data_list = {
			{
				pos_name = "posUnder",
				anim_name = var_0_25
			},
			{
				pos_name = "posUpR",
				anim_name = var_0_23
			},
			{
				pos_name = "posUpL",
				anim_name = var_0_24
			}
		},
		type = var_0_14
	},
	{
		hide = true,
		name = "furniture_Sofa_S",
		time = 4,
		pos_data_list = {
			{
				pos_name = "posSofaS",
				anim_name = var_0_26
			}
		},
		type = var_0_14
	},
	{
		hide = true,
		name = "furniture_Sofa_L",
		time = 4,
		pos_data_list = {
			{
				pos_name = "posSofaL",
				anim_name = var_0_27
			},
			{
				pos_name = "posUpL",
				anim_name = var_0_24
			}
		},
		type = var_0_14
	},
	{
		hide = true,
		name = "furniture_Hako_S1_3",
		time = 4,
		pos_data_list = {
			{
				pos_name = "posHakoSL",
				anim_name = var_0_28
			}
		},
		type = var_0_14
	},
	{
		hide = true,
		name = "furniture_Desk_S",
		time = 4,
		pos_data_list = {
			{
				pos_name = "posDeskSL",
				anim_name = var_0_33
			},
			{
				pos_name = "posDeskSR",
				anim_name = var_0_32
			},
			{
				pos_name = "posDeskUnder",
				anim_name = var_0_25
			}
		},
		type = var_0_14
	},
	{
		hide = true,
		name = "furniture_Hako_L2",
		time = 4,
		pos_data_list = {
			{
				pos_name = "posHakoCL",
				anim_name = var_0_21
			},
			{
				pos_name = "posHakoCR",
				anim_name = var_0_22
			}
		},
		type = var_0_14
	},
	{
		hide = true,
		name = "furniture_Desk_Study",
		time = 4,
		pos_data_list = {
			{
				pos_name = "posDeskStudyL",
				anim_name = var_0_34
			},
			{
				pos_name = "posDeskStudyR",
				anim_name = var_0_35
			}
		},
		type = var_0_14
	},
	{
		hide = true,
		name = "furniture_Hako_M1",
		time = 4,
		pos_data_list = {
			{
				pos_name = "posHakoML",
				anim_name = var_0_30
			}
		},
		type = var_0_14
	},
	{
		hide = true,
		name = "furniture_Hako_M2",
		time = 4,
		pos_data_list = {
			{
				pos_name = "posHakoMR",
				anim_name = var_0_31
			}
		},
		type = var_0_14
	},
	{
		hide = true,
		name = "furniture_Hako_S2",
		time = 4,
		pos_data_list = {
			{
				pos_name = "posHakoSR",
				anim_name = var_0_29
			}
		},
		type = var_0_14
	},
	{
		name = "furniture_Manjuu_cushion",
		pos_data_list = {
			{
				pos_name = "posCushion",
				anim_name = var_0_36
			}
		},
		type = var_0_14,
		hide_tfs = {
			"img"
		}
	}
}
local var_0_41 = {
	HideSeekBath = {
		prefab = "hideseekbath.prefab",
		name = var_0_18,
		ignore_char = {}
	},
	HideSeekBed = {
		prefab = "hideseekbed.prefab",
		name = var_0_19,
		ignore_char = {}
	},
	HideSeekFridge = {
		prefab = "hideseekfridge.prefab",
		name = var_0_20,
		ignore_char = {}
	},
	HideSeekHakoCL = {
		prefab = "hideseekhakocl.prefab",
		name = var_0_21,
		ignore_char = {}
	},
	HideSeekHakoCR = {
		prefab = "hideseekhakocr.prefab",
		name = var_0_22,
		ignore_char = {}
	},
	HideSeekUpR = {
		prefab = "hideseekupr.prefab",
		name = var_0_23,
		ignore_char = {}
	},
	HideSeekUpL = {
		prefab = "hideseekupl.prefab",
		name = var_0_24,
		ignore_char = {}
	},
	HideSeekDeskUnder = {
		prefab = "hideseekdeskunder.prefab",
		name = var_0_25,
		ignore_char = {}
	},
	HideSeekSofaS = {
		prefab = "hideseeksofas.prefab",
		name = var_0_26,
		ignore_char = {}
	},
	HideSeekSofaL = {
		prefab = "hideseeksofal.prefab",
		name = var_0_27,
		ignore_char = {}
	},
	HideSeekHakoSL = {
		prefab = "hideseekhakosl.prefab",
		name = var_0_28,
		ignore_char = {}
	},
	HideSeekHakoSR = {
		prefab = "hideseekhakosr.prefab",
		name = var_0_29,
		ignore_char = {}
	},
	HideSeekDeskSL = {
		prefab = "hideseekdesksl.prefab",
		name = var_0_33,
		ignore_char = {}
	},
	HideSeekDeskSR = {
		prefab = "hideseekdesksr.prefab",
		name = var_0_32,
		ignore_char = {}
	},
	HideSeekDeskStudyL = {
		prefab = "hideseekdeskstudyl.prefab",
		name = var_0_34,
		ignore_char = {}
	},
	HideSeekDeskStudyR = {
		prefab = "hideseekdeskstudyr.prefab",
		name = var_0_35,
		ignore_char = {}
	},
	HideSeekHakoML = {
		prefab = "hideseekhakoml.prefab",
		name = var_0_30,
		ignore_char = {}
	},
	HideSeekHakoMR = {
		prefab = "hideseekhakomr.prefab",
		name = var_0_31,
		ignore_char = {}
	},
	HideSeekCushion = {
		prefab = "hideseekcushion.prefab",
		name = var_0_36,
		ignore_char = {}
	}
}
local var_0_42 = 0.1
local var_0_43 = {
	-475,
	652
}
local var_0_44 = {
	-335,
	290
}

Vector2 = var_0_10044

local var_0_45 = var_0_10044(150, -200)
local var_0_46 = "hideseektv.prefab"
local var_0_47 = {}

local function var_0_48(arg_1_0, arg_1_1)
	local var_1_0 = {
		ctor = function(arg_2_0)
			arg_2_0._event = arg_1_1
			arg_2_0._sceneTf = arg_1_0
			findTF = var_1
			arg_2_0._tplContainer = var_1(arg_1_0, "tplPos")
			Clone = var_1
			var_0_47 = var_1(var_0_39)
			arg_2_0._furnituresPools = {}

			for iter_2_0 = 1, #var_0_40 do
				Clone = var_2_10005
				var_2_10005 = var_2_10005(var_0_40[iter_2_0])
				findTF = var_6

				local var_2_0 = var_6(arg_2_0._sceneTf, var_0_40[iter_2_0].name)

				table = var_7

				var_7.insert(arg_2_0._furnituresPools, {
					activeIndex = 0,
					data = var_2_10005,
					tf = var_2_0
				})
			end

			arg_2_0._unActiveFurnitures = {}
			arg_2_0._activeFurnitures = {}
			arg_2_0._furnitureAnimTfPool = {}
			arg_2_0._animTplDic = {}

			return
		end,
		start = function(arg_3_0)
			arg_3_0.timeStep = 0

			arg_3_0:clear()

			arg_3_0.timeAppear = 0
			arg_3_0.additiveScore = var_0_8

			for iter_3_0 = #arg_3_0._furnituresPools, 1, -1 do
				if arg_3_0._furnituresPools[iter_3_0].data.type == var_0_15 then
					math = var_6

					if var_6.random() <= var_5.data.weight then
						arg_3_0:appearChar(var_5.data.name)
					end

					var_5.initFlag = true
					table = var_7

					var_7.insert(arg_3_0._unActiveFurnitures, arg_3_0:getFunitureFromPool(var_5.data.name))
				elseif var_5.data.type == var_0_16 then
					arg_3_0:appearChar(var_5.data.name)
				end
			end

			return
		end,
		step = function(arg_4_0)
			local var_4_0 = arg_4_0.timeStep

			Time = var_2_10002
			arg_4_0.timeStep = var_4_0 + var_2_10002.deltaTime

			local var_4_1 = false
			local var_4_4

			if arg_4_0.timeAppear <= 0 then
				var_4_1 = true

				local var_4_2 = var_0_6 - arg_4_0.timeStep

				arg_4_0.timeAppear = nil

				for iter_4_0 = 1, #var_0_7 do
					if not arg_4_0.timeAppear and var_4_2 < var_0_7[iter_4_0][1] or iter_4_0 == #var_0_7 then
						local var_4_3 = var_0_7[iter_4_0][2]

						var_2_10008 = var_0_7[iter_4_0][3]
						math = var_2_10009
						arg_4_0.timeAppear = var_2_10009.random() * (var_2_10008 - var_4_3) + var_4_3

						break
					end
				end

				var_4_4 = not arg_4_0.timeAppear and 2 or arg_4_0.timeAppear
				arg_4_0.timeAppear = var_4_4
			else
				local var_4_5 = arg_4_0.timeAppear

				Time = var_4_4
				arg_4_0.timeAppear = var_4_5 - var_4_4.deltaTime
			end

			for iter_4_1 = #arg_4_0._activeFurnitures, 1, -1 do
				if arg_4_0._activeFurnitures[iter_4_1].time then
					local var_4_6 = var_6.time

					Time = var_2_10008
					var_6.time = var_4_6 - var_2_10008.deltaTime

					if var_6.time <= 0 then
						var_2_10008 = arg_4_0

						arg_4_0.setFurnitureTimeEvent(var_2_10008, var_6)
					end
				end
			end

			if var_4_1 then
				arg_4_0:appearChar()
			end

			return
		end,
		setFurnitureTimeEvent = function(arg_5_0, arg_5_1)
			if arg_5_1.data.type == var_0_16 then
				arg_5_0:returnCharIndex(arg_5_1.charIndex)

				math = var_2

				local var_5_2

				if var_2.random() <= arg_5_1.data.weight then
					local var_5_0 = #var_0_47

					if 0 < var_5_0 then
						table = var_5_0

						local var_5_1 = var_5_0.remove

						var_5_2 = var_0_47
						math = var_4
						arg_5_1.charIndex = var_5_1(var_5_2, var_4.random(1, #var_0_47))

						goto label_5_0
					end
				end

				arg_5_1.charIndex = arg_5_1.data.defaut_char_index

				::label_5_0::

				arg_5_1.readyToRemove = false
				arg_5_1.time = arg_5_1.data.time
				GetComponent = var_2
				findTF = var_5_2

				local var_5_3 = var_5_2(arg_5_1.animTf, "anim")

				typeof = var_4
				Animator = var_2_10005

				local var_5_4 = var_2(var_5_3, var_4(var_2_10005))

				var_2.SetInteger(var_5_4, "charIndex", arg_5_1.charIndex)
			elseif arg_5_1.data.type == var_0_14 then
				if arg_5_1.data.hide and not arg_5_1.readyToRemove then
					arg_5_1.time = 2
					arg_5_1.readyToRemove = true
					findTF = var_2

					local var_5_5

					var_5_5, GetComponent = var_2(arg_5_1.animTf, "anim"), var_3
					typeof = var_2_10005
					Animator = var_2_10006

					local var_5_6 = var_3(var_5_5, var_2_10005(var_2_10006))

					var_3.SetTrigger(var_5_6, "hide")
				else
					arg_5_0:returnFurniture(arg_5_1)
				end
			elseif arg_5_1.data.type == var_0_15 then
				if arg_5_1.charIndex then
					local var_5_7 = arg_5_0

					arg_5_0.returnCharIndex(var_5_7, arg_5_1.charIndex)

					if arg_5_1.animTf then
						setActive = var_2
						findTF = var_5_7

						var_2(var_5_7(arg_5_1.animTf, "collider"), false)
					end

					arg_5_1.charIndex = nil
					arg_5_1.time = nil
				end
			else
				arg_5_0:returnFurniture(arg_5_1)
			end

			return
		end,
		returnCharIndex = function(arg_6_0, arg_6_1)
			table = var_2_10002

			if not var_2_10002.contains(var_0_47, arg_6_1) then
				table = var_2

				if var_2.contains(var_0_39, arg_6_1) then
					table = var_2

					var_2.insert(var_0_47, arg_6_1)
				end
			end

			return
		end,
		appearChar = function(arg_7_0, arg_7_1)
			if #var_0_47 <= 0 then
				return
			end

			if #arg_7_0._furnituresPools <= 0 then
				return
			end

			local var_7_0

			if arg_7_1 then
				var_7_0 = arg_7_0:getFunitureFromPool(arg_7_1)
			end

			if not var_7_0 then
				table = var_3

				local var_7_1 = var_3.remove
				local var_7_2 = arg_7_0._furnituresPools

				math = var_2_10005
				var_7_0 = var_7_1(var_7_2, var_2_10005.random(1, #arg_7_0._furnituresPools))
			end

			local var_7_3 = var_7_0.data.pos_data_list

			math = var_2_10005

			local var_7_4 = var_7_3[var_2_10005.random(1, #var_3.pos_data_list)].pos_name
			local var_7_5 = var_4.anim_name
			local var_7_6 = arg_7_0:getActiveIndex()

			if not var_0_41[var_7_5] then
				print = var_2_10009

				var_2_10009("警告，没有找到" .. var_7_5 .. "的动画数据")
				arg_7_0:returnFurniture(var_7_0)

				return
			end

			local var_7_7
			local var_7_8

			if var_7_0.data.type == var_0_16 then
				var_7_7 = var_7_0.data.defaut_char_index
			else
				table = var_7_8
				var_7_8 = var_7_8.remove

				local var_7_9 = var_0_47

				math = var_2_10012
				var_7_7 = var_7_8(var_7_9, var_2_10012.random(1, #var_0_47))
			end

			var_7_0.charIndex = var_7_7
			table = var_7_8

			if var_7_8.contains(var_8.ignore_char, var_7_7) then
				arg_7_0:returnFurniture(var_7_0)

				return
			elseif var_7_0.data.type == var_0_15 and var_7_0.initFlag then
				arg_7_0:returnFurniture(var_7_0)

				return
			end

			var_7_0.posData = var_4
			var_7_0.activeIndex = var_7_6
			var_7_0.animData = var_8
			table = var_10

			var_10.insert(arg_7_0._activeFurnitures, var_7_0)
			arg_7_0:getAnimTfByPosData(var_4, var_7_6, function(arg_8_0, arg_8_1)
				if arg_8_1 ~= var_7_0.activeIndex then
					local var_8_0 = arg_7_0

					var_2.returnAnimTf(var_8_0, var_7_5, arg_8_0)

					return
				end

				if var_7_0.data.hide_tfs then
					for iter_8_0 = 1, #var_7_0.data.hide_tfs do
						setActive = var_3_10006
						findTF = var_3_10007

						var_3_10006(var_3_10007(var_7_0.tf, var_7_0.data.hide_tfs[iter_8_0]), false)
					end
				end

				findTF = var_2

				local var_8_1 = var_2(var_7_0.tf, var_7_4)

				SetParent = var_3

				var_3(arg_8_0, var_8_1)

				setActive = var_3

				var_3(arg_8_0, true)

				setActive = var_3
				findTF = var_4

				var_3(var_4(arg_8_0, "collider"), true)

				Vector2 = var_3
				arg_8_0.anchoredPosition = var_3(0, 0)
				var_7_0.animTf = arg_8_0

				local var_8_2 = arg_7_0

				var_3.prepareAnim(var_8_2, var_7_0)

				return
			end)

			return
		end,
		getFunitureFromPool = function(arg_9_0, arg_9_1)
			for iter_9_0 = 1, #arg_9_0._furnituresPools do
				if arg_9_0._furnituresPools[iter_9_0].data.name == arg_9_1 then
					table = var_6

					return var_6.remove(arg_9_0._furnituresPools, iter_9_0)
				end
			end

			return nil
		end,
		prepareAnim = function(arg_10_0, arg_10_1)
			if not arg_10_1.animData or not arg_10_1.animTf then
				return
			end

			local var_10_0 = arg_10_1.animData
			local var_10_1 = arg_10_1.animTf

			arg_10_1.time = arg_10_1.data.time
			GetComponent = var_4
			findTF = var_2_10005

			local var_10_2 = var_2_10005(var_10_1, "anim")

			typeof = var_6
			Animator = var_7

			local var_10_3 = var_4(var_10_2, var_6(var_7))

			var_4.SetInteger(var_10_3, "charIndex", arg_10_1.charIndex)

			local var_10_4

			if arg_10_1.data.type ~= var_0_16 then
				var_10_4 = var_4

				var_4.SetTrigger(var_10_4, "trigger")
			end

			GetOrAddComponent = var_5
			findTF = var_10_4

			local var_10_5 = var_10_4(var_10_1, "collider")

			typeof = var_7
			EventTriggerListener = var_8

			local var_10_6 = var_5(var_10_5, var_7(var_8))

			var_5.AddPointDownFunc(var_10_6, function(arg_11_0, arg_11_1, arg_11_2)
				if arg_10_1.readyToRemove then
					return
				end

				if arg_10_1.data.type == var_0_16 and arg_10_1.data.defaut_char_index == arg_10_1.charIndex and not arg_10_1.data.defaut_trigger then
					return
				end

				local var_11_0 = false

				if arg_10_1.data.type == var_0_16 and arg_10_1.data.defaut_char_index == arg_10_1.charIndex then
					var_11_0 = true
				end

				if not var_11_0 then
					local var_11_1 = arg_10_0
					local var_11_2 = var_4.getScore(var_11_1)

					pg = var_11_1

					local var_11_3 = var_11_1.CriMgr.GetInstance()

					var_5.PlaySoundEffect_V3(var_11_3, var_0_4)

					local var_11_4 = arg_10_0._event

					var_5.emit(var_11_4, var_0_13, {
						score = var_11_2,
						pos = arg_11_1.position
					})
				end

				arg_10_1.readyToRemove = true

				local var_11_5 = var_0

				var_4.SetTrigger(var_11_5, "next")

				local var_11_6 = arg_10_1
				local var_11_7

				if not arg_10_1.data.time then
					var_11_7 = 3
				end

				var_11_6.time = var_11_7

				return
			end)

			return
		end,
		getScore = function(arg_12_0)
			if not arg_12_0.additiveScore then
				arg_12_0.additiveScore = var_0_8
			end

			if arg_12_0.scoreTime and arg_12_0.timeStep - arg_12_0.scoreTime < var_0_9 then
				arg_12_0.additiveScore = arg_12_0.additiveScore + var_0_10
			else
				arg_12_0.additiveScore = var_0_8
			end

			if arg_12_0.additiveScore >= var_0_11 then
				arg_12_0.additiveScore = var_0_11
			end

			arg_12_0.scoreTime = arg_12_0.timeStep

			return arg_12_0.additiveScore
		end,
		getAnimTfByPosData = function(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
			local var_13_0 = arg_13_1.anim_name

			if arg_13_0._furnitureAnimTfPool and arg_13_0._furnitureAnimTfPool[var_13_0] then
				local var_13_1 = #arg_13_0._furnitureAnimTfPool[var_13_0]

				if 0 < var_13_1 then
					local var_13_2 = arg_13_3

					table = var_6

					var_13_2(var_6.remove(arg_13_0._furnitureAnimTfPool[var_13_0], 1), arg_13_2)

					return
				end
			end

			return arg_13_0:createAnimTf(var_13_0, arg_13_2, arg_13_3)
		end,
		returnFurniture = function(arg_14_0, arg_14_1)
			if not arg_14_1 then
				return
			end

			if arg_14_1.charIndex then
				arg_14_0:returnCharIndex(arg_14_1.charIndex)

				arg_14_1.charIndex = nil
			end

			if arg_14_1.animData and arg_14_1.animTf then
				local var_14_0 = arg_14_1.animData.name

				arg_14_0:returnAnimTf(var_14_0, arg_14_1.animTf)
			end

			if arg_14_1.data.hide_tfs then
				for iter_14_0 = 1, #arg_14_1.data.hide_tfs do
					setActive = var_2_10006
					findTF = var_2_10007

					var_2_10006(var_2_10007(arg_14_1.tf, arg_14_1.data.hide_tfs[iter_14_0]), true)
				end
			end

			arg_14_1.animTf = nil
			arg_14_1.animData = nil
			arg_14_1.activeIndex = nil
			arg_14_1.readyToRemove = false
			arg_14_1.time = nil

			for iter_14_1 = #arg_14_0._activeFurnitures, 1, -1 do
				if arg_14_0._activeFurnitures[iter_14_1] == arg_14_1 then
					table = var_6

					local var_14_1 = var_6.insert
					local var_14_2 = arg_14_0._furnituresPools

					table = var_2_10008

					var_14_1(var_14_2, var_2_10008.remove(arg_14_0._activeFurnitures, iter_14_1))
				end
			end

			for iter_14_2 = #arg_14_0._unActiveFurnitures, 1, -1 do
				if arg_14_0._unActiveFurnitures[iter_14_2] == arg_14_1 then
					table = var_6

					local var_14_3 = var_6.insert
					local var_14_4 = arg_14_0._furnituresPools

					table = var_2_10008

					var_14_3(var_14_4, var_2_10008.remove(arg_14_0._unActiveFurnitures, iter_14_2))
				end
			end

			local var_14_5 = false

			for iter_14_3 = 1, #arg_14_0._furnituresPools do
				if arg_14_0._furnituresPools[iter_14_3] == arg_14_1 then
					var_14_5 = true
				end
			end

			if not var_14_5 then
				table = var_3

				var_3.insert(arg_14_0._furnituresPools, arg_14_1)
			end

			return
		end,
		returnAnimTf = function(arg_15_0, arg_15_1, arg_15_2)
			local var_15_0

			if not arg_15_0._furnitureAnimTfPool[arg_15_1] then
				var_15_0 = arg_15_0._furnitureAnimTfPool
				var_15_0[arg_15_1] = {}
			end

			setActive = var_15_0

			var_15_0(arg_15_2, false)

			table = var_15_0

			var_15_0.insert(arg_15_0._furnitureAnimTfPool[arg_15_1], arg_15_2)

			return
		end,
		createAnimTf = function(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
			if not var_0_41[arg_16_1] then
				return nil
			end

			local var_16_0 = var_4.prefab
			local var_16_1 = var_4.name
			local var_16_2

			if arg_16_0._animTplDic[var_16_1] then
				var_16_2 = arg_16_3
				tf = var_2_10008
				Instantiate = var_2_10009

				var_16_2(var_2_10008(var_2_10009(arg_16_0._animTplDic[var_16_1])), arg_16_2)
			else
				LoadAndInstantiateAsync = var_16_2

				var_16_2(var_0_37, var_16_0, function(arg_17_0)
					if not arg_17_0 then
						print = var_3_10001

						var_3_10001("找不到资源" .. var_16_1)

						return
					end

					if arg_16_0.destroyFlag then
						Destroy = var_1

						var_1(arg_17_0)

						return
					end

					local var_17_0 = arg_16_0._animTplDic

					var_17_0[var_16_1] = arg_17_0
					SetParent = var_17_0
					tf = var_2

					var_17_0(var_2(arg_17_0), arg_16_0._tplContainer)

					local var_17_1 = arg_16_3

					tf = var_2
					Instantiate = var_3

					var_17_1(var_2(var_3(arg_16_0._animTplDic[var_16_1])), arg_16_2)

					return
				end)
			end

			return
		end,
		getActiveIndex = function(arg_18_0)
			if not arg_18_0._activeIndex then
				arg_18_0._activeIndex = 0
			end

			arg_18_0._activeIndex = arg_18_0._activeIndex + 1

			return arg_18_0._activeIndex
		end,
		clear = function(arg_19_0)
			for iter_19_0 = #arg_19_0._activeFurnitures, 1, -1 do
				arg_19_0:returnFurniture(arg_19_0._activeFurnitures[iter_19_0])
			end

			for iter_19_1 = #arg_19_0._unActiveFurnitures, 1, -1 do
				arg_19_0:returnFurniture(arg_19_0._unActiveFurnitures[iter_19_1])
			end

			for iter_19_2 = 1, #arg_19_0._furnituresPools do
				if arg_19_0._furnituresPools[iter_19_2].data.type == var_0_15 then
					var_5.initFlag = false
				end
			end

			arg_19_0._activeFurnitures = {}
			Clone = var_1
			var_0_47 = var_1(var_0_39)

			return
		end,
		destroy = function(arg_20_0)
			arg_20_0:clear()

			for iter_20_0 = 1, #arg_20_0._furnitureAnimTfPool do
				if arg_20_0._furnitureAnimTfPool[iter_20_0].animTf then
					GetOrAddComponent = var_2_10006
					findTF = var_2_10007
					var_2_10007 = var_2_10007(var_5, "collider")
					typeof = var_8
					EventTriggerListener = var_9
					var_2_10006 = var_2_10006(var_2_10007, var_8(var_9))
					ClearEventTrigger = var_2_10007

					var_2_10007(var_2_10006)
				end
			end

			arg_20_0.destroyFlag = true

			return
		end
	}

	var_2.ctor(var_1_0)

	return var_2
end

local var_0_49 = {
	{
		name = "posMoveRole_1",
		start = true,
		switch_parent = true,
		finish = true,
		finish_weight = 1,
		next = {
			"posMoveRole_2"
		}
	},
	{
		finish = false,
		name = "posMoveRole_2",
		start = false,
		next = {
			"posMoveRole_1",
			"posMoveRole_3",
			"posMoveRole_4"
		}
	},
	{
		name = "posMoveRole_3",
		start = false,
		finish = false,
		finish_weight = 1,
		next = {
			"posMoveRole_2",
			"posMoveRole_5"
		}
	},
	{
		name = "posMoveRole_4",
		start = true,
		finish = true,
		finish_weight = 1,
		next = {
			"posMoveRole_2"
		}
	},
	{
		name = "posMoveRole_5",
		start = false,
		finish = false,
		finish_weight = 1,
		next = {
			"posMoveRole_3",
			"posMoveRole_6",
			"posMoveRole_9"
		}
	},
	{
		name = "posMoveRole_6",
		start = false,
		finish = false,
		finish_weight = 1,
		next = {
			"posMoveRole_5",
			"posMoveRole_7",
			"posMoveRole_8"
		}
	},
	{
		name = "posMoveRole_7",
		start = true,
		switch_parent = true,
		finish = true,
		finish_weight = 1,
		next = {
			"posMoveRole_6"
		}
	},
	{
		name = "posMoveRole_8",
		start = true,
		finish = true,
		finish_weight = 1,
		next = {
			"posMoveRole_6"
		}
	},
	{
		name = "posMoveRole_9",
		start = true,
		finish = true,
		finish_weight = 1,
		next = {
			"posMoveRole_5"
		}
	}
}
local var_0_50 = {
	5,
	10
}
local var_0_51 = 300
local var_0_52 = 200

local function var_0_53(arg_21_0, arg_21_1)
	local var_21_0 = {
		ctor = function(arg_22_0)
			arg_22_0._tf = arg_21_0
			arg_22_0._event = arg_21_1
			findTF = var_1
			arg_22_0._roleTf = var_1(arg_22_0._tf, "fushun")
			GetComponent = var_1
			findTF = var_2

			local var_22_0 = var_2(arg_22_0._roleTf, "img/anim")

			typeof = var_3
			Animator = var_4
			arg_22_0._roleAnimator = var_1(var_22_0, var_3(var_4))
			GetComponent = var_1
			findTF = var_22_0

			local var_22_1 = var_22_0(arg_22_0._roleTf, "img/anim")

			typeof = var_3
			DftAniEvent = var_4
			arg_22_0._dftEvent = var_1(var_22_1, var_3(var_4))

			local var_22_2 = arg_22_0._dftEvent

			var_1.SetEndEvent(var_22_2, function(arg_23_0)
				setActive = var_3_10001

				var_3_10001(arg_22_0._roleTf, false)

				local var_23_0 = arg_22_0

				var_1.clear(var_23_0)

				return
			end)

			GetOrAddComponent = var_1
			findTF = var_22_2

			local var_22_3 = var_22_2(arg_22_0._roleTf, "img/collider")

			typeof = var_3
			EventTriggerListener = var_4
			arg_22_0._eventTrigger = var_1(var_22_3, var_3(var_4))

			local var_22_4 = arg_22_0._eventTrigger

			var_1.AddPointDownFunc(var_22_4, function(arg_24_0, arg_24_1, arg_24_2)
				if arg_22_0.removeRoleFlag then
					return
				end

				pg = var_3

				local var_24_0 = var_3.CriMgr.GetInstance()

				var_3.PlaySoundEffect_V3(var_24_0, var_0_4)

				local var_24_1 = arg_22_0._event

				var_3.emit(var_24_1, var_0_13, {
					score = var_0_12,
					pos = arg_24_1.position
				})

				arg_22_0.removeRoleFlag = true

				local var_24_2 = arg_22_0

				var_3.setRoleAnimatorTrigger(var_24_2, "touch")

				return
			end)

			arg_22_0._roleShowData = {}
			arg_22_0._roleShowStartData = {}

			for iter_22_0 = 1, #var_0_49 do
				local var_22_5

				if var_0_49[iter_22_0].start then
					table = var_22_5
					var_22_5 = var_22_5.insert

					local var_22_6 = arg_22_0._roleShowStartData

					Clone = var_2_10007

					var_22_5(var_22_6, var_2_10007(var_0_49[iter_22_0]))
				end

				Clone = var_22_5

				local var_22_7 = var_22_5(var_0_49[iter_22_0])

				arg_22_0._roleShowData[var_22_7.name] = var_22_7
			end

			arg_22_0._active = false
			Vector2 = var_1
			arg_22_0._targetPos = var_1(0, 0)
			arg_22_0._currentTargetData = nil
			arg_22_0._currentTargetPos = nil

			return
		end,
		setRoleAnimatorTrigger = function(arg_25_0, arg_25_1, arg_25_2)
			if not arg_25_2 then
				local var_25_0 = arg_25_0._roleAnimator

				var_3.SetTrigger(var_25_0, arg_25_1)
			else
				local var_25_1 = arg_25_0._roleAnimator

				var_3.ResetTrigger(var_25_1, arg_25_1)
			end

			return
		end,
		start = function(arg_26_0)
			math = var_2_10001
			arg_26_0.showTime = var_2_10001.random() * (var_0_50[2] - var_0_50[1]) + var_0_50[1]

			arg_26_0:clear()

			return
		end,
		step = function(arg_27_0)
			local var_27_0 = arg_27_0.showTime

			if 0 < var_27_0 then
				local var_27_1 = arg_27_0.showTime

				Time = var_2
				arg_27_0.showTime = var_27_1 - var_2.deltaTime

				if arg_27_0.showTime <= 0 then
					arg_27_0.showTime = 0

					arg_27_0:checkShow()
				end
			end

			if arg_27_0._currentTargetData and not arg_27_0.removeRoleFlag then
				local var_27_2 = arg_27_0._roleTf.anchoredPosition
				local var_27_3 = var_0_51

				math = var_2_10003

				local var_27_4 = var_27_3 * var_2_10003.cos(arg_27_0._moveAngle)

				Time = var_3

				local var_27_5 = var_27_4 * var_3.deltaTime
				local var_27_6 = var_0_51

				math = var_4

				local var_27_7 = var_27_6 * var_4.sin(arg_27_0._moveAngle)

				Time = var_4

				local var_27_8 = var_27_7 * var_4.deltaTime

				if arg_27_0._roleDirectX == 1 and arg_27_0._roleDirectX * var_27_5 + var_27_2.x > arg_27_0._currentTargetPos.x then
					var_27_2.x = var_27_2.x + arg_27_0._roleDirectX * var_27_5
					arg_27_0._roleDirectX = nil
				elseif arg_27_0._roleDirectX == -1 and arg_27_0._roleDirectX * var_27_5 + var_27_2.x < arg_27_0._currentTargetPos.x then
					var_27_2.x = var_27_2.x + arg_27_0._roleDirectX * var_27_5
					arg_27_0._roleDirectX = nil
				elseif arg_27_0._roleDirectX then
					var_27_2.x = var_27_2.x + arg_27_0._roleDirectX * var_27_5
				end

				if arg_27_0._roleDirectY == 1 and arg_27_0._roleDirectY * var_27_8 + var_27_2.y > arg_27_0._currentTargetPos.y then
					var_27_2.y = var_27_2.y + arg_27_0._roleDirectY * var_27_8
					arg_27_0._roleDirectY = nil
				elseif arg_27_0._roleDirectY == -1 and arg_27_0._roleDirectY * var_27_8 + var_27_2.y < arg_27_0._currentTargetPos.y then
					var_27_2.y = var_27_2.y + arg_27_0._roleDirectY * var_27_8
					arg_27_0._roleDirectY = nil
				elseif arg_27_0._roleDirectY then
					var_27_2.y = var_27_2.y + arg_27_0._roleDirectY * var_27_8
				end

				arg_27_0._roleTf.anchoredPosition = var_27_2

				if arg_27_0._roleDirectX == nil and arg_27_0._roleDirectY == nil then
					arg_27_0:setRoleNext()
				end
			end

			return
		end,
		setRoleStatus = function(arg_28_0, arg_28_1)
			setActive = var_2_10002

			var_2_10002(arg_28_0._roleTf, true)

			if arg_28_1 then
				arg_28_0:setRoleAnimatorTrigger("change", true)
				arg_28_0:setRoleAnimatorTrigger("hide", true)
				arg_28_0:setRoleAnimatorTrigger("show")
			else
				arg_28_0:setRoleAnimatorTrigger("change")
			end

			local var_28_0 = arg_28_0._roleAnimator

			var_2.SetInteger(var_28_0, "directX", arg_28_0._roleDirectX)

			local var_28_1 = arg_28_0._roleAnimator

			var_2.SetInteger(var_28_1, "directY", arg_28_0._roleDirectY)

			return
		end,
		setRoleNext = function(arg_29_0, arg_29_1)
			if arg_29_1 or not arg_29_0._currentTargetData.finish then
				local var_29_0

				if not arg_29_1 then
					var_29_0 = arg_29_0._currentData.name
					var_29_0 = arg_29_0._currentData.name
					arg_29_0._currentData = arg_29_0._currentTargetData
				end

				Clone = var_2_10003

				local var_29_1 = var_2_10003(arg_29_0._currentData.next)

				if var_29_0 then
					for iter_29_0 = #var_29_1, 1, -1 do
						if var_29_1[iter_29_0] == var_29_0 then
							table = var_8

							var_8.remove(var_29_1, iter_29_0)
						end
					end
				end

				if #var_29_1 == 0 then
					arg_29_0:clear()

					return
				end

				math = var_4

				local var_29_2 = var_29_1[var_4.random(1, #var_29_1)]

				arg_29_0._currentTargetData = arg_29_0._roleShowData[var_29_2]
				findTF = var_5

				local var_29_3 = var_5(arg_29_0._tf, arg_29_0._currentData.name)

				findTF = var_6

				local var_29_4 = var_6(arg_29_0._tf, arg_29_0._currentTargetData.name)

				if arg_29_0._currentTargetData and arg_29_0._currentTargetData.switch_parent then
					setParent = var_7

					var_7(arg_29_0._roleTf, var_29_4)
				else
					setParent = var_7

					var_7(arg_29_0._roleTf, var_29_3)
				end

				findTF = var_7

				local var_29_5 = var_7(var_29_3, "rolePos")
				local var_29_6 = arg_29_0._roleTf

				var_29_6.anchoredPosition = var_29_5.anchoredPosition
				findTF = var_29_6
				arg_29_0._currentTargetPos = var_29_6(arg_29_0._tf, arg_29_0._currentTargetData.name .. "/rolePos").anchoredPosition
				arg_29_0._roleDirectX = arg_29_0._currentTargetPos.x > arg_29_0._roleTf.anchoredPosition.x and 1 or -1

				local var_29_7 = arg_29_0._currentTargetPos.y

				arg_29_0._roleDirectY = arg_29_0._roleTf.anchoredPosition.y < var_29_7 and 1 or -1
				math = var_8

				local var_29_8 = var_8.atan

				math = var_9

				local var_29_9 = var_9.abs(arg_29_0._currentTargetPos.y - arg_29_0._roleTf.anchoredPosition.y)

				math = var_10
				arg_29_0._moveAngle = var_29_8(var_29_9 / var_10.abs(arg_29_0._currentTargetPos.x - arg_29_0._roleTf.anchoredPosition.x))
				arg_29_0.removeRoleFlag = false

				arg_29_0:setRoleStatus(arg_29_1)
			elseif arg_29_0._currentTargetData.finish then
				arg_29_0:clear()
			end

			return
		end,
		checkShow = function(arg_30_0)
			if arg_30_0._active then
				table = var_1

				if not var_1.contains(var_0_47, var_0_38) then
					return
				end
			end

			for iter_30_0 = #var_0_47, 1, -1 do
				if var_0_47[iter_30_0] == var_0_38 then
					table = var_5

					var_5.remove(var_0_47, iter_30_0)
				end
			end

			arg_30_0._active = true

			local var_30_0 = arg_30_0._roleShowStartData

			math = var_2
			arg_30_0._currentData = var_30_0[var_2.random(1, #arg_30_0._roleShowStartData)]

			arg_30_0:setRoleNext(true)

			return
		end,
		clear = function(arg_31_0)
			arg_31_0._currentTargetData = nil
			arg_31_0._currentTargetPos = nil
			table = var_1

			if not var_1.contains(var_0_47, var_0_38) then
				table = var_1

				var_1.insert(var_0_47, var_0_38)
			end

			isActive = var_1

			if var_1(arg_31_0._roleTf) then
				arg_31_0:setRoleAnimatorTrigger("hide")

				arg_31_0.removeRoleFlag = true
				setActive = var_1

				var_1(arg_31_0._roleTf, false)
			end

			math = var_1
			arg_31_0.showTime = var_1.random() * (var_0_50[2] - var_0_50[1]) + var_0_50[1]
			arg_31_0._active = false

			return
		end,
		destroy = function(arg_32_0)
			return
		end
	}

	var_2.ctor(var_21_0)

	return var_2
end

local var_0_54 = {
	"boot00",
	"boot01",
	"boot02"
}
local var_0_55 = {
	"game00",
	"game01",
	"game02"
}
local var_0_56 = {
	"tv00",
	"tv01",
	"tv02",
	"tv03",
	"tv04",
	"tv05",
	"tv06",
	"tv07",
	"tv08",
	"tv09",
	"tv10",
	"tv11",
	"tv12",
	"tv13",
	"tv14"
}
local var_0_57 = {
	1,
	3
}

local function var_0_58(arg_33_0, arg_33_1)
	local var_33_0 = {
		ctor = function(arg_34_0)
			arg_34_0._tf = arg_33_0
			arg_34_0._event = arg_33_1
			arg_34_0.loadedFlag = false
			arg_34_0._tvTf = nil
			arg_34_0._active = false
			arg_34_0._tvAnimator = nil
			onButton = var_1

			local var_34_0 = arg_34_0._event

			findTF = var_2_10003

			local var_34_1 = var_2_10003(arg_34_0._tf, "collider")

			local function var_34_2()
				if arg_34_0.loadedFlag then
					return
				end

				arg_34_0._active = not arg_34_0._active

				local var_35_0 = arg_34_0

				var_0.updateUI(var_35_0)

				return
			end

			SFX_CANCEL = var_5

			var_1(var_34_0, var_34_1, var_34_2, var_5)

			return
		end,
		start = function(arg_36_0)
			arg_36_0._active = true

			arg_36_0:updateUI()

			if not arg_36_0.loadedFlag then
				LoadAndInstantiateAsync = var_1

				var_1(var_0_37, var_0_46, function(arg_37_0)
					if not arg_37_0 then
						print = var_3_10001

						var_3_10001("tv资源加载失败")

						return
					end

					if arg_36_0.destroyFlag then
						Destroy = var_1

						var_1(arg_37_0)

						return
					end

					arg_36_0.loadedFlag = true

					local var_37_0 = arg_36_0

					tf = var_2
					var_37_0._tvTf = var_2(arg_37_0)

					local var_37_1 = arg_36_0

					GetComponent = var_2
					findTF = var_3

					local var_37_2 = var_3(arg_36_0._tvTf, "anim")

					typeof = var_4
					Animator = var_5
					var_37_1._tvAnimator = var_2(var_37_2, var_4(var_5))
					GetComponent = var_37_1
					findTF = var_2

					local var_37_3 = var_2(arg_36_0._tvTf, "anim")

					typeof = var_3
					DftAniEvent = var_4

					local var_37_4 = var_37_1(var_37_3, var_3(var_4))

					var_1.SetEndEvent(var_37_4, function()
						local var_38_0 = arg_36_0

						var_0.onTvComplete(var_38_0)

						return
					end)

					onButton = var_2

					local var_37_5 = arg_36_0._event

					findTF = var_4

					var_2(var_37_5, var_4(arg_36_0._tvTf, "collider"), function()
						arg_36_0._active = not arg_36_0._active

						local var_39_0 = arg_36_0

						var_0.updateUI(var_39_0)

						return
					end)

					setParent = var_2

					local var_37_6 = arg_36_0._tvTf

					findTF = var_4

					var_2(var_37_6, var_4(arg_36_0._tf, "posTv"))

					local var_37_7 = arg_36_0

					var_2.updateUI(var_37_7)

					local var_37_8 = arg_36_0

					var_2.setTvData(var_37_8)

					return
				end)
			else
				arg_36_0:setTvData()
			end

			return
		end,
		setTvData = function(arg_40_0)
			arg_40_0.playIndex = 1
			arg_40_0.playTvData = {}
			math = var_1

			local var_40_0 = var_1.random(var_0_57[1], var_0_57[2])

			Clone = var_2

			local var_40_1 = var_2(var_0_56)

			Clone = var_3

			local var_40_2 = var_3(var_0_54)

			Clone = var_4

			local var_40_3 = var_4(var_0_55)

			for iter_40_0 = 1, var_40_0 do
				table = var_2_10009
				var_2_10009 = var_2_10009.insert

				local var_40_4 = arg_40_0.playTvData

				table = var_2_10011
				var_2_10011 = var_2_10011.remove

				local var_40_5 = var_40_1

				math = var_2_10013

				var_2_10009(var_40_4, var_2_10011(var_40_5, var_2_10013.random(1, #var_40_1)))
			end

			table = var_5

			local var_40_6 = var_5.insert
			local var_40_7 = arg_40_0.playTvData

			table = var_7

			local var_40_8 = var_7.remove
			local var_40_9 = var_40_2

			math = var_2_10009

			var_40_6(var_40_7, var_40_8(var_40_9, var_2_10009.random(1, #var_40_2)))

			table = var_40_6

			local var_40_10 = var_40_6.insert
			local var_40_11 = arg_40_0.playTvData

			table = var_7

			local var_40_12 = var_7.remove
			local var_40_13 = var_40_3

			math = var_9

			var_40_10(var_40_11, var_40_12(var_40_13, var_9.random(1, #var_40_3)))

			local var_40_14 = arg_40_0._tvAnimator

			var_5.Play(var_40_14, arg_40_0.playTvData[arg_40_0.playIndex], -1, 0)

			return
		end,
		onTvComplete = function(arg_41_0)
			if not arg_41_0.playIndex and not arg_41_0.playTvData and #arg_41_0.playTvData == 0 then
				return
			end

			if arg_41_0._tvAnimator then
				arg_41_0.playIndex = arg_41_0.playIndex + 1

				if arg_41_0.playIndex > #arg_41_0.playTvData then
					arg_41_0.playIndex = #arg_41_0.playTvData
				end

				local var_41_0 = arg_41_0._tvAnimator

				var_1.Play(var_41_0, arg_41_0.playTvData[arg_41_0.playIndex], -1, 0)
			end

			return
		end,
		step = function(arg_42_0)
			if arg_42_0._tvAnimator and arg_42_0._tvAnimator.speed == 0 then
				arg_42_0._tvAnimator.speed = 1
			end

			return
		end,
		pause = function(arg_43_0)
			if arg_43_0._tvAnimator then
				arg_43_0._tvAnimator.speed = 0
			end

			return
		end,
		updateUI = function(arg_44_0)
			local var_44_0

			if arg_44_0.loadedFlag then
				setActive = var_44_0
				findTF = var_2_10002

				var_44_0(var_2_10002(arg_44_0._tf, "on"), false)

				setActive = var_44_0
				findTF = var_2_10002

				var_44_0(var_2_10002(arg_44_0._tf, "off"), false)

				if not arg_44_0.tvCanvas then
					GetComponent = var_44_0
					findTF = var_2_10002
					var_2_10002 = var_2_10002(arg_44_0._tvTf, "anim")
					typeof = var_3
					CanvasGroup = var_4
					arg_44_0.tvCanvas = var_44_0(var_2_10002, var_3(var_4))
				end

				var_44_0 = arg_44_0.tvCanvas
				var_2_10002 = arg_44_0._active and 1 or 0
				var_44_0.alpha = var_2_10002
			else
				setActive = var_44_0
				findTF = var_2_10002

				var_44_0(var_2_10002(arg_44_0._tf, "on"), arg_44_0._active)

				setActive = var_44_0
				findTF = var_2

				var_44_0(var_2(arg_44_0._tf, "off"), not arg_44_0._active)
			end

			return
		end,
		destroy = function(arg_45_0)
			arg_45_0.destroyFlag = true

			return
		end,
		clear = function(arg_46_0)
			return
		end
	}

	var_2.ctor(var_33_0)

	return var_2
end

function var_0_1.getUIName(arg_47_0)
	return "HideSeekGameUI"
end

function var_0_1.getBGM(arg_48_0)
	return var_0_2
end

function var_0_1.didEnter(arg_49_0)
	arg_49_0:initEvent()
	arg_49_0:initData()
	arg_49_0:initUI()
	arg_49_0:initGameUI()
	arg_49_0:initController()
	arg_49_0:updateMenuUI()
	arg_49_0:openMenuUI()

	return
end

function var_0_1.initEvent(arg_50_0)
	if not arg_50_0.uiCam then
		GameObject = var_1

		local var_50_0 = var_1.Find("UICamera")

		arg_50_0.uiCam = var_1.GetComponent(var_50_0, "Camera")
	end

	arg_50_0:bind(var_0_13, function(arg_51_0, arg_51_1, arg_51_2)
		local var_51_0 = arg_50_0

		var_3.addScore(var_51_0, arg_51_1.score)

		local var_51_1 = arg_50_0

		var_3.showScore(var_51_1, arg_51_1)

		return
	end)

	return
end

function var_0_1.showScore(arg_52_0, arg_52_1)
	local var_52_0
	local var_52_1 = #arg_52_0.showScoresPool
	local var_52_2

	if 0 < var_52_1 then
		table = var_52_1
		var_52_0 = var_52_1.remove(arg_52_0.showScoresPool, 1)
	else
		tf = var_52_1
		Instantiate = var_52_2
		var_52_0 = var_52_1(var_52_2(arg_52_0.showScoreTpl))
		setParent = var_52_1

		var_52_1(var_52_0, arg_52_0.sceneFrontContainer)

		GetComponent = var_52_1
		findTF = var_52_2
		var_52_2 = var_52_2(var_52_0, "anim")
		typeof = var_5
		DftAniEvent = var_6

		local var_52_3 = var_52_1(var_52_2, var_5(var_6))

		var_52_1.SetEndEvent(var_52_3, function()
			for iter_53_0 = #arg_52_0.showScores, 1, -1 do
				if var_52_0 == arg_52_0.showScores[iter_53_0] then
					table = var_4

					local var_53_0 = var_4.insert
					local var_53_1 = arg_52_0.showScoresPool

					table = var_2_10006

					var_53_0(var_53_1, var_2_10006.remove(arg_52_0.showScores, iter_53_0))
				end
			end

			return
		end)
	end

	setText = var_52_1
	findTF = var_52_2

	local var_52_4 = var_52_2(var_52_0, "anim")
	local var_52_5 = "+"

	tostring = var_6

	var_52_1(var_52_4, var_52_5 .. var_6(arg_52_1.score))

	local var_52_6 = arg_52_0.uiCam
	local var_52_7 = var_3.ScreenToWorldPoint(var_52_6, arg_52_1.pos)
	local var_52_8 = arg_52_0.sceneFrontContainer

	var_52_0.anchoredPosition = var_4.InverseTransformPoint(var_52_8, var_52_7)
	setActive = var_4

	var_4(var_52_0, false)

	setActive = var_4

	var_4(var_52_0, true)

	table = var_4

	var_4.insert(arg_52_0.showScores, var_52_0)

	return
end

function var_0_1.onEventHandle(arg_54_0, arg_54_1)
	return
end

function var_0_1.initData(arg_55_0)
	Application = var_1_10001

	local var_55_0

	if not var_1_10001.targetFrameRate then
		var_55_0 = 60
	end

	if 60 < var_55_0 then
		var_55_0 = 60
	end

	Timer = var_2
	arg_55_0.timer = var_2.New(function()
		local var_56_0 = arg_55_0

		var_0.onTimer(var_56_0)

		return
	end, 1 / var_55_0, -1)
	arg_55_0.showScores = {}
	arg_55_0.showScoresPool = {}

	return
end

function var_0_1.initUI(arg_57_0)
	findTF = var_1_10001
	arg_57_0.backSceneTf = var_1_10001(arg_57_0._tf, "scene_background")
	findTF = var_1
	arg_57_0.sceneContainer = var_1(arg_57_0._tf, "sceneMask/sceneContainer")
	findTF = var_1
	arg_57_0.sceneFrontContainer = var_1(arg_57_0._tf, "sceneMask/sceneContainer/scene_front")
	findTF = var_1
	arg_57_0.clickMask = var_1(arg_57_0._tf, "clickMask")
	findTF = var_1
	arg_57_0.bg = var_1(arg_57_0._tf, "bg")
	findTF = var_1
	arg_57_0.countUI = var_1(arg_57_0._tf, "pop/CountUI")
	GetComponent = var_1
	findTF = var_2

	local var_57_0 = var_2(arg_57_0.countUI, "count")

	typeof = var_3
	Animator = var_4
	arg_57_0.countAnimator = var_1(var_57_0, var_3(var_4))
	GetOrAddComponent = var_1
	findTF = var_57_0

	local var_57_1 = var_57_0(arg_57_0.countUI, "count")

	typeof = var_3
	DftAniEvent = var_4
	arg_57_0.countDft = var_1(var_57_1, var_3(var_4))

	local var_57_2 = arg_57_0.countDft

	var_1.SetTriggerEvent(var_57_2, function()
		return
	end)

	local var_57_3 = arg_57_0.countDft

	var_1.SetEndEvent(var_57_3, function()
		setActive = var_2_10000

		var_2_10000(arg_57_0.countUI, false)

		local var_59_0 = arg_57_0

		var_0.gameStart(var_59_0)

		return
	end)

	findTF = var_1
	arg_57_0.leaveUI = var_1(arg_57_0._tf, "pop/LeaveUI")
	onButton = var_1

	local var_57_4 = arg_57_0

	findTF = var_3

	local var_57_5 = var_3(arg_57_0.leaveUI, "ad/btnOk")

	local function var_57_6()
		local var_60_0 = arg_57_0

		var_0.resumeGame(var_60_0)

		local var_60_1 = arg_57_0

		var_0.onGameOver(var_60_1)

		return
	end

	SFX_CANCEL = var_5

	var_1(var_57_4, var_57_5, var_57_6, var_5)

	onButton = var_1

	local var_57_7 = arg_57_0

	findTF = var_57_5

	local var_57_8 = var_57_5(arg_57_0.leaveUI, "ad/btnCancel")

	local function var_57_9()
		local var_61_0 = arg_57_0

		var_0.resumeGame(var_61_0)

		return
	end

	SFX_CANCEL = var_5

	var_1(var_57_7, var_57_8, var_57_9, var_5)

	findTF = var_1
	arg_57_0.pauseUI = var_1(arg_57_0._tf, "pop/pauseUI")
	onButton = var_1

	local var_57_10 = arg_57_0

	findTF = var_3

	local var_57_11 = var_3(arg_57_0.pauseUI, "ad/btnOk")

	local function var_57_12()
		setActive = var_2_10000

		var_2_10000(arg_57_0.pauseUI, false)

		local var_62_0 = arg_57_0

		var_0.resumeGame(var_62_0)

		return
	end

	SFX_CANCEL = var_5

	var_1(var_57_10, var_57_11, var_57_12, var_5)

	findTF = var_1
	arg_57_0.settlementUI = var_1(arg_57_0._tf, "pop/SettleMentUI")
	onButton = var_1

	local var_57_13 = arg_57_0

	findTF = var_3

	local var_57_14 = var_3(arg_57_0.settlementUI, "ad/btnOver")

	local function var_57_15()
		setActive = var_2_10000

		var_2_10000(arg_57_0.settlementUI, false)

		local var_63_0 = arg_57_0

		var_0.openMenuUI(var_63_0)

		return
	end

	SFX_CANCEL = var_5

	var_1(var_57_13, var_57_14, var_57_15, var_5)

	findTF = var_1
	arg_57_0.menuUI = var_1(arg_57_0._tf, "pop/menuUI")
	GetComponent = var_1
	findTF = var_2

	local var_57_16 = var_2(arg_57_0.menuUI, "battList")

	typeof = var_3
	ScrollRect = var_4
	arg_57_0.battleScrollRect = var_1(var_57_16, var_3(var_4))
	arg_57_0.totalTimes = arg_57_0:getGameTotalTime()

	local var_57_17, var_57_18

	if arg_57_0:getGameUsedTimes() - 4 < 0 then
		var_57_17 = 0
	else
		var_57_18 = arg_57_0
		var_57_17 = arg_57_0.getGameUsedTimes(var_57_18) - 4
	end

	scrollTo = var_57_18

	var_57_18(arg_57_0.battleScrollRect, 0, 1 - var_57_17 / (arg_57_0.totalTimes - 4))

	onButton = var_57_18

	local var_57_19 = arg_57_0

	findTF = var_4

	local var_57_20 = var_4(arg_57_0.menuUI, "rightPanelBg/arrowUp")

	local function var_57_21()
		local var_64_0 = arg_57_0.battleScrollRect.normalizedPosition.y + 1 / (arg_57_0.totalTimes - 4)

		if 1 < var_64_0 then
			var_64_0 = 1
		end

		scrollTo = var_1

		var_1(arg_57_0.battleScrollRect, 0, var_64_0)

		return
	end

	SFX_CANCEL = var_6

	var_57_18(var_57_19, var_57_20, var_57_21, var_6)

	onButton = var_57_18

	local var_57_22 = arg_57_0

	findTF = var_57_20

	local var_57_23 = var_57_20(arg_57_0.menuUI, "rightPanelBg/arrowDown")

	local function var_57_24()
		local var_65_0

		if arg_57_0.battleScrollRect.normalizedPosition.y - 1 / (arg_57_0.totalTimes - 4) < 0 then
			var_65_0 = 0
		end

		scrollTo = var_1

		var_1(arg_57_0.battleScrollRect, 0, var_65_0)

		return
	end

	SFX_CANCEL = var_6

	var_57_18(var_57_22, var_57_23, var_57_24, var_6)

	onButton = var_57_18

	local var_57_25 = arg_57_0

	findTF = var_57_23

	local var_57_26 = var_57_23(arg_57_0.menuUI, "btnBack")

	local function var_57_27()
		local var_66_0 = arg_57_0

		var_0.closeView(var_66_0)

		return
	end

	SFX_CANCEL = var_6

	var_57_18(var_57_25, var_57_26, var_57_27, var_6)

	onButton = var_57_18

	local var_57_28 = arg_57_0

	findTF = var_57_26

	local var_57_29 = var_57_26(arg_57_0.menuUI, "btnRule")

	local function var_57_30()
		pg = var_2_10000

		local var_67_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_67_1 = var_0.ShowMsgBox
		local var_67_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_67_2.type = var_2_10003
		pg = var_2_10003
		var_67_2.helps = var_2_10003.gametip.five_duomaomao.tip

		var_67_1(var_67_0, var_67_2)

		return
	end

	SFX_CANCEL = var_6

	var_57_18(var_57_28, var_57_29, var_57_30, var_6)

	onButton = var_57_18

	local var_57_31 = arg_57_0

	findTF = var_57_29

	local var_57_32 = var_57_29(arg_57_0.menuUI, "btnStart")

	local function var_57_33()
		setActive = var_2_10000

		var_2_10000(arg_57_0.menuUI, false)

		local var_68_0 = arg_57_0

		var_0.readyStart(var_68_0)

		return
	end

	SFX_CANCEL = var_6

	var_57_18(var_57_31, var_57_32, var_57_33, var_6)

	findTF = var_57_18

	local var_57_34 = var_57_18(arg_57_0.menuUI, "tplBattleItem")

	arg_57_0.battleItems = {}

	for iter_57_0 = 1, 7 do
		tf = var_1_10007
		instantiate = var_1_10008
		var_1_10007 = var_1_10007(var_1_10008(var_57_34))
		var_1_10007.name = "battleItem_" .. iter_57_0
		setParent = var_1_10008

		local var_57_35 = var_1_10007

		findTF = var_1_10010

		var_1_10008(var_57_35, var_1_10010(arg_57_0.menuUI, "battList/Viewport/Content"))

		var_1_10008 = iter_57_0
		GetSpriteFromAtlasAsync = var_57_35

		var_57_35("ui/minigameui/" .. var_0_5, "battleDesc" .. var_1_10008, function(arg_69_0)
			setImageSprite = var_2_10001
			findTF = var_2_10002

			var_2_10001(var_2_10002(var_1_10007, "state_open/buttomDesc"), arg_69_0, true)

			setImageSprite = var_2_10001
			findTF = var_2

			var_2_10001(var_2(var_1_10007, "state_clear/buttomDesc"), arg_69_0, true)

			setImageSprite = var_2_10001
			findTF = var_2

			var_2_10001(var_2(var_1_10007, "state_current/buttomDesc"), arg_69_0, true)

			setImageSprite = var_2_10001
			findTF = var_2

			var_2_10001(var_2(var_1_10007, "state_closed/buttomDesc"), arg_69_0, true)

			return
		end)

		setActive = var_57_35

		var_57_35(var_1_10007, true)

		table = var_57_35

		var_57_35.insert(arg_57_0.battleItems, var_1_10007)
	end

	if not arg_57_0.handle then
		IsUnityEditor = var_3

		if var_3 then
			UpdateBeat = var_3
			arg_57_0.handle = var_3:CreateListener(arg_57_0.Update, arg_57_0)
			UpdateBeat = var_3

			var_3:AddListener(arg_57_0.handle)
		end
	end

	return
end

function var_0_1.initGameUI(arg_70_0)
	findTF = var_1_10001
	arg_70_0.gameUI = var_1_10001(arg_70_0._tf, "ui/gameUI")
	findTF = var_1
	arg_70_0.showScoreTpl = var_1(arg_70_0.sceneFrontContainer, "score")
	setActive = var_1

	var_1(arg_70_0.showScoreTpl, false)

	onButton = var_1

	local var_70_0 = arg_70_0

	findTF = var_3

	var_1(var_70_0, var_3(arg_70_0.gameUI, "topRight/btnStop"), function()
		local var_71_0 = arg_70_0

		var_0.stopGame(var_71_0)

		setActive = var_0

		var_0(arg_70_0.pauseUI, true)

		return
	end)

	onButton = var_1

	local var_70_1 = arg_70_0

	findTF = var_3

	var_1(var_70_1, var_3(arg_70_0.gameUI, "btnLeave"), function()
		local var_72_0 = arg_70_0

		var_0.stopGame(var_72_0)

		setActive = var_0

		var_0(arg_70_0.leaveUI, true)

		return
	end)

	findTF = var_1
	arg_70_0.gameTimeS = var_1(arg_70_0.gameUI, "top/time/s")
	findTF = var_1
	arg_70_0.scoreTf = var_1(arg_70_0.gameUI, "top/score")

	local var_70_2 = arg_70_0.sceneContainer

	Vector2 = var_2
	var_70_2.anchoredPosition = var_2(0, 0)
	GetOrAddComponent = var_70_2

	local var_70_3 = arg_70_0.sceneContainer

	typeof = var_3
	EventTriggerListener = var_4

	local var_70_4 = var_70_2(var_70_3, var_3(var_4))
	local var_70_5
	local var_70_6

	Vector2 = var_4
	arg_70_0.velocityXSmoothing = var_4(0, 0)
	arg_70_0.offsetPosition = arg_70_0.sceneContainer.anchoredPosition

	var_70_4:AddBeginDragFunc(function(arg_73_0, arg_73_1)
		var_70_5 = arg_73_1.position
		var_70_6 = arg_70_0.sceneContainer.anchoredPosition

		local var_73_0 = arg_70_0

		Vector2 = var_2_10003
		var_73_0.velocityXSmoothing = var_2_10003(0, 0)
		arg_70_0.offsetPosition = arg_70_0.sceneContainer.anchoredPosition

		return
	end)
	var_70_4:AddDragFunc(function(arg_74_0, arg_74_1)
		arg_70_0.offsetPosition.x = arg_74_1.position.x - var_70_5.x + var_70_6.x
		arg_70_0.offsetPosition.y = arg_74_1.position.y - var_70_5.y + var_70_6.y

		local var_74_0 = arg_70_0.offsetPosition
		local var_74_1

		if not (arg_70_0.offsetPosition.x > var_0_43[2]) or not var_0_43[2] then
			var_74_1 = arg_70_0.offsetPosition.x
		end

		var_74_0.x = var_74_1

		local var_74_2 = arg_70_0.offsetPosition
		local var_74_3

		if not (arg_70_0.offsetPosition.x < var_0_43[1]) or not var_0_43[1] then
			var_74_3 = arg_70_0.offsetPosition.x
		end

		var_74_2.x = var_74_3

		local var_74_4 = arg_70_0.offsetPosition
		local var_74_5

		if not (arg_70_0.offsetPosition.y > var_0_44[2]) or not var_0_44[2] then
			var_74_5 = arg_70_0.offsetPosition.y
		end

		var_74_4.y = var_74_5

		local var_74_6 = arg_70_0.offsetPosition
		local var_74_7

		if not (arg_70_0.offsetPosition.y < var_0_44[1]) or not var_0_44[1] then
			var_74_7 = arg_70_0.offsetPosition.y
		end

		var_74_6.y = var_74_7

		return
	end)
	var_70_4:AddDragEndFunc(function(arg_75_0, arg_75_1)
		return
	end)

	return
end

function var_0_1.initController(arg_76_0)
	local var_76_0 = var_0_48

	findTF = var_1_10002
	arg_76_0.furnitureCtrl = var_76_0(var_1_10002(arg_76_0.sceneContainer, "scene"), arg_76_0)

	local var_76_1 = var_0_53

	findTF = var_2
	arg_76_0.moveRoleCtrl = var_76_1(var_2(arg_76_0.sceneContainer, "scene"), arg_76_0)

	local var_76_2 = var_0_58

	findTF = var_2
	arg_76_0.tvCtrl = var_76_2(var_2(arg_76_0.sceneContainer, "scene/furniture_tv"), arg_76_0)

	return
end

function var_0_1.Update(arg_77_0)
	arg_77_0:AddDebugInput()

	return
end

function var_0_1.AddDebugInput(arg_78_0)
	if arg_78_0.gameStop or arg_78_0.settlementFlag then
		return
	end

	IsUnityEditor = var_1

	if var_1 then
		Input = var_1

		local var_78_0 = var_1.GetKeyDown

		KeyCode = var_1_10002

		if var_78_0(var_1_10002.S) then
			-- block empty
		end
	end

	return
end

function var_0_1.updateMenuUI(arg_79_0)
	local var_79_0 = arg_79_0:getGameUsedTimes()
	local var_79_1 = arg_79_0:getGameTimes()

	for iter_79_0 = 1, #arg_79_0.battleItems do
		setActive = var_1_10007
		findTF = var_1_10008

		var_1_10007(var_1_10008(arg_79_0.battleItems[iter_79_0], "state_open"), false)

		setActive = var_1_10007
		findTF = var_1_10008

		var_1_10007(var_1_10008(arg_79_0.battleItems[iter_79_0], "state_closed"), false)

		setActive = var_1_10007
		findTF = var_1_10008

		var_1_10007(var_1_10008(arg_79_0.battleItems[iter_79_0], "state_clear"), false)

		setActive = var_1_10007
		findTF = var_1_10008

		var_1_10007(var_1_10008(arg_79_0.battleItems[iter_79_0], "state_current"), false)

		if iter_79_0 <= var_79_0 then
			setActive = var_1_10007
			findTF = var_1_10008

			var_1_10007(var_1_10008(arg_79_0.battleItems[iter_79_0], "state_clear"), true)
		elseif iter_79_0 == var_79_0 + 1 and 1 <= var_79_1 then
			setActive = var_1_10007
			findTF = var_1_10008

			var_1_10007(var_1_10008(arg_79_0.battleItems[iter_79_0], "state_current"), true)
		elseif var_79_0 < iter_79_0 and iter_79_0 <= var_79_0 + var_79_1 then
			setActive = var_1_10007
			findTF = var_1_10008

			var_1_10007(var_1_10008(arg_79_0.battleItems[iter_79_0], "state_open"), true)
		else
			setActive = var_1_10007
			findTF = var_1_10008

			var_1_10007(var_1_10008(arg_79_0.battleItems[iter_79_0], "state_closed"), true)
		end
	end

	arg_79_0.totalTimes = arg_79_0:getGameTotalTime()

	local var_79_2 = 1 - (arg_79_0:getGameUsedTimes() - 3 < 0 and 0 or arg_79_0:getGameUsedTimes() - 3) / (arg_79_0.totalTimes - 4)

	if 1 < var_79_2 then
		var_79_2 = 1
	end

	scrollTo = var_5

	var_5(arg_79_0.battleScrollRect, 0, var_79_2)

	setActive = var_5
	findTF = var_6

	var_5(var_6(arg_79_0.menuUI, "btnStart/tip"), var_79_1 > 0)
	arg_79_0:CheckGet()

	return
end

function var_0_1.CheckGet(arg_80_0)
	setActive = var_1_10001
	findTF = var_1_10002

	var_1_10001(var_1_10002(arg_80_0.menuUI, "got"), false)

	if arg_80_0:getUltimate() then
		local var_80_0 = arg_80_0

		if arg_80_0.getUltimate(var_80_0) ~= 0 then
			setActive = var_1
			findTF = var_80_0

			var_1(var_80_0(arg_80_0.menuUI, "got"), true)
		end
	end

	if arg_80_0:getUltimate() == 0 then
		local var_80_1 = arg_80_0:getGameTotalTime()
		local var_80_2 = arg_80_0

		if var_80_1 > arg_80_0.getGameUsedTimes(var_80_2) then
			return
		end

		pg = var_80_2

		local var_80_3 = var_80_2.m02
		local var_80_4 = var_3.sendNotification

		GAME = var_1_10005

		local var_80_5 = var_1_10005.SEND_MINI_GAME_OP
		local var_80_6 = {
			hubid = arg_80_0:GetMGHubData().id
		}

		MiniGameOPCommand = var_7
		var_80_6.cmd = var_7.CMD_ULTIMATE
		var_80_6.args1 = {}

		var_80_4(var_80_3, var_80_5, var_80_6)

		setActive = var_80_4
		findTF = var_80_3

		var_80_4(var_80_3(arg_80_0.menuUI, "got"), true)
	end

	return
end

function var_0_1.openMenuUI(arg_81_0)
	setActive = var_1_10001
	findTF = var_1_10002

	var_1_10001(var_1_10002(arg_81_0.sceneContainer, "scene_front"), false)

	setActive = var_1_10001
	findTF = var_2

	var_1_10001(var_2(arg_81_0.sceneContainer, "scene_background"), false)

	setActive = var_1_10001
	findTF = var_2

	var_1_10001(var_2(arg_81_0.sceneContainer, "scene"), false)

	setActive = var_1_10001

	var_1_10001(arg_81_0.gameUI, false)

	setActive = var_1_10001

	var_1_10001(arg_81_0.menuUI, true)

	setActive = var_1_10001

	var_1_10001(arg_81_0.bg, true)
	arg_81_0:updateMenuUI()

	return
end

function var_0_1.clearUI(arg_82_0)
	setActive = var_1_10001

	var_1_10001(arg_82_0.sceneContainer, false)

	setActive = var_1_10001

	var_1_10001(arg_82_0.settlementUI, false)

	setActive = var_1_10001

	var_1_10001(arg_82_0.countUI, false)

	setActive = var_1_10001

	var_1_10001(arg_82_0.menuUI, false)

	setActive = var_1_10001

	var_1_10001(arg_82_0.gameUI, false)

	return
end

function var_0_1.readyStart(arg_83_0)
	setActive = var_1_10001

	var_1_10001(arg_83_0.countUI, true)

	local var_83_0 = arg_83_0.countAnimator

	var_1.Play(var_83_0, "count")

	pg = var_1

	local var_83_1 = var_1.CriMgr.GetInstance()

	var_1.PlaySoundEffect_V3(var_83_1, var_0_3)

	return
end

function var_0_1.gameStart(arg_84_0)
	setActive = var_1_10001
	findTF = var_1_10002

	var_1_10001(var_1_10002(arg_84_0.sceneContainer, "scene_front"), true)

	setActive = var_1_10001
	findTF = var_2

	var_1_10001(var_2(arg_84_0.sceneContainer, "scene_background"), true)

	setActive = var_1_10001
	findTF = var_2

	var_1_10001(var_2(arg_84_0.sceneContainer, "scene"), true)

	setActive = var_1_10001

	var_1_10001(arg_84_0.bg, false)

	arg_84_0.sceneContainer.anchoredPosition = var_0_45
	arg_84_0.offsetPosition = var_0_45
	setActive = var_1

	var_1(arg_84_0.gameUI, true)

	arg_84_0.gameStartFlag = true
	arg_84_0.scoreNum = 0
	arg_84_0.nextPositionIndex = 2
	arg_84_0.gameStepTime = 0
	arg_84_0.heart = 3
	arg_84_0.gameTime = var_0_6

	for iter_84_0 = #arg_84_0.showScores, 1, -1 do
		table = var_1_10005

		if not var_1_10005.contains(arg_84_0.showScoresPool, arg_84_0.showScores[iter_84_0]) then
			table = var_1_10005
			var_1_10005 = var_1_10005.remove(arg_84_0.showScores, iter_84_0)
			table = var_6

			var_6.insert(arg_84_0.showScoresPool, var_1_10005)
		end
	end

	for iter_84_1 = #arg_84_0.showScoresPool, 1, -1 do
		setActive = var_1_10005

		var_1_10005(arg_84_0.showScoresPool[iter_84_1], false)
	end

	arg_84_0:updateGameUI()
	arg_84_0:timerStart()
	arg_84_0:controllerStart()

	return
end

function var_0_1.controllerStart(arg_85_0)
	if arg_85_0.furnitureCtrl then
		local var_85_0 = arg_85_0.furnitureCtrl

		var_1.start(var_85_0)
	end

	if arg_85_0.moveRoleCtrl then
		local var_85_1 = arg_85_0.moveRoleCtrl

		var_1.start(var_85_1)
	end

	if arg_85_0.tvCtrl then
		local var_85_2 = arg_85_0.tvCtrl

		var_1.start(var_85_2)
	end

	return
end

function var_0_1.getGameTimes(arg_86_0)
	return arg_86_0:GetMGHubData().count
end

function var_0_1.getGameUsedTimes(arg_87_0)
	return arg_87_0:GetMGHubData().usedtime
end

function var_0_1.getUltimate(arg_88_0)
	return arg_88_0:GetMGHubData().ultimate
end

function var_0_1.getGameTotalTime(arg_89_0)
	local var_89_0 = arg_89_0:GetMGHubData()

	return (var_1.getConfig(var_89_0, "reward_need"))
end

function var_0_1.changeSpeed(arg_90_0, arg_90_1)
	return
end

function var_0_1.onTimer(arg_91_0)
	arg_91_0:gameStep()

	return
end

function var_0_1.gameStep(arg_92_0)
	local var_92_0 = arg_92_0.gameTime

	Time = var_1_10002
	arg_92_0.gameTime = var_92_0 - var_1_10002.deltaTime

	if arg_92_0.gameTime < 0 then
		arg_92_0.gameTime = 0
	end

	local var_92_1 = arg_92_0.gameStepTime

	Time = var_2
	arg_92_0.gameStepTime = var_92_1 + var_2.deltaTime

	arg_92_0:controllerStep()
	arg_92_0:updateGameUI()

	if arg_92_0.gameTime <= 0 then
		arg_92_0:onGameOver()

		return
	end

	return
end

function var_0_1.controllerStep(arg_93_0)
	if arg_93_0.furnitureCtrl then
		local var_93_0 = arg_93_0.furnitureCtrl

		var_1.step(var_93_0)
	end

	if arg_93_0.moveRoleCtrl then
		local var_93_1 = arg_93_0.moveRoleCtrl

		var_1.step(var_93_1)
	end

	if arg_93_0.tvCtrl then
		local var_93_2 = arg_93_0.tvCtrl

		var_1.step(var_93_2)
	end

	return
end

function var_0_1.timerStart(arg_94_0)
	if not arg_94_0.timer.running then
		local var_94_0 = arg_94_0.timer

		var_1.Start(var_94_0)
	end

	return
end

function var_0_1.timerStop(arg_95_0)
	if arg_95_0.timer.running then
		local var_95_0 = arg_95_0.timer

		var_1.Stop(var_95_0)

		if arg_95_0.tvCtrl then
			local var_95_1 = arg_95_0.tvCtrl

			var_1.pause(var_95_1)
		end
	end

	return
end

function var_0_1.updateGameUI(arg_96_0)
	setText = var_1_10001

	var_1_10001(arg_96_0.scoreTf, arg_96_0.scoreNum)

	setText = var_1_10001

	local var_96_0 = arg_96_0.gameTimeS

	math = var_3

	var_1_10001(var_96_0, var_3.ceil(arg_96_0.gameTime))

	local var_96_1 = arg_96_0.sceneContainer

	Vector2 = var_96_0
	var_96_1.anchoredPosition, arg_96_0.velocityXSmoothing = var_96_0.SmoothDamp(arg_96_0.sceneContainer.anchoredPosition, arg_96_0.offsetPosition, arg_96_0.velocityXSmoothing, var_0_42)

	return
end

function var_0_1.addScore(arg_97_0, arg_97_1)
	arg_97_0.scoreNum = arg_97_0.scoreNum + arg_97_1

	if arg_97_0.scoreNum < 0 then
		arg_97_0.scoreNum = 0
	end

	return
end

function var_0_1.onGameOver(arg_98_0)
	if arg_98_0.settlementFlag then
		return
	end

	arg_98_0:timerStop()

	arg_98_0.settlementFlag = true
	setActive = var_1

	var_1(arg_98_0.clickMask, true)

	LeanTween = var_1

	local var_98_0 = var_1.delayedCall

	go = var_2

	local var_98_1 = var_2(arg_98_0._tf)
	local var_98_2 = 0.1

	System = var_1_10004

	var_98_0(var_98_1, var_98_2, var_1_10004.Action(function()
		arg_98_0.settlementFlag = false

		local var_99_0 = arg_98_0

		var_99_0.gameStartFlag = false
		setActive = var_99_0

		var_99_0(arg_98_0.clickMask, false)

		local var_99_1 = arg_98_0

		var_0.showSettlement(var_99_1)

		return
	end))

	return
end

function var_0_1.showSettlement(arg_100_0)
	setActive = var_1_10001

	var_1_10001(arg_100_0.settlementUI, true)

	GetComponent = var_1_10001
	findTF = var_2

	local var_100_0 = var_2(arg_100_0.settlementUI, "ad")

	typeof = var_3
	Animator = var_4

	local var_100_1 = var_1_10001(var_100_0, var_3(var_4))

	var_1.Play(var_100_1, "settlement", -1, 0)

	local var_100_2 = arg_100_0:GetMGData()
	local var_100_3 = var_2.GetRuntimeData(var_100_2, "elements")
	local var_100_4 = arg_100_0.scoreNum

	if var_100_3 then
		local var_100_5 = #var_100_3
		local var_100_6

		if not (0 < var_100_5) or not var_100_3[1] then
			var_100_6 = 0
		end

		setActive = var_5
		findTF = var_6

		var_5(var_6(arg_100_0.settlementUI, "ad/new"), var_100_6 < var_100_4)

		if var_100_6 <= var_100_4 then
			var_100_6 = var_100_4

			arg_100_0:StoreDataToServer({
				var_100_6
			})
		end

		findTF = var_5

		local var_100_7 = var_5(arg_100_0.settlementUI, "ad/highText")

		findTF = var_6

		local var_100_8 = var_6(arg_100_0.settlementUI, "ad/currentText")

		setText = var_7

		var_7(var_100_7, var_100_6)

		setText = var_7

		var_7(var_100_8, var_100_4)

		if arg_100_0:getGameTimes() and arg_100_0:getGameTimes() > 0 then
			arg_100_0.sendSuccessFlag = true

			arg_100_0:SendSuccess(0)
		end

		return
	end
end

function var_0_1.resumeGame(arg_101_0)
	arg_101_0.gameStop = false
	setActive = var_1

	var_1(arg_101_0.leaveUI, false)
	arg_101_0:changeSpeed(1)
	arg_101_0:timerStart()

	return
end

function var_0_1.stopGame(arg_102_0)
	arg_102_0.gameStop = true

	arg_102_0:timerStop()
	arg_102_0:changeSpeed(0)

	return
end

function var_0_1.onBackPressed(arg_103_0)
	if not arg_103_0.gameStartFlag then
		arg_103_0:emit(var_0_1.ON_BACK_PRESSED)
	else
		if arg_103_0.settlementFlag then
			return
		end

		isActive = var_1

		if var_1(arg_103_0.pauseUI) then
			setActive = var_1

			var_1(arg_103_0.pauseUI, false)
		end

		arg_103_0:stopGame()

		setActive = var_1

		var_1(arg_103_0.leaveUI, true)
	end

	return
end

function var_0_1.willExit(arg_104_0)
	if arg_104_0.handle then
		UpdateBeat = var_1
		var_1_10002 = var_1

		var_1.RemoveListener(var_1_10002, arg_104_0.handle)
	end

	if arg_104_0._tf then
		LeanTween = var_1

		local var_104_0 = var_1.isTweening

		go = var_1_10002

		if var_104_0(var_1_10002(arg_104_0._tf)) then
			LeanTween = var_1

			local var_104_1 = var_1.cancel

			go = var_2

			var_104_1(var_2(arg_104_0._tf))
		end
	end

	arg_104_0:destroyController()

	if arg_104_0.timer and arg_104_0.timer.running then
		local var_104_2 = arg_104_0.timer

		var_1.Stop(var_104_2)
	end

	Time = var_1
	var_1.timeScale = 1
	arg_104_0.timer = nil

	return
end

function var_0_1.destroyController(arg_105_0)
	if arg_105_0.furnitureCtrl then
		local var_105_0 = arg_105_0.furnitureCtrl

		var_1.destroy(var_105_0)
	end

	if arg_105_0.moveRoleCtrl then
		local var_105_1 = arg_105_0.moveRoleCtrl

		var_1.destroy(var_105_1)
	end

	if arg_105_0.tvCtrl then
		local var_105_2 = arg_105_0.tvCtrl

		var_1.destroy(var_105_2)
	end

	return
end

return var_0_1
