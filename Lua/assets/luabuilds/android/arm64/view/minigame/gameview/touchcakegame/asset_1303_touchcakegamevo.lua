local TouchCakeGameVo = class("TouchCakeGameVo")

TouchCakeGameVo.game_id = nil
TouchCakeGameVo.hub_id = nil
TouchCakeGameVo.total_times = nil
TouchCakeGameVo.drop = nil
TouchCakeGameVo.menu_bgm = "story-fantasyland-light"
TouchCakeGameVo.game_bgm = "story-fantasyland-light"
TouchCakeGameVo.game_time = 45
TouchCakeGameVo.rule_tip = "touch_cake_minigame_help"
TouchCakeGameVo.rank_tip = "touch_cake_minigame_rank"
TouchCakeGameVo.frameRate = Application.targetFrameRate or 60
TouchCakeGameVo.ui_atlas = "ui/minigameui/touchcakegameui_atlas"
TouchCakeGameVo.game_ui = "TouchCakeGameUI"
TouchCakeGameVo.game_room_ui = "GameRoomTouchCakeUI"
TouchCakeGameVo.SFX_COUNT_DOWN = "event:/ui/ddldaoshu2"
TouchCakeGameVo.SFX_COUNT_THROW = "event:/ui/mini_throw"
TouchCakeGameVo.SFX_COUNT_STEP = "event:/ui/step"
TouchCakeGameVo.SFX_COUNT_CLICK3 = "event:/ui/mini_click3"
TouchCakeGameVo.SFX_COUNT_PERFECT = "event:/ui/mini_perfect"
TouchCakeGameVo.use_direct_round = nil
TouchCakeGameVo.gameTime = 0
TouchCakeGameVo.gameStepTime = 0
TouchCakeGameVo.deltaTime = 0

function TouchCakeGameVo:Init(arg_1_1)
	TouchCakeGameVo.game_id = self
	TouchCakeGameVo.hub_id = arg_1_1
	TouchCakeGameVo.total_times = pg.mini_game_hub[TouchCakeGameVo.hub_id]
	TouchCakeGameVo.drop = pg.mini_game[TouchCakeGameVo.game_id].simple_config_data.drop_ids
	TouchCakeGameVo.total_times = pg.mini_game_hub[TouchCakeGameVo.hub_id].reward_need

	return
end

function TouchCakeGameVo.GetGameTimes()
	return TouchCakeGameVo.GetMiniGameHubData().count
end

function TouchCakeGameVo.GetGameUseTimes()
	return TouchCakeGameVo.GetMiniGameHubData().usedtime or 0
end

function TouchCakeGameVo.GetGameRound()
	if TouchCakeGameVo.use_direct_round ~= nil then
		return TouchCakeGameVo.use_direct_round
	end

	if TouchCakeGameVo.selectRound ~= nil then
		return TouchCakeGameVo.selectRound
	end

	local var_4_0 = TouchCakeGameVo.GetGameUseTimes()
	local var_4_1 = TouchCakeGameVo.GetGameTimes()

	if var_4_1 and var_4_1 > 0 then
		return var_4_0 + 1
	end

	if var_4_0 and var_4_0 > 0 then
		return var_4_0
	end

	return 1
end

function TouchCakeGameVo.GetMiniGameData()
	return getProxy(MiniGameProxy):GetMiniGameData(TouchCakeGameVo.game_id)
end

function TouchCakeGameVo.GetMiniGameHubData()
	return getProxy(MiniGameProxy):GetHubByHubId(TouchCakeGameVo.hub_id)
end

TouchCakeGameVo.scoreNum = 0
TouchCakeGameVo.roundData = nil
TouchCakeGameVo.selectRound = nil
TouchCakeGameVo.tplItemPool = {}
TouchCakeGameVo.comboNum = 0
TouchCakeGameVo.dragItem = nil
TouchCakeGameVo.gameDragTime = nil
TouchCakeGameVo.startSettlement = false

function TouchCakeGameVo.Prepare()
	TouchCakeGameVo.gameTime = TouchCakeGameVo.game_time
	TouchCakeGameVo.gameDragTime = TouchCakeGameVo.game_drag_time
	TouchCakeGameVo.gameStepTime = 0
	TouchCakeGameVo.scoreNum = 0
	TouchCakeGameVo.draging = false
	TouchCakeGameVo.dragScreenPos = Vector2(0, 0)
	TouchCakeGameVo.dragItem = nil
	TouchCakeGameVo.roundData = TouchCakeGameConst.game_round[TouchCakeGameVo.GetGameRound()]
	TouchCakeGameVo.sceneSpeed = Vector2(0, 0)
	TouchCakeGameVo.startSettlement = false
	TouchCakeGameVo.comboNum = 0

	return
end

function TouchCakeGameVo:SetGameTpl()
	TouchCakeGameVo.tpl = self

	return
end

function TouchCakeGameVo:GetTplItemFromPool(arg_9_1)
	if not arg_9_1 then
		return nil
	end

	if TouchCakeGameVo.tplItemPool[self] == nil then
		TouchCakeGameVo.tplItemPool[self] = {}
	end

	if #TouchCakeGameVo.tplItemPool[self] == 0 then
		local var_9_0 = tf(instantiate(findTF(TouchCakeGameVo.tpl, self)))

		setParent(var_9_0, arg_9_1)
		setActive(var_9_0, true)

		return var_9_0
	else
		return table.remove(TouchCakeGameVo.tplItemPool[self], #TouchCakeGameVo.tplItemPool[self])
	end

	return
end

function TouchCakeGameVo:RetTplItem(arg_10_1)
	if TouchCakeGameVo.tplItemPool[self] == nil then
		TouchCakeGameVo.tplItemPool[self] = {}
	end

	table.insert(TouchCakeGameVo.tplItemPool[self], arg_10_1)

	return
end

function TouchCakeGameVo:GetSprite()
	return GetSpriteFromAtlas(TouchCakeGameVo.ui_atlas, self)
end

function TouchCakeGameVo.GetRoundData()
	return TouchCakeGameVo.roundData
end

function TouchCakeGameVo.Clear()
	TouchCakeGameVo.tpl = nil
	TouchCakeGameVo.char = nil

	return
end

return TouchCakeGameVo
