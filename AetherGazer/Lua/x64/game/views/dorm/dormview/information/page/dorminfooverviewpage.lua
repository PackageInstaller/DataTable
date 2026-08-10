local var_0_0 = class("DormInfoOverviewPage", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:InitUI()
end

function var_0_0.BuildContext(arg_2_0)
	arg_2_0.modules = {
		canteen = {
			script = DormOverviewCanteenModule
		},
		dormitory = {
			script = DormOverviewDormitoryModule
		},
		training = {
			script = DormOverviewTrainingModule
		}
	}
end

function var_0_0.BuildView(arg_3_0)
	if not arg_3_0.modules.training.entity then
		arg_3_0.modules.training.entity = arg_3_0.modules.training.script.New(arg_3_0.container)
	end

	if not arg_3_0.modules.canteen.entity then
		arg_3_0.modules.canteen.entity = arg_3_0.modules.canteen.script.New(arg_3_0.container)
	end

	if not arg_3_0.modules.dormitory.entity then
		arg_3_0.modules.dormitory.entity = arg_3_0.modules.dormitory.script.New(arg_3_0.container)
	end
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
	arg_4_0:AddListener()
	arg_4_0:BuildContext()
	arg_4_0:BuildView()
end

function var_0_0.Show(arg_5_0)
	SetActive(arg_5_0.gameObject_, true)
	arg_5_0:Render()
	arg_5_0:RegisterEvents()

	for iter_5_0, iter_5_1 in pairs(arg_5_0.modules) do
		iter_5_1.entity:RegisterEvents()
		iter_5_1.entity:OnEnter()
	end

	arg_5_0.cacheEntrustNum_ = 0

	if not arg_5_0.refreshTimer then
		arg_5_0.refreshTimer = Timer.New(function()
			local var_6_0 = CanteenEntrustData:CheckTimeOverEntrustNum()

			if arg_5_0.cacheEntrustNum_ ~= var_6_0 then
				arg_5_0.cacheEntrustNum_ = var_6_0

				arg_5_0.modules.canteen.entity:Render()
			end
		end, 1, -1)
	end

	arg_5_0.refreshTimer:Start()
end

function var_0_0.Hide(arg_7_0)
	SetActive(arg_7_0.gameObject_, false)

	for iter_7_0, iter_7_1 in pairs(arg_7_0.modules) do
		iter_7_1.entity:RemoveAllEventListener()
		iter_7_1.entity:OnExit()
	end

	arg_7_0:RemoveAllEventListener()

	if arg_7_0.refreshTimer then
		arg_7_0.refreshTimer:Stop()

		arg_7_0.refreshTimer = nil
	end

	arg_7_0.cacheEntrustNum_ = 0
end

function var_0_0.NeedEmpty(arg_8_0)
	return false
end

function var_0_0.Render(arg_9_0)
	arg_9_0.modules.canteen.entity:Render()
	arg_9_0.modules.dormitory.entity:Render()
	arg_9_0.modules.training.entity:Render()
end

function var_0_0.AddListener(arg_10_0)
	return
end

function var_0_0.Dispose(arg_11_0)
	if arg_11_0.refreshTimer then
		arg_11_0.refreshTimer:Stop()

		arg_11_0.refreshTimer = nil
	end

	arg_11_0.cacheEntrustNum_ = 0

	if arg_11_0.modules.canteen.entity then
		arg_11_0.modules.canteen.entity:Dispose()

		arg_11_0.modules.canteen.entity = nil
	end

	if arg_11_0.modules.dormitory.entity then
		arg_11_0.modules.dormitory.entity:Dispose()

		arg_11_0.modules.dormitory.entity = nil
	end

	if arg_11_0.modules.training.entity then
		arg_11_0.modules.training.entity:Dispose()

		arg_11_0.modules.training.entity = nil
	end

	var_0_0.super.Dispose(arg_11_0)
end

function var_0_0.RegisterEvents(arg_12_0)
	arg_12_0:RegistEventListener(DORM_REFRESH_HERO_DEPLOY_LIST, function()
		arg_12_0:Render()
	end)
end

return var_0_0
