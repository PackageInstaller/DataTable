-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/bootstrap/BootstrapAdaptationoverlayview.lua

module("bootstrap.BootstrapAdaptationoverlayview", package.seeall)

local BootstrapAdaptationoverlayview = {}

BootstrapAdaptationoverlayview.IsBuild = false

function BootstrapAdaptationoverlayview.buildUI()
	if BootstrapAdaptationoverlayview.IsBuild then
		return
	end

	if not BootstrapUtil._isCanUseAdapter() then
		return
	end

	getres("ui/views/bootstrap/bootstrapadaptationoverlayview.prefab", BootstrapAdaptationoverlayview._onResLoaded, BootstrapAdaptationoverlayview)
end

function BootstrapAdaptationoverlayview:_onBgResLoaded(res)
	if not res or not res.IsSuccess then
		return
	end

	local mainAsset = res:GetMainAsset()

	if not mainAsset then
		return
	end

	res:Retain()
	getres("ui/views/bootstrap/bootstrapadaptationoverlayview.prefab", BootstrapAdaptationoverlayview._onResLoaded, BootstrapAdaptationoverlayview)
end

function BootstrapAdaptationoverlayview:_onResLoaded(res)
	if not res or not res.IsSuccess then
		return
	end

	local mainAsset = res:GetMainAsset()

	if not mainAsset then
		return
	end

	BootstrapAdaptationoverlayview.IsBuild = true

	res:Retain()

	BootstrapAdaptationoverlayview._gameObject = UnityEngine.GameObject.Instantiate(mainAsset)

	if BootstrapAdaptationoverlayview._gameObject then
		BootstrapAdaptationoverlayview._upGo = BootstrapAdaptationoverlayview._findChild(BootstrapAdaptationoverlayview._gameObject, "up")
		BootstrapAdaptationoverlayview._downGo = BootstrapAdaptationoverlayview._findChild(BootstrapAdaptationoverlayview._gameObject, "down")
	end

	BootstrapAdaptationoverlayview.updatePos()
end

function BootstrapAdaptationoverlayview.updatePos()
	if not BootstrapAdaptationoverlayview._gameObject then
		return
	end

	local curWidth, curHeight = SceneResolution.Instance:GetCurrentResolution(0, 0)
	local realHeight = curHeight
	local realWidth = curWidth

	if Framework.OSDef.isEditor then
		local oriWidth, oriHeight = SceneResolution.Instance:GetOriginalResolution(0, 0)

		realWidth = oriWidth
		realHeight = oriHeight

		printInfo("test BootstrapAdaptationoverlayview分辨率数值 编辑器状态下：", CameraRectSetter.HeightRatio, oriHeight)
	end

	local height = CameraRectSetter.HeightRatio * realHeight
	local adaptHeight = (realHeight - realHeight * CameraRectSetter.HeightRatio) / 2
	local posy = height * 0.5

	Framework.TransformUtil.SetLocalPos(BootstrapAdaptationoverlayview._upGo.transform, 0, posy, 0)
	Framework.TransformUtil.SetLocalPos(BootstrapAdaptationoverlayview._downGo.transform, 0, -posy, 0)
	BootstrapAdaptationoverlayview._setWidth(BootstrapAdaptationoverlayview._upGo, realWidth)
	BootstrapAdaptationoverlayview._setWidth(BootstrapAdaptationoverlayview._downGo, realWidth)
	BootstrapAdaptationoverlayview._setHeight(BootstrapAdaptationoverlayview._upGo, adaptHeight)
	BootstrapAdaptationoverlayview._setHeight(BootstrapAdaptationoverlayview._downGo, adaptHeight)
end

function BootstrapAdaptationoverlayview._setWidth(go, width)
	local trans = go:GetComponent(typeof(UnityEngine.RectTransform))

	if trans then
		Framework.GeometryUtil.SetWidth(trans, width)
	end
end

function BootstrapAdaptationoverlayview._setHeight(go, width)
	local trans = go:GetComponent(typeof(UnityEngine.RectTransform))

	if trans then
		Framework.GeometryUtil.SetHeight(trans, width)
	end
end

function BootstrapAdaptationoverlayview._findChild(container, childName)
	local trs = container.transform:Find(childName)

	if trs then
		return trs.gameObject
	end

	return nil
end

function BootstrapAdaptationoverlayview.destroyUI()
	if BootstrapAdaptationoverlayview._gameObject then
		UnityEngine.GameObject.Destroy(BootstrapAdaptationoverlayview._gameObject)
	end

	BootstrapAdaptationoverlayview._gameObject = nil
	BootstrapAdaptationoverlayview._upGo = nil
	BootstrapAdaptationoverlayview._downGo = nil
end

return BootstrapAdaptationoverlayview
