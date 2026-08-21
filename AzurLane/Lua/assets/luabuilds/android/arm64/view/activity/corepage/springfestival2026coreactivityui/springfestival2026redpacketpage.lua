local var_0_0 = class("SpringFestival2026RedPacketPage", import("view.activity.CorePage.CoreActivityPage"))

function var_0_0.OnInit(arg_1_0)
	arg_1_0:findUI()

	return
end

function var_0_0.OnUpdateFlush(arg_2_0)
	arg_2_0:updateUI()

	return
end

function var_0_0.OnDataSetting(arg_3_0)
	arg_3_0.activityProxy = getProxy(ActivityProxy)
	arg_3_0.activityID = arg_3_0.activity.id
	arg_3_0.countToStory = {}

	local var_3_0 = arg_3_0.activity:getConfig("config_client").story

	if var_3_0 then
		for iter_3_0, iter_3_1 in ipairs(var_3_0) do
			arg_3_0.countToStory[iter_3_1[1]] = iter_3_1[2]
		end
	end

	return
end

function var_0_0.findUI(arg_4_0)
	arg_4_0.packetBtn = arg_4_0._tf:Find("BG/Container/PacketBtn")
	arg_4_0.packetMask = arg_4_0._tf:Find("BG/Container/PacketBtnMask")
	arg_4_0.helpBtn = arg_4_0._tf:Find("BG/Container/HelpBtn")
	arg_4_0.tagTF = arg_4_0.packetBtn:Find("tag")
	arg_4_0.countTF = arg_4_0._tf:Find("BG/Container/Count")
	arg_4_0.specialTF = arg_4_0._tf:Find("BG/Container/Count/Special")
	arg_4_0.specialCountText = arg_4_0.specialTF:Find("Text")
	arg_4_0.normalTF = arg_4_0._tf:Find("BG/Container/Count/Normal")
	arg_4_0.normalCountText = arg_4_0.normalTF:Find("Text")
	arg_4_0.awardBtnList = {}

	table.insert(arg_4_0.awardBtnList, arg_4_0._tf:Find("BG/Container/Award"))
	table.insert(arg_4_0.awardBtnList, arg_4_0._tf:Find("BG/Container/Award2"))

	arg_4_0.countText = arg_4_0._tf:Find("BG/Container/CountText")

	return
end

function var_0_0.OnFirstFlush(arg_5_0)
	onButton(arg_5_0, arg_5_0.packetBtn, function()
		pg.m02:sendNotification(GAME.ACTIVITY_OPERATION, {
			cmd = 1,
			activity_id = arg_5_0.activity.id
		})

		return
	end, SFX_PANEL)
	onButton(arg_5_0, arg_5_0.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.help_chunjie_jiulou_2026.tip
		})

		return
	end, SFX_PANEL)

	for iter_5_0, iter_5_1 in ipairs(arg_5_0.awardBtnList) do
		if iter_5_1 then
			onButton(arg_5_0, iter_5_1, function()
				pg.m02:sendNotification(GAME.GO_SCENE, SCENE.SKINSHOP)

				return
			end, SFX_PANEL)
		end
	end

	return
end

function var_0_0.updateUI(arg_9_0)
	local var_9_1 = arg_9_0.activity.data1
	local var_9_2 = math.min(arg_9_0.activity.data1, arg_9_0.activity.data2)
	local var_9_3 = arg_9_0.activity.data1 - var_9_2

	setActive(arg_9_0.tagTF, var_9_2 > 0)
	setActive(arg_9_0.normalTF, var_9_3 > 0)
	setActive(arg_9_0.specialTF, var_9_2 > 0)
	setActive(arg_9_0.countTF, var_9_1 > 0)
	setText(arg_9_0.normalCountText, var_9_3)
	setText(arg_9_0.specialCountText, var_9_2)
	setActive(arg_9_0.packetBtn, var_9_1 > 0)
	setActive(arg_9_0.packetMask, not (var_9_1 > 0))
	setText(arg_9_0.countText, arg_9_0.activity.data1_list[2] .. "/" .. arg_9_0.activity.data1_list[1])

	return
end

function var_0_0.tryPlayStory(arg_10_0)
	local var_10_0 = arg_10_0.activity.data1 - math.min(arg_10_0.activity.data1, arg_10_0.activity.data2)

	if arg_10_0.countToStory[arg_10_0.activity.data3 - arg_10_0.activity.data2] then
		pg.NewStoryMgr.GetInstance():Play(arg_10_0.countToStory[arg_10_0.activity.data3 - arg_10_0.activity.data2])
	end

	return
end

function var_0_0.OnUpdateFlush(arg_11_0)
	arg_11_0:updateUI()
	arg_11_0:tryPlayStory()

	return
end

return var_0_0
