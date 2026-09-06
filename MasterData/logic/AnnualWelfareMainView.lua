-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/firstannualwelfare/view/AnnualWelfareMainView.lua

module("logic.extensions.firstannualwelfare.view.AnnualWelfareMainView", package.seeall)

local AnnualWelfareMainView = class("AnnualWelfareMainView", ViewComponent)

function AnnualWelfareMainView:buildUI()
	AnnualWelfareMainView.super.buildUI(self)

	self._petCon = self:getGo("petCon")
	self._btnClose = self:getGo("btnClose")
	self._btnTip = self:getGo("btnTips")
	self._goCell = self:getGo("cell")
	self._goTableview = self:getGo("tableview")
	self._tableview = ScrollerList.create(self._goTableview, self._goCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._txtOpenTime = self:getTxt("txtOpenTime/txt")
end

function AnnualWelfareMainView:bindEvents()
	AnnualWelfareMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
end

function AnnualWelfareMainView:unbindEvents()
	AnnualWelfareMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
end

function AnnualWelfareMainView:onEnter()
	AnnualWelfareMainView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.FirstAnnualWelfareGetInfoRes, self._refreshViewByInfo, self)
	FirstAnnualWelfareController.instance:resetRedPoint()

	self._actTimeCfg = ActivityDefineController.instance:getActivityCfgByType(GameEnum.ActivityType.FirstAnnualWelfare)

	self:_updateTime()

	if self._actTimeCfg then
		self:_refreshViewByCfg()
		FirstAnnualWelfareController.instance:onSendFirstAnnualWelfareGetInfoReq(self._actId)
	else
		FloatWordMgr.instance:show("活动不在开启期限内")
		self:close()

		return
	end

	self.loader = RoleObjectPool.instance:addRoleToParent(self.loader, 1200501, self._petCon, 0.6)
end

function AnnualWelfareMainView:onExit()
	AnnualWelfareMainView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.FirstAnnualWelfareGetInfoRes, self._refreshViewByInfo, self)

	self.loader = RoleObjectPool.instance:removeRole(self.loader)

	self._tableview:dispose()
end

function AnnualWelfareMainView:_refreshViewByCfg()
	self._actId = self._actTimeCfg.activityId
	self._actCfg = FirstAnnualWelfareConfig.instance:getFawCfg(self._actId)
	self._hudCfgs = FirstAnnualWelfareConfig.instance:getHudCfgs(self._actId)

	self._tableview:reloadData(self._hudCfgs)
end

function AnnualWelfareMainView:_refreshViewByInfo()
	self._curGainFreeGolgenCard = FirstAnnualWelfareModel.instance:getGainFreeGoldenCard()
	self._curGainSkinCard = FirstAnnualWelfareModel.instance:getGainSkinCard()

	self._tableview:reloadData(self._hudCfgs)
end

function AnnualWelfareMainView:_updateCell(view, goCell, data)
	local cell = self:_clearCell(goCell)

	if data.Id == 1 then
		RedPointController.instance:regRedPoint(cell.redPoint, RedPointModel.ID_ANNUALWELFARE_GOLDENDIAMONDCARD2)
	else
		RedPointController.instance:unregRedPoint(cell.redPoint)
	end

	GameUtil.addClickHandler(cell.btnGoTo, GameUtil.handler(self._onClickJumpTo, self, data))

	if not string.nilorempty(data.iconPath) then
		local path = GameUrl.getItemIconUrl(data.iconPath)

		uGuiUtil.setSpriteToImage(cell.item, uGuiUtil.SpriteType.BigBg, path)
	end

	cell.txtName.text = langPara("特权%s", GameUtil.getChineseNumber(data.Id))
	cell.txtTitle.text = lang(data.tag)
	cell.txtTime.text = lang(data.timeDesc)
	cell.txtDesc.text = lang(data.Desc)

	self:_specialDealCell(cell, data.dealType)
end

function AnnualWelfareMainView:_specialDealCell(cell, dealType)
	if dealType == "goldenCard" then
		cell.txtBtn.text = self._curGainFreeGolgenCard and lang("查 看") or lang("领 取 ")
	elseif dealType == "skinTry" then
		cell.txtBtn.text = lang("领 取 ")

		if self._curGainSkinCard then
			goutil.setActive(cell.markGet, true)
		end
	end
end

function AnnualWelfareMainView:_clearCell(goCell)
	local cell = {}

	cell.go = goCell
	cell.item = goutil.findChild(cell.go, "item")
	cell.btnGoTo = goutil.findChild(cell.go, "btnGoTo")
	cell.redPoint = goutil.findChild(cell.go, "btnGoTo/redpoint")
	cell.markGet = goutil.findChild(cell.go, "markGet")
	cell.txtName = goutil.findChildTextComponent(cell.go, "txtName")
	cell.txtTitle = goutil.findChildTextComponent(cell.go, "txtTitle")
	cell.txtTime = goutil.findChildTextComponent(cell.go, "txtTime")
	cell.txtDesc = goutil.findChildTextComponent(cell.go, "txtDesc")
	cell.txtBtn = goutil.findChildTextComponent(cell.btnGoTo, "Text")

	uGuiUtil.clearImage(cell.item)
	GameUtil.rmClickHandler(cell.btnGoTo)

	cell.txtBtn.text = lang("前 往")

	goutil.setActive(cell.redPoint, false)
	goutil.setActive(cell.markGet, false)
	RedPointController.instance:unregRedPoint(cell.redpoint)

	return cell
end

function AnnualWelfareMainView:_onClickJumpTo(data)
	if (data.openFunc and data.openFunc > 0 or nil) and FuncOpenModel.instance:getFuncIsOpen(data.openFunc) then
		if string.nilorempty(data.dealType) then
			if not string.nilorempty(data.jumpTo) then
				GotoMgr.gotoByString(data.jumpTo)
			end
		else
			self:_gotoByDealType(data.dealType)
		end

		if data.Id == 1 then
			FirstAnnualWelfareController.instance:saveSpecialOnceRedPoint(self._actId)
		end
	else
		FloatWordMgr.instance:show("功能未开启")
	end
end

function AnnualWelfareMainView:_gotoByDealType(dealType)
	if dealType == "goldenCard" then
		if self._curGainFreeGolgenCard then
			PayShopController.instance:openView(GameEnum.PayShopEasyJump.GoldenDiamondCard)
		else
			UIStateManager.instance:push(ViewName.NewhandprivilegeView, {
				source = NewhandwelfareEnum.PrivilegeViewSource_Annual,
				actId = self._actId
			})
		end
	elseif dealType == "skinTry" then
		if self._curGainSkinCard then
			FloatWordMgr.instance:show("今日已领取")
		else
			UIStateManager.instance:push(ViewName.SkinTryTakeView, self._actId)
		end
	end
end

function AnnualWelfareMainView:_onClickTip()
	UIStateManager.instance:push(ViewName.RulesView, "annualwelfaremainviewrule")
end

function AnnualWelfareMainView:_updateTime()
	if self._actTimeCfg then
		local startTimestamp, endTimestamp = ActivityDefineController.instance:getStartTimeAndEndTime(self._actTimeCfg.activityType, self._actTimeCfg.activityId)

		self._txtOpenTime.text = string.format("%s：%s", lang("activitytime"), GameUtil.getTimeTxt(startTimestamp, endTimestamp, GameEnum.TimeTxt.CN_M_D_H))
	else
		self._txtOpenTime.text = string.format("%s：", lang("activitytime"))
	end
end

return AnnualWelfareMainView
