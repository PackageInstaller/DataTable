local var_0_0 = g.core.model.User.mysteryData
local var_0_1 = g.core.const.ConstMgr.MysteryConst
local DayNotifyToolConst = require("app.view.common.const.DayNotifyToolConst")
local MysteryGameWorld = require("app.view.module.mystery.view.map.MysteryGameWorld")
local MysteryMapComp = class("MysteryMapComp", require("app.fairyGUI.mystery.UI_MysteryMapComp"))

function MysteryMapComp:ctor()
	self._npcStoryId = 0
	self._bgMusic = nil
end

function MysteryMapComp:loadTiledMap()
	if self._mapWorld then
		self._mapWorld:removeSelf()

		self._mapWorld = nil
	end

	self._chapterId = var_0_0:getCurChapterId()
	self._chapterData = var_0_0:getChapterDataById(self._chapterId)
	self._chapterInfo = self._chapterData:getChapterConfig()
	self._mapId = self._chapterData:getChapterMapId()
	self._mapWorld = MysteryGameWorld.new(self, self._mapId)

	self._mapWorld:startObserver(self.m_touchMap)
	self.m_tiledHold:addNode(self._mapWorld)
	self._mapWorld:startWorld()
	self._mapWorld:refreshEntityState(self._chapterInfo)
	self:_addBgMusic()
	var_0_0:resetRoomData()
end

function MysteryMapComp:_addBgMusic()
	self._bgMusic = nil

	if self._chapterInfo then
		if self._chapterInfo.music and string.len(self._chapterInfo.music) > 0 then
			self._bgMusic = self._chapterInfo.music

			g.core.sound.SoundManager:playMusic(self._chapterInfo.music)
		end
	end
end

function MysteryMapComp:getMapWorld()
	return self._mapWorld
end

function MysteryMapComp:getMapGround()
	return self._mapWorld:getMapGround()
end

function MysteryMapComp:getStayCoord()
	return (g.core.common.Storage:load("mystery.json") or {})["stay_" .. self._chapterId]
end

function MysteryMapComp:saveStayCoord(arg_7_1)
	local var_7_0 = g.core.common.Storage:load("mystery.json") or {}

	var_7_0["stay_" .. self._chapterId] = {
		x = arg_7_1.x,
		y = arg_7_1.y
	}

	g.core.common.Storage:save("mystery.json", var_7_0)
end

function MysteryMapComp:setAutoSearchPath(arg_8_1)
	return
end

function MysteryMapComp:autoGoToTerminus(arg_9_1)
	local var_9_0 = self._mapWorld:getBindEntity(arg_9_1)

	if var_9_0 then
		self._mapWorld:autoRouteTalk(var_9_0)
	end
end

function MysteryMapComp:talkTrigger(arg_10_1)
	local var_10_0 = arg_10_1:getBindID()

	if var_10_0 == nil then
		return
	end

	local var_10_1 = var_0_0:getChapterDataById(self._chapterId):getStageInfoByBindId(var_10_0)

	if not var_10_1 then
		return
	end

	self._curStageInfo = var_10_1

	if var_10_1.type == var_0_1.MAP_ITEM_TYPE.MONSTER or var_10_1.type == var_0_1.MAP_ITEM_TYPE.ELITE_MONSTER then
		self:_triggerBattleOrStory(var_10_1.type)
	elseif var_10_1.type == var_0_1.MAP_ITEM_TYPE.NPC then
		local var_10_2, var_10_3 = self._chapterData:isHaveStoryTrigger(var_0_1.STORY_TYPE.NPC)

		if var_10_2 then
			self._npcStoryId = var_10_3

			local var_10_4 = g.core.config.mystery_story_info.get(var_10_3)

			if not var_0_0:isAwardMysteryStoryById(var_10_3) and var_0_0:isNeedStory(var_10_4.trigger_story) then
				g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_STORY_FORCE_START, false, {
					id = var_10_4.trigger_story,
					callback = handler(self, self._sendNpcStoryGetAward)
				})
				var_0_0:saveStoryStorage(var_10_4.trigger_story)
			else
				self:showDailyTaskPop()
			end
		else
			self:showDailyTaskPop()
		end
	end
end

function MysteryMapComp:showDailyTaskPop()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.mystery.view.infoPop.MysteryOtherTaskPop").new(), {
		withoutAni = true
	})
end

function MysteryMapComp:_triggerBattleOrStory(arg_12_1)
	if arg_12_1 == var_0_1.MAP_ITEM_TYPE.MONSTER then
		local var_12_0 = self._chapterData:getNextAttackGroup()

		if var_12_0 >= self._curStageInfo.group and var_12_0 > 0 then
			self:_isPlayBeginBattleStory()
		else
			local var_12_1 = self._chapterData:getPreStageInfoByGroup(self._curStageInfo.group)

			if var_12_1 then
				g.core.module.ModuleManager:tip(g.core.lang:get(423011, {
					name = var_12_1.stage_name
				}))
			end
		end
	elseif arg_12_1 == var_0_1.MAP_ITEM_TYPE.ELITE_MONSTER then
		self:_isPlayBeginBattleStory()
	end
end

function MysteryMapComp:_isPlayBeginBattleStory()
	local var_13_0, var_13_1 = self._chapterData:isHaveStoryTrigger(var_0_1.STORY_TYPE.BATTLE, self._curStageInfo.id)

	if var_13_0 then
		local var_13_2 = g.core.config.mystery_story_info.get(var_13_1)

		if not var_0_0:isAwardMysteryStoryById(var_13_1) and var_0_0:isNeedStory(var_13_2.trigger_story) then
			var_0_0:saveStoryStorage(var_13_2.trigger_story)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_STORY_FORCE_START, false, {
				id = var_13_2.trigger_story,
				callback = handler(self, self.checkMysteryBattle)
			})
		else
			self:checkMysteryBattle()
		end
	else
		self:checkMysteryBattle()
	end
end

function MysteryMapComp:checkMysteryBattle()
	if not var_0_0:isHaveChallengeTime() and self._curStageInfo.type == var_0_1.MAP_ITEM_TYPE.MONSTER then
		if g.core.model.User.dayNotifyTool:isTodayHasRecord(DayNotifyToolConst.TYPE_MYSTERY_NO_CHALLENGE_TIME_TIP) then
			self:showMysteryBattlePop()
		else
			local var_14_0 = require("app.view.base.pop.BaseConfirmPop").new

			g.core.module.ModuleManager:pushPopup((require("app.view.base.pop.BaseConfirmPop").new({
				title = g.core.lang:get(1257),
				desc = g.core.lang:get(423013),
				onConfirm = handler(self, self.showMysteryBattlePop),
				onCancel = function()
					return
				end,
				tip = {
					txt = g.core.lang:get(408110)
				},
				onCheck = handler(self, self._onMysteryTipClickNotify)
			})))
		end
	else
		self:showMysteryBattlePop()
	end

	self:resumeMusic()
end

function MysteryMapComp:resumeMusic()
	if self._bgMusic then
		g.core.sound.SoundManager:resumeMusic()
	end
end

function MysteryMapComp:_onMysteryTipClickNotify(arg_17_1)
	g.core.model.User.dayNotifyTool:saveTodayRecord(DayNotifyToolConst.TYPE_MYSTERY_NO_CHALLENGE_TIME_TIP, arg_17_1)
end

function MysteryMapComp:showMysteryBattlePop()
	local var_18_0 = var_0_0:getStageDataById(self._curStageInfo.id)

	if not var_18_0:isMonsterLockTime() then
		if var_18_0:getPassed() then
			if self._curStageInfo.type == var_0_1.MAP_ITEM_TYPE.ELITE_MONSTER then
				if var_0_0:getDailyChallengeEliteTime() == 0 then
					g.core.module.ModuleManager:tip(g.core.lang:get(423018))
				else
					g.core.network.GameNetProxy:send_C2S_Mystery_Elite_ChallengeBegin({
						monster_id = self._curStageInfo.id
					})
				end
			elseif self._curStageInfo.type == var_0_1.MAP_ITEM_TYPE.MONSTER then
				if var_0_0:isCanFastChallangeFinishChapter(self._curStageInfo.id) then
					g.core.network.GameNetProxy:send_C2S_Mystery_Monster_FastChallenge({
						monster_id = self._curStageInfo.id
					})
				else
					g.core.network.GameNetProxy:send_C2S_Mystery_Monster_ChallengeBegin({
						monster_id = self._curStageInfo.id
					})
				end
			end
		else
			g.core.module.ModuleManager:pushPopup(require("app.view.module.mystery.view.infoPop.MysteryBattleChallengePop").new({
				info = self._curStageInfo
			}), {
				touchDisappear = true
			})
		end
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(423026))
	end
end

function MysteryMapComp:_sendNpcStoryGetAward()
	if not var_0_0:isAwardMysteryStoryById(self._npcStoryId) and self._npcStoryId > 0 then
		g.core.network.GameNetProxy:send_C2S_Mystery_Story_Finish({
			story_id = self._npcStoryId
		})

		self._npcStoryId = 0
	end

	self:resumeMusic()
	self:newScheduleOnce(handler(self, self.showDailyTaskPop), 1)
end

function MysteryMapComp:showSelfOpView(arg_20_1, arg_20_2)
	self.m_opeComp:setShowState(arg_20_1)

	if not arg_20_1 then
		self.m_opeComp:resetSelfState()
	else
		self.m_opeComp:setPosition(arg_20_2.x, display.height - arg_20_2.y - 50)
	end
end

function MysteryMapComp:updateOpPosition(arg_21_1)
	if self.m_opeComp:isVisible() then
		self.m_opeComp:setPosition(arg_21_1.x, display.height - arg_21_1.y - 50)
	end
end

function MysteryMapComp:syncRoomUserStatus()
	self._mapWorld:removeOldRoomUser()
	self._mapWorld:createUserEntity()
end

return MysteryMapComp
