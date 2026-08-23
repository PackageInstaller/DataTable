local ExplorationPlayerStruct = class("ExplorationPlayerStruct")

function ExplorationPlayerStruct:ctor()
	self._score = 0
	self._formationList = {}
	self._poolTab = {}
end

function ExplorationPlayerStruct:getBattleFormation()
	return self._formationList[1]
end

function ExplorationPlayerStruct:get()
	return self._formationList[1]
end

return ExplorationPlayerStruct
