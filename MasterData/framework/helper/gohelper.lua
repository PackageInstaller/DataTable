-- chunkname: @framework/helper/gohelper.lua

module("framework.helper.gohelper", package.seeall)

local gohelper = {}

gohelper.Type_Image = typeof(UnityEngine.UI.Image)
gohelper.Type_Text = typeof(UnityEngine.UI.Text)
gohelper.Type_TextMesh = typeof(TMPro.TextMeshProUGUI)
gohelper.Type_RawImage = typeof(UnityEngine.UI.RawImage)
gohelper.Type_Toggle = typeof(UnityEngine.UI.Toggle)
gohelper.Type_ToggleGroup = typeof(UnityEngine.UI.ToggleGroup)
gohelper.Type_ScrollRect = typeof(UnityEngine.UI.ScrollRect)
gohelper.Type_Graphic = typeof(UnityEngine.UI.Graphic)
gohelper.Type_CanvasRenderer = typeof(UnityEngine.CanvasRenderer)
gohelper.Type_GridLayoutGroup = typeof(UnityEngine.UI.GridLayoutGroup)
gohelper.Type_HorizontalLayoutGroup = typeof(UnityEngine.UI.HorizontalLayoutGroup)
gohelper.Type_VerticalLayoutGroup = typeof(UnityEngine.UI.VerticalLayoutGroup)

local UnityEngine_GameObject = UnityEngine.GameObject
local GameObjectHelper = SLFramework.GameObjectHelper
local ButtonWrap = SLFramework.UGUI.ButtonWrap
local InputFieldWrap = SLFramework.UGUI.InputFieldWrap
local ScrollRectWrap = SLFramework.UGUI.ScrollRectWrap
local SliderWrap = SLFramework.UGUI.SliderWrap
local ToggleWrap = SLFramework.UGUI.ToggleWrap
local SingleImage = SLFramework.UGUI.SingleImage
local UIClickListener = SLFramework.UGUI.UIClickListener

function gohelper.isNil(gameObject)
	return gameObject == nil or gameObject:Equals(nil)
end

function gohelper.destroy(go)
	if not gohelper.isNil(go) then
		UnityEngine_GameObject.Destroy(go)
	end
end

function gohelper.addChild(parentGO, childGO)
	GameObjectHelper.AddChild(parentGO, childGO)
end

function gohelper.destroyAllChildren(go)
	GameObjectHelper.DestroyAllChildren(go)
end

function gohelper.setActive(go_comp, isActive)
	return GameObjectHelper.SetActive(go_comp, isActive and true or false)
end

function gohelper.setAsFirstSibling(go)
	GameObjectHelper.SetAsFirstSibling(go)
end

function gohelper.setAsLastSibling(go)
	GameObjectHelper.SetAsLastSibling(go)
end

function gohelper.setSibling(go, index)
	GameObjectHelper.SetSibling(go, index)
end

function gohelper.getSibling(go)
	return GameObjectHelper.GetSibling(go)
end

function gohelper.setSiblingBefore(go, otherGO)
	return GameObjectHelper.SetSiblingBefore(go, otherGO)
end

function gohelper.setSiblingAfter(go, otherGO)
	return GameObjectHelper.SetSiblingAfter(go, otherGO)
end

function gohelper.setLayer(go, layer, recursive)
	GameObjectHelper.SetLayer(go, layer, recursive)
end

function gohelper.setTag(go, tag, recursive)
	GameObjectHelper.SetTag(go, tag, recursive)
end

function gohelper.find(name)
	return UnityEngine_GameObject.Find(name)
end

function gohelper.findChild(parentGO, childPath)
	return GameObjectHelper.FindChild(parentGO, childPath)
end

function gohelper.findChildComponent(parentGO, childPath, componentType)
	return GameObjectHelper.FindChildComponent(parentGO, childPath, componentType)
end

function gohelper.onceAddComponent(go_comp, componentType)
	return GameObjectHelper.OnceAddComponent(go_comp, componentType)
end

function gohelper.findChildText(parentGO, childPath)
	return gohelper.findChildComponent(parentGO, childPath, gohelper.Type_TextMesh) or gohelper.findChildComponent(parentGO, childPath, gohelper.Type_Text)
end

function gohelper.findChildTextMesh(parentGO, childPath)
	return gohelper.findChildComponent(parentGO, childPath, gohelper.Type_TextMesh)
end

function gohelper.findChildImage(parentGO, childPath)
	return gohelper.findChildComponent(parentGO, childPath, gohelper.Type_Image)
end

function gohelper.create2d(parentGO, name)
	return GameObjectHelper.Create(parentGO, name, true)
end

function gohelper.create3d(parentGO, name)
	return GameObjectHelper.Create(parentGO, name, false)
end

function gohelper.clone(sourceGO, parentGO, name)
	return GameObjectHelper.Clone(sourceGO, parentGO, name)
end

function gohelper.cloneInPlace(sourceGO, name)
	return GameObjectHelper.CloneInPlace(sourceGO, name)
end

function gohelper.findChildButtonWithAudio(go, childPath)
	return ButtonWrap.GetWithPath(go, childPath)
end

function gohelper.findChildButton(go, childPath)
	return ButtonWrap.GetWithPath(go, childPath)
end

function gohelper.findChildInputField(go, childPath)
	return InputFieldWrap.GetWithPath(go, childPath)
end

function gohelper.findChildScrollRect(go, childPath)
	return ScrollRectWrap.GetWithPath(go, childPath)
end

function gohelper.findChildSlider(go, childPath)
	return SliderWrap.GetWithPath(go, childPath)
end

function gohelper.findChildToggle(go, childPath)
	return ToggleWrap.GetWithPath(go, childPath)
end

function gohelper.findChildSingleImage(go, childPath)
	return SingleImage.GetWithPath(go, childPath)
end

function gohelper.getSingleImage(go)
	return SingleImage.Get(go)
end

function gohelper.findChildClick(go, childPath)
	return UIClickListener.GetWithPath(go, childPath)
end

function gohelper.getClick(go)
	return UIClickListener.Get(go)
end

return gohelper
