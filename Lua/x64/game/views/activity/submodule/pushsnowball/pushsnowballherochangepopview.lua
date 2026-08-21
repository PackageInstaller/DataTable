local var_0_0 = class("PushSnowBallHeroChangePopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/IndiaUI_2_8/IndiaPushTheSnowballUI/PushTheSnowballRoleChangePopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.heroDataList_ = PushSnowBallData:GetHeroDataList()
	arg_4_0.heroItemList_ = {}
	arg_4_0.heroControllerList_ = {}

	for iter_4_0 = 1, 4 do
		if arg_4_0.heroDataList_[iter_4_0] then
			local var_4_0 = ControllerUtil.GetController(arg_4_0["heroItem" .. iter_4_0].transform, "toggle")

			arg_4_0["heroIcon" .. iter_4_0].sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/IndiaUI_2_8/snowballPortrait/" .. arg_4_0.heroDataList_[iter_4_0])

			arg_4_0:AddBtnListener(arg_4_0["heroItem" .. iter_4_0], nil, function()
				arg_4_0.selectIndex_ = iter_4_0

				arg_4_0:RefreshController()
			end)
			table.insert(arg_4_0.heroItemList_, arg_4_0["heroItem" .. iter_4_0])
			table.insert(arg_4_0.heroControllerList_, var_4_0)
		end
	end
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.maskBtn_, nil, function()
		arg_6_0:Back()
	end)
	arg_6_0:AddBtnListener(arg_6_0.changeBtn_, nil, function()
		PushSnowBallData:SetSelectedHeroIndex(arg_6_0.selectIndex_)
		PushSnowBallGameMgr.GetInstance():SetPlayer(PushSnowBallData:GetSelectedHeroID())
		arg_6_0:Back()
	end)
end

function var_0_0.OnEnter(arg_9_0)
	arg_9_0.selectIndex_ = PushSnowBallData:GetSelectedHeroIndex()

	arg_9_0:RefreshController()
end

function var_0_0.RefreshController(arg_10_0)
	for iter_10_0, iter_10_1 in ipairs(arg_10_0.heroControllerList_) do
		if arg_10_0.selectIndex_ == iter_10_0 then
			iter_10_1:SetSelectedState("on")
		else
			iter_10_1:SetSelectedState("off")
		end
	end
end

return var_0_0
