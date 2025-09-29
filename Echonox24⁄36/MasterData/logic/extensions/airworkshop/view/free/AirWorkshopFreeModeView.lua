-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/view/free/AirWorkshopFreeModeView.lua

module("logic.extensions.airworkshop.view.free.AirWorkshopFreeModeView", package.seeall)

local M = class("AirWorkshopFreeModeView", ViewComponent)

function M:buildUI()
	self._canvasGroup = goutil.addComponentOnce(self.mainGO, ComponentType.CanvasGroup)
	self._btnRecord = self:getBtn("free_mode_view_528670074")
	self._btnEndlessRank = self:getBtn("free_mode_view_-554935889")
	self._scroll = self:getUIComponent("free_mode_view_884701865", UIComponentType.ScrollRect)
	self._rectTrLevelRoot = self:getUIComponent("free_mode_view_212649451", UIComponentType.RectTransform)
	self._btnEndlessMode = self:getBtn("free_mode_view_-600257398")
	self._goEndlessWinRecord = self:getGo("free_mode_view_-1085117651")
	self._txtEndlessWinRecord = self:getText("free_mode_view_-1576548467")

	self:_buildEntry()
end

function M:destroyUI()
	for _, btn in pairs(self._entryBtn or {}) do
		btn:RemoveClickListener()
	end

	self._entryBtn = nil
end

function M:bindEvents()
	self._btnRecord:AddClickListener(self._onClickRecord, self)
	self._btnEndlessRank:AddClickListener(self._onClickEndlessRank, self)
	self._btnEndlessMode:AddClickListener(self._onClickEndlessMode, self)
end

function M:unbindEvents()
	self._btnRecord:RemoveClickListener()
	self._btnEndlessRank:RemoveClickListener()
	self._btnEndlessMode:RemoveClickListener()
end

function M:onEnter()
	self._canvasGroup.interactable = true

	self:setEvent(true)

	local infoMo = AirWorkShopFreeModel.instance:getEndlessPlayerInfoMo()

	if Astral.OSDef.isEditor then
		TableUtil.dump(infoMo)
		printWarn(infoMo:getStatusMsg())
	end

	if infoMo:getMatchLevelNO() and infoMo:getMatchLevelNO().mapId and tonumber(infoMo:getMatchLevelNO().mapId) > 0 then
		self._txtEndlessWinRecord.text = infoMo:getCurWinNum()
	else
		self._txtEndlessWinRecord.text = ""
	end
end

function M:onExit()
	self._canvasGroup.interactable = false

	self:setEvent(false)
end

function M:setEvent(add)
	if add then
		-- block empty
	end
end

function M:_onClickRecord()
	ToolTipsMgr.showAirWorkShopFreeCheckRecordTips()
end

function M:_onClickEndlessRank()
	ToolTipsMgr.showAirWorkShopFreeRankTipsView()
end

function M:_onClickEndlessMode()
	ViewMgr.instance:open(ViewName.AirWorkShopFreeLevelSelectView, {
		airPlayType = AirAtkExtension_pb.AirPlayType.ENDLESS,
		id = self._cfgEndless.id
	})
end

function M:_onClickFreeEntry(index)
	local cfg = self._cfgLst[index]
	local airPlayType = AirWorkShopEnum.Id2AirPlayType[cfg.id]

	if airPlayType then
		ViewMgr.instance:open(ViewName.AirWorkShopFreeLevelSelectView, {
			airPlayType = airPlayType,
			id = cfg.id
		})
	else
		pringError(string.format("无法找到id[%s]对应的AirPlayType", cfg.id))
	end
end

function M:_buildEntry()
	self._cfgEndless = nil
	self._cfgLst = {}
	self._entryBtn = {}

	for _, cfg in ipairs(AirWorkShopConfig.instance:getConfigList(ConfigName.AirAtkFree) or {}) do
		if cfg.endless > 0 then
			self._cfgEndless = cfg
		else
			table.insert(self._cfgLst, cfg)
		end
	end

	while self._rectTrLevelRoot.childCount < #self._cfgLst do
		goutil.cloneAndSetParent(self._rectTrLevelRoot:GetChild(0).gameObject, self._rectTrLevelRoot)
	end

	for i = 0, self._rectTrLevelRoot.childCount - 1 do
		local go = self._rectTrLevelRoot:GetChild(i).gameObject

		self:_buildEntryCell(go, i + 1)
	end

	self._scroll.enabled = #self._cfgLst > 4
end

function M:_buildEntryCell(go, index)
	local cfg = self._cfgLst[index]

	goutil.setActive(go, cfg)

	if cfg then
		local txtName = goutil.findChildTextComponent(go, "txtNum")

		txtName.text = cfg.name

		local btnClick = UIComponentType.ButtonAdapter(goutil.findChild(go, "click").gameObject)

		btnClick:AddClickListener(function()
			self:_onClickFreeEntry(index)
		end, self)

		self._entryBtn[index] = btnClick
	end
end

return M
