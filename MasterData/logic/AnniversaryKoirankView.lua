-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/anniversarykoi/view/AnniversaryKoirankView.lua

module("logic.extensions.anniversarykoi.view.AnniversaryKoirankView", package.seeall)

local AnniversaryKoirankView = class("AnniversaryKoirankView", ViewComponent)
local tabRootName = {
	{
		index = 1,
		name = "天选锦鲤",
		childIndex = {
			1,
			2
		}
	},
	{
		index = 2,
		name = "免单锦鲤",
		childIndex = {
			3,
			4
		}
	},
	{
		index = 3,
		name = "肝帝锦鲤",
		childIndex = {
			5,
			6
		}
	}
}
local tabLeafName = {
	{
		index = 1,
		name = "天选之人"
	},
	{
		index = 2,
		name = "幸运锦鲤"
	},
	{
		index = 3,
		name = "天选之人"
	},
	{
		index = 4,
		name = "幸运锦鲤"
	},
	{
		index = 5,
		name = "天选之人"
	},
	{
		index = 6,
		name = "幸运锦鲤"
	}
}

function AnniversaryKoirankView:ctor()
	AnniversaryKoirankView.super.ctor(self)
end

function AnniversaryKoirankView:unbindEvents()
	AnniversaryKoirankView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function AnniversaryKoirankView:bindEvents()
	AnniversaryKoirankView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._OnClickClose, self)
end

function AnniversaryKoirankView:buildUI()
	AnniversaryKoirankView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._tabViweGo = self:getGo("tabView")
	self._tabCell = self:getGo("tabCell")
	self._tabView = ScrollerList.create(self._tabViweGo, self._tabCell, GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self._clearTabCell, self))

	self._tabView:regGetCellSize(function(view, index)
		return self:_pageCellSize(view, index)
	end)

	self._dropLineRectTrans = self:getGo("tabView/viewport/content/dropLine"):GetComponent(goutil.Type_RectTransform)

	self:_initScrollBgParam()

	self._tableviewGo = self:getGo("right/tableview")
	self._cell = self:getGo("right/cell")
	self._empty = self:getGo("right/empty")
	self._tableView = ScrollerList.create(self._tableviewGo, self._cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function AnniversaryKoirankView:onExit()
	AnniversaryKoirankView.super.onExit(self)
	self._tabView:dispose()
	self._tableView:dispose()
	GlobalDispatcher:removeListener(GlobalNotify.AnniversaryKoiRankViewRes, self._refreshUI, self)
end

function AnniversaryKoirankView:onEnter()
	AnniversaryKoirankView.super.onEnter(self)

	self._activityId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.AnniversaryKoi)

	local params = self:getOpenParam()
	local index = 1
	local rankIndex = AnniversaryKoiModel.instance:getRankId()

	if AnniversaryKoiModel.instance:getRankId() > 0 then
		index = rankIndex
		self._prizeType = Mathf.Clamp((rankIndex - 1) % 2 + 1, 1, 2)
	else
		index = checknumber(params[1])
		self._prizeType = 1
	end

	self._curPoolId = math.floor((index + 1) / 2)

	AnniversaryKoiModel.instance:setRankId(index)
	self:_onClickTab(self._curPoolId, self._prizeType, true)
	self:_initTabList(index)
	self:_updateTabList(self:_getClickIndexByChildIndex(index))
	GlobalDispatcher:addListener(GlobalNotify.AnniversaryKoiRankViewRes, self._refreshUI, self)
end

function AnniversaryKoirankView:_refreshUI()
	local data = AnniversaryKoiModel.instance:getRankList(self._curPoolId, self._prizeType) or {}

	GameUtil.SetActive(self._tableviewGo, #data > 0)
	GameUtil.SetActive(self._empty, #data <= 0)

	if #data <= 0 then
		return
	end

	table.sort(data, function(a, b)
		return checknumber(b.timeStamp) < checknumber(a.timeStamp)
	end)
	self._tableView:reloadData(data)
end

function AnniversaryKoirankView:_pageCellSize(view, index)
	if self._tabView:getData()[index + 1].isParentTag then
		return 192, 70
	else
		return 160, 48
	end
end

function AnniversaryKoirankView:_initTabList(selectChildIndex)
	self._curSelectClickIndex = 1

	local list = {}
	local index = 1
	local ParentPageInfo = tabRootName

	for i, v in ipairs(ParentPageInfo) do
		local parentElement = {}

		parentElement.index = index
		parentElement.parentIndex = v.index
		parentElement.name = v.name
		parentElement.cfg = v
		parentElement.isParentTag = true
		parentElement.isUnfold = false
		parentElement.childIndexList = {}

		table.insert(list, parentElement)

		index = index + 1

		for j, childIndex in ipairs(v.childIndex) do
			if selectChildIndex == childIndex then
				parentElement.isUnfold = true
				self._curSelectClickIndex = index
			end

			local isAddChild = true
			local petCgs
			local childCfg = tabLeafName[childIndex]

			if isAddChild then
				local info = childCfg
				local childElement = {}

				childElement.index = index
				childElement.parentIndex = parentElement.index
				childElement.name = info.name
				childElement.cfg = info
				childElement.isParentTag = false
				childElement.isSelect = selectChildIndex == childIndex
				childElement.redPointIds = redPointIds

				table.insert(list, childElement)
				table.insert(parentElement.childIndexList, index)

				index = index + 1
			end
		end

		parentElement.isSingleChild = #parentElement.childIndexList == 1
	end

	self._saveList = list
end

function AnniversaryKoirankView:_getClickIndexByChildIndex(childIndex)
	local index = 1

	for i, v in ipairs(self._saveList) do
		if v.isParentTag then
			if v.isSingleChild and self._saveList[v.childIndexList[1]].cfg.index == childIndex then
				index = v.index

				break
			end
		elseif v.cfg.index == childIndex then
			index = v.index

			break
		end
	end

	return index
end

function AnniversaryKoirankView:_updateTabList(clickIndex)
	self._curSelectClickIndex = clickIndex
	self._filterList = self._filterList or {}

	table.clear(self._filterList)

	local isClickParent = self._saveList[clickIndex].isParentTag
	local selectParentIndex = 1
	local isSelectParentUnfold = false

	if isClickParent then
		selectParentIndex = clickIndex
		isSelectParentUnfold = self._saveList[clickIndex].isUnfold

		for i, v in ipairs(self._saveList) do
			if v.isParentTag then
				if clickIndex == v.index then
					v.isUnfold = v.isSingleChild and true or not v.isUnfold
					isSelectParentUnfold = v.isUnfold
				else
					v.isUnfold = false
				end

				table.insert(self._filterList, v)
			else
				local parentElement = self._saveList[v.parentIndex]

				if parentElement.isUnfold then
					if parentElement.isSingleChild then
						v.isSelect = true
					else
						v.isSelect = v.index == parentElement.childIndexList[1]

						table.insert(self._filterList, v)
					end
				else
					v.isSelect = false
				end
			end
		end
	else
		for i, v in ipairs(self._saveList) do
			if v.isParentTag then
				table.insert(self._filterList, v)
			else
				v.isSelect = clickIndex == v.index

				if self._saveList[v.parentIndex].isUnfold then
					table.insert(self._filterList, v)
				end

				if v.isSelect then
					selectParentIndex = v.parentIndex
					isSelectParentUnfold = self._saveList[v.parentIndex].isUnfold
				end
			end
		end
	end

	self._tabView:reloadData(self._filterList)
	self:_updateScrollBg(self:_getSelectedIndex(selectParentIndex), isSelectParentUnfold, self:_getChildCellCount(selectParentIndex))
end

function AnniversaryKoirankView:_getSelectedIndex(parentIndex)
	local index = 1

	for i, v in ipairs(self._filterList) do
		if v.isParentTag and v.index == parentIndex then
			index = i

			break
		end
	end

	return index
end

function AnniversaryKoirankView:_getChildCellCount(parentIndex)
	local parentElement = self._saveList[parentIndex]

	if parentElement.isUnfold then
		return #parentElement.childIndexList
	else
		return 0
	end
end

function AnniversaryKoirankView:_initScrollBgParam()
	local tableview = self._tabView:getView()

	self._cellSpaceingY = tableview.cellSpacing.y
	self._cellOffsetY = tableview.cellOffset.y
	self._cellHeight = 70
end

function AnniversaryKoirankView:_updateScrollBg(index, isUnfold, childCellCount)
	local posY = 0 - (self._cellOffsetY + (index - 1) * (self._cellHeight + self._cellSpaceingY))

	posY = posY - 30

	local height = 0

	if isUnfold then
		local count = childCellCount

		if count > 1 then
			height = count * (self._cellHeight + self._cellSpaceingY) + self._cellHeight * 0.5
		end
	end

	local x, y = Framework.TransformUtil.GetAnchoredPos(self._dropLineRectTrans, 0, 0)

	Framework.TransformUtil.SetAnchoredPos(self._dropLineRectTrans, x, posY)
	goutil.setHeight(self._dropLineRectTrans, height)
end

function AnniversaryKoirankView:_updateTabCell(view, cell, data)
	local rootBgChange = goutil.findChild(cell, "imgBg"):GetComponent(typeof(UIImageSpriteChange))
	local leafBgChange = goutil.findChild(cell, "imgSmallBg"):GetComponent(typeof(UIImageSpriteChange))
	local txtNameChange = goutil.findChild(cell, "txtName"):GetComponent(ComponentType.UITextColorChange)
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local btn = Framework.ButtonAdapter.GetFrom(cell.gameObject, "click")

	btn:AddClickListener(function()
		if not data.isParentTag then
			if self._curSelectClickIndex ~= data.index then
				self:_updateTabList(data.index)
				self:_onClickTab(math.ceil(data.parentIndex / 3), (data.cfg.index - 1) % 2 + 1, false)
			end
		else
			if not data.isUnfold and data.childIndexList[1] then
				local childFirstIndex = self._saveList[data.childIndexList[1]].cfg.index

				self:_onClickTab(data.parentIndex, (childFirstIndex - 1) % 2 + 1, true)
			end

			if not data.isSingleChild or self._curSelectClickIndex ~= data.index then
				self:_updateTabList(data.index)
			end
		end
	end)
	rootBgChange:SetState(data.isParentTag and (data.isUnfold and 1 or 0) or 2)
	leafBgChange:SetState(data.isParentTag and 2 or data.isSelect and 1 or 0)

	txtName.text = data.name

	txtNameChange:SetState(data.isParentTag and (data.isUnfold and 1 or 0) or data.isSelect and 3 or 2)
end

function AnniversaryKoirankView:_clearTabCell(cell)
	local btn = Framework.ButtonAdapter.GetFrom(cell.gameObject, "click")

	btn:RemoveClickListener()
end

function AnniversaryKoirankView:_updateCell(view, cell, data)
	local head = goutil.findChild(cell, "head")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local txtArea = goutil.findChildTextComponent(cell, "txtArea")
	local txtTime = goutil.findChildTextComponent(cell, "txtTime")
	local proxy = HeadItemController.instance:setHeadCellByInfo(head, data.headInfo)

	if proxy then
		proxy:setCallBack(function()
			FriendController.instance:showInfoView(data.headInfo.userId, head)
		end)
	end

	txtName.text = data.headInfo.userName
	txtArea.text = data.headInfo.areaName

	local time = GameUtil.time2date(data.timeStamp / 1000)

	txtTime.text = string.format("%04d年%02d月%02d日 %02d:%02d:%02d", time.year, time.month, time.day, time.hour, time.min, time.sec)
end

function AnniversaryKoirankView:_clearCell(cell)
	local head = goutil.findChild(cell, "head")

	HeadItemController:resetHeadCell(head)
end

function AnniversaryKoirankView:_onClickTab(poolId, prizeType)
	self._curPoolId = poolId
	self._prizeType = prizeType

	local index = math.abs(poolId + prizeType + (poolId + 1 - 3))

	AnniversaryKoiModel.instance:setRankId(index)
	AnniversaryKoiController.instance:sendPM_AnniversaryKoiRankViewReq(self._activityId, self._curPoolId, self._prizeType)
end

function AnniversaryKoirankView:_OnClickClose()
	AnniversaryKoiModel.instance:setRankId(0, 0)
	self:close()
end

return AnniversaryKoirankView
