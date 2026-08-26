-- chunkname: @framework/mvc/view/ViewEvent.lua

module("framework.mvc.view.ViewEvent", package.seeall)

local ViewEvent = {}

ViewEvent.OnOpenView = 1
ViewEvent.OnOpenViewFinish = 2
ViewEvent.OnCloseView = 3
ViewEvent.OnCloseViewFinish = 4
ViewEvent.OnOpenModalView = 5
ViewEvent.OnOpenModalViewFinish = 6
ViewEvent.OnCloseModalView = 7
ViewEvent.OnCloseModalViewFinish = 8
ViewEvent.OnOpenFullView = 9
ViewEvent.OnOpenFullViewFinish = 10
ViewEvent.OnCloseFullView = 11
ViewEvent.OnCloseFullViewFinish = 12
ViewEvent.ReOpenWhileOpen = 13
ViewEvent.BeforeOpenView = 14
ViewEvent.DestroyViewFinish = 15
ViewEvent.DestroyFullViewFinish = 16
ViewEvent.DestroyModalViewFinish = 17
ViewEvent.ToSwitchTab = "ToSwitchTab"
ViewEvent.BeforeOpenTabView = 100

return ViewEvent
