local DOACharacterGiftPage = class("DOACharacterGiftPage", import("view.activity.CorePage.CorePtTemplatePage"))
local var_0_1 = 7

function DOACharacterGiftPage:OnInit()
	self.AD = self._tf:Find("AD")
	self.task = self.AD:Find("task")
	self.awardTF = self.task:Find("award")
	self.slider = self.task:Find("slider")
	self.friendText = self.task:Find("friendText")
	self.targetText = self.task:Find("targetText")
	self.displayBtn = self.AD:Find("display_btn")
	self.getAwardTxt = self.displayBtn:Find("Text")
	self.hearts = UIItemList.New(self.AD:Find("heart"), self.AD:Find("heart/1"))
	self.btnGroup = self.AD:Find("btnGroup")
	self.battleBtn = self.btnGroup:Find("battle_btn")
	self.getBtn = self.btnGroup:Find("get_btn")
	self.gotBtn = self.btnGroup:Find("got_btn")

	return
end

function DOACharacterGiftPage:OnFirstFlush()
	DOACharacterGiftPage.super.OnFirstFlush(self)
	self:InitLocal()
	onButton(self, self.battleBtn, function()
		self:emit(ActivityMediator.SPECIAL_BATTLE_OPERA)

		return
	end, SFX_PANEL)

	return
end

function DOACharacterGiftPage:InitLocal()
	self.imgHeart = GetSpriteFromAtlas("ui/DOACharacterGiftPage_atlas", "heart")
	self.imgHeratGreay = GetSpriteFromAtlas("ui/DOACharacterGiftPage_atlas", "heart_greay")

	setText(self.friendText, i18n("doa3_activityPageUI_7"))
	setText(self.getAwardTxt, i18n("doa3_activityPageUI_6"))

	return
end

function DOACharacterGiftPage:OnUpdateFlush()
	self:UpdateSlider()
	self:UpdateBtnGroup()
	self:UpdateAward()
	self:UpdateHearts()

	return
end

function DOACharacterGiftPage:UpdateSlider()
	local var_6_0, var_6_1, var_6_2 = self.ptData:GetResProgress()

	setText(self.targetText, "<color=#353c70>" .. var_6_0 .. "</color>" .. "/" .. "<color=#AEB7D0>" .. var_6_1 .. "</color>")
	setSlider(self.slider, 0, 1, var_6_2)

	return
end

function DOACharacterGiftPage:UpdateBtnGroup()
	local var_7_0 = self.ptData:CanGetAward()
	local var_7_1 = self.ptData:CanGetNextAward()

	setActive(self.battleBtn, self.ptData:CanGetMorePt() and not var_7_0 and var_7_1)
	setActive(self.getBtn, var_7_0)
	setActive(self.gotBtn, not var_7_1)

	return
end

function DOACharacterGiftPage:UpdateHearts()
	self.hearts:make(function(arg_9_0, arg_9_1, arg_9_2)
		if arg_9_0 == UIItemList.EventUpdate then
			if arg_9_1 < self.ptData.level then
				setImageSprite(arg_9_2, self.imgHeart)
			else
				setImageSprite(arg_9_2, self.imgHeratGreay)
			end
		end

		return
	end)
	self.hearts:align(var_0_1)

	return
end

function DOACharacterGiftPage:UpdateAward()
	local var_10_0 = self.ptData:GetAward()

	updateDrop(self.awardTF, var_10_0)
	onButton(self, self.awardTF, function()
		self:emit(BaseUI.ON_DROP, var_10_0)

		return
	end, SFX_PANEL)

	return
end

return DOACharacterGiftPage
