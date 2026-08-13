class = var_0_10000

local var_0_0 = "Dorm3dInsPhoneLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "Dorm3dInsPhoneUI"
end

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.bg = var_1.Find(var_2_0, "bg")

	local var_2_1 = arg_2_0.bg

	arg_2_0.btnBack = var_1.Find(var_2_1, "top/back")

	local var_2_2 = arg_2_0.bg

	arg_2_0.voiceListContainer = var_1.Find(var_2_2, "main/voice/scroll/mask/list")
	UIItemList = var_1

	local var_2_3 = var_1.New
	local var_2_4 = arg_2_0.voiceListContainer
	local var_2_5 = arg_2_0.voiceListContainer

	arg_2_0.voiceItemList = var_2_3(var_2_4, var_4.Find(var_2_5, "tpl"))

	local var_2_6 = arg_2_0.voiceItemList

	var_1.make(var_2_6, function(arg_3_0, arg_3_1, arg_3_2)
		UIItemList = var_2_10003

		if arg_3_0 == var_2_10003.EventUpdate then
			local var_3_0 = arg_2_0

			var_3.UpdateVoiceItem(var_3_0, arg_3_1, arg_3_2)
		end

		return
	end)

	getProxy = var_1
	Dorm3dInsProxy = var_2_6

	local var_2_7 = var_1(var_2_6)
	local var_2_8

	if not var_1.GetPhoneListByGroup(var_2_7, arg_2_0.contextData.groupId) then
		var_2_8 = {}
	end

	arg_2_0.data = var_2_8
	VoiceChatLoader = var_2_8
	arg_2_0.player = var_2_8.New(arg_2_0._tf)

	arg_2_0:OverlayPanel(arg_2_0._tf)

	return
end

function var_0_1.didEnter(arg_4_0)
	onButton = var_1_10001

	var_1_10001(arg_4_0, arg_4_0.btnBack, function()
		local var_5_0 = arg_4_0

		var_0.closeView(var_5_0)

		return
	end)

	setText = var_1_10001

	local var_4_0 = arg_4_0.voiceListContainer
	local var_4_1 = var_3.Find(var_4_0, "tpl/bg/uncheck/Text")

	i18n = var_4

	var_1_10001(var_4_1, var_4("dorm3d_privatechat_telephone_noviewed"))

	setText = var_1_10001

	local var_4_2 = arg_4_0.bg
	local var_4_3 = var_3.Find(var_4_2, "top/title")

	i18n = var_4

	var_1_10001(var_4_3, var_4("dorm3d_privatechat_telephone_calllog"))

	setText = var_1_10001

	local var_4_4 = arg_4_0.bg
	local var_4_5 = var_3.Find(var_4_4, "main/voice/title/Text")

	i18n = var_4

	var_1_10001(var_4_5, var_4("dorm3d_privatechat_telephone_call"))
	arg_4_0:Flush()

	return
end

function var_0_1.Flush(arg_6_0)
	local var_6_0 = arg_6_0.voiceItemList

	var_1.align(var_6_0, #arg_6_0.data)

	return
end

function var_0_1.UpdateVoiceItem(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_0.data[arg_7_1 + 1]
	local var_7_1 = var_3.IsLock(var_7_0)

	setText = var_1_10005

	var_1_10005(arg_7_2:Find("bg/name"), var_3:GetName())

	setActive = var_1_10005

	var_1_10005(arg_7_2:Find("bg/day"), not var_7_1)

	setActive = var_1_10005

	var_1_10005(arg_7_2:Find("bg/lock"), var_7_1)

	setActive = var_1_10005

	var_1_10005(arg_7_2:Find("bg/uncheck"), var_3:ShouldTip())

	if var_7_1 then
		setText = var_1_10005

		var_1_10005(arg_7_2:Find("bg/lock/info"), var_3:GetDesc())
	else
		setText = var_1_10005

		var_1_10005(arg_7_2:Find("bg/day"), var_3:GetDay())
	end

	onButton = var_1_10005

	var_1_10005(arg_7_0, arg_7_2, function()
		if var_7_1 then
			return
		end

		local var_8_0 = var_0

		if var_0.GetType(var_8_0) == 1 then
			local var_8_1 = arg_7_0
			local var_8_2 = var_0.emit

			Dorm3dInsPhoneMediator = var_2_10003
			var_2_10003 = var_2_10003.ON_DORM

			local var_8_3 = var_0

			var_8_2(var_8_1, var_2_10003, var_2_10004.GetVideoData(var_8_3))
		else
			local var_8_4 = var_0

			if var_0.GetType(var_8_4) == 2 then
				local var_8_5 = arg_7_0.player
				local var_8_6 = var_0.ExecuteAction

				var_2_10003 = "Play"

				local var_8_7 = var_0

				var_8_6(var_8_5, var_2_10003, var_2_10004.GetContent(var_8_7))
			end
		end

		local var_8_8 = var_0
		local var_8_10

		if var_0.ShouldTip(var_8_8) then
			local var_8_9 = arg_7_0

			var_8_10 = var_8_10.emit
			Dorm3dInsPhoneMediator = var_2_10003

			var_8_10(var_8_9, var_2_10003.MARK_READ, {
				groupId = arg_7_0.contextData.groupId,
				id = var_0.id
			})
		end

		pg = var_8_10

		local var_8_11 = var_8_10.m02
		local var_8_12 = var_0.sendNotification

		GAME = var_2_10003

		local var_8_13 = var_2_10003.APARTMENT_TRACK

		Dorm3dTrackCommand = var_2_10004

		local var_8_14 = var_2_10004.BuildDataPhone
		local var_8_15 = arg_7_0.contextData.groupId
		local var_8_16 = var_0

		var_8_12(var_8_11, var_8_13, var_8_14(var_8_15, var_7.GetType(var_8_16), var_0.id))

		return
	end)

	return
end

function var_0_1.willExit(arg_9_0)
	local var_9_0 = arg_9_0.player

	var_1.Destroy(var_9_0)

	return
end

return var_0_1
