local SimBusinessGuestInfoItem = class("SimBusinessGuestInfoItem", ReduxView)

function SimBusinessGuestInfoItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitUI()
end

function SimBusinessGuestInfoItem:InitUI()
	self:BindCfgUI()

	self.statusController = self.controllers_:GetController("status")
	self.selectController = self.controllers_:GetController("select")
	self.hpBarController = self.controllers_:GetController("showHp")
	self.typeController = self.controllers_:GetController("category")
	self.specialController = self.controllers_:GetController("special")

	self:AddUIListener()
	self:RegisterEvents()
end

function SimBusinessGuestInfoItem:AddUIListener()
	self:AddBtnListener(self.btn_, nil, function()
		if self.clickFunc then
			self:clickFunc()
		end
	end)
end

function SimBusinessGuestInfoItem:RegisterEvents()
	self:RegistEventListener("SIM_BUSINESS_GUEST_HP_CHANGE", handler(self, self.OnSetHp))
end

local function var_0_1(arg_6_0, arg_6_1)
	if not arg_6_1 then
		return 0, 0
	end

	local var_6_0
	local var_6_1

	if arg_6_0.eid and Dorm.DormEntityManager.IsValidEntityID(arg_6_0.eid) then
		local var_6_2 = DormUtils.GetEntityData(arg_6_0.eid)

		var_6_1 = var_6_2.max
		var_6_0 = var_6_2.hp
	else
		var_6_1 = arg_6_0.max
		var_6_0 = arg_6_0.remain
	end

	local var_6_3 = math.max(var_6_0, 0)

	var_6_1 = var_6_1 or var_6_3

	return var_6_3, var_6_1
end

function SimBusinessGuestInfoItem:HideIfHpBarEmpty(arg_7_1, arg_7_2)
	self.hideEmptyBar = arg_7_1

	if not arg_7_2 then
		return
	end

	if self.showHp then
		if arg_7_1 then
			self.hpBarController:SetSelectedState(self.bar_.fillAmount == 0 and "normal" or "none")
		else
			self.hpBarController:SetSelectedState("normal")
		end
	else
		self.hpBarController:SetSelectedState("none")
	end
end

function SimBusinessGuestInfoItem:RefreshData(arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5)
	self.focus = arg_8_1
	self.guestID = arg_8_1.id
	self.index = arg_8_2

	local var_8_0 = SimBusinessGuestCfg[arg_8_1.id]

	self.icon_.sprite = SimBusinessTools.GetClientIcon(arg_8_1.id)

	self.specialController:SetSelectedState(var_8_0.special_effect and var_8_0.special_effect ~= 0 and "true" or "false")
	self.typeController:SetSelectedState(tostring(var_8_0.love_type))
	self:SetSelected(arg_8_3)

	local var_8_1, var_8_2 = var_0_1(arg_8_1, arg_8_4)

	self:SetHpBar(arg_8_4, arg_8_5, var_8_1, var_8_2)

	if self.statusController then
		self.statusController:SetSelectedState(var_8_1 == 0 and "happy" or "sad")
	end
end

function SimBusinessGuestInfoItem:SetSelected(arg_9_1)
	self.selectController:SetSelectedState(arg_9_1 and "true" or "false")
end

function SimBusinessGuestInfoItem:SetHpBar(arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	self.showHp, self.reverseHpBarFill = arg_10_1, arg_10_2

	if arg_10_1 then
		if arg_10_2 then
			arg_10_3 = arg_10_4 - arg_10_3
		end

		if arg_10_4 ~= 0 then
			self.bar_.fillAmount = arg_10_3 / arg_10_4
		end

		self.progressText_.text = arg_10_3
	end

	if self.hideEmptyBar and self.bar_.fillAmount == 0 then
		arg_10_1 = false
	end

	self.hpBarController:SetSelectedState(arg_10_1 and "normal" or "none")
end

function SimBusinessGuestInfoItem:OnSetHp(arg_11_1)
	if arg_11_1 == nullable(self.focus, "eid") then
		self:SetHpBar(self.showHp, self.reverseHpBarFill, var_0_1({
			eid = arg_11_1
		}, self.showHp))
	end
end

function SimBusinessGuestInfoItem:RegisterClickFunc(arg_12_1)
	self.clickFunc = arg_12_1
end

function SimBusinessGuestInfoItem:SetNewRedpoint(arg_13_1)
	manager.redPoint:SetRedPointIndependent(self.transform_, arg_13_1, nil, RedPointStyle.SHOW_NEW_TAG)
end

return SimBusinessGuestInfoItem
