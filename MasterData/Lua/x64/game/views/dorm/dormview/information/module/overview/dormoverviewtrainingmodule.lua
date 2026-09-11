DormOverviewModuleBase = import("game.views.dorm.DormView.Information.Module.overview.DormOverviewModuleBase")

local DormOverviewTrainingModule = class("DormOverviewTrainingModule", DormOverviewModuleBase)

function DormOverviewTrainingModule:ModuleName()
	return "Widget/BackHouseUI/Dorm/item/Infomation/overview/trainingPanel"
end

function DormOverviewTrainingModule:InitUI()
	self:BindCfgUI()
	self:AddListener()
	self:InitView()
end

function DormOverviewTrainingModule:InitView()
	self.items = {}

	for iter_3_0 = 1, 5 do
		table.insert(self.items, DormInfomationHeroItem.New(self["heroItem" .. iter_3_0]))
		self.items[iter_3_0]:RegistCallBack(function(arg_4_0)
			self:OnHeroItemClick(arg_4_0)
		end)
	end
end

function DormOverviewTrainingModule:OnHeroItemClick(arg_5_1)
	JumpTools.OpenPageByJump("/dormInfomationTrainSetHeroView", {
		state = "train"
	})
end

function DormOverviewTrainingModule:AddListener()
	self:AddBtnListener(self.goBtn_, nil, function()
		BackHomeTools:GotoBackHomeRoom(nil, true, nil, function()
			return
		end)
	end)
	self:AddBtnListener(self.imgGoBtn_, nil, function()
		IdolTraineeData:SetLastJumpContext({
			trainView = true,
			backToDormInfo = true
		})
		BackHomeTools:GotoBackHomeRoom(nil, true)
	end)
end

function DormOverviewTrainingModule:RegisterEvents()
	self:RegistEventListener(BACKHOME_HERO_FATIGUR_REFRESH, handler(self, self.Render))
end

function DormOverviewTrainingModule:Render()
	local var_11_0 = IdolTraineeData:GetHeroPosList()

	for iter_11_0 = 1, 5 do
		if var_11_0[iter_11_0] then
			self.items[iter_11_0]:SetData({
				heroID = var_11_0[iter_11_0]
			})
		else
			self.items[iter_11_0]:SetData(nil)
		end
	end

	local var_11_1 = IdolTraineeTools:GetCurTrainMaxTimes()

	self.todayTimes_.text = var_11_1 - IdolTraineeData:GetCurTrainTimes() .. "/" .. var_11_1
end

function DormOverviewTrainingModule:Dispose()
	for iter_12_0 = 1, 5 do
		self.items[iter_12_0]:Dispose()
	end

	self.items = nil

	DormOverviewTrainingModule.super.Dispose(self)
end

return DormOverviewTrainingModule
