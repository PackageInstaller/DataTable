-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/equip/component/EquipHoleComponent.lua

module("logic.extensions.charactersystem.view.equip.component.EquipHoleComponent", package.seeall)

local M = class("EquipHoleComponent")

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._mainGo = self._compContainer.gameObject
	self._registry = ViewElementsRegistry.New(self._mainGo)

	self:_buildUI()

	self._view2holesIndex = {}
end

function M:_buildUI()
	self._holeAttrViewList = {}
	self._txtDescList = {}
	self._equipHoleItemViewList = {}
	self._holeAni = {}
	self._qipaoAni = {}

	for index = 1, EquipEnum.MaxDiceCount do
		local equipHoleItemGo = goutil.findChild(self._mainGo, "equip_hole_item" .. index)
		local itemView = Astral.LuaComponentContainer.Add(equipHoleItemGo, EquipHoleItemView)

		itemView:setNoCalibrationIcon(false)
		table.insert(self._equipHoleItemViewList, itemView)
		itemView:setClickCallback(function()
			self:_onClickHole(index)
		end)

		local ani = equipHoleItemGo:GetComponent(ComponentType.Animation)

		table.insert(self._holeAni, ani)

		local qipaoGo = goutil.findChild(self._mainGo, "qipao_" .. index)
		local attrView = Astral.LuaComponentContainer.Add(qipaoGo, EquipHoleAttrView)

		attrView:setClickCallback(function()
			self:_onClickHole(index)
		end)
		table.insert(self._holeAttrViewList, attrView)

		local ani1 = qipaoGo:GetComponent(ComponentType.Animation)

		table.insert(self._qipaoAni, ani1)
	end

	local imageGo = goutil.findChild(self._mainGo, "imgIcon")

	self._equipModelComponent = Astral.LuaComponentContainer.Add(imageGo, EquipModelComponent)
end

function M:bindEvents()
	return
end

function M:unbindEvents()
	return
end

function M:onEnter()
	self._equipModelComponent:onEnter()
end

function M:onExit()
	self._equipModelComponent:onExit()

	self._equipMo = nil
end

function M:setVisible(visible)
	self._mainGo:SetActive(visible)
end

function M:refreshView()
	self._equipModelComponent:refreshView()
	self:_refreshHoleView()
	self:_refreshBubblesView()
end

function M:refreshHole()
	self:_refreshHoleView()
	self:_refreshBubblesView()
end

function M:_refreshHoleView()
	local curHoleIndex = EquipIntensifyModel.instance:getTimingHoleIndex()
	local hasOriginalD6 = self._equipMo:hasOriginalD6()
	local viewIndex = 0

	table.clear(self._view2holesIndex)

	for index = 1, EquipEnum.MaxDiceCount do
		local status = self._equipMo:getHoleStatus(index)
		local visible = self:getIsHoleVisible(status)

		if not visible then
			-- block empty
		else
			viewIndex = viewIndex + 1

			local itemView = self._equipHoleItemViewList[viewIndex]

			itemView:setVisible(true)
			itemView:setStatus(status)
			itemView:setSelectGoVisible(false)
			itemView:showGuang(false)

			if index == 1 then
				if hasOriginalD6 then
					itemView:setData(self._equipMo:getOriginalD6():getEffectAttr())
				else
					itemView:setData(nil)
				end
			else
				local holeIndex = index - 1
				local isHoldUnlock = self._equipMo:getIsHoleUnlock(holeIndex)

				if isHoldUnlock then
					local fixedD6Mo = self._equipMo:getFixedD6ByHoleIndex(holeIndex)

					if fixedD6Mo then
						itemView:setData(fixedD6Mo:getEffectAttr())
						itemView:showGuang(not EquipIntensifyModel.instance:isEquipMaxTimingTimes(self._equipMo))
					else
						itemView:setData(nil)
						itemView:showGuang(true)
					end
				end

				itemView:setSelectGoVisible(curHoleIndex and curHoleIndex == holeIndex)
			end

			table.insert(self._view2holesIndex, index)
		end
	end

	for index = viewIndex + 1, EquipEnum.MaxDiceCount do
		local itemView = self._equipHoleItemViewList[index]

		itemView:setVisible(false)
	end
end

function M:_refreshBubblesView()
	if self._isBubblesHided then
		return
	end

	local holesNum = #self._view2holesIndex

	for index, holeIndex in pairs(self._view2holesIndex) do
		local itemView = self._holeAttrViewList[index]
		local equipHoleAttrMo = EquipIntensifyModel.instance:genEquipHoleAttrMo(self._equipMo, holeIndex - 1)

		if itemView then
			itemView:setVisible(true)
			itemView:setEquipHoleAttrMo(equipHoleAttrMo)

			local noCalibration = equipHoleAttrMo.status == EquipEnum.HoleStatus.NoCalibration
			local canTming = equipHoleAttrMo.status == EquipEnum.HoleStatus.Unlock and not EquipIntensifyModel.instance:isEquipMaxTimingTimes(self._equipMo)

			itemView:showGuang(noCalibration or canTming)
			itemView:showTimingTisp(canTming)
		end
	end

	for index = holesNum + 1, EquipEnum.MaxDiceCount do
		local itemView = self._holeAttrViewList[index]

		if itemView then
			itemView:setVisible(false)
		end
	end
end

function M:getIsHoleVisible(holeStatus)
	return holeStatus == EquipEnum.HoleStatus.NoCalibration or holeStatus == EquipEnum.HoleStatus.Unlock or holeStatus == EquipEnum.HoleStatus.Lock or holeStatus == EquipEnum.HoleStatus.Unalterable
end

function M:setEquipData(equipMo)
	self._equipMo = equipMo

	self._equipModelComponent:setEquipData(equipMo)
	self:refreshView()
	self:_setHoleItemsPos()
end

function M:OnDestroy()
	self._equipHoleItemViewList = nil
	self._holeAttrViewList = nil

	self._equipModelComponent:OnDestroy()
end

function M:_setHoleItemsPos()
	local holesNum = #self._view2holesIndex

	if holesNum < 1 then
		return
	end

	local posInfo = self:_getHolePosInfo(holesNum)

	if not posInfo then
		printError("无法找到装备词条位置， 当前词条数", holesNum)

		return
	end

	for index = 1, holesNum do
		local itemView = self._equipHoleItemViewList[index]
		local pos = posInfo.holePos[index]

		if itemView and pos then
			itemView:setPos(pos.x, pos.y)
		end

		itemView = self._holeAttrViewList[index]
		pos = posInfo.qipaoPos[index]

		if itemView and pos then
			itemView:setPos(pos.x, pos.y)
		end
	end
end

function M:hideBubbles()
	self._isBubblesHided = true

	for index = 1, EquipEnum.MaxDiceCount do
		self._holeAttrViewList[index]:setVisible(false)
	end
end

function M:setEquipModelPos(pos)
	self._equipModelComponent:setModelPos(pos)
end

function M:setHolePos(pos)
	self._holePos = pos
end

function M:_getHolePosInfo(holesNum)
	return self._holePos[holesNum]
end

function M:_onClickHole(index)
	local holeIndex = self._view2holesIndex[index]

	if not holeIndex or holeIndex == 1 then
		return
	end

	holeIndex = holeIndex - 1

	local equipHoleAttrMo = EquipIntensifyModel.instance:genEquipHoleAttrMo(self._equipMo, holeIndex)

	if equipHoleAttrMo.status == EquipEnum.HoleStatus.Unalterable or equipHoleAttrMo.status == EquipEnum.HoleStatus.Lock then
		return
	end

	if equipHoleAttrMo.status == EquipEnum.HoleStatus.NoCalibration then
		local part = self._equipMo:getPart()
		local moList = EquipIntensifyModel.instance:getAllPartD6Item(part)

		if #moList == 0 then
			FloatWordMgr.instance:show(lang("tip_equip_timing_no_adaptive_d6"))

			return
		end
	end

	EquipIntensifyModel.instance:setTimingHoleIndex(holeIndex)

	for _index = 1, #self._view2holesIndex do
		local itemView = self._equipHoleItemViewList[_index]

		itemView:setSelectGoVisible(_index == index)
		EquipIntensifyModel.instance:setTuoweiPos(self._view2holesIndex[_index] - 1, itemView:getIconTransPos())
	end

	if equipHoleAttrMo.status == EquipEnum.HoleStatus.NoCalibration then
		self:_tryOpenEquipTimingView()
	elseif equipHoleAttrMo.status == EquipEnum.HoleStatus.Unlock then
		self:_tryOpenEquipResetView()
	end
end

function M:_tryOpenEquipTimingView()
	local part = self._equipMo:getPart()

	EquipIntensifyModel.instance:setTimingD6Part(part)
	GlobalDispatcher:dispatchEvent(EventType.EQUIP_UI_STATUS_CHANGED, EquipEnum.MainUIStatus.Timing)
end

function M:_tryOpenEquipResetView()
	GlobalDispatcher:dispatchEvent(EventType.EQUIP_UI_STATUS_CHANGED, EquipEnum.MainUIStatus.Retiming)
end

function M:playEquipTmingAni()
	local holeIndex = EquipIntensifyModel.instance:getTimingHoleIndex()

	for index, hole in ipairs(self._view2holesIndex) do
		if hole - 1 == holeIndex then
			local ani = self._holeAni[index]

			ani:Stop()
			AnimationUtils.ResetAnimation(ani, "left_equip_shengji2")
			ani:Play("left_equip_shengji2")

			local ani1 = self._qipaoAni[index]

			ani1:Stop()
			AnimationUtils.ResetAnimation(ani1, "left_equip_tiaojiao")
			ani1:Play("left_equip_tiaojiao")
		end
	end
end

function M:playEquipLvAni()
	local oldEquip = EquipIntensifyModel.instance:getEquipBeforeUpdate()
	local newEquip = EquipIntensifyModel.instance:getOperatingEquip()
	local oldUnlockHoleCount = oldEquip:getUnlockHoleCount()
	local newUnlockHoleCount = newEquip:getUnlockHoleCount()

	if oldUnlockHoleCount < newUnlockHoleCount then
		for index = oldUnlockHoleCount + 1, newUnlockHoleCount do
			local viewIndex = self:getHoleItemViewIndexByHoleIndex(index + 1)

			if viewIndex then
				local ani = self._holeAni[viewIndex]

				ani:Stop()
				AnimationUtils.ResetAnimation(ani, "left_equip_shengji2")
				ani:Play("left_equip_shengji2")

				local ani1 = self._qipaoAni[viewIndex]

				ani1:Stop()
				AnimationUtils.ResetAnimation(ani1, "left_equip_shengji1")
				ani1:Play("left_equip_shengji1")
			end
		end
	end
end

function M:getHoleItemViewIndexByHoleIndex(holeIndex)
	for index, hole in ipairs(self._view2holesIndex) do
		if hole == holeIndex then
			return index
		end
	end
end

return M
