-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Avatar\\ClientAvatar.lua

local ClientEntity = require("Avatar/ClientEntity")
local NetService = require("Network/NetService")
local UserData = require("Helper/UserData")
local PerformManager = require("Logic/perform/PerformManager")
local RedDotMgr = require("UI/RedDotManager")
local SubpackageHelper = require("Helper/SubpackageHelper")
local LoginHelper = require("UI/Login/LoginHelper")
local strClassName = "ClientAvatar"
local ClientAvatar = Class(strClassName, ClientEntity)
local AvatarMixins = {
	"HeroMixin",
	"SkinMixin",
	"ItemMixin",
	"BattlePassMixin",
	"BattleMixin",
	"PlayerMixin",
	"ChatMixin",
	"StepTowerMixin",
	"MailMixin",
	"CommonGetConditionMixin",
	"EquipMixin",
	"PetMixin",
	"AchieveMixin",
	"TaskMixin",
	"OtherBattleMixin",
	"FriendMixin",
	"RankMixin",
	"RearHouseMixin",
	"HandBookMixin",
	"OperateMixin",
	"RechargeMixin",
	"WelfareMixin",
	"ShopMixin",
	"RoleInfoMixin",
	"CircleMixin",
	"FatigueMixin",
	"PlayerMiscMixin",
	"CommentMixin",
	"RentTaskMixin",
	"WindowsMixin",
	"RegionMixin",
	"AVGBulletMixin",
	"SignetMixin",
	"OpActivityMixin",
	"MiniGameMixin",
	"StageSkipMixin",
	"MasterApprenticeMixin",
	"SeasonPlayMixin"
}

for i = 1, #AvatarMixins do
	local mixin = loadstring(string.format("return require 'Avatar/AvatarMixins/%s'", AvatarMixins[i]))()

	if mixin then
		MixinClass(ClientAvatar, mixin)
	end
end

function ClientAvatar:ctor(gameData, all_data_num, shortUid)
	CurAvatar = self

	RPC.setAgent(self)
	CHATRPC.setAgent(self)

	self.shortUid = shortUid
	self.isAvatar = true
	self.baseData = gameData.role_data
	self.syncData = {}
	self.syncDataNum = all_data_num
	self.syncDataReady = false
	self.gender = self.baseData.base.gender or Const.DEFAULT_GENDER
	self.head = self.baseData.base.head
	self.headFrameId = self.baseData.base.head_frame_id == 0 and Const.DEFAULT_HEAD_FRAME_ID or self.baseData.base.head_frame_id
	self.headPendantId = self.baseData.base.head_pendant_id == 0 and Const.DEFAULT_HEAD_PENDANT_ID or self.baseData.base.head_pendant_id
	self.chatBubbleId = self.baseData.base.chat_bubble_id == 0 and Const.DEFAULT_CHAT_BUBBLE_ID or self.baseData.base.chat_bubble_id

	if not self.head or self.head == 0 then
		self.head = Const.DEFAULT_HEAD
	end

	self.uid = self.baseData.uid
	self.openid = self.baseData.openid
	self.serverFormatName = self.baseData.base.name

	self:initPlayerName(self.serverFormatName)
	self:initBeginnerData(self.baseData.necessary.newbie)

	self.idCard = self.baseData.necessary.misc.addiction.id_card
	self.roleCreateTick = self.baseData.necessary.misc.sol_reg_time
	self.inAntiAddiction = self.baseData.necessary.misc.addiction.flag == 1
	self.userAge = self.baseData.necessary.misc.addiction.age

	ClientTimerManager.initAllTimer()
	self:checkLoginInfo()

	if ClientUtils.uid == nil or ClientUtils.uid ~= self.uid then
		ClientUtils.uid = self.uid
		ClientUtils.record = {}
	end

	self.isMobileRecorded = self:_getMobileRecordState(self.baseData.necessary.misc.bitmem)

	self:_callMixinMemberFunc("initBase@", self.baseData)

	self._slotResReady = Slot(self._onSubpackageDownloaded, self)

	LoginHelper.headBuriedPoint(true)
end

function ClientAvatar:checkLoginInfo()
	local preLoginName = UserData.loadCommonData("LoginName")

	if preLoginName ~= self.name then
		self:onNewNameLogin()
	end

	local preLoginTime = UserData.loadCommonData("LoginTick")
	local todayStart = ClientUtils.getServerTimeTodayStart()

	if tonumber(preLoginTime) == nil or todayStart > tonumber(preLoginTime) then
		self:onNewDayLogin()
	end
end

function ClientAvatar:onNewNameLogin()
	UserData.saveCommonData("LoginName", self.name)
	UserData.saveCommonData("HookScriptScene", "")
end

function ClientAvatar:onNewDayLogin()
	local todayStart = ClientUtils.getServerTimeTodayStart()

	UserData.saveCommonData("LoginTick", tostring(todayStart))
	UserData.saveCommonData("HookScriptScene", "")
end

function ClientAvatar:initPlayerName(playerName)
	local nameList = utils.splitString(playerName, "-")
	local serverID = tonumber(nameList[1])
	local serverName = SvrListManager.getServerName(serverID)

	if serverName then
		self.name = nameList[2]
		self.serverName = serverName
	else
		self.name = playerName
		self.serverName = nil
	end

	self.genderTitle = self.gender == 1 and Lang.get(1800) or Lang.get(1801)
	self.genderHonorTitle = self.gender == 1 and Lang.get(1802) or Lang.get(1803)
	self.genderBrotherTitle = self.gender == 1 and Lang.get(59806) or Lang.get(19477)
end

function ClientAvatar:getPlayerName(useUid)
	if self:playerNameInited() then
		return self.name
	elseif useUid then
		return utils.GetDefaultName(self.uid)
	else
		return utils.GetDefaultName()
	end
end

function ClientAvatar:playerNameInited()
	return self.name ~= nil and self.name ~= ""
end

function ClientAvatar:onRoleLoginDataNotify(idx, dataType, bag, other, equip_scheme, other_bag)
	if dataType == "kRoleLoginDataTypeBag" then
		self.syncData.bag = bag
	elseif dataType == "kRoleLoginDataTypeOther" then
		self.syncData.other = other
	elseif dataType == "kRoleLoginDataTypeEquipScheme" then
		self.syncData.equip_scheme = equip_scheme
	elseif dataType == "kRoleLoginDataTypeOtherBag" then
		self.syncData.other_bag = other_bag
	end

	if idx >= self.syncDataNum then
		self:onDataReady()
	end
end

function ClientAvatar:setToReconnect()
	self.isReconnect = true
end

function ClientAvatar:onDataReady()
	UIManager.getUI("relinkDlg", false, false)
	self:_callMixinMemberFunc("init@", self.baseData, self.syncData)
	self:_callMixinMemberFunc("postinit@", self.baseData, self.syncData)

	local baseData = self.baseData

	self.baseData = nil
	self.syncData = nil
	self.syncDataReady = true

	ConditionLimitManager.initPlayerData()

	if not self.isReconnect then
		BeginnerManager.initPlayerData()
	end

	self:_checkReddotsAfterInited()
	self:_callMixinMemberFunc("initCheck@")
	SDKAgent.onRoleLogin()

	local mainMenu = UIManager.getUI("mainMenu", nil, false)

	if mainMenu and mainMenu:isInShow() then
		mainMenu:onRefresh()
	end

	if self.isReconnect then
		if GameFsm.isInState(Const.STATE_MAIN) then
			GameFsm.getState():onReconnect()
		end

		if GameFsm.isInState(Const.STATE_MAIN_STAGE) then
			PerformManager.start()
		end

		UIManager.onReconnect()
	end

	local record = baseData.necessary.deposit.record

	if SubpackageHelper.tryDownloadRemaining(record.chapter, ClientAvatar._onSubpackageDownloaded) then
		GameFsm.reset()
	end

	SubpackageHelper.onEnterChapter(record.chapter)
	NetService.setTouchReport(true)
end

function ClientAvatar:_onSubpackageDownloaded()
	AccountManager.connectGameServer(nil, nil, true)
end

function ClientAvatar:destroy()
	ClientTimerManager.stopAllTimer()
	self:_callMixinMemberFunc("destroy@")
	RedDotMgr.clearRegistedRedDot()

	CurAvatar = false

	RPC.setAgent(false)
	CHATRPC.setAgent(false)
end

function ClientAvatar:_callMixinMemberFunc(funcTemplate, ...)
	for i = 1, #AvatarMixins do
		local name = AvatarMixins[i]
		local funcName = string.gsub(funcTemplate, "@", name)

		if self[funcName] then
			ClientUtils.trycall(self[funcName], self, ...)
		end
	end
end

function ClientAvatar:onHeartBeatResp(time, count)
	Const.HEART_BEAT_TIME = Time.time

	ClientUtils.onSetServerTime(time)

	NetService.missBeatCount = 0
end

function ClientAvatar:onChatHeartBeatResp()
	return
end

function ClientAvatar:onExecuteGMResp(respid, gmres)
	MsgManager.notice(string.format(Lang.get(1799), gmres))
end

function ClientAvatar:onRoleMiscAddicationNotify(addiction)
	self.inAntiAddiction = addiction.flag == 1

	if self.inAntiAddiction and IS_VERIFY_VERSION then
		self:noticeInAntiAddiction()
	end
end

local function AddictionYse()
	if IS_VERIFY_VERSION and (CurAvatar and CurAvatar.idCard == nil or CurAvatar.idCard == "") then
		UIManager.getUI("idConfirmDlg", true)
	end
end

function ClientAvatar:noticeInAntiAddiction()
	UIManager.showConfirm(UIConst.CONFIRM_ONEBTN, Lang.get(5), Lang.get(1804), AddictionYse)
end

function ClientAvatar:catchSvrError(msgID)
	if msgID == "kCSErrorSystemBagIsFull" then
		-- block empty
	elseif msgID == "kCSErrorPVECanNotSweep" then
		self.pvpScoreRefreshTime = nil

		local ui = UIManager.getUI("pvpEnemyDlg", nil, false)

		if ui then
			ui:refreshScore()
		end
	elseif msgID == "kCSErrorTokenInvalid" then
		RPC.wChatRegister()
	end
end

function ClientAvatar:_checkReddotsAfterInited()
	self:refreshNewbiePoolReddot()
	self:refreshWelfareReddot()
end

function ClientAvatar:onRoleLogoutNotify(reason)
	if Framework.Tools.LuaToolkit.IsEditor() then
		NetService.disconnect()

		local rookieMainDlg = UIManager.getUI("rookieMainDlg", nil, false)

		if rookieMainDlg then
			rookieMainDlg:setVisible(false)
		end

		if reason == "kRoleLogoutReasonAntiAddiction" then
			GameFsm.translateState(Const.STATE_LOGIN)
			UIManager.showConfirm(UIConst.CONFIRM_ONEBTN, Lang.get(1793), Lang.get(48078))
		else
			UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, Lang.get(1805), Lang.get(1806), Slot(GameFsm.translateState, Const.STATE_LOGIN), nil, 60)
		end

		return
	end

	AccountManager.logoutGame()

	if reason == "kRoleLogoutReasonRemoteLogin" then
		UIManager.showConfirm(UIConst.CONFIRM_ONEBTN, Lang.get(1792), Lang.get(1797))
	elseif reason == "kRoleLogoutReasonClientVersionError" then
		UIManager.showConfirm(UIConst.CONFIRM_ONEBTN, Lang.get(1793), Lang.get(1798))
	elseif reason == "kRoleLogoutReasonAntiAddiction" then
		UIManager.showConfirm(UIConst.CONFIRM_ONEBTN, Lang.get(1793), Lang.get(52070))
	end
end

function ClientAvatar:onSystemSwitchNotify(systemSwitch)
	for _, switch in ipairs(systemSwitch) do
		local key, close = switch.key, switch.close

		if key == Const.SWITCH_KEY.ANTI_ADDICTION then
			self:onFatigueSwitchNotify(close == 0)
		end
	end
end

function ClientAvatar:_getMobileRecordState(bitmem)
	local index = 1
	local bitDict = {}

	if bitmem ~= nil then
		local tIndex = ClientUtils.getBitsListFromByteString(bitmem)

		for _, i in pairs(tIndex) do
			bitDict[i] = true
		end
	end

	return bitDict[index] == true
end

return ClientAvatar
