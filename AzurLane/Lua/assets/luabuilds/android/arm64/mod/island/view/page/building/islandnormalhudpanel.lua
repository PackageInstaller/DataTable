local var_0_0 = class("IslandNormalHudPanel", import("Mod.Island.Core.View.IslandBaseHudPanel"))

function var_0_0.GetUIName(arg_1_0)
	return "IslandNormalNpcHud"
end

function var_0_0.Ctor(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	var_0_0.super.Ctor(arg_2_0, arg_2_1, arg_2_2, arg_2_3)

	arg_2_0.hud_name_range = pg.island_set.hud_name_range.key_value_int
	arg_2_0.currentTaskType = -1
	arg_2_0.currentTaskId = -1

	return
end

function var_0_0.OnInit(arg_3_0)
	arg_3_0.npcId = tonumber(arg_3_0.param1)
	arg_3_0.hudImageTF = arg_3_0._tf:Find("hud_bg/hudImage")
	arg_3_0.hudImageBg = arg_3_0._tf:Find("hud_bg")
	arg_3_0.hudImageIcon = pg.island_npc_hud[arg_3_0.npcId].icon
	arg_3_0.hudTitle = arg_3_0._tf:Find("title")
	arg_3_0.hudName = arg_3_0._tf:Find("name")

	setText(arg_3_0.hudTitle, pg.island_npc_hud[arg_3_0.npcId].title)
	setText(arg_3_0.hudName, pg.island_npc_hud[arg_3_0.npcId].name)

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

function var_0_0.CheckPlayer(arg_4_0)
	arg_4_0.isNear = arg_4_0:CheckIsNear()

	setActive(arg_4_0.hudTitle, arg_4_0.isNear)
	setActive(arg_4_0.hudName, arg_4_0.isNear)
	arg_4_0:UpdateTaskDisplay()

	return
end

function var_0_0.OnDispose(arg_5_0)
	var_0_0.super.OnDispose(arg_5_0)

	return
end

function var_0_0.GetPlayer(arg_6_0)
	for iter_6_0, iter_6_1 in ipairs((GameObject.Find("Root"):GetComponentsInChildren(typeof(WorldObjectItem)):ToTable())) do
		if iter_6_1.isPlayer then
			arg_6_0.hasPlayer = true

			return iter_6_1.gameObject.transform
		end
	end

	return nil
end

function var_0_0.CheckIsNear(arg_7_0)
	local var_7_0 = arg_7_0.view:GetUnitModuleWithType(arg_7_0.unitType, arg_7_0.unitId)

	if var_7_0 then
		local var_7_1 = var_7_0._go or nil

		if not var_7_0 or IsNil(var_7_1) or IsNil(var_7_1.transform) then
			return false
		end

		if IsNil(arg_7_0.playerTF) then
			return false
		end

		if (arg_7_0.playerTF.position - var_7_1.transform.position).magnitude < arg_7_0.hud_name_range then
			return true
		end

		return false
	end
end

function var_0_0.OnUpdate(arg_8_0)
	if not arg_8_0.hasPlayer then
		arg_8_0.playerTF = arg_8_0:GetPlayer()

		arg_8_0:CheckPlayer()
	else
		local var_8_0 = arg_8_0:CheckIsNear()

		if var_8_0 == arg_8_0.isNear then
			return
		end

		arg_8_0.isNear = var_8_0

		for iter_8_0, iter_8_1 in ipairs({
			"title",
			"name"
		}) do
			arg_8_0:SetTFActive(iter_8_1, arg_8_0.isNear)
		end
	end

	return
end

function var_0_0.SetTFActive(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_0.tfDic[arg_9_1]

	if IsNil(arg_9_0.tfDic[arg_9_1]) then
		return
	end

	if arg_9_0.activeTFDic[arg_9_1] == arg_9_2 then
		return
	end

	arg_9_0.activeTFDic[arg_9_1] = arg_9_2

	local var_9_1 = arg_9_0.tfDic[arg_9_1]:GetComponent(typeof(Animation))

	if arg_9_2 then
		var_9_1:Play("anim_IslandNormalNpcHud_in")

		if arg_9_1 == "hudImage" then
			arg_9_0:UpdateTaskDisplay()
		else
			setActive(arg_9_0.tfDic[arg_9_1], true)
		end
	else
		var_9_1:Play("anim_IslandNormalNpcHud_out")
		arg_9_0.tfDic[arg_9_1]:GetComponent("DftAniEvent"):SetEndEvent(function(arg_10_0)
			if arg_9_1 == "hudImage" then
				arg_9_0:UpdateTaskDisplay()
			else
				setActive(var_9_0, false)
			end

			return
		end)
	end

	return
end

function var_0_0.RefreshHud(arg_11_0)
	arg_11_0:UpdateTaskDisplay()

	return
end

function var_0_0.UpdateTaskDisplay(arg_12_0)
	if IsNil(arg_12_0.hudImageBg) then
		return
	end

	local var_12_0, var_12_1 = IslandObjectTaskHudHelper.GetObjectTaskHud(arg_12_0.unitId)

	if arg_12_0.currentTaskId ~= var_12_1 then
		arg_12_0.currentTaskId = var_12_1

		if var_12_1 then
			local var_12_2, var_12_3 = IslandObjectTaskHudHelper.GetHudDislayInfoByTaskId(var_12_1)

			setActive(arg_12_0.hudImageBg, true)
			GetImageSpriteFromAtlasAsync("island/IslandHudIcon", var_12_2, arg_12_0.hudImageBg)
			setImageColor(arg_12_0.hudImageTF, Color.NewHex(var_12_3))
		else
			setActive(arg_12_0.hudImageBg, arg_12_0.hudImageIcon ~= "")
			GetImageSpriteFromAtlasAsync("island/IslandHudIcon", "hud_main", arg_12_0.hudImageBg)
			setImageColor(arg_12_0.hudImageTF, Color.NewHex("78787a"))
		end
	end

	if var_12_0 ~= arg_12_0.currentTaskType then
		arg_12_0.currentTaskType = var_12_0

		local var_12_4 = IslandObjectTaskHudHelper.TaskProcessToHudIcon[var_12_0] or arg_12_0.hudImageIcon

		setActive(arg_12_0.hudImageBg, var_12_4 ~= "")

		if var_12_4 ~= "" then
			GetImageSpriteFromAtlasAsync("island/IslandHudIcon", var_12_4, arg_12_0.hudImageTF)
		end
	end

	return
end

function var_0_0.Show(arg_13_0)
	if not arg_13_0._tf or arg_13_0.active == true then
		return
	end

	arg_13_0.active = true

	setActive(arg_13_0._tf, true)

	for iter_13_0, iter_13_1 in ipairs({
		"hudImage",
		"title",
		"name"
	}) do
		arg_13_0:SetTFActive(iter_13_1, true)
	end

	return
end

function var_0_0.Hide(arg_14_0)
	if not arg_14_0._tf then
		return
	end

	arg_14_0.active = false

	for iter_14_0, iter_14_1 in ipairs({
		"hudImage",
		"title",
		"name"
	}) do
		arg_14_0:SetTFActive(iter_14_1, false)
	end

	return
end

return var_0_0
