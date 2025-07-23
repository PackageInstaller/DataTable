module('WebInterfaceUtil', Class.impl())

-- 同步
function getDataXHR(self, url, correctCall, errorCall, callTagert, tryCount, isFormatJson)
	local function _correctCall(self, correctData)
		local function _tryCatch()
			if(correctData == nil)then
				if(errorCall)then
					errorCall(self, "", nil)
				end
			else
				if(isFormatJson == nil or isFormatJson == true)then
					if(correctData == "")then
						if(errorCall)then
							errorCall(self, correctData, nil)
						end
					else
						local jsonObj = JsonUtil.decode(correctData)
						if(jsonObj)then
							if(correctCall)then
								correctCall(self, correctData, jsonObj)
							end
						else
							if(errorCall)then
								errorCall(self, correctData, nil)
							end
						end
					end
				else
					if(correctCall)then
						correctCall(self, correctData, nil)
					end
				end
			end
		end
		local isOk, value = pcall(_tryCatch)
		if not isOk then
			WebInterfaceUtil:callErrorTip(value)
		end
	end
	local function _errorCall(self, errorData)
        local function _tryCatch()
			tryCount = tryCount or 5
			if(tryCount <= 1)then
				if(errorCall)then
					errorCall(self, errorData, nil)
				end
			else
				LoopManager:addTimer(1, 1, self, function() WebInterfaceUtil:getDataXHR(url, correctCall, errorCall, callTagert, tryCount - 1) end)
			end
        end
        local isOk, value = pcall(_tryCatch)
        if not isOk then
			WebInterfaceUtil:callErrorTip(value)
        end
	end
	gs.webInterfaceUtil.GetDataXHR(url, _correctCall, _errorCall, callTagert, 5000)
end

-- 同步
function getDataXHRByPost(self, url, param, correctCall, errorCall, callTagert, tryCount, isFormatJson)
	local function _correctCall(self, correctData)
		local function _tryCatch()
			if(correctData == nil)then
				if(errorCall)then
					errorCall(self, "", nil)
				end
			else
				if(isFormatJson == nil or isFormatJson == true)then
					if(correctData == "")then
						if(errorCall)then
							errorCall(self, correctData, nil)
						end
					else
						local jsonObj = JsonUtil.decode(correctData)
						if(jsonObj)then
							if(correctCall)then
								correctCall(self, correctData, jsonObj)
							end
						else
							if(errorCall)then
								errorCall(self, correctData, nil)
							end
						end
					end
				else
					if(correctCall)then
						correctCall(self, correctData, nil)
					end
				end
			end
		end
		local isOk, value = pcall(_tryCatch)
		if not isOk then
			WebInterfaceUtil:callErrorTip(value)
		end
	end
	local function _errorCall(self, errorData)
        local function _tryCatch()
			tryCount = tryCount or 5
			if(tryCount <= 1)then
				if(errorCall)then
					errorCall(self, errorData, nil)
				end
			else
				LoopManager:addTimer(1, 1, self, function() WebInterfaceUtil:getDataXHRByPost(url, param, correctCall, errorCall, callTagert, tryCount - 1) end)
			end
        end
        local isOk, value = pcall(_tryCatch)
        if not isOk then
			WebInterfaceUtil:callErrorTip(value)
        end
	end
	gs.webInterfaceUtil.GetDataXHRByPost(url, param, _correctCall, _errorCall, callTagert, 5000)
end

-- get循环异步
function getAsyncLoop(self, url, correctCall, errorCall, callTagert, tryCount, isFormatJson)
	local function _correctCall(correctData)
		if(WebInterfaceUtil:isCacheToFile())then
			if(correctData == nil)then
				WebInterfaceUtil:callErrorTip(url .. " 正确返回：空")
			else
				WebInterfaceUtil:callErrorTip(url .. " 正确返回：" .. correctData)
			end
		end
		local function _tryCatch()
			if(correctData == nil)then
				if(errorCall)then
					errorCall(callTagert, "", nil)
				end
			else
				if(isFormatJson == nil or isFormatJson == true)then
					if(correctData == "")then
						if(errorCall)then
							errorCall(callTagert, correctData, nil)
						end
					else
						local jsonObj = nil
						local isOk, value = pcall(function() jsonObj = JsonUtil.decode(correctData) end)
						if(isOk and jsonObj)then
							if(correctCall)then
								correctCall(callTagert, correctData, jsonObj)
							end
						else
							if(errorCall)then
								WebInterfaceUtil:callErrorTip("解析 " .. correctData .. " 报错：" .. value)
								errorCall(callTagert, "解析 " .. correctData .. " 报错：" .. value, nil)
							end
						end
					end
				else
					if(correctCall)then
						correctCall(callTagert, correctData, nil)
					end
				end
			end
		end
		local isOk, value = pcall(_tryCatch)
		if not isOk then
			WebInterfaceUtil:callErrorTip(value)
		end
	end
	local function _errorCall(errorData)
		if(WebInterfaceUtil:isCacheToFile())then
			if(errorData == nil)then
				WebInterfaceUtil:callErrorTip(url .. " 错误返回：空")
			else
				WebInterfaceUtil:callErrorTip(url .. " 错误返回：" .. errorData)
			end
		end
        local function _tryCatch()
			tryCount = tryCount or 5
			if(tryCount <= 1)then
				if(errorCall)then
					errorCall(callTagert, errorData, nil)
				end
			else
				LoopManager:addTimer(1, 1, self, function() WebInterfaceUtil:getAsyncLoop(url, correctCall, errorCall, callTagert, tryCount - 1) end)
			end
        end
        local isOk, value = pcall(_tryCatch)
        if not isOk then
			WebInterfaceUtil:callErrorTip(value)
        end
	end

	if(gs.Application.platform == gs.RuntimePlatform.WindowsPlayer)then
		-- 该方法模拟器可以，但有些真机访问不了
		gs.WebUtil.GetAsyncUnityWebRequest(_correctCall, _errorCall, url, 5000)
	else
		-- HttpClient首次会卡顿因为内部机制执行了预热
		gs.WebUtil.GetAsyncHttpClient(_correctCall, _errorCall, url, 3000, true)
	end
end

-- post循环异步
function postAsyncLoop(self, url, param, correctCall, errorCall, callTagert, tryCount, isFormatJson)
	local function _correctCall(correctData)
		if(WebInterfaceUtil:isCacheToFile())then
			if(correctData == nil)then
				WebInterfaceUtil:callErrorTip(url .. " 正确返回：空")
			else
				WebInterfaceUtil:callErrorTip(url .. " 正确返回：" .. correctData)
			end
		end
		local function _tryCatch()
			if(correctData == nil)then
				if(errorCall)then
					errorCall(callTagert, "", nil)
				end
			else
				if(isFormatJson == nil or isFormatJson == true)then
					if(correctData == "")then
						if(errorCall)then
							errorCall(callTagert, correctData, nil)
						end
					else
						local jsonObj = nil
						local isOk, value = pcall(function() jsonObj = JsonUtil.decode(correctData) end)
						if(isOk and jsonObj)then
							if(correctCall)then
								correctCall(callTagert, correctData, jsonObj)
							end
						else
							if(errorCall)then
								WebInterfaceUtil:callErrorTip("解析 " .. correctData .. " 报错：" .. value)
								errorCall(callTagert, "解析 " .. correctData .. " 报错：" .. value, nil)
							end
						end
					end
				else
					if(correctCall)then
						correctCall(callTagert, correctData, nil)
					end
				end
			end
		end
		local isOk, value = pcall(_tryCatch)
		if not isOk then
			WebInterfaceUtil:callErrorTip(value)
		end
	end
	local function _errorCall(errorData)
		if(WebInterfaceUtil:isCacheToFile())then
			if(errorData == nil)then
				WebInterfaceUtil:callErrorTip(url .. " 正确返回：空")
			else
				WebInterfaceUtil:callErrorTip(url .. " 正确返回：" .. errorData)
			end
		end
        local function _tryCatch()
			tryCount = tryCount or 5
			if(tryCount <= 1)then
				if(errorCall)then
					errorCall(callTagert, errorData, nil)
				end
			else
				LoopManager:addTimer(1, 1, self, function() WebInterfaceUtil:postAsyncLoop(url, param, correctCall, errorCall, callTagert, tryCount - 1) end)
			end
        end
        local isOk, value = pcall(_tryCatch)
        if not isOk then
			WebInterfaceUtil:callErrorTip(value)
        end
	end
	
	if(gs.Application.platform == gs.RuntimePlatform.WindowsPlayer)then
		-- 该方法模拟器可以，但有些真机访问不了
		gs.WebUtil.PostAsyncUnityWebRequest(_correctCall, _errorCall, url, param, 3000)
	else
		-- HttpClient首次会卡顿因为内部机制执行了预热
		gs.WebUtil.PostAsyncHttpClient(_correctCall, _errorCall, url, param, 3000, true)
	end
end

function callErrorTip(self, tip)
	print("WebInterfaceUtil Error：", tip)
	if(WebInterfaceUtil:isCacheToFile())then
		gs.File.AppendAllText(gs.Application.dataPath .. "/AnchorLog.txt", os.date("%Y-%m-%d %H:%M:%S", os.time()) .. ":::::" .. tip .. "\n------------------------------------------------------------------------------------------------------------------------\n");
	end
end

-- 是否生成缓存文件
function isCacheToFile(self)
	return false
end

return _M
