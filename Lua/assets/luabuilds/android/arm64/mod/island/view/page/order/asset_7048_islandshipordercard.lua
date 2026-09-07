local IslandShipOrderCard = class("IslandShipOrderCard")
local var_0_1 = Color.New(0.2235294117647059, 0.7450980392156863, 1, 1)
local var_0_2 = Color.New(0.8274509803921568, 0.8274509803921568, 0.8274509803921568, 1)
local var_0_3 = Color.New(0.8588235294117647, 0.8588235294117647, 0.8588235294117647, 1)
local var_0_4 = Color.New(1, 0.6823529411764706, 0.13333333333333333, 1)
local var_0_5 = Color.New(1, 1, 1, 1)

IslandShipOrderCard.EVENT_CD_END = "IslandShipOrderCard.EVENT_CD_END"

function IslandShipOrderCard:Ctor(arg_1_1, arg_1_2)
	self.parent = arg_1_2
	self._tf = arg_1_1
	self.bgTr = arg_1_1:Find("bg")
	self.bgImg = arg_1_1:Find("bg"):GetComponent(typeof(Image))
	self.request = arg_1_1:Find("request")
	self.exchangeBtn = arg_1_1:Find("refresh")
	self.requestCG = GetOrAddComponent(self.request, typeof(CanvasGroup))
	self.uiRequestList = UIItemList.New(arg_1_1:Find("request"), arg_1_1:Find("request/tpl"))
	self.titleTr = arg_1_1:Find("title")
	self.titleLineImg = arg_1_1:Find("title/line"):GetComponent(typeof(Image))
	self.titleTxt = arg_1_1:Find("title/Text"):GetComponent(typeof(Text))
	self.loadingTr = arg_1_1:Find("state_loading")
	self.loadingRequest = arg_1_1:Find("loading_request")
	self.loadingAward = arg_1_1:Find("loading_award")
	self.finishTr = arg_1_1:Find("state_finish")
	self.award = arg_1_1:Find("award")
	self.uiAwardList = UIItemList.New(arg_1_1:Find("award"), arg_1_1:Find("award/tpl"))
	self.lockTr = arg_1_1:Find("state_lock")
	self.normalTr = arg_1_1:Find("normal_award")
	self.levelLockTr = arg_1_1:Find("state_lock/level")
	self.levelLockTxt = self.levelLockTr:Find("Text"):GetComponent(typeof(Text))
	self.resLockTr = arg_1_1:Find("state_lock/gold")
	self.resLockTxt = self.resLockTr:Find("content/Text"):GetComponent(typeof(Text))
	self.timeTxt = arg_1_1:Find("loading_request/time/content/Text"):GetComponent(typeof(Text))
	self.getBtn = arg_1_1:Find("state_finish/get")
	self.signTr = arg_1_1:Find("sign")
	self.resImg = arg_1_1:Find("state_lock/gold/content/icon")
	self.emptyTr = arg_1_1:Find("empty")
	self.finishCntTxt = arg_1_1:Find("count"):GetComponent(typeof(Text))

	setText(arg_1_1:Find("loading_award/state/Text"), i18n("island_order_get_label"))
	setText(arg_1_1:Find("normal_award/state/Text"), i18n("island_order_get_label"))
	setText(self.getBtn:Find("Text"), i18n("island_order_get_label"))
	setText(arg_1_1:Find("empty/Text"), i18n("island_order_ship_sel_delegate_label"))
	setText(self.exchangeBtn:Find("Text"), i18n("island_order_ship_btn_replace"))

	self.animator = arg_1_1:GetComponent(typeof(Animation))
	self.aniDft = arg_1_1:GetComponent(typeof(DftAniEvent))

	return
end

function IslandShipOrderCard:Flush(arg_2_1, arg_2_2)
	self.slot = arg_2_1

	self:FlushMain(arg_2_1, arg_2_2)
	self:UpdateTimer(arg_2_1)

	return
end

function IslandShipOrderCard:FlushMain(arg_3_1, arg_3_2)
	self:SwitchMode(arg_3_1, arg_3_2)
	self:UpdateRequest(arg_3_1)
	self:UpdateAward(arg_3_1)
	self:UpdateLockTip(arg_3_1)
	self:UpdateTitle(arg_3_1)
	self:UpdateFinishCnt(arg_3_1)

	return
end

function IslandShipOrderCard:UpdateFinishCnt(arg_4_1)
	local var_4_0 = arg_4_1:GetMaxFinishCnt()

	self.finishCntTxt.text = i18n("island_order_ship_finish_cnt", var_4_0 - arg_4_1:GetRealFinishCnt(), var_4_0)

	return
end

function IslandShipOrderCard:PlayAniamtion(arg_5_1, arg_5_2, arg_5_3)
	local function var_5_0()
		self.aniDft:SetEndEvent(function()
			self.aniDft:SetEndEvent(nil)

			if arg_5_3 then
				arg_5_3()
			end

			return
		end)

		return
	end

	if arg_5_1 == IslandShipOrder.OP_TYPE_UNLOCK then
		var_5_0()
		self.animator:Play("anim_island_shiporder_unlock")
	elseif arg_5_1 == IslandShipOrder.OP_TYPE_LOADUP and arg_5_2 then
		var_5_0()
		self.animator:Play("anim_island_shiporder_intransit")
	elseif arg_5_1 == IslandShipOrder.OP_TYPE_GET_AWARD then
		var_5_0()
		self.animator:Play("anim_island_shiporder_next")
	else
		arg_5_3()
	end

	return
end

function IslandShipOrderCard:PlayFinishAnimation(arg_8_1, arg_8_2)
	if arg_8_1 then
		local var_8_0 = Clone(self.slot)

		var_8_0.endTime = pg.TimeMgr.GetInstance():GetServerTime() + 10

		self:FlushMain(var_8_0, self.mode)
	end

	self.aniDft:SetEndEvent(nil)
	self.aniDft:SetEndEvent(function()
		self.aniDft:SetEndEvent(nil)

		if arg_8_1 then
			self:FlushMain(self.slot, self.mode)
		end

		if arg_8_2 then
			arg_8_2()
		end

		return
	end)
	self.animator:Play("anim_island_shiporder_complete")

	return
end

function IslandShipOrderCard:SwitchMode(arg_10_1, arg_10_2)
	self.mode = arg_10_2

	self:UpdateStyle(arg_10_1, arg_10_2)

	return
end

function IslandShipOrderCard:UpdateTimer(arg_11_1)
	self:RemoveTimer()

	if arg_11_1:IsSubmited() and not arg_11_1:IsFinished() then
		self:AddTimer(arg_11_1)
	elseif arg_11_1:IsFinished() then
		self:PlayFinishAnimation(true)
	end

	return
end

function IslandShipOrderCard:RemoveTimer()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	return
end

function IslandShipOrderCard:AddTimer(arg_13_1)
	local var_13_0 = arg_13_1:GetEndTime()

	self.timer = Timer.New(function(arg_14_0, arg_14_1, arg_14_2)
		local var_14_0 = var_13_0 - pg.TimeMgr.GetInstance():GetServerTime()

		self.timeTxt.text = pg.TimeMgr.GetInstance():DescCDTime(var_14_0)

		if var_14_0 <= 0 then
			self:RemoveTimer()
			self:PlayFinishAnimation(function()
				self:Flush(arg_13_1, self.mode)

				return
			end)
		end

		return
	end, 1, -1)

	self.timer.func()
	self.timer:Start()

	return
end

function IslandShipOrderCard:UpdateTitle(arg_16_1)
	if arg_16_1:IsWaiting() then
		self.titleTxt.text = i18n("island_order_ship_worktime", pg.TimeMgr.GetInstance():DescCDTime((arg_16_1:GetNeedTime())))
	elseif arg_16_1:IsSubmited() and not arg_16_1:IsFinished() then
		self.titleTxt.text = i18n("island_order_ship_working")
	elseif arg_16_1:IsFinished() then
		self.titleTxt.text = i18n("island_order_ship_end_work")
	end

	return
end

function IslandShipOrderCard:UpdateLockTip(arg_17_1)
	local var_17_0 = arg_17_1:GetUnlockLevel()
	local var_17_1 = arg_17_1:GetUnlockGold()

	self.levelLockTxt.text = i18n("island_order_ship_unlock_tip")
	self.resLockTxt.text = "X" .. var_17_1.count .. i18n("island_order_ship_unlock_tip_2")

	GetImageSpriteFromAtlasAsync("island/" .. pg.island_item_data_template[var_17_1.id].icon, "", self.resImg)

	return
end

function IslandShipOrderCard:UpdateAward(arg_18_1)
	local var_18_0 = arg_18_1:GetOrder():GetAwardList()

	self.uiAwardList:make(function(arg_19_0, arg_19_1, arg_19_2)
		if arg_19_0 == UIItemList.EventUpdate then
			local var_19_0 = Drop.New(var_18_0[arg_19_1 + 1])

			updateCustomDrop(arg_19_2, Drop.New(var_18_0[arg_19_1 + 1]))
			onButton(self.parent, arg_19_2, function()
				self.parent:ShowMsgBox({
					title = i18n("island_word_desc"),
					type = IslandMsgBox.TYPE_COMMON_DROP_DESCRIBE,
					dropData = var_19_0
				})

				return
			end)
		end

		return
	end)
	self.uiAwardList:align(#var_18_0)

	return
end

function IslandShipOrderCard:UpdateRequest(arg_21_1)
	local var_21_0 = arg_21_1:GetOrder():GetConsumeList()

	self.uiRequestList:make(function(arg_22_0, arg_22_1, arg_22_2)
		if arg_22_0 == UIItemList.EventUpdate then
			local var_22_0 = Drop.New(var_21_0[arg_22_1 + 1])

			GetImageSpriteFromAtlasAsync("island/" .. (var_22_0.icon or var_22_0:getConfig("icon")), "", arg_22_2:Find("icon"))

			local var_22_1 = var_22_0.state == 1
			local var_22_2 = var_22_0:getOwnedCount()

			setText(arg_22_2:Find("cnt"), setColorStr(var_22_2 .. "/" .. var_22_0.count, (var_22_2 >= var_22_0.count or var_22_1) and "#39beff" or "#f36c6e"))
			setActive(arg_22_2:Find("finish"), var_22_1)
			setActive(arg_22_2:Find("loaded"), var_22_1)
			setActive(arg_22_2:Find("loaded_1"), false)
			setActive(arg_22_2:Find("enough"), not var_22_1 and var_22_2 >= var_22_0.count)
		end

		return
	end)
	self.uiRequestList:align(#var_21_0)

	return
end

function IslandShipOrderCard:UpdateStyle(arg_23_1, arg_23_2)
	local var_23_0 = arg_23_1:IsLock()
	local var_23_1 = arg_23_1:IsWaiting()
	local var_23_2 = arg_23_1:IsFinished()
	local var_23_3 = arg_23_1:IsSubmited() and not var_23_2
	local var_23_4 = arg_23_1:CanUnlock()
	local var_23_5 = arg_23_1:IsEmpty()
	local var_23_6 = arg_23_2 == IslandShipOrderPage.MODE_REQUEST_VIEW
	local var_23_7 = arg_23_2 == IslandShipOrderPage.MODE_AWARD_VIEW

	setActive(self.loadingTr, var_23_3)
	setActive(self.loadingRequest, var_23_3 and var_23_6)
	setActive(self.loadingAward, var_23_3 and var_23_7)
	setActive(self.finishTr, var_23_2 and not var_23_5)
	setActive(self.request, not var_23_0 and var_23_6 and not var_23_2 and not var_23_5)
	setActive(self.award, (not var_23_0 and var_23_7 or var_23_2) and not var_23_5)
	setActive(self.lockTr, var_23_0)
	setActive(self.normalTr, var_23_1 and var_23_7 and not var_23_5)
	setActive(self.levelLockTr, var_23_0 and not var_23_4)
	setActive(self.resLockTr, var_23_0 and var_23_4)
	setActive(self.titleTr, not var_23_0 and not var_23_5)
	setActive(self.emptyTr, var_23_5 and var_23_1)
	setActive(self.exchangeBtn, not var_23_5 and var_23_1 and var_23_6)
	setActive(self.finishCntTxt.gameObject, not var_23_0)

	self.requestCG.alpha = var_23_3 and 0.6 or 1
	self.titleTr.sizeDelta = var_23_1 and Vector2(360, 39) or Vector2(155, 39)

	self:UpdateBgColor(arg_23_1)
	self:UpdateTitleColor(arg_23_1)

	return
end

function IslandShipOrderCard:RemoveReloadingTimer()
	if self.reloadingTimer then
		self.reloadingTimer:Stop()

		self.reloadingTimer = nil
	end

	return
end

function IslandShipOrderCard:UpdateBgColor(arg_25_1)
	if arg_25_1:IsSubmited() and not arg_25_1:IsFinished() then
		setActive(self.bgTr, false)

		return
	end

	setActive(self.bgTr, true)

	if arg_25_1:IsFinished() then
		self.bgImg.color = var_0_1 or var_0_3
	end

	return
end

function IslandShipOrderCard:UpdateTitleColor(arg_26_1)
	if arg_26_1:IsFinished() then
		self.titleLineImg.color = var_0_1
	elseif arg_26_1:IsSubmited() and not arg_26_1:IsFinished() then
		self.titleLineImg.color = var_0_4
	elseif arg_26_1:IsWaiting() then
		self.titleLineImg.color = var_0_2
	end

	if arg_26_1:IsWaiting() then
		self.titleTxt.color = var_0_2 or var_0_5
	end

	return
end

function IslandShipOrderCard:Dispose()
	self:RemoveTimer()
	self:RemoveReloadingTimer()
	self.aniDft:SetEndEvent(nil)

	return
end

return IslandShipOrderCard
