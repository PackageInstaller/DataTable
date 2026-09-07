local TWCelebrationPage1 = class("TWCelebrationPage1", import("...base.BaseActivityPage"))

function TWCelebrationPage1:OnInit()
	self.bg = self._tf:Find("AD")
	self.shop = self.bg:Find("go")

	return
end

function TWCelebrationPage1:OnFirstFlush()
	onButton(self, self.shop, function()
		local var_3_0

		if configClinet.shopLinkActID then
			var_3_0 = getProxy(ActivityProxy):getActivitiesById(configClinet.shopLinkActID) or underscore.detect(getProxy(ActivityProxy):getActivitiesByType(ActivityConst.ACTIVITY_TYPE_SHOP), function(arg_4_0)
				return not arg_4_0:isEnd()
			end)

			if not var_3_0 or var_3_0:isEnd() then
				pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

				return
			end
		end

		self:emit(ActivityMediator.GO_SHOPS_LAYER, {
			warp = NewShopsScene.TYPE_ACTIVITY,
			actId = var_3_0.id
		})

		return
	end)

	return
end

return TWCelebrationPage1
