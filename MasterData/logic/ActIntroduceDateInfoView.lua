-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/actintroduce/view/ActIntroduceDateInfoView.lua

module("logic.extensions.actintroduce.view.ActIntroduceDateInfoView", package.seeall)

local ActIntroduceDateInfoView = class("ActIntroduceDateInfoView", ViewComponent)

function ActIntroduceDateInfoView:ctor()
	ActIntroduceDateInfoView.super.ctor(self)
end

function ActIntroduceDateInfoView:unbindEvents()
	ActIntroduceDateInfoView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnGoto, self)
	GameUtil.rmClickHandler(self._btnClose, self)
end

function ActIntroduceDateInfoView:bindEvents()
	ActIntroduceDateInfoView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnGoto, self._onClickGoto, self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function ActIntroduceDateInfoView:buildUI()
	ActIntroduceDateInfoView.super.buildUI(self)

	self._txtDesc = self:getTxt("txtDesc")
	self._txtTitle = self:getTxt("txtTitle")
	self._btnGoto = self:getGo("btnGoto")
	self._show = self:getGo("show")
	self._btnClose = self:getBtn("btnClose")
end

function ActIntroduceDateInfoView:onExit()
	ActIntroduceDateInfoView.super.onExit(self)
	uGuiUtil.clearImage(self._show)
end

function ActIntroduceDateInfoView:onEnter()
	ActIntroduceDateInfoView.super.onEnter(self)

	self._config = self:getFirstParam()

	local startDate = GameUtil.string2date(self._config.startTime)
	local endDate = GameUtil.string2date(self._config.endTime)
	local periodType = GameUtil.getTimePeriodType(self._config.startTime, self._config.endTime)

	GameUtil.SetGray(self._btnGoto, periodType ~= GameUtil.inTimePeriod)

	self._txtDesc.text = langPara("开始时间：%d年%d月%d日 %02d:%02d\n结束时间：%d年%d月%d日 %02d:%02d", startDate.year, startDate.month, startDate.day, startDate.hour, startDate.min, endDate.year, endDate.month, endDate.day, endDate.hour, endDate.min)
	self._txtTitle.text = self._config.title

	local imgPath = self._config.imgPath

	if string.nilorempty(imgPath) then
		imgPath = ActIntroduceConfig.instance:getCommonValue("IMG_DEFAULT_DATE_INFO")
	end

	uGuiUtil.clearImage(self._show)
	uGuiUtil.setSpriteToImage(self._show, uGuiUtil.SpriteType.BigBg, GameUrl.getBigbgFolderUrl("actintroduce", imgPath))
end

function ActIntroduceDateInfoView:_onClickGoto()
	local periodType = GameUtil.getTimePeriodType(self._config.startTime, self._config.endTime)
	local strTips = "活动未开始"

	if periodType == GameUtil.afterTimePeriod then
		strTips = lang("活动已结束")
	elseif periodType == GameUtil.inTimePeriod then
		strTips = nil
	end

	if not string.nilorempty(strTips) then
		FloatWordMgr.instance:show(strTips)
	else
		self:close()
		GotoMgr.gotoByString(self._config.jumpTo)
	end
end

return ActIntroduceDateInfoView
