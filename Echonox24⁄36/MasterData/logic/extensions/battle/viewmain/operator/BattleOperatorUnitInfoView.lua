-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/viewmain/operator/BattleOperatorUnitInfoView.lua

module("logic.extensions.battle.viewmain.operator.BattleOperatorUnitInfoView", package.seeall)

local M = class("BattleOperatorUnitInfoView", ViewComponent)
local kCloseAnimDuaration = 0.5
local kDefaultKey = "UnitInfo"

function M:buildUI()
	local tipsHolder = goutil.findChild(self.mainGO, "detailInfobuffTipsHolder")

	self.mainGO = goutil.findChild(self.mainGO, "unitInfoRoot")
	self._goType1 = goutil.findChild(self.mainGO, "type1")
	self._goType2 = goutil.findChild(self.mainGO, "type2")
	self._heroDetailComp = BattleHeroInfoDetailComp.New(self._goType2)

	self._heroDetailComp:setTipsHolder(tipsHolder)

	self._heroSimpleComp = BattleHeroInfoSimpleComp.New(self._goType1)

	self._heroDetailComp:setClickHandler(self._onClickExpandChange, self)
	self._heroSimpleComp:setClickHandler(self._onClickExpandChange, self)
	self._heroSimpleComp:setVisible(false)
	self._heroDetailComp:setVisible(false)

	self._enableState = GameObjectVisibleState.New()
	self._isExpanded = false
	self._animControl1 = BattleAnimationSwitchController.New(self._goType1)
	self._animControl2 = BattleAnimationSwitchController.New(self._goType2)

	self._animControl2:setVisibleUpdateHandler(self._type2VisibleUpdate, self)

	self._animControl1.id = "key1"
	self._animControl2.id = "key2"

	self._animControl1:setAnimName("battle_main_copy_unitinforoot_type1_open", "battle_main_copy_unitinforoot_type1_close")
	self._animControl2:setAnimName("battle_main_copy_unitinforoot_type2_open", "battle_main_copy_unitinforoot_type2_close")

	self._timeWaiter = TimeWaiter.New()

	if enableErrorLog and not self.mainGO.activeSelf then
		printError("预制battle_main需要将unitInfoRoot/type2节点显示出来，为了让技能的toggleGroup初始化")
		goutil.setActive(self.mainGO, true)
		goutil.setActive(self._goType2, true)
	end
end

function M:destroyUI()
	self._heroDetailComp:destroyUI()
	self._heroSimpleComp:destroyUI()
	self._animControl1:destroy()
	self._animControl2:destroy()
end

function M:bindEvents()
	return
end

function M:unbindEvents()
	return
end

function M:onEnter()
	self:_setEvent(true)
	self._heroDetailComp:onEnter()
	self._heroSimpleComp:onEnter()
end

function M:onExit()
	self._heroDetailComp:onExit()
	self._heroSimpleComp:onExit()
	self:_setEvent(false)
	self._timeWaiter:clear()
	self._enableState:clear()
	self:clearOperateUnit()
end

function M:setOperateUnit(unit)
	self._unit = unit
	self._isClickable = BattleCampRelationUtil.isSameOrFriendOfOperateCamp(self._unit)
	self._isExpanded = not self._isClickable

	if self._isClickable and self._unit.property:isStateActive(BattleEnum.State.STEPPED) then
		self._isExpanded = true
	end

	self._heroSimpleComp:setOperateUnit(unit)
	self._heroDetailComp:setOperateUnit(unit)
	self:_updateExpandState()
	BattleMainViewFacade.instance:showRole(self._unit.property:getModelCode(), self._unit, "OperatorUnitInfo")
end

function M:getOperateUnit()
	return self._unit
end

function M:_type2VisibleUpdate(visible)
	self._heroDetailComp:setVisible(visible)
end

function M:closeExpandPanel()
	if self._isExpanded then
		self._isExpanded = false

		self:_updateExpandState()
	end
end

function M:clearOperateUnit()
	BattleMainViewFacade.instance:setRoleVisible(false, "OperatorUnitInfo")
	self._heroDetailComp:clearOperateUnit()
	self._heroSimpleComp:clearOperateUnit()

	self._unit = false
end

function M:_setEvent(add)
	if add then
		-- block empty
	end
end

function M:getVisible()
	return self._enableState:isEnable()
end

function M:setVisible(visible, key, setAtOnce)
	local isPreviewVisible = self._enableState:isEnable()

	self._enableState:setEnable(key, visible)

	local isCurVisible = self._enableState:isEnable()

	if isCurVisible ~= isPreviewVisible then
		if not isCurVisible and setAtOnce then
			self._heroSimpleComp:setVisible(false)
			self._heroDetailComp:setVisible(false)
			self:_updateVisibleAfterAnim()
			BattleMainViewFacade.instance:setForUnitInfoOpen(false, "BattleOperatorUnitInfoView")
		else
			self._timeWaiter:clear()

			if isCurVisible then
				BattleExternalDataModel.instance:setPreShowSkillTips(false)
				BattleMainViewFacade.instance:setForUnitInfoOpen(true, "BattleOperatorUnitInfoView")
				goutil.setActive(self.mainGO, true)
				self._animControl1:resetForOpen()
				self._animControl2:resetForOpen()

				self._isExpanded = false

				self._animControl1:playOpenAnim()
			else
				if self._isExpanded then
					self._heroSimpleComp:setVisible(false)
					self._animControl2:playCloseAnim()
					self._heroDetailComp:closeTips()
				else
					self._heroDetailComp:setVisible(false)
					self._animControl1:playCloseAnim()
				end

				BattleMainViewFacade.instance:setForUnitInfoOpen(false, "BattleOperatorUnitInfoView")
				self._timeWaiter:start(kCloseAnimDuaration, self._updateVisibleAfterAnim, self)
			end
		end

		BattleBossPropertyFacade.instance:setVisible(true, kDefaultKey)
	end
end

function M:_updateVisibleAfterAnim()
	goutil.setActive(self.mainGO, self._enableState:isEnable())

	if not self._enableState:isEnable() then
		self._heroSimpleComp:setVisible(false)
		self._heroDetailComp:setVisible(false)
		BattleDispatcher:dispatchEvent(BattleEventType.MaterialVisibleUpdate, false, kDefaultKey)

		if ViewMgr.instance:isOpen(ViewName.ToolTipsSkillDetailViewPresentor) then
			ViewMgr.instance:close(ViewName.ToolTipsSkillDetailViewPresentor)
		end

		if ViewMgr.instance:isOpen(ViewName.ToolTipsCharacterSkillDetailViewPresentor) then
			ViewMgr.instance:close(ViewName.ToolTipsCharacterSkillDetailViewPresentor)
		end
	end
end

function M:_updateViewInfo()
	self._isClickable = BattleCampRelationUtil.isSameOrFriendOfOperateCamp(self._unit)
	self._isExpanded = not self._isClickable

	self._heroSimpleComp:updateViewInfo()
	self._heroDetailComp:updateViewInfo()
	self:_updateExpandState()
end

function M:_onClickExpandChange()
	if self._isClickable then
		BattleAudioUtil.playSEByName("ui_battle_juesexinxi")

		self._isExpanded = not self._isExpanded

		self:_updateExpandState(true)
	end
end

function M:_updateExpandState(notPlayAnim1)
	if self._enableState:isEnable() then
		goutil.setActive(self.mainGO, true)
	end

	if self._isExpanded then
		self._heroSimpleComp:setVisible(false)
		self._animControl1:clear()
		self._animControl2:playOpenAnim()
		self._heroDetailComp:activekillAnimation()
		BattleBossPropertyFacade.instance:setVisible(false, kDefaultKey)
	else
		self._heroDetailComp:setVisible(false)
		self._animControl2:clear()
		BattleBossPropertyFacade.instance:setVisible(true, kDefaultKey)
		self._animControl1:playOpenAnim()
	end

	BattleMainViewFacade.instance:cacheInfoExpand(self._isExpanded)
	BattleDispatcher:dispatchEvent(BattleEventType.MaterialVisibleUpdate, self._enableState:isEnable(), kDefaultKey)
end

function M:updateViewInfoOnStrengthenChange()
	local property = self._unit.property
	local isInStrengthen = BattleUnitUtil.isUnitStrengthening(self._unit)
	local isVisible = self._enableState:isEnable()

	self._heroSimpleComp:updateViewInfoOnStrengthenChange(property:getSanity(), isInStrengthen, not isVisible or self._isExpanded)
	self._heroDetailComp:updateViewInfoOnStrengthenChange(property:getSanity(), isInStrengthen, not isVisible or not self._isExpanded)
end

return M
