-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/view/BattleStartView.lua

module("logic.extensions.battle.view.BattleStartView", package.seeall)

local BattleStartView = class("BattleStartView", ViewComponent)

function BattleStartView:buildUI()
	BattleStartView.super.buildUI(self)

	self._spriteAtlas = self:getGo("spriteAtlas"):GetComponent(typeof(UIImageSpriteAtlas))
end

function BattleStartView:onEnter()
	self._startAnimFinished = nil
	self._disableRotationTrack = AMPlayer.disableRotationTrack
	AMPlayer.disableRotationTrack = false

	if BattleModel.instance.isSeniorArena == true or BattleModel.instance.isEndlessBattle == true or BattleModel.instance.Infinitefuture == true or BattleModel.instance.VillainPet == true or BattleModel.instance.SeasonPVEBoss == true or BattleModel.instance.PeakTournamentIsNeedAnim == true or BattleModel.instance.SummerTreasureSnatchPvpIsNeedAnim == true or BattleModel.instance.StartGodStatuesWar == true then
		local url = "fx_ui_wujinshilian/fx_ui_wujinshilian.prefab"

		self._mainEff = UIEffectManager.instance:playEffect(self, url, self.mainGO, 0, 0, true, false, nil, function(target, eff)
			self:_onEffLoaded(eff)
		end)

		settimer(2.5, self._onAnimPlayFinish, self, false)
	else
		self:_playStartEffect()
	end
end

function BattleStartView:_onAnimPlayStarted()
	AudioPlayerEx.instance:playEffect(30219)
end

function BattleStartView:_onEffLoaded(eff)
	local parent = self.mainGO
	local trans = eff.effGo.transform
	local idx = 1

	if BattleModel.instance.isSeniorArena == true then
		idx = SeniorArenaController.instance:getCurBattleResultIdx() - 1
	end

	if BattleModel.instance.isEndlessBattle == true then
		idx = EndlessBattleController.instance:getDefendCount()
	end

	if BattleModel.instance.Infinitefuture == true then
		idx = InfinitefutureController.instance:getCurBattleResultIdx()
	end

	if BattleModel.instance.VillainPet == true then
		idx = VillaintrialController.instance:getCurBattleResultIdx()
	end

	if BattleModel.instance.StarGodChallenge == true then
		idx = StarGodChallengeController.instance:getCurBattleResultIdx()
	end

	if BattleModel.instance.PeakTournamentFight == true then
		idx = PeakTournamentController.instance:getCurBattleResultIdx()
	end

	if BattleModel.instance.SummerTreasureSnatchPvpFight == true then
		idx = SummerTreasureSnatchController.instance:getCurBattleResultIdx()
	end

	if BattleModel.instance.SeasonPVEBoss == true then
		idx = SeasonPVEBossController.instance:getCurBattleResultIdx()
	end

	if BattleModel.instance.StartGodStatuesWar == true then
		idx = GodStatuesWarController.instance:getCurBattleResultIdx()
	end

	if BattleModel.instance.UltimateWarTowerStage == true then
		idx = UltimateWarController.instance:getCurBattleResultIdxInTowerStage()
	end

	goutil.addChildToParent(trans, parent)
	Framework.TransformUtil.SetLocalPos(trans, 0, 0, 0)
	Framework.TransformUtil.SetLocalScale(trans, 1, 1, 1)
	GoUtil.SetSortingOrder(eff.effGo, UGUIToolHelper.GetNodeCanvansSortingOrder(parent) + 1)

	local spriteRender = goutil.findChildComponent(eff.effGo, "ani/shuzi/tex_1", ComponentType.SpriteRenderer)

	spriteRender.sprite = self._spriteAtlas:GetSpriteByIndex(idx)
end

function BattleStartView:onExit()
	AMPlayer.disableRotationTrack = self._disableRotationTrack

	if self._animPlayer then
		self._animPlayer:Stop()

		self._animPlayer = nil
	end

	if self._mainEff then
		UIEffectManager.instance:stopEffect(self._mainEff)

		self._mainEff = nil
	end

	removetimer(self._onAnimPlayFinish, self)
end

function BattleStartView:_onAnimPlayFinish()
	if self._startAnimFinished then
		return
	end

	self._startAnimFinished = true

	GlobalDispatcher:dispatch(GlobalNotify.BattleStartBaseAnimFinish)
end

function BattleStartView:_playStartEffect()
	local isPlaySelf = BattleStartAnimController.instance:isSeeSelfBattleStartAnim()
	local isPlayed = false

	if isPlaySelf then
		isPlayed = self:_playSelfEffect()
	else
		local teamId = BattleModel.instance:getRightTeamId()
		local enemyPlayerView = BattleModel.instance:getPlayer(teamId)

		if enemyPlayerView and enemyPlayerView.openingEffectId and enemyPlayerView.openingEffectId > 1 then
			local cfg = BattleStartAnimConfig.instance:getOpeningEffectCfg(enemyPlayerView.openingEffectId)

			if cfg and not string.nilorempty(cfg.effectPath) then
				isPlayed = true
				self._animPlayer = AnimationPlayer.play(cfg.effectPath, self._onAnimPlayFinish, self._onAnimPlayStarted, self, 1, true, true)
			end
		else
			isPlayed = self:_playSelfEffect()
		end
	end

	if not isPlayed then
		local animName = CommonResPath.BattleStartAnim

		self._animPlayer = AnimationPlayer.play(animName, self._onAnimPlayFinish, self._onAnimPlayStarted, self, 1, true, false)
	end
end

function BattleStartView:_playSelfEffect()
	local isPlayed = false
	local teamId = BattleModel.instance:getLeftTeamId()
	local playerView = BattleModel.instance:getPlayer(teamId)

	if playerView and playerView.openingEffectId and playerView.openingEffectId > 0 then
		local cfg = BattleStartAnimConfig.instance:getOpeningEffectCfg(playerView.openingEffectId)

		if cfg and not string.nilorempty(cfg.effectPath) then
			isPlayed = true
			self._animPlayer = AnimationPlayer.play(cfg.effectPath, self._onAnimPlayFinish, self._onAnimPlayStarted, self, 1, true, true)
		end
	end

	return isPlayed
end

return BattleStartView
