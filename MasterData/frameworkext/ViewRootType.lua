-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/aounity-framework/Scripts/Lua/frameworkext/lmvc/view/ViewRootType.lua

module("frameworkext.lmvc.view.ViewRootType", package.seeall)

local ViewRootType = class("ViewRootType")

ViewRootType.Hud = 1
ViewRootType.HudTop = 2
ViewRootType.FullScreen = 3
ViewRootType.Popup = 4
ViewRootType.PopupTop = 5
ViewRootType.Notify = 6
ViewRootType.NotifyTop = 7
ViewRootType.Top = 8
ViewRootType.TopMost = 9

return ViewRootType
