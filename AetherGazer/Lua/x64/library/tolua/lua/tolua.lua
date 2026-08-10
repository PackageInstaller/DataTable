if jit then
	jit.off()
	jit.flush()

	if jit.opt then
		-- block empty
	end

	print("jit", jit.status())
	print(string.format("os: %s, arch: %s", jit.os, jit.arch))
end

require("library.ToLua.Lua.misc.functions")

Mathf = require("library.ToLua.Lua.UnityEngine.Mathf")
Vector3 = require("library.ToLua.Lua.UnityEngine.Vector3")
Quaternion = require("library.ToLua.Lua.UnityEngine.Quaternion")
Vector2 = require("library.ToLua.Lua.UnityEngine.Vector2")
Vector4 = require("library.ToLua.Lua.UnityEngine.Vector4")
Color = require("library.ToLua.Lua.UnityEngine.Color")
Ray = require("library.ToLua.Lua.UnityEngine.Ray")
Bounds = require("library.ToLua.Lua.UnityEngine.Bounds")
RaycastHit = require("library.ToLua.Lua.UnityEngine.RaycastHit")
Touch = require("library.ToLua.Lua.UnityEngine.Touch")
LayerMask = require("library.ToLua.Lua.UnityEngine.LayerMask")
Plane = require("library.ToLua.Lua.UnityEngine.Plane")
Time = reimport("library.ToLua.Lua.UnityEngine.Time")
list = require("library.ToLua.Lua.list")
utf8 = require("library.ToLua.Lua.misc.utf8")

require("library.ToLua.Lua.protobuf.containers")
require("library.ToLua.Lua.protobuf.wire_format")
require("library.ToLua.Lua.protobuf.encoder")
require("library.ToLua.Lua.protobuf.decoder")
require("library.ToLua.Lua.protobuf.descriptor")
require("library.ToLua.Lua.protobuf.listener")
require("library.ToLua.Lua.protobuf.text_format")
require("library.ToLua.Lua.protobuf.type_checkers")
require("library.ToLua.Lua.protobuf.protobuf")
require("library.ToLua.Lua.event")
require("library.ToLua.Lua.typeof")
require("library.ToLua.Lua.slot")
require("library.ToLua.Lua.System.Timer")
require("library.ToLua.Lua.System.coroutine")
require("library.ToLua.Lua.System.ValueType")
require("library.ToLua.Lua.System.Reflection.BindingFlags")

Object = UnityEngine.Object
GameObject = UnityEngine.GameObject
Resources = UnityEngine.Resources
Image = UnityEngine.UI.Image
Text = UnityEngine.UI.Text
Button = UnityEngine.UI.Button
PlayerPrefs = UnityEngine.PlayerPrefs
LayoutElement = UnityEngine.LayoutElement
Slider = UnityEngine.UI.Slider
CanvasGroup = UnityEngine.CanvasGroup
Canvas = UnityEngine.Canvas
Toggle = UnityEngine.UI.Toggle
Toggle.ToggleEvent = UnityEngine.UI.Toggle.ToggleEvent
ContentSizeFitter = UnityEngine.UI.ContentSizeFitter
GuideHighlightMask = UnityEngine.UI.GuideHighlightMask
LayoutRebuilder = UnityEngine.UI.LayoutRebuilder
LayoutUtility = UnityEngine.UI.LayoutUtility
Input = UnityEngine.Input
KeyCode = UnityEngine.KeyCode
Application = UnityEngine.Application
RuntimePlatform = UnityEngine.RuntimePlatform
SystemLanguage = UnityEngine.SystemLanguage
Screen = UnityEngine.Screen
Physics = UnityEngine.Physics
Physics2D = UnityEngine.Physics2D
BoxCollider = UnityEngine.BoxCollider
BoxCollider2D = UnityEngine.BoxCollider2D
SphereCollider = UnityEngine.SphereCollider
SpriteRenderer = UnityEngine.SpriteRenderer
Space = UnityEngine.Space
RaycastHit = UnityEngine.RaycastHit
Debug = CustomLog
TextAsset = UnityEngine.TextAsset
Animation = UnityEngine.Animation
MeshRenderer = UnityEngine.MeshRenderer
PrimitiveType = UnityEngine.PrimitiveType
RenderSettings = UnityEngine.RenderSettings
Material = UnityEngine.Material
SocketError = System.Net.Sockets.SocketError
RuntimeAnimationController = UnityEngine.RuntimeAnimationController
AnimationClip = UnityEngine.AnimationClip
RectTransform = UnityEngine.RectTransform
Transform = UnityEngine.Transform
DropDown = UnityEngine.UI.DropDown
OptionData = UnityEngine.UI.Dropdown.OptionData
OptionDataList = UnityEngine.UI.Dropdown.OptionDataList
ScrollRect = UnityEngine.UI.ScrollRect
ScrollRectEx = UnityEngine.UI.ScrollRectEx
ScrollBar = UnityEngine.UI.ScrollBar
RawImage = UnityEngine.UI.RawImage
ToggleGroup = UnityEngine.UI.ToggleGroup
Mask = UnityEngine.UI.Mask
ContentSizeFitter = UnityEngine.UI.ContentSizeFitter
RichText = UnityEngine.UI.RichText
InputField = UnityEngine.UI.InputField
PlayableDirector = UnityEngine.Playables.PlayableDirector
Animator = UnityEngine.Animator
SceneManager = UnityEngine.SceneManagement.SceneManager
Physics2DRaycaster = UnityEngine.EventSystems.Physics2DRaycaster
PhysicsRaycaster = UnityEngine.EventSystems.PhysicsRaycaster
CinemachineBrain = Cinemachine.CinemachineBrain
math.randomseed_ = math.randomseed
math.random_ = math.random

local var_0_0

function math.randomseed(arg_1_0)
	var_0_0 = RandomUtil.GenRandom(arg_1_0)
end

math.randomseed(os.time())

function math.random(arg_2_0, arg_2_1)
	local var_2_0

	if arg_2_0 == nil and arg_2_1 == nil then
		var_2_0 = var_0_0:NextDouble()
	elseif arg_2_1 == nil then
		var_2_0 = 1 + var_0_0:NextInt(arg_2_0)
	else
		var_2_0 = arg_2_0 + var_0_0:NextInt(arg_2_1 - arg_2_0 + 1)
	end

	if MathRandomFlag == true then
		local var_2_1 = debug.getinfo(2, "nfS")

		print("<color=#ff0000>游戏帧请使用BattleMath.Random()产生随机数</color>" .. " source:" .. var_2_1.source)
	end

	return var_2_0
end
