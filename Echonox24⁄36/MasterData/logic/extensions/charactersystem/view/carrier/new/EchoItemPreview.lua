-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/carrier/new/EchoItemPreview.lua

module("logic.extensions.charactersystem.view.carrier.new.EchoItemPreview", package.seeall)

local M = class("EchoItemPreview", EchoItemMainViewNew)

function M:buildUI()
	M.super.buildUI(self)

	self._goLeftContent = self:getGo("echo_view_copy_1495753063")
	self._goBtnList = goutil.findChild(self.mainGO, "btnList")
	self._goContentBtn = goutil.findChild(self.mainGO, "echo_break_panel/echo_detail_panel/node/content3")
end

function M:onEnter(reasonTyp)
	self._guiAnimation:StopTimelineAni()
	self:setEvent(true)

	local params = self:getFirstParam() or {}

	self._defaultPageTyp = params.index and params.index or M.SubViewType.Change
	self._echoItemData = params.itemData

	local echoItemId = echoItemData and echoItemData:getId() or 0

	for _, _subViewComp in pairs(self._subViewComp or {}) do
		_subViewComp:onEnter()
	end

	self._showCardView:onEnter()
	self._showCardView:showGyros()
	self._showCardView:refreshView(echoItemId)
	self._showCardView:setAddBtnVisible(true)
	self:refreshBaseInfo()

	local readyDefaultPageType = self._defaultPageTyp

	if self._viewPresentor:getIsBackOpen() and self._curShowType then
		readyDefaultPageType = self._curShowType
	end

	self:changeSubPage(readyDefaultPageType)
	self:blockClickCanvasGroup(self._canvasGroupMain, false)

	if params.echoTestView then
		self._showCardView:openEchoTestView()
	end

	self:_hideContent()
end

function M:changeSubPage(typ, resetPos, playOpenAni)
	self._curShowType = typ

	local guiAnimName = typ == M.SubViewType.Break and "open_tupo" or "open2"

	self._guiAnimation:ClearAllBinding()
	self._guiAnimation:StopTimelineAni()
	self._guiAnimation:SetAniTime(0)
	self:refreshPanelPos(typ)
	self:refreshBlurBg(typ)
	self._showCardView:resetAnimByName("echo_show_card_open")
	self._showCardView:setUpgradeVFXVisible(false)
	self._showCardView:setUpgradeReadyVFXVisible(false)
	goutil.setActive(self._goRolePowerPointRoot, typ == M.SubViewType.Change)
	goutil.setActive(self._goBreakInfoShow, typ == M.SubViewType.Break)
	goutil.setActive(self._goBreakPercentRoot, typ == M.SubViewType.Break)
	goutil.setActive(self._goBgNormal, typ ~= M.SubViewType.Break)
	goutil.setActive(self._goBgBreak, true)
	self:_hideContent()

	local echoLst = {}

	if typ == EchoItemMainViewNew.SubViewType.Change then
		echoLst = self:getSubViewComp(EchoItemMainViewNew.SubViewComp.Filter):getFilterEchoItemData()

		local selectedEcho = EchoItemMainController.instance:getSelectedEchoItem()

		if typ == M.SubViewType.Change then
			echoLst = self:getSubViewComp(M.SubViewComp.Filter):getFilterEchoItemData()

			if not selectedEcho then
				selectedEcho = echoLst[1]
			end
		end

		EchoItemMainController.instance:setSelectedEchoItem(self._echoItemData)
	elseif typ == EchoItemMainViewNew.SubViewType.Break then
		EchoItemMainController.instance:clearCostEchoItemForBreakList()
		self:refreshBreakInfoShow(false)
		EchoItemMainController.instance:updateAvailableEchoItem()

		echoLst = EchoItemMainController.instance:getAvailableEchoItem():getMoList()
	end

	self._guiAnimation:PlayAniByName(guiAnimName)

	for _, _subViewComp in ipairs(self._subViewComp or {}) do
		_subViewComp:onPageTypChange(typ, echoLst)
	end

	self._subViewComp[M.SubViewComp.Filter]:setVisible(false)
	self._subViewComp[M.SubViewComp.Node]:hideLock()
	self:localNotify(EventType.UPDAET_TOP_MONEY_VIEW_SHOW, M.MoneyShowType[typ] or CommEnum.MoneyShowType.DefaultHideType)
	self._showCardView:setAddBtnVisible(false)
	self:refreshRightTopBtn()
end

function M:getCamCode(heroId)
	return 0
end

function M:_hideContent()
	self._txtTitle.text = lang("tip_compound_preview")

	goutil.setActive(self._goBtnList, false)
	goutil.setActive(self._goContentBtn, false)
	goutil.setActive(self._goLeftContent, false)
	goutil.setActive(self._goRolePowerPointRoot, false)
end

return M
