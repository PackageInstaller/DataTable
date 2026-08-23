local DailyReportRankComp = class("DailyReportRankComp", require("app.fairyGUI.dailyReport.UI_DailyReportRankComp"))
local var_0_1 = g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER
local var_0_2 = g.core.model.User.snapShotCacheData
local DailyReportConst = require("app.view.module.dailyReport.const.DailyReportConst")
local var_0_4 = g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.GUILD

function DailyReportRankComp:ctor()
	self._userId = 0
	self._snapshot = nil
end

function DailyReportRankComp:onShowPlayerInfo()
	if self._userId and self._userId ~= 0 then
		g.core.module.ModuleManager:pushModule(g.view.entrance.PLAYER_INFO, {
			uid = self._userId
		})
	end
end

function DailyReportRankComp:updateComp(arg_3_1, arg_3_2, arg_3_3)
	if arg_3_1 then
		if arg_3_1.user then
			self._snapshot = arg_3_1.user
			self._userId = arg_3_1.user.id
		else
			self._userId = arg_3_1.id

			if arg_3_3 == DailyReportConst.RANK_TYPE.USER then
				self._snapshot = var_0_2:getSnapShot(var_0_1, self._userId)
			elseif arg_3_3 == DailyReportConst.RANK_TYPE.GUILD then
				self._snapshot = var_0_2:getSnapShot(var_0_4, self._userId)
			end
		end

		if self:getChild("rankTxt") then
			self:getChild("rankTxt"):setText(arg_3_2)
		end

		if self._userId == 0 then
			if self:getController("empty") then
				self:getController("empty"):setSelectedIndex(0)
			end

			return
		end

		if self:getController("empty") then
			self:getController("empty"):setSelectedIndex(1)
		end

		if self._snapshot then
			if self:getChild("playerIcon") then
				self:getChild("playerIcon"):updateAsUser(self._snapshot)
				self:getChild("playerIcon"):setTouchCallFunc(handler(self, self.onShowPlayerInfo))
			end

			if self:getChild("nameTxt") then
				self:getChild("nameTxt"):setText(self._snapshot.name)
			end

			if self:getChild("svrNameTxt") then
				self:getChild("svrNameTxt"):setText(self._snapshot.server_name)
			end

			if self:getChild("fightValueTxt") then
				self:getChild("fightValueTxt"):setText(self._snapshot.fight_value)
			end

			if self:getChild("knightComp") then
				self:getChild("knightComp"):setIcon(g.core.common.Path:getKnightBookPicRes((self._snapshot.show_knight_dress ~= 0 or nil) and (self._snapshot.show_knight_dress or self._snapshot.show_knight_id)))

				if not self._addClickListener then
					self._addClickListener = true

					self:getChild("knightComp"):addClickListener(handler(self, self.onShowPlayerInfo))
				end
			end

			if self:getChild("knightHeadIcon") then
				self:getChild("knightHeadIcon"):setOverrideClick(true)
				self:getChild("knightHeadIcon"):updateAsUser(self._snapshot)

				if not self._addClickListener then
					self._addClickListener = true

					self:getChild("knightHeadIcon"):addClickListener(handler(self, self.onShowPlayerInfo))
				end
			end
		end

		if self:getController("rank") then
			self:getController("rank"):setSelectedIndex(arg_3_2 - 1)
		end
	elseif self:getController("empty") then
		self:getController("empty"):setSelectedIndex(0)
	end
end

return DailyReportRankComp
