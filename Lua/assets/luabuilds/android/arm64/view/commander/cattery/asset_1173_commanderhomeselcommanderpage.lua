local CommanderHomeSelCommanderPage = class("CommanderHomeSelCommanderPage", import(".CommanderHomeBaseSelPage"))

function CommanderHomeSelCommanderPage:getUIName()
	return "CommanderHomeSelCommanderPage"
end

function CommanderHomeSelCommanderPage:OnCatteryUpdate(arg_2_1)
	self.cattery = arg_2_1

	self:Update(self.home, arg_2_1)

	return
end

function CommanderHomeSelCommanderPage:OnInit()
	CommanderHomeSelCommanderPage.super.OnInit(self)

	self.selectedID = -1

	onButton(self, self.okBtn, function()
		if self.selectedID >= 0 then
			self:emit(CommanderHomeMediator.ON_SEL_COMMANDER, self.cattery.id, self.selectedID)
		end

		return
	end, SFX_PANEL)

	return
end

function CommanderHomeSelCommanderPage:OnSelected(arg_5_1)
	if arg_5_1.commanderVO then
		local var_5_0, var_5_1 = self:Check(arg_5_1.commanderVO.id)

		if var_5_0 then
			if self.mark then
				setActive(self.mark, false)
			end

			if self.selectedID == arg_5_1.commanderVO.id then
				self.selectedID = 0
				self.mark = nil

				self:emit(CatteryDescPage.CHANGE_COMMANDER, nil)
			else
				setActive(arg_5_1.mark2, true)

				self.mark = arg_5_1.mark2
				self.selectedID = arg_5_1.commanderVO.id

				self:emit(CatteryDescPage.CHANGE_COMMANDER, arg_5_1.commanderVO)
			end
		else
			pg.TipsMgr.GetInstance():ShowTips(var_5_1)
		end
	end

	return
end

function CommanderHomeSelCommanderPage:Check(arg_6_1)
	for iter_6_0, iter_6_1 in ipairs((self.home:GetCatteries())) do
		if iter_6_1:GetCommanderId() == arg_6_1 and iter_6_1.id ~= self.cattery.id then
			local var_6_1 = i18n("commander_is_in_cattery")

			return
		end
	end

	return true
end

function CommanderHomeSelCommanderPage:CheckIncludeSelf(arg_7_1)
	for iter_7_0, iter_7_1 in ipairs((self.home:GetCatteries())) do
		if iter_7_1:GetCommanderId() == arg_7_1 then
			return false
		end
	end

	return true
end

function CommanderHomeSelCommanderPage:OnUpdateItem(arg_8_1, arg_8_2)
	CommanderHomeSelCommanderPage.super.OnUpdateItem(self, arg_8_1, arg_8_2)

	local var_8_0 = self.displays[arg_8_1 + 1]
	local var_8_1 = self.cards[arg_8_2]

	if self.displays[arg_8_1 + 1] then
		local var_8_2 = self.selectedID == var_8_0.id

		setActive(var_8_1.mark2, self.selectedID == var_8_0.id)

		if var_8_2 then
			self.mark = var_8_1.mark2
		end

		setActive(var_8_1._tf:Find("info/home"), not self:CheckIncludeSelf(var_8_0.id))
	end

	return
end

function CommanderHomeSelCommanderPage:Update(arg_9_1, arg_9_2)
	self:Show()

	self.home = arg_9_1
	self.cattery = arg_9_2

	local var_9_0 = arg_9_2:GetCommanderId()

	if var_9_0 ~= 0 then
		self.selectedID = var_9_0
	end

	CommanderHomeSelCommanderPage.super.Update(self)

	return
end

function CommanderHomeSelCommanderPage:Hide()
	CommanderHomeSelCommanderPage.super.Hide(self)

	self.selectedID = -1
	self.mark = nil

	return
end

return CommanderHomeSelCommanderPage
