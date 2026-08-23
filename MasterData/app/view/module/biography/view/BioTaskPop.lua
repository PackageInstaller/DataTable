local MainAllElem = import("..model.MainAllElem")
local SubAllElem = import("..model.SubAllElem")
local SubTaskElem = import("..model.SubTaskElem")
local var_0_3 = g.core.model.User.bioData
local BioTaskPop = class("BioTaskPop", require("app.fairyGUI.biography.UI_BioTaskPop"), function()
	return fgui.GComponent:create({
		resName = "BioTaskPop",
		pkgPath = "ui/biography/biography",
		pkgName = "biography"
	})
end)

function BioTaskPop:ctor(arg_2_1, arg_2_2)
	self:showAtCenter()

	self._refChapterInfo = arg_2_1
	self._refJumpSub = arg_2_2
	self._tmpSubChainArr = nil

	self:initTask()
end

function BioTaskPop:onLoad()
	self:_initRegister()
	self.m_taskTree:startUp(self)
	self.m_taskPart:startUp(self)
	self.m_taskTree:refreshUI()

	if self._refJumpSub then
		self.m_taskTree:setSelectTreeIndex(1)
		self.m_taskTree:setSelectTreeIndex(1 + self:_getSubChainIndex(self._refJumpSub))
	else
		self.m_taskTree:setSelectTreeIndex(0)
	end
end

function BioTaskPop:onUnload()
	self.m_taskTree:startUp(nil)
	self.m_taskPart:startUp(nil)
end

function BioTaskPop:initTask()
	self:_initTaskData()
	self:_initTaskUI()
end

function BioTaskPop:onTreeSelectChange(arg_6_1)
	local var_6_0 = arg_6_1:getTaskType()

	self.m_taskTypeController:setSelectedIndex(var_6_0)

	if var_6_0 == 0 then
		self.m_taskPart:refreshTask(self._refChapterInfo)
	elseif var_6_0 == 1 then
		self.m_taskSubPart:refreshTask(arg_6_1:getSubChain(), arg_6_1:getChainState())
	elseif var_6_0 == 2 then
		self.m_taskSubListPart:refreshTask(arg_6_1:getSubChain(), arg_6_1:getChainState())
	end
end

function BioTaskPop:_initTaskData()
	self.m_taskTree:cleanTree()

	local var_7_0 = var_0_3:getChain(self._refChapterInfo.chains[1])

	self.m_taskTree:pushMainElem(MainAllElem.new((g.core.lang:get(302079, {
		num = var_7_0.current,
		maxNum = #var_7_0.missions
	}))))

	local var_7_1 = self:_getSubChains()
	local var_7_2 = SubAllElem.new(#var_7_1)

	self.m_taskTree:pushMainElem(var_7_2)

	local var_7_3 = 0

	for iter_7_0, iter_7_1 in ipairs(var_7_1) do
		if iter_7_1.finish then
			var_7_3 = var_7_3 + 1
		end

		self.m_taskTree:pushSubElem(SubTaskElem.new(iter_7_1))
	end

	var_7_2:setFinishNum(var_7_3)

	self._tmpSubChainArr = var_7_1
end

function BioTaskPop:_initTaskUI()
	return
end

function BioTaskPop:_initRegister()
	return
end

function BioTaskPop:_getSubChains()
	local var_10_0 = {}

	for iter_10_0, iter_10_1 in ipairs(self._refChapterInfo.chains) do
		local var_10_1 = var_0_3:getChain(iter_10_1)

		if var_10_1.type == 2 or var_10_1.type == 4 then
			table.insert(var_10_0, var_10_1)
		end
	end

	table.sort(var_10_0, function(arg_11_0, arg_11_1)
		if arg_11_0.mission_priority ~= arg_11_1.mission_priority then
			return arg_11_0.mission_priority < arg_11_1.mission_priority
		end

		return false
	end)

	return var_10_0
end

function BioTaskPop:_getSubChainIndex(arg_12_1)
	local var_12_0 = var_0_3:getChain(arg_12_1.chain)

	for iter_12_0, iter_12_1 in ipairs(self._tmpSubChainArr) do
		if iter_12_1.id == var_12_0.id then
			return iter_12_0
		end
	end

	return 1
end

return BioTaskPop
