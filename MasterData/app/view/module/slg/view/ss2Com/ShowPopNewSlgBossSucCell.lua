local ShowPopNewSlgBossSucCell = class("ShowPopNewSlgBossSucCell")

function ShowPopNewSlgBossSucCell:ctor()
	self._compRank = self:getChild("Comp_rank")
	self._compName = self:getChild("Comp_name")
	self._txtLevel = self:getChild("Txt_level")
	self._txtAuthority = self:getChild("Txt_authority")
	self._txtTroop = self:getChild("Txt_troop")
	self._txtScore = self:getChild("Txt_score")
	self._showBgCtrl = self:getController("show_bg")
	self._isSelfCtrl = self:getController("is_self")
end

function ShowPopNewSlgBossSucCell:updateCell(arg_2_1)
	if not arg_2_1 then
		return
	end

	self._compRank:updateRankIndex({
		rank = arg_2_1.rank
	})
	self._showBgCtrl:setSelectedIndex(arg_2_1.rank % 2 == 0 and 1 or 0)

	local var_2_0 = arg_2_1.user
	local var_2_1 = arg_2_1.user.user_id

	self._isSelfCtrl:setSelectedIndex(arg_2_1.user.user_id == g.core.model.User:getId() and 1 or 0)
	self._txtAuthority:setText(var_2_0.team.authority or 0)
	self._txtTroop:setText(arg_2_1.damage)
	self._txtScore:setText(arg_2_1.contribute_value)

	if var_2_1 ~= 0 then
		local var_2_2 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, var_2_1)

		if var_2_2 then
			self._compName:setText(var_2_2.name)
			self._txtLevel:setText(g.core.lang:get(429006, {
				level = var_2_2.level
			}))
		end
	elseif var_2_0.robot_info_id > 0 then
		local var_2_3 = g.core.model.User.snapShotCacheData:getDataSnapShotTemplate(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, var_2_0.robot_info_id)

		self._compName:setText(var_2_3.name)
		self._txtLevel:setText(g.core.lang:get(429006, {
			level = var_2_3.level
		}))
	end
end

return ShowPopNewSlgBossSucCell
