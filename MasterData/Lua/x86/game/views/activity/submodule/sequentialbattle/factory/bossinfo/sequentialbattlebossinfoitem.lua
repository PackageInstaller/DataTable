local SequentialBattleBossInfoItem = class("SequentialBattleBossInfoItem", ReduxView)

function SequentialBattleBossInfoItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()

	self.skillList_ = {}
	self.scrollRectCast_ = self:FindCom("ScrollRectCast", "", self.scrollView_.transform)

	self.scrollRectCast_:SetParent(self.parentGo_)
end

function SequentialBattleBossInfoItem:Dispose()
	SequentialBattleBossInfoItem.super.Dispose(self)

	for iter_2_0, iter_2_1 in ipairs(self.skillList_) do
		iter_2_1:Dispose()
	end

	self.skillList_ = nil
end

function SequentialBattleBossInfoItem:SetBossID(arg_3_1, arg_3_2)
	self.bossIDList_ = arg_3_1

	local var_3_0

	for iter_3_0, iter_3_1 in pairs(self.bossIDList_) do
		var_3_0 = var_3_0 == nil and tostring(iter_3_1) or var_3_0 .. tostring(iter_3_1)
	end

	self.portraitImage_.sprite = pureGetSpriteWithoutAtlas(string.format("TextureConfig/MardukUI/boss/solo582x648/%s", var_3_0))
	self.nameText_.text = GetMonsterName(self.bossIDList_)
	self.tagText_.text = GetTips("RACE_TYPE_" .. MonsterCfg[self.bossIDList_[1]].race)

	local var_3_1 = GetMonsterSkillDesList(self.bossIDList_)
	local var_3_2 = 1

	for iter_3_2 = 1, 6 do
		if var_3_1[iter_3_2] then
			self.skillList_[var_3_2] = self.skillList_[var_3_2] or BattleBossChallengeSkillItem.New(self.skillItem_, self.skillParent_)

			self.skillList_[var_3_2]:RefreshUI(var_3_1[iter_3_2])

			var_3_2 = var_3_2 + 1
		end
	end

	for iter_3_3 = var_3_2, #self.skillList_ do
		self.skillList_[iter_3_3]:Hide()
	end

	self.lvText_.text = NumberTools.IntToRomam(arg_3_2)
end

return SequentialBattleBossInfoItem
