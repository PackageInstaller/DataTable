local WorldCruiseAwardPage = class("WorldCruiseAwardPage", import("view.base.BaseSubView"))

function WorldCruiseAwardPage:getUIName()
	return "WorldCruiseAwardPage"
end

function WorldCruiseAwardPage:UpdateActivity(arg_2_1)
	self.activity = arg_2_1 or getProxy(ActivityProxy):getAliveActivityByType(ActivityConst.ACTIVITY_TYPE_PT_CRUSING)

	for iter_2_0, iter_2_1 in pairs(self.activity:GetCrusingInfo()) do
		self[iter_2_0] = iter_2_1
	end

	return
end

function WorldCruiseAwardPage:OnLoaded()
	self:UpdateActivity()

	local var_3_0 = self._tf:Find("frame")

	self.nextAwardTF = var_3_0:Find("next")
	self.btnAll = var_3_0:Find("btns/btn_all")

	setText(self.btnAll:Find("Text"), i18n("cruise_btn_all"))

	self.btnPay = var_3_0:Find("btns/btn_pay")

	setText(self.btnPay:Find("Text"), i18n("cruise_btn_pay"))

	self.scrollCom = GetComponent(var_3_0:Find("view/content"), "LScrollRect")

	function self.scrollCom.onUpdateItem(arg_4_0, arg_4_1)
		self:UpdateAwardInfo(arg_4_0, tf(arg_4_1), self.awardList[arg_4_0 + 1])

		return
	end

	return
end

function WorldCruiseAwardPage:OnInit()
	onButton(self, self.btnAll, function()
		self:GetAllAward()

		return
	end, SFX_CONFIRM)
	onButton(self, self.btnPay, function()
		self.contextData.windowForCharge:ExecuteAction("ShowBuyWindow")

		return
	end, SFX_CONFIRM)
	self.scrollCom.onValueChanged:RemoveAllListeners()
	pg.DelegateInfo.Add(self, self.scrollCom.onValueChanged)
	self.scrollCom.onValueChanged:AddListener(function(arg_8_0)
		self:UpdateNextAward(arg_8_0.x)

		return
	end)

	return
end

function WorldCruiseAwardPage:Flush(arg_9_1)
	self:Show()

	if arg_9_1 then
		self:UpdateActivity(arg_9_1)
	end

	self.scrollCom:SetTotalCount(#self.awardList - 1)
	self:BuildPhaseAwardScrollPos()

	if self.phase == 0 then
		self.scrollCom:ScrollTo(0)
	elseif self.phase == #self.awardList then
		self.scrollCom:ScrollTo(1)
	else
		self.scrollCom:ScrollTo(math.clamp(self.phasePos[self.phase], 0, 1), true)
	end

	self.nextAwardIndex = nil

	setActive(self.btnAll, #self.activity:GetCrusingUnreceiveAward() > 0)
	setActive(self.btnPay, not self.isPay)

	if not self.isPay then
		if not pg.TimeMgr.GetInstance():inTime(pg.pay_data_display[WorldCruiseChargePage.GetPassID()].time) then
			setActive(self.btnPay, false)
		end
	end

	self:UpdateNextAward(self.scrollCom.value)

	return
end

function WorldCruiseAwardPage:BuildPhaseAwardScrollPos()
	if self.phasePos then
		return
	end

	self.phasePos = {}
	self.nextPhasePos = {}

	local var_10_0 = self.scrollCom:HeadIndexToValue(#self.awardList) - self.scrollCom:HeadIndexToValue(0)
	local var_10_1 = self.scrollCom:HeadIndexToValue(#self.awardList - 6) - self.scrollCom:HeadIndexToValue(0)

	for iter_10_0 = 1, #self.awardList - 1 do
		table.insert(self.phasePos, self.scrollCom:HeadIndexToValue(iter_10_0 - 1) / var_10_0)
		table.insert(self.nextPhasePos, self.scrollCom:HeadIndexToValue(iter_10_0 - 1) / var_10_1)
	end

	return
end

function WorldCruiseAwardPage:IsSpecialMask(arg_11_1)
	return arg_11_1 == DROP_TYPE_COMBAT_UI_STYLE or arg_11_1 == DROP_TYPE_SKIN or arg_11_1 == DROP_TYPE_EQUIPMENT_SKIN
end

function WorldCruiseAwardPage:IsSkinFrame(arg_12_1)
	return arg_12_1 == DROP_TYPE_SKIN or arg_12_1 == DROP_TYPE_EQUIPMENT_SKIN
end

function WorldCruiseAwardPage:IsBattleUIFrame(arg_13_1)
	return arg_13_1 == DROP_TYPE_COMBAT_UI_STYLE
end

function WorldCruiseAwardPage:UpdateAwardInfo(arg_14_1, arg_14_2, arg_14_3)
	if arg_14_2:Find("bg_cur") then
		setActive(arg_14_2:Find("bg_cur"), arg_14_1 + 2 == self.phase)
	end

	setText(arg_14_2:Find("Text"), arg_14_3.id)

	local var_14_0 = arg_14_3.pt <= self.pt
	local var_14_1 = Drop.Create(arg_14_3.award)

	onButton(self, arg_14_2:Find("base"), function()
		self:emit(BaseUI.ON_NEW_STYLE_DROP, {
			drop = var_14_1
		})

		return
	end, SFX_CONFIRM)
	updateDrop(arg_14_2:Find("base/mask/IconTpl"), var_14_1)
	setActive(arg_14_2:Find("base/frame_skin"), self:IsSkinFrame(var_14_1.type))
	setActive(arg_14_2:Find("base/frame_ui"), self:IsBattleUIFrame(var_14_1.type))
	setActive(arg_14_2:Find("base/lock"), not var_14_0)
	setActive(arg_14_2:Find("base/get"), var_14_0 and not self.awardDic[arg_14_3.pt])
	setActive(arg_14_2:Find("base/got"), self.awardDic[arg_14_3.pt] and not self:IsSpecialMask(var_14_1.type))
	setActive(arg_14_2:Find("base/got_frame"), self.awardDic[arg_14_3.pt] and self:IsSpecialMask(var_14_1.type))

	local var_14_2 = Drop.Create(arg_14_3.award_pay)

	onButton(self, arg_14_2:Find("pay"), function()
		self:emit(BaseUI.ON_NEW_STYLE_DROP, {
			drop = var_14_2
		})

		return
	end, SFX_CONFIRM)
	updateDrop(arg_14_2:Find("pay/mask/IconTpl"), var_14_2)
	setActive(arg_14_2:Find("pay/frame_skin"), self:IsSkinFrame(var_14_2.type))
	setActive(arg_14_2:Find("pay/frame_ui"), self:IsBattleUIFrame(var_14_2.type))
	setActive(arg_14_2:Find("pay/no_pay"), not self.isPay and not self:IsSpecialMask(var_14_2.type))
	setActive(arg_14_2:Find("pay/no_pay_frame"), not self.isPay and self:IsSpecialMask(var_14_2.type))
	setActive(arg_14_2:Find("pay/lock"), not var_14_0 or not self.isPay)
	setActive(arg_14_2:Find("pay/get"), self.isPay and var_14_0 and not self.awardPayDic[arg_14_3.pt])
	setActive(arg_14_2:Find("pay/got"), self.awardPayDic[arg_14_3.pt] and not self:IsSpecialMask(var_14_2.type))
	setActive(arg_14_2:Find("pay/got_frame"), self.awardPayDic[arg_14_3.pt] and self:IsSpecialMask(var_14_2.type))

	return
end

function WorldCruiseAwardPage:UpdateNextAward(arg_17_1)
	if not self.nextPhasePos then
		return
	end

	local var_17_0 = self.nextPhasePos[#self.nextPhasePos] - 1
	local var_17_1 = #self.awardList

	for iter_17_0 = #self.awardList - 1, 1, -1 do
		if self.nextPhasePos[iter_17_0] < arg_17_1 + var_17_0 or self.awardList[iter_17_0].pt <= self.pt then
			break
		elseif self.awardList[iter_17_0].isImportent then
			var_17_1 = iter_17_0
		end
	end

	if self.nextAwardIndex ~= var_17_1 then
		self.nextAwardIndex = var_17_1

		self:UpdateAwardInfo(self.nextAwardIndex, self.nextAwardTF, self.awardList[var_17_1])
	end

	return
end

function WorldCruiseAwardPage:GetAllAward()
	local var_18_0 = self.activity:GetCrusingUnreceiveAward()

	if #var_18_0 > 0 then
		local var_18_1 = {}

		if self:CheckLimitMax(var_18_0) then
			table.insert(var_18_1, function(arg_19_0)
				pg.NewStyleMsgboxMgr.GetInstance():Show(pg.NewStyleMsgboxMgr.TYPE_COMMON_MSGBOX, {
					contentText = i18n("player_expResource_mail_fullBag"),
					onConfirm = arg_19_0
				})

				return
			end)
		end

		seriesAsync(var_18_1, function()
			self:emit(WorldCruiseMediator.EVENT_GET_AWARD_ALL)

			return
		end)
	end

	return
end

function WorldCruiseAwardPage:CheckLimitMax(arg_21_1)
	local var_21_0 = getProxy(PlayerProxy):getData()

	for iter_21_0, iter_21_1 in ipairs(arg_21_1) do
		if iter_21_1.type == DROP_TYPE_RESOURCE then
			if iter_21_1.id == 1 then
				if var_21_0:GoldMax(iter_21_1.count) then
					pg.TipsMgr.GetInstance():ShowTips(i18n("gold_max_tip_title"))

					return true
				end
			elseif iter_21_1.id == 2 and var_21_0:OilMax(iter_21_1.count) then
				pg.TipsMgr.GetInstance():ShowTips(i18n("oil_max_tip_title"))

				return true
			end
		elseif iter_21_1.type == DROP_TYPE_ITEM then
			local var_21_1 = Item.getConfigData(iter_21_1.id)

			if var_21_1.type == Item.EXP_BOOK_TYPE then
				if getProxy(BagProxy):getItemCountById(iter_21_1.id) + iter_21_1.count > var_21_1.max_num then
					return true
				end
			end
		end
	end

	return false
end

function WorldCruiseAwardPage:OnDestroy()
	return
end

return WorldCruiseAwardPage
