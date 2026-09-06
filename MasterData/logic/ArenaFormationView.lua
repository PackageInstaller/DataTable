-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/arena/view/ArenaFormationView.lua

module("logic.extensions.arena.view.ArenaFormationView", package.seeall)

local ArenaFormationView = class("ArenaFormationView", FormationView)

function ArenaFormationView:onEnter()
	FormationNewModel.instance:SetCurTeamId(FormationNewModel.arenaTeamId)
	ArenaFormationView.super.onEnter(self)
end

function ArenaFormationView:buildUI()
	ArenaFormationView.super.buildUI(self)
	goutil.setActive(self._btnShare.gameObject, false)
	self._btnSingleLine:Layout()
end

function ArenaFormationView:onExit()
	ArenaFormationView.super.onExit(self)

	local param = self:getOpenParam()
	local oriTeamId = param[1]

	FormationNewModel.instance:SetCurTeamId(oriTeamId)
end

function ArenaFormationView:_onClickRecFormation()
	local param = self:getOpenParam()

	function FuncOpenController.instance.onRecomentSelCallback(fightCreepsCfgs)
		FormationNewModel.instance:SetCurTeamId(FormationNewModel.arenaTeamId)
		FastFormation.instance:clean()

		for i = 1, #fightCreepsCfgs do
			local raceId = fightCreepsCfgs[i].raceId
			local petId = BagModel.instance:getPetIdByRaceId(raceId)

			if petId ~= nil then
				local posId = fightCreepsCfgs[i].posId

				FormationController.instance:ChangePosition(posId, petId)
			end
		end
	end

	UIStateManager.instance:push(ViewName.PetNoticeView, 5)
end

return ArenaFormationView
