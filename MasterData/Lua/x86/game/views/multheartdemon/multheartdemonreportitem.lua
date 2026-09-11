local MultHeartDemonCombatItem = class("MultHeartDemonCombatItem", ReduxView)

function MultHeartDemonCombatItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function MultHeartDemonCombatItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function MultHeartDemonCombatItem:AddUIListener()
	return
end

function MultHeartDemonCombatItem:InitUI()
	self:BindCfgUI()

	self.stateController = self.controlExCo_:GetController("state")
end

function MultHeartDemonCombatItem:SetData(arg_5_1, arg_5_2)
	self.index = arg_5_1
	self.data = arg_5_2

	self:UpdateView()
end

function MultHeartDemonCombatItem:UpdatePlayer(arg_6_1)
	local var_6_0

	if HeroStandardSystemCfg[arg_6_1.heroId] then
		self.playerIcon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Character/Icon/" .. HeroStandardSystemCfg[arg_6_1.heroId].skin_id)
		var_6_0 = HeroStandardSystemCfg[arg_6_1.heroId].hero_id
	else
		var_6_0 = arg_6_1.heroId
		self.playerIcon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Character/Icon/" .. HeroData:GetHeroUsingSkinInfo(arg_6_1.heroId).id)
	end

	self.playerNameTxt_.text = HeroTools.GetHeroFullName(var_6_0)
	self.playerSlider_.value = arg_6_1.heroHP == 0 and 0 or arg_6_1.heroHP / 100
	self.playerHp_.text = arg_6_1.heroHP .. "%"
end

function MultHeartDemonCombatItem:UpdateAI(arg_7_1)
	self.aiSlider_.value = arg_7_1.bossHP == 0 and 0 or arg_7_1.bossHP / 100
	self.aiHp_.text = arg_7_1.bossHP .. "%"
	self.aiIcon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Character/Icon/" .. arg_7_1.bossId - 4000)
	self.aiNameTxt_.text = self.nameTable[arg_7_1.bossId]
end

function MultHeartDemonCombatItem:UpdateView()
	if self.data then
		local var_8_0 = self.data.stageData[#self.data.stageData - self.index + 1]

		self.nameTable = MultHeartDemonData:GetDataByPara("nameTable")

		self:UpdateAI(var_8_0)
		self:UpdatePlayer(var_8_0)
		self.stateController:SetSelectedState(var_8_0.bossHP == 0 and "true" or "false")

		self.scoreTxt_.text = var_8_0.maxScore
		self.timeImg_.sprite = pureGetSpriteWithoutAtlas("TextureBg/Activity_Resident/Acitvity_SoloHeartDemon/SoloHeartDemonUI_" .. 1505 + self.index)
	end
end

function MultHeartDemonCombatItem:OnEnter()
	self:UpdateView()
end

function MultHeartDemonCombatItem:Dispose()
	MultHeartDemonCombatItem.super.Dispose(self)
	Object.Destroy(self.gameObject_)
end

return MultHeartDemonCombatItem
