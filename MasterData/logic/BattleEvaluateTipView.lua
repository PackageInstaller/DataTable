-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/materialchallenge/view/BattleEvaluateTipView.lua

module("logic.extensions.materialchallenge.view.BattleEvaluateTipView", package.seeall)

local BattleEvaluateTipView = class("BattleEvaluateTipView", ViewComponent)

function BattleEvaluateTipView:buildUI()
	self._closeButton = self:getBtn("btnClose")
	self._txtDesc1 = self:getTxt("content/txtDesc1")
	self._txtDesc2 = self:getTxt("content/txtDesc2")
	self._txtDesc3 = self:getTxt("content/scroll/viewport/content/txtDesc3")
	self._tableview = self:getGo("content/rewardList"):GetComponent("UITableview")
	self._tableCell = self:getGo("content/rewardList/item")
end

function BattleEvaluateTipView:bindEvents()
	self._closeButton:AddClickListener(self._onClickClose, self)
end

function BattleEvaluateTipView:unbindEvents()
	self._closeButton:RemoveClickListener()
end

function BattleEvaluateTipView:onEnter()
	BattleController.instance:setBattlePause(true)

	local params = self:getFirstParam()

	self._txtDesc1.text = params.desc1
	self._txtDesc2.text = params.desc2
	self._txtDesc3.text = params.desc3

	local rewardStr = params.rewardStr

	self._tableview:RegisterCallback(self._numInView, self._cellSize, self._cellAtIndex, self)

	self._curViewDatas = {}

	local str = string.split(rewardStr, "#")
	local rewardItems1 = {}
	local rewardItems2 = {}
	local temp = {}

	for i, v in ipairs(str) do
		local s = string.split(v, ":")

		if checknumber(s[1]) == 9 then
			table.insert(temp, v)
		else
			table.insert(rewardItems1, v)
		end
	end

	for i, v in ipairs(temp) do
		local s = MaterialMgr.changeItemStr(v)
		local items = string.split(s, "#")

		for i1, v1 in ipairs(items) do
			if not string.nilorempty(v1) then
				table.insert(rewardItems2, v1)
			end
		end
	end

	for i, v in ipairs(rewardItems2) do
		local element = {}

		element.rewardStr = v
		element.isProb = true

		table.insert(self._curViewDatas, element)
	end

	for i, v in ipairs(rewardItems1) do
		local element = {}

		element.rewardStr = v
		element.isProb = false

		table.insert(self._curViewDatas, element)
	end

	self._tableview:ReloadData()
end

function BattleEvaluateTipView:onExit()
	BattleController.instance:setBattlePause(false)
	self._tableview:Travel(self._clearTableview, self)
	self._tableview:UnRegisterAllCallbacks()
end

function BattleEvaluateTipView:_onClickClose()
	self:close()
end

function BattleEvaluateTipView:_numInView()
	return #self._curViewDatas
end

function BattleEvaluateTipView:_cellSize(view, idx)
	if idx + 1 == #self._curViewDatas then
		return 110, 90
	end

	return 90, 90
end

function BattleEvaluateTipView:_cellAtIndex(view, index)
	local cell = view:DequeueCell()

	cell = cell or view:AddChild(self._tableCell)

	local data = self._curViewDatas[index + 1]

	self:_updateCell(view, cell, data)

	return cell
end

function BattleEvaluateTipView:_updateCell(view, cell, data)
	local parentGo = goutil.findChild(cell.gameObject, "node")
	local prob = goutil.findChild(cell.gameObject, "prob")

	Framework.TransformUtil.SetLocalScale(parentGo.transform, 0.9, 0.9, 0.9)

	local proxy = MaterialMgr.setCellByCfg(data.rewardStr, parentGo)

	goutil.setActive(prob, data.isProb)
end

function BattleEvaluateTipView:_clearTableview(cell)
	local parentGo = goutil.findChild(cell.gameObject, "node")

	MaterialMgr.resetAll(parentGo)
end

return BattleEvaluateTipView
