-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ashechallenge/view/ASheBuffSelectView.lua

module("logic.extensions.ashechallenge.view.ASheBuffSelectView", package.seeall)

local ASheBuffSelectView = class("ASheBuffSelectView", ViewComponent)

function ASheBuffSelectView:ctor()
	ASheBuffSelectView.super.ctor(self)
end

function ASheBuffSelectView:buildUI()
	ASheBuffSelectView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._globalBuffGo = self:getGo("globalBuff")
	self._localBuffGo = self:getGo("localBuff")
	self._cell = self:getGo("cell")

	goutil.setActive(self._cell, false)

	self._globalCellList = {}
	self._localCellList = {}

	for i = 1, 3 do
		self:_addBuffCell(true, i)
		self:_addBuffCell(false, i)
	end

	self._txtNum = self:getTxt("txtNum")
	self._btnSure = self:getBtn("btnSure")
end

function ASheBuffSelectView:_addBuffCell(isGlobal, i)
	if isGlobal then
		if not self._globalBuffGo.transform then
			local parant = self._localBuffGo.transform
			local go = goutil.cloneAndSetParent(self._cell, parant, "buff" .. i)
			local cell = {}

			cell.go = go
			cell.skillIcon = goutil.findChild(go, "skillIcon")
			cell.txtName = goutil.findChildTextComponent(go, "txtName")
			cell.txtDesc = goutil.findChildTextComponent(go, "txtDesc")
			cell.selectGo = goutil.findChild(go, "btnSelect/imgBg/select")
			cell.btn = Framework.ButtonAdapter.GetFrom(go, "btnSelect")

			goutil.setActive(cell.selectGo, false)

			if isGlobal then
				table.insert(self._globalCellList, cell)
			else
				table.insert(self._localCellList, cell)
			end
		end
	end
end

function ASheBuffSelectView:bindEvents()
	ASheBuffSelectView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnSure:AddClickListener(self._onClickSure, self)

	for i = 1, 3 do
		self._globalCellList[i].btn:AddClickListener(function()
			self:_onClickGlobalCell(i)
		end)
	end

	for i = 1, 3 do
		self._localCellList[i].btn:AddClickListener(function()
			self:_onClickLocalCell(i)
		end)
	end
end

function ASheBuffSelectView:unbindEvents()
	ASheBuffSelectView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnSure:RemoveClickListener()

	for i = 1, 3 do
		self._globalCellList[i].btn:RemoveClickListener()
	end

	for i = 1, 3 do
		self._localCellList[i].btn:RemoveClickListener()
	end
end

function ASheBuffSelectView:onEnter()
	ASheBuffSelectView.super.onEnter(self)

	local params = self:getOpenParam()

	self._activityId = params[1]
	self._selectBuffPlanId = params[2]
	self._globalBuffList, self._localBuffList = ASheController.instance:getBuffLists(self._activityId, self._selectBuffPlanId)
	self._selectGlobalBuffIndex = 0
	self._selectLocalBuffIndex = 0

	self:_initBuffs(self._globalCellList, self._globalBuffList)
	self:_initBuffs(self._localCellList, self._localBuffList)
	self:_updateTxtNum()
	self:_initBuffIndex()
end

function ASheBuffSelectView:_initBuffIndex()
	local buffIds = ASheModel.instance:getSelectedBuffs(self._activityId)

	if #buffIds > 0 then
		local isGlobalSelect = false
		local isLocalSelect = false

		for i, buffId in ipairs(buffIds) do
			if not isGlobalSelect then
				for j, globalBuffId in ipairs(self._globalBuffList) do
					if buffId == globalBuffId then
						self:_onClickGlobalCell(j)

						isGlobalSelect = true

						break
					end
				end
			end

			if not isLocalSelect then
				for j, localBuffId in ipairs(self._localBuffList) do
					if buffId == localBuffId then
						self:_onClickLocalCell(j)

						isLocalSelect = true

						break
					end
				end
			end
		end
	end
end

function ASheBuffSelectView:onExit()
	ASheBuffSelectView.super.onExit(self)
end

function ASheBuffSelectView:_onClickSure()
	if self._selectGlobalBuffIndex == 0 then
		FloatWordMgr.instance:show("请选择一个全局增益")

		return
	end

	if self._selectLocalBuffIndex == 0 then
		FloatWordMgr.instance:show("请选择一个专属增益")

		return
	end

	local selectedBuffs = {}

	table.insert(selectedBuffs, self._globalBuffList[self._selectGlobalBuffIndex])
	table.insert(selectedBuffs, self._localBuffList[self._selectLocalBuffIndex])
	ASheChallengeAgent.instance:sendPM_ASheChallengeSelectBuffReq(self._activityId, selectedBuffs)
	self:close()
end

function ASheBuffSelectView:_onClickGlobalCell(index)
	if self._selectGlobalBuffIndex == index then
		return
	end

	self._selectGlobalBuffIndex = index

	self:_updateBtnState(true, index)
	self:_updateTxtNum()
end

function ASheBuffSelectView:_onClickLocalCell(index)
	if self._selectLocalBuffIndex == index then
		return
	end

	self._selectLocalBuffIndex = index

	self:_updateBtnState(false, index)
	self:_updateTxtNum()
end

function ASheBuffSelectView:_initBuffs(cellList, buffList)
	for i, buffId in ipairs(buffList) do
		local cell = cellList[i]

		if cell then
			local cfg = ASheConfig.instance:getSelectBuff(self._selectBuffPlanId, buffId)

			if cfg then
				goutil.setActive(cell.go, true)
				goutil.setActive(cell.selectGo, false)
				uGuiUtil.setSpriteToImage(cell.skillIcon, uGuiUtil.SpriteType.BigBg, GameUrl.getExpEventUrl(cfg.iconName))

				cell.txtName.text = cfg.buffName
				cell.txtDesc.text = cfg.buffDesc
			else
				goutil.setActive(cell.go, false)
			end
		end
	end
end

function ASheBuffSelectView:_updateBtnState(isGlobal, selectIndex)
	if isGlobal then
		if not self._globalCellList then
			local cellList = self._localCellList

			for i, v in ipairs(cellList) do
				goutil.setActive(v.selectGo, i == selectIndex)
			end
		end
	end
end

function ASheBuffSelectView:_updateTxtNum()
	local num = 0

	if self._selectGlobalBuffIndex > 0 then
		num = num + 1
	end

	if self._selectLocalBuffIndex > 0 then
		num = num + 1
	end

	if num == 2 then
		if not ColorConst.Green2 then
			local colorStr = ColorConst.Red

			self._txtNum.text = string.format("已选增益：<color=#%s>%d</color>/2", colorStr, num)
		end
	end
end

return ASheBuffSelectView
