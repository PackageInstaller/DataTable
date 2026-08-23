local WushRankCell = class("WushRankCell", require("app.fairyGUI.wush.UI_WushRankCell"))

function WushRankCell:ctor()
	self.getSharedTrans(self, "listCrossbandAUiRightIn", "LongCellFromLeft", self)
end

function WushRankCell:update(arg_2_1)
	local var_2_0, var_2_1

	if arg_2_1 then
		var_2_0 = arg_2_1.rank or 1

		if arg_2_1 then
			var_2_1 = arg_2_1.data or {}

			if var_2_0 <= 3 then
				self.m_indexRank:setCtrlState("rank", {
					index = var_2_0
				})

				goto label_2_0
			end
		end
	end

	self.m_indexRank:setCtrlState("rank", {
		index = 0
	})
	self.m_indexRank:setTitle(tostring(var_2_0))

	::label_2_0::

	self.m_numLabel:setText(var_2_1.score)

	local var_2_2 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, var_2_1.id)

	if var_2_2 then
		self.m_IconComp:updateAsUser(var_2_2)
		self.m_IconComp:setVisible(true)
		self.m_nameComp:setText(var_2_2.name)
		self.m_levelTxt:setText(g.core.lang:get(120) .. var_2_2.level)

		if var_2_2.guild_name and string.len(var_2_2.guild_name) > 0 then
			self.m_legionLabel:setText(var_2_2.guild_name)
		else
			self.m_legionLabel:setText(g.core.lang:get(300011))
		end
	else
		self.m_IconComp:setVisible(false)
		self.m_nameComp:setText("")
		self.m_levelTxt:setText("")
		self.m_legionLabel:setText("")
	end
end

return WushRankCell
