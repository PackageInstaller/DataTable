-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/answerscene/config/AnswerSceneConfig.lua

module("logic.extensions.answerscene.controller.AnswerSceneConfig", package.seeall)

local AnswerSceneConfig = class("AnswerSceneConfig", BaseConfig)

function AnswerSceneConfig:onInit()
	return
end

function AnswerSceneConfig:getNames()
	return {
		"scene_answer_question",
		"scene_answer_open_time",
		"scene_answer_common",
		"scene_answer_seek_help",
		"scene_answer_combo"
	}
end

function AnswerSceneConfig:handleConfig(name, content)
	if name == "scene_answer_question" then
		self._answerQuestion = content
	elseif name == "scene_answer_open_time" then
		self._answerOpenTime = content
		self._answerOpenTimeDataList = content.dataList
	elseif name == "scene_answer_common" then
		self._answerCommon = content
	elseif name == "scene_answer_seek_help" then
		self._answerHelper = content
	elseif name == "scene_answer_combo" then
		self._answerCombo = content
	end
end

function AnswerSceneConfig:getQuestionCo(id)
	return self._answerQuestion[id]
end

function AnswerSceneConfig:getAllQuestions()
	return self._answerQuestion.dataList
end

function AnswerSceneConfig:getOpenTimeCo(seasonID)
	return self._answerOpenTime[seasonID]
end

function AnswerSceneConfig:getOpenTimeCoDataList()
	return self._answerOpenTimeDataList
end

function AnswerSceneConfig:getParamsValue(key)
	if self._answerCommon and self._answerCommon[key] then
		return self._answerCommon[key].value
	end
end

function AnswerSceneConfig:getParamsInt(key)
	return checknumber(self:getParamsValue(key))
end

function AnswerSceneConfig:getAllHelpCos()
	return self._answerHelper.dataList
end

function AnswerSceneConfig:getHelpCo(helpType)
	return self._answerHelper[helpType]
end

function AnswerSceneConfig:getComboScores(combo)
	if combo == 0 then
		return 0
	end

	local comboCo = self._answerCombo[combo]

	if comboCo then
		return comboCo.score
	end

	return self._answerCombo.dataList[#self._answerCombo.dataList].score
end

AnswerSceneConfig.instance = AnswerSceneConfig.New()

return AnswerSceneConfig
