local HeroClueMainView_3_6 = class("HeroClueMainView_3_6", (import("game.views.heroClue.HeroClueMainView")))

function HeroClueMainView_3_6:InitController()
	self.coinEnoughController_ = self.controllerEx_:GetController("coinEnough")
end

function HeroClueMainView_3_6:OnEnter()
	HeroClueMainView_3_6.super.OnEnter(self)
	self:ResetClueAnim()
end

function HeroClueMainView_3_6:ResetClueAnim()
	self.playingClueAnim_ = false

	SetActive(self.clueTrailEffectGo_, false)
end

function HeroClueMainView_3_6:OnExit()
	HeroClueMainView_3_6.super.OnExit(self)
	self:StopAnim()
end

function HeroClueMainView_3_6:RefreshCoin()
	HeroClueMainView_3_6.super.RefreshCoin(self)
	self:RefreshCoinEnough()
end

function HeroClueMainView_3_6:RefreshCoinEnough()
	self.coinEnoughController_:SetSelectedState(tostring(ItemTools.getItemNum(HeroCluePoolCfg[self.cluePoolID_].item_id) >= HeroClueTools.GetCostOfOneDraw()))
end

function HeroClueMainView_3_6:OnClickDraw()
	if self.playingClueAnim_ then
		return
	end

	HeroClueMainView_3_6.super.OnClickDraw(self)
end

function HeroClueMainView_3_6:OnClueDraw(arg_8_1)
	self:RefreshCoin()
	self:PlayClueAnim(arg_8_1[1])
end

function HeroClueMainView_3_6:PlayClueAnim(arg_9_1)
	self:InitClueAnim()

	local var_9_0 = self:GetClueItem(arg_9_1)
	local var_9_1 = var_9_0:GetPosition()

	self:StartTween(var_9_1, self:CulculateClueTrailTime(var_9_1), function()
		SetActive(self.clueTrailEffectGo_, false)
		self:RefreshClue()
		var_9_0:PlayAnim(function()
			self.playingClueAnim_ = false
		end)
	end)
end

function HeroClueMainView_3_6:InitClueAnim()
	self.playingClueAnim_ = true

	SetActive(self.clueTrailEffectGo_, true)
	self.clueTrailEffectTrans_:SetPosition(self.drawBtn_.transform:GetPosition())
end

function HeroClueMainView_3_6:GetClueItem(arg_13_1)
	for iter_13_0, iter_13_1 in ipairs(self.clueItemList_) do
		if iter_13_1:GetClueID() == arg_13_1 then
			return iter_13_1
		end
	end
end

function HeroClueMainView_3_6:CulculateClueTrailTime(arg_14_1)
	local var_14_0 = self.clueItemList_[1]:GetPosition() - self.drawBtn_.transform:GetPosition()

	print((arg_14_1 - self.drawBtn_.transform:GetPosition()).Magnitude(var_14_0) / var_14_0:Magnitude() * 0.5)

	return (arg_14_1 - self.drawBtn_.transform:GetPosition()).Magnitude(var_14_0) / var_14_0:Magnitude() * 0.5
end

function HeroClueMainView_3_6:StartTween(arg_15_1, arg_15_2, arg_15_3)
	self.clueTrailPosTween_ = LeanTween.move(self.clueTrailEffectGo_, arg_15_1, arg_15_2):setEase(LeanTweenType.easeOutCubic):setOnComplete(LuaHelper.VoidAction(function()
		self:StopTween()

		if arg_15_3 then
			arg_15_3()
		end
	end))
end

function HeroClueMainView_3_6:StopTween()
	if self.clueTrailPosTween_ then
		self.clueTrailPosTween_:setOnComplete(nil)
		LeanTween.cancel(self.clueTrailEffectGo_)

		self.clueTrailPosTween_ = nil
	end
end

function HeroClueMainView_3_6:StopAnim()
	if self.playingClueAnim_ then
		AnimatorTools.Stop()

		self.playingClueAnim_ = false

		self:StopTween()
	end
end

return HeroClueMainView_3_6
