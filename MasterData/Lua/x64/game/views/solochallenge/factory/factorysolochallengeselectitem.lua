local FactorySoloChallengeSelectItem = class("FactorySoloChallengeSelectItem", (import("game.views.soloChallenge.SoloChallengeSelectItem")))

function FactorySoloChallengeSelectItem:Init()
	self.affixList_ = {}

	self:InitUI()
	self:AddUIListener()

	self.heroSelectController = ControllerUtil.GetController(self.transform_, "heroSelect")
	self.lockStateController_ = ControllerUtil.GetController(self.transform_, "lock")
	self.indexController_ = ControllerUtil.GetController(self.transform_, "index")
end

function FactorySoloChallengeSelectItem:RefreshTitle()
	self.indexController_:SetSelectedState(tostring(self.selectHeroPos_))
end

function FactorySoloChallengeSelectItem:RefreshEnemyUI()
	self.bossIcon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/MardukUI/boss/solo384x172/" .. ActivitySoloChallengeCfg[self.activityID_].boss_id_list[self.selectHeroPos_])
end

return FactorySoloChallengeSelectItem
