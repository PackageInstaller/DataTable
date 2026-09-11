local ShiningMagicKillPage = class("ShiningMagicKillPage", import("..CoreActivityPage"))

function ShiningMagicKillPage:OnInit()
	self.bg = self._tf:Find("AD")
	self.rtTask = self.bg:Find("task")
	self.step = self.rtTask:Find("step")
	self.nowday = self.step:Find("nowday")
	self.aimday = self.step:Find("aimday")
	self.progress = self.rtTask:Find("progress")
	self.slider = self.progress:Find("slider")
	self.awardTF = self.progress:Find("award")
	self.progressStep = self.progress:Find("step")
	self.progressRule = self.progress:Find("rule")
	self.BtnGroup = self.rtTask:Find("BtnGroup")
	self.displayBtn = self.BtnGroup:Find("Check_btn")
	self.battleBtn = self.BtnGroup:Find("battle_btn")
	self.getBtn = self.BtnGroup:Find("get_btn")
	self.gotBtn = self.BtnGroup:Find("got_btn")
	self.displayText = self.displayBtn:Find("Text")
	self.finishAll = false

	return
end

function ShiningMagicKillPage:OnDataSetting()
	if self.ptData then
		self.ptData:Update(self.activity)
	else
		self.ptData = ActivityPtData.New(self.activity)
	end

	return
end

function ShiningMagicKillPage:LocalInit()
	setText(self.displayText, i18n("nier_core_award_check"))
	setText(self.progressRule, i18n("nier_core_task_desc"))

	return
end

function ShiningMagicKillPage:InitBtn()
	onButton(self, self.displayBtn, function()
		self:emit(ActivityMediator.SHOW_AWARD_WINDOW, PtAwardWindow, {
			blur = true,
			type = self.ptData.type,
			dropList = self.ptData.dropList,
			targets = self.ptData.targets,
			level = self.ptData.level,
			count = self.ptData.count,
			resId = self.ptData.resId,
			unlockStamps = self.ptData:GetDayUnlockStamps()
		})

		return
	end, SFX_PANEL)
	onButton(self, self.battleBtn, function()
		self:emit(ActivityMediator.GO_Activity_level)

		return
	end, SFX_PANEL)
	onButton(self, self.getBtn, function()
		local var_7_0 = {}
		local var_7_1 = self.ptData:GetAward()
		local var_7_2 = getProxy(PlayerProxy):getRawData()
		local var_7_3, var_7_4 = Task.StaticJudgeOverflow(var_7_2.gold, var_7_2.oil, LOCK_UR_SHIP and 0 or getProxy(BagProxy):GetLimitCntById(pg.gameset.urpt_chapter_max.description[1]), true, true, {
			{
				var_7_1.type,
				var_7_1.id,
				var_7_1.count
			}
		})

		if var_7_3 then
			table.insert(var_7_0, function(arg_8_0)
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					type = MSGBOX_TYPE_ITEM_BOX,
					content = i18n("award_max_warning"),
					items = var_7_4,
					onYes = arg_8_0
				})

				return
			end)
		end

		seriesAsync(var_7_0, function()
			local var_9_0, var_9_1 = self.ptData:GetResProgress()

			self:emit(ActivityMediator.EVENT_PT_OPERATION, {
				cmd = 1,
				activity_id = self.ptData:GetId(),
				arg1 = var_9_1
			})

			return
		end)

		return
	end, SFX_PANEL)

	return
end

function ShiningMagicKillPage:OnFirstFlush()
	self:LocalInit()
	self:InitBtn()

	return
end

function ShiningMagicKillPage:OnUpdateFlush()
	local var_11_0 = self.ptData:getTargetLevel()
	local var_11_1, var_11_2, var_11_3 = self.ptData:GetLevelProgress()

	setText(self.nowday, string.format("%s", var_11_1))
	setText(self.aimday, string.format("/%s", var_11_2))

	local var_11_4, var_11_5, var_11_6 = self.ptData:GetResProgress()

	setText(self.progressStep, string.format("%s<color=#ffffff33>/%s</color>", var_11_6 >= 1 and setColorStr(var_11_4, COLOR_GREEN) or var_11_4, var_11_5))
	setSlider(self.slider, 0, 1, var_11_6)

	local var_11_7 = self.ptData:CanGetAward()
	local var_11_8 = self.ptData:CanGetNextAward()

	setActive(self.battleBtn, self.ptData:CanGetMorePt() and not var_11_7 and var_11_8)
	setActive(self.getBtn, var_11_7)
	setActive(self.gotBtn, not var_11_8)

	local var_11_9 = self.ptData:GetAward()

	updateDrop(self.awardTF, var_11_9)
	onButton(self, self.awardTF, function()
		self:emit(BaseUI.ON_DROP, var_11_9)

		return
	end, SFX_PANEL)

	return
end

function ShiningMagicKillPage:OnDestroy()
	return
end

function ShiningMagicKillPage:GetWorldPtData(arg_14_1)
	if arg_14_1 <= pg.TimeMgr.GetInstance():GetServerTime() - (ActivityMainScene.Data2Time or 0) then
		ActivityMainScene.Data2Time = pg.TimeMgr.GetInstance():GetServerTime()

		self:emit(ActivityMediator.EVENT_PT_OPERATION, {
			cmd = 2,
			activity_id = self.ptData:GetId()
		})
	end

	return
end

function ShiningMagicKillPage:OnHideFlush()
	return
end

function ShiningMagicKillPage:OnDestroy()
	return
end

return ShiningMagicKillPage
