pg = pg or {}

local var_0_0 = pg

pg.SendWindow = class("SendWindow")

local var_0_1

function pg.SendWindow.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.connectionMgr = arg_1_1
	arg_1_0.packetIdx = defaultValue(arg_1_2, 0)
	arg_1_0.isSending = false
	arg_1_0.toSends = {}
	arg_1_0.retryCount = 0
	var_0_1 = {}

	return
end

function pg.SendWindow.setPacketIdx(arg_2_0, arg_2_1)
	arg_2_0.packetIdx = arg_2_1

	return
end

function pg.SendWindow:getPacketIdx()
	return self.packetIdx
end

function pg.SendWindow:incPacketIdx()
	self.packetIdx = self.packetIdx + 1

	return
end

function pg.SendWindow:Queue(arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5, arg_5_6, arg_5_7)
	table.insert(self.toSends, {
		arg_5_1,
		arg_5_2,
		arg_5_3,
		arg_5_4 and function(arg_6_0)
			table.remove(self.toSends, 1)
			arg_5_4(arg_6_0)

			if arg_6_0 and arg_6_0.result and arg_6_0.result == 0 or arg_5_3 == 20012 then
				var_0_0.SeriesGuideMgr.GetInstance():receiceProtocol(arg_5_3, arg_5_2, arg_6_0)
			end

			return
		end,
		arg_5_5,
		arg_5_6,
		arg_5_7
	})

	if self.isSending then
		return
	end

	self:StartSend()

	return
end

function pg.SendWindow:RemoveLoginPacket()
	if #self.toSends > 0 and self.toSends[1][1] == 10022 then
		table.remove(self.toSends, 1)
	end

	return
end

function pg.SendWindow:StartSend()
	if #self.toSends > 0 then
		self:Send(unpack(self.toSends[1]))
	else
		warning("No more packets to send.")
	end

	return
end

function pg.SendWindow:Send(arg_9_1, arg_9_2, arg_9_3, arg_9_4, arg_9_5, arg_9_6, arg_9_7)
	self.isSending = true
	self.currentCS = arg_9_1

	if self.connectionMgr:isConnecting() then
		self.connectionMgr.needStartSend = true

		return
	end

	local var_9_0 = self.connectionMgr:getConnection()

	if not var_9_0 then
		self.connectionMgr.needStartSend = true

		self.connectionMgr:Reconnect(function()
			return
		end)

		return
	end

	arg_9_5 = defaultValue(arg_9_5, true)
	arg_9_6 = defaultValue(arg_9_6, true)
	arg_9_7 = defaultValue(arg_9_7, SEND_TIMEOUT)

	local var_9_1 = self:getPacketIdx()

	if arg_9_3 ~= nil then
		var_0_0.UIMgr.GetInstance():LoadingOn()

		local var_9_2 = arg_9_5 and arg_9_3 .. "_" .. var_9_1 or arg_9_3

		var_0_1[var_9_2] = function(arg_11_0)
			self.isSending = false

			var_0_0.UIMgr.GetInstance():LoadingOff()
			self.connectionMgr:resetHBTimer()

			if self.timer then
				self.timer:Stop()

				self.timer = nil
			end

			arg_9_4(arg_11_0)

			if arg_9_6 and not self.isSending and #self.toSends > 0 then
				self:StartSend()
			end

			return
		end
		self.timer = Timer.New(function()
			var_0_0.UIMgr.GetInstance():LoadingOff()

			var_0_1[var_9_2] = nil

			self:setPacketIdx(var_9_1)

			if self.retryCount > 3 then
				self.connectionMgr.onDisconnected(false, DISCONNECT_TIME_OUT)

				self.retryCount = 0
			end

			if PLATFORM_CODE == PLATFORM_CHT then
				self.connectionMgr.SwitchProxy()
			end

			warning("Network is timedOut, resend: " .. var_9_1 .. ", protocal: " .. arg_9_1)

			self.retryCount = self.retryCount + 1

			self:StartSend()

			return
		end, arg_9_7, 1)

		self.timer:Start()
	else
		arg_9_5 = false
	end

	local var_9_3 = var_0_0.Packer.GetInstance()
	local var_9_4 = var_9_3:GetProtocolWithName("cs_" .. arg_9_1)

	local function var_9_5(arg_13_0, arg_13_1)
		for iter_13_0, iter_13_1 in pairs(arg_13_1) do
			if type(iter_13_1) == "table" then
				if arg_13_0[iter_13_0].add then
					for iter_13_2, iter_13_3 in ipairs(iter_13_1) do
						var_9_5(arg_13_0[iter_13_0]:add(), iter_13_3)
					end
				elseif arg_13_0[iter_13_0].append then
					for iter_13_4, iter_13_5 in ipairs(iter_13_1) do
						arg_13_0[iter_13_0]:append(iter_13_5)
					end
				else
					var_9_5(arg_13_0[iter_13_0], iter_13_1)
				end
			else
				arg_13_0[iter_13_0] = iter_13_1
			end
		end

		return
	end

	local var_9_6 = var_9_4:GetMessage()

	var_9_5(var_9_3, arg_9_2)

	if arg_9_5 then
		var_9_0:Send(var_0_0.Packer.GetInstance():Pack(var_9_1, var_9_4:GetId(), var_9_6))
		originalPrint("Network sent protocol: " .. arg_9_1 .. " with idx: " .. var_9_1)
		self:incPacketIdx()
	else
		var_9_0:Send(var_0_0.Packer.GetInstance():Pack(0, var_9_4:GetId(), var_9_6))

		if arg_9_1 ~= 21211 then
			originalPrint("Network sent protocol: " .. arg_9_1 .. " without idx")
		end
	end

	if not arg_9_3 then
		table.remove(self.toSends, 1)

		if #self.toSends > 0 then
			self:StartSend()
		else
			self.isSending = false
		end
	end

	return
end

function pg.SendWindow:stopTimer()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	return
end

function pg.SendWindow:onData()
	if self.cmd ~= 21212 then
		originalPrint("Network Receive idx: " .. self.idx .. " cmd: " .. self.cmd)
	end

	local var_15_0 = var_0_0.Packer.GetInstance():Unpack(self.cmd, self:getLuaStringBuffer())

	if var_0_1[self.cmd .. "_" .. self.idx] then
		var_0_1[self.cmd .. "_" .. self.idx] = nil

		var_0_1[self.cmd .. "_" .. self.idx](var_15_0)
	elseif var_0_1[self.cmd] then
		var_0_1[self.cmd] = nil

		var_0_1[self.cmd](var_15_0)
	end

	return
end

return
