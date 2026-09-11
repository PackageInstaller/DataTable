local MoonFillingMenuItem = class("MoonFillingMenuItem", ReduxView)

function MoonFillingMenuItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:InitUI()
	self:AddListeners()
end

function MoonFillingMenuItem:InitUI()
	self:BindCfgUI()

	self.selecteController_ = ControllerUtil.GetController(self.transform_, "select")
	self.materialList_ = {}
	self.fillingItem_ = MoonCakeItem.New(self.fillingItemGo_)
end

function MoonFillingMenuItem:AddListeners()
	self:AddBtnListener(self.btn_, nil, function()
		if not ActivityData:GetActivityIsOpen(self.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		if self.maxTimes_ <= 0 then
			ShowTips("MID_AUTUMN_FESTIVAL_FILLING_MAKING_INSUFFICIENT_RAW_MATERIALS")

			return
		end

		if self.chooseHandler_ then
			self.chooseHandler_(self.fillingID_)
		end
	end)
end

function MoonFillingMenuItem:Dispose()
	for iter_5_0, iter_5_1 in ipairs(self.materialList_) do
		iter_5_1:Dispose()
	end

	self.materialList_ = nil

	self.fillingItem_:Dispose()

	self.fillingItem_ = nil

	MoonFillingMenuItem.super.Dispose(self)
end

function MoonFillingMenuItem:SetData(arg_6_1, arg_6_2)
	self.activityID_ = arg_6_2
	self.fillingID_ = arg_6_1

	self:RefreshUI()
end

function MoonFillingMenuItem:RefreshUI()
	self.fillingItem_:SetData(MoonCakeFillingCfg[self.fillingID_].patties)
	self.fillingItem_:SetType(MoonCakeConst.ITEM_STYLE.MAKE)

	self.maxTimes_ = MoonCakeTools.GetFillingMultiTimes(self.fillingID_)

	if self.maxTimes_ > 0 then
		self.fillingItem_:SetMakeTimes(self.maxTimes_)
	end

	self.fillingItem_:SetEnough(self.maxTimes_ > 0)
	self:RefreshMaterial()
end

function MoonFillingMenuItem:RefreshMaterial()
	for iter_8_0, iter_8_1 in ipairs(MoonCakeFillingCfg[self.fillingID_].recipe) do
		self.materialList_[iter_8_0] = self.materialList_[iter_8_0] or MoonCakeItem.New((Object.Instantiate(self.materialGo_, self.materialContentTrans_)))

		local var_8_0 = ItemTools.getItemNum(iter_8_1[1])

		self.materialList_[iter_8_0]:SetData(iter_8_1[1])
		self.materialList_[iter_8_0]:SetEnough(var_8_0 >= iter_8_1[2])
	end

	for iter_8_2 = #MoonCakeFillingCfg[self.fillingID_].recipe + 1, #self.materialList_ do
		self.materialList_[iter_8_2]:SetActive(false)
	end
end

function MoonFillingMenuItem:SetSelect(arg_9_1)
	self.selecteController_:SetSelectedState(self.ID_ == arg_9_1 and "true" or "false")
end

function MoonFillingMenuItem:SetChooseHandler(arg_10_1)
	self.chooseHandler_ = arg_10_1
end

return MoonFillingMenuItem
