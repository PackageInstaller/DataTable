local IdolTrainPtPage = class("IdolTrainPtPage", import(".TemplatePage.PtTemplatePage"))
local var_0_1 = {
	"dafeng_idol",
	"tashigan_idol",
	"daiduo_idol",
	"daqinghuayu_idol",
	"baerdimo_idol",
	"luoen_idol",
	"guanghui_idol",
	"edu_idol"
}

function IdolTrainPtPage:OnInit()
	IdolTrainPtPage.super.OnInit(self)

	self.skills = self.bg:Find("skill")
	self.skillBtns = {}

	eachChild(self.skills, function(arg_2_0)
		table.insert(self.skillBtns, arg_2_0)

		return
	end)

	self.getGreyBtn = self.bg:Find("get_grey_btn")
	self.helpBtn = self.bg:Find("help_btn")
	self.idol1 = self.bg:Find("idol1")
	self.idol2 = self.bg:Find("idol2")
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

	eachChild(self.trainSkills, function(arg_3_0)
		table.insert(self.trainSkillBtns, arg_3_0)

		return
	end)

	self.info = self.trainWindow:Find("panel/info")
	self.curBuff = self.info:Find("preview/current")
	self.nextBuff = self.info:Find("preview/next")
	self.msgBox = self._tf:Find("MsgBox")
	self.msgIcon = self.msgBox:Find("panel/title/icon")
	self.msgContent = self.msgBox:Find("panel/content")
	self.msgBoxMask = self.msgBox:Find("mengban")
	self.cancelBtn = self.msgBox:Find("panel/cancel_btn")
	self.confirmBtn = self.msgBox:Find("panel/confirm_btn")
	self.tipPanel = self._tf:Find("Tip")

	return
end

function IdolTrainPtPage:OnFirstFlush()
	IdolTrainPtPage.super.OnFirstFlush(self)
	removeOnButton(self.getBtn)
	onButton(self, self.getBtn, function()
		local var_5_0 = {}
		local var_5_1 = self.ptData:GetAward()

		if var_5_1.type == DROP_TYPE_RESOURCE and var_5_1.id == PlayerConst.ResGold and getProxy(PlayerProxy):getData():GoldMax(var_5_1.count) then
			table.insert(var_5_0, function(arg_6_0)
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					content = i18n("gold_max_tip_title") .. i18n("award_max_warning"),
					onYes = arg_6_0
				})

				return
			end)
		end

		seriesAsync(var_5_0, function()
			local var_7_0, var_7_1 = self.ptData:GetResProgress()

			self:emit(ActivityMediator.EVENT_PT_OPERATION, {
				cmd = 1,
				activity_id = self.ptData:GetId(),
				arg1 = var_7_1
			})

			if self.ptData:CanTrain() then
				self:showTrianPanel()
			end

			self:playIdolAni()

			return
		end)

		return
	end, SFX_PANEL)
	removeOnButton(self.battleBtn)
	onButton(self, self.battleBtn, function()
		local var_8_0
		local var_8_1

		if self.activity:getConfig("config_client") ~= "" then
			var_8_0 = self.activity:getConfig("config_client").linkActID

			if var_8_0 then
				var_8_1 = getProxy(ActivityProxy):getActivityById(var_8_0)
			end
		end

		if not var_8_0 then
			self:emit(ActivityMediator.BATTLE_OPERA)
		elseif var_8_1 and not var_8_1:isEnd() then
			self:emit(ActivityMediator.BATTLE_OPERA)
		else
			self:showTip(i18n("common_activity_end"))
		end

		return
	end, SFX_PANEL)
	self:hideBuffInfoBox()
	onButton(self, self.mask, function()
		self:hideBuffInfoBox()

		return
	end, SFX_PANEL)

	for iter_4_0, iter_4_1 in ipairs(self.skillBtns) do
		onButton(self, iter_4_1, function()
			for iter_10_0, iter_10_1 in ipairs(self.ptData:GetCurBuffInfos()) do
				if iter_4_0 == iter_10_1.group then
					self:showBuffInfoBox(iter_10_1)
				end
			end

			return
		end, SFX_PANEL)
	end

	local var_4_0, var_4_1 = self:getRandomName()

	pg.UIMgr.GetInstance():LoadingOn()
	PoolMgr.GetInstance():GetSpineChar(var_4_0, true, function(arg_11_0)
		pg.UIMgr.GetInstance():LoadingOff()

		self.prefab1 = var_4_0
		self.model1 = arg_11_0
		tf(arg_11_0).localScale = Vector3(1, 1, 1)

		arg_11_0:GetComponent("SpineAnimUI"):SetAction("stand2", 0)
		setParent(arg_11_0, self.idol1)

		return
	end)
	pg.UIMgr.GetInstance():LoadingOn()
	PoolMgr.GetInstance():GetSpineChar(var_4_1, true, function(arg_12_0)
		pg.UIMgr.GetInstance():LoadingOff()

		self.prefab2 = var_4_1
		self.model2 = arg_12_0
		tf(arg_12_0).localScale = Vector3(1, 1, 1)

		arg_12_0:GetComponent("SpineAnimUI"):SetAction("stand2", 0)
		setParent(arg_12_0, self.idol2)

		return
	end)

	return
end

function IdolTrainPtPage:OnUpdateFlush()
	local var_13_0 = self.ptData:CanTrain()

	if var_13_0 and var_13_0 <= self.ptData.level then
		self:showTrianPanel()
	end

	local var_13_1, var_13_2, var_13_3 = self.ptData:GetLevelProgress()
	local var_13_4, var_13_5, var_13_6 = self.ptData:GetResProgress()

	setText(self.step, setColorStr("PHASE  " .. var_13_1 .. "/", COLOR_WHITE) .. var_13_2)
	setText(self.progress, (var_13_6 >= 1 and setColorStr(var_13_4 .. "/", COLOR_WHITE) or var_13_4 .. "/") .. var_13_5)
	setSlider(self.slider, 0, 1, var_13_6)

	local var_13_7 = self.ptData:CanGetAward()
	local var_13_8 = self.ptData:CanGetNextAward()
	local var_13_9 = self.ptData:CanTrain()

	setActive(self.battleBtn, self.ptData:CanGetMorePt() and not var_13_7 and var_13_8)
	setActive(self.getBtn, var_13_7)
	setActive(self.getGreyBtn, not var_13_7)
	setActive(self.gotBtn, not var_13_8 and not var_13_9)

	local var_13_10 = self.ptData:GetAward()

	updateDrop(self.awardTF, var_13_10)
	onButton(self, self.awardTF, function()
		self:emit(BaseUI.ON_DROP, var_13_10)

		return
	end, SFX_PANEL)

	for iter_13_0, iter_13_1 in ipairs(self.ptData:GetCurBuffInfos()) do
		setActive(self.skillBtns[iter_13_1.group]:Find("lv1"), false)
		setActive(self.skillBtns[iter_13_1.group]:Find("lv2"), false)
		setActive(self.skillBtns[iter_13_1.group]:Find("lv3"), false)

		if iter_13_1.next then
			setActive(self.skillBtns[iter_13_1.group]:Find("lv" .. iter_13_1.lv), true)
		end

		local var_13_11

		do
			setActive(self.skillBtns[iter_13_1.group]:Find("lv3"), true)

			var_13_11 = self.skillBtns[iter_13_1.group]:Find("icon")
		end

		setImageSprite(var_13_11, LoadSprite(pg.benefit_buff_template[iter_13_1.id].icon))
	end

	onButton(self, self.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = i18n("practise_idol_help")
		})

		return
	end, SFX_PANEL)

	return
end

function IdolTrainPtPage:showTrianPanel()
	setActive(self.trainWindow, true)
	setText(self.trainTitle, i18n("upgrade_idol_tip"))

	local var_16_0 = self.ptData:GetCurBuffInfos()

	self.selectIndex = nil
	self.selectBuffId = nil
	self.selectBuffLv = nil
	self.selectNewBuffId = nil

	for iter_16_0, iter_16_1 in ipairs(self.trainSkillBtns) do
		onButton(self, iter_16_1, function()
			for iter_17_0, iter_17_1 in ipairs(var_16_0) do
				if iter_16_0 == iter_17_1.group then
					if iter_17_1.next then
						self.selectIndex = iter_16_0
						self.selectBuffId = iter_17_1.id
						self.selectNewBuffId = iter_17_1.next
						self.selectBuffLv = iter_17_1.lv
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
	self:flushTrainPanel()

	return
end

function IdolTrainPtPage:hideTrianPanel()
	setActive(self.trainWindow, false)

	return
end

function IdolTrainPtPage:flushTrainPanel()
	local var_20_0 = self.ptData:GetCurBuffInfos()

	if var_20_0 then
		for iter_20_0, iter_20_1 in ipairs(var_20_0) do
			setActive(self.trainSkillBtns[iter_20_1.group]:Find("lv1"), false)
			setActive(self.trainSkillBtns[iter_20_1.group]:Find("lv2"), false)
			setActive(self.trainSkillBtns[iter_20_1.group]:Find("lv3"), false)

			if iter_20_1.next then
				setActive(self.trainSkillBtns[iter_20_1.group]:Find("lv" .. iter_20_1.lv), true)
			end

			local var_20_1

			do
				setActive(self.trainSkillBtns[iter_20_1.group]:Find("lv3"), true)

				var_20_1 = self.trainSkillBtns[iter_20_1.group]:Find("icon")
			end

			setImageSprite(var_20_1, LoadSprite(pg.benefit_buff_template[iter_20_1.id].icon))
			setText(self.trainSkillBtns[iter_20_1.group]:Find("name"), shortenString(pg.benefit_buff_template[iter_20_1.id].name, 7))
		end
	end

	for iter_20_2, iter_20_3 in ipairs(self.trainSkillBtns) do
		if iter_20_2 == self.selectIndex then
			setActive(iter_20_3:Find("selected"), true)
			setActive(iter_20_3:Find("name"), true)
		else
			setActive(iter_20_3:Find("selected"), false)
			setActive(iter_20_3:Find("name"), false)
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

function IdolTrainPtPage:showBuffInfoBox(arg_21_1)
	setText(self.buffName, pg.benefit_buff_template[arg_21_1.id].name)
	setText(self.desc, pg.benefit_buff_template[arg_21_1.id].desc)
	setText(self.buffTip, i18n("upgrade_introduce_tip", pg.benefit_buff_template[arg_21_1.id].name))
	setImageSprite(self.titleIcon, LoadSprite(pg.benefit_buff_template[arg_21_1.id].icon))

	local var_21_0 = arg_21_1.award

	updateDrop(self.buffAwardTF, arg_21_1.award)
	onButton(self, self.buffAwardTF, function()
		self:emit(BaseUI.ON_DROP, var_21_0)

		return
	end, SFX_PANEL)

	if arg_21_1.next then
		setText(self.titleLv, "Lv." .. arg_21_1.lv)
		setActive(self.buffAwardTF:Find("icon_bg/got_mask"), false)
	else
		setText(self.titleLv, "MAX")
		setActive(self.buffAwardTF:Find("icon_bg/got_mask"), true)
		removeOnButton(self.buffAwardTF)
	end

	setActive(self.buffInfoBox, true)

	return
end

function IdolTrainPtPage:hideBuffInfoBox()
	setActive(self.buffInfoBox, false)

	return
end

function IdolTrainPtPage:OnDestroy()
	if self.prefab1 and self.model1 then
		PoolMgr.GetInstance():ReturnSpineChar(self.prefab1, self.model1)

		self.prefab1 = nil
		self.model1 = nil
	end

	if self.prefab2 and self.model2 then
		PoolMgr.GetInstance():ReturnSpineChar(self.prefab2, self.model2)

		self.prefab2 = nil
		self.model2 = nil
	end

	return
end

function IdolTrainPtPage:getRandomName()
	local var_25_0 = math.random(#var_0_1)
	local var_25_1

	while var_25_1 == var_25_0 or not var_25_1 do
		var_25_1 = math.random(#var_0_1)
	end

	return var_0_1[var_25_0], var_0_1[var_25_1]
end

function IdolTrainPtPage:playIdolAni()
	if self.model1 then
		self.model1:GetComponent("SpineAnimUI"):SetAction("idol", 0)
	end

	if self.model2 then
		self.model2:GetComponent("SpineAnimUI"):SetAction("idol", 0)
	end

	return
end

function IdolTrainPtPage:showMsgBox()
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
				oldBuffId = self.selectBuffId
			})
			self:hideTrianPanel()
			self:showTip(i18n("upgrade_complete_tip"))

			return
		end, SFX_PANEL)
	end

	return
end

function IdolTrainPtPage:hideMsgBox()
	setActive(self.msgBox, false)

	return
end

function IdolTrainPtPage:showTip(arg_32_1)
	local var_32_0 = cloneTplTo(self.tipPanel, self._tf)

	setActive(var_32_0, true)
	setText(var_32_0:Find("Text"), arg_32_1)

	var_32_0.transform.localScale = Vector3(0, 0.1, 1)

	LeanTween.scale(var_32_0, Vector3(1.8, 0.1, 1), 0.1):setUseEstimatedTime(true)
	LeanTween.scale(var_32_0, Vector3(1.1, 1.1, 1), 0.1):setDelay(0.1):setUseEstimatedTime(true)

	local var_32_1 = GetOrAddComponent(var_32_0, "CanvasGroup")

	Timer.New(function()
		if IsNil(var_32_0) then
			return
		end

		LeanTween.scale(var_32_0, Vector3(0.1, 1.5, 1), 0.1):setUseEstimatedTime(true):setOnComplete(System.Action(function()
			LeanTween.scale(var_32_0, Vector3.zero, 0.1):setUseEstimatedTime(true):setOnComplete(System.Action(function()
				Destroy(var_32_0)

				return
			end))

			return
		end))

		return
	end, 3):Start()

	return
end

return IdolTrainPtPage
