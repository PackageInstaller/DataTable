SmallFightLayer = class("SmallFightLayer", function()
	return cc.Layer:create()
end)

local level_manager = require("controller.level_manager")
local arena_manager = require("controller.arena_manager")
local audio_manager = require("controller.audio_manager")
local explore_manager = require("controller.explore_manager")
local rogue_explore_manager = require("controller.rogue_explore_manager")
local aiattack_manager = require("controller.aiattack_manager")
local activity_manager = require("controller.activity_manager")
local parse_server = require("controller.parse_server")
local substitution_manager = require("controller.substitution_manager")
local playermodel = require("model.playermodel")
local test_fight_manager = require("controller.test_fight_manager")
local FightEventManager = require("fight.FightEventManager")
local HorcruxSkillSP = require("view.Sprite.HorcruxSkillSP")
local var_0_13
local var_0_14 = GameDisplay.height * ORIGIN_FIGHT_HEIGHT / GameDisplay.origin_design_y - GameDisplay.fix_y
local var_0_15 = 640
local var_0_16 = 800
local var_0_17 = -420
local var_0_18 = -(GameDisplay.height * ORIGIN_FIGHT_HEIGHT / GameDisplay.origin_design_y - GameDisplay.fix_y) - GameDisplay.fix_y
local var_0_19 = "mainScenebg/drop_gold.png"
local var_0_20
local var_0_21 = {}
local var_0_22 = 0

function SmallFightLayer.create(arg_2_0)
	local var_2_0 = SmallFightLayer.new()

	var_2_0:init()
	var_2_0:setPosition(cc.p(0, var_0_14))

	return var_2_0
end

function SmallFightLayer.getInstance()
	return var_0_13
end

function SmallFightLayer:init()
	var_0_13 = self

	FightManager.attachBattleField(self)

	self.bgPanel = ccui.Layout:create()

	self.bgPanel:setAnchorPoint(cc.p(0, 0))
	self.bgPanel:setPosition(cc.p(0, 5))
	self.bgPanel:setContentSize(cc.size(var_0_15, var_0_16))
	self:addChild(self.bgPanel)
	self:initFightMap()
	self:registerScriptHandler(function(arg_5_0)
		if arg_5_0 == "exit" then
			FightManager.detachBattleField()

			var_0_13 = nil
		end
	end)
end

function SmallFightLayer:onFirstCreate()
	self.bgPanel:getChildByName("mapcover"):runAction(cc.Sequence:create(cc.FadeIn:create(0.2), cc.DelayTime:create(0.1), cc.FadeOut:create(0.3), cc.RemoveSelf:create()))
	self.map:runAction(cc.Sequence:create(cc.DelayTime:create(0.3), cc.Show:create()))
end

function SmallFightLayer:initFightMap()
	self.map = ccui.Layout:create()

	self.map:setContentSize(cc.size(var_0_15, var_0_16))
	self.map:setAnchorPoint(cc.p(0.5, 0))
	self.map:setPosition(cc.p(var_0_15 / 2, 0))
	self.map:setVisible(false)
	self.bgPanel:addChild(self.map)

	self.goldBatchNode = cc.SpriteBatchNode:create(var_0_19)

	self.goldBatchNode:setPosition(cc.p(0, 0))
	self.map:addChild(self.goldBatchNode, 0)

	local var_7_0 = level_manager.getCurLevelData(playermodel.curMode, playermodel.curLevel)

	for iter_7_0 = 1, 3 do
		var_0_21[iter_7_0] = FIGHT_BG_PATH .. var_7_0["sceneConfigure" .. iter_7_0] .. ".png"
	end

	var_0_20 = {
		{},
		{}
	}

	for iter_7_1 = 1, 2 do
		for iter_7_2 = 1, 3 do
			var_0_20[iter_7_1][iter_7_2] = cc.Sprite:create(var_0_21[iter_7_2])

			var_0_20[iter_7_1][iter_7_2]:setAnchorPoint(cc.p(0, 0))
			var_0_20[iter_7_1][iter_7_2]:setPosition(cc.p(-100 + (iter_7_1 - 1) * var_0_20[iter_7_1][iter_7_2]:getContentSize().width, var_0_17))
			self.map:addChild(var_0_20[iter_7_1][iter_7_2], -iter_7_2)
		end
	end

	FightManager.initCamera({
		map = self.map,
		bg = var_0_20
	})

	local var_7_1 = cc.LayerColor:create(cc.c4b(0, 0, 0, 0), var_0_15, GameDisplay.height)

	var_7_1:setAnchorPoint(cc.p(0, 0))
	var_7_1:setPosition(cc.p(0, var_0_18))
	var_7_1:setName("mapcover")
	self.bgPanel:addChild(var_7_1, 100)
end

function SmallFightLayer.initHorcruxPanels(arg_8_0)
	print("initHorcruxPanels is Deprecated...")
end

function SmallFightLayer.hideEnemyHorcrux(arg_9_0)
	print("hideEnemyHorcrux is Deprecated...")
end

function SmallFightLayer.showEnemyHorcrux(arg_10_0)
	print("showEnemyHorcrux is Deprecated...")
end

function SmallFightLayer.hidePlayerHorcrux(arg_11_0)
	print("hidePlayerHorcrux is Deprecated...")
end

function SmallFightLayer.showHorcruxSkillEffect(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4, arg_12_5)
	print("showHorcruxSkillEffect is Deprecated...")
end

local function var_0_23(arg_13_0)
	if not arg_13_0[1] then
		return
	end

	if var_0_21[1] == arg_13_0[1] then
		return
	end

	for iter_13_0 = 1, 2 do
		for iter_13_1 = 1, 3 do
			var_0_20[iter_13_0][iter_13_1]:setTexture(FIGHT_BG_PATH .. arg_13_0[iter_13_1] .. ".png")
			var_0_20[iter_13_0][iter_13_1]:setPosition(cc.p(-100 + (iter_13_0 - 1) * var_0_20[iter_13_0][iter_13_1]:getContentSize().width, var_0_17))
		end
	end

	for iter_13_2 = 1, 3 do
		var_0_21[iter_13_2] = arg_13_0[iter_13_2]
	end
end

function SmallFightLayer.updateFightMap(arg_14_0, arg_14_1, arg_14_2)
	if type(arg_14_1) == "table" then
		var_0_23(arg_14_1)
	elseif type(arg_14_1) == "string" then
		if arg_14_1 == "scorearenafight" then
			var_0_23({
				"fightbg29_1",
				"fightbg29_2",
				"fightbg29_3"
			})
		elseif arg_14_1 == "arenafight" then
			var_0_23({
				"fightbg1_1",
				"fightbg1_2",
				"fightbg1_3"
			})
		elseif arg_14_1 == "arenatftfight" then
			var_0_23({
				"fightbg3v3_1",
				"fightbg3v3_2",
				"fightbg3v3_3"
			})
		elseif arg_14_1 == "arenafriendfight" then
			var_0_23({
				"fightbg1_1",
				"fightbg1_2",
				"fightbg1_3"
			})
		elseif arg_14_1 == "explorefight" then
			local var_14_0 = explore_manager.getExploreCurLevelData()

			if newtexture ~= var_14_0.sceneConfigure1 then
				local var_14_1 = {}

				for iter_14_0 = 1, 3 do
					var_14_1[iter_14_0] = var_14_0["sceneConfigure" .. iter_14_0]
				end

				var_0_23(var_14_1)
			end
		elseif arg_14_1 == "rogueExplorefight" then
			local var_14_2 = rogue_explore_manager.getExploreCurLevelData()

			if newtexture ~= var_14_2.sceneConfigure1 then
				local var_14_3 = {}

				for iter_14_1 = 1, 3 do
					var_14_3[iter_14_1] = var_14_2["sceneConfigure" .. iter_14_1]
				end

				var_0_23(var_14_3)
			end
		elseif arg_14_1 == "expeditionfight" then
			local var_14_4 = require("controller.expedition_manager"):getExpeditionCurLevelData()

			if newtexture ~= var_14_4.sceneConfigure1 then
				local var_14_5 = {}

				for iter_14_2 = 1, 3 do
					var_14_5[iter_14_2] = var_14_4["sceneConfigure" .. iter_14_2]
				end

				var_0_23(var_14_5)
			end
		elseif arg_14_1 == "monopolyfight" then
			local monopoly_manager = require("controller.monopoly.monopoly_manager")
			local var_14_7 = monopoly_manager:getInstance():getCurLevelData()

			if newtexture ~= monopoly_manager.sceneConfigure1 then
				local var_14_8 = {}

				for iter_14_3 = 1, 3 do
					var_14_8[iter_14_3] = var_14_7["sceneConfigure" .. iter_14_3]
				end

				var_0_23(var_14_8)
			end
		elseif arg_14_1 == "flychessfight" then
			local var_14_9 = require("controller.activity_manager"):getFlyChessCurLevelData()

			if newtexture ~= var_14_9.sceneConfigure1 then
				local var_14_10 = {}

				for iter_14_4 = 1, 3 do
					var_14_10[iter_14_4] = var_14_9["sceneConfigure" .. iter_14_4]
				end

				var_0_23(var_14_10)
			end
		end
	else
		local var_14_11 = level_manager.getCurLevelData(arg_14_1, arg_14_2)

		if newtexture ~= var_14_11.sceneConfigure1 then
			local var_14_12 = {}

			for iter_14_5 = 1, 3 do
				var_14_12[iter_14_5] = var_14_11["sceneConfigure" .. iter_14_5]
			end

			var_0_23(var_14_12)
		end
	end
end

function SmallFightLayer:addCharacter(arg_15_1, arg_15_2, arg_15_3, arg_15_4)
	arg_15_1:setPosition(cc.p(arg_15_2, arg_15_3))
	self.map:addChild(arg_15_1, arg_15_4)
end

function SmallFightLayer:addBullet(arg_16_1, arg_16_2)
	arg_16_2 = arg_16_2 or 10

	self.map:addChild(arg_16_1, arg_16_2)
end

SmallFightLayer.addEffect = SmallFightLayer.addBullet

function SmallFightLayer:addFightUI(arg_17_1)
	self.bgPanel:addChild(arg_17_1, 2)
end

function SmallFightLayer:addXPBg(arg_18_1)
	self.map:addChild(arg_18_1, var_0_22)
end

function SmallFightLayer:addXPEffect(arg_19_1, arg_19_2, arg_19_3)
	if arg_19_3 then
		global_basic_scene:addChild(arg_19_1, 5)
	else
		arg_19_1:setPosition(cc.p(320, 400))

		arg_19_2 = arg_19_2 or 0

		if arg_19_2 > 50 then
			self.bgPanel:addChild(arg_19_1, arg_19_2)
		else
			self.map:addChild(arg_19_1, arg_19_2)
		end
	end
end

function SmallFightLayer:getCaptainUIPosByIndex(arg_20_1)
	if arg_20_1 then
		return arg_20_1, cc.p(300 + 100 * ((arg_20_1 + 1) % 2), (GameDisplay.height - var_0_14 - GameDisplay.fix_y) * ((GameDisplay.origin_design_y - ORIGIN_FIGHT_HEIGHT - 100) / (GameDisplay.origin_design_y - ORIGIN_FIGHT_HEIGHT)) - 100 * (arg_20_1 - 1))
	else
		local var_20_0 = 1

		while self.bgPanel:getChildByName("captainhpbar" .. 1) do
			var_20_0 = var_20_0 + 1

			local var_20_1 = self.bgPanel:getChildByName("captainhpbar" .. var_20_0)
		end

		return var_20_0, cc.p(300 + 100 * ((var_20_0 + 1) % 2), (GameDisplay.height - var_0_14 - GameDisplay.fix_y) * ((GameDisplay.origin_design_y - ORIGIN_FIGHT_HEIGHT - 100) / (GameDisplay.origin_design_y - ORIGIN_FIGHT_HEIGHT)) - 100 * (var_20_0 - 1))
	end
end

function SmallFightLayer:pushCaptainUI(arg_21_1, arg_21_2, arg_21_3)
	arg_21_2 = arg_21_2 or cc.p(0, 0)

	local var_21_1, var_21_2 = self:getCaptainUIPosByIndex(arg_21_3)

	arg_21_3 = var_21_1

	arg_21_1:setPosition(cc.p(var_21_2.x + arg_21_2.x, var_21_2.y + arg_21_2.y))
	self.bgPanel:addChild(arg_21_1, 2)

	return arg_21_3
end

function SmallFightLayer:playLockAni(arg_22_1, arg_22_2)
	local var_22_0 = arg_22_1.texture and L2Skeleton:create(UI_SPINE_PATH .. arg_22_1.file .. ".json", UI_SPINE_PATH .. arg_22_1.file .. ".atlas", {
		slotName = "role",
		attachmentName = "xp/role",
		fileName = arg_22_1.texture
	}) or L2Skeleton:create(UI_SPINE_PATH .. arg_22_1.file .. ".json", UI_SPINE_PATH .. arg_22_1.file .. ".atlas")

	var_22_0:refreshSkeleton()

	if arg_22_1.dir == -1 then
		var_22_0:setPosition(cc.p(640, 0))
		var_22_0:setScale(-1, 1)
	else
		var_22_0:setPosition(cc.p(0, 0))
	end

	self.map:addChild(var_22_0, arg_22_1.zorder or 0)
	var_22_0:registerListener(SP_ANIMATION_COMPLETE, function(arg_23_0)
		if arg_22_2 then
			arg_22_2()
		end

		var_22_0:runAction(cc.RemoveSelf:create())
	end)
	var_22_0:play(arg_22_1.ani, false)
end

function SmallFightLayer:shake_screen(arg_24_1, arg_24_2)
	local var_24_0 = {}
	local var_24_1 = 0.08

	for iter_24_0 = 1, 5 do
		var_24_0[iter_24_0] = cc.Sequence:create(cc.EaseInOut:create(cc.MoveBy:create(var_24_1 / iter_24_0, cc.p(arg_24_1 * 10 / iter_24_0 * (iter_24_0 % 2 == 0 and -1 or 1), arg_24_2 * 10 / iter_24_0 * (iter_24_0 % 2 == 0 and -1 or 1))), 2), cc.EaseInOut:create(cc.MoveBy:create(var_24_1 / iter_24_0, cc.p(-(arg_24_1 * 10 / iter_24_0 * (iter_24_0 % 2 == 0 and -1 or 1)), -(arg_24_2 * 10 / iter_24_0 * (iter_24_0 % 2 == 0 and -1 or 1)))), 2))
	end

	self.map:runAction(cc.Sequence:create(var_24_0[1], var_24_0[2], var_24_0[3], var_24_0[4], var_24_0[5]))
end

function SmallFightLayer.isNormalFight(arg_25_0)
	return FightManager.isNormalFight()
end

function SmallFightLayer.isPVEFight(arg_26_0)
	return FightManager.isPVEFight()
end

function SmallFightLayer.isPVPFight(arg_27_0)
	return FightManager.isPVPFight()
end

function SmallFightLayer.isGuideFight(arg_28_0)
	return FightManager.isGuideFight()
end

function SmallFightLayer.canSwitchFight(arg_29_0)
	return FightManager.canSwitchFight()
end

function SmallFightLayer.switchFight(arg_30_0, arg_30_1)
	FightManager.switchFight(arg_30_1)
end

function SmallFightLayer.playBosswarning(arg_31_0)
	if LayerManager:getCurrentLayerName() ~= "FightLayer" then
		return
	end

	if FightLayer.getInstance():getChildByName("warninglayer") then
		return
	end

	local var_31_0 = cc.Layer:create()

	var_31_0:setName("warninglayer")
	FightLayer.getInstance():addChild(var_31_0, -1)

	local var_31_1 = cc.LayerColor:create(cc.c4b(0, 0, 0, 200), var_0_15, GameDisplay.height)

	var_31_1:setPosition(cc.p(0, var_0_18))
	var_31_0:addChild(var_31_1, -1)

	local var_31_2

	if config._DEBUG then
		var_31_2 = cc.Scale9Sprite:create("fight/bosscomeframe.png") or cc.Scale9Sprite:createWithSpriteFrameName("fight/bosscomeframe.png")
	end

	var_31_2:setCapInsets(cc.rect(75, 140, 5, 5))
	var_31_2:setPreferredSize(cc.size(var_0_15, var_0_16 - 100))
	var_31_2:setAnchorPoint(cc.p(0.5, 0.5))
	var_31_2:setPosition(cc.p(320, 460 + var_0_16 / 2 - 50))
	var_31_2:setVisible(false)
	var_31_2:setOpacity(0)
	var_31_0:addChild(var_31_2)

	local var_31_3

	if config._DEBUG then
		var_31_3 = cc.Sprite:create("fight/bosscomebg1.png") or cc.Sprite:createWithSpriteFrameName("fight/bosscomebg1.png")
	end

	var_31_3:setPosition(cc.p(320, 460 + var_0_16 / 2))
	var_31_3:setOpacity(0)
	var_31_3:setScaleX(0.1)
	var_31_0:addChild(var_31_3, 2)

	local var_31_4

	if config._DEBUG then
		var_31_4 = cc.Sprite:create("fight/bosscomebg2.png") or cc.Sprite:createWithSpriteFrameName("fight/bosscomebg2.png")
	end

	var_31_4:setPosition(cc.p(320, 460 + var_0_16 / 2))
	var_31_4:setScaleX(0.1)
	var_31_4:setCascadeOpacityEnabled(true)
	var_31_0:addChild(var_31_4, 1)

	local var_31_5

	if config._DEBUG then
		var_31_5 = cc.Sprite:create("fight/bosscomeword1.png") or cc.Sprite:createWithSpriteFrameName("fight/bosscomeword1.png")
	end

	var_31_5:setPosition(cc.p(-var_31_5:getContentSize().width / 2, var_31_4:getContentSize().height / 2))
	var_31_5:setVisible(false)
	var_31_4:addChild(var_31_5, 1)

	local var_31_6

	if config._DEBUG then
		var_31_6 = cc.Sprite:create("fight/bosscomeword2.png") or cc.Sprite:createWithSpriteFrameName("fight/bosscomeword2.png")
	end

	var_31_6:setPosition(cc.p(640 + var_31_6:getContentSize().width / 2, var_31_4:getContentSize().height / 2))
	var_31_6:setVisible(false)
	var_31_4:addChild(var_31_6, 1)

	local var_31_7

	if config._DEBUG then
		var_31_7 = cc.Sprite:create("fight/bosscomelattice.png") or cc.Sprite:createWithSpriteFrameName("fight/bosscomelattice.png")
	end

	var_31_7:setPosition(cc.p(115, var_31_4:getContentSize().height / 2 + 56))
	var_31_7:setVisible(false)
	var_31_4:addChild(var_31_7)

	local var_31_8

	if config._DEBUG then
		var_31_8 = cc.Sprite:create("fight/bosscomelattice.png") or cc.Sprite:createWithSpriteFrameName("fight/bosscomelattice.png")
	end

	var_31_8:setPosition(cc.p(525, var_31_4:getContentSize().height / 2 - 56))
	var_31_8:setVisible(false)
	var_31_4:addChild(var_31_8)
	var_31_3:runAction(cc.Sequence:create(cc.FadeIn:create(0.2), cc.FadeOut:create(0.2)))
	var_31_3:runAction(cc.ScaleTo:create(0.3, var_0_15 / var_31_3:getContentSize().width, 1))
	var_31_4:runAction(cc.ScaleTo:create(0.3, 1, 1))
	var_31_5:runAction(cc.Sequence:create(cc.DelayTime:create(0.3), cc.Show:create(), cc.EaseInOut:create(cc.MoveBy:create(0.2, cc.p(320, 0)), 2)))
	var_31_6:runAction(cc.Sequence:create(cc.DelayTime:create(0.3), cc.Show:create(), cc.EaseInOut:create(cc.MoveBy:create(0.2, cc.p(-320, 0)), 2)))
	var_31_7:runAction(cc.Sequence:create(cc.DelayTime:create(0.3), cc.Show:create(), cc.DelayTime:create(0.3), cc.MoveBy:create(0.3, cc.p(640, 0))))
	var_31_8:runAction(cc.Sequence:create(cc.DelayTime:create(0.3), cc.Show:create(), cc.DelayTime:create(0.3), cc.MoveBy:create(0.3, cc.p(-640, 0))))
	var_31_2:runAction(cc.Sequence:create(cc.DelayTime:create(0.3), cc.Show:create(), cc.FadeTo:create(0.2, 255), cc.DelayTime:create(0.1), cc.FadeTo:create(0.2, 100), cc.DelayTime:create(0.1), cc.FadeTo:create(0.2, 255), cc.DelayTime:create(0.1), cc.FadeTo:create(0.2, 100), cc.DelayTime:create(0.1), cc.FadeTo:create(0.2, 255), cc.DelayTime:create(0.1), cc.FadeOut:create(0.2)))
	var_31_4:runAction(cc.Sequence:create(cc.DelayTime:create(0.7), cc.FadeTo:create(0.2, 100), cc.DelayTime:create(0.1), cc.FadeTo:create(0.2, 255), cc.DelayTime:create(0.1), cc.FadeTo:create(0.2, 100), cc.DelayTime:create(0.1), cc.FadeTo:create(0.2, 255), cc.ScaleTo:create(0.2, 1, 0.1), cc.Hide:create()))
	var_31_0:runAction(cc.Sequence:create(cc.DelayTime:create(2), cc.RemoveSelf:create()))
	audio_manager:playeffectMusic("sound/bosscoming")
end

function SmallFightLayer.updateWave(arg_32_0)
	FightLayer.getInstance():updateWave()
end

function SmallFightLayer.updateArenatftWave(arg_33_0)
	FightLayer.getInstance():updateArenatftWave()
end

function SmallFightLayer.updateInfinteWave(arg_34_0)
	FightLayer.getInstance():updateInfinteWave()
end

function SmallFightLayer:playBossSuccessEffect(arg_35_1, arg_35_2, arg_35_3)
	local var_35_0 = L2Skeleton:create(UI_SPINE_PATH .. "win.json", UI_SPINE_PATH .. "win.atlas")

	var_35_0:refreshSkeleton()
	var_35_0:setPosition(cc.p(var_0_15 / 2, var_0_16 / 2))
	self:addChild(var_35_0)
	audio_manager:playFightEffect("sound/smallWin")

	self._canplaytheater = true

	var_35_0:registerListener(SP_ANIMATION_COMPLETE, function(arg_36_0)
		if arg_36_0.animation == "win" then
			if arg_35_3 then
				arg_35_3()
			end

			var_35_0:runAction(cc.RemoveSelf:create())
		end
	end)
	var_35_0:play("win", false)
end

function SmallFightLayer.normalFightSuccess(arg_37_0, arg_37_1)
	local var_37_0 = playermodel.curMode
	local var_37_1 = playermodel.curLevel

	local function var_37_2()
		if arg_37_0._canplaytheater then
			FightEventManager:triggerFightEventListener(FIGHT_LISTENER_ON_PASSLEVEL, var_37_0, var_37_1, function(arg_39_0)
				FightLayer.getInstance():chapterSettlement(arg_39_0)
			end)
		end
	end

	parse_server:passLevel(playermodel.curMode, playermodel.curLevel, function()
		arg_37_0:playBossSuccessEffect(var_37_0, var_37_1, var_37_2)

		if arg_37_1 then
			arg_37_1()
		end
	end)
end

function SmallFightLayer:normalFightSuccess(arg_41_1, arg_41_2, arg_41_3)
	self:playBossSuccessEffect(passmode, passlevel)

	if arg_41_3 then
		arg_41_3()
	end
end

function SmallFightLayer:bossFightSuccess(arg_42_1, arg_42_2, arg_42_3, arg_42_4)
	self:playBossSuccessEffect(arg_42_1, arg_42_2, function()
		FightLayer.getInstance():chapterSettlement({
			createPopLayerCallBack = true,
			data = arg_42_4,
			mode = arg_42_1,
			level = arg_42_2
		}, function(arg_44_0, arg_44_1)
			if FightManager.isBigBossRefight() then
				if arg_42_3.playcallback then
					arg_42_3.playcallback(arg_44_0)
				end
			elseif self._canplaytheater then
				FightEventManager:triggerFightEventListener(FIGHT_LISTENER_ON_PASSLEVEL, arg_42_1, arg_42_2, arg_42_3, arg_44_0, arg_44_1)
			elseif arg_42_3.playcallback then
				arg_42_3.playcallback()
			end
		end)
	end)
	audio_manager:setbackgroundMusicVolume(BOSS_VOLUME * 0.5)
end

function SmallFightLayer:adventureFightSuccess(arg_45_1, arg_45_2, arg_45_3)
	audio_manager:playFightEffect(FIGHT_WIN_EFFECT)

	local var_45_0 = tonumber(arg_45_2:match("^%d+"))
	local var_45_1 = arg_45_3.cancelcallback

	self:playBossSuccessEffect(arg_45_1, arg_45_2, function()
		LayerManager:pushInLayer("PopAdventureResultLayer", {
			createPopLayerCallBack = true,
			mode = arg_45_1,
			level = arg_45_2,
			clear = level_manager:isLevelModeComplete(arg_45_1, var_45_0),
			continuecallback = arg_45_3.continuecallback,
			cancelcallback = var_45_1,
			refightcallback = arg_45_3.refightcallback,
			data = arg_45_3.data,
			isrefight = arg_45_3.isrefight,
			remainfighttime = arg_45_3.remainfighttime,
			canbuytime = arg_45_3.canbuytime
		})
	end)
	audio_manager:setbackgroundMusicVolume(BOSS_VOLUME * 0.5)
end

function SmallFightLayer:groupFightSuccess(arg_47_1, arg_47_2, arg_47_3)
	audio_manager:playFightEffect(FIGHT_WIN_EFFECT)

	local var_47_0 = tonumber(arg_47_2:match("^%d+"))

	self:playBossSuccessEffect(arg_47_1, arg_47_2, function()
		LayerManager:pushInLayer("PopAdventureResultLayer", {
			createPopLayerCallBack = true,
			modelid = arg_47_3.modelid,
			mode = arg_47_1,
			level = arg_47_2,
			clear = level_manager:isLevelModeComplete(arg_47_1, var_47_0),
			data = arg_47_3.data,
			continuecallback = arg_47_3.continuecallback,
			cancelcallback = arg_47_3.cancelcallback,
			isrefight = arg_47_3.isrefight,
			remainfighttime = arg_47_3.remainfighttime
		})
	end)
	audio_manager:setbackgroundMusicVolume(BOSS_VOLUME * 0.5)
end

function SmallFightLayer.arenaFightSuccess(arg_49_0, arg_49_1, arg_49_2, arg_49_3, arg_49_4)
	arg_49_3.enemyArray = {}

	for iter_49_0, iter_49_1 in pairs(FightManager.getStatisticModels().enemies) do
		table.insert(arg_49_3.enemyArray, {
			model = iter_49_1
		})
	end

	local var_49_0 = {
		fightResult = "win",
		fightData = FightManager.getStatisticsMsg(),
		rankChange = arg_49_3,
		addHonor = arg_49_2,
		exitcallback = function()
			LayerManager:switchShowLayer("ArenaLayer")

			if arg_49_4 then
				arg_49_4()
			end
		end
	}
	local var_49_1 = 0
	local var_49_2 = 0
	local var_49_3 = {
		area_rank_old = var_49_0.rankChange.oldRank,
		area_rank_new = var_49_0.rankChange.enemyRank
	}

	for iter_49_2, iter_49_3 in pairs(require("controller.arena_manager"):getCurArenaData().playerarray) do
		if type(iter_49_3) == "table" and iter_49_3.servantid then
			var_49_3["area_role" .. iter_49_2 .. "_id"] = iter_49_3.servantid
			var_49_1 = var_49_1 + 1

			if iter_49_3.horcrux and iter_49_3.horcrux.itemid then
				var_49_3["area_subrole" .. iter_49_2 .. "_id"] = iter_49_3.horcrux.itemid
				var_49_2 = var_49_2 + 1
			end
		end
	end

	var_49_3.area_rolenum = var_49_1
	var_49_3.area_subrolenum = var_49_2

	AnalyticManager.area_tzsuccess(var_49_3)
	LayerManager:pushInLayer("PvpResultLayer", var_49_0)
	audio_manager:setbackgroundMusicVolume(BOSS_VOLUME * 0.5)
end

function SmallFightLayer.arenatftFightSuccess(arg_51_0, arg_51_1, arg_51_2)
	if arg_51_1.result ~= 5 then
		LayerManager:pushInLayer("PopTvtResultLayer", {
			fightResult = "win",
			exitcallback = function()
				LayerManager:switchShowLayer("ThreeVsThreeLayer", {
					status = false
				})

				if arg_51_2 then
					arg_51_2()
				end
			end,
			restartcallback = function()
				if arg_51_2 then
					arg_51_2()
				end
			end
		})
	end

	audio_manager:setbackgroundMusicVolume(BOSS_VOLUME * 0.5)
end

function SmallFightLayer.scoreArenaFightSuccess(arg_54_0, arg_54_1, arg_54_2, arg_54_3, arg_54_4, arg_54_5)
	LayerManager:pushInLayer("PvpResultLayer", {
		fightResult = "win",
		arenatype = "scorearena",
		fightData = FightManager.getStatisticsMsg(),
		rank = arg_54_2,
		addHonor = arg_54_3,
		score = arg_54_4,
		enemydata = arg_54_1,
		exitcallback = function(arg_55_0)
			LayerManager:switchShowLayer("ScoreArenaLayer", {
				needAutoFight = arg_55_0
			})

			if arg_54_5 then
				arg_54_5()
			end
		end
	})
	audio_manager:setbackgroundMusicVolume(BOSS_VOLUME * 0.5)
end

function SmallFightLayer.arenaFrinedFightSuccess(arg_56_0, arg_56_1, arg_56_2)
	LayerManager:pushInLayer("PvpResultLayer", {
		fightResult = "win",
		arenatype = "friendfight",
		fightData = FightManager.getStatisticsMsg(),
		rank = rank,
		addHonor = honor,
		score = score,
		enemydata = arg_56_1,
		exitcallback = function()
			LayerManager:switchReturnLayer("FriendListLayer")

			if arg_56_2 then
				arg_56_2()
			end
		end
	})
	audio_manager:setbackgroundMusicVolume(BOSS_VOLUME * 0.5)
end

function SmallFightLayer.exploreFightSuccess(arg_58_0, arg_58_1)
	LayerManager:switchShowLayer("ExploreMapLayer")

	if arg_58_1 then
		arg_58_1()
	end
end

function SmallFightLayer.rogueExploreFightSuccess(arg_59_0, arg_59_1)
	LayerManager:switchShowLayer("RogueExploreLayer")

	if arg_59_1 then
		arg_59_1()
	end
end

function SmallFightLayer.onFightStakePvpSuccess(arg_60_0)
	LayerManager:pushInLayer("PvpResultLayer", {
		fightResult = "win",
		arenatype = "friendfight",
		fightData = FightManager.getStatisticsMsg(),
		enemydata = test_fight_manager:getFightRresultPvpData(),
		exitcallback = function()
			LayerManager:switchReturnLayer("TestFightLayer")

			if callback then
				callback()
			end
		end
	})
end

function SmallFightLayer.onFightStakePveSuccess(arg_62_0)
	LayerManager:pushInLayer("PopExpeditionResultLayer", {
		fightResult = "win",
		arenatype = "friendfight",
		fightData = FightManager.getStatisticsMsg(),
		enemydata = test_fight_manager:getFightRresultPveData(),
		cancelcallback = function()
			LayerManager:switchReturnLayer("TestFightLayer")

			if callback then
				callback()
			end
		end
	})
end

function SmallFightLayer.substitutionFightPass(arg_64_0, arg_64_1, arg_64_2, arg_64_3)
	audio_manager:playFightEffect(FIGHT_WIN_EFFECT)
	LayerManager:pushInLayer("PopSubsResultLayer", {
		score = arg_64_1.score,
		result = arg_64_1.result,
		status = arg_64_1.status,
		fightcount = arg_64_1.fightcount,
		win = arg_64_3,
		cancelcallback = function()
			LayerManager:switchShowLayer("SubstitutionLayer", {
				mode = substitution_manager:getMode(),
				endtime = substitution_manager:getEndTime()
			})

			if arg_64_2 then
				arg_64_2()
			end
		end
	})
	audio_manager:setbackgroundMusicVolume(BOSS_VOLUME * 0.5)

	if arg_64_1.item_res then
		global_gain(arg_64_1.item_res)
	end
end

function SmallFightLayer.oldSubstitutionFightPass(arg_66_0, arg_66_1, arg_66_2)
	audio_manager:playFightEffect(FIGHT_WIN_EFFECT)

	local function var_66_0()
		if arg_66_2 then
			arg_66_2()
		end
	end

	;(function()
		LayerManager:pushInLayer("PopOldSubsResultLayer", {
			hp = arg_66_1.hp,
			rank = arg_66_1.rank,
			newItems = arg_66_1.addItemList,
			oldItems = arg_66_1.oldItemList,
			curarray = arg_66_1.curarray,
			cancelcallback = var_66_0
		})
	end)()
	audio_manager:setbackgroundMusicVolume(BOSS_VOLUME * 0.5)
end

function SmallFightLayer.aiAttackFightPass(arg_69_0, arg_69_1, arg_69_2, arg_69_3)
	if arg_69_1 then
		arg_69_1()
	end

	LayerManager:pushInLayer("PopAIAttackResultLayer", {
		createPopLayerCallBack = true,
		modelid = aiattack_manager:random_ai_modelid(),
		data = arg_69_2,
		cost_ai = arg_69_3,
		cancelcallback = function()
			LayerManager:switchShowLayer("DoubleHoliday_WoldCityLayer")
		end
	})
end

function SmallFightLayer:towerDefenceFightPass(arg_71_1, arg_71_2, arg_71_3, arg_71_4)
	audio_manager:playFightEffect(FIGHT_WIN_EFFECT)

	local tower_defence_manager = require("controller.tower_defence_manager")

	self:playBossSuccessEffect(arg_71_3, level, function()
		LayerManager:pushInLayer("PopTowerDefenceResultLayer", {
			modelid = tower_defence_manager:getRandomFightingModelid(),
			mode = arg_71_3,
			level = arg_71_3 .. "-" .. arg_71_4,
			data = arg_71_2,
			cancelcallback = arg_71_1
		})
	end)
	audio_manager:setbackgroundMusicVolume(BOSS_VOLUME * 0.5)
end

function SmallFightLayer:expeditionFightPass(arg_73_1, arg_73_2, arg_73_3, arg_73_4)
	local expedition_manager = require("controller.expedition_manager")

	audio_manager:playFightEffect(FIGHT_WIN_EFFECT)
	self:playBossSuccessEffect(arg_73_3, level, expedition_manager.expeditionInfo.seasontype == EXPEDITION.SEASONTYPE.Monopoly and function()
		LayerManager:pushInLayer("PopSubsResultLayer", {
			score = 0,
			result = 3,
			fighttype = "monopoly",
			fightcount = 0,
			win = 1,
			cancelcallback = arg_73_1
		})
	end or function()
		LayerManager:pushInLayer("PopExpeditionResultLayer", {
			modelid = expedition_manager:getRandomFightingModelid(),
			mode = arg_73_3,
			level = arg_73_3 .. "-" .. arg_73_4,
			data = arg_73_2,
			cancelcallback = arg_73_1
		})
	end)
	audio_manager:setbackgroundMusicVolume(BOSS_VOLUME * 0.5)
end

function SmallFightLayer:autoChessFightSuccess(arg_77_1, arg_77_2, arg_77_3, arg_77_4)
	audio_manager:playFightEffect(FIGHT_WIN_EFFECT)

	local activity_manager = require("controller.activity_manager")

	self:playBossSuccessEffect(arg_77_3, level, function()
		LayerManager:pushInLayer("PopTowerDefenceResultLayer", {
			modelid = activity_manager:getAutoChessFightingModelid(),
			mode = arg_77_3,
			level = arg_77_3 .. "-" .. arg_77_4,
			data = arg_77_2,
			cancelcallback = arg_77_1
		})
	end)
	audio_manager:setbackgroundMusicVolume(BOSS_VOLUME * 0.5)
end

function SmallFightLayer:normalFightFail(arg_79_1)
	if self.bgPanel:getChildByName("mapcover") then
		local var_79_0 = self.bgPanel:getChildByName("mapcover")

		var_79_0:stopAllActions()
		var_79_0:removeFromParent()
	end

	local var_79_1 = cc.LayerColor:create(cc.c4b(0, 0, 0, 0), var_0_15, GameDisplay.height)

	var_79_1:setAnchorPoint(cc.p(0, 0))
	var_79_1:setPosition(cc.p(0, var_0_18))
	var_79_1:setName("mapcover")
	self.bgPanel:addChild(var_79_1, 100)
	var_79_1:runAction(cc.Sequence:create(cc.FadeIn:create(0.5), cc.CallFunc:create(arg_79_1), cc.FadeOut:create(0.5), cc.RemoveSelf:create()))
end

function SmallFightLayer.bossFightFail(arg_80_0, arg_80_1)
	local function var_80_0(arg_81_0)
		GuideListener.triggerGuide(TRIGGER_FAIL)

		if arg_80_1 then
			arg_80_1(arg_81_0)
		end
	end

	require("view.Layer.LevelResultLayer")
	LevelResultLayer:create({
		createPopLayerCallBack = true,
		showtype = 2,
		curarray = playermodel.curSoul,
		fightlevel = playermodel.curLevel,
		fightdifficulty = playermodel.curMode,
		curMonsterInfo = level_manager.getCurFightEnemys(playermodel.curMode),
		surecallback = var_80_0,
		cancelcallback = var_80_0,
		fightData = FightManager.getStatisticsMsg(),
		fighttime = math.floor(FightManager.getFightTimeStatistics()),
		packs_buy_callback = function()
			require("controller.condition_trigger_packs_manager"):check_trigger_condition({
				shop_type = ASSISTS_PACKS,
				curMode = playermodel.curMode
			})
		end
	})
end

function SmallFightLayer.adventureFightFail(arg_83_0, arg_83_1)
	if arg_83_1 then
		arg_83_1()
	end

	require("view.Layer.LevelResultLayer")
	LevelResultLayer:create({
		createPopLayerCallBack = true,
		showtype = 2,
		curarray = playermodel.curSoul,
		fightlevel = playermodel.curLevel,
		fightdifficulty = playermodel.curMode,
		curMonsterInfo = curMonsterInfo,
		surecallback = mcallback,
		cancelcallback = mcallback,
		fightData = FightManager.getStatisticsMsg(),
		fighttime = math.floor(FightManager.getFightTimeStatistics())
	})
end

function SmallFightLayer.groupFightFail(arg_84_0, arg_84_1)
	if arg_84_1 then
		arg_84_1()
	end

	require("view.Layer.LevelResultLayer")

	local var_84_0 = {}

	for iter_84_0, iter_84_1 in pairs(activity_manager:getGroupTowerArray()) do
		if iter_84_1.fight_girl then
			var_84_0[1] = {}
			var_84_0[1].fight_girl = iter_84_1.fight_girl
			var_84_0[1].pos = iter_84_1.pos
			var_84_0[1].classtype = 1
		end
	end

	activity_manager:getGroupIndexNumRestart()
	RoleDefault:getInstance():setBoolForKey("GroupTowerAutoFight", false)
	LevelResultLayer:create({
		createPopLayerCallBack = true,
		showtype = 2,
		curarray = var_84_0,
		fightlevel = playermodel.curLevel,
		fightdifficulty = playermodel.curMode,
		fightData = FightManager.getStatisticsMsg(),
		fighttime = math.floor(FightManager.getFightTimeStatistics())
	})
end

function SmallFightLayer.arenaFightFail(arg_85_0, arg_85_1, arg_85_2, arg_85_3, arg_85_4)
	local var_85_0 = FightManager.getStatisticsMsg()

	arg_85_3.enemyArray = {}

	for iter_85_0, iter_85_1 in pairs(FightManager.getStatisticModels().enemies) do
		table.insert(arg_85_3.enemyArray, {
			model = iter_85_1
		})
	end

	LayerManager:pushInLayer("PvpResultLayer", {
		fightResult = "fail",
		fightData = FightManager.getStatisticsMsg(),
		rankChange = arg_85_3,
		addHonor = arg_85_2,
		exitcallback = function()
			LayerManager:switchShowLayer("ArenaLayer")

			if arg_85_4 then
				arg_85_4()
			end
		end
	})
	audio_manager:setbackgroundMusicVolume(BOSS_VOLUME * 0.5)
end

function SmallFightLayer.arenaFrinedFightFail(arg_87_0, arg_87_1, arg_87_2)
	LayerManager:pushInLayer("PvpResultLayer", {
		fightResult = "fail",
		arenatype = "friendfight",
		fightData = FightManager.getStatisticsMsg(),
		enemydata = arg_87_1,
		exitcallback = function()
			LayerManager:switchReturnLayer("FriendListLayer")

			if arg_87_2 then
				arg_87_2()
			end
		end
	})
	audio_manager:setbackgroundMusicVolume(BOSS_VOLUME * 0.5)
end

function SmallFightLayer.arenatftFightFail(arg_89_0, arg_89_1, arg_89_2)
	if arg_89_1.result ~= 5 then
		LayerManager:pushInLayer("PopTvtResultLayer", {
			fightResult = "fail",
			exitcallback = function()
				LayerManager:switchShowLayer("ThreeVsThreeLayer")

				if arg_89_2 then
					arg_89_2()
				end
			end,
			restartcallback = function()
				if arg_89_2 then
					arg_89_2()
				end
			end
		})
	end

	audio_manager:setbackgroundMusicVolume(BOSS_VOLUME * 0.5)
end

function SmallFightLayer.scoreArenaFightFail(arg_92_0, arg_92_1, arg_92_2, arg_92_3)
	LayerManager:pushInLayer("PvpResultLayer", {
		fightResult = "fail",
		arenatype = "scorearena",
		fightData = FightManager.getStatisticsMsg(),
		rank = arg_92_2,
		enemydata = arg_92_1,
		exitcallback = function()
			LayerManager:switchShowLayer("ScoreArenaLayer")

			if arg_92_3 then
				arg_92_3()
			end
		end
	})
end

function SmallFightLayer.aiAttackFightFail(arg_94_0, arg_94_1)
	if arg_94_1 then
		arg_94_1()
	end

	LayerManager:switchShowLayer("DoubleHoliday_WoldCityLayer")
	require("view.Layer.LevelResultLayer")

	local var_94_0 = {
		showtype = 9,
		curarray = playermodel.curSoul,
		fightlevel = playermodel.curLevel,
		fightdifficulty = playermodel.curMode
	}

	var_94_0.modelid = aiattack_manager:random_ai_modelid() or "42010"
	var_94_0.fighttime = math.floor(FightManager.getFightTimeStatistics())

	LevelResultLayer:create(var_94_0)
end

function SmallFightLayer.exploreFightFail(arg_95_0, arg_95_1)
	LayerManager:switchShowLayer("ExploreMapLayer")

	if arg_95_1 then
		arg_95_1()
	end
end

function SmallFightLayer.rogueExploreFightFail(arg_96_0, arg_96_1)
	LayerManager:switchShowLayer("RogueExploreLayer")

	if arg_96_1 then
		arg_96_1()
	end
end

function SmallFightLayer.towerFightFail(arg_97_0, arg_97_1)
	if arg_97_1 then
		arg_97_1()
	end

	require("view.Layer.LevelResultLayer")
	LevelResultLayer:create({
		showtype = 9,
		curarray = playermodel.curSoul,
		fightlevel = playermodel.curLevel,
		fightdifficulty = playermodel.curMode,
		modelid = require("controller.tower_defence_manager"):getRandomFightingModelid(),
		fighttime = math.floor(FightManager.getFightTimeStatistics())
	})
end

function SmallFightLayer.onFightStakePvpFail(arg_98_0, arg_98_1)
	LayerManager:pushInLayer("PvpResultLayer", {
		fightResult = "fail",
		arenatype = "friendfight",
		fightData = FightManager.getStatisticsMsg(),
		enemydata = test_fight_manager:getFightRresultPvpData(),
		exitcallback = function()
			LayerManager:switchReturnLayer("TestFightLayer")

			if callback then
				callback()
			end
		end
	})
end

function SmallFightLayer.onFightStakePveFail(arg_100_0, arg_100_1)
	LayerManager:pushInLayer("PopExpeditionResultLayer", {
		fightResult = "fail",
		arenatype = "friendfight",
		fightData = FightManager.getStatisticsMsg(),
		enemydata = test_fight_manager:getFightRresultPveData(),
		cancelcallback = function()
			LayerManager:switchReturnLayer("TestFightLayer")

			if callback then
				callback()
			end
		end
	})
end

function SmallFightLayer.expeditionFightFail(arg_102_0, arg_102_1)
	local expedition_manager = require("controller.expedition_manager")

	if arg_102_1 then
		arg_102_1()
	end

	if expedition_manager.expeditionInfo.seasontype == EXPEDITION.SEASONTYPE.Monopoly then
		audio_manager:playFightEffect(FIGHT_WIN_EFFECT)
		LayerManager:pushInLayer("PopSubsResultLayer", {
			score = 0,
			result = 3,
			fighttype = "monopoly",
			fightcount = 0,
			win = 1,
			cancelcallback = arg_102_1
		})
		audio_manager:setbackgroundMusicVolume(BOSS_VOLUME * 0.5)
	else
		require("view.Layer.LevelResultLayer")
		LevelResultLayer:create({
			showtype = 9,
			curarray = playermodel.curSoul,
			fightlevel = playermodel.curLevel,
			fightdifficulty = playermodel.curMode,
			modelid = expedition_manager:getRandomFightingModelid(),
			fighttime = math.floor(FightManager.getFightTimeStatistics())
		})
	end
end

function SmallFightLayer.autoChessFightFail(arg_103_0, arg_103_1)
	if arg_103_1 then
		arg_103_1()
	end

	require("view.Layer.LevelResultLayer")
	LevelResultLayer:create({
		showtype = 9,
		curarray = playermodel.curSoul,
		fightlevel = playermodel.curLevel,
		fightdifficulty = playermodel.curMode,
		modelid = require("controller.activity_manager"):getAutoChessFightingModelid(),
		fighttime = math.floor(FightManager.getFightTimeStatistics())
	})
end

function SmallFightLayer:fightRefresh(arg_104_1)
	if self.bgPanel:getChildByName("mapcover") then
		local var_104_0 = self.bgPanel:getChildByName("mapcover")

		var_104_0:stopAllActions()
		var_104_0:removeFromParent()
	end

	local var_104_1 = cc.LayerColor:create(cc.c4b(0, 0, 0, 0), var_0_15, GameDisplay.height)

	var_104_1:setAnchorPoint(cc.p(0, 0))
	var_104_1:setPosition(cc.p(0, var_0_18))
	var_104_1:setName("mapcover")
	self.bgPanel:addChild(var_104_1, 100)
	var_104_1:runAction(cc.Sequence:create(cc.FadeIn:create(0.5), cc.CallFunc:create(arg_104_1), cc.FadeOut:create(0.5), cc.RemoveSelf:create()))
end

function SmallFightLayer:fightClose(arg_105_1)
	if self.bgPanel:getChildByName("mapcover") then
		local var_105_0 = self.bgPanel:getChildByName("mapcover")

		var_105_0:stopAllActions()
		var_105_0:removeFromParent()
	end

	local var_105_1 = cc.LayerColor:create(cc.c4b(0, 0, 0, 0), var_0_15, GameDisplay.height)

	var_105_1:setAnchorPoint(cc.p(0, 0))
	var_105_1:setPosition(cc.p(0, var_0_18))
	var_105_1:setName("mapcover")
	self.bgPanel:addChild(var_105_1, 100)
	var_105_1:runAction(cc.Sequence:create(cc.FadeIn:create(0.5), cc.CallFunc:create(arg_105_1 or function()
		return
	end)))
end

function SmallFightLayer:fightOpen(arg_107_1)
	local var_107_0 = self.bgPanel:getChildByName("mapcover")

	if not var_107_0 then
		var_107_0 = cc.LayerColor:create(cc.c4b(0, 0, 0, 0), var_0_15, GameDisplay.height)

		var_107_0:setAnchorPoint(cc.p(0, 0))
		var_107_0:setPosition(cc.p(0, var_0_18))
		var_107_0:setName("mapcover")
		self.bgPanel:addChild(var_107_0, 100)
	end

	var_107_0:runAction(cc.Sequence:create(cc.CallFunc:create(arg_107_1), cc.FadeOut:create(0.5), cc.RemoveSelf:create()))
end

function SmallFightLayer.changeLevel(arg_108_0)
	FightManager.changeLevel()
end

function SmallFightLayer.reload(arg_109_0)
	FightManager.setFightStatus(FIGHTSTATUS_REFRESH)
	FightManager.mainloop()
end

function SmallFightLayer.infiniteFightFail(arg_110_0, arg_110_1, arg_110_2)
	if arg_110_2 then
		arg_110_2()
	end

	require("view.Layer.LevelResultLayer")

	local var_110_0 = {}

	while playermodel.arrays[RoleDefault:getInstance():getIntegerForKey("adventurearray", 1)]["pos_" .. 1] and playermodel.arrays[RoleDefault:getInstance():getIntegerForKey("adventurearray", 1)]["pos_" .. 1].fight_girl do
		var_110_0[1] = {
			classtype = 1,
			pos = 1,
			fight_girl = playermodel.arrays[RoleDefault:getInstance():getIntegerForKey("adventurearray", 1)]["pos_" .. 1].fight_girl
		}
	end

	LevelResultLayer:create({
		createPopLayerCallBack = true,
		showtype = 2,
		curarray = var_110_0,
		fightlevel = playermodel.curLevel,
		fightdifficulty = playermodel.curMode,
		curMonsterInfo = curMonsterInfo,
		surecallback = mcallback,
		cancelcallback = mcallback,
		fightData = FightManager.getStatisticsMsg(),
		fighttime = math.floor(FightManager.getFightTimeStatistics()),
		data = {
			scoreinfinite = arg_110_1
		}
	})
end

function SmallFightLayer:infiniteFightSuccess(arg_111_1, arg_111_2)
	audio_manager:playFightEffect(FIGHT_WIN_EFFECT)

	local var_111_0 = {}

	while playermodel.arrays[RoleDefault:getInstance():getIntegerForKey("adventurearray", 1)]["pos_" .. 1] do
		var_111_0[1] = {
			classtype = 1,
			pos = 1,
			fight_girl = playermodel.arrays[RoleDefault:getInstance():getIntegerForKey("adventurearray", 1)]["pos_" .. 1].fight_girl
		}
	end

	self:playBossSuccessEffect(playermodel.curMode, playermodel.curLevel, function()
		LayerManager:pushInLayer("PopAdventureResultLayer", {
			createPopLayerCallBack = true,
			curarray = var_111_0,
			mode = playermodel.curMode,
			level = playermodel.curLevel,
			clear = level_manager:isLevelModeComplete(mode, level),
			continuecallback = arg_111_2,
			cancelcallback = arg_111_2,
			data = {
				scoreinfinite = arg_111_1,
				items = {}
			}
		})
	end)
	audio_manager:setbackgroundMusicVolume(BOSS_VOLUME * 0.5)
end
