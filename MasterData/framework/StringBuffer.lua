-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/aounity-framework/Scripts/Lua/framework/datastruct/StringBuffer.lua

module("framework.datastruct.StringBuffer", package.seeall)

local StringBuffer = class("StringBuffer")
local line = "\r\n"

function StringBuffer:ctor(data)
	self._dataList = data and {
		data
	} or nil
end

function StringBuffer:append(data)
	self._dataList = self._dataList or {}
	self._dataList[#self._dataList + 1] = data

	return self
end

function StringBuffer:appendLine()
	return self:append(line)
end

function StringBuffer:toString(splitChar)
	if not self._dataList then
		return ""
	end

	splitChar = splitChar or ""

	return table.concat(self._dataList, splitChar, 1, #self._dataList)
end

function StringBuffer:clear()
	self._dataList = nil
end

return StringBuffer
