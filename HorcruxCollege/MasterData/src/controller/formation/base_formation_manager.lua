local BaseFormationManager = class("BaseFormationManager", (require("controller.base_manager")))

BaseFormationManager.MULTITON_MSG = "BaseFormationManager instancealready constructed!"

function BaseFormationManager:ctor()
	BaseFormationManager.super.ctor(self)

	self._formationInfo = {}
	self._curFormationIndex = nil
end

function BaseFormationManager:setConfigType(arg_2_1)
	self.configType = arg_2_1
end

function BaseFormationManager:setCurFormationIndex(arg_3_1)
	self._curFormationIndex = arg_3_1
end

function BaseFormationManager:updateLayer()
	if self.layer then
		self.layer:updateLayer()
	end
end

function BaseFormationManager:updateRed()
	if self.layer then
		self.layer:updateRed()
	end
end

function BaseFormationManager:updateGirlSuccess(arg_6_1)
	if self.layer then
		self.layer:updateGirlSuccess(arg_6_1)
	end
end

function BaseFormationManager:updateGirl()
	if self.layer then
		self.layer:updateGirl()
	end
end

function BaseFormationManager:requestModeInfo(arg_8_1, arg_8_2, arg_8_3)
	require("network.network"):rpc("get_adventure_battlearray", {
		mode = arg_8_1,
		defaultIndex = arg_8_2
	}, function(arg_9_0)
		if arg_9_0.result == 1 then
			self:handlerInfo(arg_9_0)

			if arg_8_3 then
				arg_8_3(arg_9_0)
			end
		end
	end)
end

function BaseFormationManager:requestUpdateModeFightGirl(arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	local var_10_0 = self:getFormationInfo()[1] or {}

	if arg_10_3 then
		for iter_10_0 = 1, #var_10_0 do
			if var_10_0[iter_10_0].fight_girl == arg_10_3 then
				arg_10_4({
					result = 4
				})

				return
			end
		end
	end

	require("network.network"):rpc("update_adventure_array_fightgirl", {
		mode = arg_10_1,
		pos = arg_10_2,
		servantid = arg_10_3
	}, function(arg_11_0)
		if arg_11_0.result == 1 then
			self:updateFormationInfo(arg_11_0.array)
			self:updateGirl()

			if arg_10_4 then
				arg_10_4(arg_11_0)
			end

			self:playVoiceById(arg_10_3)
		end
	end)
end

function BaseFormationManager:requestUpdateModeAssistGirl(arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	require("network.network"):rpc("update_adventure_array_assistgirl", {
		mode = arg_12_1,
		pos = arg_12_2,
		assistgirl = arg_12_3
	}, function(arg_13_0)
		if arg_13_0.result == 1 then
			self:updateFormationInfo(arg_13_0.array)

			if arg_12_4 then
				arg_12_4(arg_13_0)
			end
		end
	end)
end

function BaseFormationManager:oneTimeUpdateSuccess()
	if self.layer then
		self.layer:oneTimeUpdateSuccess()
	end
end

function BaseFormationManager:requestInfo(arg_15_1)
	return
end

function BaseFormationManager:handlerInfo(arg_16_1)
	return
end

function BaseFormationManager:updateFormationInfo(arg_17_1)
	return
end

function BaseFormationManager:getCurFormationIndex()
	self._curFormationIndex = self._curFormationIndex or 1

	return self._curFormationIndex
end

function BaseFormationManager:getFormationInfo()
	return self._formationInfo
end

function BaseFormationManager:requestOneTimeUpdateArray(arg_20_1, arg_20_2)
	return
end

function BaseFormationManager:getAdvanceForcesOneTimeArray()
	local playermodel = require("model.playermodel")
	local var_21_1 = {}

	for iter_21_0, iter_21_1 in pairs(playermodel.arrays[playermodel.curArray]) do
		if type(iter_21_1) == "table" then
			var_21_1[iter_21_0] = iter_21_1
		end
	end

	return var_21_1
end

function BaseFormationManager:fastEquipmentParts(arg_22_1)
	local playermodel = require("model.playermodel")
	local item_manager = require("controller.item_manager")
	local item_data = require("data.item_data")
	local var_22_3 = {}

	for iter_22_0, iter_22_1 in pairs(arg_22_1) do
		table.insert(var_22_3, clone(iter_22_1))

		if iter_22_1.componentList then
			var_22_3[#var_22_3].componentList = {}

			for iter_22_2, iter_22_3 in pairs(iter_22_1.componentList) do
				table.insert(var_22_3[#var_22_3].componentList, iter_22_3)
			end
		end
	end

	for iter_22_4, iter_22_5 in pairs(playermodel.items) do
		if iter_22_5.itemtype == kITEM_WEAPON and arg_22_1[item_data[iter_22_5.itemid].servant] and not playermodel.items[playermodel.weaponId[item_data[iter_22_5.itemid].servant]] then
			for iter_22_6, iter_22_7 in pairs(var_22_3) do
				if iter_22_7.servantid == item_data[iter_22_5.itemid].servant then
					iter_22_7.weaponEntityid = iter_22_4

					break
				end
			end
		end
	end

	require("network.network"):rpc("servant_equip_one_key", {
		list = var_22_3
	}, function(arg_23_0)
		if arg_23_0.result == 1 then
			local var_23_0 = false

			for iter_23_0 = 1, #arg_23_0.list do
				if arg_23_0.list[iter_23_0].componentResult then
					for iter_23_1 = 1, #arg_23_0.list[iter_23_0].componentResult do
						if arg_23_0.list[iter_23_0].componentResult[iter_23_1].result == 1 then
							var_23_0 = true

							if arg_22_1[arg_23_0.list[iter_23_0].servantid].componentList and arg_22_1[arg_23_0.list[iter_23_0].servantid].componentList[arg_23_0.list[iter_23_0].componentResult[iter_23_1].pos] then
								playermodel.component[arg_23_0.list[iter_23_0].servantid] = playermodel.component[arg_23_0.list[iter_23_0].servantid] or {}
								playermodel.items[arg_22_1[arg_23_0.list[iter_23_0].servantid].componentList[arg_23_0.list[iter_23_0].componentResult[iter_23_1].pos].entityid].component_attr.use = arg_23_0.list[iter_23_0].servantid

								item_manager:remove_bag_weight(playermodel.items[arg_22_1[arg_23_0.list[iter_23_0].servantid].componentList[arg_23_0.list[iter_23_0].componentResult[iter_23_1].pos].entityid].itemid, 1)

								playermodel.component[arg_23_0.list[iter_23_0].servantid][arg_23_0.list[iter_23_0].componentResult[iter_23_1].pos] = {
									pos = arg_23_0.list[iter_23_0].componentResult[iter_23_1].pos,
									id = arg_22_1[arg_23_0.list[iter_23_0].servantid].componentList[arg_23_0.list[iter_23_0].componentResult[iter_23_1].pos].entityid
								}
							end
						end
					end

					if var_23_0 then
						if playermodel:isSoulInFight(arg_23_0.list[iter_23_0].servantid) then
							FightManager.registerPlayerChangeComponent()
							cc.Director:getInstance():getEventDispatcher():dispatchEvent(cc.EventCustom:new("syncFightPower"))
						end

						AlertManager:check_component_update(false)
					end
				end

				if arg_23_0.list[iter_23_0].weaponResult == 1 then
					local var_23_3

					for iter_23_2 = 1, #var_22_3 do
						if var_22_3[iter_23_2].servantid == arg_23_0.list[iter_23_0].servantid then
							var_23_3 = var_22_3[iter_23_2].weaponEntityid

							break
						end
					end

					playermodel.items[var_23_3].weapon_attr.use = arg_23_0.list[iter_23_0].servantid
					playermodel.weaponId[arg_23_0.list[iter_23_0].servantid] = var_23_3

					if playermodel:isSoulInFight(arg_23_0.list[iter_23_0].servantid) then
						FightManager.registerPlayerChangeWeaponSkill()
						cc.Director:getInstance():getEventDispatcher():dispatchEvent(cc.EventCustom:new("syncFightPower"))
					end

					require("controller.alert_manager"):check_weapon_update(false)
					AnalyticManager.replace_role_weapon({
						servantid = arg_23_0.list[iter_23_0].servantid
					})
				end
			end

			if var_23_0 and self.layer then
				self.layer:fastEquipmentPartsSuccess()
			end
		end
	end)
end

function BaseFormationManager:playVoiceById(arg_24_1)
	local var_24_1
	local audio_manager

	if not arg_24_1 then
		do return end

		audio_manager = require("controller.audio_manager")
		var_24_1 = GenerateRoleConversationClass(require("data.servant_data")[arg_24_1].modelid, ROLE_CONVERSATION_TYPE.fight)
	end

	for iter_24_0, iter_24_1 in pairs((require("data.role_conversation_data"))) do
		if iter_24_1.classification == var_24_1 and iter_24_1.sound then
			audio_manager:stopAllRoleSound()
			audio_manager:playPlayerSound("sound/role_voice/" .. iter_24_1.sound)

			break
		end
	end
end

function BaseFormationManager:playVoiceByArray(arg_25_1, arg_25_2)
	local role_conversation_data = require("data.role_conversation_data")
	local servant_data = require("data.servant_data")
	local audio_manager = require("controller.audio_manager")
	local var_25_3 = {}
	local var_25_4 = {}

	for iter_25_0, iter_25_1 in pairs(arg_25_1) do
		if tonumber(iter_25_0) then
			table.insert(var_25_3, iter_25_1)
		end
	end

	table.sort(var_25_3, function(arg_26_0, arg_26_1)
		return arg_26_0.pos < arg_26_1.pos
	end)

	for iter_25_2, iter_25_3 in pairs(arg_25_2) do
		if tonumber(iter_25_2) then
			table.insert(var_25_4, iter_25_3)
		end
	end

	table.sort(var_25_4, function(arg_27_0, arg_27_1)
		return arg_27_0.pos < arg_27_1.pos
	end)

	for iter_25_4 = 1, #var_25_3 do
		local var_25_5 = false

		for iter_25_5 = 1, #var_25_4 do
			if var_25_3[iter_25_4].pos == var_25_4[iter_25_5].pos and var_25_4[iter_25_4].fight_girl and var_25_3[iter_25_4].fight_girl ~= var_25_4[iter_25_4].fight_girl then
				local var_25_6 = GenerateRoleConversationClass(servant_data[var_25_4[iter_25_4].fight_girl].modelid, ROLE_CONVERSATION_TYPE.fight)

				for iter_25_6, iter_25_7 in pairs(role_conversation_data) do
					if iter_25_7.classification == var_25_6 and iter_25_7.sound then
						audio_manager:stopAllRoleSound()
						audio_manager:playPlayerSound("sound/role_voice/" .. iter_25_7.sound)

						var_25_5 = true

						break
					end
				end
			end

			if var_25_5 then
				break
			end
		end

		if var_25_5 then
			break
		end
	end
end

function BaseFormationManager:selectWeapon(arg_28_1)
	local playermodel = require("model.playermodel")
	local item_data = require("data.item_data")
	local var_28_2 = self:getFormationInfo()

	if var_28_2 and var_28_2[self._curFormationIndex] and var_28_2[self._curFormationIndex][arg_28_1] then
		local var_28_3 = var_28_2[self._curFormationIndex][arg_28_1].fight_girl

		if var_28_2[self._curFormationIndex][arg_28_1].fight_girl then
			if playermodel.items[playermodel.weaponId[var_28_2[self._curFormationIndex][arg_28_1].fight_girl]] then
				LayerManager:pushInLayer("PopWeaponUpLevelList", {
					entityid = playermodel.weaponId[var_28_2[self._curFormationIndex][arg_28_1].fight_girl]
				})
			else
				local weapon_manager = require("controller.weapon_manager")

				if weapon_manager:checkIsCanReplaceBetter(var_28_2[self._curFormationIndex][arg_28_1].fight_girl) then
					local var_28_5

					for iter_28_0, iter_28_1 in pairs(playermodel.items) do
						if iter_28_1.itemtype == kITEM_WEAPON and item_data[iter_28_1.itemid].servant == var_28_2[self._curFormationIndex][arg_28_1].fight_girl then
							var_28_5 = iter_28_0
						end
					end

					local var_28_6 = require("controller.model_manager").new()

					var_28_6:initPlayerAttribute(var_28_2[self._curFormationIndex][arg_28_1].fight_girl)

					local var_28_7, var_28_8 = require("controller.component_manager"):getSoulComponentlist(var_28_2[self._curFormationIndex][arg_28_1].fight_girl)

					var_28_6:updateComponentAttr(var_28_7)

					if playermodel.haveServant[var_28_2[self._curFormationIndex][arg_28_1].fight_girl] and playermodel.weaponId[var_28_2[self._curFormationIndex][arg_28_1].fight_girl] then
						var_28_6:updateWeaponAttr((weapon_manager:getWeaponConfig(playermodel.items[playermodel.weaponId[var_28_2[self._curFormationIndex][arg_28_1].fight_girl]])))
					end

					require("controller.fight_capacity_manager"):saveSoulAttr(var_28_2[self._curFormationIndex][arg_28_1].fight_girl, var_28_6)
					weapon_manager:replaceRoleWeapon(var_28_2[self._curFormationIndex][arg_28_1].fight_girl, var_28_5, function(arg_29_0)
						if arg_29_0 == 1 then
							LayerManager:pushInLayer("WeaponBreakAnimationLayer", {
								servantId = var_28_3
							})
						end
					end)
				else
					LayerManager:pushInLayer("PopItemLayer", {
						itemid = require("data.servant_data")[var_28_2[self._curFormationIndex][arg_28_1].fight_girl].recommend_weapon2
					})
				end
			end
		end
	end
end

return BaseFormationManager
