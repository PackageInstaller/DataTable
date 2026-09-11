local AbyssRankItemView = class("AbyssRankItemView", ReduxView)

function AbyssRankItemView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function AbyssRankItemView:Init()
	self:InitUI()

	self.commonPortrait_ = CommonHeadPortrait.New(self.headItem_)

	self:AddUIListener()
end

function AbyssRankItemView:InitUI()
	self:BindCfgUI()

	self.rankController_ = self.conExCollection_:GetController("rank")
end

function AbyssRankItemView:AddUIListener()
	self:AddBtnListener(self.viewBtn_, nil, function()
		local var_5_0 = {
			userId = self.data_.user_id,
			layer = self.data_.difficulty,
			stageInfos = {}
		}

		for iter_5_0, iter_5_1 in pairs(self.data_.stage_team_list) do
			local var_5_1 = {
				stage_id = iter_5_0,
				heroList = {}
			}

			for iter_5_2, iter_5_3 in pairs(iter_5_1) do
				table.insertto(var_5_1.heroList, iter_5_3)
			end

			table.insert(var_5_0.stageInfos, var_5_1)
		end

		table.sort(var_5_0.stageInfos, function(arg_6_0, arg_6_1)
			return arg_6_0.stage_id < arg_6_1.stage_id
		end)
		JumpTools.OpenPageByJump("abyssTeamCheck", {
			layerInfo = var_5_0
		})
	end)
end

function AbyssRankItemView:AddEventListeners()
	return
end

function AbyssRankItemView:SetData(arg_8_1, arg_8_2, arg_8_3)
	self.index_ = arg_8_1
	self.data_ = arg_8_2
	self.isGuild_ = arg_8_3

	self:UpdateView()
end

function AbyssRankItemView:UpdateView()
	self.commonPortrait_:RenderHead(self.data_.portrait)
	self.commonPortrait_:RenderFrame(self.data_.frame)

	if self.data_.rank < 4 then
		self.rankController_:SetSelectedIndex(self.data_.rank)
	else
		self.rankController_:SetSelectedIndex(0)
	end

	self.rankText_.text = GetI18NText(self.data_.rank)
	self.nickText_.text = GetI18NText(self.data_.nick)
	self.scoreText_.text = GetI18NText(self.data_.score)
	self.layerText_.text = GetI18NText(self.data_.difficulty)
end

function AbyssRankItemView:OnEnter()
	self:AddEventListeners()
end

function AbyssRankItemView:OnExit()
	self:RemoveAllEventListener()
end

function AbyssRankItemView:OnMainHomeViewTop()
	return
end

function AbyssRankItemView:Dispose()
	self.commonPortrait_:Dispose()

	self.data_ = nil

	AbyssRankItemView.super.Dispose(self)
end

return AbyssRankItemView
