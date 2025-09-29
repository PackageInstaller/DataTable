-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/characterpreview/scene/CharacterPreviewViewMgr.lua

module("logic.extensions.characterpreview.scene.CharacterPreviewViewMgr", package.seeall)

local M = class("CharacterPreviewViewMgr", ISceneFlowComp)
local RotateFactor = 0.12

function M:ctor(flow)
	self.super.ctor(self, flow)

	self._sceneInfo = nil
	self._transfHero = nil
	self._dragPos = Vector3.New()
end

function M:onInit()
	return
end

function M:onEnter(sceneInfo)
	self._sceneInfo = sceneInfo

	ViewMgrUtil.hideAllView()
	ViewMgr.instance:open(ViewName.Character3DPreview)
end

function M:onExit()
	return
end

function M:onSceneLoadDone()
	return
end

function M:onEnterDone()
	self:_addEvent()

	if goutil.isNil(self._transfHero) then
		local scene = SceneMgr.instance:getScene(SceneType.CharacterPreview)

		self._transfHero = scene.stage:getHero().transform
	end
end

function M:onExitDone()
	self:_removeEvent()
end

function M:onDestroy()
	self._sceneInfo = nil
	self._transfHero = nil
end

function M:_addEvent()
	GlobalDispatcher:addEventListener(EventType.ON_SCENE_PICKER_BEGIN_DRAG, self._onBeginDrag, self)
	GlobalDispatcher:addEventListener(EventType.ON_SCENE_PICKER_DRAG, self._onDrag, self)
	GlobalDispatcher:addEventListener(EventType.HERO_PREVIEW_POS_CTRL, self._onPosCtrl, self)
end

function M:_removeEvent()
	GlobalDispatcher:removeEventListener(EventType.ON_SCENE_PICKER_BEGIN_DRAG, self._onBeginDrag, self)
	GlobalDispatcher:removeEventListener(EventType.ON_SCENE_PICKER_DRAG, self._onDrag, self)
	GlobalDispatcher:removeEventListener(EventType.HERO_PREVIEW_POS_CTRL, self._onPosCtrl, self)
end

function M:_onBeginDrag(e, point, pointerId)
	self._dragPos:Set(point.x, point.y)
end

function M:_onDrag(e, point, pointerId)
	local degree = (self._dragPos.x - point.x) * RotateFactor

	self._dragPos:Set(point.x, point.y)

	local rotX, rotY, rotZ = Astral.TransformUtil.GetLocalRotation(self._transfHero, nil, nil, nil)

	Astral.TransformUtil.SetLocalRotation(self._transfHero, rotX, rotY + degree, rotZ)
end

function M:_onPosCtrl(e, posCo)
	local pos = posCo.pos
	local rot = posCo.rot

	Astral.TransformUtil.SetLocalPos(self._transfHero, pos.x, pos.y, pos.z)
	Astral.TransformUtil.SetLocalRotation(self._transfHero, rot.x, rot.y, rot.z)
end

return M
