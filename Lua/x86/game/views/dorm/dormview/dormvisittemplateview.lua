local var_0_0 = class("DormVisitTemplateView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/BackHouseUI/Dorm/DormCollectionSchemePopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.OnCtor(arg_3_0)
	return
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddUIListener()
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.curFurNumController = ControllerUtil.GetController(arg_5_0.transform_, "curState")
	arg_5_0.showListController = ControllerUtil.GetController(arg_5_0.transform_, "pulldown")
	arg_5_0.templateScroll = LuaList.New(handler(arg_5_0, arg_5_0.indexItem), arg_5_0.uilistGo_, DormVisitFurTemplateItem)
end

function var_0_0.OnEnter(arg_6_0)
	arg_6_0:RegisterEvents()

	local var_6_0 = DormData:GetCurrectSceneID()

	arg_6_0.type = BackHomeCfg[var_6_0].type

	if arg_6_0.type == DormConst.BACKHOME_TYPE.VISITPUBLICDORM then
		arg_6_0.type = DormConst.BACKHOME_TYPE.PublicDorm
	elseif arg_6_0.type == DormConst.BACKHOME_TYPE.VISITPRIVATEDORM then
		arg_6_0.type = DormConst.BACKHOME_TYPE.PrivateDorm
	end

	arg_6_0.maxNum = 0

	if arg_6_0.type == DormConst.BACKHOME_TYPE.PublicDorm then
		arg_6_0.maxNum = DormConst.DORM_TEMPLATE_NUM_MAX
	else
		arg_6_0.maxNum = DormConst.DORM_TEMPLATE_PRIVATE_NUM_MAX
	end

	arg_6_0.showFlag = false

	arg_6_0:UpdataView()
end

function var_0_0.OnExit(arg_7_0)
	arg_7_0:RemoveAllEventListener()
	arg_7_0.showListController:SetSelectedState("off")

	arg_7_0.showFlag = false
	arg_7_0.selTemplateID = nil
	arg_7_0.selectedPos = nil
end

function var_0_0.AddUIListener(arg_8_0)
	arg_8_0:AddBtnListener(arg_8_0.bgmaskBtn_, nil, function()
		JumpTools.Back()
	end)
	arg_8_0:AddBtnListener(arg_8_0.cancelBtn_, nil, function()
		JumpTools.Back()
	end)
	arg_8_0:AddBtnListener(arg_8_0.confirmBtn_, nil, function()
		local var_11_0 = DormVisitTools:GetVisitUserID()
		local var_11_1 = {
			layout_uid = DormVisitTools:GetLayoutID(),
			user_id = var_11_0
		}

		if arg_8_0.selTemplateID >= 0 then
			ShowMessageBox({
				isTop = true,
				content = GetTips("DORM_MOULD_COVER"),
				OkCallback = function()
					local var_12_0 = DormData:GetCurrectSceneID()
					local var_12_1 = BackHomeCfg[var_12_0].type
					local var_12_2 = DormFurnitureTemplateData:GetDormTemplateInfo(arg_8_0.selTemplateID):GetTemplateName()

					DormFurnitureTemplateData:SaveDormSceneTemplate(arg_8_0.selTemplateID, var_12_1, var_12_2, var_12_0, arg_8_0.selectedPos, var_11_1)
				end,
				CancelCallback = function()
					return
				end
			})
		else
			local var_11_2 = DormData:GetCurrectSceneID()
			local var_11_3 = BackHomeCfg[var_11_2].type
			local var_11_4 = string.format(GetTips("DORM_MOULD_DEFAULT_NAME"), tostring(arg_8_0.selectedPos))
			local var_11_5 = DormFurnitureTemplateData:GetCanUseTemplateID()

			DormFurnitureTemplateData:SaveDormSceneTemplate(var_11_5, var_11_3, var_11_4, var_11_2, arg_8_0.selectedPos, var_11_1)
		end
	end)
	arg_8_0:AddBtnListener(arg_8_0.chooseBtn, nil, function()
		if arg_8_0.showFlag then
			arg_8_0.showFlag = false

			arg_8_0.showListController:SetSelectedState("off")
		else
			arg_8_0.showFlag = true

			arg_8_0.showListController:SetSelectedState("on")
			arg_8_0:RefreshList()
		end
	end)
end

function var_0_0.UpdataView(arg_15_0)
	local var_15_0 = 0

	if not arg_15_0.selectedPos then
		arg_15_0.selectedPos = 1
		arg_15_0.selTemplateID = DormFurnitureTemplateData:GetDormTemplateInfoByPosID(1, arg_15_0.type) or -1
	end

	if arg_15_0.selTemplateID > 0 then
		local var_15_1 = DormFurnitureTemplateData:GetDormTemplateInfo(arg_15_0.selTemplateID)
		local var_15_2 = var_15_1.name

		var_15_0 = var_15_1:GetDormTemplateFurNumInfo()
		arg_15_0.curTemplateName.text = var_15_2
	else
		arg_15_0.curTemplateName.text = string.format(GetTips("DORM_MOULD_DEFAULT_NAME"), arg_15_0.selectedPos)
	end

	arg_15_0.curFurNum.text = string.format(GetTips("DORM_MOULD_FURNITURE_NUM"), var_15_0)

	if var_15_0 <= 0 then
		arg_15_0.curFurNumController:SetSelectedState("false")
	else
		arg_15_0.curFurNumController:SetSelectedState("true")
	end
end

function var_0_0.indexItem(arg_16_0, arg_16_1, arg_16_2)
	arg_16_2:RefreshUI(arg_16_0.templateData[arg_16_1], arg_16_0.selectedPos, arg_16_1)
	arg_16_2:ClickCallBack(function(arg_17_0, arg_17_1)
		arg_16_0.selTemplateID = arg_17_0
		arg_16_0.selectedPos = arg_17_1
		arg_16_0.showFlag = false

		arg_16_0.showListController:SetSelectedState("off")
		arg_16_0:UpdataView()
	end)
end

function var_0_0.RefreshList(arg_18_0)
	arg_18_0.templateData = {}

	for iter_18_0 = 1, arg_18_0.maxNum do
		local var_18_0 = DormFurnitureTemplateData:GetDormTemplateInfoByPosID(iter_18_0, arg_18_0.type)

		if var_18_0 then
			table.insert(arg_18_0.templateData, var_18_0)
		else
			table.insert(arg_18_0.templateData, -1)
		end
	end

	arg_18_0.templateScroll:StartScroll(#arg_18_0.templateData)
end

function var_0_0.RegisterEvents(arg_19_0)
	arg_19_0:RegistEventListener(DORM_TEMPLATE_CHANGE, function()
		JumpTools.Back()
	end)
end

function var_0_0.Dispose(arg_21_0)
	if arg_21_0.templateScroll then
		arg_21_0.templateScroll:Dispose()
	end

	var_0_0.super.Dispose(arg_21_0)
end

return var_0_0
