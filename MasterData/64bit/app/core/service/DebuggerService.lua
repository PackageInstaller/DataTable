local DebuggerService = class("DebuggerService")
local var_0_1 = {
	S2C_CLEAR_CACHE = "1013",
	S2C_LOG = "1001",
	S2C_FETCH_FILE = "1015",
	C2S_LOG = "1000",
	S2C_CANCEL_AUTO_CONNECT = "1011",
	S2C_AUTO_CONNECT = "1009",
	S2C_REBOOT = "1007",
	S2C_DEL_FILE = "1005",
	S2C_ADD_FILE = "1003",
	C2S_ADD_FILE = "1002"
}

function DebuggerService:ctor()
	g.core.log:info("DebuggerService:ctor --  ")

	self._socket = nil
	self.host = nil
	self.port = nil

	local var_1_0 = cc.FileUtils:getInstance()

	if not var_1_0:isDirectoryExist(device.writablePath) then
		var_1_0:createDirectory(device.writablePath)
	end
end

function DebuggerService:socketInit()
	if not self.host or not self.port then
		return
	end

	local socket = require("socket")

	print(socket._VERSION)

	self._socket = socket.tcp()

	local var_2_1, var_2_2 = self._socket:connect(self.host, self.port)

	if var_2_1 == 1 then
		print("connected !!!!!")
		self._socket:settimeout(0)
	else
		self._socket = nil

		print("no socket : " .. var_2_2)
	end
end

function DebuggerService:socketClose()
	print("DebuggerService:socketClose -- ")

	if self._socket then
		print("DebuggerService:socketClose 2-- ")
		self._socket:close()

		self._socket = nil
	end
end

function DebuggerService:socketSend(arg_4_1)
	if self._socket then
		self._socket:send(arg_4_1)
	end
end

function DebuggerService:hasConnect()
	return self._socket
end

local function var_0_2(arg_6_0)
	local var_6_0 = string.gsub(arg_6_0, "\\", "/")
	local var_6_1 = string.find(var_6_0, "src")
	local var_6_2 = string.find(var_6_0, "res")

	local function var_6_3(arg_7_0)
		local var_7_1 = arg_7_0
		local var_7_2 = ""
		local var_7_3 = string.find(arg_7_0, "/")

		while var_7_3 do
			var_7_2 = var_7_2 .. string.sub(var_7_1, 1, var_7_3)
			var_7_1 = string.sub(var_7_1, var_7_3 + 1)

			print("strB1, strB2", var_7_2, var_7_1)

			var_7_3 = string.find(var_7_1, "/")
		end

		print("strB = ", arg_7_0)
		print(var_7_2, var_7_1)

		return var_7_2, var_7_1
	end

	local var_6_4
	local var_6_5

	if var_6_1 then
		var_6_0 = string.sub(var_6_0, var_6_1)
		var_6_4, var_6_5 = var_6_3(var_6_0)
	elseif var_6_2 then
		var_6_0 = string.sub(var_6_0, var_6_2)
		var_6_4, var_6_5 = var_6_3(var_6_0)
	else
		var_6_4, var_6_5 = var_6_3(var_6_0)
		var_6_4 = ""
	end

	print("_path, filename: ", var_6_4, var_6_5)

	return var_6_4, var_6_5
end

function DebuggerService:socketReceive()
	if not self._socket then
		print("no socket -- ")

		return
	end

	local var_8_0, var_8_1 = self._socket:receive(4)

	if var_8_1 ~= "closed" then
		if var_8_0 then
			print("startDealRecv proto:", var_8_0, type(var_8_0))

			if var_8_0 == var_0_1.S2C_LOG then
				print("startDealRecv str : ", (self._socket:receive((tonumber((self._socket:receive(4)))))))
			elseif var_8_0 == var_0_1.S2C_ADD_FILE then
				local var_8_2 = self._socket:receive((tonumber((self._socket:receive(3)))))

				print("startDealRecv fileName : ", var_8_2)

				local var_8_3 = tonumber((self._socket:receive(9)))
				local var_8_4 = self._socket:receive(var_8_3)

				print("startDealRecv fileLenth, len(strFile) : ", var_8_3, string.len(var_8_4))

				if var_8_3 == string.len(var_8_4) then
					print("path: " .. device.writablePath .. "__QQQ.txt")

					local var_8_5 = io.open(device.writablePath .. "__QQQ.txt", "w")

					if var_8_5 then
						var_8_5:write(var_8_4)
						var_8_5:close()
						print("write succ !")
						self:sendLog("client add file SUCC !!!")

						local var_8_6, var_8_7 = var_0_2(var_8_2)
						local var_8_8 = cc.FileUtils:getInstance()
						local var_8_9 = uf.UpgradeManager:getInstance():getUpgradeFolder()

						if not var_8_8:isDirectoryExist(var_8_9 .. var_8_6) then
							var_8_8:createDirectory(var_8_9 .. var_8_6)
						end

						var_8_8:renameFile(device.writablePath .. "__QQQ.txt", var_8_9 .. var_8_6 .. var_8_7)
					end
				else
					self:sendLog("client add file FAIL !!! PLEASE RETRY !!")
				end
			elseif var_8_0 == var_0_1.S2C_DEL_FILE then
				local var_8_10 = self._socket:receive((tonumber((self._socket:receive(3)))))

				print("startDealRecv S2C_DEL_FILE fileName : ", var_8_10)

				local var_8_11, var_8_12 = var_0_2(var_8_10)

				cc.FileUtils:getInstance():removeFile(uf.UpgradeManager:getInstance():getUpgradeFolder() .. var_8_11 .. var_8_12)
				self:sendLog("client del file SUCC !!!")
			elseif var_8_0 == var_0_1.S2C_REBOOT then
				device.restartGame()
			elseif var_8_0 == var_0_1.S2C_AUTO_CONNECT then
				local var_8_13 = g.core.common.Storage:load("auto_connect.json", false) or {}

				var_8_13.auto = true

				g.core.common.Storage:save("auto_connect.json", var_8_13, false)
			elseif var_8_0 == var_0_1.S2C_CANCEL_AUTO_CONNECT then
				local var_8_14 = g.core.common.Storage:load("auto_connect.json", false) or {}

				var_8_14.auto = false

				g.core.common.Storage:save("auto_connect.json", var_8_14, false)
			elseif var_8_0 == var_0_1.S2C_CLEAR_CACHE then
				if type(__REMOVE_LOCAL_CACHE__) == "function" then
					__REMOVE_LOCAL_CACHE__()
				end

				device.restartGame()
			elseif var_8_0 == var_0_1.S2C_FETCH_FILE then
				local var_8_15 = self._socket:receive((tonumber((self._socket:receive(3)))))

				print("startDealRecv S2C_DEL_FILE fileName : ", var_8_15)

				local var_8_16, var_8_17 = var_0_2(var_8_15)

				if not cc.FileUtils:getInstance():isFileExist(var_8_15) then
					self:sendLog("fetch fail! file not exist !")
				else
					self:sendFile(var_8_15)
				end
			else
				print("startDealRecv -- no proto")
				self._socket:receive()
			end
		end
	else
		print("Service Closed!")
		self:socketClose()
	end
end

function DebuggerService:sendLog(arg_9_1)
	local var_9_0

	if not arg_9_1 or string.len(arg_9_1) == 0 then
		do return end

		var_9_0 = {
			var_0_1.C2S_LOG
		}
	end

	var_9_0[2] = string.format("%04d", (string.len(arg_9_1)))
	var_9_0[3] = arg_9_1

	self:socketSend(table.concat(var_9_0))
end

function DebuggerService:sendFile(arg_10_1)
	local var_10_0 = arg_10_1 or "btn/big_yellowbtn.png"
	local var_10_1 = cc.FileUtils:getInstance()
	local var_10_2 = var_10_1:fullPathForFilename(arg_10_1 or "btn/big_yellowbtn.png")
	local var_10_3 = var_10_1:getFileSize(var_10_2)

	print("sendFile", var_10_3)
	self:socketSend(table.concat({
		var_0_1.C2S_ADD_FILE,
		string.format("%02d", (string.len(arg_10_1 or "btn/big_yellowbtn.png"))),
		var_10_0,
		string.format("%9d", var_10_3)
	}))

	local var_10_4 = var_10_1:getDataFromFile(var_10_2)

	print("sendFile str", string.len(var_10_4))
	self:socketSend(var_10_4)
end

function DebuggerService:start(arg_11_1, arg_11_2)
	self.host = arg_11_1
	self.port = arg_11_2

	self:socketInit()

	if self._socket and not self._handler then
		self._handler = g.core.layer.LayerManager:getRoot():newSchedule(handler(self, self.socketReceive), 0.5)
	end
end

function DebuggerService:reset()
	if self._handler then
		g.core.layer.LayerManager:getRoot():cancelSchedule(self._handler)

		self._handler = nil
	end
end

function DebuggerService:_onUpdate(arg_13_1, arg_13_2)
	return
end

return DebuggerService
