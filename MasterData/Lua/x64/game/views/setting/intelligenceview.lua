local IntelligenceView = class("IntelligenceView", ReduxView)

function IntelligenceView:SetActive(arg_1_1)
	if self.gameObject_ then
		SetActive(self.gameObject_, arg_1_1)
	end
end

function IntelligenceView:Ctor(arg_2_1, arg_2_2, arg_2_3)
	self.hander_ = arg_2_1
	self.transform_ = arg_2_2.transform
	self.gameObject_ = arg_2_2
	self.info_ = arg_2_3[1]

	self:Init()
end

function IntelligenceView:RefreshData(arg_3_1, arg_3_2)
	self.data_ = arg_3_1
	self.info_ = arg_3_2

	self:RefreshUI()
end

function IntelligenceView:InitUI()
	self:BindCfgUI()

	self.missions_ = {}

	for iter_4_0 = 1, 3 do
		self.missions_[iter_4_0] = {
			go = self[string.format("mission%dGo_", iter_4_0)],
			on = self[string.format("mission%dOnGo_", iter_4_0)],
			off = self[string.format("mission%dOffGo_", iter_4_0)],
			name = self[string.format("mission%dNameText_", iter_4_0)],
			progress = self[string.format("mission%dNumText_", iter_4_0)],
			progressGo = self[string.format("mission%dNumText_", iter_4_0)].gameObject
		}
	end
end

function IntelligenceView:AddUIListener()
	return
end

function IntelligenceView:Init()
	self:InitUI()
	self:AddUIListener()
	self:OnEnter()
end

function IntelligenceView:UpdateAllMission(arg_7_1)
	for iter_7_0 = 1, 3 do
		if arg_7_1 and arg_7_1[iter_7_0] then
			self.missions_[iter_7_0].name.text = BattleInstance.GetStarMissionText(arg_7_1[iter_7_0].id, arg_7_1[iter_7_0].xData, arg_7_1[iter_7_0].yData)

			local var_7_2 = BattleStageData:GetStageData()[self.info_.section]
			local var_7_3 = not not (var_7_2 and var_7_2.stars and var_7_2.stars[iter_7_0] == 1)

			SetActive(self.missions_[iter_7_0].on, arg_7_1[iter_7_0].isComplete or var_7_3)
			SetActive(self.missions_[iter_7_0].off, not arg_7_1[iter_7_0].isComplete and not var_7_3)

			self.missions_[iter_7_0].progress.text = var_7_3 and "-/-" or string.format("%d/%d", arg_7_1[iter_7_0].current, arg_7_1[iter_7_0].total)

			SetActive(self.missions_[iter_7_0].go, true)
		else
			SetActive(self.missions_[iter_7_0].go, false)
		end
	end
end

function IntelligenceView:SetLevelTitle(arg_8_1)
	local var_8_0 = arg_8_1:GetStageId()
	local var_8_1 = arg_8_1:GetType()
	local var_8_2, var_8_3 = BattleStageTools.GetChapterSectionIndex(var_8_1, var_8_0)

	self.titleText_.text = var_8_2 ~= "" and string.format("%s-%s", GetI18NText(var_8_2), GetI18NText(var_8_3)) or ""
	self.nameText_.text = BattleStageTools.GetStageName(var_8_1, var_8_0)
end

function IntelligenceView:RefreshUI()
	self:SetLevelTitle(self.info_.stageData)
	self:UpdateAllMission(self.info_.starMissionData)
end

function IntelligenceView:OnEnter()
	self:RefreshUI()
end

function IntelligenceView:OnExit()
	return
end

function IntelligenceView:Dispose()
	self.info_ = nil
	self.hander_ = nil

	IntelligenceView.super.Dispose(self)
end

return IntelligenceView
