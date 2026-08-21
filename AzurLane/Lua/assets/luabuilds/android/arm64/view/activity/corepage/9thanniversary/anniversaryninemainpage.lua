local var_0_0 = class("AnniversaryNineMainPage", import("view.activity.CorePage.CoreActivityPage"))

function var_0_0.OnInit(arg_1_0)
	arg_1_0.AD = arg_1_0._tf:Find("AD")
	arg_1_0.btnGo = arg_1_0.AD:Find("title/btn_act")
	arg_1_0.btnManual = arg_1_0.AD:Find("TopPage/top/manual")
	arg_1_0.Txtmanual = arg_1_0.btnManual:Find("Text")
	arg_1_0.redPoint = arg_1_0.btnGo:Find("red_point")
	arg_1_0.redMalPoint = arg_1_0.btnManual:Find("tip")

	return
end

function var_0_0.OnFirstFlush(arg_2_0)
	if arg_2_0:GetMallActOpen() then
		onButton(arg_2_0, arg_2_0.btnGo, function()
			pg.m02:sendNotification(GAME.GO_SCENE, SCENE.MALL_MAP)

			return
		end, SFX_PANEL)
	else
		onButton(arg_2_0, arg_2_0.btnGo, function()
			arg_2_0:emit(ActivityMediator.ON_ADD_SUBLAYER, Context.New({
				mediator = MallAwardMediator,
				viewComponent = MallAwardLayer,
				data = {
					awardHandledByParent = true,
					onExit = function()
						arg_2_0:refreshRed()

						return
					end
				}
			}))

			return
		end, SFX_PANEL)
	end

	onButton(arg_2_0, arg_2_0.btnManual, function()
		arg_2_0:emit(ActivityMediator.ON_ADD_SUBLAYER, (Context.New({
			mediator = MedalAlbumTemplateMediator,
			viewComponent = FujinBayMedalAlbumView
		})))

		return
	end, SFX_PANEL)
	setText(arg_2_0.Txtmanual, i18n("anniversary_nine_main_page"))
	arg_2_0:refreshRed()

	return
end

function var_0_0.GetMallActOpen(arg_7_0)
	local var_7_0 = arg_7_0.coreActivityUI:GetActivityIdByPageClass("AnniversaryNineGamePage")
	local var_7_1 = var_7_0 and getProxy(ActivityProxy):getActivityById(var_7_0)

	return var_7_1 ~= nil and not var_7_1:isEnd()
end

function var_0_0.OnUpdateFlush(arg_8_0)
	arg_8_0:refreshRed()

	return
end

function var_0_0.refreshRed(arg_9_0)
	setActive(arg_9_0.redPoint, var_0_0.IsMallAwardTip())

	local var_9_0, var_9_1 = var_0_0.GetFujinBayMedalTaskCount()

	setActive(arg_9_0.redMalPoint, var_9_1 > 0)

	return
end

function var_0_0.IsShowReminder(arg_10_0)
	return var_0_0.IsTip()
end

function var_0_0.IsMallAwardTip()
	local var_11_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_MALL)

	if not var_11_0 or var_11_0:isEnd() then
		return false
	end

	return MallAwardLayer.IsAwardTip() or MallAwardLayer.IsInputTip() or MallAwardLayer.IsTaskTip()
end

function var_0_0.IsTip()
	return var_0_0.IsMallAwardTip() or var_0_0.IsFujinBayMedalTaskTip()
end

function var_0_0.IsFujinBayMedalTaskTip()
	local var_13_0, var_13_1 = var_0_0.GetFujinBayMedalTaskCount()

	return var_13_1 > 0
end

function var_0_0.GetFujinBayMedalTaskCount()
	if pg.activity_medal_group[FujinBayMedalAlbumView.GROUP_ID] then
		local var_14_0 = pg.activity_medal_group[FujinBayMedalAlbumView.GROUP_ID].activity_link or {}
		local var_14_1

		for iter_14_0, iter_14_1 in ipairs(var_14_0) do
			local var_14_2 = getProxy(ActivityProxy):getActivityById(iter_14_1[2])

			if var_14_2 and not var_14_2:isEnd() then
				var_14_1 = iter_14_1[3]

				break
			end
		end

		if not var_14_1 then
			return 0, 0, 0
		end

		local var_14_3 = getProxy(TaskProxy)
		local var_14_4 = 0
		local var_14_5 = 0

		for iter_14_2, iter_14_3 in ipairs(var_14_1) do
			local var_14_6 = var_14_3:getTaskById(iter_14_3) or var_14_3:getFinishTaskById(iter_14_3)

			if var_14_6 then
				local var_14_7 = var_14_6:getTaskStatus()

				if var_14_7 == 1 then
					var_14_5 = var_14_5 + 1
					var_14_4 = var_14_4 + 1
				elseif var_14_7 == 2 then
					var_14_4 = var_14_4 + 1
				end
			end
		end

		return var_14_4, var_14_5, #var_14_1
	end
end

return var_0_0
