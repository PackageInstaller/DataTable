NetBuffer = BaseUtil.NetBuffer
BaseUtil.NetBuffer = nil
CallResultType = BaseUtil.CallResultType
BaseUtil.CallResultType = nil
NetToken = BaseUtil.NetToken
BaseUtil.NetToken = nil
NetTokenType = BaseUtil.NetTokenType
BaseUtil.NetTokenType = nil
NetAddrInfo = BaseUtil.NetAddrInfo
BaseUtil.NetAddrInfo = nil
NetworkProtocol = BaseUtil.NetworkProtocol
BaseUtil.NetworkProtocol = nil
NetCallCenter = BaseUtil.NetCallCenter
BaseUtil.NetCallCenter = nil
NetMessage = BaseUtil.NetMessage
BaseUtil.NetMessage = nil
NetState = BaseUtil.NetState
BaseUtil.NetState = nil
require("const")
require("switch")
require("log_helper")
require("debug_helper")
require("string_helper")
require("table_helper")
require("vector3")
require("object")
require("singleton")
require("conf")
require("cache")
require("loader")
require("app")
require("game_helper")
require("task_manager")
require("resource_manager")
require("async_request_res")
require("net_message_factory")
require("message_def")
require("basic_message")
require("caller")
require("caller_default")
require("game_module")
require("login_base_module")
require("game_event_listener")
require("ui_module")
require("ui_controller")
require("ui_custom_widget")
require("popup_message_box")
require("luadc_helper")
require("custom_nodes_lookup")
require("sys_tool")
require("pre_require")
require("time_helper")
require("component_base")
requireall(nil)
GameGlobal:GetInstance():Init()
LuaDcHelper.Init()
if HelperProxy:GetInstance():IsDebug() and EDITOR then
  package.cpath = package.cpath .. ";c:/Users/Administrator/.vscode/extensions/tangzx.emmylua-0.5.14/debugger/emmy/windows/x64/?.dll"
  local dbg = require("emmy_core")
  dbg.tcpListen("localhost", 9966)
end
