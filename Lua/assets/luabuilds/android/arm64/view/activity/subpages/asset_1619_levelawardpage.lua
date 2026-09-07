local LevelAwardPage = class("LevelAwardPage", import("...base.BaseActivityPage"))

function LevelAwardPage:OnInit()
	self.bg = self._tf:Find("bg")
	self.award = self._tf:Find("scroll/award")
	self.content = self._tf:Find("scroll/content")
	self.scrollTF = self._tf:Find("scroll")
	self.pageSignDownTF = self._tf:Find("sign")
	self.pageSignUpTF = self._tf:Find("sign_up")

	return
end

function LevelAwardPage:OnDataSetting()
	self.config = pg.activity_level_award[self.activity:getConfig("config_id")]

	return
end

function LevelAwardPage:OnFirstFlush()
	setActive(self.award, false)

	for iter_3_0 = 1, #self.config.front_drops do
		local var_3_0 = self.config.front_drops[iter_3_0][1]
		local var_3_1 = cloneTplTo(self.award, self.content, "award" .. tostring(iter_3_0))
		local var_3_2 = var_3_1:Find("limit_label/labelLevel")
		local var_3_3 = var_3_1:Find("btnAchieve")
		local var_3_4 = var_3_1:Find("items")
		local var_3_5 = var_3_1:Find("item")

		setActive(var_3_5, false)
		GetImageSpriteFromAtlasAsync("ui/activityuipage/level_award_atlas", tostring(self.config.front_drops[iter_3_0][1]), var_3_2, true)

		for iter_3_1 = 2, #self.config.front_drops[iter_3_0] do
			local var_3_6 = cloneTplTo(var_3_5, var_3_4)
			local var_3_7 = {
				type = self.config.front_drops[iter_3_0][iter_3_1][1],
				id = self.config.front_drops[iter_3_0][iter_3_1][2],
				count = self.config.front_drops[iter_3_0][iter_3_1][3]
			}

			updateDrop(var_3_6, var_3_7)
			onButton(self, var_3_6, function()
				self:emit(BaseUI.ON_DROP, var_3_7)

				return
			end, SFX_PANEL)
		end

		onButton(self, var_3_3, function()
			self:emit(ActivityMediator.EVENT_OPERATION, {
				cmd = 1,
				activity_id = self.activity.id,
				arg1 = var_3_0
			})

			return
		end, SFX_PANEL)
		onScroll(self, self.scrollTF, function(arg_6_0)
			setActive(self.pageSignDownTF, arg_6_0.y > 0.01)
			setActive(self.pageSignUpTF, arg_6_0.y < 0.99)

			return
		end)
	end

	return
end

function LevelAwardPage:OnUpdateFlush()
	for iter_7_0 = 1, #self.config.front_drops do
		local var_7_0 = self.config.front_drops[iter_7_0]
		local var_7_1 = self.content:Find("award" .. tostring(iter_7_0))
		local var_7_2 = var_7_1:Find("btnAchieve")
		local var_7_3 = var_7_1:Find("achieve_sign")
		local var_7_4 = _.include(self.activity.data1_list, self.config.front_drops[iter_7_0][1])

		if var_7_4 then
			var_7_1.transform:SetAsLastSibling()
		end

		setGray(var_7_1:Find("limit_label"), var_7_4)
		setGray(var_7_1:Find("items"), var_7_4)
		setActive(var_7_3, var_7_4)
		setActive(var_7_2, self.shareData.player.level >= var_7_0[1] and not var_7_4)
	end

	return
end

function LevelAwardPage:OnDestroy()
	return
end

return LevelAwardPage
