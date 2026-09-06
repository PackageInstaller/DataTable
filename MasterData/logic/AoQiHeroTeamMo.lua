-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqihero/model/battleMo/AoQiHeroTeamMo.lua

module("logic.extensions.aoqihero.model.battleMo.AoQiHeroTeamMo", package.seeall)

local AoQiHeroTeamMo = class("AoQiHeroTeamMo")

function AoQiHeroTeamMo:ctor()
	self.teamId = 0
	self.actionPet = {}
	self.pos = {}
end

function AoQiHeroTeamMo:initData()
	self.actionPet = {}
	self.pos = {}
end

function AoQiHeroTeamMo:getSurvalPetNum()
	local num = 0

	for i, v in pairs(self.pos) do
		if AoQiHeroEntityMgr.instance:isPetSurvival(i) == true then
			num = num + 1
		end
	end

	return num
end

return AoQiHeroTeamMo
