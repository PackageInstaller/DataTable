local var_0_0 = g.core.model.User.newSlgDevelopData
local var_0_1 = g.core.const.ConstMgr.NewSlgConst
local NewSlgUpgradeSuccessPop = class("NewSlgUpgradeSuccessPop", require("app.fairyGUI.newSlg.UI_NewSlgUpgradeSuccessPop"), function()
	return fgui.GComponent:create({
		resName = "NewSlgUpgradeSuccessPop",
		pkgPath = "ui/newSlg/newSlg",
		pkgName = "newSlg"
	})
end)

function NewSlgUpgradeSuccessPop:ctor(arg_2_1)
	self:showAtCenter()

	self._params = arg_2_1
	self._lineupList = {}
	self._baseList = {}
	self._otherList = {}
end

function NewSlgUpgradeSuccessPop:_updateView()
	self.m_seasonController:setSelectedIndex(g.core.model.User.newSlgData:getSName() == "S1" and 0 or 1)
	self.m_buildTypeController:setSelectedIndex(self._params.buildType)
	self:_playEnterAnim()
	self.m_curBuild:updateView({
		showRed = false,
		level = self._params.curCfg.level,
		resURL = g.core.common.Path:getNewSlgBuildPic(self._params.curCfg.res_id)
	})
	self.m_nextBuild:updateView({
		showRed = true,
		level = self._params.nextCfg.level,
		resURL = g.core.common.Path:getNewSlgBuildPic(self._params.nextCfg.res_id)
	})

	if self._params.buildType == var_0_1.SLG_BUILD_TYPE.COMMAND then
		self:_updateMainCityAdd()
	else
		self:_updateOtherAdd()
	end
end

function NewSlgUpgradeSuccessPop:_playEnterAnim()
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_SingleJiesuan_CN)

	if self._params.buildType == var_0_1.SLG_BUILD_TYPE.COMMAND then
		self.m_enter1Transition:play()
	else
		self.m_enter2Transition:play()
	end
end

function NewSlgUpgradeSuccessPop:_updateMainCityAdd()
	local var_5_0 = var_0_0:getCachedUpgradeData(self._params.buildType)
	local var_5_1 = var_5_0.baseArr or {}
	local var_5_2 = var_5_0.lineUpArr or {}

	self.m_hasLineupController:setSelectedIndex(#var_5_2 > 0 and 1 or 0)

	for iter_5_0 = 1, 4 do
		if self["m_baseValue" .. iter_5_0] then
			if var_5_1[iter_5_0] then
				self["m_baseValue" .. iter_5_0]:setVisible(true)
				self["m_baseValue" .. iter_5_0]:updateUpgradeCell({
					name = var_5_1[iter_5_0].name,
					curNum = var_5_1[iter_5_0].curNum,
					nextNum = var_5_1[iter_5_0].nextNum
				})
			else
				self["m_baseValue" .. iter_5_0]:setVisible(false)
			end
		end

		local var_5_3 = var_5_2[iter_5_0]

		if self["m_lineupValue" .. iter_5_0] then
			if var_5_3 then
				self["m_lineupValue" .. iter_5_0]:setVisible(true)
				self["m_lineupValue" .. iter_5_0]:updateUpgradeCell({
					name = var_5_3.name,
					curNum = var_5_3.curNum,
					nextNum = var_5_3.nextNum
				})
			else
				self["m_lineupValue" .. iter_5_0]:setVisible(false)
			end
		end
	end
end

function NewSlgUpgradeSuccessPop:_updateOtherAdd()
	local var_6_0 = var_0_0:getCachedUpgradeData(self._params.buildType)

	for iter_6_0 = 1, 4 do
		if self["m_otherValue" .. iter_6_0] then
			if var_6_0[iter_6_0] then
				self["m_otherValue" .. iter_6_0]:setVisible(true)
				self["m_otherValue" .. iter_6_0]:updateUpgradeCell({
					name = var_6_0[iter_6_0].name,
					curNum = var_6_0[iter_6_0].curNum,
					nextNum = var_6_0[iter_6_0].nextNum
				})
			else
				self["m_otherValue" .. iter_6_0]:setVisible(false)
			end
		end
	end
end

function NewSlgUpgradeSuccessPop:onLoad()
	self:_updateView()
end

function NewSlgUpgradeSuccessPop:onUnload()
	self.m_backTransition:play()
end

return NewSlgUpgradeSuccessPop
