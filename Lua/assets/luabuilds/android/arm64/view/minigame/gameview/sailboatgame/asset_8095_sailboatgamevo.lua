local SailBoatGameVo = class("SailBoatGameVo")

SailBoatGameVo.game_id = nil
SailBoatGameVo.hub_id = nil
SailBoatGameVo.total_times = nil
SailBoatGameVo.drop = nil
SailBoatGameVo.menu_bgm = "theme-SeaAndSun-image"
SailBoatGameVo.game_bgm = "theme-tempest-up"
SailBoatGameVo.game_time = 120
SailBoatGameVo.rule_tip = "sail_boat_minigame_help"
SailBoatGameVo.frameRate = Application.targetFrameRate or 60
SailBoatGameVo.ui_atlas = "ui/minigameui/sailboatgameui_atlas"
SailBoatGameVo.game_ui = "SailBoatGameUI"
SailBoatGameVo.SFX_COUNT_DOWN = "event:/ui/ddldaoshu2"
SailBoatGameVo.SFX_SOUND_FIRE = "event:/ui/kaipao"
SailBoatGameVo.SFX_SOUND_BOOM = "event:/ui/baozha3"
SailBoatGameVo.SFX_SOUND_SKILL = "event:/ui/chongneng"
SailBoatGameVo.SFX_SOUND_ITEM = "event:/ui/mini_shine"
SailBoatGameVo.use_direct_round = nil
SailBoatGameVo.enemyToEndRate = nil
SailBoatGameVo.gameTime = 0
SailBoatGameVo.gameStepTime = 0
SailBoatGameVo.deltaTime = 0

function SailBoatGameVo:Init(arg_1_1)
	SailBoatGameVo.game_id = self
	SailBoatGameVo.hub_id = arg_1_1
	SailBoatGameVo.total_times = pg.mini_game_hub[SailBoatGameVo.hub_id]
	SailBoatGameVo.drop = pg.mini_game[SailBoatGameVo.game_id].simple_config_data.drop_ids
	SailBoatGameVo.total_times = pg.mini_game_hub[SailBoatGameVo.hub_id].reward_need

	return
end

function SailBoatGameVo.GetGameTimes()
	return SailBoatGameVo.GetMiniGameHubData().count
end

function SailBoatGameVo.GetGameUseTimes()
	return SailBoatGameVo.GetMiniGameHubData().usedtime or 0
end

function SailBoatGameVo.GetGameRound()
	if SailBoatGameVo.use_direct_round ~= nil then
		return SailBoatGameVo.use_direct_round
	end

	if SailBoatGameVo.selectRound ~= nil then
		return SailBoatGameVo.selectRound
	end

	local var_4_0 = SailBoatGameVo.GetGameUseTimes()
	local var_4_1 = SailBoatGameVo.GetGameTimes()

	if var_4_1 and var_4_1 > 0 then
		return var_4_0 + 1
	end

	if var_4_0 and var_4_0 > 0 then
		return var_4_0
	end

	return 1
end

function SailBoatGameVo.GetMiniGameData()
	return getProxy(MiniGameProxy):GetMiniGameData(SailBoatGameVo.game_id)
end

function SailBoatGameVo.GetMiniGameHubData()
	return getProxy(MiniGameProxy):GetHubByHubId(SailBoatGameVo.hub_id)
end

function SailBoatGameVo:CheckRectCollider(arg_7_1, arg_7_2, arg_7_3)
	if arg_7_1.x <= self.x and self.x >= arg_7_1.x + arg_7_3.width then
		return false
	elseif self.x <= arg_7_1.x and arg_7_1.x >= self.x + arg_7_2.width then
		return false
	elseif arg_7_1.y <= self.y and self.y >= arg_7_1.y + arg_7_3.height then
		return false
	elseif self.y <= arg_7_1.y and arg_7_1.y >= self.y + arg_7_2.height then
		return false
	else
		return true
	end

	return
end

SailBoatGameVo.char_id = 1
SailBoatGameVo.char_weapons = {
	{},
	{}
}
SailBoatGameVo.char_start_pos = Vector2(0, 0)
SailBoatGameVo.char_speed = Vector2(300, 300)
SailBoatGameVo.char_speed_rate = 1
SailBoatGameVo.scene_speed = 60
SailBoatGameVo.scene_direct = Vector2(0, -1)
SailBoatGameVo.scene_width = 1920
SailBoatGameVo.scene_height = 1080
SailBoatGameVo.fill_offsetX = 200
SailBoatGameVo.fill_offsetY = 100
SailBoatGameVo.skillTime = 10
SailBoatGameVo.collider_time = 1
SailBoatGameVo.colliderDamage = 5
SailBoatGameVo.fire_step = 10
SailBoatGameVo.bullet_step = 3
SailBoatGameVo.item_move_speed = Vector2(1000, 0)
SailBoatGameVo.scoreNum = 0
SailBoatGameVo.joyStickData = nil
SailBoatGameVo.moveAmount = nil
SailBoatGameVo.roundData = nil
SailBoatGameVo.sceneSpeed = nil
SailBoatGameVo.equips = {}
SailBoatGameVo.skill = 0
SailBoatGameVo.selectRound = nil

function SailBoatGameVo.Prepare()
	SailBoatGameVo.gameTime = SailBoatGameVo.game_time
	SailBoatGameVo.gameStepTime = 0
	SailBoatGameVo.scoreNum = 0
	SailBoatGameVo.moveAmount = Vector2(SailBoatGameVo.scene_direct.x * SailBoatGameVo.scene_speed, SailBoatGameVo.scene_direct.y * SailBoatGameVo.scene_speed)
	SailBoatGameVo.roundData = SailBoatGameConst.game_round[SailBoatGameVo.GetGameRound()]
	SailBoatGameVo.sceneSpeed = Vector2(0, 0)
	SailBoatGameVo.skill = 1

	return
end

function SailBoatGameVo:SetGameTpl()
	SailBoatGameVo.tpl = self

	return
end

function SailBoatGameVo:SetGameBgs()
	SailBoatGameVo.bg = self

	return
end

function SailBoatGameVo:GetGameBg()
	return SailBoatGameVo.bg
end

function SailBoatGameVo:SetGameChar()
	SailBoatGameVo.char = self

	return
end

function SailBoatGameVo.GetGameChar()
	return SailBoatGameVo.char
end

function SailBoatGameVo:SetGameItems()
	SailBoatGameVo.items = self

	return
end

function SailBoatGameVo:GetBulletSprite()
	return GetSpriteFromAtlas(SailBoatGameVo.ui_atlas, self)
end

function SailBoatGameVo:GetEquipIcon()
	return GetSpriteFromAtlas(SailBoatGameVo.ui_atlas, self)
end

function SailBoatGameVo:GetBgIcon()
	return GetSpriteFromAtlas(SailBoatGameVo.ui_atlas, self)
end

function SailBoatGameVo.GetGameBullet()
	return tf(instantiate(findTF(SailBoatGameVo.tpl, "bulletTpl")))
end

function SailBoatGameVo.GetGameItems()
	return SailBoatGameVo.items
end

function SailBoatGameVo:SetGameEnemys()
	SailBoatGameVo.enemys = self

	return
end

function SailBoatGameVo.GetGameEnemys()
	return SailBoatGameVo.enemys
end

function SailBoatGameVo:GetGameItemTf()
	return tf(instantiate(findTF(SailBoatGameVo.tpl, self)))
end

function SailBoatGameVo:GetGameEnemyTf()
	return tf(instantiate(findTF(SailBoatGameVo.tpl, self)))
end

function SailBoatGameVo:GetGameBgTf()
	return tf(instantiate(findTF(SailBoatGameVo.tpl, self)))
end

function SailBoatGameVo:GetGameCharTf()
	return tf(instantiate(findTF(SailBoatGameVo.tpl, self)))
end

function SailBoatGameVo:GetGameEffectTf()
	return tf(instantiate(findTF(SailBoatGameVo.tpl, self)))
end

function SailBoatGameVo:SetSceneSpeed()
	SailBoatGameVo.sceneSpeed = self

	return
end

function SailBoatGameVo.GetSceneSpeed()
	return SailBoatGameVo.sceneSpeed
end

function SailBoatGameVo.AddSkill()
	SailBoatGameVo.skill = SailBoatGameVo.skill + 1

	return
end

function SailBoatGameVo.UseSkill()
	if SailBoatGameVo.skill > 0 then
		SailBoatGameVo.skill = SailBoatGameVo.skill - 1

		return true
	end

	return false
end

function SailBoatGameVo.GetSkill()
	return SailBoatGameVo.skill
end

function SailBoatGameVo.GetRoundData()
	return SailBoatGameVo.roundData
end

function SailBoatGameVo:GetRangePos(arg_33_1)
	local var_33_0 = Vector2(math.random(self[1], self[2]), math.random(arg_33_1[1], arg_33_1[2]))

	if SailBoatGameVo.CheckDoublicat(var_33_0) then
		for iter_33_0 = 1, 4 do
			var_33_0.x = var_33_0.x + 100

			if not SailBoatGameVo.CheckDoublicat(var_33_0) then
				return var_33_0
			end
		end

		for iter_33_1 = 1, 4 do
			var_33_0.x = var_33_0.x - 100

			if not SailBoatGameVo.CheckDoublicat(var_33_0) then
				return var_33_0
			end
		end

		return nil
	else
		return var_33_0
	end

	return
end

function SailBoatGameVo:CheckDoublicat()
	local var_34_0 = SailBoatGameVo.GetGameItems()

	for iter_34_0 = 1, #var_34_0 do
		if var_34_0[iter_34_0]:checkPositionInRange(self) then
			return true
		end
	end

	local var_34_1 = SailBoatGameVo.GetGameEnemys()

	for iter_34_1 = 1, #var_34_1 do
		if var_34_1[iter_34_1]:checkPositionInRange(self) then
			return true
		end
	end

	return false
end

function SailBoatGameVo:PointInRect1(arg_35_1, arg_35_2, arg_35_3, arg_35_4)
	local var_35_2 = SailBoatGameVo.Sign(self, arg_35_2, arg_35_3)
	local var_35_3 = SailBoatGameVo.Sign(self, arg_35_3, arg_35_4)
	local var_35_4 = SailBoatGameVo.Sign(self, arg_35_4, arg_35_1)
	local var_35_5 = SailBoatGameVo.Sign(self, arg_35_1, arg_35_2) > 0 or nil > 0 or nil > 0 or nil > 0

	return not (nil < 0 or nil < 0 or nil < 0 or nil < 0) or not nil
end

function SailBoatGameVo:PointInRect2(arg_36_1, arg_36_2)
	if self.x < arg_36_1.x or self.y < arg_36_1.y then
		return false
	end

	if self.x > arg_36_2.x or self.y > arg_36_2.y then
		return false
	end

	return true
end

function SailBoatGameVo.Clear()
	SailBoatGameVo.tpl = nil
	SailBoatGameVo.char = nil

	return
end

return SailBoatGameVo
