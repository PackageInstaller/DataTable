local var_0_0 = class("HolidayVillaIslandMainPage", import(".TemplatePage.PreviewTemplatePage"))

function var_0_0.initBtn(arg_1_0)
	var_0_0.super.initBtn(arg_1_0)

	arg_1_0.Manual = arg_1_0.bg:Find("Manual")

	function arg_1_0.btnFuncList.shop(arg_2_0)
		onButton(arg_1_0, arg_2_0, function()
			local var_3_0 = underscore.detect(getProxy(ActivityProxy):getActivitiesByType(ActivityConst.ACTIVITY_TYPE_SHOP), function(arg_4_0)
				return arg_4_0:getConfig("config_id") == 3
			end)

			if not var_3_0 or var_3_0:isEnd() then
				pg.TipsMgr.GetInstance():ShowTips(i18n("challenge_end_tip"))

				return
			end

			arg_1_0:emit(ActivityMediator.OPEN_LAYER, (Context.New({
				mediator = HolidayVillaShopMediator,
				viewComponent = HolidayVillaShopLayer
			})))

			return
		end, SFX_PANEL)

		return
	end

	function arg_1_0.btnFuncList.activity(arg_5_0)
		onButton(arg_1_0, arg_5_0, function()
			local var_6_0 = getProxy(ActivityProxy):getActivityById(ActivityConst.HOLIDAY_ACT_PRE_ID)

			if var_6_0.data3 >= 5 then
				if getProxy(TaskProxy):getTaskVO(underscore.flatten(var_6_0:getConfig("config_data"))[var_6_0.data3]):getTaskStatus() == 2 then
					arg_1_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.HOLIDAY_VILLA_MAP)
				else
					arg_1_0:emit(ActivityMediator.SELECT_ACTIVITY, ActivityConst.HOLIDAY_ACT_PRE_ID)
				end
			else
				arg_1_0:emit(ActivityMediator.SELECT_ACTIVITY, ActivityConst.HOLIDAY_ACT_PRE_ID)
			end

			return
		end, SFX_PANEL)

		return
	end

	onButton(arg_1_0, arg_1_0.Manual, function()
		arg_1_0:emit(ActivityMediator.ON_ADD_SUBLAYER, (Context.New({
			mediator = MedalAlbumTemplateMediator,
			viewComponent = HolidayVillaMedalAlbumView
		})))

		return
	end, SFX_PANEL)

	return
end

return var_0_0
