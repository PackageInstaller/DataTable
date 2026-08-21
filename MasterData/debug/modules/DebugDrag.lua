-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Debug\\Modules\\DebugDrag.lua

local UIUtils = require("Framework.UI.UIUtils")
local ResScene = require("ClientData/ResScene")
local DebugConst = require("Debug/DebugConst")
local DebugModule = {}
local TEST_BATTLE_SCENE = 10001

DebugModule.ENTRY_NAME = "拖拽测试"

local CameraManager = Framework.CameraSystem.CameraManager
local GameObject = UnityEngine.GameObject

local function abc(...)
	local sceneData = ResScene[TEST_BATTLE_SCENE]
	local gridAngle = sceneData.dir or 0
	local centerPointGo = GameObject("CenterPoint")
	local centerPoint = sceneData.origin_point

	centerPoint = Vector3(centerPoint[1], centerPoint[2], centerPoint[3])
	centerPointGo.transform.position = centerPoint + Vector3(0, 0, 0)

	CameraModeManager.setBattleMode()
	CameraManager.SetTarget(centerPointGo, true, 0)
	CameraManager.SetCameraRotation(1, 0.1, 42, gridAngle + 180, 0, 23)
	CameraManager.CameraGrp:SetFov(25, 0)
	UIManager.getUI("login", false)
end

function DebugModule.stepA(sender, menu, value)
	SceneManager.loadScene(TEST_BATTLE_SCENE, abc)
end

function DebugModule.stepB(sender, menu, value)
	local a = UIManager.getUI("battleDragHeroDlg", true)
end

function DebugModule.stepC(sender, menu, value)
	return
end

function DebugModule.stepD(sender, menu, value)
	return
end

DebugModule.FUNC_MENU = {
	{
		name = "加载场景",
		typ = DebugConst.BTN_TYPE_BUTTON,
		func = DebugModule.stepA
	},
	{
		name = "加载物件1",
		typ = DebugConst.BTN_TYPE_BUTTON,
		func = DebugModule.stepB
	}
}

return DebugModule
