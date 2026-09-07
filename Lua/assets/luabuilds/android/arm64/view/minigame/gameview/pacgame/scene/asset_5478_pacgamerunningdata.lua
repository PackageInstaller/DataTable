local PacGameRunningData = class("PacGameRunningData")

function PacGameRunningData:Ctor()
	self._tpl = nil
	self._tplItemPool = {}
	self._roles = {}

	return
end

function PacGameRunningData:SetChapterData(arg_2_1)
	self._chapterData = arg_2_1

	return
end

function PacGameRunningData:GetConfig(arg_3_1)
	return self._chapterData[arg_3_1]
end

function PacGameRunningData:GetMapConfig(arg_4_1)
	return self._mapData[arg_4_1]
end

function PacGameRunningData:GetMapData()
	if not self._mapData and self._chapterData then
		self._mapData = PacGameConst.map_data[self._chapterData.map]
	end

	return self._mapData
end

function PacGameRunningData:GetGridRect()
	return self._mapData.grid_width, self._mapData.grid_height
end

function PacGameRunningData:GetGridWH()
	return self._mapData.vertical, self._mapData.horizontal
end

function PacGameRunningData:SetEditor(arg_8_1)
	self._editorFlag = arg_8_1

	return
end

function PacGameRunningData:GetEditor()
	return self._editorFlag
end

function PacGameRunningData:SetGrids(arg_10_1, arg_10_2)
	self._grids = arg_10_1
	self._gridDic = {}
	self._gridDic = arg_10_2

	return
end

function PacGameRunningData:GetGrids()
	return self._grids
end

function PacGameRunningData:GetGridDic()
	return self._gridDic
end

function PacGameRunningData:SetPlayer(arg_13_1)
	self._player = arg_13_1

	table.insert(self._roles, arg_13_1)

	return
end

function PacGameRunningData:GetPlayer()
	return self._player
end

function PacGameRunningData:SetEnemys(arg_15_1)
	self._enemys = arg_15_1

	for iter_15_0, iter_15_1 in ipairs(arg_15_1) do
		table.insert(self._roles, iter_15_1)
	end

	return
end

function PacGameRunningData:SetMapTFDic(arg_16_1)
	self._mapTFDic = arg_16_1

	return
end

function PacGameRunningData:GetMapTFDic()
	return self._mapTFDic
end

function PacGameRunningData:GetEnemys()
	return self._enemys
end

function PacGameRunningData:GetPlayerStartIndex()
	return self._mapData.player_start
end

function PacGameRunningData:GetRoles()
	return self._roles
end

function PacGameRunningData:GetPosByIndex(arg_21_1)
	if not self._gridDic then
		return Vector2(0, 0)
	end

	return self._gridDic[arg_21_1]:GetPosition()
end

function PacGameRunningData:SetJoyData(arg_22_1)
	self._joyData = arg_22_1

	return
end

function PacGameRunningData:GetJoyData()
	return self._joyData
end

function PacGameRunningData:GetScoreCount()
	if self._scoreCount and self._scoreCount > 0 then
		return self._scoreCount
	end

	self._scoreCount = 0

	if self._gridDic then
		for iter_24_0, iter_24_1 in pairs(self._gridDic) do
			if iter_24_1:HasScore() then
				self._scoreCount = self._scoreCount + 1
			end
		end
	end

	return self._scoreCount
end

function PacGameRunningData:getDirectGrid(arg_25_1, arg_25_2)
	if (arg_25_1 - 1) % self._mapData.horizontal == 0 and arg_25_2.x == -1 then
		return nil
	elseif (arg_25_1 - 1) % self._mapData.horizontal == self._mapData.horizontal - 1 and arg_25_2.x == 1 then
		return nil
	elseif arg_25_1 - 1 < self._mapData.horizontal and arg_25_2.y == 1 then
		return nil
	elseif arg_25_1 - 1 >= self._mapData.horizontal * (self._mapData.vertical - 1) and arg_25_2.y == -1 then
		return nil
	end

	local var_25_0

	if arg_25_2.x ~= 0 then
		var_25_0 = arg_25_1 + arg_25_2.x
	elseif arg_25_2.y ~= 0 then
		var_25_0 = arg_25_1 + -arg_25_2.y * self._mapData.horizontal
	end

	if var_25_0 then
		if self._gridDic[var_25_0] and self._gridDic[var_25_0]:GetPassAble() then
			return self._gridDic[var_25_0]
		end
	end

	return nil
end

function PacGameRunningData:GetNearGridIndex(arg_26_1)
	local var_26_0 = {}
	local var_26_1 = self:getDirectGrid(arg_26_1, Vector2(-1, 0))
	local var_26_2 = self:getDirectGrid(arg_26_1, Vector2(1, 0))
	local var_26_3 = self:getDirectGrid(arg_26_1, Vector2(0, 1))
	local var_26_4 = self:getDirectGrid(arg_26_1, Vector2(0, -1))

	if var_26_1 then
		table.insert(var_26_0, var_26_1:GetIndex())
	end

	if var_26_2 then
		table.insert(var_26_0, var_26_2:GetIndex())
	end

	if var_26_3 then
		table.insert(var_26_0, var_26_3:GetIndex())
	end

	if var_26_4 then
		table.insert(var_26_0, var_26_4:GetIndex())
	end

	return var_26_0
end

function PacGameRunningData:SetTpl(arg_27_1)
	self._tpl = arg_27_1

	return
end

function PacGameRunningData:GetTplItemFromPool(arg_28_1, arg_28_2)
	if not arg_28_1 or arg_28_1 == "" then
		return nil
	end

	if not arg_28_2 then
		return nil
	end

	if self._tplItemPool[arg_28_1] == nil then
		self._tplItemPool[arg_28_1] = {}
	end

	if #self._tplItemPool[arg_28_1] == 0 then
		local var_28_0 = tf(instantiate(findTF(self._tpl, arg_28_1)))

		setParent(var_28_0, arg_28_2)

		return var_28_0, true
	else
		return table.remove(self._tplItemPool[arg_28_1], #self._tplItemPool[arg_28_1]), false
	end

	return nil, nil
end

function PacGameRunningData:Clear()
	self._chapterData = nil
	self._mapData = nil
	self._player = nil
	self._enemys = nil
	self._scoreCount = 0
	self._roles = {}

	return
end

function PacGameRunningData:Dispose()
	self._tpl = nil
	self._tplItemPool = {}
	self._chapterData = nil
	self._mapData = nil
	self._scoreCount = 0
	self._gridDic = {}
	self._grids = {}

	return
end

return PacGameRunningData
