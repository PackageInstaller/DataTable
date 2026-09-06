-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bigorange/config/BigOrangeConfig.lua

module("logic.extensions.bigorange.config.BigOrangeConfig", package.seeall)

local BigOrangeConfig = class("BigOrangeConfig", BaseConfig)

BigOrangeConfig.SAVEFLAG = "BIGORANGE"

function BigOrangeConfig:onInit()
	BigOrangeConfig.super.onInit(self)
end

function BigOrangeConfig:getNames()
	return {
		"bigOrange_notice",
		"bigOrange_answer",
		"bigOrange_type",
		"bigOrange_dialog"
	}
end

function BigOrangeConfig:handleConfig(name, content)
	if name == "bigOrange_notice" then
		self._notice = content
	elseif name == "bigOrange_answer" then
		self._answer = content
	elseif name == "bigOrange_type" then
		self._type = content
	elseif name == "bigOrange_dialog" then
		self._dialog = content
	end
end

function BigOrangeConfig:getNoticeById(id)
	return self._notice[id]
end

function BigOrangeConfig:getNotice()
	return self._notice
end

function BigOrangeConfig:getAnswerById(id)
	return self._answer[id]
end

function BigOrangeConfig:getAnswer()
	return self._answer
end

function BigOrangeConfig:getTypeById(id)
	return self._type[id]
end

function BigOrangeConfig:getType()
	return self._type
end

function BigOrangeConfig:getDialog()
	return self._dialog
end

BigOrangeConfig.instance = BigOrangeConfig.New()

return BigOrangeConfig
