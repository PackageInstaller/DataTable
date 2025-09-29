-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/battleflow/viewextension/MaterialBattleExpExtensionView.lua

module("logic.extensions.dungeon.battleflow.viewextension.MaterialBattleExpExtensionView", package.seeall)

local MaterialBattleExpExtensionView = class("MaterialBattleExpExtensionView", IBattleExtensionView)
local kSegmentAnimations = {
	"",
	"battle_resourcea_view_open_t2_01",
	"battle_resourcea_view_open_t2_02",
	"battle_resourcea_view_open_t2_03"
}

function MaterialBattleExpExtensionView:dependMainResource()
	return "ui/views/resources_explore/battle_resources_view.prefab"
end

function MaterialBattleExpExtensionView:dependExtensionResources()
	return {
		GameUrl.get3dEffectUIUrl("scene_jingyanben_jishu")
	}
end

function MaterialBattleExpExtensionView:attachToWhichRoot()
	return IBattleExtensionView.AttackRoot.TOP_LEFT
end

function MaterialBattleExpExtensionView:buildUI()
	self._effectPrefab = self:getPrefab(GameUrl.get3dEffectUIUrl("scene_jingyanben_jishu"))
	self._incrEffectPool = LocalReusableCollection.New(MaterialBattleIncrEffect, 5)
	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "txtHint2")
	self._txtCount = goutil.findChildTextComponent(self.mainGO, "txtHint2/txtNum2")
	self._rollingCount = UIEffectUtil.getTextRollingEffect(self._txtCount.gameObject)
	self._totalDamage = 0
	self._damageSegements = false
	self._currentSegmentIndex = 1

	local goldSignGo = goutil.findChild(self.mainGO, "imgType1")
	local expSignGo = goutil.findChild(self.mainGO, "imgType2")

	self._animation = goutil.addComponentOnce(self.mainGO, ComponentType.Animation)

	goutil.setActive(goldSignGo, false)
	goutil.setActive(expSignGo, true)

	self._isVisible = true
end

function MaterialBattleExpExtensionView:destroyUI()
	self._incrEffectPool:clear()

	self._incrEffectPool = nil
	self._effectPrefab = nil
	self._txtTitle = nil
	self._txtCount = nil
	self._totalDamage = nil
	self._damageSegements = nil
end

function MaterialBattleExpExtensionView:onEnter()
	self._hideKeyDic = {}

	self:_setEvent(true)

	self._totalDamage = 0

	self._rollingCount:setValue(0)

	self._currentSegmentIndex = 0

	self:_initInfo()
	self:_onCollectInfoReload()

	self._txtTitle.text = lang("tip_give_hurt")

	AnimationUtils.ResetAnimation(self._animation, "battle_resourcea_view_open_t2_01")
end

function MaterialBattleExpExtensionView:onExit()
	self._hideKeyDic = {}

	self:_setEvent(false)
	self._incrEffectPool:clearAllInstance()
end

function MaterialBattleExpExtensionView:_setEvent(add)
	if add then
		BattleDispatcher:addEventListener(BattleEventType.OnDamaged, self._onAttackEvent, self)
		BattleDispatcher:addEventListener(BattleEventType.OnCollectInfoReload, self._onCollectInfoReload, self)
		BattleDispatcher:addEventListener(BattleEventType.MaterialVisibleUpdate, self._setVisiable, self)
	else
		BattleDispatcher:removeEventListener(BattleEventType.OnDamaged, self._onAttackEvent, self)
		BattleDispatcher:removeEventListener(BattleEventType.OnCollectInfoReload, self._onCollectInfoReload, self)
		BattleDispatcher:removeEventListener(BattleEventType.MaterialVisibleUpdate, self._setVisiable, self)
	end
end

function MaterialBattleExpExtensionView:_setVisiable(_, status, key)
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
		AnimationUtils.ResetToLastFrame(self._animation)
		self._incrEffectPool:clearAllInstance()
		self:_updateView()
	end

	goutil.setActive(self.mainGO, not isHide)
end

function MaterialBattleExpExtensionView:_onAttackEvent(evt, damage, fx, fy, fz)
	self._totalDamage = self._totalDamage + damage

	self:_playIncreaseEffect(fx, fy, fz)
end

function MaterialBattleExpExtensionView:_playIncreaseEffect(fx, fy, fz)
	if not BattleMainViewFacade.instance:isVisible() then
		self:_updateView()

		return
	end

	local tx, ty, tz = Astral.TransformUtil.GetPos(self.mainGO.transform, 0, 0, 0)
	local effect = self._incrEffectPool:createInstance(self._effectPrefab)

	effect:setMoveToDestinationListener(self._updateView, self)
	effect:setFinishListener(self._onEffectFinish, self)
	effect:play(fx, fy, fz, tx, ty, tz)
end

function MaterialBattleExpExtensionView:_onCollectInfoReload()
	local infoCollector = BattleMgr.instance:getInfoCollector()

	self._totalDamage = infoCollector:getInitialTotalDamageToEnemy()

	self:_updateView()
end

function MaterialBattleExpExtensionView:_onEffectFinish(effect)
	self._incrEffectPool:releaseInstance(effect)
end

function MaterialBattleExpExtensionView:_updateView()
	local segmentIndex = self:_getDamageSegementIndex()

	if self._currentSegmentIndex ~= segmentIndex then
		self._currentSegmentIndex = segmentIndex

		self:_playSegmentAnimation(segmentIndex)
	end

	self._rollingCount:rollToValue(self._totalDamage, 0.2, true)
	TextUtils.SetColor(self._txtCount, self:_getDamageColorString(self._currentSegmentIndex))
end

function MaterialBattleExpExtensionView:_initInfo()
	local dungeonCode = BattleEnterUtil.getCurrentDungeonCode()
	local dungeonMO = DungeonModel.instance:getDungeonMoById(dungeonCode)
	local materialDungeonCode = dungeonMO:getMaterialDungeonCode()
	local materialDungeonCO = DungeonConfig.instance:getMaterialDungeonCfgByMaterialDungoenId(materialDungeonCode)

	self._damageSegements = materialDungeonCO.expSegements

	local bossId = materialDungeonCO.boss
	local levelCode = materialDungeonCO.commonDungeonId
	local battleLevelCO = BattleConfig.instance:getBattleLevelCO(levelCode)
	local bossHP = 0

	for monsterID, monsterCO in pairs(battleLevelCO.monsters) do
		if monsterID == bossId then
			bossHP = monsterCO.maxHp

			break
		end
	end

	self._bossHP = bossHP
end

function MaterialBattleExpExtensionView:_playSegmentAnimation(index)
	local animationName = kSegmentAnimations[index]

	if animationName and animationName ~= "" then
		self._animation:Play(animationName)
	end
end

function MaterialBattleExpExtensionView:_getDamageSegementIndex()
	if self._damageSegements then
		for i = #self._damageSegements, 1, -1 do
			if self._totalDamage >= self._bossHP * self._damageSegements[i] then
				return i + 1
			end
		end
	end

	return 0
end

function MaterialBattleExpExtensionView:_getDamageColorString(index)
	return "#ffffff"
end

function MaterialBattleExpExtensionView:_getColorStringBySegementIndex(index)
	if index >= 4 then
		return CommEnum.QualityColorType[GameEnum.QualityEnum.S]
	elseif index >= 3 then
		return CommEnum.QualityColorType[GameEnum.QualityEnum.A]
	elseif index >= 2 then
		return CommEnum.QualityColorType[GameEnum.QualityEnum.B]
	else
		return CommEnum.QualityColorType[GameEnum.QualityEnum.C]
	end
end

return MaterialBattleExpExtensionView
