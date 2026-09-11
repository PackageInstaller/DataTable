local SummerWaterBattleStatisticsHeroItem = class("SummerWaterBattleStatisticsHeroItem", ReduxView)

function SummerWaterBattleStatisticsHeroItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function SummerWaterBattleStatisticsHeroItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function SummerWaterBattleStatisticsHeroItem:InitUI()
	self:BindCfgUI()

	self.haveHeroController = ControllerUtil.GetController(self.transform_, "haveHero")
	self.reportController = ControllerUtil.GetController(self.transform_, "report")
	self.cooperationController = ControllerUtil.GetController(self.transform_, "cooperation")
	self.friendController = ControllerUtil.GetController(self.transform_, "friend")
	self.thumbController = ControllerUtil.GetController(self.transform_, "thumb")
	self.showThumbController = ControllerUtil.GetController(self.transform_, "showThumb")
	self.offlineController = ControllerUtil.GetController(self.transform_, "offline")
	self.isThumbsUp = false
	self.isReport = false
end

function SummerWaterBattleStatisticsHeroItem:AddUIListener()
	self:AddBtnListener(self.reportBtn_, nil, function()
		ShowMessageBox({
			isTop = true,
			title = GetTips("PROMPT"),
			content = GetTips("ACTIVITY_STRONGHOLD_CONFIRM_REPORT_TIPS"),
			OkCallback = function()
				self.isReport = true

				self.reportController:SetSelectedIndex(2)
				CooperationAction.CooperationReport(self.player_id, (BattleFieldData:GetServerBattleID()))
			end
		})
	end)
	self:AddBtnListener(self.addFriendBtn_, nil, function()
		if not FriendsData:IsCanBeFriend(self.player_id) then
			return
		end

		FriendsAction:TryToRequestToFriend(self.player_id, FriendConst.ADD_FRIEND_SOURCE.COOPERATION_RESULT)
	end)
	self:AddBtnListener(self.thumbsBtn_, nil, function()
		self.isThumbsUp = true

		CooperationAction.ThumbsUp(self.player_id)
	end)
end

function SummerWaterBattleStatisticsHeroItem:SetData(arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	if arg_9_1 and arg_9_3 then
		self.battleCountDamageNum_.text = tostring(arg_9_3.damage)
		self.battleCountCureNum_.text = tostring(arg_9_3.cure)
		self.battleCountHurtNum_.text = tostring(arg_9_3.hurt)
		self.battleCountDamageImg_.enabled = int64.equals(arg_9_4.damage, arg_9_3.damage) and arg_9_4.damage > int64.zero
		self.battleCountCureNumImg_.enabled = int64.equals(arg_9_4.cure, arg_9_3.cure) and arg_9_4.cure > int64.zero
		self.battleCountHurtNumImg_.enabled = int64.equals(arg_9_4.hurt, arg_9_3.hurt) and arg_9_4.hurt > int64.zero
		self.player_id = arg_9_1.playerID
		self.nickText_.text = arg_9_1.nick
		self.battleCountLv_.text = arg_9_2.level
		self.battleCountIcon_.sprite = getSpriteViaConfig("HeroIcon", SkinCfg[(arg_9_2.skin == 0 or nil) and (arg_9_2.id or arg_9_2.skin)].picture_id)

		self.haveHeroController:SetSelectedState("true")
	else
		self.haveHeroController:SetSelectedState("false")
	end

	self:RefreshState()
end

function SummerWaterBattleStatisticsHeroItem:SetIsCooperation(arg_10_1)
	self.isCooperation_ = arg_10_1
end

function SummerWaterBattleStatisticsHeroItem:SetCaptain(arg_11_1)
	SetActive(self.captainGo_, arg_11_1)
end

function SummerWaterBattleStatisticsHeroItem:SetCustomStaticData(arg_12_1)
	self.staticData_ = arg_12_1.dataDic
	self.maxData_ = ActivitySummerWaterData:GetSettleMaxData(ActivitySummerWaterData:GetMainActivityID())
	self.battleCountFangfanNum_.text = self.staticData_[45] or 0

	local var_12_0 = int64.equals(self.maxData_[45] or 0, self.staticData_[45])

	var_12_0 = var_12_0 and self.maxData_[45] > 0
	self.battleCountFangfanImg_.enabled = var_12_0
	self.battleCountZjjNum_.text = self.staticData_[59] or 0

	local var_12_1 = int64.equals(self.maxData_[59] or 0, self.staticData_[59])

	var_12_1 = var_12_1 and self.maxData_[59] > 0
	self.battleCountZjjImg_.enabled = var_12_1
end

function SummerWaterBattleStatisticsHeroItem:RefreshState()
	if PlayerData:GetPlayerInfo().userID == self.player_id or not self.isCooperation_ then
		self.cooperationController:SetSelectedState("false")
	else
		self.cooperationController:SetSelectedState("true")

		if self.isThumbsUp then
			self.thumbController:SetSelectedState("false")
		else
			self.thumbController:SetSelectedState("true")
		end

		if self.isReport then
			self.reportController:SetSelectedState("false")
		else
			self.reportController:SetSelectedState("true")
		end
	end

	self:RefreshThumb()
end

function SummerWaterBattleStatisticsHeroItem:RefreshThumb()
	local var_14_0 = CooperationData:GetRoomData()

	if var_14_0 then
		local var_14_1 = var_14_0:GetBeLikedPlayerIds(self.player_id) or {}

		if #var_14_1 > 0 then
			local var_14_2

			for iter_14_0, iter_14_1 in ipairs(var_14_1) do
				local var_14_3 = var_14_0:GetRoomPlayerData(iter_14_1)

				if var_14_3 then
					var_14_2 = var_14_2 == nil and var_14_3.nick or var_14_2 .. "," .. var_14_3.nick
				end
			end

			self.thumbsUpLabText_.text = var_14_2 or ""

			if PlayerData:GetPlayerInfo().userID == self.player_id or self.isThumbsUp then
				self.showThumbController:SetSelectedState("true")
			else
				self.showThumbController:SetSelectedState("false")
			end
		else
			self.showThumbController:SetSelectedState("false")
		end
	else
		self.showThumbController:SetSelectedState("false")
	end
end

return SummerWaterBattleStatisticsHeroItem
