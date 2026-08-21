local var_0_0 = class("SailBoatGameVo")

var_0_0.game_id = nil
var_0_0.hub_id = nil
var_0_0.total_times = nil
var_0_0.drop = nil
var_0_0.menu_bgm = "theme-SeaAndSun-image"
var_0_0.game_bgm = "theme-tempest-up"
var_0_0.game_time = 120
var_0_0.rule_tip = "sail_boat_minigame_help"
var_0_0.frameRate = Application.targetFrameRate or 60
var_0_0.ui_atlas = "ui/minigameui/sailboatgameui_atlas"
var_0_0.game_ui = "SailBoatGameUI"
var_0_0.SFX_COUNT_DOWN = "event:/ui/ddldaoshu2"
var_0_0.SFX_SOUND_FIRE = "event:/ui/kaipao"
var_0_0.SFX_SOUND_BOOM = "event:/ui/baozha3"
var_0_0.SFX_SOUND_SKILL = "event:/ui/chongneng"
var_0_0.SFX_SOUND_ITEM = "event:/ui/mini_shine"
var_0_0.use_direct_round = nil
var_0_0.enemyToEndRate = nil
var_0_0.gameTime = 0
var_0_0.gameStepTime = 0
var_0_0.deltaTime = 0

function var_0_0.Init(arg_1_0, arg_1_1)
	var_0_0.game_id = arg_1_0
	var_0_0.hub_id = arg_1_1
	var_0_0.total_times = pg.mini_game_hub[var_0_0.hub_id]
	var_0_0.drop = pg.mini_game[var_0_0.game_id].simple_config_data.drop_ids
	var_0_0.total_times = pg.mini_game_hub[var_0_0.hub_id].reward_need

	return
end

function var_0_0.GetGameTimes()
	return var_0_0.GetMiniGameHubData().count
end

function var_0_0.GetGameUseTimes()
	return var_0_0.GetMiniGameHubData().usedtime or 0
end

function var_0_0.GetGameRound()
	if var_0_0.use_direct_round ~= nil then
		return var_0_0.use_direct_round
	end

	if var_0_0.selectRound ~= nil then
		return var_0_0.selectRound
	end

	local var_4_0 = var_0_0.GetGameUseTimes()
	local var_4_1 = var_0_0.GetGameTimes()

	if var_4_1 and var_4_1 > 0 then
		return var_4_0 + 1
	end

	if var_4_0 and var_4_0 > 0 then
		return var_4_0
	end

	return 1
end

function var_0_0.GetMiniGameData()
	return getProxy(MiniGameProxy):GetMiniGameData(var_0_0.game_id)
end

function var_0_0.GetMiniGameHubData()
	return getProxy(MiniGameProxy):GetHubByHubId(var_0_0.hub_id)
end

function var_0_0.CheckRectCollider(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	if arg_7_1.x <= arg_7_0.x and arg_7_0.x >= arg_7_1.x + arg_7_3.width then
		return false
	elseif arg_7_0.x <= arg_7_1.x and arg_7_1.x >= arg_7_0.x + arg_7_2.width then
		return false
	elseif arg_7_1.y <= arg_7_0.y and arg_7_0.y >= arg_7_1.y + arg_7_3.height then
		return false
	elseif arg_7_0.y <= arg_7_1.y and arg_7_1.y >= arg_7_0.y + arg_7_2.height then
		return false
	else
		return true
	end

	return
end

var_0_0.char_id = 1
var_0_0.char_weapons = {
	{},
	{}
}
var_0_0.char_start_pos = Vector2(0, 0)
var_0_0.char_speed = Vector2(300, 300)
var_0_0.char_speed_rate = 1
var_0_0.scene_speed = 60
var_0_0.scene_direct = Vector2(0, -1)
var_0_0.scene_width = 1920
var_0_0.scene_height = 1080
var_0_0.fill_offsetX = 200
var_0_0.fill_offsetY = 100
var_0_0.skillTime = 10
var_0_0.collider_time = 1
var_0_0.colliderDamage = 5
var_0_0.fire_step = 10
var_0_0.bullet_step = 3
var_0_0.item_move_speed = Vector2(1000, 0)
var_0_0.scoreNum = 0
var_0_0.joyStickData = nil
var_0_0.moveAmount = nil
var_0_0.roundData = nil
var_0_0.sceneSpeed = nil
var_0_0.equips = {}
var_0_0.skill = 0
var_0_0.selectRound = nil

function var_0_0.Prepare()
	var_0_0.gameTime = var_0_0.game_time
	var_0_0.gameStepTime = 0
	var_0_0.scoreNum = 0
	var_0_0.moveAmount = Vector2(var_0_0.scene_direct.x * var_0_0.scene_speed, var_0_0.scene_direct.y * var_0_0.scene_speed)
	var_0_0.roundData = SailBoatGameConst.game_round[var_0_0.GetGameRound()]
	var_0_0.sceneSpeed = Vector2(0, 0)
	var_0_0.skill = 1

	return
end

function var_0_0.SetGameTpl(arg_9_0)
	var_0_0.tpl = arg_9_0

	return
end

function var_0_0.SetGameBgs(arg_10_0)
	var_0_0.bg = arg_10_0

	return
end

function var_0_0.GetGameBg(arg_11_0)
	return var_0_0.bg
end

function var_0_0.SetGameChar(arg_12_0)
	var_0_0.char = arg_12_0

	return
end

function var_0_0.GetGameChar()
	return var_0_0.char
end

function var_0_0.SetGameItems(arg_14_0)
	var_0_0.items = arg_14_0

	return
end

function var_0_0.GetBulletSprite(arg_15_0)
	return GetSpriteFromAtlas(var_0_0.ui_atlas, arg_15_0)
end

function var_0_0.GetEquipIcon(arg_16_0)
	return GetSpriteFromAtlas(var_0_0.ui_atlas, arg_16_0)
end

function var_0_0.GetBgIcon(arg_17_0)
	return GetSpriteFromAtlas(var_0_0.ui_atlas, arg_17_0)
end

function var_0_0.GetGameBullet()
	return tf(instantiate(findTF(var_0_0.tpl, "bulletTpl")))
end

function var_0_0.GetGameItems()
	return var_0_0.items
end

function var_0_0.SetGameEnemys(arg_20_0)
	var_0_0.enemys = arg_20_0

	return
end

function var_0_0.GetGameEnemys()
	return var_0_0.enemys
end

function var_0_0.GetGameItemTf(arg_22_0)
	return tf(instantiate(findTF(var_0_0.tpl, arg_22_0)))
end

function var_0_0.GetGameEnemyTf(arg_23_0)
	return tf(instantiate(findTF(var_0_0.tpl, arg_23_0)))
end

function var_0_0.GetGameBgTf(arg_24_0)
	return tf(instantiate(findTF(var_0_0.tpl, arg_24_0)))
end

function var_0_0.GetGameCharTf(arg_25_0)
	return tf(instantiate(findTF(var_0_0.tpl, arg_25_0)))
end

function var_0_0.GetGameEffectTf(arg_26_0)
	return tf(instantiate(findTF(var_0_0.tpl, arg_26_0)))
end

function var_0_0.SetSceneSpeed(arg_27_0)
	var_0_0.sceneSpeed = arg_27_0

	return
end

function var_0_0.GetSceneSpeed()
	return var_0_0.sceneSpeed
end

function var_0_0.AddSkill()
	var_0_0.skill = var_0_0.skill + 1

	return
end

function var_0_0.UseSkill()
	if var_0_0.skill > 0 then
		var_0_0.skill = var_0_0.skill - 1

		return true
	end

	return false
end

function var_0_0.GetSkill()
	return var_0_0.skill
end

function var_0_0.GetRoundData()
	return var_0_0.roundData
end

function var_0_0.GetRangePos(arg_33_0, arg_33_1)
	local var_33_0 = Vector2(math.random(arg_33_0[1], arg_33_0[2]), math.random(arg_33_1[1], arg_33_1[2]))

	if var_0_0.CheckDoublicat(var_33_0) then
		for iter_33_0 = 1, 4 do
			var_33_0.x = var_33_0.x + 100

			if not var_0_0.CheckDoublicat(var_33_0) then
				return var_33_0
			end
		end

		for iter_33_1 = 1, 4 do
			var_33_0.x = var_33_0.x - 100

			if not var_0_0.CheckDoublicat(var_33_0) then
				return var_33_0
			end
		end

		return nil
	else
		return var_33_0
	end

	return
end

function var_0_0.CheckDoublicat(arg_34_0)
	local var_34_0 = var_0_0.GetGameItems()

	for iter_34_0 = 1, #var_34_0 do
		if var_34_0[iter_34_0]:checkPositionInRange(arg_34_0) then
			return true
		end
	end

	local var_34_1 = var_0_0.GetGameEnemys()

	for iter_34_1 = 1, #var_34_1 do
		if var_34_1[iter_34_1]:checkPositionInRange(arg_34_0) then
			return true
		end
	end

	return false
end

function var_0_0.PointInRect1(arg_35_0, arg_35_1, arg_35_2, arg_35_3, arg_35_4)
	local var_35_2 = var_0_0.Sign(arg_35_0, arg_35_2, arg_35_3)
	local var_35_3 = var_0_0.Sign(arg_35_0, arg_35_3, arg_35_4)
	local var_35_4 = var_0_0.Sign(arg_35_0, arg_35_4, arg_35_1)
	local var_35_5 = var_0_0.Sign(arg_35_0, arg_35_1, arg_35_2) > 0 or nil > 0 or nil > 0 or nil > 0

	return not (nil < 0 or nil < 0 or nil < 0 or nil < 0) or not nil
end

function var_0_0.PointInRect2(arg_36_0, arg_36_1, arg_36_2)
	if arg_36_0.x < arg_36_1.x or arg_36_0.y < arg_36_1.y then
		return false
	end

	if arg_36_0.x > arg_36_2.x or arg_36_0.y > arg_36_2.y then
		return false
	end

	return true
end

function var_0_0.Clear()
	var_0_0.tpl = nil
	var_0_0.char = nil

	return
end

return var_0_0
