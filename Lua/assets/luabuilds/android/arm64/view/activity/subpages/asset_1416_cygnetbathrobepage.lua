local CygnetBathrobePage = class("CygnetBathrobePage", import("...base.BaseActivityPage"))

CygnetBathrobePage.MAX_COUNT = 7

function CygnetBathrobePage:OnInit()
	self.drawBtn = self._tf:Find("DrawBtn")
	self.resultTF = self._tf:Find("ResultImg")
	self.resultImgLittle = self.resultTF:Find("Little")
	self.resultImgMiddle = self.resultTF:Find("Middle")
	self.resultImgBig = self.resultTF:Find("Big")
	self.progressTF = self._tf:Find("Progress")
	self.progressText = self._tf:Find("Progress/ProgressText")
	self.gotImg = self._tf:Find("GotImg")
	self.awardPanel = self._tf:Find("AwardPanel")
	self.itemTpl = self.awardPanel:Find("itemTpl")
	self.resultTextTF = self.awardPanel:Find("ResultImg")
	self.resultTextLittle = self.awardPanel:Find("ResultImg/Little")
	self.resultTextMiddle = self.awardPanel:Find("ResultImg/Middle")
	self.resultTextBig = self.awardPanel:Find("ResultImg/Big")
	self.itemTplContainer = self.awardPanel:Find("AwardList")
	self.animTF = self._tf:Find("Anim")

	return
end

function CygnetBathrobePage:OnDataSetting()
	self.progressNum = self.activity.data1
	self.resultNum = self.activity.data2
	self.awardDayList = self.activity.data1_list
	self.isFinished = self.progressNum > CygnetBathrobePage.MAX_COUNT
	self.isAvailable = self.resultNum <= 0

	return
end

function CygnetBathrobePage:OnFirstFlush()
	onButton(self, self.drawBtn, function()
		self:emit(ActivityMediator.EVENT_OPERATION, {
			cmd = 1,
			activity_id = self.activity.id
		})

		return
	end, SFX_PANEL)

	return
end

function CygnetBathrobePage:OnUpdateFlush()
	setActive(self.drawBtn, self.isAvailable)
	setActive(self.resultTF, not self.isAvailable)

	if not self.isAvailable then
		for iter_5_0 = 1, self.resultTF.childCount do
			setActive(self.resultTF:GetChild(iter_5_0 - 1), iter_5_0 == self.resultNum)
		end
	end

	setActive(self.progressTF, not self.isFinished)
	setActive(self.gotImg, self.isFinished)

	if not self.isFinished then
		setText(self.progressText, self.progressNum .. "/" .. CygnetBathrobePage.MAX_COUNT)
	end

	local var_5_0 = self.activity:getConfig("config_data")[2]

	if var_5_0 then
		for iter_5_1, iter_5_2 in ipairs((_.filter(var_5_0, function(arg_6_0)
			for iter_6_0, iter_6_1 in ipairs(self.activity.data1_list) do
				if iter_6_1 == arg_6_0[1] then
					return false
				end
			end

			return true
		end))) do
			if self.progressNum == iter_5_2[1] then
				self:emit(ActivityMediator.EVENT_OPERATION, {
					cmd = 2,
					activity_id = self.activity.id,
					arg1 = iter_5_2[1]
				})

				return
			end
		end
	end

	return
end

function CygnetBathrobePage:OnDestroy()
	return
end

function CygnetBathrobePage:showLotteryAwardResult(arg_8_1, arg_8_2, arg_8_3)
	GetComponent(self.animTF, typeof(DftAniEvent)):SetEndEvent(function(arg_9_0)
		setActive(self.animTF, false)
		setActive(self.awardPanel, true)

		for iter_9_0 = 1, self.resultTextTF.childCount do
			setActive(self.resultTextTF:GetChild(iter_9_0 - 1), iter_9_0 == arg_8_2)
		end

		removeAllChildren(self.itemTplContainer)

		for iter_9_1, iter_9_2 in ipairs(arg_8_1) do
			local var_9_0 = cloneTplTo(self.itemTpl, self.itemTplContainer)
			local var_9_1 = {
				type = iter_9_2.type,
				id = iter_9_2.id,
				count = iter_9_2.count
			}

			updateDrop(var_9_0, var_9_1)
			onButton(self, var_9_0, function()
				self:emit(BaseUI.ON_DROP, var_9_1)

				return
			end, SFX_PANEL)
		end

		self:emit(ActivityMainScene.LOCK_ACT_MAIN, false)
		arg_8_3()
		onButton(self, self.awardPanel, function()
			setActive(self.awardPanel, false)

			return
		end)

		return
	end)
	setActive(self.animTF, true)
	self:emit(ActivityMainScene.LOCK_ACT_MAIN, true)

	return
end

function CygnetBathrobePage.IsTip()
	local var_12_0 = getProxy(ActivityProxy):getActivityById(ActivityConst.CYGNET_BATHROBE_PAGE_ID)

	if var_12_0 and not var_12_0:isEnd() then
		return var_12_0.data2 <= 0
	end

	return
end

return CygnetBathrobePage
