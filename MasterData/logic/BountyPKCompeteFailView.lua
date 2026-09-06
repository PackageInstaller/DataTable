-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bountypkcompete/view/BountyPKCompeteFailView.lua

module("logic.extensions.bountypkcompete.view.BountyPKCompeteFailView", package.seeall)

local BountyPKCompeteFailView = class("BountyPKCompeteFailView", ViewComponent)

function BountyPKCompeteFailView:ctor()
	BountyPKCompeteFailView.super.ctor(self)
end

function BountyPKCompeteFailView:unbindEvents()
	BountyPKCompeteFailView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function BountyPKCompeteFailView:bindEvents()
	BountyPKCompeteFailView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function BountyPKCompeteFailView:buildUI()
	BountyPKCompeteFailView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._reward = self:getGo("bottom/reward")
	self._txtChangeBounty = self:getTxt("bottom/bounty1/txtNum")
	self._txtBounty = self:getTxt("bottom/bounty2/txtNum")
end

function BountyPKCompeteFailView:onExit()
	BountyPKCompeteFailView.super.onExit(self)
	self:_closeBattle()
	MaterialMgr.resetAll(self._reward)
end

function BountyPKCompeteFailView:onEnter()
	BountyPKCompeteFailView.super.onEnter(self)

	local phaseModel = BountyPKCompeteModel.instance:getPhaseModel()

	self._txtChangeBounty.text = langPara("bountypk__14", phaseModel:getChangeScoreStr())
	self._txtBounty.text = langPara("bountypk__15", phaseModel.newScore)

	local changeSetId = phaseModel.changeSetId

	if changeSetId then
		local var_6_0 = MaterialFacade.instance:getItemsByChangeSetId(changeSetId)

		if not var_6_0 then
			var_6_0 = MaterialController.instance:getTempItemsByChangeSetId(changeSetId)

			local items = var_6_0
			local itemStrArray = {}

			if items then
				for i, v in ipairs(items) do
					table.insert(itemStrArray, MaterialMgr.createSerName(v.materialType, v.id, v.num))
				end

				MaterialMgr.setCellListByCfg(table.concat(itemStrArray, "#"), self._reward)
			end
		end
	end
end

function BountyPKCompeteFailView:_closeBattle()
	BountyPKCompeteController.instance:endFight()
end

return BountyPKCompeteFailView
