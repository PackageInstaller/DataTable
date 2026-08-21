-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Debug\\Modules\\DebugAutoTest.lua

local AutoModule = require("Debug/AutoTest/AutoTestModule")
local DebugConst = require("Debug/DebugConst")
local AutoRecordClick = AutoRecordClick
local DebugModule = {}

DebugModule.ENTRY_NAME = "自动化测试"

function DebugModule.initAutoRecord()
	AutoModule.init()
	AutoRecordClick.init()
	MsgManager.notice("自动化录屏初始化成功")
end

function DebugModule.startAutoRecord()
	if not AutoRecordClick.isInit then
		MsgManager.notice("请在游戏启动后登录游戏之前先开启录屏功能")

		return
	end

	AutoRecordClick.open()
	MsgManager.notice("开始录屏")
end

function DebugModule.stopAutoRecord()
	AutoRecordClick.stop()
	MsgManager.notice("结束录屏")
end

DebugModule.FUNC_MENU = {
	{
		name = "打开自动录屏功能",
		typ = DebugConst.BTN_TYPE_BUTTON,
		func = DebugModule.initAutoRecord
	},
	{
		name = "开始录屏",
		typ = DebugConst.BTN_TYPE_BUTTON,
		func = DebugModule.startAutoRecord
	},
	{
		name = "停止录屏",
		typ = DebugConst.BTN_TYPE_BUTTON,
		func = DebugModule.stopAutoRecord
	}
}

return DebugModule
