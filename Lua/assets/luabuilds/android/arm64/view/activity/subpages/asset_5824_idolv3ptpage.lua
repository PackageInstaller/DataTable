local IdolV3PtPage = class("IdolV3PtPage", import(".TemplatePage.PtTemplatePage"))
local var_0_1 = {
	"kewei_idol",
	"ougen_idol",
	"nengdai_idol",
	"jingang_idol",
	"lumang_idol",
	"boyixi_idol"
}

function IdolV3PtPage:OnInit()
	IdolV3PtPage.super.OnInit(self)

	self.trainEntranceBtn = self.bg:Find("train_btn")
	self.skills = self.bg:Find("skill")
	self.skillBtns = {}

	for iter_1_0 = 0, self.skills.childCount - 1 do
		table.insert(self.skillBtns, self.skills:GetChild(iter_1_0))
	end

	self.helpBtn = self.bg:Find("help_btn")
	self.idol1 = self.bg:Find("idol1")
	self.buffInfoBox = self._tf:Find("BuffInfoBox")
	self.mask = self.buffInfoBox:Find("mengban")
	self.buffWindow = self.buffInfoBox:Find("panel")
	self.buffName = self.buffWindow:Find("title/name")
	self.titleLv = self.buffWindow:Find("title/lv")
	self.titleIcon = self.buffWindow:Find("title/icon")
	self.buffTip = self.buffWindow:Find("content/tip")
	self.desc = self.buffWindow:Find("content/desc")
	self.buffAwardTF = self.buffWindow:Find("award_bg/award")
	self.trainWindow = self._tf:Find("IdolTrainWindow")
	self.trainTitle = self.trainWindow:Find("panel/title/Text")
	self.trainBtn = self.trainWindow:Find("panel/train_btn")
	self.trainSkills = self.trainWindow:Find("panel/skills")
	self.trainSkillBtns = {}

	for iter_1_1 = 0, self.trainSkills.childCount - 1 do
		table.insert(self.trainSkillBtns, self.trainSkills:GetChild(iter_1_1))
	end

	self.info = self.trainWindow:Find("panel/info")
	self.curBuff = self.info:Find("preview/current")
	self.nextBuff = self.info:Find("preview/next")
	self.msgBox = self._tf:Find("MsgBox")
	self.msgIcon = self.msgBox:Find("panel/title/icon")

	setText(self.msgBox:Find("panel/title/Text"), i18n("title_info"))

	self.msgContent = self.msgBox:Find("panel/content")
	self.msgBoxMask = self.msgBox:Find("mengban")
	self.cancelBtn = self.msgBox:Find("panel/cancel_btn")
	self.confirmBtn = self.msgBox:Find("panel/confirm_btn")
	self.tipPanel = self._tf:Find("Tip")

	return
end

function IdolV3PtPage:OnFirstFlush()
	IdolV3PtPage.super.OnFirstFlush(self)
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
			local var_5_0, var_5_1 = self.ptData:GetResProgress()

			self:emit(ActivityMediator.EVENT_PT_OPERATION, {
				cmd = 1,
				activity_id = self.ptData:GetId(),
				arg1 = var_5_1
			})
			self:playIdolAni()

			return
		end)

		return
	end, SFX_PANEL)
	removeOnButton(self.battleBtn)
	onButton(self, self.battleBtn, function()
		local var_6_0
		local var_6_1

		if self.activity:getConfig("config_client") ~= "" then
			var_6_0 = self.activity:getConfig("config_client").linkActID

			if var_6_0 then
				var_6_1 = getProxy(ActivityProxy):getActivityById(var_6_0)
			end
		end

		if not var_6_0 then
			self:emit(ActivityMediator.BATTLE_OPERA)
		elseif var_6_1 and not var_6_1:isEnd() then
			self:emit(ActivityMediator.BATTLE_OPERA)
		else
			self:showTip(i18n("common_activity_end"))
		end

		return
	end, SFX_PANEL)
	onButton(self, self.trainEntranceBtn, function()
		self:showTrianPanel()

		return
	end, SFX_PANEL)
	onButton(self, self.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = i18n("idol3rd_practice")
		})

		return
	end, SFX_PANEL)
	self:hideBuffInfoBox()
	onButton(self, self.mask, function()
		self:hideBuffInfoBox()

		return
	end, SFX_PANEL)

	for iter_2_0, iter_2_1 in ipairs(self.skillBtns) do
		onButton(self, iter_2_1, function()
			for iter_10_0, iter_10_1 in ipairs(self.ptData:GetCurBuffInfos()) do
				if iter_2_0 == iter_10_1.group then
					self:showBuffInfoBox(iter_10_1)
				end
			end

			return
		end, SFX_PANEL)
	end

	local var_2_0 = var_0_1[math.random(#var_0_1)]

	pg.UIMgr.GetInstance():LoadingOn()
	PoolMgr.GetInstance():GetSpineChar(var_2_0, true, function(arg_11_0)
		pg.UIMgr.GetInstance():LoadingOff()

		self.prefab1 = var_2_0
		self.model1 = arg_11_0
		tf(arg_11_0).localScale = Vector3(1, 1, 1)

		arg_11_0:GetComponent("SpineAnimUI"):SetAction("stand2", 0)
		setParent(arg_11_0, self.idol1)

		return
	end)
	setActive(self.skills, self.ptData:isInBuffTime())

	return
end

function IdolV3PtPage:OnUpdateFlush()
	local var_12_0 = false
	local var_12_1 = self.ptData:CanTrain()

	if var_12_1 and var_12_1 <= self.ptData.level then
		var_12_0 = true
	end

	local var_12_2, var_12_3, var_12_4 = self.ptData:GetLevelProgress()
	local var_12_5, var_12_6, var_12_7 = self.ptData:GetResProgress()

	setText(self.step, var_12_2 .. "/" .. var_12_3)
	setText(self.progress, var_12_5 .. "/" .. var_12_6)
	setSlider(self.slider, 0, 1, var_12_7)

	local var_12_8 = self.ptData:CanGetNextAward()
	local var_12_9 = self.ptData:CanGetMorePt()
	local var_12_10 = self.ptData:CanTrain()

	setActive(self.battleBtn, true)
	setActive(self.getBtn, self.ptData:CanGetAward() and not var_12_0)
	setActive(self.trainEntranceBtn, var_12_0)
	setActive(self.gotBtn, not var_12_8 and not var_12_10)

	local var_12_11 = self.ptData:GetAward()

	updateDrop(self.awardTF, var_12_11)
	onButton(self, self.awardTF, function()
		self:emit(BaseUI.ON_DROP, var_12_11)

		return
	end, SFX_PANEL)

	for iter_12_0, iter_12_1 in ipairs(self.ptData:GetCurBuffInfos()) do
		setActive(self.skillBtns[iter_12_1.group]:Find("lv1"), false)
		setActive(self.skillBtns[iter_12_1.group]:Find("lv2"), false)
		setActive(self.skillBtns[iter_12_1.group]:Find("lv3"), false)

		if iter_12_1.next then
			setActive(self.skillBtns[iter_12_1.group]:Find("lv" .. iter_12_1.lv), true)
		end

		local var_12_12

		do
			setActive(self.skillBtns[iter_12_1.group]:Find("lv3"), true)

			var_12_12 = self.skillBtns[iter_12_1.group]:Find("icon")
		end

		setImageSprite(var_12_12, LoadSprite(pg.benefit_buff_template[iter_12_1.id].icon))
	end

	return
end

function IdolV3PtPage:showTrianPanel()
	setActive(self.trainWindow, true)
	setText(self.trainTitle, i18n("upgrade_idol_tip"))

	local var_14_0 = self.ptData:GetCurBuffInfos()

	self.selectIndex = nil
	self.selectBuffId = nil
	self.selectBuffLv = nil
	self.selectNewBuffId = nil

	for iter_14_0, iter_14_1 in ipairs(self.trainSkillBtns) do
		onButton(self, iter_14_1, function()
			for iter_15_0, iter_15_1 in ipairs(var_14_0) do
				if iter_14_0 == iter_15_1.group and iter_15_1.next then
					self.selectIndex = iter_14_0
					self.selectBuffId = iter_15_1.id
					self.selectNewBuffId = iter_15_1.next
					self.selectBuffLv = iter_15_1.lv
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

	local var_14_1 = underscore.detect(var_14_0, function(arg_17_0)
		return arg_17_0.next
	end)

	if var_14_1 then
		triggerButton(self.trainSkillBtns[var_14_1.group])
	end

	return
end

function IdolV3PtPage:hideTrianPanel()
	setActive(self.trainWindow, false)

	return
end

function IdolV3PtPage:flushTrainPanel()
	local var_19_0 = self.ptData:GetCurBuffInfos()

	if var_19_0 then
		for iter_19_0, iter_19_1 in ipairs(var_19_0) do
			setActive(self.trainSkillBtns[iter_19_1.group]:Find("lv1"), false)
			setActive(self.trainSkillBtns[iter_19_1.group]:Find("lv2"), false)
			setActive(self.trainSkillBtns[iter_19_1.group]:Find("lv3"), false)

			if iter_19_1.next then
				setActive(self.trainSkillBtns[iter_19_1.group]:Find("lv" .. iter_19_1.lv), true)
			end

			local var_19_1

			do
				setActive(self.trainSkillBtns[iter_19_1.group]:Find("lv3"), true)

				var_19_1 = self.trainSkillBtns[iter_19_1.group]:Find("icon")
			end

			setImageSprite(var_19_1, LoadSprite(pg.benefit_buff_template[iter_19_1.id].icon))
			setText(self.trainSkillBtns[iter_19_1.group]:Find("name"), shortenString(pg.benefit_buff_template[iter_19_1.id].name, 7))
		end
	end

	for iter_19_2, iter_19_3 in ipairs(self.trainSkillBtns) do
		if iter_19_2 == self.selectIndex then
			setActive(iter_19_3:Find("selected"), true)
			setActive(iter_19_3:Find("name"), true)
		else
			setActive(iter_19_3:Find("selected"), false)
			setActive(iter_19_3:Find("name"), false)
		end
	end

	if self.selectIndex then
		setActive(self.info, true)
		setActive(self.trainBtn, true)
		setText(self.curBuff, "Lv." .. self.selectBuffLv .. pg.benefit_buff_template[self.selectBuffId].desc)
		setText(self.nextBuff, "Lv." .. self.selectBuffLv + 1 .. pg.benefit_buff_template[self.selectNewBuffId].desc)
	else
		setActive(self.info, false)
		setActive(self.trainBtn, false)
	end

	return
end

function IdolV3PtPage:showBuffInfoBox(arg_20_1)
	setText(self.buffName, pg.benefit_buff_template[arg_20_1.id].name)
	setText(self.desc, pg.benefit_buff_template[arg_20_1.id].desc)
	setText(self.buffTip, i18n("upgrade_introduce_tip", pg.benefit_buff_template[arg_20_1.id].name))
	setImageSprite(self.titleIcon, LoadSprite(pg.benefit_buff_template[arg_20_1.id].icon))

	local var_20_0 = arg_20_1.award

	updateDrop(self.buffAwardTF, arg_20_1.award)
	onButton(self, self.buffAwardTF, function()
		self:emit(BaseUI.ON_DROP, var_20_0)

		return
	end, SFX_PANEL)

	if arg_20_1.next then
		setText(self.titleLv, "Lv." .. arg_20_1.lv)
		setActive(self.buffAwardTF:Find("icon_bg/got_mask"), false)
	else
		setText(self.titleLv, "MAX")
		setActive(self.buffAwardTF:Find("icon_bg/got_mask"), true)
		removeOnButton(self.buffAwardTF)
	end

	setActive(self.buffInfoBox, true)

	return
end

function IdolV3PtPage:hideBuffInfoBox()
	setActive(self.buffInfoBox, false)

	return
end

function IdolV3PtPage:OnDestroy()
	if self.prefab1 and self.model1 then
		PoolMgr.GetInstance():ReturnSpineChar(self.prefab1, self.model1)

		self.prefab1 = nil
		self.model1 = nil
	end

	return
end

function IdolV3PtPage:playIdolAni()
	if self.model1 then
		self.model1:GetComponent("SpineAnimUI"):SetAction("idol", 0)
	end

	return
end

function IdolV3PtPage:showMsgBox()
	if self.selectBuffId then
		setActive(self.msgBox, true)
		setImageSprite(self.msgIcon, LoadSprite(pg.benefit_buff_template[self.selectBuffId].icon))
		setText(self.msgContent, i18n("practise_idol_tip", pg.benefit_buff_template[self.selectBuffId].name))
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
				oldBuffId = self.selectBuffId,
				callback = function()
					self:hideTrianPanel()
					self:showTip(i18n("upgrade_complete_tip"))

					return
				end
			})

			return
		end, SFX_PANEL)
	end

	return
end

function IdolV3PtPage:hideMsgBox()
	setActive(self.msgBox, false)

	return
end

function IdolV3PtPage:showTip(arg_31_1)
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

return IdolV3PtPage
