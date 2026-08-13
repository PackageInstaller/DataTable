class = var_0_10000

local var_0_0 = "IslandNormalHudPanel"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("Mod.Island.Core.View.IslandBaseHudPanel"))

function var_0_1.GetUIName(arg_1_0)
	return "IslandNormalNpcHud"
end

function var_0_1.Ctor(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	var_0_1.super.Ctor(arg_2_0, arg_2_1, arg_2_2, arg_2_3)

	pg = var_4
	arg_2_0.hud_name_range = var_4.island_set.hud_name_range.key_value_int
	arg_2_0.currentTaskType = -1
	arg_2_0.currentTaskId = -1

	return
end

function var_0_1.OnInit(arg_3_0)
	tonumber = var_1_10001
	arg_3_0.npcId = var_1_10001(arg_3_0.param1)

	local var_3_0 = arg_3_0._tf

	arg_3_0.hudImageTF = var_1.Find(var_3_0, "hud_bg/hudImage")

	local var_3_1 = arg_3_0._tf

	arg_3_0.hudImageBg = var_1.Find(var_3_1, "hud_bg")
	pg = var_1
	arg_3_0.hudImageIcon = var_1.island_npc_hud[arg_3_0.npcId].icon

	local var_3_2 = arg_3_0._tf

	arg_3_0.hudTitle = var_2.Find(var_3_2, "title")

	local var_3_3 = arg_3_0._tf

	arg_3_0.hudName = var_2.Find(var_3_3, "name")
	setText = var_2

	var_2(arg_3_0.hudTitle, var_1.title)

	setText = var_2

	var_2(arg_3_0.hudName, var_1.name)

	arg_3_0.tfDic = {
		hudImage = arg_3_0.hudImageBg,
		title = arg_3_0.hudTitle,
		name = arg_3_0.hudName
	}
	arg_3_0.activeTFDic = {}
	arg_3_0.playerTF = arg_3_0:GetPlayer()

	arg_3_0:CheckPlayer()

	return
end

function var_0_1.CheckPlayer(arg_4_0)
	arg_4_0.isNear = arg_4_0:CheckIsNear()
	setActive = var_1

	var_1(arg_4_0.hudTitle, arg_4_0.isNear)

	setActive = var_1

	var_1(arg_4_0.hudName, arg_4_0.isNear)
	arg_4_0:UpdateTaskDisplay()

	return
end

function var_0_1.OnDispose(arg_5_0)
	var_0_1.super.OnDispose(arg_5_0)

	return
end

function var_0_1.GetPlayer(arg_6_0)
	GameObject = var_1_10001

	local var_6_0 = var_1_10001.Find("Root")
	local var_6_1 = var_1.GetComponentsInChildren

	typeof = var_1_10005
	WorldObjectItem = var_1_10007

	local var_6_2 = var_6_1(var_6_0, var_1_10005(var_1_10007))
	local var_6_3 = var_2.ToTable(var_6_2)

	ipairs = var_3

	for iter_6_0, iter_6_1 in var_3(var_6_3) do
		if iter_6_1.isPlayer then
			arg_6_0.hasPlayer = true

			return iter_6_1.gameObject.transform
		end
	end

	return nil
end

function var_0_1.CheckIsNear(arg_7_0)
	local var_7_0 = arg_7_0.view
	local var_7_1

	if not var_1.GetUnitModuleWithType(var_7_0, arg_7_0.unitType, arg_7_0.unitId) or not var_1._go then
		var_7_1 = nil
	end

	if var_1 then
		IsNil = var_7_0

		if not var_7_0(var_7_1) then
			IsNil = var_7_0

			if var_7_0(var_7_1.transform) then
				return false
			end

			IsNil = var_7_0

			if var_7_0(arg_7_0.playerTF) then
				return false
			end

			if (arg_7_0.playerTF.position - var_7_1.transform.position).magnitude < arg_7_0.hud_name_range then
				return true
			end

			return false
		end
	end
end

function var_0_1.OnUpdate(arg_8_0)
	if not arg_8_0.hasPlayer then
		arg_8_0.playerTF = arg_8_0:GetPlayer()

		arg_8_0:CheckPlayer()
	else
		local var_8_0 = arg_8_0

		if arg_8_0.CheckIsNear(var_8_0) == arg_8_0.isNear then
			return
		end

		arg_8_0.isNear = var_1

		local var_8_1 = {
			"title",
			"name"
		}

		ipairs = var_8_0

		for iter_8_0, iter_8_1 in var_8_0(var_8_1) do
			arg_8_0:SetTFActive(iter_8_1, arg_8_0.isNear)
		end
	end

	return
end

function var_0_1.SetTFActive(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_0.tfDic[arg_9_1]

	IsNil = var_1_10004

	if var_1_10004(var_9_0) then
		return
	end

	if arg_9_0.activeTFDic[arg_9_1] == arg_9_2 then
		return
	end

	arg_9_0.activeTFDic[arg_9_1] = arg_9_2

	local var_9_1 = var_9_0
	local var_9_2 = var_9_0.GetComponent

	typeof = var_1_10007
	Animation = var_1_10009

	local var_9_3 = var_9_2(var_9_1, var_1_10007(var_1_10009))

	if arg_9_2 then
		var_9_3:Play("anim_IslandNormalNpcHud_in")

		if arg_9_1 == "hudImage" then
			arg_9_0:UpdateTaskDisplay()
		else
			setActive = var_5

			var_5(var_9_0, true)
		end
	else
		var_9_3:Play("anim_IslandNormalNpcHud_out")

		local var_9_4 = var_9_0:GetComponent("DftAniEvent")

		var_5.SetEndEvent(var_9_4, function(arg_10_0)
			if arg_9_1 == "hudImage" then
				local var_10_0 = arg_9_0

				var_1.UpdateTaskDisplay(var_10_0)
			else
				setActive = var_1

				var_1(var_9_0, false)
			end

			return
		end)
	end

	return
end

function var_0_1.RefreshHud(arg_11_0)
	arg_11_0:UpdateTaskDisplay()

	return
end

function var_0_1.UpdateTaskDisplay(arg_12_0)
	IsNil = var_1_10001

	if var_1_10001(arg_12_0.hudImageBg) then
		return
	end

	IslandObjectTaskHudHelper = var_1

	local var_12_0, var_12_1 = var_1.GetObjectTaskHud(arg_12_0.unitId)

	if arg_12_0.currentTaskId ~= var_12_1 then
		arg_12_0.currentTaskId = var_12_1

		local var_12_2

		if var_12_1 then
			IslandObjectTaskHudHelper = var_12_2
			var_12_2, var_1_10004 = var_12_2.GetHudDislayInfoByTaskId(var_12_1)
			setActive = var_5

			var_5(arg_12_0.hudImageBg, true)

			GetImageSpriteFromAtlasAsync = var_5

			var_5("island/IslandHudIcon", var_12_2, arg_12_0.hudImageBg)

			setImageColor = var_5

			local var_12_3 = arg_12_0.hudImageTF

			Color = var_8

			var_5(var_12_3, var_8.NewHex(var_1_10004))
		else
			setActive = var_12_2

			var_12_2(arg_12_0.hudImageBg, arg_12_0.hudImageIcon ~= "")

			GetImageSpriteFromAtlasAsync = var_12_2

			var_12_2("island/IslandHudIcon", "hud_main", arg_12_0.hudImageBg)

			setImageColor = var_12_2

			local var_12_4 = arg_12_0.hudImageTF

			Color = var_6

			var_12_2(var_12_4, var_6.NewHex("78787a"))
		end
	end

	if var_12_0 ~= arg_12_0.currentTaskType then
		arg_12_0.currentTaskType = var_12_0
		IslandObjectTaskHudHelper = var_3

		local var_12_5

		if not var_3.TaskProcessToHudIcon[var_12_0] then
			var_12_5 = arg_12_0.hudImageIcon
		end

		setActive = var_1_10004

		var_1_10004(arg_12_0.hudImageBg, var_12_5 ~= "")

		if var_12_5 ~= "" then
			GetImageSpriteFromAtlasAsync = var_1_10004

			var_1_10004("island/IslandHudIcon", var_12_5, arg_12_0.hudImageTF)
		end
	end

	return
end

function var_0_1.Show(arg_13_0)
	if not arg_13_0._tf or arg_13_0.active == true then
		return
	end

	arg_13_0.active = true
	setActive = var_1

	var_1(arg_13_0._tf, true)

	local var_13_0 = {
		"hudImage",
		"title",
		"name"
	}

	ipairs = var_1_10002

	for iter_13_0, iter_13_1 in var_1_10002(var_13_0) do
		arg_13_0:SetTFActive(iter_13_1, true)
	end

	return
end

function var_0_1.Hide(arg_14_0)
	if not arg_14_0._tf then
		return
	end

	arg_14_0.active = false

	local var_14_0 = {
		"hudImage",
		"title",
		"name"
	}

	ipairs = var_1_10002

	for iter_14_0, iter_14_1 in var_1_10002(var_14_0) do
		arg_14_0:SetTFActive(iter_14_1, false)
	end

	return
end

return var_0_1
