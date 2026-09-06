-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/boccacciochapter/view/BoccaccioChapterTwoStageFmtExView.lua

module("logic.extensions.boccacciochapter.view.BoccaccioChapterTwoStageFmtExView", package.seeall)

local BoccaccioChapterTwoStageFmtExView = class("BoccaccioChapterTwoStageFmtExView", ViewComponent)

function BoccaccioChapterTwoStageFmtExView:ctor()
	BoccaccioChapterTwoStageFmtExView.super.ctor(self)
end

function BoccaccioChapterTwoStageFmtExView:buildUI()
	BoccaccioChapterTwoStageFmtExView.super.buildUI(self)

	self._tagView = self:getGo("tagView")
	self._tagCell = self:getGo("tagCell")

	GameUtil.SetActive(self._tagCell, false)
end

function BoccaccioChapterTwoStageFmtExView:bindEvents()
	BoccaccioChapterTwoStageFmtExView.super.bindEvents(self)
end

function BoccaccioChapterTwoStageFmtExView:unbindEvents()
	BoccaccioChapterTwoStageFmtExView.super.unbindEvents(self)
end

function BoccaccioChapterTwoStageFmtExView:onEnter()
	BoccaccioChapterTwoStageFmtExView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._fmtMo = params[1]
	self._activityId = self._fmtMo:getActivityId()
	self._stageId = self._fmtMo:getStageId()
	self._chapterId = self._fmtMo:getChapterId()
	self._storyId = self._fmtMo:getStoryId()
	self._subMo = BoccaccioChapterController.instance:getSubMo(self._activityId)

	self:_onUpdate()
end

function BoccaccioChapterTwoStageFmtExView:onExit()
	BoccaccioChapterTwoStageFmtExView.super.onExit(self)
end

function BoccaccioChapterTwoStageFmtExView:_onUpdate()
	local wordList = {}
	local stageData = BoccaccioChapterConfig.instance:getChapter2StageData(self._activityId, self._stageId)

	if not stageData.positionWord then
		for posId = 1, 9 do
			wordList[posId] = stageData.positionWord[posId] or 0
		end

		local dataLength = #wordList
		local childCount = self._tagView.transform.childCount

		for index = 1, dataLength do
			local mainGo = index <= childCount and self._tagView.transform:GetChild(index - 1).gameObject or goutil.cloneAndSetParent(self._tagCell, self._tagView.transform, self._tagCell.name .. "_" .. index)
		end

		self._tagView:GetComponent(ComponentType.TestRecordPos):LoadPlan(0)

		local childCount = self._tagView.transform.childCount

		for index = 1, Mathf.Max(childCount, dataLength) do
			local mainGo = self._tagView.transform:GetChild(index - 1).gameObject

			if index <= dataLength then
				local wordId = checknumber(wordList[index])

				if wordId > 0 then
					GameUtil.SetActive(mainGo, true)

					local data = BoccaccioChapterConfig.instance:getChapter2WordData(self._activityId, wordId)
					local txtContent = goutil.findChildTextComponent(mainGo, "txtContent")

					txtContent.text = data.content
				else
					GameUtil.SetActive(mainGo, false)
				end
			else
				GameUtil.SetActive(mainGo, false)
			end
		end
	end
end

return BoccaccioChapterTwoStageFmtExView
