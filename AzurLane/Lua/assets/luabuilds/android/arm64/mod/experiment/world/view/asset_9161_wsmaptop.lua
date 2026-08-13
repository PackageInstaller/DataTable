class = var_0_10000

local var_0_0 = "WSMapTop"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...BaseEntity"))

var_0_1.Fields = {
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
var_0_1.Listeners = {
	onUpdateFleetBuff = "OnUpdateFleetBuff",
	onUpdateGlobalBuff = "OnUpdateGlobalBuff",
	onUpdateFlashTips = "OnUpdateFlashTips",
	onUpdateCmdSkill = "OnUpdateCmdSkill",
	onUpdateSelectedFleet = "OnUpdateSelectedFleet"
}

function var_0_1.Setup(arg_1_0)
	nowWorld = var_1_10001

	local var_1_0 = var_1_10001()
	local var_1_1 = var_1.AddListener

	World = var_1_10005

	var_1_1(var_1_0, var_1_10005.EventUpdateGlobalBuff, arg_1_0.onUpdateGlobalBuff)

	local var_1_2 = var_1:GetAtlas()
	local var_1_3 = var_2.AddListener

	WorldAtlas = var_5

	var_1_3(var_1_2, var_5.EventUpdateActiveMap, arg_1_0.onUpdateFleetBuff)

	pg = var_1_3

	var_1_3.DelegateInfo.New(arg_1_0)
	arg_1_0:Init()

	return
end

function var_0_1.Dispose(arg_2_0)
	if arg_2_0.flashTimer then
		arg_2_0.flashTimer.func()
	end

	nowWorld = var_1

	local var_2_0 = var_1()
	local var_2_1 = var_1.RemoveListener

	World = var_1_10005

	var_2_1(var_2_0, var_1_10005.EventUpdateGlobalBuff, arg_2_0.onUpdateGlobalBuff)

	local var_2_2 = var_1:GetAtlas()
	local var_2_3 = var_2.RemoveListener

	WorldAtlas = var_5

	var_2_3(var_2_2, var_5.EventUpdateActiveMap, arg_2_0.onUpdateFleetBuff)
	arg_2_0:RemoveFleetListener(arg_2_0.fleet)
	arg_2_0:RemoveMapListener()

	pg = var_2

	var_2.DelegateInfo.Dispose(arg_2_0)
	arg_2_0:Clear()

	return
end

local function var_0_2(arg_3_0, arg_3_1)
	local var_3_0

	if arg_3_1.config.icon then
		var_3_0 = #arg_3_1.config.icon

		if 0 < var_3_0 then
			GetImageSpriteFromAtlasAsync = var_3_0

			var_3_0("world/buff/" .. arg_3_1.config.icon, "", arg_3_0:Find("icon"))

			goto label_3_0
		end
	end

	clearImageSprite = var_3_0

	var_3_0(arg_3_0:Find("icon"))

	::label_3_0::

	setText = var_3_0

	var_3_0(arg_3_0:Find("floor"), arg_3_1:GetFloor())

	setActive = var_3_0

	var_3_0(arg_3_0:Find("floor"), arg_3_1.config.buff_maxfloor > 1)

	local var_3_1 = arg_3_1:GetLost()

	setText = var_1_10003

	var_1_10003(arg_3_0:Find("lost"), var_3_1)

	setActive = var_1_10003

	var_1_10003(arg_3_0:Find("lost"), var_3_1)

	onButton = var_1_10003
	self = var_5

	local var_3_2 = arg_3_0

	local function var_3_3()
		pg = var_2_10000

		local var_4_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_4_1 = var_0.ShowMsgBox
		local var_4_2 = {
			yesText = "text_confirm",
			hideNo = true,
			content = ""
		}

		MSGBOX_TYPE_SINGLE_ITEM = var_2_10004
		var_4_2.type = var_2_10004
		Drop = var_2_10004

		local var_4_3 = var_2_10004.New
		local var_4_4 = {
			isWorldBuff = true
		}

		DROP_TYPE_STRATEGY = var_2_10007
		var_4_4.type = var_2_10007
		var_4_4.id = arg_3_1.id
		var_4_2.drop = var_4_3(var_4_4)

		var_4_1(var_4_0, var_4_2)

		return
	end

	SFX_PANEL = var_8

	var_1_10003(var_5, var_3_2, var_3_3, var_8)

	return
end

function var_0_1.Init(arg_5_0)
	local var_5_0 = arg_5_0.transform

	arg_5_0.btnBack = var_1.Find(var_5_0, "back_button")
	arg_5_0.rtMapName = var_1:Find("title/name")
	arg_5_0.rtTime = var_1:Find("title/time")
	arg_5_0.rtResource = var_1:Find("resources")
	arg_5_0.rtGlobalBuffs = var_1:Find("features/status_field/global_buffs")
	arg_5_0.rtMoveLimit = var_1:Find("features/status_field/move_limit")
	arg_5_0.rtPoisonRate = var_1:Find("features/status_field/poison_rate")
	arg_5_0.rtFleetBuffs = var_1:Find("features/fleet_field/fleet_buffs")
	arg_5_0.rtCmdSkills = var_1:Find("features/fleet_field/cmd_skills")
	arg_5_0.rtFlashTipWord = var_1:Find("flash_tip_word")
	setActive = var_2

	var_2(arg_5_0.rtFlashTipWord, false)

	setText = var_2

	var_2(arg_5_0.rtMapName, "")

	setText = var_2

	var_2(arg_5_0.rtTime, "")

	UIItemList = var_2

	local var_5_1 = var_2.New
	local var_5_2 = arg_5_0.rtGlobalBuffs
	local var_5_3 = arg_5_0.rtGlobalBuffs

	arg_5_0.globalBuffItemList = var_5_1(var_5_2, var_5.GetChild(var_5_3, 0))

	local var_5_4 = arg_5_0.globalBuffItemList

	var_2.make(var_5_4, function(arg_6_0, arg_6_1, arg_6_2)
		UIItemList = var_2_10003

		if arg_6_0 == var_2_10003.EventUpdate then
			var_0_2(arg_6_2, arg_5_0.globalBuffs[arg_6_1 + 1])
		end

		return
	end)

	UIItemList = var_2

	local var_5_5 = var_2.New
	local var_5_6 = arg_5_0.rtFleetBuffs
	local var_5_7 = arg_5_0.rtFleetBuffs

	arg_5_0.fleetBuffItemList = var_5_5(var_5_6, var_5.GetChild(var_5_7, 0))

	local var_5_8 = arg_5_0.fleetBuffItemList

	var_2.make(var_5_8, function(arg_7_0, arg_7_1, arg_7_2)
		UIItemList = var_2_10003

		if arg_7_0 == var_2_10003.EventUpdate then
			var_0_2(arg_7_2, arg_5_0.fleetBuffs[arg_7_1 + 1])
		end

		return
	end)

	UIItemList = var_2

	local var_5_9 = var_2.New
	local var_5_10 = arg_5_0.rtCmdSkills
	local var_5_11 = arg_5_0.rtCmdSkills

	arg_5_0.cmdSkillItemList = var_5_9(var_5_10, var_5.GetChild(var_5_11, 0))

	local var_5_12 = arg_5_0.cmdSkillItemList

	var_2.make(var_5_12, function(arg_8_0, arg_8_1, arg_8_2)
		UIItemList = var_2_10003

		if arg_8_0 == var_2_10003.EventUpdate then
			local var_8_0 = arg_5_0.cmdSkills[arg_8_1 + 1]

			GetImageSpriteFromAtlasAsync = var_4

			var_4("commanderskillicon/" .. var_8_0:getConfig("icon"), "", arg_8_2:Find("icon"))

			setText = var_4

			var_4(arg_8_2:Find("floor"), "Lv." .. var_8_0:getConfig("lv"))

			setActive = var_4

			var_4(arg_8_2:Find("floor"), true)

			setActive = var_4

			var_4(arg_8_2:Find("lost"), false)

			onButton = var_4

			local var_8_1 = arg_5_0
			local var_8_2 = arg_8_2

			local function var_8_3()
				arg_5_0.cmdSkillFunc(var_8_0)

				return
			end

			SFX_PANEL = var_9

			var_4(var_8_1, var_8_2, var_8_3, var_9)
		end

		return
	end)

	return
end

function var_0_1.Update(arg_10_0, arg_10_1, arg_10_2)
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

function var_0_1.AddMapListener(arg_11_0)
	if arg_11_0.map then
		local var_11_0 = arg_11_0.map
		local var_11_1 = var_1.AddListener

		WorldMap = var_1_10004

		var_11_1(var_11_0, var_1_10004.EventUpdateFIndex, arg_11_0.onUpdateSelectedFleet)
	end

	return
end

function var_0_1.RemoveMapListener(arg_12_0)
	if arg_12_0.map then
		local var_12_0 = arg_12_0.map
		local var_12_1 = var_1.RemoveListener

		WorldMap = var_1_10004

		var_12_1(var_12_0, var_1_10004.EventUpdateFIndex, arg_12_0.onUpdateSelectedFleet)
	end

	return
end

function var_0_1.AddFleetListener(arg_13_0, arg_13_1)
	if arg_13_1 then
		local var_13_0 = arg_13_1
		local var_13_1 = arg_13_1.AddListener

		WorldMapFleet = var_1_10005

		var_13_1(var_13_0, var_1_10005.EventUpdateBuff, arg_13_0.onUpdateFleetBuff)

		local var_13_2 = arg_13_1
		local var_13_3 = arg_13_1.AddListener

		WorldMapFleet = var_5

		var_13_3(var_13_2, var_5.EventUpdateDamageLevel, arg_13_0.onUpdateFleetBuff)

		local var_13_4 = arg_13_1
		local var_13_5 = arg_13_1.AddListener

		WorldMapFleet = var_5

		var_13_5(var_13_4, var_5.EventUpdateCatSalvage, arg_13_0.onUpdateCmdSkill)

		local var_13_6 = arg_13_1
		local var_13_7 = arg_13_1.AddListener

		WorldMapFleet = var_5

		var_13_7(var_13_6, var_5.EventUpdateFlashTips, arg_13_0.onUpdateFlashTips)
	end

	return
end

function var_0_1.RemoveFleetListener(arg_14_0, arg_14_1)
	if arg_14_1 then
		local var_14_0 = arg_14_1
		local var_14_1 = arg_14_1.RemoveListener

		WorldMapFleet = var_1_10005

		var_14_1(var_14_0, var_1_10005.EventUpdateBuff, arg_14_0.onUpdateFleetBuff)

		local var_14_2 = arg_14_1
		local var_14_3 = arg_14_1.RemoveListener

		WorldMapFleet = var_5

		var_14_3(var_14_2, var_5.EventUpdateDamageLevel, arg_14_0.onUpdateFleetBuff)

		local var_14_4 = arg_14_1
		local var_14_5 = arg_14_1.RemoveListener

		WorldMapFleet = var_5

		var_14_5(var_14_4, var_5.EventUpdateCatSalvage, arg_14_0.onUpdateCmdSkill)

		local var_14_6 = arg_14_1
		local var_14_7 = arg_14_1.RemoveListener

		WorldMapFleet = var_5

		var_14_7(var_14_6, var_5.EventUpdateFlashTips, arg_14_0.onUpdateFlashTips)
	end

	return
end

function var_0_1.OnUpdateMap(arg_15_0)
	setText = var_1_10001

	local var_15_0 = arg_15_0.rtMapName
	local var_15_1 = arg_15_0.map

	var_1_10001(var_15_0, var_4.GetName(var_15_1, arg_15_0.entrance))

	return
end

function var_0_1.OnUpdateSelectedFleet(arg_16_0)
	local var_16_0 = arg_16_0.map
	local var_16_1 = var_1.GetFleet(var_16_0)

	if arg_16_0.fleet ~= var_16_1 then
		arg_16_0:RemoveFleetListener(arg_16_0.fleet)

		arg_16_0.fleet = var_16_1

		arg_16_0:AddFleetListener(arg_16_0.fleet)
		arg_16_0:OnUpdateFleetBuff()
		arg_16_0:OnUpdateCmdSkill()
	end

	return
end

function var_0_1.OnUpdateGlobalBuff(arg_17_0)
	nowWorld = var_1_10001

	local var_17_0 = var_1_10001()

	arg_17_0.globalBuffs = var_1.GetWorldMapBuffs(var_17_0)

	local var_17_1 = arg_17_0.globalBuffItemList

	var_1.align(var_17_1, #arg_17_0.globalBuffs)

	return
end

function var_0_1.OnUpdateMoveLimit(arg_18_0)
	local var_18_0 = arg_18_0.map
	local var_18_1 = not var_1.IsUnlockFleetMode(var_18_0)

	setActive = var_1_10002

	var_1_10002(arg_18_0.rtMoveLimit, var_18_1)

	if var_18_1 then
		WorldBuff = var_1_10002

		local var_18_2 = var_1_10002.New()
		local var_18_3 = var_2.Setup
		local var_18_4 = {
			floor = 0
		}

		WorldConst = var_1_10007
		var_18_4.id = var_1_10007.MoveLimitBuffId

		var_18_3(var_18_2, var_18_4)
		var_0_2(arg_18_0.rtMoveLimit, var_2)
	end

	return
end

function var_0_1.OnUpdatePoison(arg_19_0)
	local var_19_0 = arg_19_0.map
	local var_19_1, var_19_2 = var_1.GetEventPoisonRate(var_19_0)

	setActive = var_19_0

	var_19_0(arg_19_0.rtPoisonRate, var_19_2 > 0)

	if 0 < var_19_2 then
		calcFloor = var_3

		local var_19_3 = var_3(var_19_1 / var_19_2 * 100)

		Clone = var_1_10004
		pg = var_6

		local var_19_4 = var_1_10004(var_6.gameset.world_sairen_infection.description)

		table = var_5

		var_5.insert(var_19_4, 1, 0)

		table = var_5

		var_5.insert(var_19_4, 999)

		eachChild = var_5

		local var_19_5 = arg_19_0.rtPoisonRate

		var_5(var_7.Find(var_19_5, "bg/ring"), function(arg_20_0)
			local var_20_0 = arg_20_0:GetSiblingIndex() + 1
			local var_20_2

			if var_19_3 >= var_19_4[var_20_0] and var_19_3 < var_19_4[var_20_0 + 1] then
				setActive = var_20_2

				var_20_2(arg_20_0, true)

				local var_20_1 = arg_20_0

				var_20_2 = arg_20_0.GetComponent
				typeof = var_5
				Image = var_2_10007
				var_20_2 = var_20_2(var_20_1, var_5(var_2_10007))
				var_20_2.fillAmount = var_19_3 / 100
			else
				setActive = var_20_2

				var_20_2(arg_20_0, false)
			end

			setText = var_20_2

			local var_20_3 = arg_19_0.rtPoisonRate

			var_20_2(var_4.Find(var_20_3, "bg/Text"), var_19_3 .. "%")

			return
		end)

		onButton = var_5

		local var_19_6 = arg_19_0
		local var_19_7 = arg_19_0.rtPoisonRate

		local function var_19_8()
			arg_19_0.poisonFunc(var_19_3)

			return
		end

		SFX_PANEL = var_10

		var_5(var_19_6, var_19_7, var_19_8, var_10)
	end

	return
end

function var_0_1.OnUpdateFleetBuff(arg_22_0)
	local var_22_0 = arg_22_0.fleet

	arg_22_0.fleetBuffs = var_1.GetBuffList(var_22_0)

	local var_22_1 = arg_22_0.fleet

	if var_1.GetDamageBuff(var_22_1) then
		table = var_1_10002

		var_1_10002.insert(arg_22_0.fleetBuffs, 1, var_1)
	end

	local var_22_2 = arg_22_0.fleetBuffItemList

	var_2.align(var_22_2, #arg_22_0.fleetBuffs)

	setActive = var_2

	var_2(arg_22_0.rtFleetBuffs, #arg_22_0.fleetBuffs > 0)

	return
end

function var_0_1.OnUpdateCmdSkill(arg_23_0)
	local var_23_0 = arg_23_0.fleet

	if var_1.IsCatSalvage(var_23_0) then
		arg_23_0.cmdSkills = {}
	else
		_ = var_1

		local var_23_1 = var_1.map

		_ = var_23_0

		local var_23_2 = var_23_0.values
		local var_23_3 = arg_23_0.fleet

		arg_23_0.cmdSkills = var_23_1(var_23_2(var_5.getCommanders(var_23_3)), function(arg_24_0)
			return arg_24_0:getSkills()[1]
		end)
	end

	local var_23_4 = arg_23_0.cmdSkillItemList

	var_1.align(var_23_4, #arg_23_0.cmdSkills)

	setActive = var_1

	var_1(arg_23_0.rtCmdSkills, #arg_23_0.cmdSkills > 0)

	return
end

function var_0_1.OnUpdateFlashTips(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	if arg_25_0.flashTimer then
		arg_25_0.flashTimer.func()
	end

	setActive = var_4

	var_4(arg_25_0.rtFlashTipWord, true)

	quickPlayAnimation = var_4

	var_4(arg_25_0.rtFlashTipWord, "anim_flash_tip_word_in")

	setText = var_4

	local var_25_0 = arg_25_0.rtFlashTipWord
	local var_25_1 = var_6.Find(var_25_0, "Text")

	HXSet = var_7

	var_4(var_25_1, var_7.hxLan(arg_25_3))

	GetOrAddComponent = var_4

	local var_25_2 = arg_25_0.rtFlashTipWord
	local var_25_3 = var_6.Find(var_25_2, "Text")

	typeof = var_7
	Typewriter = var_9

	local var_25_4 = var_4(var_25_3, var_7(var_9))

	Timer = var_1_10005

	local var_25_5 = var_1_10005.New

	local function var_25_6()
		if arg_25_0.flashTimer then
			local var_26_0 = arg_25_0.flashTimer

			var_0.Stop(var_26_0)

			arg_25_0.flashTimer = nil
		end

		local var_26_1

		local function var_26_2()
			var_26_2 = nil
			setActive = var_3_10000

			var_3_10000(arg_25_0.rtFlashTipWord, false)

			return
		end

		local var_26_3 = arg_25_0.rtFlashTipWord
		local var_26_4 = var_1.GetComponent

		typeof = var_2_10004
		DftAniEvent = var_2_10006

		local var_26_5 = var_26_4(var_26_3, var_2_10004(var_2_10006))

		var_1.SetEndEvent(var_26_5, function()
			existCall = var_3_10000

			var_3_10000(var_26_2)

			return
		end)

		quickPlayAnimation = var_1

		var_1(arg_25_0.rtFlashTipWord, "anim_flash_tip_word_out")

		return
	end

	getGameset = var_25_2
	arg_25_0.flashTimer = var_25_5(var_25_6, var_25_2("world_tip_last")[1])

	function var_25_4.endFunc()
		if arg_25_0.flashTimer then
			local var_29_0 = arg_25_0.flashTimer

			var_0.Start(var_29_0)
		end

		return
	end

	local var_25_7 = var_25_4
	local var_25_8 = var_25_4.setSpeed

	getGameset = var_8

	var_25_8(var_25_7, var_8("world_tip_typewriter")[2][1])
	var_25_4:Play()

	return
end

return var_0_1
