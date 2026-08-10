local var_0_0 = class("DormTemplateView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/BackHouseUI/Dorm/DormEditschemeUI"
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

	arg_5_0.scrollHelper_ = LuaList.New(handler(arg_5_0, arg_5_0.indexTemplate), arg_5_0.uilistUilist_, DormFurTemplateItem)
	arg_5_0.templateID = nil
	arg_5_0.choiceController = ControllerUtil.GetController(arg_5_0.shareswitchTrs_, "choice")
	arg_5_0.switchController = ControllerUtil.GetController(arg_5_0.shareswitchTrs_, "switch")
end

function var_0_0.OnEnter(arg_6_0)
	arg_6_0.canPreview = arg_6_0.params_.canPreview

	if arg_6_0.canPreview == nil then
		arg_6_0.canPreview = true
	end

	arg_6_0.pos = arg_6_0.params_.pos or arg_6_0.pos
	arg_6_0.params_.pos = nil

	arg_6_0:RefreshDormFurTemplateList()
	arg_6_0:RegisterEvents()

	arg_6_0.switchFlag = false

	arg_6_0:RefreshCanSaveView()
	arg_6_0:RefreshCanSaveFlag()
end

function var_0_0.OnExit(arg_7_0)
	arg_7_0:RemoveAllEventListener()
end

function var_0_0.AddUIListener(arg_8_0)
	arg_8_0:AddBtnListener(arg_8_0.bgmaskBtn_, nil, function()
		JumpTools.Back()
	end)
	arg_8_0:AddBtnListenerScale(arg_8_0.infoBtn_, nil, function()
		JumpTools.OpenPageByJump("gameHelp", {
			content = GetTips("DORM_TEMPLATE_GAME_HELP"),
			title = GetTips("DORM_TEMPLATE_GAME_TITLE")
		})
	end)
	arg_8_0:AddBtnListener(arg_8_0.switchBtn, nil, function()
		arg_8_0.switchFlag = not arg_8_0.switchFlag

		arg_8_0:RefreshCanSaveFlag()
	end)

	for iter_8_0 = 1, 2 do
		arg_8_0:AddToggleListener(arg_8_0["label_" .. iter_8_0 .. "Tgl_"], function(arg_12_0)
			if arg_12_0 then
				arg_8_0:SelectSaveType(iter_8_0)
			end
		end)
	end
end

function var_0_0.RegisterEvents(arg_13_0)
	arg_13_0:RegistEventListener(DORM_TEMPLATE_CHANGE, function()
		arg_13_0:RefreshDormFurTemplateList()
	end)
	arg_13_0:RegistEventListener(DOMR_RENAME_TEMPLATE_SUCCESS, function()
		arg_13_0:RefreshDormFurTemplateList()
	end)
	arg_13_0:RegistEventListener(SDK_UPLOAD_IMG, function(arg_16_0)
		arg_13_0:UploadImageSuccess(arg_16_0)
	end)
	arg_13_0:RegistEventListener(DOMR_SAVE_FLAG_CHANGE, function()
		if DormFurnitureTemplateData:GetOtherCanSave() then
			arg_13_0.saveText.text = GetTips("DORM_TEMPLATE_SHAREABLE")
		else
			arg_13_0.saveText.text = GetTips("DORM_TEMPLATE_CANNOT_SHAREABLE")
		end

		ShowTips("DORM_SUCCESS_SET")
	end)
end

function var_0_0.indexTemplate(arg_18_0, arg_18_1, arg_18_2)
	arg_18_2:RefreshUI(arg_18_0.templateData[arg_18_1], arg_18_1, arg_18_0.canPreview)
	arg_18_2:RegisterUseTemplateCallBack(function(arg_19_0)
		if not arg_18_0.canPreview or arg_19_0 < 0 then
			ShowTips(GetTips("DORM_MOULD_CANT_USE"))

			return
		end

		local var_19_0 = DormData:GetCurrectSceneID()
		local var_19_1 = DormFurnitureTemplateData:GetDormTemplateInfo(arg_19_0)
		local var_19_2, var_19_3 = DormFurnitureTemplateData:CheckFurNumSuitTemplate(arg_19_0, var_19_0)

		DormHeroTools.HideAllCharacter()

		if not var_19_2 then
			ShowMessageBox({
				isTop = true,
				content = GetTips("DORM_MOULD_NOT_ENOUGH"),
				OkCallback = function()
					local var_20_0, var_20_1 = DormFurnitureTemplateData:ReduceTemplateLackFurInfoS(arg_19_0, var_19_3)

					DormFurnitureTools:GenFurListInCurRoom(var_20_0)
					DormSpecialFurnitureTools:ChangeDormFloorOrWallData(var_20_1)

					local var_20_2 = {
						furInfoList = var_20_0,
						specialInfo = var_20_1
					}

					if SDKTools.IsSDK() then
						arg_18_0:PreSaveShot(arg_19_0, var_19_0, var_19_2, var_20_2, true)
					else
						arg_18_0:SaveFurTemplet(arg_19_0, var_19_0, var_19_2, var_20_2, true)
					end
				end,
				CancelCallback = function()
					DormFurEditStateData:ExitEditState()
					DormSuitEditData:ExitFullSuitEditMode()
					DormHeroTools:GenerateHeroWhenEnterScene()
				end
			})
		else
			if var_19_1 then
				local var_19_4 = var_19_1.furnitureInfoS

				DormFurnitureTools:GenFurListInCurRoom(var_19_4)
				DormSpecialFurnitureTools:ChangeDormFloorOrWallData(var_19_1.specialFur)

				if SDKTools.IsSDK() then
					arg_18_0:PreSaveShot(arg_19_0, var_19_0, var_19_2, nil, false)
				else
					arg_18_0:SaveFurTemplet(arg_19_0, var_19_0, var_19_2, nil, false)
				end
			else
				print("未找到模板信息,id为" .. arg_19_0)
			end

			DormHeroTools:GenerateHeroWhenEnterScene()
		end
	end)
	arg_18_2:RegisterPreviewCallBack(function(arg_22_0, arg_22_1)
		if not arg_18_0.canPreview then
			ShowTips(GetTips("DORM_MOULD_CANT_USE"))

			return
		end

		if arg_22_0 < 0 then
			ShowTips(GetTips("DORM_MOULD_CANT_USE"))

			return
		end

		arg_18_0.pos = arg_22_1

		DormFurnitureTemplateData:PreviewDormSceneTemplate(arg_22_0)
		JumpTools.OpenPageByJump("/dormSuitFurInfoView", {
			templateID = arg_22_0
		})
	end)
	arg_18_2:SaveTemplateCallBack(function(arg_23_0, arg_23_1)
		local var_23_0 = DormData:GetCurrectSceneID()
		local var_23_1 = DormitoryData:GetDormSceneData(var_23_0)

		if arg_23_1 then
			arg_18_0.pos = arg_23_1

			if arg_23_0 > 0 then
				ShowMessageBox({
					isTop = true,
					content = GetTips("DORM_MOULD_COVER"),
					OkCallback = function()
						local var_24_0 = BackHomeCfg[var_23_0].type
						local var_24_1 = DormFurnitureTemplateData:GetDormTemplateInfo(arg_23_0):GetTemplateName()

						DormFurnitureTemplateData:SaveDormSceneTemplate(arg_23_0, var_24_0, var_24_1, var_23_0, arg_23_1)
					end,
					CancelCallback = function()
						return
					end
				})
			else
				local var_23_2 = BackHomeCfg[var_23_0].type
				local var_23_3 = string.format(GetTips("DORM_MOULD_DEFAULT_NAME"), tostring(arg_23_1))
				local var_23_4 = DormFurnitureTemplateData:GetCanUseTemplateID()

				DormFurnitureTemplateData:SaveDormSceneTemplate(var_23_4, var_23_2, var_23_3, var_23_0, arg_23_1)
			end
		end
	end)
	arg_18_2:ReviseNameCallBack(function(arg_26_0, arg_26_1)
		if arg_26_0 < 0 then
			ShowTips(GetTips("DORM_MOULD_DATA_NULL"))

			return
		end

		arg_18_0.pos = arg_26_1

		local function var_26_0(arg_27_0)
			DormAction:ReviseFurTemplateName(arg_26_0, arg_27_0)
		end

		JumpTools.OpenPageByJump("dormChangeTemplateNameView", {
			callBack = var_26_0,
			template_ID = arg_26_0,
			oldName = DormFurnitureTemplateData:GetDormTemplateInfo(arg_26_0).name,
			showText = GetTips("DORM_MOULD_NAME_SET_TIPS")
		})
	end)
	arg_18_2:DelTemplateCallBack(function(arg_28_0, arg_28_1)
		if arg_28_0 < 0 then
			ShowTips(GetTips("DORM_MOULD_DATA_NULL"))

			return
		end

		ShowMessageBox({
			isTop = true,
			content = GetTips("DORM_DELETE_TEMPLATE"),
			OkCallback = function()
				arg_18_0.pos = arg_28_1

				DormAction:DeleteFurTemplate(arg_28_0)
			end,
			CancelCallback = function()
				return
			end
		})
	end)
end

function var_0_0.SaveFurTemplet(arg_31_0, arg_31_1, arg_31_2, arg_31_3, arg_31_4, arg_31_5, arg_31_6)
	DormFurnitureTemplateData:ConfirmUseTemplateInRoom(arg_31_1, arg_31_2, arg_31_3, arg_31_4, arg_31_6)
	ShowTips(GetTips("DORM_MOULD_SET_SUCCESS"))
	JumpTools.OpenPageByJump("/dorm")

	if arg_31_5 then
		DormHeroTools:GenerateHeroWhenEnterScene()
	end
end

function var_0_0.PreSaveShot(arg_32_0, arg_32_1, arg_32_2, arg_32_3, arg_32_4, arg_32_5)
	SetForceShowQuanquan(true)

	arg_32_0.tempShotCtx = {
		templateID = arg_32_1,
		curRoomID = arg_32_2,
		flag = arg_32_3,
		furInfo = arg_32_4,
		generateHero = arg_32_5
	}
	arg_32_0.snapShot = UnityEngine.RenderTexture.New(math.floor(Screen.width / 4), math.floor(Screen.height / 4), 0, UnityEngine.RenderTextureFormat.ARGB32)

	local var_32_0 = manager.ui.mainCamera:GetComponent("CameraExtension")

	if not isNil(var_32_0) then
		var_32_0:CaptureSnapshot(arg_32_0.snapShot)
	end

	local var_32_1 = FrameTimer.New(function()
		local var_33_0 = manager.share:SaveRenderTextureByModule("room_edit", arg_32_0.snapShot)

		arg_32_0.snapShot:Release()

		arg_32_0.snapShot = nil

		SDKUploadImage("room_edit", var_33_0)
	end, 1, 1):Start()
end

function var_0_0.UploadImageSuccess(arg_34_0, arg_34_1)
	if arg_34_1.code == 1 then
		arg_34_0:SaveFurTemplet(arg_34_0.tempShotCtx.templateID, arg_34_0.tempShotCtx.curRoomID, arg_34_0.tempShotCtx.flag, arg_34_0.tempShotCtx.furInfo, arg_34_0.tempShotCtx.generateHero, arg_34_1.url)

		arg_34_0.tempShotCtx = nil
	else
		ShowTips("IMAGE_UPLOAD_FAIL")
	end

	SetForceShowQuanquan(false)
end

function var_0_0.RefreshDormFurTemplateList(arg_35_0)
	local var_35_0 = DormData:GetCurrectSceneID()
	local var_35_1 = BackHomeCfg[var_35_0].type

	if var_35_1 == DormConst.BACKHOME_TYPE.VISITPUBLICDORM then
		var_35_1 = DormConst.BACKHOME_TYPE.PublicDorm
	elseif var_35_1 == DormConst.BACKHOME_TYPE.VISITPRIVATEDORM then
		var_35_1 = DormConst.BACKHOME_TYPE.PrivateDorm
	end

	arg_35_0.templateData = {}

	local var_35_2

	if var_35_1 == DormConst.BACKHOME_TYPE.PublicDorm then
		var_35_2 = DormConst.DORM_TEMPLATE_NUM_MAX
	else
		var_35_2 = DormConst.DORM_TEMPLATE_PRIVATE_NUM_MAX
	end

	for iter_35_0 = 1, var_35_2 do
		local var_35_3 = DormFurnitureTemplateData:GetDormTemplateInfoByPosID(iter_35_0, var_35_1)

		if var_35_3 then
			table.insert(arg_35_0.templateData, var_35_3)
		else
			table.insert(arg_35_0.templateData, -1)
		end
	end

	arg_35_0.scrollHelper_:StartScroll(#arg_35_0.templateData)

	if arg_35_0.pos then
		arg_35_0.scrollHelper_:ScrollToIndex(arg_35_0.pos, true, false)
	end
end

function var_0_0.RefreshCanSaveView(arg_36_0)
	arg_36_0.tgl1.text = GetTips("DORM_TEMPLATE_CANNOT_SHAREABLE")
	arg_36_0.tgl2.text = GetTips("DORM_TEMPLATE_SHAREABLE")
end

function var_0_0.RefreshCanSaveFlag(arg_37_0)
	local var_37_0 = DormFurnitureTemplateData:GetOtherCanSave()

	if var_37_0 then
		arg_37_0.saveText.text = GetTips("DORM_TEMPLATE_SHAREABLE")
	else
		arg_37_0.saveText.text = GetTips("DORM_TEMPLATE_CANNOT_SHAREABLE")
	end

	if arg_37_0.switchFlag then
		arg_37_0.switchController:SetSelectedState("on")

		if var_37_0 then
			arg_37_0["label_" .. 2 .. "Tgl_"].isOn = true
		else
			arg_37_0["label_" .. 1 .. "Tgl_"].isOn = true
		end
	else
		arg_37_0.switchController:SetSelectedState("off")
	end
end

function var_0_0.SelectSaveType(arg_38_0, arg_38_1)
	local var_38_0 = DormFurnitureTemplateData:GetOtherCanSave()

	if arg_38_1 == 1 and var_38_0 then
		DormAction.SetFurnitureTemplatCanSave(false)
	elseif arg_38_1 == 2 and not var_38_0 then
		DormAction.SetFurnitureTemplatCanSave(true)
	end
end

function var_0_0.Dispose(arg_39_0)
	if arg_39_0.scrollHelper_ then
		arg_39_0.scrollHelper_:Dispose()

		arg_39_0.scrollHelper_ = nil
	end

	var_0_0.super.Dispose(arg_39_0)
end

return var_0_0
