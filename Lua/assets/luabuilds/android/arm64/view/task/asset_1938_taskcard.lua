local TaskCard = class("TaskCard")
local var_0_1 = 0
local var_0_2 = 1
local var_0_3 = 2
local var_0_4 = 3
local var_0_5 = 4
local var_0_6 = 0.3

function TaskCard:Type2Tag()
	TaskCard.types = TaskCard.types or {
		[0] = "subtitle_week",
		"subtitle_brach",
		"subtitle_activity",
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		"subtitle_week",
		nil,
		nil,
		"subtitle_activity",
		26,
		"subtitle_activity",
		36,
		"subtitle_activity",
		[nil] = "subtitle_main",
		subtitle_brach = "subtitle_daily"
	}

	return TaskCard.types[self]
end

function TaskCard:Ctor(arg_2_1, arg_2_2)
	pg.DelegateInfo.New(self)

	self._go = arg_2_1
	self._tf = tf(self._go)
	self.viewComponent = arg_2_2
	self.frame = self._tf:Find("frame")
	self.descTxt = self._tf:Find("frame/desc"):GetComponent(typeof(Text))
	self.tagTF = self._tf:Find("frame/tag"):GetComponent(typeof(Image))
	self.rewardPanel = self._tf:Find("frame/awards")
	self._rewardModel = self.rewardPanel:GetChild(0)
	self.progressBar = self._tf:Find("frame/slider"):GetComponent(typeof(Slider))
	self.progressNum = self._tf:Find("frame/slider/Text"):GetComponent(typeof(Text))
	self.GotoBtn = self._tf:Find("frame/go_btn")
	self.GetBtn = self._tf:Find("frame/get_btn")
	self.storyIconFrame = self._tf:Find("frame/storyIcon")
	self.storyIcon = self._tf:Find("frame/storyIcon/icon")
	self._modelWidth = self.frame.rect.width + 100
	self.finishBg = self._tf:Find("frame/finish_bg")
	self.unfinishBg = self._tf:Find("frame/unfinish_bg")
	self.tip = self._tf:Find("frame/tip")
	self.cg = GetOrAddComponent(self._tf, "CanvasGroup")
	self.height = self._tf.rect.height
	self.urTag = self._tf:Find("frame/urTag")
	self.lockBg = self._tf:Find("lock_bg")
	self.lockTxt = self.lockBg:Find("btn/Text"):GetComponent(typeof(Text))
	self.sIconOldPosition = Vector2(0, 20)
	self.framePos = self.frame.localPosition

	return
end

function TaskCard:update(arg_3_1)
	assert(isa(arg_3_1, Task), "should be an instance of Task")

	self.taskVO = arg_3_1

	if arg_3_1.id == 10302 then
		self._go.name = arg_3_1.id
	end

	self.descTxt.text = arg_3_1:getConfig("desc")
	self.tagTF.sprite = GetSpriteFromAtlas("ui/TaskUI_atlas", TaskCard.Type2Tag(arg_3_1:GetRealType()))

	local var_3_0 = arg_3_1:getConfig("target_num")

	self:updateAwards(arg_3_1:getConfig("award_display"))

	local var_3_1 = arg_3_1:getProgress()

	self.progressNum.text = arg_3_1:isFinish() and "COMPLETE" or arg_3_1:getConfig("sub_type") == 1012 and math.floor(var_3_1 / 100) .. "/" .. math.floor(var_3_0 / 100) or var_3_1 .. "/" .. var_3_0
	self.progressBar.value = var_3_1 / var_3_0

	self:updateBtnState(arg_3_1)

	local var_3_2 = arg_3_1:getConfig("story_id")
	local var_3_3 = arg_3_1:IsUrTask()

	setActive(self.urTag, var_3_3)
	setActive(self.storyIconFrame, var_3_2 and var_3_2 ~= "" and not var_3_3)

	if var_3_2 and var_3_2 ~= "" then
		local var_3_4 = arg_3_1:getConfig("story_icon")

		if not var_3_4 or var_3_4 == "" then
			var_3_4 = "task_icon_default"
		end

		LoadSpriteAsync("shipmodels/" .. var_3_4, function(arg_4_0)
			if arg_4_0 then
				setImageSprite(self.storyIcon, arg_4_0, true)
				self:UpdateStoryIconPosition(arg_3_1)
			end

			return
		end)
		onButton(self, self.storyIconFrame, function()
			pg.NewStoryMgr.GetInstance():Play(var_3_2, nil, true)

			return
		end, SFX_PANEL)
	else
		removeOnButton(self.storyIconFrame)
	end

	self.cg.alpha = 1

	setActive(self.frame, true)
	setActive(self._go, true)

	self.frame.transform.localPosition = self.framePos

	return
end

function TaskCard:UpdateStoryIconPosition(arg_6_1)
	local var_6_0 = arg_6_1:getConfig("story_icon_shift")

	if type(var_6_0) == "table" and #var_6_0 >= 2 then
		setAnchoredPosition(self.storyIcon, {
			x = self.sIconOldPosition.x + var_6_0[1],
			y = self.sIconOldPosition.y + var_6_0[2]
		})
	else
		local var_6_1 = {}

		var_6_1.x = self.sIconOldPosition.x + 0
		var_6_1.y = self.sIconOldPosition.y + 0

		setAnchoredPosition(self.storyIcon, var_6_1)
	end

	return
end

function TaskCard:updateBtnState(arg_7_1)
	local var_7_0 = var_0_1

	removeOnButton(self.GotoBtn)
	removeOnButton(self.GetBtn)

	if arg_7_1:isLock() then
		var_7_0 = var_0_5
	elseif arg_7_1:isFinish() then
		var_7_0 = arg_7_1:isReceive() and var_0_4 or var_0_3

		onButton(self, self.GetBtn, function()
			local function var_8_0()
				if not self.isClick then
					self.isClick = true

					self:DoSubmitAnim(function()
						self.isClick = nil

						self:Submit(arg_7_1)

						return
					end)
				end

				return
			end

			local var_8_1

			var_8_1 = coroutine.wrap(function()
				if arg_7_1:getConfig("sub_type") == TASK_SUB_TYPE_GIVE_ITEM or arg_7_1:getConfig("sub_type") == TASK_SUB_TYPE_GIVE_VIRTUAL_ITEM or arg_7_1:getConfig("sub_type") == TASK_SUB_TYPE_PLAYER_RES then
					local var_11_0 = DROP_TYPE_ITEM
					local var_11_2
					local var_11_1

					if arg_7_1:getConfig("sub_type") == TASK_SUB_TYPE_PLAYER_RES then
						var_11_0 = DROP_TYPE_RESOURCE
						var_11_1 = {
							type = MSGBOX_TYPE_ITEM_BOX,
							content = i18n("sub_item_warning")
						}
						var_11_2 = {}
					end

					var_11_2[1] = {
						type = var_11_0,
						id = tonumber(arg_7_1:getConfig("target_id")),
						count = arg_7_1:getConfig("target_num")
					}
					var_11_1.items = var_11_2

					function var_11_1.onYes()
						var_8_1()

						return
					end

					pg.MsgboxMgr.GetInstance():ShowMsgBox(var_11_1)
					coroutine.yield()
				end

				local var_11_3, var_11_4 = arg_7_1:judgeOverflow()

				if var_11_3 then
					pg.MsgboxMgr.GetInstance():ShowMsgBox({
						type = MSGBOX_TYPE_ITEM_BOX,
						content = i18n("award_max_warning"),
						items = var_11_4,
						onYes = function()
							var_8_1()

							return
						end
					})
					coroutine.yield()
				end

				var_8_0()

				return
			end)

			;(nil)()

			return
		end, SFX_PANEL)
	else
		var_7_0 = var_0_2

		onButton(self, self.GotoBtn, function()
			self:Skip(arg_7_1)

			return
		end, SFX_PANEL)
	end

	SetActive(self.GotoBtn, var_7_0 == var_0_2)
	SetActive(self.GetBtn, var_7_0 == var_0_3)
	setActive(self.finishBg, var_7_0 == var_0_3 or var_7_0 == var_0_4)
	setActive(self.unfinishBg, var_7_0 ~= var_0_3 and var_7_0 ~= var_0_4)
	setActive(self.tip, var_7_0 == var_0_3 or var_7_0 == var_0_4)
	setActive(self.lockBg, var_7_0 == var_0_5)
	setGray(self.frame, var_7_0 == var_0_5, true)

	if var_7_0 == var_0_5 then
		self.lockTxt.text = i18n("task_lock", arg_7_1:getConfig("level"))
	end

	return
end

function TaskCard:Submit(arg_15_1)
	if arg_15_1.isWeekTask then
		self.viewComponent:onSubmitForWeek(arg_15_1)
	elseif arg_15_1:isAvatarTask() then
		self.viewComponent:onSubmitForAvatar(arg_15_1)
	else
		self.viewComponent:onSubmit(arg_15_1)
	end

	return
end

function TaskCard:Skip(arg_16_1)
	self.viewComponent:onGo(arg_16_1)

	return
end

function TaskCard:updateAwards(arg_17_1)
	local var_17_0 = _.slice(arg_17_1, 1, 3)

	for iter_17_0 = self.rewardPanel.childCount, #var_17_0 - 1 do
		cloneTplTo(self._rewardModel, self.rewardPanel)
	end

	for iter_17_1 = 1, self.rewardPanel.childCount do
		local var_17_1 = self.rewardPanel:GetChild(iter_17_1 - 1)
		local var_17_2 = iter_17_1 <= #var_17_0

		setActive(var_17_1, iter_17_1 <= #var_17_0)

		if var_17_2 then
			local var_17_3 = {
				type = var_17_0[iter_17_1][1],
				id = var_17_0[iter_17_1][2],
				count = var_17_0[iter_17_1][3]
			}

			updateDrop(var_17_1, var_17_3)
			setActive(findTF(var_17_1, "got"), Task.OwnSpAward(var_17_0[iter_17_1]))
			onButton(self, var_17_1, function()
				self.viewComponent:emit(TaskMediator.ON_DROP, var_17_3)

				return
			end, SFX_PANEL)
		end
	end

	return
end

function TaskCard:DoSubmitAnim(arg_19_1)
	local var_19_0 = self.frame.localPosition

	LeanTween.alphaCanvas(self.cg, 0, var_0_6):setFrom(1)
	LeanTween.value(go(self.frame), self.frame.localPosition.x, self.frame.localPosition.x + self._modelWidth, var_0_6):setOnUpdate(System.Action_float(function(arg_20_0)
		self.frame.transform.localPosition = Vector3(arg_20_0, var_19_0.y, var_19_0.z)

		return
	end)):setOnComplete(System.Action(function()
		self.frame.transform.localPosition = var_19_0

		setActive(self.frame, false)
		arg_19_1()

		return
	end))

	return
end

function TaskCard:dispose()
	pg.DelegateInfo.Dispose(self)

	return
end

return TaskCard
