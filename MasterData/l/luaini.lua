---@class LuaIni
local LuaIni = class("LuaIni")

function LuaIni:ctor(fileName)
	self.data = nil
	self.section = nil
	self.fileName = fileName
end

function LuaIni:load(fileName)
	fileName = fileName or self.fileName

	local file = io.open(fileName, 'r')
	if not file then
		LuaLogger.es('Error loading file : ' .. fileName)
		return false
	end
	
	local data = {}
	local section
	local sectionRule = '^%[([^%[%]]+)%]$'
	local paramRule = '^([%w|_]+)%s-=%s-(.+)$'
	if _VERSION == "Lua 5.4" then
		sectionRule = '^%[([^%[%]]+)%]\r$'
		paramRule = '^([%w|_]+)%s-=%s-(.+)\r$'
	end

	for line in file:lines() do
		local tempSection = line:match(sectionRule)
		if(tempSection)then
			section = tonumber(tempSection) and tonumber(tempSection) or tempSection
			data[section] = data[section] or {}
		end

		local param, value = line:match(paramRule)
		if(param and value ~= nil)then
			if(tonumber(value))then
				value = tonumber(value)
			elseif(value == 'true')then
				value = true
			elseif(value == 'false')then
				value = false
			end
			if(tonumber(param))then
				param = tonumber(param)
			end
			data[section][param] = value
		end
	end

	file:close()
	self.data = data
	return data
end

function LuaIni:setCurrSection(section)
	self.section = section
end

function LuaIni:setData(key, value)
	self.data[self.section][key] = value
end

function LuaIni:setSectionData(section, key, value)
	self.data[section][key] = value
end

-- data为table格式:
-- {
-- 	section1 = {data1 = 1, data2 = "abc"}
-- 	section2 = {data3 = 3.5, data4 = true}
-- }
-- 如果不传data，用已经加载(或修改)的数据
function LuaIni:save(fileName, data)
	data = data or self.data
	fileName = fileName or self.fileName

	local file = assert(io.open(fileName, 'w+b'), 'Error loading file :' .. fileName)
	local contents = ''
	for section, param in pairs(data) do
		contents = contents .. ('[%s]\n'):format(section)
		for key, value in pairs(param) do
			contents = contents .. ('%s=%s\n'):format(key, tostring(value))
		end
		contents = contents .. '\n'
	end

	file:write(contents)
	file:close()
end

return LuaIni