local NieRAutomataKillPage = class("NieRAutomataKillPage", import("..CoreActivityPage"))

function NieRAutomataKillPage:OnInit()
	self.bg = self._tf:Find("AD")
	self.title = self.bg:Find("title")
	self.desc1 = self.title:Find("desc1")
	self.desc2 = self.title:Find("desc2")
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

function NieRAutomataKillPage:OnDataSetting()
	if self.ptData then
		self.ptData:Update(self.activity)
	else
		self.ptData = ActivityPtData.New(self.activity)
	end

	return
end

function NieRAutomataKillPage:LocalInit()
	setText(self.displayText, i18n("nier_core_award_check"))
	setText(self.progressRule, i18n("nier_core_task_desc"))

	return
end

function NieRAutomataKillPage:LocalFresh()
	local var_4_0, var_4_1, var_4_2 = self.ptData:GetLevelProgress()
	local var_4_3 = "nier_2b_text_block_day"
	local var_4_4

	self.finishAll = var_4_0 >= 7 and not self.ptData:CanGetNextAward()

	if self.finishAll then
		var_4_4 = i18n(var_4_3 .. "_fin")

		setActive(self.desc1, false)
	else
		var_4_4 = i18n(var_4_3 .. var_4_0)

		setText(self.desc1, var_4_4[1].info)
	end

	setText(self.desc2, var_4_4[2].info)
	setActive(self.desc2, false)
	self:Playwriter()

	return
end

function NieRAutomataKillPage:InitBtn()
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
		local var_8_0 = {}
		local var_8_1 = self.ptData:GetAward()
		local var_8_2 = getProxy(PlayerProxy):getRawData()
		local var_8_3, var_8_4 = Task.StaticJudgeOverflow(var_8_2.gold, var_8_2.oil, LOCK_UR_SHIP and 0 or getProxy(BagProxy):GetLimitCntById(pg.gameset.urpt_chapter_max.description[1]), true, true, {
			{
				var_8_1.type,
				var_8_1.id,
				var_8_1.count
			}
		})

		if var_8_3 then
			table.insert(var_8_0, function(arg_9_0)
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					type = MSGBOX_TYPE_ITEM_BOX,
					content = i18n("award_max_warning"),
					items = var_8_4,
					onYes = arg_9_0
				})

				return
			end)
		end

		seriesAsync(var_8_0, function()
			local var_10_0, var_10_1 = self.ptData:GetResProgress()

			self:emit(ActivityMediator.EVENT_PT_OPERATION, {
				cmd = 1,
				activity_id = self.ptData:GetId(),
				arg1 = var_10_1
			})

			return
		end)

		return
	end, SFX_PANEL)

	return
end

function NieRAutomataKillPage:GetTypewriterSpeed()
	local var_11_0 = self.activity:getConfig("config_client").typewriterSpeed

	return var_11_0 and var_11_0 or 0.1
end

function NieRAutomataKillPage:InvalidateWriter()
	self.writerToken = (self.writerToken or 0) + 1

	if self.desc1 then
		GetOrAddComponent(self.desc1, typeof(Typewriter)).endFunc = nil
	end

	if self.desc2 then
		GetOrAddComponent(self.desc2, typeof(Typewriter)).endFunc = nil
	end

	return
end

function NieRAutomataKillPage:Playwriter()
	self:InvalidateWriter()

	local var_13_0 = self.writerToken

	local function var_13_1()
		local var_14_0 = self.writerToken == var_13_0 and self._go and isActive(self._go) or false

		return (false or nil) and true
	end

	local var_13_2 = {}

	if not self.finishAll then
		table.insert(var_13_2, function(arg_15_0)
			if not var_13_1() then
				return
			end

			local var_15_0 = GetOrAddComponent(self.desc1, typeof(Typewriter))

			function var_15_0.endFunc()
				if not var_13_1() then
					return
				end

				arg_15_0()

				return
			end

			var_15_0:setSpeed(self:GetTypewriterSpeed())
			var_15_0:Play()

			return
		end)
	else
		local var_13_3, var_13_4, var_13_5 = self.ptData:GetLevelProgress()

		table.insert(var_13_2, function(arg_17_0)
			local var_17_0 = checkExist(self.activity:getConfig("config_client").story, {
				var_13_3
			}, {
				1
			})

			if var_17_0 then
				if not pg.NewStoryMgr.GetInstance():IsPlayed(var_17_0) then
					pg.NewStoryMgr.GetInstance():Play(var_17_0, function()
						if not var_13_1() then
							return
						end

						arg_17_0()

						return
					end)

					goto label_17_0
				end
			end

			arg_17_0()

			::label_17_0::

			return
		end)
	end

	table.insert(var_13_2, function(arg_19_0)
		if not var_13_1() then
			return
		end

		local var_19_0 = self.desc2

		setActive(self.desc2, true)

		local var_19_1 = GetOrAddComponent(var_19_0, typeof(Typewriter))

		function var_19_1.endFunc()
			if not var_13_1() then
				return
			end

			arg_19_0()

			return
		end

		var_19_1:setSpeed(self:GetTypewriterSpeed())
		var_19_1:Play()

		return
	end)
	seriesAsync(var_13_2)

	return
end

function NieRAutomataKillPage:OnFirstFlush()
	self:LocalInit()
	self:LocalFresh()
	self:InitBtn()
	self:Hx4Channel()

	return
end

function NieRAutomataKillPage:OnUpdateFlush()
	local var_22_0 = self.ptData:getTargetLevel()
	local var_22_1, var_22_2, var_22_3 = self.ptData:GetLevelProgress()

	setText(self.nowday, string.format("%s", var_22_1))
	setText(self.aimday, string.format("/%s", var_22_2))
	self:LocalFresh()

	local var_22_4, var_22_5, var_22_6 = self.ptData:GetResProgress()

	setText(self.progressStep, string.format("%s<color=#ffffff33>/%s</color>", var_22_6 >= 1 and setColorStr(var_22_4, COLOR_GREEN) or var_22_4, var_22_5))
	setSlider(self.slider, 0, 1, var_22_6)

	local var_22_7 = self.ptData:CanGetAward()
	local var_22_8 = self.ptData:CanGetNextAward()

	setActive(self.battleBtn, self.ptData:CanGetMorePt() and not var_22_7 and var_22_8)
	setActive(self.getBtn, var_22_7)
	setActive(self.gotBtn, not var_22_8)

	local var_22_9 = self.ptData:GetAward()

	updateDrop(self.awardTF, var_22_9)
	onButton(self, self.awardTF, function()
		self:emit(BaseUI.ON_DROP, var_22_9)

		return
	end, SFX_PANEL)

	return
end

function NieRAutomataKillPage:OnDestroy()
	return
end

function NieRAutomataKillPage:GetWorldPtData(arg_25_1)
	if arg_25_1 <= pg.TimeMgr.GetInstance():GetServerTime() - (ActivityMainScene.Data2Time or 0) then
		ActivityMainScene.Data2Time = pg.TimeMgr.GetInstance():GetServerTime()

		self:emit(ActivityMediator.EVENT_PT_OPERATION, {
			cmd = 2,
			activity_id = self.ptData:GetId()
		})
	end

	return
end

local function var_0_1(arg_26_0)
	return (arg_26_0._tf:Find("rw/hx_ch" .. pg.SdkMgr.GetInstance():GetChannelUIDIncludeHarmony()))
end

function NieRAutomataKillPage:Hx4Channel()
	local var_27_0 = var_0_1(self)

	if not IsNil(var_27_0) then
		setActive(var_27_0, HXSet.isHx())
	end

	return
end

function NieRAutomataKillPage:OnHideFlush()
	self:InvalidateWriter()

	return
end

function NieRAutomataKillPage:OnDestroy()
	self:InvalidateWriter()

	return
end

return NieRAutomataKillPage
