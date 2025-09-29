-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/photo/FullscreenPhotoEffect.lua

module("logic.common.photo.FullscreenPhotoEffect", package.seeall)

local FullscreenPhotoEffect = class("FullscreenPhotoEffect", PhotoEffect)

FullscreenPhotoEffect.HEIGHT = 720
FullscreenPhotoEffect.WIDTH = 1280
FullscreenPhotoEffect.ASPECT = FullscreenPhotoEffect.WIDTH / FullscreenPhotoEffect.HEIGHT

function FullscreenPhotoEffect.Get(go)
	FullscreenPhotoEffect._adjustGoSize(go)

	return Astral.LuaComponentContainer.Add(go, FullscreenPhotoEffect)
end

function FullscreenPhotoEffect._adjustGoSize(go)
	local screenAspect = ViewMgr.instance:getUIWidth() / ViewMgr.instance:getUIHeight()
	local scale = 1

	if screenAspect > FullscreenPhotoEffect.ASPECT then
		scale = ViewMgr.instance:getUIWidth() / FullscreenPhotoEffect.WIDTH
	else
		scale = ViewMgr.instance:getUIWidth() / FullscreenPhotoEffect.ASPECT / FullscreenPhotoEffect.HEIGHT
	end

	RectTransformUtils.SetSize(go.transform, FullscreenPhotoEffect.WIDTH, FullscreenPhotoEffect.HEIGHT)
	Astral.TransformUtil.SetLocalScale(go.transform, scale, scale, scale)
end

function FullscreenPhotoEffect.getBalckWidthHeight()
	local screenH = ViewMgr.instance:getUIHeight()
	local screenW = ViewMgr.instance:getUIWidth()
	local screenAspect = screenW / screenH

	if screenAspect > FullscreenPhotoEffect.ASPECT then
		local doubleW = screenW - screenH * FullscreenPhotoEffect.ASPECT

		return doubleW / 2, 0
	else
		local doubleH = screenH - screenW / FullscreenPhotoEffect.ASPECT

		return 0, doubleH / 2
	end

	return 0, 0
end

return FullscreenPhotoEffect
