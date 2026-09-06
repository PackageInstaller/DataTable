-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/aounity-framework/Scripts/Lua/frameworkext/debug/MemoryReferenceInfo.lua

local cConfig = {
	m_bComparedMemoryRefFileAddTime = true,
	m_bSingleMemoryRefFileAddTime = true,
	m_bAllMemoryRefFileAddTime = true
}

local function FormatDateTimeNow()
	local cDateTime = os.date("*t")

	return (string.format("%04d%02d%02d-%02d%02d%02d", tostring(cDateTime.year), tostring(cDateTime.month), tostring(cDateTime.day), tostring(cDateTime.hour), tostring(cDateTime.min), tostring(cDateTime.sec)))
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
	local cFile = assert(io.open(strFilePath, "rb"))

	for strLine in cFile:lines() do
		local strHeader = string.sub(strLine, 1, 2)

		if strHeader ~= "--" then
			local _, _, strAddr, strName, strRefCount = string.find(strLine, "(.+)\t(.*)\t(%d+)")

			if strAddr then
				cRefInfo[strAddr] = strRefCount
				cNameInfo[strAddr] = strName
			end
		end
	end

	io.close(cFile)

	cFile = nil

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
	cContainer.m_strAddressName = type(cObject) == "string" and "\"" .. tostring(cObject) .. "\"" or GetOriginalToStringResult(cObject)
	cContainer.m_cObjectExistTag[cObject] = true

	return cContainer
end

local builtinNames = {
	[_G] = "_G",
	[_G.package.loaded] = "_G.package.loaded"
}

setmetatable(builtinNames, {
	__mode = "k"
})

local function ConvertBuiltinName(strName, cObject)
	local newName = builtinNames[cObject]

	if newName then
		return newName
	end

	return strName
end

local function CollectObjectReferenceInMemory(strName, cObject, cDumpInfoContainer)
	if not cObject then
		return
	end

	strName = strName or ""
	strName = ConvertBuiltinName(strName, cObject)
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

		if cRefInfoContainer[cObject] then
			cRefInfoContainer[cObject] = cRefInfoContainer[cObject] + 1 or 1
		end

		if cNameInfoContainer[cObject] then
			if string.len(strName) < string.len(cNameInfoContainer[cObject]) then
				cNameInfoContainer[cObject] = strName
			end

			return
		end

		cNameInfoContainer[cObject] = strName

		for k, v in pairs(cObject) do
			local strKeyType = type(k)

			if strKeyType == "table" then
				if not bWeakK then
					CollectObjectReferenceInMemory(strName .. ".[table:key.table]", k, cDumpInfoContainer)
				end

				if not bWeakV then
					CollectObjectReferenceInMemory(strName .. ".[table:value]", v, cDumpInfoContainer)
				end
			elseif strKeyType == "function" then
				if not bWeakK then
					CollectObjectReferenceInMemory(strName .. ".[table:key.function]", k, cDumpInfoContainer)
				end

				if not bWeakV then
					CollectObjectReferenceInMemory(strName .. ".[table:value]", v, cDumpInfoContainer)
				end
			elseif strKeyType == "thread" then
				if not bWeakK then
					CollectObjectReferenceInMemory(strName .. ".[table:key.thread]", k, cDumpInfoContainer)
				end

				if not bWeakV then
					CollectObjectReferenceInMemory(strName .. ".[table:value]", v, cDumpInfoContainer)
				end
			elseif strKeyType == "userdata" then
				if not bWeakK then
					CollectObjectReferenceInMemory(strName .. ".[table:key.userdata]", k, cDumpInfoContainer)
				end

				if not bWeakV then
					CollectObjectReferenceInMemory(strName .. ".[table:value]", v, cDumpInfoContainer)
				end
			else
				CollectObjectReferenceInMemory(strName .. "." .. k, v, cDumpInfoContainer)
			end
		end

		if cMt then
			CollectObjectReferenceInMemory(strName .. ".[metatable]", cMt, cDumpInfoContainer)
		end
	elseif strType == "function" then
		local cDInfo = debug.getinfo(cObject, "Su")

		if cRefInfoContainer[cObject] then
			cRefInfoContainer[cObject] = cRefInfoContainer[cObject] + 1 or 1
		end

		local strNameAndSufix = strName .. "[line:" .. tostring(cDInfo.linedefined) .. "@file:" .. cDInfo.short_src .. "]"

		if cNameInfoContainer[cObject] then
			if string.len(strNameAndSufix) < string.len(cNameInfoContainer[cObject]) then
				cNameInfoContainer[cObject] = strNameAndSufix
			end

			return
		end

		cNameInfoContainer[cObject] = strNameAndSufix

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

		local getfenv = debug.getfenv

		if getfenv then
			local cEnv = debug.getfenv(cObject)

			if cEnv then
				CollectObjectReferenceInMemory(strName .. ".[function:environment]", cEnv, cDumpInfoContainer)
			end
		end
	elseif strType == "thread" then
		if cRefInfoContainer[cObject] then
			cRefInfoContainer[cObject] = cRefInfoContainer[cObject] + 1 or 1
		end

		if cNameInfoContainer[cObject] then
			if string.len(strName) < string.len(cNameInfoContainer[cObject]) then
				cNameInfoContainer[cObject] = strName
			end

			return
		end

		cNameInfoContainer[cObject] = strName

		local getfenv = debug.getfenv

		if getfenv then
			local cEnv = debug.getfenv(cObject)

			if cEnv then
				CollectObjectReferenceInMemory(strName .. ".[thread:environment]", cEnv, cDumpInfoContainer)
			end
		end

		local cMt = getmetatable(cObject)

		if cMt then
			CollectObjectReferenceInMemory(strName .. ".[thread:metatable]", cMt, cDumpInfoContainer)
		end
	elseif strType == "userdata" then
		if cRefInfoContainer[cObject] then
			cRefInfoContainer[cObject] = cRefInfoContainer[cObject] + 1 or 1
		end

		if cNameInfoContainer[cObject] then
			if string.len(strName) < string.len(cNameInfoContainer[cObject]) then
				cNameInfoContainer[cObject] = strName
			end

			return
		end

		cNameInfoContainer[cObject] = strName

		local getfenv = debug.getfenv

		if getfenv then
			local cEnv = debug.getfenv(cObject)

			if cEnv then
				CollectObjectReferenceInMemory(strName .. ".[userdata:environment]", cEnv, cDumpInfoContainer)
			end
		end

		local cMt = getmetatable(cObject)

		if cMt then
			CollectObjectReferenceInMemory(strName .. ".[userdata:metatable]", cMt, cDumpInfoContainer)
		end
	elseif strType == "string" then
		if cRefInfoContainer[cObject] then
			cRefInfoContainer[cObject] = cRefInfoContainer[cObject] + 1 or 1
		end

		local strNameAndSufix2 = strName .. "[" .. strType .. "]"

		if cNameInfoContainer[cObject] then
			if string.len(strNameAndSufix2) < string.len(cNameInfoContainer[cObject]) then
				cNameInfoContainer[cObject] = strNameAndSufix2
			end

			return
		end

		cNameInfoContainer[cObject] = strNameAndSufix2
	end
end

local function CollectSingleObjectReferenceInMemory(strName, cObject, cDumpInfoContainer)
	if not cObject then
		return
	end

	strName = strName or ""
	strName = ConvertBuiltinName(strName, cObject)
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

		local getfenv = debug.getfenv

		if getfenv then
			local cEnv = debug.getfenv(cObject)

			if cEnv then
				CollectSingleObjectReferenceInMemory(strName .. ".[function:environment]", cEnv, cDumpInfoContainer)
			end
		end
	elseif strType == "thread" then
		if cExistTag[cObject] and not cNameAllAlias[strName] then
			cNameAllAlias[strName] = true
		end

		if cAccessTag[cObject] then
			return
		end

		cAccessTag[cObject] = true

		local getfenv = debug.getfenv

		if getfenv then
			local cEnv = debug.getfenv(cObject)

			if cEnv then
				CollectSingleObjectReferenceInMemory(strName .. ".[thread:environment]", cEnv, cDumpInfoContainer)
			end
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

		local getfenv = debug.getfenv

		if getfenv then
			local cEnv = debug.getfenv(cObject)

			if cEnv then
				CollectSingleObjectReferenceInMemory(strName .. ".[userdata:environment]", cEnv, cDumpInfoContainer)
			end
		end

		local cMt = getmetatable(cObject)

		if cMt then
			CollectSingleObjectReferenceInMemory(strName .. ".[userdata:metatable]", cMt, cDumpInfoContainer)
		end
	elseif strType == "string" then
		if cExistTag[cObject] and not cNameAllAlias[strName] then
			cNameAllAlias[strName] = true
		end

		if cAccessTag[cObject] then
			return
		end

		cAccessTag[cObject] = true
	end
end

local function OutputMemorySnapshot(strSavePath, strExtraFileName, nMaxRescords, strRootObjectName, cRootObject, cDumpInfoResultsBase, cDumpInfoResults)
	if not cDumpInfoResults then
		return
	end

	local strDateTime = FormatDateTimeNow()

	if cDumpInfoResultsBase then
		if not cDumpInfoResultsBase.m_cObjectReferenceCount then
			local cRefInfoBase

			if cDumpInfoResultsBase then
				if not cDumpInfoResultsBase.m_cObjectAddressToName then
					local cNameInfoBase
					local cRefInfo = cDumpInfoResults.m_cObjectReferenceCount
					local cNameInfo = cDumpInfoResults.m_cObjectAddressToName
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

						if not strExtraFileName or string.len(strExtraFileName) == 0 then
							strExtraFileName = "snapshot[" .. strDateTime .. "].txt"
						end

						local strFileName = strSavePath .. strExtraFileName
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
					cOutputer("-- [Table/Function/String Address/Name]\t[Reference Path]\t[Reference Count]\n")
					cOutputer("--------------------------------------------------------\n")

					if strRootObjectName and cRootObject then
						if type(cRootObject) == "string" then
							cOutputer("-- From Root Object: \"" .. tostring(cRootObject) .. "\" (" .. strRootObjectName .. ")\n")
						else
							cOutputer("-- From Root Object: " .. GetOriginalToStringResult(cRootObject) .. " (" .. strRootObjectName .. ")\n")
						end
					end

					for i, v in ipairs(cRes) do
						if not cDumpInfoResultsBase or not cRefInfoBase[v] then
							if nMaxRescords > 0 then
								if i <= nMaxRescords then
									if type(v) == "string" then
										local strOrgString = tostring(v)
										local nPattenBegin, nPattenEnd = string.find(strOrgString, "string: \".*\"")

										if not cDumpInfoResultsBase and (nPattenBegin == nil or nPattenEnd == nil) then
											local strRepString = string.gsub(strOrgString, "([\n\r])", "\\n")

											cOutputer("string: \"" .. strRepString .. "\"\t" .. cNameInfo[v] .. "\t" .. tostring(cRefInfo[v]) .. "\n")
										else
											cOutputer(tostring(v) .. "\t" .. cNameInfo[v] .. "\t" .. tostring(cRefInfo[v]) .. "\n")
										end
									else
										cOutputer(GetOriginalToStringResult(v) .. "\t" .. cNameInfo[v] .. "\t" .. tostring(cRefInfo[v]) .. "\n")
									end
								end
							elseif type(v) == "string" then
								local strOrgString = tostring(v)
								local nPattenBegin, nPattenEnd = string.find(strOrgString, "string: \".*\"")

								if not cDumpInfoResultsBase and (nPattenBegin == nil or nPattenEnd == nil) then
									local strRepString = string.gsub(strOrgString, "([\n\r])", "\\n")

									cOutputer("string: \"" .. strRepString .. "\"\t" .. cNameInfo[v] .. "\t" .. tostring(cRefInfo[v]) .. "\n")
								else
									cOutputer(tostring(v) .. "\t" .. cNameInfo[v] .. "\t" .. tostring(cRefInfo[v]) .. "\n")
								end
							else
								cOutputer(GetOriginalToStringResult(v) .. "\t" .. cNameInfo[v] .. "\t" .. tostring(cRefInfo[v]) .. "\n")
							end
						end
					end

					if bOutputFile then
						io.close(cOutputHandle)

						cOutputHandle = nil
					end
				end
			end
		end
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

		if not strExtraFileName or string.len(strExtraFileName) == 0 then
			strExtraFileName = "snapshot[" .. strDateTime .. "].txt"
		end

		local strFileName = strSavePath .. strExtraFileName
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
			if k <= nMaxRescords then
				cOutputer(k .. "\n")
			end
		else
			cOutputer(k .. "\n")
		end
	end

	if bOutputFile then
		io.close(cOutputHandle)

		cOutputHandle = nil
	end
end

local cPublications = {
	m_cMethods = {},
	m_cHelpers = {},
	m_cBases = {}
}

cPublications.m_cConfig = cConfig

function cPublications.m_cMethods.DumpMemorySnapshot(strSavePath, strExtraFileName, nMaxRescords, strRootObjectName, cRootObject)
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
	OutputMemorySnapshot(strSavePath, strExtraFileName, nMaxRescords, strRootObjectName, cRootObject, nil, cDumpInfoContainer)
end

function cPublications.m_cMethods.DumpMemorySnapshotCompared(strSavePath, strExtraFileName, nMaxRescords, cResultBefore, cResultAfter)
	OutputMemorySnapshot(strSavePath, strExtraFileName, nMaxRescords, nil, nil, cResultBefore, cResultAfter)
end

function cPublications.m_cMethods.DumpMemorySnapshotComparedFile(strSavePath, strExtraFileName, nMaxRescords, strResultFilePathBefore, strResultFilePathAfter)
	local cResultBefore = CreateObjectReferenceInfoContainerFromFile(strResultFilePathBefore)
	local cResultAfter = CreateObjectReferenceInfoContainerFromFile(strResultFilePathAfter)

	OutputMemorySnapshot(strSavePath, strExtraFileName, nMaxRescords, nil, nil, cResultBefore, cResultAfter)
end

function cPublications.m_cMethods.DumpMemorySnapshotSingleObject(strSavePath, strExtraFileName, nMaxRescords, strObjectName, cObject)
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

cPublications.m_cHelpers.FormatDateTimeNow = FormatDateTimeNow
cPublications.m_cHelpers.GetOriginalToStringResult = GetOriginalToStringResult
cPublications.m_cBases.CreateObjectReferenceInfoContainer = CreateObjectReferenceInfoContainer
cPublications.m_cBases.CreateObjectReferenceInfoContainerFromFile = CreateObjectReferenceInfoContainerFromFile
cPublications.m_cBases.CreateSingleObjectReferenceInfoContainer = CreateSingleObjectReferenceInfoContainer
cPublications.m_cBases.CollectObjectReferenceInMemory = CollectObjectReferenceInMemory
cPublications.m_cBases.CollectSingleObjectReferenceInMemory = CollectSingleObjectReferenceInMemory
cPublications.m_cBases.OutputMemorySnapshot = OutputMemorySnapshot
cPublications.m_cBases.OutputMemorySnapshotSingleObject = OutputMemorySnapshotSingleObject

function cPublications.m_cBases.OutputFilteredResult(strFilePath, strFilter, bIncludeFilter, bOutputFile)
	if not strFilePath or string.len(strFilePath) == 0 then
		print("You need to specify a file path.")

		return
	end

	if not strFilter or string.len(strFilter) == 0 then
		print("You need to specify a filter string.")

		return
	end

	local cFilteredResult = {}
	local cReadFile = assert(io.open(strFilePath, "rb"))

	for strLine in cReadFile:lines() do
		local nBegin, nEnd = string.find(strLine, strFilter)

		if nBegin and nEnd then
			if bIncludeFilter then
				nBegin, nEnd = string.find(strLine, "[\r\n]")

				if nBegin and nEnd and string.len(strLine) == nEnd then
					table.insert(cFilteredResult, string.sub(strLine, 1, nBegin - 1))
				else
					table.insert(cFilteredResult, strLine)
				end
			end
		elseif not bIncludeFilter then
			nBegin, nEnd = string.find(strLine, "[\r\n]")

			if nBegin and nEnd and string.len(strLine) == nEnd then
				table.insert(cFilteredResult, string.sub(strLine, 1, nBegin - 1))
			else
				table.insert(cFilteredResult, strLine)
			end
		end
	end

	io.close(cReadFile)

	cReadFile = nil

	local cOutputHandle
	local cOutputEntry = print

	if bOutputFile then
		local _, _, strResFileName = string.find(strFilePath, "(.*)%.txt")

		strResFileName = strResFileName .. "-filter-" .. (bIncludeFilter and "i" or "e") .. ".txt"

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

		cOutputHandle = nil
	end
end

rawset(_G, "lua_memory_inspector", cPublications)

return cPublications
