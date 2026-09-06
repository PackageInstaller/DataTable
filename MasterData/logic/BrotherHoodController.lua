-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/brotherhood/controller/BrotherHoodController.lua

module("logic.extensions.brotherhood.controller.BrotherHoodController", package.seeall)

local BrotherHoodController = class("BrotherHoodController", BaseController)

BrotherHoodController.BeginDrag = "brotherhood_begindrag"
BrotherHoodController.Drag = "brotherhoodbegin_drag"
BrotherHoodController.EndDrag = "brotherhood_enddrag"
BrotherHoodController.Drop = "brotherhood_drop"

function BrotherHoodController:ctor()
	return
end

function BrotherHoodController:onInit()
	return
end

BrotherHoodController.instance = BrotherHoodController.New()

return BrotherHoodController
