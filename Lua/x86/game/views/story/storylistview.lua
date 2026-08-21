local var_0_0 = class("StoryListView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/StoryPreviewListUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.OnCtor(arg_3_0)
	return
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0.list_ = arg_4_0:FindTrs("list/Grid")
	arg_4_0.item_ = Asset.Load("UI/StoryPreviewItem")
	arg_4_0.items_ = {}

	local var_4_0 = keyPairsSort(StoryCfg)

	for iter_4_0, iter_4_1 in ipairs(var_4_0) do
		local var_4_1 = StoryCfg[iter_4_1]

		arg_4_0.items_[iter_4_1] = StoryItem.New(arg_4_0, Object.Instantiate(arg_4_0.item_, arg_4_0.list_), var_4_1)
	end

	arg_4_0.input_ = arg_4_0:FindCom(typeof(InputField), "InputField")
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0.input_.onEndEdit:AddListener(function()
		local var_6_0 = arg_5_0.input_.text

		for iter_6_0, iter_6_1 in pairs(arg_5_0.items_) do
			iter_6_1:Show(string.gmatch(iter_6_0, var_6_0)() ~= nil)
		end
	end)
end

function var_0_0.Render(arg_7_0)
	return
end

function var_0_0.RefreshUI(arg_8_0)
	return
end

function var_0_0.MoveList(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0.list_.transform.localPosition
	local var_9_1 = var_9_0.y + arg_9_1
	local var_9_2 = math.floor(var_9_1 / 440) * 440 + 10

	arg_9_0.list_.transform.localPosition = Vector3(var_9_0.x, var_9_2, var_9_0.z)
end

function var_0_0.Init(arg_10_0)
	arg_10_0:InitUI()
	arg_10_0:AddUIListener()
end

function var_0_0.OnEnter(arg_11_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		NAVI_BAR
	})
	arg_11_0:RefreshUI()
end

function var_0_0.OnExit(arg_12_0)
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_13_0)
	arg_13_0:RemoveAllListeners()

	for iter_13_0, iter_13_1 in pairs(arg_13_0.items_) do
		iter_13_1:Dispose()
	end

	var_0_0.super.Dispose(arg_13_0)
end

return var_0_0
