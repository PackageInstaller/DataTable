local LittleSpeePage = class("LittleSpeePage", import(".TemplatePage.PtTemplatePage"))

LittleSpeePage.FILL_ANI_TIME = 0.5
LittleSpeePage.IMAGE_ANI_TIME = 0.5
LittleSpeePage.IMAGE_MAX_SCALE = Vector3(2, 2, 2)
LittleSpeePage.TEXT_ANI_TIME = 0.3
LittleSpeePage.TEXT_MAX_SCALE = Vector3(3, 3, 3)

function LittleSpeePage:OnInit()
	LittleSpeePage.super.OnInit(self)

	self.heartTpl = self.bg:Find("HeartTpl")
	self.heartContainer = self.bg:Find("HeartContainer")
	self.helpBtn = self.bg:Find("help_btn")
	self.getFinalBtn = self.bg:Find("get_final_btn")
	self.gotFinalBtn = self.bg:Find("got_final_btn")
	self.performBtn = self.bg:Find("perform_btn")
	self.performImage = self.performBtn:Find("image")
	self.performText = self.performBtn:Find("text")
	self.performReBtn = self.bg:Find("perform_re_btn")

	return
end

function LittleSpeePage:OnFirstFlush()
	LittleSpeePage.super.OnFirstFlush(self)

	self.storyName = self.activity:getConfig("config_client").performStory
	self.activateStoryName = self.activity:getConfig("config_client").activateStory
	self.heartUIItemList = UIItemList.New(self.heartContainer, self.heartTpl)

	self.heartUIItemList:make(function(arg_3_0, arg_3_1, arg_3_2)
		if arg_3_0 == UIItemList.EventUpdate then
			local var_3_0 = arg_3_1 + 1

			arg_3_2.name = arg_3_1 + 1

			local var_3_1 = self.ptData:GetLevel()
			local var_3_2 = arg_3_2:Find("Full")

			setFillAmount(var_3_2, 1)
			setActive(var_3_2, var_3_0 <= var_3_1)
		end

		return
	end)
	onButton(self, self.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.littleSpee_npc.tip
		})

		return
	end, SFX_PANEL)
	onButton(self, self.battleBtn, function()
		self:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.LEVEL)

		return
	end, SFX_PANEL)
	onButton(self, self.getBtn, function()
		self:OnGetBtnClick()

		return
	end, SFX_PANEL)
	onButton(self, self.getFinalBtn, function()
		self:OnGetBtnClick()

		return
	end, SFX_PANEL)
	onButton(self, self.performBtn, function()
		local var_8_0 = pg.NewStoryMgr.GetInstance():StoryName2StoryId(self.storyName)

		assert(var_8_0 and var_8_0 ~= 0, "Missing Story Stage ID: " .. (self.storyName or "NIL"))
		self:emit(ActivityMediator.GO_PERFORM_COMBAT, {
			stageId = var_8_0
		})

		return
	end, SFX_PANEL)
	onButton(self, self.performReBtn, function()
		local var_9_0 = pg.NewStoryMgr.GetInstance():StoryName2StoryId(self.storyName)

		assert(var_9_0 and var_9_0 ~= 0, "Missing Story Stage ID: " .. (self.storyName or "NIL"))
		self:emit(ActivityMediator.GO_PERFORM_COMBAT, {
			memory = true,
			stageId = var_9_0
		})

		return
	end, SFX_PANEL)
	setActive(self.performReBtn, false)
	setActive(self.performBtn, false)
	setActive(self.getFinalBtn, false)

	self.inGetProcess = false

	return
end

function LittleSpeePage:OnUpdateFlush()
	LittleSpeePage.super.OnUpdateFlush(self)

	local var_10_0, var_10_1 = self.ptData:GetLevelProgress()

	self.heartUIItemList:align(var_10_1)

	if var_10_0 == var_10_1 then
		setActive(self.getBtn, false)
		setActive(self.gotBtn, false)

		local var_10_2 = self.ptData:CanGetAward()
		local var_10_3 = self.ptData:CanGetNextAward()
		local var_10_4 = pg.NewStoryMgr.GetInstance():IsPlayed(self.storyName)

		setActive(self.performBtn, not var_10_4 and var_10_2)
		setActive(self.performReBtn, var_10_4)
		setActive(self.getFinalBtn, var_10_4 and var_10_2)
		setActive(self.gotFinalBtn, var_10_4 and not var_10_3)

		if not var_10_4 and var_10_2 then
			pg.NewStoryMgr.GetInstance():Play(self.activateStoryName)
			setActive(self.performBtn, true)
			setLocalScale(self.performImage, Vector3.one)
			self:managedTween(LeanTween.scale, nil, self.performImage, LittleSpeePage.IMAGE_MAX_SCALE, LittleSpeePage.IMAGE_ANI_TIME)
			self:managedTween(LeanTween.alphaCanvas, nil, GetOrAddComponent(self.performImage, typeof(CanvasGroup)), 1, LittleSpeePage.IMAGE_ANI_TIME / 2):setFrom(0)
			self:managedTween(LeanTween.delayedCall, function()
				self:managedTween(LeanTween.alphaCanvas, nil, GetOrAddComponent(self.performImage, typeof(CanvasGroup)), 0, LittleSpeePage.IMAGE_ANI_TIME / 2)

				return
			end, LittleSpeePage.IMAGE_ANI_TIME / 2, nil)
			setLocalScale(self.performText, LittleSpeePage.TEXT_MAX_SCALE)
			self:managedTween(LeanTween.scale, nil, self.performText, Vector3.one, LittleSpeePage.TEXT_ANI_TIME)
			self:managedTween(LeanTween.alphaCanvas, nil, GetOrAddComponent(self.performText, typeof(CanvasGroup)), 1, LittleSpeePage.TEXT_ANI_TIME):setFrom(0)
		else
			setActive(self.performBtn, false)
		end
	end

	return
end

function LittleSpeePage:OnGetBtnClick()
	if self.inGetProcess then
		return
	end

	self.inGetProcess = true

	local var_12_0 = {}
	local var_12_1 = self.ptData:GetAward()
	local var_12_2 = getProxy(PlayerProxy):getRawData()
	local var_12_3, var_12_4 = Task.StaticJudgeOverflow(var_12_2.gold, var_12_2.oil, LOCK_UR_SHIP and 0 or getProxy(BagProxy):GetLimitCntById(pg.gameset.urpt_chapter_max.description[1]), true, true, {
		{
			var_12_1.type,
			var_12_1.id,
			var_12_1.count
		}
	})

	if var_12_3 then
		table.insert(var_12_0, function(arg_13_0)
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				type = MSGBOX_TYPE_ITEM_BOX,
				content = i18n("award_max_warning"),
				items = var_12_4,
				onYes = arg_13_0
			})

			return
		end)

		self.inGetProcess = false
	end

	table.insert(var_12_0, function(arg_14_0)
		local var_14_0 = self.heartContainer:Find(self.ptData:GetLevelProgress() .. "/Full")

		setFillAmount(var_14_0, 0)
		setActive(var_14_0, true)
		self:managedTween(LeanTween.value, nil, go(var_14_0), 0, 1, LittleSpeePage.FILL_ANI_TIME):setOnUpdate(System.Action_float(function(arg_15_0)
			setFillAmount(var_14_0, arg_15_0)

			return
		end)):setOnComplete(System.Action(function()
			arg_14_0()

			return
		end))

		return
	end)
	seriesAsync(var_12_0, function()
		local var_17_0, var_17_1 = self.ptData:GetResProgress()

		self:emit(ActivityMediator.EVENT_PT_OPERATION, {
			cmd = 1,
			activity_id = self.ptData:GetId(),
			arg1 = var_17_1
		})

		self.inGetProcess = false

		return
	end)

	return
end

return LittleSpeePage
