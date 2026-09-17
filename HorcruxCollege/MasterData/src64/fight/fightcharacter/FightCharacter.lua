require("fight.fightcharacter.FightCharacterHeader")

local var_0_1 = math
local var_0_2 = table
local playermodel = require("model.playermodel")
local model_manager = require("controller.model_manager")
local fightlogic = require("fight.fightlogic.fightlogic")
local skilllogic = require("fight.fightlogic.skilllogic")
local StatusPool = require("fight.fightstatus.StatusPool")
local FightUIElementsManager = require("fight.FightUIElementsManager")
local expedition_manager = require("controller.expedition_manager")
local total_skill_data = require("data.total_skill_data")
local BarSprite = require("view.Sprite.BarSprite")
local BossBarSprite = require("view.Sprite.BossBarSprite")
local TowerBaseBarSprite = require("view.Sprite.TowerBaseBarSprite")
local CaptainBarSprite = require("view.Sprite.CaptainBarSprite")
local NumberLabelSprite = require("view.Sprite.NumberLabelSprite")
local FightBuffPanel = require("view.Sprite.FightBuffPanel")
local var_0_17 = {
	wind = "public/career_icon/wind_icon.png",
	water = "public/career_icon/water_icon.png",
	fire = "public/career_icon/fire_icon.png",
	light = "public/career_icon/light_icon.png",
	dark = "public/career_icon/dark_icon.png"
}
local file_check_manager = require("controller.filedownloader.file_check_manager")

require("controller.filedownloader.download_node_utils"):addDownloadInterface(FightCharacter, "Spine")

function FightCharacter.create(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = FightCharacter.new()

	var_1_0:init(arg_1_1, arg_1_2, arg_1_3)

	return var_1_0
end

function FightCharacter:init(arg_2_1, arg_2_2, arg_2_3)
	self:initDownload()

	self.model = arg_2_1
	self.externmodel = model_manager.newExternModel()
	self.charactertype = arg_2_2
	self.logic = fightlogic.new(self)
	self.skilllogic = skilllogic.new(self)
	self.statuspool = StatusPool.new(self)
	self.skeleton = nil
	self.skeletonindex = nil
	self.hpbar = nil
	self.buffpanel = nil
	self.schedule = nil

	self:initBasicStatus(arg_2_2, arg_2_3)

	if arg_2_2 == "slave" then
		self:initSlaveCharacter()
	else
		self:initMasterCharacter()
	end

	self._instance = true

	self:registerScriptHandler(function(arg_3_0)
		if arg_3_0 == "enter" then
			self:onEnter()
		elseif arg_3_0 == "exit" then
			self:onExit()
		end
	end)
end

function FightCharacter:initBasicStatus(arg_4_1, arg_4_2)
	self:setState(STATE_WAITING)

	self._direction = arg_4_1 == "player" and 1 or -1
	self._speed = 0
	self._turnbackLimit = false
	self._moveforcedir = 1
	self._playing = nil
	self._godie = false
	self._suppress = false
	self._revivaling = nil
	self._usingXP = false
	self._distance = 0
	self._lockmove = false
	self._enablegravity = true
	self.target = nil
	self._lastTarget = nil
	self._locktargetpool = nil
	self._lockdistance = nil
	self._lockturnbacklimit = nil
	self._attackcount = 0
	self._skillcount = 0
	self._attack_cd_count = 0
	self._crossing = nil
	self._crashing = nil
	self._cd = 0
	self._skilllist = {}
	self._behitted = 0
	self._movingForward = nil
	self._rushingForward = nil
	self._fightforce = nil
	self._carriedconf = nil
	self._feardir = nil
	self._fightforceY = nil
	self._gravity = nil
	self._grabing = nil
	self._grabed = nil
	self._contracted = nil
	self._timer = 1
	self._pause = false
	self._lock = false
	self._shader = false
	self._idle = false
	self._globallock = false
	self._battlefieldlock = false
	self._hideondie = false
	self._transformer = nil
	self._boss = arg_4_2
	self._captainindex = nil
	self._defaultzorder = 0
	self._defaulty = 0
	self._unitorder = 0
	self._attackunitorder = self:getAttribute("range") >= 200 and 1 or 0
end

function FightCharacter:initMasterCharacter()
	self._assistconfig = nil
	self._assist = nil
	self._componenteffect = nil
	self.buff_effect_tbl = {}
	self._hitnumberpool = {}
	self._enterhandler = nil
	self._exithandler = nil
	self.aniListener = {
		_start = {},
		_complete = {}
	}

	self:initFightHandlers()
	self:resetSkeleton()
	self:resetHpBar()
	self:initImpactPos()
	self:initSkillList()
	self:initXPSkill()
	self:initFightSlaves()
end

function FightCharacter:initSlaveCharacter()
	self.buff_effect_tbl = {}
	self._hitnumberpool = {}
	self._enterhandler = nil
	self._exithandler = nil
	self.aniListener = {
		_start = {},
		_complete = {}
	}

	self:initFightHandlers()
	self:resetSkeleton()
	self:initImpactPos()
	self:initSkillList()
end

function FightCharacter:initFightSlaves()
	self._slaves = nil

	local var_7_0 = {}

	while self:getAttribute("slave" .. 1) do
		local var_7_1 = SlaveCharacter:create(self, self:getAttribute("slave" .. 1))

		self:addChild(var_7_1)
		var_0_2.insert(var_7_0, var_7_1)
	end

	if #var_7_0 > 0 then
		self._slaves = var_7_0
	end
end

function FightCharacter:getSlave(arg_8_1)
	if not self._slaves then
		return nil
	end

	return self._slaves[arg_8_1]
end

function FightCharacter:getSlaves()
	return self._slaves
end

function FightCharacter:resetSkeleton()
	local var_10_0 = self.model:getAttribute("spinemodel")
	local var_10_1 = self.model:getAttribute("clothesmodel")

	self.jsonFilePath = ROLE_SPINE_PATH .. var_10_0 .. ".json"
	self.atlasFilePath = ROLE_SPINE_PATH .. var_10_0 .. ".atlas"

	if var_10_1 then
		self.clothesFilePath = CLOTHES_SPINE_PATH .. var_10_1 .. ".atlas" or nil
	end

	self.changeSlot = self.model:getAttribute("changeslot")
	self.changeAttachment = self.model:getAttribute("changeattachment")
	self.changeTexture = self.model:getAttribute("changetexture") and "spine/attachment/" .. self.model:getAttribute("changetexture") or nil

	self:checkResource()
end

function FightCharacter:checkResource()
	self._downloadinglist = {}

	local var_11_0 = self.model:getAttribute("clothesmodel")
	local var_11_1, var_11_2 = file_check_manager:checkBattleSpineResource(self.jsonFilePath, (var_11_0 or nil) and (CLOTHES_SPINE_PATH .. var_11_0 or nil), self.changetexture)

	if var_11_1 then
		self:onDownloadProcessing()
		self:startDownload(var_11_2)
	else
		self:onDownloadComplete()
	end
end

function FightCharacter:onDownloadProcessing()
	if self.skeleton then
		self:removeChild(self.skeleton)

		self.skeleton = nil
	end

	if self.skeletondata then
		self.skeletondata:release()

		self.skeletondata = nil
	end

	self.skeletondata = SpineCacheManager:addSpineData("default/default.json", "default/default.atlas")

	self.skeletondata:retain()

	self.skeleton = sp.SkeletonAnimation:create(self.skeletondata:getData())

	self:addChild(self.skeleton)
end

function FightCharacter:onDownloadComplete()
	self:refreshSkeleton()
end

function FightCharacter:refreshSkeleton()
	if self.skeleton then
		self:removeChild(self.skeleton)

		self.skeleton = nil
	end

	if self.skeletondata then
		self.skeletondata:release()

		self.skeletondata = nil
	end

	self.skeletondata = SpineCacheManager:addSpineData(self.jsonFilePath, self.atlasFilePath, self.clothesFilePath, self.changeSlot)

	self.skeletondata:retain()

	self.skeleton = sp.SkeletonAnimation:create(self.skeletondata:getData())

	self:addChild(self.skeleton)
	self.skeleton:setScale(STANDARD_SCALE * self._direction * self:getAttribute("model_scale") * self:getAttribute("model_flip"), STANDARD_SCALE * self:getAttribute("model_scale"))
	self.skeleton:registerSpineEventHandler(function(arg_15_0)
		if self.aniListener._start[arg_15_0.animation] then
			self.aniListener._start[arg_15_0.animation]()
		end
	end, SP_ANIMATION_START)
	self.skeleton:registerSpineEventHandler(function(arg_16_0)
		if self.aniListener._complete[arg_16_0.animation] then
			self.aniListener._complete[arg_16_0.animation]()
		end
	end, SP_ANIMATION_COMPLETE)

	if self.changeSlot then
		self.skeleton:setSlotTexture(self.changeSlot, self.changeAttachment, self.changeTexture, 1, self.skeletondata:getData())
	end
end

function FightCharacter:resetHpBar()
	if self.model.baseid and self:isBoss() then
		self:resetTowerBaseHpBar()

		return
	end

	if self._boss then
		self.hpbar = cc.Node:create()

		local var_17_0 = GameDisplay.height * ORIGIN_FIGHT_HEIGHT / GameDisplay.origin_design_y - GameDisplay.fix_y
		local var_17_1 = (GameDisplay.height - (GameDisplay.height * ORIGIN_FIGHT_HEIGHT / GameDisplay.origin_design_y - GameDisplay.fix_y) - GameDisplay.fix_y) * ((GameDisplay.origin_design_y - ORIGIN_FIGHT_HEIGHT - 100) / (GameDisplay.origin_design_y - ORIGIN_FIGHT_HEIGHT))

		self.hpbar:setPosition(cc.p(360, (GameDisplay.height - (GameDisplay.height * ORIGIN_FIGHT_HEIGHT / GameDisplay.origin_design_y - GameDisplay.fix_y) - GameDisplay.fix_y) * ((GameDisplay.origin_design_y - ORIGIN_FIGHT_HEIGHT - 100) / (GameDisplay.origin_design_y - ORIGIN_FIGHT_HEIGHT))))
		FightManager.addFightUI(self.hpbar)

		local var_17_2

		if config._DEBUG then
			var_17_2 = cc.Sprite:create("FightLayer/boss_blood_frame.png") or cc.Sprite:createWithSpriteFrameName("FightLayer/boss_blood_frame.png")
		end

		var_17_2:setAnchorPoint(cc.p(0.5, 1))
		var_17_2:setPosition(-40, GameDisplay.height - var_17_0 - var_17_1)
		self.hpbar:addChild(var_17_2, -1)

		local var_17_3 = {}

		var_17_3.careericon = self:getAttribute("majorAttr") and self:getAttribute("career") .. "_" .. self:getAttribute("majorAttr") or "class_" .. self:getAttribute("career") .. "_black"
		var_17_3.headimg = self.model.headimg
		var_17_3.lv = self.model.monsterlevel
		var_17_3.name = self.model.name

		local var_17_4 = BossBarSprite:createHpBar(self.model.singlehp, self.model.singlehp, self.model.hpcount, 1, var_17_3)

		var_17_4:setName("hpbar")
		var_17_4:resetCurHp((self.model.curhpcount - 1) * self.model.singlehp + self.model.curhp)
		self.hpbar:addChild(var_17_4, 1)

		self.horcruxSkillsNode = cc.Node:create()

		self.horcruxSkillsNode:setPosition(cc.p(-220, 70))
		self.hpbar:addChild(self.horcruxSkillsNode)
		self:initialBossBuffPanel(var_17_1)
	elseif self.model.iscaptainmonster then
		self.hpbar = cc.Node:create()
		self._captainindex = FightManager.pushCaptainUI(self.hpbar)

		self.hpbar:setName("captainhpbar" .. self._captainindex)

		local var_17_5 = {}

		var_17_5.careericon = self:getAttribute("majorAttr") and self:getAttribute("career") .. "_" .. self:getAttribute("majorAttr") or "class_" .. self:getAttribute("career") .. "_black"
		var_17_5.headimg = self.model.headimg
		var_17_5.lv = self.model.monsterlevel
		var_17_5.name = self.model.name

		local var_17_6 = BossBarSprite:createHpBar(self.model.singlehp, self.model.singlehp, self.model.hpcount, 1, var_17_5)

		var_17_6:setName("hpbar")
		var_17_6:setScale(0.8)
		self.hpbar:addChild(var_17_6, 1)

		self.horcruxSkillsNode = cc.Node:create()

		self.horcruxSkillsNode:setPosition(cc.p(-160, 56))
		self.hpbar:addChild(self.horcruxSkillsNode)
		self:initialCaptainBuffPanel()
	else
		self.hpbar = cc.Node:create()

		self.hpbar:setPosition(cc.p(0, self:getAttribute("model_height") * STANDARD_SCALE * self:getAttribute("model_scale") + HPBAR_HEIGHT))
		self:addChild(self.hpbar)

		local var_17_7

		if config._DEBUG then
			var_17_7 = cc.Sprite:create(HPBAR_BOX_BG) or cc.Sprite:createWithSpriteFrameName(HPBAR_BOX_BG)
		end

		var_17_7:setScaleX(self._direction)
		self.hpbar:addChild(var_17_7)

		local var_17_8 = BarSprite:createHpBar(self.model.singlehp, self.model.singlehp, self.model.hpcount, {
			{
				bar = (self.charactertype == "player" or nil) and (HPBAR_BAR_PLAYER or HPBAR_BAR_ENEMY),
				bg = HPBAR_BOX_BG
			},
			{
				bar = "fight/UI_haemalStrandy_4.png",
				bg = HPBAR_BOX_BG
			},
			sub = HPBAR_BAR_SUB
		}, -1 * self._direction)

		var_17_8:setName("hpbar")
		var_17_8:setPosition(cc.p(var_17_7:getPositionX(), var_17_7:getPositionY()))
		self.hpbar:addChild(var_17_8, 1)

		self.horcruxSkillsNode = cc.Node:create()

		self.horcruxSkillsNode:setPosition(cc.p(5 * self._direction, 40))
		self.hpbar:addChild(self.horcruxSkillsNode)

		if self:getAttribute("majorAttr") then
			if self:getAttribute("career") then
				local var_17_9 = self:getAttribute("majorAttr")
				local var_17_10 = self:getAttribute("career")
				local var_17_11

				if config._DEBUG then
					var_17_11 = cc.Sprite:create("public/career_icon/" .. var_17_9 .. ".png") or cc.Sprite:createWithSpriteFrameName("public/career_icon/" .. var_17_9 .. ".png")
				end

				var_17_11:setScale(0.6)
				var_17_11:setPosition(cc.p(-70 * self._direction, var_17_7:getPositionY()))
				self.hpbar:addChild(var_17_11)
			else
				local var_17_12 = self:getAttribute("majorAttr")
				local var_17_13

				if config._DEBUG then
					var_17_13 = cc.Sprite:create(var_0_17[var_17_12]) or cc.Sprite:createWithSpriteFrameName(var_0_17[var_17_12])
				end

				var_17_13:setPosition(cc.p(-70 * self._direction, var_17_7:getPositionY()))
				self.hpbar:addChild(var_17_13)
			end
		end

		if self.charactertype == "player" then
			self.hpbar:setVisible(not FightManager.isNormalFight() or FightManager.isFightingBoss())
		end
	end
end

function FightCharacter:resetTowerBaseHpBar()
	self.hpbar = cc.Node:create()

	local var_18_0 = GameDisplay.height * ORIGIN_FIGHT_HEIGHT / GameDisplay.origin_design_y - GameDisplay.fix_y
	local var_18_1 = GameDisplay.height - (GameDisplay.height * ORIGIN_FIGHT_HEIGHT / GameDisplay.origin_design_y - GameDisplay.fix_y) - GameDisplay.fix_y - 80

	self.hpbar:setPosition(cc.p(0, GameDisplay.height - (GameDisplay.height * ORIGIN_FIGHT_HEIGHT / GameDisplay.origin_design_y - GameDisplay.fix_y) - GameDisplay.fix_y - 80))
	FightManager.addFightUI(self.hpbar)

	local var_18_2

	if config._DEBUG then
		var_18_2 = cc.Sprite:create("FightLayer/boss_blood_frame.png") or cc.Sprite:createWithSpriteFrameName("FightLayer/boss_blood_frame.png")
	end

	var_18_2:setAnchorPoint(cc.p(0.5, 1))
	var_18_2:setVisible(self.charactertype == "player")
	var_18_2:setPosition(320, GameDisplay.height - var_18_0 - var_18_1)
	self.hpbar:addChild(var_18_2, -1)

	local var_18_3 = {}

	var_18_3.careericon = self:getAttribute("majorAttr") and self:getAttribute("career") .. "_" .. self:getAttribute("majorAttr") or "class_" .. self:getAttribute("career") .. "_black"
	var_18_3.headimg = self.model.headimg
	var_18_3.lv = self.model.monsterlevel
	var_18_3.name = self.model.name
	var_18_3.charactertype = self.charactertype

	local var_18_4 = TowerBaseBarSprite:createHpBar(self.model.singlehp, self.model.singlehp, self.model.hpcount, 1, var_18_3)

	var_18_4:setName("hpbar")
	var_18_4:setPositionX(self.charactertype == "player" and 0 or 640)
	self.hpbar:addChild(var_18_4, 1)

	self.horcruxSkillsNode = cc.Node:create()

	self.horcruxSkillsNode:setPosition(cc.p(-220, 70))
	self.hpbar:addChild(self.horcruxSkillsNode)
	self:initialBossBuffPanel(var_18_1 - 60)
end

function FightCharacter:initialBossBuffPanel(arg_19_1)
	self.buffpanel = FightBuffPanel:create()

	self.buffpanel:setAnchor(1)
	self.buffpanel:setPosition(cc.p(560, arg_19_1 - 45))
	FightManager.addFightUI(self.buffpanel)
end

function FightCharacter:initialCaptainBuffPanel()
	self.buffpanel = FightBuffPanel:create()

	self.buffpanel:setAnchor(1)
	self.buffpanel:setScale(0.625)
	FightManager.pushCaptainUI(self.buffpanel, cc.p(160, -40), self._captainindex)
end

function FightCharacter:onEnter()
	if self._enterhandler then
		self._enterhandler()
	end
end

function FightCharacter.registerEnterHandler(arg_22_0, arg_22_1)
	arg_22_0._enterhandler = arg_22_1
end

function FightCharacter:onExit()
	self._instance = false

	if self.skeletonindex then
		FightUIElementsManager.detachCharacter(self.skeletonindex)
	end

	if self.skeletondata then
		self.skeletondata:release()

		self.skeletondata = nil
	end

	if self._boss then
		if self.hpbar then
			self.hpbar:runAction(cc.Sequence:create(cc.DelayTime:create(1), cc.RemoveSelf:create()))
		end

		if self.buffpanel then
			self.buffpanel:runAction(cc.RemoveSelf:create())
		end
	elseif self._captainindex then
		if self.hpbar then
			self.hpbar:runAction(cc.Sequence:create(cc.DelayTime:create(1), cc.RemoveSelf:create()))
		end

		if self.buffpanel then
			self.buffpanel:runAction(cc.RemoveSelf:create())
		end
	end

	self.logic:finishFight()

	self._slaves = nil

	if self._exithandler then
		self._exithandler()
	end
end

function FightCharacter.registerExitHandler(arg_24_0, arg_24_1)
	arg_24_0._exithandler = arg_24_1
end

function FightCharacter:checkInstance()
	return self._instance
end

function FightCharacter:isBoss()
	return self._boss
end

function FightCharacter.setBossTag(arg_27_0)
	arg_27_0._boss = true
end

function FightCharacter:setBossHpBarVisible(arg_28_1)
	if not self._boss then
		return
	end

	if self.hpbar then
		self.hpbar:setVisible(arg_28_1)
	end

	if self.buffpanel then
		self.buffpanel:setVisible(arg_28_1)
	end
end

function FightCharacter:setCaptainHpBarVisible(arg_29_1)
	if not self._captainindex then
		return
	end

	if self.hpbar then
		self.hpbar:setVisible(arg_29_1)
	end

	if self.buffpanel then
		self.buffpanel:setVisible(arg_29_1)
	end
end

function FightCharacter.attachUIindex(arg_30_0, arg_30_1)
	arg_30_0.skeletonindex = arg_30_1
end

function FightCharacter.registerDefaultZOrder(arg_31_0, arg_31_1)
	arg_31_0._defaultzorder = arg_31_1
end

function FightCharacter.registerDefaultY(arg_32_0, arg_32_1)
	arg_32_0._defaulty = arg_32_1
end

function FightCharacter.setGravityEnabled(arg_33_0, arg_33_1)
	arg_33_0._enablegravity = arg_33_1
end

function FightCharacter:reset()
	self.model.curhp = self.model.singlehp
	self.model.curhpcount = self.model.hpcount

	self.hpbar:getChildByName("hpbar"):setCurHp(self.model.singlehp)
	self.hpbar:getChildByName("hpbar"):setTotalHp(self.model.singlehp)
	self.hpbar:getChildByName("hpbar"):setHpCount(self.model.curhpcount)
	self:resumeAni()
	self:setVisible(true)

	if self.charactertype == "player" then
		self.hpbar:setVisible(not FightManager.isNormalFight() or FightManager.isFightingBoss())
	else
		self.hpbar:setVisible(true)
	end

	self._behitted = 0
	self._distance = 0
	self._movingForward = nil
	self._rushingForward = nil
	self._carriedconf = nil
	self._fightforce = nil
	self._fightforceY = nil
	self._gravity = nil
	self._grabing = nil
	self._grabed = nil
	self._running = false
	self._lockmove = false
	self._enablegravity = true
	self._playing = nil
	self._godie = false
	self._suppress = false
	self._revivaling = nil
	self._usingXP = false
	self._hideondie = false
	self._attackcount = 0
	self._skillcount = 0

	if self:getStatus() == STATUS_DIED then
		self:registerStatusPool()
	end

	self:resetAllCD()
	self:resetRage()
	self.statuspool:clearTriggerCD()
	self:setStatus(STATUS_SEARCHING)

	if self.charactertype == "player" then
		self:relive()
	end
end

function FightCharacter:pauseAni()
	if not self._pause then
		self._pause = true

		if self:getState() ~= STATE_DIED and self:getState() ~= STATE_REVIVAL or self._godie then
			self:recordCurAni()
			self:playIdle()
		end

		self:stopMoving()
		self:setSpeed(0)

		if self._carriedconf then
			self._carriedconf:lock()
		end

		if self._rushingForward then
			self._rushingForward:lock()
		end

		self:setBossHpBarVisible(self:isVisible())
		self:setCaptainHpBarVisible(self:isVisible())
	end
end

function FightCharacter:resumeAni()
	if self._pause then
		self._pause = false

		self:replayPreAni()

		if self._carriedconf then
			self._carriedconf:unlock()
		end

		if self._rushingForward then
			self._rushingForward:unlock()
		end

		self:setBossHpBarVisible(true)
		self:setCaptainHpBarVisible(true)
	end
end

function FightCharacter:lockcharacter()
	if not self._globallock then
		self.skeleton:pause()

		self._globallock = true

		self:setBossHpBarVisible(false)
		self:setCaptainHpBarVisible(false)
	end
end

function FightCharacter:unlockcharacter()
	if self._globallock then
		self._globallock = false

		self:setBossHpBarVisible(self._pause and self:isVisible())
		self:setCaptainHpBarVisible(self._pause and self:isVisible())

		if not self._battlefieldlock then
			self.skeleton:resume()
		end
	end
end

function FightCharacter:lockBattleField()
	self._battlefieldlock = true

	self.skeleton:pause()
end

function FightCharacter:unlockBattleField()
	if self._battlefieldlock then
		self._battlefieldlock = false

		if not self._globallock then
			self.skeleton:resume()
		end
	end
end

function FightCharacter:showOnXP(arg_41_1)
	if arg_41_1 then
		if not self._hideondie then
			self:setVisible(true)
		end
	else
		self:setVisible(false)
	end
end

function FightCharacter:onUseXPBegin(arg_42_1)
	self._usingXP = true

	self.hpbar:setVisible(false)

	if self.buffpanel and self.charactertype == "enemy" then
		self.buffpanel:setVisible(false)
	end

	self:hideBuffEffect()
	self:removeCarriedConf()
	self:finishForce()
end

function FightCharacter:onUseXPEnd()
	self._usingXP = false

	if self.charactertype == "player" then
		self.hpbar:setVisible(not FightManager.isNormalFight() or FightManager.isFightingBoss())
	else
		self.hpbar:setVisible(true)
	end

	if self.buffpanel and self.charactertype == "enemy" then
		self.buffpanel:setVisible(true)
	end

	self:showBuffEffect()
	self:setPositionY(self._defaulty)
	self:setGravityEnabled(true)
end

function FightCharacter:switchTimeScale(arg_44_1)
	self.skeleton:setTimeScale(self.skeleton:getTimeScale() * arg_44_1)

	for iter_44_0, iter_44_1 in pairs(self.buff_effect_tbl) do
		iter_44_1.effect:setTimeScale(iter_44_1.effect:getTimeScale() * arg_44_1)
	end
end

function FightCharacter:setTimeScale(arg_45_1)
	self.skeleton:setTimeScale(arg_45_1)
end

function FightCharacter:getTimeScale()
	return self.skeleton:getTimeScale()
end

function FightCharacter:recordCurAni()
	if not self._lastAniName then
		return
	end

	if not self.skeleton:isAnimationExist(self._lastAniName) then
		return
	end

	self._preAni = {}
	self._preAni.ani = self._lastAniName
	self._preAni.isloop = self.skeleton:isAnimationLoop()
	self._preAni.time = self.skeleton:getAnimationTime()
end

function FightCharacter:replayPreAni()
	if not self._preAni then
		return
	end

	if not self._preAni.ani then
		return
	end

	self:play(self._preAni.ani, self._preAni.isloop, self._preAni.time)

	self._preAni = nil
end

function FightCharacter.removeAniRecord(arg_49_0)
	arg_49_0._preAni = nil
end

function FightCharacter:setSlotTexture(arg_50_1, arg_50_2, arg_50_3)
	self.skeleton:setSlotTexture(arg_50_1, arg_50_2, arg_50_3, 1, self.skeletondata:getData())
end

function FightCharacter:getAniSuffix()
	if not self._transformer then
		return ""
	end

	return "_" .. self._transformer
end

function FightCharacter:play(arg_52_1, arg_52_2, arg_52_3, arg_52_4)
	if self._lock then
		return
	end

	if arg_52_2 == nil then
		arg_52_2 = true
	end

	local var_52_0 = arg_52_1

	arg_52_1 = arg_52_1 .. self:getAniSuffix()
	self._playing = nil
	self._lastAniName = nil

	if self.skeleton:isAnimationExist(arg_52_1) then
		self.skeleton:setAnimation(0, arg_52_1, arg_52_2)

		self._lastAniName = var_52_0

		if arg_52_3 and arg_52_3 > 0 then
			self.skeleton:jumpToTime(arg_52_3)
		end
	end

	if var_52_0 ~= "idle" and var_52_0 ~= "idle_fly" then
		self._idle = false
	end
end

function FightCharacter.addAnimation(arg_53_0, arg_53_1, arg_53_2)
	return
end

function FightCharacter:clearTracks()
	self.skeleton:clearTracks()

	self._lastAniName = nil
end

function FightCharacter:setToSetupPose()
	self.skeleton:setToSetupPose()
end

function FightCharacter:playIdle()
	if not self._idle then
		if self._unitorder == 1 then
			self:play("idle_fly")
		else
			self:play("idle")
		end

		self._idle = true
	end
end

function FightCharacter:playDieAni()
	self._aniWait = true

	self:cleanAllHandlers()

	if self._unitorder == 1 then
		self:play("die_fly", false)
	else
		self:play("die", false)
	end

	self:pushInDieHandler(self.skeleton:getAnimationDuration())
	self:playSlaveDieAni()
end

function FightCharacter:playSlaveDieAni()
	if not self._slaves then
		return
	end

	for iter_58_0, iter_58_1 in ipairs(self._slaves) do
		iter_58_1:playDieAni()
	end
end

function FightCharacter:playWinAni()
	if self._unitorder == 1 then
		self:play("win_fly", false)
	else
		self:play("win", false)
	end

	self:pushInWinHandler(self.skeleton:getAnimationDuration())
	self:playSlaveWinAni()
end

function FightCharacter:playSlaveWinAni()
	if not self._slaves then
		return
	end

	for iter_60_0, iter_60_1 in ipairs(self._slaves) do
		iter_60_1:playWinAni()
	end
end

function FightCharacter:shaderDark()
	if not self._shader then
		l2util:shaderDarkNode(self.skeleton)

		self._shader = true
	end
end

function FightCharacter:unshaderDark()
	if self._shader then
		l2util:recoverShader(self.skeleton)

		self._shader = false
	end
end

function FightCharacter:runFight()
	self.logic:runFight()

	if self._slaves then
		for iter_63_0, iter_63_1 in ipairs(self._slaves) do
			iter_63_1:runFight()
		end
	end
end

function FightCharacter:finishFight()
	self:cleanAllFightHandlers()
	self.logic:finishFight()
	self.skilllogic:clean_xp_effect()

	self.target = nil
	self._locktargetpool = nil
	self._movingForward = nil

	self:removeRushingForward()

	self._grabing = nil

	self:stopMoving()
	self:setSpeed(0)

	self._attackcount = 0
	self._skillcount = 0
	self._playing = nil
	self._locktargetpool = nil

	if self._slaves then
		for iter_64_0, iter_64_1 in ipairs(self._slaves) do
			iter_64_1:finishFight()
		end
	end
end

function FightCharacter:getAttackcount()
	return self._attackcount
end

function FightCharacter:addAttackcount(arg_66_1)
	arg_66_1 = arg_66_1 or 1
	self._attackcount = self._attackcount + arg_66_1
end

function FightCharacter:getSkillcount()
	return self._skillcount
end

function FightCharacter:addSkillcount(arg_68_1)
	arg_68_1 = arg_68_1 or 1
	self._skillcount = self._skillcount + arg_68_1
end

function FightCharacter:getAttackCDCount()
	return self._attack_cd_count
end

function FightCharacter:addAttackCDCount(arg_70_1)
	arg_70_1 = arg_70_1 or 1
	self._attack_cd_count = self._attack_cd_count + arg_70_1
end

function FightCharacter.setAttackCDCount(arg_71_0, arg_71_1)
	if not arg_71_1 then
		return
	end

	arg_71_0._attack_cd_count = arg_71_1
end

function FightCharacter.resetAttackCDCount(arg_72_0)
	arg_72_0._attack_cd_count = 0
end

function FightCharacter:shutDown(arg_73_1)
	self._playing = nil

	self:cleanAllFightHandlers()
	self:removeAniRecord()

	arg_73_1 = arg_73_1 or "idle"

	if arg_73_1 == "hitdown" then
		self:setUnitOrder(0, true)
	elseif self._unitorder == 1 then
		arg_73_1 = arg_73_1 .. "_fly"
	end

	self.skeleton:setTimeScale(global_battlefield_timescale * FightManager.getBossSpeedUp())

	if arg_73_1 ~= "clearTracks" then
		self:play(arg_73_1, false)
	end

	self._running = false

	self:setSpeed(0)

	self._movingForward = nil

	self:removeRushingForward()

	self._grabing = nil
	self._locktargetpool = nil

	if self._pause then
		if arg_73_1 == "hitdown" or arg_73_1 == "hitdown_fly" then
			self:pushInShutDownHandler(1)
		else
			self:pushInResetHandler()
		end
	elseif arg_73_1 == "hitdown" or arg_73_1 == "hitdown_fly" then
		self:pushInShutDownHandler(1)
	else
		self.logic:reset()
	end
end

function FightCharacter:shutDownSlaves(arg_74_1)
	if not self._slaves then
		return
	end

	for iter_74_0, iter_74_1 in ipairs(self._slaves) do
		iter_74_1:shutDown(arg_74_1)
	end
end

local function var_0_19(arg_75_0)
	if #arg_75_0 == 0 then
		return nil
	elseif #arg_75_0 == 1 then
		return FightManager.getCharacter(arg_75_0[1]):getPosition()
	else
		return FightManager.getCharacter(arg_75_0[var_0_1.round(#arg_75_0 / 2)]):getPosition()
	end
end

function FightCharacter:lockTarget(arg_76_1)
	if type(arg_76_1) == "string" then
		self.target = arg_76_1
		self._lastTarget = arg_76_1

		if not self._lockturnbacklimit then
			self:switchDirection(self:getPosition() < self:getTarget():getPosition() and 1 or self:getPosition() > self:getTarget():getPosition() and -1 or self._direction)
		end
	elseif type(arg_76_1) == "table" then
		self.target = arg_76_1
		self._lastTarget = nil

		if not self._lockturnbacklimit then
			local var_76_2 = var_0_19(self.target)

			if not var_76_2 then
				return
			end

			self:switchDirection(var_76_2 > self:getPosition() and 1 or var_76_2 < self:getPosition() and -1 or self._direction)
		end
	end
end

function FightCharacter:addShield(arg_77_1, arg_77_2)
	local var_77_0 = self.statuspool:getStatus("shield")

	var_77_0.total = var_77_0.total + arg_77_1

	var_0_2.insert(var_77_0.list, {
		id = arg_77_2,
		value = arg_77_1
	})

	if self.hpbar then
		self.hpbar:getChildByName("hpbar"):addShield(var_77_0.total)
	end
end

function FightCharacter:removeShield(arg_78_1)
	local var_78_0 = self.statuspool:getStatus("shield")
	local var_78_1

	for iter_78_0, iter_78_1 in ipairs(var_78_0.list) do
		if iter_78_1.id == arg_78_1 then
			var_78_1 = iter_78_0

			break
		end
	end

	if var_78_1 then
		local var_78_2 = var_0_2.remove(var_78_0.list, var_78_1)

		var_78_0.total = var_78_0.total - var_78_2.value

		if self.hpbar then
			self.hpbar:getChildByName("hpbar"):reduceShield(var_78_2.value)
		end
	end
end

function FightCharacter:hitShield(arg_79_1)
	local var_79_0 = self.statuspool:getStatus("shield")

	if var_79_0.total > 0 then
		local var_79_1 = arg_79_1 <= var_79_0.total and arg_79_1 or var_79_0.total

		var_79_0.total = var_79_0.total - (arg_79_1 <= var_79_0.total and arg_79_1 or var_79_0.total)
		arg_79_1 = arg_79_1 - var_79_1

		local var_79_2 = var_79_0.list
		local var_79_3 = {}

		for iter_79_0 = 1, #var_79_0.list do
			var_79_2[iter_79_0].value = var_79_2[iter_79_0].value - (var_79_1 <= var_79_2[iter_79_0].value and var_79_1 or var_79_2[iter_79_0].value)
			var_79_1 = var_79_1 - (var_79_1 <= var_79_2[iter_79_0].value and var_79_1 or var_79_2[iter_79_0].value)

			if var_79_2[iter_79_0].value <= 0 then
				var_0_2.insert(var_79_3, var_79_2[iter_79_0].id)
			end

			if var_79_1 <= 0 then
				break
			end
		end

		for iter_79_1 = #var_79_3, 1, -1 do
			self.statuspool:removeShieldByID(var_79_3[iter_79_1])
		end

		if self.hpbar then
			self.hpbar:getChildByName("hpbar"):reduceShield(var_79_1, true)
		end
	end

	return arg_79_1
end

function FightCharacter:calculateDefence(arg_80_1, arg_80_2, arg_80_3)
	if arg_80_1 == MECHANICAL_DAMAGE then
		local var_80_0 = self:getAttribute("defence")

		arg_80_2 = arg_80_2 * (1 - self:getAttribute("mechanical_attack_resistance"))

		if arg_80_3 then
			var_80_0 = var_80_0 * (1 - arg_80_3:getAttribute("piercepercent")) - arg_80_3:getAttribute("pierce")
		end

		local var_80_1 = var_80_0 / (var_0_1.abs(var_80_0) + DEFENCE_CONSTANT) * (1 + self:getAttribute("defence_rate"))

		if var_80_1 > 1 then
			var_80_1 = 1
		end

		if var_80_1 < 0 then
			var_80_1 = 0
		end

		return var_0_1.round(arg_80_2 * (1 - var_80_1))
	elseif arg_80_1 == ENERGY_DAMAGE then
		local var_80_2 = self:getAttribute("energydefence")

		arg_80_2 = arg_80_2 * (1 - self:getAttribute("energy_attack_resistance"))

		if arg_80_3 then
			var_80_2 = var_80_2 * (1 - arg_80_3:getAttribute("energypiercepercent")) - arg_80_3:getAttribute("energypierce")
		end

		local var_80_3 = var_80_2 / (var_0_1.abs(var_80_2) + DEFENCE_CONSTANT)

		if var_80_3 > 1 then
			var_80_3 = 1
		end

		if var_80_3 < 0 then
			var_80_3 = 0
		end

		return var_0_1.round(arg_80_2 * (1 - var_80_3))
	end

	return arg_80_2
end

function FightCharacter:pushBackHitnumber(arg_81_1)
	var_0_2.insert(self._hitnumberpool, arg_81_1)
end

function FightCharacter:popHitnumber()
	for iter_82_0 = 1, #self._hitnumberpool do
		local var_82_1 = var_0_1.random(1, 30)
		local var_82_2 = var_0_1.random(1, 30)
		local var_82_3
		local var_82_5

		if self._hitnumberpool[iter_82_0].side then
			var_82_3 = self._hitnumberpool[iter_82_0].side

			local var_82_4 = os.time()

			var_82_5 = self:getParent()
		end

		NumberLabelSprite:hitNumber(var_82_5, self._hitnumberpool[iter_82_0].posx + ((#self._hitnumberpool + 1) / 2 - iter_82_0) * 35 + var_82_1, self._hitnumberpool[iter_82_0].posy, self._hitnumberpool[iter_82_0].number, self._hitnumberpool[iter_82_0].cri, self._hitnumberpool[iter_82_0].miss, self._hitnumberpool[iter_82_0].strike, self._hitnumberpool[iter_82_0].restrain, global_battlefield_timescale * FightManager.getBossSpeedUp(), var_82_3, self._hitnumberpool[iter_82_0].attacktype, self._hitnumberpool[iter_82_0].blind)
	end

	self._hitnumberpool = {}
end

function FightCharacter:onHittedShutDown(arg_83_1)
	if self.statuspool:checkStatus("vertigo") then
		return
	end

	if self.statuspool:checkStatus("stone") then
		return
	end

	if self._usingXP then
		return
	end

	if not arg_83_1 then
		if self._pause then
			self.skeleton:setTimeScale(global_battlefield_timescale * FightManager.getBossSpeedUp())

			if self._unitorder == 1 then
				self:play("hit_fly", false)
			else
				self:play("hit", false)
			end
		end
	else
		if self.statuspool:checkStatus("antihitdown") then
			return
		end

		self:shutDown(arg_83_1)
	end
end

function FightCharacter:beHittedBlind()
	self:pushBackHitnumber({
		restrain = false,
		number = 0,
		cri = false,
		blind = true,
		strike = false,
		miss = false,
		attacktype = 1,
		posx = self:getPositionX(),
		posy = self:getPositionY() + self:getAttribute("model_height") * STANDARD_SCALE * self:getAttribute("model_scale") + HITWORD_HEIGHT,
		side = self.charactertype
	})
end

function FightCharacter:isDamageCauseDie(arg_85_1, arg_85_2)
	if arg_85_1 == HOLY_DAMAGE then
		return arg_85_2 >= self:getAttribute("curhp") + self:getAttribute("singlehp") * (self:getAttribute("curhpcount") - 1)
	else
		local var_85_0 = self:getAttribute("curhp") + self:getAttribute("singlehp") * (self:getAttribute("curhpcount") - 1)

		arg_85_2 = arg_85_2 - self.statuspool:getStatus("shield").total

		if arg_85_2 <= 0 then
			return false
		end

		arg_85_2 = self:calculateDefence(arg_85_1, arg_85_2)

		return var_85_0 <= arg_85_2
	end
end

function FightCharacter:beHitted(arg_86_1, arg_86_2)
	if arg_86_1.damage <= 0 then
		if arg_86_1.info and arg_86_1.info.isBlind then
			self:beHittedBlind()
		end

		return false
	end

	if not self:canBeHit() then
		return false
	end

	local var_86_0 = FightManager.getCharacter(arg_86_1.sourceindex)

	if var_86_0 and var_86_0.statuspool:getStatus("damage_change_mechanical") then
		arg_86_1.damagetype = MECHANICAL_DAMAGE
	end

	if self.statuspool:getStatus("suffer_damage_change_mechanical") then
		arg_86_1.damagetype = MECHANICAL_DAMAGE
	end

	if not arg_86_1.behitted then
		self._behitted = 0.2
	end

	self:onHittedShutDown(arg_86_1.behitted)

	if arg_86_1.sourceindex and arg_86_1.info.isRes == nil then
		local var_86_1, var_86_2 = calculate_majorattr_addition(FightManager.getCharacter(arg_86_1.sourceindex), self)

		arg_86_1.info.isRes = var_86_1
		arg_86_1.damage = var_0_1.floor(arg_86_1.damage * var_86_2)
	end

	arg_86_1.damage = arg_86_1.damage * (1 + FightManager.getGlobalDamageAddition())

	local var_86_3 = self:getAttribute("max_taken_damage")

	if var_86_3 then
		self:setAttribute("max_taken_damage", var_86_3 * (1 + FightManager.getGlobalDamageAddition()))
	end

	if self:isDamageCauseDie(arg_86_1.damagetype, arg_86_1.damage) then
		self:triggerStatus("onDyingBeforeSheild", FightManager.getCharacter(arg_86_1.sourceindex), arg_86_1)
	end

	local var_86_4 = {
		damage = 0,
		finalhit = true
	}
	local var_86_5 = 0

	if arg_86_1.damagetype == HOLY_DAMAGE then
		var_86_4.damage = arg_86_1.damage
		var_86_5 = arg_86_1.damage
	else
		var_86_4.damage = self:hitShield(arg_86_1.damage)
		var_86_4.damage = self:calculateDefence(arg_86_1.damagetype, var_86_4.damage, FightManager.getCharacter(arg_86_1.sourceindex))
		arg_86_1.damage = var_86_4.damage + (arg_86_1.damage - var_86_4.damage)
		var_86_5 = arg_86_1.damage
	end

	if var_86_0 and not var_86_0.statuspool:getStatus("ignoremaxdamage") and self:getAttribute("max_taken_damage") > 0 and arg_86_1.damage > self:getAttribute("max_taken_damage") then
		arg_86_1.damage = self:getAttribute("max_taken_damage")
		var_86_5 = arg_86_1.damage
		var_86_4.damage = arg_86_1.damage
	end

	FightManager.addStatistics("damage", var_86_5, arg_86_1.sourceindex, self.index, arg_86_1)

	if not arg_86_2 then
		arg_86_1.triggeronhurt = true

		if arg_86_1.damagetype == MECHANICAL_DAMAGE then
			if FightManager.getCharacter(arg_86_1.sourceindex) then
				FightManager.getCharacter(arg_86_1.sourceindex):triggerStatus("onMechanicalDamage", self, arg_86_1)
			end

			self:triggerStatus("onMechanicalHurt", FightManager.getCharacter(arg_86_1.sourceindex), arg_86_1)
		elseif arg_86_1.damagetype == ENERGY_DAMAGE then
			if FightManager.getCharacter(arg_86_1.sourceindex) then
				FightManager.getCharacter(arg_86_1.sourceindex):triggerStatus("onEnergyDamage", self, arg_86_1)
			end

			self:triggerStatus("onEnergyHurt", FightManager.getCharacter(arg_86_1.sourceindex), arg_86_1)
		end

		self:triggerStatus("onHurt", FightManager.getCharacter(arg_86_1.sourceindex), arg_86_1)
	end

	if self._bear and self._bear:transferDamage({
		damage = var_86_4.damage,
		damagetype = arg_86_1.damagetype,
		sourceindex = arg_86_1.sourceindex,
		info = {
			isRes = false
		}
	}) then
		local var_86_6 = self._bear:getEffect()

		self:playStatusEffect(false, var_86_6.filename, var_86_6.ani, var_86_6.offsetX, var_86_6.offsetY, var_86_6.offsetZ, self:getDirection())

		var_86_4.damage = var_86_4.damage * (1 - self._bear:getPercent())
	end

	local var_86_7 = false

	if self._contracted then
		local var_86_8 = FightManager.getCharacter(self._contracted:getIndex())

		if var_86_8 and var_86_8._bear then
			var_86_7 = true
		end
	end

	if not var_86_7 and self:getAttribute("curhp") + self:getAttribute("singlehp") * (self:getAttribute("curhpcount") - 1) - var_86_4.damage <= 0 then
		if self._contracted and self._contracted:trigger({
			damage = var_86_4.damage,
			damagetype = arg_86_1.damagetype,
			sourceindex = arg_86_1.sourceindex
		}) then
			local var_86_9 = self._contracted:getEffect()

			self:playStatusEffect(false, var_86_9.filename, var_86_9.ani, var_86_9.offsetX, var_86_9.offsetY, var_86_9.offsetZ, self:getDirection())

			return false
		end

		self:triggerStatus("onDying", FightManager.getCharacter(arg_86_1.sourceindex), var_86_4)

		if not self.statuspool:getStatus("superimmortal") and (arg_86_1.immortallimit or not self.statuspool:getStatus("immortal")) then
			self:triggerStatus("onDyingNoImmortal", FightManager.getCharacter(arg_86_1.sourceindex), var_86_4)
		end
	end

	local var_86_10 = self:addCurHp(-1 * var_0_1.round(var_86_4.damage), arg_86_1.immortallimit)

	if self.skeleton then
		local var_86_11 = arg_86_1.info.beattype

		if arg_86_1.damagetype == ENERGY_DAMAGE then
			var_86_11 = 10

			if arg_86_1.skilltype == "attack" then
				var_86_11 = 9
			elseif arg_86_1.skilltype == "xp" then
				var_86_11 = 11
			end
		end

		self:pushBackHitnumber({
			posx = self:getPositionX(),
			posy = self:getPositionY() + (self:getAttribute("model_height") + self:getRootOffsetY()) * STANDARD_SCALE * self:getAttribute("model_scale") + HITWORD_HEIGHT,
			number = var_0_1.round(-1 * var_86_5),
			cri = arg_86_1.info.isCri,
			miss = arg_86_1.info.isMiss,
			strike = arg_86_1.info.isStrike,
			restrain = arg_86_1.info.isRes,
			side = self.charactertype,
			attacktype = var_86_11
		})
	end

	if var_86_10 < 0 then
		self:addRageOnHitted(-var_86_10)
	end

	if self:getAttribute("curhp") < 1 and self:getAttribute("curhpcount") <= 1 then
		return self:dieAction(arg_86_1.sourceindex)
	end

	return false
end

function FightCharacter:getRecovery(arg_87_1, arg_87_2)
	if arg_87_1.heal and arg_87_1.heal > 0 then
		if self:getStatus() == STATUS_DIED then
			return
		end

		if not arg_87_2 then
			arg_87_1.triggeronheal = true

			self.triggerStatus(self, "onHeal", self, arg_87_1)
		end

		local var_87_0 = 1 + self:getAttribute("extra_heal")

		if arg_87_1.sourceindex and FightManager.getCharacter(arg_87_1.sourceindex) then
			var_87_0 = var_87_0 + FightManager.getCharacter(arg_87_1.sourceindex):getAttribute("extra_heal_extern")
		end

		if var_87_0 < 0 then
			var_87_0 = 0
		end

		local var_87_1 = var_0_1.round(arg_87_1.heal * var_87_0 + self:getAttribute("extra_heal_const"))

		FightManager.addStatistics("heal", var_87_1, arg_87_1.sourceindex, nil, arg_87_1)

		local var_87_2 = self:addCurHp(var_87_1)

		FightManager.addStatistics("effective_heal", var_87_2, arg_87_1.sourceindex, nil, arg_87_1)

		if self.skeleton then
			if var_87_2 > 0 then
				self:pushBackHitnumber({
					miss = false,
					cri = false,
					attacktype = 4,
					strike = false,
					posx = self:getPositionX(),
					posy = self:getPositionY() + self:getAttribute("model_height") * STANDARD_SCALE * self:getAttribute("model_scale") + HITWORD_HEIGHT,
					number = var_87_1,
					side = self.charactertype
				})
			end
		end

		if var_87_2 > 0 and FightManager.getCharacter(arg_87_1.sourceindex) then
			FightManager.getCharacter(arg_87_1.sourceindex):addRageOnHeal(var_87_2)
		end
	end
end

function FightCharacter:dieAction(arg_88_1)
	if self:getStatus() == STATUS_DIED then
		return false
	end

	if self:getStatus() == STATUS_REVIVAL then
		return false
	end

	self.statuspool:setStatus("invincible", false)
	self.statuspool:setStatus("invincible_count", 0)
	self:setStatus(STATUS_DIED)
	self:triggerStatus("onDied", FightManager.getCharacter(arg_88_1))

	self._godie = true

	return true
end

function FightCharacter:getState()
	return self._state
end

function FightCharacter:setState(arg_90_1)
	self:switchState(arg_90_1)
end

function FightCharacter:switchState(arg_91_1)
	if self._state == arg_91_1 then
		return
	end

	self._state = arg_91_1
end

FightCharacter.getStatus = FightCharacter.getState
FightCharacter.setStatus = FightCharacter.setState
FightCharacter.switchStatus = FightCharacter.switchState

function FightCharacter:update(arg_92_1)
	if self._globallock then
		return
	end

	if self._battlefieldlock then
		return
	end

	self:popHitnumber()
	self:updateGravity(arg_92_1)
	self:updateSubUIPos()

	if self._pause then
		self:updateXPBehavior(arg_92_1)
		self:updateSlaves(arg_92_1)

		return
	end

	self:updateStatus(arg_92_1)
	self:updateHandlers(arg_92_1)
	self:updateFightState(arg_92_1)
	self:updateBehavior(arg_92_1)

	if not self._usingXP then
		self.statuspool:updateStatusPool(arg_92_1)

		if self._contracted then
			self._contracted:update(arg_92_1)
		end
	end

	self:updateSlaves(arg_92_1)
end

function FightCharacter:updateSlaves(arg_93_1)
	if not self._slaves then
		return
	end

	for iter_93_0, iter_93_1 in ipairs(self._slaves) do
		iter_93_1:update(arg_93_1)
	end
end

function FightCharacter:updateStatus(arg_94_1)
	if not self._usingXP then
		self:updateCDStatus(arg_94_1)
		self:updateTimer(arg_94_1)
		self:updateShutDown(arg_94_1)
	end

	self:updateCrash(arg_94_1)
end

function FightCharacter.updateFightState(arg_95_0, arg_95_1)
	return
end

function FightCharacter:updateBehavior(arg_96_1)
	if self._behitted > 0 then
		self.skeleton:playHitEffect(true)

		self._behitted = self._behitted - arg_96_1
	else
		self.skeleton:playHitEffect(false)
	end

	if self._movingForward then
		self._movingForward = false

		self.logic:updateFight()
	end

	self:updateMoveBehavior(arg_96_1)

	if self._slaves then
		for iter_96_0, iter_96_1 in ipairs(self._slaves) do
			iter_96_1:updateBehavior(arg_96_1)
		end
	end
end

function FightCharacter:updateXPBehavior(arg_97_1)
	if self._behitted > 0 then
		self.skeleton:playHitEffect(true)

		self._behitted = self._behitted - arg_97_1
	else
		self.skeleton:playHitEffect(false)
	end

	self:updateMoveBehavior(arg_97_1)
end

function FightCharacter:updateTimer(arg_98_1)
	self.statuspool:updateTriggerCD(arg_98_1)

	self._timer = self._timer - arg_98_1

	if self._timer > 0 then
		return
	end

	self.triggerStatus(self, "onTimer", self)

	local var_98_0 = self:getAttribute("healrate") + self:getAttribute("healpoint") * 5e-05

	if var_98_0 ~= 0 then
		local var_98_1 = 1 + self:getAttribute("extra_heal") + self:getAttribute("extra_heal_extern")

		if var_98_1 < 0 then
			var_98_1 = 0
		end

		local var_98_2 = self:addCurHp((var_0_1.round(var_98_0 * self:getBasicAttribute("hp") * var_98_1 + self:getAttribute("healconst"))))
	end

	self:addRageByValue((self:getAttribute("rage_recover_speed") or 0) * (1 + self:getAttribute("extra_recovery_rage")) + self:getAttribute("extra_recovery_rage_const"))

	self._timer = 1
end

function FightCharacter:updateCrash(arg_99_1)
	if not self._locktargetpool then
		return
	end

	if self._crossing then
		local var_99_0 = self:getCrashRect(self._crossing.fixbound)

		for iter_99_0, iter_99_1 in pairs(FightManager[self._locktargetpool]) do
			if iter_99_1.index ~= self.index and iter_99_1:canBeLocked(self:getAttackUnitOrder()) and not self._crossing.msg.hitted[iter_99_1.index] and FightManager.fightSpriteCrash(var_99_0, iter_99_1:getCrashRect()) then
				self._crossing.msg.hitted[iter_99_1.index] = true

				self._crossing.proc(iter_99_1.index)
			end
		end
	end

	if self._crashing and self._rushingForward then
		if self._crashing.crashtype == "once" then
			local var_99_1 = self:getCrashRect(self._crashing.fixbound)
			local var_99_2 = false

			for iter_99_2, iter_99_3 in pairs(FightManager[self._locktargetpool]) do
				if iter_99_3.index ~= self.index and iter_99_3:canBeLocked(self:getAttackUnitOrder()) and FightManager.fightSpriteCrash(var_99_1, iter_99_3:getCrashRect()) then
					self._crashing.proc(iter_99_3.index)

					var_99_2 = true
				end
			end

			if var_99_2 then
				self._crashing = nil

				self:removeRushingForward()
			end
		else
			local var_99_3 = self:getCrashRect(self._crashing.fixbound)

			for iter_99_4, iter_99_5 in pairs(FightManager[self._locktargetpool]) do
				if iter_99_5.index ~= self.index and iter_99_5:canBeLocked(self:getAttackUnitOrder()) and not self._crashing.msg.hitted[iter_99_5.index] and FightManager.fightSpriteCrash(var_99_3, iter_99_5:getCrashRect()) then
					self._crashing.msg.hitted[iter_99_5.index] = true

					self._crashing.proc(iter_99_5.index)

					if not self._rushingForward then
						break
					end

					iter_99_5:setCarriedConf(self._rushingForward, self:getCarriedFix(var_99_3, iter_99_5:getCrashRect(), arg_99_1))
				end
			end
		end
	end
end

function FightCharacter:updateSubUIPos()
	local var_100_0 = self.skeleton:getRootPosition()

	var_100_0.x = var_100_0.x * STANDARD_SCALE * self:getAttribute("model_scale") * self._direction
	var_100_0.y = var_100_0.y * STANDARD_SCALE * self:getAttribute("model_scale")

	if not self._boss and not self._captainindex then
		self.hpbar:setPosition(cc.p(var_100_0.x, var_100_0.y + self._size.height + HPBAR_HEIGHT))
	end

	for iter_100_0, iter_100_1 in pairs(self.buff_effect_tbl) do
		iter_100_1.effect:setPosition(cc.p(var_100_0.x + iter_100_1.offset.x, var_100_0.y + iter_100_1.offset.y))
	end
end

function FightCharacter:setAttribute(arg_101_1, arg_101_2)
	self.model:setAttribute(arg_101_1, arg_101_2)
	self.statuspool:influence_attr_chain(arg_101_1)
end

function FightCharacter:addAttribute(arg_102_1, arg_102_2, arg_102_3)
	if arg_102_1 == "curhp" then
		arg_102_2 = var_0_1.round(arg_102_2)

		self:addCurHp(arg_102_2)
	elseif arg_102_1 == "hp" then
		arg_102_2 = var_0_1.round(arg_102_2)

		self.model:addAttribute(arg_102_1, arg_102_2)

		local var_102_0 = var_0_1.floor(arg_102_2 / self.model:getAttribute("hpcount"))

		self.model:addAttribute("singlehp", var_102_0)
		self.model:addAttribute("curhp", (var_0_1.floor(var_102_0 * (self.model:getAttribute("curhp") / self.model:getAttribute("singlehp")))))

		if self.hpbar then
			self.hpbar:getChildByName("hpbar"):setTotalHp(self.model:getAttribute("singlehp"))
			self.hpbar:getChildByName("hpbar"):setCurHp(self.model:getAttribute("curhp"))
		end
	else
		self.model:addAttribute(arg_102_1, arg_102_2)

		if arg_102_1 == "range" then
			self.model:addAttribute("max_range", arg_102_2)
		end
	end

	if arg_102_2 ~= 0 then
		self.statuspool:influence_attr_chain(arg_102_1, arg_102_3)
	end
end

function FightCharacter:resetAttribute(arg_103_1, arg_103_2)
	if arg_103_1 == "curhp" then
		return
	end

	if arg_103_1 == "hp" then
		self.model:addAttribute(arg_103_1, arg_103_2)
		self.model:setAttribute("curhp", (var_0_1.floor(self.model:getAttribute("hp") * (self.model:getAttribute("curhp") / self.model:getAttribute("hp")))))
	else
		self.model:addAttribute(arg_103_1, arg_103_2)
	end
end

function FightCharacter:getAttribute(arg_104_1)
	if self.model:isAttributeIncludeExtern(arg_104_1) then
		return self.model:getAttribute(arg_104_1) + self.externmodel:getAttribute(arg_104_1)
	else
		return self.model:getAttribute(arg_104_1)
	end
end

function FightCharacter:rawGetAttribute(arg_105_1)
	return self.model:getAttribute(arg_105_1)
end

function FightCharacter:getBasicAttribute(arg_106_1)
	return self.model:getBasicAttribute(arg_106_1)
end

function FightCharacter:addCurHp(arg_107_1, arg_107_2)
	local var_107_0

	if arg_107_1 > 0 then
		if self.statuspool:getStatus("heallimit") then
			var_107_0 = 0
		else
			local var_107_1 = self:getAttribute("curhp") + self:getAttribute("singlehp") * (self:getAttribute("curhpcount") - 1)

			if var_107_1 + arg_107_1 >= self.model:getAttribute("singlehp") * self.model:getAttribute("hpcount") then
				self.model:setAttribute("curhp", self.model:getAttribute("singlehp"))
				self.model:setAttribute("curhpcount", self.model:getAttribute("hpcount"))

				var_107_0 = self.model:getAttribute("singlehp") * self.model:getAttribute("hpcount") - var_107_1
			else
				local var_107_2 = (var_107_1 + arg_107_1) % self:getAttribute("singlehp")

				if var_107_2 == 0 and var_107_1 + arg_107_1 >= self:getAttribute("singlehp") then
					var_107_2 = self:getAttribute("singlehp")
				end

				local var_107_3 = var_0_1.ceil((var_107_1 + arg_107_1) / self:getAttribute("singlehp"))

				self.model:setAttribute("curhp", var_107_2)
				self.model:setAttribute("curhpcount", var_107_3)

				var_107_0 = arg_107_1
			end
		end
	else
		local var_107_4 = self:getAttribute("curhp") + self:getAttribute("singlehp") * (self:getAttribute("curhpcount") - 1)

		if var_107_4 + arg_107_1 < 1 then
			if self.statuspool:getStatus("superimmortal") or not arg_107_2 and self.statuspool:getStatus("immortal") then
				local var_107_5 = 1

				if self:isBoss() and FightManager.getFightType() == FIGHTTYPE_EXPEDITION_MONOPOLY then
					var_107_5 = expedition_manager:checkMonopolyCurHp(var_107_5)
				end

				self.model:setAttribute("curhp", var_107_5)
				self.model:setAttribute("curhpcount", 1)

				var_107_0 = -var_107_4 + var_107_5
			else
				local var_107_6 = 0

				if self:isBoss() and FightManager.getFightType() == FIGHTTYPE_EXPEDITION_MONOPOLY then
					var_107_6 = expedition_manager:checkMonopolyCurHp(var_107_6)
				end

				self.model:setAttribute("curhp", var_107_6)
				self.model:setAttribute("curhpcount", 1)

				var_107_0 = -var_107_4 + var_107_6
			end
		else
			local var_107_7 = (var_107_4 + arg_107_1) % self:getAttribute("singlehp")

			if self:isBoss() and FightManager.getFightType() == FIGHTTYPE_EXPEDITION_MONOPOLY then
				var_107_7 = expedition_manager:checkMonopolyCurHp(var_107_7)
			end

			if var_107_7 == 0 then
				var_107_7 = self:getAttribute("singlehp")
			end

			local var_107_8 = var_0_1.ceil((var_107_4 + arg_107_1) / self:getAttribute("singlehp"))

			self.model:setAttribute("curhp", var_107_7)
			self.model:setAttribute("curhpcount", var_107_8)

			var_107_0 = arg_107_1
		end
	end

	if var_107_0 ~= 0 then
		self.statuspool:influence_attr_chain("curhp")

		if self.hpbar then
			self.hpbar:getChildByName("hpbar"):runBar(var_107_0)
		end
	end

	if self.updateHpCallFunc then
		self.updateHpCallFunc(self:getAttribute("curhp") + self:getAttribute("singlehp") * (self:getAttribute("curhpcount") - 1), self.model:getAttribute("singlehp") * self.model:getAttribute("hpcount"))
	end

	return var_107_0
end

function FightCharacter:isAttributeIncludeExtern(arg_108_1)
	return self.model:isAttributeIncludeExtern(arg_108_1)
end

function FightCharacter:addExternAttribute(arg_109_1, arg_109_2)
	if not self.externmodel then
		return
	end

	self.externmodel:addAttribute(arg_109_1, arg_109_2)

	if arg_109_2 ~= 0 then
		self.statuspool:influence_attr_chain(arg_109_1)
	end
end

function FightCharacter:getExternAttribute(arg_110_1)
	if self.model:isAttributeIncludeExtern(arg_110_1) then
		return self.externmodel:getAttribute(arg_110_1)
	else
		return 0
	end
end

function FightCharacter:refreshExternAttribute()
	for iter_111_0, iter_111_1 in pairs((self.externmodel:refreshExternModel())) do
		self.statuspool:influence_attr_chain(iter_111_1)
	end
end

function FightCharacter:getEffectStatus(arg_112_1)
	return self.statuspool:getStatus(arg_112_1)
end

function FightCharacter:doDoubleAttack(arg_113_1)
	self.skilllogic:runDoubleAttack(arg_113_1)
end

function FightCharacter:addRage(arg_114_1)
	if self._closerageadd then
		return
	end

	if self.statuspool:checkStatus("ragelimit") then
		return
	end

	if arg_114_1 > 0 and self:getAttribute("rage") >= self:getAttribute("maxrage") then
		return
	end

	arg_114_1 = arg_114_1 or 0
	arg_114_1 = arg_114_1 * (1 + self:getAttribute("extra_rage")) + self:getAttribute("extra_rage_const")

	self:addAttribute("rage", (var_0_1.max(-1 * self:getAttribute("rage"), (var_0_1.min(arg_114_1 / self:getAttribute("science_point"), self:getAttribute("maxrage") - self:getAttribute("rage"))))))

	if self.charactertype == "player" and self.__cname ~= "MonsterCharacter" and self.__cname ~= "BaseCharacter" then
		self:updateXPRageToPlayerItem(1)
	end
end

function FightCharacter:addRageOnHitted(arg_115_1)
	if self._closerageadd then
		return
	end

	if self.statuspool:checkStatus("ragelimit") then
		return
	end

	if arg_115_1 > 0 and self:getAttribute("rage") >= self:getAttribute("maxrage") then
		return
	end

	arg_115_1 = arg_115_1 / (1 + FightManager.getGlobalDamageAddition())

	self:addAttribute("rage", (var_0_1.max(-1 * self:getAttribute("rage"), (var_0_1.min(100 * self:getAttribute("hitted_rage_fac") * arg_115_1 / self:getAttribute("hp"), self:getAttribute("maxrage") - self:getAttribute("rage"))))))

	if self.charactertype == "player" and self.__cname ~= "MonsterCharacter" and self.__cname ~= "BaseCharacter" then
		self:updateXPRageToPlayerItem(1)
	end
end

function FightCharacter:addRageOnAttack()
	if self._closerageadd then
		return
	end

	if self.statuspool:checkStatus("ragelimit") then
		return
	end

	if self:getAttribute("rage") >= self:getAttribute("maxrage") then
		return
	end

	local var_116_0 = self:getAttribute("attack_rage_fac")

	if not var_116_0 then
		return
	end

	self:addAttribute("rage", (var_0_1.max(-1 * self:getAttribute("rage"), (var_0_1.min(var_116_0 / var_0_1.max(self:getAttribute("attackspeed"), 0.6) * (1 + self:getAttribute("extra_attack_rage")) + self:getAttribute("extra_rage_const"), self:getAttribute("maxrage") - self:getAttribute("rage"))))))

	if self.charactertype == "player" and self.__cname ~= "MonsterCharacter" and self.__cname ~= "BaseCharacter" then
		self:updateXPRageToPlayerItem(1)
	end
end

function FightCharacter.addRageOnHeal(arg_117_0, arg_117_1)
	return
end

function FightCharacter:addRageByValue(arg_118_1)
	if self.statuspool:checkStatus("ragelimit") then
		return
	end

	if arg_118_1 > 0 and self:getAttribute("rage") >= self:getAttribute("maxrage") then
		return
	end

	arg_118_1 = arg_118_1 or 0

	self:addAttribute("rage", (var_0_1.max(-1 * self:getAttribute("rage"), (var_0_1.min(arg_118_1, self:getAttribute("maxrage") - self:getAttribute("rage"))))))

	if self.charactertype == "player" and self.__cname ~= "MonsterCharacter" and self.__cname ~= "BaseCharacter" then
		self:updateXPRageToPlayerItem(1)
	end
end

function FightCharacter:resetRage()
	self:setAttribute("rage", 0)

	if self.charactertype == "player" and self.__cname ~= "MonsterCharacter" and self.__cname ~= "BaseCharacter" then
		self:updateXPRageToPlayerItem(2)
	end
end

function FightCharacter.closeRageAdd(arg_120_0)
	arg_120_0._closerageadd = true
end

function FightCharacter.openRageAdd(arg_121_0)
	arg_121_0._closerageadd = false
end

function FightCharacter:getUnitOrder()
	return self._unitorder
end

function FightCharacter:getAttackUnitOrder()
	return self._unitorder + self._attackunitorder
end

function FightCharacter:setUnitOrder(arg_124_1, arg_124_2)
	if self._unitorder == arg_124_1 then
		return
	end

	if arg_124_1 == 1 then
		-- block empty
	elseif not arg_124_2 then
		self:pushInDelayCallFuncs(0, function()
			if self._unitorder == 0 then
				self:addAnimation("land", false)
			end
		end)
	end

	self._unitorder = arg_124_1
end

function FightCharacter:isCharacterOverClock()
	return self:getAttribute("overclockRank") > 0
end

function FightCharacter:getBonePositionByName(arg_127_1)
	if not self.skeleton.getBonePositionByName then
		return nil
	end

	return self.skeleton:getBonePositionByName(arg_127_1)
end

function FightCharacter.registerUpdateHpCallFunc(arg_128_0, arg_128_1)
	arg_128_0.updateHpCallFunc = arg_128_1
end

function FightCharacter:updateHpPercent(arg_129_1)
	self:addCurHp(var_0_1.round(-(self.model:getAttribute("singlehp") * self.model:getAttribute("hpcount")) * (1 - arg_129_1)))
end

function FightCharacter:checkAttrValid(arg_130_1)
	return self:getAttribute("validAttr")[arg_130_1] == true
end

function FightCharacter:updateBloodWithExpedition(arg_131_1)
	if arg_131_1 == nil then
		return
	end

	self:setAttribute("curhp", self:getAttribute("hp") * arg_131_1 / 100)

	if self.hpbar then
		self.hpbar:getChildByName("hpbar"):setCurHp(self.model:getAttribute("curhp"))
	end
end

function FightCharacter:updateEnergyWithExpedition(arg_132_1)
	if arg_132_1 == nil then
		return
	end

	self:setAttribute("rage", self:getAttribute("maxrage") * arg_132_1 / 100)

	if self.charactertype == "player" and self.__cname ~= "MonsterCharacter" and self.__cname ~= "BaseCharacter" then
		self:updateXPRageToPlayerItem(1)
	end
end

function FightCharacter:getServantId()
	if self.model then
		return self.model.servantid
	end
end

function FightCharacter:getRagePercent()
	return self:getAttribute("rage") / self:getAttribute("maxrage")
end

function FightCharacter:strengthenHpAndDamage(arg_135_1)
	self:addAttribute("damage", arg_135_1 * 0.01 * self:getAttribute("damage"))
	self:addAttribute("hp", arg_135_1 * 0.01 * self:getAttribute("hp"))
	self:setAttribute("singlehp", var_0_1.floor(self:getAttribute("hp") / self:getAttribute("hpcount")))
	self:setAttribute("curhp", self:getAttribute("singlehp"))

	if self.hpbar then
		self.hpbar:getChildByName("hpbar"):setTotalHp(self.model:getAttribute("singlehp"))
		self.hpbar:getChildByName("hpbar"):setCurHp(self.model:getAttribute("curhp"))
	end
end
