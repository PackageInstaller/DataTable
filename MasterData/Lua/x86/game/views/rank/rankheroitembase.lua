local RankHeroItemBase = class("RankHeroItemBase", ReduxView)

function RankHeroItemBase:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:initUI()
end

function RankHeroItemBase:initUI()
	self:BindCfgUI()
	self:AddListeners()

	self.selectController_ = ControllerUtil.GetController(self.transform_, "select")
end

function RankHeroItemBase:AddListeners()
	self:AddBtnListener(self.btn_, nil, function()
		if self.clickHandler_ then
			self.clickHandler_(self.heroID_)
		end
	end)
end

function RankHeroItemBase:SetData(arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	self.heroID_ = arg_5_1

	local var_5_0 = RankData:GetActivityRank(arg_5_2, arg_5_4)

	if var_5_0 and var_5_0.curRank then
		self.scoreText_.text = (var_5_0 and var_5_0.curRank).score or 0
	end

	self.nameText_.text = HeroCfg[self.heroID_].name
	self.portraitImg_.sprite = getSpriteViaConfig("HeroLittleIcon", arg_5_3)
end

function RankHeroItemBase:SetSelect(arg_6_1)
	if arg_6_1 == self.heroID_ then
		self.selectController_:SetSelectedState("true")
	else
		self.selectController_:SetSelectedState("false")
	end
end

function RankHeroItemBase:SetClickHandler(arg_7_1)
	self.clickHandler_ = arg_7_1
end

function RankHeroItemBase:Dispose()
	RankHeroItemBase.super.Dispose(self)
end

return RankHeroItemBase
