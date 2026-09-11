local BattleSkinBtnView = class("BattleSkinBtnView", ReduxView)

function BattleSkinBtnView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function BattleSkinBtnView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function BattleSkinBtnView:InitUI()
	self:BindCfgUI()

	self.stateController_ = self.conEx_:GetController("select")
end

function BattleSkinBtnView:AddUIListeners()
	self:AddBtnListener(self.btn_, nil, function()
		if self.callBack_ then
			self.callBack_(self.heroID_)
		end

		if self.usingBattleSkin_ and self.usingBattleSkin_ == self.skinID_ then
			HeroAction.ChangeBattleSkin(self.heroID_, 0, function()
				self:RefreshUI(self.heroID_, self.skinID_)
				ShowTips("HERO_SKIN_BATTLE_CANCEL")
			end)
		else
			HeroAction.ChangeBattleSkin(self.heroID_, self.skinID_, function()
				self:RefreshUI(self.heroID_, self.skinID_)
				ShowTips("HERO_SKIN_BATTLE_SET")
			end)
		end
	end)
end

function BattleSkinBtnView:SetCallBack(arg_8_1)
	self.callBack_ = arg_8_1
end

function BattleSkinBtnView:RefreshUI(arg_9_1, arg_9_2)
	self.heroID_ = arg_9_1
	self.heroData = HeroData:GetHeroData(self.heroID_)
	self.usingBattleSkin_ = self.heroData.battle_using_skin
	self.heroDataUsingSkin_ = self.heroData.using_skin
	self.skinID_ = arg_9_2

	self:RefreshController()
end

function BattleSkinBtnView:RefreshController()
	if self.usingBattleSkin_ and self.usingBattleSkin_ == self.skinID_ then
		self.stateController_:SetSelectedState("on")
	else
		self.stateController_:SetSelectedState("off")
	end
end

function BattleSkinBtnView:GetIsBattleSkin()
	return self.usingBattleSkin_ and self.usingBattleSkin_ == self.skinID_, self.usingBattleSkin_
end

function BattleSkinBtnView:Show(arg_12_1)
	SetActive(self.gameObject_.transform.parent.gameObject, arg_12_1)
end

function BattleSkinBtnView:Dispose()
	self:RemoveAllListeners()
	BattleSkinBtnView.super.Dispose(self)
end

return BattleSkinBtnView
