local var_0_0 = class("WSMapTop", import("...BaseEntity"))

var_0_0.Fields = {
	map = "table",
	btnBack = "userdata",
	rtGlobalBuffs = "userdata",
	gid = "number",
	rtResource = "userdata",
	rtTime = "userdata",
	cmdSkills = "table",
	rtFleetBuffs = "userdata",
	flashTimer = "table",
	entrance = "table",
	rtCmdSkills = "userdata",
	fleet = "table",
	rtPoisonRate = "userdata",
	rtMapName = "userdata",
	rtFlashTipWord = "userdata",
	cmdSkillFunc = "function",
	fleetBuffItemList = "table",
	world = "table",
	transform = "userdata",
	globalBuffItemList = "table",
	cmdSkillItemList = "table",
	globalBuffs = "table",
	poisonFunc = "function",
	fleetBuffs = "table",
	rtMoveLimit = "userdata"
}
var_0_0.Listeners = {
	onUpdateFleetBuff = "OnUpdateFleetBuff",
	onUpdateGlobalBuff = "OnUpdateGlobalBuff",
	onUpdateFlashTips = "OnUpdateFlashTips",
	onUpdateCmdSkill = "OnUpdateCmdSkill",
	onUpdateSelectedFleet = "OnUpdateSelectedFleet"
}

function var_0_0.Setup(arg_1_0)
	local var_1_0 = nowWorld()

	var_1_0:AddListener(World.EventUpdateGlobalBuff, arg_1_0.onUpdateGlobalBuff)
	var_1_0:GetAtlas():AddListener(WorldAtlas.EventUpdateActiveMap, arg_1_0.onUpdateFleetBuff)
	pg.DelegateInfo.New(arg_1_0)
	arg_1_0:Init()

	return
end

function var_0_0.Dispose(arg_2_0)
	if arg_2_0.flashTimer then
		arg_2_0.flashTimer.func()
	end

	local var_2_0 = nowWorld()

	var_2_0:RemoveListener(World.EventUpdateGlobalBuff, arg_2_0.onUpdateGlobalBuff)
	var_2_0:GetAtlas():RemoveListener(WorldAtlas.EventUpdateActiveMap, arg_2_0.onUpdateFleetBuff)
	arg_2_0:RemoveFleetListener(arg_2_0.fleet)
	arg_2_0:RemoveMapListener()
	pg.DelegateInfo.Dispose(arg_2_0)
	arg_2_0:Clear()

	return
end

local function var_0_1(arg_3_0, arg_3_1)
	if arg_3_1.config.icon and #arg_3_1.config.icon > 0 then
		GetImageSpriteFromAtlasAsync("world/buff/" .. arg_3_1.config.icon, "", arg_3_0:Find("icon"))
	else
		clearImageSprite(arg_3_0:Find("icon"))
	end

	setText(arg_3_0:Find("floor"), arg_3_1:GetFloor())
	setActive(arg_3_0:Find("floor"), arg_3_1.config.buff_maxfloor > 1)

	local var_3_0 = arg_3_1:GetLost()

	setText(arg_3_0:Find("lost"), var_3_0)
	setActive(arg_3_0:Find("lost"), var_3_0)
	onButton(self, arg_3_0, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			yesText = "text_confirm",
			hideNo = true,
			content = "",
			type = MSGBOX_TYPE_SINGLE_ITEM,
			drop = Drop.New({
				isWorldBuff = true,
				type = DROP_TYPE_STRATEGY,
				id = arg_3_1.id
			})
		})

		return
	end, SFX_PANEL)

	return
end

function var_0_0.Init(arg_5_0)
	arg_5_0.btnBack = arg_5_0.transform:Find("back_button")
	arg_5_0.rtMapName = arg_5_0.transform:Find("title/name")
	arg_5_0.rtTime = arg_5_0.transform:Find("title/time")
	arg_5_0.rtResource = arg_5_0.transform:Find("resources")
	arg_5_0.rtGlobalBuffs = arg_5_0.transform:Find("features/status_field/global_buffs")
	arg_5_0.rtMoveLimit = arg_5_0.transform:Find("features/status_field/move_limit")
	arg_5_0.rtPoisonRate = arg_5_0.transform:Find("features/status_field/poison_rate")
	arg_5_0.rtFleetBuffs = arg_5_0.transform:Find("features/fleet_field/fleet_buffs")
	arg_5_0.rtCmdSkills = arg_5_0.transform:Find("features/fleet_field/cmd_skills")
	arg_5_0.rtFlashTipWord = arg_5_0.transform:Find("flash_tip_word")

	setActive(arg_5_0.rtFlashTipWord, false)
	setText(arg_5_0.rtMapName, "")
	setText(arg_5_0.rtTime, "")

	arg_5_0.globalBuffItemList = UIItemList.New(arg_5_0.rtGlobalBuffs, arg_5_0.rtGlobalBuffs:GetChild(0))

	arg_5_0.globalBuffItemList:make(function(arg_6_0, arg_6_1, arg_6_2)
		if arg_6_0 == UIItemList.EventUpdate then
			var_0_1(arg_6_2, arg_5_0.globalBuffs[arg_6_1 + 1])
		end

		return
	end)

	arg_5_0.fleetBuffItemList = UIItemList.New(arg_5_0.rtFleetBuffs, arg_5_0.rtFleetBuffs:GetChild(0))

	arg_5_0.fleetBuffItemList:make(function(arg_7_0, arg_7_1, arg_7_2)
		if arg_7_0 == UIItemList.EventUpdate then
			var_0_1(arg_7_2, arg_5_0.fleetBuffs[arg_7_1 + 1])
		end

		return
	end)

	arg_5_0.cmdSkillItemList = UIItemList.New(arg_5_0.rtCmdSkills, arg_5_0.rtCmdSkills:GetChild(0))

	arg_5_0.cmdSkillItemList:make(function(arg_8_0, arg_8_1, arg_8_2)
		if arg_8_0 == UIItemList.EventUpdate then
			local var_8_0 = arg_5_0.cmdSkills[arg_8_1 + 1]

			GetImageSpriteFromAtlasAsync("commanderskillicon/" .. arg_5_0.cmdSkills[arg_8_1 + 1]:getConfig("icon"), "", arg_8_2:Find("icon"))
			setText(arg_8_2:Find("floor"), "Lv." .. arg_5_0.cmdSkills[arg_8_1 + 1]:getConfig("lv"))
			setActive(arg_8_2:Find("floor"), true)
			setActive(arg_8_2:Find("lost"), false)
			onButton(arg_5_0, arg_8_2, function()
				arg_5_0.cmdSkillFunc(var_8_0)

				return
			end, SFX_PANEL)
		end

		return
	end)

	return
end

function var_0_0.Update(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_0.entrance ~= arg_10_1 or arg_10_0.map ~= arg_10_2 or arg_10_0.gid ~= arg_10_2.gid then
		arg_10_0:RemoveMapListener()

		arg_10_0.entrance = arg_10_1
		arg_10_0.map = arg_10_2
		arg_10_0.gid = arg_10_2.gid

		arg_10_0:AddMapListener()
		arg_10_0:OnUpdateMap()
		arg_10_0:OnUpdateSelectedFleet()
		arg_10_0:OnUpdateGlobalBuff()
		arg_10_0:OnUpdatePoison()
		arg_10_0:OnUpdateMoveLimit()
	end

	return
end

function var_0_0.AddMapListener(arg_11_0)
	if arg_11_0.map then
		arg_11_0.map:AddListener(WorldMap.EventUpdateFIndex, arg_11_0.onUpdateSelectedFleet)
	end

	return
end

function var_0_0.RemoveMapListener(arg_12_0)
	if arg_12_0.map then
		arg_12_0.map:RemoveListener(WorldMap.EventUpdateFIndex, arg_12_0.onUpdateSelectedFleet)
	end

	return
end

function var_0_0.AddFleetListener(arg_13_0, arg_13_1)
	if arg_13_1 then
		arg_13_1:AddListener(WorldMapFleet.EventUpdateBuff, arg_13_0.onUpdateFleetBuff)
		arg_13_1:AddListener(WorldMapFleet.EventUpdateDamageLevel, arg_13_0.onUpdateFleetBuff)
		arg_13_1:AddListener(WorldMapFleet.EventUpdateCatSalvage, arg_13_0.onUpdateCmdSkill)
		arg_13_1:AddListener(WorldMapFleet.EventUpdateFlashTips, arg_13_0.onUpdateFlashTips)
	end

	return
end

function var_0_0.RemoveFleetListener(arg_14_0, arg_14_1)
	if arg_14_1 then
		arg_14_1:RemoveListener(WorldMapFleet.EventUpdateBuff, arg_14_0.onUpdateFleetBuff)
		arg_14_1:RemoveListener(WorldMapFleet.EventUpdateDamageLevel, arg_14_0.onUpdateFleetBuff)
		arg_14_1:RemoveListener(WorldMapFleet.EventUpdateCatSalvage, arg_14_0.onUpdateCmdSkill)
		arg_14_1:RemoveListener(WorldMapFleet.EventUpdateFlashTips, arg_14_0.onUpdateFlashTips)
	end

	return
end

function var_0_0.OnUpdateMap(arg_15_0)
	setText(arg_15_0.rtMapName, arg_15_0.map:GetName(arg_15_0.entrance))

	return
end

function var_0_0.OnUpdateSelectedFleet(arg_16_0)
	local var_16_0 = arg_16_0.map:GetFleet()

	if arg_16_0.fleet ~= var_16_0 then
		arg_16_0:RemoveFleetListener(arg_16_0.fleet)

		arg_16_0.fleet = var_16_0

		arg_16_0:AddFleetListener(arg_16_0.fleet)
		arg_16_0:OnUpdateFleetBuff()
		arg_16_0:OnUpdateCmdSkill()
	end

	return
end

function var_0_0.OnUpdateGlobalBuff(arg_17_0)
	arg_17_0.globalBuffs = nowWorld():GetWorldMapBuffs()

	arg_17_0.globalBuffItemList:align(#arg_17_0.globalBuffs)

	return
end

function var_0_0.OnUpdateMoveLimit(arg_18_0)
	local var_18_0 = not arg_18_0.map:IsUnlockFleetMode()

	setActive(arg_18_0.rtMoveLimit, var_18_0)

	if var_18_0 then
		local var_18_1 = WorldBuff.New()

		var_18_1:Setup({
			floor = 0,
			id = WorldConst.MoveLimitBuffId
		})
		var_0_1(arg_18_0.rtMoveLimit, var_18_1)
	end

	return
end

function var_0_0.OnUpdatePoison(arg_19_0)
	local var_19_0, var_19_1 = arg_19_0.map:GetEventPoisonRate()

	setActive(arg_19_0.rtPoisonRate, var_19_1 > 0)

	if var_19_1 > 0 then
		local var_19_2 = calcFloor(var_19_0 / var_19_1 * 100)
		local var_19_3 = Clone(pg.gameset.world_sairen_infection.description)

		table.insert(var_19_3, 1, 0)
		table.insert(var_19_3, 999)
		eachChild(arg_19_0.rtPoisonRate:Find("bg/ring"), function(arg_20_0)
			local var_20_0 = arg_20_0:GetSiblingIndex() + 1

			if var_19_2 >= var_19_3[var_20_0] and var_19_2 < var_19_3[var_20_0 + 1] then
				setActive(arg_20_0, true)

				arg_20_0:GetComponent(typeof(Image)).fillAmount = var_19_2 / 100
			else
				setActive(arg_20_0, false)
			end

			setText(arg_19_0.rtPoisonRate:Find("bg/Text"), var_19_2 .. "%")

			return
		end)
		onButton(arg_19_0, arg_19_0.rtPoisonRate, function()
			arg_19_0.poisonFunc(var_19_2)

			return
		end, SFX_PANEL)
	end

	return
end

function var_0_0.OnUpdateFleetBuff(arg_22_0)
	arg_22_0.fleetBuffs = arg_22_0.fleet:GetBuffList()

	local var_22_0 = arg_22_0.fleet:GetDamageBuff()

	if var_22_0 then
		table.insert(arg_22_0.fleetBuffs, 1, var_22_0)
	end

	arg_22_0.fleetBuffItemList:align(#arg_22_0.fleetBuffs)
	setActive(arg_22_0.rtFleetBuffs, #arg_22_0.fleetBuffs > 0)

	return
end

function var_0_0.OnUpdateCmdSkill(arg_23_0)
	arg_23_0.cmdSkills = arg_23_0.fleet:IsCatSalvage() and {} or _.map(_.values(arg_23_0.fleet:getCommanders()), function(arg_24_0)
		return arg_24_0:getSkills()[1]
	end)

	arg_23_0.cmdSkillItemList:align(#arg_23_0.cmdSkills)
	setActive(arg_23_0.rtCmdSkills, #arg_23_0.cmdSkills > 0)

	return
end

function var_0_0.OnUpdateFlashTips(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	if arg_25_0.flashTimer then
		arg_25_0.flashTimer.func()
	end

	setActive(arg_25_0.rtFlashTipWord, true)
	quickPlayAnimation(arg_25_0.rtFlashTipWord, "anim_flash_tip_word_in")
	setText(arg_25_0.rtFlashTipWord:Find("Text"), HXSet.hxLan(arg_25_3))

	local var_25_0 = GetOrAddComponent(arg_25_0.rtFlashTipWord:Find("Text"), typeof(Typewriter))

	arg_25_0.flashTimer = Timer.New(function()
		if arg_25_0.flashTimer then
			arg_25_0.flashTimer:Stop()

			arg_25_0.flashTimer = nil
		end

		local function var_26_1()
			var_26_1 = nil

			setActive(arg_25_0.rtFlashTipWord, false)

			return
		end

		arg_25_0.rtFlashTipWord:GetComponent(typeof(DftAniEvent)):SetEndEvent(function()
			existCall(var_26_1)

			return
		end)
		quickPlayAnimation(arg_25_0.rtFlashTipWord, "anim_flash_tip_word_out")

		return
	end, getGameset("world_tip_last")[1])

	function var_25_0.endFunc()
		if arg_25_0.flashTimer then
			arg_25_0.flashTimer:Start()
		end

		return
	end

	var_25_0:setSpeed(getGameset("world_tip_typewriter")[2][1])
	var_25_0:Play()

	return
end

return var_0_0
