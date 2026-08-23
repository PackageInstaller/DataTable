local PetStruct = require("app.view.module.pet.model.PetStruct")
local var_0_1 = g.core.config.knight_info
local KnightStruct = require("app.view.module.knight.model.KnightStruct")
local var_0_3 = g.core.const.ConstMgr.LineUpConst
local ObtBattleTeamComp = class("ObtBattleTeamComp", require("app.fairyGUI.debug.UI_ObtBattleTeamComp"))

function ObtBattleTeamComp:ctor()
	return
end

function ObtBattleTeamComp:updateBattleTeam(arg_2_1)
	if not arg_2_1 then
		self:setVisible(false)

		return
	end

	self:setVisible(true)
	self.m_userComp:updateUser(arg_2_1.user)

	local var_2_0 = arg_2_1.units or {}

	for iter_2_0 = 1, var_0_3.MAX_KNIGHT_NUM do
		if var_2_0[iter_2_0] then
			local var_2_1 = var_0_1.get(var_2_0[iter_2_0].id)
			local var_2_2 = KnightStruct.new(var_2_1.advance_id)

			var_2_2:addCfgInfo(var_2_1)
			var_2_2:setIsOtherUser(true, arg_2_1.user.name or "")
			self["m_knightIcon" .. iter_2_0]:setVisible(true)
			self["m_knightIcon" .. iter_2_0]:updateIcon({
				isOthers = true,
				type = g.core.common.Goods.TYPE_KNIGHT,
				struct = var_2_2,
				star = var_2_1.star
			})
			self["m_knightIcon" .. iter_2_0]:setStar(var_2_0[iter_2_0].star)
			self["m_knightIcon" .. iter_2_0]:setAdvanceLevel(var_2_0[iter_2_0].advance_level)
		else
			self["m_knightIcon" .. iter_2_0]:setVisible(false)
		end
	end

	local var_2_4 = (arg_2_1.combo or {}).tokens or {}

	for iter_2_1 = 1, var_0_3.MAX_UNITE_TOKEN_NUM do
		if var_2_4[iter_2_1] then
			self["m_unite" .. iter_2_1]:updateIcon({
				skillId = var_2_4[iter_2_1]
			})
			self["m_unite" .. iter_2_1]:openClick()
			self["m_unite" .. iter_2_1]:setVisible(true)
		else
			self["m_unite" .. iter_2_1]:setVisible(false)
		end
	end

	local var_2_5 = arg_2_1.pets or {}

	for iter_2_2 = 1, 6 do
		if var_2_5[iter_2_2] then
			local var_2_6 = g.core.config.pet_info.get(var_2_5[iter_2_2])
			local var_2_7 = PetStruct.new(var_2_6.advance_id)

			var_2_7:setServerData({
				base_id = var_2_5[iter_2_2]
			})
			self["m_pet" .. iter_2_2]:updateIcon({
				struct = var_2_7
			})
			self["m_pet" .. iter_2_2]:setStar(var_2_6.star)
			self["m_pet" .. iter_2_2]:setVisible(true)
		else
			self["m_pet" .. iter_2_2]:setVisible(false)
		end
	end
end

return ObtBattleTeamComp
