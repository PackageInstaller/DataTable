local var_0_0 = class("GameRoomHideSeekView", import("..BaseMiniGameView"))
local var_0_1 = "bar-soft"
local var_0_2 = "event:/ui/ddldaoshu2"
local var_0_3 = "event:/ui/break_out_full"
local var_0_4 = "hideseekgameui_atlas"
local var_0_5 = 60
local var_0_6 = {
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
local var_0_7 = 100
local var_0_8 = 2
local var_0_9 = 50
local var_0_10 = 400
local var_0_11 = 400
local var_0_12 = "on_touch_furniture"
local var_0_13 = 1
local var_0_14 = 2
local var_0_15 = 3
local var_0_17 = "hideseekui"
local var_0_18 = 3
local var_0_19 = {
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
local var_0_20 = {}

;({
	pos_name = "posBath"
}).anim_name = "HideSeekBath"
;({})[1] = {
	pos_name = "posBath"
}
;({
	name = "furniture_bath"
}).pos_data_list = {}
;({
	name = "furniture_bath"
}).type = 1
;({})[1] = {
	name = "furniture_bath"
}
;({})[2] = {
	name = "furniture_bed",
	weight = 0.2,
	pos_data_list = {
		{
			pos_name = "posBed",
			anim_name = "HideSeekBed"
		}
	},
	type = 2
}
;({})[3] = {
	defaut_char_index = 9,
	name = "furniture_Fridge",
	time = 3,
	defaut_trigger = true,
	weight = 0.15,
	pos_data_list = {
		{
			pos_name = "posFridge",
			anim_name = "HideSeekFridge"
		}
	},
	type = 3
}
;({})[4] = {
	hide = true,
	name = "furniture_Hako_L1",
	time = 4,
	pos_data_list = {
		{
			pos_name = "posHakoCL",
			anim_name = "HideSeekHakoCL"
		}
	},
	type = 1
}
;({})[5] = {
	hide = true,
	name = "furniture_Cook",
	time = 4,
	pos_data_list = {
		{
			pos_name = "posUpR",
			anim_name = "HideSeekUpR"
		}
	},
	type = 1
}
;({})[6] = {
	hide = true,
	name = "furniture_Desk_Dining",
	time = 4,
	pos_data_list = {
		{
			pos_name = "posUnder",
			anim_name = "HideSeekDeskUnder"
		},
		{
			pos_name = "posUpR",
			anim_name = "HideSeekUpR"
		},
		{
			pos_name = "posUpL",
			anim_name = "HideSeekUpL"
		}
	},
	type = 1
}
;({})[7] = {
	hide = true,
	name = "furniture_Sofa_S",
	time = 4,
	pos_data_list = {
		{
			pos_name = "posSofaS",
			anim_name = "HideSeekSofaS"
		}
	},
	type = 1
}
;({})[8] = {
	hide = true,
	name = "furniture_Sofa_L",
	time = 4,
	pos_data_list = {
		{
			pos_name = "posSofaL",
			anim_name = "HideSeekSofaL"
		},
		{
			pos_name = "posUpL",
			anim_name = "HideSeekUpL"
		}
	},
	type = 1
}
;({})[9] = {
	hide = true,
	name = "furniture_Hako_S1_3",
	time = 4,
	pos_data_list = {
		{
			pos_name = "posHakoSL",
			anim_name = "HideSeekHakoSL"
		}
	},
	type = 1
}
;({})[10] = {
	hide = true,
	name = "furniture_Desk_S",
	time = 4,
	pos_data_list = {
		{
			pos_name = "posDeskSL",
			anim_name = "HideSeekDeskSL"
		},
		{
			pos_name = "posDeskSR",
			anim_name = "HideSeekDeskSR"
		},
		{
			pos_name = "posDeskUnder",
			anim_name = "HideSeekDeskUnder"
		}
	},
	type = 1
}
;({})[11] = {
	hide = true,
	name = "furniture_Hako_L2",
	time = 4,
	pos_data_list = {
		{
			pos_name = "posHakoCL",
			anim_name = "HideSeekHakoCL"
		},
		{
			pos_name = "posHakoCR",
			anim_name = "HideSeekHakoCR"
		}
	},
	type = 1
}
;({})[12] = {
	hide = true,
	name = "furniture_Desk_Study",
	time = 4,
	pos_data_list = {
		{
			pos_name = "posDeskStudyL",
			anim_name = "HideSeekDeskStudyL"
		},
		{
			pos_name = "posDeskStudyR",
			anim_name = "HideSeekDeskStudyR"
		}
	},
	type = 1
}
;({})[13] = {
	hide = true,
	name = "furniture_Hako_M1",
	time = 4,
	pos_data_list = {
		{
			pos_name = "posHakoML",
			anim_name = "HideSeekHakoML"
		}
	},
	type = 1
}
;({})[14] = {
	hide = true,
	name = "furniture_Hako_M2",
	time = 4,
	pos_data_list = {
		{
			pos_name = "posHakoMR",
			anim_name = "HideSeekHakoMR"
		}
	},
	type = 1
}
;({})[15] = {
	hide = true,
	name = "furniture_Hako_S2",
	time = 4,
	pos_data_list = {
		{
			pos_name = "posHakoSR",
			anim_name = "HideSeekHakoSR"
		}
	},
	type = 1
}
;({})[16] = {
	name = "furniture_Manjuu_cushion",
	pos_data_list = {
		{
			pos_name = "posCushion",
			anim_name = "HideSeekCushion"
		}
	},
	type = 1,
	hide_tfs = {
		"img"
	}
}

local var_0_21 = {
	HideSeekBath = {
		prefab = "hideseekbath",
		name = "HideSeekBath",
		ignore_char = {}
	},
	HideSeekBed = {
		prefab = "hideseekbed",
		name = "HideSeekBed",
		ignore_char = {}
	},
	HideSeekFridge = {
		prefab = "hideseekfridge",
		name = "HideSeekFridge",
		ignore_char = {}
	},
	HideSeekHakoCL = {
		prefab = "hideseekhakocl",
		name = "HideSeekHakoCL",
		ignore_char = {}
	},
	HideSeekHakoCR = {
		prefab = "hideseekhakocr",
		name = "HideSeekHakoCR",
		ignore_char = {}
	},
	HideSeekUpR = {
		prefab = "hideseekupr",
		name = "HideSeekUpR",
		ignore_char = {}
	},
	HideSeekUpL = {
		prefab = "hideseekupl",
		name = "HideSeekUpL",
		ignore_char = {}
	},
	HideSeekDeskUnder = {
		prefab = "hideseekdeskunder",
		name = "HideSeekDeskUnder",
		ignore_char = {}
	},
	HideSeekSofaS = {
		prefab = "hideseeksofas",
		name = "HideSeekSofaS",
		ignore_char = {}
	},
	HideSeekSofaL = {
		prefab = "hideseeksofal",
		name = "HideSeekSofaL",
		ignore_char = {}
	},
	HideSeekHakoSL = {
		prefab = "hideseekhakosl",
		name = "HideSeekHakoSL",
		ignore_char = {}
	},
	HideSeekHakoSR = {
		prefab = "hideseekhakosr",
		name = "HideSeekHakoSR",
		ignore_char = {}
	},
	HideSeekDeskSL = {
		prefab = "hideseekdesksl",
		name = "HideSeekDeskSL",
		ignore_char = {}
	},
	HideSeekDeskSR = {
		prefab = "hideseekdesksr",
		name = "HideSeekDeskSR",
		ignore_char = {}
	},
	HideSeekDeskStudyL = {
		prefab = "hideseekdeskstudyl",
		name = "HideSeekDeskStudyL",
		ignore_char = {}
	},
	HideSeekDeskStudyR = {
		prefab = "hideseekdeskstudyr",
		name = "HideSeekDeskStudyR",
		ignore_char = {}
	},
	HideSeekHakoML = {
		prefab = "hideseekhakoml",
		name = "HideSeekHakoML",
		ignore_char = {}
	},
	HideSeekHakoMR = {
		prefab = "hideseekhakomr",
		name = "HideSeekHakoMR",
		ignore_char = {}
	},
	HideSeekCushion = {
		prefab = "hideseekcushion",
		name = "HideSeekCushion",
		ignore_char = {}
	}
}
local var_0_22 = 0.1
local var_0_23 = {
	-475,
	652
}
local var_0_24 = {
	-335,
	290
}
local var_0_25 = Vector2(150, -200)
local var_0_26 = "hideseektv"
local var_0_27 = {}

local function var_0_28(arg_1_0, arg_1_1)
	({
		ctor = function(arg_2_0)
			arg_2_0._event = arg_1_1
			arg_2_0._sceneTf = arg_1_0
			arg_2_0._tplContainer = findTF(arg_1_0, "tplPos")
			var_0_27 = Clone(var_0_19)
			arg_2_0._furnituresPools = {}

			for iter_2_0 = 1, #var_0_20 do
				table.insert(arg_2_0._furnituresPools, {
					activeIndex = 0,
					data = Clone(var_0_20[iter_2_0]),
					tf = findTF(arg_2_0._sceneTf, var_0_20[iter_2_0].name)
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
			arg_3_0.additiveScore = var_0_7

			for iter_3_0 = #arg_3_0._furnituresPools, 1, -1 do
				if arg_3_0._furnituresPools[iter_3_0].data.type == var_0_14 then
					if math.random() <= arg_3_0._furnituresPools[iter_3_0].data.weight then
						arg_3_0:appearChar(arg_3_0._furnituresPools[iter_3_0].data.name)
					end

					arg_3_0._furnituresPools[iter_3_0].initFlag = true

					table.insert(arg_3_0._unActiveFurnitures, arg_3_0:getFunitureFromPool(arg_3_0._furnituresPools[iter_3_0].data.name))
				elseif arg_3_0._furnituresPools[iter_3_0].data.type == var_0_15 then
					arg_3_0:appearChar(arg_3_0._furnituresPools[iter_3_0].data.name)
				end
			end

			return
		end,
		step = function(arg_4_0)
			arg_4_0.timeStep = arg_4_0.timeStep + Time.deltaTime

			local var_4_0 = false

			if arg_4_0.timeAppear <= 0 then
				var_4_0 = true
				arg_4_0.timeAppear = nil

				for iter_4_0 = 1, #var_0_6 do
					if not arg_4_0.timeAppear and var_0_5 - arg_4_0.timeStep < var_0_6[iter_4_0][1] or iter_4_0 == #var_0_6 then
						arg_4_0.timeAppear = math.random() * (var_0_6[iter_4_0][3] - var_0_6[iter_4_0][2]) + var_0_6[iter_4_0][2]

						break
					end
				end

				arg_4_0.timeAppear = not arg_4_0.timeAppear and 2 or arg_4_0.timeAppear
			else
				arg_4_0.timeAppear = arg_4_0.timeAppear - Time.deltaTime
			end

			for iter_4_1 = #arg_4_0._activeFurnitures, 1, -1 do
				if arg_4_0._activeFurnitures[iter_4_1].time then
					arg_4_0._activeFurnitures[iter_4_1].time = arg_4_0._activeFurnitures[iter_4_1].time - Time.deltaTime

					if arg_4_0._activeFurnitures[iter_4_1].time <= 0 then
						arg_4_0:setFurnitureTimeEvent(arg_4_0._activeFurnitures[iter_4_1])
					end
				end
			end

			if var_4_0 then
				arg_4_0:appearChar()
			end

			return
		end,
		setFurnitureTimeEvent = function(arg_5_0, arg_5_1)
			if arg_5_1.data.type == var_0_15 then
				arg_5_0:returnCharIndex(arg_5_1.charIndex)

				arg_5_1.charIndex = math.random() <= arg_5_1.data.weight and #var_0_27 > 0 and table.remove(var_0_27, math.random(1, #var_0_27)) or arg_5_1.data.defaut_char_index
				arg_5_1.readyToRemove = false
				arg_5_1.time = arg_5_1.data.time

				GetComponent(findTF(arg_5_1.animTf, "anim"), typeof(Animator)):SetInteger("charIndex", arg_5_1.charIndex)
			elseif arg_5_1.data.type == var_0_13 then
				if arg_5_1.data.hide and not arg_5_1.readyToRemove then
					arg_5_1.time = 2
					arg_5_1.readyToRemove = true

					GetComponent(findTF(arg_5_1.animTf, "anim"), typeof(Animator)):SetTrigger("hide")
				else
					arg_5_0:returnFurniture(arg_5_1)
				end
			elseif arg_5_1.data.type == var_0_14 then
				if arg_5_1.charIndex then
					arg_5_0:returnCharIndex(arg_5_1.charIndex)

					if arg_5_1.animTf then
						setActive(findTF(arg_5_1.animTf, "collider"), false)
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
			if not table.contains(var_0_27, arg_6_1) and table.contains(var_0_19, arg_6_1) then
				table.insert(var_0_27, arg_6_1)
			end

			return
		end,
		appearChar = function(arg_7_0, arg_7_1)
			if #var_0_27 <= 0 then
				return
			end

			if #arg_7_0._furnituresPools <= 0 then
				return
			end

			local var_7_0

			if arg_7_1 then
				var_7_0 = arg_7_0:getFunitureFromPool(arg_7_1)
			end

			var_7_0 = var_7_0 or table.remove(arg_7_0._furnituresPools, math.random(1, #arg_7_0._furnituresPools))

			local var_7_1 = var_7_0.data.pos_data_list[math.random(1, #var_7_0.data.pos_data_list)]
			local var_7_2 = var_7_1.pos_name
			local var_7_3 = var_7_1.anim_name
			local var_7_4 = arg_7_0:getActiveIndex()
			local var_7_5 = var_0_21[var_7_1.anim_name]

			if not var_0_21[var_7_1.anim_name] then
				print("警告，没有找到" .. var_7_1.anim_name .. "的动画数据")
				arg_7_0:returnFurniture(var_7_0)

				return
			end

			local var_7_6 = var_7_0.data.type == var_0_15 and var_7_0.data.defaut_char_index or table.remove(var_0_27, math.random(1, #var_0_27))

			var_7_0.charIndex = var_7_6

			if table.contains(var_7_5.ignore_char, var_7_6) then
				arg_7_0:returnFurniture(var_7_0)

				return
			elseif var_7_0.data.type == var_0_14 and var_7_0.initFlag then
				arg_7_0:returnFurniture(var_7_0)

				return
			end

			var_7_0.posData = var_7_1
			var_7_0.activeIndex = var_7_4
			var_7_0.animData = var_7_5

			table.insert(arg_7_0._activeFurnitures, var_7_0)
			arg_7_0:getAnimTfByPosData(var_7_1, var_7_4, function(arg_8_0, arg_8_1)
				if arg_8_1 ~= var_7_0.activeIndex then
					arg_7_0:returnAnimTf(var_7_3, arg_8_0)

					return
				end

				if var_7_0.data.hide_tfs then
					for iter_8_0 = 1, #var_7_0.data.hide_tfs do
						setActive(findTF(var_7_0.tf, var_7_0.data.hide_tfs[iter_8_0]), false)
					end
				end

				SetParent(arg_8_0, (findTF(var_7_0.tf, var_7_2)))
				setActive(arg_8_0, true)
				setActive(findTF(arg_8_0, "collider"), true)

				arg_8_0.anchoredPosition = Vector2(0, 0)
				var_7_0.animTf = arg_8_0

				arg_7_0:prepareAnim(var_7_0)

				return
			end)

			return
		end,
		getFunitureFromPool = function(arg_9_0, arg_9_1)
			for iter_9_0 = 1, #arg_9_0._furnituresPools do
				if arg_9_0._furnituresPools[iter_9_0].data.name == arg_9_1 then
					return table.remove(arg_9_0._furnituresPools, iter_9_0)
				end
			end

			return nil
		end,
		prepareAnim = function(arg_10_0, arg_10_1)
			if not arg_10_1.animData or not arg_10_1.animTf then
				return
			end

			arg_10_1.time = arg_10_1.data.time

			local var_10_1 = GetComponent(findTF(arg_10_1.animTf, "anim"), typeof(Animator))

			var_10_1:SetInteger("charIndex", arg_10_1.charIndex)

			if arg_10_1.data.type ~= var_0_15 then
				var_10_1:SetTrigger("trigger")
			end

			GetOrAddComponent(findTF(arg_10_1.animTf, "collider"), typeof(EventTriggerListener)):AddPointDownFunc(function(arg_11_0, arg_11_1, arg_11_2)
				if arg_10_1.readyToRemove then
					return
				end

				if arg_10_1.data.type == var_0_15 and arg_10_1.data.defaut_char_index == arg_10_1.charIndex and not arg_10_1.data.defaut_trigger then
					return
				end

				local var_11_0 = false

				if arg_10_1.data.type == var_0_15 and arg_10_1.data.defaut_char_index == arg_10_1.charIndex then
					var_11_0 = true
				end

				if not var_11_0 then
					pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_3)
					arg_10_0._event:emit(var_0_12, {
						score = arg_10_0:getScore(),
						pos = arg_11_1.position
					})
				end

				arg_10_1.readyToRemove = true

				var_10_1:SetTrigger("next")

				arg_10_1.time = arg_10_1.data.time or 3

				return
			end)

			return
		end,
		getScore = function(arg_12_0)
			arg_12_0.additiveScore = arg_12_0.additiveScore or var_0_7
			arg_12_0.additiveScore = arg_12_0.scoreTime and arg_12_0.timeStep - arg_12_0.scoreTime < var_0_8 and arg_12_0.additiveScore + var_0_9 or var_0_7

			if arg_12_0.additiveScore >= var_0_10 then
				arg_12_0.additiveScore = var_0_10
			end

			arg_12_0.scoreTime = arg_12_0.timeStep

			return arg_12_0.additiveScore
		end,
		getAnimTfByPosData = function(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
			if arg_13_0._furnitureAnimTfPool and arg_13_0._furnitureAnimTfPool[arg_13_1.anim_name] and #arg_13_0._furnitureAnimTfPool[arg_13_1.anim_name] > 0 then
				arg_13_3(table.remove(arg_13_0._furnitureAnimTfPool[arg_13_1.anim_name], 1), arg_13_2)

				return
			end

			return arg_13_0:createAnimTf(arg_13_1.anim_name, arg_13_2, arg_13_3)
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
				arg_14_0:returnAnimTf(arg_14_1.animData.name, arg_14_1.animTf)
			end

			if arg_14_1.data.hide_tfs then
				for iter_14_0 = 1, #arg_14_1.data.hide_tfs do
					setActive(findTF(arg_14_1.tf, arg_14_1.data.hide_tfs[iter_14_0]), true)
				end
			end

			arg_14_1.animTf = nil
			arg_14_1.animData = nil
			arg_14_1.activeIndex = nil
			arg_14_1.readyToRemove = false
			arg_14_1.time = nil

			for iter_14_1 = #arg_14_0._activeFurnitures, 1, -1 do
				if arg_14_0._activeFurnitures[iter_14_1] == arg_14_1 then
					table.insert(arg_14_0._furnituresPools, table.remove(arg_14_0._activeFurnitures, iter_14_1))
				end
			end

			for iter_14_2 = #arg_14_0._unActiveFurnitures, 1, -1 do
				if arg_14_0._unActiveFurnitures[iter_14_2] == arg_14_1 then
					table.insert(arg_14_0._furnituresPools, table.remove(arg_14_0._unActiveFurnitures, iter_14_2))
				end
			end

			local var_14_0 = false

			for iter_14_3 = 1, #arg_14_0._furnituresPools do
				if arg_14_0._furnituresPools[iter_14_3] == arg_14_1 then
					var_14_0 = true
				end
			end

			if not var_14_0 then
				table.insert(arg_14_0._furnituresPools, arg_14_1)
			end

			return
		end,
		returnAnimTf = function(arg_15_0, arg_15_1, arg_15_2)
			arg_15_0._furnitureAnimTfPool[arg_15_1] = arg_15_0._furnitureAnimTfPool[arg_15_1] or {}

			setActive(arg_15_2, false)
			table.insert(arg_15_0._furnitureAnimTfPool[arg_15_1], arg_15_2)

			return
		end,
		createAnimTf = function(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
			if not var_0_21[arg_16_1] then
				return nil
			end

			local var_16_0 = var_0_21[arg_16_1].prefab
			local var_16_1 = var_0_21[arg_16_1].name

			if arg_16_0._animTplDic[var_0_21[arg_16_1].name] then
				arg_16_3(tf(Instantiate(arg_16_0._animTplDic[var_0_21[arg_16_1].name])), arg_16_2)
			else
				LoadAndInstantiateAsync(var_0_17, var_16_0, function(arg_17_0)
					if not arg_17_0 then
						print("找不到资源" .. var_16_1)

						return
					end

					if arg_16_0.destroyFlag then
						Destroy(arg_17_0)

						return
					end

					arg_16_0._animTplDic[var_16_1] = arg_17_0

					SetParent(tf(arg_17_0), arg_16_0._tplContainer)
					arg_16_3(tf(Instantiate(arg_16_0._animTplDic[var_16_1])), arg_16_2)

					return
				end)
			end

			return
		end,
		getActiveIndex = function(arg_18_0)
			arg_18_0._activeIndex = arg_18_0._activeIndex or 0
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
				if arg_19_0._furnituresPools[iter_19_2].data.type == var_0_14 then
					arg_19_0._furnituresPools[iter_19_2].initFlag = false
				end
			end

			arg_19_0._activeFurnitures = {}
			var_0_27 = Clone(var_0_19)

			return
		end,
		destroy = function(arg_20_0)
			arg_20_0:clear()

			for iter_20_0 = 1, #arg_20_0._furnitureAnimTfPool do
				if arg_20_0._furnitureAnimTfPool[iter_20_0].animTf then
					ClearEventTrigger((GetOrAddComponent(findTF(arg_20_0._furnitureAnimTfPool[iter_20_0].animTf, "collider"), typeof(EventTriggerListener))))
				end
			end

			arg_20_0.destroyFlag = true

			return
		end
	}).ctor({
		ctor = function(arg_2_0)
			arg_2_0._event = arg_1_1
			arg_2_0._sceneTf = arg_1_0
			arg_2_0._tplContainer = findTF(arg_1_0, "tplPos")
			var_0_27 = Clone(var_0_19)
			arg_2_0._furnituresPools = {}

			for iter_2_0 = 1, #var_0_20 do
				table.insert(arg_2_0._furnituresPools, {
					activeIndex = 0,
					data = Clone(var_0_20[iter_2_0]),
					tf = findTF(arg_2_0._sceneTf, var_0_20[iter_2_0].name)
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
			arg_3_0.additiveScore = var_0_7

			for iter_3_0 = #arg_3_0._furnituresPools, 1, -1 do
				if arg_3_0._furnituresPools[iter_3_0].data.type == var_0_14 then
					if math.random() <= arg_3_0._furnituresPools[iter_3_0].data.weight then
						arg_3_0:appearChar(arg_3_0._furnituresPools[iter_3_0].data.name)
					end

					arg_3_0._furnituresPools[iter_3_0].initFlag = true

					table.insert(arg_3_0._unActiveFurnitures, arg_3_0:getFunitureFromPool(arg_3_0._furnituresPools[iter_3_0].data.name))
				elseif arg_3_0._furnituresPools[iter_3_0].data.type == var_0_15 then
					arg_3_0:appearChar(arg_3_0._furnituresPools[iter_3_0].data.name)
				end
			end

			return
		end,
		step = function(arg_4_0)
			arg_4_0.timeStep = arg_4_0.timeStep + Time.deltaTime

			local var_4_0 = false

			if arg_4_0.timeAppear <= 0 then
				var_4_0 = true
				arg_4_0.timeAppear = nil

				for iter_4_0 = 1, #var_0_6 do
					if not arg_4_0.timeAppear and var_0_5 - arg_4_0.timeStep < var_0_6[iter_4_0][1] or iter_4_0 == #var_0_6 then
						arg_4_0.timeAppear = math.random() * (var_0_6[iter_4_0][3] - var_0_6[iter_4_0][2]) + var_0_6[iter_4_0][2]

						break
					end
				end

				arg_4_0.timeAppear = not arg_4_0.timeAppear and 2 or arg_4_0.timeAppear
			else
				arg_4_0.timeAppear = arg_4_0.timeAppear - Time.deltaTime
			end

			for iter_4_1 = #arg_4_0._activeFurnitures, 1, -1 do
				if arg_4_0._activeFurnitures[iter_4_1].time then
					arg_4_0._activeFurnitures[iter_4_1].time = arg_4_0._activeFurnitures[iter_4_1].time - Time.deltaTime

					if arg_4_0._activeFurnitures[iter_4_1].time <= 0 then
						arg_4_0:setFurnitureTimeEvent(arg_4_0._activeFurnitures[iter_4_1])
					end
				end
			end

			if var_4_0 then
				arg_4_0:appearChar()
			end

			return
		end,
		setFurnitureTimeEvent = function(arg_5_0, arg_5_1)
			if arg_5_1.data.type == var_0_15 then
				arg_5_0:returnCharIndex(arg_5_1.charIndex)

				arg_5_1.charIndex = math.random() <= arg_5_1.data.weight and #var_0_27 > 0 and table.remove(var_0_27, math.random(1, #var_0_27)) or arg_5_1.data.defaut_char_index
				arg_5_1.readyToRemove = false
				arg_5_1.time = arg_5_1.data.time

				GetComponent(findTF(arg_5_1.animTf, "anim"), typeof(Animator)):SetInteger("charIndex", arg_5_1.charIndex)
			elseif arg_5_1.data.type == var_0_13 then
				if arg_5_1.data.hide and not arg_5_1.readyToRemove then
					arg_5_1.time = 2
					arg_5_1.readyToRemove = true

					GetComponent(findTF(arg_5_1.animTf, "anim"), typeof(Animator)):SetTrigger("hide")
				else
					arg_5_0:returnFurniture(arg_5_1)
				end
			elseif arg_5_1.data.type == var_0_14 then
				if arg_5_1.charIndex then
					arg_5_0:returnCharIndex(arg_5_1.charIndex)

					if arg_5_1.animTf then
						setActive(findTF(arg_5_1.animTf, "collider"), false)
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
			if not table.contains(var_0_27, arg_6_1) and table.contains(var_0_19, arg_6_1) then
				table.insert(var_0_27, arg_6_1)
			end

			return
		end,
		appearChar = function(arg_7_0, arg_7_1)
			if #var_0_27 <= 0 then
				return
			end

			if #arg_7_0._furnituresPools <= 0 then
				return
			end

			local var_7_0

			if arg_7_1 then
				var_7_0 = arg_7_0:getFunitureFromPool(arg_7_1)
			end

			var_7_0 = var_7_0 or table.remove(arg_7_0._furnituresPools, math.random(1, #arg_7_0._furnituresPools))

			local var_7_1 = var_7_0.data.pos_data_list[math.random(1, #var_7_0.data.pos_data_list)]
			local var_7_2 = var_7_1.pos_name
			local var_7_3 = var_7_1.anim_name
			local var_7_4 = arg_7_0:getActiveIndex()
			local var_7_5 = var_0_21[var_7_1.anim_name]

			if not var_0_21[var_7_1.anim_name] then
				print("警告，没有找到" .. var_7_1.anim_name .. "的动画数据")
				arg_7_0:returnFurniture(var_7_0)

				return
			end

			local var_7_6 = var_7_0.data.type == var_0_15 and var_7_0.data.defaut_char_index or table.remove(var_0_27, math.random(1, #var_0_27))

			var_7_0.charIndex = var_7_6

			if table.contains(var_7_5.ignore_char, var_7_6) then
				arg_7_0:returnFurniture(var_7_0)

				return
			elseif var_7_0.data.type == var_0_14 and var_7_0.initFlag then
				arg_7_0:returnFurniture(var_7_0)

				return
			end

			var_7_0.posData = var_7_1
			var_7_0.activeIndex = var_7_4
			var_7_0.animData = var_7_5

			table.insert(arg_7_0._activeFurnitures, var_7_0)
			arg_7_0:getAnimTfByPosData(var_7_1, var_7_4, function(arg_8_0, arg_8_1)
				if arg_8_1 ~= var_7_0.activeIndex then
					arg_7_0:returnAnimTf(var_7_3, arg_8_0)

					return
				end

				if var_7_0.data.hide_tfs then
					for iter_8_0 = 1, #var_7_0.data.hide_tfs do
						setActive(findTF(var_7_0.tf, var_7_0.data.hide_tfs[iter_8_0]), false)
					end
				end

				SetParent(arg_8_0, (findTF(var_7_0.tf, var_7_2)))
				setActive(arg_8_0, true)
				setActive(findTF(arg_8_0, "collider"), true)

				arg_8_0.anchoredPosition = Vector2(0, 0)
				var_7_0.animTf = arg_8_0

				arg_7_0:prepareAnim(var_7_0)

				return
			end)

			return
		end,
		getFunitureFromPool = function(arg_9_0, arg_9_1)
			for iter_9_0 = 1, #arg_9_0._furnituresPools do
				if arg_9_0._furnituresPools[iter_9_0].data.name == arg_9_1 then
					return table.remove(arg_9_0._furnituresPools, iter_9_0)
				end
			end

			return nil
		end,
		prepareAnim = function(arg_10_0, arg_10_1)
			if not arg_10_1.animData or not arg_10_1.animTf then
				return
			end

			arg_10_1.time = arg_10_1.data.time

			local var_10_1 = GetComponent(findTF(arg_10_1.animTf, "anim"), typeof(Animator))

			var_10_1:SetInteger("charIndex", arg_10_1.charIndex)

			if arg_10_1.data.type ~= var_0_15 then
				var_10_1:SetTrigger("trigger")
			end

			GetOrAddComponent(findTF(arg_10_1.animTf, "collider"), typeof(EventTriggerListener)):AddPointDownFunc(function(arg_11_0, arg_11_1, arg_11_2)
				if arg_10_1.readyToRemove then
					return
				end

				if arg_10_1.data.type == var_0_15 and arg_10_1.data.defaut_char_index == arg_10_1.charIndex and not arg_10_1.data.defaut_trigger then
					return
				end

				local var_11_0 = false

				if arg_10_1.data.type == var_0_15 and arg_10_1.data.defaut_char_index == arg_10_1.charIndex then
					var_11_0 = true
				end

				if not var_11_0 then
					pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_3)
					arg_10_0._event:emit(var_0_12, {
						score = arg_10_0:getScore(),
						pos = arg_11_1.position
					})
				end

				arg_10_1.readyToRemove = true

				var_10_1:SetTrigger("next")

				arg_10_1.time = arg_10_1.data.time or 3

				return
			end)

			return
		end,
		getScore = function(arg_12_0)
			arg_12_0.additiveScore = arg_12_0.additiveScore or var_0_7
			arg_12_0.additiveScore = arg_12_0.scoreTime and arg_12_0.timeStep - arg_12_0.scoreTime < var_0_8 and arg_12_0.additiveScore + var_0_9 or var_0_7

			if arg_12_0.additiveScore >= var_0_10 then
				arg_12_0.additiveScore = var_0_10
			end

			arg_12_0.scoreTime = arg_12_0.timeStep

			return arg_12_0.additiveScore
		end,
		getAnimTfByPosData = function(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
			if arg_13_0._furnitureAnimTfPool and arg_13_0._furnitureAnimTfPool[arg_13_1.anim_name] and #arg_13_0._furnitureAnimTfPool[arg_13_1.anim_name] > 0 then
				arg_13_3(table.remove(arg_13_0._furnitureAnimTfPool[arg_13_1.anim_name], 1), arg_13_2)

				return
			end

			return arg_13_0:createAnimTf(arg_13_1.anim_name, arg_13_2, arg_13_3)
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
				arg_14_0:returnAnimTf(arg_14_1.animData.name, arg_14_1.animTf)
			end

			if arg_14_1.data.hide_tfs then
				for iter_14_0 = 1, #arg_14_1.data.hide_tfs do
					setActive(findTF(arg_14_1.tf, arg_14_1.data.hide_tfs[iter_14_0]), true)
				end
			end

			arg_14_1.animTf = nil
			arg_14_1.animData = nil
			arg_14_1.activeIndex = nil
			arg_14_1.readyToRemove = false
			arg_14_1.time = nil

			for iter_14_1 = #arg_14_0._activeFurnitures, 1, -1 do
				if arg_14_0._activeFurnitures[iter_14_1] == arg_14_1 then
					table.insert(arg_14_0._furnituresPools, table.remove(arg_14_0._activeFurnitures, iter_14_1))
				end
			end

			for iter_14_2 = #arg_14_0._unActiveFurnitures, 1, -1 do
				if arg_14_0._unActiveFurnitures[iter_14_2] == arg_14_1 then
					table.insert(arg_14_0._furnituresPools, table.remove(arg_14_0._unActiveFurnitures, iter_14_2))
				end
			end

			local var_14_0 = false

			for iter_14_3 = 1, #arg_14_0._furnituresPools do
				if arg_14_0._furnituresPools[iter_14_3] == arg_14_1 then
					var_14_0 = true
				end
			end

			if not var_14_0 then
				table.insert(arg_14_0._furnituresPools, arg_14_1)
			end

			return
		end,
		returnAnimTf = function(arg_15_0, arg_15_1, arg_15_2)
			arg_15_0._furnitureAnimTfPool[arg_15_1] = arg_15_0._furnitureAnimTfPool[arg_15_1] or {}

			setActive(arg_15_2, false)
			table.insert(arg_15_0._furnitureAnimTfPool[arg_15_1], arg_15_2)

			return
		end,
		createAnimTf = function(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
			if not var_0_21[arg_16_1] then
				return nil
			end

			local var_16_0 = var_0_21[arg_16_1].prefab
			local var_16_1 = var_0_21[arg_16_1].name

			if arg_16_0._animTplDic[var_0_21[arg_16_1].name] then
				arg_16_3(tf(Instantiate(arg_16_0._animTplDic[var_0_21[arg_16_1].name])), arg_16_2)
			else
				LoadAndInstantiateAsync(var_0_17, var_16_0, function(arg_17_0)
					if not arg_17_0 then
						print("找不到资源" .. var_16_1)

						return
					end

					if arg_16_0.destroyFlag then
						Destroy(arg_17_0)

						return
					end

					arg_16_0._animTplDic[var_16_1] = arg_17_0

					SetParent(tf(arg_17_0), arg_16_0._tplContainer)
					arg_16_3(tf(Instantiate(arg_16_0._animTplDic[var_16_1])), arg_16_2)

					return
				end)
			end

			return
		end,
		getActiveIndex = function(arg_18_0)
			arg_18_0._activeIndex = arg_18_0._activeIndex or 0
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
				if arg_19_0._furnituresPools[iter_19_2].data.type == var_0_14 then
					arg_19_0._furnituresPools[iter_19_2].initFlag = false
				end
			end

			arg_19_0._activeFurnitures = {}
			var_0_27 = Clone(var_0_19)

			return
		end,
		destroy = function(arg_20_0)
			arg_20_0:clear()

			for iter_20_0 = 1, #arg_20_0._furnitureAnimTfPool do
				if arg_20_0._furnitureAnimTfPool[iter_20_0].animTf then
					ClearEventTrigger((GetOrAddComponent(findTF(arg_20_0._furnitureAnimTfPool[iter_20_0].animTf, "collider"), typeof(EventTriggerListener))))
				end
			end

			arg_20_0.destroyFlag = true

			return
		end
	})

	return {
		ctor = function(arg_2_0)
			arg_2_0._event = arg_1_1
			arg_2_0._sceneTf = arg_1_0
			arg_2_0._tplContainer = findTF(arg_1_0, "tplPos")
			var_0_27 = Clone(var_0_19)
			arg_2_0._furnituresPools = {}

			for iter_2_0 = 1, #var_0_20 do
				table.insert(arg_2_0._furnituresPools, {
					activeIndex = 0,
					data = Clone(var_0_20[iter_2_0]),
					tf = findTF(arg_2_0._sceneTf, var_0_20[iter_2_0].name)
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
			arg_3_0.additiveScore = var_0_7

			for iter_3_0 = #arg_3_0._furnituresPools, 1, -1 do
				if arg_3_0._furnituresPools[iter_3_0].data.type == var_0_14 then
					if math.random() <= arg_3_0._furnituresPools[iter_3_0].data.weight then
						arg_3_0:appearChar(arg_3_0._furnituresPools[iter_3_0].data.name)
					end

					arg_3_0._furnituresPools[iter_3_0].initFlag = true

					table.insert(arg_3_0._unActiveFurnitures, arg_3_0:getFunitureFromPool(arg_3_0._furnituresPools[iter_3_0].data.name))
				elseif arg_3_0._furnituresPools[iter_3_0].data.type == var_0_15 then
					arg_3_0:appearChar(arg_3_0._furnituresPools[iter_3_0].data.name)
				end
			end

			return
		end,
		step = function(arg_4_0)
			arg_4_0.timeStep = arg_4_0.timeStep + Time.deltaTime

			local var_4_0 = false

			if arg_4_0.timeAppear <= 0 then
				var_4_0 = true
				arg_4_0.timeAppear = nil

				for iter_4_0 = 1, #var_0_6 do
					if not arg_4_0.timeAppear and var_0_5 - arg_4_0.timeStep < var_0_6[iter_4_0][1] or iter_4_0 == #var_0_6 then
						arg_4_0.timeAppear = math.random() * (var_0_6[iter_4_0][3] - var_0_6[iter_4_0][2]) + var_0_6[iter_4_0][2]

						break
					end
				end

				arg_4_0.timeAppear = not arg_4_0.timeAppear and 2 or arg_4_0.timeAppear
			else
				arg_4_0.timeAppear = arg_4_0.timeAppear - Time.deltaTime
			end

			for iter_4_1 = #arg_4_0._activeFurnitures, 1, -1 do
				if arg_4_0._activeFurnitures[iter_4_1].time then
					arg_4_0._activeFurnitures[iter_4_1].time = arg_4_0._activeFurnitures[iter_4_1].time - Time.deltaTime

					if arg_4_0._activeFurnitures[iter_4_1].time <= 0 then
						arg_4_0:setFurnitureTimeEvent(arg_4_0._activeFurnitures[iter_4_1])
					end
				end
			end

			if var_4_0 then
				arg_4_0:appearChar()
			end

			return
		end,
		setFurnitureTimeEvent = function(arg_5_0, arg_5_1)
			if arg_5_1.data.type == var_0_15 then
				arg_5_0:returnCharIndex(arg_5_1.charIndex)

				arg_5_1.charIndex = math.random() <= arg_5_1.data.weight and #var_0_27 > 0 and table.remove(var_0_27, math.random(1, #var_0_27)) or arg_5_1.data.defaut_char_index
				arg_5_1.readyToRemove = false
				arg_5_1.time = arg_5_1.data.time

				GetComponent(findTF(arg_5_1.animTf, "anim"), typeof(Animator)):SetInteger("charIndex", arg_5_1.charIndex)
			elseif arg_5_1.data.type == var_0_13 then
				if arg_5_1.data.hide and not arg_5_1.readyToRemove then
					arg_5_1.time = 2
					arg_5_1.readyToRemove = true

					GetComponent(findTF(arg_5_1.animTf, "anim"), typeof(Animator)):SetTrigger("hide")
				else
					arg_5_0:returnFurniture(arg_5_1)
				end
			elseif arg_5_1.data.type == var_0_14 then
				if arg_5_1.charIndex then
					arg_5_0:returnCharIndex(arg_5_1.charIndex)

					if arg_5_1.animTf then
						setActive(findTF(arg_5_1.animTf, "collider"), false)
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
			if not table.contains(var_0_27, arg_6_1) and table.contains(var_0_19, arg_6_1) then
				table.insert(var_0_27, arg_6_1)
			end

			return
		end,
		appearChar = function(arg_7_0, arg_7_1)
			if #var_0_27 <= 0 then
				return
			end

			if #arg_7_0._furnituresPools <= 0 then
				return
			end

			local var_7_0

			if arg_7_1 then
				var_7_0 = arg_7_0:getFunitureFromPool(arg_7_1)
			end

			var_7_0 = var_7_0 or table.remove(arg_7_0._furnituresPools, math.random(1, #arg_7_0._furnituresPools))

			local var_7_1 = var_7_0.data.pos_data_list[math.random(1, #var_7_0.data.pos_data_list)]
			local var_7_2 = var_7_1.pos_name
			local var_7_3 = var_7_1.anim_name
			local var_7_4 = arg_7_0:getActiveIndex()
			local var_7_5 = var_0_21[var_7_1.anim_name]

			if not var_0_21[var_7_1.anim_name] then
				print("警告，没有找到" .. var_7_1.anim_name .. "的动画数据")
				arg_7_0:returnFurniture(var_7_0)

				return
			end

			local var_7_6 = var_7_0.data.type == var_0_15 and var_7_0.data.defaut_char_index or table.remove(var_0_27, math.random(1, #var_0_27))

			var_7_0.charIndex = var_7_6

			if table.contains(var_7_5.ignore_char, var_7_6) then
				arg_7_0:returnFurniture(var_7_0)

				return
			elseif var_7_0.data.type == var_0_14 and var_7_0.initFlag then
				arg_7_0:returnFurniture(var_7_0)

				return
			end

			var_7_0.posData = var_7_1
			var_7_0.activeIndex = var_7_4
			var_7_0.animData = var_7_5

			table.insert(arg_7_0._activeFurnitures, var_7_0)
			arg_7_0:getAnimTfByPosData(var_7_1, var_7_4, function(arg_8_0, arg_8_1)
				if arg_8_1 ~= var_7_0.activeIndex then
					arg_7_0:returnAnimTf(var_7_3, arg_8_0)

					return
				end

				if var_7_0.data.hide_tfs then
					for iter_8_0 = 1, #var_7_0.data.hide_tfs do
						setActive(findTF(var_7_0.tf, var_7_0.data.hide_tfs[iter_8_0]), false)
					end
				end

				SetParent(arg_8_0, (findTF(var_7_0.tf, var_7_2)))
				setActive(arg_8_0, true)
				setActive(findTF(arg_8_0, "collider"), true)

				arg_8_0.anchoredPosition = Vector2(0, 0)
				var_7_0.animTf = arg_8_0

				arg_7_0:prepareAnim(var_7_0)

				return
			end)

			return
		end,
		getFunitureFromPool = function(arg_9_0, arg_9_1)
			for iter_9_0 = 1, #arg_9_0._furnituresPools do
				if arg_9_0._furnituresPools[iter_9_0].data.name == arg_9_1 then
					return table.remove(arg_9_0._furnituresPools, iter_9_0)
				end
			end

			return nil
		end,
		prepareAnim = function(arg_10_0, arg_10_1)
			if not arg_10_1.animData or not arg_10_1.animTf then
				return
			end

			arg_10_1.time = arg_10_1.data.time

			local var_10_1 = GetComponent(findTF(arg_10_1.animTf, "anim"), typeof(Animator))

			var_10_1:SetInteger("charIndex", arg_10_1.charIndex)

			if arg_10_1.data.type ~= var_0_15 then
				var_10_1:SetTrigger("trigger")
			end

			GetOrAddComponent(findTF(arg_10_1.animTf, "collider"), typeof(EventTriggerListener)):AddPointDownFunc(function(arg_11_0, arg_11_1, arg_11_2)
				if arg_10_1.readyToRemove then
					return
				end

				if arg_10_1.data.type == var_0_15 and arg_10_1.data.defaut_char_index == arg_10_1.charIndex and not arg_10_1.data.defaut_trigger then
					return
				end

				local var_11_0 = false

				if arg_10_1.data.type == var_0_15 and arg_10_1.data.defaut_char_index == arg_10_1.charIndex then
					var_11_0 = true
				end

				if not var_11_0 then
					pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_3)
					arg_10_0._event:emit(var_0_12, {
						score = arg_10_0:getScore(),
						pos = arg_11_1.position
					})
				end

				arg_10_1.readyToRemove = true

				var_10_1:SetTrigger("next")

				arg_10_1.time = arg_10_1.data.time or 3

				return
			end)

			return
		end,
		getScore = function(arg_12_0)
			arg_12_0.additiveScore = arg_12_0.additiveScore or var_0_7
			arg_12_0.additiveScore = arg_12_0.scoreTime and arg_12_0.timeStep - arg_12_0.scoreTime < var_0_8 and arg_12_0.additiveScore + var_0_9 or var_0_7

			if arg_12_0.additiveScore >= var_0_10 then
				arg_12_0.additiveScore = var_0_10
			end

			arg_12_0.scoreTime = arg_12_0.timeStep

			return arg_12_0.additiveScore
		end,
		getAnimTfByPosData = function(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
			if arg_13_0._furnitureAnimTfPool and arg_13_0._furnitureAnimTfPool[arg_13_1.anim_name] and #arg_13_0._furnitureAnimTfPool[arg_13_1.anim_name] > 0 then
				arg_13_3(table.remove(arg_13_0._furnitureAnimTfPool[arg_13_1.anim_name], 1), arg_13_2)

				return
			end

			return arg_13_0:createAnimTf(arg_13_1.anim_name, arg_13_2, arg_13_3)
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
				arg_14_0:returnAnimTf(arg_14_1.animData.name, arg_14_1.animTf)
			end

			if arg_14_1.data.hide_tfs then
				for iter_14_0 = 1, #arg_14_1.data.hide_tfs do
					setActive(findTF(arg_14_1.tf, arg_14_1.data.hide_tfs[iter_14_0]), true)
				end
			end

			arg_14_1.animTf = nil
			arg_14_1.animData = nil
			arg_14_1.activeIndex = nil
			arg_14_1.readyToRemove = false
			arg_14_1.time = nil

			for iter_14_1 = #arg_14_0._activeFurnitures, 1, -1 do
				if arg_14_0._activeFurnitures[iter_14_1] == arg_14_1 then
					table.insert(arg_14_0._furnituresPools, table.remove(arg_14_0._activeFurnitures, iter_14_1))
				end
			end

			for iter_14_2 = #arg_14_0._unActiveFurnitures, 1, -1 do
				if arg_14_0._unActiveFurnitures[iter_14_2] == arg_14_1 then
					table.insert(arg_14_0._furnituresPools, table.remove(arg_14_0._unActiveFurnitures, iter_14_2))
				end
			end

			local var_14_0 = false

			for iter_14_3 = 1, #arg_14_0._furnituresPools do
				if arg_14_0._furnituresPools[iter_14_3] == arg_14_1 then
					var_14_0 = true
				end
			end

			if not var_14_0 then
				table.insert(arg_14_0._furnituresPools, arg_14_1)
			end

			return
		end,
		returnAnimTf = function(arg_15_0, arg_15_1, arg_15_2)
			arg_15_0._furnitureAnimTfPool[arg_15_1] = arg_15_0._furnitureAnimTfPool[arg_15_1] or {}

			setActive(arg_15_2, false)
			table.insert(arg_15_0._furnitureAnimTfPool[arg_15_1], arg_15_2)

			return
		end,
		createAnimTf = function(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
			if not var_0_21[arg_16_1] then
				return nil
			end

			local var_16_0 = var_0_21[arg_16_1].prefab
			local var_16_1 = var_0_21[arg_16_1].name

			if arg_16_0._animTplDic[var_0_21[arg_16_1].name] then
				arg_16_3(tf(Instantiate(arg_16_0._animTplDic[var_0_21[arg_16_1].name])), arg_16_2)
			else
				LoadAndInstantiateAsync(var_0_17, var_16_0, function(arg_17_0)
					if not arg_17_0 then
						print("找不到资源" .. var_16_1)

						return
					end

					if arg_16_0.destroyFlag then
						Destroy(arg_17_0)

						return
					end

					arg_16_0._animTplDic[var_16_1] = arg_17_0

					SetParent(tf(arg_17_0), arg_16_0._tplContainer)
					arg_16_3(tf(Instantiate(arg_16_0._animTplDic[var_16_1])), arg_16_2)

					return
				end)
			end

			return
		end,
		getActiveIndex = function(arg_18_0)
			arg_18_0._activeIndex = arg_18_0._activeIndex or 0
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
				if arg_19_0._furnituresPools[iter_19_2].data.type == var_0_14 then
					arg_19_0._furnituresPools[iter_19_2].initFlag = false
				end
			end

			arg_19_0._activeFurnitures = {}
			var_0_27 = Clone(var_0_19)

			return
		end,
		destroy = function(arg_20_0)
			arg_20_0:clear()

			for iter_20_0 = 1, #arg_20_0._furnitureAnimTfPool do
				if arg_20_0._furnitureAnimTfPool[iter_20_0].animTf then
					ClearEventTrigger((GetOrAddComponent(findTF(arg_20_0._furnitureAnimTfPool[iter_20_0].animTf, "collider"), typeof(EventTriggerListener))))
				end
			end

			arg_20_0.destroyFlag = true

			return
		end
	}
end

local var_0_29 = {
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
local var_0_30 = {
	5,
	10
}
local var_0_31 = 300

local function var_0_33(arg_21_0, arg_21_1)
	({
		ctor = function(arg_22_0)
			arg_22_0._tf = arg_21_0
			arg_22_0._event = arg_21_1
			arg_22_0._roleTf = findTF(arg_22_0._tf, "fushun")
			arg_22_0._roleAnimator = GetComponent(findTF(arg_22_0._roleTf, "img/anim"), typeof(Animator))
			arg_22_0._dftEvent = GetComponent(findTF(arg_22_0._roleTf, "img/anim"), typeof(DftAniEvent))

			arg_22_0._dftEvent:SetEndEvent(function(arg_23_0)
				setActive(arg_22_0._roleTf, false)
				arg_22_0:clear()

				return
			end)

			arg_22_0._eventTrigger = GetOrAddComponent(findTF(arg_22_0._roleTf, "img/collider"), typeof(EventTriggerListener))

			arg_22_0._eventTrigger:AddPointDownFunc(function(arg_24_0, arg_24_1, arg_24_2)
				if arg_22_0.removeRoleFlag then
					return
				end

				pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_3)
				arg_22_0._event:emit(var_0_12, {
					score = var_0_11,
					pos = arg_24_1.position
				})

				arg_22_0.removeRoleFlag = true

				arg_22_0:setRoleAnimatorTrigger("touch")

				return
			end)

			arg_22_0._roleShowData = {}
			arg_22_0._roleShowStartData = {}

			for iter_22_0 = 1, #var_0_29 do
				if var_0_29[iter_22_0].start then
					table.insert(arg_22_0._roleShowStartData, Clone(var_0_29[iter_22_0]))
				end

				local var_22_0 = Clone(var_0_29[iter_22_0])

				arg_22_0._roleShowData[var_22_0.name] = var_22_0
			end

			arg_22_0._active = false
			arg_22_0._targetPos = Vector2(0, 0)
			arg_22_0._currentTargetData = nil
			arg_22_0._currentTargetPos = nil

			return
		end,
		setRoleAnimatorTrigger = function(arg_25_0, arg_25_1, arg_25_2)
			if not arg_25_2 then
				arg_25_0._roleAnimator:SetTrigger(arg_25_1)
			else
				arg_25_0._roleAnimator:ResetTrigger(arg_25_1)
			end

			return
		end,
		start = function(arg_26_0)
			arg_26_0.showTime = math.random() * (var_0_30[2] - var_0_30[1]) + var_0_30[1]

			arg_26_0:clear()

			return
		end,
		step = function(arg_27_0)
			if arg_27_0.showTime > 0 then
				arg_27_0.showTime = arg_27_0.showTime - Time.deltaTime

				if arg_27_0.showTime <= 0 then
					arg_27_0.showTime = 0

					arg_27_0:checkShow()
				end
			end

			if arg_27_0._currentTargetData and not arg_27_0.removeRoleFlag then
				local var_27_0 = arg_27_0._roleTf.anchoredPosition
				local var_27_1 = var_0_31 * math.cos(arg_27_0._moveAngle) * Time.deltaTime
				local var_27_2 = var_0_31 * math.sin(arg_27_0._moveAngle) * Time.deltaTime

				if arg_27_0._roleDirectX == 1 and arg_27_0._roleDirectX * var_27_1 + var_27_0.x > arg_27_0._currentTargetPos.x then
					var_27_0.x = var_27_0.x + arg_27_0._roleDirectX * var_27_1
					arg_27_0._roleDirectX = nil
				elseif arg_27_0._roleDirectX == -1 and arg_27_0._roleDirectX * var_27_1 + var_27_0.x < arg_27_0._currentTargetPos.x then
					var_27_0.x = var_27_0.x + arg_27_0._roleDirectX * var_27_1
					arg_27_0._roleDirectX = nil
				elseif arg_27_0._roleDirectX then
					var_27_0.x = var_27_0.x + arg_27_0._roleDirectX * var_27_1
				end

				if arg_27_0._roleDirectY == 1 and arg_27_0._roleDirectY * var_27_2 + var_27_0.y > arg_27_0._currentTargetPos.y then
					var_27_0.y = var_27_0.y + arg_27_0._roleDirectY * var_27_2
					arg_27_0._roleDirectY = nil
				elseif arg_27_0._roleDirectY == -1 and arg_27_0._roleDirectY * var_27_2 + var_27_0.y < arg_27_0._currentTargetPos.y then
					var_27_0.y = var_27_0.y + arg_27_0._roleDirectY * var_27_2
					arg_27_0._roleDirectY = nil
				elseif arg_27_0._roleDirectY then
					var_27_0.y = var_27_0.y + arg_27_0._roleDirectY * var_27_2
				end

				arg_27_0._roleTf.anchoredPosition = var_27_0

				if arg_27_0._roleDirectX == nil and arg_27_0._roleDirectY == nil then
					arg_27_0:setRoleNext()
				end
			end

			return
		end,
		setRoleStatus = function(arg_28_0, arg_28_1)
			setActive(arg_28_0._roleTf, true)

			if arg_28_1 then
				arg_28_0:setRoleAnimatorTrigger("change", true)
				arg_28_0:setRoleAnimatorTrigger("hide", true)
				arg_28_0:setRoleAnimatorTrigger("show")
			else
				arg_28_0:setRoleAnimatorTrigger("change")
			end

			arg_28_0._roleAnimator:SetInteger("directX", arg_28_0._roleDirectX)
			arg_28_0._roleAnimator:SetInteger("directY", arg_28_0._roleDirectY)

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

				local var_29_1 = Clone(arg_29_0._currentData.next)

				if var_29_0 then
					for iter_29_0 = #var_29_1, 1, -1 do
						if var_29_1[iter_29_0] == var_29_0 then
							table.remove(var_29_1, iter_29_0)
						end
					end
				end

				if #var_29_1 == 0 then
					arg_29_0:clear()

					return
				end

				arg_29_0._currentTargetData = arg_29_0._roleShowData[var_29_1[math.random(1, #var_29_1)]]

				local var_29_2 = findTF(arg_29_0._tf, arg_29_0._currentData.name)

				if arg_29_0._currentTargetData and arg_29_0._currentTargetData.switch_parent then
					setParent(arg_29_0._roleTf, (findTF(arg_29_0._tf, arg_29_0._currentTargetData.name)))
				else
					setParent(arg_29_0._roleTf, var_29_2)
				end

				arg_29_0._roleTf.anchoredPosition = findTF(var_29_2, "rolePos").anchoredPosition
				arg_29_0._currentTargetPos = findTF(arg_29_0._tf, arg_29_0._currentTargetData.name .. "/rolePos").anchoredPosition
				arg_29_0._roleDirectX = arg_29_0._currentTargetPos.x > arg_29_0._roleTf.anchoredPosition.x and 1 or -1
				arg_29_0._roleDirectY = arg_29_0._currentTargetPos.y > arg_29_0._roleTf.anchoredPosition.y and 1 or -1
				arg_29_0._moveAngle = math.atan(math.abs(arg_29_0._currentTargetPos.y - arg_29_0._roleTf.anchoredPosition.y) / math.abs(arg_29_0._currentTargetPos.x - arg_29_0._roleTf.anchoredPosition.x))
				arg_29_0.removeRoleFlag = false

				arg_29_0:setRoleStatus(arg_29_1)
			elseif arg_29_0._currentTargetData.finish then
				arg_29_0:clear()
			end

			return
		end,
		checkShow = function(arg_30_0)
			if arg_30_0._active and not table.contains(var_0_27, var_0_18) then
				return
			end

			for iter_30_0 = #var_0_27, 1, -1 do
				if var_0_27[iter_30_0] == var_0_18 then
					table.remove(var_0_27, iter_30_0)
				end
			end

			arg_30_0._active = true
			arg_30_0._currentData = arg_30_0._roleShowStartData[math.random(1, #arg_30_0._roleShowStartData)]

			arg_30_0:setRoleNext(true)

			return
		end,
		clear = function(arg_31_0)
			arg_31_0._currentTargetData = nil
			arg_31_0._currentTargetPos = nil

			if not table.contains(var_0_27, var_0_18) then
				table.insert(var_0_27, var_0_18)
			end

			if isActive(arg_31_0._roleTf) then
				arg_31_0:setRoleAnimatorTrigger("hide")

				arg_31_0.removeRoleFlag = true

				setActive(arg_31_0._roleTf, false)
			end

			arg_31_0.showTime = math.random() * (var_0_30[2] - var_0_30[1]) + var_0_30[1]
			arg_31_0._active = false

			return
		end,
		destroy = function(arg_32_0)
			return
		end
	}).ctor({
		ctor = function(arg_22_0)
			arg_22_0._tf = arg_21_0
			arg_22_0._event = arg_21_1
			arg_22_0._roleTf = findTF(arg_22_0._tf, "fushun")
			arg_22_0._roleAnimator = GetComponent(findTF(arg_22_0._roleTf, "img/anim"), typeof(Animator))
			arg_22_0._dftEvent = GetComponent(findTF(arg_22_0._roleTf, "img/anim"), typeof(DftAniEvent))

			arg_22_0._dftEvent:SetEndEvent(function(arg_23_0)
				setActive(arg_22_0._roleTf, false)
				arg_22_0:clear()

				return
			end)

			arg_22_0._eventTrigger = GetOrAddComponent(findTF(arg_22_0._roleTf, "img/collider"), typeof(EventTriggerListener))

			arg_22_0._eventTrigger:AddPointDownFunc(function(arg_24_0, arg_24_1, arg_24_2)
				if arg_22_0.removeRoleFlag then
					return
				end

				pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_3)
				arg_22_0._event:emit(var_0_12, {
					score = var_0_11,
					pos = arg_24_1.position
				})

				arg_22_0.removeRoleFlag = true

				arg_22_0:setRoleAnimatorTrigger("touch")

				return
			end)

			arg_22_0._roleShowData = {}
			arg_22_0._roleShowStartData = {}

			for iter_22_0 = 1, #var_0_29 do
				if var_0_29[iter_22_0].start then
					table.insert(arg_22_0._roleShowStartData, Clone(var_0_29[iter_22_0]))
				end

				local var_22_0 = Clone(var_0_29[iter_22_0])

				arg_22_0._roleShowData[var_22_0.name] = var_22_0
			end

			arg_22_0._active = false
			arg_22_0._targetPos = Vector2(0, 0)
			arg_22_0._currentTargetData = nil
			arg_22_0._currentTargetPos = nil

			return
		end,
		setRoleAnimatorTrigger = function(arg_25_0, arg_25_1, arg_25_2)
			if not arg_25_2 then
				arg_25_0._roleAnimator:SetTrigger(arg_25_1)
			else
				arg_25_0._roleAnimator:ResetTrigger(arg_25_1)
			end

			return
		end,
		start = function(arg_26_0)
			arg_26_0.showTime = math.random() * (var_0_30[2] - var_0_30[1]) + var_0_30[1]

			arg_26_0:clear()

			return
		end,
		step = function(arg_27_0)
			if arg_27_0.showTime > 0 then
				arg_27_0.showTime = arg_27_0.showTime - Time.deltaTime

				if arg_27_0.showTime <= 0 then
					arg_27_0.showTime = 0

					arg_27_0:checkShow()
				end
			end

			if arg_27_0._currentTargetData and not arg_27_0.removeRoleFlag then
				local var_27_0 = arg_27_0._roleTf.anchoredPosition
				local var_27_1 = var_0_31 * math.cos(arg_27_0._moveAngle) * Time.deltaTime
				local var_27_2 = var_0_31 * math.sin(arg_27_0._moveAngle) * Time.deltaTime

				if arg_27_0._roleDirectX == 1 and arg_27_0._roleDirectX * var_27_1 + var_27_0.x > arg_27_0._currentTargetPos.x then
					var_27_0.x = var_27_0.x + arg_27_0._roleDirectX * var_27_1
					arg_27_0._roleDirectX = nil
				elseif arg_27_0._roleDirectX == -1 and arg_27_0._roleDirectX * var_27_1 + var_27_0.x < arg_27_0._currentTargetPos.x then
					var_27_0.x = var_27_0.x + arg_27_0._roleDirectX * var_27_1
					arg_27_0._roleDirectX = nil
				elseif arg_27_0._roleDirectX then
					var_27_0.x = var_27_0.x + arg_27_0._roleDirectX * var_27_1
				end

				if arg_27_0._roleDirectY == 1 and arg_27_0._roleDirectY * var_27_2 + var_27_0.y > arg_27_0._currentTargetPos.y then
					var_27_0.y = var_27_0.y + arg_27_0._roleDirectY * var_27_2
					arg_27_0._roleDirectY = nil
				elseif arg_27_0._roleDirectY == -1 and arg_27_0._roleDirectY * var_27_2 + var_27_0.y < arg_27_0._currentTargetPos.y then
					var_27_0.y = var_27_0.y + arg_27_0._roleDirectY * var_27_2
					arg_27_0._roleDirectY = nil
				elseif arg_27_0._roleDirectY then
					var_27_0.y = var_27_0.y + arg_27_0._roleDirectY * var_27_2
				end

				arg_27_0._roleTf.anchoredPosition = var_27_0

				if arg_27_0._roleDirectX == nil and arg_27_0._roleDirectY == nil then
					arg_27_0:setRoleNext()
				end
			end

			return
		end,
		setRoleStatus = function(arg_28_0, arg_28_1)
			setActive(arg_28_0._roleTf, true)

			if arg_28_1 then
				arg_28_0:setRoleAnimatorTrigger("change", true)
				arg_28_0:setRoleAnimatorTrigger("hide", true)
				arg_28_0:setRoleAnimatorTrigger("show")
			else
				arg_28_0:setRoleAnimatorTrigger("change")
			end

			arg_28_0._roleAnimator:SetInteger("directX", arg_28_0._roleDirectX)
			arg_28_0._roleAnimator:SetInteger("directY", arg_28_0._roleDirectY)

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

				local var_29_1 = Clone(arg_29_0._currentData.next)

				if var_29_0 then
					for iter_29_0 = #var_29_1, 1, -1 do
						if var_29_1[iter_29_0] == var_29_0 then
							table.remove(var_29_1, iter_29_0)
						end
					end
				end

				if #var_29_1 == 0 then
					arg_29_0:clear()

					return
				end

				arg_29_0._currentTargetData = arg_29_0._roleShowData[var_29_1[math.random(1, #var_29_1)]]

				local var_29_2 = findTF(arg_29_0._tf, arg_29_0._currentData.name)

				if arg_29_0._currentTargetData and arg_29_0._currentTargetData.switch_parent then
					setParent(arg_29_0._roleTf, (findTF(arg_29_0._tf, arg_29_0._currentTargetData.name)))
				else
					setParent(arg_29_0._roleTf, var_29_2)
				end

				arg_29_0._roleTf.anchoredPosition = findTF(var_29_2, "rolePos").anchoredPosition
				arg_29_0._currentTargetPos = findTF(arg_29_0._tf, arg_29_0._currentTargetData.name .. "/rolePos").anchoredPosition
				arg_29_0._roleDirectX = arg_29_0._currentTargetPos.x > arg_29_0._roleTf.anchoredPosition.x and 1 or -1
				arg_29_0._roleDirectY = arg_29_0._currentTargetPos.y > arg_29_0._roleTf.anchoredPosition.y and 1 or -1
				arg_29_0._moveAngle = math.atan(math.abs(arg_29_0._currentTargetPos.y - arg_29_0._roleTf.anchoredPosition.y) / math.abs(arg_29_0._currentTargetPos.x - arg_29_0._roleTf.anchoredPosition.x))
				arg_29_0.removeRoleFlag = false

				arg_29_0:setRoleStatus(arg_29_1)
			elseif arg_29_0._currentTargetData.finish then
				arg_29_0:clear()
			end

			return
		end,
		checkShow = function(arg_30_0)
			if arg_30_0._active and not table.contains(var_0_27, var_0_18) then
				return
			end

			for iter_30_0 = #var_0_27, 1, -1 do
				if var_0_27[iter_30_0] == var_0_18 then
					table.remove(var_0_27, iter_30_0)
				end
			end

			arg_30_0._active = true
			arg_30_0._currentData = arg_30_0._roleShowStartData[math.random(1, #arg_30_0._roleShowStartData)]

			arg_30_0:setRoleNext(true)

			return
		end,
		clear = function(arg_31_0)
			arg_31_0._currentTargetData = nil
			arg_31_0._currentTargetPos = nil

			if not table.contains(var_0_27, var_0_18) then
				table.insert(var_0_27, var_0_18)
			end

			if isActive(arg_31_0._roleTf) then
				arg_31_0:setRoleAnimatorTrigger("hide")

				arg_31_0.removeRoleFlag = true

				setActive(arg_31_0._roleTf, false)
			end

			arg_31_0.showTime = math.random() * (var_0_30[2] - var_0_30[1]) + var_0_30[1]
			arg_31_0._active = false

			return
		end,
		destroy = function(arg_32_0)
			return
		end
	})

	return {
		ctor = function(arg_22_0)
			arg_22_0._tf = arg_21_0
			arg_22_0._event = arg_21_1
			arg_22_0._roleTf = findTF(arg_22_0._tf, "fushun")
			arg_22_0._roleAnimator = GetComponent(findTF(arg_22_0._roleTf, "img/anim"), typeof(Animator))
			arg_22_0._dftEvent = GetComponent(findTF(arg_22_0._roleTf, "img/anim"), typeof(DftAniEvent))

			arg_22_0._dftEvent:SetEndEvent(function(arg_23_0)
				setActive(arg_22_0._roleTf, false)
				arg_22_0:clear()

				return
			end)

			arg_22_0._eventTrigger = GetOrAddComponent(findTF(arg_22_0._roleTf, "img/collider"), typeof(EventTriggerListener))

			arg_22_0._eventTrigger:AddPointDownFunc(function(arg_24_0, arg_24_1, arg_24_2)
				if arg_22_0.removeRoleFlag then
					return
				end

				pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_3)
				arg_22_0._event:emit(var_0_12, {
					score = var_0_11,
					pos = arg_24_1.position
				})

				arg_22_0.removeRoleFlag = true

				arg_22_0:setRoleAnimatorTrigger("touch")

				return
			end)

			arg_22_0._roleShowData = {}
			arg_22_0._roleShowStartData = {}

			for iter_22_0 = 1, #var_0_29 do
				if var_0_29[iter_22_0].start then
					table.insert(arg_22_0._roleShowStartData, Clone(var_0_29[iter_22_0]))
				end

				local var_22_0 = Clone(var_0_29[iter_22_0])

				arg_22_0._roleShowData[var_22_0.name] = var_22_0
			end

			arg_22_0._active = false
			arg_22_0._targetPos = Vector2(0, 0)
			arg_22_0._currentTargetData = nil
			arg_22_0._currentTargetPos = nil

			return
		end,
		setRoleAnimatorTrigger = function(arg_25_0, arg_25_1, arg_25_2)
			if not arg_25_2 then
				arg_25_0._roleAnimator:SetTrigger(arg_25_1)
			else
				arg_25_0._roleAnimator:ResetTrigger(arg_25_1)
			end

			return
		end,
		start = function(arg_26_0)
			arg_26_0.showTime = math.random() * (var_0_30[2] - var_0_30[1]) + var_0_30[1]

			arg_26_0:clear()

			return
		end,
		step = function(arg_27_0)
			if arg_27_0.showTime > 0 then
				arg_27_0.showTime = arg_27_0.showTime - Time.deltaTime

				if arg_27_0.showTime <= 0 then
					arg_27_0.showTime = 0

					arg_27_0:checkShow()
				end
			end

			if arg_27_0._currentTargetData and not arg_27_0.removeRoleFlag then
				local var_27_0 = arg_27_0._roleTf.anchoredPosition
				local var_27_1 = var_0_31 * math.cos(arg_27_0._moveAngle) * Time.deltaTime
				local var_27_2 = var_0_31 * math.sin(arg_27_0._moveAngle) * Time.deltaTime

				if arg_27_0._roleDirectX == 1 and arg_27_0._roleDirectX * var_27_1 + var_27_0.x > arg_27_0._currentTargetPos.x then
					var_27_0.x = var_27_0.x + arg_27_0._roleDirectX * var_27_1
					arg_27_0._roleDirectX = nil
				elseif arg_27_0._roleDirectX == -1 and arg_27_0._roleDirectX * var_27_1 + var_27_0.x < arg_27_0._currentTargetPos.x then
					var_27_0.x = var_27_0.x + arg_27_0._roleDirectX * var_27_1
					arg_27_0._roleDirectX = nil
				elseif arg_27_0._roleDirectX then
					var_27_0.x = var_27_0.x + arg_27_0._roleDirectX * var_27_1
				end

				if arg_27_0._roleDirectY == 1 and arg_27_0._roleDirectY * var_27_2 + var_27_0.y > arg_27_0._currentTargetPos.y then
					var_27_0.y = var_27_0.y + arg_27_0._roleDirectY * var_27_2
					arg_27_0._roleDirectY = nil
				elseif arg_27_0._roleDirectY == -1 and arg_27_0._roleDirectY * var_27_2 + var_27_0.y < arg_27_0._currentTargetPos.y then
					var_27_0.y = var_27_0.y + arg_27_0._roleDirectY * var_27_2
					arg_27_0._roleDirectY = nil
				elseif arg_27_0._roleDirectY then
					var_27_0.y = var_27_0.y + arg_27_0._roleDirectY * var_27_2
				end

				arg_27_0._roleTf.anchoredPosition = var_27_0

				if arg_27_0._roleDirectX == nil and arg_27_0._roleDirectY == nil then
					arg_27_0:setRoleNext()
				end
			end

			return
		end,
		setRoleStatus = function(arg_28_0, arg_28_1)
			setActive(arg_28_0._roleTf, true)

			if arg_28_1 then
				arg_28_0:setRoleAnimatorTrigger("change", true)
				arg_28_0:setRoleAnimatorTrigger("hide", true)
				arg_28_0:setRoleAnimatorTrigger("show")
			else
				arg_28_0:setRoleAnimatorTrigger("change")
			end

			arg_28_0._roleAnimator:SetInteger("directX", arg_28_0._roleDirectX)
			arg_28_0._roleAnimator:SetInteger("directY", arg_28_0._roleDirectY)

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

				local var_29_1 = Clone(arg_29_0._currentData.next)

				if var_29_0 then
					for iter_29_0 = #var_29_1, 1, -1 do
						if var_29_1[iter_29_0] == var_29_0 then
							table.remove(var_29_1, iter_29_0)
						end
					end
				end

				if #var_29_1 == 0 then
					arg_29_0:clear()

					return
				end

				arg_29_0._currentTargetData = arg_29_0._roleShowData[var_29_1[math.random(1, #var_29_1)]]

				local var_29_2 = findTF(arg_29_0._tf, arg_29_0._currentData.name)

				if arg_29_0._currentTargetData and arg_29_0._currentTargetData.switch_parent then
					setParent(arg_29_0._roleTf, (findTF(arg_29_0._tf, arg_29_0._currentTargetData.name)))
				else
					setParent(arg_29_0._roleTf, var_29_2)
				end

				arg_29_0._roleTf.anchoredPosition = findTF(var_29_2, "rolePos").anchoredPosition
				arg_29_0._currentTargetPos = findTF(arg_29_0._tf, arg_29_0._currentTargetData.name .. "/rolePos").anchoredPosition
				arg_29_0._roleDirectX = arg_29_0._currentTargetPos.x > arg_29_0._roleTf.anchoredPosition.x and 1 or -1
				arg_29_0._roleDirectY = arg_29_0._currentTargetPos.y > arg_29_0._roleTf.anchoredPosition.y and 1 or -1
				arg_29_0._moveAngle = math.atan(math.abs(arg_29_0._currentTargetPos.y - arg_29_0._roleTf.anchoredPosition.y) / math.abs(arg_29_0._currentTargetPos.x - arg_29_0._roleTf.anchoredPosition.x))
				arg_29_0.removeRoleFlag = false

				arg_29_0:setRoleStatus(arg_29_1)
			elseif arg_29_0._currentTargetData.finish then
				arg_29_0:clear()
			end

			return
		end,
		checkShow = function(arg_30_0)
			if arg_30_0._active and not table.contains(var_0_27, var_0_18) then
				return
			end

			for iter_30_0 = #var_0_27, 1, -1 do
				if var_0_27[iter_30_0] == var_0_18 then
					table.remove(var_0_27, iter_30_0)
				end
			end

			arg_30_0._active = true
			arg_30_0._currentData = arg_30_0._roleShowStartData[math.random(1, #arg_30_0._roleShowStartData)]

			arg_30_0:setRoleNext(true)

			return
		end,
		clear = function(arg_31_0)
			arg_31_0._currentTargetData = nil
			arg_31_0._currentTargetPos = nil

			if not table.contains(var_0_27, var_0_18) then
				table.insert(var_0_27, var_0_18)
			end

			if isActive(arg_31_0._roleTf) then
				arg_31_0:setRoleAnimatorTrigger("hide")

				arg_31_0.removeRoleFlag = true

				setActive(arg_31_0._roleTf, false)
			end

			arg_31_0.showTime = math.random() * (var_0_30[2] - var_0_30[1]) + var_0_30[1]
			arg_31_0._active = false

			return
		end,
		destroy = function(arg_32_0)
			return
		end
	}
end

local var_0_34 = {
	"boot00",
	"boot01",
	"boot02"
}
local var_0_35 = {
	"game00",
	"game01",
	"game02"
}
local var_0_36 = {
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
local var_0_37 = {
	1,
	3
}

local function var_0_38(arg_33_0, arg_33_1)
	({
		ctor = function(arg_34_0)
			arg_34_0._tf = arg_33_0
			arg_34_0._event = arg_33_1
			arg_34_0.loadedFlag = false
			arg_34_0._tvTf = nil
			arg_34_0._active = false
			arg_34_0._tvAnimator = nil

			onButton(arg_34_0._event, findTF(arg_34_0._tf, "collider"), function()
				if arg_34_0.loadedFlag then
					return
				end

				arg_34_0._active = not arg_34_0._active

				arg_34_0:updateUI()

				return
			end, SFX_CANCEL)

			return
		end,
		start = function(arg_36_0)
			arg_36_0._active = true

			arg_36_0:updateUI()

			if not arg_36_0.loadedFlag then
				LoadAndInstantiateAsync(var_0_17, var_0_26, function(arg_37_0)
					if not arg_37_0 then
						print("tv资源加载失败")

						return
					end

					if arg_36_0.destroyFlag then
						Destroy(arg_37_0)

						return
					end

					arg_36_0.loadedFlag = true
					arg_36_0._tvTf = tf(arg_37_0)
					arg_36_0._tvAnimator = GetComponent(findTF(arg_36_0._tvTf, "anim"), typeof(Animator))

					GetComponent(findTF(arg_36_0._tvTf, "anim"), typeof(DftAniEvent)):SetEndEvent(function()
						arg_36_0:onTvComplete()

						return
					end)
					onButton(arg_36_0._event, findTF(arg_36_0._tvTf, "collider"), function()
						arg_36_0._active = not arg_36_0._active

						arg_36_0:updateUI()

						return
					end)
					setParent(arg_36_0._tvTf, findTF(arg_36_0._tf, "posTv"))
					arg_36_0:updateUI()
					arg_36_0:setTvData()

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

			local var_40_0 = Clone(var_0_36)
			local var_40_1 = Clone(var_0_34)
			local var_40_2 = Clone(var_0_35)

			for iter_40_0 = 1, math.random(var_0_37[1], var_0_37[2]) do
				table.insert(arg_40_0.playTvData, table.remove(var_40_0, math.random(1, #var_40_0)))
			end

			table.insert(arg_40_0.playTvData, table.remove(var_40_1, math.random(1, #var_40_1)))
			table.insert(arg_40_0.playTvData, table.remove(var_40_2, math.random(1, #var_40_2)))
			arg_40_0._tvAnimator:Play(arg_40_0.playTvData[arg_40_0.playIndex], -1, 0)

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

				arg_41_0._tvAnimator:Play(arg_41_0.playTvData[arg_41_0.playIndex], -1, 0)
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
			if arg_44_0.loadedFlag then
				setActive(findTF(arg_44_0._tf, "on"), false)
				setActive(findTF(arg_44_0._tf, "off"), false)

				arg_44_0.tvCanvas = arg_44_0.tvCanvas or GetComponent(findTF(arg_44_0._tvTf, "anim"), typeof(CanvasGroup))
				arg_44_0.tvCanvas.alpha = arg_44_0._active and 1 or 0
			else
				setActive(findTF(arg_44_0._tf, "on"), arg_44_0._active)
				setActive(findTF(arg_44_0._tf, "off"), not arg_44_0._active)
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
	}).ctor({
		ctor = function(arg_34_0)
			arg_34_0._tf = arg_33_0
			arg_34_0._event = arg_33_1
			arg_34_0.loadedFlag = false
			arg_34_0._tvTf = nil
			arg_34_0._active = false
			arg_34_0._tvAnimator = nil

			onButton(arg_34_0._event, findTF(arg_34_0._tf, "collider"), function()
				if arg_34_0.loadedFlag then
					return
				end

				arg_34_0._active = not arg_34_0._active

				arg_34_0:updateUI()

				return
			end, SFX_CANCEL)

			return
		end,
		start = function(arg_36_0)
			arg_36_0._active = true

			arg_36_0:updateUI()

			if not arg_36_0.loadedFlag then
				LoadAndInstantiateAsync(var_0_17, var_0_26, function(arg_37_0)
					if not arg_37_0 then
						print("tv资源加载失败")

						return
					end

					if arg_36_0.destroyFlag then
						Destroy(arg_37_0)

						return
					end

					arg_36_0.loadedFlag = true
					arg_36_0._tvTf = tf(arg_37_0)
					arg_36_0._tvAnimator = GetComponent(findTF(arg_36_0._tvTf, "anim"), typeof(Animator))

					GetComponent(findTF(arg_36_0._tvTf, "anim"), typeof(DftAniEvent)):SetEndEvent(function()
						arg_36_0:onTvComplete()

						return
					end)
					onButton(arg_36_0._event, findTF(arg_36_0._tvTf, "collider"), function()
						arg_36_0._active = not arg_36_0._active

						arg_36_0:updateUI()

						return
					end)
					setParent(arg_36_0._tvTf, findTF(arg_36_0._tf, "posTv"))
					arg_36_0:updateUI()
					arg_36_0:setTvData()

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

			local var_40_0 = Clone(var_0_36)
			local var_40_1 = Clone(var_0_34)
			local var_40_2 = Clone(var_0_35)

			for iter_40_0 = 1, math.random(var_0_37[1], var_0_37[2]) do
				table.insert(arg_40_0.playTvData, table.remove(var_40_0, math.random(1, #var_40_0)))
			end

			table.insert(arg_40_0.playTvData, table.remove(var_40_1, math.random(1, #var_40_1)))
			table.insert(arg_40_0.playTvData, table.remove(var_40_2, math.random(1, #var_40_2)))
			arg_40_0._tvAnimator:Play(arg_40_0.playTvData[arg_40_0.playIndex], -1, 0)

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

				arg_41_0._tvAnimator:Play(arg_41_0.playTvData[arg_41_0.playIndex], -1, 0)
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
			if arg_44_0.loadedFlag then
				setActive(findTF(arg_44_0._tf, "on"), false)
				setActive(findTF(arg_44_0._tf, "off"), false)

				arg_44_0.tvCanvas = arg_44_0.tvCanvas or GetComponent(findTF(arg_44_0._tvTf, "anim"), typeof(CanvasGroup))
				arg_44_0.tvCanvas.alpha = arg_44_0._active and 1 or 0
			else
				setActive(findTF(arg_44_0._tf, "on"), arg_44_0._active)
				setActive(findTF(arg_44_0._tf, "off"), not arg_44_0._active)
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
	})

	return {
		ctor = function(arg_34_0)
			arg_34_0._tf = arg_33_0
			arg_34_0._event = arg_33_1
			arg_34_0.loadedFlag = false
			arg_34_0._tvTf = nil
			arg_34_0._active = false
			arg_34_0._tvAnimator = nil

			onButton(arg_34_0._event, findTF(arg_34_0._tf, "collider"), function()
				if arg_34_0.loadedFlag then
					return
				end

				arg_34_0._active = not arg_34_0._active

				arg_34_0:updateUI()

				return
			end, SFX_CANCEL)

			return
		end,
		start = function(arg_36_0)
			arg_36_0._active = true

			arg_36_0:updateUI()

			if not arg_36_0.loadedFlag then
				LoadAndInstantiateAsync(var_0_17, var_0_26, function(arg_37_0)
					if not arg_37_0 then
						print("tv资源加载失败")

						return
					end

					if arg_36_0.destroyFlag then
						Destroy(arg_37_0)

						return
					end

					arg_36_0.loadedFlag = true
					arg_36_0._tvTf = tf(arg_37_0)
					arg_36_0._tvAnimator = GetComponent(findTF(arg_36_0._tvTf, "anim"), typeof(Animator))

					GetComponent(findTF(arg_36_0._tvTf, "anim"), typeof(DftAniEvent)):SetEndEvent(function()
						arg_36_0:onTvComplete()

						return
					end)
					onButton(arg_36_0._event, findTF(arg_36_0._tvTf, "collider"), function()
						arg_36_0._active = not arg_36_0._active

						arg_36_0:updateUI()

						return
					end)
					setParent(arg_36_0._tvTf, findTF(arg_36_0._tf, "posTv"))
					arg_36_0:updateUI()
					arg_36_0:setTvData()

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

			local var_40_0 = Clone(var_0_36)
			local var_40_1 = Clone(var_0_34)
			local var_40_2 = Clone(var_0_35)

			for iter_40_0 = 1, math.random(var_0_37[1], var_0_37[2]) do
				table.insert(arg_40_0.playTvData, table.remove(var_40_0, math.random(1, #var_40_0)))
			end

			table.insert(arg_40_0.playTvData, table.remove(var_40_1, math.random(1, #var_40_1)))
			table.insert(arg_40_0.playTvData, table.remove(var_40_2, math.random(1, #var_40_2)))
			arg_40_0._tvAnimator:Play(arg_40_0.playTvData[arg_40_0.playIndex], -1, 0)

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

				arg_41_0._tvAnimator:Play(arg_41_0.playTvData[arg_41_0.playIndex], -1, 0)
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
			if arg_44_0.loadedFlag then
				setActive(findTF(arg_44_0._tf, "on"), false)
				setActive(findTF(arg_44_0._tf, "off"), false)

				arg_44_0.tvCanvas = arg_44_0.tvCanvas or GetComponent(findTF(arg_44_0._tvTf, "anim"), typeof(CanvasGroup))
				arg_44_0.tvCanvas.alpha = arg_44_0._active and 1 or 0
			else
				setActive(findTF(arg_44_0._tf, "on"), arg_44_0._active)
				setActive(findTF(arg_44_0._tf, "off"), not arg_44_0._active)
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
end

function var_0_0.getUIName(arg_47_0)
	return "GameRoomHideSeekUI"
end

function var_0_0.getBGM(arg_48_0)
	return var_0_1
end

function var_0_0.didEnter(arg_49_0)
	arg_49_0:initEvent()
	arg_49_0:initData()
	arg_49_0:initUI()
	arg_49_0:initGameUI()
	arg_49_0:initController()
	arg_49_0:updateMenuUI()
	arg_49_0:openMenuUI()

	return
end

function var_0_0.initEvent(arg_50_0)
	arg_50_0.uiCam = arg_50_0.uiCam or GameObject.Find("UICamera"):GetComponent("Camera")

	arg_50_0:bind(var_0_12, function(arg_51_0, arg_51_1, arg_51_2)
		arg_50_0:addScore(arg_51_1.score)
		arg_50_0:showScore(arg_51_1)

		return
	end)

	return
end

function var_0_0.showScore(arg_52_0, arg_52_1)
	local var_52_0

	if #arg_52_0.showScoresPool > 0 then
		var_52_0 = table.remove(arg_52_0.showScoresPool, 1)
	else
		var_52_0 = tf(Instantiate(arg_52_0.showScoreTpl))

		setParent(var_52_0, arg_52_0.sceneFrontContainer)
		GetComponent(findTF(var_52_0, "anim"), typeof(DftAniEvent)):SetEndEvent(function()
			for iter_53_0 = #arg_52_0.showScores, 1, -1 do
				if var_52_0 == arg_52_0.showScores[iter_53_0] then
					table.insert(arg_52_0.showScoresPool, table.remove(arg_52_0.showScores, iter_53_0))
				end
			end

			return
		end)
	end

	setText(findTF(var_52_0, "anim"), "+" .. tostring(arg_52_1.score))

	var_52_0.anchoredPosition = arg_52_0.sceneFrontContainer:InverseTransformPoint((arg_52_0.uiCam:ScreenToWorldPoint(arg_52_1.pos)))

	setActive(var_52_0, false)
	setActive(var_52_0, true)
	table.insert(arg_52_0.showScores, var_52_0)

	return
end

function var_0_0.onEventHandle(arg_54_0, arg_54_1)
	return
end

function var_0_0.initData(arg_55_0)
	local var_55_0 = Application.targetFrameRate or 60

	if var_55_0 > 60 then
		var_55_0 = 60
	end

	arg_55_0.timer = Timer.New(function()
		arg_55_0:onTimer()

		return
	end, 1 / var_55_0, -1)
	arg_55_0.showScores = {}
	arg_55_0.showScoresPool = {}

	return
end

function var_0_0.initUI(arg_57_0)
	arg_57_0.backSceneTf = findTF(arg_57_0._tf, "scene_background")
	arg_57_0.sceneContainer = findTF(arg_57_0._tf, "sceneMask/sceneContainer")
	arg_57_0.sceneFrontContainer = findTF(arg_57_0._tf, "sceneMask/sceneContainer/scene_front")
	arg_57_0.clickMask = findTF(arg_57_0._tf, "clickMask")
	arg_57_0.bg = findTF(arg_57_0._tf, "bg")
	arg_57_0.countUI = findTF(arg_57_0._tf, "pop/CountUI")
	arg_57_0.countAnimator = GetComponent(findTF(arg_57_0.countUI, "count"), typeof(Animator))
	arg_57_0.countDft = GetOrAddComponent(findTF(arg_57_0.countUI, "count"), typeof(DftAniEvent))

	arg_57_0.countDft:SetTriggerEvent(function()
		return
	end)
	arg_57_0.countDft:SetEndEvent(function()
		setActive(arg_57_0.countUI, false)
		arg_57_0:gameStart()

		return
	end)

	arg_57_0.leaveUI = findTF(arg_57_0._tf, "pop/LeaveUI")

	onButton(arg_57_0, findTF(arg_57_0.leaveUI, "ad/btnOk"), function()
		arg_57_0:resumeGame()
		arg_57_0:onGameOver()

		return
	end, SFX_CANCEL)
	onButton(arg_57_0, findTF(arg_57_0.leaveUI, "ad/btnCancel"), function()
		arg_57_0:resumeGame()

		return
	end, SFX_CANCEL)

	arg_57_0.pauseUI = findTF(arg_57_0._tf, "pop/pauseUI")

	onButton(arg_57_0, findTF(arg_57_0.pauseUI, "ad/btnOk"), function()
		setActive(arg_57_0.pauseUI, false)
		arg_57_0:resumeGame()

		return
	end, SFX_CANCEL)

	arg_57_0.settlementUI = findTF(arg_57_0._tf, "pop/SettleMentUI")

	onButton(arg_57_0, findTF(arg_57_0.settlementUI, "ad/btnOver"), function()
		setActive(arg_57_0.settlementUI, false)
		arg_57_0:openMenuUI()

		return
	end, SFX_CANCEL)

	arg_57_0.menuUI = findTF(arg_57_0._tf, "pop/menuUI")
	arg_57_0.battleScrollRect = GetComponent(findTF(arg_57_0.menuUI, "battList"), typeof(ScrollRect))
	arg_57_0.totalTimes = arg_57_0:getGameTotalTime()

	scrollTo(arg_57_0.battleScrollRect, 0, 1 - (arg_57_0:getGameUsedTimes() - 4 < 0 and 0 or arg_57_0:getGameUsedTimes() - 4) / (arg_57_0.totalTimes - 4))
	onButton(arg_57_0, findTF(arg_57_0.menuUI, "rightPanelBg/arrowUp"), function()
		local var_64_0 = arg_57_0.battleScrollRect.normalizedPosition.y + 1 / (arg_57_0.totalTimes - 4)

		if arg_57_0.battleScrollRect.normalizedPosition.y + 1 / (arg_57_0.totalTimes - 4) > 1 then
			var_64_0 = 1
		end

		scrollTo(arg_57_0.battleScrollRect, 0, var_64_0)

		return
	end, SFX_CANCEL)
	onButton(arg_57_0, findTF(arg_57_0.menuUI, "rightPanelBg/arrowDown"), function()
		local var_65_0 = arg_57_0.battleScrollRect.normalizedPosition.y - 1 / (arg_57_0.totalTimes - 4)

		if arg_57_0.battleScrollRect.normalizedPosition.y - 1 / (arg_57_0.totalTimes - 4) < 0 then
			var_65_0 = 0
		end

		scrollTo(arg_57_0.battleScrollRect, 0, var_65_0)

		return
	end, SFX_CANCEL)
	onButton(arg_57_0, findTF(arg_57_0.menuUI, "btnBack"), function()
		arg_57_0:closeView()

		return
	end, SFX_CANCEL)
	onButton(arg_57_0, findTF(arg_57_0.menuUI, "btnRule"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = arg_57_0:getGameRoomData().game_help
		})

		return
	end, SFX_CANCEL)
	onButton(arg_57_0, findTF(arg_57_0.menuUI, "btnStart"), function()
		setActive(arg_57_0.menuUI, false)
		arg_57_0:readyStart()

		return
	end, SFX_CANCEL)

	local var_57_0 = findTF(arg_57_0.menuUI, "tplBattleItem")

	arg_57_0.battleItems = {}

	for iter_57_0 = 1, 7 do
		local var_57_1 = tf(instantiate(var_57_0))

		var_57_1.name = "battleItem_" .. iter_57_0

		setParent(var_57_1, findTF(arg_57_0.menuUI, "battList/Viewport/Content"))
		GetSpriteFromAtlasAsync("ui/minigameui/" .. var_0_4, "battleDesc" .. iter_57_0, function(arg_69_0)
			setImageSprite(findTF(var_57_1, "state_open/buttomDesc"), arg_69_0, true)
			setImageSprite(findTF(var_57_1, "state_clear/buttomDesc"), arg_69_0, true)
			setImageSprite(findTF(var_57_1, "state_current/buttomDesc"), arg_69_0, true)
			setImageSprite(findTF(var_57_1, "state_closed/buttomDesc"), arg_69_0, true)

			return
		end)
		setActive(var_57_1, true)
		table.insert(arg_57_0.battleItems, var_57_1)
	end

	if not arg_57_0.handle and IsUnityEditor then
		arg_57_0.handle = UpdateBeat:CreateListener(arg_57_0.Update, arg_57_0)

		UpdateBeat:AddListener(arg_57_0.handle)
	end

	return
end

function var_0_0.initGameUI(arg_70_0)
	arg_70_0.gameUI = findTF(arg_70_0._tf, "ui/gameUI")
	arg_70_0.showScoreTpl = findTF(arg_70_0.sceneFrontContainer, "score")

	setActive(arg_70_0.showScoreTpl, false)
	onButton(arg_70_0, findTF(arg_70_0.gameUI, "topRight/btnStop"), function()
		arg_70_0:stopGame()
		setActive(arg_70_0.pauseUI, true)

		return
	end)
	onButton(arg_70_0, findTF(arg_70_0.gameUI, "btnLeave"), function()
		arg_70_0:stopGame()
		setActive(arg_70_0.leaveUI, true)

		return
	end)

	arg_70_0.gameTimeS = findTF(arg_70_0.gameUI, "top/time/s")
	arg_70_0.scoreTf = findTF(arg_70_0.gameUI, "top/score")
	arg_70_0.sceneContainer.anchoredPosition = Vector2(0, 0)

	local var_70_0 = GetOrAddComponent(arg_70_0.sceneContainer, typeof(EventTriggerListener))
	local var_70_1
	local var_70_2

	arg_70_0.velocityXSmoothing = Vector2(0, 0)
	arg_70_0.offsetPosition = arg_70_0.sceneContainer.anchoredPosition

	var_70_0:AddBeginDragFunc(function(arg_73_0, arg_73_1)
		var_70_1 = arg_73_1.position
		var_70_2 = arg_70_0.sceneContainer.anchoredPosition
		arg_70_0.velocityXSmoothing = Vector2(0, 0)
		arg_70_0.offsetPosition = arg_70_0.sceneContainer.anchoredPosition

		return
	end)
	var_70_0:AddDragFunc(function(arg_74_0, arg_74_1)
		arg_70_0.offsetPosition.x = arg_74_1.position.x - var_70_1.x + var_70_2.x
		arg_70_0.offsetPosition.y = arg_74_1.position.y - var_70_1.y + var_70_2.y

		local var_74_0 = arg_70_0.offsetPosition

		if arg_70_0.offsetPosition.x > var_0_23[2] then
			var_74_0.x = var_0_23[2] or arg_70_0.offsetPosition.x

			local var_74_1 = arg_70_0.offsetPosition

			if arg_70_0.offsetPosition.x < var_0_23[1] then
				var_74_1.x = var_0_23[1] or arg_70_0.offsetPosition.x

				local var_74_2 = arg_70_0.offsetPosition

				if arg_70_0.offsetPosition.y > var_0_24[2] then
					var_74_2.y = var_0_24[2] or arg_70_0.offsetPosition.y

					local var_74_3 = arg_70_0.offsetPosition

					if arg_70_0.offsetPosition.y < var_0_24[1] then
						var_74_3.y = var_0_24[1] or arg_70_0.offsetPosition.y

						return
					end
				end
			end
		end
	end)
	var_70_0:AddDragEndFunc(function(arg_75_0, arg_75_1)
		return
	end)

	return
end

function var_0_0.initController(arg_76_0)
	arg_76_0.furnitureCtrl = var_0_28(findTF(arg_76_0.sceneContainer, "scene"), arg_76_0)
	arg_76_0.moveRoleCtrl = var_0_33(findTF(arg_76_0.sceneContainer, "scene"), arg_76_0)
	arg_76_0.tvCtrl = var_0_38(findTF(arg_76_0.sceneContainer, "scene/furniture_tv"), arg_76_0)

	return
end

function var_0_0.Update(arg_77_0)
	arg_77_0:AddDebugInput()

	return
end

function var_0_0.AddDebugInput(arg_78_0)
	if arg_78_0.gameStop or arg_78_0.settlementFlag then
		return
	end

	if IsUnityEditor and Input.GetKeyDown(KeyCode.S) then
		-- block empty
	end

	return
end

function var_0_0.updateMenuUI(arg_79_0)
	local var_79_0 = arg_79_0:getGameUsedTimes()
	local var_79_1 = arg_79_0:getGameTimes()

	for iter_79_0 = 1, #arg_79_0.battleItems do
		setActive(findTF(arg_79_0.battleItems[iter_79_0], "state_open"), false)
		setActive(findTF(arg_79_0.battleItems[iter_79_0], "state_closed"), false)
		setActive(findTF(arg_79_0.battleItems[iter_79_0], "state_clear"), false)
		setActive(findTF(arg_79_0.battleItems[iter_79_0], "state_current"), false)

		if iter_79_0 <= var_79_0 then
			setActive(findTF(arg_79_0.battleItems[iter_79_0], "state_clear"), true)
		elseif iter_79_0 == var_79_0 + 1 and var_79_1 >= 1 then
			setActive(findTF(arg_79_0.battleItems[iter_79_0], "state_current"), true)
		elseif var_79_0 < iter_79_0 and iter_79_0 <= var_79_0 + var_79_1 then
			setActive(findTF(arg_79_0.battleItems[iter_79_0], "state_open"), true)
		else
			setActive(findTF(arg_79_0.battleItems[iter_79_0], "state_closed"), true)
		end
	end

	arg_79_0.totalTimes = arg_79_0:getGameTotalTime()

	local var_79_2 = 1 - (arg_79_0:getGameUsedTimes() - 3 < 0 and 0 or arg_79_0:getGameUsedTimes() - 3) / (arg_79_0.totalTimes - 4)

	if var_79_2 > 1 then
		var_79_2 = 1
	end

	scrollTo(arg_79_0.battleScrollRect, 0, var_79_2)
	setActive(findTF(arg_79_0.menuUI, "btnStart/tip"), var_79_1 > 0)
	arg_79_0:CheckGet()

	return
end

function var_0_0.CheckGet(arg_80_0)
	setActive(findTF(arg_80_0.menuUI, "got"), false)

	if arg_80_0:getUltimate() and arg_80_0:getUltimate() ~= 0 then
		setActive(findTF(arg_80_0.menuUI, "got"), true)
	end

	if arg_80_0:getUltimate() == 0 then
		if arg_80_0:getGameTotalTime() > arg_80_0:getGameUsedTimes() then
			return
		end

		pg.m02:sendNotification(GAME.SEND_MINI_GAME_OP, {
			hubid = arg_80_0:GetMGHubData().id,
			cmd = MiniGameOPCommand.CMD_ULTIMATE,
			args1 = {}
		})
		setActive(findTF(arg_80_0.menuUI, "got"), true)
	end

	return
end

function var_0_0.openMenuUI(arg_81_0)
	setActive(findTF(arg_81_0.sceneContainer, "scene_front"), false)
	setActive(findTF(arg_81_0.sceneContainer, "scene_background"), false)
	setActive(findTF(arg_81_0.sceneContainer, "scene"), false)
	setActive(arg_81_0.gameUI, false)
	setActive(arg_81_0.menuUI, true)
	setActive(arg_81_0.bg, true)
	arg_81_0:openCoinLayer(true)
	arg_81_0:updateMenuUI()

	return
end

function var_0_0.clearUI(arg_82_0)
	setActive(arg_82_0.sceneContainer, false)
	setActive(arg_82_0.settlementUI, false)
	setActive(arg_82_0.countUI, false)
	setActive(arg_82_0.menuUI, false)
	setActive(arg_82_0.gameUI, false)

	return
end

function var_0_0.readyStart(arg_83_0)
	setActive(arg_83_0.countUI, true)
	arg_83_0.countAnimator:Play("count")
	pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_2)
	arg_83_0:openCoinLayer(false)

	return
end

function var_0_0.gameStart(arg_84_0)
	setActive(findTF(arg_84_0.sceneContainer, "scene_front"), true)
	setActive(findTF(arg_84_0.sceneContainer, "scene_background"), true)
	setActive(findTF(arg_84_0.sceneContainer, "scene"), true)
	setActive(arg_84_0.bg, false)

	arg_84_0.sceneContainer.anchoredPosition = var_0_25
	arg_84_0.offsetPosition = var_0_25

	setActive(arg_84_0.gameUI, true)

	arg_84_0.gameStartFlag = true
	arg_84_0.scoreNum = 0
	arg_84_0.nextPositionIndex = 2
	arg_84_0.gameStepTime = 0
	arg_84_0.heart = 3
	arg_84_0.gameTime = var_0_5

	for iter_84_0 = #arg_84_0.showScores, 1, -1 do
		if not table.contains(arg_84_0.showScoresPool, arg_84_0.showScores[iter_84_0]) then
			table.insert(arg_84_0.showScoresPool, (table.remove(arg_84_0.showScores, iter_84_0)))
		end
	end

	for iter_84_1 = #arg_84_0.showScoresPool, 1, -1 do
		setActive(arg_84_0.showScoresPool[iter_84_1], false)
	end

	arg_84_0:updateGameUI()
	arg_84_0:timerStart()
	arg_84_0:controllerStart()

	return
end

function var_0_0.controllerStart(arg_85_0)
	if arg_85_0.furnitureCtrl then
		arg_85_0.furnitureCtrl:start()
	end

	if arg_85_0.moveRoleCtrl then
		arg_85_0.moveRoleCtrl:start()
	end

	if arg_85_0.tvCtrl then
		arg_85_0.tvCtrl:start()
	end

	return
end

function var_0_0.getGameTimes(arg_86_0)
	return arg_86_0:GetMGHubData().count
end

function var_0_0.getGameUsedTimes(arg_87_0)
	return arg_87_0:GetMGHubData().usedtime
end

function var_0_0.getUltimate(arg_88_0)
	return arg_88_0:GetMGHubData().ultimate
end

function var_0_0.getGameTotalTime(arg_89_0)
	return (arg_89_0:GetMGHubData():getConfig("reward_need"))
end

function var_0_0.changeSpeed(arg_90_0, arg_90_1)
	return
end

function var_0_0.onTimer(arg_91_0)
	arg_91_0:gameStep()

	return
end

function var_0_0.gameStep(arg_92_0)
	arg_92_0.gameTime = arg_92_0.gameTime - Time.deltaTime

	if arg_92_0.gameTime < 0 then
		arg_92_0.gameTime = 0
	end

	arg_92_0.gameStepTime = arg_92_0.gameStepTime + Time.deltaTime

	arg_92_0:controllerStep()
	arg_92_0:updateGameUI()

	if arg_92_0.gameTime <= 0 then
		arg_92_0:onGameOver()

		return
	end

	return
end

function var_0_0.controllerStep(arg_93_0)
	if arg_93_0.furnitureCtrl then
		arg_93_0.furnitureCtrl:step()
	end

	if arg_93_0.moveRoleCtrl then
		arg_93_0.moveRoleCtrl:step()
	end

	if arg_93_0.tvCtrl then
		arg_93_0.tvCtrl:step()
	end

	return
end

function var_0_0.timerStart(arg_94_0)
	if not arg_94_0.timer.running then
		arg_94_0.timer:Start()
	end

	return
end

function var_0_0.timerStop(arg_95_0)
	if arg_95_0.timer.running then
		arg_95_0.timer:Stop()

		if arg_95_0.tvCtrl then
			arg_95_0.tvCtrl:pause()
		end
	end

	return
end

function var_0_0.updateGameUI(arg_96_0)
	setText(arg_96_0.scoreTf, arg_96_0.scoreNum)
	setText(arg_96_0.gameTimeS, math.ceil(arg_96_0.gameTime))

	arg_96_0.sceneContainer.anchoredPosition, arg_96_0.velocityXSmoothing = Vector2.SmoothDamp(arg_96_0.sceneContainer.anchoredPosition, arg_96_0.offsetPosition, arg_96_0.velocityXSmoothing, var_0_22)

	return
end

function var_0_0.addScore(arg_97_0, arg_97_1)
	arg_97_0.scoreNum = arg_97_0.scoreNum + arg_97_1

	if arg_97_0.scoreNum < 0 then
		arg_97_0.scoreNum = 0
	end

	return
end

function var_0_0.onGameOver(arg_98_0)
	if arg_98_0.settlementFlag then
		return
	end

	arg_98_0:timerStop()

	arg_98_0.settlementFlag = true

	setActive(arg_98_0.clickMask, true)
	LeanTween.delayedCall(go(arg_98_0._tf), 0.1, System.Action(function()
		arg_98_0.settlementFlag = false
		arg_98_0.gameStartFlag = false

		setActive(arg_98_0.clickMask, false)
		arg_98_0:showSettlement()

		return
	end))

	return
end

function var_0_0.showSettlement(arg_100_0)
	setActive(arg_100_0.settlementUI, true)
	GetComponent(findTF(arg_100_0.settlementUI, "ad"), typeof(Animator)):Play("settlement", -1, 0)

	local var_100_0 = arg_100_0.scoreNum
	local var_100_1 = getProxy(GameRoomProxy):getRoomScore(arg_100_0:getGameRoomData().id)

	setActive(findTF(arg_100_0.settlementUI, "ad/new"), var_100_1 < arg_100_0.scoreNum)

	if var_100_1 <= var_100_0 then
		var_100_1 = var_100_0

		arg_100_0:StoreDataToServer({
			var_100_0
		})
	end

	setText(findTF(arg_100_0.settlementUI, "ad/highText"), var_100_1)
	setText(findTF(arg_100_0.settlementUI, "ad/currentText"), var_100_0)

	arg_100_0.sendSuccessFlag = true

	arg_100_0:SendSuccess(var_100_0)

	return
end

function var_0_0.resumeGame(arg_101_0)
	arg_101_0.gameStop = false

	setActive(arg_101_0.leaveUI, false)
	arg_101_0:changeSpeed(1)
	arg_101_0:timerStart()

	return
end

function var_0_0.stopGame(arg_102_0)
	arg_102_0.gameStop = true

	arg_102_0:timerStop()
	arg_102_0:changeSpeed(0)

	return
end

function var_0_0.onBackPressed(arg_103_0)
	if not arg_103_0.gameStartFlag then
		arg_103_0:emit(var_0_0.ON_BACK_PRESSED)
	else
		if arg_103_0.settlementFlag then
			return
		end

		if isActive(arg_103_0.pauseUI) then
			setActive(arg_103_0.pauseUI, false)
		end

		arg_103_0:stopGame()
		setActive(arg_103_0.leaveUI, true)
	end

	return
end

function var_0_0.willExit(arg_104_0)
	if arg_104_0.handle then
		UpdateBeat:RemoveListener(arg_104_0.handle)
	end

	if arg_104_0._tf and LeanTween.isTweening(go(arg_104_0._tf)) then
		LeanTween.cancel(go(arg_104_0._tf))
	end

	arg_104_0:destroyController()

	if arg_104_0.timer and arg_104_0.timer.running then
		arg_104_0.timer:Stop()
	end

	Time.timeScale = 1
	arg_104_0.timer = nil

	return
end

function var_0_0.destroyController(arg_105_0)
	if arg_105_0.furnitureCtrl then
		arg_105_0.furnitureCtrl:destroy()
	end

	if arg_105_0.moveRoleCtrl then
		arg_105_0.moveRoleCtrl:destroy()
	end

	if arg_105_0.tvCtrl then
		arg_105_0.tvCtrl:destroy()
	end

	return
end

return var_0_0
