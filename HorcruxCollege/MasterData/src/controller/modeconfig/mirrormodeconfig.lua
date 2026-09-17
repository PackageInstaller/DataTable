local playermodel = require("model.playermodel")
local model_manager = require("controller.model_manager")
local horcrux_manager = require("controller.horcrux_manager")
local component_manager = require("controller.component_manager")
local weapon_manager = require("controller.weapon_manager")
local core_manager = require("controller.core_manager")
local var_0_6 = {
	1540,
	1640,
	1740,
	1740
}
local var_0_7 = {
	30,
	0,
	-30,
	0
}

return {
	generateEnemy = function(arg_1_0)
		local var_1_0 = {}

		for iter_1_0, iter_1_1 in pairs(playermodel.curSoul) do
			local var_1_1 = {
				id = iter_1_1.fight_girl,
				majorlist = {}
			}

			var_1_1.majorlist.assist = iter_1_1.assist_girl
			var_1_1.pos = var_0_6[iter_1_0]
			var_1_1.offset = var_0_7[iter_1_0]

			table.insert(var_1_0, var_1_1)
		end

		return var_1_0
	end,
	getCreateEnemyFunc = function(arg_2_0)
		return function(arg_3_0, arg_3_1)
			local var_3_0 = model_manager.new()

			var_3_0:initPlayerAttribute(arg_3_1)

			local var_3_1 = PlayerCharacter:create(var_3_0, "enemy")

			var_3_1:initBattleAssist(horcrux_manager:getHorcruxAssistConfigWithServant(assist, core_manager:getServantCoreRank(arg_3_1)), horcrux_manager:getHorcruxItemid(assist), assist)
			var_3_1:updateComponentAttr((component_manager:getSoulComponentlist(arg_3_1)))

			if playermodel.weaponId[arg_3_1] then
				var_3_1:initWeaponSkill((weapon_manager:getWeaponConfig(playermodel.items[playermodel.weaponId[servantid]], playermodel.skill1Level[arg_3_1])))
			end

			return var_3_1
		end
	end
}
