DormOverviewModuleBase = import("game.views.dorm.DormView.Information.Module.overview.DormOverviewModuleBase")

local DormOverviewDormitoryModule = class("DormOverviewDormitoryModule", DormOverviewModuleBase)

function DormOverviewDormitoryModule:ModuleName()
	return "Widget/BackHouseUI/Dorm/item/Infomation/overview/dormitoryPanel"
end

function DormOverviewDormitoryModule:InitUI()
	self:BindCfgUI()
	self:InitView()
end

function DormOverviewDormitoryModule:InitView()
	self.items = {}

	for iter_3_0 = 1, 5 do
		table.insert(self.items, DormInfomationHeroItem.New(self["heroItem" .. iter_3_0]))
		self.items[iter_3_0]:RegistCallBack(function(arg_4_0)
			self:OnHolderHeroItemClick(arg_4_0)
		end)
	end
end

function DormOverviewDormitoryModule:RegisterEvents()
	self:RegistEventListener(BACKHOME_CATEEN_FEED_SUCCESS, handler(self, self.OnFeedSuccess))
	self:RegistEventListener(BACKHOME_HERO_FATIGUR_REFRESH, handler(self, self.Render))
end

function DormOverviewDormitoryModule:OnFeedSuccess()
	ShowTips(GetTips("BACKHOME_FEED_SUCCESS"))
	self:Render()
end

function DormOverviewDormitoryModule:OnHolderHeroItemClick(arg_7_1)
	JumpTools.OpenPageByJump("/dormInfomationTrainSetHeroView", {
		state = "dorm"
	})
end

function DormOverviewDormitoryModule:Render()
	local var_8_0 = {}

	for iter_8_0, iter_8_1 in pairs((DormData:GetHeroInfoList())) do
		if iter_8_1:GetHeroState() == DormEnum.DormHeroState.InPublicDorm then
			table.insert(var_8_0, iter_8_1.hero_id)
		end
	end

	for iter_8_2 = 1, 5 do
		if var_8_0[iter_8_2] then
			self.items[iter_8_2]:SetData({
				heroID = var_8_0[iter_8_2]
			})
		else
			self.items[iter_8_2]:SetData(nil)
		end
	end
end

function DormOverviewDormitoryModule:Dispose()
	for iter_9_0 = 1, 5 do
		self.items[iter_9_0]:Dispose()
	end

	self.items = nil

	DormOverviewDormitoryModule.super.Dispose(self)
end

return DormOverviewDormitoryModule
