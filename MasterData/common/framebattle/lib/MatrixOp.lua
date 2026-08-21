-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Common\\FrameBattle\\Lib\\MatrixOp.lua

local BattleConst = require("Common/FrameBattle/BattleConst")
local MatrixOp = {}

MatrixOp.OP_USE_SKILL = BattleConst.INPUT_EVENT_USE_SKILL
MatrixOp.OP_SET_AUTO = BattleConst.INPUT_EVENT_SET_AUTO
MatrixOp.OP_SET_SHORT = BattleConst.INPUT_EVENT_SET_SHORT

local OPARG = {
	[MatrixOp.OP_USE_SKILL] = "<I4",
	[MatrixOp.OP_SET_AUTO] = "<I4",
	[MatrixOp.OP_SET_SHORT] = "<I4"
}

function MatrixOp.packMatrixOp(opCode, ...)
	if not MatrixOp.struct then
		MatrixOp.struct = require("struct")
	end

	local opArgsStruct = OPARG[opCode]

	if opArgsStruct then
		return MatrixOp.struct.pack(opArgsStruct, ...)
	end

	return nil
end

function MatrixOp.unpackMatrixOp(opCode, data)
	if not MatrixOp.struct then
		MatrixOp.struct = require("struct")
	end

	local opArgsStruct = OPARG[opCode]

	if opArgsStruct then
		return {
			MatrixOp.struct.unpack(opArgsStruct, data)
		}
	end

	return nil
end

return MatrixOp
