-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Common\\BattleMiscConfig.lua

local BattleMiscConfig = {}

BattleMiscConfig.BATTLE_MODIFY_VERSION = 189
BattleMiscConfig.BATTLE_MISS_CD_FRAME = 5
BattleMiscConfig.SHIELD_MAX = 30000000
BattleMiscConfig.SYNC_REPLAY_TIME_SPEED = 1.55
BattleMiscConfig.BATTLE_LEVEL_DEF_LIMIT = {
	{
		100,
		0.45
	},
	{
		150,
		0.4
	},
	{
		200,
		0.3
	},
	{
		999,
		0.22
	}
}

function BattleMiscConfig.GetLevelDefLimit(level)
	for _, limitInfo in ipairs(BattleMiscConfig.BATTLE_LEVEL_DEF_LIMIT) do
		if level and level <= limitInfo[1] then
			return limitInfo[2]
		end
	end

	return 1
end

BattleMiscConfig.NORMAL_POS_CONFIG = {
	LineConfig = {
		{
			7,
			4,
			1,
			-1,
			-4,
			-7
		},
		{
			8,
			5,
			2,
			0,
			-2,
			-5,
			-8
		},
		{
			9,
			6,
			3,
			-3,
			-6,
			-9
		}
	},
	DEFAULT_CHUYIN_POS = {
		1,
		3.5
	},
	DEFAULT_PET_ANIM_POS = {
		0,
		0
	}
}
BattleMiscConfig.SPE_BOSS_POS_CONFIG = {
	GridType = 1,
	LineConfig = {
		{
			9,
			4,
			-13,
			-4,
			-9
		},
		{
			10,
			5,
			1,
			-1,
			-5,
			-10
		},
		{
			6,
			2,
			0,
			-2,
			-6
		},
		{
			11,
			7,
			3,
			-3,
			-7,
			-11
		},
		{
			12,
			8,
			-14,
			-8,
			-12
		}
	},
	DEFAULT_CHUYIN_POS = {
		1,
		4.5
	},
	DEFAULT_PET_ANIM_POS = {
		0,
		0
	}
}
BattleMiscConfig.ZOMBIE_POS_CONFIG = {
	GridType = 2,
	LineConfig = {
		{
			12,
			11,
			10,
			0,
			-10,
			-11,
			-12
		},
		{
			7,
			4,
			1,
			-1,
			-4,
			-7
		},
		{
			8,
			5,
			2,
			0,
			-2,
			-5,
			-8
		},
		{
			9,
			6,
			3,
			-3,
			-6,
			-9
		},
		{
			15,
			14,
			13,
			0,
			-13,
			-14,
			-15
		}
	},
	DEFAULT_CHUYIN_POS = {
		2,
		2.5
	},
	DEFAULT_PET_ANIM_POS = {
		0,
		0
	}
}
BattleMiscConfig.ONE_LINE_MAX = 100

local function AddToContainer(key, value, container)
	if container[key] then
		table.insert(container[key], value)
	else
		container[key] = {
			value
		}
	end
end

local function _initPosConfig(gridConfig)
	gridConfig.LineNumConfig = {}
	gridConfig.PosToCoord = {}
	gridConfig.CoordToPos = {}

	for lineNum, lineConf in ipairs(gridConfig.LineConfig) do
		gridConfig.LineNumConfig[lineNum] = #lineConf

		local coordStart = lineNum * BattleMiscConfig.ONE_LINE_MAX

		for index, pos in ipairs(lineConf) do
			gridConfig.CoordToPos[coordStart + index] = pos
			gridConfig.PosToCoord[pos] = coordStart + index
		end
	end

	gridConfig.NebConfig = {}
	gridConfig.PosToCoordXY = {}

	local lineNumConfig = gridConfig.LineNumConfig
	local eventStartX = -0.5

	if lineNumConfig[1] > lineNumConfig[2] then
		eventStartX = 0.5
	end

	local totalLine = #lineNumConfig

	for lineNum, gridNum in ipairs(lineNumConfig) do
		local upType
		local upStart = lineNum * BattleMiscConfig.ONE_LINE_MAX + BattleMiscConfig.ONE_LINE_MAX

		if lineNum < totalLine then
			upType = gridNum > lineNumConfig[lineNum + 1] and 1 or 2
		end

		local coordY = lineNum - 1
		local coordXStart = 0

		if lineNum % 2 == 0 then
			coordXStart = eventStartX
		end

		for index = 1, gridNum do
			local coord = lineNum * BattleMiscConfig.ONE_LINE_MAX + index
			local pos = gridConfig.CoordToPos[coord]

			gridConfig.PosToCoordXY[pos] = {
				coordXStart + index - 1,
				coordY
			}

			if index < gridNum then
				AddToContainer(pos, gridConfig.CoordToPos[coord + 1], gridConfig.NebConfig)
				AddToContainer(gridConfig.CoordToPos[coord + 1], pos, gridConfig.NebConfig)
			end

			if upType then
				if gridConfig.CoordToPos[upStart + index] then
					AddToContainer(pos, gridConfig.CoordToPos[upStart + index], gridConfig.NebConfig)
					AddToContainer(gridConfig.CoordToPos[upStart + index], pos, gridConfig.NebConfig)
				end

				if upType == 2 then
					AddToContainer(pos, gridConfig.CoordToPos[upStart + index + 1], gridConfig.NebConfig)
					AddToContainer(gridConfig.CoordToPos[upStart + index + 1], pos, gridConfig.NebConfig)
				elseif index > 1 then
					AddToContainer(pos, gridConfig.CoordToPos[upStart + index - 1], gridConfig.NebConfig)
					AddToContainer(gridConfig.CoordToPos[upStart + index - 1], pos, gridConfig.NebConfig)
				end
			end
		end
	end
end

_initPosConfig(BattleMiscConfig.NORMAL_POS_CONFIG)
_initPosConfig(BattleMiscConfig.SPE_BOSS_POS_CONFIG)
_initPosConfig(BattleMiscConfig.ZOMBIE_POS_CONFIG)

return BattleMiscConfig
