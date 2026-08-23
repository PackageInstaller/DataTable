local NewSlgBuildingPool = class("NewSlgBuildingPool")
local NewSlgBattleNode = require("app.view.module.slg.view.cocosNode.NewSlgBattleNode")

function NewSlgBuildingPool:ctor()
	self._unUsePool = {}
	self._usePool = {}
end

function NewSlgBuildingPool.funcName()
	return
end

return NewSlgBuildingPool
