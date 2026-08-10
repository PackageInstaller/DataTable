local var_0_0 = class("AdminCatExploreRegionItem", ReduxView)
local var_0_1 = {
	"I",
	"II",
	"III",
	"IV",
	"V"
}

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_2

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.stateController = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "state")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.exploreBtn_, nil, function()
		local var_5_0 = arg_4_0.stateController:GetSelectedState()

		if var_5_0 == "normal" then
			JumpTools.OpenPageByJump("adminCatExplorePop", {
				regionId = arg_4_0.regionId
			})
		elseif var_5_0 == "finish" then
			AdminCatExploreAction.AdminCatExploreFinish(arg_4_0.regionId)
		elseif var_5_0 == "exploring" then
			JumpTools.OpenPageByJump("adminCatExploringPop", {
				regionId = arg_4_0.regionId
			})
		elseif var_5_0 == "lock" then
			ShowTips("ERROR_EXPLORE_LV_LIMIT")
		end
	end)
end

function var_0_0.SetData(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.getGo = arg_6_1
	arg_6_0.index = arg_6_2
	arg_6_0.regionId = AdminCatExploreData:GetRegionIdByIndex(arg_6_0.index)
end

function var_0_0.UpdateBar(arg_7_0)
	return
end

function var_0_0.UpdateView(arg_8_0)
	if arg_8_0.updateTimer_ then
		arg_8_0.updateTimer_:Stop()

		arg_8_0.updateTimer_ = nil
	end

	arg_8_0.level = AdminCatExploreData:GetDataByPara("level")

	local var_8_0 = ExploreAreaCfg[arg_8_0.regionId]

	arg_8_0.regionData = AdminCatExploreData:GetDataByPara("regionData")[arg_8_0.regionId]
	arg_8_0.regionUnlockLevel = AdminCatExploreData:GetDataByPara("regionUnlockLevel")

	if arg_8_0.regionUnlockLevel[arg_8_0.regionId] and arg_8_0.level < arg_8_0.regionUnlockLevel[arg_8_0.regionId] then
		arg_8_0.stateController:SetSelectedState("lock")

		arg_8_0.lockTxt_.text = string.format(GetTips("EXPLORE_DEBLOCKING_LEVEL"), var_0_1[arg_8_0.regionUnlockLevel[arg_8_0.regionId]])
	elseif arg_8_0.regionData then
		if arg_8_0.regionData.stopTime > manager.time:GetServerTime() then
			local var_8_1 = math.max(0, arg_8_0.regionData.stopTime - manager.time:GetServerTime())

			arg_8_0.remainTxt_.text = manager.time:DescCDTime(var_8_1)
			arg_8_0.fillImg_.fillAmount = 1 - var_8_1 / (arg_8_0.regionData.stopTime - arg_8_0.regionData.startTime)
			arg_8_0.updateTimer_ = Timer.New(function()
				var_8_1 = math.max(0, arg_8_0.regionData.stopTime - manager.time:GetServerTime())
				arg_8_0.remainTxt_.text = manager.time:DescCDTime(var_8_1)
				arg_8_0.fillImg_.fillAmount = 1 - var_8_1 / (arg_8_0.regionData.stopTime - arg_8_0.regionData.startTime)

				if var_8_1 <= 0 then
					SetActive(arg_8_0.getGo, true)
					AdminCatExploreData:UpdateRegionRedPoint()
					arg_8_0.stateController:SetSelectedState("finish")

					arg_8_0.stateText_.text = GetTips("EXPLORE_REGION_FINISH")

					arg_8_0.updateTimer_:Stop()

					arg_8_0.updateTimer_ = nil
				end
			end, 1, var_8_1, 1)

			arg_8_0.updateTimer_:Start()
			arg_8_0.stateController:SetSelectedState("exploring")

			arg_8_0.stateText_.text = GetTips("EXPLORE_REGION_EXPLORING")
		else
			arg_8_0.getFill_.fillAmount = 1

			SetActive(arg_8_0.getGo, true)

			arg_8_0.remainTxt_.text = manager.time:DescCDTime(0)

			arg_8_0.stateController:SetSelectedState("finish")

			arg_8_0.stateText_.text = GetTips("EXPLORE_REGION_FINISH")
		end
	else
		arg_8_0.fillImg_.fillAmount = 0

		arg_8_0.stateController:SetSelectedState("normal")

		arg_8_0.stateText_.text = GetTips("EXPLORE_REGION_NORMAL")
	end

	arg_8_0.regionNameTxt_.text = GetI18NText(var_8_0.area_name)

	if arg_8_0.regionData then
		local var_8_2 = ExploreMeowCfg[arg_8_0.regionData.adminCatID]

		arg_8_0.adminCatImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Managecat_s/" .. var_8_2.meow_icon)
	end
end

function var_0_0.BindRedPoint(arg_10_0)
	manager.redPoint:bindUIandKey(arg_10_0.exploreBtn_.transform, RedPointConst.EXPLORE_FINISH .. arg_10_0.regionId, {
		x = 50,
		y = 50
	})
end

function var_0_0.UnbindRedPoint(arg_11_0)
	manager.redPoint:unbindUIandKey(arg_11_0.exploreBtn_.transform, RedPointConst.EXPLORE_FINISH .. arg_11_0.regionId)
end

function var_0_0.OnEnter(arg_12_0)
	arg_12_0:UpdateView()
	arg_12_0:BindRedPoint()
end

function var_0_0.OnExit(arg_13_0)
	if arg_13_0.updateTimer_ then
		arg_13_0.updateTimer_:Stop()

		arg_13_0.updateTimer_ = nil
	end

	arg_13_0:UnbindRedPoint()
	manager.windowBar:HideBar()
end

function var_0_0.Hide(arg_14_0)
	SetActive(arg_14_0.gameObject_, false)
end

function var_0_0.Show(arg_15_0)
	SetActive(arg_15_0.gameObject_, true)
end

function var_0_0.Dispose(arg_16_0)
	var_0_0.super.Dispose(arg_16_0)
	Object.Destroy(arg_16_0.gameObject_)
end

return var_0_0
