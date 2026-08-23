local var_0_0 = g.core.const.ConstMgr.NewSlgConst
local NewSlgPvcRankTopComp = class("NewSlgPvcRankTopComp")

function NewSlgPvcRankTopComp:ctor()
	self:getChild("Comp_Eff"):addEffect({
		name = "effect_wdzy_diyiming"
	})
	self:addClickListener(handler(self, self.onRankClick))
end

function NewSlgPvcRankTopComp:updateRankView(arg_2_1, arg_2_2)
	self._rankType = arg_2_2

	if arg_2_2 == 1 then
		self:getChild("Comp_rank"):updateRankIndex({
			rank = arg_2_1.rank
		})
		self:getChild("Txt_score"):setText(arg_2_1.score)

		self._user = arg_2_1.user

		self:getChild("Txt_name"):updateQualityTxtForce({
			isDark = true,
			quality = g.core.common.Goods:convertUserSnapshot({
				snapshot = arg_2_1.user
			}).quality,
			text = arg_2_1.user.name
		})
		self:getChild("Txt_commandValue"):setText(arg_2_1.param)
		self:setCtrlState("type", {
			index = 0
		})
	else
		if arg_2_2 == 5 then
			self:setCtrlState("type", {
				index = 2
			})
		else
			self:setCtrlState("type", {
				index = 1
			})
		end

		self:getChild("Comp_rank"):updateRankIndex({
			rank = arg_2_1.rank
		})

		local var_2_0 = g.core.common.GlobalFunc.rankUnit_param(arg_2_1.param, "NewSlgAlliRankData", true)

		self:getChild("Txt_Unionname"):setText(var_2_0.name)
		self:getChild("Txt_AlliScore"):setText(var_2_0.score)

		self._rankData = arg_2_1
		self._alliId = var_2_0.id

		self:getChild("Txt_leaderName"):updateQualityTxtForce({
			isDark = true,
			quality = g.core.common.Goods:convert({
				type = g.core.common.Goods.TYPE_KNIGHT,
				value = var_2_0.leader_user.base_id
			}).quality,
			text = var_2_0.leader_user.name
		})

		if var_2_0.occupied_city_id and var_2_0.occupied_city_id > 0 then
			local var_2_1 = g.core.config.new_slg_city_info.get(var_2_0.occupied_city_id)

			if var_2_1.type == var_0_0.CITY_TYPE.INFINITE_DRAGON then
				if arg_2_2 == var_0_0.RANK_TYPE.FINAL_DRAGON then
					self:getChild("Txt_cityName"):setText(g.core.lang:get(428900))
				else
					self:getChild("Txt_cityName"):setText(var_2_1.name)
				end
			else
				self:getChild("Txt_cityName"):setText(g.core.lang:get(428899, {
					level = var_2_1.level,
					name = var_2_1.name
				}))
			end
		end
	end
end

function NewSlgPvcRankTopComp:onAlliIconClick()
	if self._alliId then
		g.core.module.ModuleManager:pushModule(g.view.entrance.ALLIANCE_INFO, {
			id = self._alliId
		})
	end
end

function NewSlgPvcRankTopComp:onRankClick()
	if self._rankType == 1 then
		self:_onUserIconClick()
	else
		self:onAlliIconClick()
	end
end

function NewSlgPvcRankTopComp:_onUserIconClick()
	if not self._user then
		return
	end

	if self._user.id == g.core.model.User:getId() then
		g.core.module.ModuleManager:tip(g.core.lang:get(429011))
	elseif self._user.is_robot then
		g.core.module.ModuleManager:tip(g.core.lang:get(428979))
	else
		g.core.module.ModuleManager:pushModule(g.view.entrance.NEW_SLG_PLAYER_INFO, {
			uid = self._user.id
		})
	end
end

return NewSlgPvcRankTopComp
