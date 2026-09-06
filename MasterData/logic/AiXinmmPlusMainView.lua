-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/aixinmmplus/AiXinmmPlusMainView.lua

module("logic.extensions.timelimitedchallenge.view.aixinmmplus.AiXinmmPlusMainView", package.seeall)

local AiXinmmPlusMainView = class("AiXinmmPlusMainView", XiuMumMainView)

function AiXinmmPlusMainView:buildUI()
	AiXinmmPlusMainView.super.buildUI(self)

	self._btnIntroduce = self:getBtn("petInfo/btnIntroduce")
end

function AiXinmmPlusMainView:bindEvents()
	AiXinmmPlusMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnIntroduce, self._onClickIntroduce, self)
end

function AiXinmmPlusMainView:unbindEvents()
	AiXinmmPlusMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnIntroduce)
end

function AiXinmmPlusMainView:_getActivityId()
	return 239002
end

function AiXinmmPlusMainView:_onClickChallenge()
	UIStateManager.instance:push(ViewName.AiXinmmPlusLevelView)
end

function AiXinmmPlusMainView:_onClickIntroduce()
	local cfg = PetSkinConfig.instance:getPetSkinCfg(self._skinId)

	if cfg then
		PetbookController.instance:openPetinfoView(cfg.raceId)
	end
end

return AiXinmmPlusMainView
