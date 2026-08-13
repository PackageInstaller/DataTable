class = var_0_10000

local var_0_0 = "GuildMainScene"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.BaseUI"))

function var_0_1.forceGC(arg_1_0)
	return true
end

function var_0_1.getUIName(arg_2_0)
	return "GuildMainUI"
end

function var_0_1.getGroupName(arg_3_0)
	return "group_GuildMainUI"
end

function var_0_1.setGuildVO(arg_4_0, arg_4_1)
	arg_4_0.guildVO = arg_4_1

	if arg_4_0.guildRes then
		local var_4_0 = arg_4_0.guildRes

		if var_2.GetLoaded(var_4_0) then
			local var_4_1 = arg_4_0.guildRes

			var_2.Update(var_4_1, arg_4_0.playerVO, arg_4_1)
		end
	end

	if arg_4_0.themePage then
		local var_4_2 = arg_4_0.themePage

		if var_2.GetLoaded(var_4_2) then
			local var_4_3 = arg_4_0.themePage

			var_2.UpdateGuild(var_4_3, arg_4_0.guildVO)
		end
	end

	return
end

function var_0_1.setPlayerVO(arg_5_0, arg_5_1)
	arg_5_0.playerVO = arg_5_1

	return
end

function var_0_1.setChatMsgs(arg_6_0, arg_6_1)
	arg_6_0.chatMsgs = arg_6_1

	return
end

function var_0_1.setActivity(arg_7_0, arg_7_1)
	arg_7_0.activity = arg_7_1

	return
end

function var_0_1.setGuildEvent(arg_8_0, arg_8_1)
	arg_8_0.guildEvent = arg_8_1

	return
end

function var_0_1.UpdateRes(arg_9_0)
	if arg_9_0.guildRes then
		local var_9_0 = arg_9_0.guildRes

		if var_1.GetLoaded(var_9_0) then
			local var_9_1 = arg_9_0.guildRes

			var_1.Update(var_9_1, arg_9_0.playerVO, arg_9_0.guildVO)
		end
	end

	return
end

function var_0_1.OnReportUpdated(arg_10_0)
	if arg_10_0.themePage then
		local var_10_0 = arg_10_0.themePage

		if var_1.GetLoaded(var_10_0) then
			local var_10_1 = arg_10_0.themePage

			var_1.RefreshReportBtn(var_10_1)
		end
	end

	return
end

local var_0_2 = "main"
local var_0_3 = "member"
local var_0_4 = "apply"
local var_0_5 = "office"
local var_0_6 = "technology"
local var_0_7 = "battle"

var_0_1.TOGGLE_TAG = {
	var_0_2,
	var_0_3,
	var_0_4,
	var_0_5,
	var_0_6,
	var_0_7
}
var_0_1.NOTIFY_TYPE_ALL = 0
var_0_1.NOTIFY_TYPE_MAIN = 1
var_0_1.NOTIFY_TYPE_APPLY = 2
var_0_1.NOTIFY_TYPE_OFFICE = 3
var_0_1.NOTIFY_TYPE_BATTLE = 4
var_0_1.NOTIFY_TYPE_TECH = 5

function var_0_1.init(arg_11_0)
	local var_11_0 = arg_11_0._tf

	arg_11_0._bg = var_1.Find(var_11_0, "bg")
	pg = var_1

	local var_11_1 = var_1.GuildPaintingMgr.GetInstance()
	local var_11_2 = var_1.Enter
	local var_11_3 = arg_11_0._bg

	var_11_2(var_11_1, var_4.Find(var_11_3, "painting"))

	local var_11_4 = arg_11_0._tf

	arg_11_0._playerResOb = var_1.Find(var_11_4, "blur_panel/adapt/top/res")
	GuildResPage = var_1
	arg_11_0.guildRes = var_1.New(arg_11_0._playerResOb, arg_11_0.event)

	local var_11_5 = arg_11_0._tf

	arg_11_0.toggleRoot = var_1.Find(var_11_5, "blur_panel/adapt/left_length/frame/scroll_rect/tagRoot")

	local var_11_6 = arg_11_0.toggleRoot

	arg_11_0.mainTip = var_1.Find(var_11_6, "main/tip")

	local var_11_7 = arg_11_0.toggleRoot

	arg_11_0.applyTip = var_1.Find(var_11_7, "apply/tip")

	local var_11_8 = arg_11_0.toggleRoot

	arg_11_0.officeTip = var_1.Find(var_11_8, "office/tip")

	local var_11_9 = arg_11_0.toggleRoot

	arg_11_0.techTip = var_1.Find(var_11_9, "technology/tip")

	local var_11_10 = arg_11_0.toggleRoot

	arg_11_0.battleTip = var_1.Find(var_11_10, "battle/tip")

	local var_11_11 = arg_11_0._tf

	arg_11_0.back = var_1.Find(var_11_11, "blur_panel/adapt/top/back")

	local var_11_12 = arg_11_0._tf

	arg_11_0.blurPanel = var_1.Find(var_11_12, "blur_panel")

	local var_11_13 = arg_11_0._tf

	arg_11_0.mainTF = var_1.Find(var_11_13, "main")

	local var_11_14 = arg_11_0._tf

	arg_11_0.eyeTF = var_1.Find(var_11_14, "blur_panel/adapt/eye")
	findTF = var_1
	arg_11_0._leftLength = var_1(arg_11_0.blurPanel, "adapt/left_length")
	findTF = var_1
	arg_11_0._topPanel = var_1(arg_11_0.blurPanel, "adapt/top")

	local var_11_15 = arg_11_0._tf

	arg_11_0.topBg = var_1.Find(var_11_15, "blur_panel/top_bg")
	arg_11_0.topBgWidth = arg_11_0.topBg.rect.height
	arg_11_0.topWidth = arg_11_0._topPanel.rect.height
	arg_11_0.letfWidth = -1 * (arg_11_0._leftLength.rect.width + 300)
	GuildOfficeLogPage = var_1
	arg_11_0.logPage = var_1.New(arg_11_0._tf, arg_11_0.event)
	GuildDynamicBG = var_1

	local var_11_16 = var_1.New
	local var_11_17 = arg_11_0._tf

	arg_11_0.dynamicBg = var_11_16(var_3.Find(var_11_17, "dynamic_bg"))
	Input = var_1
	var_1.multiTouchEnabled = false

	return
end

function var_0_1.preload(arg_12_0, arg_12_1)
	seriesAsync = var_1_10002

	var_1_10002({
		function(arg_13_0)
			pg = var_2_10001

			local var_13_0 = var_2_10001.m02
			local var_13_1 = var_1.sendNotification

			GAME = var_2_10004

			var_13_1(var_13_0, var_2_10004.GET_GUILD_REPORT, {
				callback = arg_13_0
			})

			return
		end,
		function(arg_14_0)
			getProxy = var_2_10001
			GuildProxy = var_2_10003

			local var_14_0 = var_2_10001(var_2_10003)
			local var_14_1 = var_1.getRawData(var_14_0)

			if not var_1.GetActiveEvent(var_14_1) then
				pg = var_2_10002

				local var_14_2 = var_2_10002.m02
				local var_14_3 = var_2.sendNotification

				GAME = var_2_10005

				var_14_3(var_14_2, var_2_10005.GUILD_GET_ACTIVATION_EVENT, {
					force = false,
					callback = arg_14_0
				})
			elseif var_1 and var_1:IsExpired() then
				pg = var_2

				local var_14_4 = var_2.m02
				local var_14_5 = var_2.sendNotification

				GAME = var_2_10005

				var_14_5(var_14_4, var_2_10005.GUILD_GET_ACTIVATION_EVENT, {
					force = true,
					callback = arg_14_0
				})
			else
				arg_14_0()
			end

			return
		end
	}, arg_12_1)

	return
end

function var_0_1.didEnter(arg_15_0)
	onButton = var_1_10001

	local var_15_0 = arg_15_0
	local var_15_1 = arg_15_0.back

	local function var_15_2()
		local var_16_0 = arg_15_0
		local var_16_1 = var_0.emit

		GuildMainMediator = var_2_10003

		var_16_1(var_16_0, var_2_10003.ON_BACK)

		return
	end

	SOUND_BACK = var_1_10006

	var_1_10001(var_15_0, var_15_1, var_15_2, var_1_10006)

	arg_15_0.hideFlag = false
	onButton = var_1

	local var_15_3 = arg_15_0
	local var_15_4 = arg_15_0.eyeTF

	local function var_15_5()
		arg_15_0.hideFlag = not arg_15_0.hideFlag

		local var_17_0 = arg_15_0

		var_0.EnterOrExitPreView(var_17_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_15_3, var_15_4, var_15_5, var_1_10006)

	local var_15_6 = arg_15_0.guildRes

	var_1.ExecuteAction(var_15_6, "Update", arg_15_0.playerVO, arg_15_0.guildVO)
	arg_15_0:initToggles()
	arg_15_0:UpdateRes()

	pg = var_1

	local var_15_7 = var_1.GuildLayerMgr.GetInstance()

	var_1.BlurTopPanel(var_15_7, arg_15_0.blurPanel)

	local var_15_8 = arg_15_0.guildVO

	if var_1.shouldRefreshCaptial(var_15_8) then
		local var_15_9 = arg_15_0
		local var_15_10 = arg_15_0.emit

		GuildMainMediator = var_4

		var_15_10(var_15_9, var_4.ON_FETCH_CAPITAL)
	end

	local var_15_11 = arg_15_0.guildVO
	local var_15_12 = var_1.GetMemberShips

	GuildConst = var_4

	local var_15_13 = var_15_12(var_15_11, var_4.MAX_DISPLAY_MEMBER_SHIP)
	local var_15_14 = arg_15_0.dynamicBg

	var_2.Init(var_15_14, var_15_13)
	arg_15_0:UpdateNotices(var_0_1.NOTIFY_TYPE_ALL)

	return
end

function var_0_1.OnDeleteMember(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_1:GetShip()
	local var_18_1 = arg_18_0.dynamicBg

	var_3.ExitShip(var_18_1, var_18_0.name)

	return
end

function var_0_1.OnAddMember(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_1:GetShip()
	local var_19_1 = arg_19_0.dynamicBg

	var_3.AddShip(var_19_1, var_19_0, function()
		return
	end)

	return
end

function var_0_1.EnterOrExitPreView(arg_21_0)
	LeanTween = var_1_10001

	local var_21_0 = var_1_10001.isTweening

	go = var_1_10003

	if not var_21_0(var_1_10003(arg_21_0._topPanel)) then
		LeanTween = var_1

		local var_21_1 = var_1.isTweening

		go = var_21_3

		if not var_21_1(var_21_3(arg_21_0._leftLength)) then
			LeanTween = var_1

			local var_21_2 = var_1.isTweening

			go = var_21_3

			if var_21_2(var_21_3(arg_21_0.topBg)) then
				return
			end

			local var_21_3

			if arg_21_0.themePage then
				var_21_3 = arg_21_0.themePage

				if var_1.GetLoaded(var_21_3) then
					var_21_3 = arg_21_0.themePage

					var_1.EnterOrExitPreView(var_21_3, arg_21_0.hideFlag)
				end
			end

			local var_21_4

			if not arg_21_0.hideFlag or not {
				0,
				arg_21_0.topWidth
			} then
				var_21_4 = {
					arg_21_0.topWidth,
					0
				}
			end

			LeanTween = var_1_10002

			local var_21_5 = var_1_10002.value

			go = var_1_10004

			local var_21_6 = var_21_5(var_1_10004(arg_21_0._topPanel), var_21_4[1], var_21_4[2], 0.3)
			local var_21_7 = var_2.setOnUpdate

			System = var_5

			var_21_7(var_21_6, var_5.Action_float(function(arg_22_0)
				setAnchoredPosition = var_2_10001

				var_2_10001(arg_21_0._topPanel, {
					y = arg_22_0
				})

				return
			end))

			local var_21_8

			if not arg_21_0.hideFlag or not {
				0,
				arg_21_0.letfWidth
			} then
				var_21_8 = {
					arg_21_0.letfWidth,
					0
				}
			end

			LeanTween = var_21_3

			local var_21_9 = var_21_3.value

			go = var_5

			local var_21_10 = var_21_9(var_5(arg_21_0._leftLength), var_21_8[1], var_21_8[2], 0.3)
			local var_21_11 = var_3.setOnUpdate

			System = var_6

			var_21_11(var_21_10, var_6.Action_float(function(arg_23_0)
				setAnchoredPosition = var_2_10001

				var_2_10001(arg_21_0._leftLength, {
					x = arg_23_0
				})

				return
			end))

			local var_21_12

			if not arg_21_0.hideFlag or not {
				0,
				arg_21_0.topBgWidth
			} then
				var_21_12 = {
					arg_21_0.topBgWidth,
					0
				}
			end

			LeanTween = var_21_6

			local var_21_13 = var_21_6.value

			go = var_6

			local var_21_14 = var_21_13(var_6(arg_21_0.topBg), var_21_12[1], var_21_12[2], 0.3)
			local var_21_15 = var_4.setOnUpdate

			System = var_7

			var_21_15(var_21_14, var_7.Action_float(function(arg_24_0)
				setAnchoredPosition = var_2_10001

				var_2_10001(arg_21_0.topBg, {
					y = arg_24_0
				})

				return
			end))

			return
		end
	end
end

function var_0_1.UpdateBg(arg_25_0)
	local var_25_0 = arg_25_0.guildVO
	local var_25_1 = var_1.getBgName(var_25_0)

	if arg_25_0.bgName ~= var_25_1 then
		GetSpriteFromAtlasAsync = var_2

		var_2(var_25_1, "", function(arg_26_0)
			IsNil = var_2_10001

			if not var_2_10001(arg_25_0._tf) then
				setImageSprite = var_1

				var_1(arg_25_0._bg, arg_26_0, false)
			end

			return
		end)

		arg_25_0.bgName = var_25_1
	end

	return
end

function var_0_1.UpdateNotices(arg_27_0, arg_27_1)
	getProxy = var_1_10002
	GuildProxy = var_1_10004

	local var_27_0 = var_1_10002(var_1_10004)
	local var_27_1 = arg_27_0.guildVO

	if arg_27_1 == var_0_1.NOTIFY_TYPE_ALL or arg_27_1 == var_0_1.NOTIFY_TYPE_MAIN then
		setActive = var_4

		var_4(arg_27_0.mainTip, var_27_0:ShouldShowMainTip())
	end

	if arg_27_1 == var_0_1.NOTIFY_TYPE_ALL or arg_27_1 == var_0_1.NOTIFY_TYPE_APPLY then
		setActive = var_4

		var_4(arg_27_0.applyTip, var_27_0:ShouldShowApplyTip())
	end

	if arg_27_1 == var_0_1.NOTIFY_TYPE_ALL or arg_27_1 == var_0_1.NOTIFY_TYPE_OFFICE then
		setActive = var_4

		var_4(arg_27_0.officeTip, var_27_1:ShouldShowOfficeTip())
	end

	if arg_27_1 == var_0_1.NOTIFY_TYPE_ALL or arg_27_1 == var_0_1.NOTIFY_TYPE_BATTLE then
		setActive = var_4

		var_4(arg_27_0.battleTip, var_27_0:ShouldShowBattleTip())
	end

	if arg_27_1 == var_0_1.NOTIFY_TYPE_ALL or arg_27_1 == var_0_1.NOTIFY_TYPE_TECH then
		setActive = var_4

		var_4(arg_27_0.techTip, var_27_1:ShouldShowTechTip())
	end

	return
end

function var_0_1.initTheme(arg_28_0)
	local var_28_0 = arg_28_0.guildVO
	local var_28_1 = var_1.getFaction(var_28_0)

	if not arg_28_0.faction or arg_28_0.faction ~= var_28_1 then
		if arg_28_0.themePage then
			local var_28_2 = arg_28_0.themePage

			var_2.Destroy(var_28_2)
		end

		GuildThemePage = var_2
		arg_28_0.themePage = var_2.New(arg_28_0.mainTF, arg_28_0.event, arg_28_0.contextData)

		local var_28_3 = arg_28_0.themePage

		var_2.ExecuteAction(var_28_3, "Update", arg_28_0.guildVO, arg_28_0.playerVO, arg_28_0.chatMsgs)

		arg_28_0.faction = var_28_1
	else
		local var_28_4 = arg_28_0.themePage

		var_2.ActionInvoke(var_28_4, "Update", arg_28_0.guildVO, arg_28_0.playerVO, arg_28_0.chatMsgs)
	end

	return
end

function var_0_1.OpenMainPage(arg_29_0)
	if arg_29_0.themePage then
		local var_29_0 = arg_29_0.themePage

		if not var_1.GetLoaded(var_29_0) then
			arg_29_0:initTheme()
		else
			local var_29_1 = arg_29_0.themePage

			var_1.Show(var_29_1)
		end

		return
	end
end

function var_0_1.initToggles(arg_30_0)
	local var_30_0 = arg_30_0.contextData

	var_30_0.toggles = {}
	ipairs = var_30_0

	for iter_30_0, iter_30_1 in var_30_0(var_0_1.TOGGLE_TAG) do
		local var_30_1 = arg_30_0.contextData.toggles
		local var_30_2 = arg_30_0.toggleRoot

		var_30_1[iter_30_1] = var_7.Find(var_30_2, iter_30_1)
		assert = var_30_1

		var_30_1(arg_30_0.contextData.toggles[iter_30_1], "transform canot be nil" .. iter_30_1)

		onToggle = var_30_1

		local var_30_3 = arg_30_0
		local var_30_4 = arg_30_0.contextData.toggles[iter_30_1]

		local function var_30_5(arg_31_0)
			if arg_31_0 then
				local var_31_0 = arg_30_0

				var_1.openPage(var_31_0, iter_30_1)

				setActive = var_1

				var_1(arg_30_0._bg, iter_30_1 ~= var_0_2)
			else
				local var_31_1 = arg_30_0

				var_1.closePage(var_31_1, iter_30_1)
			end

			return
		end

		SFX_PANEL = var_1_10011

		var_30_1(var_30_3, var_30_4, var_30_5, var_1_10011)
	end

	LOCK_GUILD_BATTLE = var_1

	if var_1 then
		setActive = var_1

		var_1(arg_30_0.contextData.toggles[var_0_7], false)
	end

	local var_30_6 = arg_30_0.guildVO
	local var_30_7 = var_1.getDutyByMemberId(var_30_6, arg_30_0.playerVO.id)

	setActive = var_2

	local var_30_8 = arg_30_0.contextData.toggles[var_0_4]

	GuildConst = var_5

	local var_30_9

	if var_30_7 ~= var_5.DUTY_COMMANDER then
		GuildConst = var_5

		if var_30_7 ~= var_5.DUTY_DEPUTY_COMMANDER then
			var_30_9 = false

			goto label_30_0
		end
	end

	var_30_9 = true

	::label_30_0::

	var_2(var_30_8, var_30_9)

	local var_30_10

	if not arg_30_0.contextData.page then
		var_30_10 = var_0_2
	end

	local var_30_11 = arg_30_0.contextData

	var_30_11.page = nil
	assert = var_30_11

	var_30_11(arg_30_0.contextData.toggles[var_30_10])

	triggerToggle = var_30_11

	var_30_11(arg_30_0.contextData.toggles[var_30_10], true)

	return
end

function var_0_1.TriggerOfficePage(arg_32_0)
	triggerToggle = var_1_10001

	var_1_10001(arg_32_0.contextData.toggles[var_0_5], true)

	return
end

function var_0_1.openPage(arg_33_0, arg_33_1)
	setActive = var_1_10002

	var_1_10002(arg_33_0.eyeTF, arg_33_1 == var_0_2)

	if arg_33_1 == var_0_5 or arg_33_1 == var_0_6 then
		local var_33_0 = arg_33_0.guildRes

		var_2.Show(var_33_0)
	elseif arg_33_1 == var_0_7 or arg_33_1 == var_0_4 or arg_33_1 == var_0_3 then
		local var_33_1 = arg_33_0.guildRes

		var_2.Hide(var_33_1)
	else
		local var_33_2 = arg_33_0.guildRes

		var_2.Hide(var_33_2)
	end

	if arg_33_0.themePage then
		local var_33_3 = arg_33_0.themePage

		if var_2.GetLoaded(var_33_3) and arg_33_0.themePage.isShowChatWindow then
			local var_33_4 = arg_33_0.themePage

			var_2.ShowOrHideChatWindow(var_33_4, false)
		end
	end

	if arg_33_0.contextData.page == arg_33_1 then
		return
	end

	if arg_33_1 == var_0_2 then
		arg_33_0:OpenMainPage()

		local var_33_5 = arg_33_0
		local var_33_6 = arg_33_0.emit

		GuildMainMediator = var_5

		var_33_6(var_33_5, var_5.OPEN_MAIN)
	elseif arg_33_1 == var_0_3 then
		local var_33_7 = arg_33_0
		local var_33_8 = arg_33_0.emit

		GuildMainMediator = var_5

		var_33_8(var_33_7, var_5.OPEN_MEMBER)
	elseif arg_33_1 == var_0_4 then
		local var_33_9 = arg_33_0
		local var_33_10 = arg_33_0.emit

		GuildMainMediator = var_5

		var_33_10(var_33_9, var_5.OPEN_APPLY)
	elseif arg_33_1 == var_0_5 then
		local var_33_11 = arg_33_0
		local var_33_12 = arg_33_0.emit

		GuildMainMediator = var_5

		var_33_12(var_33_11, var_5.OPEN_OFFICE)
	elseif arg_33_1 == var_0_6 then
		local var_33_13 = arg_33_0
		local var_33_14 = arg_33_0.emit

		GuildMainMediator = var_5

		var_33_14(var_33_13, var_5.OPEN_TECH)
	elseif arg_33_1 == var_0_7 then
		local var_33_15 = arg_33_0
		local var_33_16 = arg_33_0.emit

		GuildMainMediator = var_5

		var_33_16(var_33_15, var_5.OPEN_BATTLE)
	end

	arg_33_0:UpdateBg()

	arg_33_0.contextData.page = arg_33_1

	return
end

function var_0_1.closePage(arg_34_0, arg_34_1)
	if arg_34_1 == var_0_2 then
		if arg_34_0.themePage then
			local var_34_0 = arg_34_0.themePage

			var_2.ExecuteAction(var_34_0, "Hide")
		end
	elseif arg_34_1 == var_0_3 then
		local var_34_1 = arg_34_0
		local var_34_2 = arg_34_0.emit

		GuildMainMediator = var_1_10005

		var_34_2(var_34_1, var_1_10005.CLOSE_MEMBER)
	elseif arg_34_1 == var_0_4 then
		local var_34_3 = arg_34_0
		local var_34_4 = arg_34_0.emit

		GuildMainMediator = var_1_10005

		var_34_4(var_34_3, var_1_10005.CLOSE_APPLY)
	elseif arg_34_1 == var_0_5 then
		local var_34_5 = arg_34_0
		local var_34_6 = arg_34_0.emit

		GuildMainMediator = var_1_10005

		var_34_6(var_34_5, var_1_10005.CLOSE_OFFICE)
	elseif arg_34_1 == var_0_6 then
		local var_34_7 = arg_34_0
		local var_34_8 = arg_34_0.emit

		GuildMainMediator = var_1_10005

		var_34_8(var_34_7, var_1_10005.CLOSE_TECH)
	elseif arg_34_1 == var_0_7 then
		local var_34_9 = arg_34_0
		local var_34_10 = arg_34_0.emit

		GuildMainMediator = var_1_10005

		var_34_10(var_34_9, var_1_10005.CLOSE_BATTLE)
	end

	return
end

function var_0_1.BlurView(arg_35_0, arg_35_1)
	pg = var_1_10002

	local var_35_0 = var_1_10002.UIMgr.GetInstance()

	var_2.OverlayPanel(var_35_0, arg_35_1, {
		pbList = {
			arg_35_1:Find("Image1/Image1")
		}
	})

	return
end

function var_0_1.UnBlurView(arg_36_0, arg_36_1, arg_36_2)
	pg = var_1_10003

	local var_36_0 = var_1_10003.UIMgr.GetInstance()

	var_3.UnOverlayPanel(var_36_0, arg_36_1, arg_36_2)

	return
end

function var_0_1.Append(arg_37_0, arg_37_1, arg_37_2)
	if arg_37_0.themePage then
		local var_37_0 = arg_37_0.themePage

		if var_3.GetLoaded(var_37_0) then
			local var_37_1 = arg_37_0.themePage

			var_3.Append(var_37_1, arg_37_1, arg_37_2)
		end
	end

	return
end

function var_0_1.UpdateAllChat(arg_38_0, arg_38_1)
	if arg_38_0.themePage then
		local var_38_0 = arg_38_0.themePage

		if var_2.GetLoaded(var_38_0) then
			local var_38_1 = arg_38_0.themePage

			var_2.UpdateAllChat(var_38_1, arg_38_1)
		end
	end

	return
end

function var_0_1.UpdateAllLog(arg_39_0, arg_39_1)
	if arg_39_0.themePage then
		local var_39_0 = arg_39_0.themePage

		if var_2.GetLoaded(var_39_0) then
			local var_39_1 = arg_39_0.themePage

			var_2.UpdateAllChat(var_39_1, arg_39_1)
		end
	end

	return
end

function var_0_1.AppendLog(arg_40_0, arg_40_1, arg_40_2)
	if arg_40_0.themePage then
		local var_40_0 = arg_40_0.themePage

		if var_3.GetLoaded(var_40_0) then
			local var_40_1 = arg_40_0.themePage

			var_3.AppendLog(var_40_1, arg_40_1, arg_40_2)
		end
	end

	return
end

function var_0_1.openResourceLog(arg_41_0)
	local var_41_0 = arg_41_0.logPage

	var_1.ExecuteAction(var_41_0, "Show", arg_41_0.guildVO)

	return
end

function var_0_1.willExit(arg_42_0)
	local var_42_0 = arg_42_0.dynamicBg

	var_1.Dispose(var_42_0)

	local var_42_1 = arg_42_0.logPage

	var_1.Destroy(var_42_1)

	local var_42_2 = arg_42_0.guildRes

	var_1.Destroy(var_42_2)

	if arg_42_0.themePage then
		local var_42_3 = arg_42_0.themePage

		var_1.Destroy(var_42_3)
	end

	pg = var_1

	local var_42_4 = var_1.GuildLayerMgr.GetInstance()

	var_1.Clear(var_42_4)

	pg = var_1

	local var_42_5 = var_1.GuildPaintingMgr.GetInstance()

	var_1.Exit(var_42_5)

	if arg_42_0.contextData.page then
		arg_42_0:closePage(arg_42_0.contextData.page)
	end

	Input = var_1
	var_1.multiTouchEnabled = true

	return
end

function var_0_1.insertEmojiToInputText(arg_43_0, arg_43_1)
	if arg_43_0.themePage then
		local var_43_0 = arg_43_0.themePage

		var_2.InsertEmojiToInputText(var_43_0, arg_43_1)
	end

	return
end

return var_0_1
