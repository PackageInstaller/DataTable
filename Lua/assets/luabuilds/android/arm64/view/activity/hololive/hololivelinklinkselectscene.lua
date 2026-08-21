local var_0_0 = class("HoloLiveLinkLinkSelectScene", import("view.base.BaseUI"))

var_0_0.HOLOLIVE_LINKGAME_HUB_ID = 3
var_0_0.HOLOLIVE_LINKGAME_ID = 7

function var_0_0.getUIName(arg_1_0)
	return "HoloLiveLinkGameSelectUI"
end

function var_0_0.init(arg_2_0)
	arg_2_0:initData()
	arg_2_0:findUI()
	arg_2_0:initUI()
	arg_2_0:addListener()

	return
end

function var_0_0.didEnter(arg_3_0)
	arg_3_0:updateProgressBar()
	arg_3_0:updateAwardPanel()
	arg_3_0:updateEntranceList()

	return
end

function var_0_0.willExit(arg_4_0)
	return
end

function var_0_0.initData(arg_5_0)
	arg_5_0.lightPointTFList = {}
	arg_5_0.lightLineTFList = {}
	arg_5_0.entranceTFList = {}

	arg_5_0:updateData()

	return
end

function var_0_0.findUI(arg_6_0)
	arg_6_0.forNotchPanel = arg_6_0._tf:Find("ForNotchPanel")
	arg_6_0.backBtn = arg_6_0.forNotchPanel:Find("BackBtn")
	arg_6_0.helpBtn = arg_6_0.forNotchPanel:Find("HelpBtn")
	arg_6_0.awardMask = arg_6_0.forNotchPanel:Find("AwardImg/Mask")
	arg_6_0.progressText = arg_6_0.forNotchPanel:Find("AwardImg/ProgressText")
	arg_6_0.getAwardBtn = arg_6_0.forNotchPanel:Find("AwardImg/GetBtn")
	arg_6_0.gotAwardBtn = arg_6_0.forNotchPanel:Find("AwardImg/GotBtn")
	arg_6_0.progressPanel = arg_6_0.forNotchPanel:Find("Progress")
	arg_6_0.lightPointContainer = arg_6_0.progressPanel:Find("Light")
	arg_6_0.lightLineContainer = arg_6_0.progressPanel:Find("LightLine")
	arg_6_0.entranceContainer = arg_6_0._tf:Find("EntranceContainer")

	return
end

function var_0_0.initUI(arg_7_0)
	setActive(arg_7_0.getAwardBtn, false)
	setActive(arg_7_0.gotAwardBtn, false)
	eachChild(arg_7_0.lightPointContainer, function(arg_8_0)
		table.insert(arg_7_0.lightPointTFList, 1, arg_8_0)
		setActive(arg_8_0, false)
		setActive(arg_8_0:Find("Point"), false)

		return
	end)
	eachChild(arg_7_0.lightLineContainer, function(arg_9_0)
		table.insert(arg_7_0.lightLineTFList, 1, arg_9_0)
		setActive(arg_9_0, false)

		return
	end)

	for iter_7_0 = 0, 7 do
		local var_7_0 = arg_7_0.entranceContainer:GetChild(iter_7_0)

		table.insert(arg_7_0.entranceTFList, var_7_0)

		local var_7_1 = var_7_0:Find("GotImg")
		local var_7_2 = var_7_0:Find("LockText")

		setActive(var_7_0:Find("Mask"), true)
		setActive(var_7_1, false)
		setActive(var_7_2, true)
	end

	return
end

function var_0_0.addListener(arg_10_0)
	onButton(arg_10_0, arg_10_0.backBtn, function()
		arg_10_0:closeView()

		return
	end, SFX_CANCEL)
	onButton(arg_10_0, arg_10_0.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.hololive_lianliankan.tip
		})

		return
	end, SFX_PANEL)

	for iter_10_0, iter_10_1 in ipairs(arg_10_0.entranceTFList) do
		onButton(arg_10_0, iter_10_1:Find("EntranceBtn"), function()
			arg_10_0.linkGameData:SetRuntimeData("curLinkGameID", iter_10_0)
			pg.m02:sendNotification(GAME.GO_MINI_GAME, var_0_0.HOLOLIVE_LINKGAME_ID)

			return
		end, SFX_PANEL)
	end

	return
end

function var_0_0.updateProgressBar(arg_14_0)
	local var_14_0 = math.min(arg_14_0.linkGameHub.usedtime, 7)

	if var_14_0 > 0 then
		for iter_14_0 = 1, var_14_0 do
			setActive(arg_14_0.lightPointTFList[iter_14_0], true)
		end

		setActive(arg_14_0.lightPointTFList[var_14_0]:Find("Point"), true)
	end

	if var_14_0 > 1 then
		for iter_14_1 = 1, var_14_0 - 1 do
			setActive(arg_14_0.lightLineTFList[iter_14_1], true)
		end
	end

	return
end

function var_0_0.updateAwardPanel(arg_15_0)
	local var_15_0 = arg_15_0.linkGameHub.usedtime

	setText(arg_15_0.progressText, arg_15_0.linkGameHub.usedtime > 7 and 7 or var_15_0)

	if arg_15_0.linkGameHub.ultimate > 0 then
		setActive(arg_15_0.getAwardBtn, false)
		setActive(arg_15_0.gotAwardBtn, true)
		setActive(arg_15_0.awardMask, true)
	elseif var_15_0 >= arg_15_0.linkGameHub:getConfig("reward_need") then
		setActive(arg_15_0.getAwardBtn, true)
		setActive(arg_15_0.gotAwardBtn, false)
		setActive(arg_15_0.awardMask, true)
		onButton(arg_15_0, arg_15_0.getAwardBtn, function()
			pg.m02:sendNotification(GAME.SEND_MINI_GAME_OP, {
				hubid = arg_15_0.linkGameHub.id,
				cmd = MiniGameOPCommand.CMD_ULTIMATE,
				args1 = {}
			})

			return
		end, SFX_PANEL)
	else
		setActive(arg_15_0.getAwardBtn, false)
		setActive(arg_15_0.gotAwardBtn, false)
		setActive(arg_15_0.awardMask, false)
	end

	return
end

function var_0_0.updateEntranceList(arg_17_0)
	for iter_17_0 = 1, 8 do
		local var_17_0 = arg_17_0.entranceTFList[iter_17_0]:Find("Mask")
		local var_17_1 = arg_17_0.entranceTFList[iter_17_0]:Find("GotImg")
		local var_17_2 = arg_17_0.entranceTFList[iter_17_0]:Find("LockText")

		setText(var_17_2, arg_17_0.linkGameData:GetConfigCsvLine(iter_17_0).unlock_txt)

		if iter_17_0 <= arg_17_0.linkGameHub.usedtime then
			setActive(var_17_0, false)
			setActive(var_17_1, true)
			setActive(var_17_2, false)
		elseif iter_17_0 == arg_17_0.linkGameHub.usedtime + 1 then
			if arg_17_0.linkGameHub.count == 0 then
				setActive(var_17_0, true)
				setActive(var_17_1, false)
				setActive(var_17_2, true)
			elseif arg_17_0.linkGameHub.count > 0 then
				setActive(var_17_0, false)
				setActive(var_17_1, false)
				setActive(var_17_2, false)
			end
		elseif iter_17_0 > arg_17_0.linkGameHub.usedtime + 1 then
			setActive(var_17_0, true)
			setActive(var_17_1, false)
			setActive(var_17_2, true)
		end
	end

	return
end

function var_0_0.updateData(arg_18_0)
	arg_18_0.miniGameProxy = getProxy(MiniGameProxy)
	arg_18_0.linkGameHub = arg_18_0.miniGameProxy:GetHubByHubId(var_0_0.HOLOLIVE_LINKGAME_HUB_ID)
	arg_18_0.linkGameData = arg_18_0.miniGameProxy:GetMiniGameData(var_0_0.HOLOLIVE_LINKGAME_ID)

	return
end

function var_0_0.updateUI(arg_19_0)
	arg_19_0:updateProgressBar()
	arg_19_0:updateAwardPanel()
	arg_19_0:updateEntranceList()

	return
end

function var_0_0.isTip()
	local var_20_0 = getProxy(MiniGameProxy):GetHubByHubId(var_0_0.HOLOLIVE_LINKGAME_HUB_ID)

	if var_20_0.ultimate == 0 and var_20_0.usedtime >= 7 then
		return true
	elseif var_20_0.count > 0 then
		return true
	end

	return
end

return var_0_0
