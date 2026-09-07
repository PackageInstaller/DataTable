local PSSHei5AwardPage = class("PSSHei5AwardPage", import("view.base.BaseSubView"))

function PSSHei5AwardPage:getUIName()
	return "PSSHei5AwardPage"
end

function PSSHei5AwardPage:UpdateActivity(arg_2_1)
	self.activity = arg_2_1 or getProxy(ActivityProxy):getAliveActivityByType(ActivityConst.ACTIVITY_TYPE_PT_HEI5)

	for iter_2_0, iter_2_1 in pairs(self.activity:GetHei5Info()) do
		self[iter_2_0] = iter_2_1
	end

	return
end

function PSSHei5AwardPage:initTplVar()
	self.btnAllTip = "blackfriday_cruise_btn_all"

	return
end

function PSSHei5AwardPage:OnLoaded()
	self:initTplVar()
	self:UpdateActivity()

	local var_4_0 = self._tf:Find("frame")

	self.nextAwardTF = var_4_0:Find("next")
	self.btnAll = var_4_0:Find("btns/btn_all")

	setText(self.btnAll:Find("Text"), i18n(self.btnAllTip))

	self.scrollCom = GetComponent(var_4_0:Find("view/content"), "LScrollRect")

	function self.scrollCom.onUpdateItem(arg_5_0, arg_5_1)
		self:UpdateAwardInfo(arg_5_0, tf(arg_5_1), self.awardList[arg_5_0 + 1])

		return
	end

	return
end

function PSSHei5AwardPage:OnInit()
	onButton(self, self.btnAll, function()
		self:GetAllAward()

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

function PSSHei5AwardPage:Flush(arg_9_1)
	self:Show()

	if arg_9_1 then
		self:UpdateActivity(arg_9_1)
	end

	self.scrollCom:SetTotalCount(#self.awardList)
	self:BuildPhaseAwardScrollPos()

	self.nextAwardIndex = nil

	local var_9_0 = #self.activity:GetHei5UnreceiveAward() > 0

	setGray(self.btnAll, not var_9_0)
	setTextColor(self.btnAll:Find("Text"), var_9_0 and Color.NewHex("#ffffff") or Color.NewHex("#7df39f"))
	setButtonEnabled(self.btnAll, var_9_0)
	self:UpdateNextAward(self.scrollCom.value)

	return
end

function PSSHei5AwardPage:BuildPhaseAwardScrollPos()
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

function PSSHei5AwardPage:IsSpecialMask(arg_11_1)
	return arg_11_1 == DROP_TYPE_COMBAT_UI_STYLE or arg_11_1 == DROP_TYPE_SKIN or arg_11_1 == DROP_TYPE_EQUIPMENT_SKIN
end

function PSSHei5AwardPage:UpdateAwardInfo(arg_12_1, arg_12_2, arg_12_3)
	if arg_12_3.id < 10 then
		setText(arg_12_2:Find("Text"), "0" .. arg_12_3.id)
	else
		setText(arg_12_2:Find("Text"), arg_12_3.id)
	end

	local var_12_0 = arg_12_3.pt <= self.pt
	local var_12_1 = Drop.Create(arg_12_3.award)

	var_12_1.desc = cancelColorRich(var_12_1.desc)

	onButton(self, arg_12_2:Find("base"), function()
		self:emit(BaseUI.ON_NEW_STYLE_DROP, {
			drop = var_12_1
		})

		return
	end, SFX_CONFIRM)
	setActive(arg_12_2:Find("base/lock"), not var_12_0)
	updateDrop(arg_12_2:Find("base/mask/IconTpl"), var_12_1)
	setActive(arg_12_2:Find("base/get"), var_12_0 and not self.awardDic[arg_12_3.pt])
	setActive(arg_12_2:Find("base/got"), self.awardDic[arg_12_3.pt])

	local var_12_2 = Drop.Create(arg_12_3.award_pay)

	onButton(self, arg_12_2:Find("pay"), function()
		self:emit(BaseUI.ON_NEW_STYLE_DROP, {
			drop = var_12_2
		})

		return
	end, SFX_CONFIRM)
	updateDrop(arg_12_2:Find("pay/mask/IconTpl"), var_12_2)
	setActive(arg_12_2:Find("pay/no_pay"), not self.isPay and not self:IsSpecialMask(var_12_2.type))
	setActive(arg_12_2:Find("pay/get"), self.isPay and var_12_0 and not self.awardPayDic[arg_12_3.pt])
	setActive(arg_12_2:Find("pay/got"), self.awardPayDic[arg_12_3.pt])

	return
end

function PSSHei5AwardPage:UpdateNextAward(arg_15_1)
	if not self.nextPhasePos then
		return
	end

	local var_15_0 = self.nextPhasePos[#self.nextPhasePos] - 1
	local var_15_1 = #self.awardList

	for iter_15_0 = #self.awardList - 1, 1, -1 do
		if self.nextPhasePos[iter_15_0] < arg_15_1 + var_15_0 or self.awardList[iter_15_0].pt <= self.pt then
			break
		elseif self.awardList[iter_15_0].isImportent then
			var_15_1 = iter_15_0
		end
	end

	self:UpdateAwardInfo(self.nextAwardIndex, self.nextAwardTF, self.awardList[var_15_1])

	return
end

function PSSHei5AwardPage:GetAllAward()
	local var_16_0 = self.activity:GetHei5UnreceiveAward()

	if #var_16_0 > 0 then
		local var_16_1 = {}

		if self:CheckLimitMax(var_16_0) then
			table.insert(var_16_1, function(arg_17_0)
				pg.NewStyleMsgboxMgr.GetInstance():Show(pg.NewStyleMsgboxMgr.TYPE_COMMON_MSGBOX, {
					contentText = i18n("player_expResource_mail_fullBag"),
					onConfirm = arg_17_0
				})

				return
			end)
		end

		seriesAsync(var_16_1, function()
			self:emit(PSSHei5Mediator.EVENT_GET_AWARD_ALL)

			return
		end)
	end

	return
end

function PSSHei5AwardPage:CheckLimitMax(arg_19_1)
	local var_19_0 = getProxy(PlayerProxy):getData()

	for iter_19_0, iter_19_1 in ipairs(arg_19_1) do
		if iter_19_1.type == DROP_TYPE_RESOURCE then
			if iter_19_1.id == 1 then
				if var_19_0:GoldMax(iter_19_1.count) then
					pg.TipsMgr.GetInstance():ShowTips(i18n("gold_max_tip_title"))

					return true
				end
			elseif iter_19_1.id == 2 and var_19_0:OilMax(iter_19_1.count) then
				pg.TipsMgr.GetInstance():ShowTips(i18n("oil_max_tip_title"))

				return true
			end
		elseif iter_19_1.type == DROP_TYPE_ITEM then
			local var_19_1 = Item.getConfigData(iter_19_1.id)

			if var_19_1.type == Item.EXP_BOOK_TYPE then
				if getProxy(BagProxy):getItemCountById(iter_19_1.id) + iter_19_1.count > var_19_1.max_num then
					return true
				end
			end
		end
	end

	return false
end

function PSSHei5AwardPage:OnDestroy()
	return
end

return PSSHei5AwardPage
