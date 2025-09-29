-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/unit/comp/BattleUnitCompUIProxy.lua

module("logic.battle.unit.comp.BattleUnitCompUIProxy", package.seeall)

local BattleUnitCompUIProxy = class("BattleUnitCompUIProxy", BattleUnitCompBase)

BattleUnitCompUIProxy.SignEnum = {
	LOCKED = 1,
	KILL = 3,
	PROTECT = 4,
	ASSISTANT = 2
}

local kDefaultKey = "BattleUnitCompUIProxy"

function BattleUnitCompUIProxy:onInit()
	self._uiFollow = self._unit.uiFollow
	self._uiBloodFollow = self._unit.uiBloodFollow
	self._uiPropertyTop = false
	self._uiPropertyCenter = false
	self._uiPropertyBottom = false
	self._invisibleSignAmount = SignalAmount.New()

	self:onReuse()
end

function BattleUnitCompUIProxy:onReuse()
	self._invisibleSignAmount:clear()

	self._uiPropertyTop = UIBattleUnitProperty:createInstance()
	self._uiPropertyBottom = UIBattleUnitPropertyInBottom:createInstance()
	self._uiPropertyCenter = UIBattleUnitPropertyInCenter:createInstance()

	self._uiFollow:addFollowGameObject(UIFollowType.Top, self._uiPropertyTop.rootGO)
	self._uiFollow:addFollowGameObject(UIFollowType.Center, self._uiPropertyCenter.rootGO)
	self._uiBloodFollow:addFollowGameObject(UIFollowType.Top, self._uiPropertyBottom.rootGO)
	self:setEvent(true)
end

function BattleUnitCompUIProxy:onReset()
	self._uiFollow:removeFollowGameObject(UIFollowType.Top, self._uiPropertyTop.rootGO)
	self._uiFollow:removeFollowGameObject(UIFollowType.Center, self._uiPropertyCenter.rootGO)
	self._uiBloodFollow:removeFollowGameObject(UIFollowType.Top, self._uiPropertyBottom.rootGO)
	self:setEvent(false)
	self._uiPropertyTop:returnSelf()

	self._uiPropertyTop = false

	self._uiPropertyCenter:returnSelf()

	self._uiPropertyCenter = false

	self._uiPropertyBottom:returnSelf()

	self._uiPropertyBottom = false

	self._invisibleSignAmount:clear()

	if self._isShowInBossView then
		BattleBossPropertyFacade.instance:setUnit(false)

		self._isShowInBossView = false
	end
end

function BattleUnitCompUIProxy:onDestroy()
	if self._uiPropertyTop then
		self._uiFollow:removeFollowGameObject(UIFollowType.Top, self._uiPropertyTop.rootGO)
		self._uiPropertyTop:returnSelf()
	end

	if self._uiPropertyCenter then
		self._uiFollow:removeFollowGameObject(UIFollowType.Center, self._uiPropertyCenter.rootGO)
		self._uiPropertyCenter:returnSelf()
	end

	if self._uiPropertyBottom then
		self._uiBloodFollow:removeFollowGameObject(UIFollowType.Bottom, self._uiPropertyBottom.rootGO)
		self._uiPropertyBottom:returnSelf()
	end

	self:setEvent(false)

	self._uiFollow = nil
	self._uiBloodFollow = nil
	self._uiPropertyTop = nil
	self._uiPropertyCenter = nil
	self._uiPropertyBottom = nil
end

function BattleUnitCompUIProxy:setEvent(isAdd)
	if isAdd then
		self._unit:addInnerEventListener(UnitActionType.BattleAttributeUpdate, self._onAttributeUpdate, self)
		self._unit:addInnerEventListener(UnitActionType.BattleBuffUpdate, self._onBuffUpdate, self)
		self._unit:addInnerEventListener(UnitActionType.MeshModelLoaded, self._onMeshModelLoaded, self)
	else
		self._unit:removeInnerEventListener(UnitActionType.BattleAttributeUpdate, self._onAttributeUpdate, self)
		self._unit:removeInnerEventListener(UnitActionType.BattleBuffUpdate, self._onBuffUpdate, self)
		self._unit:removeInnerEventListener(UnitActionType.MeshModelLoaded, self._onMeshModelLoaded, self)
	end
end

function BattleUnitCompUIProxy:onUpdateTimeScale(timeScale)
	if self._uiPropertyTop then
		self._uiPropertyTop:setPlaySpeed(timeScale)
	end

	if self._uiPropertyCenter then
		self._uiPropertyCenter:setPlaySpeed(timeScale)
	end

	if self._uiPropertyBottom then
		self._uiPropertyBottom:setPlaySpeed(timeScale)
	end
end

function BattleUnitCompUIProxy:rebuildUI()
	local property = self._unit.property
	local campId = property:getCampId()

	self._uiPropertyCenter:setUrl(BattleResourceName.UIUnitPropertyCenter)
	self._uiPropertyTop:setUrl(BattleUISettingUtil.getPropertyUIUrl(campId, self._unit.transform:isComposite()))
	self._uiPropertyBottom:setUrl(BattleUISettingUtil.getPropertyBottomUIUrl(campId, self._unit.transform:isComposite()))
	self:_updateBaseInfo(self._unit)
	self:_updateBuffInfo(self._unit)

	if not self._isShowInBossView then
		self._uiPropertyBottom:updateBossStatus()
	end
end

function BattleUnitCompUIProxy:_updateBaseInfo(unit)
	if self._isShowInBossView then
		BattleBossPropertyFacade.instance:updateBaseInfo(unit)
	else
		self._uiPropertyTop:updateBaseInfo(unit)
		self._uiPropertyBottom:updateBaseInfo(unit)
	end
end

function BattleUnitCompUIProxy:_updateBuffInfo(unit)
	if self._isShowInBossView then
		BattleBossPropertyFacade.instance:updateBuffInfo(unit)
	else
		self._uiPropertyTop:updateBuffInfo(unit)
	end
end

function BattleUnitCompUIProxy:forceSync()
	self:_updateBaseInfo(self._unit)
end

function BattleUnitCompUIProxy:forecast(forecastEntityInfo)
	if self._isShowInBossView then
		BattleBossPropertyFacade.instance:forecast(forecastEntityInfo)
	else
		self._uiPropertyTop:forecast(forecastEntityInfo)
		self._uiPropertyBottom:forecast(forecastEntityInfo)
	end

	self._uiPropertyCenter:forecast(forecastEntityInfo)
end

function BattleUnitCompUIProxy:clearForecast()
	if self._isShowInBossView then
		BattleBossPropertyFacade.instance:clearForecast()
	else
		if self._uiPropertyTop then
			self._uiPropertyTop:clearForecast()
		end

		if self._uiPropertyBottom then
			self._uiPropertyBottom:clearForecast()
		end
	end

	if self._uiPropertyCenter then
		self._uiPropertyCenter:clearForecast()
	end
end

function BattleUnitCompUIProxy:playSanityBreakAnim()
	if self._uiPropertyCenter then
		self._uiPropertyCenter:playSanityBreakAnim()
	end
end

function BattleUnitCompUIProxy:updateOnSanityChange()
	if self._isShowInBossView then
		BattleBossPropertyFacade.instance:updateBaseInfo(self._unit, true)
	elseif self._uiPropertyBottom then
		self._uiPropertyBottom:updateBaseInfo(self._unit, true)
	end
end

function BattleUnitCompUIProxy:doSanityPreview(sanityValue)
	if not self._isShowInBossView then
		self._uiPropertyBottom:doSanityPreview(sanityValue)
	end
end

function BattleUnitCompUIProxy:stopSanityPreview()
	if not self._isShowInBossView and self._uiPropertyBottom then
		self._uiPropertyBottom:stopSanityPreview()
	end
end

function BattleUnitCompUIProxy:setRestrainRelation(restrainRelation)
	self._uiPropertyCenter:setRestrainRelation(restrainRelation)
end

function BattleUnitCompUIProxy:clearRestrainRelation()
	self._uiPropertyCenter:setRestrainRelation(BattleEnum.Restrain.NONE)
end

function BattleUnitCompUIProxy:setSnipingStatus(status)
	self._uiPropertyCenter:setSnipingStatus(status)
end

function BattleUnitCompUIProxy:_onAttributeUpdate()
	if self._isShowInBossView then
		BattleBossPropertyFacade.instance:updateBaseInfo(self._unit, true)
	else
		if self._uiPropertyTop then
			self._uiPropertyTop:updateBaseInfo(self._unit, true)
		end

		if self._uiPropertyBottom then
			self._uiPropertyBottom:updateBaseInfo(self._unit, true)
		end
	end
end

function BattleUnitCompUIProxy:_onBuffUpdate()
	self:_updateBuffInfo(self._unit)
end

function BattleUnitCompUIProxy:playBuffRemoveAnim(buffCodes)
	self._uiPropertyTop:playBuffRemoveAnim(buffCodes)
end

function BattleUnitCompUIProxy:_onMeshModelLoaded()
	self:_updateVisible(false)
end

function BattleUnitCompUIProxy:_updateVisible(isDeath)
	local visible = self._invisibleSignAmount:isUnactive()

	goutil.setActive(self._uiPropertyTop.rootGO, visible)
	goutil.setActive(self._uiPropertyCenter.rootGO, visible)
	goutil.setActive(self._uiPropertyBottom.rootGO, visible)

	if visible then
		self._uiFollow:forceFollow()
	end

	if self._isShowInBossView and not isDeath then
		BattleBossPropertyFacade.instance:setVisible(visible, kDefaultKey)
	end
end

function BattleUnitCompUIProxy:setVisible(visible, isDeath, key)
	self._invisibleSignAmount:setKeyEnable(key, not visible)
	self:_updateVisible(isDeath)
end

function BattleUnitCompUIProxy:setCenterVisible(visible)
	goutil.setActive(self._uiPropertyCenter.rootGO, visible)
end

function BattleUnitCompUIProxy:setIsInBossView(isInBoss)
	if isInBoss then
		self._uiPropertyTop:setBossUIStatus(true)
		self._uiPropertyBottom:setBossUIStatus(true)
	end

	self._isShowInBossView = isInBoss
end

function BattleUnitCompUIProxy:doFade(isFade, duration)
	self._uiPropertyTop:doFade(isFade, duration)
	self._uiPropertyBottom:doFade(isFade, duration)

	if self._isShowInBossView then
		BattleBossPropertyFacade.instance:setVisible(not isFade, kDefaultKey)
	end
end

function BattleUnitCompUIProxy:setMask(isMask)
	self._uiPropertyTop:setMask(isMask)
	self._uiPropertyBottom:setMask(isMask)
end

function BattleUnitCompUIProxy:setDiableActionArrowStatus(isEnable)
	self._uiPropertyCenter:setDiableActionArrowStatus(isEnable)
end

function BattleUnitCompUIProxy:setCareerVisible(inVisible, key)
	self._uiPropertyBottom:setCareerVisible(inVisible, key)
end

function BattleUnitCompUIProxy:setSelected(isSelected)
	self._uiPropertyTop:setSelected(isSelected)
end

function BattleUnitCompUIProxy:setSignEnable(signEnum, enable)
	self._uiPropertyTop:setSignEnable(signEnum, enable)
end

function BattleUnitCompUIProxy:destroySignUI()
	self._uiPropertyTop:hideAllSign()
end

return BattleUnitCompUIProxy
