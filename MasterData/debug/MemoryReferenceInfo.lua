-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Debug\\MemoryReferenceInfo.lua

local cPublications = {
	m_cMethods = {},
	m_cHelpers = {},
	m_cBases = {}
}
local RECORD_TABLE = 1
local RECORD_FUNCTION = 2
local RECORD_USERDATA = 3
local RECORD_THREAD = 4

cPublications.m_cConfig = {
	[RECORD_TABLE] = 1,
	[RECORD_FUNCTION] = 1,
	[RECORD_USERDATA] = 1,
	[RECORD_THREAD] = 1
}

local function FormatDateTimeNow()
	local cDateTime = os.date("*t")
	local strDateTime = string.format("%04d%02d%02d-%02d%02d%02d", tostring(cDateTime.year), tostring(cDateTime.month), tostring(cDateTime.day), tostring(cDateTime.hour), tostring(cDateTime.min), tostring(cDateTime.sec))

	return strDateTime
end

local function GetOriginalToStringResult(cObject)
	if not cObject then
		return ""
	end

	local cMt = getmetatable(cObject)

	if not cMt then
		return tostring(cObject)
	end

	local strName = ""
	local cToString = rawget(cMt, "__tostring")

	if cToString then
		rawset(cMt, "__tostring", nil)

		strName = tostring(cObject)

		rawset(cMt, "__tostring", cToString)
	else
		strName = tostring(cObject)
	end

	return strName
end

local function CreateObjectReferenceInfoContainer()
	local cContainer = {}
	local cObjectReferenceCount = {}

	setmetatable(cObjectReferenceCount, {
		__mode = "k"
	})

	local cObjectAddressToName = {}

	setmetatable(cObjectAddressToName, {
		__mode = "k"
	})

	cContainer.m_cObjectReferenceCount = cObjectReferenceCount
	cContainer.m_cObjectAddressToName = cObjectAddressToName
	cContainer.m_cTypeTableContainer = {}
	cContainer.m_cFuncCountContainer = {}
	cContainer.m_cUserdataInfoContainer = {}
	cContainer.m_nStackLevel = -1
	cContainer.m_strShortSrc = "None"
	cContainer.m_nCurrentLine = -1

	return cContainer
end

local function CreateObjectReferenceInfoContainerFromFile(strFilePath)
	local cContainer = CreateObjectReferenceInfoContainer()

	cContainer.m_strShortSrc = strFilePath

	local cRefInfo = cContainer.m_cObjectReferenceCount
	local cNameInfo = cContainer.m_cObjectAddressToName
	local strHeader, strAddr, strName, strRefCount

	for strLine in io.lines(strFilePath) do
		strHeader = string.sub(strLine, 1, 2)

		if strHeader ~= "--" then
			local _, _, strAddr, strName, strRefCount = string.find(strLine, "(.+)\t(.*)\t(%d+)")

			if strAddr then
				cRefInfo[strAddr] = strRefCount
				cNameInfo[strAddr] = strName
			end
		end
	end

	return cContainer
end

local function CreateSingleObjectReferenceInfoContainer(strObjectName, cObject)
	local cContainer = {}
	local cObjectExistTag = {}

	setmetatable(cObjectExistTag, {
		__mode = "k"
	})

	local cObjectAliasName = {}
	local cObjectAccessTag = {}

	setmetatable(cObjectAccessTag, {
		__mode = "k"
	})

	cContainer.m_cObjectExistTag = cObjectExistTag
	cContainer.m_cObjectAliasName = cObjectAliasName
	cContainer.m_cObjectAccessTag = cObjectAccessTag
	cContainer.m_nStackLevel = -1
	cContainer.m_strShortSrc = "None"
	cContainer.m_nCurrentLine = -1
	cContainer.m_strObjectName = strObjectName
	cContainer.m_strAddressName = GetOriginalToStringResult(cObject)
	cContainer.m_cObjectExistTag[cObject] = true

	return cContainer
end

local function RecordKeyInfo(container, key, objectKey, refStr)
	if not container[key] then
		container[key] = {
			0
		}
	end

	if not container[key][objectKey] then
		container[key][objectKey] = {}
		container[key][1] = container[key][1] + 1
	end

	table.insert(container[key][objectKey], refStr)
end

local testF = 0

local function CollectObjectReferenceInMemory(strName, cObject, cDumpInfoContainer)
	if not cObject then
		return
	end

	strName = strName or ""
	cDumpInfoContainer = cDumpInfoContainer or CreateObjectReferenceInfoContainer()

	if cDumpInfoContainer.m_nStackLevel > 0 then
		local cStackInfo = debug.getinfo(cDumpInfoContainer.m_nStackLevel, "Sl")

		if cStackInfo then
			cDumpInfoContainer.m_strShortSrc = cStackInfo.short_src
			cDumpInfoContainer.m_nCurrentLine = cStackInfo.currentline
		end

		cDumpInfoContainer.m_nStackLevel = -1
	end

	local cRefInfoContainer = cDumpInfoContainer.m_cObjectReferenceCount
	local cNameInfoContainer = cDumpInfoContainer.m_cObjectAddressToName
	local cTypeTableContainer = cDumpInfoContainer.m_cTypeTableContainer
	local cFuncCountInfo = cDumpInfoContainer.m_cFuncCountContainer
	local cUserdataInfo = cDumpInfoContainer.m_cUserdataInfoContainer
	local typeName
	local strType = type(cObject)

	if strType == "table" then
		if rawget(cObject, "getType") then
			typeName = cObject:getType()
			strName = strName .. "[" .. typeName .. "]"
		end

		if cObject == _G then
			strName = strName .. "[_G]"
		end

		local bWeakK = false
		local bWeakV = false
		local cMt = getmetatable(cObject)

		if cMt then
			local strMode = rawget(cMt, "__mode")

			if strMode then
				if strMode == "k" then
					bWeakK = true
				elseif strMode == "v" then
					bWeakV = true
				elseif strMode == "kv" then
					bWeakK = true
					bWeakV = true
				end
			end
		end

		if cPublications.m_cConfig[RECORD_TABLE] and typeName then
			RecordKeyInfo(cTypeTableContainer, typeName, cObject, strName)
		end

		if cNameInfoContainer[cObject] then
			if #strName < #cNameInfoContainer[cObject] then
				cNameInfoContainer[cObject] = strName
			end

			return
		end

		if typeName then
			cNameInfoContainer[cObject] = typeName
		else
			cNameInfoContainer[cObject] = strName
		end

		for k, v in pairs(cObject) do
			local strKeyType = type(k)

			if strKeyType == "table" then
				if not bWeakK then
					CollectObjectReferenceInMemory(strName, k, cDumpInfoContainer)
				end

				if not bWeakV then
					CollectObjectReferenceInMemory(strName, v, cDumpInfoContainer)
				end
			elseif strKeyType == "function" then
				if not bWeakK then
					CollectObjectReferenceInMemory(strName, k, cDumpInfoContainer)
				end

				if not bWeakV then
					CollectObjectReferenceInMemory(strName, v, cDumpInfoContainer)
				end
			elseif strKeyType == "thread" then
				if not bWeakK then
					CollectObjectReferenceInMemory(strName, k, cDumpInfoContainer)
				end

				if not bWeakV then
					CollectObjectReferenceInMemory(strName, v, cDumpInfoContainer)
				end
			elseif strKeyType == "userdata" then
				if not bWeakK then
					CollectObjectReferenceInMemory(strName, k, cDumpInfoContainer)
				end

				if not bWeakV then
					CollectObjectReferenceInMemory(strName, v, cDumpInfoContainer)
				end
			else
				CollectObjectReferenceInMemory(strName .. "." .. tostring(k), v, cDumpInfoContainer)
			end
		end

		if cMt then
			CollectObjectReferenceInMemory(strName .. ".[metatable]", cMt, cDumpInfoContainer)
		end
	elseif strType == "function" then
		local cDInfo = debug.getinfo(cObject, "Su")

		if cPublications.m_cConfig[RECORD_FUNCTION] then
			local keyName = "[line:" .. tostring(cDInfo.linedefined) .. "@file:" .. cDInfo.short_src .. "]"

			RecordKeyInfo(cFuncCountInfo, keyName, cObject, strName)
		end

		if cNameInfoContainer[cObject] then
			return
		end

		strName = strName .. "[line:" .. tostring(cDInfo.linedefined) .. "@file:" .. cDInfo.short_src .. "]"
		cNameInfoContainer[cObject] = strName

		local nUpsNum = cDInfo.nups

		for i = 1, nUpsNum do
			local strUpName, cUpValue = debug.getupvalue(cObject, i)
			local strUpValueType = type(cUpValue)

			if strUpValueType == "table" then
				CollectObjectReferenceInMemory(strName .. ".[ups:table:" .. strUpName .. "]", cUpValue, cDumpInfoContainer)
			elseif strUpValueType == "function" then
				CollectObjectReferenceInMemory(strName .. ".[ups:function:" .. strUpName .. "]", cUpValue, cDumpInfoContainer)
			elseif strUpValueType == "thread" then
				CollectObjectReferenceInMemory(strName .. ".[ups:thread:" .. strUpName .. "]", cUpValue, cDumpInfoContainer)
			elseif strUpValueType == "userdata" then
				CollectObjectReferenceInMemory(strName .. ".[ups:userdata:" .. strUpName .. "]", cUpValue, cDumpInfoContainer)
			end
		end

		local cEnv = debug.getfenv(cObject)

		if cEnv then
			CollectObjectReferenceInMemory(strName .. ".[function:environment]", cEnv, cDumpInfoContainer)
		end
	elseif strType == "thread" and (not cPublications.m_cConfig[RECORD_THREAD] or true) then
		if cNameInfoContainer[cObject] then
			if #strName < #cNameInfoContainer[cObject] then
				cNameInfoContainer[cObject] = strName
			end

			return
		end

		cNameInfoContainer[cObject] = strName

		local cEnv = debug.getfenv(cObject)

		if cEnv then
			CollectObjectReferenceInMemory(strName .. ".[thread:environment]", cEnv, cDumpInfoContainer)
		end

		local cMt = getmetatable(cObject)

		if cMt then
			CollectObjectReferenceInMemory(strName .. ".[thread:metatable]", cMt, cDumpInfoContainer)
		end
	elseif strType == "userdata" then
		if cPublications.m_cConfig[RECORD_USERDATA] then
			local cMt = getmetatable(cObject)

			if cMt then
				local name = cMt[".name"]

				if name then
					RecordKeyInfo(cUserdataInfo, name, cObject, strName)
				end
			end
		end

		if cNameInfoContainer[cObject] then
			if #strName < #cNameInfoContainer[cObject] then
				cNameInfoContainer[cObject] = strName
			end

			return
		end

		cNameInfoContainer[cObject] = strName

		local cEnv = debug.getfenv(cObject)

		if cEnv then
			CollectObjectReferenceInMemory(strName .. ".[userdata:environment]", cEnv, cDumpInfoContainer)
		end

		local cMt = getmetatable(cObject)

		if cMt then
			CollectObjectReferenceInMemory(strName .. ".[userdata:metatable]", cMt, cDumpInfoContainer)
		end
	end
end

local function CollectSingleObjectReferenceInMemory(strName, cObject, cDumpInfoContainer)
	if not cObject then
		return
	end

	strName = strName or ""
	cDumpInfoContainer = cDumpInfoContainer or CreateObjectReferenceInfoContainer()

	if cDumpInfoContainer.m_nStackLevel > 0 then
		local cStackInfo = debug.getinfo(cDumpInfoContainer.m_nStackLevel, "Sl")

		if cStackInfo then
			cDumpInfoContainer.m_strShortSrc = cStackInfo.short_src
			cDumpInfoContainer.m_nCurrentLine = cStackInfo.currentline
		end

		cDumpInfoContainer.m_nStackLevel = -1
	end

	local cExistTag = cDumpInfoContainer.m_cObjectExistTag
	local cNameAllAlias = cDumpInfoContainer.m_cObjectAliasName
	local cAccessTag = cDumpInfoContainer.m_cObjectAccessTag
	local strType = type(cObject)

	if strType == "table" then
		if rawget(cObject, "__cname") then
			if type(cObject.__cname) == "string" then
				strName = strName .. "[class:" .. cObject.__cname .. "]"
			end
		elseif rawget(cObject, "class") then
			if type(cObject.class) == "string" then
				strName = strName .. "[class:" .. cObject.class .. "]"
			end
		elseif rawget(cObject, "_className") and type(cObject._className) == "string" then
			strName = strName .. "[class:" .. cObject._className .. "]"
		end

		if cObject == _G then
			strName = strName .. "[_G]"
		end

		local bWeakK = false
		local bWeakV = false
		local cMt = getmetatable(cObject)

		if cMt then
			local strMode = rawget(cMt, "__mode")

			if strMode then
				if strMode == "k" then
					bWeakK = true
				elseif strMode == "v" then
					bWeakV = true
				elseif strMode == "kv" then
					bWeakK = true
					bWeakV = true
				end
			end
		end

		if cExistTag[cObject] and not cNameAllAlias[strName] then
			cNameAllAlias[strName] = true
		end

		if cAccessTag[cObject] then
			return
		end

		cAccessTag[cObject] = true

		for k, v in pairs(cObject) do
			local strKeyType = type(k)

			if strKeyType == "table" then
				if not bWeakK then
					CollectSingleObjectReferenceInMemory(strName .. ".[table:key.table]", k, cDumpInfoContainer)
				end

				if not bWeakV then
					CollectSingleObjectReferenceInMemory(strName .. ".[table:value]", v, cDumpInfoContainer)
				end
			elseif strKeyType == "function" then
				if not bWeakK then
					CollectSingleObjectReferenceInMemory(strName .. ".[table:key.function]", k, cDumpInfoContainer)
				end

				if not bWeakV then
					CollectSingleObjectReferenceInMemory(strName .. ".[table:value]", v, cDumpInfoContainer)
				end
			elseif strKeyType == "thread" then
				if not bWeakK then
					CollectSingleObjectReferenceInMemory(strName .. ".[table:key.thread]", k, cDumpInfoContainer)
				end

				if not bWeakV then
					CollectSingleObjectReferenceInMemory(strName .. ".[table:value]", v, cDumpInfoContainer)
				end
			elseif strKeyType == "userdata" then
				if not bWeakK then
					CollectSingleObjectReferenceInMemory(strName .. ".[table:key.userdata]", k, cDumpInfoContainer)
				end

				if not bWeakV then
					CollectSingleObjectReferenceInMemory(strName .. ".[table:value]", v, cDumpInfoContainer)
				end
			else
				CollectSingleObjectReferenceInMemory(strName .. "." .. k, v, cDumpInfoContainer)
			end
		end

		if cMt then
			CollectSingleObjectReferenceInMemory(strName .. ".[metatable]", cMt, cDumpInfoContainer)
		end
	elseif strType == "function" then
		local cDInfo = debug.getinfo(cObject, "Su")
		local cCombinedName = strName .. "[line:" .. tostring(cDInfo.linedefined) .. "@file:" .. cDInfo.short_src .. "]"

		if cExistTag[cObject] and not cNameAllAlias[cCombinedName] then
			cNameAllAlias[cCombinedName] = true
		end

		if cAccessTag[cObject] then
			return
		end

		cAccessTag[cObject] = true
		strName = strName .. "[line:" .. tostring(cDInfo.linedefined) .. "@file:" .. cDInfo.short_src .. "]"

		local nUpsNum = cDInfo.nups

		for i = 1, nUpsNum do
			local strUpName, cUpValue = debug.getupvalue(cObject, i)
			local strUpValueType = type(cUpValue)

			if strUpValueType == "table" then
				CollectSingleObjectReferenceInMemory(strName .. ".[ups:table:" .. strUpName .. "]", cUpValue, cDumpInfoContainer)
			elseif strUpValueType == "function" then
				CollectSingleObjectReferenceInMemory(strName .. ".[ups:function:" .. strUpName .. "]", cUpValue, cDumpInfoContainer)
			elseif strUpValueType == "thread" then
				CollectSingleObjectReferenceInMemory(strName .. ".[ups:thread:" .. strUpName .. "]", cUpValue, cDumpInfoContainer)
			elseif strUpValueType == "userdata" then
				CollectSingleObjectReferenceInMemory(strName .. ".[ups:userdata:" .. strUpName .. "]", cUpValue, cDumpInfoContainer)
			end
		end

		local cEnv = debug.getfenv(cObject)

		if cEnv then
			CollectSingleObjectReferenceInMemory(strName .. ".[function:environment]", cEnv, cDumpInfoContainer)
		end
	elseif strType == "thread" then
		if cExistTag[cObject] and not cNameAllAlias[strName] then
			cNameAllAlias[strName] = true
		end

		if cAccessTag[cObject] then
			return
		end

		cAccessTag[cObject] = true

		local cEnv = debug.getfenv(cObject)

		if cEnv then
			CollectSingleObjectReferenceInMemory(strName .. ".[thread:environment]", cEnv, cDumpInfoContainer)
		end

		local cMt = getmetatable(cObject)

		if cMt then
			CollectSingleObjectReferenceInMemory(strName .. ".[thread:metatable]", cMt, cDumpInfoContainer)
		end
	elseif strType == "userdata" then
		if cExistTag[cObject] and not cNameAllAlias[strName] then
			cNameAllAlias[strName] = true
		end

		if cAccessTag[cObject] then
			return
		end

		cAccessTag[cObject] = true

		local cEnv = debug.getfenv(cObject)

		if cEnv then
			CollectSingleObjectReferenceInMemory(strName .. ".[userdata:environment]", cEnv, cDumpInfoContainer)
		end

		local cMt = getmetatable(cObject)

		if cMt then
			CollectSingleObjectReferenceInMemory(strName .. ".[userdata:metatable]", cMt, cDumpInfoContainer)
		end
	end
end

local function OutputKeyInfo(cOutputer, keyInfo, keyStr, compareInfo)
	cOutputer("\n\n\n\n")
	cOutputer("-----------------------------------------------------------\n")
	cOutputer("-- " .. keyStr .. "创建信息 -------------------------------------------\n")
	cOutputer("-----------------------------------------------------------\n")

	for typeName, typeInfo in pairs(keyInfo) do
		local objectCount = typeInfo[1]

		cOutputer("Class:" .. typeName .. "\t" .. "创建" .. keyStr .. "次数:" .. objectCount .. "\t\n")
	end

	cOutputer("\n\n\n\n")
	cOutputer("-- 对象引用详细信息 -------------------------------------------\n")

	for typeName, typeInfo in pairs(keyInfo) do
		local objectCount = typeInfo[1]

		cOutputer("Class:" .. typeName .. "\t" .. "创建" .. keyStr .. "次数:" .. objectCount .. "\t\n")

		for c, infos in pairs(typeInfo) do
			if c ~= 1 then
				cOutputer(keyStr .. GetOriginalToStringResult(c) .. " 引用次数:" .. #infos .. "\t\n")

				for index, referStr in pairs(infos) do
					cOutputer("++++++++" .. referStr .. "\n")
				end
			end
		end
	end

	print("zh---------------------", keyStr, compareInfo)

	if compareInfo then
		cOutputer("\n\n\n\n")
		cOutputer("-- " .. keyStr .. "对比信息 -------------------------------------------\n")

		for typeName, typeInfo in pairs(keyInfo) do
			local nowCount = typeInfo[1]
			local preCount = 0

			if compareInfo[typeName] then
				preCount = compareInfo[typeName][1]
			end

			if preCount < nowCount then
				cOutputer(keyStr .. ":" .. typeName .. "\t" .. "原" .. keyStr .. "次数:" .. preCount .. " 现在" .. keyStr .. "次数:" .. nowCount .. " 改变值:" .. nowCount - preCount .. "\t\n")
			end
		end
	end
end

local function OutputMemorySnapshot(strSavePath, strExtraFileName, nMaxRescords, strRootObjectName, cRootObject, cDumpInfoResultsBase, cDumpInfoResults, preTableInfo, preFuncInfo, preUserdataInfo)
	if not cDumpInfoResults then
		return
	end

	local strDateTime = FormatDateTimeNow()
	local cRefInfoBase = cDumpInfoResultsBase and cDumpInfoResultsBase.m_cObjectReferenceCount or nil
	local cNameInfoBase = cDumpInfoResultsBase and cDumpInfoResultsBase.m_cObjectAddressToName or nil
	local cRefInfo = cDumpInfoResults.m_cObjectReferenceCount
	local cNameInfo = cDumpInfoResults.m_cObjectAddressToName
	local cTypeTableInfo = cDumpInfoResults.m_cTypeTableContainer
	local cFuncCountInfo = cDumpInfoResults.m_cFuncCountContainer
	local cUserdataInfo = cDumpInfoResults.m_cUserdataInfoContainer
	local cRes = {}
	local nIdx = 0

	for k in pairs(cRefInfo) do
		nIdx = nIdx + 1
		cRes[nIdx] = k
	end

	table.sort(cRes, function(l, r)
		return cRefInfo[l] > cRefInfo[r]
	end)

	local bOutputFile = strSavePath and string.len(strSavePath) > 0
	local cOutputHandle
	local cOutputEntry = print

	if bOutputFile then
		local strAffix = string.sub(strSavePath, -1)

		if strAffix ~= "/" and strAffix ~= "\\" then
			strSavePath = strSavePath .. "/"
		end

		local strFileName = strSavePath .. "LuaMemRefInfo-All"

		if not strExtraFileName or string.len(strExtraFileName) == 0 then
			strFileName = strFileName .. "-[" .. strDateTime .. "].txt"
		else
			strFileName = strFileName .. "-[" .. strDateTime .. "]-[" .. strExtraFileName .. "].txt"
		end

		local cFile = assert(io.open(strFileName, "w"))

		cOutputHandle = cFile
		cOutputEntry = cFile.write
	end

	local function cOutputer(strContent)
		if cOutputHandle then
			cOutputEntry(cOutputHandle, strContent)
		else
			cOutputEntry(strContent)
		end
	end

	if cDumpInfoResultsBase then
		cOutputer("--------------------------------------------------------\n")
		cOutputer("-- This is compared memory information.\n")
		cOutputer("--------------------------------------------------------\n")
		cOutputer("-- Collect base memory reference at line:" .. tostring(cDumpInfoResultsBase.m_nCurrentLine) .. "@file:" .. cDumpInfoResultsBase.m_strShortSrc .. "\n")
		cOutputer("-- Collect compared memory reference at line:" .. tostring(cDumpInfoResults.m_nCurrentLine) .. "@file:" .. cDumpInfoResults.m_strShortSrc .. "\n")
	else
		cOutputer("--------------------------------------------------------\n")
		cOutputer("-- Collect memory reference at line:" .. tostring(cDumpInfoResults.m_nCurrentLine) .. "@file:" .. cDumpInfoResults.m_strShortSrc .. "\n")
	end

	cOutputer("--------------------------------------------------------\n")
	cOutputer("-- [Table/Function Address/Name]\t[Reference Count]\n")
	cOutputer("--------------------------------------------------------\n")

	if strRootObjectName and cRootObject then
		cOutputer("-- From Root Object: " .. GetOriginalToStringResult(cRootObject) .. " (" .. strRootObjectName .. ")\n")
	end

	for i, v in ipairs(cRes) do
		if not cDumpInfoResultsBase or not cRefInfoBase[v] then
			if nMaxRescords > 0 then
				if i <= nMaxRescords then
					cOutputer(GetOriginalToStringResult(v) .. "\t" .. cNameInfo[v] .. "\t" .. tostring(cRefInfo[v]) .. "\n")
				end
			else
				cOutputer(GetOriginalToStringResult(v) .. "\t" .. cNameInfo[v] .. "\t" .. tostring(cRefInfo[v]) .. "\n")
			end
		end
	end

	OutputKeyInfo(cOutputer, cTypeTableInfo, "对象", preTableInfo)
	OutputKeyInfo(cOutputer, cFuncCountInfo, "函数", preFuncInfo)
	OutputKeyInfo(cOutputer, cUserdataInfo, "C#对象", preUserdataInfo)

	if bOutputFile then
		io.close(cOutputHandle)
	end
end

local function OutputMemorySnapshotSingleObject(strSavePath, strExtraFileName, nMaxRescords, cDumpInfoResults)
	if not cDumpInfoResults then
		return
	end

	local strDateTime = FormatDateTimeNow()
	local cObjectAliasName = cDumpInfoResults.m_cObjectAliasName
	local bOutputFile = strSavePath and string.len(strSavePath) > 0
	local cOutputHandle
	local cOutputEntry = print

	if bOutputFile then
		local strAffix = string.sub(strSavePath, -1)

		if strAffix ~= "/" and strAffix ~= "\\" then
			strSavePath = strSavePath .. "/"
		end

		local strFileName = strSavePath .. "LuaMemRefInfo-Single"

		if not strExtraFileName or string.len(strExtraFileName) == 0 then
			strFileName = strFileName .. "-[" .. strDateTime .. "].txt"
		else
			strFileName = strFileName .. "-[" .. strDateTime .. "]-[" .. strExtraFileName .. "].txt"
		end

		local cFile = assert(io.open(strFileName, "w"))

		cOutputHandle = cFile
		cOutputEntry = cFile.write
	end

	local function cOutputer(strContent)
		if cOutputHandle then
			cOutputEntry(cOutputHandle, strContent)
		else
			cOutputEntry(strContent)
		end
	end

	cOutputer("--------------------------------------------------------\n")
	cOutputer("-- Collect single object memory reference at line:" .. tostring(cDumpInfoResults.m_nCurrentLine) .. "@file:" .. cDumpInfoResults.m_strShortSrc .. "\n")
	cOutputer("--------------------------------------------------------\n")

	local nCount = 0

	for k in pairs(cObjectAliasName) do
		nCount = nCount + 1
	end

	cOutputer("-- For Object: " .. cDumpInfoResults.m_strAddressName .. " (" .. cDumpInfoResults.m_strObjectName .. "), have " .. tostring(nCount) .. " reference in total.\n")
	cOutputer("--------------------------------------------------------\n")

	for k in pairs(cObjectAliasName) do
		if nMaxRescords > 0 then
			if nMaxRescords >= i then
				cOutputer(k .. "\n")
			end
		else
			cOutputer(k .. "\n")
		end
	end

	if bOutputFile then
		io.close(cOutputHandle)
	end
end

local function OutputFilteredResult(strFilePath, strFilter, bIncludeFilter, bOutputFile)
	if not strFilePath or string.len(strFilePath) == 0 then
		print("You need to specify a file path.")

		return
	end

	if not strFilter or string.len(strFilter) == 0 then
		print("You need to specify a filter string.")

		return
	end

	local cFilteredResult = {}

	for strLine in io.lines(strFilePath) do
		local nBegin, nEnd = string.find(strLine, strFilter)

		if nBegin and nEnd then
			if bIncludeFilter then
				table.insert(cFilteredResult, strLine)
			end
		elseif not bIncludeFilter then
			table.insert(cFilteredResult, strLine)
		end
	end

	local cOutputHandle
	local cOutputEntry = print

	if bOutputFile then
		local _, _, strResFileName = string.find(strFilePath, "(.*)%.txt")

		strResFileName = strResFileName .. "-Filter-" .. (bIncludeFilter and "I" or "E") .. "-[" .. strFilter .. "].txt"

		local cFile = assert(io.open(strResFileName, "w"))

		cOutputHandle = cFile
		cOutputEntry = cFile.write
	end

	local function cOutputer(strContent)
		if cOutputHandle then
			cOutputEntry(cOutputHandle, strContent)
		else
			cOutputEntry(strContent)
		end
	end

	for i, v in ipairs(cFilteredResult) do
		cOutputer(v .. "\n")
	end

	if bOutputFile then
		io.close(cOutputHandle)
	end
end

local function DumpMemorySnapshot(strSavePath, strExtraFileName, nMaxRescords, strRootObjectName, cRootObject, preTableInfo, preFuncInfo, preUserdataInfo)
	local strDateTime = FormatDateTimeNow()

	if cRootObject then
		if not strRootObjectName or string.len(strRootObjectName) == 0 then
			strRootObjectName = tostring(cRootObject)
		end
	else
		cRootObject = debug.getregistry()
		strRootObjectName = "registry"
	end

	local cDumpInfoContainer = CreateObjectReferenceInfoContainer()
	local cStackInfo = debug.getinfo(2, "Sl")

	if cStackInfo then
		cDumpInfoContainer.m_strShortSrc = cStackInfo.short_src
		cDumpInfoContainer.m_nCurrentLine = cStackInfo.currentline
	end

	CollectObjectReferenceInMemory(strRootObjectName, cRootObject, cDumpInfoContainer)
	OutputMemorySnapshot(strSavePath, strExtraFileName, nMaxRescords, strRootObjectName, cRootObject, nil, cDumpInfoContainer, preTableInfo, preFuncInfo, preUserdataInfo)

	local cTypeTableInfo = cDumpInfoContainer.m_cTypeTableContainer
	local outTableInfo = {}

	for typeName, typeInfo in pairs(cTypeTableInfo) do
		outTableInfo[typeName] = {}
		outTableInfo[typeName][1] = typeInfo[1]
	end

	local cFuncCountInfo = cDumpInfoContainer.m_cFuncCountContainer
	local outFuncInfo = {}

	for typeName, typeInfo in pairs(cFuncCountInfo) do
		outFuncInfo[typeName] = {}
		outFuncInfo[typeName][1] = typeInfo[1]
	end

	local cUserdataInfo = cDumpInfoContainer.m_cUserdataInfoContainer
	local outUserdataInfo = {}

	for typeName, typeInfo in pairs(cUserdataInfo) do
		outUserdataInfo[typeName] = {}
		outUserdataInfo[typeName][1] = typeInfo[1]
	end

	return outTableInfo, outFuncInfo, outUserdataInfo
end

local function DumpMemorySnapshotCompared(strSavePath, strExtraFileName, nMaxRescords, cResultBefore, cResultAfter)
	OutputMemorySnapshot(strSavePath, strExtraFileName, nMaxRescords, nil, nil, cResultBefore, cResultAfter)
end

local function DumpMemorySnapshotComparedFile(strSavePath, strExtraFileName, nMaxRescords, strResultFilePathBefore, strResultFilePathAfter)
	local cResultBefore = CreateObjectReferenceInfoContainerFromFile(strResultFilePathBefore)
	local cResultAfter = CreateObjectReferenceInfoContainerFromFile(strResultFilePathAfter)

	OutputMemorySnapshot(strSavePath, strExtraFileName, nMaxRescords, nil, nil, cResultBefore, cResultAfter)
end

local function DumpMemorySnapshotSingleObject(strSavePath, strExtraFileName, nMaxRescords, strObjectName, cObject)
	if not cObject then
		return
	end

	if not strObjectName or string.len(strObjectName) == 0 then
		strObjectName = GetOriginalToStringResult(cObject)
	end

	local strDateTime = FormatDateTimeNow()
	local cDumpInfoContainer = CreateSingleObjectReferenceInfoContainer(strObjectName, cObject)
	local cStackInfo = debug.getinfo(2, "Sl")

	if cStackInfo then
		cDumpInfoContainer.m_strShortSrc = cStackInfo.short_src
		cDumpInfoContainer.m_nCurrentLine = cStackInfo.currentline
	end

	CollectSingleObjectReferenceInMemory("registry", debug.getregistry(), cDumpInfoContainer)
	OutputMemorySnapshotSingleObject(strSavePath, strExtraFileName, nMaxRescords, cDumpInfoContainer)
end

cPublications.m_cMethods.DumpMemorySnapshot = DumpMemorySnapshot
cPublications.m_cMethods.DumpMemorySnapshotCompared = DumpMemorySnapshotCompared
cPublications.m_cMethods.DumpMemorySnapshotComparedFile = DumpMemorySnapshotComparedFile
cPublications.m_cMethods.DumpMemorySnapshotSingleObject = DumpMemorySnapshotSingleObject
cPublications.m_cHelpers.FormatDateTimeNow = FormatDateTimeNow
cPublications.m_cHelpers.GetOriginalToStringResult = GetOriginalToStringResult
cPublications.m_cBases.CreateObjectReferenceInfoContainer = CreateObjectReferenceInfoContainer
cPublications.m_cBases.CreateObjectReferenceInfoContainerFromFile = CreateObjectReferenceInfoContainerFromFile
cPublications.m_cBases.CreateSingleObjectReferenceInfoContainer = CreateSingleObjectReferenceInfoContainer
cPublications.m_cBases.CollectObjectReferenceInMemory = CollectObjectReferenceInMemory
cPublications.m_cBases.CollectSingleObjectReferenceInMemory = CollectSingleObjectReferenceInMemory
cPublications.m_cBases.OutputMemorySnapshot = OutputMemorySnapshot
cPublications.m_cBases.OutputMemorySnapshotSingleObject = OutputMemorySnapshotSingleObject
cPublications.m_cBases.OutputFilteredResult = OutputFilteredResult

return cPublications
