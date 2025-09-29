-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/house/view/common/RoomWorkerItem.lua

module("logic.extensions.house.view.common.RoomWorkerItem", package.seeall)

local M = class("RoomWorkerItem")

function M:ctor(compContainer)
	self._mainGO = compContainer.gameObject
	self._handler = Handler.New()

	self:_buildUI()
end

function M:OnDestroy()
	self:unbindEvents()
	self._handler:clear()

	self._handler = nil
end

function M:_buildUI()
	self._goClick = goutil.findChild(self._mainGO, "click")
	self._goHeadRoot = goutil.findChild(self._mainGO, "headMask")
	self._imgHeroIcon = goutil.findChildImageComponent(self._goHeadRoot, "headIcon")
	self._goMoodRoot = goutil.findChild(self._mainGO, "mood")
	self._moodCell = Astral.LuaComponentContainer.Add(self._goMoodRoot, HouseHeroMoodCell)
	self._goNoneRoot = goutil.findChild(self._mainGO, "none")
	self._goLockRoot = goutil.findChild(self._mainGO, "lock")
	self._goWarn = goutil.findChild(self._mainGO, "guang")

	self:bindEvents()
end

function M:bindEvents()
	Astral.UIClickTrigger.Get(self._goClick):AddClickListener(self._onClickItem, self)
end

function M:unbindEvents()
	Astral.UIClickTrigger.Get(self._goClick):RemoveClickListener()
end

function M:setVisible(visible)
	goutil.setActive(self._mainGO.transform.parent.gameObject, visible)
end

function M:setClickCallback(callback, handler)
	self._handler:setListener(callback, handler)
end

function M:setHero(heroId)
	goutil.setActive(self._goHeadRoot, true)
	goutil.setActive(self._goMoodRoot, true)
	goutil.setActive(self._goNoneRoot, false)
	goutil.setActive(self._goLockRoot, false)

	local characterCO = CharacterConfig.instance:getCfgInfoByID(heroId)

	IconLoader.setSprite(self._imgHeroIcon, IconType.Head, characterCO.modelId)

	local mood = 0
	local featureMO = HeroHouseFeatureModel.instance:getFeatureMO(heroId)

	if featureMO then
		mood = featureMO:getMood()
	end

	self._moodCell:updateMood(mood)
end

function M:setNone()
	goutil.setActive(self._goHeadRoot, false)
	goutil.setActive(self._goMoodRoot, false)
	goutil.setActive(self._goNoneRoot, true)
	goutil.setActive(self._goLockRoot, false)
end

function M:setLock()
	goutil.setActive(self._goHeadRoot, false)
	goutil.setActive(self._goMoodRoot, false)
	goutil.setActive(self._goNoneRoot, false)
	goutil.setActive(self._goLockRoot, true)
end

function M:_onClickItem()
	self._handler:call(self)
end

return M
