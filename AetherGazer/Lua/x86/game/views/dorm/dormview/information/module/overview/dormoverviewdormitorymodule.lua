DormOverviewModuleBase = import("game.views.dorm.DormView.Information.Module.overview.DormOverviewModuleBase")

local var_0_0 = class("DormOverviewDormitoryModule", DormOverviewModuleBase)

function var_0_0.ModuleName(arg_1_0)
	return "Widget/BackHouseUI/Dorm/item/Infomation/overview/dormitoryPanel"
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:InitView()
end

function var_0_0.InitView(arg_3_0)
	arg_3_0.items = {}

	for iter_3_0 = 1, 5 do
		table.insert(arg_3_0.items, DormInfomationHeroItem.New(arg_3_0["heroItem" .. iter_3_0]))
		arg_3_0.items[iter_3_0]:RegistCallBack(function(arg_4_0)
			arg_3_0:OnHolderHeroItemClick(arg_4_0)
		end)
	end
end

function var_0_0.RegisterEvents(arg_5_0)
	arg_5_0:RegistEventListener(BACKHOME_CATEEN_FEED_SUCCESS, handler(arg_5_0, arg_5_0.OnFeedSuccess))
	arg_5_0:RegistEventListener(BACKHOME_HERO_FATIGUR_REFRESH, handler(arg_5_0, arg_5_0.Render))
end

function var_0_0.OnFeedSuccess(arg_6_0)
	ShowTips(GetTips("BACKHOME_FEED_SUCCESS"))
	arg_6_0:Render()
end

function var_0_0.OnHolderHeroItemClick(arg_7_0, arg_7_1)
	JumpTools.OpenPageByJump("/dormInfomationTrainSetHeroView", {
		state = "dorm"
	})
end

function var_0_0.Render(arg_8_0)
	local var_8_0 = DormData:GetHeroInfoList()
	local var_8_1 = {}

	for iter_8_0, iter_8_1 in pairs(var_8_0) do
		if iter_8_1:GetHeroState() == DormEnum.DormHeroState.InPublicDorm then
			table.insert(var_8_1, iter_8_1.hero_id)
		end
	end

	for iter_8_2 = 1, 5 do
		if var_8_1[iter_8_2] then
			arg_8_0.items[iter_8_2]:SetData({
				heroID = var_8_1[iter_8_2]
			})
		else
			arg_8_0.items[iter_8_2]:SetData(nil)
		end
	end
end

function var_0_0.Dispose(arg_9_0)
	for iter_9_0 = 1, 5 do
		arg_9_0.items[iter_9_0]:Dispose()
	end

	arg_9_0.items = nil

	var_0_0.super.Dispose(arg_9_0)
end

return var_0_0
