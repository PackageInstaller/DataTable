-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Debug\\Modules\\DebugGM.lua

local DebugConst = require("Debug/DebugConst")
local ResItem = require("ClientData/ResItem")
local UserData = require("Helper/UserData")
local BattleConst = require("Common/FrameBattle/BattleConst")
local RPC = require("Framework/RPC")
local tfcapi = require("libconapi")
local ChatService = require("Network/ChatService")
local PluginManager = require("SDK/Plugin/PluginManager")
local RemoteController = require("SDK/Plugin/RemoteController")
local LuaToolkit = Framework.Tools.LuaToolkit
local RemoteDebug = require("SDK/Plugin/RemoteDebug")
local Item = require("Common/Object/Item")
local SwitchServerHelper = require("Helper/SwitchServerHelper")
local EventConst = require("EventConst")
local DebugWebGM = require("Debug/Modules/DebugWebGM")
local DebugSetServerList = require("Debug/Modules/DebugSetServerList")
local DebugModule = {}
local BaseTips = require("UI/Control/Tips/BaseTips")
local tester_uid = ""

DebugModule.ENTRY_NAME = "GM指令"

function DebugModule.executeGM(sender, menu, value)
	if string.find(value, "//stage ") == 1 then
		local ResStage = require("ClientData/ResStage")
		local l = utils.splitString(value, " ")

		l[2] = tonumber(l[2])
		l[3] = tonumber(l[3])
		l[4] = tonumber(l[4])

		if ResStage[l[2]] and ResStage[l[2]][l[3]] and ResStage[l[2]][l[3]][l[4]] then
			local PerformManager = require("Logic/perform/PerformManager")

			PerformManager.preStory = ""

			UserData.saveCommonData("HookScriptStory", "")
		else
			MsgManager.notice("输入的关卡不合法，此关数据不存在，请重新输入")

			return
		end
	end

	if string.find(value, ",") then
		local args = utils.splitString(value, ",")
		local server = tonumber(args[2])

		RPC.executeGM(args[1], server)
	else
		RPC.executeGM(value)
	end
end

local function parseTime(strDate)
	local patternDate = "(%d+)-(%d+)-(%d+)"
	local patternTime = "(%d+):(%d+):(%d+)"
	local year, month, day = strDate:match(patternDate)
	local hour, min, sec = strDate:match(patternTime)

	return year, month, day, hour, min, sec
end

function DebugModule.setServerTime(sender, menu, strDateArgs)
	local cmdSetServerTime = {}
	local server
	local strDate = strDateArgs

	if string.find(strDateArgs, ",") then
		local args = utils.splitString(strDateArgs, ",")

		strDate = args[1]
		server = tonumber(args[2])
	end

	local year, month, day, hour, min, sec = parseTime(strDate)
	local now = os.date("*t", os.time())

	if hour and min and sec then
		local targetTime = os.time({
			day = day or now.day,
			year = year or now.year,
			month = month or now.month,
			hour = hour,
			min = min,
			sec = sec
		})
		local timeDev = os.difftime(targetTime, os.time())

		if server then
			RPC.executeGM("//time offset " .. timeDev, server)
		else
			RPC.executeGM("//time offset " .. timeDev)
		end
	end
end

function DebugModule.drawCard(sender, menu, value)
	RPC.executeGM("//item 510002 5")
	RPC.draw(Const.DrawTypeFree, 1)
end

function DebugModule.executeItem(sender, menu, value)
	local value = tonumber(value)

	if ResItem[value] then
		RPC.executeGM("//item " .. value .. " " .. (ResItem[value].piles or 10))
	end
end

function DebugModule.passDeposit(sender, menu, value)
	local value = tonumber(value)

	if value then
		RPC.executeGM("//deposit " .. value)
	end
end

function DebugModule.hideMenuBg(sender, menu, value)
	local MainMenuDlg = require("UI/MainMenu/MainMenuDlg")
	local ui = UIManager.getUI("mainMenu", nil, false)

	if MainMenuDlg.HideBg then
		MainMenuDlg.HideBg = false

		UserData.saveCommonData(BattleConst.INFO_SHOW_MENU_BG, "0")

		if ui then
			ui.panelBg:setVisible(true)
		end

		MsgManager.notice("切换到显示图片模式")
	else
		MainMenuDlg.HideBg = true

		UserData.saveCommonData(BattleConst.INFO_SHOW_MENU_BG, "1")

		if ui then
			ui.panelBg:setVisible(false)
		end

		MsgManager.notice("切换到显示场景模式")
	end
end

local function sendItemUpdate(tolog)
	local itemUpdateList = "更新背包 "
	local tmp = ""
	local qualitys = ""

	for k, v in ipairs(tolog) do
		if k > 1 then
			for i, value in ipairs(tolog[k]) do
				local colors = ""

				if itemUpdateList .. tolog[k][i].id then
					qualitys = ResItem[tolog[k][i].id].quality
					colors = qualitys == 2 and "<color=#228b22>" or qualitys == 3 and "<color=#009ad6>" or qualitys == 4 and "<color=#8552a1>" or qualitys == 5 and "<color=#fdb933>" or qualitys == 6 and "<color=#ea66a6>" or qualitys == 7 and "<color=#ef4136>" or "<color=#ffffff>"
					tmp = tmp .. colors .. ResItem[tolog[k][i].id].name .. "==>" .. tolog[k][i].num .. "</color>" .. ","
				end
			end
		end
	end

	MsgManager.notice(itemUpdateList .. tmp)
end

local function addListAttrNotify(tolog)
	local itemUpdateList = "获得道具 "
	local tmp = ""
	local qualitys = ""

	for k, v in ipairs(tolog) do
		if k == 2 then
			for j, coin in ipairs(tolog[k]) do
				if tolog[k][j].type then
					if tolog[k][j].type == "kRoleAttrResourceGold" then
						tmp = tmp .. "幸运币" .. "==>" .. tolog[k][j].value .. ","
					elseif tolog[k][j].type == "kRoleAttrResourceDiamond" or tolog[k][j].type == "kRoleAttrResourceDiamondBuy" then
						tmp = tmp .. "钻石" .. "==>" .. tolog[k][j].value .. ","
					end
				end
			end
		end

		if k == 3 then
			for i, value in ipairs(tolog[k]) do
				local colors = ""

				if tolog[k][i].id then
					qualitys = ResItem[tolog[k][i].id].quality
					colors = qualitys == 2 and "<color=#228b22>" or qualitys == 3 and "<color=#009ad6>" or qualitys == 4 and "<color=#8552a1>" or qualitys == 5 and "<color=#fdb933>" or qualitys == 6 and "<color=#ea66a6>" or qualitys == 7 and "<color=#ef4136>" or "<color=#ffffff>"
					tmp = tmp .. colors .. ResItem[tolog[k][i].id].name .. "==>" .. tolog[k][i].num .. "</color>" .. ","
				end
			end
		end
	end

	if tmp ~= "" then
		-- block empty
	end
end

local function RPC_dispatch(msgTable)
	EventCenter.sendEvent(EventConst.NETWORK_MESSAGE_RECV, msgTable)

	local agent = RPC._agent

	if agent == false then
		return
	end

	local msgID = msgTable.head.cmd
	local ecode = msgTable.head.ecode

	if RPC.SendTimes[msgID] then
		RPC.SendTimes[msgID] = nil
	end

	if ecode ~= "kCSErrorNone" and ecode ~= "kCSErrorDefault" then
		local checkSpec = msgID == "kCSMsgCDKey" and ecode == "kCSErrorCDKeyUsingTooMany"

		if not checkSpec then
			local funcName = agent.onErrorCodeResp

			if not funcName or not funcName(agent, msgID, ecode) then
				local msgTitle = "服务器异常"
				local msgContent = "RPC.dispatch kCSError, ecode = " .. ecode .. ", msgID = " .. msgID

				UIManager.showConfirm(UIConst.CONFIRM_ONEBTN, msgTitle, msgContent)
			end
		end

		local dict2ListFuncName = RPC._msgRespDict2ListMap[msgID]

		if RPC[dict2ListFuncName] then
			local msgList = RPC[dict2ListFuncName](msgTable)
			local msgCBFuncName = RPC._msgRespCBMap[msgID]

			msgCBFuncName = msgCBFuncName .. "Error"

			local funcName = agent[msgCBFuncName]

			if funcName then
				funcName(agent, ecode, unpack(msgList))
			end
		end

		return
	end

	local dict2ListFuncName = RPC._msgRespDict2ListMap[msgID]

	if RPC[dict2ListFuncName] then
		local msgList = RPC[dict2ListFuncName](msgTable)
		local msgCBFuncName = RPC._msgRespCBMap[msgID]
		local funcName = agent[msgCBFuncName]

		if funcName then
			if DebugModule.ShowServerLog and msgCBFuncName ~= "onHeartBeatResp" and msgCBFuncName ~= "onChatHeartBeatResp" then
				local tolog = utils.dumpTab(msgList)

				if msgCBFuncName == "onItemUpdateNotify" then
					sendItemUpdate(msgList)
				elseif msgCBFuncName == "onListAttrNotify" then
					addListAttrNotify(msgList)
				elseif msgCBFuncName == "onRoleLoginResp" then
					tester_uid = msgList[2].role_data.uid
				end
			end

			funcName(agent, unpack(msgList))
		end
	end
end

local function RPC_packAndSend(clientPkg)
	if RPC.SendPacksInLimit(clientPkg.head.cmd) then
		return
	end

	if DebugModule.ShowServerLog and clientPkg.head and clientPkg.head.cmd ~= "kCSMsgHeartBeat" and clientPkg.head.cmd ~= "kCSMsgChatHeartBeat" then
		-- block empty
	end

	EventCenter.sendEvent(EventConst.NETWORK_MESSAGE_SEND, clientPkg)

	local connect = RPC._getConnectHandleByCmd(clientPkg.head.cmd)

	if connect == nil then
		return
	end

	if connect >= 0 then
		local buffer = protobuf.encode("csp.ClientPkg", clientPkg)

		tfcapi.sendMsg(connect, buffer, string.len(buffer))
	end
end

local function CHATRPC_dispatch(msgTable)
	EventCenter.sendEvent(EventConst.NETWORK_MESSAGE_RECV, msgTable)

	local agent = CHATRPC._agent

	if agent == false then
		return
	end

	local msgID = msgTable.head.cmd
	local ecode = msgTable.head.ecode

	if ecode ~= "kCSErrorNone" and ecode ~= "kCSErrorDefault" then
		local funcName = agent.onErrorCodeResp

		if not funcName or not funcName(agent, msgID, ecode) then
			local msgTitle = "服务器异常"
			local msgContent = "CHATRPC.dispatch kCSError, ecode = " .. ecode .. ", msgID = " .. msgID

			UIManager.showConfirm(UIConst.CONFIRM_ONEBTN, msgTitle, msgContent)
		end

		local dict2ListFuncName = CHATRPC._msgRespDict2ListMap[msgID]

		if CHATRPC[dict2ListFuncName] then
			local msgList = CHATRPC[dict2ListFuncName](msgTable)
			local msgCBFuncName = CHATRPC._msgRespCBMap[msgID]

			msgCBFuncName = msgCBFuncName .. "Error"

			local funcName = agent[msgCBFuncName]

			if funcName then
				funcName(agent, ecode, unpack(msgList))
			end
		end

		return
	end

	local dict2ListFuncName = CHATRPC._msgRespDict2ListMap[msgID]

	if CHATRPC[dict2ListFuncName] then
		local msgList = CHATRPC[dict2ListFuncName](msgTable)
		local msgCBFuncName = CHATRPC._msgRespCBMap[msgID]
		local funcName = agent[msgCBFuncName]

		if funcName then
			if DebugModule.ShowServerLog then
				local tolog = utils.dumpTab(msgList)
			end

			funcName(agent, unpack(msgList))
		end
	end
end

local function CHATRPC_packAndSend(clientPkg)
	if DebugModule.ShowServerLog then
		-- block empty
	end

	EventCenter.sendEvent(EventConst.NETWORK_MESSAGE_SEND, clientPkg)

	local buffer = protobuf.encode("cscp.ClientPkg", clientPkg)

	ChatService.send(buffer)
end

local function StrToTable(str)
	if str == nil or type(str) ~= "string" then
		return
	end

	return loadstring("return " .. str)()
end

function DebugModule.executeMsg(sender, menu, value)
	local data = StrToTable(value)

	RPC[data.func](unpack(data.param))
end

local modeStr = UserData.loadCommonData("ShowServerLog")

if Framework.Tools.LuaToolkit.IsEditor() and modeStr == "1" then
	DebugModule.ShowServerLog = true

	MsgManager.notice("显示服务器log  替换RPC的dispatch接口实现")

	RPC.dispatch = RPC_dispatch
	RPC._packAndSend = RPC_packAndSend
	CHATRPC._packAndSend = CHATRPC_packAndSend
	CHATRPC.dispatch = CHATRPC_dispatch
end

function DebugModule.showServerLog(sender, menu, value)
	if Framework.Tools.LuaToolkit.IsEditor() then
		if DebugModule.ShowServerLog then
			DebugModule.ShowServerLog = false

			MsgManager.notice("隐藏服务器log  仍然替换了RPC的dispatch接口")
			UserData.saveCommonData("ShowServerLog", "0")
		else
			DebugModule.ShowServerLog = true

			MsgManager.notice("显示服务器log  替换RPC的dispatch接口实现")
			UserData.saveCommonData("ShowServerLog", "1")
		end

		RPC.dispatch = RPC_dispatch
		RPC._packAndSend = RPC_packAndSend
		CHATRPC.packAndSend = CHATRPC_packAndSend
	end
end

function DebugModule.unlockAllCondition()
	ConditionLimitManager.unlockAllCondition()
end

local beginnerStr = UserData.loadCommonData("HideBeginner")

if beginnerStr == "1" then
	BeginnerManager.disable = true
end

function DebugModule.closeBeginner()
	if beginnerStr == "1" then
		BeginnerManager.disable = false

		MsgManager.notice("开启新手")
		UserData.saveCommonData("HideBeginner", "0")

		beginnerStr = "0"
	else
		BeginnerManager.disable = true

		MsgManager.notice("关闭新手")
		UserData.saveCommonData("HideBeginner", "1")

		beginnerStr = "1"
	end
end

function DebugModule.closeDrawOpt()
	CurAvatar.SkipDrawCardOperate = true
end

function DebugModule.testWorldHotfix()
	local file = io.open("d:\\Hotfix_1.lua", "r")
	local data = file:read("*a")
	local f = loadstring(data)

	if f then
		ClientUtils.trycall(f)
	end

	file:close()
end

function DebugModule.testDisconnect(sender, menu, value)
	local NetService = require("Network/NetService")

	NetService.testDisconnect = true
end

function DebugModule.winBattle(sender, menu, value)
	if GameFsm.isInState(Const.STATE_BATTLE) then
		GameFsm.getCurState():onMatrixOver(BattleConst.CAMP_MONSTER, nil, 1)
		GameFsm.getCurState().frameMgr:pause()

		if GameFsm.getCurState().battleConfig and GameFsm.getCurState().battleConfig.id == 11001 then
			BeginnerManager.stopBeginnerStep(12)
		end
	end
end

function DebugModule.testABTest(sender, menu, value)
	if UserData.loadCommonData("ForceUIModeB") == "1" then
		UserData.saveCommonData("ForceUIModeB", "2")

		CurAvatar.testType = Const.TEST_TYPE_B

		MsgManager.notice("UITest切换成B包,重启后强制为B包")
	elseif UserData.loadCommonData("ForceUIModeB") == "2" then
		UserData.saveCommonData("ForceUIModeB", "0")
		MsgManager.notice("UITest不切换,重启后使用服务端数值")
	else
		UserData.saveCommonData("ForceUIModeB", "1")

		CurAvatar.testType = Const.TEST_TYPE_A

		MsgManager.notice("UITest切换成A包,重启后强制为A包")
	end
end

local function report_output_line(rp)
	local size = string.format("%0.3f", rp[2])

	return string.format("%s,%s\n", rp[1], size)
end

function DebugModule.printDataSize()
	local dataSize = Game.ModuleSize
	local s = {}

	for mName, size in pairs(dataSize) do
		table.insert(s, {
			mName,
			size
		})
	end

	table.sort(s, function(a, b)
		return a[2] > b[2]
	end)
	collectgarbage("collect")

	local nowMem = collectgarbage("count")
	local total = 0

	for index, info in ipairs(s) do
		total = total + info[2]
	end

	local FORMAT_HEADER_LINE = "%s,%s\n"
	local header = string.format(FORMAT_HEADER_LINE, "NAME", "SIZE")
	local output = header

	for i, rp in ipairs(s) do
		if rp[2] > 0 then
			output = output .. report_output_line(rp)
		end
	end

	local file = io.open("luaMemory" .. os.date("%Yy%mM%dD%Hh%Mm", ClientUtils.getServerTime()) .. ".csv", "w+")

	file:write(output)
	file:flush()
	file:close()
end

function DebugModule._onTraceRoute(text)
	Framework.Tools.LuaToolkit.LogEx("_onTraceRoute" .. (text or "nil"))
end

function DebugModule.testCircleBattleAni(sender, menu, value)
	local CircleControlCenter = require("Logic/Circle/CircleControlCenter")

	Const.CIRCLE_BATTLE_DEBUG_MODE = true
end

function DebugModule.testCircleBattleCamera(...)
	local CircleControlCenter = require("Logic/Circle/CircleControlCenter")

	CircleControlCenter.testAi()
end

local function replaceDebugGm(gmstr, server)
	local clientPkg = {
		head = {
			cmd = "kCSMsgExecuteGM"
		},
		["csp.gm_c"] = {}
	}
	local specEntry = clientPkg["csp.gm_c"]
	local worldidgmstr = string.gsub(gmstr, "//", "//" .. DebugModule.worldid .. " ")

	specEntry.gmstr = worldidgmstr
	specEntry.server = server

	RPC._packAndSend(clientPkg)
end

function DebugModule.inputWorldid(sender, menu, value)
	if value then
		DebugModule.worldid = tonumber(value)
		RPC.executeGM = replaceDebugGm
	end
end

function DebugModule.switchCircleBattleServer(cmd)
	local isPubServer = UserData.loadCommonData("CircleBattleServer") == "1"

	if cmd == "init" then
		-- block empty
	else
		isPubServer = not isPubServer

		UserData.saveCommonData("CircleBattleServer", isPubServer and "1" or "0")
		MsgManager.notice(string.format("切换至 %s", isPubServer and "工会战测试服" or "内网"))
	end

	local UrlConfig = require("Network/UrlConfig")

	if isPubServer then
		UrlConfig.setDebugArgs(true, "android", "business1", "")
	else
		UrlConfig.setDebugArgs(false, "android", "", "")
	end

	SvrListManager._initUrl()
	SvrListManager._clearAllCD()
	SvrListManager.requestUpdate(SvrListManager.REQ_TYPE.ENTRY)
	SvrListManager.requestUpdate(SvrListManager.REQ_TYPE.FULL)
end

function DebugModule.setLanguage(sender, menu, value)
	local orgLang = LuaToolkit.GetCurLanguage()

	LuaToolkit.SetCurLanguage(value)

	local setVer = LuaToolkit.GetCurLanguage()

	if orgLang ~= setVer then
		UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, "设置语言", utils.format("切换语言至%1s，部分内容需要重启生效", setVer), Game.Reload, nil, nil, "立即重启", "稍后手动")
	else
		MsgManager.notice(string.format("设置语言至%1s失败", value))
	end
end

function DebugModule:_show(grid, config, uiConfig, checkNeedConvertObject, params)
	self.uiConfig = uiConfig

	if grid == nil then
		self:clear()
	end

	self._grid = grid

	if self.panelFunc then
		self._config = config

		if config == nil then
			config = UIControls.TipsConfig()
		end

		self.panelFunc:setConfig(config:getConfigs(grid), grid)
	end

	self.checkNeedConvertObject = checkNeedConvertObject

	self:_setObj(grid, params)

	local baseOrder = 0

	if grid.mWindow then
		baseOrder = grid.mWindow:getOrder()
	end

	self:setOrder(baseOrder + 15)
	self:checkItemSpec()

	if not self:getVisible() then
		self:setVisible(true)
	end

	if grid.object then
		MsgManager.notice("id " .. grid.object.id)
	end
end

function DebugModule.test(sender, menu, value)
	HotfixClassFunction(BaseTips, "show", DebugModule._show)
	MsgManager.notice("显示道具ID")
	MsgManager.notice(tester_uid)
end

function DebugModule.executeMsg2(sender, menu, value)
	local content = string.format("do local _=%s return _ end", value)
	local tmp1 = string.gsub(content, "csp", "%[\"csp")
	local tmp2 = string.gsub(tmp1, " =", "\"%] =", 1)
	local tmp3 = string.gsub(tmp2, "=.}", "= {}}")
	local data = loadstring(tmp3)

	data = data()

	RPC._packAndSend(data)
end

function DebugModule.changeServer(sender, menu, value)
	local nid = tonumber(value)

	if nid == nil then
		return
	end

	local serverinfo = SvrListManager.getServerInfo(nid)

	if serverinfo then
		if GameFsm.isInState(Const.STATE_LOGIN) then
			SvrListManager.selectWithPriority(serverinfo.id, SvrListManager.PRIORITY_USER)
		else
			SwitchServerHelper.tryUpdatePatchVersion(serverinfo.svrMark)
			SwitchServerHelper.changeSvrAndTryReset(serverinfo)
		end
	end
end

local spMarkLen = 0
local spMarkList = {}

for keys, urls in pairs(DebugSetServerList.SpMarkConst) do
	spMarkLen = spMarkLen + 1
	spMarkList[spMarkLen] = keys
end

DebugModule.FUNC_MENU = {
	{
		name = "自定义输入",
		typ = DebugConst.BTN_TYPE_INPUT,
		func = DebugModule.executeGM
	},
	{
		name = "自定义输入2",
		typ = DebugConst.BTN_TYPE_INPUT,
		func = DebugModule.executeGM
	},
	{
		name = "自定义输入3",
		typ = DebugConst.BTN_TYPE_INPUT,
		func = DebugModule.executeGM
	},
	{
		name = "挂机时间",
		typ = DebugConst.BTN_TYPE_INPUT,
		func = DebugModule.passDeposit
	},
	{
		name = "解锁条件限制",
		typ = DebugConst.BTN_TYPE_BUTTON,
		func = DebugModule.unlockAllCondition
	},
	{
		name = "隐藏/显示场景BG",
		typ = DebugConst.BTN_TYPE_BUTTON,
		func = DebugModule.hideMenuBg
	},
	{
		name = "隐藏/显示ServerLog",
		typ = DebugConst.BTN_TYPE_BUTTON,
		func = DebugModule.showServerLog
	},
	{
		name = "自定义发送协议",
		typ = DebugConst.BTN_TYPE_INPUT,
		func = DebugModule.executeMsg
	},
	{
		name = "偏移服务器时间",
		typ = DebugConst.BTN_TYPE_INPUT,
		func = DebugModule.setServerTime
	},
	{
		name = "关闭新手",
		typ = DebugConst.BTN_TYPE_BUTTON,
		func = DebugModule.closeBeginner
	},
	{
		name = "切换服务器",
		typ = DebugConst.BTN_TYPE_INPUT,
		func = DebugModule.changeServer
	},
	{
		name = "关闭抽卡动画",
		typ = DebugConst.BTN_TYPE_BUTTON,
		func = DebugModule.closeDrawOpt
	},
	{
		name = "测试HotFix",
		typ = DebugConst.BTN_TYPE_BUTTON,
		func = DebugModule.testWorldHotfix
	},
	{
		name = "测试断线",
		typ = DebugConst.BTN_TYPE_BUTTON,
		func = DebugModule.testDisconnect
	},
	{
		name = "战斗胜利",
		typ = DebugConst.BTN_TYPE_BUTTON,
		func = DebugModule.winBattle
	},
	{
		name = "切换UI的AB包",
		typ = DebugConst.BTN_TYPE_BUTTON,
		func = DebugModule.testABTest
	},
	{
		name = "测试公会战智能移动",
		typ = DebugConst.BTN_TYPE_BUTTON,
		func = DebugModule.testCircleBattleCamera
	},
	{
		name = "插入平台ID",
		typ = DebugConst.BTN_TYPE_INPUT,
		func = DebugModule.inputWorldid
	},
	{
		name = "设置语言",
		typ = DebugConst.BTN_TYPE_INPUT,
		func = DebugModule.setLanguage
	},
	{
		name = "协议测试工具",
		typ = DebugConst.BTN_TYPE_INPUT,
		func = DebugModule.executeMsg2
	},
	{
		name = "显示道具ID和UID",
		typ = DebugConst.BTN_TYPE_BUTTON,
		func = DebugModule.test
	},
	{
		name = "切换公会战测试服",
		typ = DebugConst.BTN_TYPE_BUTTON,
		func = DebugModule.switchCircleBattleServer
	},
	{
		name = "网页版GM工具",
		typ = DebugConst.BTN_TYPE_MENU,
		value = {
			{
				name = "连接网页版GM工具",
				typ = DebugConst.BTN_TYPE_BUTTON,
				func = DebugWebGM.init
			},
			{
				name = "断开网页版GM工具",
				typ = DebugConst.BTN_TYPE_BUTTON,
				func = DebugWebGM.close
			},
			{
				name = "设置服务器列表",
				typ = DebugConst.BTN_TYPE_MENU,
				value = {
					{
						name = "是否为发布版",
						typ = DebugConst.BTN_TYPE_COMBOX,
						func = DebugSetServerList.setIsPublish,
						value = {
							"false",
							"true"
						}
					},
					{
						name = "设置主标记",
						typ = DebugConst.BTN_TYPE_COMBOX,
						func = DebugSetServerList.setDebugSpMark,
						value = spMarkList
					},
					{
						name = "设置POSTFIX",
						typ = DebugConst.BTN_TYPE_COMBOX,
						func = DebugSetServerList.setPostfix,
						value = {
							"默认",
							"pre",
							"qa"
						}
					}
				}
			}
		}
	}
}

return DebugModule
