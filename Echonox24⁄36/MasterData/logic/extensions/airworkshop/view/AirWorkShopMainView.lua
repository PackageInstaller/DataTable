-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/view/AirWorkShopMainView.lua

module("logic.extensions.airworkshop.view.AirWorkShopMainView", package.seeall)

local M = class("AirWorkShopMainView", ViewComponent)

function M:ctor()
	M.super.ctor(self)
end

function M:buildUI()
	self._btnPersonalPage = self:getBtn("air_workshop_main_view_1051544204")
	self._txtPersonalLv = self:getText("air_workshop_main_view_392360662")
	self._imgPersonalExp = self:getImage("air_workshop_main_view_-1873886388")
	self._btnDynMsg = self:getBtn("air_workshop_main_view_-1305756287")
	self._goDynMsgRedPoint = goutil.findChild(self._btnDynMsg.gameObject, "red_point")
	self._btnStore = self:getBtn("air_workshop_main_view_1779961713")
	self._btnTask = self:getBtn("air_workshop_main_view_2043082683")
	self._goRedPointTask = goutil.findChild(self._btnTask.gameObject, "red_point").gameObject
	self._btnSearch = self:getBtn("air_workshop_main_view_720578399")
	self._goRedPointSearch = goutil.findChild(self._btnSearch.gameObject, "red_point").gameObject
	self._btnCreateMode = self:getBtn("air_workshop_main_view_-2006392520")
	self._goRedDotCreateMode = goutil.findChild(self._btnCreateMode.gameObject, "red_point").gameObject
	self._txtNameCreateMode = self:getText("air_workshop_main_view_618802903")
	self._txtNameChallengeMode = self:getText("air_workshop_main_view_1059055228")
	self._btnChallengeMode = self:getBtn("air_workshop_main_view_-1471355820")
	self._txtChallengeModeTime = self:getText("air_workshop_main_view_2013198839")
	self._goLv1Bg = self:getGo("air_workshop_main_view_-1235076801")
	self._imgRodeoLv1 = self:getImage("air_workshop_main_view_-953570298")
	self._imgRodeoLv2 = self:getImage("air_workshop_main_view_-340378830")
	self._imgRodeoLv2Bg = self:getImage("air_workshop_main_view_1784902962")
	self._txtRodeoLvNickName = self:getText("air_workshop_main_view_1545067420")
	self._txtChallengeModeScore = self:getText("air_workshop_main_view_-939378420")
	self._goRedDotRodeo = goutil.findChild(self._btnChallengeMode.gameObject, "red_point").gameObject
	self._txtNameHotRecommend = self:getText("air_workshop_main_view_-889865151")
	self._btnHotRecommend = self:getBtn("air_workshop_main_view_-1345608180")
	self._txtNameFreeMode = self:getText("air_workshop_main_view_-2099201781")
	self._btnFreeMode = self:getBtn("air_workshop_main_view_-1437092516")
end

function M:destroyUI()
	return
end

function M:bindEvents()
	self._btnDynMsg:AddClickListener(self._onClickDynMsg, self)
	self._btnPersonalPage:AddClickListener(self._onClickPersonalPage, self)
	self._btnStore:AddClickListener(self._onClickStore, self)
	self._btnTask:AddClickListener(self._onClickTask, self)
	self._btnSearch:AddClickListener(self._onClickSearch, self)
	self._btnCreateMode:AddClickListener(self._onClickCreateMode, self)
	self._btnChallengeMode:AddClickListener(self._onClickChallengeMode, self)
	self._btnHotRecommend:AddClickListener(self._onClickHotRecommend, self)
	self._btnFreeMode:AddClickListener(self._onClickFreeMode, self)
end

function M:unbindEvents()
	self._btnDynMsg:RemoveClickListener()
	self._btnPersonalPage:RemoveClickListener()
	self._btnStore:RemoveClickListener()
	self._btnTask:RemoveClickListener()
	self._btnSearch:RemoveClickListener()
	self._btnCreateMode:RemoveClickListener()
	self._btnChallengeMode:RemoveClickListener()
	self._btnHotRecommend:RemoveClickListener()
	self._btnFreeMode:RemoveClickListener()
end

function M:onEnter()
	self._isEnter = true

	IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_AirWorkShop)
	self:setEvent(true)
	self:_refreshRodeoModeShow()
	self:_refreshRedDot()
	StoreAgent.instance:sendGetMallListRequest(false)
	AirWorkShopDefAgent.instance:sendGetAirInfoRequest()
	AirWorkShopAtkAgent.instance:sendRodeoInfoRequest()
	AirWorkShopAtkAgent.instance:sendFreeEndlessInfoRequest()
	AirWorkShopDefAgent.instance:sendGetAllAirMapNewsReq()

	self._txtNameCreateMode.text = lang("tip_air_entry_create_mode")
	self._txtNameChallengeMode.text = lang("tip_air_entry_rodeo_mode")
	self._txtNameHotRecommend.text = lang("tip_air_entry_hot_mode")
	self._txtNameFreeMode.text = lang("tip_air_entry_free_mode")
end

function M:onExit()
	self._isEnter = false

	self:setEvent(false)
	IconLoader.unbindSpriteAtlas(IconType.DynSpriteAtlas_AirWorkShop)
end

function M:setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.RED_DOT_UPDATE_EVENT, self._refreshRedDot, self)
		AirWorkDispatcher:addEventListener(AirWorkShopEventType.ON_GET_AIR_MAP_NEWS_REPLY, self._handleOnGetAirMapNewsReply, self)
		GlobalDispatcher:addEventListener(AirWorkShopEventType.ON_RODEO_INFO_CHANGE, self._handleOnRodeoInfoChange, self)
		GlobalDispatcher:addEventListener(AirWorkShopEventType.ON_FREE_ENDLESS_INFO_CHANGE, self._handleOnFreeEndlessInfoChange, self)
		GlobalDispatcher:addEventListener(AirWorkShopEventType.ON_AIR_INFO_CHANGE, self._handleOnAirInfoChange, self)
	else
		GlobalDispatcher:removeEventListener(EventType.RED_DOT_UPDATE_EVENT, self._refreshRedDot, self)
		AirWorkDispatcher:removeEventListener(AirWorkShopEventType.ON_GET_AIR_MAP_NEWS_REPLY, self._handleOnGetAirMapNewsReply, self)
		GlobalDispatcher:removeEventListener(AirWorkShopEventType.ON_RODEO_INFO_CHANGE, self._handleOnRodeoInfoChange, self)
		GlobalDispatcher:removeEventListener(AirWorkShopEventType.ON_FREE_ENDLESS_INFO_CHANGE, self._handleOnFreeEndlessInfoChange, self)
		GlobalDispatcher:removeEventListener(AirWorkShopEventType.ON_AIR_INFO_CHANGE, self._handleOnAirInfoChange, self)
	end
end

function M:_handleOnGetAirMapNewsReply()
	local allMsgCount = AirWorkShopModel.instance:getAllAirMapNewsCount()

	goutil.setActive(self._goDynMsgRedPoint, allMsgCount > 0)
end

function M:_refreshRedDot()
	if not self._isEnter then
		return
	end

	self:_handleOnGetAirMapNewsReply()

	local isActive = RedDotModel.instance:getDotIsActive(GameEnum.RedPointEnum.AirTask)

	goutil.setActive(self._goRedPointTask, isActive)
end

function M:_onClickDynMsg()
	ViewMgr.instance:open(ViewName.AirWorkShopDynMsgView)
end

function M:_onClickPersonalPage()
	AirWorkShopUtil.openPersonalPage(PlayerModel.instance:getId(), AirWorkShopEnum.PersonalPageType.Main)
end

function M:_onClickSearch()
	ViewMgr.instance:open(ViewName.AirWorkshopSortView)
end

function M:_onClickHotRecommend()
	ViewMgr.instance:open(ViewName.AirWorkShopHotRecommendView)
end

function M:_onClickCreateMode()
	AirWorkShopDefMgr.instance:tryEnterCreateMode()
end

function M:_onClickTask()
	AirWorkShopDefAgent.instance:sendGetAirTaskListRequest()
	ViewMgr.instance:open(ViewName.AirWorkShopTaskView)
end

function M:_onClickStore()
	ViewMgr.instance:open(ViewName.AirWorkShopStoreView)
end

function M:_onClickFreeMode()
	ViewMgr.instance:open(ViewName.AirWorkshopFreeModeView)
end

function M:_onClickChallengeMode()
	ViewMgr.instance:open(ViewName.AirWorkShopRodeoMainView)
end

function M:_handleOnRodeoInfoChange(e)
	if not self._isEnter then
		return
	end

	self:_refreshRodeoModeShow()
end

function M:_handleOnFreeEndlessInfoChange(e)
	if not self._isEnter then
		return
	end
end

function M:_handleOnAirInfoChange(e)
	if not self._isEnter then
		return
	end

	local airInfo = AirWorkShopModel.instance:getAirInfo()
	local createLv = airInfo.lv
	local createExp = airInfo.exp
	local curLvMaxExp = self:_getCurCreateLvMaxExp(createLv)

	self._txtPersonalLv.text = string.format("Lv.%s", createLv)
	self._imgPersonalExp.fillAmount = createExp / curLvMaxExp
end

function M:_refreshRodeoModeShow()
	local nowTime = ServerTime.now()
	local infoMo = AirWorkShopChallengeModel.instance:getPlayerInfoMo()
	local curLv = infoMo:getLv()
	local curChallengeNum = AirWorkShopChallengeModel.instance:getCurChallengeNum()
	local maxChallengeNum = AirWorkShopConfig.instance:getMaxChallengeNum()

	self._txtChallengeModeScore.text = string.format("%s", infoMo:getMaxOfWeek())

	AirWorkShopUtil.rodeoLvImgChange(curLv, self._imgRodeoLv1, self._imgRodeoLv2, self._goLv1Bg, self._imgRodeoLv2Bg)

	self._txtRodeoLvNickName.text = AirWorkShopUtil:getRodeoLvGradeNickName(curLv)

	local remainTimeStr
	local inCalculateTime = AirWorkShopUtil.getInRodeoCalculateTime(nowTime, false)

	if inCalculateTime then
		remainTimeStr = lang("tip_air_workshop_in_calculate_time")
	else
		remainTimeStr = self:_formatRemainTime(AirWorkShopUtil.getRodeoEndTimeStamp(nowTime), nowTime)
	end

	self._txtChallengeModeTime.text = remainTimeStr

	local canRodeoSettle = AirWorkShopUtil.getCanRodeoSettle()

	goutil.setActive(self._goRedDotRodeo, canRodeoSettle)
end

function M:_formatRemainTime(longTS, shortTS)
	local remainTime = ServerTime.getDateTimeDiff(longTS, shortTS)
	local remainTimeStr

	if remainTime.day > 0 then
		remainTimeStr = langF("tip_left_xx_day", remainTime.day)
	elseif remainTime.hour > 0 then
		remainTimeStr = langF("tip_left_xx_hour", remainTime.hour)
	elseif remainTime.min > 0 then
		remainTimeStr = langF("tip_left_xx_min", remainTime.min)
	else
		remainTimeStr = langF("tip_left_xx_min", 0)
	end

	return remainTimeStr
end

function M:_getCurCreateLvMaxExp(createLv)
	local maxExp = 0
	local cfg = AirWorkShopConfig.instance:getConfigByKey(ConfigName.AirStudioLevel, createLv)

	if cfg then
		maxExp = cfg.exp
	end

	return maxExp
end

return M
