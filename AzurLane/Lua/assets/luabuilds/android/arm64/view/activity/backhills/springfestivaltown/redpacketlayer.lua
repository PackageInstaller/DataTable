local var_0_0 = class("RedPacketLayer", import("view.base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	if PLATFORM_CODE == PLATFORM_CHT then
		return "RedPacket2023UI"
	else
		return "RedPacket2023UI"
	end

	return
end

function var_0_0.init(arg_2_0)
	arg_2_0:initData()
	arg_2_0:findUI()
	arg_2_0:addListener()

	return
end

function var_0_0.didEnter(arg_3_0)
	arg_3_0:updateUI()
	pg.UIMgr.GetInstance():OverlayPanel(arg_3_0._tf)

	return
end

function var_0_0.willExit(arg_4_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_4_0._tf)

	return
end

function var_0_0.initData(arg_5_0)
	arg_5_0.activityProxy = getProxy(ActivityProxy)

	local var_5_0 = arg_5_0.activityProxy:getActivityByType(ActivityConst.ACTIVITY_TYPE_RED_PACKETS)

	arg_5_0.activityID = var_5_0.id
	arg_5_0.countToStory = {}

	local var_5_1 = var_5_0:getConfig("config_client").story

	if var_5_1 then
		for iter_5_0, iter_5_1 in ipairs(var_5_1) do
			arg_5_0.countToStory[iter_5_1[1]] = iter_5_1[2]
		end
	end

	return
end

function var_0_0.findUI(arg_6_0)
	arg_6_0.packetBtn = arg_6_0._tf:Find("Container/PacketBtn")
	arg_6_0.packetMask = arg_6_0._tf:Find("Container/PacketBtnMask")
	arg_6_0.helpBtn = arg_6_0._tf:Find("Container/HelpBtn")
	arg_6_0.tagTF = arg_6_0.packetBtn:Find("tag")
	arg_6_0.countTF = arg_6_0._tf:Find("Container/Count")
	arg_6_0.specialTF = arg_6_0._tf:Find("Container/Count/Special")
	arg_6_0.specialCountText = arg_6_0.specialTF:Find("Text")
	arg_6_0.normalTF = arg_6_0._tf:Find("Container/Count/Normal")
	arg_6_0.normalCountText = arg_6_0.normalTF:Find("Text")
	arg_6_0.awardBtnList = {}

	table.insert(arg_6_0.awardBtnList, arg_6_0._tf:Find("Container/Award"))
	table.insert(arg_6_0.awardBtnList, arg_6_0._tf:Find("Container/Award2"))

	arg_6_0.countText = arg_6_0._tf:Find("Container/CountText")
	arg_6_0.backBtn = arg_6_0._tf:Find("Top/BackBtn")

	return
end

function var_0_0.addListener(arg_7_0)
	onButton(arg_7_0, arg_7_0.backBtn, function()
		arg_7_0:closeView()

		return
	end, SFX_PANEL)
	onButton(arg_7_0, arg_7_0.packetBtn, function()
		pg.m02:sendNotification(GAME.ACTIVITY_OPERATION, {
			cmd = 1,
			activity_id = arg_7_0.activityID
		})

		return
	end, SFX_PANEL)
	onButton(arg_7_0, arg_7_0.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.help_chunjie_jiulou.tip
		})

		return
	end, SFX_PANEL)

	for iter_7_0, iter_7_1 in ipairs(arg_7_0.awardBtnList) do
		if iter_7_1 then
			onButton(arg_7_0, iter_7_1, function()
				pg.m02:sendNotification(GAME.GO_SCENE, SCENE.SKINSHOP)

				return
			end, SFX_PANEL)
		end
	end

	return
end

function var_0_0.updateUI(arg_12_0)
	local var_12_0 = arg_12_0.activityProxy:getActivityByType(ActivityConst.ACTIVITY_TYPE_RED_PACKETS)
	local var_12_2 = var_12_0.data1
	local var_12_3 = math.min(var_12_0.data1, var_12_0.data2)
	local var_12_4 = var_12_0.data1 - var_12_3

	print(var_12_0.data1 - var_12_3, var_12_3, var_12_0.data1)
	setActive(arg_12_0.tagTF, var_12_3 > 0)
	setActive(arg_12_0.normalTF, var_12_4 > 0)
	setActive(arg_12_0.specialTF, var_12_3 > 0)
	setActive(arg_12_0.countTF, var_12_2 > 0)
	setText(arg_12_0.normalCountText, var_12_4)
	setText(arg_12_0.specialCountText, var_12_3)
	setActive(arg_12_0.packetBtn, var_12_2 > 0)
	setActive(arg_12_0.packetMask, not (var_12_2 > 0))
	setText(arg_12_0.countText, var_12_0.data1_list[2] .. "/" .. var_12_0.data1_list[1])

	return
end

function var_0_0.tryPlayStory(arg_13_0)
	local var_13_0 = arg_13_0.activityProxy:getActivityByType(ActivityConst.ACTIVITY_TYPE_RED_PACKETS)
	local var_13_1 = var_13_0.data1 - math.min(var_13_0.data1, var_13_0.data2)

	if arg_13_0.countToStory[var_13_0.data3 - var_13_0.data2] then
		pg.NewStoryMgr.GetInstance():Play(arg_13_0.countToStory[var_13_0.data3 - var_13_0.data2])
	end

	return
end

function var_0_0.onSubmitFinished(arg_14_0)
	arg_14_0:updateUI()
	arg_14_0:tryPlayStory()

	return
end

function var_0_0.isShowRedPoint()
	local var_15_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_RED_PACKETS).data1

	return var_15_0 > 0
end

return var_0_0
