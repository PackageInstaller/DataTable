-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/view/BattleFamilyBossView.lua

module("logic.extensions.battle.view.BattleFamilyBossView", package.seeall)

local BattleFamilyBossView = class("BattleFamilyBossView")
local DROP_POINT_MAX_NUM = 4

function BattleFamilyBossView:ctor(go, view, bloodBar)
	self._view = view
	self.mainGO = go
	self._drops = {}
	self._usedPoints = {}
	self._actions = {}
	self._bloodBar = bloodBar
end

function BattleFamilyBossView:onExit()
	removetimer(self._updateActionEff, self)

	self._actions = self._actions or {}

	while #self._actions > 0 do
		self:_clearAction()
	end

	self._actions = nil

	if self._boxTweens then
		for i = 1, #self._boxTweens do
			self._boxTweens[i]:Kill(false)
		end

		self._boxTweens = nil
	end
end

function BattleFamilyBossView:setActive(active)
	goutil.setActive(self.mainGO, active)
end

function BattleFamilyBossView:buildUI()
	self._cloneBox = goutil.findChild(self.mainGO, "bom/drop")
	self._txtBoxNum = goutil.findChildComponent(self.mainGO, "top/box/txtBoxNum", "Text")
	self._imgBox = goutil.findChild(self.mainGO, "top/box/imgBox")

	uGuiUtil.setSpriteToImage(self._imgBox, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl("icon_zb2"))
	goutil.setActive(self._cloneBox, false)

	self._dropPoints = {}

	for i = 1, DROP_POINT_MAX_NUM do
		table.insert(self._dropPoints, goutil.findChild(self.mainGO, "bom/drop_point_" .. i))
	end
end

function BattleFamilyBossView:onEnter()
	if not BattleModel.instance.familyBossId then
		local bossId = 1
		local bossCfg = FamilyConfig.instance:getFamilyBossCfg(bossId)
		local cfgs = FamilyConfig.instance:getBossPrizeStrategy(bossCfg.rewardId)

		self._cfgs = {}

		for _, v in pairs(cfgs) do
			if checknumber(v.interval) > 0 then
				table.insert(self._cfgs, v)
			end
		end

		table.sort(self._cfgs, function(a, b)
			return a.interval < b.interval
		end)
		settimer(0, self._updateActionEff, self)
	end
end

function BattleFamilyBossView:updateValue(cur, total, isForce)
	local value = total - cur

	if self._cfgs == nil then
		return
	end

	value = checknumber(value)
	value = math.max(0, value)
	self._value = checknumber(self._value)
	self._value = math.max(0, self._value)

	local targetCfg, targetIdx = self:_getCurCfgAndNeed(value)

	self._txtBoxNum.text = targetIdx - 1

	self._bloodBar:setTextProgress(string.format("总伤害：%s/%s", value, targetCfg.interval))

	local sliderValue = targetIdx - 1 + value / targetCfg.interval

	self._bloodBar:setProgress(sliderValue, isForce)

	local curCfg, curIdx = self:_getCurCfgAndNeed(self._value)

	for i = curIdx, targetIdx - 1 do
		local cfg = self._cfgs[i]

		self:_dropBox(cfg.quality)
	end

	self._value = value
end

function BattleFamilyBossView:_getCurCfgAndNeed(value)
	local idx

	for i = 1, #self._cfgs do
		if value < self._cfgs[i].interval then
			idx = i

			break
		end
	end

	idx = idx or #self._cfgs

	local cfg = self._cfgs[idx]

	return cfg, idx
end

function BattleFamilyBossView:_dropBox(qua)
	print("drop qua = " .. qua)

	local screenPos = self:getBossUnitFootPos()
	local uiCamera = GlobalModel.instance.uiCamera
	local pos = uiCamera:ScreenToWorldPoint(screenPos)
	local drop = self:getFreeItem()

	drop.transform.position = pos

	drop:SetActive(true)
	uGuiUtil.setSpriteToImage(drop, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl("icon_zb2"))

	local x, y, z = Framework.TransformUtil.GetPos(drop.transform, 0, 0, 0)
	local targetPoint, idx = self:getDropPoint()
	local x2, y2, z2 = Framework.TransformUtil.GetPos(targetPoint.transform, 0, 0, 0)
	local tween = TweenUtil.ValueTo(0, 1, 0.4, function(val)
		Framework.TransformUtil.SetPos(drop.transform, x + val * (x2 - x), y + val * (y2 - y), z)
	end, function()
		self:_startAction(drop, idx)
	end, self)

	self._boxTweens = self._boxTweens or {}

	table.insert(self._boxTweens, tween)
end

function BattleFamilyBossView:_startAction(go, idx)
	local action = {}

	action.dropIdx = idx
	action.bindGo = go
	action.index = #self._actions + 1

	local x, y, z = Framework.TransformUtil.GetPos(go.transform, 0, 0, 0)
	local x2, y2, z2 = Framework.TransformUtil.GetPos(self._imgBox.transform, 0, 0, 0)

	action.tweenPos = TweenUtil.ValueTo(0, 1, 0.6, function(val)
		Framework.TransformUtil.SetPos(go.transform, x + val * (x2 - x), y + val * (y2 - y), z)
	end, self._clearAction, self)
	action.eff = UIEffectManager.instance:playEffect(self._view, "fx_ui_xinshouzhiyin/fx_xinshouzhiyin_003/fx_feiru_xingxing.prefab", go, 0, 0, true, nil, nil, nil, self)
	action.tweenScale = TweenUtil.ValueTo(1, 0, 0.3, function(val)
		Framework.TransformUtil.SetLocalScale(go.transform, val, val, 1)
	end, nil, self)

	action.tweenPos:SetDelay(1)
	action.tweenScale:SetDelay(1)
	table.insert(self._actions, action)
end

function BattleFamilyBossView:_clearAction()
	local action = self._actions[1]

	table.remove(self._actions, 1)

	self._usedPoints[action.dropIdx] = false

	UIEffectManager.instance:stopEffect(action.eff)
	action.bindGo:SetActive(false)

	action.bindGo = nil
	action.eff = nil
	action.tweenPos = nil
	action.dropIdx = nil
	action.tweenScale = nil
end

function BattleFamilyBossView:_updateActionEff()
	if self._actions and #self._actions >= 1 then
		for _, action in ipairs(self._actions) do
			if action.eff then
				UIEffectManager.instance:updateEffectPosition(action.eff)
			end
		end
	end
end

function BattleFamilyBossView:getBossUnitFootPos()
	local scene = SceneMgr.instance:getCurScene()
	local unitFactory = scene.unitFactory
	local allUnits = unitFactory:getAllUnit()
	local unit
	local teamId = BattleModel.instance:getEnemyPlayerTeam()

	for k1, v1 in pairs(allUnits) do
		if k1 == teamId then
			for k2, v2 in pairs(v1) do
				if not v2.isSourceMon then
					unit = v2
				end
			end
		end
	end

	local foot = unit:getMountPoint(GameEnum.MountPointType.Foot)
	local camera = unit:getUnitCamera()

	return (camera:WorldToScreenPoint(foot.transform.position))
end

function BattleFamilyBossView:getFreeItem()
	for i = 1, #self._drops do
		if not self._drops[i].activeSelf then
			return self._drops[i]
		end
	end

	local go = goutil.cloneAndSetParent(self._cloneBox, self._cloneBox.transform.parent, "drop_" .. #self._drops + 1)

	table.insert(self._drops, go)
	Framework.TransformUtil.SetLocalScale(go.transform, 1, 1, 1)

	return go
end

function BattleFamilyBossView:getDropPoint()
	local idx = 1

	for i = 1, DROP_POINT_MAX_NUM do
		if self._usedPoints[i] ~= true then
			self._usedPoints[i] = true
			idx = i

			break
		end
	end

	return self._dropPoints[idx], idx
end

return BattleFamilyBossView
