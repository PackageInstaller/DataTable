local var_0_0 = g.core.model.User.guildWarData
local var_0_1 = g.core.model.User.guildData
local var_0_2 = g.core.const.ConstMgr.GuildWarConst.FightStageType
local GuildWarOperatePop = class("GuildWarOperatePop", require("app.fairyGUI.guildWar.UI_GuildWarOperatePop"), function()
	return fgui.GComponent:create({
		pkgName = "guildWar",
		resName = "GuildWarOperatePop",
		pkgPath = "ui/guildWar/guildWar"
	}, ...)
end)
local var_0_4 = {
	NONE = 0,
	OPEN = 1
}

function GuildWarOperatePop:ctor(arg_2_1)
	self:showAtCenter()

	self._canOpe = false
	self._curSelectDataList = {}
	self._selectUserIdMap = {}
	self._state = var_0_4.NONE

	self:setSize(display.width, display.height)
	self.m_touchComp:setSize(display.width, display.height)

	self._buildId = arg_2_1.buildId
	self._buildStruct = var_0_0:getBuildDataById(self._buildId)
	self._allUser = self._buildStruct:getUsers()
	self._allMember = {}
	self._curCanUpMember = {}

	self.m_touchComp:addClickListener(handler(self, self._onTouchCompClick))
	self.m_confirmBtn:addClickListener(handler(self, self._onTouchCompClick))
	self.m_memberList:setVirtual()
	self.m_memberList:setItemRenderer(handler(self, self._onSelectMemberRenderer))
	self.m_memberList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onMemberClick))

	for iter_2_0 = 1, 2 do
		self["m_compBtn" .. iter_2_0]:addClickListener(handler(self, self["onOpenCompClick" .. iter_2_0]))
	end

	self:initView()
end

function GuildWarOperatePop:onLoad()
	self.m_enterTransition:play()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_WAR_FORMAT, handler(self, self._onGuildWarFormation), self)
	self:updateView()
end

function GuildWarOperatePop:initView()
	local var_4_0 = self._buildStruct:getCfg()

	self.m_nameTxt:setText(var_4_0.build_name)

	self._maxBuildHp = var_4_0.build_score

	self.m_progressBaseTxt:setText("/" .. var_4_0.build_score)
	self.m_progressTxt:setText(var_4_0.build_score)
	self.m_buildHpProgress:setProgress(var_4_0.build_hp, var_4_0.build_score)
	self.m_numController:setSelectedIndex(var_4_0.people_num - 1)

	self._peopleNum = var_4_0.people_num

	self.m_buildIcon:setURL(g.core.common.Path:getGuildWarBuild(var_4_0.build_type))

	for iter_4_0 = 1, self._peopleNum do
		self["m_compBtn" .. iter_4_0]:updateAsMemberData()
	end
end

function GuildWarOperatePop:calcAllMemberList()
	self._allMember = {}

	for iter_5_0, iter_5_1 in ipairs((var_0_1:getMemberData())) do
		local var_5_0 = var_0_0:getBuildDataByPlayerId(iter_5_1.user.id)

		table.insert(self._allMember, {
			buildStruct = var_5_0,
			buildId = var_5_0 and var_5_0:getCfg().id,
			userId = iter_5_1.user.id,
			position = var_5_0 and var_5_0:getPositionByPlayerId(iter_5_1.user.id),
			fightValue = iter_5_1.user.fight_value,
			user = iter_5_1.user
		})
	end
end

function GuildWarOperatePop:onOpenCompClick1()
	if not self._canOpe then
		if self.m_selectController:getSelectedIndex() <= 1 then
			local var_6_0 = self._buildStruct:getUserByPosition(1)

			if var_6_0 and var_6_0:getUser() then
				g.core.module.ModuleManager:pushModule(g.view.entrance.PLAYER_INFO, {
					uid = var_6_0:getUser().id
				})
			elseif not var_0_0:isLeader() then
				g.core.module.ModuleManager:tip(g.core.lang:get(308656))
			end
		end

		return
	end

	if self._state == var_0_4.NONE then
		self._state = var_0_4.OPEN

		self:updateListView()
		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.GUILD_WAR_SELECTED_USER_POP)
		self.m_showListController:setSelectedIndex(1)
	end
end

function GuildWarOperatePop:onOpenCompClick2()
	if not self._canOpe then
		if self.m_selectController:getSelectedIndex() <= 1 then
			local var_7_0 = self._buildStruct:getUserByPosition(2)

			if var_7_0 and var_7_0:getUser() then
				g.core.module.ModuleManager:pushModule(g.view.entrance.PLAYER_INFO, {
					uid = var_7_0:getUser().id
				})
			elseif not var_0_0:isLeader() then
				g.core.module.ModuleManager:tip(g.core.lang:get(308656))
			end
		end

		return
	end

	if self._state == var_0_4.NONE then
		self._state = var_0_4.OPEN

		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.GUILD_WAR_SELECTED_USER_POP)
		self:updateListView()
		self.m_showListController:setSelectedIndex(1)
	end
end

function GuildWarOperatePop:updateFormationData()
	self:calcAllMemberList()

	self._curCanUpMember = {}
	self._allUser = self._buildStruct:getUsers()

	local var_8_0 = {}

	for iter_8_0, iter_8_1 in ipairs(self._allMember) do
		iter_8_1.isCurPos = false

		if not iter_8_1.position or not iter_8_1.buildId then
			iter_8_1.upBuildType = 999

			if not var_8_0[iter_8_1.userId] then
				var_8_0[iter_8_1.userId] = true

				table.insert(self._curCanUpMember, iter_8_1)
			end
		elseif iter_8_1.buildId ~= self._buildId then
			iter_8_1.upBuildType = iter_8_1.buildStruct:getCfg().build_type

			if not var_8_0[iter_8_1.userId] then
				var_8_0[iter_8_1.userId] = true

				table.insert(self._curCanUpMember, iter_8_1)
			end
		else
			for iter_8_2, iter_8_3 in pairs(self._allUser) do
				iter_8_1.upBuildType = 99999
				iter_8_1.isCurPos = true

				if not var_8_0[iter_8_1.userId] then
					var_8_0[iter_8_1.userId] = true

					table.insert(self._curCanUpMember, iter_8_1)
				end
			end
		end
	end

	table.sort(self._curCanUpMember, function(arg_9_0, arg_9_1)
		if arg_9_0.isCurPos ~= arg_9_1.isCurPos then
			return arg_9_0.isCurPos
		end

		if arg_9_0.upBuildType ~= arg_9_1.upBuildType then
			return arg_9_0.upBuildType > arg_9_1.upBuildType
		end

		if arg_9_0.fightValue ~= arg_9_1.fightValue then
			return arg_9_0.fightValue > arg_9_1.fightValue
		end

		return false
	end)
end

function GuildWarOperatePop:_onClickItemChange()
	return
end

function GuildWarOperatePop:_onGuildWarFormation()
	g.core.module.ModuleManager:tip(g.core.lang:get(308664))
	self:onCloseAnimFinish()
end

function GuildWarOperatePop:updateView()
	if var_0_0:isLeader() and var_0_0:getFightStageType() == var_0_2.DEPLOY then
		self.m_canOpeController:setSelectedIndex(0)

		self._canOpe = true
	else
		self.m_canOpeController:setSelectedIndex(1)

		self._canOpe = false
	end

	self._buildStruct = var_0_0:getBuildDataById(self._buildId)

	local var_12_0 = self._maxBuildHp - self._buildStruct:getCostScore()

	self.m_progressTxt:setText(var_12_0)

	for iter_12_0, iter_12_1 in pairs((self._buildStruct:getUsers())) do
		if self["m_compBtn" .. iter_12_0] then
			self["m_compBtn" .. iter_12_0]:updateUserSelectComp(iter_12_1)
		end
	end

	self.m_buildHpProgress:setProgress(var_12_0)
	self:updateListView()
end

function GuildWarOperatePop:updateListView()
	self:updateFormationData()

	for iter_13_0, iter_13_1 in ipairs(self._curCanUpMember) do
		if iter_13_1.isCurPos then
			self._selectUserIdMap[iter_13_1.userId] = true
		end
	end

	if #self._curCanUpMember == 0 then
		self.m_noMemberController:setSelectedIndex(0)
	else
		self.m_noMemberController:setSelectedIndex(1)
		self.m_memberList:setNumItems(#self._curCanUpMember)
	end
end

function GuildWarOperatePop:_onTouchCompClick()
	if not self._canOpe then
		if self._close then
			return
		end

		self._close = true

		self:onCloseAnimFinish()

		return
	end

	if self._state == var_0_4.OPEN then
		self._state = var_0_4.NONE

		self.m_showListController:setSelectedIndex(0)
		self:checkAndLineUp()
	else
		if self._close then
			return
		end

		self._close = true

		self:onCloseAnimFinish()
	end
end

function GuildWarOperatePop:onCloseAnimFinish()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function GuildWarOperatePop:checkAndLineUp()
	local var_16_0 = {}
	local var_16_1 = {}

	for iter_16_0, iter_16_1 in pairs((self._buildStruct:getUsers())) do
		var_16_0[iter_16_1:getPosition()] = iter_16_1:getUserId()
	end

	for iter_16_2, iter_16_3 in pairs(self._selectUserIdMap) do
		table.insert(var_16_1, iter_16_2)
	end

	local var_16_2 = {}

	for iter_16_4 = 1, self._peopleNum do
		if var_16_1[iter_16_4] == var_16_0[iter_16_4] then
			var_16_1[iter_16_4] = nil
			var_16_2[iter_16_4] = true
		end
	end

	if next(var_16_1) then
		for iter_16_5, iter_16_6 in pairs(var_16_1) do
			g.core.network.GameNetProxy:send_C2S_GuildWar_Format({
				build_id = self._buildId,
				position = iter_16_5,
				user_id = iter_16_6
			})
		end
	end

	for iter_16_7 = 1, self._peopleNum do
		if var_16_1[iter_16_7] then
			g.core.network.GameNetProxy:send_C2S_GuildWar_Format({
				build_id = self._buildId,
				position = iter_16_7,
				user_id = var_16_1[iter_16_7]
			})
		elseif not var_16_2[iter_16_7] then
			g.core.network.GameNetProxy:send_C2S_GuildWar_Format({
				user_id = 0,
				build_id = self._buildId,
				position = iter_16_7
			})
		end
	end
end

function GuildWarOperatePop:_onMemberClick(arg_17_1)
	local var_17_0 = arg_17_1:getDataValue()

	if var_17_0 and var_17_0 ~= -1 then
		local var_17_1 = self.m_memberList:getChildAt(self.m_memberList:itemIndexToChildIndex(var_17_0))

		if self._selectUserIdMap[self._curCanUpMember[var_17_0 + 1].userId] then
			var_17_1:setChoose(false)

			self._selectUserIdMap[self._curCanUpMember[var_17_0 + 1].userId] = nil
		elseif table.nums(self._selectUserIdMap) >= self._peopleNum then
			g.core.module.ModuleManager:tip(g.core.lang:get(308655))
		else
			self._selectUserIdMap[self._curCanUpMember[var_17_0 + 1].userId] = true

			var_17_1:setChoose(true)
		end

		self:updateSelectShow()
	end
end

function GuildWarOperatePop:updateSelectShow()
	local var_18_0 = {}

	if next(self._selectUserIdMap) then
		local var_18_1 = table.nums(self._selectUserIdMap)

		for iter_18_0, iter_18_1 in ipairs(self._curCanUpMember) do
			if self._selectUserIdMap[iter_18_1.userId] then
				table.insert(var_18_0, iter_18_1)

				if var_18_1 == #var_18_0 then
					break
				end
			end
		end
	end

	for iter_18_2 = 1, self._peopleNum do
		self["m_compBtn" .. iter_18_2]:updateAsMemberData(var_18_0[iter_18_2])
	end
end

function GuildWarOperatePop:_onSelectMemberRenderer(arg_19_1, arg_19_2)
	arg_19_2:updateMemberCell(self._curCanUpMember[arg_19_1 + 1])

	if self._selectUserIdMap[self._curCanUpMember[arg_19_1 + 1].userId] then
		arg_19_2:setChoose(true)
	else
		arg_19_2:setChoose(false)
	end
end

return GuildWarOperatePop
