local BattleSummaryCell = class("BattleSummaryCell", require("app.fairyGUI.battleResult.UI_BattleSummaryCell"))

function BattleSummaryCell:ctor()
	return
end

function BattleSummaryCell:update(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	if arg_2_1[1] then
		self.m_group1:setVisible(true)

		local var_2_0

		self.m_showStateController:setSelectedIndex(0)

		if arg_2_1[1].type == 2 then
			self.m_name1:setText(g.core.config.unite_token_info.get(arg_2_1[1].id).name)
			self.m_iconComp1:updateIcon({
				overrideClick = true,
				type = g.core.common.Goods.TYPE_UNITETOKEN,
				value = arg_2_1[1].id
			})
		elseif arg_2_1[1].type == 3 then
			self.m_name1:setText(g.core.config.pet_info.get(arg_2_1[1].id).name)
			self.m_iconComp1:updateIcon({
				overrideClick = true,
				type = g.core.common.Goods.TYPE_PET,
				value = arg_2_1[1].id
			})
		elseif arg_2_1[1].type == 6 then
			self.m_name1:setText(g.core.config.succuba_info.get(arg_2_1[1].id).name)
			self.m_iconComp1:updateIcon({
				overrideClick = true,
				type = g.core.common.Goods.TYPE_SUCCUBA,
				value = arg_2_1[1].id
			})
		elseif arg_2_1[1].type == 7 then
			local var_2_1 = g.core.config.skill_info.get(arg_2_1[1].id)

			self.m_name1:setText(var_2_1.curtain_name)
			self.m_showStateController:setSelectedIndex(1)
			self.m_iconLoader:setURL(g.core.common.Path:getSkillIconById(var_2_1.icon))
		else
			local var_2_2

			if arg_2_1[1].avartar_id then
				var_2_2 = g.core.config.knight_info.get(arg_2_1[1].id)

				if var_2_2.type == 1 then
					if arg_2_3 == 1 then
						if arg_2_2.own_name then
							self.m_name1:setText(arg_2_2.own_name)
						end
					elseif arg_2_2.enemy_name then
						self.m_name1:setText(g.core.lang:get(arg_2_2.enemy_name))
					end

					var_2_0 = require("app.view.module.knight.model.KnightStruct").new(arg_2_1[1].id)
					arg_2_1[1].base_id = arg_2_1[1].id
					arg_2_1[1].skin = arg_2_1[1].avartar_id
					arg_2_1[1].skin_ts = 0

					var_2_0:onlySetInfo(arg_2_1[1])
					var_2_0:onlyAddCfgInfo((g.core.config.knight_info.get(arg_2_1[1].id)))
				else
					self.m_name1:setText(var_2_2.name)
				end
			else
				var_2_2 = self:getCellCfg(arg_2_1[1].id, arg_2_4)

				if not var_2_2 then
					var_2_2 = self:getCellCfg((var_2_2 or nil) and (var_2_2.advance_id or arg_2_1[1].id), arg_2_4)

					if var_2_2 then
						if g.core.config.knight_info.get(var_2_2.advance_id or arg_2_1[1].id).type == 1 then
							self.m_name1:setText(arg_2_2.own_name)

							goto label_2_0
						end
					end
				end

				self.m_name1:setText(var_2_2.name)
			end

			::label_2_0::

			if arg_2_1[1].avartar_id then
				local var_2_4 = {
					overrideClick = true,
					type = g.core.common.Goods.TYPE_KNIGHT,
					value = arg_2_1[1].id
				}

				if var_2_0 then
					var_2_4.struct = var_2_0
					var_2_4.iconCompName = "BaseKnightIcon"
				end

				if var_2_2.type == 1 then
					var_2_4.dressId = arg_2_1[1].avartar_id
				else
					var_2_4.skin = arg_2_1[1].avartar_id
				end

				self.m_iconComp1:updateIcon(var_2_4)
			else
				local var_2_5 = {
					type = g.core.common.Goods.TYPE_KNIGHT
				}

				var_2_5.icon = g.core.common.Path:getKnightIconById(g.core.config.knight_base_info.get(var_2_2.res_id).icon_id)
				var_2_5.name = var_2_2.name
				var_2_5.quality = var_2_2.quality
				var_2_5.advanceId = var_2_2.advance_id

				self.m_iconComp1:updateByGoods(var_2_5)
			end
		end

		local var_2_6 = self.m_dam1Pb

		self.m_dam1Pb:setMax(arg_2_1.dtotal[1])
		var_2_6:setValue(arg_2_1[1].dam or 0)
		var_2_6:getChild("numTxt"):setText(arg_2_1[1].dam or 0)
		self.m_takeDam1Pb:setMax(arg_2_1.ttotal[1])
		self.m_takeDam1Pb:setValue(arg_2_1[1].take_dam or 0)
		self.m_takeDam1Pb:getChild("numTxt"):setText(arg_2_1[1].take_dam or 0)
		self.m_recover1Pb:setMax(arg_2_1.rtotal[1])
		self.m_recover1Pb:setValue(arg_2_1[1].recover or 0)
		self.m_recover1Pb:getChild("numTxt"):setText(arg_2_1[1].recover or 0)
	else
		self.m_group1:setVisible(false)
	end
end

function BattleSummaryCell:getCellCfg(arg_3_1, arg_3_2)
	if arg_3_2 then
		local var_3_0 = g.core.config.monster_info.fetch(arg_3_1)

		if not var_3_0 then
			return g.core.config.knight_info.get(arg_3_1)
		end

		return var_3_0
	else
		local var_3_1 = g.core.config.knight_info.fetch(arg_3_1)

		if not var_3_1 then
			return g.core.config.monster_info.get(arg_3_1)
		end

		return var_3_1
	end
end

return BattleSummaryCell
