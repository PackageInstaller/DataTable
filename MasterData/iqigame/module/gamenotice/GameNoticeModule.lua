-- chunkname: @IQIGame\\Module\\GameNotice\\GameNoticeModule.lua

local json = require("Util.json")

GameNoticeModule = {}

function GameNoticeModule.Initialize()
	GameNoticeModule.__InitPayActiveNoticeRecord()
end

function GameNoticeModule.ShutDown()
	GameNoticeModule.SavePayActiveNoticeTag()
end

function GameNoticeModule.GetNotice(type)
	local data = NoticeData.New()

	data.types = type

	local jsonStr = LoginModule.CreateLoginParam(data)
	local url = LoginModule.GetRequestUrl(Constant.LoginConst.NoticeUrl)

	HttpModule.RequestPost(url, jsonStr, GameNoticeModule.OnSendNoticeSucceed, GameNoticeModule.OnSendNoticeFailed)
end

function GameNoticeModule.OnSendNoticeSucceed(serverResponse)
	local response = json.decode(LoginModule.HttpDecrypt(serverResponse))

	if response.code ~= 0 then
		warning("Send Notice error : " .. getErrorMsg(response.code))
	elseif response.data.notices ~= "" then
		EventDispatcher.Dispatch(EventID.GetNoticeResultEvent, response.data.notices)
	end
end

function GameNoticeModule.OnSendNoticeFailed(serverResponse)
	warning("Send Notice error : " .. serverResponse)
end

function GameNoticeModule.GetPayActiveNoticeList()
	local cfgList = {}

	ForPairs(CfgPayActivityTable, function(_cid, _cfg)
		if not GameNoticeModule.__CheckPayActiveItem(_cfg) then
			return
		end

		table.insert(cfgList, _cfg)
	end)
	table.sort(cfgList, function(a, b)
		return a.Order < b.Order
	end)

	return cfgList
end

function GameNoticeModule.CheckActivityBtnShow(activityCid)
	local activityCfg = CfgPayActivityTable[activityCid]

	if activityCfg == nil then
		return false
	end

	return GameNoticeModule.__CheckPayActiveItem(activityCfg)
end

function GameNoticeModule.__CheckPayActiveItem(itemConfig)
	if itemConfig.Type ~= 2 then
		return false
	end

	local _showConditionCid = TryToNumber(itemConfig.ShowCondition, 0)

	if not ConditionModule.Check(_showConditionCid) then
		return false
	end

	if LuaUtility.StrIsNullOrEmpty(itemConfig.OpenTime) then
		return true
	end

	local serverTime = PlayerModule.GetServerTime()
	local openTime = cfgDateTimeToTimeStamp(itemConfig.OpenTime)
	local closeTime = cfgDateTimeToTimeStamp(itemConfig.OpenTime) + itemConfig.Duration[1]

	if openTime < serverTime and serverTime < closeTime then
		return true
	end

	return false
end

function GameNoticeModule.__InitPayActiveNoticeRecord()
	GameNoticeModule.__PayActiveRecordData = {}

	local recordStr = PlayerPrefsUtil.GetString(PlayerModule.GetPlayerPid(), Constant.PlayerPrefsConst.PayActiveRecordData)

	if LuaUtility.StrIsNullOrEmpty(recordStr) then
		return
	end

	local recordDataList = string.split(recordStr, "|")

	ForArray(recordDataList, function(_, _cidStr)
		local cid = TryToNumber(_cidStr, 0)

		GameNoticeModule.__PayActiveRecordData[cid] = true
	end)
end

function GameNoticeModule.UpdatePayActiveNoticeTag(cid)
	if GameNoticeModule.__PayActiveRecordData[cid] == true then
		return
	end

	GameNoticeModule.__PayActiveRecordData[cid] = true
	GameNoticeModule.__SavePayActiveRecordData = true
end

function GameNoticeModule.SavePayActiveNoticeTag()
	if not GameNoticeModule.__SavePayActiveRecordData then
		return
	end

	GameNoticeModule.__SavePayActiveRecordData = false

	local recordStr = ""

	ForPairs(WarlockModule.__PayActiveRecordData, function(_cid, _)
		if LuaUtility.StrIsNullOrEmpty(recordStr) then
			recordStr = tostring(_cid)
		else
			recordStr = recordStr .. "|" .. tostring(_cid)
		end
	end)
	PlayerPrefsUtil.SetString(PlayerModule.GetPlayerPid(), Constant.PlayerPrefsConst.PayActiveRecordData, recordStr)
	PlayerPrefsUtil.Save()
end

function GameNoticeModule.GetPayActiveNoticeNewTag(cfgCid)
	return not GameNoticeModule.__PayActiveRecordData[cfgCid] == true
end
