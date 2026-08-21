local var_0_0 = class("PreviewTemplatePage", import("view.base.BaseActivityPage"))

function var_0_0.OnInit(arg_1_0)
	arg_1_0.bg = arg_1_0._tf:Find("AD")
	arg_1_0.btnList = arg_1_0.bg:Find("btn_list")

	return
end

function var_0_0.OnFirstFlush(arg_2_0)
	arg_2_0:initBtn()
	eachChild(arg_2_0.btnList, function(arg_3_0)
		arg_2_0.btnFuncList[arg_3_0.name](arg_3_0)

		return
	end)

	return
end

function var_0_0.initBtn(arg_4_0)
	local function var_4_0(arg_5_0)
		local var_5_0 = getProxy(ActivityProxy):getActivityById(arg_5_0)

		if not var_5_0 or var_5_0 and var_5_0:isEnd() then
			return true
		else
			return false
		end

		return
	end

	local var_4_1 = arg_4_0.activity:getConfig("config_client")

	arg_4_0.btnFuncList = {
		task = function(arg_6_0)
			onButton(arg_4_0, arg_6_0, function()
				if var_4_1.taskLinkActID and var_4_0(var_4_1.taskLinkActID) then
					pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

					return
				end

				arg_4_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.TASK, {
					page = "activity"
				})

				return
			end)

			return
		end,
		shop = function(arg_8_0)
			onButton(arg_4_0, arg_8_0, function()
				if var_4_1.shopLinkActID then
					local var_9_0 = getProxy(ActivityProxy):getActivitiesById(var_4_1.shopLinkActID) or underscore.detect(getProxy(ActivityProxy):getActivitiesByType(ActivityConst.ACTIVITY_TYPE_SHOP), function(arg_10_0)
						return not arg_10_0:isEnd()
					end)

					if not var_9_0 or var_9_0:isEnd() then
						pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

						return
					end

					arg_4_0:emit(ActivityMediator.GO_SHOPS_LAYER, {
						warp = NewShopsScene.TYPE_ACTIVITY,
						actId = var_9_0.id
					})

					return
				end
			end)

			return
		end,
		build = function(arg_11_0)
			onButton(arg_4_0, arg_11_0, function()
				if var_4_1.buildLinkActID and var_4_0(var_4_1.buildLinkActID) then
					pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

					return
				end

				arg_4_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.GETBOAT, {
					page = BuildShipScene.PAGE_BUILD,
					projectName = BuildShipScene.PROJECTS.ACTIVITY
				})

				return
			end)

			return
		end,
		fight = function(arg_13_0)
			onButton(arg_4_0, arg_13_0, function()
				if var_4_1.fightLinkActID and var_4_0(var_4_1.fightLinkActID) then
					pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

					return
				end

				if var_4_1.fightLinkActID then
					arg_4_0:emit(ActivityMediator.SKIP_ACTIVITY_MAP, var_4_1.fightLinkActID)
				else
					arg_4_0:emit(ActivityMediator.BATTLE_OPERA)
				end

				return
			end)

			return
		end,
		lottery = function(arg_15_0)
			onButton(arg_4_0, arg_15_0, function()
				if var_4_1.lotteryLinkActID and var_4_0(var_4_1.lotteryLinkActID) then
					pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

					return
				end

				arg_4_0:emit(ActivityMediator.GO_LOTTERY)

				return
			end)

			return
		end,
		memory = function(arg_17_0)
			return
		end,
		activity = function(arg_18_0)
			return
		end,
		mountain = function(arg_19_0)
			return
		end,
		skinshop = function(arg_20_0)
			onButton(arg_4_0, arg_20_0, function()
				arg_4_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.SKINSHOP)

				return
			end)

			return
		end
	}

	return
end

return var_0_0
