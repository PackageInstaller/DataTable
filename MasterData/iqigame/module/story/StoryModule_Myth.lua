-- chunkname: @IQIGame\\Module\\Story\\StoryModule_Myth.lua

local this = StoryModule
local json = require("Util.json")

function this.AddMythData(resourceIDArray)
	local jsStr = this.GetPODVariable(Constant.StoryMazeNpcID, Constant.StoryMythData)
	local data = {}

	if not LuaUtility.StrIsNullOrEmpty(jsStr) then
		data = json.decode(jsStr)
	end

	local len = getTableLength(data)
	local len2 = #resourceIDArray

	for i = 1, len2 do
		data[tostring(len + 1)] = resourceIDArray[i]
		len = len + 1
	end

	local js = json.encode(data)

	this.SetPODVariable(Constant.StoryMazeNpcID, Constant.StoryMythData, Constant.StoryVariableType.String, js)
end

function this.ChangeMythData(oldID, newID)
	local jsStr = this.GetPODVariable(Constant.StoryMazeNpcID, Constant.StoryMythData)
	local data = {}

	if not LuaUtility.StrIsNullOrEmpty(jsStr) then
		data = json.decode(jsStr)
	end

	for i, v in pairs(data) do
		if v == oldID then
			data[i] = newID

			break
		end
	end

	local js = json.encode(data)

	this.SetPODVariable(Constant.StoryMazeNpcID, Constant.StoryMythData, Constant.StoryVariableType.String, js)
end

function StoryModule.GetStoryMythData()
	local jsStr = this.GetPODVariable(Constant.StoryMazeNpcID, Constant.StoryMythData)
	local data = {}

	if not LuaUtility.StrIsNullOrEmpty(jsStr) then
		data = json.decode(jsStr)
	end

	local tb = {}

	for i, v in pairs(data) do
		tb[tonumber(i)] = v
	end

	return tb
end
