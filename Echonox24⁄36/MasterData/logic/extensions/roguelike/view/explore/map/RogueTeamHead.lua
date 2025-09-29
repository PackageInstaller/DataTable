-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/explore/map/RogueTeamHead.lua

module("logic.extensions.roguelike.view.explore.map.RogueTeamHead", package.seeall)

local M = class("RogueTeamHead")

function M:ctor(container)
	self:setEvent(true)

	local go = container.gameObject

	self._go = go
	self._tempSort = {
		1,
		2,
		3,
		4
	}
	self._onItemClickCallback = nil
	self._goNormal = goutil.findChild(go, "normal")
	self._goSelect = goutil.findChild(go, "select")

	local goBtnChange = goutil.findChild(go, "normal/btnChange")
	local goBtnConfirm = goutil.findChild(go, "select/btnConfirm")

	self._goTextDesc = goutil.findChild(go, "Text1")
	self._canChange = not goutil.isNil(goBtnChange)
	self._animation = go:GetComponent(ComponentType.Animation)

	if self._canChange then
		self._btnChange = UIComponentType.ButtonAdapter(goBtnChange)

		self._btnChange:AddClickListener(self._onClickChange, self)

		self._btnConfirm = UIComponentType.ButtonAdapter(goBtnConfirm)

		self._btnConfirm:AddClickListener(self._onClickConfirm, self)
	end

	self:initHeroItem()
	self:initGoState()
end

function M:initGoState()
	local isInGuideScript = RoguelikeUtil.instance:getIsGuideScript()

	if isInGuideScript then
		goutil.setActive(self._goTextDesc, false)

		if self._btnChange then
			goutil.setActive(self._btnChange.gameObject, false)
		end
	end
end

function M:initHeroItem()
	self._heroItems = {}

	for i = 1, 4 do
		local itemGo = goutil.findChild(self._go, "headList/hero_head" .. i)
		local item = Astral.LuaComponentContainer.Add(itemGo, RogueRoleHeadItem2)

		item:setSelect(false)
		table.insert(self._heroItems, item)
	end

	self:updateData()
	self:showConfirmState(false)
end

function M:setClickCallback(callback)
	self._onItemClickCallback = callback
end

function M:_onClickConfirm()
	self._animation:Play("run_group_main_view_copy_headgroup_open")

	local isChange = false

	for i = 1, 4 do
		if self._tempSort[i] ~= i then
			isChange = true
		end
	end

	if not isChange then
		self:showConfirmState(false)

		return
	end

	local allRoles = RogueMgr.instance:getModel():getAllRoleMos()
	local roleIds = {}

	for i = 1, #allRoles do
		local prop = allRoles[self._tempSort[i]].roleProp

		table.insert(roleIds, prop:getRoleId())
	end

	RogueExploreAgent.instance:sendSortRequest(roleIds)
end

function M:_onClickChange()
	self:showConfirmState(true)
end

function M:showConfirmState(isActive)
	goutil.setActive(self._goNormal, not isActive)
	goutil.setActive(self._goSelect, isActive)
	goutil.setActive(self._goTextDesc, isActive)

	self._isConfirmState = isActive
end

function M:updateData()
	if not RogueMgr.instance:isInRogue() then
		return
	end

	local allRoles = RogueMgr.instance:getModel():getAllRoleMos()

	self._isInLongPress = false

	local captainIndex = RogueMgr.instance:getModel():getCaptainIndex()
	local isInGuideScript = RoguelikeUtil.instance:getIsGuideScript()

	for i = 1, #allRoles do
		local item = self._heroItems[i]
		local index = self._tempSort[i]
		local prop = allRoles[index].roleProp
		local isDeath = prop:getIsDeath()
		local data = {}

		data.roleId = prop:getRoleId()
		data.index = index
		data.captainIndex = captainIndex
		data.card = prop:getCard()

		function data.callback()
			self:onItemClick(index)
		end

		if self._canChange and not isInGuideScript then
			function data.longPressCallback()
				if not self._isConfirmState then
					return
				end

				self:initDragItem(data, item)

				self._isInLongPress = true
				self._dragIndex = i
			end

			function data.longPressExitCallback(isExit)
				if not self._isConfirmState then
					return
				end

				if isExit and not self._isInDrag then
					-- block empty
				end
			end

			function data.beginDragCallback(eventData)
				if not self._isConfirmState then
					return
				end

				self._originPos = item:getPosition()
				self._orginDragEventPosition = eventData.position

				local x, y = RectTransformUtils.ScreenPointToLocalPointInRectangle(item:getGo().transform, eventData.position.x, eventData.position.y, eventData.pressEventCamera, 0, 0)

				self._originDragPos = Vector2.New(x, y)
				self._isInDrag = true
			end

			function data.endDragCallback(eventData)
				if not self._isConfirmState then
					return
				end

				self._isInDrag = false

				if self._dragItem then
					self._dragItem:setActive(false)
				end

				if self._isInLongPress and self._onItemClickCallback and self._dragItem then
					self:onItemDragEnd()
				end

				self._isInLongPress = false
			end

			function data.dragCallback(eventData)
				if not self._isConfirmState then
					return
				end

				if self._isInLongPress and self._onItemClickCallback and self._dragItem then
					RectTransformUtils.ScreenPointToWorldPointInRectangle(self._dragItem:getGo().transform, eventData.pressEventCamera, eventData.position - self._originDragPos)
				end
			end
		end

		item:updateData(data)
	end
end

function M:_onRoleInfoUpdate()
	self._tempSort = {
		1,
		2,
		3,
		4
	}

	self:updateData()
	self:showConfirmState(false)
end

function M:onItemDragEnd()
	local itemPos = self._dragItem:getPosition()
	local maxOffset = 100000
	local matchIndex = 0

	for i = 1, 4 do
		local item = self._heroItems[i]
		local targetPos = item:getPosition()
		local offsetX = math.abs(targetPos.x - itemPos.x)

		if offsetX < maxOffset then
			matchIndex = i
		end

		maxOffset = math.min(offsetX, maxOffset)
	end

	if matchIndex ~= 0 then
		local temp = self._tempSort[self._dragIndex]

		self._tempSort[self._dragIndex] = self._tempSort[matchIndex]
		self._tempSort[matchIndex] = temp

		self:updateData()
	end
end

function M:initDragItem(data, item)
	if not self._dragItem then
		local prefab = goutil.findChild(self._go, "headList/hero_head1")
		local itemGo = goutil.cloneAndSetParent(prefab, self._go.transform)

		self._dragItem = Astral.LuaComponentContainer.Add(itemGo, RogueRoleHeadItem2)
	end

	local tempData = {}

	tempData.roleId = data.roleId
	tempData.index = data.index
	tempData.card = data.card

	self._dragItem:updateData(tempData)

	self._dragItem:getGo().transform.position = item:getGo().transform.position
end

function M:onItemClick(index)
	for k, v in pairs(self._heroItems) do
		v:setSelect(self._tempSort[k] == index)
	end

	if self._onItemClickCallback then
		self._onItemClickCallback(index)
	end
end

function M:reset()
	for k, v in pairs(self._heroItems or {}) do
		v:setSelect(false)
	end
end

function M:setEvent(isAdd)
	if isAdd then
		GlobalDispatcher:addEventListener(EventType.ROGUE_EXPLORE_INFO, self._onRoleInfoUpdate, self)
	else
		GlobalDispatcher:removeEventListener(EventType.ROGUE_EXPLORE_INFO, self._onRoleInfoUpdate, self)
	end
end

function M:OnDestroy()
	self._onItemClickCallback = nil

	self:setEvent(false)

	if self._btnChange then
		self._btnChange:RemoveClickListener()

		self._btnChange = nil
	end

	if self._btnConfirm then
		self._btnConfirm:RemoveClickListener()

		self._btnConfirm = nil
	end

	for k, v in pairs(self._heroItems or {}) do
		v:OnDestroy()
	end

	self._heroItems = nil

	if self._dragItem then
		self._dragItem:OnDestroy()
	end

	self._dragItem = nil
	self._isConfirmState = nil
end

return M
