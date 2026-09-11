local HodurSelectEventItem = class("HodurSelectEventItem", ReduxView)

function HodurSelectEventItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitUI()
	self:AddUIListener()
end

function HodurSelectEventItem:InitUI()
	self:BindCfgUI()

	self.obtainController_ = self.mainControllerEx_:GetController("obtain")
	self.selectController_ = self.mainControllerEx_:GetController("select")
end

function HodurSelectEventItem:AddUIListener()
	self:AddBtnListener(self.selfBtn_, nil, function()
		self.onClickHandler_(self.optionID_)
	end)
end

function HodurSelectEventItem:SetData(arg_5_1, arg_5_2, arg_5_3)
	self.optionID_ = arg_5_1
	self.eventID_ = arg_5_2
	self.chapterID_ = arg_5_3

	self:RefreshUI()
end

function HodurSelectEventItem:SetClickHandler(arg_6_1)
	self.onClickHandler_ = arg_6_1
end

function HodurSelectEventItem:SetSelected(arg_7_1)
	self.selected_ = arg_7_1

	self:RefreshUI()
end

function HodurSelectEventItem:SetComplete(arg_8_1)
	self.isCompleted_ = arg_8_1

	self:RefreshUI()
end

function HodurSelectEventItem:RefreshUI()
	self.selectController_:SetSelectedState(self.selected_ and "on" or "off")

	self.nameText_.text = ActivityHodurEventOptionCfg[self.optionID_].option_title
	self.descText_.text = ActivityHodurEventOptionCfg[self.optionID_].option_desc
	self.affixText_.text = ActivityHodurEventOptionCfg[self.optionID_].ending_desc
	self.affixdescText_.text = AffixTypeCfg[tonumber(ActivityHodurEventOptionCfg[self.optionID_].buff_id)].name

	if self.isCompleted_ then
		self.obtainController_:SetSelectedState("obtain")

		local var_9_0, var_9_1 = HodurTools.GetEventComplete(self.eventID_, self.chapterID_)

		if var_9_1 == self.optionID_ then
			self:Show(true)
		else
			self:Show(false)
		end
	else
		self:Show(true)
		self.obtainController_:SetSelectedState("event")
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(self.eventTrs_)
	LayoutRebuilder.ForceRebuildLayoutImmediate(self.eventTrs_)
end

function HodurSelectEventItem:Show(arg_10_1)
	SetActive(self.gameObject_, arg_10_1)

	if arg_10_1 then
		LayoutRebuilder.ForceRebuildLayoutImmediate(self.eventTrs_)
		LayoutRebuilder.ForceRebuildLayoutImmediate(self.eventTrs_)
	end
end

function HodurSelectEventItem:Dispose()
	HodurSelectEventItem.super.Dispose(self)
end

return HodurSelectEventItem
