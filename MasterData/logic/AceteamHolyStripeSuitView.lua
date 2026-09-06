-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aceteam/view/petshow/AceteamHolyStripeSuitView.lua

module("logic.extensions.aceteam.view.petshow.AceteamHolyStripeSuitView", package.seeall)

local AceteamHolyStripeSuitView = class("AceteamHolyStripeSuitView", ViewComponent)

function AceteamHolyStripeSuitView:ctor()
	AceteamHolyStripeSuitView.super.ctor(self)
end

function AceteamHolyStripeSuitView:buildUI()
	AceteamHolyStripeSuitView.super.buildUI(self)

	self._suitFitlerGo = self:getGo("suitFitlerRoot")
	self._cellGo = self:getGo("suitFitlerRoot/tablecell")
	self._rootGo = self:getGo("suitFitlerRoot/tableview")
	self._tableview = ScrollerList.create(self._rootGo, self._cellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._selectAllBtn = self:getBtn("suitFitlerRoot/select/btn")
	self._customInput = UICustomInput.Get(self:getGo("suitFitlerRoot"))
	self._suitGo = self:getGo("suitFitlerRoot")
	self._selectUIChange = goutil.findChildComponent(self._suitGo, "select", "UIChangeGroup")
end

function AceteamHolyStripeSuitView:bindEvents()
	AceteamHolyStripeSuitView.super.bindEvents(self)
	self._customInput:AddListener(self._onCustomInputCallback, self)
	self._selectAllBtn:AddClickListener(self._onSelectBtnClick, self)
end

function AceteamHolyStripeSuitView:unbindEvents()
	AceteamHolyStripeSuitView.super.unbindEvents(self)
	self._customInput:RemoveListener()
	self._selectAllBtn:RemoveClickListener()
end

function AceteamHolyStripeSuitView:onEnter()
	AceteamHolyStripeSuitView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.AceteamHolyStripeSuitOpen, self._openSuitList, self)
	GameUtil.SetActive(self._suitFitlerGo, false)
	self._selectUIChange:SetState(1)
	self:_updateList()
end

function AceteamHolyStripeSuitView:onExit()
	AceteamHolyStripeSuitView.super.onExit()
	GlobalDispatcher:removeListener(GlobalNotify.AceteamHolyStripeSuitOpen, self._openSuitList, self)
	self._tableview:dispose()
end

function AceteamHolyStripeSuitView:_updateList(suitId)
	self._params = suitId
	self._curSuitCfg = AceTeamConfig.instance:getHolyStripeSuitCfg(checknumber(self._params))

	local list = AceTeamConfig.instance:getHolyStripeAllSuitCfg()

	self._tableview:reloadData(list)
end

function AceteamHolyStripeSuitView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local uiChange = go:GetComponent("UIChangeGroup")
	local icon = goutil.findChild(go, "icon")
	local txt = goutil.findChildTextComponent(go, "txt")
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local btn = GameUtil.asBtn(goutil.findChild(go, "raycast"))

	if self._params and data.suitId == self._params then
		uiChange:SetState(1)
	else
		uiChange:SetState(0)
	end

	uGuiUtil.clearImage(icon)
	uGuiUtil.setSpriteToImage(icon, nil, GameUrl.getItemIconUrl(data.suitIcon))

	txtName.text = data.suitName
	txt.text = data.suitDesc

	btn:AddClickListener(function()
		self:_onItemClick(data.suitId)
	end)
end

function AceteamHolyStripeSuitView:_clearCell(cell)
	local go = cell.gameObject
	local btn = GameUtil.asBtn(goutil.findChild(go, "raycast"))
	local icon = goutil.findChild(go, "icon")

	uGuiUtil.clearImage(icon)
	btn:RemoveClickListener()
end

function AceteamHolyStripeSuitView:_onCustomInputCallback(hover)
	if not hover then
		self:_onSelectBtnClick()
	end
end

function AceteamHolyStripeSuitView:_onItemClick(suitId)
	GlobalDispatcher:dispatch(GlobalNotify.AceteamHolyStripeSuitTryChange, suitId)
	self:_updateList(suitId)
end

function AceteamHolyStripeSuitView:_onSelectBtnClick()
	local petMo = AceTeamModel.instance:getCurrPetMo()
	local changeCost = AceTeamConfig.instance:getCommonValue("CHANGE_HOLY_STRIPE_SUIT_COST", true)

	if petMo.holyStripeSuitId ~= self._params and self._curSuitCfg then
		local suitId = self._curSuitCfg.suitId

		self._customInput:RemoveListener()

		local changeTip = langPara("确认是否消耗%d战队积分更换灵纹为%s", changeCost, self._curSuitCfg.suitName)

		local function sureChange()
			self:_closeSuitChange()
			AceTeamController.instance:sendChangeHolyStripe(petMo:getId(), suitId)
		end

		local function canelChange()
			self._customInput:AddListener(self._onCustomInputCallback, self)
			self:_closeSuitChange()
		end

		TipsFacade.instance:openPopupWindow(lang("text_tong_tips"), changeTip, sureChange, canelChange)
	else
		self:_closeSuitChange()
	end
end

function AceteamHolyStripeSuitView:_openSuitList(suitId)
	if suitId then
		GameUtil.SetActive(self._suitFitlerGo, true)
		self:_updateList(suitId)
	else
		self:_closeSuitChange()
	end

	self._customInput:AddListener(self._onCustomInputCallback, self)
end

function AceteamHolyStripeSuitView:_closeSuitChange()
	GlobalDispatcher:dispatch(GlobalNotify.AceteamHolyStripeSuitTryChange)
	GameUtil.SetActive(self._suitFitlerGo, false)
	self._customInput:RemoveListener()
end

return AceteamHolyStripeSuitView
