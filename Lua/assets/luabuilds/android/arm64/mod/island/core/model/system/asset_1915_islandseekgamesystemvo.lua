local IslandSeekGameSystemVO = class("IslandSeekGameSystemVO", import(".IslandSystemVO"))

function IslandSeekGameSystemVO:Ctor(arg_1_1, arg_1_2)
	IslandSeekGameSystemVO.super.Ctor(self, arg_1_2)

	self.miniGameID = arg_1_1
	self.miniGameConfig = pg.island_minigame_template[self.miniGameID]

	return
end

function IslandSeekGameSystemVO:GetBehaviourTree()
	return self.miniGameConfig.bt
end

function IslandSeekGameSystemVO:GetResultUIName()
	return self.miniGameConfig.result_ui
end

function IslandSeekGameSystemVO:GetInteractiveObjects()
	local var_4_0 = {}

	for iter_4_0, iter_4_1 in ipairs(self.miniGameConfig.interactive_objects) do
		table.insert(var_4_0, iter_4_1)
	end

	return var_4_0
end

function IslandSeekGameSystemVO:GetType()
	return IslandConst.SYSTEM_TYPE_SEEKGAME
end

return IslandSeekGameSystemVO
