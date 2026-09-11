local BilliardGameIlluItemView = class("BilliardGameIlluItemView", ReduxView)

function BilliardGameIlluItemView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function BilliardGameIlluItemView:Init()
	self:InitUI()
	self:AddUIListener()
end

function BilliardGameIlluItemView:InitUI()
	self:BindCfgUI()

	self.statusController_ = self.exController_:GetController("status")
	self.selectController_ = self.exController_:GetController("select")
end

function BilliardGameIlluItemView:RefreshUI(arg_4_1, arg_4_2)
	self.index_ = arg_4_1
	self.active_ = arg_4_2.active
	self.id_ = arg_4_2.id
	self.select_ = arg_4_2.select
	self.viewState_ = arg_4_2.viewState

	local var_4_0 = string.format("%s_%s", RedPointConst.SUMMER_PUB_ILLUSTRATION, arg_4_2.id)

	manager.redPoint:bindUIandKey(self.transform_:GetChild(0).gameObject.transform, var_4_0)

	if self.active_ then
		self.titleIcon_.sprite = pureGetSpriteWithoutAtlas(BilliardIllustrationsCfg[self.id_].little_icon)
		self.nameText_.text = GetI18NText(BilliardIllustrationsCfg[self.id_].name)

		self.statusController_:SetSelectedIndex(1)
	else
		self.nameText_.text = GetI18NText("???")

		self.statusController_:SetSelectedIndex(0)
	end

	if self.select_ then
		self.selectController_:SetSelectedState("select")
	else
		self.selectController_:SetSelectedState("unselect")
	end

	if self.viewState_ == 1 then
		manager.redPoint:setTip(var_4_0, 1)
	else
		manager.redPoint:setTip(var_4_0, 0)
	end
end

function BilliardGameIlluItemView:AddUIListener()
	self:AddBtnListener(self.itemBtn_, nil, function()
		if self.func_ then
			self.func_(self.index_)
		end
	end)
end

function BilliardGameIlluItemView:RegisterBtnListener(arg_7_1)
	self.func_ = arg_7_1
end

function BilliardGameIlluItemView:Dispose()
	BilliardGameIlluItemView.super.Dispose(self)
end

function BilliardGameIlluItemView:ShowSelect(arg_9_1)
	self.select_ = arg_9_1

	if self.select_ then
		self.selectController_:SetSelectedState("select")

		self.viewState_ = 2

		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.SUMMER_PUB_ILLUSTRATION, self.id_), 0)
	else
		self.selectController_:SetSelectedState("unselect")
	end
end

return BilliardGameIlluItemView
