local AnniversaryEightLoginJpPage = class("AnniversaryEightLoginJpPage", import("view.activity.CorePage.templatePage.CoreLoginSignTemplatePage"))

function AnniversaryEightLoginJpPage:OnInit()
	self.bg = self._tf:Find("AD")
	self.item = self.bg:Find("item")
	self.items = self.bg:Find("items/items")
	self.itemList = UIItemList.New(self.items, self.item)
	self.signBtn = self.bg:Find("signBtn")
	self.signRedTip = self.bg:Find("signBtn/tip")

	return
end

function AnniversaryEightLoginJpPage:OnFirstFlush()
	self.enterFlag = true

	setActive(self.item, false)

	self.playedAnimationList = {}

	for iter_2_0 = 1, self.activity.data1 do
		table.insert(self.playedAnimationList, iter_2_0 - 1)
	end

	self.itemList:make(function(arg_3_0, arg_3_1, arg_3_2)
		if arg_3_0 == UIItemList.EventUpdate then
			local var_3_0 = {
				type = self.config.front_drops[arg_3_1 + 1][1],
				id = self.config.front_drops[arg_3_1 + 1][2],
				count = self.config.front_drops[arg_3_1 + 1][3]
			}

			updateDrop(arg_3_2:Find("item"), var_3_0)
			onButton(self, arg_3_2, function()
				self:emit(BaseUI.ON_DROP, var_3_0)

				return
			end, SFX_PANEL)
			setActive(arg_3_2:Find("got"), arg_3_1 < self.nday)
			setActive(arg_3_2:Find("getEffect"), self.activity.data1 == arg_3_1 and self.activity:readyToAchieve())

			if table.contains(self.playedAnimationList, arg_3_1) and arg_3_1 == self.nday - 1 then
				GetComponent(arg_3_2, typeof(Animation)):Play("anim_AnniversaryEightLoginJPPage_tpl_get")
			end
		end

		return
	end)
	onButton(self, self.signBtn, function()
		if self.activity:readyToAchieve() == false then
			return
		end

		self:emit(ActivityMediator.EVENT_OPERATION, {
			cmd = 1,
			activity_id = self.activity.id
		})

		return
	end, SFX_CONFIRM)

	return
end

function AnniversaryEightLoginJpPage:ShowOrHide(arg_6_1)
	AnniversaryEightLoginJpPage.super.ShowOrHide(self, arg_6_1)

	if arg_6_1 == true then
		setActive(self.items, false)

		self.showTimer = Timer.New(function()
			self.enterFlag = false

			setActive(self.items, true)
			self:StopTimer()

			return
		end, 0.396, 1)

		self.showTimer:Start()
	else
		self.enterFlag = true
	end

	return
end

function AnniversaryEightLoginJpPage:StopTimer()
	if self.showTimer then
		self.showTimer:Stop()

		self.showTimer = nil
	end

	return
end

function AnniversaryEightLoginJpPage:OnUpdateFlush()
	self.nday = self.activity.data1

	for iter_9_0 = 1, self.activity.data1 do
		table.insert(self.playedAnimationList, iter_9_0 - 1)
	end

	self.itemList:align(self.Day, self.enterFlag and 0.1 or 0)
	setText(self.bg:Find("items/Root/image_05/Text"), self.nday .. "/" .. self.Day)

	local var_9_0 = self.activity:readyToAchieve()

	setActive(self.signRedTip, var_9_0)
	setGray(self.signBtn, not var_9_0)

	return
end

function AnniversaryEightLoginJpPage:OnDestroy()
	self:StopTimer()
	self.itemList:Dispose()
	AnniversaryEightLoginJpPage.super.OnDestroy(self)

	return
end

return AnniversaryEightLoginJpPage
