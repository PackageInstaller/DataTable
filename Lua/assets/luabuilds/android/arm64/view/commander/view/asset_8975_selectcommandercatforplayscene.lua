local SelectCommanderCatForPlayScene = class("SelectCommanderCatForPlayScene", import(".CommanderCatScene"))

function SelectCommanderCatForPlayScene:emit(...)
	if unpack({
		...
	}) == SelectCommanderCatForPlayScene.ON_BACK then
		SelectCommanderCatForPlayScene.super.emit(self, SelectCommanderCatForPlayScene.ON_CLOSE)
	else
		SelectCommanderCatForPlayScene.super.emit(self, ...)
	end

	return
end

function SelectCommanderCatForPlayScene:didEnter()
	local var_2_0 = self.contextData.activeCommander

	self.contextData.mode = SelectCommanderCatForPlayScene.MODE_SELECT
	self.contextData.maxCount = 10
	self.contextData.fleetType = CommanderCatScene.FLEET_TYPE_COMMON
	self.contextData.activeGroupId = self.contextData.activeCommander.groupId
	self.contextData.ignoredIds = {}

	table.insert(self.contextData.ignoredIds, self.contextData.activeCommander.id)
	self:CollectIgnoredIdsForPlay(self.contextData.ignoredIds)

	function self.contextData.onCommander(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
		return self:IsLegalForPlay(var_2_0, arg_3_0, arg_3_1, arg_3_2)
	end

	SelectCommanderCatForPlayScene.super.didEnter(self)

	return
end

function SelectCommanderCatForPlayScene:RegisterEvent()
	SelectCommanderCatForPlayScene.super.RegisterEvent(self)
	self:bind(CommanderCatDockPage.ON_SORT, function(arg_5_0)
		onNextTick(function()
			if self.pages[CommanderCatScene.PAGE_DOCK] and self.pages[CommanderCatScene.PAGE_DOCK]:GetLoaded() then
				if self.contextData.OnSort then
					self.contextData.OnSort((Clone(self.pages[CommanderCatScene.PAGE_DOCK].sortData)))
				end
			end

			return
		end)

		return
	end)

	return
end

function SelectCommanderCatForPlayScene:CollectIgnoredIdsForPlay(arg_7_1)
	for iter_7_0, iter_7_1 in pairs((getProxy(CommanderProxy):getRawData())) do
		if iter_7_1:isLocked() then
			table.insert(arg_7_1, iter_7_1.id)
		end
	end

	local var_7_0 = getProxy(ChapterProxy):getActiveChapter()

	if var_7_0 then
		_.each(var_7_0.fleets, function(arg_8_0)
			for iter_8_0, iter_8_1 in pairs((arg_8_0:getCommanders())) do
				table.insert(arg_7_1, iter_8_1.id)
			end

			return
		end)
	end

	return
end

function SelectCommanderCatForPlayScene:IsLegalForPlay(arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	if nowWorld():CheckCommanderInFleet(arg_9_2.id) then
		local var_9_1 = i18n("commander_is_in_bigworld")

		return
	end

	if arg_9_1:isMaxLevel() and not arg_9_1:isSameGroup(arg_9_2.groupId) then
		local var_9_3 = i18n("commander_select_matiral_erro")

		return
	end

	if getProxy(CommanderProxy):IsHome(arg_9_2.id) then
		local var_9_5 = i18n("cat_sleep_notplay")

		return
	end

	if not self:CheckFormation(arg_9_2, arg_9_4, arg_9_3) then
		return false, nil
	end

	if not self:CheckGuild(arg_9_2, arg_9_4, arg_9_3) then
		return false, nil
	end

	if not self:CheckExtra(arg_9_2, arg_9_4, arg_9_3) then
		return false, nil
	end

	if not self:CheckFullExp(arg_9_1, arg_9_2) and not arg_9_1:isSameGroup(arg_9_2.groupId) then
		local var_9_7 = i18n("commander_exp_limit")

		return
	end

	return true
end

function SelectCommanderCatForPlayScene:SimulateAddCommanderExp(arg_10_1, arg_10_2)
	local var_10_0 = Clone(arg_10_1)

	var_10_0:addExp(arg_10_2)

	return var_10_0, arg_10_1
end

function SelectCommanderCatForPlayScene:CheckFullExp(arg_11_1, arg_11_2)
	local var_11_1, var_11_2 = CommanderCatUtil.GetSkillExpAndCommanderExp(arg_11_1, (self.pages[CommanderCatScene.PAGE_DOCK] and self.pages[CommanderCatScene.PAGE_DOCK].selectedList or nil) and self.pages[CommanderCatScene.PAGE_DOCK].selectedList)

	if self:SimulateAddCommanderExp(arg_11_1, var_11_1):isMaxLevel() then
		return false
	end

	return true
end

function SelectCommanderCatForPlayScene:CheckFormation(arg_12_1, arg_12_2, arg_12_3)
	local var_12_0 = getProxy(FleetProxy)
	local var_12_1 = var_12_0:getCommanders()
	local var_12_2 = _.detect(var_12_1, function(arg_13_0)
		return arg_12_1.id == arg_13_0.commanderId
	end)

	if not var_12_2 then
		return true
	end

	self.contextData.msgBox:ExecuteAction("Show", {
		content = i18n("commander_material_is_in_fleet_tip"),
		onYes = function()
			pg.m02:sendNotification(GAME.COOMMANDER_EQUIP_TO_FLEET, {
				commanderId = 0,
				fleetId = var_12_2.fleetId,
				pos = var_12_2.pos,
				callback = function()
					var_12_1 = var_12_0:getCommanders()

					if arg_12_2 then
						arg_12_2()
					end

					return
				end
			})

			return
		end,
		onNo = arg_12_3,
		onClose = arg_12_3
	})

	return false
end

function SelectCommanderCatForPlayScene:CheckGuild(arg_16_1, arg_16_2, arg_16_3)
	local var_16_0 = getProxy(GuildProxy):getRawData()

	if not var_16_0 or not var_16_0:ExistCommander(arg_16_1.id) then
		return true
	end

	self.contextData.msgBox:ExecuteAction("Show", {
		content = i18n("commander_is_in_guild"),
		onYes = function()
			local var_17_0 = var_16_0:GetActiveEvent()

			if not var_17_0 then
				return
			end

			local var_17_1 = var_17_0:GetBossMission()

			if not var_17_1 or not var_17_1:IsActive() then
				return
			end

			local var_17_2 = var_17_1:GetFleetCommanderId(arg_16_1.id)

			if not var_17_2 then
				return
			end

			local var_17_3 = Clone(var_17_2)
			local var_17_4 = var_17_3:GetCommanderPos(arg_16_1.id)

			if not var_17_4 then
				return
			end

			var_17_3:RemoveCommander(var_17_4)
			pg.m02:sendNotification(GAME.GUILD_UPDATE_BOSS_FORMATION, {
				force = true,
				editFleet = {
					[var_17_3.id] = var_17_3
				},
				callback = arg_16_2
			})

			return
		end,
		onNo = arg_16_3,
		onClose = arg_16_3
	})

	return false
end

function SelectCommanderCatForPlayScene:CheckExtra(arg_18_1, arg_18_2, arg_18_3)
	local var_18_0 = getProxy(FleetProxy)
	local var_18_1 = var_18_0:getCommanders()
	local var_18_2 = _.detect(var_18_0:GetExtraCommanders(), function(arg_19_0)
		return arg_18_1.id == arg_19_0.commanderId
	end)

	if not var_18_2 then
		return true
	end

	self.contextData.msgBox:ExecuteAction("Show", {
		content = i18n("commander_material_is_in_fleet_tip"),
		onYes = function()
			pg.m02:sendNotification(GAME.COOMMANDER_EQUIP_TO_FLEET, {
				commanderId = 0,
				fleetId = var_18_2.fleetId,
				pos = var_18_2.pos,
				callback = function()
					var_18_1 = var_18_0:getCommanders()

					if arg_18_2 then
						arg_18_2()
					end

					return
				end
			})

			return
		end,
		onNo = arg_18_3,
		onClose = arg_18_3
	})

	return false
end

return SelectCommanderCatForPlayScene
