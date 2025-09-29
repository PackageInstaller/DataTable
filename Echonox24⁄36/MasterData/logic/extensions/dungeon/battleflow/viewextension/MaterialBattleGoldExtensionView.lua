-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/battleflow/viewextension/MaterialBattleGoldExtensionView.lua

module("logic.extensions.dungeon.battleflow.viewextension.MaterialBattleGoldExtensionView", package.seeall)

local MaterialBattleGoldExtensionView = class("MaterialBattleGoldExtensionView", IBattleExtensionView)

function MaterialBattleGoldExtensionView:dependMainResource()
	return "ui/views/resources_explore/battle_resources_view.prefab"
end

function MaterialBattleGoldExtensionView:dependExtensionResources()
	return {
		GameUrl.get3dEffectUIUrl("scene_jinbiben_jishu")
	}
end

function MaterialBattleGoldExtensionView:attachToWhichRoot()
	return IBattleExtensionView.AttackRoot.TOP_LEFT
end

function MaterialBattleGoldExtensionView:buildUI()
	self._effectPrefab = self:getPrefab(GameUrl.get3dEffectUIUrl("scene_jinbiben_jishu"))
	self._incrEffectPool = LocalReusableCollection.New(MaterialBattleIncrEffect, 5)
	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "txtHint2")
	self._txtCount = goutil.findChildTextComponent(self.mainGO, "txtHint2/txtNum2")
	self._rollingCount = UIEffectUtil.getTextRollingEffect(self._txtCount.gameObject)
	self._factorA = 0
	self._factorB = 0
	self._killEnemyCount = 0
	self._totalValue = 0

	local goldSignGo = goutil.findChild(self.mainGO, "imgType1")
	local expSignGo = goutil.findChild(self.mainGO, "imgType2")

	self._animation = goutil.addComponentOnce(self.mainGO, ComponentType.Animation)

	goutil.setActive(goldSignGo, true)
	goutil.setActive(expSignGo, false)

	self._isVisible = true
end

function MaterialBattleGoldExtensionView:destroyUI()
	self._incrEffectPool:clear()

	self._incrEffectPool = nil
	self._effectPrefab = nil
	self._txtTitle = nil
	self._txtCount = nil
	self._factorA = nil
	self._factorB = nil
	self._killEnemyCount = nil
end

function MaterialBattleGoldExtensionView:onEnter()
	self._hideKeyDic = {}

	self:_setEvent(true)
	self:_initFactors()
	self._rollingCount:setValue(0)
	self:_onCollectInfoReload()

	self._txtTitle.text = lang("tip_get_lzb")
end

function MaterialBattleGoldExtensionView:onExit()
	self._hideKeyDic = {}

	self:_setEvent(false)
	self._incrEffectPool:clearAllInstance()
end

function MaterialBattleGoldExtensionView:_setEvent(add)
	if add then
		BattleDispatcher:addEventListener(BattleEventType.OnEntityDead, self._onEntityDeadEvent, self)
		BattleDispatcher:addEventListener(BattleEventType.OnCollectInfoReload, self._onCollectInfoReload, self)
		BattleDispatcher:addEventListener(BattleEventType.MaterialVisibleUpdate, self._setVisiable, self)
	else
		BattleDispatcher:removeEventListener(BattleEventType.OnEntityDead, self._onEntityDeadEvent, self)
		BattleDispatcher:removeEventListener(BattleEventType.OnCollectInfoReload, self._onCollectInfoReload, self)
		BattleDispatcher:removeEventListener(BattleEventType.MaterialVisibleUpdate, self._setVisiable, self)
	end
end

function MaterialBattleGoldExtensionView:_setVisiable(_, status, key)
	key = key and key or "default"
	self._hideKeyDic[key] = status

	local isHide = false

	for key, status in pairs(self._hideKeyDic) do
		if status then
			isHide = true

			break
		end
	end

	local preVisible = self._isVisible

	if preVisible == not isHide then
		return
	end

	self._isVisible = not isHide

	if not self._isVisible then
		AnimationUtils.ResetAnimation(self._animation, "battle_resourcea_view_open")
		self._incrEffectPool:clearAllInstance()
		self:_updateView()
	end

	goutil.setActive(self.mainGO, not isHide)
end

function MaterialBattleGoldExtensionView:_onEntityDeadEvent(evt, deadEntityId)
	local unitMgr = BattleMgr.instance:getUnitMgr()
	local unit = unitMgr:getUnit(deadEntityId)

	if BattleCampRelationUtil.isEnemyOfOperateCamp(unit) then
		self._killEnemyCount = self._killEnemyCount + 1

		self:_playIncreaseEffect(unit)
	end
end

function MaterialBattleGoldExtensionView:_playIncreaseEffect(unit)
	if not BattleMainViewFacade.instance:isVisible() then
		self:_updateView()

		return
	end

	local fx, fy, fz = BattleUnitUtil.getUnitCenterPos(unit)
	local tx, ty, tz = Astral.TransformUtil.GetPos(self.mainGO.transform, 0, 0, 0)
	local effect = self._incrEffectPool:createInstance(self._effectPrefab)

	effect:setMoveToDestinationListener(self._updateView, self)
	effect:setFinishListener(self._onEffectFinish, self)
	effect:play(fx, fy, fz, tx, ty, tz)
end

function MaterialBattleGoldExtensionView:_onCollectInfoReload()
	local infoCollector = BattleMgr.instance:getInfoCollector()

	self._killEnemyCount = infoCollector:getEnemyTotalDeadCount()

	self:_updateView()
end

function MaterialBattleGoldExtensionView:_onEffectFinish(effect)
	self._incrEffectPool:releaseInstance(effect)
end

function MaterialBattleGoldExtensionView:_updateView()
	local n = self._killEnemyCount
	local a = self._factorA
	local b = self._factorB
	local sn = a * n * (b / (n + 20))

	sn = math.ceil(sn)

	local additional = PlayerInfoFacade.instance:getAchievementSkillProfit(CommEnum.CharacterSkillType.Type4)

	sn = math.floor(sn * (1 + additional))
	self._totalValue = sn

	self._rollingCount:rollToValue(sn, 0.2, true)
	self._animation:Play("battle_resourcea_view_open")
end

function MaterialBattleGoldExtensionView:_initFactors()
	local dungeonCode = BattleEnterUtil.getCurrentDungeonCode()
	local dungeonMO = DungeonModel.instance:getDungeonMoById(dungeonCode)
	local materialDungeonCode = dungeonMO:getMaterialDungeonCode()
	local materialDungeonCO = DungeonConfig.instance:getMaterialDungeonCfgByMaterialDungoenId(materialDungeonCode)

	self._factorA = materialDungeonCO.goldA
	self._factorB = materialDungeonCO.goldB
	self._killEnemyCount = 0
	self._totalValue = 0
end

return MaterialBattleGoldExtensionView
