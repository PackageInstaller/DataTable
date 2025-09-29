-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/specialtraining/scene/SpecialTrainingResMgr.lua

module("logic.extensions.specialtraining.scene.SpecialTrainingResMgr", package.seeall)

local M = class("SpecialTrainingResMgr", ISceneFlowComp)
local DEFAULT_CENTER = {
	z = 0,
	x = 0,
	y = 0.8
}
local DEFAULT_SIZE = {
	z = 0.24,
	x = 0.4,
	y = 1.6
}

function M:onInit()
	self._colliderCenter = Vector3.New(DEFAULT_CENTER.x, DEFAULT_CENTER.y, DEFAULT_CENTER.z)
	self._colliderSize = Vector3.New(DEFAULT_SIZE.x, DEFAULT_SIZE.y, DEFAULT_SIZE.z)
	self._heroLoader = MultiResLoader.New()
	self._handler = Handler.New()
	self._heroResPaths = {}
	self._heroRoots = {}
end

function M:onEnter()
	self:_setEvent(true)
end

function M:onEnterDone()
	local curScene = SceneMgr.instance:getCurScene()

	self._cameraGo = curScene.stage:getGoList("CM vcam3")[1]
	self._initTrs = curScene.stage:getGoList("cameraPosition0")[1].transform
	self._targetPosition = self._initTrs

	Astral.TransformUtil.SetLocalPos(self._cameraGo.transform, self._initTrs.localPosition.x, self._initTrs.localPosition.y, self._initTrs.localPosition.z)
	Astral.TransformUtil.SetLocalRotation(self._cameraGo.transform, self._initTrs.eulerAngles.x, self._initTrs.eulerAngles.y, self._initTrs.eulerAngles.z)

	local characterRootGo = curScene.stage:getGoList("otherResources")[1]

	if characterRootGo then
		self._cameraPos = {
			goutil.findChild(characterRootGo, "cameraPosition4").transform,
			goutil.findChild(characterRootGo, "cameraPosition1").transform,
			goutil.findChild(characterRootGo, "cameraPosition2").transform,
			goutil.findChild(characterRootGo, "cameraPosition3").transform
		}
		self._heroRoots = {
			goutil.findChild(characterRootGo, "character01"),
			goutil.findChild(characterRootGo, "character02"),
			goutil.findChild(characterRootGo, "character03")
		}

		self:_refreshHero()
	end

	self:_instanceHero()
end

function M:onExit()
	self:_setEvent(false)
	self._handler:clear()
	self._heroLoader:clear()

	self._heroResPaths = {}
	self._heroRoots = {}
end

function M:load(callback, callbackSelf)
	self._handler:setListener(callback, callbackSelf)
	self:getAllHeroResource()
end

function M:removeListener()
	self._handler:clear()
end

function M:_setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.SPECIAL_TRAINING_PLANCLICK, self._clickHero, self)
		GlobalDispatcher:addEventListener(EventType.SPECIAL_TRAINING_PLANCHANGE, self._clickHero, self)
		GlobalDispatcher:addEventListener(EventType.SPECIAL_TRAINING_UPDATESTAGE, self._refreshHero, self)
	else
		GlobalDispatcher:removeEventListener(EventType.SPECIAL_TRAINING_PLANCLICK, self._clickHero, self)
		GlobalDispatcher:removeEventListener(EventType.SPECIAL_TRAINING_PLANCHANGE, self._clickHero, self)
		GlobalDispatcher:removeEventListener(EventType.SPECIAL_TRAINING_UPDATESTAGE, self._refreshHero, self)
	end
end

function M:_clickHero(e, planId)
	self._targetPosition = self._cameraPos[planId + 1].localPosition
	self._targetRotation = self._cameraPos[planId + 1].eulerAngles

	if planId > 0 then
		for i, v in ipairs(self._heroRoots) do
			goutil.setActive(v, planId == i)
		end
	else
		for i, v in ipairs(self._heroRoots) do
			goutil.setActive(v, true)
		end
	end

	local ease = DG.Tweening.Ease.InOutSine

	self._camTweenerPos = self._cameraGo.transform:DOLocalMove(self._targetPosition, 1):SetEase(ease):SetAutoKill(true)
	self._camTweenerRotation = self._cameraGo.transform:DOLocalRotate(self._targetRotation, 1, DG.Tweening.RotateMode.Fast):SetAutoKill(true)
end

function M:_refreshHero()
	local planId = SpecialtrainingModel.instance:getPlanId()

	if planId > 0 then
		for i, v in ipairs(self._heroRoots) do
			goutil.setActive(v, planId == i)
		end
	else
		for i, v in ipairs(self._heroRoots) do
			goutil.setActive(v, true)
		end
	end
end

function M:getAllHeroResource()
	local planList = SpecialtrainingModel.instance:getPlans()

	for i, v in ipairs(planList) do
		local characterCo = CharacterConfig.instance:getCfgInfoByID(v.heroId)
		local modelCO = ModelConfig.instance:getModelConfig(characterCo.modelId)

		printWarn("====hero resource path: ", GameUrl.getHighMeshModelUrl(modelCO.resName))
		self._heroLoader:addResPath(GameUrl.getHighMeshModelUrl(modelCO.resName))
		table.insert(self._heroResPaths, GameUrl.getHighMeshModelUrl(modelCO.resName))
	end

	self._heroLoader:load(self._onAllHeroLoaded, false, self)
end

function M:getHeroResource(resPath)
	return self._heroLoader:getResource(resPath)
end

function M:_updateCollider(heroGo)
	local collider = heroGo:GetComponent(ComponentType.BoxCollider)

	if collider then
		collider.center = self._colliderCenter
		collider.size = self._colliderSize
	end
end

function M:_instanceHero()
	for i, v in ipairs(self._heroResPaths) do
		local res = self:getHeroResource(v)

		if res then
			local heroGo = goutil.clone(res:GetMainAsset())

			if heroGo then
				goutil.addComponentOnce(heroGo, ComponentType.BoxCollider)
				self:_updateCollider(heroGo)
			end

			goutil.addChildToParent(heroGo, self._heroRoots[i])

			local anim = AnimationPlayer.Get(heroGo)
			local allAniNames = {}

			anim:GetAnimationNamesLua(allAniNames)

			local aniName = ""

			for _, _name in ipairs(allAniNames) do
				if string.match(_name, "idle") then
					aniName = _name

					break
				end
			end

			if aniName == "idle2" then
				anim:PlayAnimation(aniName, true, false)
			end
		end
	end
end

function M:_onAllHeroLoaded()
	if not self._heroLoader:isAllSuccess() then
		if enableErrorLog then
			printError("preload hero resource failed!")
		end

		self._handler:call(false)

		return
	end

	self._handler:call(true)
end

return M
