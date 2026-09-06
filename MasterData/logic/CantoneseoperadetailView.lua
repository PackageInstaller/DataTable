-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cantoneseopera/view/CantoneseoperadetailView.lua

module("logic.extensions.cantoneseopera.view.CantoneseoperadetailView", package.seeall)

local CantoneseoperadetailView = class("CantoneseoperadetailView", ViewComponent)

function CantoneseoperadetailView:ctor()
	CantoneseoperadetailView.super.ctor(self)
end

function CantoneseoperadetailView:unbindEvents()
	CantoneseoperadetailView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self.btnClose)
	GameUtil.rmClickHandler(self.btnShare)
end

function CantoneseoperadetailView:bindEvents()
	CantoneseoperadetailView.super.bindEvents(self)
	GameUtil.addClickHandler(self.btnClose, self.close, self)
	GameUtil.addClickHandler(self.btnShare, self.onClickShare, self)
	GameUtil.addClickHandler(self.btnPrevious, self.onClickPrevious, self)
	GameUtil.addClickHandler(self.btnNext, self.onClickNext, self)
end

function CantoneseoperadetailView:buildUI()
	CantoneseoperadetailView.super.buildUI(self)

	self.btnClose = self:getGo("btnClose")
	self.btnShare = self:getGo("btnShare")
	self.bgImage = self:getGo("bg")
	self.container = self:getGo("container")
	self.bubble = self:getGo("bubble")
	self.reward = self:getGo("bubble/reward")
	self.txt = self:getGo("txt")
	self.page3 = self:getGo("page3")
	self.btnPrevious = self:getBtn("btnPrevious")
	self.btnNext = self:getBtn("btnNext")
end

function CantoneseoperadetailView:onExit()
	CantoneseoperadetailView.super.onExit(self)
	uGuiUtil.clearImage(self.bgImage)
	MaterialMgr.resetAll(self.reward)
	GlobalDispatcher:removeListener(GlobalNotify.OnCantoneseOperaInfo, self.refreshUI, self)
end

function CantoneseoperadetailView:onEnter()
	CantoneseoperadetailView.super.onEnter(self)

	self.prizeNodeId = self:getFirstParam()

	GameUtil.SetActive(self.txt, false)
	GameUtil.SetActive(self.page3, self.prizeNodeId == 3)
	self:refreshUI()
	GlobalDispatcher:addListener(GlobalNotify.OnCantoneseOperaInfo, self.refreshUI, self)
	CantoneseOperaController.instance:sendGainPrize(self.prizeNodeId)
end

function CantoneseoperadetailView:onClickShare()
	self.activityId = CantoneseOperaController.instance:getActivityId()

	local infoCfg = CantoneseOperaConfig.instance:getActivityCfg(self.activityId) or {}
	local planCfg = CantoneseOperaConfig.instance:getPlanCfg(infoCfg.planId, self.prizeNodeId) or {}

	ShareController.instance:share(planCfg.shareId, {
		self.btnShare.gameObject,
		self.bubble
	}, nil, 200321)
end

function CantoneseoperadetailView:refreshUI()
	goutil.clearChildren(self.container)

	self.activityId = CantoneseOperaController.instance:getActivityId()

	local infoCfg = CantoneseOperaConfig.instance:getActivityCfg(self.activityId) or {}
	local planCfg = CantoneseOperaConfig.instance:getPlanCfg(infoCfg.planId, self.prizeNodeId) or {}
	local descList = CantoneseOperaConfig.instance:getDescList(self.prizeNodeId)
	local prize = ShareController.instance.activeByTimes(planCfg.shareId, self.bubble)

	self._shareProxy = MaterialMgr.setCellByCfg(prize, self.reward)

	if self.prizeNodeId ~= 3 then
		self.pageNum = 1

		self:pageSetUI(self.pageNum)
	else
		GameUtil.SetActive(self.page3, true)
		GameUtil.SetActive(self.btnNext, false)
		GameUtil.SetActive(self.btnPrevious, false)
	end
end

function CantoneseoperadetailView:pageSetUI(pageId)
	local pageDescList = CantoneseOperaConfig.instance:getDescListPage(self.prizeNodeId, pageId)

	GameUtil.SetActive(self.btnPrevious, pageId > 1)
	GameUtil.SetActive(self.btnNext, pageId < 4 and #pageDescList ~= 0)

	if #pageDescList == 0 then
		pageDescList = CantoneseOperaConfig.instance:getDescListPage(self.prizeNodeId, 0)
	end

	for i, cfg in pairs(pageDescList) do
		uGuiUtil.setSpriteToImage(self.bgImage.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getBigbgFolderUrl("cantoneseopera", cfg.bgName), function()
			self.bgImage.gameObject:GetComponent("Image"):SetNativeSize()
		end)

		local childCount = self.container.transform.childCount

		if childCount > #pageDescList then
			for child = #pageDescList + 1, childCount do
				GameUtil.SetActive(goutil.findChild(self.container, "txt_" .. child), false)
			end
		end

		local txtGo = goutil.findChild(self.container, "txt_" .. i)

		if txtGo == nil then
			txtGo = goutil.clone(self.txt, "txt_" .. i)
		end

		goutil.addChildToParent(txtGo, self.container)
		GameUtil.SetActive(txtGo, true)

		local txt = txtGo:GetComponent(goutil.Type_UIText)
		local txtTitle = goutil.findChildTextComponent(txtGo, "imgTitle/txt")
		local arr = string.split(cfg.posInfo, ",")
		local x, y, width = checknumber(arr[1]), checknumber(arr[2]), checknumber(arr[3])

		GameUtil.setAnchoredPos(txtGo, x, y)
		GameUtil.setWidth(txtGo, width)

		local icon = goutil.findChild(txtGo, "icon")

		GameUtil.SetActive(icon, not string.nilorempty(cfg.iconName))

		local arrIcon = string.split(cfg.iconPos, ",")
		local iconX, iconY = checknumber(arrIcon[1]), checknumber(arrIcon[2])

		GameUtil.setAnchoredPos(icon, iconX, iconY)

		if not string.nilorempty(cfg.iconPos) then
			uGuiUtil.setSpriteToImage(icon.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getBigbgFolderUrl("cantoneseopera", cfg.iconName), function()
				icon.gameObject:GetComponent("Image"):SetNativeSize()
			end)
		end

		txt.text = cfg.desc
		txtTitle.text = cfg.title
	end
end

function CantoneseoperadetailView:onClickPrevious()
	self.pageNum = self.pageNum - 1

	self:pageSetUI(self.pageNum)
end

function CantoneseoperadetailView:onClickNext()
	self.pageNum = self.pageNum + 1

	self:pageSetUI(self.pageNum)
end

return CantoneseoperadetailView
