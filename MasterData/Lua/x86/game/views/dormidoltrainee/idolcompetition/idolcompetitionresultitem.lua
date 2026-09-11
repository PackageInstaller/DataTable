local IdolCompetitionResultItem = class("IdolCompetitionResultItem", ReduxView)

function IdolCompetitionResultItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function IdolCompetitionResultItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function IdolCompetitionResultItem:InitUI()
	self:BindCfgUI()

	self.winController_ = self.mainControllerEx_:GetController("win")
end

function IdolCompetitionResultItem:AddUIListener()
	return
end

function IdolCompetitionResultItem:SetData(arg_5_1)
	if IdolTraineePvpBattleCfg[arg_5_1.stageID] then
		if IdolStageSceneCfg[IdolTraineePvpBattleCfg[arg_5_1.stageID].scene_id] then
			self.stageImg_.spriteSync = SpritePathCfg.IdolStageIcon.path .. IdolStageSceneCfg[IdolTraineePvpBattleCfg[arg_5_1.stageID].scene_id].stage_picture
			self.stageText_.text = IdolStageSceneCfg[IdolTraineePvpBattleCfg[arg_5_1.stageID].scene_id].scene_show_name
		end
	end

	self.p1scoreText_.text = arg_5_1.player1Info.score
	self.p2scoreText_.text = arg_5_1.player2Info.score

	if arg_5_1.player1Info.npc then
		self.p1nameText_.text = IdolPveNpcCfg[arg_5_1.player1Info.heroID].name
		self.p1headImg_.sprite = getSpriteViaConfig("DormHeroHeadIcon", IdolPveNpcCfg[arg_5_1.player1Info.heroID].icon)
	else
		self.p1nameText_.text = HeroCfg[arg_5_1.player1Info.heroID].suffix
		self.p1headImg_.sprite = getSpriteViaConfig("DormHeroHeadIcon", arg_5_1.player1Info.heroID)
	end

	if arg_5_1.player2Info.npc then
		self.p2nameText_.text = IdolPveNpcCfg[arg_5_1.player2Info.heroID].name
		self.p2headImg_.sprite = getSpriteViaConfig("DormHeroHeadIcon", IdolPveNpcCfg[arg_5_1.player2Info.heroID].icon)
	else
		self.p2nameText_.text = HeroCfg[arg_5_1.player2Info.heroID].suffix
		self.p2headImg_.sprite = getSpriteViaConfig("DormHeroHeadIcon", arg_5_1.player2Info.heroID)
	end

	self.winController_:SetSelectedState(arg_5_1.result == 1 and "L" or "R")
end

function IdolCompetitionResultItem:Dispose()
	IdolCompetitionResultItem.super.Dispose(self)
end

return IdolCompetitionResultItem
