local ShanChengPtSkinPage = class("ShanChengPtSkinPage", import("...base.BaseActivityPage"))

function ShanChengPtSkinPage:OnInit()
	self.bg = self._tf:Find("AD")
	self.shop = self.bg:Find("go")

	return
end

function ShanChengPtSkinPage:OnFirstFlush()
	local var_2_0 = _.detect(getProxy(ActivityProxy):getActivitiesByType(ActivityConst.ACTIVITY_TYPE_SHOP), function(arg_3_0)
		return arg_3_0:getConfig("config_client").pt_id == self.activity:getConfig("config_client").pt_id
	end)

	onButton(self, self.shop, function()
		local var_4_0 = {
			warp = NewShopsScene.TYPE_ACTIVITY
		}

		var_4_0.actId = var_2_0 and var_2_0.id

		self:emit(ActivityMediator.GO_SHOPS_LAYER, var_4_0)

		return
	end)

	return
end

return ShanChengPtSkinPage
