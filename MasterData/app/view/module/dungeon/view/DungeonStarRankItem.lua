local var_0_0 = g.core.lang
local var_0_1 = g.core.model.User
local DungeonStarRankItem = class("DungeonStarRankItem", require("app.fairyGUI.dungeon.UI_DungeonStarRankItem"))

function DungeonStarRankItem:updateRankCell(arg_1_1, arg_1_2, arg_1_3)
	self.m_bgColorController:setSelectedIndex(arg_1_3 % 2 == 0 and 0 or 1)
	self.m_rankComp:updateRankIndex({
		rank = arg_1_1.rank
	})
	self.m_starLabel:setText(arg_1_1.score)

	local var_1_0 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, arg_1_1.id)

	if var_1_0 then
		self.m_nameText:setText(var_1_0.name)

		local var_1_1 = {}

		var_1_1.level = var_1_0.level or 0

		self.m_levelTxt:setText(var_0_0:get(300023, var_1_1))
		self.m_guildLabel:setText(var_1_0.guild_name and string.len(var_1_0.guild_name) > 0 and var_1_0.guild_name or var_0_0:get(300011))

		if arg_1_2 == arg_1_1.rank then
			self.m_iconComp:updateAsUser(var_0_1:packUser())
		else
			self.m_iconComp:updateAsUser(var_1_0)
		end

		self.m_iconComp:setVisible(true)
	else
		self.m_nameText:setText("")
		self.m_levelTxt:setText("")
		self.m_guildLabel:setText("")
		self.m_iconComp:setVisible(false)
	end
end

return DungeonStarRankItem
