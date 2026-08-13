class = var_0_10000

local var_0_0 = "WSMapAttachment"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".WSMapTransform"))

var_0_1.Fields = {
	cell = "table",
	lurkTimer = "table",
	isInit = "boolean",
	map = "table",
	attachment = "table",
	twTimer = "userdata",
	isFighting = "boolean",
	spineChar = "table",
	twBreathId = "number"
}
var_0_1.Listeners = {
	onUpdate = "Update"
}
Vector2 = var_1
var_0_1.CharBasePos = var_1.zero
Vector2 = var_1
var_0_1.IconBasePos = var_1(0, 10)

function var_0_1.GetResName(arg_1_0)
	local var_1_0 = arg_1_0.type

	WorldMapAttachment = var_1_10002

	if var_1_0 == var_1_10002.TypeEvent then
		if arg_1_0:GetReplaceDisplayEnemyConfig() then
			return "enemy_tpl"
		else
			return "event_tpl"
		end
	else
		local var_1_1 = arg_1_0.type

		WorldMapAttachment = var_2

		if var_1_1 == var_2.TypeBox then
			return "event_tpl"
		else
			WorldMapAttachment = var_1_1

			if var_1_1.IsEnemyType(arg_1_0.type) then
				return "enemy_tpl"
			else
				local var_1_2 = arg_1_0.type

				WorldMapAttachment = var_2

				if var_1_2 == var_2.TypePort then
					return "blank_tpl"
				else
					local var_1_3 = arg_1_0.type

					WorldMapAttachment = var_2

					if var_1_3 == var_2.TypeTransportFleet then
						return "transport_tpl"
					else
						local var_1_4 = arg_1_0.type

						WorldMapAttachment = var_2

						if var_1_4 == var_2.TypeTrap then
							return "event_tpl"
						else
							assert = var_1_4

							local var_1_5 = false
							local var_1_6 = "invalid attachment type: "

							tostring = var_1_10005

							var_1_4(var_1_5, var_1_6 .. var_1_10005(arg_1_0.type))
						end
					end
				end
			end
		end
	end

	return
end

function var_0_1.Setup(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	assert = var_1_10004

	var_1_10004(arg_2_0.worldMapAttachment == nil)

	arg_2_0.map = arg_2_1
	arg_2_0.cell = arg_2_2

	local var_2_0 = arg_2_0.cell
	local var_2_1 = var_4.AddListener

	WorldMapCell = var_1_10007

	var_2_1(var_2_0, var_1_10007.EventUpdateInFov, arg_2_0.onUpdate)

	local var_2_2 = arg_2_0.cell
	local var_2_3 = var_4.AddListener

	WorldMap = var_7

	var_2_3(var_2_2, var_7.EventUpdateMapBuff, arg_2_0.onUpdate)

	arg_2_0.attachment = arg_2_3

	arg_2_0:Init()

	return
end

function var_0_1.Dispose(arg_3_0)
	local var_3_0 = arg_3_0.cell
	local var_3_1 = var_1.RemoveListener

	WorldMapCell = var_1_10004

	var_3_1(var_3_0, var_1_10004.EventUpdateInFov, arg_3_0.onUpdate)

	local var_3_2 = arg_3_0.cell
	local var_3_3 = var_1.RemoveListener

	WorldMap = var_4

	var_3_3(var_3_2, var_4.EventUpdateMapBuff, arg_3_0.onUpdate)

	if arg_3_0.twBreathId then
		LeanTween = var_1

		var_1.cancel(arg_3_0.twBreathId)
	end

	if arg_3_0.lurkTimer then
		local var_3_4 = arg_3_0.lurkTimer

		var_1.Stop(var_3_4)
	end

	local var_3_5 = arg_3_0.transform

	Vector3 = var_1_10002
	var_3_5.localEulerAngles = var_1_10002.zero

	var_0_1.super.Dispose(arg_3_0)

	return
end

function var_0_1.Init(arg_4_0)
	local var_4_0 = arg_4_0.transform

	Vector3 = var_1_10002
	var_4_0.anchoredPosition3D = var_1_10002.zero

	local var_4_1 = arg_4_0.transform

	Vector3 = var_2
	var_4_1.localEulerAngles = var_2.zero

	local var_4_2 = arg_4_0.transform
	local var_4_3 = arg_4_0.attachment

	var_4_2.name = var_2.GetDebugName(var_4_3)

	local var_4_4 = arg_4_0
	local var_4_5 = arg_4_0.SetModelOrder
	local var_4_6 = arg_4_0.attachment

	var_4_5(var_4_4, var_4.GetModelOrder(var_4_6), arg_4_0.cell.row)
	arg_4_0:Update()

	return
end

function var_0_1.LoadAvatar(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = {}

	if arg_5_1 and #arg_5_1 > 0 then
		table = var_1_10005

		var_1_10005.insert(var_5_0, function(arg_6_0)
			local var_6_0 = arg_5_0
			local var_6_1 = var_1.LoadModel

			WorldConst = var_2_10004

			var_6_1(var_6_0, var_2_10004.ModelSpine, arg_5_1, nil, true, function()
				local var_7_0 = arg_5_0.model

				var_0.SetParent(var_7_0, arg_5_2, false)
				arg_6_0()

				return
			end)

			return
		end)
	end

	seriesAsync = var_1_10005

	var_1_10005(var_5_0, arg_5_3)

	return
end

function var_0_1.LoadBoxPrefab(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = {}

	if arg_8_1 and #arg_8_1 > 0 then
		table = var_1_10005

		var_1_10005.insert(var_8_0, function(arg_9_0)
			local var_9_0 = arg_8_0
			local var_9_1 = var_1.LoadModel

			WorldConst = var_2_10004

			local var_9_2 = var_2_10004.ModelPrefab

			WorldConst = var_2_10005

			var_9_1(var_9_0, var_9_2, var_2_10005.ResBoxPrefab .. arg_8_1, arg_8_1, true, function()
				local var_10_0 = arg_8_0.model

				var_0.SetParent(var_10_0, arg_8_2, false)
				arg_9_0()

				return
			end)

			return
		end)
	end

	seriesAsync = var_1_10005

	var_1_10005(var_8_0, arg_8_3)

	return
end

function var_0_1.LoadChapterPrefab(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = {}

	if arg_11_1 and #arg_11_1 > 0 then
		table = var_1_10005

		var_1_10005.insert(var_11_0, function(arg_12_0)
			local var_12_0 = arg_11_0
			local var_12_1 = var_1.LoadModel

			WorldConst = var_2_10004

			local var_12_2 = var_2_10004.ModelPrefab

			WorldConst = var_2_10005

			var_12_1(var_12_0, var_12_2, var_2_10005.ResChapterPrefab .. arg_11_1, arg_11_1, true, function()
				local var_13_0 = arg_11_0.model

				var_0.SetParent(var_13_0, arg_11_2, false)
				arg_12_0()

				return
			end)

			return
		end)
	end

	seriesAsync = var_1_10005

	var_1_10005(var_11_0, arg_11_3)

	return
end

function var_0_1.Update(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0.attachment.type

	WorldMapAttachment = var_1_10004

	if var_14_0 == var_1_10004.TypeEvent then
		if var_2:GetReplaceDisplayEnemyConfig() then
			arg_14_0:UpdateEventEnemy(arg_14_1)
		else
			arg_14_0:UpdateEvent(arg_14_1)
		end
	else
		local var_14_1 = var_2.type

		WorldMapAttachment = var_4

		if var_14_1 == var_4.TypeBox then
			arg_14_0:UpdateBox(arg_14_1)
		else
			local var_14_2 = var_2.type

			WorldMapAttachment = var_4

			if var_14_2 == var_4.TypePort then
				arg_14_0:UpdatePort(arg_14_1)
			else
				WorldMapAttachment = var_14_2

				if var_14_2.IsEnemyType(var_2.type) then
					arg_14_0:UpdateEnemy(arg_14_1)
				else
					local var_14_3 = var_2.type

					WorldMapAttachment = var_4

					if var_14_3 == var_4.TypeTransportFleet then
						arg_14_0:UpdateTransportFleet(arg_14_1)
					else
						local var_14_4 = var_2.type

						WorldMapAttachment = var_4

						if var_14_4 == var_4.TypeTrap then
							arg_14_0:UpdateTrap(arg_14_1)
						else
							assert = var_14_4

							var_14_4(false, "invalid attachment type: " .. var_2.type)
						end
					end
				end
			end
		end
	end

	arg_14_0:UpdateBreathTween()

	local var_14_5 = arg_14_0
	local var_14_6 = arg_14_0.UpdateModelAngles
	local var_14_7 = arg_14_0.attachment

	if var_6.GetMillor(var_14_7) then
		Vector3 = var_14_8

		local var_14_8

		if not var_14_8(0, 180, 0) then
			Vector3 = var_14_8
			var_14_8 = var_14_8.zero
		end

		var_14_6(var_14_5, var_14_8)

		local var_14_9 = arg_14_0
		local var_14_10 = arg_14_0.UpdateModelScale
		local var_14_11 = arg_14_0.attachment

		var_14_10(var_14_9, var_6.GetScale(var_14_11))

		return
	end
end

function var_0_1.UpdateEvent(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0.map
	local var_15_1 = arg_15_0.cell
	local var_15_2 = arg_15_0.attachment
	local var_15_3 = arg_15_0.transform
	local var_15_4 = var_15_0:CheckDisplay(var_15_2)

	setActive = var_1_10007

	var_1_10007(var_15_3, var_15_4)

	if var_15_4 then
		local var_15_5 = var_15_2:IsAvatar()

		if arg_15_0.isInit then
			WorldMap = var_8

			if arg_15_1 == var_8.EventUpdateMapBuff then
				local var_15_6 = arg_15_0
				local var_15_7 = arg_15_0.UpdateMapBuff
				local var_15_8 = var_15_3
				local var_15_9 = var_15_2:GetRadiationBuffs()
				local var_15_10 = var_15_0
				local var_15_11 = var_15_0.GetBuffList

				WorldMap = var_1_10016

				var_15_7(var_15_6, var_15_8, var_15_9, var_15_11(var_15_10, var_1_10016.FactionEnemy, var_15_2))
			end
		end

		local var_15_12

		if not arg_15_0.isInit then
			arg_15_0.isInit = true
			var_15_12 = var_15_2.config

			local var_15_13 = var_15_3
			local var_15_14 = var_15_3.Find(var_15_13, "char")
			local var_15_15 = var_15_3:Find("icon")

			setActive = var_15_13

			var_15_13(var_15_14, var_15_5)

			setActive = var_15_13

			var_15_13(var_15_15, not var_15_5)

			if var_15_5 then
				arg_15_0:LoadAvatar(var_15_12.icon, var_15_14:Find("ship"), function()
					if #var_15_12.icon > 0 then
						setAnchoredPosition = var_0

						local var_16_0 = arg_15_0.model
						local var_16_1 = var_15_2

						var_0(var_16_0, var_3.GetDeviation(var_16_1))
					end

					return
				end)
			else
				math = var_15_13

				if var_15_13.floor(var_15_12.enemyicon / 2) == 2 then
					arg_15_0:LoadChapterPrefab(var_15_12.icon, var_15_15, function()
						if #var_15_12.icon > 0 then
							setAnchoredPosition = var_0

							local var_17_0 = arg_15_0.model
							local var_17_1 = var_15_2

							var_0(var_17_0, var_3.GetDeviation(var_17_1))
						end

						return
					end)
				else
					math = var_11

					if var_11.floor(var_15_12.enemyicon / 2) == 0 then
						arg_15_0:LoadBoxPrefab(var_15_12.icon, var_15_15, function()
							if #var_15_12.icon > 0 then
								setAnchoredPosition = var_0

								local var_18_0 = arg_15_0.model
								local var_18_1 = var_15_2

								var_0(var_18_0, var_3.GetDeviation(var_18_1))
							end

							return
						end)
					else
						assert = var_11

						var_11(false, "enemyicon error from id: " .. var_15_2.id)
					end
				end
			end

			arg_15_0:UpdateBuffList(var_15_3, var_15_2:GetBuffList())

			local var_15_16 = arg_15_0
			local var_15_17 = arg_15_0.UpdateMapBuff
			local var_15_18 = var_15_3
			local var_15_19 = var_15_2:GetRadiationBuffs()
			local var_15_20 = var_15_0
			local var_15_21 = var_15_0.GetBuffList

			WorldMap = var_1_10019

			var_15_17(var_15_16, var_15_18, var_15_19, var_15_21(var_15_20, var_1_10019.FactionEnemy, var_15_2))
		end

		WorldMapAttachment = var_15_12

		if arg_15_1 == var_15_12.EventUpdateLurk and var_15_1:GetInFOV() and not var_15_2.lurk then
			setActive = var_8

			var_8(var_15_3:Find("effect_found"), true)

			Timer = var_8
			arg_15_0.lurkTimer = var_8.New(function()
				setActive = var_2_10000

				local var_19_0 = var_15_3

				var_2_10000(var_2.Find(var_19_0, "effect_found"), false)

				return
			end, 3, 1)

			local var_15_22 = arg_15_0.lurkTimer

			var_8.Start(var_15_22)
		else
			setActive = var_8

			var_8(var_15_3:Find("effect_found"), false)
		end
	end

	return
end

function var_0_1.UpdateEventEnemy(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_0.map
	local var_20_1 = arg_20_0.cell
	local var_20_2 = arg_20_0.attachment
	local var_20_3 = arg_20_0.transform
	local var_20_4 = var_5.Find(var_20_3, "live")
	local var_20_5 = var_5
	local var_20_6 = var_5.Find(var_20_5, "dead")
	local var_20_7 = var_20_0:CheckDisplay(var_20_2)

	setActive = var_20_5

	var_20_5(var_5, var_20_7)

	if var_20_7 then
		local var_20_8 = var_20_2:IsAlive()
		local var_20_9 = var_20_2:IsAvatar()

		if arg_20_0.isInit then
			WorldMap = var_11

			if arg_20_1 == var_11.EventUpdateMapBuff then
				local var_20_10 = arg_20_0
				local var_20_11 = arg_20_0.UpdateMapBuff
				local var_20_12 = var_20_4
				local var_20_13 = var_20_2:GetRadiationBuffs()
				local var_20_14 = var_20_0
				local var_20_15 = var_20_0.GetBuffList

				WorldMap = var_1_10019

				var_20_11(var_20_10, var_20_12, var_20_13, var_20_15(var_20_14, var_1_10019.FactionEnemy, var_20_2))
			end
		end

		local var_20_16

		if not arg_20_0.isInit then
			arg_20_0.isInit = true
			var_20_16 = var_20_2:GetReplaceDisplayEnemyConfig()

			local var_20_17 = var_20_4
			local var_20_18 = var_20_4.Find(var_20_17, "char")
			local var_20_19 = var_20_4:Find("icon")

			setActive = var_20_17

			var_20_17(var_20_18, var_20_9)

			setActive = var_20_17

			var_20_17(var_20_19, not var_20_9)

			if var_20_9 then
				arg_20_0:LoadAvatar(var_20_16.icon, var_20_18:Find("ship"))
			else
				GetImageSpriteFromAtlasAsync = var_20_17

				var_20_17("enemies/" .. var_20_16.icon, "", var_20_19:Find("pic"))

				WorldConst = var_20_17

				local var_20_20 = var_20_17.EnemySize[var_20_16.type]

				setActive = var_15

				var_15(var_20_19:Find("size/bg_s"), var_20_20 == 1 or not var_20_20)

				setActive = var_15

				var_15(var_20_19:Find("size/bg_m"), var_20_20 == 2)

				setActive = var_15

				var_15(var_20_19:Find("size/bg_h"), var_20_20 == 3)

				setActive = var_15

				var_15(var_20_19:Find("size/bg_boss"), var_20_20 == 99)

				local var_20_21 = var_20_16.difficulty

				ys = var_16

				if var_20_21 == var_16.Battle.BattleConst.Difficulty.WORLD then
					setActive = var_20_21

					var_20_21(var_20_19:Find("size/bg_boss"), false)

					setText = var_20_21

					local var_20_22 = var_20_19:Find("lv/Text")

					WorldConst = var_18

					var_20_21(var_20_22, var_18.WorldLevelCorrect(var_20_0.config.expedition_level, var_20_16.type))
				else
					setText = var_20_21

					var_20_21(var_20_19:Find("lv/Text"), var_20_16.level)
				end

				GetImageSpriteFromAtlasAsync = var_20_21

				var_20_21("enemies/" .. var_20_16.icon .. "_d_blue", "", var_20_6:Find("icon"))
			end

			arg_20_0:UpdateHP(var_20_4:Find("hp"), var_20_2:GetHP(), var_20_2:GetMaxHP())
			arg_20_0:UpdateBuffList(var_20_4, var_20_2:GetBuffList())

			local var_20_23 = arg_20_0
			local var_20_24 = arg_20_0.UpdateMapBuff
			local var_20_25 = var_20_4
			local var_20_26 = var_20_2:GetRadiationBuffs()
			local var_20_27 = var_20_0
			local var_20_28 = var_20_0.GetBuffList

			WorldMap = var_1_10022

			var_20_24(var_20_23, var_20_25, var_20_26, var_20_28(var_20_27, var_1_10022.FactionEnemy, var_20_2))
		end

		setActive = var_20_16

		var_20_16(var_20_4, var_20_8)

		setActive = var_20_16

		var_20_16(var_20_6, false)

		setActive = var_20_16

		var_20_16(var_20_4:Find("fighting"), false)

		WorldMapAttachment = var_20_16

		if arg_20_1 == var_20_16.EventUpdateLurk and var_20_1:GetInFOV() and not var_20_2.lurk then
			setActive = var_11

			var_11(var_20_4:Find("effect_found"), true)

			Timer = var_11
			arg_20_0.lurkTimer = var_11.New(function()
				setActive = var_2_10000

				local var_21_0 = var_20_4

				var_2_10000(var_2.Find(var_21_0, "effect_found"), false)

				return
			end, 3, 1)

			local var_20_29 = arg_20_0.lurkTimer

			var_11.Start(var_20_29)
		else
			setActive = var_11

			var_11(var_20_4:Find("effect_found"), false)
		end
	end

	return
end

function var_0_1.UpdateBox(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0.map
	local var_22_1 = arg_22_0.cell
	local var_22_2 = arg_22_0.attachment
	local var_22_3 = arg_22_0.transform
	local var_22_4 = var_22_0:CheckDisplay(var_22_2)

	setActive = var_1_10007

	var_1_10007(var_22_3, var_22_4)

	if var_22_4 then
		local var_22_5 = var_22_2:IsAvatar()

		if not arg_22_0.isInit then
			arg_22_0.isInit = true

			local var_22_6 = var_22_2.config
			local var_22_7 = var_22_3
			local var_22_8 = var_22_3.Find(var_22_7, "char")
			local var_22_9 = var_22_3:Find("icon")

			setActive = var_22_7

			var_22_7(var_22_8, var_22_5)

			setActive = var_22_7

			var_22_7(var_22_9, not var_22_5)

			setAnchoredPosition = var_22_7

			var_22_7(var_22_8, var_0_1.CharBasePos)

			setAnchoredPosition = var_22_7

			var_22_7(var_22_9, var_0_1.IconBasePos)

			if var_22_5 then
				arg_22_0:LoadAvatar(var_22_6.icon, var_22_8:Find("ship"))
			else
				arg_22_0:LoadBoxPrefab(var_22_6.icon, var_22_9)
			end

			arg_22_0:UpdateBuffList(var_22_3, {})
			arg_22_0:UpdateMapBuff(var_22_3, {}, {})
		end
	end

	return
end

function var_0_1.UpdateEnemy(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_0.map
	local var_23_1 = arg_23_0.cell
	local var_23_2 = arg_23_0.attachment
	local var_23_3 = arg_23_0.transform
	local var_23_4 = var_5.Find(var_23_3, "live")
	local var_23_5 = var_5
	local var_23_6 = var_5.Find(var_23_5, "dead")
	local var_23_7 = var_23_0:CheckDisplay(var_23_2)

	setActive = var_23_5

	var_23_5(var_5, var_23_7)

	if var_23_7 then
		local var_23_8 = var_23_2:IsAlive()
		local var_23_9 = var_23_2:IsAvatar()

		if arg_23_0.isInit then
			WorldMap = var_11

			if arg_23_1 == var_11.EventUpdateMapBuff then
				local var_23_10 = arg_23_0
				local var_23_11 = arg_23_0.UpdateMapBuff
				local var_23_12 = var_23_4
				local var_23_13 = var_23_2:GetRadiationBuffs()
				local var_23_14 = var_23_0
				local var_23_15 = var_23_0.GetBuffList

				WorldMap = var_1_10019

				var_23_11(var_23_10, var_23_12, var_23_13, var_23_15(var_23_14, var_1_10019.FactionEnemy, var_23_2))
			end
		end

		local var_23_16

		if not arg_23_0.isInit then
			arg_23_0.isInit = true
			var_23_16 = var_23_2.config

			local var_23_17 = var_23_4
			local var_23_18 = var_23_4.Find(var_23_17, "char")
			local var_23_19 = var_23_4:Find("icon")

			setActive = var_23_17

			var_23_17(var_23_18, var_23_9)

			setActive = var_23_17

			var_23_17(var_23_19, not var_23_9)

			if var_23_9 then
				arg_23_0:LoadAvatar(var_23_16.icon, var_23_18:Find("ship"))
			else
				GetImageSpriteFromAtlasAsync = var_23_17

				var_23_17("enemies/" .. var_23_16.icon, "", var_23_19:Find("pic"))

				WorldConst = var_23_17

				local var_23_20 = var_23_17.EnemySize[var_23_16.type]

				setActive = var_15

				var_15(var_23_19:Find("size/bg_s"), var_23_20 == 1 or not var_23_20)

				setActive = var_15

				var_15(var_23_19:Find("size/bg_m"), var_23_20 == 2)

				setActive = var_15

				var_15(var_23_19:Find("size/bg_h"), var_23_20 == 3)

				setActive = var_15

				var_15(var_23_19:Find("size/bg_boss"), var_23_20 == 99)

				local var_23_21 = var_23_16.difficulty

				ys = var_16

				if var_23_21 == var_16.Battle.BattleConst.Difficulty.WORLD then
					setActive = var_23_21

					var_23_21(var_23_19:Find("size/bg_boss"), false)

					setText = var_23_21

					local var_23_22 = var_23_19:Find("lv/Text")

					WorldConst = var_18

					var_23_21(var_23_22, var_18.WorldLevelCorrect(var_23_0.config.expedition_level, var_23_16.type))
				else
					setText = var_23_21

					var_23_21(var_23_19:Find("lv/Text"), var_23_16.level)
				end

				GetImageSpriteFromAtlasAsync = var_23_21

				var_23_21("enemies/" .. var_23_16.icon .. "_d_blue", "", var_23_6:Find("icon"))
			end

			arg_23_0:UpdateHP(var_23_4:Find("hp"), var_23_2:GetHP(), var_23_2:GetMaxHP())
			arg_23_0:UpdateBuffList(var_23_4, var_23_2:GetBuffList())

			local var_23_23 = arg_23_0
			local var_23_24 = arg_23_0.UpdateMapBuff
			local var_23_25 = var_23_4
			local var_23_26 = var_23_2:GetRadiationBuffs()
			local var_23_27 = var_23_0
			local var_23_28 = var_23_0.GetBuffList

			WorldMap = var_1_10022

			var_23_24(var_23_23, var_23_25, var_23_26, var_23_28(var_23_27, var_1_10022.FactionEnemy, var_23_2))
		end

		setActive = var_23_16

		var_23_16(var_23_4, var_23_8)

		setActive = var_23_16

		var_23_16(var_23_6, not var_23_9 and var_23_2.flag == 1)

		if var_23_8 then
			setActive = var_23_16

			var_23_16(var_23_4:Find("fighting"), arg_23_0.isFighting)
		end
	end

	return
end

function var_0_1.UpdatePort(arg_24_0, arg_24_1)
	setActive = var_1_10002

	var_1_10002(arg_24_0.transform, false)

	return
end

function var_0_1.UpdateTransportFleet(arg_25_0, arg_25_1)
	local var_25_0 = arg_25_0.map
	local var_25_1 = arg_25_0.cell
	local var_25_2 = arg_25_0.attachment
	local var_25_3 = arg_25_0.transform
	local var_25_4 = var_25_0:CheckDisplay(var_25_2)

	setActive = var_1_10007

	var_1_10007(var_25_3, var_25_4)

	if var_25_4 and not arg_25_0.isInit then
		arg_25_0.isInit = true

		local var_25_5 = var_25_2.config
		local var_25_6 = var_25_3:Find("ship/icon")

		GetImageSpriteFromAtlasAsync = var_9

		var_9("enemies/" .. var_25_5.icon, "", var_25_6)
	end

	return
end

function var_0_1.UpdateTrap(arg_26_0, arg_26_1)
	local var_26_0 = arg_26_0.map
	local var_26_1 = arg_26_0.cell
	local var_26_2 = arg_26_0.attachment
	local var_26_3 = arg_26_0.transform
	local var_26_4 = var_26_0:CheckDisplay(var_26_2)

	setActive = var_1_10007

	var_1_10007(var_26_3, var_26_4)

	if var_26_4 then
		local var_26_5 = var_26_2:IsAvatar()

		if not arg_26_0.isInit then
			arg_26_0.isInit = true

			local var_26_6 = var_26_2.config
			local var_26_7 = var_26_3
			local var_26_8 = var_26_3.Find(var_26_7, "char")
			local var_26_9 = var_26_3:Find("icon")

			setActive = var_26_7

			var_26_7(var_26_8, var_26_5)

			setActive = var_26_7

			var_26_7(var_26_9, not var_26_5)

			setAnchoredPosition = var_26_7

			var_26_7(var_26_8, var_0_1.CharBasePos)

			setAnchoredPosition = var_26_7

			var_26_7(var_26_9, var_0_1.IconBasePos)

			if var_26_5 then
				arg_26_0:LoadAvatar(var_26_6.trap_fx, var_26_8:Find("ship"))
			else
				arg_26_0:LoadBoxPrefab(var_26_6.trap_fx, var_26_9)
			end

			arg_26_0:UpdateBuffList(var_26_3, {})
			arg_26_0:UpdateMapBuff(var_26_3, {}, {})
		end
	end

	return
end

function var_0_1.UpdateBuffList(arg_27_0, arg_27_1, arg_27_2)
	local var_27_0 = arg_27_1:Find("buffs")

	setActive = var_1_10004

	var_1_10004(var_27_0, #arg_27_2 > 0)

	UIItemList = var_1_10004

	local var_27_1 = var_1_10004.New(var_27_0, var_27_0:GetChild(0))

	var_4.make(var_27_1, function(arg_28_0, arg_28_1, arg_28_2)
		arg_28_1 = arg_28_1 + 1
		UIItemList = var_2_10003

		if arg_28_0 == var_2_10003.EventUpdate then
			local var_28_0 = arg_27_2[arg_28_1]

			GetImageSpriteFromAtlasAsync = var_2_10004

			var_2_10004("world/buff/" .. var_28_0.config.icon, "", arg_28_2)
		end

		return
	end)
	var_4:align(#arg_27_2)

	setAnchoredPosition = var_5

	local var_27_2 = var_27_0
	local var_27_3 = {}
	local var_27_4 = arg_27_0.modelType

	WorldConst = var_10
	var_27_3.y = var_27_4 == var_10.ModelSpine and 100 or 0

	var_5(var_27_2, var_27_3)

	return
end

function var_0_1.UpdateMapBuff(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
	local var_29_0 = arg_29_1:Find("map_buff")
	local var_29_1 = false
	local var_29_2

	if #arg_29_2 > 0 then
		var_29_1 = "wifi"
		unpack = var_29_2

		local var_29_3, var_29_4

		var_29_2, var_29_3, var_29_4 = var_29_2(arg_29_2[1])
		GetImageSpriteFromAtlasAsync = var_1_10009

		local var_29_5 = "world/mapbuff/"

		pg = var_1_10012

		var_1_10009(var_29_5 .. var_1_10012.world_SLGbuff_data[var_29_3].icon, "", var_29_0:Find("Image"))
	else
		var_29_2 = #arg_29_3

		if 0 < var_29_2 then
			var_29_1 = "arrow"
			var_29_2 = arg_29_3[1]
			GetImageSpriteFromAtlasAsync = var_7

			var_7("world/mapbuff/" .. var_29_2.config.icon, "", var_29_0:Find("Image"))
		end
	end

	setActive = var_29_2

	var_29_2(var_29_0:Find("wifi"), var_29_1 == "wifi")

	setActive = var_29_2

	var_29_2(var_29_0:Find("arrow"), var_29_1 == "arrow")

	setActive = var_29_2

	var_29_2(var_29_0, var_29_1)

	return
end

function var_0_1.UpdateHP(arg_30_0, arg_30_1, arg_30_2, arg_30_3)
	setActive = var_1_10004

	var_1_10004(arg_30_1, arg_30_2 and arg_30_3)

	if arg_30_2 and arg_30_3 then
		setSlider = var_1_10004

		var_1_10004(arg_30_1, 0, arg_30_3, arg_30_2)
	end

	return
end

function var_0_1.UpdateBreathTween(arg_31_0)
	local var_31_0 = arg_31_0.attachment

	if var_1.IsFloating(var_31_0) and var_1:IsAlive() and var_1:IsVisible() then
		if not arg_31_0.twBreathId then
			local var_31_1 = arg_31_0.transform

			Vector3 = var_1_10003
			var_31_1.localPosition = var_1_10003(0, 40, 0)
			LeanTween = var_31_1

			local var_31_2 = var_31_1.moveY(arg_31_0.transform, 50, 1)
			local var_31_3 = var_2.setEase

			LeanTweenType = var_5

			local var_31_4 = var_31_3(var_31_2, var_5.easeInOutSine)
			local var_31_5 = var_2.setLoopPingPong(var_31_4)

			var_31_5.passed = arg_31_0.twTimer.passed
			var_31_5.direction = arg_31_0.twTimer.direction
			arg_31_0.twBreathId = var_31_5.uniqueId
		end
	elseif arg_31_0.twBreathId then
		LeanTween = var_2

		var_2.cancel(arg_31_0.twBreathId)

		arg_31_0.twBreathId = nil

		local var_31_6 = arg_31_0.transform

		Vector3 = var_1_10003
		var_31_6.localPosition = var_1_10003(0, 40, 0)
	end

	return
end

function var_0_1.UpdateIsFighting(arg_32_0, arg_32_1)
	assert = var_1_10002
	WorldMapAttachment = var_1_10004

	var_1_10002(var_1_10004.IsEnemyType(arg_32_0.attachment.type))

	if arg_32_0.isFighting ~= arg_32_1 then
		arg_32_0.isFighting = arg_32_1

		arg_32_0:UpdateEnemy()
	end

	return
end

function var_0_1.TrapAnimDisplay(arg_33_0, arg_33_1)
	local var_33_0 = {}
	local var_33_1 = arg_33_0.model
	local var_33_2 = var_3.GetChild(var_33_1, 0)

	table = var_1_10004

	var_1_10004.insert(var_33_0, function(arg_34_0)
		local var_34_0 = var_33_2
		local var_34_1 = var_1.GetComponent(var_34_0, "DftAniEvent")

		var_1.SetEndEvent(var_34_1, arg_34_0)

		local var_34_2 = var_33_2
		local var_34_3 = var_1.GetComponent(var_34_2, "Animator")

		var_1.Play(var_34_3, "disappear")

		return
	end)

	table = var_4

	var_4.insert(var_33_0, function(arg_35_0)
		local var_35_0 = arg_33_0.attachment
		local var_35_1 = var_1.GetScale(var_35_0, arg_33_0.attachment.config.trap_range[1])
		local var_35_2 = arg_33_0

		var_2.UpdateModelScale(var_35_2, var_35_1)

		local var_35_3 = var_33_2
		local var_35_4 = var_2.GetComponent(var_35_3, "DftAniEvent")

		var_2.SetEndEvent(var_35_4, arg_35_0)

		local var_35_5 = var_33_2
		local var_35_6 = var_2.GetComponent(var_35_5, "Animator")

		var_2.Play(var_35_6, "vortexAnimation")

		return
	end)

	table = var_4

	var_4.insert(var_33_0, function(arg_36_0)
		local var_36_0 = arg_33_0
		local var_36_1 = var_1.UpdateModelScale

		Vector3 = var_2_10004

		var_36_1(var_36_0, var_2_10004.zero)

		local var_36_2 = var_33_2
		local var_36_3 = var_1.GetComponent(var_36_2, "Animator")

		var_1.Play(var_36_3, "loop")
		arg_36_0()

		return
	end)

	seriesAsync = var_4

	var_4(var_33_0, arg_33_1)

	return
end

return var_0_1
