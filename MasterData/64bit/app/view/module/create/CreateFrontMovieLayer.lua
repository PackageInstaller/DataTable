local KnightVoiceCommon = require("app.view.module.knight.common.KnightVoiceCommon")
local TypeWriter = require("app.view.common.TypeWriter")
local var_0_2 = {
	{
		voice = "Vo_510040_s05",
		name = g.core.lang:get(100202),
		content = g.core.lang:get(100203)
	},
	{
		voice = "Vo_510040_s06",
		name = g.core.lang:get(100202),
		content = g.core.lang:get(100204)
	}
}
local CreateFrontMovieLayer = class("CreateFrontMovieLayer", require("app.fairyGUI.create.UI_CreateFrontMovieLayer"), function()
	return fgui.GComponent:create({
		pkgName = "create",
		isFullScreen = true,
		pkgPath = "ui/create/create",
		resName = "CreateFrontMovieLayer"
	}, ...)
end)

CreateFrontMovieLayer.STATE = {
	OPEN_EYE = 0,
	PULL = 3,
	LOOP = 2,
	LOOP_WITH_DIALOG = 1
}

function CreateFrontMovieLayer:ctor()
	self._perMovie = nil
	self._perLoadMovie = nil
	self._state = CreateFrontMovieLayer.STATE.OPEN_EYE

	local var_2_0 = {
		fullScreenState = 2,
		moduleName = "create",
		x = 0,
		y = 0
	}

	var_2_0.movieName = "CjNvZzy_1334x750_3000"
	var_2_0.listener = handler(self, self._onOpenEyeCallBack)

	self:perLoadMovie(1)

	self._perMovie = self.m_moviePlayHolder:addCriSprite(var_2_0)

	g.core.sound.SoundManager:playMusic(g.core.const.ConstMgr.SoundConst.BGM.MUSIC_ROLE_CREATE_A)
end

function CreateFrontMovieLayer:_onOpenEyeCallBack(arg_3_1)
	if arg_3_1 == "complete" then
		self:_playLoopMovie()
	end
end

function CreateFrontMovieLayer:_playLoopMovie()
	self._state = CreateFrontMovieLayer.STATE.LOOP_WITH_DIALOG
	self._perMovie = self._perLoadMovie
	self._perLoadMovie = nil

	self:playPreLoadMovie()
	self:perLoadMovie(2)

	self.m_nameTxt = self.m_talkComp:getChild("nameTxt")
	self.m_dialogTxt = self.m_talkComp:getChild("dialogTxt")
	self._dialogIndex = 1

	self.m_nameTxt:setText(var_0_2[self._dialogIndex].name)

	if var_0_2[self._dialogIndex].voice and not g.core.const.ConstMgr.BASE_CONST.MUTE_STORY_AND_GUIDE_SOUND then
		KnightVoiceCommon.playVoice({
			voiceName = var_0_2[self._dialogIndex].voice
		})
	end

	self:startTypeWriter(var_0_2[self._dialogIndex].content)
	self.m_dialogClickComp:addClickListener(handler(self, self._onDialogClick))
	self.m_stepController:setSelectedIndex(1)
end

function CreateFrontMovieLayer:_onDialogClick(arg_5_1)
	arg_5_1:stopPropagation()

	if self._inWriting then
		if self._typeWriter then
			self._typeWriter:finish()
		end
	else
		self._dialogIndex = self._dialogIndex + 1

		if not var_0_2[self._dialogIndex] then
			self.m_stepController:setSelectedIndex(0)
			self:_enterLoopState()
		else
			self.m_nameTxt:setText(var_0_2[self._dialogIndex].name)
			self:startTypeWriter(var_0_2[self._dialogIndex].content)

			if var_0_2[self._dialogIndex].voice and not g.core.const.ConstMgr.BASE_CONST.MUTE_STORY_AND_GUIDE_SOUND then
				KnightVoiceCommon.playVoice({
					voiceName = var_0_2[self._dialogIndex].voice
				})
			end
		end
	end
end

function CreateFrontMovieLayer:_enterLoopState()
	self._state = CreateFrontMovieLayer.STATE.LOOP

	self.m_effComp:addEffectSpine({
		isLoop = true,
		scale = 1.2,
		name = "eff_ui_create_qte"
	})
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.ROLE_REATE_RING)
	self.m_touchComp:addClickListener(handler(self, self._onTouchHandClick))
end

function CreateFrontMovieLayer:_onTouchHandClick()
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.ROLE_REATE_RING_CHOOSE)
	self.m_effComp:removeAllEffect()
	self.m_moviePlayHolder:removeAllCriSprite()

	self._state = CreateFrontMovieLayer.STATE.LOOP_WITH_DIALOG
	self._perMovie = self._perLoadMovie

	self:playPreLoadMovie()
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.ROLE_REATE_SCENE_CLOSE)
end

function CreateFrontMovieLayer:_onPullEndCallBack()
	g.core.module.ModuleManager:pushModule(g.view.entrance.CREATE)
end

function CreateFrontMovieLayer:perLoadMovie(arg_9_1)
	if arg_9_1 == 1 then
		self._perLoadMovie = self.m_moviePlayHolder:addCriSprite({
			fullScreenState = 2,
			moduleName = "create",
			x = 0,
			isLoop = true,
			y = 0,
			movieName = "CjNvZcjxh_1334x750_3333",
			listener = handler(self, self._onOpenEyeCallBack)
		})

		self._perLoadMovie:setVisible(false)
		self._perLoadMovie:pause(true)
	else
		local var_9_0 = {
			fullScreenState = 2,
			moduleName = "create",
			x = 0,
			isLoop = false,
			y = 0
		}

		var_9_0.movieName = "CjNvZlj_1334x750_3333"
		var_9_0.listener = handler(self, self._onPullEndCallBack)
		self._perLoadMovie = self.m_moviePlayHolder:addCriSprite(var_9_0)

		self._perLoadMovie:setVisible(false)
		self._perLoadMovie:pause(true)
	end
end

function CreateFrontMovieLayer:playPreLoadMovie()
	if self._perMovie and not tolua.isnull(self._perMovie) then
		self._perMovie:setVisible(true)
		self._perMovie:pause(false)
	end
end

function CreateFrontMovieLayer:startTypeWriter(arg_11_1)
	self._inWriting = true
	self._typeWriter = TypeWriter.new({
		speed = 25,
		label = self.m_dialogTxt,
		str = arg_11_1,
		callback = function()
			self._inWriting = false
			self._typeWriter = nil
		end
	})

	self._typeWriter:start()
end

return CreateFrontMovieLayer
