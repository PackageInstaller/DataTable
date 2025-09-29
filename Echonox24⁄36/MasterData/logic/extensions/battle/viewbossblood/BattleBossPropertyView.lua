-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/viewbossblood/BattleBossPropertyView.lua

module("logic.extensions.battle.viewbossblood.BattleBossPropertyView", package.seeall)

local BattleBossPropertyView = class("BattleBossPropertyView", ViewComponent)

function BattleBossPropertyView:buildUI()
	local weak_fill1 = goutil.findChild(self.mainGO, "content/weak_fill")
	local weak_fill2 = goutil.findChild(self.mainGO, "content/weak_fill2")

	self._weakPoint = UIBattleWeakPoint.New(weak_fill1, weak_fill2)

	self._weakPoint:setVisible(false)

	self._bloodHintView = BattleBossBloodHintView.New(goutil.findChild(self.mainGO, "content/bloodHint"))
	self._bossNameTxt = goutil.findChildTextComponent(self.mainGO, "content/txtName")
	self._career = UIBattleCareer.New(goutil.findChild(self.mainGO, "content/career"))
	self._goBuffRoot = goutil.findChild(self.mainGO, "content/buffList")
	self._sanity = UIBattleSanity.New(goutil.findChild(self.mainGO, "content/sanity_copy"))
	self._goTipsHolder = goutil.findChild(self.mainGO, "content/tipsholder")
	self._enableState = GameObjectEnableState.New(self.mainGO)
	self._clickBtn = self:getBtnByPath("content/click")

	self:setVisible(false)

	self._mainAnim = self.mainGO:GetComponent(typeof(Astral.GUITimelineAniLua))
end

function BattleBossPropertyView:bindEvents()
	self._clickBtn:AddClickListener(self._onClickBoss, self)
	self._mainAnim:AddListener(self._onMainAnimDone, self)
end

function BattleBossPropertyView:unbindEvents()
	self._clickBtn:RemoveClickListener()
	self._mainAnim:RemoveListener()
end

function BattleBossPropertyView:destroyUI()
	self._weakPoint:destroy()
	self._bloodHintView:destroy()
	self._sanity:destroy()

	self._sanity = nil
end

function BattleBossPropertyView:setVisible(visible, key)
	local isVisible = self._enableState:isEnable()

	self._enableState:setEnable(key, visible)

	if self._enableState:isEnable() and isVisible ~= self._enableState:isEnable() then
		self:_playAnim("open1")
	end

	if self._enableState then
		self._bloodHintView:clearPerformance()
	end
end

function BattleBossPropertyView:_onClickBoss()
	local buffs = self._unit.buff:getAllBuff()

	if #buffs > 0 then
		local forceAlign = UnityEngine.TextAnchor.LowerLeft
		local forceTipsAlignVer = CommEnum.TipsAlignType.Down

		ToolTipsMgr.showBattleBuffTips(self._unit, self._goTipsHolder, forceAlign, forceTipsAlignVer)
	end
end

function BattleBossPropertyView:onEnter()
	self:setVisible(false)
	BattleBossPropertyFacade.instance:registerView(self)

	self._buffIconList = {}

	local battleModel = BattleMgr.instance:getModel()
	local unit = battleModel:getBossViewUnit()

	if unit then
		self:setVisible(true)
		self:setUnit(unit)
	end

	BattleDispatcher:addEventListener(BattleEventType.ON_UPDATE_VS_VIEW_INFO, self._onUpdateVsViewInfo, self)
end

function BattleBossPropertyView:onExit()
	BattleTableUtil.clearReusableTable(self._buffIconList)
	BattleBossPropertyFacade.instance:unregisterView(self)
	BattleDispatcher:removeEventListener(BattleEventType.ON_UPDATE_VS_VIEW_INFO, self._onUpdateVsViewInfo, self)
end

function BattleBossPropertyView:_onUpdateVsViewInfo()
	self:updatePerformance()
end

function BattleBossPropertyView:onEnterFinished()
	self.mainGO.transform:SetSiblingIndex(0)
end

function BattleBossPropertyView:setUnit(unit)
	self._unit = unit

	self:updateBaseInfo()
	self:updateBuffInfo()
end

function BattleBossPropertyView:clearUnit()
	if self._enableState:isEnable() then
		self:_playAnim("close1")
	else
		BattleBossPropertyFacade.instance:tryShowNextBoss()
	end
end

function BattleBossPropertyView:_playAnim(name)
	self._mainAnim:StopTimelineAni()
	self._mainAnim:PlayAniByName(name)
end

function BattleBossPropertyView:_onMainAnimDone(name)
	if name == "close1" then
		self:setVisible(false)
		BattleBossPropertyFacade.instance:tryShowNextBoss()
	end
end

function BattleBossPropertyView:updateBaseInfo(unit)
	self._unit = unit and unit or self._unit

	if not self._unit then
		return
	end

	local property = self._unit.property

	self._bossNameTxt.text = property:getName()

	local heroMO = HeroDepotModel.instance:getHeroInfoByID(self._selectedHeroId)

	self._career:setCareerAndColorType(property:getCareer(), property:getColorType())
	self._weakPoint:updateBaseInfo(self._unit)
	self._bloodHintView:updateBaseInfo(self._unit)

	if property:hasAttribute(BattleExtension_pb.Attribute.CURRENT_SAN) then
		self._sanity:setVisible(true)

		local isInStrengthen = BattleUnitUtil.isUnitStrengthening(unit)

		self._sanity:setSanity(property:getSanity(), isInStrengthen, true)
	else
		self._sanity:setVisible(false)
	end
end

function BattleBossPropertyView:updatePerformance()
	if not self._unit then
		return
	end

	self._bloodHintView:updatePerformance(self._unit)

	local property = self._unit.property

	self._weakPoint:updatePerformance(self._unit)

	if property:hasAttribute(BattleExtension_pb.Attribute.CURRENT_SAN) then
		self._sanity:setVisible(true)

		local isInStrengthen = BattleUnitUtil.isUnitStrengthening(self._unit)

		self._sanity:setSanity(property:getSanity(), isInStrengthen, true)
	else
		self._sanity:setVisible(false)
	end
end

function BattleBossPropertyView:forecast(forecastEntityInfo)
	self._bloodHintView:forecast(forecastEntityInfo)

	local weakPointHp = forecastEntityInfo:getAttribute(BattleEnum.Attribute.CURRENT_WEAKPOINT_HP)

	self._weakPoint:forecast(nil, weakPointHp)

	local sanity = forecastEntityInfo:getAttribute(BattleExtension_pb.Attribute.CURRENT_SAN)

	if sanity then
		self:_doSanityPreview(sanity)
	end
end

function BattleBossPropertyView:_doSanityPreview(sanityValue)
	local isInStrengthen = BattleUnitUtil.isUnitStrengthening(self._unit)

	self._sanity:doPreview(self._unit.property:getSanity(), isInStrengthen, sanityValue)
end

function BattleBossPropertyView:stopSanityPreview()
	self._sanity:stopPreview()
end

function BattleBossPropertyView:clearForecast()
	self._bloodHintView:clearForecast()
	self._weakPoint:clearForecast()

	if self._sanity then
		self:stopSanityPreview()
	end
end

function BattleBossPropertyView:updateBuffInfo(unit)
	self._unit = unit and unit or self._unit

	local buffComp = self._unit.buff

	BattleTableUtil.clearReusableTable(self._buffIconList)

	local allBuffList = buffComp:getAllBuff()
	local isOver = #allBuffList > 6
	local count = Mathf.Min(#allBuffList, 6)

	if isOver then
		local buffIcon = BattleBuffIcon:createInstance()

		table.insert(self._buffIconList, buffIcon)
		goutil.addChildToParent(buffIcon.mainGO, self._goBuffRoot)
		buffIcon:setMoreSign(true)
	end

	for i = count, 1, -1 do
		local buffMO = allBuffList[i]
		local buffIcon = BattleBuffIcon:createInstance()

		buffIcon:setBuffMO(buffMO)
		table.insert(self._buffIconList, buffIcon)
		goutil.addChildToParent(buffIcon.mainGO, self._goBuffRoot)
	end
end

return BattleBossPropertyView
