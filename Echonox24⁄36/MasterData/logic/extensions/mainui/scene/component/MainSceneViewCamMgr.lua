-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/scene/component/MainSceneViewCamMgr.lua

module("logic.extensions.mainui.scene.component.MainSceneViewCamMgr", package.seeall)

local M = class("MainSceneViewCamMgr", SceneComponentBase)

M.CamData = {
	[ViewName.CharacterDepotMainViewNew] = {
		{
			index = MainPerformEnum.CharSysCamGroupItemTyp.Depot
		}
	},
	[ViewName.CharacterMainSystemViewNew] = {
		[CommEnum.CharacterSystemTab.Detail] = {
			index = MainPerformEnum.CharSysCamGroupItemTyp.Detail
		},
		[CommEnum.CharacterSystemTab.Authority] = {
			index = MainPerformEnum.CharSysCamGroupItemTyp.Authority
		},
		[CommEnum.CharacterSystemTab.Equip] = {
			index = MainPerformEnum.CharSysCamGroupItemTyp.Equip
		},
		[CommEnum.CharacterSystemTab.EchoItem] = {
			index = MainPerformEnum.CharSysCamGroupItemTyp.Echo
		},
		[CommEnum.CharacterSystemTab.Thinking] = {
			index = MainPerformEnum.CharSysCamGroupItemTyp.Thinking
		},
		[CommEnum.CharacterSystemTab.Profile] = {
			index = MainPerformEnum.CharSysCamGroupItemTyp.Profile
		}
	},
	[ViewName.AirtightRoomTimeView] = {
		{
			camCode = MainPerformEnum.CamCodeClock
		},
		{
			camCode = 2
		},
		{
			camCode = 11
		},
		{
			camCode = 12
		}
	},
	[ViewName.ChamberExchange] = {
		{
			camCode = 13
		}
	},
	[ViewName.CharacterSkinView] = {
		[MainPerformEnum.SkinTabIndex.SkinMainView] = {
			index = MainPerformEnum.CharSysCamGroupItemTyp.Skin
		},
		[MainPerformEnum.SkinTabIndex.SkinPreview] = {
			index = MainPerformEnum.CharSysCamGroupItemTyp.SkinPreview
		}
	},
	[ViewName.WelfareMainView] = {
		{
			camCode = 14
		}
	},
	[ViewName.Character3DPreview] = {
		{
			index = MainPerformEnum.CharSysCamGroupItemTyp.SkillPreview
		}
	}
}

function M:ctor(scene)
	M.super.ctor(self, scene)
end

function M:onInit()
	return
end

function M:onEnterScene(sceneId, bornX, bornZ)
	self._viewRecord = {}

	self:_setEvent(true)
end

function M:onEnterSceneFinished(sceneId, bornX, bornZ)
	return
end

function M:onExitScene()
	self:_setEvent(false)

	self._viewRecord = {}
end

function M:onLeaveScene()
	self:_setEvent(false)
end

function M:onReturnScene()
	self:_setEvent(true)
end

function M:onReturnSceneFinished()
	return
end

function M:_setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.MAIN_SCENE_VIEW_CAM_CTRL, self._handleViewCamCtrl, self)
		GlobalDispatcher:addEventListener(EventType.JUMP_VIEW_TO_MAIN, self._handleJumpViewToMain, self)
	else
		GlobalDispatcher:removeEventListener(EventType.MAIN_SCENE_VIEW_CAM_CTRL, self._handleViewCamCtrl, self)
		GlobalDispatcher:removeEventListener(EventType.JUMP_VIEW_TO_MAIN, self._handleJumpViewToMain, self)
	end
end

function M:_handleJumpViewToMain(e)
	self._viewRecord = {}

	local camCode = 0
	local duration = MainPerformEnum.DefaultCamTweenDuration

	MainScenePerformUtil.tweenMainSceneCam(camCode, duration, DG.Tweening.Ease.OutQuint)
end

function M:_handleViewCamCtrl(e, info)
	local viewName = info.viewName
	local subPage = info.subPage
	local open = info.open
	local isNormal = info.isNormal
	local heroId = info.heroId
	local modelId = info.modelId
	local callBack = info.callBack
	local callBackHandler = info.callBackHandler

	if not heroId then
		local displayHero, _ = MainScenePerformUtil.getDisplayAdjutantHeroId()

		heroId = displayHero
	end

	if open then
		if not self._viewRecord[viewName] then
			self._viewRecord[viewName] = {}
		end

		self._viewRecord[viewName].subPage = subPage

		self:checkViewRecord()
	else
		if self._viewRecord[viewName] then
			self._viewRecord[viewName] = nil
		end

		self:checkViewRecord()

		if not isNormal then
			return
		end
	end

	local camCode = TableUtil.getLen(self._viewRecord) == 0 and 0 or nil
	local duration = MainPerformEnum.DefaultCamTweenDuration

	if open then
		camCode = self:getCamCode(viewName, subPage, heroId, modelId)
	end

	if camCode then
		MainScenePerformUtil.tweenMainSceneCam(camCode, duration, DG.Tweening.Ease.OutQuint, callBack, callBackHandler)
	end
end

function M:getCamCode(viewName, subPage, heroId, modelId)
	modelId = modelId or CharacterUtil.getDepotHeroModelId(heroId)

	local camCode = 0

	if M.CamData[viewName] and M.CamData[viewName][subPage] then
		if M.CamData[viewName][subPage].camCode then
			return M.CamData[viewName][subPage].camCode
		end

		local index = M.CamData[viewName][subPage].index
		local cfgCamGroup = MainPerformConfig.instance:getHeroCharSysCamGroup(modelId)

		if cfgCamGroup and cfgCamGroup.camIds and #cfgCamGroup.camIds > 0 then
			return cfgCamGroup.camIds[index]
		end
	end

	return camCode
end

function M:checkViewRecord()
	if not self._viewRecord then
		self._viewRecord = {}
	end

	local removeMap = {}

	for viewName, _ in pairs(self._viewRecord) do
		if not ViewMgr.instance:isOpen(viewName) then
			removeMap[viewName] = 1
		end
	end

	for viewName, _ in pairs(removeMap) do
		self._viewRecord[viewName] = nil
	end
end

function M:printStatus(titleStr)
	local t = {
		titleStr
	}

	table.insert(t, string.format("记录总数:%s", TableUtil.getLen(self._viewRecord)))

	for key, value in pairs(self._viewRecord) do
		table.insert(t, string.format("[%s] subPage:%s", key, value.subPage))
	end

	printError(table.concat(t, "\n"))
end

return M
