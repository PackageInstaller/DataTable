local SleeplessCityPage = class("SleeplessCityPage", import(".TemplatePage.PtTemplatePage"))

SleeplessCityPage.COLOR = "#BD3F40"

function SleeplessCityPage:OnFirstFlush()
	SleeplessCityPage.super.OnFirstFlush(self)
	onButton(self, self.getBtn, function()
		local var_2_0 = {}
		local var_2_1 = self.ptData:GetAward()
		local var_2_2 = getProxy(PlayerProxy):getRawData()
		local var_2_3, var_2_4 = Task.StaticJudgeOverflow(var_2_2.gold, var_2_2.oil, LOCK_UR_SHIP and 0 or getProxy(BagProxy):GetLimitCntById(pg.gameset.urpt_chapter_max.description[1]), true, true, {
			{
				var_2_1.type,
				var_2_1.id,
				var_2_1.count
			}
		})

		if var_2_3 then
			table.insert(var_2_0, function(arg_3_0)
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					type = MSGBOX_TYPE_ITEM_BOX,
					content = i18n("award_max_warning"),
					items = var_2_4,
					onYes = arg_3_0
				})

				return
			end)
		end

		seriesAsync(var_2_0, function()
			local var_4_0, var_4_1 = self.ptData:GetResProgress()

			self:emit(ActivityMediator.EVENT_PT_OPERATION, {
				cmd = 1,
				activity_id = self.ptData:GetId(),
				arg1 = var_4_1,
				callback = function()
					self:OnUpdateFlush()

					return
				end
			})

			return
		end)

		return
	end, SFX_PANEL)
	self:OnUpdateFlush()

	return
end

function SleeplessCityPage:OnUpdateFlush()
	local var_6_0 = self.activity:getConfig("config_client").story

	if self.level and checkExist(var_6_0, {
		self.level
	}, {
		1
	}) then
		pg.NewStoryMgr.GetInstance():Play(var_6_0[self.level][1])
	end

	self.level = self.ptData:getTargetLevel()

	if self.step then
		local var_6_1, var_6_2, var_6_3 = self.ptData:GetLevelProgress()

		setText(self.step, var_6_1 .. "/" .. var_6_2)
	end

	local var_6_4, var_6_5, var_6_6 = self.ptData:GetResProgress()

	setText(self.progress, (var_6_6 >= 1 and setColorStr(var_6_4, COLOR_GREEN) or setColorStr(var_6_4, SleeplessCityPage.COLOR)) .. "/" .. var_6_5)
	setSlider(self.slider, 0, 1, var_6_6)

	local var_6_7 = self.ptData:CanGetAward()
	local var_6_8 = self.ptData:CanGetNextAward()

	setActive(self.battleBtn, self.ptData:CanGetMorePt() and not var_6_7 and var_6_8)
	setActive(self.getBtn, var_6_7)
	setActive(self.gotBtn, not var_6_8)

	local var_6_9 = self.ptData:GetAward()

	updateDrop(self.awardTF, var_6_9)
	onButton(self, self.awardTF, function()
		self:emit(BaseUI.ON_DROP, var_6_9)

		return
	end, SFX_PANEL)
	setText(self.bg:Find("description"), i18n("activity_victory"))

	if not var_6_8 and var_6_6 >= 1 and not var_6_7 then
		self.level = self.level + 1
	end

	return
end

return SleeplessCityPage
