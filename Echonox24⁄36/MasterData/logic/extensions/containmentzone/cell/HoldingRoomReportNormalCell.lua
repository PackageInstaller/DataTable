-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/containmentzone/cell/HoldingRoomReportNormalCell.lua

module("logic.extensions.containmentzone.cell.HoldingRoomReportNormalCell", package.seeall)

local M = class("HoldingRoomReportNormalCell", UIReusableLuaBehavior)

function M:buildUI()
	self._guiAnimation = goutil.addComponentOnce(self.mainGO, typeof(Astral.GUITimelineAniLua))
	self._goNoneHeroItem = goutil.findChild(self.mainGO, "cell/none").gameObject
	self._goHeroItem = goutil.findChild(self.mainGO, "cell/hero_item").gameObject
	self._txtDate = goutil.findChildTextComponent(self.mainGO, "txtDate")
	self._txtName = goutil.findChildTextComponent(self.mainGO, "txtName")
	self._goTouchWayGroup = goutil.findChild(self.mainGO, "prototype").gameObject
	self._goTouchWayItem = goutil.findChild(self.mainGO, "prototype/prototype_item").gameObject
	self._txtDesc = goutil.findChildTextComponent(self.mainGO, "descScroll/view/txtDesc")
	self._imgResult = goutil.findChildImageComponent(self.mainGO, "imgHoldingResult")
	self._imgPoint = goutil.findChildImageComponent(self.mainGO, "num/imgIcon")
	self._txtPoint = goutil.findChildTextComponent(self.mainGO, "num/txtValue")
	self._goPresureGroup = goutil.findChild(self.mainGO, "pressure").gameObject
	self._goPresureItem = goutil.findChild(self.mainGO, "pressure/pressure_item").gameObject
end

function M:destroyUI()
	self._guiAnimation = nil
	self._goNoneHeroItem = nil
	self._goHeroItem = nil

	if self._heroItem then
		self._heroItem:destroyUI()
	end

	self._heroItem = nil
	self._txtDate = nil
	self._txtName = nil
	self._goTouchWayGroup = nil
	self._goTouchWayItem = nil
	self._txtDesc = nil
	self._imgResult = nil
	self._imgPoint = nil
	self._txtPoint = nil
	self._goPresureGroup = nil
	self._goPresureItem = nil
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
	self._guiAnimation:StopTimelineAni()

	if self._heroItem then
		self._heroItem:onExit()
	end
end

function M:onClickHeroItem()
	return
end

function M:setCellData(itemData, curIndex)
	self._txtDate.text = string.format("DATE_%s", itemData.data:getReportId())

	local protomerMo = ProtomerModel.instance:getProtomerInfo(itemData.data:getProtomerId())
	local heroId = itemData.data:getHeroId()
	local touchWay = itemData.data:getTouchWay()

	if heroId > 0 then
		self._txtName.text = ContainmentUtil.getHeroName(heroId)

		local heroMO = HeroDepotModel.instance:getHeroInfoByID(heroId)

		self._heroItem = Astral.LuaComponentContainer.Add(self._goHeroItem, HeroHeadItem)

		self._heroItem:setHandler(self)
		self._heroItem:showName(false)
		self._heroItem:showCareer(false)
		self._heroItem:showLevel(false)
		self._heroItem:setHeroMO(heroMO)
	else
		self._txtName.text = "NONE"
	end

	goutil.setActive(self._goHeroItem, heroId > 0)
	goutil.setActive(self._goNoneHeroItem, heroId <= 0)
	self:_updateTouchWay(itemData.data:getProtomerId(), touchWay)

	self._txtDesc.text = string.format("%s:\n%s", lang("tip_protomer_report"), ContainmentConfig.instance:getReportDescById(itemData.data:getDescId()))

	local resultImgCode = itemData.data:getScore()

	IconLoader.setSprite(self._imgResult, IconType.DynSpriteAtlas_Language, string.format("room_holding_result_%d", resultImgCode))

	self._txtPoint.text = string.format("%d", itemData.data:getPoint())

	self:setPresureShow(itemData.data:getPresure(), protomerMo:getPressureLimitEnhance())
end

function M:setShow(show)
	goutil.setActive(self.mainGO, show)
end

function M:playFirstOpenAni()
	self._guiAnimation:StopTimelineAni()
	self._guiAnimation:PlayOpenAni()
end

function M:setPresureShow(val, maxVal)
	local rootTrans = self._goPresureGroup.transform

	while maxVal > rootTrans.childCount do
		goutil.cloneAndSetParent(self._goPresureItem, rootTrans)
	end

	for i = 0, rootTrans.childCount - 1 do
		local show = i < maxVal
		local active = i < val
		local tempGo = rootTrans:GetChild(i).gameObject

		if show then
			local activeGo = tempGo.transform:GetChild(0).gameObject

			goutil.setActive(activeGo, active)
		end

		goutil.setActive(tempGo, show)
	end
end

function M:_updateTouchWay(protomerId, touchWay)
	local name = ContainmentUtil.getTouchDefineName(touchWay, protomerId)
	local touchName = goutil.findChildTextComponent(self._goTouchWayItem, "text")

	touchName.text = name
end

return M
