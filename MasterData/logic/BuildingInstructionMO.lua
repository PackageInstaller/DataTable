-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zoo/model/BuildingInstructionMO.lua

module("logic.extensions.petzoo.model.BuildingInstructionMO", package.seeall)

local BuildingInstructionMO = class("BuildingInstructionMO")

function BuildingInstructionMO:ctor()
	self.level = 0
	self.instruction = nil
end

return BuildingInstructionMO
