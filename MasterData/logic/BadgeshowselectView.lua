-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/badge/view/BadgeshowselectView.lua

module("logic.extensions.badge.view.BadgeshowselectView", package.seeall)

local BadgeshowselectView = class("BadgeshowselectView", ViewComponent)

function BadgeshowselectView:ctor()
	BadgeshowselectView.super.ctor(self)
end

function BadgeshowselectView:buildUI()
	BadgeshowselectView.super.buildUI(self)

	self._changeIndex = self:getGo("changeIndex")
	self._closeBtn = self:getBtn("closeBtn")
	self._badgeCell = self:getGo("bg/badgeCell")
	self._badgeView = ScrollerList.create(self:getGo("bg/badgeView"), self._badgeCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._emptyText = goutil.findChildTextComponent(self.mainGO, "bg/emptyText")
end

function BadgeshowselectView:bindEvents()
	BadgeshowselectView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
end

function BadgeshowselectView:unbindEvents()
	BadgeshowselectView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
end

function BadgeshowselectView:destroyUI()
	BadgeshowselectView.super.destroyUI(self)
end

function BadgeshowselectView:onEnter()
	BadgeshowselectView.super.onEnter(self)

	self._badgeList = {}

	local replaceableBadge = BadgeController.instance:getReplaceableBadge()
	local cardInfo = RoleModel.instance:getCardInfoMo(RoleModel.CardBelong.My)

	self._selectId = cardInfo.badgeIds[self:getFirstParam()] and cardInfo.badgeIds[self:getFirstParam()].left or nil

	if replaceableBadge and #replaceableBadge > 0 then
		if self._selectId then
			local data = {
				{
					remove = true
				}
			}

			for i, value in ipairs(replaceableBadge) do
				table.insert(data, value)
			end

			self._badgeView:reloadData(data)
		else
			self._badgeView:reloadData(replaceableBadge)
		end

		goutil.setActive(self._emptyText.gameObject, false)
	else
		if self._selectId then
			self._badgeView:reloadData({
				{
					remove = true
				}
			})

			self._emptyText.text = "当前没有可替换的勋章"
		else
			self._badgeView:reloadData({})

			self._emptyText.text = "当前没有可展示的勋章"
		end

		goutil.setActive(self._emptyText.gameObject, true)
	end

	local anchor = GameUtil.getAnchoredPos(self._changeIndex)

	GameUtil.setAnchoredPos(self._changeIndex, 200.135 + (self:getFirstParam() - 1) * 90, anchor.y)
end

function BadgeshowselectView:onEnterFinished()
	BadgeshowselectView.super.onEnterFinished(self)
end

function BadgeshowselectView:onExit()
	BadgeshowselectView.super.onExit(self)
	self._badgeView:dispose()
end

function BadgeshowselectView:onExitFinished()
	BadgeshowselectView.super.onExitFinished(self)
end

function BadgeshowselectView:_updateCell(view, cell, data)
	local starGroup = goutil.findChild(cell.gameObject, "starLv")
	local con = goutil.findChild(cell.gameObject, "con")
	local badgeBgChange = goutil.findChildComponent(cell.gameObject, "badgeBg", "UIImageSpriteChange")

	GameUtil.SetActive(badgeBgChange, false)

	if data.remove then
		goutil.setActive(goutil.findChild(cell.gameObject, "remove"), true)
		MaterialMgr.resetAll(con)

		self._badgeList[cell] = nil

		Framework.ButtonAdapter.Get(cell.gameObject):AddClickListener(function()
			self:close()
			BadgeController.instance:changeBadge(self._selectId)
		end)
		GameUtil.SetActive(starGroup, false)
	else
		local info = BadgeModel.instance:getBadgeInfoById(data.id)
		local cfg = BadgeConfig.instance:getDefineById(data.id)

		goutil.setActive(goutil.findChild(cell.gameObject, "remove"), false)
		Framework.ButtonAdapter.Get(cell.gameObject):RemoveClickListener()

		local proxy = MaterialMgr.setCell(MatType.Item_Badge, data.id, con)

		self._badgeList[cell] = proxy

		proxy.binder:setActiveImgC_Bg(false)
		proxy.binder:setGray(false)
		proxy:setAutoTips(false)

		if info then
			proxy.binder:setLevel(info.level)
		end

		self._badgeList[cell].binder:setClick(function()
			self:close()
			BadgeController.instance:changeBadge(self._selectId, data.id)
		end)

		local iconGroupCfg = BadgeConfig.instance:getIconGroup(cfg.iconGroupId)

		if info and info.level and iconGroupCfg and not iconGroupCfg[info.level] then
			GameUtil.SetActive(starGroup, true)

			local addLevel = info.level - #iconGroupCfg
			local totalCount = starGroup.transform.childCount
			local iconState = 0

			if addLevel > 0 then
				iconState = math.floor((addLevel - 1) / totalCount)
			end

			addLevel = addLevel - iconState * totalCount

			for i = 1, starGroup.transform.childCount do
				local starGo = goutil.findChild(starGroup, "star_" .. i)
				local starImgChange = starGo:GetComponent(ComponentType.UIImageSpriteChange)

				starImgChange:SetState(iconState)
				GameUtil.SetActive(starGo, i <= addLevel)
			end
		else
			GameUtil.SetActive(starGroup, false)
		end
	end
end

function BadgeshowselectView:_clearCell(cell)
	if self._badgeList[cell] then
		self._badgeList[cell].binder:RemoveClickListener()
	end
end

return BadgeshowselectView
