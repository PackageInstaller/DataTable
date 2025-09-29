-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/systemtip/view/SecretView.lua

module("logic.extensions.systemtip.view.SecretView", package.seeall)

local M = class("SecretView", ViewComponent)
local typeEnum = {
	levelCode = 1,
	commitId = 2
}
local isVisable = true

function M:ctor()
	M.super.ctor(self)
end

function M:buildUI()
	self._content = goutil.findChild(self.mainGO, "imgHintDi/Text"):GetComponent(UIComponentType.Text)
	self._levelContent = goutil.findChild(self.mainGO, "imgHintDi/levelCode"):GetComponent(UIComponentType.Text)
	self._gitCommitContent = goutil.findChild(self.mainGO, "imgHintDi/gitCommit"):GetComponent(UIComponentType.Text)
	self._timeContent = goutil.findChild(self.mainGO, "imgHintDi/time"):GetComponent(UIComponentType.Text)
end

function M:bindEvents()
	GlobalDispatcher:addEventListener(EventType.ENTER_GAME_REQUEST_OVER_EVENT, self._setID, self)
	BattleDispatcher:addEventListener(BattleEventType.OnBattleEnterFinish, self._setLevelId, self)
	BattleDispatcher:addEventListener(BattleEventType.OnBeforeExitBattle, self._setVisible, self)
	GlobalDispatcher:addEventListener(EventType.SECRET_VISIBLE, self._setVisible, self)
	GlobalDispatcher:addEventListener(EventType.GIT_COMMITID, self._setCommidId, self)
end

function M:unbindEvents()
	GlobalDispatcher:removeEventListener(EventType.ENTER_GAME_REQUEST_OVER_EVENT, self._setID, self)
	BattleDispatcher:removeEventListener(BattleEventType.OnBattleEnterFinish, self._setLevelId, self)
	BattleDispatcher:removeEventListener(BattleEventType.OnBeforeExitBattle, self._setVisible, self)
	GlobalDispatcher:removeEventListener(EventType.SECRET_VISIBLE, self._setVisible, self)
	GlobalDispatcher:removeEventListener(EventType.GIT_COMMITID, self._setCommidId, self)
end

function M:onEnter()
	if BootstrapGameConfigMgr.getIsReview() then
		self:close()

		return
	end

	self._isLogin = false

	if isVisable then
		settimer(1, self._updateTime, self, true)
	else
		goutil.setActive(self._timeContent.gameObject, false)
	end
end

function M:_setID()
	self._isLogin = true
	self._content.text = lang("tip_secret") .. " ID：" .. PlayerModel.instance:getId()
end

function M:_setLevelId()
	if isVisable then
		local activeBattleFlow = BattleMgr.instance:getActiveBattleFlow()

		if OOPUtil.isInstanceOf(activeBattleFlow, LevelBattleFlowBase) then
			local levelCode = activeBattleFlow:getBattleLevelCode()

			self._levelContent.text = " 当前关卡ID：" .. levelCode
		end
	end

	if HacktoolMo.instance:getLevelCodeVisible() then
		self:_setVisible(nil, 1, true)
	end
end

function M:_setVisible(_, type, status)
	if not isVisable then
		return
	end

	if type == typeEnum.levelCode then
		goutil.setActive(self._levelContent.gameObject, status)
	elseif type == typeEnum.commitId then
		if not isInEditorMode then
			return
		end

		goutil.setActive(self._gitCommitContent.gameObject, status)
	end
end

function M:_setCommidId(_, serverId, serverTime)
	if not serverId or not serverTime then
		return
	end

	if not isInEditorMode then
		return
	end

	local assetPath = UnityEngine.Application.dataPath
	local path = assetPath:sub(1, assetPath:len() - 16) .. ".git/"
	local www = UnityEngine.WWW.New(path .. "logs/HEAD")

	while not www.isDone do
		-- block empty
	end

	local log = www.text

	log = log:rtrim():split("\n")
	nowRef = string.split(log[#log], " ")

	local clientId = nowRef[2]
	local clientTime = tonumber(nowRef[5])

	clientTime = TimeUtil:formatUnixTime2Date(clientTime)
	clientTime = string.format(" %02d%02d %02d:%02d", clientTime.month, clientTime.day, clientTime.hour, clientTime.minute)

	local timeStr = serverTime:split("T")
	local serverD = timeStr[1]:split("-")
	local serverT = timeStr[2]:split(":")

	serverTime = string.format(" %s%s %s:%s", serverD[2], serverD[3], serverT[1], serverT[2])
	self._gitCommitContent.text = " client: " .. clientId:sub(1, 6) .. clientTime .. " server: " .. serverId:sub(1, 6) .. serverTime
end

function M:_updateTime()
	if not self._isLogin then
		return
	end

	local curTime = TimeUtil:formatUnixTime2Date(ServerTime.now())

	curTime = string.format("%02d:%02d:%02d", curTime.hour, curTime.minute, curTime.second)
	self._timeContent.text = " 当前时间：" .. curTime
end

return M
