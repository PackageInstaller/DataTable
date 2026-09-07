local ChocolateWorkshopSkinPage = class("ChocolateWorkshopSkinPage", import(".TemplatePage.SkinTemplatePage"))

ChocolateWorkshopSkinPage.FADE_TIME = 0.5
ChocolateWorkshopSkinPage.SHOW_TIME = 2
ChocolateWorkshopSkinPage.FADE_OUT_TIME = 0.5

function ChocolateWorkshopSkinPage:OnInit()
	ChocolateWorkshopSkinPage.super.OnInit(self)

	self.finishContainer = self.bg:Find("FinishContainer")
	self.bubbleTF = self.bg:Find("Bubble")
	self.bubbleText = self.bubbleTF:Find("Text")
	self.bubbleCG = GetComponent(self.bubbleTF, "CanvasGroup")
	self.sdContainer = self.bg:Find("SDcontainer")
	self.sdBtn = self.bg:Find("SDBtn")

	onButton(self, self.sdBtn, function()
		local var_2_0 = {
			{
				{
					2022,
					2,
					14
				},
				{
					0,
					0,
					0
				}
			},
			{
				{
					2022,
					2,
					23
				},
				{
					23,
					59,
					59
				}
			}
		}

		if type(var_2_0) == "table" then
			if pg.TimeMgr.GetInstance():inTime(var_2_0) then
				setActive(self.boxTF, true)
			end
		end

		return
	end, SFX_PANEL)

	self.boxTF = self._tf:Find("Box")
	self.boxBG = self.boxTF:Find("BG")
	self.boxText = self.boxTF:Find("Content/Text")

	setText(self.boxText, i18n("valentinesday__shop_tip"))

	self.confirmBtn = self.boxTF:Find("Content/Confirm")
	self.cancelBtn = self.boxTF:Find("Content/Cancel")

	onButton(self, self.boxBG, function()
		setActive(self.boxTF, false)

		return
	end, SFX_CANCEL)
	onButton(self, self.cancelBtn, function()
		setActive(self.boxTF, false)

		return
	end, SFX_CANCEL)
	onButton(self, self.confirmBtn, function()
		pg.m02:sendNotification(GAME.GO_SCENE, SCENE.SKINSHOP)
		setActive(self.boxTF, false)

		return
	end, SFX_PANEL)

	self.sdNameList = {
		"anshan_3",
		"shiyu_4"
	}
	self.bubbleTextTable = {
		anshan_3 = {
			"valentinesday__txt1_tip",
			"valentinesday__txt2_tip",
			"valentinesday__txt3_tip"
		},
		shiyu_4 = {
			"valentinesday__txt4_tip",
			"valentinesday__txt5_tip",
			"valentinesday__txt6_tip"
		}
	}
	self.aniContainerTF = self.bg:Find("AniContainer")
	self.sdName = self.sdNameList[math.random(#self.sdNameList)]
	self.animChar = nil

	GetSpineRequestPackage.New(self.sdName, function(arg_6_0)
		self.animChar = arg_6_0

		self.animChar:SetParent(self.sdContainer)
		self.animChar:SetLocalScale(Vector3.one)
		self.animChar:SetAction("stand2", 0)

		return
	end):Start()

	return
end

function ChocolateWorkshopSkinPage:OnFirstFlush()
	self.uilist:make(function(arg_8_0, arg_8_1, arg_8_2)
		if arg_8_0 == UIItemList.EventUpdate then
			local var_8_0 = arg_8_2:Find("item")
			local var_8_1 = self.taskProxy:getTaskById(self.taskGroup[self.nday][arg_8_1 + 1]) or self.taskProxy:getFinishTaskById(self.taskGroup[self.nday][arg_8_1 + 1])

			assert(var_8_1, "without this task by id: " .. self.taskGroup[self.nday][arg_8_1 + 1])

			local var_8_2 = var_8_1:getConfig("award_display")[1]
			local var_8_3 = {
				type = var_8_2[1],
				id = var_8_2[2],
				count = var_8_2[3]
			}

			updateDrop(var_8_0, var_8_3)
			onButton(self, var_8_0, function()
				self:emit(BaseUI.ON_DROP, var_8_3)

				return
			end, SFX_PANEL)

			local var_8_4 = var_8_1:getProgress()
			local var_8_5 = var_8_1:getConfig("target_num")

			setText(arg_8_2:Find("description"), var_8_1:getConfig("desc"))
			setText(arg_8_2:Find("progressText"), setColorStr(var_8_4, "#BBCF2EFF") .. "/" .. var_8_5)
			setSlider(arg_8_2:Find("progress"), 0, var_8_5, var_8_4)

			local var_8_6 = arg_8_2:Find("go_btn")
			local var_8_7 = arg_8_2:Find("get_btn")
			local var_8_8 = arg_8_2:Find("got_btn")
			local var_8_9 = var_8_1:getTaskStatus()

			setActive(var_8_6, var_8_9 == 0)
			setActive(var_8_7, var_8_9 == 1)
			setActive(var_8_8, var_8_9 == 2)
			onButton(self, var_8_6, function()
				self:emit(ActivityMediator.ON_TASK_GO, var_8_1)

				return
			end, SFX_PANEL)
			onButton(self, var_8_7, function()
				self:emit(ActivityMediator.ON_TASK_SUBMIT, var_8_1)

				return
			end, SFX_PANEL)
		end

		return
	end)

	self.showBubbleTag = false

	return
end

function ChocolateWorkshopSkinPage:OnUpdateFlush()
	ChocolateWorkshopSkinPage.super.OnUpdateFlush(self)
	setActive(self.boxTF, false)

	for iter_12_0 = 1, self.finishContainer.childCount do
		setActive(self.finishContainer:GetChild(iter_12_0 - 1), iter_12_0 <= self.nday)
	end

	local var_12_0 = self.taskProxy:getTaskVO(self.taskGroup[self.nday][1]):getTaskStatus()

	if not self.showBubbleTag then
		if var_12_0 == 0 then
			self:showBubble(i18n(self.bubbleTextTable[self.sdName][1]))

			self.showBubbleTag = true
		elseif var_12_0 == 1 then
			self:showBubble(i18n(self.bubbleTextTable[self.sdName][2]))

			self.showBubbleTag = true
		end
	end

	eachChild(self.aniContainerTF, function(arg_13_0)
		setActive(arg_13_0, false)

		return
	end)

	if var_12_0 == 0 then
		setActive(self.aniContainerTF:Find("choco_factory_rest"), true)
	else
		setActive(self.aniContainerTF:Find("choco_factory_working"), true)
	end

	return
end

function ChocolateWorkshopSkinPage:OnDestroy()
	ChocolateWorkshopSkinPage.super.OnDestroy(self)

	if self.animChar then
		self.animChar:Dispose()

		self.animChar = nil
	end

	return
end

function ChocolateWorkshopSkinPage:showBubble(arg_15_1)
	setText(self.bubbleText, not arg_15_1 and i18n(self.bubbleTextList[math.random(#self.bubbleTextList)]) or arg_15_1)

	local function var_15_1(arg_16_0)
		self.bubbleCG.alpha = arg_16_0

		setLocalScale(self.bubbleTF, Vector3.one * arg_16_0)

		return
	end

	local function var_15_2()
		LeanTween.value(go(self.bubbleTF), 1, 0, ChocolateWorkshopSkinPage.FADE_OUT_TIME):setOnUpdate(System.Action_float(var_15_1)):setOnComplete(System.Action(function()
			setActive(self.bubbleTF, false)

			return
		end))

		return
	end

	LeanTween.cancel(go(self.bubbleTF))
	setActive(self.bubbleTF, true)
	LeanTween.value(go(self.bubbleTF), 0, 1, ChocolateWorkshopSkinPage.FADE_TIME):setOnUpdate(System.Action_float(var_15_1)):setOnComplete(System.Action(function()
		LeanTween.delayedCall(go(self.bubbleTF), ChocolateWorkshopSkinPage.SHOW_TIME, System.Action(var_15_2))

		return
	end))

	return
end

return ChocolateWorkshopSkinPage
