-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/answerscene/model/AnswerHelperMO.lua

module("logic.extensions.answerscene.model.AnswerHelperMO", package.seeall)

local AnswerHelperMO = class("AnswerHelperMO")

function AnswerHelperMO:ctor()
	self.iconPath = nil
	self.helperName = nil
	self.helperDesc = nil
	self.helpeTimes = 0
	self.helpType = 0
end

return AnswerHelperMO
