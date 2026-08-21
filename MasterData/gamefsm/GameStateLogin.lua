-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/GameFsm\\GameStateLogin.lua

local LuaToolkit = Framework.Tools.LuaToolkit
local GameState = require("GameFsm/GameState")
local GameSettings = require("Helper/GameSettings")
local UrlConfig = require("Network/UrlConfig")
local DeviceHelper = require("Helper/DeviceHelper")
local VersionUtils = require("System/VersionUtils")
local RemoteConfig = require("Helper/RemoteConfig")
local SubpackageHelper = require("Helper/SubpackageHelper")
local ResLoginCgConfig = require("ClientData/ResLoginCgConfig")
local strClassName = "GameStateLogin"
local GameStateLogin = Class(strClassName, GameState)
local UserData = require("Helper/UserData")
local LoginNoticeKey = "login_notice_id"
local LoginNoticeKeyJP = "login_notice_id_jp"
local VersionUtils = require("System/VersionUtils")

function GameStateLogin:ctor(name)
	self:_initData()

	self._loginDlgShowed = false
end

function GameStateLogin:_initData()
	self._autoAction = Const.AUTO_LOGIN
	self.toLogin = true
	self.isLogin = true
	self._waitNotice = false
	self._slotShowLoginDlg = Slot(self.showLoginDlg, self)
end

function GameStateLogin:onEnter(preStateName)
	GameStateLogin.super.onEnter(self, preStateName)
	Framework.UI.UIUtils.ClosePatchUI()
	GameSettings.initGameSettings()
	DeviceHelper.setRenderResolution()
	DeviceHelper.initLoaderMemoryControl()
	DeviceHelper.tryWarmUpShader()
	UIManager.emulatorAdjust()
	UIManager.ClearUICache()
	RemoteConfig.init()

	if VersionUtils.isLabelCheck() and pcall(function()
		local try = LuaToolkit.GetCheckTextToolEnable
	end) and LuaToolkit.GetCheckTextToolEnable() then
		LuaToolkit.SetCheckTextToolEnable(true)
	end
end

function GameStateLogin:onExit(nextStateName)
	UIManager.delUI("login")
	GameStateLogin.super.onExit(self, nextStateName)
end

function GameStateLogin:onSceneLoaded()
	GameStateLogin.super.onSceneLoaded(self)
end

GameStateLogin.LoginCGVersion = "1"
Const.LoginCGPath = "Videos/Login_CG.mp4"

function GameStateLogin:showLoginDlg()
	self:checkLoginCgVersion()

	local headMoviePlayed = UserData.loadCommonData("headMoviePlayed")

	if headMoviePlayed ~= GameStateLogin.LoginCGVersion then
		local function movieEndFunc(...)
			UIManager.getUI("login", true)
		end

		if GameConfig.getChannelConfig(Const.REMOTE_CONFIG_HIDE_LOGIN_MOVIE) == 1 then
			UserData.saveCommonData("headMoviePlayed", GameStateLogin.LoginCGVersion)
			UIManager.getUI("login", true)
		else
			UIManager.playLoginCG(movieEndFunc)
			UserData.saveCommonData("headMoviePlayed", GameStateLogin.LoginCGVersion)
		end
	else
		UIManager.getUI("login", true)
	end
end

function GameStateLogin:checkLoginCgVersion()
	local validIndex = 1
	local validInfo

	for index, info in ipairs(ResLoginCgConfig) do
		if info.time_valid_id == nil or ClientUtils.isTimeConfigPassed(info.time_valid_id) then
			validIndex = index
			validInfo = info
		else
			break
		end
	end

	GameStateLogin.LoginCGVersion = tostring(validIndex)
	Const.LoginCGPath = "Videos/" .. validInfo.cg_path
end

function GameStateLogin:onLoadEnded()
	GameStateLogin.super.onLoadEnded(self)
	SubpackageHelper.onGameStart()

	if not IS_PUBLISH_VERSION then
		local patchUI = UIManager.getUI("patch", true)

		if patchUI then
			patchUI:setVisible(false)
		end
	end

	self:showLoginDlg()
end

function GameStateLogin:resetState()
	self.toLogin = true
end

local NOTICE_LAN_CONFIG = {
	[RegionConst.LANGUAGE_ENG] = 1,
	[RegionConst.LANGUAGE_CHS] = 2,
	[RegionConst.LANGUAGE_CHT] = 3,
	[RegionConst.LANGUAGE_THAI] = 4,
	[RegionConst.LANGUAGE_VIET] = 5
}

function GameStateLogin:checkLoginNotice()
	if VersionUtils.isSectionEnabled() then
		local ServerSection = require("Network/ServerSection")

		if ServerSection.getSection() == nil then
			return
		end
	end

	if self.mNoticeInfo == nil and not self._waitNotice then
		local urlNotice = UrlConfig.NoticeUrl

		if RegionUtils.isJP() then
			urlNotice = UrlConfig.NoticeUrlJP
		end

		if RegionUtils.isSEA() and NOTICE_LAN_CONFIG[RegionUtils.curLanguage] then
			urlNotice:SetUrlAppend("?t=" .. tostring(os.time()) .. "&lang=" .. NOTICE_LAN_CONFIG[RegionUtils.curLanguage])
		else
			urlNotice:SetUrlAppend("?t=" .. tostring(os.time()))
		end

		HttpHelper.get(urlNotice, Slot(self.onNoticeLoaded, self), 5)

		self._waitNotice = true
	end
end

function GameStateLogin:onNoticeLoaded(succ, data)
	self._waitNotice = false

	if succ ~= 0 then
		MsgManager.notice(Lang.get(29944))

		return
	end

	self.mNoticeInfo = ClientUtils.string2Table(data)

	if RegionUtils.isJP() then
		if not self.hasReadConfig then
			local config = UserData.loadCommonData(LoginNoticeKeyJP)

			if config == nil or config == "" then
				self.hasReadConfig = {}
			else
				self.hasReadConfig = ClientUtils.string2Table(config)
			end
		end

		if self.mNoticeInfo then
			for _, v in ipairs(self.mNoticeInfo) do
				if not self.hasReadConfig[tostring(v.id)] then
					local notice = UIManager.getUI("loginNoticeJP")

					notice:show()

					return
				end
			end
		end
	else
		if self.mNoticeID == nil then
			local saveNoticeID = UserData.loadCommonData(LoginNoticeKey)

			if saveNoticeID ~= nil and saveNoticeID ~= "" then
				self.mNoticeID = tonumber(saveNoticeID)
			else
				self.mNoticeID = 0
			end
		end

		local newID = self.mNoticeInfo.id or 0

		if newID > self.mNoticeID and GameFsm.isInState(Const.STATE_LOGIN) then
			UIManager.getUI("loginNotice", true):show()

			self.mNoticeID = newID

			UserData.saveCommonData(LoginNoticeKey, self.mNoticeID)
		end
	end
end

function GameStateLogin:setAutoAction(action)
	self._autoAction = action
end

function GameStateLogin:popAutoAction()
	local ret = self._autoAction

	self._autoAction = nil

	return ret
end

function GameStateLogin:onShowLoginDlg()
	if not self._loginDlgShowed then
		self._loginDlgShowed = true

		self._setWantsToQuit()
		self._checkMissingPatchTxt()
		self._fixPatchSameSizeBug()
	end
end

function GameStateLogin:_checkMissingPatchTxt()
	if ClientUtils.isPatchTxtMissing() then
		UnityEngine.PlayerPrefs.SetInt("PatchIntegraty", 0)
		UnityEngine.PlayerPrefs.Save()
		MsgManager.notice(Lang.get(29945))
	end
end

function GameStateLogin:_fixPatchSameSizeBug()
	local engineVersion = VersionUtils.getEngineVersion()

	if engineVersion == 91977 then
		UnityEngine.PlayerPrefs.SetInt("PatchIntegraty", 0)
	end
end

function GameStateLogin:_setWantsToQuit()
	local DeviceHelper = require("Helper/DeviceHelper")

	if DeviceHelper.isWindows() then
		LuaToolkit.SetWantsToQuitCallback(Slot(GameStateLogin._onWantsToQuit, self))
	end
end

function GameStateLogin:_onWantsToQuit()
	if ChannelUtil.isQQGame() and ClientUtils.isFirstOpen() and Time.time < 600 then
		return false
	end

	UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, Lang.get(1793), Lang.get(29946), LuaToolkit.QuitApplication, nil, nil, Lang.get(1796), Lang.get(7))

	local confirmBox = UIManager.tryGetUI("confirmui")

	if confirmBox then
		confirmBox:setOrder(1000)
	end

	return false
end

return GameStateLogin
