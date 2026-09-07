local CorePreviewTemplatePage = class("CorePreviewTemplatePage", import("view.activity.CorePage.CoreActivityPage"))

function CorePreviewTemplatePage:OnInit()
	self.bg = self._tf:Find("AD")
	self.btnList = self.bg:Find("btn_list")

	return
end

function CorePreviewTemplatePage:OnFirstFlush()
	self:initBtn()
	eachChild(self.btnList, function(arg_3_0)
		self.btnFuncList[arg_3_0.name](arg_3_0)

		return
	end)

	return
end

function CorePreviewTemplatePage:initBtn()
	local function var_4_0(arg_5_0)
		local var_5_0 = getProxy(ActivityProxy):getActivityById(arg_5_0)

		if not var_5_0 or var_5_0 and var_5_0:isEnd() then
			return true
		else
			return false
		end

		return
	end

	local var_4_1 = self.activity:getConfig("config_client")

	self.btnFuncList = {
		task = function(arg_6_0)
			onButton(self, arg_6_0, function()
				if var_4_1.taskLinkActID and var_4_0(var_4_1.taskLinkActID) then
					pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

					return
				end

				self:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.TASK, {
					page = "activity"
				})

				return
			end)

			return
		end,
		shop = function(arg_8_0)
			onButton(self, arg_8_0, function()
				local var_9_0

				if var_4_1.shopLinkActID then
					var_9_0 = getProxy(ActivityProxy):getActivitiesById(var_4_1.shopLinkActID) or underscore.detect(getProxy(ActivityProxy):getActivitiesByType(ActivityConst.ACTIVITY_TYPE_SHOP), function(arg_10_0)
						return not arg_10_0:isEnd()
					end)

					if not var_9_0 or var_9_0:isEnd() then
						pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

						return
					end
				end

				self:emit(ActivityMediator.GO_SHOPS_LAYER, {
					warp = NewShopsScene.TYPE_ACTIVITY,
					actId = var_9_0.id
				})

				return
			end)

			return
		end,
		build = function(arg_11_0)
			onButton(self, arg_11_0, function()
				if var_4_1.buildLinkActID and var_4_0(var_4_1.buildLinkActID) then
					pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

					return
				end

				self:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.GETBOAT, {
					page = BuildShipScene.PAGE_BUILD,
					projectName = BuildShipScene.PROJECTS.ACTIVITY
				})

				return
			end)

			return
		end,
		fight = function(arg_13_0)
			onButton(self, arg_13_0, function()
				if var_4_1.fightLinkActID and var_4_0(var_4_1.fightLinkActID) then
					pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

					return
				end

				self:emit(ActivityMediator.BATTLE_OPERA)

				return
			end)

			return
		end,
		lottery = function(arg_15_0)
			onButton(self, arg_15_0, function()
				if var_4_1.lotteryLinkActID and var_4_0(var_4_1.lotteryLinkActID) then
					pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

					return
				end

				self:emit(ActivityMediator.GO_LOTTERY)

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
			onButton(self, arg_20_0, function()
				self:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.SKINSHOP)

				return
			end)

			return
		end
	}

	return
end

return CorePreviewTemplatePage
