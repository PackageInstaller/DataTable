local BoatAdGameVo = class("BoatAdGameVo")

BoatAdGameVo.game_id = nil
BoatAdGameVo.hub_id = nil
BoatAdGameVo.total_times = nil
BoatAdGameVo.drop = nil
BoatAdGameVo.menu_bgm = "theme-tempest"
BoatAdGameVo.game_bgm = "story-temepest-2"
BoatAdGameVo.rule_tip = "BoatAdGame_minigame_help"
BoatAdGameVo.frameRate = Application.targetFrameRate or 60
BoatAdGameVo.ui_atlas = "ui/minigameui/boatadgameui_atlas"
BoatAdGameVo.game_ui = "BoatAdGameUI"
BoatAdGameVo.game_room_ui = "GameRoomBoatAdUI"
BoatAdGameVo.SFX_COUNT_DOWN = "event:/ui/ddldaoshu2"
BoatAdGameVo.SFX_SOUND_SHIBAI = "event:/ui/shibai"
BoatAdGameVo.SFX_SOUND_GREAT = "event:/ui/mini_great"
BoatAdGameVo.SFX_SOUND_PERFECT = "event:/ui/mini_perfect"
BoatAdGameVo.SFX_SOUND_BATTLE = "event:/ui/minigame_hitwood"
BoatAdGameVo.use_direct_round = nil
BoatAdGameVo.enemyToEndRate = nil
BoatAdGameVo.gameTime = 0
BoatAdGameVo.gameStepTime = 0
BoatAdGameVo.deltaTime = 0

function BoatAdGameVo:Init(arg_1_1)
	BoatAdGameVo.game_id = self
	BoatAdGameVo.hub_id = arg_1_1
	BoatAdGameVo.total_times = pg.mini_game_hub[BoatAdGameVo.hub_id]
	BoatAdGameVo.drop = pg.mini_game[BoatAdGameVo.game_id].simple_config_data.drop_ids
	BoatAdGameVo.total_times = pg.mini_game_hub[BoatAdGameVo.hub_id].reward_need

	return
end

function BoatAdGameVo.GetGameMaxTimes()
	return BoatAdGameVo.GetMiniGameHubData():getConfig("reward_need")
end

function BoatAdGameVo.GetGameTimes()
	return BoatAdGameVo.GetMiniGameHubData().count
end

function BoatAdGameVo.GetGameUseTimes()
	return BoatAdGameVo.GetMiniGameHubData().usedtime or 0
end

function BoatAdGameVo.GetGameRound()
	if BoatAdGameVo.use_direct_round ~= nil then
		return BoatAdGameVo.use_direct_round
	end

	if BoatAdGameVo.selectRound ~= nil then
		return BoatAdGameVo.selectRound
	end

	local var_5_0 = BoatAdGameVo.GetGameUseTimes()
	local var_5_1 = BoatAdGameVo.GetGameTimes()

	if var_5_1 == 0 and var_5_0 == 7 then
		return 8
	end

	if var_5_1 and var_5_1 > 0 then
		return var_5_0 + 1
	end

	if var_5_0 and var_5_0 > 0 then
		return var_5_0
	end

	return 1
end

function BoatAdGameVo.GetMiniGameData()
	return getProxy(MiniGameProxy):GetMiniGameData(BoatAdGameVo.game_id)
end

function BoatAdGameVo.GetMiniGameHubData()
	return getProxy(MiniGameProxy):GetHubByHubId(BoatAdGameVo.hub_id)
end

BoatAdGameVo.char_id = 2
BoatAdGameVo.scene_width = 1920
BoatAdGameVo.scene_height = 1080
BoatAdGameVo.collider_time = 1
BoatAdGameVo.colliderDamage = 5
BoatAdGameVo.scoreNum = 0
BoatAdGameVo.joyStickData = nil
BoatAdGameVo.roundData = nil
BoatAdGameVo.selectRound = nil
BoatAdGameVo.items = {}
BoatAdGameVo.enemys = {}
BoatAdGameVo.isEndLessRound = false

function BoatAdGameVo.Prepare()
	local var_8_0 = BoatAdGameVo.GetGameRound()

	BoatAdGameVo.gameTime = BoatAdGameConst.game_time[var_8_0]
	BoatAdGameVo.gameStepTime = 0
	BoatAdGameVo.scoreNum = 0
	BoatAdGameVo.isEndLessRound = BoatAdGameVo.gameTime > 10000
	BoatAdGameVo.roundData = BoatAdGameConst.game_round[var_8_0]

	return
end

function BoatAdGameVo:SetGameTpl()
	BoatAdGameVo.tpl = self

	return
end

function BoatAdGameVo:SetGameBgs()
	BoatAdGameVo.bg = self

	return
end

function BoatAdGameVo:GetGameBg()
	return BoatAdGameVo.bg
end

function BoatAdGameVo:SetGameChar()
	BoatAdGameVo.char = self

	return
end

function BoatAdGameVo.GetGameChar()
	return BoatAdGameVo.char
end

function BoatAdGameVo:SetGameItems()
	BoatAdGameVo.items = self

	return
end

function BoatAdGameVo.GetGameItems()
	return BoatAdGameVo.items
end

function BoatAdGameVo:SetGameEnemys()
	BoatAdGameVo.enemys = self

	return
end

function BoatAdGameVo.GetGameEnemys()
	return BoatAdGameVo.enemys
end

function BoatAdGameVo:GetGameTplTf()
	return tf(instantiate(findTF(BoatAdGameVo.tpl, self)))
end

function BoatAdGameVo.GetRoundData()
	return BoatAdGameVo.roundData
end

function BoatAdGameVo:PointInRect1(arg_20_1, arg_20_2, arg_20_3, arg_20_4)
	local var_20_2 = BoatAdGameVo.Sign(self, arg_20_2, arg_20_3)
	local var_20_3 = BoatAdGameVo.Sign(self, arg_20_3, arg_20_4)
	local var_20_4 = BoatAdGameVo.Sign(self, arg_20_4, arg_20_1)
	local var_20_5 = BoatAdGameVo.Sign(self, arg_20_1, arg_20_2) > 0 or nil > 0 or nil > 0 or nil > 0

	return not (nil < 0 or nil < 0 or nil < 0 or nil < 0) or not nil
end

function BoatAdGameVo:PointInRect2(arg_21_1, arg_21_2)
	if self.x < arg_21_1.x or self.y < arg_21_1.y then
		return false
	end

	if self.x > arg_21_2.x or self.y > arg_21_2.y then
		return false
	end

	return true
end

function BoatAdGameVo:SetMovePoint(arg_22_1, arg_22_2, arg_22_3)
	BoatAdGameVo.lpt1 = self
	BoatAdGameVo.lpt2 = arg_22_1
	BoatAdGameVo.rtp1 = arg_22_2
	BoatAdGameVo.rtp2 = arg_22_3

	return
end

function BoatAdGameVo:CheckPointOutLeftLine()
	return BoatAdGameVo.PointLeftLine(self, BoatAdGameVo.lpt1, BoatAdGameVo.lpt2)
end

function BoatAdGameVo:CheckPointOutRightLine()
	return BoatAdGameVo.PointRightLine(self, BoatAdGameVo.rtp1, BoatAdGameVo.rtp2)
end

function BoatAdGameVo:PointLeftLine(arg_25_1, arg_25_2)
	return (arg_25_2.x - arg_25_1.x) * (self.y - arg_25_1.y) - (arg_25_2.y - arg_25_1.y) * (self.x - arg_25_1.x) < 0
end

function BoatAdGameVo:PointRightLine(arg_26_1, arg_26_2)
	return (arg_26_2.x - arg_26_1.x) * (self.y - arg_26_1.y) - (arg_26_2.y - arg_26_1.y) * (self.x - arg_26_1.x) > 0
end

function BoatAdGameVo:CheckRectCollider(arg_27_1, arg_27_2, arg_27_3)
	if arg_27_1.x <= self.x and self.x >= arg_27_1.x + arg_27_3.width then
		return false
	elseif self.x <= arg_27_1.x and arg_27_1.x >= self.x + arg_27_2.width then
		return false
	elseif arg_27_1.y <= self.y and self.y >= arg_27_1.y + arg_27_3.height then
		return false
	elseif self.y <= arg_27_1.y and arg_27_1.y >= self.y + arg_27_2.height then
		return false
	else
		return true
	end

	return
end

function BoatAdGameVo.Clear()
	BoatAdGameVo.tpl = nil
	BoatAdGameVo.char = nil

	return
end

return BoatAdGameVo
