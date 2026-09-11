local SwimsuitBattleVoteRoundHead = class("SwimsuitBattleVoteRoundHead", ReduxView)

function SwimsuitBattleVoteRoundHead:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitUI()
end

function SwimsuitBattleVoteRoundHead:InitUI()
	self:BindCfgUI()

	self.headController_ = self.mainControllerEx_:GetController("head")
	self.winerController_ = self.mainControllerEx_:GetController("winer")
end

function SwimsuitBattleVoteRoundHead:SetData(arg_3_1, arg_3_2)
	if not arg_3_1 then
		self.headController_:SetSelectedState("state1")
	else
		self.headController_:SetSelectedState("state0")

		self.headImg_.spriteAsync = "TextureConfig/Character/LittleIcon/" .. SwimsuitVoteHeroCfg[arg_3_1].show_image
	end

	if arg_3_2 then
		self.winerController_:SetSelectedState("true")
	else
		self.winerController_:SetSelectedState("false")
	end
end

function SwimsuitBattleVoteRoundHead:Dispose()
	SwimsuitBattleVoteRoundHead.super.Dispose(self)
end

return SwimsuitBattleVoteRoundHead
