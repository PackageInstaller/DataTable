-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/player/view/PlayerInfoView.lua

module("logic.extensions.player.view.PlayerInfoView", package.seeall)

local M = class("PlayerInfoView", ViewComponent)

function M:ctor()
	M.super.ctor(self)
end

function M:buildUI()
	self._nickText = self:getText("main_view_-1826764432")
	self._levelText = self:getText("main_view_-1813575202")
	self._expProgress = self:getImage("main_view_-1759265872")
	self._btnImgDi = self:getBtn("main_view_2020249584")
	self._imgPlayerMask = self:getImage("main_view_1034587835")
end

function M:destroyUI()
	self._idText = false
	self._nickText = false
	self._levelText = false
	self._energyText = false
	self._expProgress = false
	self._btnRealName = false
	self._txtRealName = false
end

function M:bindEvents()
	self._btnImgDi:AddClickListener(self._onClickImgDi, self)
end

function M:unbindEvents()
	self._btnImgDi:RemoveClickListener()
end

function M:onEnter()
	GlobalDispatcher:addEventListener(EventType.UPDATE_PLAYER_INFO_EVENT, self._handleUpdatePlayerInfo, self)
	GlobalDispatcher:addEventListener(EventType.HERO_INFO_REAL_NAME_STATE_CHANGE, self.updateRealNameStatus, self)
	SDKManager.getSDKInstacne():registerRealNameAuthListener(self._onRealNameAuthCallback, self)

	self._nickText.text = PlayerModel.instance:getNickName()

	self:updateRealNameStatus()

	if PlayerModel.instance:getPlayerCardInfo() then
		self:_handleUpdatePlayerInfo()
	else
		PlayerAgent.instance:sendGetPlayerCardInfoRequest(PlayerModel.instance:getId())
	end
end

function M:updateRealNameStatus(sender, realNameResult)
	local isRealName = SDKManager.getSDKInstacne():getUserRealNameStatus()

	if realNameResult ~= nil then
		isRealName = realNameResult == GameEnum.RealNameStatusEnum.Success
	end
end

function M:onExit()
	GlobalDispatcher:removeEventListener(EventType.UPDATE_PLAYER_INFO_EVENT, self._handleUpdatePlayerInfo, self)
	GlobalDispatcher:removeEventListener(EventType.HERO_INFO_REAL_NAME_STATE_CHANGE, self.updateRealNameStatus, self)
	SDKManager.getSDKInstacne():unregisterRealNameAuthListener()
end

function M:_handleUpdatePlayerInfo()
	self._levelText.text = self:_formatLevel(PlayerModel.instance:getLevel())
	self._expProgress.fillAmount = PlayerModel.instance:getCurExpPercent()

	local info = PlayerModel.instance:getMyPlayerInfo()
	local male = info.image == CommEnum.ImageEnum.Boy
	local portraitCO = BackpackConfig.instance:getItemInfoByItemId(info.portrait)

	if portraitCO then
		IconLoader.setSprite(self._imgPlayerMask, IconType.PlayerInfoMask, portraitCO.icon)
	end
end

function M:_formatLevel(level)
	local a = math.floor(level / 10)
	local b = level % 10

	return string.format("%s-%s", a, b)
end

function M:_onClickImgDi()
	if not SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.DisplayCard, true) then
		return
	end

	PlayerAgent.instance:sendGetPlayerCardInfoRequest(PlayerModel.instance:getId())

	if Astral.OSDef.isEditor then
		local lv = PlayerModel.instance:getLevel()
		local exp = PlayerModel.instance:getExp()
		local needExp = PlayerModel.instance:getMaxExp()

		printWarn(string.format("主管等级信息: lv:%s, exp:%s/%s, need:%s", lv, exp, needExp, needExp - exp))
	end
end

function M:_onRealNameAuthCallback(statusCode, statusDesc)
	UserAgent.instance:sendNotifyRealNameInfoUpdateRequest()
	self:updateRealNameStatus()

	if statusCode == SDKManager.STATUS_OK then
		local isRealName = true
	end
end

function M:_onClickRealName()
	if SDKManager.getSDKInstacne():isShowGuestUpgradeAccount() then
		SDKManager.getSDKInstacne():registerGuestUpgradeListener(function(statusCode, statusDesc)
			if statusCode == SDKManager.STATUS_GUEST_UPGRADE_SUCCESS then
				UserAgent.instance:sendNotifyRealNameInfoUpdateRequest()

				local isRealName = SDKManager.getSDKInstacne():getUserRealNameStatus()

				if not isRealName then
					SDKManager.getSDKInstacne():gotoRealNameAuth()
				end
			elseif statusCode == SDKManager.STATUS_GUEST_UPGRADE_CANCEL then
				printError(lang("guest upgrade tourist cancel..."))
			else
				printError(lang("guest upgrade tourist fail ...") .. statusDesc)
				FloatWordMgr.instance:show(string.format("%d:%s", statusCode, statusDesc))
			end

			SDKManager.getSDKInstacne():unregisterGuestUpgradeListener()
		end)
		SDKManager.getSDKInstacne():gotoGuestUpgradeAccount()

		return
	else
		printError(lang("guest upgrade tourist not support..."))
	end

	local isRealName = SDKManager.getSDKInstacne():getUserRealNameStatus()

	if not isRealName then
		SDKManager.getSDKInstacne():gotoRealNameAuth()
	else
		self:updateRealNameStatus()
	end
end

return M
