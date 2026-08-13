class = var_0_10000

local var_0_0 = "GuildAppiontPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".GuildMemberBasePage"))

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

	typeof = var_4
	Image = var_1_10006
	arg_2_0.print = var_2_3(var_2_2, var_4(var_1_10006))

	local var_2_4 = arg_2_0._tf

	arg_2_0.confirmBtn = var_1.Find(var_2_4, "frame/confirm_btn")

	local var_2_5 = arg_2_0._tf
	local var_2_6 = var_1.Find(var_2_5, "frame/info/name/Text")
	local var_2_7 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.nameTF = var_2_7(var_2_6, var_4(var_1_10006))

	local var_2_8 = arg_2_0._tf
	local var_2_9 = var_1.Find(var_2_8, "frame/info/shipicon/icon")
	local var_2_10 = var_1.GetComponent

	typeof = var_4
	Image = var_1_10006
	arg_2_0.iconTF = var_2_10(var_2_9, var_4(var_1_10006))

	local var_2_11 = arg_2_0._tf

	arg_2_0.starsTF = var_1.Find(var_2_11, "frame/info/shipicon/stars")

	local var_2_12 = arg_2_0._tf

	arg_2_0.starTF = var_1.Find(var_2_12, "frame/info/shipicon/stars/star")

	local var_2_13 = arg_2_0._tf
	local var_2_14 = var_1.Find(var_2_13, "frame/info/level/Text")
	local var_2_15 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.levelTF = var_2_15(var_2_14, var_4(var_1_10006))

	local var_2_16 = arg_2_0._tf

	arg_2_0.circle = var_1.Find(var_2_16, "frame/info/shipicon/frame")

	local var_2_17 = arg_2_0._tf
	local var_2_18 = var_1.Find(var_2_17, "frame/duty")
	local var_2_19 = var_1.GetComponent

	typeof = var_4
	ToggleGroup = var_1_10006
	arg_2_0.toggles = var_2_19(var_2_18, var_4(var_1_10006))

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

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10006)

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
	local var_6_6 = var_3
	local var_6_7 = var_3.getAssistantCount(var_6_6)
	local var_6_8

	ipairs = var_6_6

	for iter_6_0, iter_6_1 in var_6_6(var_0_2) do
		local var_6_9 = arg_6_0.dutyContainer

		var_1_10017 = var_14.Find(var_6_9, iter_6_1)
		var_1_10015 = var_14.Find(var_1_10017, "Text")

		local var_6_10 = false

		if var_6_1.duty == iter_6_0 then
			setText = var_1_10017

			local var_6_11 = var_1_10015

			i18n = var_1_10020

			var_1_10017(var_6_11, var_1_10020("guild_duty_tip_1"))

			var_6_10 = true
		else
			table = var_1_10017

			if not var_1_10017.contains(var_6_4, iter_6_0) then
				if var_6_5 <= var_6_7 and iter_6_0 == 2 then
					setText = var_1_10017

					local var_6_12 = var_1_10015

					i18n = var_1_10020

					var_1_10017(var_6_12, var_1_10020("guild_deputy_commander_cnt_is_full"))
				else
					setText = var_1_10017

					local var_6_13 = var_1_10015

					i18n = var_1_10020

					var_1_10017(var_6_13, var_1_10020("guild_duty_tip_2"))
				end

				var_6_10 = true
			end
		end

		setActive = var_1_10017

		local var_6_14 = var_1_10015

		table = var_1_10020

		var_1_10017(var_6_14, not var_1_10020.contains(var_6_4, iter_6_0))

		GuildConst = var_1_10017

		if var_6_3 == var_1_10017.DUTY_COMMANDER and iter_6_0 == 2 and not var_6_10 then
			if var_6_5 <= var_6_7 then
				setText = var_1_10017

				local var_6_15 = var_1_10015

				i18n = var_1_10020

				var_1_10017(var_6_15, var_1_10020("guild_deputy_commander_cnt_is_full"))
			else
				setText = var_1_10017

				local var_6_16 = var_1_10015

				i18n = var_1_10020

				var_1_10017(var_6_16, var_1_10020("guild_deputy_commander_cnt", var_6_7, var_6_5))
			end

			setActive = var_1_10017

			var_1_10017(var_1_10015, true)
		end

		setToggleEnabled = var_1_10017

		local var_6_17 = var_14

		table = var_1_10020

		var_1_10017(var_6_17, var_1_10020.contains(var_6_4, iter_6_0))

		onToggle = var_1_10017

		local var_6_18 = arg_6_0

		var_1_10020 = var_14

		local function var_6_19(arg_7_0)
			if arg_7_0 then
				var_6_8 = iter_6_0
				arg_6_0.selectedToggle = var_0
			end

			return
		end

		SFX_PANEL = var_22

		var_1_10017(var_6_18, var_1_10020, var_6_19, var_22)
	end

	local var_6_20 = arg_6_0.dutyContainer
	local var_6_21 = var_9.Find(var_6_20, "commander/Image2")

	GuildConst = var_10

	if var_6_3 == var_10.DUTY_COMMANDER then
		local var_6_22 = var_6_1.duty

		GuildConst = var_6_20

		if var_6_20.DUTY_DEPUTY_COMMANDER < var_6_22 then
			onButton = var_6_22

			local var_6_23 = arg_6_0

			iter_6_1 = var_6_21

			local function var_6_24()
				pg = var_2_10000

				local var_8_0 = var_2_10000.TipsMgr.GetInstance()
				local var_8_1 = var_0.ShowTips

				i18n = var_2_10003

				var_8_1(var_8_0, var_2_10003("guild_duty_shoule_be_deputy_commander"))

				return
			end

			SFX_PANEL = var_1_10015

			var_6_22(var_6_23, iter_6_1, var_6_24, var_1_10015)

			goto label_6_0
		end
	end

	do
		local var_6_25 = var_6_21
		local var_6_26 = var_6_21.GetComponent

		typeof = iter_6_1
		Button = var_1_10015

		local var_6_27 = var_6_26(var_6_25, iter_6_1(var_1_10015))

		IsNil = var_6_20

		if not var_6_20(var_6_27) then
			Object = var_6_20

			var_6_20.Destroy(var_6_27)
		end
	end

	::label_6_0::

	local var_6_28 = var_3
	local var_6_29 = var_3.getFaction(var_6_28)

	GuildConst = var_6_20

	local var_6_30

	if var_6_29 == var_6_20.FACTION_TYPE_BLHX then
		var_6_30 = arg_6_0.print
		Color = var_6_28
		var_6_30.color = var_6_28.New(0.4235294117647059, 0.6313725490196078, 0.9568627450980393)
	else
		GuildConst = var_6_30

		if var_6_29 == var_6_30.FACTION_TYPE_CSZZ then
			local var_6_31 = arg_6_0.print

			Color = var_6_28
			var_6_31.color = var_6_28.New(0.9568627450980393, 0.44313725490196076, 0.42745098039215684)
		end
	end

	local var_6_32 = arg_6_0.nameTF

	var_6_32.text = var_6_1.name
	AttireFrame = var_6_32

	local var_6_33 = var_6_32.attireFrameRes
	local var_6_34 = var_6_1
	local var_6_35 = var_6_1.id

	getProxy = var_1_10015
	PlayerProxy = var_1_10017

	local var_6_36 = var_1_10015(var_1_10017)
	local var_6_37 = var_6_35 == var_15.getRawData(var_6_36).id

	AttireConst = var_15

	local var_6_38 = var_6_33(var_6_34, var_6_37, var_15.TYPE_ICON_FRAME, var_6_1.propose)

	PoolMgr = var_12

	local var_6_39 = var_12.GetInstance()

	var_12.GetPrefab(var_6_39, "IconFrame/" .. var_6_38, var_6_38, true, function(arg_9_0)
		IsNil = var_2_10001

		if var_2_10001(arg_6_0._tf) then
			return
		end

		if arg_6_0.circle then
			arg_9_0.name = var_6_38
			findTF = var_1

			local var_9_0 = var_1(arg_9_0.transform, "icon")
			local var_9_1 = var_1.GetComponent

			typeof = var_2_10005
			Image = var_2_10007
			var_9_1(var_9_0, var_2_10005(var_2_10007)).raycastTarget = false
			setParent = var_3

			var_3(arg_9_0, arg_6_0.circle, false)
		else
			PoolMgr = var_1

			local var_9_2 = var_1.GetInstance()

			var_1.ReturnPrefab(var_9_2, "IconFrame/" .. var_6_38, var_6_38, arg_9_0)
		end

		return
	end)

	pg = var_12

	local var_6_40 = var_12.ship_data_statistics[var_6_1.icon]

	Ship = var_13

	local var_6_41 = var_13.New({
		configId = var_6_1.icon,
		skin_id = var_6_1.skinId
	})

	LoadSpriteAsync = var_6_39

	local var_6_42 = "qicon/"
	local var_6_43 = var_6_41

	var_6_39(var_6_42 .. var_6_41.getPainting(var_6_43), function(arg_10_0)
		IsNil = var_2_10001

		if not var_2_10001(arg_6_0.iconTF) then
			arg_6_0.iconTF.sprite = arg_10_0
		end

		return
	end)

	for iter_6_2 = arg_6_0.starsTF.childCount, var_6_40.star - 1 do
		cloneTplTo = var_6_43

		var_6_43(arg_6_0.starTF, arg_6_0.starsTF)
	end

	for iter_6_3 = 1, var_14 do
		local var_6_44 = arg_6_0.starsTF
		local var_6_45 = var_19.GetChild(var_6_44, iter_6_3 - 1)

		setActive = var_1_10020

		var_1_10020(var_6_45, iter_6_3 <= var_6_40.star)
	end

	local var_6_46 = arg_6_0.levelTF

	var_6_46.text = "Lv." .. var_6_1.level
	onButton = var_6_46

	local var_6_47 = arg_6_0
	local var_6_48 = arg_6_0.confirmBtn

	local function var_6_49()
		local function var_11_0()
			local var_12_0 = arg_6_0
			local var_12_1 = var_0.emit

			GuildMemberMediator = var_3_10003

			var_12_1(var_12_0, var_3_10003.SET_DUTY, var_6_1.id, var_6_8)

			local var_12_2 = arg_6_0

			var_0.Hide(var_12_2)

			return
		end

		local var_11_1 = var_6_3

		GuildConst = var_2_10002

		if var_11_1 == var_2_10002.DUTY_COMMANDER then
			local var_11_2 = var_6_8

			GuildConst = var_2

			if var_11_2 == var_2.DUTY_COMMANDER then
				pg = var_11_2

				local var_11_3 = var_11_2.MsgboxMgr.GetInstance()
				local var_11_4 = var_1.ShowMsgBox
				local var_11_5 = {}

				i18n = var_2_10005
				var_11_5.content = var_2_10005("guild_transfer_president_confirm", var_6_1.name)
				var_11_5.onYes = var_11_0

				var_11_4(var_11_3, var_11_5)

				goto label_11_0
			end
		end

		var_11_0()

		::label_11_0::

		return
	end

	SFX_CONFIRM = var_1_10020

	var_6_46(var_6_47, var_6_48, var_6_49, var_1_10020)

	return
end

function var_0_1.Hide(arg_13_0)
	local var_13_0 = arg_13_0.toggles

	var_1.SetAllTogglesOff(var_13_0)
	var_0_1.super.Hide(arg_13_0)

	return
end

return var_0_1
