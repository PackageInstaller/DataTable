-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/course/widgets/CourseCupItem.lua

module("logic.extensions.playerinfo.view.course.widgets.CourseCupItem", package.seeall)

local M = class("CourseCupItem", CourseEditItem)

function M:ctor(compContainer)
	self._mainGO = compContainer.gameObject
	self._registry = ViewElementsRegistry.New(self._mainGO)
end

function M:Awake()
	self:buildUI()
	self:bindEvents()
end

function M:OnDestroy()
	self:unbindEvents()

	self._clickCupHandler = nil
	self._clickEditHandler = nil
end

function M:buildUI()
	local registry = self._registry

	self._emptyGo = registry:findUIElement("player_course_card_item_-275654727")
	self._editGo = registry:findUIElement("player_course_card_item_1730788007")
	self._signGo = registry:findUIElement("player_course_card_item_540871799")
	self._cupGo = goutil.findChild(self._mainGO, "syndrome_card_item")
	self._editBtn = Astral.ButtonAdapter.Get(self._editGo)
	self._hintGo = goutil.findChild(self._cupGo, "hint")
	self._lockGo = goutil.findChild(self._cupGo, "lock")
	self._imgMonument = goutil.findChildImageComponent(self._cupGo, "imgSyndromeCard")
	self._txtName = goutil.findChildTextComponent(self._cupGo, "txtName")
	self._txtHint = goutil.findChildTextComponent(self._cupGo, "hint/txtHint")
	self._btnClick = Astral.ButtonAdapter.Get(goutil.findChild(self._cupGo, "click"))
	self._rateGo = goutil.findChild(self._mainGO, "rateLayer")

	local lightGo1 = goutil.findChild(self._rateGo, "layer1/light")
	local lightGo2 = goutil.findChild(self._rateGo, "layer2/light")
	local lightGo3 = goutil.findChild(self._rateGo, "layer3/light")
	local lightGo4 = goutil.findChild(self._rateGo, "layer4/light")

	self._rateGOs = {
		lightGo1,
		lightGo2,
		lightGo3,
		lightGo4
	}
	self._txtRate = goutil.findChildTextComponent(self._rateGo, "txtRate")

	local colorNone = goutil.findChild(self._cupGo, "garade/none")
	local colorHong = goutil.findChild(self._cupGo, "garade/hong")
	local colorHuang = goutil.findChild(self._cupGo, "garade/huang")

	self._colorBgs = {
		colorNone,
		colorHuang,
		colorHong
	}

	goutil.setActive(self._mainGO, true)
	goutil.setActive(self._signGo, false)
	goutil.setActive(self._txtName.gameObject, false)

	self._clickCupHandler = Handler.New()
	self._clickEditHandler = Handler.New()
end

function M:bindEvents()
	self._editBtn:AddClickListener(self.onClickEdit, self)
	self._btnClick:AddClickListener(self.onClickCup, self)
end

function M:unbindEvents()
	self._editBtn:RemoveClickListener()
	self._btnClick:RemoveClickListener()
	self._clickCupHandler:clear()
	self._clickEditHandler:clear()
end

function M:AddEditClickListener(callback, handler)
	self._clickEditHandler:setListener(callback, handler)
end

function M:AddClickListener(callback, handler)
	self._clickCupHandler:setListener(callback, handler)
end

function M:setCup(cupInfo)
	self:showCup(true)

	local cup = cupInfo.mo
	local currLevel = cup:getLv()
	local maxLevel = MonumentConfig.instance:maxGradeUpLevel(cup:getNo())

	self._txtName.text = cup:getName()

	self._lockGo:SetActive(false)
	goutil.setActive(self._hintGo, true)
	IconLoader.setSprite(self._imgMonument, IconType.Monument, cup:getStyle())

	local colorBgIndex = 1
	local hintStr = "<color=#9f9f9f>轻度 %d/%d</color>"

	if currLevel == maxLevel then
		hintStr = "<color=#e63f3f>重度 %d/%d</color>"
		colorBgIndex = 3
	elseif currLevel > 1 then
		hintStr = "<color=#d28d3a>中度 %d/%d</color>"
		colorBgIndex = 2
	end

	self._txtHint.text = string.format(hintStr, currLevel, maxLevel)

	for i = 1, #self._colorBgs do
		goutil.setActive(self._colorBgs[i], i == colorBgIndex)
	end

	self._txtRate.text = string.format("%.2f%%", cup:getRate() * 100)

	local layer = self:_getRateLayer(cup:getRate())

	for i = 1, #self._rateGOs do
		goutil.setActive(self._rateGOs[i], i == layer)
	end

	goutil.setActive(self._hintGo, maxLevel > 1)

	self._cupId = cup:getId()
end

function M:showCup(active)
	goutil.setActive(self._cupGo, active)
	goutil.setActive(self._rateGo, active)
	goutil.setActive(self._emptyGo, not active)
end

function M:showEdit(active)
	goutil.setActive(self._editGo, active)
end

function M:showSign(active)
	goutil.setActive(self._signGo, active)
end

function M:showEntity(entity)
	if entity then
		self:setCup(entity)
	else
		self:showCup(false)
		self:showSign(false)
	end
end

function M:_getRateLayer(rate)
	local layer = 1

	layer = rate >= 0 and rate <= 0.25 and 1 or rate > 0.25 and rate <= 0.5 and 2 or rate > 0.5 and rate <= 0.75 and 3 or 4

	return layer
end

function M:onClickCup()
	self._clickCupHandler:call(self._cupId)
end

function M:onClickEdit()
	self._clickEditHandler:call()
end

return M
