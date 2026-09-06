-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aceteam/view/ActstargodchangeView.lua

module("logic.extensions.aceteam.view.ActstargodchangeView", package.seeall)

local ActstargodchangeView = class("ActstargodchangeView", ViewComponent)

function ActstargodchangeView:ctor()
	ActstargodchangeView.super.ctor(self)
end

function ActstargodchangeView:unbindEvents()
	ActstargodchangeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self.btnClose)
	GameUtil.rmClickHandler(self.btnSure)
end

function ActstargodchangeView:bindEvents()
	ActstargodchangeView.super.bindEvents(self)
	GameUtil.addClickHandler(self.btnClose, self.close, self)
	GameUtil.addClickHandler(self.btnSure, self.onClickSure, self)
end

function ActstargodchangeView:buildUI()
	ActstargodchangeView.super.buildUI(self)

	self.btnClose = self:getGo("btnClose")
	self.btnSure = self:getGo("btnSure")
	self.txtCost = self:getTxt("txtCost")
	self.txtCostIcon = self:getGo("txtCost/icon")
	self.tableview = self:getGo("tableview")
	self.cell = self:getGo("cell")
	self.scrollList = ScrollerList.create(self.tableview, self.cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self.clearCell, self))
end

function ActstargodchangeView:onExit()
	ActstargodchangeView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_ACETEAM_STARGOD_CHANGE, self.onRefreshUI, self)
	self.scrollList:dispose()
	MaterialMgr.clearIcon(self.txtCostIcon)
end

function ActstargodchangeView:onEnter()
	ActstargodchangeView.super.onEnter(self)

	self.petMo = AceTeamModel.instance:getCurrPetMo()
	self.solt = checknumber(self:getFirstParam())
	self.stargodMap = {}

	for i, star in ipairs(self.petMo.starGodPlusSlots) do
		self.stargodMap[star.fillerDefineId] = star
	end

	self.curSelectId = -1

	local listStr = AceTeamConfig.instance:getCommonValue("STAR_GOD_LIST")
	local list = string.splitToNumber(listStr, "#")

	for i, v in ipairs(list) do
		if self.stargodMap[v] == nil then
			self.curSelectId = v

			break
		end
	end

	self.scrollList:reloadData(list)
	self.scrollList:refresh()

	local cost = checknumber(AceTeamConfig.instance:getCommonValue("REPLACE_STAR_GOD_NEED_SCORE"))
	local total = MaterialModel.instance:getMaterialsNumber(MatType.Item_Fake, AceTeamModel.ITEM_ACE_POINT)

	self.txtCost.text = langPara("actstargodchangeview__1", cost, total)

	MaterialMgr.setIcon(self.txtCostIcon, MatType.Item_Fake, AceTeamModel.ITEM_ACE_POINT)
	GlobalDispatcher:addListener(GlobalNotify.PM_ACETEAM_STARGOD_CHANGE, self.onRefreshUI, self)
end

function ActstargodchangeView:onRefreshUI()
	self:close()
end

function ActstargodchangeView:_updateCell(view, cell, data, tag)
	local con = goutil.findChild(cell, "con")
	local selected = goutil.findChild(cell, "selected")
	local nameText = goutil.findChildTextComponent(cell, "nameText")
	local nameChange = nameText.gameObject:GetComponent(ComponentType.UITextColorChange)
	local top = goutil.findChild(cell, "top")

	GameUtil.addClickHandler(top, GameUtil.handler(self.onClickCell, self, data))

	local proxy = MaterialMgr.setCell(MatType.StarGodPlus, data, con)

	if proxy then
		if self.stargodMap[data] == nil then
			proxy.binder:SetGray(false)
		else
			proxy.binder:SetGray(true)
		end
	end

	GameUtil.SetActive(selected, self.curSelectId == data)

	local _cfg = StargodplusConfig.instance:getFillerCfg(data)

	nameChange:SetState(_cfg.quality)

	nameText.text = _cfg.name
end

function ActstargodchangeView:clearCell(cell)
	local con = goutil.findChild(cell, "con")

	MaterialMgr.resetAll(con)
end

function ActstargodchangeView:onClickCell(data)
	if self.stargodMap[data] == nil then
		self.curSelectId = data

		self.scrollList:refresh()
	else
		TipsFacade.instance:openCommonTips(lang("actstargodchangeview__3"))
	end
end

function ActstargodchangeView:onClickSure()
	local petId = self.petMo.petId

	AceTeamController.instance:sendChangeStarGod(petId, self.solt, self.curSelectId)
end

return ActstargodchangeView
