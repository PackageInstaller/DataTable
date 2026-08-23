local StoryService = class("StoryService")
local var_0_1 = g.core.const.ConstMgr.StoryConst
local var_0_2 = g.core.module.ModuleManager

function StoryService:ctor()
	self:registerListeners()
end

function StoryService:registerListeners()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_STORY_FORCE_START, self._onForcePlayStory, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_GAME_LOGIN_LOADING, self._onLoadProgress, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_DUNGEON_LAND_START, self._onCheckTrigger, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_DUNGEON_LAND_END, self._onCheckTrigger, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_DUNGEON_STAGE_START, self._onCheckTrigger, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_DUNGEON_STAGE_END, self._onCheckTrigger, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_DUNGEON_CHAPTER_START, self._onCheckTrigger, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_DUNGEON_CHAPTER_END, self._onCheckTrigger, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_STORY_DUNGEON_START, self._onCheckTrigger, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_STORY_DUNGEON_END, self._onCheckTrigger, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_BATTLE_START, self._onCheckTrigger, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_BATTLE_END, self._onCheckTrigger, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_BATTLE_ROUND_END, self._onCheckTrigger, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_BATTLE_WAVE_START, self._onCheckTrigger, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_STORY_END, self._onPlayStoryEnd, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_BATTLE_MONSTER_CHANGE_BEGIN, self._onCheckTrigger, self)
end

function StoryService:_onLoadProgress()
	g.core.model.User.storyData:loadLocalProgress()
end

function StoryService:_onForcePlayStory(arg_4_1, arg_4_2)
	local var_4_0 = arg_4_2.id % var_0_1.DIALOG_MAX
	local var_4_1 = arg_4_2.id <= var_0_1.DIALOG_MAX
	local var_4_2 = arg_4_2.id > var_0_1.DIALOG_MAX and arg_4_2.id <= var_0_1.ANIMATION_MAX
	local var_4_3 = arg_4_2.id > var_0_1.ANIMATION_MAX and arg_4_2.id <= var_0_1.ILLUSTRATION_MAX
	local var_4_4 = arg_4_2.id > var_0_1.ILLUSTRATION_MAX
	local var_4_5

	release_print("cur story id------------------->" .. tostring(arg_4_2.id))

	self._endCallBack = arg_4_2.callback
	self._curBgm = g.core.sound.SoundManager:getCurBgm()

	if var_4_1 then
		var_4_5 = g.core.model.User.storyData:getDialogData(var_4_0)
	elseif var_4_2 then
		var_4_5 = g.core.model.User.storyData:getAnimationData(var_4_0)
	elseif var_4_3 then
		var_4_5 = g.core.model.User.storyData:getIllustrationData(var_4_0)
	elseif var_4_4 then
		var_4_5 = g.core.model.User.storyData:getMovieData(var_4_0)
	end

	if var_4_5 and next(var_4_5) then
		if not arg_4_2.nostart then
			g.core.model.User.storyData:setTriggerType(arg_4_1)
			g.core.model.User.storyData:setTriggerData(arg_4_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_STORY_START, false, {
				id = arg_4_2.id
			})
		end

		if var_4_1 then
			self:playDialog(var_4_0, arg_4_2)
		elseif var_4_2 then
			self:playAnimation(var_4_0, arg_4_2)
		elseif var_4_3 then
			self:playIllustration(var_4_0, arg_4_2)
		elseif var_4_4 then
			self:playMovie(var_4_0, arg_4_2)
		end
	else
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_STORY_END, false, {
			id = arg_4_2.id
		})
	end
end

function StoryService:_onCheckTrigger(arg_5_1, arg_5_2)
	if g.core.model.User.storyData:isInStory() then
		return
	end

	self._curBgm = g.core.sound.SoundManager:getCurBgm()

	local var_5_0 = g.core.model.User.storyData:checkTriggerDialog(arg_5_1, arg_5_2.story)

	if var_5_0 then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_STORY_START, false, {
			id = var_5_0
		})
		self:playDialog(var_5_0)

		return
	end

	local var_5_1 = g.core.model.User.storyData:checkTriggerAnimation(arg_5_1, arg_5_2.story)

	if var_5_1 then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_STORY_START, false, {
			id = var_5_1 + var_0_1.DIALOG_MAX
		})
		self:playAnimation(var_5_1)

		return
	end

	local var_5_2 = g.core.model.User.storyData:checkTriggerIllustration(arg_5_1, arg_5_2.story)

	if var_5_2 then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_STORY_START, false, {
			id = var_5_2 + var_0_1.ANIMATION_MAX
		})
		self:playIllustration(var_5_2)

		return
	end

	local var_5_3 = g.core.model.User.storyData:checkTriggerMovie(arg_5_1, arg_5_2.story)

	if var_5_3 then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_STORY_START, false, {
			id = var_5_3 + var_0_1.ILLUSTRATION_MAX
		})
		self:playMovie(var_5_3)

		return
	end
end

function StoryService:playFirstDarkCurtain(arg_6_1, arg_6_2)
	g.core.model.User.storyData:startPlayStorySound()
	arg_6_2()
end

function StoryService:playDialog(arg_7_1)
	self._storyId = arg_7_1

	local var_7_0 = g.core.model.User.storyData:getDialogData(arg_7_1)

	if var_7_0 and next(var_7_0) then
		if g.core.model.User.storyData:checkTriggerTypeBattle() then
			g.core.battle.BattleProxy:pause()
		end

		self:playFirstDarkCurtain(var_7_0, function()
			var_0_2:pushModule(g.view.entrance.STORY_DIALOG, {
				id = arg_7_1
			})
		end)
		g.core.model.User.storyData:startPlay()

		return true
	else
		self:_onPlayStoryEnd()

		return false
	end
end

function StoryService:playAnimation(arg_9_1)
	self._storyId = arg_9_1 + var_0_1.DIALOG_MAX

	local var_9_0 = g.core.model.User.storyData:getAnimationData(arg_9_1)

	if var_9_0 and next(var_9_0) then
		if g.core.model.User.storyData:checkTriggerTypeBattle() then
			g.core.battle.BattleProxy:pause()
		end

		self:playFirstDarkCurtain(var_9_0, function()
			var_0_2:pushModule(g.view.entrance.STORY_ANIMATION, {
				id = arg_9_1
			})
		end)
		g.core.model.User.storyData:startPlay()

		return true
	else
		self:_onPlayStoryEnd()

		return false
	end
end

function StoryService:playIllustration(arg_11_1, arg_11_2)
	self._storyId = arg_11_1 + var_0_1.ANIMATION_MAX

	local var_11_0 = g.core.model.User.storyData:getIllustrationData(arg_11_1)

	if var_11_0 and next(var_11_0) then
		if g.core.model.User.storyData:checkTriggerTypeBattle() then
			g.core.battle.BattleProxy:pause()
		end

		self:playFirstDarkCurtain(var_11_0, function()
			var_0_2:pushModule(g.view.entrance.STORY_ILLUSTRATION, {
				id = arg_11_1
			}, arg_11_2)
		end)
		g.core.model.User.storyData:startPlay()

		return true
	else
		self:_onPlayStoryEnd()

		return false
	end
end

function StoryService:playMovie(arg_13_1, arg_13_2)
	self._storyId = arg_13_1 + var_0_1.ILLUSTRATION_MAX

	local var_13_0 = g.core.model.User.storyData:getMovieData(arg_13_1)

	if var_13_0 and next(var_13_0) then
		if g.core.model.User.storyData:checkTriggerTypeBattle() then
			g.core.battle.BattleProxy:pause()
		end

		self:playFirstDarkCurtain(var_13_0, function()
			var_0_2:pushModule(g.view.entrance.STORY_MOVIE, {
				id = arg_13_1
			}, arg_13_2)
		end)
		g.core.model.User.storyData:startPlay()

		return true
	else
		self:_onPlayStoryEnd()

		return false
	end
end

function StoryService:_onPlayStoryEnd(arg_15_1, arg_15_2)
	if g.core.model.User.storyData:checkTriggerTypeBattle() then
		g.core.battle.BattleProxy:resume()
	end

	arg_15_2 = arg_15_2 and arg_15_2 or {}

	if not arg_15_2.id or not self._storyId or arg_15_2.id == self._storyId then
		g.core.sound.SoundManager:playMusic(self._curBgm)

		self._storyId = nil
	end

	g.core.model.User.storyData:endPlay()

	if self._endCallBack then
		self._endCallBack()
	end

	self._endCallBack = nil
end

return StoryService
