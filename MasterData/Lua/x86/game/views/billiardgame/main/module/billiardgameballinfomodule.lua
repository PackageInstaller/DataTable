local BilliardGameBallInfoModule = class("BilliardGameBallInfoModule", ReduxView)

function BilliardGameBallInfoModule:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function BilliardGameBallInfoModule:Init()
	self:BindCfgUI()
	self:AddUIListener()
end

function BilliardGameBallInfoModule:AddUIListener()
	self:AddBtnListener(self.ballBtn_, nil, function()
		if manager.guide:IsPlaying() then
			return
		end

		SetActive(self.tipsGo_, true)
	end)
	self:AddBtnListener(self.hideTipsBtn_, nil, function()
		if manager.guide:IsPlaying() then
			return
		end

		SetActive(self.tipsGo_, false)
	end)
end

function BilliardGameBallInfoModule:OnEnter(arg_6_1)
	self.nameText_.text = MergeBallVehicleCfg[arg_6_1].name
	self.descText_.text = MergeBallVehicleCfg[arg_6_1].desc
	self.iconImg_.sprite = pureGetSpriteWithoutAtlas(MergeBallVehicleCfg[arg_6_1].icon_small)
	self.maxHp_ = MergeBallVehicleCfg[arg_6_1].param[2]
	self.nowHp_ = self.maxHp_
	self.nowBufferHp_ = self.maxHp_
	self.hpText_.text = self.nowHp_ .. "/" .. self.maxHp_
	self.ballHpFillImg_.fillAmount = 1
end

function BilliardGameBallInfoModule:RefreshHp(arg_7_1)
	if arg_7_1 == self.nowHp_ then
		return
	end

	self:RemoveTween()

	self.ballHpFillImg_.fillAmount = arg_7_1 / self.maxHp_
	self.nowHp_ = arg_7_1
	self.hpText_.text = string.format("%d/%d", math.floor(arg_7_1), self.maxHp_)
	self.bufferTween_ = LeanTween.value(self.nowBufferHp_, arg_7_1, 1):setOnUpdate(LuaHelper.FloatAction(function(arg_8_0)
		self.nowBufferHp_ = arg_8_0
		self.ballHpBufferFillImg_.fillAmount = arg_8_0 / self.maxHp_
	end)):setOnComplete(System.Action(function()
		self:RemoveTween()
	end))
end

function BilliardGameBallInfoModule:RemoveTween()
	if self.bufferTween_ then
		self.bufferTween_:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
		LeanTween.cancel(self.bufferTween_.id)

		self.bufferTween_ = nil
		self.ballHpBufferFillImg_.fillAmount = self.nowHp_ / self.maxHp_
	end
end

function BilliardGameBallInfoModule:Dispose()
	self:RemoveTween()
	BilliardGameBallInfoModule.super.Dispose(self)
end

return BilliardGameBallInfoModule
