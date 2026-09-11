local HeroClueItem_3_6 = class("HeroClueItem_3_6", (import("game.views.heroClue.HeroClueItem")))

function HeroClueItem_3_6:InitController()
	self.statusController_ = self.controllerEx_:GetController("level")
end

function HeroClueItem_3_6:RefreshUI()
	self.curData_ = HeroClueData:GetUnlockClueDataDic()[self.clueID_]

	SetActive(self.animGo_, false)
	self:RefreshState()
	self:RefreshIcon()
	self:RefreshName()
	self:RefreshProgress()
	self:RefreshIndex()
end

function HeroClueItem_3_6:RefreshState()
	if self.curData_ == nil then
		self.statusController_:SetSelectedIndex(0)
	else
		self.statusController_:SetSelectedIndex(self.curData_.level)
	end
end

function HeroClueItem_3_6:RefreshIcon()
	if self.curData_ then
		self.clueIcon_.sprite = self.curData_.level == 1 and pureGetSpriteWithoutAtlas(HeroClueCfg[self.clueID_].icon_path_1) or self.curData_.level == 2 and pureGetSpriteWithoutAtlas(HeroClueCfg[self.clueID_].icon_path_2) or pureGetSpriteWithoutAtlas(HeroClueCfg[self.clueID_].icon_path_3)
	end
end

function HeroClueItem_3_6:RefreshName()
	if self.curData_ and self.curData_.level >= 2 then
		self.nameText_.text = HeroClueCfg[self.clueID_].name
	end
end

function HeroClueItem_3_6:RefreshProgress()
	self.progressText_.text = string.format("%d/%d", (self.curData_ and self.curData_.level >= 1 or nil) and self.curData_.level, #HeroClueCfg[self.clueID_].level)
end

function HeroClueItem_3_6:RefreshIndex()
	self.indexText_.text = self.index_ < 10 and "0" .. self.index_ or self.index_
end

function HeroClueItem_3_6:PlayAnim(arg_8_1)
	SetActive(self.animGo_, true)
	AnimatorTools.PlayAnimationWithCallback(self.anim_, "unlock", function()
		SetActive(self.animGo_, false)

		if arg_8_1 then
			arg_8_1()
		end
	end)
	self.anim_:Update(0)
end

return HeroClueItem_3_6
