-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/climbingtower/view/ClimbingTowerExplainTipsView.lua

module("logic.extensions.climbingtower.view.ClimbingTowerExplainTipsView", package.seeall)

local M = class("ClimbingTowerExplainTipsView", ViewComponent)

function M:ctor()
	M.super.ctor(self)
end

function M:buildUI()
	self._guiAnimation = goutil.addComponentOnce(self.mainGO, typeof(Astral.GUITimelineAniLua))
	self._btnClose = self:getBtn("1&middle_tips_common_bg_-1205189576")

	local baseTitle = self:getText("climbing_tower_explan_tips_-1546766761")

	baseTitle.text = ClimbingTowerConfig.instance:getConst("RuleDescBGTitle").strValue

	local baseDesc = self:getText("climbing_tower_explan_tips_-274220622")

	baseDesc.text = ClimbingTowerConfig.instance:getConst("RuleDescBGIntroduction").strValue

	local playTitle = self:getText("climbing_tower_explan_tips_1611713660")

	playTitle.text = ClimbingTowerConfig.instance:getConst("RuleDescPlayTitle").strValue

	local playDesc = self:getText("climbing_tower_explan_tips_996119252")

	playDesc.text = ClimbingTowerConfig.instance:getConst("RuleDescPlay").strValue

	local brightSideTitle = self:getText("climbing_tower_explan_tips_1259213643")

	brightSideTitle.text = ClimbingTowerConfig.instance:getConst("RuleDescBrightSideTitle").strValue

	local brightSideDesc = self:getText("climbing_tower_explan_tips_1150828159")

	brightSideDesc.text = ClimbingTowerConfig.instance:getConst("RuleDescBrightSide").strValue

	local darkSideTitle = self:getText("climbing_tower_explan_tips_1374157552")

	darkSideTitle.text = ClimbingTowerConfig.instance:getConst("RuleDescDarkSideTitle").strValue

	local darkSideDesc = self:getText("climbing_tower_explan_tips_1602884405")

	darkSideDesc.text = ClimbingTowerConfig.instance:getConst("RuleDescDarkSide").strValue

	local goScroll = self:getGo("climbing_tower_explan_tips_-1322306672")

	self._loopList = LoopListHelper.New(goScroll)

	self._loopList:InitListView(0, self._onCellUpdate, self)
end

function M:destroyUI()
	self._guiAnimation = nil
	self._btnClose = nil

	self._loopList:Dispose()

	self._loopList = nil
	self._cacheScrollItem = nil
end

function M:bindEvents()
	self._btnClose:AddClickListener(self._onClickClose, self)
	GlobalDispatcher:addEventListener(EventType.ON_BLUR_BG_CAPTURE_FINISH, self._handleBlurBgCaptureFinish, self)
end

function M:unbindEvents()
	self._btnClose:RemoveClickListener()
	GlobalDispatcher:removeEventListener(EventType.ON_BLUR_BG_CAPTURE_FINISH, self._handleBlurBgCaptureFinish, self)
end

function M:onEnter()
	self:refreshRightPanel()
	self._guiAnimation:StopTimelineAni()
end

function M:onExit()
	self._descItemDataLst = nil

	self._loopList:ClearCells()

	self._cacheScrollItem = nil

	self._guiAnimation:StopTimelineAni()
	self._guiAnimation:PlayAniByName("close")
end

function M:_handleBlurBgCaptureFinish(e, viewName)
	self._guiAnimation:StopTimelineAni()
	self._guiAnimation:PlayAniByName("open")
end

function M:_onClickClose()
	self:close()
end

function M:refreshRightPanel()
	local effListModel = ClimbingTowerModel.instance:getTowerEffListModel()
	local moLst = effListModel:getMoList()

	if moLst and #moLst > 0 then
		self._descItemDataLst = moLst
	else
		self._descItemDataLst = {}
	end

	self._loopList:SetListItemCount(#self._descItemDataLst, true)
	self._loopList:RefreshAllShownItem()
end

function M:_onCellUpdate(curIndex)
	local data = self._descItemDataLst[curIndex + 1]
	local itemPrefabName = "desc_item"
	local isSkill = data.isSkill

	if isSkill then
		itemPrefabName = data.skillTyp == 1 and "buff_item" or "buff_item (1)"
	end

	local item = self._loopList:NewListViewItem(itemPrefabName)

	if isSkill then
		self:_fillUpSkillItemShow(item, data)
	else
		self:_fillUpBaseDescItemShow(item, data)
	end

	settimer(0, function()
		if self._cacheScrollItem and item then
			local instanceId = item:GetInstanceID()
			local height = RectTransformUtils.GetHeight(self._cacheScrollItem[instanceId].contentRect)

			if height > 0 then
				RectTransformUtils.SetHeight(self._cacheScrollItem[instanceId].rootRect, height)
				self._loopList:GetLoopListView():OnItemSizeChanged(curIndex)
			end
		end
	end, self, false)

	return item
end

function M:_fillUpSkillItemShow(gobj, data)
	if not self._cacheScrollItem then
		self._cacheScrollItem = {}
	end

	local instanceId = gobj:GetInstanceID()
	local comps = self._cacheScrollItem[instanceId]

	if not comps then
		comps = {
			rootRect = goutil.findChildComponent(gobj, "", UIComponentType.RectTransform),
			contentRect = goutil.findChildComponent(gobj, "content", UIComponentType.RectTransform),
			txtTitle = goutil.findChildComponent(gobj, "content/txtBuffName", UIComponentType.Text),
			txtContent = goutil.findChildComponent(gobj, "content/txtDesc", UIComponentType.Text)
		}
		self._cacheScrollItem[instanceId] = comps
	end

	local txtTitle = comps.txtTitle
	local txtContent = comps.txtContent

	txtTitle.text = data.name
	txtContent.text = data.desc
end

function M:_fillUpBaseDescItemShow(gobj, data)
	if not self._cacheScrollItem then
		self._cacheScrollItem = {}
	end

	local instanceId = gobj:GetInstanceID()
	local comps = self._cacheScrollItem[instanceId]

	if not comps then
		comps = {
			rootRect = goutil.findChildComponent(gobj, "", UIComponentType.RectTransform),
			contentRect = goutil.findChildComponent(gobj, "content", UIComponentType.RectTransform),
			txtTitle = goutil.findChildComponent(gobj, "content/txtSmallTitle", UIComponentType.Text),
			txtContent = goutil.findChildComponent(gobj, "content/txtDesc", UIComponentType.Text)
		}
		self._cacheScrollItem[instanceId] = comps
	end

	local txtTitle = comps.txtTitle
	local txtContent = comps.txtContent

	txtTitle.text = data.name
	txtContent.text = data.desc
end

return M
