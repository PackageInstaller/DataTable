local PacGameMapController = class("PacGameMapController")

function PacGameMapController:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self._sceneMask = arg_1_1
	self._event = arg_1_2
	self._runningData = arg_1_3
	self._mapTF = findTF(self._sceneMask, "sceneContainer/scene/content/map")
	self._grids = {}
	self._gridDic = {}
	self._mapTFDic = {}

	for iter_1_0 = 0, self._mapTF.childCount - 1 do
		self._mapTFDic[iter_1_0 + 1] = self._mapTF:GetChild(iter_1_0)
	end

	return
end

function PacGameMapController:SetParent()
	return
end

function PacGameMapController:SetPosition()
	return
end

function PacGameMapController:SetScale()
	return
end

function PacGameMapController:SetGridIndex()
	return
end

function PacGameMapController:Prepare()
	self._mapData = self._runningData:GetMapData()
	self._activeScoreCount = 0
	self._ignoreScore = self._mapData.ignore_score

	self:prepareMap()

	return
end

function PacGameMapController:Start()
	self._player = self._runningData:GetPlayer()
	self._scoreCount = self._runningData:GetScoreCount()
	self._delayReflashScoreTime = nil
	self._roles = self._runningData:GetRoles()

	self:reflashGridScore()

	return
end

function PacGameMapController:Step(arg_8_1)
	self._deltaTime = arg_8_1

	self:udateScoreGrid()
	self:updateRoleLayer()
	self:updateReflashTime()

	return
end

function PacGameMapController:updateReflashTime()
	if self._delayReflashScoreTime and self._delayReflashScoreTime >= 0 then
		self._delayReflashScoreTime = self._delayReflashScoreTime - self._deltaTime

		if self._delayReflashScoreTime <= 0 then
			self._delayReflashScoreTime = nil

			self:reflashGridScore()
		end
	end

	return
end

function PacGameMapController:Clear()
	for iter_10_0 = 1, #self._grids do
		self._grids[iter_10_0]:Dispose()
	end

	self._roles = {}
	self._grids = {}
	self._gridDic = {}
	self._player = nil
	self._delayReflashScoreTime = nil
	self._scoreCount = 0

	return
end

function PacGameMapController:Stop()
	return
end

function PacGameMapController:Resume()
	return
end

function PacGameMapController:Dispose()
	self._roles = {}
	self._grids = {}
	self._gridDic = {}

	return
end

function PacGameMapController:prepareMap()
	self._mapTF.anchoredPosition = Vector2(-self._mapData.map_bound[1] / 2 + self._mapData.grid_width / 2 + self._mapData.offset[1], self._mapData.map_bound[2] / 2 - self._mapData.grid_height / 2 + self._mapData.offset[2])

	for iter_14_0 = 1, #self._mapData.grid_list do
		for iter_14_1 = 1, #self._mapData.grid_list[iter_14_0] do
			local var_14_2 = PacGameGrid.New(self._runningData:GetTplItemFromPool(PacGameConst.grid_data[(self._mapData.grid_list[iter_14_0][iter_14_1] == 0 or nil) and PacGameConst.default_grid].prefab, self._mapTFDic[iter_14_0]), self._mapData.horizontal * (iter_14_0 - 1) + iter_14_1, self._mapData.grid_list[iter_14_0][iter_14_1])

			var_14_2:SetPosition((Vector2((iter_14_1 - 1) * self._mapData.grid_width, -(iter_14_0 - 1) * self._mapData.grid_height)))
			var_14_2:SetActive(true)
			var_14_2:SetVH(iter_14_0, iter_14_1)
			table.insert(self._grids, var_14_2)

			self._gridDic[self._mapData.horizontal * (iter_14_0 - 1) + iter_14_1] = var_14_2
		end
	end

	self._runningData:SetGrids(self._grids, self._gridDic)
	self._runningData:SetMapTFDic(self._mapTFDic)

	return
end

function PacGameMapController:reflashGridScore()
	if self._runningData:GetEditor() then
		return
	end

	self._activeScoreCount = 0

	for iter_15_0 = 1, #self._grids do
		if self._grids[iter_15_0]:HasScore() then
			if not table.contains(self._ignoreScore, (self._grids[iter_15_0]:GetIndex())) then
				self._activeScoreCount = self._activeScoreCount + 1

				self._grids[iter_15_0]:SetScoreFlag(true)
			else
				self._grids[iter_15_0]:SetScoreFlag(false)
			end
		end
	end

	return
end

function PacGameMapController:udateScoreGrid()
	if self._activeScoreCount <= 0 and not self._delayReflashScoreTime then
		self._delayReflashScoreTime = 2
	end

	if self._delayCheckReflashCount == nil then
		self._delayCheckReflashCount = 10
	end

	if self._delayCheckReflashCount and not self._delayReflashScoreTime then
		self._delayCheckReflashCount = self._delayCheckReflashCount - self._deltaTime

		if self._delayCheckReflashCount <= 0 then
			self._delayCheckReflashCount = nil

			if self._gridDic then
				local var_16_0 = 0

				for iter_16_0, iter_16_1 in pairs(self._gridDic) do
					if iter_16_1 and iter_16_1:GetScoreFlag() then
						var_16_0 = var_16_0 + 1
					end
				end

				if var_16_0 == 0 then
					warning("吃完所有珠子，准备刷新")

					self._delayReflashScoreTime = 2
				end
			end
		end
	end

	local var_16_1 = self._gridDic[self._player:GetGridIndex()]

	if var_16_1 and var_16_1:GetScoreFlag() then
		var_16_1:SetScoreFlag(false)

		self._activeScoreCount = self._activeScoreCount - 1

		self._event(PacGameScene.GET_SCORE, var_16_1:GetScore(), nil)
	end

	return
end

function PacGameMapController:updateRoleLayer()
	for iter_17_0 = 1, #self._roles do
		local var_17_0 = self._gridDic[self._roles[iter_17_0]:GetGridIndexNext()]

		if var_17_0 then
			local var_17_1, var_17_2 = var_17_0:GetVH()

			if self._roles[iter_17_0]:GetParent() ~= self._mapTFDic[var_17_1] then
				self._roles[iter_17_0]:SetParent(self._mapTFDic[var_17_1])
			end
		end
	end

	return
end

return PacGameMapController
