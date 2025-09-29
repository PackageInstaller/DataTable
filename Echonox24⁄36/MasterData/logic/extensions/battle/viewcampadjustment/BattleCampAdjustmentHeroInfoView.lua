-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/viewcampadjustment/BattleCampAdjustmentHeroInfoView.lua

module("logic.extensions.battle.viewcampadjustment.BattleCampAdjustmentHeroInfoView", package.seeall)

local M = class("BattleCampAdjustmentHeroInfoView", ViewComponent)
local kMaterialDefaultKey = "UnitInfo"

function M:buildUI()
	local roleInfoGo = goutil.findChild(self.mainGO, "roleInfoPanel")

	self._heroDetailComp = BattleCampAdjustHeroInfoDetailComp.New(roleInfoGo)
	self._heroPhotoPanelGo = goutil.findChild(self.mainGO, "roleInfoPanel/CharacterPanel")
	self._guiAnimation = roleInfoGo:GetComponent(typeof(Astral.GUITimelineAniLua))
end

function M:destroyUI()
	self._heroDetailComp:destroyUI()
end

function M:bindEvents()
	self._guiAnimation:AddListener(self._dealTimelineListener, self)
end

function M:unbindEvents()
	self._guiAnimation:RemoveListener()
end

function M:onEnter()
	self._isOpening = false

	BattleCampAdjustmentViewFacade.instance:registerHeroInfoView(self)
	self._heroDetailComp:onEnter()
end

function M:setHeroInfo(heroId)
	if heroId then
		self:_tryPlayAnimation(true)
		self._heroDetailComp:setSelectedHero(heroId)
		self._heroDetailComp:activekillAnimation()

		local heroMO = HeroDepotModel.instance:getHeroInfoByID(heroId)

		if not heroMO then
			local settingModel = BattleMgr.instance:getSettingModel()
			local trialList = settingModel:getTrialHeroList()

			for _, item in ipairs(trialList) do
				if item:getId() == heroId then
					heroMO = item

					break
				end
			end
		end

		local modelId = heroMO:getModelId()

		BattleMainViewFacade.instance:showRole(modelId, false, "AdjustOperatorUnitInfo")
		BattleDispatcher:dispatchEvent(BattleEventType.MaterialVisibleUpdate, true, kMaterialDefaultKey)
	else
		self:_tryPlayAnimation(false)
		BattleDispatcher:dispatchEvent(BattleEventType.MaterialVisibleUpdate, false, kMaterialDefaultKey)
	end
end

function M:setOperateUnit(unit)
	if unit then
		self:_tryPlayAnimation(true)
		self._heroDetailComp:setOperateUnit(unit)
		self._heroDetailComp:setVisible(true)
		self._heroDetailComp:activekillAnimation()
		BattleMainViewFacade.instance:showRole(unit.property:getModelCode(), unit, "AdjustOperatorUnitInfo")
		BattleDispatcher:dispatchEvent(BattleEventType.MaterialVisibleUpdate, true, kMaterialDefaultKey)
	else
		self:_tryPlayAnimation(false)
		BattleDispatcher:dispatchEvent(BattleEventType.MaterialVisibleUpdate, false, kMaterialDefaultKey)
	end
end

function M:getHeroPhotoPanelGo()
	return self._heroPhotoPanelGo
end

function M:_dealTimelineListener(tagName)
	if tagName == "RoleInfoClose" then
		self._heroDetailComp:setVisible(false)
		BattleMainViewFacade.instance:setRoleVisible(false, "AdjustOperatorUnitInfo")
	end
end

function M:onExit()
	self:_tryPlayAnimation(false)
	BattleCampAdjustmentViewFacade.instance:unregisterHeroInfoView()
	self._heroDetailComp:onExit()
end

function M:_tryPlayAnimation(isOpen)
	if self._isOpening == isOpen then
		return
	end

	self._guiAnimation:StopTimelineAni()

	self._isOpening = not self._isOpening

	if isOpen then
		self._guiAnimation:PlayAniByName("openroleInfo")
	else
		self._guiAnimation:PlayAniByName("closeroleInfo")
	end
end

return M
