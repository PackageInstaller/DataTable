-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/autochess/view/AutochessfettertipsView.lua

module("logic.extensions.autochess.view.AutochessfettertipsView", package.seeall)

local AutochessfettertipsView = class("AutochessfettertipsView", ViewComponent)

function AutochessfettertipsView:unbindEvents()
	AutochessfettertipsView.super.unbindEvents(self)
	self._customInput:RemoveListener()
end

function AutochessfettertipsView:bindEvents()
	AutochessfettertipsView.super.bindEvents(self)
	self._customInput:AddListener(self._onCustomInputCallback, self)
end

function AutochessfettertipsView:_onCustomInputCallback(hover)
	if not hover then
		self:close()
	end
end

function AutochessfettertipsView:onExit()
	AutochessfettertipsView.super.onExit(self)
	self._scrollList:dispose()
end

function AutochessfettertipsView:buildUI()
	AutochessfettertipsView.super.buildUI(self)

	self.content = self:getGo("Nego_Content")
	self._customInput = UICustomInput.Get(self.content)
	self._adjustPosition = self.content:GetComponent("UIAdjustPosition")
	self._txtName = self:getTxt("Nego_Content/top/txtName")
	self._tableviewGo = self:getGo("Nego_Content/tableview")
	self._tablecellGo = self:getGo("Nego_Content/tablecell")
	self._buffIcon = self:getGo("Nego_Content/top/icon"):GetComponent(ComponentType.UIImageSpriteChange)
	self._scrollList = ScrollerList.create(self._tableviewGo, self._tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function AutochessfettertipsView:onEnter()
	AutochessfettertipsView.super.onEnter(self)

	local params = self:getOpenParam()

	self._fetterId = params[1]

	self:_updateUI()
end

function AutochessfettertipsView:_adjustPos(clickUIGo)
	local sizeDelta = {
		0,
		0
	}
	local pos

	if clickUIGo and clickUIGo.gameObject then
		local rect = clickUIGo.gameObject:GetComponent("RectTransform")

		if rect ~= nil then
			sizeDelta = {
				rect.sizeDelta.x,
				rect.sizeDelta.y
			}
		end

		pos = clickUIGo.gameObject.transform.position

		local uiCamera = CameraTargetMgr.instance:getUICameraTarget():getCamera()

		pos = uiCamera:WorldToScreenPoint(pos)
	end

	if pos then
		self._adjustPosition:AdjustScreenPosition(pos, sizeDelta[1], sizeDelta[2])
	end
end

function AutochessfettertipsView:_updateUI()
	local fcfg = AutochessConfig.instance:getFettersCfg(self._fetterId)

	self._buffIcon:ChangeSprite(fcfg.iconPath)

	self._txtName.text = fcfg.name

	local cfgs = AutochessConfig.instance:getFettersBuffCfgs(self._fetterId)
	local newCfgs = table.values(cfgs)

	table.sort(newCfgs, function(a, b)
		return a.num < b.num
	end)
	self._scrollList:reloadData(newCfgs)
end

function AutochessfettertipsView:_updateCell(view, cell, fettersBuffCfg, tag)
	local txtCondition = goutil.findChildTextComponent(cell.gameObject, "txtCondition")
	local txtDesc = goutil.findChildTextComponent(cell.gameObject, "txtDesc")
	local txtName = goutil.findChildTextComponent(cell.gameObject, "txtName")

	txtName.text = fettersBuffCfg.name
	txtDesc.text = fettersBuffCfg.buffDesc
	txtCondition.text = string.format("(%s人同时上阵)", fettersBuffCfg.num)
end

function AutochessfettertipsView:_clearCell(cell)
	return
end

return AutochessfettertipsView
