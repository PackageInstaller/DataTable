require("data.constants")
require("data.language_constants")
require("data.editor_constants")
require("controller.global_func")
require("controller.helper")
require("view.Armature.L2Skeleton")

SpineCacheManager = require("controller.spinecache_manager")
TextureManager = require("controller.texture_manager")
RoleDefault = require("controller.RoleDefault")
global_basic_scene = nil

local TalkEditorScene = class("TalkEditorScene", function()
	return cc.Scene:create()
end)

function TalkEditorScene:create()
	local var_2_0 = TalkEditorScene.new()

	global_basic_scene = var_2_0

	var_2_0:init()

	return var_2_0
end

function TalkEditorScene:init()
	cc.FileUtils:getInstance():addSearchPath("activity_all_rounder")

	if config._DEBUG == true then
		require("view.Layer.TalkEditor.TalkEditor")
		global_basic_scene:addChild(TalkEditor:create())
	else
		print("需要在debug模式下启动")
	end
end

function TalkEditorScene:initKeyEvent()
	KeyCodeManager:initWithScene(self)
	KeyCodeManager:setLock(true)
end

return TalkEditorScene
