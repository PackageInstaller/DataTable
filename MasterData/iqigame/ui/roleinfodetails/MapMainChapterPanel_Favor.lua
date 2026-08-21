-- chunkname: @IQIGame\\UI\\RoleInfoDetails\\MapMainChapterPanel_Favor.lua

local MapMainChapterPanel = require("IQIGame.UI.Map.MapChapterDetails.MapMainChapterPanel")
local m = class(nil, MapMainChapterPanel)

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:OnEnterGameBtnClick()
	local enterDupData = {}

	enterDupData.PassId = self.StageCfg.Id
	enterDupData.ChapterType = Constant.ChapterPassType.TYPE_Favor
	enterDupData.HeroID = self.StageCfg.HeroID

	GameChapterModule.EnterDupByChapterType(enterDupData)
end

function m:OnGmBtnClick()
	local CChatPOD = {}

	CChatPOD.channel = 3
	CChatPOD.type = 1
	CChatPOD.target = ""
	CChatPOD.content = string.format("/cmd finishFavorableStage %s %s %s", self.StageCfg.Type, self.StageCfg.Id, self.StageCfg.HeroID)

	net_centerChat.sendChat(CChatPOD)
	self:Hide()
end

return m
