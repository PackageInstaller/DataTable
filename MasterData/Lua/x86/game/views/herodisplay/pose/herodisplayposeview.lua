local HeroDisplayPoseView = class("HeroDisplayPoseView", ReduxView)

function HeroDisplayPoseView:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()

	self.heroPoseItemList_ = {}
end

function HeroDisplayPoseView:OnEnter(arg_2_1)
	self.heroID_ = arg_2_1

	local var_2_0 = HeroDisplayData:GetHeroPoseList(arg_2_1)

	for iter_2_0 = 1, #var_2_0 do
		self.heroPoseItemList_[iter_2_0] = self.heroPoseItemList_[iter_2_0] or HeroDisplayPoseItem.New(self.goItem_, self.goParent_)

		self.heroPoseItemList_[iter_2_0]:SetData(arg_2_1, iter_2_0)
		self.heroPoseItemList_[iter_2_0]:SetSelect(iter_2_0 == 1)
	end

	for iter_2_1 = #var_2_0 + 1, #self.heroPoseItemList_ do
		self.heroPoseItemList_[iter_2_1]:Show(false)
	end
end

function HeroDisplayPoseView:SetData(arg_3_1)
	for iter_3_0, iter_3_1 in pairs(self.heroPoseItemList_) do
		iter_3_1:SetSelect(iter_3_0 == arg_3_1)
	end
end

function HeroDisplayPoseView:OnExit()
	return
end

function HeroDisplayPoseView:Dispose()
	HeroDisplayPoseView.super.Dispose(self)

	for iter_5_0, iter_5_1 in ipairs(self.heroPoseItemList_) do
		iter_5_1:Dispose()
	end

	self.heroPoseItemList_ = nil
end

function HeroDisplayPoseView:Show(arg_6_1)
	SetActive(self.gameObject_, arg_6_1)

	if arg_6_1 then
		-- block empty
	end
end

return HeroDisplayPoseView
