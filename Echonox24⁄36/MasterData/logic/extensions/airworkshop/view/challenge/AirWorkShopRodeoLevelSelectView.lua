-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/view/challenge/AirWorkShopRodeoLevelSelectView.lua

module("logic.extensions.airworkshop.view.challenge.AirWorkShopRodeoLevelSelectView", package.seeall)

local M = class("AirWorkShopRodeoLevelSelectView", ViewComponent)

function M:ctor()
	M.super.ctor(self)
end

function M:buildUI()
	self._canvasGroup = goutil.addComponentOnce(self.mainGO.gameObject, ComponentType.CanvasGroup)
	self._txtRoundProgress = self:getText("sports_mode_level_select_view_-2001593205")
	self._txtScore = self:getText("sports_mode_level_select_view_-583299576")
	self._btnGiveUp = self:getBtn("sports_mode_level_select_view_-1214351133")
	self._rectTrProgressRoot = self:getUIComponent("sports_mode_level_select_view_-1764254626", UIComponentType.RectTransform)
	self._goProgressLst = {}

	for i = 0, self._rectTrProgressRoot.childCount - 1 do
		local go = goutil.findChild(self._rectTrProgressRoot:GetChild(i).gameObject, "imgLight").gameObject

		table.insert(self._goProgressLst, go)
	end

	self._rectTrTopHeartRoot = self:getUIComponent("sports_mode_level_select_view_1475601924", UIComponentType.RectTransform)
	self._goHeartLst = {}

	for i = 0, self._rectTrTopHeartRoot.childCount - 1 do
		local go = goutil.findChild(self._rectTrTopHeartRoot:GetChild(i).gameObject, "imgLight").gameObject

		table.insert(self._goHeartLst, go)
	end

	self._rectTrLevelRoot = self:getUIComponent("sports_mode_level_select_view_-1386081091", UIComponentType.RectTransform)
	self._levelCell = {}

	for i = 0, self._rectTrLevelRoot.childCount - 1 do
		local index = i + 1
		local go = self._rectTrLevelRoot:GetChild(i).gameObject
		local cell = self:_buildLevelCell(go, index)

		table.insert(self._levelCell, cell)
	end
end

function M:destroyUI()
	for _, cell in pairs(self._levelCell or {}) do
		cell.destroyUI()
	end
end

function M:bindEvents()
	self._btnGiveUp:AddClickListener(self._onClickGiveUp, self)
end

function M:unbindEvents()
	self._btnGiveUp:RemoveClickListener()
end

function M:onEnter()
	self._canvasGroup.interactable = true

	self:_setEvent(true)

	if AirWorkShopUtil.getInRodeoCalculateTime(nil, true) then
		self:_backSelf(false, "竞技模式-结算时间，强制退出")

		return
	end

	if AirWorkShopUtil.getCanRodeoSettle() then
		FloatWordMgr.instance:show(lang("tip_air_rodeo_in_calculate"))
		self:_backSelf(false, "竞技模式-可结算未结算，强制退出")

		return
	end

	local settle = AirWorkShopChallengeModel.instance:getRodeoSettle()
	local info = AirWorkShopChallengeModel.instance:getPlayerInfoMo()
	local mapLst = info:getMapLst()
	local mapCount = #mapLst

	if Astral.OSDef.isEditor then
		TableUtil.dump(info)
		printWarn(info:getStatusMsg())
		printWarn(string.format("工坊竞技-被打开[%s] settle[%s] mapCount[%s]", self._viewPresentor:getIsBackOpen(), settle, mapCount))
	end

	if self._viewPresentor:getIsBackOpen() and settle and mapCount == 0 then
		self:_backSelf(true, "竞技模式-5胜完成")

		return
	end

	self:_refreshInfo()
	self:refreshLevelItem()

	local defaultSelectIndex

	if mapCount == 0 then
		AirWorkShopAtkAgent.instance:sendRodeoMatchRequest()
	elseif mapCount == 1 then
		defaultSelectIndex = 1
	end

	self:setSelectIndex(defaultSelectIndex)
end

function M:onExit()
	self._canvasGroup.interactable = false

	self:_setEvent(false)

	self._selectIndex = nil
end

function M:_backSelf(isQuick, reasonStr)
	self._canvasGroup.interactable = false

	if Astral.OSDef.isEditor and not string.nilorempty(reasonStr) then
		printWarn(reasonStr)
	end

	if isQuick then
		ViewMgr.instance:close(ViewName.AirWorkShopRodeoLevelSelectView, true, WindowType.WindowCloseReasonType.QuickCloseType, false)
	else
		self:back()
	end
end

function M:_setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(AirWorkShopEventType.ON_RODEO_INFO_CHANGE, self._handleOnRodeoInfoChange, self)
		GlobalDispatcher:addEventListener(AirWorkShopEventType.ON_RODEO_GIVE_UP_REPLY, self._handleOnRodeoGiveUp, self)
		GlobalDispatcher:addEventListener(AirWorkShopEventType.ON_RODEO_MATCH_REPLY, self._handleOnRodeoMatch, self)
		GlobalDispatcher:addEventListener(AirWorkShopEventType.ON_SCENE_IMAGE_DOWNLOADED, self._onSceneImageUpdate, self)
	else
		GlobalDispatcher:removeEventListener(AirWorkShopEventType.ON_RODEO_INFO_CHANGE, self._handleOnRodeoInfoChange, self)
		GlobalDispatcher:removeEventListener(AirWorkShopEventType.ON_RODEO_GIVE_UP_REPLY, self._handleOnRodeoGiveUp, self)
		GlobalDispatcher:removeEventListener(AirWorkShopEventType.ON_RODEO_MATCH_REPLY, self._handleOnRodeoMatch, self)
		GlobalDispatcher:removeEventListener(AirWorkShopEventType.ON_SCENE_IMAGE_DOWNLOADED, self._onSceneImageUpdate, self)
	end
end

function M:_handleOnRodeoInfoChange(e)
	self:_refreshInfo()
	self:refreshLevelItem()
end

function M:_handleOnRodeoGiveUp(e)
	self:back()
end

function M:_handleOnRodeoMatch(e, status, lstLevelNO)
	if status ~= 0 then
		self:_backSelf(true, string.format("竞技模式-匹配出错,status=%s", status))

		return
	end

	AirWorkShopAtkAgent.instance:sendRodeoInfoRequest()
	self:refreshLevelItem()
end

function M:_onClickGiveUp()
	if AirWorkShopUtil.getInRodeoCalculateTime(nil, true) then
		self:_backSelf(false, "竞技模式-结算时间，放弃无效")

		return
	end

	if AirWorkShopUtil.getCanRodeoSettle() then
		FloatWordMgr.instance:show(lang("tip_air_rodeo_in_calculate"))
		self:_backSelf(false, "竞技模式-可结算未结算，放弃无效")

		return
	end

	AirWorkShopUtil.GiveUpChallengeMode()
end

function M:_refreshInfo()
	local info = AirWorkShopChallengeModel.instance:getPlayerInfoMo()
	local curRound = info:getRound()
	local winRound = curRound - 1
	local life = info:getLife()

	self._txtScore.text = info:getScore()
	self._txtRoundProgress.text = string.format("%s/%s", winRound, AirWorkShopEnum.RodeoMaxRound)

	for index, go in ipairs(self._goProgressLst) do
		goutil.setActive(go, index <= winRound)
	end

	for index, go in ipairs(self._goHeartLst) do
		goutil.setActive(go, index <= life)
	end
end

function M:refreshLevelItem()
	local info = AirWorkShopChallengeModel.instance:getPlayerInfoMo()
	local mapLst = info:getMapLst()
	local mapCount = #mapLst

	for index, cell in ipairs(self._levelCell) do
		cell.updateData()
	end
end

function M:getSelectIndex()
	return self._selectIndex
end

function M:setSelectIndex(index)
	self._selectIndex = index

	for _, cell in ipairs(self._levelCell or {}) do
		cell.updateSelect()
	end
end

function M:_onCellClick(index)
	local info = AirWorkShopChallengeModel.instance:getPlayerInfoMo()
	local mapLst = info:getMapLst()
	local _leveNO = mapLst[index]

	if not _leveNO then
		return
	end

	self:setSelectIndex(index)

	if Astral.OSDef.isEditor then
		printWarn(string.format("选择了关卡[%s][%s]", index, _leveNO.mapId))
	end
end

function M:_onCellClickStatistics(index)
	local info = AirWorkShopChallengeModel.instance:getPlayerInfoMo()
	local mapLst = info:getMapLst()
	local _leveNO = mapLst[index]

	if not _leveNO then
		return
	end

	local params = {}

	params.mapId = _leveNO.mapId
	params.showTabCount = 1

	ViewMgr.instance:open(ViewName.AirWorkShopStatisticView, params)
end

function M:_onCellClickCheck(index)
	if AirWorkShopUtil.getInRodeoCalculateTime(nil, true) then
		self:_backSelf(false, "竞技模式-结算时间，调查无效")

		return
	end

	if AirWorkShopUtil.getCanRodeoSettle() then
		FloatWordMgr.instance:show(lang("tip_air_rodeo_in_calculate"))
		self:_backSelf(false, "竞技模式-可结算未结算，调查无效")

		return
	end

	local info = AirWorkShopChallengeModel.instance:getPlayerInfoMo()
	local mapLst = info:getMapLst() or {}
	local mapCount = #mapLst

	if mapCount == 0 then
		return
	end

	local hard = mapCount == 1 and 0 or index

	if hard == 0 then
		if info:getLife() <= 0 then
			local dialog = Dialog.showNotifyMessage(lang("tip_title"), lang("tip_air_rodeo_nolife_to_reborn"))

			dialog:setConfirmButtonText(lang("tip_common_sure"))
			dialog:setConfirmListener(function()
				AirWorkShopAtkAgent.instance:sendRodeoGiveUpRequest()
			end, self)
		else
			local dialog = Dialog.showMessage(lang("tip_title"), lang("tip_air_revive_rodeo"))

			dialog:setConfirmListener(function()
				if info:getLife() <= 0 then
					ToolTipsMgr.showCharacterTopToast(lang("tip_air_rodeo_life_not_enough"), CommEnum.CharacterTopToastIcon.Fail, 1)
				else
					AirWorkShopAtkAgent.instance:sendRodeoStartRequest(hard)
				end
			end, self)
		end
	else
		AirWorkShopAtkAgent.instance:sendRodeoStartRequest(hard)
	end
end

function M:_buildLevelCell(go, index)
	local cell = {}

	cell.go = go
	cell.index = index
	cell.goDiNormal = goutil.findChild(go, "imgDi").gameObject
	cell.goDiSelected = goutil.findChild(go, "imgDi2").gameObject
	cell.goSelected = goutil.findChild(go, "objSelect").gameObject
	cell.rectTrContent = goutil.findChildComponent(go, "content", UIComponentType.RectTransform)
	cell.imgLevel = goutil.findChildImageComponent(go, "content/imgLevel")
	cell.txtScore = goutil.findChildTextComponent(go, "content/txtScore")
	cell.txtPassRatio = goutil.findChildTextComponent(go, "content/txtPass")
	cell.btnClick = UIComponentType.ButtonAdapter(goutil.findChild(go, "click").gameObject)
	cell.btnStatistics = UIComponentType.ButtonAdapter(goutil.findChild(go, "content/btnStatistics").gameObject)
	cell.btnCheck = UIComponentType.ButtonAdapter(goutil.findChild(go, "objSelect/btnCheck").gameObject)
	cell.btnReviveCheck = UIComponentType.ButtonAdapter(goutil.findChild(go, "objSelect/btnReviveCheck").gameObject)

	cell.btnClick:AddClickListener(function()
		self:_onCellClick(cell.getIndex())
	end, self)
	cell.btnReviveCheck:AddClickListener(function()
		self:_onCellClickCheck(cell.getIndex())
	end, self)
	cell.btnStatistics:AddClickListener(function()
		self:_onCellClickStatistics(cell.getIndex())
	end, self)
	cell.btnCheck:AddClickListener(function()
		self:_onCellClickCheck(cell.getIndex())
	end, self)

	function cell.destroyUI()
		cell.btnClick:RemoveClickListener()
		cell.btnStatistics:RemoveClickListener()
		cell.btnCheck:RemoveClickListener()
		cell.btnReviveCheck:RemoveClickListener()
	end

	function cell.getIndex()
		return cell.index
	end

	function cell.getCover()
		return cell.cover
	end

	function cell.setActive(active)
		goutil.setActive(cell.go, active)
	end

	function cell.updateData()
		local info = AirWorkShopChallengeModel.instance:getPlayerInfoMo()
		local mapLst = info:getMapLst()
		local _leveNO = mapLst[cell.getIndex()]

		if _leveNO then
			cell.cover = _leveNO.cover

			cell.updateImage()

			cell.txtScore.text = string.format("%s%s", _leveNO.point, AirWorkShopEnum.RodeoScoreSuffix)
			cell.txtPassRatio.text = string.format("%s%%", AirWorkShopUtil.formatPassRatio(_leveNO.passRate * 100, 1))

			goutil.setActive(cell.btnCheck.gameObject, #mapLst ~= 1)
			goutil.setActive(cell.btnReviveCheck.gameObject, #mapLst == 1)
		end

		cell.setActive(_leveNO)
	end

	function cell.updateSelect()
		local isSelected = cell.getIndex() == self:getSelectIndex()

		goutil.setActive(cell.goDiNormal, not isSelected)
		goutil.setActive(cell.goDiSelected, isSelected)
		goutil.setActive(cell.goSelected, isSelected)

		local y = isSelected and 40 or 0

		RectTransformUtils.SetAnchoredPosition(cell.rectTrContent, 0, y)
	end

	function cell.updateImage()
		AirWorkShopUtil.loadSceneImage(cell.imgLevel, cell.cover, true)
	end

	RectTransformUtils.SetAnchoredPosition(cell.rectTrContent, 0, 0)

	return cell
end

function M:_onSceneImageUpdate(_, cover)
	if self._levelCell then
		for k, v in pairs(self._levelCell) do
			if v.getCover() == cover then
				v.updateImage()
			end
		end
	end
end

return M
