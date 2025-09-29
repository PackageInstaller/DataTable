-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/containmentzone/cell/ProtomerModuleUpgradeCell.lua

module("logic.extensions.containmentzone.cell.ProtomerModuleUpgradeCell", package.seeall)

local M = class("ProtomerModuleUpgradeCell", UIReusableLuaBehavior)

function M:buildUI()
	self._mainRect = goutil.findChildComponent(self.mainGO, "", goutil.Type_RectTransform)
	self._goLock = goutil.findChild(self.mainGO, "lock")
	self._goUnLock = goutil.findChild(self.mainGO, "unlock")
	self._txtNameLock = goutil.findChildTextComponent(self.mainGO, "lock/txtName")
	self._txtNameUnLock = goutil.findChildTextComponent(self.mainGO, "unlock/txtName")
	self._btnClick = UIComponentType.ButtonAdapter(goutil.findChild(self.mainGO, "click"))
	self._goLineRoot = goutil.findChild(self.mainGO, "line_root")
	self._goLineItem = goutil.findChild(self.mainGO, "line_root/line")
end

function M:destroyUI()
	self._mainRect = nil
	self._goLock = nil
	self._goUnLock = nil
	self._txtNameLock = nil
	self._txtNameUnLock = nil
	self._btnClick = nil
	self._goLineRoot = nil
	self._goLineItem = nil
end

function M:bindEvents()
	self._btnClick:AddClickListener(self._onClick, self)
end

function M:unbindEvents()
	self._btnClick:RemoveClickListener()
end

function M:onEnter()
	self._itemWidth = goutil.getWidth(self._mainRect)
end

function M:onExit()
	self._moduleCode = nil
	self._moduleId = nil
	self._protomerId = nil
	self._lockTyp = nil
	self._cfg = nil
	self._handler = nil
end

function M:getItemAnchorPosX()
	return self._mainRect.anchoredPosition.x
end

function M:_onClick()
	printWarn(string.format("点击弹出[%d]原体模块[%d]LockTyp[%d]", self._protomerId, self._moduleId, self._lockTyp))

	if self._lockTyp == ContainmentEnum.ModuleLockTyp.Lock then
		FloatWordMgr.instance:show(lang("tip_lock_pre_module"))
	else
		ToolTipsMgr.showFacilityHoldingModuleTips(self._protomerId, self._moduleCode, self._moduleId, self._lockTyp)
	end
end

function M:setHandler(handler)
	self._handler = handler
end

function M:setCellData(itemData)
	self._cfg = itemData.cfg
	self._moduleCode = itemData.cfg.id
	self._moduleId = itemData.cfg.module
	self._moduleTyp = itemData.cfg.moduletyp
	self._protomerId = itemData.protomerId
	self._preLst = itemData.preLst or {}
	self._lockTyp = itemData.lockTyp
	self._layoutInfo = itemData.layoutInfo

	self:setName(itemData.cfg.name)
	self:setLock(self._lockTyp ~= ContainmentEnum.ModuleLockTyp.isUpgrade)
	self:updateModuleGraph()
end

function M:setLock(lock)
	goutil.setActive(self._goLock, lock)
	goutil.setActive(self._goUnLock, not lock)
end

function M:setName(content)
	self._txtNameLock.text = content
	self._txtNameUnLock.text = content
end

function M:updateModuleGraph()
	local count = #self._preLst
	local rootTrans = self._goLineRoot.transform

	while count > rootTrans.childCount do
		goutil.cloneAndSetParent(self._goLineItem, rootTrans)
	end

	for i = 0, rootTrans.childCount - 1 do
		local show = i < count
		local tempGo = rootTrans:GetChild(i).gameObject

		goutil.setActive(tempGo, show)
	end

	local protomerMo = ProtomerModel.instance:getProtomerInfo(self._protomerId)
	local myPos = self:_getModulePosX(self._moduleId)
	local lineWidthDefault = 10

	for index, value in ipairs(self._preLst or {}) do
		local rectLine = self._goLineRoot.transform:GetChild(index - 1):GetComponent(goutil.Type_RectTransform)
		local goLineLock = goutil.findChild(rectLine, "line_lock")
		local goLineUnLock = goutil.findChild(rectLine, "line_unlock")
		local preModuleId = value
		local preModulePos = self:_getModulePosX(preModuleId)
		local preModuleIsUpgrade = protomerMo:getIsModuleUpGrade(preModuleId)

		goutil.setActive(goLineLock, not preModuleIsUpgrade)
		goutil.setActive(goLineUnLock, preModuleIsUpgrade)

		if myPos == preModulePos then
			goutil.setWidth(rectLine, lineWidthDefault)
			Astral.TransformUtil.SetAnchoredPos(rectLine.transform, 0, 0)
			Astral.TransformUtil.SetLocalScale(rectLine.transform, 1, 1, 1)
		elseif myPos < preModulePos then
			goutil.setWidth(rectLine, preModulePos - myPos + lineWidthDefault)
			Astral.TransformUtil.SetAnchoredPos(rectLine.transform, (preModulePos - myPos) * 0.5, 0)
			Astral.TransformUtil.SetLocalScale(rectLine.transform, 1, 1, 1)
		elseif preModulePos < myPos then
			goutil.setWidth(rectLine, myPos - preModulePos + lineWidthDefault)
			Astral.TransformUtil.SetAnchoredPos(rectLine.transform, (myPos - preModulePos) * -0.5, 0)
			Astral.TransformUtil.SetLocalScale(rectLine.transform, -1, 1, 1)
		end
	end
end

function M:_getModulePosX(moduleId)
	local _mTyp = self:_getModuleTyp(moduleId)
	local _numInTyp = self:_getModuleNumInTyp(_mTyp)
	local _midPos = self._layoutInfo.contentWidth * 0.5

	if _numInTyp == 1 then
		return _midPos
	end

	local _uiIndex = self:_getModuleUiIndexInTyp(moduleId)
	local step = self._itemWidth + self._layoutInfo.spacing
	local pos = _midPos

	if _numInTyp % 2 == 0 then
		local _numEachSide = _numInTyp / 2
		local _left = _uiIndex < _numEachSide

		if _left then
			pos = pos + step * 0.5

			for i = _numEachSide - 1, 0, -1 do
				pos = pos - step

				if i == _uiIndex then
					break
				end
			end
		else
			pos = pos - step * 0.5

			for i = _numEachSide, _numInTyp - 1 do
				pos = pos + step

				if i == _uiIndex then
					break
				end
			end
		end

		return pos
	else
		local _midIndex = math.floor(_numInTyp / 2)

		if _uiIndex == _midIndex then
			return pos
		elseif _uiIndex < _midIndex then
			for i = _midIndex - 1, 0, -1 do
				pos = pos - step

				if i == _uiIndex then
					break
				end
			end
		elseif _midIndex < _uiIndex then
			for i = _midIndex + 1, _numInTyp - 1 do
				pos = pos + step

				if i == _uiIndex then
					break
				end
			end
		end

		return pos
	end
end

function M:_getModuleTyp(moduleId)
	if moduleId < self._layoutInfo.baseNum then
		return ContainmentEnum.moduleTypBase
	elseif moduleId <= self._layoutInfo.primaryNum then
		return ContainmentEnum.moduleTypPrimary
	else
		return ContainmentEnum.moduleTypAdvanced
	end
end

function M:_getModuleNumInTyp(moduleTyp)
	if moduleTyp == ContainmentEnum.moduleTypBase then
		return self._layoutInfo.baseNum
	elseif moduleTyp == ContainmentEnum.moduleTypPrimary then
		return self._layoutInfo.primaryNum
	elseif moduleTyp == ContainmentEnum.moduleTypAdvanced then
		return self._layoutInfo.advancedNum
	end
end

function M:_getModuleUiIndexInTyp(moduleId)
	local moduleTyp = self:_getModuleTyp(moduleId)

	if moduleTyp == ContainmentEnum.moduleTypBase then
		return moduleId
	elseif moduleTyp == ContainmentEnum.moduleTypPrimary then
		return moduleId - self._layoutInfo.baseNum
	elseif moduleTyp == ContainmentEnum.moduleTypAdvanced then
		return moduleId - self._layoutInfo.baseNum - self._layoutInfo.primaryNum
	end
end

return M
