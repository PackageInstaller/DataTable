local var_0_0 = class("BeachPacketLayer", import("view.base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "BeachPacketUI"
end

function var_0_0.init(arg_2_0)
	arg_2_0:initData()
	arg_2_0:findUI()
	arg_2_0:addListener()

	return
end

function var_0_0.didEnter(arg_3_0)
	arg_3_0:updateUI()

	return
end

function var_0_0.willExit(arg_4_0)
	return
end

function var_0_0.initData(arg_5_0)
	arg_5_0.activityProxy = getProxy(ActivityProxy)

	local var_5_0 = arg_5_0.activityProxy:getActivityByType(ActivityConst.ACTIVITY_TYPE_RED_PACKET_LOTTER)

	arg_5_0.activityID = var_5_0.id
	arg_5_0.awardList = {}
	arg_5_0.awardListMap = {}

	local var_5_1 = var_5_0:getConfig("config_client")

	if var_5_1 then
		for iter_5_0, iter_5_1 in ipairs(var_5_1) do
			arg_5_0.awardListMap[iter_5_1[4]] = arg_5_0.awardListMap[iter_5_1[4]] or {}

			local var_5_2 = {
				id = iter_5_1[2][2],
				type = iter_5_1[2][1],
				count = iter_5_1[3],
				awardID = iter_5_1[1]
			}

			table.insert(arg_5_0.awardListMap[iter_5_1[4]], {
				id = iter_5_1[2][2],
				type = iter_5_1[2][1],
				count = iter_5_1[3],
				awardID = iter_5_1[1]
			})

			arg_5_0.awardList[iter_5_1[1]] = var_5_2
		end
	end

	arg_5_0:updateActData()

	return
end

function var_0_0.findUI(arg_6_0)
	local var_6_0 = arg_6_0._tf:Find("Adapt")

	arg_6_0.backBtn = var_6_0:Find("BackBtn")
	arg_6_0.homeBtn = var_6_0:Find("HomeBtn")
	arg_6_0.helpBtn = var_6_0:Find("HelpBtn")

	local var_6_1 = arg_6_0._tf:Find("PacketPanel")

	arg_6_0.countText = var_6_1:Find("Count/CountText")
	arg_6_0.packetTFList = {}

	local var_6_2 = var_6_1:Find("ContainerBehide")

	for iter_6_0 = 1, 5 do
		table.insert(arg_6_0.packetTFList, (var_6_2:GetChild(iter_6_0 - 1)))
	end

	local var_6_3 = var_6_1:Find("ContainerFront")

	for iter_6_1 = 1, 5 do
		table.insert(arg_6_0.packetTFList, (var_6_3:GetChild(iter_6_1 - 1)))
	end

	local var_6_4 = arg_6_0._tf:Find("AwardPanel")

	arg_6_0.awardTpl = var_6_4:Find("AwardTpl")
	arg_6_0.iconTpl = arg_6_0.awardTpl:Find("Icon/IconTpl")
	arg_6_0.awardTFList = {}

	;(function(arg_7_0, arg_7_1, arg_7_2)
		for iter_7_0, iter_7_1 in ipairs((arg_6_0:getAwardListByLevel(arg_7_0))) do
			arg_6_0.awardTFList[iter_7_1.awardID] = cloneTplTo(arg_7_1, arg_7_2)
		end

		return
	end)(1, arg_6_0.awardTpl, var_6_4:Find("Container_1"))
	;(function(arg_7_0, arg_7_1, arg_7_2)
		for iter_7_0, iter_7_1 in ipairs((arg_6_0:getAwardListByLevel(arg_7_0))) do
			arg_6_0.awardTFList[iter_7_1.awardID] = cloneTplTo(arg_7_1, arg_7_2)
		end

		return
	end)(2, arg_6_0.awardTpl, var_6_4:Find("Container_2"))
	;(function(arg_7_0, arg_7_1, arg_7_2)
		for iter_7_0, iter_7_1 in ipairs((arg_6_0:getAwardListByLevel(arg_7_0))) do
			arg_6_0.awardTFList[iter_7_1.awardID] = cloneTplTo(arg_7_1, arg_7_2)
		end

		return
	end)(3, arg_6_0.awardTpl, var_6_4:Find("Container_3"))
	;(function(arg_7_0, arg_7_1, arg_7_2)
		for iter_7_0, iter_7_1 in ipairs((arg_6_0:getAwardListByLevel(arg_7_0))) do
			arg_6_0.awardTFList[iter_7_1.awardID] = cloneTplTo(arg_7_1, arg_7_2)
		end

		return
	end)(4, arg_6_0.awardTpl, var_6_4:Find("Container_4"))

	arg_6_0.aniPanel = arg_6_0._tf:Find("AniPanel")
	arg_6_0.aniTF = arg_6_0.aniPanel:Find("Ani")
	arg_6_0.aniSC = GetComponent(arg_6_0.aniTF, "SpineAnimUI")

	return
end

function var_0_0.addListener(arg_8_0)
	onButton(arg_8_0, arg_8_0.backBtn, function()
		arg_8_0:closeView()

		return
	end, SFX_PANEL)
	onButton(arg_8_0, arg_8_0.homeBtn, function()
		arg_8_0:emit(var_0_0.ON_HOME)

		return
	end, SFX_PANEL)
	onButton(arg_8_0, arg_8_0.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.tips_yuandanhuoyue2023.tip
		})

		return
	end, SFX_PANEL)

	return
end

function var_0_0.updateActData(arg_12_0)
	local var_12_0 = arg_12_0.activityProxy:getActivityByType(ActivityConst.ACTIVITY_TYPE_RED_PACKET_LOTTER)
	local var_12_1 = pg.TimeMgr.GetInstance()

	arg_12_0.curCount = math.min(10, var_12_1:DiffDay(var_12_0.data2, (var_12_1:GetServerTime())) + 1) - var_12_0.data1
	arg_12_0.gotIndexList = {}

	for iter_12_0, iter_12_1 in pairs(var_12_0.data2_list) do
		if not table.contains(arg_12_0.gotIndexList, iter_12_1) then
			table.insert(arg_12_0.gotIndexList, iter_12_1)
		end
	end

	arg_12_0.gotIDList = {}

	for iter_12_2, iter_12_3 in pairs(var_12_0.data1_list) do
		if not table.contains(arg_12_0.gotIDList, iter_12_3) then
			table.insert(arg_12_0.gotIDList, iter_12_3)
		end
	end

	return
end

function var_0_0.updatePacketTpl(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_2:Find("Selected")
	local var_13_1 = arg_13_0:isPacketIndexGot(arg_13_1)

	setActive(arg_13_2:Find("Got"), var_13_1)
	setActive(arg_13_2:Find("Normal"), not var_13_1)
	onButton(arg_13_0, arg_13_2, function()
		if not var_13_1 and arg_13_0.curCount > 0 then
			pg.m02:sendNotification(GAME.ACTIVITY_OPERATION, {
				cmd = 1,
				activity_id = arg_13_0.activityID,
				arg1 = arg_13_1
			})
		end

		return
	end, SFX_PANEL)

	return
end

function var_0_0.updatePacketList(arg_15_0)
	for iter_15_0, iter_15_1 in ipairs(arg_15_0.packetTFList) do
		arg_15_0:updatePacketTpl(iter_15_0, iter_15_1)
	end

	return
end

function var_0_0.updateAwardTpl(arg_16_0, arg_16_1, arg_16_2)
	updateDrop(arg_16_0._tf:Find("Icon/IconTpl(Clone)", arg_16_2), arg_16_0.awardList[arg_16_1])
	setActive(arg_16_2:Find("Got"), (arg_16_0:isAwardGot(arg_16_1)))
	onButton(arg_16_0, arg_16_2, function()
		if not var_0 then
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				type = MSGBOX_TYPE_SINGLE_ITEM,
				drop = var_0
			})
		end

		return
	end, SFX_PANEL)

	return
end

function var_0_0.updateAwardList(arg_18_0)
	for iter_18_0, iter_18_1 in ipairs(arg_18_0.awardTFList) do
		arg_18_0:updateAwardTpl(iter_18_0, iter_18_1)
	end

	return
end

function var_0_0.updateUI(arg_19_0)
	arg_19_0:updatePacketList()
	arg_19_0:updateAwardList()
	setText(arg_19_0.countText, arg_19_0.curCount)

	return
end

function var_0_0.playAni(arg_20_0, arg_20_1)
	arg_20_0.isPlaying = true

	setActive(arg_20_0.aniPanel, true)
	arg_20_0.aniSC:SetActionCallBack(nil)

	local var_20_0 = 0

	arg_20_0.aniSC:SetActionCallBack(function(arg_21_0)
		if arg_21_0 == "action" then
			var_20_0 = var_20_0 + 1

			if var_20_0 == 2 then
				arg_20_0.aniSC:SetActionCallBack(nil)
				setActive(arg_20_0.aniPanel, false)

				arg_20_0.isPlaying = false

				if arg_20_1 then
					arg_20_1()
				end

				var_20_0 = 0
			end
		end

		return
	end)
	arg_20_0.aniSC:SetAction("4", 0)

	return
end

function var_0_0.isPacketIndexGot(arg_22_0, arg_22_1)
	return table.contains(arg_22_0.gotIndexList, arg_22_1)
end

function var_0_0.isAwardGot(arg_23_0, arg_23_1)
	return table.contains(arg_23_0.gotIDList, arg_23_1)
end

function var_0_0.getAwardCountByLevel(arg_24_0, arg_24_1)
	return #arg_24_0:getAwardListByLevel(arg_24_1)
end

function var_0_0.getAwardListByLevel(arg_25_0, arg_25_1)
	return arg_25_0.awardListMap[arg_25_1]
end

function var_0_0.onSubmitFinished(arg_26_0)
	arg_26_0:updateActData()
	arg_26_0:updateUI()

	return
end

function var_0_0.isShowRedPoint()
	local var_27_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_RED_PACKET_LOTTER)
	local var_27_1 = pg.TimeMgr.GetInstance()
	local var_27_2 = var_27_1:GetServerTime()
	local var_27_3 = var_27_1:DiffDay(var_27_0.data2, var_27_2) + 1

	return math.min(10, var_27_1:DiffDay(var_27_0.data2, var_27_2) + 1) - var_27_0.data1 > 0
end

return var_0_0
