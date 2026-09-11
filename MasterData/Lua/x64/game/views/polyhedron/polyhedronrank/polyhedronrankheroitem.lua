local PolyhedronRankHeroItem = class("PolyhedronRankHeroItem", ReduxView)

function PolyhedronRankHeroItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:initUI()
end

function PolyhedronRankHeroItem:initUI()
	self:BindCfgUI()
	self:AddListeners()

	self.selectController_ = ControllerUtil.GetController(self.transform_, "select")
end

function PolyhedronRankHeroItem:AddListeners()
	self:AddBtnListener(self.btn_, nil, function()
		if self.clickHandler_ then
			self.clickHandler_(self.heroID_)
		end
	end)
end

function PolyhedronRankHeroItem:SetData(arg_5_1)
	self.heroID_ = arg_5_1

	local var_5_0 = RankData:GetCommonRank(RankConst.RANK_ID.POLYHERON, arg_5_1)

	if var_5_0 and var_5_0.curRank then
		self.scoreText_.text = (var_5_0 and var_5_0.curRank).score or 0
	end

	self.nameText_.text = GetI18NText(HeroCfg[self.heroID_].name)
	self.portraitImg_.sprite = getSpriteViaConfig("HeroLittleIcon", PolyhedronData:GetHeroUsingSkinInfo(self.heroID_).id)
end

function PolyhedronRankHeroItem:SetSelect(arg_6_1)
	if arg_6_1 == self.heroID_ then
		self.selectController_:SetSelectedState("true")
	else
		self.selectController_:SetSelectedState("false")
	end
end

function PolyhedronRankHeroItem:SetClickHandler(arg_7_1)
	self.clickHandler_ = arg_7_1
end

return PolyhedronRankHeroItem
