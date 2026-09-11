local IdolTraineeStageInfoPage = class("IdolTraineeStageInfoPage", ReduxView)

function IdolTraineeStageInfoPage:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitUI()
end

function IdolTraineeStageInfoPage:InitUI()
	self:BindCfgUI()

	self.ememyItem = {}

	self:BindCfgUI(self.changeCharaGo_, self.ememyItem)
	self:AddUIListener()

	self.raceUIList_ = LuaList.New(handler(self, self.IndexRaceItem), self.advanceRace_, EnterBattleRaceListItem)
	self.styleUIList = IdolStyleTagItemList.New(self.gameObject_)
	self.stateController = self.controller:GetController("state")
	self.raceEmptyController = self.controller:GetController("raceEmpty")
	self.styleEmptyController = self.controller:GetController("styleEmpty")
end

function IdolTraineeStageInfoPage:AddUIListener()
	self:AddBtnListener(self.headbtn, nil, function()
		JumpTools.OpenPageByJump("idolTraineeBattleComparePop", {
			userID = self.curUserID_,
			friendType = self.friendType
		})
	end)
end

function IdolTraineeStageInfoPage:IndexRaceItem(arg_5_1, arg_5_2)
	arg_5_2:SetData(self.raceData_[arg_5_1])
end

function IdolTraineeStageInfoPage:IndexEnemyItem(arg_6_1, arg_6_2)
	arg_6_2:SetData(self.enemyData[arg_6_1])
end

function IdolTraineeStageInfoPage:ShowPage(arg_7_1)
	return
end

function IdolTraineeStageInfoPage:OnEnter()
	self:RefreshUI()
end

function IdolTraineeStageInfoPage:OnExit()
	return
end

function IdolTraineeStageInfoPage:RefreshUI()
	self.pvpBattle_ = self.params_.pvpBattle
	self.stageID_ = self.params_.stageID

	local var_10_0

	if self.pvpBattle_ then
		self.stageID_ = IdolTraineeData:GetCurPVPStage()
		var_10_0 = IdolTraineePvpBattleCfg[self.stageID_]

		self.stateController:SetSelectedState("pvp")
	elseif self.params_.idolCompetition then
		self.stageID_ = self.params_.stageID
		var_10_0 = IdolTraineePvpBattleCfg[self.stageID_]

		self.stateController:SetSelectedState("pvp")
	else
		var_10_0 = IdolTraineePveBattleCfg[self.stageID_]

		self.stateController:SetSelectedState("pve")

		self.friendType = IdolTraineeConst.friendType.npc
		self.ememyItem.headIcon_.sprite = DormHeroTools.GetBackHomeHeadSprite(var_10_0.npc_id)
	end

	if var_10_0 then
		self.scene_.sprite = pureGetSpriteWithoutAtlas(SpritePathCfg.IdolStageIcon.path .. IdolStageSceneCfg[var_10_0.scene_id].stage_picture)
		self.bgmName_.text = IdolStageMusicCfg[var_10_0.bgm].music_name
		self.descText_.text = var_10_0.stage_desc
		self.raceData_ = var_10_0.race_id_list
		self.styleData_ = {}

		for iter_10_0, iter_10_1 in ipairs(var_10_0.peculiarity_rate) do
			if iter_10_1 > 100 then
				table.insert(self.styleData_, iter_10_0)
			end
		end

		self.raceUIList_:StartScroll(#self.raceData_)
		self.styleUIList:SetData(self.styleData_)
		self.raceEmptyController:SetSelectedState(#self.raceData_ == 0 and "true" or "false")
		self.styleEmptyController:SetSelectedState(#self.styleData_ == 0 and "true" or "false")
	end
end

function IdolTraineeStageInfoPage:OnIdolPvpStageUpdateFromServer()
	self:RefreshUI()
end

function IdolTraineeStageInfoPage:Dispose()
	if self.raceUIList_ then
		self.raceUIList_:Dispose()

		self.raceUIList_ = nil
	end

	if self.styleUIList then
		self.styleUIList:Dispose()

		self.styleUIList = nil
	end

	self.gameObject_ = nil

	IdolTraineeStageInfoPage.super.Dispose(self)
end

return IdolTraineeStageInfoPage
