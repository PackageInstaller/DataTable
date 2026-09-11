local AutoChessHeroUpgradePopView_4_8 = class("AutoChessHeroUpgradePopView_4_8", (require("game.views.autoChess.view.AutoChessHeroUpgradePopView")))

function AutoChessHeroUpgradePopView_4_8:UIName()
	return "Widget/System/Activity_Xihe/Activity_Xihe_UpgradePopUI"
end

function AutoChessHeroUpgradePopView_4_8:InitUI()
	AutoChessHeroUpgradePopView_4_8.super.InitUI(self)

	self.autoChessCountDownView_ = AutoChessCountDownView.New(self.timerGo_)
end

function AutoChessHeroUpgradePopView_4_8:OnEnter()
	AutoChessHeroUpgradePopView_4_8.super.OnEnter(self)

	self.attrSelectText_.text = "(0/1)"
	self.skillSelectText_.text = "(0/1)"

	self.autoChessCountDownView_:UpdateCountDownTime()
end

function AutoChessHeroUpgradePopView_4_8:OnExit()
	self.super.OnExit(self)
end

function AutoChessHeroUpgradePopView_4_8:ClickFunc(arg_5_1)
	AutoChessHeroUpgradePopView_4_8.super.ClickFunc(self, arg_5_1)

	local var_5_0 = self.selectedBuffItem and 1 or 0

	self.attrSelectText_.text = string.format("(%d/1)", self.selectedAttrItem and 1 or 0)
	self.skillSelectText_.text = string.format("(%d/1)", var_5_0)
end

function AutoChessHeroUpgradePopView_4_8:OnUpgradeHero()
	if self.params_.upgradeBackCb then
		self.params_.upgradeBackCb()
	end

	if self.selectedAttrItem and self.selectedBuffItem then
		AutoChessTools.PlayerCheesUpgrade(self.params_.gameType, self.selectedAttrItem.index_, self.selectedBuffItem.index_)
	end
end

function AutoChessHeroUpgradePopView_4_8:Dispose()
	if self.autoChessCountDownView_ then
		self.autoChessCountDownView_:Dispose()

		self.autoChessCountDownView_ = nil
	end

	AutoChessHeroUpgradePopView_4_8.super.Dispose(self)
end

return AutoChessHeroUpgradePopView_4_8
