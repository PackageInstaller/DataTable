local var_0_0 = {}

var_0_0.ref = nil

local playermodel = require("model.playermodel")
local autopop_manager = require("controller.autopop_manager")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.ref = arg_1_1
end

function var_0_0.exit(arg_2_0)
	arg_2_0.ref = nil
end

function var_0_0:getRef()
	return self.ref
end

function var_0_0:switchShowLayer(arg_4_1, arg_4_2)
	if not self.ref then
		return
	end

	if not self:layerUnlocked(arg_4_1, "switchShowLayer") then
		return
	end

	KeyCodeManager:registerSwitchShowLayerEvent(arg_4_1, arg_4_2)
	KeyCodeManager:saveCurLayerParam(arg_4_1)
	self.ref:switchLayer(arg_4_1, arg_4_2)
end

function var_0_0:switchReturnLayer(arg_5_1, arg_5_2)
	if not self.ref then
		return
	end

	if not self:layerUnlocked(arg_5_1, "switchShowLayer") then
		return
	end

	KeyCodeManager:registerSwitchShowLayerEvent(arg_5_1)

	local var_5_0 = KeyCodeManager:getCurLayerParam(arg_5_1) or arg_5_2

	if type(var_5_0) == "table" and not next(var_5_0) then
		var_5_0 = nil
	end

	self.ref:switchLayer(arg_5_1, var_5_0)
end

function var_0_0:showTopBottomLayer(arg_6_1)
	if not self.ref or not arg_6_1 then
		return
	end

	if arg_6_1.ListButtonLayer ~= nil then
		self.ref:switchListButtonLayer(arg_6_1.ListButtonLayer)
	end

	if arg_6_1.TopcostLayer ~= nil then
		self.ref:switchTopcostLayer(arg_6_1.TopcostLayer)
	end
end

function var_0_0:getCurrentLayerName()
	if self.ref then
		if self.ref:isShowPopLayer() then
			return self.ref:getTopPopLayer():getName()
		else
			return self:getActiveLayerName()
		end
	end
end

function var_0_0:getActiveLayerName()
	return self.ref:getActiveLayerName()
end

function var_0_0:getActiveLayerObj()
	return self.ref:getLayerObject(self:getActiveLayerName())
end

function var_0_0:pushInLayer(arg_10_1, ...)
	if not self:checkLayerCondition(arg_10_1, ...) then
		return
	end

	if not self:layerUnlocked(arg_10_1, "pushInLayer") then
		return nil
	end

	KeyCodeManager:registerPushInLayerEvent(arg_10_1)

	return self.ref:pushInLayer(arg_10_1, ...)
end

function var_0_0:removePopLayer(arg_11_1)
	KeyCodeManager:registerPopLayerEixtEvent()
	self.ref:deletePopLayer(arg_11_1)
end

function var_0_0:getCurrentLayerObj()
	if self.ref:isShowPopLayer() then
		return self.ref:getTopPopLayer()
	else
		return self.ref:getLayerObject(self:getActiveLayerName())
	end
end

function var_0_0:getUIElement(arg_13_1)
	return self.ref:getLayerObject(arg_13_1)
end

function var_0_0:getGuideObj()
	return self.ref._guidelayer
end

function var_0_0:getBgObj()
	return self.ref._bglayer
end

function var_0_0:getPlotObj()
	return self.ref._plotlayer
end

function var_0_0:getTipsLayer()
	return self.ref:getTipsLayer()
end

function var_0_0:updateGuidesOnSwitchLayer()
	GuideListener.cleanCurGuides()
	GuideListener.lockGuideTrigger(false)
	GuideListener.showAllGuidesWithFullScreen(true)

	if RoleDefault:getInstance():getIntegerForKey("guide_level", 0) > 0 and GuideListener.updateGuides(self:getCurrentLayerObj()) then
		autopop_manager:pauseOtherPop()
	else
		autopop_manager:resumeOtherPop()
	end
end

local var_0_4 = {
	PhotoMemoryLayer = UNLOCK_PHOTO,
	PhotoFileLayer = UNLOCK_PHOTO,
	PhotoGoodsLayer = UNLOCK_PHOTO,
	EnergyLabLayer = UNLOCK_LAB,
	RankListLayer = UNLOCK_RANK,
	ArenaLayer = UNLOCK_ARENA,
	HandOfMidasLayer = UNLOCK_MIDAS,
	HorcruxLayer = UNLOCK_HORCRUX,
	TwisteggLayer = UNLOCK_TWIST,
	DormitoryLayer = UNLOCK_FAVOR,
	MarketLayer = UNLOCK_SHOP,
	AdventureLayer = math.min(UNLOCK_AD, UNLOCK_SCOREARENA, UNLOCK_SHILIANTA, UNLOCK_ARENA, UNLOCK_ADVENTURENEWITEMLAYER_2),
	ExploreLayer = UNLOCK_EXPLORE,
	ExploreMapLayer = UNLOCK_EXPLORE,
	SchoolAreaLayer = UNLOCK_SCHOOL,
	PatrolPopLayer = UNLOCK_PATRO,
	ScoreArenaLayer = UNLOCK_SCOREARENA,
	ChangeBtnLayer = UNLOCK_SCOREARENA,
	AdventureNewTowerLayer = UNLOCK_SHILIANTA,
	AdventureNewItemLayer = UNLOCK_AD,
	SchoolTrainLayer = UNLOCK_SCHOOL_TRAIN,
	LabMakeNewLayer = UNLOCK_LAB_FACTORY,
	LabMenuLayer = UNLOCK_LAB,
	SubstitutionBossLayer = UNLOCK_SUBSTITUTIONBOSSLAYER,
	ThreeVsThreeLayer = UNLOCK_THREE_VS_THREE,
	CommunityMainLayer = UNLOCK_COMMAINMAINLAYE,
	joinCommunityLayer = UNLOCK_COMMAINJOINLAYE,
	AdventurerRandomLayer = UNLOCK_RADOMADVERTURE,
	SchoolOrderLayer = UNLOCK_SCHOOL_ORDER,
	LevelTalkMapLayer = UNLOCK_LEVELTALK,
	SpecialJumpTowerLayer = math.min(UNLOCK_AD, UNLOCK_SCOREARENA, UNLOCK_SHILIANTA, UNLOCK_ARENA),
	TowerDefenceLevelLayer = UNLOCK_TOWERDEFENCE,
	StoryModesLayer = UNLOCK_STORYMODES,
	TowerDefenceLevelLayer = UNLOCK_TOWERDEFENCE,
	StoryModesLayer = UNLOCK_STORYMODES,
	CompetitionLayer = math.min(UNLOCK_ARENA, UNLOCK_SCOREARENA, UNLOCK_THREE_VS_THREE),
	TowerDefenceLevelLayer = UNLOCK_TOWERDEFENCE,
	StoryModesLayer = UNLOCK_STORYMODES,
	CompetitionLayer = math.min(UNLOCK_ARENA, UNLOCK_SCOREARENA, UNLOCK_THREE_VS_THREE),
	TowerDefenceLevelLayer = UNLOCK_TOWERDEFENCE,
	StoryModesLayer = UNLOCK_STORYMODES,
	CompetitionLayer = math.min(UNLOCK_ARENA, UNLOCK_SCOREARENA, UNLOCK_THREE_VS_THREE),
	TowerDefenceLevelLayer = UNLOCK_TOWERDEFENCE,
	StoryModesLayer = UNLOCK_STORYMODES,
	CompetitionLayer = math.min(UNLOCK_ARENA, UNLOCK_SCOREARENA, UNLOCK_THREE_VS_THREE),
	PopQuickGuaJiSure = UNLOCK_QUICKFIGHT,
	SpecialJumpTowerLayer = UNLOCK_SHILIANTA,
	BianhuaStoryLayer = UNLOCK_STORYMODES,
	AvalonStoryLayer = UNLOCK_STORYMODES,
	LamiaStoryLayer = UNLOCK_STORYMODES,
	ExploreOfferLayer = UNLOCK_EXPLOREOFFERLAYER,
	ActivityMainLayer_173 = UNLOCK_STORYMODES,
	LimitTowerDefenceLevelLayer = UNLOCK_LIMITTOWERDEFENCELEVEL,
	SchoolStudyLayer = UNLOCK_SCHOOL_STUDY,
	AfkLevelLayer = UNLOCK_LAB,
	ActivityEntranceLayer = UNLOCK_ACTIVITY_ENTTRANCE
}

function var_0_0.layerUnlocked(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	arg_20_3 = type(arg_20_3) ~= "boolean" and true or arg_20_3

	local level_manager = require("controller.level_manager")

	if not var_0_4[arg_20_1] then
		return true
	end

	if type(var_0_4[arg_20_1]) == "function" then
		return var_0_4[arg_20_1]()
	end

	if var_0_4[arg_20_1] < 0 then
		if arg_20_3 then
			global_ShowBlockWords(L_NO_OPEN)
		end

		return false
	elseif level_manager:isPlayerPassLevel(var_0_4[arg_20_1]) then
		return true
	else
		local var_20_1 = level_manager:formatSystemUnlockLevel(var_0_4[arg_20_1])

		print(var_20_1, var_0_4[arg_20_1])

		if arg_20_3 then
			global_ShowBlockWords(string.format(L_LAYER_UNLOCKED, var_20_1))
		end

		return false, string.format(L_LAYER_UNLOCKED, var_20_1)
	end
end

function var_0_0.getLayerUnlockStat(arg_21_0, arg_21_1)
	if not var_0_4[arg_21_1] then
		return true
	end

	if type(var_0_4[arg_21_1]) == "function" then
		return var_0_4[arg_21_1]()
	end

	local level_manager = require("controller.level_manager")

	if var_0_4[arg_21_1] < 0 then
		return false, L_NO_OPEN
	elseif level_manager:isPlayerPassLevel(var_0_4[arg_21_1]) then
		return true
	else
		return false, level_manager:formatSystemUnlockLevel(var_0_4[arg_21_1]) .. L_UNLOCK
	end
end

function var_0_0:shake_screen(arg_22_1, arg_22_2)
	if not self:getBgObj() then
		return
	end

	local var_22_0 = {}

	for iter_22_0 = 1, 3 do
		var_22_0[iter_22_0] = cc.Sequence:create(cc.MoveBy:create(0.05 / (iter_22_0 * iter_22_0), cc.p(arg_22_1 * 10 / iter_22_0, arg_22_2 * 10 / iter_22_0)), cc.MoveBy:create(0.05 / (iter_22_0 * iter_22_0), cc.p(-(arg_22_1 * 10 / iter_22_0), -(arg_22_2 * 10 / iter_22_0))), cc.MoveBy:create(0.05 / (iter_22_0 * iter_22_0), cc.p(-(arg_22_1 * 10 / iter_22_0), -(arg_22_2 * 10 / iter_22_0))), cc.MoveBy:create(0.05 / (iter_22_0 * iter_22_0), cc.p(arg_22_1 * 10 / iter_22_0, arg_22_2 * 10 / iter_22_0)))
	end

	self:getBgObj():getChildByName("bg"):runAction(cc.Sequence:create(var_22_0[1], var_22_0[2], var_22_0[3]))
end

function var_0_0:isShowPopLayer()
	return self.ref:isShowPopLayer()
end

function var_0_0:cleanPopLayer()
	self.ref:cleanPopLayer()
end

function var_0_0:showPlotLayer()
	self.ref:showPlotLayer()
end

function var_0_0:showUILayer()
	self.ref:showUILayer()
end

function var_0_0:createFullScreenMask(arg_27_1, arg_27_2, arg_27_3, arg_27_4)
	self.ref:createFullScreenMask(arg_27_1, arg_27_2, arg_27_3, arg_27_4)
end

function var_0_0.checkLayerCondition(arg_28_0, arg_28_1, arg_28_2)
	if arg_28_1 == "PopGoGainLayer" and arg_28_2 and type(arg_28_2) == "table" then
		if arg_28_2.item ~= "gold" and arg_28_2.item ~= "horcrux" and not require("data.item_data")[arg_28_2.item].targetlayer1 then
			global_ShowBlockWords(L_NO_WAY_GET)
			require("controller.audio_manager"):playeffectMusicTest("sound/invalid")

			return
		end
	end

	return true
end

function var_0_0:getUILayerBgm()
	return self.ref:getUILayerBgm()
end

function var_0_0:isShowPopLayerWithLayerName(...)
	return self.ref:isShowPopLayerWithLayerName(...)
end

function var_0_0:getPopLayerWithLayerName(...)
	return self.ref:getPopLayerWithLayerName(...)
end

return var_0_0
