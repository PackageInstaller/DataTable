local MythicDifficultyItem = class("MythicDifficultyItem", ReduxView)

function MythicDifficultyItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:initUI()
	self:AddClickListen()
end

function MythicDifficultyItem:initUI()
	self:BindCfgUI()

	self.selectController_ = self.m_contrExCo_:GetController("select")
	self.lockController_ = self.m_contrExCo_:GetController("lock")
end

function MythicDifficultyItem:AddClickListen()
	self:AddBtnListener(self.m_button, nil, function()
		if self.unlock and self.clickFunc then
			self.clickFunc(self.index)
		end
	end)
end

function MythicDifficultyItem:RegistCallBack(arg_5_1)
	self.clickFunc = arg_5_1
end

function MythicDifficultyItem:SetChoice(arg_6_1)
	self.selectController_:SetSelectedIndex(arg_6_1 == self.index and 1 or 0)
end

function MythicDifficultyItem:RefreshData(arg_7_1)
	self.index = arg_7_1

	local var_7_0 = MythicCfg.all[self.index]
	local var_7_1 = MythicCfg[MythicCfg.all[self.index]]

	self.m_bg.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Challenge_Mythic/" .. MythicCfg[MythicCfg.all[self.index]].background)
	self.unlock = MythicData:GetIsOpenDifficulty(var_7_0)

	self.lockController_:SetSelectedIndex(self.unlock and 0 or 1)

	self.numText_.text = var_7_1.difficulty == 1 and NumberTools.IntToRomam(var_7_0) or "Ω"
end

return MythicDifficultyItem
