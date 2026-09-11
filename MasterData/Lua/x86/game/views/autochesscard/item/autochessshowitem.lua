local AutoChessShowItem = class("AutoChessShowItem", AutoChessItem)

function AutoChessShowItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function AutoChessShowItem:Init()
	self:BindCfgUI()
	ComponentBinder.GetInstance():BindCfgUI(self, self.originalGo_)
	self:InitUI()
	self:AddListeners()
end

function AutoChessShowItem:AddListeners()
	return
end

function AutoChessShowItem:InitUI()
	self.sunglassController_ = self.controllerEx_:GetController("sunglass")
	self.gradeController_ = self.battleChessControllerEX_:GetController("grade")
end

function AutoChessShowItem:SetData(arg_5_1, arg_5_2, arg_5_3)
	self.cardID_ = arg_5_1
	self.chessID_ = arg_5_2
	self.isSunglass_ = arg_5_3

	self:UpdateIcon()
end

function AutoChessShowItem:UpdateIcon()
	local var_6_0 = AutoChessCardCfg[self.cardID_]

	self.roleImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Activity_AutoChess_Chess/RoleBattle/" .. AutoChessCardCfg[self.cardID_].pic)
	self.roleLightImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Activity_AutoChess_Chess/RoleBattle/" .. var_6_0.pic)

	if self.isSunglass_ then
		self.sunglassImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Activity_AutoChess_Chess/Sunglass/" .. (string.isNullOrEmpty(var_6_0.sunglass) and "com_m" or var_6_0.sunglass))
	end

	self:RefreshSunglassesState(self.isSunglass_)
	self.gradeController_:SetSelectedIndex(var_6_0.type - 1)
end

function AutoChessShowItem:RefreshSunglassesState(arg_7_1)
	self.isSunglass_ = arg_7_1

	self.sunglassController_:SetSelectedState(self.isSunglass_ == 1 and "show" or "hide")
end

function AutoChessShowItem:Dispose()
	AutoChessShowItem.super.Dispose(self)
end

return AutoChessShowItem
