local var_0_0 = class("MenuPopItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.typeController_ = arg_3_0.controllerEx_:GetController("bgType")
	arg_3_0.lockController_ = arg_3_0.controllerEx_:GetController("lock")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.button_, nil, function()
		if arg_4_0.clickFun_ then
			arg_4_0.clickFun_(arg_4_0)
		end
	end)
end

function var_0_0.SetData(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.data_ = arg_6_1
	arg_6_0.clickFun_ = arg_6_2
	arg_6_0.iconImg_.sprite = getSprite("Atlas/MainAtlas", arg_6_1.icon)
	arg_6_0.nameText_.text = GetTips(arg_6_1.nameId)

	arg_6_0.typeController_:SetSelectedState(arg_6_1.type)
	arg_6_0.lockController_:SetSelectedState(arg_6_1.lock and "true" or "false")
end

function var_0_0.BindRedPointUI(arg_7_0)
	if MenuPopConst.MenuRedPointList[arg_7_0.data_.id] then
		manager.redPoint:bindUIandKey(arg_7_0.transform_, MenuPopConst.MenuRedPointList[arg_7_0.data_.id])
	end
end

function var_0_0.UnBindRedPointUI(arg_8_0)
	if MenuPopConst.MenuRedPointList[arg_8_0.data_.id] then
		manager.redPoint:unbindUIandKey(arg_8_0.transform_, MenuPopConst.MenuRedPointList[arg_8_0.data_.id])
	end
end

function var_0_0.GetBulletinID(arg_9_0)
	local var_9_0 = manager.time:GetServerTime()
	local var_9_1 = {
		101,
		102,
		104
	}

	for iter_9_0, iter_9_1 in ipairs(var_9_1) do
		local var_9_2 = BulletinData.GetBulletinIDList()[iter_9_1]

		if var_9_2 then
			for iter_9_2, iter_9_3 in pairs(var_9_2) do
				local var_9_3 = BulletinData.GetBulletinPageList()[iter_9_3]

				if var_9_0 < var_9_3.endTime then
					return var_9_3.id
				end
			end
		end
	end

	return false
end

function var_0_0.OnExit(arg_10_0)
	arg_10_0:UnBindRedPointUI()
end

function var_0_0.Dispose(arg_11_0)
	var_0_0.super.Dispose(arg_11_0)
	arg_11_0:UnBindRedPointUI()
end

return var_0_0
