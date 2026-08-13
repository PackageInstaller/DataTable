class = var_0_10000

local var_0_0 = var_0_10000("SailBoatGameVo")

var_0_0.game_id = nil
var_0_0.hub_id = nil
var_0_0.total_times = nil
var_0_0.drop = nil
var_0_0.menu_bgm = "theme-SeaAndSun-image"
var_0_0.game_bgm = "theme-tempest-up"
var_0_0.game_time = 120
var_0_0.rule_tip = "sail_boat_minigame_help"
Application = var_1

local var_0_1

if not var_1.targetFrameRate then
	var_0_1 = 60
end

var_0_0.frameRate = var_0_1
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

	local var_1_0 = var_0_0

	pg = var_1_10003
	var_1_0.total_times = var_1_10003.mini_game_hub[var_0_0.hub_id]

	local var_1_1 = var_0_0

	pg = var_3
	var_1_1.drop = var_3.mini_game[var_0_0.game_id].simple_config_data.drop_ids

	local var_1_2 = var_0_0

	pg = var_3
	var_1_2.total_times = var_3.mini_game_hub[var_0_0.hub_id].reward_need

	return
end

function var_0_0.GetGameTimes()
	return var_0_0.GetMiniGameHubData().count
end

function var_0_0.GetGameUseTimes()
	local var_3_0

	if not var_0_0.GetMiniGameHubData().usedtime then
		var_3_0 = 0
	end

	return var_3_0
end

function var_0_0.GetGameRound()
	if var_0_0.use_direct_round ~= nil then
		return var_0_0.use_direct_round
	end

	if var_0_0.selectRound ~= nil then
		return var_0_0.selectRound
	end

	local var_4_0 = var_0_0.GetGameUseTimes()

	if var_0_0.GetGameTimes() and var_1 > 0 then
		return var_4_0 + 1
	end

	if var_4_0 and var_4_0 > 0 then
		return var_4_0
	end

	return 1
end

function var_0_0.GetMiniGameData()
	getProxy = var_1_10000
	MiniGameProxy = var_1_10002

	local var_5_0 = var_1_10000(var_1_10002)

	return var_0.GetMiniGameData(var_5_0, var_0_0.game_id)
end

function var_0_0.GetMiniGameHubData()
	getProxy = var_1_10000
	MiniGameProxy = var_1_10002

	local var_6_0 = var_1_10000(var_1_10002)

	return var_0.GetHubByHubId(var_6_0, var_0_0.hub_id)
end

function var_0_0.CheckRectCollider(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = arg_7_0.x
	local var_7_1 = arg_7_0.y
	local var_7_2 = arg_7_2.width
	local var_7_3 = arg_7_2.height
	local var_7_4 = arg_7_1.x
	local var_7_5 = arg_7_1.y
	local var_7_6 = arg_7_3.width
	local var_7_7 = arg_7_3.height

	if var_7_4 <= var_7_0 and var_7_0 >= var_7_4 + var_7_6 then
		return false
	elseif var_7_0 <= var_7_4 and var_7_4 >= var_7_0 + var_7_2 then
		return false
	elseif var_7_5 <= var_7_1 and var_7_1 >= var_7_5 + var_7_7 then
		return false
	elseif var_7_1 <= var_7_5 and var_7_5 >= var_7_1 + var_7_3 then
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
Vector2 = var_1
var_0_0.char_start_pos = var_1(0, 0)
Vector2 = var_1
var_0_0.char_speed = var_1(300, 300)
var_0_0.char_speed_rate = 1
var_0_0.scene_speed = 60
Vector2 = var_1
var_0_0.scene_direct = var_1(0, -1)
var_0_0.scene_width = 1920
var_0_0.scene_height = 1080
var_0_0.fill_offsetX = 200
var_0_0.fill_offsetY = 100
var_0_0.skillTime = 10
var_0_0.collider_time = 1
var_0_0.colliderDamage = 5
var_0_0.fire_step = 10
var_0_0.bullet_step = 3
Vector2 = var_1
var_0_0.item_move_speed = var_1(1000, 0)
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

	local var_8_0 = var_0_0

	Vector2 = var_1
	var_8_0.moveAmount = var_1(var_0_0.scene_direct.x * var_0_0.scene_speed, var_0_0.scene_direct.y * var_0_0.scene_speed)

	local var_8_1 = var_0_0

	SailBoatGameConst = var_1
	var_8_1.roundData = var_1.game_round[var_0_0.GetGameRound()]

	local var_8_2 = var_0_0

	Vector2 = var_1
	var_8_2.sceneSpeed = var_1(0, 0)
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
	GetSpriteFromAtlas = var_1_10001

	return var_1_10001(var_0_0.ui_atlas, arg_15_0)
end

function var_0_0.GetEquipIcon(arg_16_0)
	GetSpriteFromAtlas = var_1_10001

	return var_1_10001(var_0_0.ui_atlas, arg_16_0)
end

function var_0_0.GetBgIcon(arg_17_0)
	GetSpriteFromAtlas = var_1_10001

	return var_1_10001(var_0_0.ui_atlas, arg_17_0)
end

function var_0_0.GetGameBullet()
	tf = var_1_10000
	instantiate = var_1_10002
	findTF = var_1_10004

	return var_1_10000(var_1_10002(var_1_10004(var_0_0.tpl, "bulletTpl")))
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
	tf = var_1_10001
	instantiate = var_1_10003
	findTF = var_1_10005

	return var_1_10001(var_1_10003(var_1_10005(var_0_0.tpl, arg_22_0)))
end

function var_0_0.GetGameEnemyTf(arg_23_0)
	tf = var_1_10001
	instantiate = var_1_10003
	findTF = var_1_10005

	return var_1_10001(var_1_10003(var_1_10005(var_0_0.tpl, arg_23_0)))
end

function var_0_0.GetGameBgTf(arg_24_0)
	tf = var_1_10001
	instantiate = var_1_10003
	findTF = var_1_10005

	return var_1_10001(var_1_10003(var_1_10005(var_0_0.tpl, arg_24_0)))
end

function var_0_0.GetGameCharTf(arg_25_0)
	tf = var_1_10001
	instantiate = var_1_10003
	findTF = var_1_10005

	return var_1_10001(var_1_10003(var_1_10005(var_0_0.tpl, arg_25_0)))
end

function var_0_0.GetGameEffectTf(arg_26_0)
	tf = var_1_10001
	instantiate = var_1_10003
	findTF = var_1_10005

	return var_1_10001(var_1_10003(var_1_10005(var_0_0.tpl, arg_26_0)))
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
	Vector2 = var_1_10002
	math = var_1_10004

	local var_33_0 = var_1_10004.random(arg_33_0[1], arg_33_0[2])

	math = var_1_10005

	local var_33_1 = var_1_10002(var_33_0, var_1_10005.random(arg_33_1[1], arg_33_1[2]))

	if var_0_0.CheckDoublicat(var_33_1) then
		local var_33_2 = var_33_1

		for iter_33_0 = 1, 4 do
			var_33_2.x = var_33_2.x + 100

			if not var_0_0.CheckDoublicat(var_33_2) then
				return var_33_2
			end
		end

		local var_33_3 = var_33_1

		for iter_33_1 = 1, 4 do
			var_33_2.x = var_33_2.x - 100

			if not var_0_0.CheckDoublicat(var_33_2) then
				return var_33_2
			end
		end

		return nil
	else
		return var_33_1
	end

	return
end

function var_0_0.CheckDoublicat(arg_34_0)
	local var_34_0 = var_0_0.GetGameItems()

	for iter_34_0 = 1, #var_34_0 do
		local var_34_1 = var_34_0[iter_34_0]

		if var_6.checkPositionInRange(var_34_1, arg_34_0) then
			return true
		end
	end

	local var_34_2 = var_0_0.GetGameEnemys()

	for iter_34_1 = 1, #var_34_2 do
		local var_34_3 = var_34_2[iter_34_1]

		if var_7.checkPositionInRange(var_34_3, arg_34_0) then
			return true
		end
	end

	return false
end

function var_0_0.PointInRect1(arg_35_0, arg_35_1, arg_35_2, arg_35_3, arg_35_4)
	local var_35_0
	local var_35_1
	local var_35_2
	local var_35_3
	local var_35_4
	local var_35_5
	local var_35_6 = var_0_0.Sign(arg_35_0, arg_35_1, arg_35_2)
	local var_35_7 = var_0_0.Sign(arg_35_0, arg_35_2, arg_35_3)
	local var_35_8 = var_0_0.Sign(arg_35_0, arg_35_3, arg_35_4)
	local var_35_9 = var_0_0.Sign(arg_35_0, arg_35_4, arg_35_1)
	local var_35_10 = var_35_6 < 0 or var_35_7 < 0 or var_35_8 < 0 or var_35_9 < 0
	local var_35_11 = var_35_6 > 0 or var_35_7 > 0 or var_35_8 > 0 or var_35_9 > 0

	return not var_35_10 or not var_35_11
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
