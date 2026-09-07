local DOAPtPage = class("DOAPtPage", import(".TemplatePage.PtTemplatePage"))

function DOAPtPage:OnInit()
	DOAPtPage.super.OnInit(self)

	self.buffModule = self.bg:Find("buff_module")
	self.buffPanel = self.buffModule:Find("skill")
	self.buffLvs = {
		self.buffPanel:Find("pow_lv"),
		self.buffPanel:Find("tec_lv"),
		self.buffPanel:Find("stm_lv"),
		self.buffPanel:Find("apl_lv")
	}
	self.getGreyBtn = self.bg:Find("get_grey_btn")
	self.helpBtn = self.bg:Find("help_btn")
	self.levelPanel = self.buffModule:Find("level")
	self.f2aPanel = self.levelPanel:Find("f_to_a")
	self.sPanel = self.levelPanel:Find("s_ss")
	self.sssPanel = self.levelPanel:Find("sss")
	self.lvBarImages = self.bg:Find("lv_bars")
	self.lvTagImages = self.bg:Find("lv_tags")
	self.shieldEffect = self.buffModule:Find("level/shield_effect")
	self.starEffect = self.buffModule:Find("level/star_effect")
	self.mask = self.bg:Find("mask")
	self.trainWindow = self._tf:Find("TrainWindow")
	self.trainBtn = self.trainWindow:Find("panel/train_btn")
	self.trainSkills = self.trainWindow:Find("panel/skills")
	self.trainSkillBtns = {
		self.trainSkills:Find("pow_btn"),
		self.trainSkills:Find("tec_btn"),
		self.trainSkills:Find("stm_btn"),
		self.trainSkills:Find("apl_btn")
	}
	self.curInfoPanel = self.trainWindow:Find("panel/info_bg")
	self.curInfo = self.trainWindow:Find("panel/info_bg/cur")
	self.nextInfo = self.trainWindow:Find("panel/info_bg/next")
	self.msgBox = self._tf:Find("MsgBox")
	self.msgContent = self.msgBox:Find("panel/content")
	self.msgBoxMask = self.msgBox:Find("mengban")
	self.cancelBtn = self.msgBox:Find("panel/cancel_btn")
	self.confirmBtn = self.msgBox:Find("panel/confirm_btn")
	self.tipPanel = self._tf:Find("Tip")
	self.buffBox = self._tf:Find("BuffBox")
	self.buffMask = self.buffBox:Find("mask")
	self.buffIconParent = self.buffBox:Find("window/panel/icon")
	self.buffDescContent = self.buffBox:Find("window/panel/intro_view/Viewport/Content")
	self.buffDescTpl = self.buffBox:Find("window/panel/intro_view/buff_desc_tpl")
	self.singleBuffBox = self._tf:Find("SingleBuffBox")
	self.singleBuffMask = self.singleBuffBox:Find("bg")
	self.singleSureBtn = self.singleBuffBox:Find("window/top/btnBack")
	self.singleCloseBtn = self.singleBuffBox:Find("window/sure_btn")
	self.singleIconParent = self.singleBuffBox:Find("window/panel/icon")
	self.singleDescContent = self.singleBuffBox:Find("window/panel/intro_view/Viewport/Content")
	self.singleDescTpl = self.singleBuffBox:Find("window/panel/intro_view/buff_desc_tpl")

	setText(self.singleBuffBox:Find("window/top/bg/infomation/title"), i18n("words_information"))
	setText(self.singleBuffBox:Find("window/sure_btn/pic"), i18n("text_confirm"))

	return
end

function DOAPtPage:OnFirstFlush()
	DOAPtPage.super.OnFirstFlush(self)
	setActive(self.bg, true)
	removeOnButton(self.getBtn)
	onButton(self, self.getBtn, function()
		local var_3_0 = {}
		local var_3_1 = self.ptData:GetAward()

		if var_3_1.type == DROP_TYPE_RESOURCE and var_3_1.id == PlayerConst.ResGold and getProxy(PlayerProxy):getData():GoldMax(var_3_1.count) then
			table.insert(var_3_0, function(arg_4_0)
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					content = i18n("gold_max_tip_title") .. i18n("award_max_warning"),
					onYes = arg_4_0
				})

				return
			end)
		end

		seriesAsync(var_3_0, function()
			self.isShowEffect = true

			local var_5_0 = self.ptData:CanTrain() and self.ptData:isInBuffTime()

			local function var_5_1()
				if var_5_0 then
					self:showUpEffect()
				else
					self:updateLevelPanel()
				end

				return
			end

			local var_5_2, var_5_3 = self.ptData:GetResProgress()

			self:emit(ActivityMediator.EVENT_PT_OPERATION, {
				cmd = 1,
				activity_id = self.ptData:GetId(),
				arg1 = var_5_3,
				callback = var_5_1
			})

			return
		end)

		return
	end, SFX_PANEL)
	removeOnButton(self.battleBtn)
	onButton(self, self.battleBtn, function()
		local var_7_0
		local var_7_1
		local var_7_2 = self.activity:getConfig("config_client")

		if var_7_2 ~= "" then
			var_7_0 = self.activity:getConfig("config_client").linkActID

			if var_7_0 then
				var_7_1 = getProxy(ActivityProxy):getActivityById(var_7_0)
			end
		end

		if var_7_2.fightLinkActID then
			self:emit(ActivityMediator.SKIP_ACTIVITY_MAP, var_7_2.fightLinkActID)

			return
		end

		if not var_7_0 then
			self:emit(ActivityMediator.BATTLE_OPERA)
		elseif var_7_1 and not var_7_1:isEnd() then
			self:emit(ActivityMediator.BATTLE_OPERA)
		else
			self:showTip(i18n("common_activity_end"))
		end

		return
	end, SFX_PANEL)
	onButton(self, self.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = i18n("doa_pt_help")
		})

		return
	end, SFX_PANEL)
	onButton(self, self.buffModule, function()
		self:showBuffBox()

		return
	end, SFX_PANEL)

	if self.contextData.singleActivity then
		setActive(self.bg, false)
		self:showSingleBuffBox()
	end

	self.starEffect:GetComponent("DftAniEvent"):SetEndEvent(function()
		self:updateLevelPanel()
		self:managedTween(LeanTween.delayedCall, function()
			self:showTrianPanel()
			setActive(self.starEffect, false)
			setActive(self.mask, false)
			pg.UIMgr.GetInstance():UnOverlayPanel(self.mask, self.bg)

			return
		end, 0.2, nil)

		return
	end)
	self.shieldEffect:GetComponent("DftAniEvent"):SetEndEvent(function()
		self:updateLevelPanel()
		self:managedTween(LeanTween.delayedCall, function()
			self:showTrianPanel()
			setActive(self.starEffect, false)
			setActive(self.mask, false)
			pg.UIMgr.GetInstance():UnOverlayPanel(self.mask, self.bg)

			return
		end, 0.2, nil)

		return
	end)

	self.isShowEffect = false

	return
end

function DOAPtPage:showUpEffect(arg_14_1)
	setSlider(self.curPanel, 0, 1, 1)

	local var_14_0 = self.ptData:GetBuffLevelProgress()

	if var_14_0 == 8 or var_14_0 == 9 then
		setActive(self.starEffect, true)
		self.starEffect:GetComponent("Animator"):Play("saoguang_anim", -1, 0)
	else
		setActive(self.shieldEffect, true)
		self.shieldEffect:GetComponent("Animator"):Play("saoguang_anim", -1, 0)
	end

	setActive(self.mask, true)
	pg.UIMgr.GetInstance():OverlayPanel(self.mask)

	return
end

function DOAPtPage:updateLevelPanel()
	local var_15_0, var_15_1 = self.ptData:GetBuffLevelProgress()

	setActive(self.f2aPanel, false)
	setActive(self.sPanel, false)
	setActive(self.sssPanel, false)

	self.curPanel = nil
	self.curPanel = var_15_0 == 9 and self.sssPanel or var_15_0 > 6 and self.sPanel or self.f2aPanel

	setActive(self.curPanel, true)
	setImageSprite(self.curPanel:Find("bar"), self.lvBarImages:Find(var_15_0):GetComponent(typeof(Image)).sprite)
	setImageSprite(self.curPanel:Find("lv_tag"), self.lvTagImages:Find(var_15_0):GetComponent(typeof(Image)).sprite, true)
	setSlider(self.curPanel, 0, 1, var_15_1)

	return self.curPanel
end

function DOAPtPage:OnUpdateFlush()
	setActive(self.starEffect, false)
	setActive(self.shieldEffect, false)

	local var_16_0 = self.ptData:CanTrain()

	if var_16_0 and var_16_0 <= self.ptData.level and self.ptData:isInBuffTime() and not self.contextData.singleActivity and not self.isShowEffect then
		self:showTrianPanel()
	end

	local var_16_1, var_16_2, var_16_3 = self.ptData:GetLevelProgress()
	local var_16_4, var_16_5, var_16_6 = self.ptData:GetResProgress()

	setText(self.step, var_16_1 .. "/" .. var_16_2)
	setText(self.progress, (var_16_6 >= 1 and setColorStr(var_16_4, COLOR_GREEN) or var_16_4) .. "/" .. var_16_5)
	setSlider(self.slider, 0, 1, var_16_6)

	if not self.isShowEffect then
		self:updateLevelPanel()
	end

	local var_16_7 = self.ptData:CanGetAward()
	local var_16_8 = self.ptData:CanGetNextAward()
	local var_16_9 = self.ptData:CanTrain()

	setActive(self.battleBtn, self.ptData:CanGetMorePt() and not var_16_7 and var_16_8)
	setActive(self.getBtn, var_16_7)
	setActive(self.getGreyBtn, not var_16_7)
	setActive(self.gotBtn, not var_16_8 and not var_16_9)
	setActive(self.buffModule, self.ptData:isInBuffTime())

	local var_16_10 = self.ptData:GetAward()

	updateDrop(self.awardTF, var_16_10)
	onButton(self, self.awardTF, function()
		self:emit(BaseUI.ON_DROP, var_16_10)

		return
	end, SFX_PANEL)

	for iter_16_0, iter_16_1 in ipairs(self.ptData:GetCurBuffInfos()) do
		setText(self.buffLvs[iter_16_1.group], (iter_16_1.next or nil) and ("LV." .. iter_16_1.lv or "MAX"))
	end

	return
end

function DOAPtPage:showTrianPanel()
	setActive(self.trainWindow, true)

	local var_18_0 = self.ptData:GetCurBuffInfos()

	self.selectIndex = nil
	self.selectBuffId = nil
	self.selectBuffLv = nil
	self.selectNewBuffId = nil

	for iter_18_0, iter_18_1 in ipairs(self.trainSkillBtns) do
		onButton(self, iter_18_1, function()
			for iter_19_0, iter_19_1 in ipairs(var_18_0) do
				if iter_18_0 == iter_19_1.group then
					if iter_19_1.next then
						self.selectIndex = iter_18_0
						self.selectBuffId = iter_19_1.id
						self.selectNewBuffId = iter_19_1.next
						self.selectBuffLv = iter_19_1.lv
					else
						self.selectIndex = nil
						self.selectBuffId = nil
						self.selectNewBuffId = nil
						self.selectBuffLv = nil
					end
				end
			end

			self:flushTrainPanel()

			return
		end, SFX_PANEL)
	end

	onButton(self, self.trainBtn, function()
		self:showMsgBox()

		return
	end, SFX_PANEL)
	;(function()
		for iter_21_0, iter_21_1 in ipairs(var_18_0) do
			if iter_21_1.next then
				self.selectIndex = iter_21_1.group
				self.selectBuffId = iter_21_1.id
				self.selectNewBuffId = iter_21_1.next
				self.selectBuffLv = iter_21_1.lv

				return
			end
		end

		return
	end)()
	self:flushTrainPanel()

	return
end

function DOAPtPage:hideTrianPanel()
	setActive(self.trainWindow, false)

	return
end

function DOAPtPage:flushTrainPanel()
	local var_23_0 = self.ptData:GetCurBuffInfos()

	if var_23_0 then
		for iter_23_0, iter_23_1 in ipairs(var_23_0) do
			setText(self.trainSkillBtns[iter_23_1.group]:Find("lv_bg/lv"), (iter_23_1.next or nil) and ("LV." .. iter_23_1.lv or "MAX"))
		end
	end

	for iter_23_2, iter_23_3 in ipairs(self.trainSkillBtns) do
		if iter_23_2 == self.selectIndex then
			setActive(iter_23_3:Find("selected"), true)
		else
			setActive(iter_23_3:Find("selected"), false)
		end
	end

	if self.selectIndex then
		setActive(self.curInfoPanel, true)
		setActive(self.trainBtn, true)
		setText(self.curInfo, pg.benefit_buff_template[self.selectBuffId].desc)
		setText(self.nextInfo, pg.benefit_buff_template[self.selectNewBuffId].desc)
	else
		setActive(self.curInfoPanel, false)
		setActive(self.trainBtn, false)
	end

	return
end

function DOAPtPage:getBuffNameIndex(arg_24_1)
	if arg_24_1 == 35 or arg_24_1 == 36 or arg_24_1 == 37 then
		return 1
	elseif arg_24_1 == 38 or arg_24_1 == 39 or arg_24_1 == 40 then
		return 2
	elseif arg_24_1 == 41 or arg_24_1 == 42 or arg_24_1 == 43 then
		return 3
	elseif arg_24_1 == 44 or arg_24_1 == 45 or arg_24_1 == 46 then
		return 4
	end

	return 1
end

function DOAPtPage:getTip(arg_25_1)
	if arg_25_1 == 35 or arg_25_1 == 36 or arg_25_1 == 37 then
		return i18n("doa_liliang")
	elseif arg_25_1 == 38 or arg_25_1 == 39 or arg_25_1 == 40 then
		return i18n("doa_jiqiao")
	elseif arg_25_1 == 41 or arg_25_1 == 42 or arg_25_1 == 43 then
		return i18n("doa_tili")
	elseif arg_25_1 == 44 or arg_25_1 == 45 or arg_25_1 == 46 then
		return i18n("doa_meili")
	end

	return ""
end

function DOAPtPage:showMsgBox()
	if self.selectBuffId then
		setActive(self.msgBox, true)
		setText(self.msgContent, i18n("doa_pt_up", self:getTip(pg.benefit_buff_template[self.selectBuffId].id)))
		onButton(self, self.msgBoxMask, function()
			self:hideMsgBox()

			return
		end, SFX_PANEL)
		onButton(self, self.cancelBtn, function()
			self:hideMsgBox()

			return
		end, SFX_PANEL)
		onButton(self, self.confirmBtn, function()
			self:hideMsgBox()
			self:emit(ActivityMediator.EVENT_PT_OPERATION, {
				cmd = 3,
				activity_id = self.ptData:GetId(),
				arg1 = self.ptData:CanTrain(),
				arg2 = self.selectNewBuffId,
				oldBuffId = self.selectBuffId
			})
			self:hideTrianPanel()
			self:showTip(i18n("doa_pt_complete"))

			return
		end, SFX_PANEL)
	end

	return
end

function DOAPtPage:hideMsgBox()
	setActive(self.msgBox, false)

	return
end

function DOAPtPage:showTip(arg_31_1)
	local var_31_0 = cloneTplTo(self.tipPanel, self._tf)

	setActive(var_31_0, true)
	setText(var_31_0:Find("Text"), arg_31_1)

	var_31_0.transform.localScale = Vector3(0, 0.1, 1)

	LeanTween.scale(var_31_0, Vector3(1.8, 0.1, 1), 0.1):setUseEstimatedTime(true)
	LeanTween.scale(var_31_0, Vector3(1.1, 1.1, 1), 0.1):setDelay(0.1):setUseEstimatedTime(true)

	local var_31_1 = GetOrAddComponent(var_31_0, "CanvasGroup")

	Timer.New(function()
		if IsNil(var_31_0) then
			return
		end

		LeanTween.scale(var_31_0, Vector3(0.1, 1.5, 1), 0.1):setUseEstimatedTime(true):setOnComplete(System.Action(function()
			LeanTween.scale(var_31_0, Vector3.zero, 0.1):setUseEstimatedTime(true):setOnComplete(System.Action(function()
				Destroy(var_31_0)

				return
			end))

			return
		end))

		return
	end, 3):Start()

	return
end

function DOAPtPage:showBuffBox()
	setActive(self.buffBox, true)
	removeAllChildren(self.buffIconParent)

	local var_35_0 = cloneTplTo(self:updateLevelPanel(), self.buffIconParent)

	setLocalPosition(var_35_0, Vector3(0, 0, 0))
	setLocalScale(var_35_0, Vector3(1.3, 1.3, 1))

	local var_35_1 = self.ptData:GetCurBuffInfos()

	if var_35_1 then
		for iter_35_0, iter_35_1 in ipairs(var_35_1) do
			setText(iter_35_0 <= self.buffDescContent.childCount and self.buffDescContent:GetChild(iter_35_0 - 1) or cloneTplTo(self.buffDescTpl, self.buffDescContent), pg.benefit_buff_template[iter_35_1.id].name .. pg.benefit_buff_template[iter_35_1.id].desc)
		end
	end

	onButton(self, self.buffMask, function()
		setActive(self.buffBox, false)

		return
	end, SFX_PANEL)

	return
end

function DOAPtPage:showSingleBuffBox()
	setActive(self.singleBuffBox, true)
	pg.UIMgr.GetInstance():BlurPanel(self.singleBuffBox)
	removeAllChildren(self.singleIconParent)

	local var_37_0 = cloneTplTo(self:updateLevelPanel(), self.singleIconParent)

	setLocalPosition(var_37_0, Vector3(0, 0, 0))
	setLocalScale(var_37_0, Vector3(1.3, 1.3, 1))

	local var_37_1 = self.ptData:GetCurBuffInfos()

	if var_37_1 then
		for iter_37_0, iter_37_1 in ipairs(var_37_1) do
			setText(iter_37_0 <= self.singleDescContent.childCount and self.singleDescContent:GetChild(iter_37_0 - 1) or cloneTplTo(self.singleDescTpl, self.singleDescContent), pg.benefit_buff_template[iter_37_1.id].name .. pg.benefit_buff_template[iter_37_1.id].desc)
		end
	end

	local function var_37_3()
		setActive(self.singleBuffBox, false)
		self:emit(ActivitySingleScene.EXIT)
		self:emit(ActivitySingleScene.ON_CLOSE)
		pg.UIMgr.GetInstance():UnOverlayPanel(self.singleBuffBox, self._tf)

		return
	end

	onButton(self, self.singleBuffMask, function()
		var_37_3()

		return
	end, SFX_PANEL)
	onButton(self, self.singleCloseBtn, function()
		var_37_3()

		return
	end, SFX_PANEL)
	onButton(self, self.singleSureBtn, function()
		var_37_3()

		return
	end, SFX_PANEL)

	return
end

function DOAPtPage:onBackPressed()
	if self.contextData.singleActivity then
		pg.UIMgr.GetInstance():UnOverlayPanel(self.singleBuffBox, self._tf)
	end

	return
end

function DOAPtPage:willExit()
	if self.contextData.singleActivity then
		pg.UIMgr.GetInstance():UnOverlayPanel(self.singleBuffBox, self._tf)
	end

	return
end

return DOAPtPage
