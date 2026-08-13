class = var_0_10000

local var_0_0 = "AuctionGameCoreActivityUI"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.activity.CorePage.CoreActivityMainScene"))

function var_0_1.getUIName(arg_1_0)
	return "AuctionGameCoreActivityUI"
end

function var_0_1.preload(arg_2_0, arg_2_1)
	local var_2_0 = {}

	table = var_1_10003

	var_1_10003.insert(var_2_0, function(arg_3_0)
		pg = var_2_10001

		local var_3_0 = var_2_10001.m02
		local var_3_1 = var_1.sendNotification

		GAME = var_2_10004

		var_3_1(var_3_0, var_2_10004.AUCTION_GAME_INIT, {
			callback = arg_3_0
		})

		return
	end)

	seriesAsync = var_3

	var_3(var_2_0, arg_2_1)

	return
end

var_0_1.optionsPath = {
	"adapt/TopPage/top/btn_home"
}

function var_0_1.init(arg_4_0, ...)
	var_0_1.super.init(arg_4_0, ...)

	local var_4_0 = arg_4_0._tf

	arg_4_0.btnBack = var_1.Find(var_4_0, "adapt/TopPage/top/btn_back")

	local var_4_1 = arg_4_0._tf

	arg_4_0.topPage = var_1.Find(var_4_1, "adapt/TopPage")
	setText = var_1

	local var_4_2 = arg_4_0._tf
	local var_4_3 = var_3.Find(var_4_2, "adapt/TopPage/top/deco/Text")

	i18n = var_4

	var_1(var_4_3, var_4("HelenaCoreActivity_title"))

	setText = var_1

	local var_4_4 = arg_4_0._tf
	local var_4_5 = var_3.Find(var_4_4, "adapt/TopPage/top/deco/Text/Text_1")

	i18n = var_4

	var_1(var_4_5, var_4("HelenaCoreActivity_title2"))

	setText = var_1

	local var_4_6 = arg_4_0._tf
	local var_4_7 = var_3.Find(var_4_6, "adapt/taskBtn/Text")

	i18n = var_4

	var_1(var_4_7, var_4("auction_signin_task"))

	setText = var_1

	local var_4_8 = arg_4_0._tf
	local var_4_9 = var_3.Find(var_4_8, "adapt/auctionGameBtn/Text")

	i18n = var_4

	var_1(var_4_9, var_4("auction_signin_goto"))

	findTF = var_1
	arg_4_0.uiTaskTipGo = var_1(arg_4_0._tf, "adapt/taskBtn/tip")
	findTF = var_1
	arg_4_0.uiAuctionTipGo = var_1(arg_4_0._tf, "adapt/auctionGameBtn/tip")
	onButton = var_1

	local var_4_10 = arg_4_0

	findTF = var_4

	local var_4_11 = var_4(arg_4_0._tf, "adapt/auctionGameBtn")

	local function var_4_12()
		getProxy = var_2_10000
		ActivityProxy = var_2_10002

		local var_5_0 = var_2_10000(var_2_10002)
		local var_5_1 = var_0.getActivityByType

		ActivityConst = var_2_10004

		if var_5_1(var_5_0, var_2_10004.ACTIVITY_TYPE_AUCTION_GAME) == nil or var_1 and var_1:isEnd() then
			pg = var_2_10002

			local var_5_2 = var_2_10002.TipsMgr.GetInstance()

			var_2_10002 = var_2_10002.ShowTips
			i18n = var_2_10005

			var_2_10002(var_5_2, var_2_10005("auction_activity_closed_tip"))

			return
		end

		pg = var_2_10002

		local var_5_3 = var_2_10002.m02
		local var_5_4 = var_2.sendNotification

		GAME = var_2_10005

		local var_5_5 = var_2_10005.GO_SCENE

		SCENE = var_2_10006

		var_5_4(var_5_3, var_5_5, var_2_10006.AUCTION_GAME_ENTRANCE)

		return
	end

	SFX_PANEL = var_6

	var_1(var_4_10, var_4_11, var_4_12, var_6)

	onButton = var_1

	local var_4_13 = arg_4_0

	findTF = var_4_11

	local var_4_14 = var_4_11(arg_4_0._tf, "adapt/taskBtn")

	local function var_4_15()
		getProxy = var_2_10000
		ActivityProxy = var_2_10002

		local var_6_0 = var_2_10000(var_2_10002)
		local var_6_1 = var_0.getActivityByType

		ActivityConst = var_2_10004

		if var_6_1(var_6_0, var_2_10004.ACTIVITY_TYPE_AUCTION_GAME) == nil or var_1 and var_1:isEnd() then
			pg = var_2_10002

			local var_6_2 = var_2_10002.TipsMgr.GetInstance()
			local var_6_3 = var_2.ShowTips

			i18n = var_2_10005

			var_6_3(var_6_2, var_2_10005("auction_activity_closed_tip"))

			return
		end

		local var_6_4 = arg_4_0
		local var_6_5 = var_2.emit

		BaseUI = var_2_10005

		local var_6_6 = var_2_10005.ON_ADD_SUBLAYER

		Context = var_2_10006

		local var_6_7 = var_2_10006.New
		local var_6_8 = {}

		AuctionGameTaskScene = var_2_10009
		var_6_8.viewComponent = var_2_10009
		AuctionGameTaskMediator = var_2_10009
		var_6_8.mediator = var_2_10009
		var_6_8.data = {}

		var_6_5(var_6_4, var_6_6, var_6_7(var_6_8))

		return
	end

	SFX_PANEL = var_6

	var_1(var_4_13, var_4_14, var_4_15, var_6)

	local var_4_16
	local var_4_17 = arg_4_0.tabsList

	var_2.make(var_4_17, function(arg_7_0, arg_7_1, arg_7_2)
		UIItemList = var_2_10003

		if arg_7_0 == var_2_10003.EventUpdate then
			underscore = var_3

			if var_3.detect(arg_4_0.activities, function(arg_8_0)
				tostring = var_3_10001

				return var_3_10001(arg_8_0:getConfig("is_show")) == arg_7_2.name
			end) then
				local var_7_0 = var_3

				if var_3.isEnd(var_7_0) then
					setActive = var_2_10004

					var_2_10004(arg_7_2, false)
				elseif not arg_4_0.pageDic[var_3.id] then
					warning = var_4
					string = var_7_0

					var_4(var_7_0.format("without page in act:", var_3.id))
				else
					local var_7_1 = arg_4_0

					var_4.OnToggleName(var_7_1, arg_7_2, var_3)

					if arg_4_0.pageDic[var_3.id] ~= nil then
						setActive = var_5

						local var_7_2 = arg_7_2:Find("tip")
						local var_7_3 = var_3

						var_5(var_7_2, var_3.readyToAchieve(var_7_3))

						onToggle = var_5

						local var_7_4 = arg_4_0
						local var_7_5 = arg_7_2

						local function var_7_6(arg_9_0)
							local var_9_0 = arg_7_2
							local var_9_1 = var_1.Find(var_9_0, "off")

							if arg_9_0 then
								if var_4_16 ~= var_0.id then
									local var_9_2 = arg_4_0

									var_3_10002.selectActivity(var_9_2, var_0)
								end

								var_4_16 = var_0.id
							end

							setActive = var_3_10002

							var_3_10002(var_9_1, not arg_9_0)

							return
						end

						SFX_PANEL = var_7_3

						var_5(var_7_4, var_7_5, var_7_6, var_7_3)
					end
				end

				return
			end
		end
	end)

	return
end

function var_0_1.didEnter(arg_10_0)
	var_0_1.super.didEnter(arg_10_0)

	pg = var_1

	local var_10_0 = var_1.NewStoryMgr.GetInstance()

	var_1.Play(var_10_0, "TEBIEJINGPAISHIKE1")
	arg_10_0:RefreshTip()

	return
end

function var_0_1.updateActivity(arg_11_0, arg_11_1)
	var_0_1.super.updateActivity(arg_11_0, arg_11_1)
	arg_11_0:RefreshTip()

	return
end

function var_0_1.RefreshTip(arg_12_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10003

	local var_12_0 = var_1_10001(var_1_10003)
	local var_12_1 = var_1.getActivityByType

	ActivityConst = var_1_10005

	if var_12_1(var_12_0, var_1_10005.ACTIVITY_TYPE_AUCTION_GAME) == nil then
		setActive = var_1_10003

		var_1_10003(arg_12_0.uiTaskTipGo, false)

		setActive = var_1_10003

		var_1_10003(arg_12_0.uiAuctionTipGo, false)
	else
		setActive = var_1_10003

		var_1_10003(arg_12_0.uiTaskTipGo, var_2:GetTaskTip())

		setActive = var_1_10003

		var_1_10003(arg_12_0.uiAuctionTipGo, var_2:readyToAchieve())
	end

	return
end

function var_0_1.verifyTabs(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0.activities
	local var_13_1

	if not arg_13_0:getActivityIndex(arg_13_1) and not arg_13_0:getActivityIndex(arg_13_0:GetActiveActivity()) then
		var_13_1 = 1
	end

	if var_13_0[var_13_1] == nil then
		return
	end

	local var_13_2 = var_2:getConfig("is_show")
	local var_13_3 = arg_13_0.tabs
	local var_13_4 = var_4.Find

	tostring = var_1_10007

	local var_13_5 = var_13_4(var_13_3, var_1_10007(var_13_2))

	if #arg_13_0.activities == 1 then
		setActive = var_5

		local var_13_6 = arg_13_0._tf

		var_5(var_7.Find(var_13_6, "adapt/tabs"), false)
	else
		setActive = var_5

		local var_13_7 = arg_13_0._tf

		var_5(var_7.Find(var_13_7, "adapt/tabs"), true)
	end

	triggerToggle = var_5

	var_5(var_13_5, true)

	return
end

function var_0_1.OnToggleName(arg_14_0, arg_14_1, arg_14_2)
	setText = var_1_10003

	local var_14_0 = arg_14_1:Find("on/name")

	i18n = var_1_10006

	var_1_10003(var_14_0, var_1_10006(arg_14_2:getConfig("title_res_tag")))

	setText = var_1_10003

	local var_14_1 = arg_14_1:Find("off/name")

	i18n = var_6

	var_1_10003(var_14_1, var_6(arg_14_2:getConfig("title_res_tag")))

	return
end

function var_0_1.willExit(arg_15_0)
	var_0_1.super.willExit(arg_15_0)

	return
end

return var_0_1
