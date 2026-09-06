-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/annimatch/view/AnnimatchBuffView.lua

module("logic.extensions.annimatch.view.AnnimatchBuffView", package.seeall)

local AnnimatchBuffView = class("AnnimatchBuffView", ViewComponent)

function AnnimatchBuffView:buildUI()
	AnnimatchBuffView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._bgBtnClose = Framework.UIClickTrigger.Get(self:getGo("bg"))
	self._btnGet = self:getBtn("btnGet")

	local bgCanvas = self:getGo("Canvas")

	GameUtil.expandRectTransform(bgCanvas.transform)

	self._cell = self:getGo("cell")

	goutil.setActive(self._cell, false)

	self._cellRoot = self:getGo("cellRoot")
	self._gridHeight = GameUtil.getHeight(self._cell)
	self._gridWidth = GameUtil.getWidth(self._cell)
	self._gridGap = 30

	self:_initCells()
end

function AnnimatchBuffView:bindEvents()
	AnnimatchBuffView.super.bindEvents(self)
	self._btnGet:AddClickListener(self._onClickGet, self)

	for i, v in ipairs(self._cellList) do
		v.btn:AddClickListener(function()
			self:_onClickItem(i)
		end)
		v.viewClick:RemoveClickListener()
		v.viewClick:AddClickListener(function()
			self:_onClickItem(i)
		end, self)
	end
end

function AnnimatchBuffView:unbindEvents()
	AnnimatchBuffView.super.unbindEvents(self)
	self._btnGet:RemoveClickListener()

	for i, v in ipairs(self._cellList) do
		v.btn:RemoveClickListener()
		v.viewClick:RemoveClickListener()
	end
end

function AnnimatchBuffView:_onClickClose()
	self:close()
end

function AnnimatchBuffView:_onClickGet()
	local activityId = AnnimatchController.instance:getCurrActId()
	local buffId = self._idList[self._curSelectIndex]

	AnnimatchController.instance:sendSetBuff(activityId, buffId)
	self:_onClickClose()
end

function AnnimatchBuffView:_onClickItem(index)
	self._curSelectIndex = index

	self:_setupBuffList()
end

function AnnimatchBuffView:onEnter()
	local activityId = AnnimatchController.instance:getCurrActId()

	self._idList = AnnimatchModel.instance:getCurrSelectBuffIds(activityId)
	self._curSelectIndex = 1

	self:_setupBuffList()
	GameUtil.SetActive(self._btnClose, false)
end

function AnnimatchBuffView:onExit()
	AnnimatchBuffView.super.onExit(self)
	self:_stopSelectEffect()
	self:_resetCells()
end

function AnnimatchBuffView:_initCells()
	self._cellList = {}

	for i = 1, 3 do
		local go = goutil.cloneAndSetParent(self._cell, self._cellRoot.transform, "cell" .. i)

		goutil.setActive(go, false)

		local element = {}

		element.go = go
		element.btn = Framework.ButtonAdapter.GetFrom(go, "btn")
		element.txtName = goutil.findChildTextComponent(go, "txtName")
		element.txtDesc = goutil.findChildTextComponent(go, "View/Viewport/Content/txtDesc")
		element.bufIcon = Framework.ImageBigBG.GetFrom(go, "BuffIcon")
		element.buffLv = goutil.findChildComponent(go, "level", "UIImageSpriteChange")
		element.buffLvState = goutil.findChildComponent(go, "icon", "UIImageSpriteChange")
		element.buffLvIcon = element.buffLv:GetComponent(typeof(UnityEngine.UI.Image))
		element.scrollRect = goutil.findChildComponent(go, "View", "ScrollRect")
		element.content = goutil.findChild(go, "View/Viewport/Content").transform
		element.viewClick = Framework.UIClickTrigger.Get(element.scrollRect.gameObject)
		element.leftSide = goutil.findChild(element.go, "LeftSide")
		element.rightSide = goutil.findChild(element.go, "RightSide")

		table.insert(self._cellList, element)
	end
end

function AnnimatchBuffView:_playSelectEffect(go)
	self:_stopSelectEffect()

	local eff = UIEffectManager.instance:playEffectBrief(self, "fx_ui_yuanzheng/fx_ui_yuanzheng_xuanka.prefab", go.transform, true)

	eff:setParent(go.transform)
	eff:setLocalPos(118, 0, 0)
	eff:setScale(1)
	eff:setSortingOrder(220)

	self._selectEff = eff
end

function AnnimatchBuffView:_stopSelectEffect()
	if self._selectEff then
		UIEffectManager.instance:stopEffect(self._selectEff)

		self._selectEff = nil
	end
end

function AnnimatchBuffView:_setupBuffList()
	self:_stopSelectEffect()
	self:_resetCells()

	local activityId = AnnimatchController.instance:getCurrActId()
	local anniCfg = AnnimatchConfig.instance:getCfgById(activityId)

	for k, v in ipairs(self._idList) do
		local cfg = AnnimatchConfig.instance:getBuffCfg(anniCfg.buffPlanId, v)
		local grid = self._cellList[k]

		goutil.setActive(grid.go, false)

		if cfg then
			local index = k

			goutil.setActive(grid.go, true)

			grid.txtName.text = cfg.name
			grid.txtDesc.text = cfg.desc

			grid.bufIcon:SetImage(GameUrl.getExpEventUrl(cfg.icon))
			grid.buffLv:SetState(cfg.quality)
			grid.buffLvState:SetState(checknumber(cfg.nature))
			grid.buffLvIcon:SetNativeSize()

			if self._curSelectIndex == index then
				self:_playSelectEffect(grid.go)
			end

			GameUtil.setLocalPos(grid.go, (k - 1) * (self._gridWidth + self._gridGap), 0, 0)
			Framework.TransformUtil.SetLocalPos(grid.content, 0, 0, 0)

			local sizeDelta = grid.content.sizeDelta

			sizeDelta.y = grid.txtDesc.preferredHeight + 8
			grid.content.sizeDelta = sizeDelta

			local preferredHeight = grid.txtName.preferredWidth
			local widthDelta = math.max(0, preferredHeight - 120) * 0.5

			Framework.TransformUtil.SetAnchoredPos(grid.leftSide.transform, -68 - widthDelta, -40)
			Framework.TransformUtil.SetAnchoredPos(grid.rightSide.transform, 72 + widthDelta, -40)
		end
	end
end

function AnnimatchBuffView:_resetCells()
	for i, v in ipairs(self._cellList) do
		v.bufIcon:ClearImage()
		v.go:SetActive(false)
	end
end

function AnnimatchBuffView:checkOpenReplace()
	local activityId = AnnimatchController.instance:getCurrActId()
	local replaceCreepsIds = AnnimatchModel.instance:getReplaceCreepsIds(activityId)

	if replaceCreepsIds and #replaceCreepsIds > 0 then
		return true
	end

	return false
end

return AnnimatchBuffView
