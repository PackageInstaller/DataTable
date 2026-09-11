local MoonFillingItem = class("MoonFillingItem", ReduxView)

function MoonFillingItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:InitUI()
	self:AddListeners()
end

function MoonFillingItem:InitUI()
	self:BindCfgUI()

	self.selecteController_ = ControllerUtil.GetController(self.transform_, "select")
	self.typeController_ = ControllerUtil.GetController(self.transform_, "type")
	self.makeTimesController_ = ControllerUtil.GetController(self.transform_, "makeTimes")
end

function MoonFillingItem:AddListeners()
	self:AddBtnListener(self.btn_, nil, function()
		if self.clickHandler_ then
			self.clickHandler_(self.ID_)
		end
	end)
end

function MoonFillingItem:Dispose()
	MoonFillingItem.super.Dispose(self)
end

function MoonFillingItem:SetData(arg_6_1)
	self.ID_ = arg_6_1

	self:RefrehsUI()
end

function MoonFillingItem:RefrehsUI()
	self.icon_.sprite = ItemTools.getItemSprite(MoonCakeFillingCfg[self.ID_].patties)
	self.nameText_.text = ItemTools.getItemName(MoonCakeFillingCfg[self.ID_].patties)
end

function MoonFillingItem:SetType(arg_8_1)
	self.type_ = arg_8_1

	self.typeController_:SetSelectedIndex(self.type_)

	if self.type_ == MoonCakeConst.FILLING_ITEM_TYPE.FILLING_MAKE then
		self.maxTimes_ = MoonCakeTools.GetFillingMultiTimes(self.ID_)
		self.timesText_.text = self.maxTimes_ > 0 and string.format(GetTips("%d", self.maxTimes_)) or GetTips("NOT_ENOUGH")

		self.makeTimesController_:SetSelectedState(self.maxTimes_ and "true" or "false")
	end
end

function MoonFillingItem:SetSelect(arg_9_1)
	self.selecteController_:SetSelectedState(self.ID_ == arg_9_1 and "true" or "false")
end

function MoonFillingItem:SetClickHandler(arg_10_1)
	self.clickHandler_ = arg_10_1
end

return MoonFillingItem
