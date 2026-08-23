local ThemeMainAllElem = import("..model.ThemeMainAllElem")
local ThemeSubAllElem = import("..model.ThemeSubAllElem")
local ThemeSubTaskElem = import("..model.ThemeSubTaskElem")
local var_0_3 = g.core.model.User.themeData
local ThemeBioTaskPop = class("ThemeBioTaskPop", require("app.fairyGUI.themeBio.UI_ThemeBioTaskPop"), function()
	return fgui.GComponent:create({
		resName = "ThemeBioTaskPop",
		pkgPath = "ui/themeBio/themeBio",
		pkgName = "themeBio"
	})
end)

function ThemeBioTaskPop:ctor(arg_2_1, arg_2_2, arg_2_3)
	self:showAtCenter()

	self._refChapterInfo = arg_2_1
	self._refJumpSub = arg_2_2
	self._tmpSubChainArr = nil
	self._activeThemeValue = arg_2_3
	self._themeBioData = var_0_3:getThemeData(self._activeThemeValue):getThemeBioData()

	self:initTask()
end

function ThemeBioTaskPop:onLoad()
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

function ThemeBioTaskPop:onUnload()
	self.m_taskTree:startUp(nil)
	self.m_taskPart:startUp(nil)
end

function ThemeBioTaskPop:initTask()
	self:_initTaskData()
	self:_initTaskUI()
end

function ThemeBioTaskPop:onTreeSelectChange(arg_6_1)
	local var_6_0 = arg_6_1:getTaskType()

	self.m_taskTypeController:setSelectedIndex(var_6_0)

	if var_6_0 == 0 then
		self.m_taskPart:refreshTask(self._refChapterInfo, self._activeThemeValue)
	elseif var_6_0 == 1 then
		self.m_taskSubPart:refreshTask(arg_6_1:getSubChain(), arg_6_1:getChainState(), self._activeThemeValue)
	elseif var_6_0 == 2 then
		self.m_taskSubListPart:refreshTask(arg_6_1:getSubChain(), arg_6_1:getChainState(), self._activeThemeValue)
	end
end

function ThemeBioTaskPop:_initTaskData()
	self.m_taskTree:cleanTree()

	local var_7_0 = self._themeBioData:getChain(self._refChapterInfo.chains[1])
	local var_7_1 = 409118
	local var_7_2 = g.core.lang:get(409101, {
		num = var_7_0.current,
		maxNum = #var_7_0.missions
	})

	if self._activeThemeValue == g.core.const.ConstMgr.ThemeConst.THEME_VALUE.GOLDENDANCE then
		var_7_2 = g.core.lang:get(409156, {
			num = var_7_0.current,
			maxNum = #var_7_0.missions
		})
		var_7_1 = 409157
	end

	self.m_taskTree:pushMainElem(ThemeMainAllElem.new(var_7_2))

	local var_7_3 = self:_getSubChains()

	if next(var_7_3) then
		local var_7_4 = ThemeSubAllElem.new(#var_7_3)

		self.m_taskTree:pushMainElem(var_7_4)

		local var_7_5 = 0

		for iter_7_0, iter_7_1 in ipairs(var_7_3) do
			if iter_7_1.finish then
				var_7_5 = var_7_5 + 1
			end

			self.m_taskTree:pushSubElem(ThemeSubTaskElem.new(iter_7_1, self._activeThemeValue))
		end

		var_7_4:setFinishNum(var_7_5, var_7_1)
	end

	self._tmpSubChainArr = var_7_3
end

function ThemeBioTaskPop:_initTaskUI()
	return
end

function ThemeBioTaskPop:_initRegister()
	return
end

function ThemeBioTaskPop:_getSubChains()
	local var_10_0 = {}

	for iter_10_0, iter_10_1 in ipairs(self._refChapterInfo.chains) do
		local var_10_1 = self._themeBioData:getChain(iter_10_1)

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

function ThemeBioTaskPop:_getSubChainIndex(arg_12_1)
	local var_12_0 = self._themeBioData:getChain(arg_12_1.chain)

	for iter_12_0, iter_12_1 in ipairs(self._tmpSubChainArr) do
		if iter_12_1.id == var_12_0.id then
			return iter_12_0
		end
	end

	return 1
end

return ThemeBioTaskPop
