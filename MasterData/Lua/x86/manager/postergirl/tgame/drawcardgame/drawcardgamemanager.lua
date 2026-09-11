local DrawCardGameManager = class("DrawCardGameManager", (import("..T0GameManagerBase")))
local Include = import(".States.Include")

function DrawCardGameManager:Ctor()
	DrawCardGameManager.super.Ctor(self)

	self.totalRound = 3
end

function DrawCardGameManager:Init()
	if self.init then
		return
	end

	self.init = true

	DrawCardGameManager.super.Init(self)

	self.startTime = manager.time:GetServerTime()
	self.gameData = {
		lose = 0,
		win = 0,
		recordData = {}
	}

	manager.posterGirl:OpenPhysicsRaycaster()

	self.raycaster = manager.posterGirl.raycaster

	manager.posterGirl:RefreshOtherModel(605603, "605603ui_custom", PosterGirlDlcActor, 1)

	self.actors = {
		self:GetCurMainActor(),
		self:GetCurExtraActor(1)
	}

	self.actors[2]:SetActive(false)
	self:GoToState(Include.EnterState)
end

function DrawCardGameManager:BindActorState(arg_3_1, arg_3_2)
	if self.actorState == nil or arg_3_2 then
		DrawCardGameManager.super.BindActorState(self, arg_3_1)
	end
end

function DrawCardGameManager:SwapActor()
	manager.posterGirl:SwapExtraActorToMainActor(1)
	self:BindActorState(self:GetCurMainActor():GetCurrentState(), true)
end

function DrawCardGameManager:WillGameOver()
	return self.gameData.win == self.totalRound or self.gameData.lose == self.totalRound, self.gameData.win == self.totalRound, self.gameData.lose == self.totalRound
end

function DrawCardGameManager:Reset()
	if self.init then
		manager.audio:StopVoice()
		manager.audio:PlayEffect("ui_scene_102003", "ui_scene_102003_chair_game_stop")

		self.init = nil
		self.gameData = nil

		if not isNil(self.raycaster) then
			-- block empty
		end

		if not self:IsLittleChara() then
			self:SwapActor()
		end

		self.actorState = nil

		self.actors[2]:Dispose()

		self.actors = nil
	end

	DrawCardGameManager.super.Reset(self)
end

function DrawCardGameManager:IsLittleChara()
	return self:GetCurMainActor().modelId == "102003ui_custom"
end

function DrawCardGameManager.StartGame()
	DrawCardGameManager.super.StartGameImpl(DrawCardGameManager)
end

function DrawCardGameManager:GetStateName()
	return PosterGirlConst.StateKay.drawCardMiniGame
end

DrawCardGameManager.GameResult = {
	Canceled = 3,
	Lose = 2,
	Win = 1
}

function DrawCardGameManager:ExitGame(arg_10_1)
	local var_10_0 = manager.posterGirl.actor
	local var_10_1 = manager.posterGirl.actor:GetCurrentState()

	if var_10_1 and var_10_1.gameInst then
		var_10_0 = var_10_1.gameInst.actors[1]

		var_10_1.gameInst:OnExitSendMsgToSDK(arg_10_1 or DrawCardGameManager.GameResult.Canceled)
		var_10_1.gameInst:Reset()
	end

	if var_10_0 then
		var_10_0:ChangeState(self or PosterGirlConst.StateKay.init)
	end

	var_10_0:SetSelfCamera(0, true)
	manager.notify:Invoke(HOME_BTN_VISIBE, true)
	manager.posterGirl:SetStateCanChange(true)
	manager.posterGirl:ExitMiniGame()
end

function DrawCardGameManager:OnExitSendMsgToSDK(arg_11_1)
	SDKTools.SendMessageToSDK("activity_combat_over", {
		stage_id = 2,
		sys_id = 101,
		skin_id = PlayerData:GetPosterGirlHeroSkinId(),
		scene_id = HomeSceneSettingData:GetCurScene(),
		result = arg_11_1,
		start_time = self.startTime,
		battle_times = self.gameData.win + self.gameData.lose,
		other_data = SDKTools.JsonEncode(self.gameData.recordData)
	})
end

return DrawCardGameManager
