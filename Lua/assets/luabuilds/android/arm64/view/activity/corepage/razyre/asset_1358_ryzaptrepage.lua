local RyzaPtRePage = class("RyzaPtRePage", import("view.activity.CorePage.CorePtTemplatePage"))
local var_0_1 = 9

function RyzaPtRePage:OnInit()
	RyzaPtRePage.super.OnInit(self)

	self.kalaSpine = self.bg:Find("shadow/kala")
	self.kalaAnim = self.kalaSpine:GetComponent("SpineAnimUI")
	self.puniSpine = self.bg:Find("puni")
	self.puniAnim = self.puniSpine:GetComponent("SpineAnimUI")
	self.feedBtn = self.bg:Find("feed_btn")
	self.clickMask = self.bg:Find("click_mask")

	return
end

function RyzaPtRePage:OnFirstFlush()
	RyzaPtRePage.super.OnFirstFlush(self)
	self:InitAnimData()
	onButton(self, self.feedBtn, function()
		local var_3_0 = {}

		table.insert(var_3_0, function(arg_4_0)
			self:PlayFeedAnim(arg_4_0)

			return
		end)

		local var_3_1 = self.ptData:GetAward()
		local var_3_2 = getProxy(PlayerProxy):getRawData()
		local var_3_3, var_3_4 = Task.StaticJudgeOverflow(var_3_2.gold, var_3_2.oil, LOCK_UR_SHIP and 0 or getProxy(BagProxy):GetLimitCntById(pg.gameset.urpt_chapter_max.description[1]), true, true, {
			{
				var_3_1.type,
				var_3_1.id,
				var_3_1.count
			}
		})

		if var_3_3 then
			table.insert(var_3_0, function(arg_5_0)
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					type = MSGBOX_TYPE_ITEM_BOX,
					content = i18n("award_max_warning"),
					items = var_3_4,
					onYes = arg_5_0
				})

				return
			end)
		end

		seriesAsync(var_3_0, function()
			local var_6_0, var_6_1 = self.ptData:GetResProgress()

			self:emit(ActivityMediator.EVENT_PT_OPERATION, {
				cmd = 1,
				activity_id = self.ptData:GetId(),
				arg1 = var_6_1
			})

			return
		end)

		return
	end, SFX_PANEL)

	return
end

function RyzaPtRePage:OnUpdateFlush()
	RyzaPtRePage.super.OnUpdateFlush(self)

	if isActive(self.getBtn) and self.specialPhase[self.ptData:GetLevelProgress()] then
		setActive(self.getBtn, false)
		setActive(self.feedBtn, true)
	else
		setActive(self.feedBtn, false)
	end

	return
end

function RyzaPtRePage:UpdateSpineIdle(arg_8_1)
	self.kalaAnim:SetAction("pt_ui", 0)

	if arg_8_1 > self.puniPhaseCfg[#self.puniPhaseCfg] then
		local var_8_0, var_8_1, var_8_2 = self:GetAnimName(self.puniPhaseCfg[math.random(#self.puniPhaseCfg)])

		self.puniAnim:SetAction(var_8_0, 0)
		self:PlayIdleFeedAnim(var_8_1, var_8_2)
	else
		self.puniAnim:SetAction(self:GetAnimName(), 0)
	end

	return
end

function RyzaPtRePage:PlayIdleFeedAnim(arg_9_1, arg_9_2)
	self:PlayKalaAnim()
	self.puniAnim:SetActionCallBack(function(arg_10_0)
		if arg_10_0 == "finish" then
			self.puniAnim:SetActionCallBack(nil)
			self.puniAnim:SetAction(arg_9_2, 0)
		end

		return
	end)
	self.puniAnim:SetAction(arg_9_1, 0)

	return
end

function RyzaPtRePage:PlayFeedAnim(arg_11_1)
	setActive(self.clickMask, true)
	pg.UIMgr.GetInstance():OverlayPanel(self.clickMask)
	self:PlayKalaAnim()
	self:PlayPuniChangeAnim(function()
		setActive(self.clickMask, false)
		pg.UIMgr.GetInstance():UnOverlayPanel(self.clickMask, self.bg)

		if arg_11_1 then
			arg_11_1()
		end

		return
	end)

	return
end

function RyzaPtRePage:PlayKalaAnim(arg_13_1)
	self.kalaAnim:SetActionCallBack(function(arg_14_0)
		if arg_14_0 == "finish" then
			self.kalaAnim:SetActionCallBack(nil)
			self.kalaAnim:SetAction("pt_ui", 0)

			if arg_13_1 then
				arg_13_1()
			end
		end

		return
	end)
	self.kalaAnim:SetAction("event_weishi", 0)

	return
end

function RyzaPtRePage:PlayPuniChangeAnim(arg_15_1)
	local var_15_0, var_15_1, var_15_2 = self:GetAnimName()

	self.puniAnim:SetActionCallBack(function(arg_16_0)
		if arg_16_0 == "finish" then
			self.puniAnim:SetActionCallBack(nil)
			self.puniAnim:SetAction(var_15_2, 0)

			if arg_15_1 then
				arg_15_1()
			end
		end

		return
	end)
	self.puniAnim:SetAction(var_15_1, 0)

	return
end

function RyzaPtRePage:InitAnimData()
	self.puniPhaseCfg = self.activity:getConfig("config_client").puni_phase
	self.specialPhase = {}

	for iter_17_0, iter_17_1 in ipairs(self.puniPhaseCfg) do
		self.specialPhase[iter_17_1] = true
	end

	self.phase2anims = {}

	local var_17_0, var_17_1 = self.ptData:GetLevelProgress()

	for iter_17_2 = 1, self.puniPhaseCfg[#self.puniPhaseCfg] do
		local var_17_2 = {}

		table.insert(var_17_2, "normal_" .. 1)

		if self.specialPhase[iter_17_2] then
			table.insert(var_17_2, "action" .. 1)
			table.insert(var_17_2, "normal_" .. 1 + 1)
		end

		table.insert(self.phase2anims, var_17_2)
	end

	return
end

function RyzaPtRePage:GetAnimName(arg_18_1)
	local var_18_0 = arg_18_1 and arg_18_1 or self.ptData:GetLevelProgress()

	if var_18_0 > self.puniPhaseCfg[#self.puniPhaseCfg] then
		return "normal_" .. math.random(var_0_1)
	else
		return self.phase2anims[var_18_0][1], self.phase2anims[var_18_0][2], self.phase2anims[var_18_0][3]
	end

	return
end

function RyzaPtRePage:OnShowFlush()
	self:UpdateSpineIdle(self.ptData:GetLevelProgress())

	return
end

function RyzaPtRePage:OnDestroy()
	if isActive(self.clickMask) then
		setActive(self.clickMask, false)
		pg.UIMgr.GetInstance():UnOverlayPanel(self.clickMask, self.bg)
	end

	return
end

return RyzaPtRePage
