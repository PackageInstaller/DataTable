-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/unit/comp/monster/RogueUnitCompMonsterInfoBar.lua

module("logic.extensions.roguelike.unit.comp.monster.RogueUnitCompMonsterInfoBar", package.seeall)

local M = class("RogueUnitCompMonsterInfoBar", RogueUnitCompBase)
local URL_INFOBAR = ResName.Rungroup_monster_unit1
local CardInfoItem = class("CardInfoItem")

function CardInfoItem:ctor(container)
	local go = container.gameObject

	self._goSelect = goutil.findChild(go, "drag/pos/select")
end

function CardInfoItem:setSelect(isSelect)
	goutil.setActive(self._goSelect, isSelect)
end

function M:ctor(unit)
	M.super.ctor(self, unit)

	self._resLoader = SingleResLoader.New()
	self._goInst = nil
	self._followUIComp = nil
	self._viewElementsRegistry = nil
	self._isVisible = nil
end

function M:setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.ROGUE_FEATURES_ROLL_RESULT, self._onFeatureRollResult, self)
		GlobalDispatcher:addEventListener(EventType.ROGUE_SHOW_MONSTER_HP_ANI, self._onMonsterHpAni, self)
	else
		GlobalDispatcher:removeEventListener(EventType.ROGUE_FEATURES_ROLL_RESULT, self._onFeatureRollResult, self)
		GlobalDispatcher:removeEventListener(EventType.ROGUE_SHOW_MONSTER_HP_ANI, self._onMonsterHpAni, self)
	end
end

function M:_onMonsterHpRefresh(sender, id, hp)
	local monsterId = self._unit.monsterProp:getId()

	if monsterId == id then
		self:updateData(hp)
	end
end

function M:_onFeatureRollResult(sender, feature, isNew, index)
	if not self._goInst then
		self:delayShowFeatureResult()

		return
	end

	local hadAttack, params = RogueMgr.instance:getRogueFlow().judgeModel:getMonsterActionIsTakeDamage()
	local damage = hadAttack and RogueMgr.instance:getRogueFlow().judgeModel:getMonsterAttackDamage(params, true) or 0

	goutil.setActive(self._goAttack, hadAttack)

	self._txtAttackDamage.text = "x" .. damage

	local curFeatureIndex = RogueMgr.instance:getRogueFlow().judgeMgr:getFeatureIndex()

	for k, v in ipairs(self._cardItems or {}) do
		local isHighLight = false

		isHighLight = curFeatureIndex == k

		if index then
			isHighLight = k == index
		end

		v:setSelect(isHighLight)
	end
end

function M:delayShowFeatureResult()
	if self._goInst ~= nil then
		removetimer(self.delayShowFeatureResult, self)
		self:_onFeatureRollResult()

		return
	end

	settimer(0.1, self.delayShowFeatureResult, self, false)
end

function M:_onMonsterHpAni(sender, id, hp)
	local monsterId = self._unit.monsterProp:getId()

	if monsterId ~= id then
		-- block empty
	end

	self:updateData(hp)
end

function M:onInit()
	self:setEvent(true)

	self._followUIComp = self._unit.uiFollow
end

function M:onReset()
	removetimer(self._showHpChange, self)
	self:setEvent(false)

	if self._btnInfo then
		self._btnInfo:RemoveClickListener()
	end

	self._btnInfo = nil

	if self._followUIComp then
		self._followUIComp:removeAllFollowGameObject()
	end

	if self._goInst then
		goutil.destroy(self._goInst)

		self._goInst = false
	end

	if self._resLoader then
		self._resLoader:clear()
	end

	self._isVisible = false
end

function M:onDestroy()
	removetimer(self._showHpChange, self)
	removetimer(self.delayShowFeatureResult, self)
	self:setEvent(false)

	if self._btnInfo then
		self._btnInfo:RemoveClickListener()
	end

	self._btnInfo = nil

	if self._followUIComp then
		self._followUIComp:removeAllFollowGameObject()
	end

	if self._goInst then
		goutil.destroy(self._goInst)
	end

	self._goInst = nil

	if self._resLoader then
		self._resLoader:clear()
	end

	self._resLoader = nil
	self._followUIComp = nil
	self._viewElementsRegistry = nil
	self._isVisible = false
end

function M:setVisible(visible, exit)
	self._isVisible = visible

	if self._goInst then
		self:_setVisible()
	else
		if exit then
			return
		end

		if self._resLoader then
			self._resLoader:load(URL_INFOBAR, self._onResLoaded, self)
		end
	end
end

function M:_setVisible()
	goutil.setActive(self._goInst, self._isVisible)
end

function M:_onResLoaded()
	self._goInst = self._resLoader:getResInstance()

	self:_buildUI(self._goInst)

	local parentGo = SceneRoot2DMgr.instance:getRoot(SceneRoot2DType.NameBar)

	goutil.addChildToParent(self._goInst, parentGo)
	self._followUIComp:addFollowGameObject(UIFollowType.Top, self._goInst)

	local monsterProp = self._unit.monsterProp
	local yOffset = monsterProp:getHpYOffset()

	self._followUIComp:setPivot(UIFollowType.Top, 0, yOffset)
	self._followUIComp:setPerspectiveEnable(true)
	self:_setVisible()
end

function M:_buildUI(mainGO)
	self._viewElementsRegistry = ViewElementsRegistry.New()

	self._viewElementsRegistry:setMainGO(mainGO)

	self._txtHp = self._viewElementsRegistry:findUIElement("rungroup_monster_unit1_-572532714", UIComponentType.Text)
	self._imgHp = self._viewElementsRegistry:findUIElement("rungroup_monster_unit1_-1668169305", UIComponentType.Image)
	self._goAttack = self._viewElementsRegistry:findUIElement("rungroup_monster_unit1_467206600")
	self._txtAttackDamage = self._viewElementsRegistry:findUIElement("rungroup_monster_unit1_-588988994", UIComponentType.Text)
	self._imgHpMax = self._viewElementsRegistry:findUIElement("rungroup_monster_unit1_-605743937", UIComponentType.Image)
	self._hpAni = self._viewElementsRegistry:findUIElement("rungroup_monster_unit1_-605743937"):GetComponent("Animation")
	self._hpAni.enabled = false
	self._btnInfo = Astral.ButtonAdapter.Get(self._viewElementsRegistry:findUIElement("rungroup_monster_unit1_-2129800187"))

	self._btnInfo:AddClickListener(self._onClickInfo, self)

	self._cardParent = self._viewElementsRegistry:findUIElement("rungroup_monster_unit1_1023065066").transform

	self:resetHpFill()
	self:initCardInfo()
end

function M:initCardInfo()
	local featureDices = RogueMgr.instance:getRogueFlow().judgeMgr:getFeaturePatterns()

	self._cardItems = {}

	for i = 0, self._cardParent.childCount - 1 do
		local go = self._cardParent:GetChild(i).gameObject
		local item = Astral.LuaComponentContainer.Add(go, CardInfoItem)

		item:setSelect(false)
		table.insert(self._cardItems, item)
	end
end

function M:_onClickInfo()
	ViewMgr.instance:open(ViewName.RogueMonsterCard)
end

function M:resetHpFill()
	if self._goInst == nil then
		return
	end

	removetimer(self._showHpChange, self)

	local monsterProp = self._unit.monsterProp
	local hp = monsterProp:getHp()

	self._curHp = hp

	local totalHp = monsterProp:getOriginHp()

	if not hp or not totalHp then
		return
	end

	self._txtHp.text = string.format("%d/%d", hp, totalHp)

	local fillAmount = hp / totalHp

	self._imgHp.fillAmount = fillAmount
	self._fillAmount = fillAmount
	self._imgHpMax.fillAmount = fillAmount
end

function M:updateData(aniHp)
	if self._goInst == nil then
		return
	end

	removetimer(self._showHpChange, self)

	local monsterProp = self._unit.monsterProp
	local hp = monsterProp:getHp()

	if aniHp then
		self._curHp = self._curHp - aniHp

		if self._curHp < 0 then
			self._curHp = 0
		end
	else
		self._curHp = hp
	end

	local totalHp = monsterProp:getOriginHp()

	if not hp or not totalHp then
		return
	end

	self._txtHp.text = string.format("%d/%d", self._curHp, totalHp)

	local fillAmount = self._curHp / totalHp

	self._imgHp.fillAmount = fillAmount
	self._fillAmount = fillAmount

	if self._imgHpMax.fillAmount ~= fillAmount then
		if fillAmount > self._imgHpMax.fillAmount then
			self._imgHpMax.fillAmount = 1
		end

		self:showHpAnimation()
	end
end

function M:showHpAnimation()
	self._hpAni.enabled = true

	self._unit.material:showOutlineColor("#BF0000")
	settimer(0.05, self._showHpChange, self, true)

	if self._curHp <= 0 then
		GlobalDispatcher:dispatchEvent(EventType.ROGUE_SHOW_MONSTER_ANI, RoguelikeConst.ROGUE_MONSTER_ANI.DEATH)
	end
end

function M:_showHpChange()
	if self._imgHpMax.fillAmount <= self._fillAmount then
		self._hpAni.enabled = false

		removetimer(self._showHpChange, self)
		self:resetHpFill()

		return
	end

	self._imgHpMax.fillAmount = self._imgHpMax.fillAmount - 0.02
end

function M:_onChangeVisible(visible)
	self:showByData(visible)
end

function M:clear()
	if self._followUIComp then
		self._followUIComp:removeAllFollowGameObject()
	end

	if self._btnInfo then
		self._btnInfo:RemoveClickListener()
	end

	self._btnInfo = nil

	if self._goInst then
		goutil.destroy(self._goInst)
	end

	self._goInst = false

	if self._resLoader then
		self._resLoader:clear()
	end

	removetimer(self._showHpChange, self)
end

return M
