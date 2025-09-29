-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/view/materialdungeon/StableAreaChapterCell.lua

module("logic.extensions.dungeon.view.materialdungeon.StableAreaChapterCell", package.seeall)

local M = class("StableAreaChapterCell", SimpleCellComponent)

function M:ctor(container)
	self.super.ctor(self, container)

	self._clickHandler = Handler.New()
end

function M:buildUI()
	self._textName = self._registry:getText("stable_area_item_2079860498")
	self._textHint = self._registry:getText("stable_area_item_1140802377")
	self._imgBg = Astral.ImageDynIcon.Get(self._registry:getGo("stable_area_item_2130418365"))
	self._imgItem = Astral.ImageDynIcon.Get(self._registry:getGo("stable_area_chapter_item_-218038417"))
	self._btnClick = self._registry:getBtn("stable_area_item_531457323")
	self._btnLock = self._registry:getBtn("stable_area_item_1886708110")
	self._goLock = self._registry:getGo("stable_area_item_1886708110")
	self._textLock = self._registry:getText("stable_area_item_1611669424")
	self._doubleHint = self._registry:getGo("0&com_multiple_rewards_hint_2109480314")
end

function M:bindEvents()
	self._btnClick:AddClickListener(self._onClickSelf, self)
	self._btnLock:AddClickListener(self._onClickSelf, self)
end

function M:unbindEvents()
	self._btnClick:RemoveClickListener()
	self._btnLock:RemoveClickListener()
end

function M:onEnter()
	return
end

function M:onExit()
	return
end

function M:destroyUI()
	self._clickHandler:clear()

	self._clickHandler = nil
end

function M:_setData(chapterMo, clickFunc, clickObj)
	self._chapterMo = chapterMo

	self._clickHandler:setListener(clickFunc, clickObj)
end

function M:_refreshUI()
	self._textName.text = self._chapterMo:getName()
	self._textHint.text = self._chapterMo:getDesc()

	self._imgBg:SetImage(self:_getImgUrl(self._chapterMo:getIconRes1()))

	local isLock = not self._chapterMo:getIsChapterUnlock()

	if isLock then
		self._textLock.text = self._chapterMo:getLockStr()
	end

	goutil.setActive(self._goLock, isLock)
	self._imgItem:SetImage(self:_getImgUrl(self._chapterMo:getIconRes2()))
	self:setMultipleDrop()
end

function M:_getImgUrl(imgName)
	return string.format("ui/bigbg/resources_explore/stable_area_banner/%s.png", imgName)
end

function M:_onClickSelf()
	if not self._chapterMo:getIsChapterUnlock() then
		FloatWordMgr.instance:show(self._chapterMo:getLockStr())
	else
		self._clickHandler:call(self._chapterMo)
	end
end

function M:setMultipleDrop()
	local itemList = self._chapterMo:getDropItems()
	local dungeonType = self._chapterMo:getDungeonType()

	if MultipleDropController.instance:getDungeonOpenByType(dungeonType) then
		local tableT = MultipleDropController.instance:getLeftNumberByTypeAndReward(dungeonType, itemList)

		if tableT.times ~= "" and tableT.leftNumber ~= 0 then
			goutil.setActive(self._doubleHint.gameObject, true)
		else
			goutil.setActive(self._doubleHint.gameObject, false)
		end
	else
		goutil.setActive(self._doubleHint.gameObject, false)
	end
end

return M
