local ALYPtPage = class("ALYPtPage", import("..CorePageNewPtTemplatePage"))

function ALYPtPage:OnInit()
	ALYPtPage.super.OnInit(self)

	self.anim = self._tf:Find("bg/Image_back"):GetComponent(typeof(Animation))

	self.anim:Play("anim_AlyptPage_BackImage")

	self.animEvent = self.anim:GetComponent(typeof(DftAniEvent))

	self.animEvent:SetStartEvent(function()
		self._tf:GetComponent(typeof(Animation)):Play("anim_AlyptPage_In")

		return
	end)

	self._tfanim = self._tf:GetComponent(typeof(Animation))
	self._tfanimEvent = self._tfanim:GetComponent(typeof(DftAniEvent))

	self._tfanimEvent:SetEndEvent(function()
		setActive(self._tf:Find("bg/Image_back_Loop"), true)
		setActive(self._tf:Find("bg/VX"), true)

		return
	end)

	self.itemAlpha = 0

	setCanvasGroupAlpha(self.awardTpl, self.itemAlpha)

	self.awardanimEvent = self._tf:GetComponent(typeof(DftAniEvent))

	self.awardanimEvent:SetTriggerEvent(function(arg_4_0)
		self.itemAlpha = 1

		setCanvasGroupAlpha(self.awardTpl, self.itemAlpha)

		for iter_4_0 = 0, self.content.transform.childCount - 1 do
			local var_4_0 = self.content:GetChild(iter_4_0)

			onDelayTick(function()
				if self._state == ALYPtPage.STATES.DESTROY then
					return
				end

				setCanvasGroupAlpha(var_4_0, self.itemAlpha)
				quickPlayAnimation(var_4_0, "anim_AlyptPage_awardtpl_In")

				return
			end, 0.08)
		end

		onDelayTick(function()
			if self._state == ALYPtPage.STATES.DESTROY then
				return
			end

			quickPlayAnimation(self.sptf, "anim_AlyptPage_sp_award_In")

			return
		end, 0.08)

		return
	end)

	return
end

function ALYPtPage:UpdateAward(arg_7_1, arg_7_2)
	local var_7_0 = self.awardList[arg_7_1 + 1].drop

	updateDrop(arg_7_2:Find("icon"), self.awardList[arg_7_1 + 1].drop)
	setText(arg_7_2:Find("pt"), self.awardList[arg_7_1 + 1].target)

	local var_7_1 = arg_7_1 + 1 <= self.ptData:GetLevel()
	local var_7_2 = not var_7_1 and arg_7_1 + 1 <= self.ptData:GetMaxAvailableTargetIndex()
	local var_7_3 = not var_7_1 and not var_7_2

	setText(arg_7_2:Find("got/got_text"), i18n("yumia_pt_4"))
	setActive(arg_7_2:Find("got"), var_7_1)
	setActive(arg_7_2:Find("get"), var_7_2)
	setActive(arg_7_2:Find("lock"), var_7_3)
	onButton(self, arg_7_2, function()
		self:emit(BaseUI.ON_DROP, var_7_0)

		return
	end, SFX_PANEL)

	return
end

function ALYPtPage:OnFirstFlush()
	ALYPtPage.super.OnFirstFlush(self)
	setText(self._tf:Find("Text (Legacy)", self.shopBtn), i18n("yumia_pt_3"))
	setText(self._tf:Find("Text (Legacy)", self.getBtn), i18n("yumia_pt_2"))
	setText(self.bg:Find("rule_bg/rule_text"), i18n("yumia_pt_1"))
	setText(self._tf:Find("pt_bg/Text (Legacy)", self.bg), i18n("yumia_pt_tip"))

	return
end

function ALYPtPage:UpdateNextAward(arg_10_1)
	arg_10_1 = math.min(arg_10_1, 1)

	for iter_10_0, iter_10_1 in pairs(self.importantPos) do
		if arg_10_1 + ALYPtPage.AWARD_OFFSET < iter_10_1.pos then
			self:UpdateAward(iter_10_1.index - 1, self.spAward)

			break
		elseif iter_10_0 == #self.importantPos then
			self:UpdateAward(iter_10_1.index - 1, self.spAward)
		end
	end

	return
end

function ALYPtPage:OnUpdateFlush()
	if isActive(self._tf) then
		self.scrollCom:ScrollTo(math.clamp(self.scrollCom:HeadIndexToValue(self.ptData:GetLevel()) / self.impTotalPos + ALYPtPage.OFFSET * self.ptData:GetLevel(), 0, 1), true)
	end

	setText(self.get, i18n("word_got_pt"))
	setText(self.ptCount, self.ptData.count)

	return
end

function ALYPtPage:OnHideFlush()
	onDelayTick(function()
		for iter_13_0 = 0, self.content.transform.childCount - 1 do
			self.content:GetChild(iter_13_0):GetComponent(typeof(Animation)):Stop()
			setCanvasGroupAlpha(self.content:GetChild(iter_13_0), 0)
		end

		return
	end, 0.08)
	onDelayTick(function()
		setCanvasGroupAlpha(self.sptf, 0)

		return
	end, 0.08)

	return
end

return ALYPtPage
