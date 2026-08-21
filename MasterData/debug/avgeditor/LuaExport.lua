-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Debug\\AVGEditor\\LuaExport.lua

local LuaExport = {}

if not IsGLDeclared("LuaExport") or not LuaExport then
	GLDeclare("LuaExport", LuaExport)
end

function LuaExport.convertLuaToJSON(tablePath, tableName, outputPath)
	local resTable = require(tablePath)
	local json = require("Debug/AVGEditor/dkjson")
	local str = json.encode(resTable, {
		indent = true
	})
	local filePath = outputPath .. tableName .. ".json"
	local file = io.open(filePath, "w")

	io.output(file)
	io.write(str)
	io.close()
end

function LuaExport.updateLuaData(...)
	local outputPath = "Assets/Code/CSharpCode/Framework/Accelerator/Editor/LuaResExport/.ResJson/"

	for i, path in ipairs({
		...
	}) do
		local names = utils.splitString(path, "/")
		local name = names[#names]

		LuaExport.convertLuaToJSON("ClientData/" .. path, name, outputPath)
	end
end

local function genAVGNPCName(talkNameDic, sourceData, ResTalkNpc)
	local function addDict(talk, npc_id, section_key)
		if talk then
			if npc_id then
				local npc = ResTalkNpc[npc_id]

				if npc == nil then
					-- block empty
				else
					talkNameDic[talk] = {}
					talkNameDic[talk].npc_name = npc.name

					if section_key then
						talkNameDic[talk].section_key = section_key
					else
						talkNameDic[talk].section_key = "0"
					end
				end
			else
				talkNameDic[talk] = {}
				talkNameDic[talk].npc_name = "旁白"

				if section_key then
					talkNameDic[talk].section_key = section_key
				else
					talkNameDic[talk].section_key = "0"
				end
			end
		end
	end

	local function convertKey(id)
		if id then
			return math.modf(id / 1000) .. "_" .. math.fmod(id, 1000)
		else
			return 0
		end
	end

	for _, talkInfo in pairs(sourceData) do
		addDict(talkInfo.talk, talkInfo.npc_id, convertKey(talkInfo.id))

		if talkInfo.branch_info then
			for branchKey, branchValue in pairs(talkInfo.branch_info) do
				local section_key = convertKey(talkInfo.id) .. "_Opt_" .. branchKey

				addDict(branchValue.branch_content, talkInfo.npc_id, section_key)
			end
		end
	end
end

function LuaExport.updateAVGNPCName()
	local outputPath = "Misc/Localization/JsonConfig/TalkNameDic.json"
	local AVGInfo = require("UI/AVG/AVGInfo")
	local editorData, excelData = AVGInfo:getRawAVGData("ResTalk")
	local ResTalkNpc = require("ClientData/ResTalkNpc")
	local talkNameDic = {}

	genAVGNPCName(talkNameDic, editorData, ResTalkNpc)
	genAVGNPCName(talkNameDic, excelData, ResTalkNpc)

	local talkNameJson = ClientUtils.table2String(talkNameDic)
	local file = io.open(outputPath, "w")

	file:write(talkNameJson)
	file:close()
end

local function deepCompare(t1, t2, ignore_mt)
	local ty1 = type(t1)
	local ty2 = type(t2)

	if ty1 ~= ty2 then
		return false
	end

	if ty1 ~= "table" and ty2 ~= "table" then
		return t1 == t2
	end

	local mt = getmetatable(t1)

	if not ignore_mt and mt and mt.__eq then
		return t1 == t2
	end

	for k1, v1 in pairs(t1) do
		local v2 = t2[k1]

		if v2 == nil or not deepCompare(v1, v2) then
			return false
		end
	end

	return true
end

return LuaExport
