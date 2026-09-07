local GameRoomHideSeekView = class("GameRoomHideSeekView", import("..BaseMiniGameView"))
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
local var_0_21 = {
	name = "furniture_bath"
}
local var_0_22 = {}
local var_0_23 = {
	pos_name = "posBath"
}

var_0_23.anim_name = "HideSeekBath"
var_0_22[1] = var_0_23
var_0_21.pos_data_list = var_0_22
var_0_21.type = 1
var_0_20[1] = var_0_21
var_0_20[2] = {
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
var_0_20[3] = {
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
var_0_20[4] = {
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
var_0_20[5] = {
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
var_0_20[6] = {
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
var_0_20[7] = {
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
var_0_20[8] = {
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
var_0_20[9] = {
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
var_0_20[10] = {
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
var_0_20[11] = {
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
var_0_20[12] = {
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
var_0_20[13] = {
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
var_0_20[14] = {
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
var_0_20[15] = {
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
var_0_20[16] = {
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

local var_0_24 = {
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
local var_0_25 = 0.1
local var_0_26 = {
	-475,
	652
}
local var_0_27 = {
	-335,
	290
}
local var_0_28 = Vector2(150, -200)
local var_0_29 = "hideseektv"
local var_0_30 = {}

local function var_0_31(arg_1_0, arg_1_1)
	local var_1_0 = {
		ctor = function(self)
			self._event = arg_1_1
			self._sceneTf = arg_1_0
			self._tplContainer = findTF(arg_1_0, "tplPos")
			var_0_30 = Clone(var_0_19)
			self._furnituresPools = {}

			for iter_2_0 = 1, #var_0_20 do
				table.insert(self._furnituresPools, {
					activeIndex = 0,
					data = Clone(var_0_20[iter_2_0]),
					tf = findTF(self._sceneTf, var_0_20[iter_2_0].name)
				})
			end

			self._unActiveFurnitures = {}
			self._activeFurnitures = {}
			self._furnitureAnimTfPool = {}
			self._animTplDic = {}

			return
		end,
		start = function(self)
			self.timeStep = 0

			self:clear()

			self.timeAppear = 0
			self.additiveScore = var_0_7

			for iter_3_0 = #self._furnituresPools, 1, -1 do
				if self._furnituresPools[iter_3_0].data.type == var_0_14 then
					if math.random() <= self._furnituresPools[iter_3_0].data.weight then
						self:appearChar(self._furnituresPools[iter_3_0].data.name)
					end

					self._furnituresPools[iter_3_0].initFlag = true

					table.insert(self._unActiveFurnitures, self:getFunitureFromPool(self._furnituresPools[iter_3_0].data.name))
				elseif self._furnituresPools[iter_3_0].data.type == var_0_15 then
					self:appearChar(self._furnituresPools[iter_3_0].data.name)
				end
			end

			return
		end,
		step = function(self)
			self.timeStep = self.timeStep + Time.deltaTime

			local var_4_0 = false

			if self.timeAppear <= 0 then
				var_4_0 = true
				self.timeAppear = nil

				for iter_4_0 = 1, #var_0_6 do
					if not self.timeAppear and var_0_5 - self.timeStep < var_0_6[iter_4_0][1] or iter_4_0 == #var_0_6 then
						self.timeAppear = math.random() * (var_0_6[iter_4_0][3] - var_0_6[iter_4_0][2]) + var_0_6[iter_4_0][2]

						break
					end
				end

				self.timeAppear = not self.timeAppear and 2 or self.timeAppear
			else
				self.timeAppear = self.timeAppear - Time.deltaTime
			end

			for iter_4_1 = #self._activeFurnitures, 1, -1 do
				if self._activeFurnitures[iter_4_1].time then
					self._activeFurnitures[iter_4_1].time = self._activeFurnitures[iter_4_1].time - Time.deltaTime

					if self._activeFurnitures[iter_4_1].time <= 0 then
						self:setFurnitureTimeEvent(self._activeFurnitures[iter_4_1])
					end
				end
			end

			if var_4_0 then
				self:appearChar()
			end

			return
		end,
		setFurnitureTimeEvent = function(self, arg_5_1)
			if arg_5_1.data.type == var_0_15 then
				self:returnCharIndex(arg_5_1.charIndex)

				arg_5_1.charIndex = math.random() <= arg_5_1.data.weight and #var_0_30 > 0 and table.remove(var_0_30, math.random(1, #var_0_30)) or arg_5_1.data.defaut_char_index
				arg_5_1.readyToRemove = false
				arg_5_1.time = arg_5_1.data.time

				GetComponent(findTF(arg_5_1.animTf, "anim"), typeof(Animator)):SetInteger("charIndex", arg_5_1.charIndex)
			elseif arg_5_1.data.type == var_0_13 then
				if arg_5_1.data.hide and not arg_5_1.readyToRemove then
					arg_5_1.time = 2
					arg_5_1.readyToRemove = true

					GetComponent(findTF(arg_5_1.animTf, "anim"), typeof(Animator)):SetTrigger("hide")
				else
					self:returnFurniture(arg_5_1)
				end
			elseif arg_5_1.data.type == var_0_14 then
				if arg_5_1.charIndex then
					self:returnCharIndex(arg_5_1.charIndex)

					if arg_5_1.animTf then
						setActive(findTF(arg_5_1.animTf, "collider"), false)
					end

					arg_5_1.charIndex = nil
					arg_5_1.time = nil
				end
			else
				self:returnFurniture(arg_5_1)
			end

			return
		end,
		returnCharIndex = function(arg_6_0, arg_6_1)
			if not table.contains(var_0_30, arg_6_1) and table.contains(var_0_19, arg_6_1) then
				table.insert(var_0_30, arg_6_1)
			end

			return
		end,
		appearChar = function(self, arg_7_1)
			if #var_0_30 <= 0 then
				return
			end

			if #self._furnituresPools <= 0 then
				return
			end

			local var_7_0

			if arg_7_1 then
				var_7_0 = self:getFunitureFromPool(arg_7_1)
			end

			var_7_0 = var_7_0 or table.remove(self._furnituresPools, math.random(1, #self._furnituresPools))

			local var_7_1 = var_7_0.data.pos_data_list[math.random(1, #var_7_0.data.pos_data_list)]
			local var_7_2 = var_7_1.pos_name
			local var_7_3 = var_7_1.anim_name
			local var_7_4 = self:getActiveIndex()
			local var_7_5 = var_0_24[var_7_1.anim_name]

			if not var_0_24[var_7_1.anim_name] then
				print("警告，没有找到" .. var_7_1.anim_name .. "的动画数据")
				self:returnFurniture(var_7_0)

				return
			end

			local var_7_6 = var_7_0.data.type == var_0_15 and var_7_0.data.defaut_char_index or table.remove(var_0_30, math.random(1, #var_0_30))

			var_7_0.charIndex = var_7_6

			if table.contains(var_7_5.ignore_char, var_7_6) then
				self:returnFurniture(var_7_0)

				return
			elseif var_7_0.data.type == var_0_14 and var_7_0.initFlag then
				self:returnFurniture(var_7_0)

				return
			end

			var_7_0.posData = var_7_1
			var_7_0.activeIndex = var_7_4
			var_7_0.animData = var_7_5

			table.insert(self._activeFurnitures, var_7_0)
			self:getAnimTfByPosData(var_7_1, var_7_4, function(arg_8_0, arg_8_1)
				if arg_8_1 ~= var_7_0.activeIndex then
					self:returnAnimTf(var_7_3, arg_8_0)

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

				self:prepareAnim(var_7_0)

				return
			end)

			return
		end,
		getFunitureFromPool = function(self, arg_9_1)
			for iter_9_0 = 1, #self._furnituresPools do
				if self._furnituresPools[iter_9_0].data.name == arg_9_1 then
					return table.remove(self._furnituresPools, iter_9_0)
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

				if not (arg_10_1.data.type == var_0_15 and arg_10_1.data.defaut_char_index == arg_10_1.charIndex) then
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
		getScore = function(self)
			self.additiveScore = self.additiveScore or var_0_7
			self.additiveScore = self.scoreTime and self.timeStep - self.scoreTime < var_0_8 and self.additiveScore + var_0_9 or var_0_7

			if self.additiveScore >= var_0_10 then
				self.additiveScore = var_0_10
			end

			self.scoreTime = self.timeStep

			return self.additiveScore
		end,
		getAnimTfByPosData = function(self, arg_13_1, arg_13_2, arg_13_3)
			if self._furnitureAnimTfPool and self._furnitureAnimTfPool[arg_13_1.anim_name] and #self._furnitureAnimTfPool[arg_13_1.anim_name] > 0 then
				arg_13_3(table.remove(self._furnitureAnimTfPool[arg_13_1.anim_name], 1), arg_13_2)

				return
			end

			return self:createAnimTf(arg_13_1.anim_name, arg_13_2, arg_13_3)
		end,
		returnFurniture = function(self, arg_14_1)
			if not arg_14_1 then
				return
			end

			if arg_14_1.charIndex then
				self:returnCharIndex(arg_14_1.charIndex)

				arg_14_1.charIndex = nil
			end

			if arg_14_1.animData and arg_14_1.animTf then
				self:returnAnimTf(arg_14_1.animData.name, arg_14_1.animTf)
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

			for iter_14_1 = #self._activeFurnitures, 1, -1 do
				if self._activeFurnitures[iter_14_1] == arg_14_1 then
					table.insert(self._furnituresPools, table.remove(self._activeFurnitures, iter_14_1))
				end
			end

			for iter_14_2 = #self._unActiveFurnitures, 1, -1 do
				if self._unActiveFurnitures[iter_14_2] == arg_14_1 then
					table.insert(self._furnituresPools, table.remove(self._unActiveFurnitures, iter_14_2))
				end
			end

			local var_14_0 = false

			for iter_14_3 = 1, #self._furnituresPools do
				if self._furnituresPools[iter_14_3] == arg_14_1 then
					var_14_0 = true
				end
			end

			if not var_14_0 then
				table.insert(self._furnituresPools, arg_14_1)
			end

			return
		end,
		returnAnimTf = function(self, arg_15_1, arg_15_2)
			self._furnitureAnimTfPool[arg_15_1] = self._furnitureAnimTfPool[arg_15_1] or {}

			setActive(arg_15_2, false)
			table.insert(self._furnitureAnimTfPool[arg_15_1], arg_15_2)

			return
		end,
		createAnimTf = function(self, arg_16_1, arg_16_2, arg_16_3)
			if not var_0_24[arg_16_1] then
				return nil
			end

			local var_16_0 = var_0_24[arg_16_1].prefab
			local var_16_1 = var_0_24[arg_16_1].name

			if self._animTplDic[var_0_24[arg_16_1].name] then
				arg_16_3(tf(Instantiate(self._animTplDic[var_0_24[arg_16_1].name])), arg_16_2)
			else
				LoadAndInstantiateAsync(var_0_17, var_16_0, function(arg_17_0)
					if not arg_17_0 then
						print("找不到资源" .. var_16_1)

						return
					end

					if self.destroyFlag then
						Destroy(arg_17_0)

						return
					end

					self._animTplDic[var_16_1] = arg_17_0

					SetParent(tf(arg_17_0), self._tplContainer)
					arg_16_3(tf(Instantiate(self._animTplDic[var_16_1])), arg_16_2)

					return
				end)
			end

			return
		end,
		getActiveIndex = function(self)
			self._activeIndex = self._activeIndex or 0
			self._activeIndex = self._activeIndex + 1

			return self._activeIndex
		end,
		clear = function(self)
			for iter_19_0 = #self._activeFurnitures, 1, -1 do
				self:returnFurniture(self._activeFurnitures[iter_19_0])
			end

			for iter_19_1 = #self._unActiveFurnitures, 1, -1 do
				self:returnFurniture(self._unActiveFurnitures[iter_19_1])
			end

			for iter_19_2 = 1, #self._furnituresPools do
				if self._furnituresPools[iter_19_2].data.type == var_0_14 then
					self._furnituresPools[iter_19_2].initFlag = false
				end
			end

			self._activeFurnitures = {}
			var_0_30 = Clone(var_0_19)

			return
		end,
		destroy = function(self)
			self:clear()

			for iter_20_0 = 1, #self._furnitureAnimTfPool do
				if self._furnitureAnimTfPool[iter_20_0].animTf then
					ClearEventTrigger((GetOrAddComponent(findTF(self._furnitureAnimTfPool[iter_20_0].animTf, "collider"), typeof(EventTriggerListener))))
				end
			end

			self.destroyFlag = true

			return
		end
	}

	var_1_0:ctor()

	return var_1_0
end

local var_0_32 = {
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
local var_0_33 = {
	5,
	10
}
local var_0_34 = 300

local function var_0_36(arg_21_0, arg_21_1)
	local var_21_0 = {
		ctor = function(self)
			self._tf = arg_21_0
			self._event = arg_21_1
			self._roleTf = findTF(self._tf, "fushun")
			self._roleAnimator = GetComponent(findTF(self._roleTf, "img/anim"), typeof(Animator))
			self._dftEvent = GetComponent(findTF(self._roleTf, "img/anim"), typeof(DftAniEvent))

			self._dftEvent:SetEndEvent(function(arg_23_0)
				setActive(self._roleTf, false)
				self:clear()

				return
			end)

			self._eventTrigger = GetOrAddComponent(findTF(self._roleTf, "img/collider"), typeof(EventTriggerListener))

			self._eventTrigger:AddPointDownFunc(function(arg_24_0, arg_24_1, arg_24_2)
				if self.removeRoleFlag then
					return
				end

				pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_3)
				self._event:emit(var_0_12, {
					score = var_0_11,
					pos = arg_24_1.position
				})

				self.removeRoleFlag = true

				self:setRoleAnimatorTrigger("touch")

				return
			end)

			self._roleShowData = {}
			self._roleShowStartData = {}

			for iter_22_0 = 1, #var_0_32 do
				if var_0_32[iter_22_0].start then
					table.insert(self._roleShowStartData, Clone(var_0_32[iter_22_0]))
				end

				local var_22_0 = Clone(var_0_32[iter_22_0])

				self._roleShowData[var_22_0.name] = var_22_0
			end

			self._active = false
			self._targetPos = Vector2(0, 0)
			self._currentTargetData = nil
			self._currentTargetPos = nil

			return
		end,
		setRoleAnimatorTrigger = function(self, arg_25_1, arg_25_2)
			if not arg_25_2 then
				self._roleAnimator:SetTrigger(arg_25_1)
			else
				self._roleAnimator:ResetTrigger(arg_25_1)
			end

			return
		end,
		start = function(self)
			self.showTime = math.random() * (var_0_33[2] - var_0_33[1]) + var_0_33[1]

			self:clear()

			return
		end,
		step = function(self)
			if self.showTime > 0 then
				self.showTime = self.showTime - Time.deltaTime

				if self.showTime <= 0 then
					self.showTime = 0

					self:checkShow()
				end
			end

			if self._currentTargetData and not self.removeRoleFlag then
				local var_27_0 = self._roleTf.anchoredPosition
				local var_27_1 = var_0_34 * math.cos(self._moveAngle) * Time.deltaTime
				local var_27_2 = var_0_34 * math.sin(self._moveAngle) * Time.deltaTime

				if self._roleDirectX == 1 and self._roleDirectX * var_27_1 + var_27_0.x > self._currentTargetPos.x then
					var_27_0.x = var_27_0.x + self._roleDirectX * var_27_1
					self._roleDirectX = nil
				elseif self._roleDirectX == -1 and self._roleDirectX * var_27_1 + var_27_0.x < self._currentTargetPos.x then
					var_27_0.x = var_27_0.x + self._roleDirectX * var_27_1
					self._roleDirectX = nil
				elseif self._roleDirectX then
					var_27_0.x = var_27_0.x + self._roleDirectX * var_27_1
				end

				if self._roleDirectY == 1 and self._roleDirectY * var_27_2 + var_27_0.y > self._currentTargetPos.y then
					var_27_0.y = var_27_0.y + self._roleDirectY * var_27_2
					self._roleDirectY = nil
				elseif self._roleDirectY == -1 and self._roleDirectY * var_27_2 + var_27_0.y < self._currentTargetPos.y then
					var_27_0.y = var_27_0.y + self._roleDirectY * var_27_2
					self._roleDirectY = nil
				elseif self._roleDirectY then
					var_27_0.y = var_27_0.y + self._roleDirectY * var_27_2
				end

				self._roleTf.anchoredPosition = var_27_0

				if self._roleDirectX == nil and self._roleDirectY == nil then
					self:setRoleNext()
				end
			end

			return
		end,
		setRoleStatus = function(self, arg_28_1)
			setActive(self._roleTf, true)

			if arg_28_1 then
				self:setRoleAnimatorTrigger("change", true)
				self:setRoleAnimatorTrigger("hide", true)
				self:setRoleAnimatorTrigger("show")
			else
				self:setRoleAnimatorTrigger("change")
			end

			self._roleAnimator:SetInteger("directX", self._roleDirectX)
			self._roleAnimator:SetInteger("directY", self._roleDirectY)

			return
		end,
		setRoleNext = function(self, arg_29_1)
			if arg_29_1 or not self._currentTargetData.finish then
				local var_29_0

				if not arg_29_1 then
					var_29_0 = self._currentData.name
					var_29_0 = self._currentData.name
					self._currentData = self._currentTargetData
				end

				local var_29_1 = Clone(self._currentData.next)

				if var_29_0 then
					for iter_29_0 = #var_29_1, 1, -1 do
						if var_29_1[iter_29_0] == var_29_0 then
							table.remove(var_29_1, iter_29_0)
						end
					end
				end

				if #var_29_1 == 0 then
					self:clear()

					return
				end

				self._currentTargetData = self._roleShowData[var_29_1[math.random(1, #var_29_1)]]

				local var_29_2 = findTF(self._tf, self._currentData.name)

				if self._currentTargetData and self._currentTargetData.switch_parent then
					setParent(self._roleTf, (findTF(self._tf, self._currentTargetData.name)))
				else
					setParent(self._roleTf, var_29_2)
				end

				self._roleTf.anchoredPosition = findTF(var_29_2, "rolePos").anchoredPosition
				self._currentTargetPos = findTF(self._tf, self._currentTargetData.name .. "/rolePos").anchoredPosition
				self._roleDirectX = self._currentTargetPos.x > self._roleTf.anchoredPosition.x and 1 or -1
				self._roleDirectY = self._currentTargetPos.y > self._roleTf.anchoredPosition.y and 1 or -1
				self._moveAngle = math.atan(math.abs(self._currentTargetPos.y - self._roleTf.anchoredPosition.y) / math.abs(self._currentTargetPos.x - self._roleTf.anchoredPosition.x))
				self.removeRoleFlag = false

				self:setRoleStatus(arg_29_1)
			elseif self._currentTargetData.finish then
				self:clear()
			end

			return
		end,
		checkShow = function(self)
			if self._active and not table.contains(var_0_30, var_0_18) then
				return
			end

			for iter_30_0 = #var_0_30, 1, -1 do
				if var_0_30[iter_30_0] == var_0_18 then
					table.remove(var_0_30, iter_30_0)
				end
			end

			self._active = true
			self._currentData = self._roleShowStartData[math.random(1, #self._roleShowStartData)]

			self:setRoleNext(true)

			return
		end,
		clear = function(self)
			self._currentTargetData = nil
			self._currentTargetPos = nil

			if not table.contains(var_0_30, var_0_18) then
				table.insert(var_0_30, var_0_18)
			end

			if isActive(self._roleTf) then
				self:setRoleAnimatorTrigger("hide")

				self.removeRoleFlag = true

				setActive(self._roleTf, false)
			end

			self.showTime = math.random() * (var_0_33[2] - var_0_33[1]) + var_0_33[1]
			self._active = false

			return
		end,
		destroy = function(arg_32_0)
			return
		end
	}

	var_21_0:ctor()

	return var_21_0
end

local var_0_37 = {
	"boot00",
	"boot01",
	"boot02"
}
local var_0_38 = {
	"game00",
	"game01",
	"game02"
}
local var_0_39 = {
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
local var_0_40 = {
	1,
	3
}

local function var_0_41(arg_33_0, arg_33_1)
	local var_33_0 = {
		ctor = function(self)
			self._tf = arg_33_0
			self._event = arg_33_1
			self.loadedFlag = false
			self._tvTf = nil
			self._active = false
			self._tvAnimator = nil

			onButton(self._event, findTF(self._tf, "collider"), function()
				if self.loadedFlag then
					return
				end

				self._active = not self._active

				self:updateUI()

				return
			end, SFX_CANCEL)

			return
		end,
		start = function(self)
			self._active = true

			self:updateUI()

			if not self.loadedFlag then
				LoadAndInstantiateAsync(var_0_17, var_0_29, function(arg_37_0)
					if not arg_37_0 then
						print("tv资源加载失败")

						return
					end

					if self.destroyFlag then
						Destroy(arg_37_0)

						return
					end

					self.loadedFlag = true
					self._tvTf = tf(arg_37_0)
					self._tvAnimator = GetComponent(findTF(self._tvTf, "anim"), typeof(Animator))

					GetComponent(findTF(self._tvTf, "anim"), typeof(DftAniEvent)):SetEndEvent(function()
						self:onTvComplete()

						return
					end)
					onButton(self._event, findTF(self._tvTf, "collider"), function()
						self._active = not self._active

						self:updateUI()

						return
					end)
					setParent(self._tvTf, findTF(self._tf, "posTv"))
					self:updateUI()
					self:setTvData()

					return
				end)
			else
				self:setTvData()
			end

			return
		end,
		setTvData = function(self)
			self.playIndex = 1
			self.playTvData = {}

			local var_40_0 = Clone(var_0_39)
			local var_40_1 = Clone(var_0_37)
			local var_40_2 = Clone(var_0_38)

			for iter_40_0 = 1, math.random(var_0_40[1], var_0_40[2]) do
				table.insert(self.playTvData, table.remove(var_40_0, math.random(1, #var_40_0)))
			end

			table.insert(self.playTvData, table.remove(var_40_1, math.random(1, #var_40_1)))
			table.insert(self.playTvData, table.remove(var_40_2, math.random(1, #var_40_2)))
			self._tvAnimator:Play(self.playTvData[self.playIndex], -1, 0)

			return
		end,
		onTvComplete = function(self)
			if not self.playIndex and not self.playTvData and #self.playTvData == 0 then
				return
			end

			if self._tvAnimator then
				self.playIndex = self.playIndex + 1

				if self.playIndex > #self.playTvData then
					self.playIndex = #self.playTvData
				end

				self._tvAnimator:Play(self.playTvData[self.playIndex], -1, 0)
			end

			return
		end,
		step = function(self)
			if self._tvAnimator and self._tvAnimator.speed == 0 then
				self._tvAnimator.speed = 1
			end

			return
		end,
		pause = function(self)
			if self._tvAnimator then
				self._tvAnimator.speed = 0
			end

			return
		end,
		updateUI = function(self)
			if self.loadedFlag then
				setActive(findTF(self._tf, "on"), false)
				setActive(findTF(self._tf, "off"), false)

				self.tvCanvas = self.tvCanvas or GetComponent(findTF(self._tvTf, "anim"), typeof(CanvasGroup))
				self.tvCanvas.alpha = self._active and 1 or 0
			else
				setActive(findTF(self._tf, "on"), self._active)
				setActive(findTF(self._tf, "off"), not self._active)
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

	var_33_0:ctor()

	return var_33_0
end

function GameRoomHideSeekView:getUIName()
	return "GameRoomHideSeekUI"
end

function GameRoomHideSeekView:getBGM()
	return var_0_1
end

function GameRoomHideSeekView:didEnter()
	self:initEvent()
	self:initData()
	self:initUI()
	self:initGameUI()
	self:initController()
	self:updateMenuUI()
	self:openMenuUI()

	return
end

function GameRoomHideSeekView:initEvent()
	self.uiCam = self.uiCam or GameObject.Find("UICamera"):GetComponent("Camera")

	self:bind(var_0_12, function(arg_51_0, arg_51_1, arg_51_2)
		self:addScore(arg_51_1.score)
		self:showScore(arg_51_1)

		return
	end)

	return
end

function GameRoomHideSeekView:showScore(arg_52_1)
	local var_52_0

	if #self.showScoresPool > 0 then
		var_52_0 = table.remove(self.showScoresPool, 1)
	else
		var_52_0 = tf(Instantiate(self.showScoreTpl))

		setParent(var_52_0, self.sceneFrontContainer)
		GetComponent(findTF(var_52_0, "anim"), typeof(DftAniEvent)):SetEndEvent(function()
			for iter_53_0 = #self.showScores, 1, -1 do
				if var_52_0 == self.showScores[iter_53_0] then
					table.insert(self.showScoresPool, table.remove(self.showScores, iter_53_0))
				end
			end

			return
		end)
	end

	setText(findTF(var_52_0, "anim"), "+" .. tostring(arg_52_1.score))

	var_52_0.anchoredPosition = self.sceneFrontContainer:InverseTransformPoint((self.uiCam:ScreenToWorldPoint(arg_52_1.pos)))

	setActive(var_52_0, false)
	setActive(var_52_0, true)
	table.insert(self.showScores, var_52_0)

	return
end

function GameRoomHideSeekView:onEventHandle(arg_54_1)
	return
end

function GameRoomHideSeekView:initData()
	local var_55_0 = Application.targetFrameRate or 60

	if var_55_0 > 60 then
		var_55_0 = 60
	end

	self.timer = Timer.New(function()
		self:onTimer()

		return
	end, 1 / var_55_0, -1)
	self.showScores = {}
	self.showScoresPool = {}

	return
end

function GameRoomHideSeekView:initUI()
	self.backSceneTf = findTF(self._tf, "scene_background")
	self.sceneContainer = findTF(self._tf, "sceneMask/sceneContainer")
	self.sceneFrontContainer = findTF(self._tf, "sceneMask/sceneContainer/scene_front")
	self.clickMask = findTF(self._tf, "clickMask")
	self.bg = findTF(self._tf, "bg")
	self.countUI = findTF(self._tf, "pop/CountUI")
	self.countAnimator = GetComponent(findTF(self.countUI, "count"), typeof(Animator))
	self.countDft = GetOrAddComponent(findTF(self.countUI, "count"), typeof(DftAniEvent))

	self.countDft:SetTriggerEvent(function()
		return
	end)
	self.countDft:SetEndEvent(function()
		setActive(self.countUI, false)
		self:gameStart()

		return
	end)

	self.leaveUI = findTF(self._tf, "pop/LeaveUI")

	onButton(self, findTF(self.leaveUI, "ad/btnOk"), function()
		self:resumeGame()
		self:onGameOver()

		return
	end, SFX_CANCEL)
	onButton(self, findTF(self.leaveUI, "ad/btnCancel"), function()
		self:resumeGame()

		return
	end, SFX_CANCEL)

	self.pauseUI = findTF(self._tf, "pop/pauseUI")

	onButton(self, findTF(self.pauseUI, "ad/btnOk"), function()
		setActive(self.pauseUI, false)
		self:resumeGame()

		return
	end, SFX_CANCEL)

	self.settlementUI = findTF(self._tf, "pop/SettleMentUI")

	onButton(self, findTF(self.settlementUI, "ad/btnOver"), function()
		setActive(self.settlementUI, false)
		self:openMenuUI()

		return
	end, SFX_CANCEL)

	self.menuUI = findTF(self._tf, "pop/menuUI")
	self.battleScrollRect = GetComponent(findTF(self.menuUI, "battList"), typeof(ScrollRect))
	self.totalTimes = self:getGameTotalTime()

	scrollTo(self.battleScrollRect, 0, 1 - (self:getGameUsedTimes() - 4 < 0 and 0 or self:getGameUsedTimes() - 4) / (self.totalTimes - 4))
	onButton(self, findTF(self.menuUI, "rightPanelBg/arrowUp"), function()
		scrollTo(self.battleScrollRect, 0, (self.battleScrollRect.normalizedPosition.y + 1 / (self.totalTimes - 4) > 1 or nil) and 1)

		return
	end, SFX_CANCEL)
	onButton(self, findTF(self.menuUI, "rightPanelBg/arrowDown"), function()
		scrollTo(self.battleScrollRect, 0, (self.battleScrollRect.normalizedPosition.y - 1 / (self.totalTimes - 4) < 0 or nil) and 0)

		return
	end, SFX_CANCEL)
	onButton(self, findTF(self.menuUI, "btnBack"), function()
		self:closeView()

		return
	end, SFX_CANCEL)
	onButton(self, findTF(self.menuUI, "btnRule"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = self:getGameRoomData().game_help
		})

		return
	end, SFX_CANCEL)
	onButton(self, findTF(self.menuUI, "btnStart"), function()
		setActive(self.menuUI, false)
		self:readyStart()

		return
	end, SFX_CANCEL)

	local var_57_0 = findTF(self.menuUI, "tplBattleItem")

	self.battleItems = {}

	for iter_57_0 = 1, 7 do
		local var_57_1 = tf(instantiate(var_57_0))

		var_57_1.name = "battleItem_" .. iter_57_0

		setParent(var_57_1, findTF(self.menuUI, "battList/Viewport/Content"))
		GetSpriteFromAtlasAsync("ui/minigameui/" .. var_0_4, "battleDesc" .. iter_57_0, function(arg_69_0)
			setImageSprite(findTF(var_57_1, "state_open/buttomDesc"), arg_69_0, true)
			setImageSprite(findTF(var_57_1, "state_clear/buttomDesc"), arg_69_0, true)
			setImageSprite(findTF(var_57_1, "state_current/buttomDesc"), arg_69_0, true)
			setImageSprite(findTF(var_57_1, "state_closed/buttomDesc"), arg_69_0, true)

			return
		end)
		setActive(var_57_1, true)
		table.insert(self.battleItems, var_57_1)
	end

	if not self.handle and IsUnityEditor then
		self.handle = UpdateBeat:CreateListener(self.Update, self)

		UpdateBeat:AddListener(self.handle)
	end

	return
end

function GameRoomHideSeekView:initGameUI()
	self.gameUI = findTF(self._tf, "ui/gameUI")
	self.showScoreTpl = findTF(self.sceneFrontContainer, "score")

	setActive(self.showScoreTpl, false)
	onButton(self, findTF(self.gameUI, "topRight/btnStop"), function()
		self:stopGame()
		setActive(self.pauseUI, true)

		return
	end)
	onButton(self, findTF(self.gameUI, "btnLeave"), function()
		self:stopGame()
		setActive(self.leaveUI, true)

		return
	end)

	self.gameTimeS = findTF(self.gameUI, "top/time/s")
	self.scoreTf = findTF(self.gameUI, "top/score")
	self.sceneContainer.anchoredPosition = Vector2(0, 0)

	local var_70_0 = GetOrAddComponent(self.sceneContainer, typeof(EventTriggerListener))
	local var_70_1
	local var_70_2

	self.velocityXSmoothing = Vector2(0, 0)
	self.offsetPosition = self.sceneContainer.anchoredPosition

	var_70_0:AddBeginDragFunc(function(arg_73_0, arg_73_1)
		var_70_1 = arg_73_1.position
		var_70_2 = self.sceneContainer.anchoredPosition
		self.velocityXSmoothing = Vector2(0, 0)
		self.offsetPosition = self.sceneContainer.anchoredPosition

		return
	end)
	var_70_0:AddDragFunc(function(arg_74_0, arg_74_1)
		self.offsetPosition.x = arg_74_1.position.x - var_70_1.x + var_70_2.x
		self.offsetPosition.y = arg_74_1.position.y - var_70_1.y + var_70_2.y

		if self.offsetPosition.x > var_0_26[2] then
			self.offsetPosition.x = var_0_26[2] or self.offsetPosition.x
		end

		if self.offsetPosition.x < var_0_26[1] then
			self.offsetPosition.x = var_0_26[1] or self.offsetPosition.x
		end

		if self.offsetPosition.y > var_0_27[2] then
			self.offsetPosition.y = var_0_27[2] or self.offsetPosition.y
		end

		if self.offsetPosition.y < var_0_27[1] then
			self.offsetPosition.y = var_0_27[1] or self.offsetPosition.y
		end

		return
	end)
	var_70_0:AddDragEndFunc(function(arg_75_0, arg_75_1)
		return
	end)

	return
end

function GameRoomHideSeekView:initController()
	self.furnitureCtrl = var_0_31(findTF(self.sceneContainer, "scene"), self)
	self.moveRoleCtrl = var_0_36(findTF(self.sceneContainer, "scene"), self)
	self.tvCtrl = var_0_41(findTF(self.sceneContainer, "scene/furniture_tv"), self)

	return
end

function GameRoomHideSeekView:Update()
	self:AddDebugInput()

	return
end

function GameRoomHideSeekView:AddDebugInput()
	if self.gameStop or self.settlementFlag then
		return
	end

	if IsUnityEditor and Input.GetKeyDown(KeyCode.S) then
		-- block empty
	end

	return
end

function GameRoomHideSeekView:updateMenuUI()
	local var_79_0 = self:getGameUsedTimes()
	local var_79_1 = self:getGameTimes()

	for iter_79_0 = 1, #self.battleItems do
		setActive(findTF(self.battleItems[iter_79_0], "state_open"), false)
		setActive(findTF(self.battleItems[iter_79_0], "state_closed"), false)
		setActive(findTF(self.battleItems[iter_79_0], "state_clear"), false)
		setActive(findTF(self.battleItems[iter_79_0], "state_current"), false)

		if iter_79_0 <= var_79_0 then
			setActive(findTF(self.battleItems[iter_79_0], "state_clear"), true)
		elseif iter_79_0 == var_79_0 + 1 and var_79_1 >= 1 then
			setActive(findTF(self.battleItems[iter_79_0], "state_current"), true)
		elseif var_79_0 < iter_79_0 and iter_79_0 <= var_79_0 + var_79_1 then
			setActive(findTF(self.battleItems[iter_79_0], "state_open"), true)
		else
			setActive(findTF(self.battleItems[iter_79_0], "state_closed"), true)
		end
	end

	self.totalTimes = self:getGameTotalTime()

	local var_79_2 = 1 - (self:getGameUsedTimes() - 3 < 0 and 0 or self:getGameUsedTimes() - 3) / (self.totalTimes - 4)

	if var_79_2 > 1 then
		var_79_2 = 1
	end

	scrollTo(self.battleScrollRect, 0, var_79_2)
	setActive(findTF(self.menuUI, "btnStart/tip"), var_79_1 > 0)
	self:CheckGet()

	return
end

function GameRoomHideSeekView:CheckGet()
	setActive(findTF(self.menuUI, "got"), false)

	if self:getUltimate() and self:getUltimate() ~= 0 then
		setActive(findTF(self.menuUI, "got"), true)
	end

	if self:getUltimate() == 0 then
		if self:getGameTotalTime() > self:getGameUsedTimes() then
			return
		end

		pg.m02:sendNotification(GAME.SEND_MINI_GAME_OP, {
			hubid = self:GetMGHubData().id,
			cmd = MiniGameOPCommand.CMD_ULTIMATE,
			args1 = {}
		})
		setActive(findTF(self.menuUI, "got"), true)
	end

	return
end

function GameRoomHideSeekView:openMenuUI()
	setActive(findTF(self.sceneContainer, "scene_front"), false)
	setActive(findTF(self.sceneContainer, "scene_background"), false)
	setActive(findTF(self.sceneContainer, "scene"), false)
	setActive(self.gameUI, false)
	setActive(self.menuUI, true)
	setActive(self.bg, true)
	self:openCoinLayer(true)
	self:updateMenuUI()

	return
end

function GameRoomHideSeekView:clearUI()
	setActive(self.sceneContainer, false)
	setActive(self.settlementUI, false)
	setActive(self.countUI, false)
	setActive(self.menuUI, false)
	setActive(self.gameUI, false)

	return
end

function GameRoomHideSeekView:readyStart()
	setActive(self.countUI, true)
	self.countAnimator:Play("count")
	pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_2)
	self:openCoinLayer(false)

	return
end

function GameRoomHideSeekView:gameStart()
	setActive(findTF(self.sceneContainer, "scene_front"), true)
	setActive(findTF(self.sceneContainer, "scene_background"), true)
	setActive(findTF(self.sceneContainer, "scene"), true)
	setActive(self.bg, false)

	self.sceneContainer.anchoredPosition = var_0_28
	self.offsetPosition = var_0_28

	setActive(self.gameUI, true)

	self.gameStartFlag = true
	self.scoreNum = 0
	self.nextPositionIndex = 2
	self.gameStepTime = 0
	self.heart = 3
	self.gameTime = var_0_5

	for iter_84_0 = #self.showScores, 1, -1 do
		if not table.contains(self.showScoresPool, self.showScores[iter_84_0]) then
			table.insert(self.showScoresPool, (table.remove(self.showScores, iter_84_0)))
		end
	end

	for iter_84_1 = #self.showScoresPool, 1, -1 do
		setActive(self.showScoresPool[iter_84_1], false)
	end

	self:updateGameUI()
	self:timerStart()
	self:controllerStart()

	return
end

function GameRoomHideSeekView:controllerStart()
	if self.furnitureCtrl then
		self.furnitureCtrl:start()
	end

	if self.moveRoleCtrl then
		self.moveRoleCtrl:start()
	end

	if self.tvCtrl then
		self.tvCtrl:start()
	end

	return
end

function GameRoomHideSeekView:getGameTimes()
	return self:GetMGHubData().count
end

function GameRoomHideSeekView:getGameUsedTimes()
	return self:GetMGHubData().usedtime
end

function GameRoomHideSeekView:getUltimate()
	return self:GetMGHubData().ultimate
end

function GameRoomHideSeekView:getGameTotalTime()
	return (self:GetMGHubData():getConfig("reward_need"))
end

function GameRoomHideSeekView:changeSpeed(arg_90_1)
	return
end

function GameRoomHideSeekView:onTimer()
	self:gameStep()

	return
end

function GameRoomHideSeekView:gameStep()
	self.gameTime = self.gameTime - Time.deltaTime

	if self.gameTime < 0 then
		self.gameTime = 0
	end

	self.gameStepTime = self.gameStepTime + Time.deltaTime

	self:controllerStep()
	self:updateGameUI()

	if self.gameTime <= 0 then
		self:onGameOver()

		return
	end

	return
end

function GameRoomHideSeekView:controllerStep()
	if self.furnitureCtrl then
		self.furnitureCtrl:step()
	end

	if self.moveRoleCtrl then
		self.moveRoleCtrl:step()
	end

	if self.tvCtrl then
		self.tvCtrl:step()
	end

	return
end

function GameRoomHideSeekView:timerStart()
	if not self.timer.running then
		self.timer:Start()
	end

	return
end

function GameRoomHideSeekView:timerStop()
	if self.timer.running then
		self.timer:Stop()

		if self.tvCtrl then
			self.tvCtrl:pause()
		end
	end

	return
end

function GameRoomHideSeekView:updateGameUI()
	setText(self.scoreTf, self.scoreNum)
	setText(self.gameTimeS, math.ceil(self.gameTime))

	self.sceneContainer.anchoredPosition, self.velocityXSmoothing = Vector2.SmoothDamp(self.sceneContainer.anchoredPosition, self.offsetPosition, self.velocityXSmoothing, var_0_25)

	return
end

function GameRoomHideSeekView:addScore(arg_97_1)
	self.scoreNum = self.scoreNum + arg_97_1

	if self.scoreNum < 0 then
		self.scoreNum = 0
	end

	return
end

function GameRoomHideSeekView:onGameOver()
	if self.settlementFlag then
		return
	end

	self:timerStop()

	self.settlementFlag = true

	setActive(self.clickMask, true)
	LeanTween.delayedCall(go(self._tf), 0.1, System.Action(function()
		self.settlementFlag = false
		self.gameStartFlag = false

		setActive(self.clickMask, false)
		self:showSettlement()

		return
	end))

	return
end

function GameRoomHideSeekView:showSettlement()
	setActive(self.settlementUI, true)
	GetComponent(findTF(self.settlementUI, "ad"), typeof(Animator)):Play("settlement", -1, 0)

	local var_100_0 = self.scoreNum
	local var_100_1 = getProxy(GameRoomProxy):getRoomScore(self:getGameRoomData().id)

	setActive(findTF(self.settlementUI, "ad/new"), var_100_1 < self.scoreNum)

	if var_100_1 <= var_100_0 then
		var_100_1 = var_100_0

		self:StoreDataToServer({
			var_100_0
		})
	end

	setText(findTF(self.settlementUI, "ad/highText"), var_100_1)
	setText(findTF(self.settlementUI, "ad/currentText"), var_100_0)

	self.sendSuccessFlag = true

	self:SendSuccess(var_100_0)

	return
end

function GameRoomHideSeekView:resumeGame()
	self.gameStop = false

	setActive(self.leaveUI, false)
	self:changeSpeed(1)
	self:timerStart()

	return
end

function GameRoomHideSeekView:stopGame()
	self.gameStop = true

	self:timerStop()
	self:changeSpeed(0)

	return
end

function GameRoomHideSeekView:onBackPressed()
	if not self.gameStartFlag then
		self:emit(GameRoomHideSeekView.ON_BACK_PRESSED)
	else
		if self.settlementFlag then
			return
		end

		if isActive(self.pauseUI) then
			setActive(self.pauseUI, false)
		end

		self:stopGame()
		setActive(self.leaveUI, true)
	end

	return
end

function GameRoomHideSeekView:willExit()
	if self.handle then
		UpdateBeat:RemoveListener(self.handle)
	end

	if self._tf and LeanTween.isTweening(go(self._tf)) then
		LeanTween.cancel(go(self._tf))
	end

	self:destroyController()

	if self.timer and self.timer.running then
		self.timer:Stop()
	end

	Time.timeScale = 1
	self.timer = nil

	return
end

function GameRoomHideSeekView:destroyController()
	if self.furnitureCtrl then
		self.furnitureCtrl:destroy()
	end

	if self.moveRoleCtrl then
		self.moveRoleCtrl:destroy()
	end

	if self.tvCtrl then
		self.tvCtrl:destroy()
	end

	return
end

return GameRoomHideSeekView
