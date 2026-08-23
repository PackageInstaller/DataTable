local WeeklyCompetitionConst = require("app.view.module.weeklyCompetition.const.WeeklyCompetitionConst")
local WeeklyCompetitionTopRankCell = class("WeeklyCompetitionTopRankCell", (require("app.fairyGUI.weeklyCompetition.UI_WeeklyCompetitionTopRankCell")))

function WeeklyCompetitionTopRankCell:ctor()
	self._roleId = 0

	self.m_iconComp:addClickListener(handler(self, self._onClickKnightIcon))

	self._user = nil

	if self.m_rankController:getSelectedIndex() == 0 then
		self.m_effFirst:addEffectSpine({
			anim = "play",
			name = "eff_ui_storm_frist",
			isLoop = true
		})
	end
end

function WeeklyCompetitionTopRankCell:setItemName(arg_2_1)
	self:getChild("n17"):setText(arg_2_1)
end

function WeeklyCompetitionTopRankCell:updateTopRankCell(arg_3_1, arg_3_2)
	if not arg_3_1 then
		return
	end

	self._params = arg_3_1

	self.m_scoreTxt:setText(arg_3_1.score, false, true)

	local var_3_0 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, arg_3_1.id)

	self._user = var_3_0

	if var_3_0 then
		self._roleId = var_3_0.id

		self.m_levelTxt:setText(g.core.lang:get(304601, {
			lv = var_3_0.level
		}))
		self.m_nameTxt:setText(var_3_0.name)

		local var_3_1 = ""

		if arg_3_2 == WeeklyCompetitionConst.SERVER_TYPE.LOCAL then
			var_3_1 = var_3_0.guild_name

			if not var_3_0.guild_name or var_3_1 == "" then
				var_3_1 = g.core.lang:get(1012)
			end
		else
			var_3_1 = var_3_0.server_name

			if not var_3_0.server_name or var_3_1 == "" then
				var_3_1 = g.core.lang:get(410326)
			end
		end

		self.m_guildNameTxt:setText(var_3_1)
		self.m_iconComp:updateAsUser(var_3_0)
		self.m_iconComp:setOverrideClick(true)
	end
end

function WeeklyCompetitionTopRankCell:_onClickKnightIcon(arg_4_1)
	if not self._params then
		return
	end

	if self:checkIsSelf() then
		g.core.module.ModuleManager:pushModule(g.view.entrance.PLAYER_INFO, {
			isSelf = true
		})
	else
		local var_4_0

		if arg_4_1 then
			var_4_0 = {}

			local var_4_1 = arg_4_1:getInput():getTouch()

			var_4_0.x = var_4_1:getLocationInView().x
			var_4_0.y = var_4_1:getLocationInView().y
		end

		local var_4_2 = self:_checkAndGetPopInfo(self._user)

		var_4_2.clickWorldPos = var_4_0

		self:addPopup(require("app.view.base.infoPop.InfoUserMenuPop").new(var_4_2), {
			isUpdateBlack = false,
			hideContinue = true
		})
	end
end

function WeeklyCompetitionTopRankCell:checkIsSelf()
	if not self._roleId then
		return false
	end

	return math.uint64_equal(self._roleId, g.core.model.User:getId())
end

function WeeklyCompetitionTopRankCell:_checkAndGetPopInfo(arg_6_1)
	local var_6_0 = {}
	local var_6_1 = {
		user = clone(arg_6_1)
	}

	if var_6_1.user.guild_id and var_6_1.user.guild_id == 0 then
		var_6_1.user.guild_id = -1
	end

	var_6_0.playerInfo = var_6_1

	return var_6_0
end

return WeeklyCompetitionTopRankCell
