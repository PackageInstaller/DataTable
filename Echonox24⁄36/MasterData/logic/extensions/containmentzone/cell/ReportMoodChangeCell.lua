-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/containmentzone/cell/ReportMoodChangeCell.lua

module("logic.extensions.containmentzone.cell.ReportMoodChangeCell", package.seeall)

local M = class("ReportMoodChangeCell", UIReusableLuaBehavior)

function M:buildUI()
	self._goHeroItem = goutil.findChild(self.mainGO, "hero_item")
	self._imgMood = goutil.findChildImageComponent(self.mainGO, "mood/Image")
	self._txtMood = goutil.findChildTextComponent(self.mainGO, "mood/txtMood")
end

function M:destroyUI()
	self._goHeroItem = nil

	if self._heroItem then
		self._heroItem:destroyUI()
	end

	self._imgMood = nil
	self._txtMood = nil
end

function M:bindEvents()
	return
end

function M:unbindEvents()
	if self._heroItem then
		self._heroItem:unbindEvents()
	end
end

function M:onEnter()
	return
end

function M:onExit()
	if self._heroItem then
		self._heroItem:onExit()
	end
end

function M:setHeroData(heroId)
	local heroMO = HeroDepotModel.instance:getHeroInfoByID(heroId)

	self._heroItem = Astral.LuaComponentContainer.Add(self._goHeroItem, HeroHeadItem)

	self._heroItem:setHandler(self)
	self._heroItem:showName(false)
	self._heroItem:showCareer(false)
	self._heroItem:showLevel(false)

	if not heroMO then
		if enableLog then
			printWarn("没有角色：", heroId)
		end

		self._heroItem:setIsNone(true)

		return
	end

	self._heroItem:setIsNone(false)
	self._heroItem:setHeroMO(heroMO)
end

function M:setMoodChange(num)
	if num >= 0 then
		self._txtMood.text = string.format("+%d", num)
	else
		self._txtMood.text = string.format("<color=#ff3e48>%d</color>", num)
	end
end

function M:onClickHeroItem()
	return
end

return M
