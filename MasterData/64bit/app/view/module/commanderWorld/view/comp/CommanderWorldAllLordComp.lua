local var_0_0 = {
	[2] = {
		[1] = "pic_zz_2_1.png",
		[2] = "pic_zz_2_2.png"
	},
	[3] = {
		[1] = "pic_zz_3_1.png",
		[2] = "pic_zz_3_2.png"
	},
	[4] = {
		[1] = "pic_zz_4_1.png",
		[2] = "pic_zz_4_2.png"
	}
}
local var_0_1 = g.core.const.ConstMgr.SpineConst
local var_0_2 = g.core.model.User.commanderWorldData
local var_0_3 = g.core.const.ConstMgr.CommanderWorldConst
local CommanderWorldAllLordComp = class("CommanderWorldAllLordComp", require("app.fairyGUI.commanderWorld.UI_CommanderWorldAllLordComp"))

function CommanderWorldAllLordComp:ctor()
	for iter_1_0 = 1, 3 do
		self["m_playInfoLoader" .. iter_1_0]:addClickListener(handler(self, self._onClickPlayer))
		self["m_getAwardBtn" .. iter_1_0]:addClickListener(handler(self, self._onClickGetAward))
	end

	self._userSnapList = nil
end

function CommanderWorldAllLordComp:updateRankLordComp(arg_2_1)
	self._type = arg_2_1
	self._marsRankDatas = var_0_2:getCommanderMarsRankInfo(arg_2_1)
	self._userSnapList = {}

	for iter_2_0 = 1, 3 do
		if iter_2_0 <= #self._marsRankDatas then
			local var_2_0 = self._marsRankDatas[iter_2_0]
			local var_2_1 = var_0_2:getGuildAwardNum()
			local var_2_2 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, self._marsRankDatas[iter_2_0].id)

			self._userSnapList[iter_2_0] = var_2_2

			if var_2_2 then
				if self._type == var_0_3.SERVER_TYPE.LOCAL then
					self._genre = var_0_3.REWARDTYPE.LOCALSERVICEPERSONAL
				elseif self._type == var_0_3.SERVER_TYPE.CROSS then
					self._genre = var_0_3.REWARDTYPE.LOCALSERVICEPUBLIC
					var_2_1 = var_0_2:getServerAwardNum()
				end

				local var_2_3 = g.core.config.knight_info.fetch(var_2_2.base_id)

				if var_2_3 then
					local var_2_4 = g.core.config.knight_base_info.get(var_2_3.advance_id)
					local var_2_5 = self["m_knightPicComp" .. iter_2_0]

					self["m_knightPicComp" .. iter_2_0]:getController("isEmpty"):setSelectedIndex(0)

					local var_2_6 = {
						scale = 0.9
					}

					if var_2_2.show_knight_dress > 0 then
						var_2_6.resId = var_2_2.show_knight_dress or var_2_2.show_knight_id
					end

					var_2_5:updateKnight(var_2_6)
					var_2_5:setType(false, "ui_cocos/storm/" .. var_0_0[3][iter_2_0 > 1 and 2 or 1], iter_2_0 > 1 and 2 or 1)
					var_2_5:setAlphaRect(var_0_1.MASK_TYPE.HORIZON, cc.rect(-300, 0, 400, 0), 200)
				end

				self["m_playerInfoComp" .. iter_2_0]:updateKnight(var_2_2)

				self._rewardHasGot = var_2_1 >= 3 and true or var_0_2:getMarsRewardInfo(self._type, var_2_0.rank) == 1

				if not self._rewardHasGot then
					local var_2_7 = iter_2_0 > 1 and 2 or 1

					self["m_getAwardBtn" .. iter_2_0]:setVisible(true)
					self["m_getAwardBtn" .. iter_2_0]:removeAllEffect()
					self["m_getAwardBtn" .. iter_2_0]:addEffectSpine({
						name = "eff_ui_commanderworld_rewardsbox",
						isLoop = true,
						anim = "play_" .. var_2_7,
						x = self["m_getAwardBtn" .. iter_2_0]:getWidth() / 2,
						y = self["m_getAwardBtn" .. iter_2_0]:getHeight() / 2
					})
				else
					self["m_getAwardBtn" .. iter_2_0]:setVisible(false)
				end
			else
				self:setEmptyKnight(iter_2_0)
			end
		else
			self:setEmptyKnight(iter_2_0)
		end
	end
end

function CommanderWorldAllLordComp:setEmptyKnight(arg_3_1)
	self["m_knightPicComp" .. arg_3_1]:getController("isEmpty"):setSelectedIndex(1)
	self["m_playInfoLoader" .. arg_3_1]:setVisible(false)
	self["m_knightPicComp" .. arg_3_1]:getChild("firstImg"):setVisible(false)
	self["m_playerInfoComp" .. arg_3_1]:setVisible(false)
	self["m_getAwardBtn" .. arg_3_1]:setVisible(false)
end

function CommanderWorldAllLordComp:_onClickGetAward(arg_4_1)
	local var_4_0 = arg_4_1:getSender():getName()
	local var_4_1 = self._marsRankDatas[tonumber(string.sub(var_4_0, #var_4_0))]

	if var_4_1 and var_4_1.id then
		g.core.network.GameNetProxy:send_C2S_OrderWorld_MarsAward({
			genre = self._genre,
			rank = var_4_1.rank,
			rank_user_id = var_4_1.id
		})
	end
end

function CommanderWorldAllLordComp:_onClickPlayer(arg_5_1)
	local var_5_0 = arg_5_1:getSender():getName()
	local var_5_1 = self._marsRankDatas[tonumber(string.sub(var_5_0, #var_5_0))]

	if var_5_1 and var_5_1.id then
		g.core.module.ModuleManager:pushModule(g.view.entrance.PLAYER_INFO, {
			uid = var_5_1.id
		})
	end
end

return CommanderWorldAllLordComp
