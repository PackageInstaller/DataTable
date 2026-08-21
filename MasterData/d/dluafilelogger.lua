local DLuaFileLogger = class("DLuaFileLogger")

function DLuaFileLogger:ctor(filePath)
	self.logFilePath = filePath
end

function DLuaFileLogger:open()
	return self:reopen(false)
end

function DLuaFileLogger:write(content)
	if not self.file then
		return false, "file not open"
	end
	
	local ok, res = self.file:write(content)
	if not ok then
		return res
	end
end

function DLuaFileLogger:writeLine(content)
	self:write(content)
	self:write("\n")

	if self.file then
		self.file:flush()
	end
end

function DLuaFileLogger:reopen(newFile)
	self:close()

	local err
	if newFile then
		self.file, err = io.open(self.logFilePath, "w+")
	else
		self.file, err = io.open(self.logFilePath, "a+")
	end
	
	return self.file, err
end

function DLuaFileLogger:close()
	if self.file then
		self.file:close()
		self.file = nil
	end
end

function DLuaFileLogger:getLogFilePath()
	return self.logFilePath
end

function DLuaFileLogger:isLogFileExist()
	--if self.file then
	--	return true
	--end

	if not self.logFilePath then
		return false
	end
	
	local testFile = io.open(self.logFilePath, "r")
	if not testFile then
		return false
	end

	local pos = testFile:seek("end")
	testFile:close()
	return pos
end

return DLuaFileLogger