-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/aounity-framework/Scripts/Lua/frameworkext/scene/picker/ScenePickerBase.lua

module("frameworkext.scene.picker.ScenePickerBase", package.seeall)

local ScenePickerBase = class("ScenePickerBase", SceneComponentBase)

function ScenePickerBase:ctor()
	ScenePickerBase.super.ctor(self, scene)
end

return ScenePickerBase
