local GuildBossAvatarView = class("GuildBossAvatarView", ReduxView)

function GuildBossAvatarView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function GuildBossAvatarView:Init()
	self:InitUI()
	self:AddUIListener()
end

function GuildBossAvatarView:InitUI()
	self.playable_ = self:FindCom(typeof(PlayableDirector), "")
end

function GuildBossAvatarView:AddUIListener()
	return
end

function GuildBossAvatarView:OnEnter()
	self:InitBackScene()
end

function GuildBossAvatarView:OnExit()
	if self.backGround_ then
		manager.resourcePool:DestroyOrReturn(self.backGround_, ASSET_TYPE.SCENE)
	end

	self:Finish()
end

function GuildBossAvatarView:SetBossID(arg_7_1)
	if self.bossID_ == arg_7_1 then
		return
	end

	self:Finish()
	self:LoadModel(arg_7_1)

	self.bossID_ = arg_7_1
end

function GuildBossAvatarView:ShowBossModel(arg_8_1)
	if self.bossModel_ then
		SetActive(self.bossModel_, arg_8_1)
	end
end

function GuildBossAvatarView:InitBackScene()
	self.backGround_ = manager.resourcePool:Get("UI/Common/BackgroundQuad", ASSET_TYPE.SCENE)
	self.backGroundTrs_ = self.backGround_.transform

	self.backGroundTrs_:SetParent(manager.ui.mainCamera.transform)

	self.backGroundTrs_.localPosition = Vector3(GameDisplayCfg.club_boss_bg_pos.value[1], GameDisplayCfg.club_boss_bg_pos.value[2], GameDisplayCfg.club_boss_bg_pos.value[3])
	self.backGroundTrs_.localEulerAngles = Vector3(0, 0, 0)
	self.backGroundTrs_.localScale = Vector3(GameDisplayCfg.club_boss_bg_pos.scale[1], GameDisplayCfg.club_boss_bg_pos.scale[2], GameDisplayCfg.club_boss_bg_pos.scale[3])
	self.backGroundTrs_:Find("pic_background1"):GetComponent("SpriteRenderer").sprite = pureGetSpriteWithoutAtlas(SpritePathCfg.ClubBossBg.path .. CameraCfg.clubBoss.pictureName)
end

function GuildBossAvatarView:Finish()
	if self.animator_ then
		if self.playable_ then
			self.playable_:Stop()
		end

		local var_10_0 = self.animator_.gameObject:GetComponent("LipSync")

		if var_10_0 then
			var_10_0:ResetEmotion(0)
		end
	end

	self.bossID_ = nil

	if self.bossModel_ then
		manager.resourcePool:DestroyOrReturn(self.bossModel_, ASSET_TYPE.TPOSE)

		self.bossModel_ = nil
		self.animator_ = nil
		self.actionTimer_ = nil
		self.actioning_ = false
	end
end

function GuildBossAvatarView:InitModel(arg_11_1, arg_11_2)
	self.bossModel_ = arg_11_1
	self.animator_ = self:FindCom(typeof(Animator), "", self.bossModel_.transform)

	if self.animator_ == nil then
		-- block empty
	end
end

function GuildBossAvatarView:LoadModel(arg_12_1)
	local var_12_0 = manager.resourcePool:Get("Char/" .. MonsterCfg[BossChallengeUICfg[arg_12_1].boss_id_list[1]].model_name, ASSET_TYPE.TPOSE)

	var_12_0.transform.localPosition = Vector3(BossChallengeUICfg[arg_12_1].model_pos[1][1], BossChallengeUICfg[arg_12_1].model_pos[1][2], BossChallengeUICfg[arg_12_1].model_pos[1][3])
	var_12_0.transform.localEulerAngles = Vector3(BossChallengeUICfg[arg_12_1].model_rot[1][1], BossChallengeUICfg[arg_12_1].model_rot[1][2], BossChallengeUICfg[arg_12_1].model_rot[1][3])
	var_12_0.transform.localScale = Vector3((nil)[1], (nil)[2], (nil)[3])

	self:InitModel(var_12_0, BossChallengeUICfg[arg_12_1].id)
end

function GuildBossAvatarView:Dispose()
	self:RemoveAllListeners()
	self:Finish()
	GuildBossAvatarView.super.Dispose(self)
end

return GuildBossAvatarView
