-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/model/round/BattleRoundPlayStory.lua

module("logic.extensions.battle.model.round.BattleRoundPlayStory", package.seeall)

local BattleRoundPlayStory = class("BattleRoundPlayStory", BattleRoundBase)

function BattleRoundPlayStory:ctor()
	self.roundType = BattleRoundBase.RoundPlayStory
end

function BattleRoundPlayStory:start()
	BattleRoundPlayStory.super.start(self)

	if self.isResult then
		UnityEngine.Time.timeScale = 1
	end

	if TipsFacade.popupWindowSource == ViewName.Battle then
		ViewMgr.instance:close("popupwindow")
	end

	CommonTipsMgr.instance:closeOneView(ViewName.PetTips)
	GlobalDispatcher:addListener(GlobalNotify.EndStory, self._onStoryPlayFinished, self)
	GlobalDispatcher:dispatch(GlobalNotify.StartStory, self.storyId)
end

function BattleRoundPlayStory:finish()
	BattleRoundPlayStory.super.finish(self)
	GlobalDispatcher:removeListener(GlobalNotify.EndStory, self._onStoryPlayFinished, self)
end

function BattleRoundPlayStory:isDone()
	return self._isStoryPlayFinished and not StoryController.instance.isOpeningStoryview
end

function BattleRoundPlayStory:_onStoryPlayFinished(storyId)
	if self.storyId == storyId then
		self._isStoryPlayFinished = true
	end
end

return BattleRoundPlayStory
