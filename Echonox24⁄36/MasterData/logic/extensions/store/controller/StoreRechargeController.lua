-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/store/controller/StoreRechargeController.lua

module("logic.extensions.store.controller.StoreRechargeController", package.seeall)

local M = class("StoreRechargeController", BaseController)

function M:ctor()
	return
end

function M:onInit()
	self:_setEvent(true)
end

function M:onReset()
	removetimer(self._tryPopUp, self)
end

function M:_setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.SHOW_MAIN_VIEW_FINISH, self._handleShowMainViewFinish, self)
	else
		GlobalDispatcher:removeEventListener(EventType.SHOW_MAIN_VIEW_FINISH, self._handleShowMainViewFinish, self)
	end
end

function M:_handleShowMainViewFinish(e, isEnter)
	local isOpen = SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.FirstRecharge)

	if not isEnter or not isOpen then
		return
	end

	local isShow = StoreRechargeModel.instance:isShowFirstCharge()
	local isGet = StoreRechargeModel.instance:getFirstStatus() == StoreEnum.StoreFirstChargeStatus.hasGet

	if not isShow or isGet then
		return
	end

	local cfg = StoreRechargeConfig.instance:getFirstChargeConfig()

	if cfg.dungeonId == 0 then
		return
	end

	local dungeonId = cfg.dungeonId
	local cacheId = PlayerModel.instance:getLocalStorageInt(StoreEnum.StoreFirstPopChargeViewKey, 0)

	if dungeonId == cacheId then
		return
	end

	local dungeonMo = DungeonModel.instance:getDungeonMoById(dungeonId)

	if not dungeonMo or not dungeonMo:hasPassed() then
		return
	end

	local code = LoginPopEnum.PopCode[LoginPopEnum.PopType.FirstCharge]

	if LoginPopUpsModel.instance:isContain(code) then
		return
	end

	local jumpId = 10900005

	GlobalDispatcher:dispatchEvent(EventType.LOGIN_POP_UP_REG, code, 0, true, jumpId)
	settimer(0.1, self._tryPopUp, self, false)
end

function M:_tryPopUp()
	local viewName = LoginPopUpsController.instance:getLastPopUpViewName()

	if not ViewMgr.instance:isOpen(viewName) and ViewMgr.instance:isOpen(ViewName.MainUIView) then
		GlobalDispatcher:dispatchEvent(EventType.LOGIN_POP_UP_VIEW_EXIT)
	end
end

M.instance = M.New()

return M
