local var_0_0 = class("AuctionGameCoreActivityUI", import("view.activity.CorePage.CoreActivityMainScene"))

function var_0_0.getUIName(arg_1_0)
	return "AuctionGameCoreActivityUI"
end

function var_0_0.preload(arg_2_0, arg_2_1)
	table.insert({}, function(arg_3_0)
		pg.m02:sendNotification(GAME.AUCTION_GAME_INIT, {
			callback = arg_3_0
		})

		return
	end)
	seriesAsync({}, arg_2_1)

	return
end

var_0_0.optionsPath = {
	"adapt/TopPage/top/btn_home"
}

function var_0_0.init(arg_4_0, ...)
	var_0_0.super.init(arg_4_0, ...)

	arg_4_0.btnBack = arg_4_0._tf:Find("adapt/TopPage/top/btn_back")
	arg_4_0.topPage = arg_4_0._tf:Find("adapt/TopPage")

	setText(arg_4_0._tf:Find("adapt/TopPage/top/deco/Text"), i18n("HelenaCoreActivity_title"))
	setText(arg_4_0._tf:Find("adapt/TopPage/top/deco/Text/Text_1"), i18n("HelenaCoreActivity_title2"))
	setText(arg_4_0._tf:Find("adapt/taskBtn/Text"), i18n("auction_signin_task"))
	setText(arg_4_0._tf:Find("adapt/auctionGameBtn/Text"), i18n("auction_signin_goto"))

	arg_4_0.uiTaskTipGo = findTF(arg_4_0._tf, "adapt/taskBtn/tip")
	arg_4_0.uiAuctionTipGo = findTF(arg_4_0._tf, "adapt/auctionGameBtn/tip")

	onButton(arg_4_0, findTF(arg_4_0._tf, "adapt/auctionGameBtn"), function()
		local var_5_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_AUCTION_GAME)

		if var_5_0 == nil or var_5_0 and var_5_0:isEnd() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("auction_activity_closed_tip"))

			return
		end

		pg.m02:sendNotification(GAME.GO_SCENE, SCENE.AUCTION_GAME_ENTRANCE)

		return
	end, SFX_PANEL)
	onButton(arg_4_0, findTF(arg_4_0._tf, "adapt/taskBtn"), function()
		local var_6_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_AUCTION_GAME)

		if var_6_0 == nil or var_6_0 and var_6_0:isEnd() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("auction_activity_closed_tip"))

			return
		end

		arg_4_0:emit(BaseUI.ON_ADD_SUBLAYER, Context.New({
			viewComponent = AuctionGameTaskScene,
			mediator = AuctionGameTaskMediator,
			data = {}
		}))

		return
	end, SFX_PANEL)

	local var_4_0

	arg_4_0.tabsList:make(function(arg_7_0, arg_7_1, arg_7_2)
		if arg_7_0 == UIItemList.EventUpdate then
			local var_7_0 = underscore.detect(arg_4_0.activities, function(arg_8_0)
				return tostring(arg_8_0:getConfig("is_show")) == arg_7_2.name
			end)

			if not var_7_0 or var_7_0:isEnd() then
				setActive(arg_7_2, false)
			elseif not arg_4_0.pageDic[var_7_0.id] then
				warning(string.format("without page in act:", var_7_0.id))
			else
				arg_4_0:OnToggleName(arg_7_2, var_7_0)

				if arg_4_0.pageDic[var_7_0.id] ~= nil then
					setActive(arg_7_2:Find("tip"), var_7_0:readyToAchieve())
					onToggle(arg_4_0, arg_7_2, function(arg_9_0)
						if arg_9_0 then
							if var_4_0 ~= var_7_0.id then
								arg_4_0:selectActivity(var_7_0)
							end

							var_4_0 = var_7_0.id
						end

						setActive(arg_7_2:Find("off"), not arg_9_0)

						return
					end, SFX_PANEL)
				end
			end
		end

		return
	end)

	return
end

function var_0_0.didEnter(arg_10_0)
	var_0_0.super.didEnter(arg_10_0)
	pg.NewStoryMgr.GetInstance():Play("TEBIEJINGPAISHIKE1")
	arg_10_0:RefreshTip()

	return
end

function var_0_0.updateActivity(arg_11_0, arg_11_1)
	var_0_0.super.updateActivity(arg_11_0, arg_11_1)
	arg_11_0:RefreshTip()

	return
end

function var_0_0.RefreshTip(arg_12_0)
	local var_12_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_AUCTION_GAME)

	if var_12_0 == nil then
		setActive(arg_12_0.uiTaskTipGo, false)
		setActive(arg_12_0.uiAuctionTipGo, false)
	else
		setActive(arg_12_0.uiTaskTipGo, var_12_0:GetTaskTip())
		setActive(arg_12_0.uiAuctionTipGo, var_12_0:readyToAchieve())
	end

	return
end

function var_0_0.verifyTabs(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0:getActivityIndex(arg_13_1) or arg_13_0:getActivityIndex(arg_13_0:GetActiveActivity()) or 1

	if arg_13_0.activities[var_13_0] == nil then
		return
	end

	local var_13_1 = arg_13_0.tabs:Find(tostring((arg_13_0.activities[var_13_0]:getConfig("is_show"))))

	if #arg_13_0.activities == 1 then
		setActive(arg_13_0._tf:Find("adapt/tabs"), false)
	else
		setActive(arg_13_0._tf:Find("adapt/tabs"), true)
	end

	triggerToggle(var_13_1, true)

	return
end

function var_0_0.OnToggleName(arg_14_0, arg_14_1, arg_14_2)
	setText(arg_14_1:Find("on/name"), i18n(arg_14_2:getConfig("title_res_tag")))
	setText(arg_14_1:Find("off/name"), i18n(arg_14_2:getConfig("title_res_tag")))

	return
end

function var_0_0.willExit(arg_15_0)
	var_0_0.super.willExit(arg_15_0)

	return
end

return var_0_0
