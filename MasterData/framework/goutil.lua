-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/aounity-framework/Scripts/Lua/framework/util/goutil.lua

module("framework.util.gameobject", package.seeall)

local goutil = {}

goutil.Type_UIImage = typeof(UnityEngine.UI.Image)
goutil.Type_UIText = typeof(UnityEngine.UI.Text)
goutil.Type_UIButton = typeof(UnityEngine.UI.Button)
goutil.Type_RectTransform = typeof(UnityEngine.RectTransform)
goutil.Layer_UI = Framework.LayerUtil.NameToLayer("UI")

function goutil.isNil(gameObject)
	return gameObject == nil or gameObject:Equals(nil)
end

function goutil.find(name)
	return (UnityEngine.GameObject.Find(name))
end

function goutil.findChild(container, childName)
	local trs = container.transform:Find(childName)

	if trs then
		return trs.gameObject
	end

	return nil
end

function goutil.findChildComponent(container, childName, compName)
	local offspring = goutil.findChild(container, childName)

	if offspring then
		return offspring:GetComponent(compName)
	end

	return nil
end

function goutil.findChildRectTransformComponent(container, childName)
	return goutil.findChildComponent(container, childName, goutil.Type_RectTransform)
end

function goutil.findChildImageComponent(container, childName)
	return goutil.findChildComponent(container, childName, goutil.Type_UIImage)
end

function goutil.findChildTextComponent(container, childName)
	return goutil.findChildComponent(container, childName, goutil.Type_UIText)
end

function goutil.findChildButtonComponent(container, childName)
	return goutil.findChildComponent(container, childName, goutil.Type_UIButton)
end

function goutil.addComponentOnce(go, compName)
	local comp = go:GetComponent(compName)

	comp = comp or go:AddComponent(compName)

	return comp
end

function goutil.addChildToParent(child, parent)
	child.transform:SetParent((parent or nil) and (parent.transform or nil), false)
end

function goutil.create(name, is2D)
	local go = UnityEngine.GameObject.New()

	if name ~= nil then
		go.name = name
	end

	if is2D ~= false then
		go:AddComponent(goutil.Type_RectTransform)

		go.layer = goutil.Layer_UI
	end

	return go
end

function goutil.clearChildren(container)
	local trs = container.transform
	local count = trs.childCount

	for i = count, 1, -1 do
		local child = trs:GetChild(i - 1)

		UnityEngine.GameObject.Destroy(child.gameObject)
	end

	trs:DetachChildren()
end

function goutil.clone(sourceGameObject, name)
	if sourceGameObject == nil then
		return nil
	end

	local go = UnityEngine.GameObject.Instantiate(sourceGameObject)

	if name ~= nil then
		go.name = name
	end

	return go
end

function goutil.cloneAndSetParent(sourceGameObject, parent, name)
	if sourceGameObject == nil then
		return nil
	end

	return (Framework.GameObjectUtil.CloneAndSetParent(sourceGameObject, parent, name))
end

function goutil.destroy(gameObject, isImmediate)
	if gameObject == nil then
		return
	end

	UnityEngine.GameObject.Destroy(gameObject)
end

function goutil.getWidth(rectTransform)
	return rectTransform.rect.width
end

function goutil.getHeight(rectTransform)
	return rectTransform.rect.height
end

function goutil.setWidth(rectTransform, width)
	Framework.GeometryUtil.SetWidth(rectTransform, width)
end

function goutil.setHeight(rectTransform, height)
	Framework.GeometryUtil.SetHeight(rectTransform, height)
end

function goutil.screenToLocalPos(screenPos, rectTransform)
	local uiCamera = CameraTargetMgr.instance:getUICameraTarget():getCamera()

	return Framework.GeometryUtil.ScreenToLocalPos(screenPos, rectTransform, uiCamera)
end

function goutil.setActive(gameObject, active)
	if gameObject == nil or goutil.isNil(gameObject) then
		return
	end

	active = checkbool(active)

	if gameObject.activeSelf ~= active then
		gameObject:SetActive(active)
	end
end

setglobal("goutil", goutil)
