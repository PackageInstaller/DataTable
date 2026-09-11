local MatrixRankView = class("MatrixRankView", ReduxView)

function MatrixRankView:UIName()
	return "UI/Matrix/Main/MatrixRankUI"
end

function MatrixRankView:UIParent()
	return manager.ui.uiMain.transform
end

function MatrixRankView:Init()
	self:InitUI()
	self:AddListeners()

	self.rankTypeController = ControllerUtil.GetController(self.m_rankTypeController, "toggle")
end

function MatrixRankView:InitUI()
	self:BindCfgUI()

	self.list_ = LuaList.New(handler(self, self.IndexItem), self.m_list, MatrixRankItem)
end

function MatrixRankView:AddListeners()
	self:AddBtnListener(self.m_guildBtn, nil, function()
		self:SelectRankType(MatrixConst.MatirxRankType.GUILD)
	end)
	self:AddBtnListener(self.m_allBtn, nil, function()
		self:SelectRankType(MatrixConst.MatirxRankType.ALL)
	end)
end

function MatrixRankView:SelectRankType(arg_8_1)
	if self.rankType == arg_8_1 then
		return
	end

	self:Refresh(arg_8_1)
end

function MatrixRankView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
end

function MatrixRankView:OnUpdate()
	self:Refresh(self.params_.type)
end

function MatrixRankView:OnEnter()
	self:RefreshGuildRankGo()
	RankAction.QueryCommonRank(RankConst.RANK_ID.MATRIX)

	local var_11_0 = GuildData:GetGuildInfo()

	if var_11_0 and var_11_0.id ~= nil and var_11_0.id ~= 0 then
		RankAction.QueryGuildCommonRank(RankConst.RANK_ID.MATRIX)
	end

	self:Refresh(self.params_.type)
end

function MatrixRankView:OnExit()
	manager.windowBar:HideBar()
end

function MatrixRankView:Refresh(arg_13_1)
	self.rankType = arg_13_1

	if self.rankType == MatrixConst.MatirxRankType.ALL then
		local var_13_0 = RankData:GetCommonRank(RankConst.RANK_ID.MATRIX)

		if var_13_0 then
			self.rankList = var_13_0.rankList or {}
		end

		if var_13_0 then
			local var_13_1, var_13_2 = var_13_0:GetCurRankDes()

			self.m_rank.text = var_13_1
			self.m_score.text = var_13_2
		else
			self.m_rank.text = ""
			self.m_score.text = ""
		end
	else
		local var_13_3 = RankData:GetGuildCommonRank(RankConst.RANK_ID.MATRIX)

		if var_13_3 then
			self.rankList = var_13_3.rankList or {}
		end

		if var_13_3 then
			local var_13_4, var_13_5 = var_13_3:GetCurRankDes()

			self.m_rank.text = var_13_4
			self.m_score.text = var_13_5
		else
			self.m_rank.text = ""
			self.m_score.text = ""
		end
	end

	self.list_:StartScroll(#self.rankList)

	local var_13_6 = PlayerData:GetPlayerInfo()

	self.m_icon.sprite = ItemTools.getItemSprite(var_13_6 and var_13_6.portrait)
	self.m_frame.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Frame/" .. var_13_6.icon_frame)

	self.rankTypeController:SetSelectedIndex(self.rankType - 1)
end

function MatrixRankView:RefreshNone()
	self.m_rank.text = GetTips("MATRIX_RANK_NO_RANK")
	self.m_score.text = GetTips("MATRIX_RANK_NO_INFO")
end

function MatrixRankView:IndexItem(arg_15_1, arg_15_2)
	arg_15_2:Refresh(self.rankList[arg_15_1])
end

function MatrixRankView:Dispose()
	self.list_:Dispose()
	MatrixRankView.super.Dispose(self)

	self.refreshGuildHandler_ = nil
end

function MatrixRankView:RefreshGuildRankGo()
	if GuildData:GetGuildInfo().id == nil then
		SetActive(self.m_guildGo, false)
	else
		SetActive(self.m_guildGo, true)
	end
end

function MatrixRankView:OnRankUpdate()
	self:Refresh(self.rankType)
end

return MatrixRankView
