-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/uifollow/UIBattleUnitPropertyInBottom.lua

module("logic.battle.uifollow.UIBattleUnitPropertyInBottom", package.seeall)

local UIBattleUnitPropertyInBottom = class("UIBattleUnitPropertyInBottom", IBattleReusable)

function UIBattleUnitPropertyInBottom:getCapacity()
	return BattleConst.ObjPoolCapacityMid
end

function UIBattleUnitPropertyInBottom:ctor()
	local sceneGoMgr = BattleMgr.instance:getSceneGameObjectMgr()
	local parentGo = sceneGoMgr:getUnitUIRoot(UIFollowType.Bottom)

	self.rootGO = goutil.create("UIBattleUnitPropertyInBottom", true)

	goutil.addChildToParent(self.rootGO, parentGo)

	self.mainGO = false
	self._url = false
	self._isInBossView = false
	self._careerEnableState = GameObjectVisibleState.New()
end

function UIBattleUnitPropertyInBottom:reuse()
	goutil.setActive(self.rootGO, true)
end

function UIBattleUnitPropertyInBottom:reset()
	if self.mainGO then
		self:setMask(false)

		self._canvasGroup.alpha = 1
	end

	self._isInBossView = false

	goutil.setActive(self.rootGO, false)
	self._careerEnableState:clear()
end

function UIBattleUnitPropertyInBottom:destroy()
	self:_clearResource()

	self._url = false

	if self.rootGO then
		goutil.destroy(self.rootGO)

		self.rootGO = false
	end
end

function UIBattleUnitPropertyInBottom:_clearResource()
	if self.mainGO then
		self:destroyUI()
		goutil.destroy(self.mainGO)

		self.mainGO = false
	end

	self._url = false
end

function UIBattleUnitPropertyInBottom:buidUI()
	self._canvasGroup = self.mainGO:GetComponent(ComponentType.CanvasGroup)
	self._career = UIBattleCareer.New(goutil.findChild(self.mainGO, "career"))
	self._sanity = UIBattleSanity.New(goutil.findChild(self.mainGO, "sanity/sanity_copy"))
	self._goBoss = goutil.findChild(self.mainGO, "bossSign")

	self:setBossUIStatus(self._isInBossView)
end

function UIBattleUnitPropertyInBottom:setBossUIStatus(isInBoss)
	self._isInBossView = isInBoss

	self:setCareerVisible(not isInBoss, "isInBoss")

	if self.mainGO then
		self:_showCareer()
		self._sanity:setVisible(not isInBoss)
		goutil.setActive(self._goBoss, not isInBoss)
	end
end

function UIBattleUnitPropertyInBottom:setCareerVisible(inVisible, key)
	self._careerEnableState:setEnable(key, inVisible)
	self:_showCareer()
end

function UIBattleUnitPropertyInBottom:_showCareer()
	if self.mainGO then
		local visible = self._careerEnableState:isEnable()

		self._career:setVisible(visible)
	end
end

function UIBattleUnitPropertyInBottom:destroyUI()
	self._sanity:destroy()
	self._career:destroy()

	self._sanity = nil
	self._career = nil
end

function UIBattleUnitPropertyInBottom:setUrl(url)
	if self._url == url then
		return
	end

	self:_clearResource()

	local resMgr = BattleMgr.instance:getResourceMgr()
	local mainGO = resMgr:getInst(url)

	goutil.addChildToParent(mainGO, self.rootGO)

	self._url = url
	self.mainGO = mainGO

	self:buidUI()
end

function UIBattleUnitPropertyInBottom:updateBossStatus()
	goutil.setActive(self._goBoss, self._unit.property:getMonsterType() == BattleEnum.MonsterType.BOSS)
end

function UIBattleUnitPropertyInBottom:setPlaySpeed(playSpeed)
	return
end

function UIBattleUnitPropertyInBottom:updateBaseInfo(unit, sanityAnim)
	self._unit = unit

	local property = unit.property

	if property:hasAttribute(BattleExtension_pb.Attribute.CURRENT_SAN) then
		self._sanity:setVisible(true)

		local isInStrengthen = BattleUnitUtil.isUnitStrengthening(unit)

		self._sanity:setSanity(property:getSanity(), isInStrengthen, not sanityAnim)
	else
		self._sanity:setVisible(false)
	end

	self._career:setCareerAndColorType(property:getCareer(), property:getColorType())
end

function UIBattleUnitPropertyInBottom:updateBuffInfo(unit)
	return
end

function UIBattleUnitPropertyInBottom:_doSanityPreview(sanityValue)
	local isInStrengthen = BattleUnitUtil.isUnitStrengthening(self._unit)

	self._sanity:doPreview(self._unit.property:getSanity(), isInStrengthen, sanityValue)
end

function UIBattleUnitPropertyInBottom:stopSanityPreview()
	self._sanity:stopPreview()
end

function UIBattleUnitPropertyInBottom:clearForecast()
	self:stopSanityPreview()
end

function UIBattleUnitPropertyInBottom:forecast(forecastEntityInfo)
	local sanity = forecastEntityInfo:getAttribute(BattleExtension_pb.Attribute.CURRENT_SAN)

	if sanity then
		self:_doSanityPreview(sanity)
	end
end

function UIBattleUnitPropertyInBottom:doFade(isFade, duration)
	if self.mainGO then
		if isFade then
			self._canvasGroup:DOKill(false)
			self._canvasGroup:DOFade(0, duration)
		else
			self._canvasGroup:DOKill(false)
			self._canvasGroup:DOFade(1, duration)
		end
	end
end

function UIBattleUnitPropertyInBottom:_onAddEffectFinished(unit)
	goutil.setActive(unit.mainGO, false)
end

function UIBattleUnitPropertyInBottom:setMask(isMask)
	self._career:setMask(isMask)
	self._sanity:setMask(isMask)
end

return UIBattleUnitPropertyInBottom
