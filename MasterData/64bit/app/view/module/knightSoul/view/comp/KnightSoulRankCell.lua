local KnightSoulRankCell = class("KnightSoulRankCell", require("app.fairyGUI.knightSoul.UI_KnightSoulRankCell"))

function KnightSoulRankCell:ctor()
	self.getSharedTrans(self, "enter_left", "CommonLongCellList", self)
end

function KnightSoulRankCell:updateRankCell(arg_2_1, arg_2_2, arg_2_3)
	self.m_rankIndexComp:updateRankIndex({
		rank = arg_2_3
	})

	if arg_2_1.id then
		local var_2_0 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, arg_2_1.id, true)

		if var_2_0 then
			self.m_hasRankController:setSelectedIndex(0)
			self.m_headComp:updateAsUser(var_2_0)
			self.m_nameTxt:setText(var_2_0.name)
			self.m_bookNum:setText(var_2_0.ksoul_book_num)
			self.m_honorNum:setText(arg_2_1.score)
			self.m_belongNameTxt:setText(arg_2_2 == 0 and (var_2_0.guild_name and string.len(var_2_0.guild_name) > 0 and var_2_0.guild_name or g.core.lang:get(1012)) or self:getServerNameBySid(var_2_0.sid))
		else
			self.m_hasRankController:setSelectedIndex(1)
		end
	else
		self.m_hasRankController:setSelectedIndex(1)
	end

	self.m_haveBgController:setSelectedIndex(arg_2_3 % 2 ~= 0 and 1 or 0)
end

function KnightSoulRankCell:getServerNameBySid(arg_3_1)
	for iter_3_0, iter_3_1 in ipairs(g.core.platform.ServerListProxy:getServerList() or {}) do
		if iter_3_1.id == arg_3_1 then
			return iter_3_1.name
		end
	end

	return ""
end

return KnightSoulRankCell
