-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/view/StoryAfflatuseEffectView.lua

module("logic.extensions.story.view.StoryAfflatuseEffectView", package.seeall)

local M = class("StoryAfflatuseEffectView", ViewComponent)

function M:buildUI()
	self._curObj = self:getGo("story_main_view_1195403412")
	self._openGo = self:getGo("story_main_view_1186662102")
	self._holdGo = self:getGo("story_main_view_1248501445")
	self._openImag = self:getImage("story_main_view_1186662102")
	self._holdImag = self:getImage("story_main_view_1248501445")
	self._openEffect = CriWareVideoMgr.Get(self._openGo.gameObject)
	self._holdEffect = CriWareVideoMgr.Get(self._holdGo.gameObject)
	self._afflatImgGo = self:getGo("story_main_view_1625196672")
	self._photoEff = PhotoEffect.Get(self._afflatImgGo)

	self._photoEff:clear()

	self._alfflatusMaskGo = self:getGo("story_main_view_734864401")
	self._btnEnter = self:getBtn("story_main_view_1248501445")
end

function M:destroyUI()
	if self._openEffect then
		self._openEffect:DestroyMovie()
	end

	if self._holdEffect then
		self._holdEffect:DestroyMovie()
	end
end

function M:bindEvents()
	self._btnEnter:AddClickListener(self._onClickEnter, self)
end

function M:unbindEvents()
	self._btnEnter:RemoveClickListener()
end

function M:_onClickEnter()
	if self._canClickClose then
		self:_showCloseAnimation()
	end
end

function M:onEnter()
	self:setVisible(false)

	self._holdImag.color = Color.New(1, 1, 1, 0)
end

function M:onExit()
	removetimer(self._onEffectFinish, self)
	removetimer(self._setCanClick, self)
	self:_clearEffect()
end

function M:closeAfflatuseMask(isClose)
	if isClose then
		goutil.setActive(self._alfflatusMaskGo, false)
	end
end

function M:setVisible(visible)
	self._isInAfflastuseEffect = visible

	if visible then
		self._canClickClose = false

		CriwareAudioFacade.instance:playSEById(CriwareAudioEnum.ui_juqing_telepathyattack)
		goutil.setActive(self._curObj, true)

		local fullVideoPath = GameUrl.getVideoUrl("linggankaiqi_open")

		self._openImag.color = Color.New(1, 1, 1, 1)

		self._openEffect:PlayMovie(fullVideoPath, true, false, self._onPlayFinished, self)
		StoryFacde.instance:hideAll(StoryConst.DefaultStateKey)

		self._holdImag.color = Color.New(1, 1, 1, 0)

		local holdViewName = GameUrl.getVideoUrl("linggankaiqi_hold")

		self._holdEffect:PlayMovie(holdViewName, true, true)
		removetimer(self._setCanClick, self)
		settimer(0.3, self._setCanClick, self, false)
	else
		self:_finishAfflatuseEffect()
	end
end

function M:_setCanClick()
	self._canClickClose = true
end

function M:_onPlayFinished()
	self._holdImag.color = Color.New(1, 1, 1, 1)

	self._openEffect:StopMovie()
end

function M:_finishAfflatuseEffect()
	self._openEffect:Reset()
	self._holdEffect:Reset()

	self._canClickClose = false

	goutil.setActive(self._curObj, false)

	self._isInAfflastuseEffect = false

	goutil.setActive(self._afflatImgGo, false)
	removetimer(self._onEffectFinish, self)
	self:_clearEffect()
end

function M:_showCloseAnimation()
	self._canClickClose = false

	goutil.setActive(self._afflatImgGo, true)

	local path = GameUrl.get3dEffectUIUrl("ui_rt_story_linggai_open")

	self._photoEff:showEffect(path, PhotoCacheMgr.SIZE_FULL_WIDTH, PhotoCacheMgr.SIZE_FULL_HEIGHT)
	self._photoEff:setCameraPosition(0, 0, 0)
	self._holdImag:DOKill(false)
	self._holdImag:DOFade(0, 1.5)
	self._openImag:DOKill(false)
	self._openImag:DOFade(0, 1.5)
	goutil.setActive(self._alfflatusMaskGo, true)
	removetimer(self._onEffectFinish, self)
	settimer(1.5, self._onEffectFinish, self, false)
end

function M:_onEffectFinish()
	self:_finishAfflatuseEffect()
	StoryFacde.instance:tryNextShot()
end

function M:_clearEffect()
	if self._photoEff then
		self._photoEff:clear()
	end
end

function M:hasAfflastuseEffect()
	return self._isInAfflastuseEffect
end

return M
