class = var_0_10000

local var_0_0 = "GuildAppiontPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".GuildMemberBasePage"))

function var_0_1.getUIName(arg_1_0)
	return "GuildAppiontPage"
end

local var_0_2 = {
	"commander",
	"deputyCommander",
	"picked",
	"normal"
}

function var_0_1.OnLoaded(arg_2_0)
	var_0_1.super.OnLoaded(arg_2_0)

	local var_2_0 = arg_2_0._tf

	arg_2_0.dutyContainer = var_1.Find(var_2_0, "frame/duty")

	local var_2_1 = arg_2_0._tf
	local var_2_2 = var_1.Find(var_2_1, "frame/prints/print")
	local var_2_3 = var_1.GetComponent

	typeof = var_3
	Image = var_1_10004
	arg_2_0.print = var_2_3(var_2_2, var_3(var_1_10004))

	local var_2_4 = arg_2_0._tf

	arg_2_0.confirmBtn = var_1.Find(var_2_4, "frame/confirm_btn")

	local var_2_5 = arg_2_0._tf
	local var_2_6 = var_1.Find(var_2_5, "frame/info/name/Text")
	local var_2_7 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.nameTF = var_2_7(var_2_6, var_3(var_1_10004))

	local var_2_8 = arg_2_0._tf
	local var_2_9 = var_1.Find(var_2_8, "frame/info/shipicon/icon")
	local var_2_10 = var_1.GetComponent

	typeof = var_3
	Image = var_1_10004
	arg_2_0.iconTF = var_2_10(var_2_9, var_3(var_1_10004))

	local var_2_11 = arg_2_0._tf

	arg_2_0.starsTF = var_1.Find(var_2_11, "frame/info/shipicon/stars")

	local var_2_12 = arg_2_0._tf

	arg_2_0.starTF = var_1.Find(var_2_12, "frame/info/shipicon/stars/star")

	local var_2_13 = arg_2_0._tf
	local var_2_14 = var_1.Find(var_2_13, "frame/info/level/Text")
	local var_2_15 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.levelTF = var_2_15(var_2_14, var_3(var_1_10004))

	local var_2_16 = arg_2_0._tf

	arg_2_0.circle = var_1.Find(var_2_16, "frame/info/shipicon/frame")

	local var_2_17 = arg_2_0._tf
	local var_2_18 = var_1.Find(var_2_17, "frame/duty")
	local var_2_19 = var_1.GetComponent

	typeof = var_3
	ToggleGroup = var_1_10004
	arg_2_0.toggles = var_2_19(var_2_18, var_3(var_1_10004))

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0._tf

	local function var_3_2()
		local var_4_0 = arg_3_0

		var_0.Hide(var_4_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10005)

	return
end

function var_0_1.ShouldShow(arg_5_0)
	return arg_5_0.memberVO.id ~= arg_5_0.playerVO.id
end

function var_0_1.OnShow(arg_6_0)
	local var_6_0 = arg_6_0.playerVO
	local var_6_1 = arg_6_0.memberVO
	local var_6_2 = arg_6_0.guildVO
	local var_6_3 = var_3.getDutyByMemberId(var_6_2, var_6_0.id)
	local var_6_4 = var_3:getEnableDuty(var_6_3, var_6_1.duty)
	local var_6_5 = var_3:getAssistantMaxCount()
	local var_6_6 = var_3:getAssistantCount()
	local var_6_7

	ipairs = var_1_10009

	for iter_6_0, iter_6_1 in var_1_10009(var_0_2) do
		var_1_10015 = arg_6_0.dutyContainer

		local var_6_8 = var_1_10014.Find(var_1_10015, iter_6_1)

		var_1_10015 = var_1_10014.Find(var_6_8, "Text")

		local var_6_9 = false

		if var_6_1.duty == iter_6_0 then
			setText = var_17

			local var_6_10 = var_1_10015

			i18n = var_1_10019

			var_17(var_6_10, var_1_10019("guild_duty_tip_1"))

			var_6_9 = true
		else
			table = var_17

			if not var_17.contains(var_6_4, iter_6_0) then
				if var_6_5 <= var_6_6 and iter_6_0 == 2 then
					setText = var_17

					local var_6_11 = var_1_10015

					i18n = var_1_10019

					var_17(var_6_11, var_1_10019("guild_deputy_commander_cnt_is_full"))
				else
					setText = var_17

					local var_6_12 = var_1_10015

					i18n = var_1_10019

					var_17(var_6_12, var_1_10019("guild_duty_tip_2"))
				end

				var_6_9 = true
			end
		end

		setActive = var_17

		local var_6_13 = var_1_10015

		table = var_1_10019

		var_17(var_6_13, not var_1_10019.contains(var_6_4, iter_6_0))

		GuildConst = var_17

		if var_6_3 == var_17.DUTY_COMMANDER and iter_6_0 == 2 and not var_6_9 then
			if var_6_5 <= var_6_6 then
				setText = var_17

				local var_6_14 = var_1_10015

				i18n = var_1_10019

				var_17(var_6_14, var_1_10019("guild_deputy_commander_cnt_is_full"))
			else
				setText = var_17

				local var_6_15 = var_1_10015

				i18n = var_1_10019

				var_17(var_6_15, var_1_10019("guild_deputy_commander_cnt", var_6_6, var_6_5))
			end

			setActive = var_17

			var_17(var_1_10015, true)
		end

		setToggleEnabled = var_17

		local var_6_16 = var_1_10014

		table = var_1_10019

		var_17(var_6_16, var_1_10019.contains(var_6_4, iter_6_0))

		onToggle = var_17

		local var_6_17 = arg_6_0

		var_1_10019 = var_1_10014

		local function var_6_18(arg_7_0)
			if arg_7_0 then
				var_6_7 = iter_6_0
				arg_6_0.selectedToggle = var_1_10014
			end

			return
		end

		SFX_PANEL = var_21

		var_17(var_6_17, var_1_10019, var_6_18, var_21)
	end

	local var_6_19 = arg_6_0.dutyContainer
	local var_6_20 = var_9.Find(var_6_19, "commander/Image2")

	GuildConst = var_6_19

	if var_6_3 == var_6_19.DUTY_COMMANDER then
		local var_6_21 = var_6_1.duty

		GuildConst = var_11

		if var_6_21 > var_11.DUTY_DEPUTY_COMMANDER then
			onButton = var_6_21

			local var_6_22 = arg_6_0

			iter_6_0 = var_6_20

			function iter_6_1()
				pg = var_2_10000

				local var_8_0 = var_2_10000.TipsMgr.GetInstance()
				local var_8_1 = var_0.ShowTips

				i18n = var_2_10002

				var_8_1(var_8_0, var_2_10002("guild_duty_shoule_be_deputy_commander"))

				return
			end

			SFX_PANEL = var_1_10014

			var_6_21(var_6_22, iter_6_0, iter_6_1, var_1_10014)

			goto label_6_0
		end
	end

	do
		local var_6_23 = var_6_20
		local var_6_24 = var_6_20.GetComponent

		typeof = iter_6_0
		Button = iter_6_1

		local var_6_25 = var_6_24(var_6_23, iter_6_0(iter_6_1))

		IsNil = var_6_23

		if not var_6_23(var_6_25) then
			Object = var_11

			var_11.Destroy(var_6_25)
		end
	end

	::label_6_0::

	local var_6_26 = var_3
	local var_6_27 = var_3.getFaction(var_6_26)

	GuildConst = var_6_26

	local var_6_28

	if var_6_27 == var_6_26.FACTION_TYPE_BLHX then
		var_6_28 = arg_6_0.print
		Color = iter_6_0
		var_6_28.color = iter_6_0.New(0.4235294117647059, 0.6313725490196078, 0.9568627450980393)
	else
		GuildConst = var_6_28

		if var_6_27 == var_6_28.FACTION_TYPE_CSZZ then
			local var_6_29 = arg_6_0.print

			Color = iter_6_0
			var_6_29.color = iter_6_0.New(0.9568627450980393, 0.44313725490196076, 0.42745098039215684)
		end
	end

	local var_6_30 = arg_6_0.nameTF

	var_6_30.text = var_6_1.name
	AttireFrame = var_6_30

	local var_6_31 = var_6_30.attireFrameRes
	local var_6_32 = var_6_1
	local var_6_33 = var_6_1.id

	getProxy = var_1_10014
	PlayerProxy = var_1_10015

	local var_6_34 = var_1_10014(var_1_10015)
	local var_6_35 = var_6_33 == var_14.getRawData(var_6_34).id

	AttireConst = var_14

	local var_6_36 = var_6_31(var_6_32, var_6_35, var_14.TYPE_ICON_FRAME, var_6_1.propose)

	PoolMgr = var_6_32

	local var_6_37 = var_6_32.GetInstance()

	var_12.GetPrefab(var_6_37, "IconFrame/" .. var_6_36, var_6_36, true, function(arg_9_0)
		IsNil = var_2_10001

		if var_2_10001(arg_6_0._tf) then
			return
		end

		if arg_6_0.circle then
			arg_9_0.name = var_6_36
			findTF = var_1

			local var_9_0 = var_1(arg_9_0.transform, "icon")
			local var_9_1 = var_1.GetComponent

			typeof = var_2_10004
			Image = var_2_10005
			var_9_1(var_9_0, var_2_10004(var_2_10005)).raycastTarget = false
			setParent = var_3

			var_3(arg_9_0, arg_6_0.circle, false)
		else
			PoolMgr = var_1

			local var_9_2 = var_1.GetInstance()

			var_1.ReturnPrefab(var_9_2, "IconFrame/" .. var_6_36, var_6_36, arg_9_0)
		end

		return
	end)

	pg = var_12

	local var_6_38 = var_12.ship_data_statistics[var_6_1.icon]

	Ship = var_13

	local var_6_39 = var_13.New({
		configId = var_6_1.icon,
		skin_id = var_6_1.skinId
	})

	LoadSpriteAsync = var_14

	var_14("qicon/" .. var_6_39:getPainting(), function(arg_10_0)
		IsNil = var_2_10001

		if not var_2_10001(arg_6_0.iconTF) then
			arg_6_0.iconTF.sprite = arg_10_0
		end

		return
	end)

	for iter_6_2 = arg_6_0.starsTF.childCount, var_6_38.star - 1 do
		cloneTplTo = var_1_10019

		var_1_10019(arg_6_0.starTF, arg_6_0.starsTF)
	end

	for iter_6_3 = 1, var_14 do
		local var_6_40 = arg_6_0.starsTF

		var_1_10019 = var_1_10019.GetChild(var_6_40, iter_6_3 - 1)
		setActive = var_6_40

		var_6_40(var_1_10019, iter_6_3 <= var_6_38.star)
	end

	local var_6_41 = arg_6_0.levelTF

	var_6_41.text = "Lv." .. var_6_1.level
	onButton = var_6_41

	local var_6_42 = arg_6_0
	local var_6_43 = arg_6_0.confirmBtn

	local function var_6_44()
		local function var_11_0()
			local var_12_0 = arg_6_0
			local var_12_1 = var_0.emit

			GuildMemberMediator = var_3_10002

			var_12_1(var_12_0, var_3_10002.SET_DUTY, var_6_1.id, var_6_7)

			local var_12_2 = arg_6_0

			var_0.Hide(var_12_2)

			return
		end

		local var_11_1 = var_6_3

		GuildConst = var_2_10002

		if var_11_1 == var_2_10002.DUTY_COMMANDER then
			local var_11_2 = var_6_7

			GuildConst = var_2

			if var_11_2 == var_2.DUTY_COMMANDER then
				pg = var_11_2

				local var_11_3 = var_11_2.MsgboxMgr.GetInstance()
				local var_11_4 = var_1.ShowMsgBox
				local var_11_5 = {}

				i18n = var_2_10004
				var_11_5.content = var_2_10004("guild_transfer_president_confirm", var_6_1.name)
				var_11_5.onYes = var_11_0

				var_11_4(var_11_3, var_11_5)

				goto label_11_0
			end
		end

		var_11_0()

		::label_11_0::

		return
	end

	SFX_CONFIRM = var_1_10019

	var_6_41(var_6_42, var_6_43, var_6_44, var_1_10019)

	return
end

function var_0_1.Hide(arg_13_0)
	local var_13_0 = arg_13_0.toggles

	var_1.SetAllTogglesOff(var_13_0)
	var_0_1.super.Hide(arg_13_0)

	return
end

return var_0_1
