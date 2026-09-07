local PipeGameVo = class("PipeGameVo")

PipeGameVo.game_id = nil
PipeGameVo.hub_id = nil
PipeGameVo.total_times = nil
PipeGameVo.drop = nil
PipeGameVo.menu_bgm = "story-richang-3"
PipeGameVo.game_bgm = "story-richang-3"
PipeGameVo.game_time = 0
PipeGameVo.rule_tip = "pipe_minigame_help"
PipeGameVo.rank_tip = "pipe_minigame_rank"
PipeGameVo.game_drag_time = 300
PipeGameVo.frameRate = Application.targetFrameRate or 60
PipeGameVo.ui_atlas = "ui/minigameui/pipegameui_atlas"
PipeGameVo.game_ui = "PipeGameUI"
PipeGameVo.game_room_ui = "GameRoomPipeUI"
PipeGameVo.SFX_COUNT_DOWN = "event:/ui/ddldaoshu2"
PipeGameVo.SFX_SOUND_FIRE = "event:/ui/kaipao"
PipeGameVo.SFX_SOUND_BOOM = "event:/ui/baozha3"
PipeGameVo.SFX_SOUND_SKILL = "event:/ui/chongneng"
PipeGameVo.SFX_SOUND_ITEM = "event:/ui/mini_shine"
PipeGameVo.use_direct_round = nil
PipeGameVo.gameTime = 0
PipeGameVo.gameStepTime = 0
PipeGameVo.deltaTime = 0

function PipeGameVo:Init(arg_1_1)
	PipeGameVo.game_id = self
	PipeGameVo.hub_id = arg_1_1
	PipeGameVo.total_times = pg.mini_game_hub[PipeGameVo.hub_id]
	PipeGameVo.drop = pg.mini_game[PipeGameVo.game_id].simple_config_data.drop_ids
	PipeGameVo.total_times = pg.mini_game_hub[PipeGameVo.hub_id].reward_need

	return
end

function PipeGameVo.GetGameTimes()
	return PipeGameVo.GetMiniGameHubData().count
end

function PipeGameVo.GetGameUseTimes()
	return PipeGameVo.GetMiniGameHubData().usedtime or 0
end

function PipeGameVo.GetGameRound()
	if PipeGameVo.use_direct_round ~= nil then
		return PipeGameVo.use_direct_round
	end

	if PipeGameVo.selectRound ~= nil then
		return PipeGameVo.selectRound
	end

	local var_4_0 = PipeGameVo.GetGameUseTimes()
	local var_4_1 = PipeGameVo.GetGameTimes()

	if var_4_1 and var_4_1 > 0 then
		return var_4_0 + 1
	end

	if var_4_0 and var_4_0 > 0 then
		return var_4_0
	end

	return 1
end

function PipeGameVo.GetMiniGameData()
	return getProxy(MiniGameProxy):GetMiniGameData(PipeGameVo.game_id)
end

function PipeGameVo.GetMiniGameHubData()
	return getProxy(MiniGameProxy):GetHubByHubId(PipeGameVo.hub_id)
end

PipeGameVo.scoreNum = 0
PipeGameVo.roundData = nil
PipeGameVo.selectRound = nil
PipeGameVo.tplItemPool = {}
PipeGameVo.draging = false
PipeGameVo.dragScreenPos = Vector2(0, 0)
PipeGameVo.dragItem = nil
PipeGameVo.gameDragTime = nil
PipeGameVo.startSettlement = false

function PipeGameVo.Prepare()
	PipeGameVo.gameTime = PipeGameVo.game_time
	PipeGameVo.gameDragTime = PipeGameVo.game_drag_time
	PipeGameVo.gameStepTime = 0
	PipeGameVo.scoreNum = 0
	PipeGameVo.draging = false
	PipeGameVo.dragScreenPos = Vector2(0, 0)
	PipeGameVo.dragItem = nil
	PipeGameVo.roundData = PipeGameConst.game_round[PipeGameVo.GetGameRound()]
	PipeGameVo.sceneSpeed = Vector2(0, 0)
	PipeGameVo.startSettlement = false

	return
end

function PipeGameVo:SetGameTpl()
	PipeGameVo.tpl = self

	return
end

function PipeGameVo:GetTplItemFromPool(arg_9_1)
	if not arg_9_1 then
		return nil
	end

	if PipeGameVo.tplItemPool[self] == nil then
		PipeGameVo.tplItemPool[self] = {}
	end

	if #PipeGameVo.tplItemPool[self] == 0 then
		local var_9_0 = tf(instantiate(findTF(PipeGameVo.tpl, self)))

		setParent(var_9_0, arg_9_1)

		return var_9_0
	else
		return table.remove(PipeGameVo.tplItemPool[self], #PipeGameVo.tplItemPool[self])
	end

	return
end

function PipeGameVo:RetTplItem(arg_10_1)
	if PipeGameVo.tplItemPool[self] == nil then
		PipeGameVo.tplItemPool[self] = {}
	end

	table.insert(PipeGameVo.tplItemPool[self], arg_10_1)

	return
end

function PipeGameVo:GetSprite()
	return GetSpriteFromAtlas(PipeGameVo.ui_atlas, self)
end

function PipeGameVo.GetResultLevel()
	if not PipeGameVo.scoreNum or PipeGameVo.scoreNum == 0 then
		return 1
	end

	for iter_12_0 = #PipeGameConst.game_result_level, 1, -1 do
		if PipeGameVo.scoreNum >= PipeGameConst.game_result_level[iter_12_0] then
			return iter_12_0
		end
	end

	return 1
end

function PipeGameVo.GetRoundData()
	return PipeGameVo.roundData
end

function PipeGameVo.Clear()
	PipeGameVo.tpl = nil
	PipeGameVo.char = nil

	return
end

return PipeGameVo
