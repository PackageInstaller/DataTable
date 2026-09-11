local DormTemplateView = class("DormTemplateView", ReduxView)

function DormTemplateView:UIName()
	return "Widget/BackHouseUI/Dorm/DormEditschemeUI"
end

function DormTemplateView:UIParent()
	return manager.ui.uiMain.transform
end

function DormTemplateView:OnCtor()
	return
end

function DormTemplateView:Init()
	self:InitUI()
	self:AddUIListener()
end

function DormTemplateView:InitUI()
	self:BindCfgUI()

	self.scrollHelper_ = LuaList.New(handler(self, self.indexTemplate), self.uilistUilist_, DormFurTemplateItem)
	self.templateID = nil
	self.choiceController = ControllerUtil.GetController(self.shareswitchTrs_, "choice")
	self.switchController = ControllerUtil.GetController(self.shareswitchTrs_, "switch")
end

function DormTemplateView:OnEnter()
	self.canPreview = self.params_.canPreview

	if self.canPreview == nil then
		self.canPreview = true
	end

	self.pos = self.params_.pos or self.pos
	self.params_.pos = nil

	self:RefreshDormFurTemplateList()
	self:RegisterEvents()

	self.switchFlag = false

	self:RefreshCanSaveView()
	self:RefreshCanSaveFlag()
end

function DormTemplateView:OnExit()
	self:RemoveAllEventListener()
end

function DormTemplateView:AddUIListener()
	self:AddBtnListener(self.bgmaskBtn_, nil, function()
		JumpTools.Back()
	end)
	self:AddBtnListenerScale(self.infoBtn_, nil, function()
		JumpTools.OpenPageByJump("gameHelp", {
			content = GetTips("DORM_TEMPLATE_GAME_HELP"),
			title = GetTips("DORM_TEMPLATE_GAME_TITLE")
		})
	end)
	self:AddBtnListener(self.switchBtn, nil, function()
		self.switchFlag = not self.switchFlag

		self:RefreshCanSaveFlag()
	end)

	for iter_8_0 = 1, 2 do
		self:AddToggleListener(self["label_" .. iter_8_0 .. "Tgl_"], function(arg_12_0)
			if arg_12_0 then
				self:SelectSaveType(iter_8_0)
			end
		end)
	end
end

function DormTemplateView:RegisterEvents()
	self:RegistEventListener(DORM_TEMPLATE_CHANGE, function()
		self:RefreshDormFurTemplateList()
	end)
	self:RegistEventListener(DOMR_RENAME_TEMPLATE_SUCCESS, function()
		self:RefreshDormFurTemplateList()
	end)
	self:RegistEventListener(SDK_UPLOAD_IMG, function(arg_16_0)
		self:UploadImageSuccess(arg_16_0)
	end)
	self:RegistEventListener(DOMR_SAVE_FLAG_CHANGE, function()
		self.saveText.text = DormFurnitureTemplateData:GetOtherCanSave() and GetTips("DORM_TEMPLATE_SHAREABLE") or GetTips("DORM_TEMPLATE_CANNOT_SHAREABLE")

		ShowTips("DORM_SUCCESS_SET")
	end)
end

function DormTemplateView:indexTemplate(arg_18_1, arg_18_2)
	arg_18_2:RefreshUI(self.templateData[arg_18_1], arg_18_1, self.canPreview)
	arg_18_2:RegisterUseTemplateCallBack(function(arg_19_0)
		if not self.canPreview or arg_19_0 < 0 then
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
						self:PreSaveShot(arg_19_0, var_19_0, var_19_2, var_20_2, true)
					else
						self:SaveFurTemplet(arg_19_0, var_19_0, var_19_2, var_20_2, true)
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
				DormFurnitureTools:GenFurListInCurRoom(var_19_1.furnitureInfoS)
				DormSpecialFurnitureTools:ChangeDormFloorOrWallData(var_19_1.specialFur)

				if SDKTools.IsSDK() then
					self:PreSaveShot(arg_19_0, var_19_0, var_19_2, nil, false)
				else
					self:SaveFurTemplet(arg_19_0, var_19_0, var_19_2, nil, false)
				end
			else
				print("未找到模板信息,id为" .. arg_19_0)
			end

			DormHeroTools:GenerateHeroWhenEnterScene()
		end
	end)
	arg_18_2:RegisterPreviewCallBack(function(arg_22_0, arg_22_1)
		if not self.canPreview then
			ShowTips(GetTips("DORM_MOULD_CANT_USE"))

			return
		end

		if arg_22_0 < 0 then
			ShowTips(GetTips("DORM_MOULD_CANT_USE"))

			return
		end

		self.pos = arg_22_1

		DormFurnitureTemplateData:PreviewDormSceneTemplate(arg_22_0)
		JumpTools.OpenPageByJump("/dormSuitFurInfoView", {
			templateID = arg_22_0
		})
	end)
	arg_18_2:SaveTemplateCallBack(function(arg_23_0, arg_23_1)
		local var_23_0 = DormData:GetCurrectSceneID()
		local var_23_1 = DormitoryData:GetDormSceneData(var_23_0)

		if arg_23_1 then
			self.pos = arg_23_1

			if arg_23_0 > 0 then
				ShowMessageBox({
					isTop = true,
					content = GetTips("DORM_MOULD_COVER"),
					OkCallback = function()
						DormFurnitureTemplateData:SaveDormSceneTemplate(arg_23_0, BackHomeCfg[var_23_0].type, DormFurnitureTemplateData:GetDormTemplateInfo(arg_23_0):GetTemplateName(), var_23_0, arg_23_1)
					end,
					CancelCallback = function()
						return
					end
				})
			else
				DormFurnitureTemplateData:SaveDormSceneTemplate(DormFurnitureTemplateData:GetCanUseTemplateID(), BackHomeCfg[var_23_0].type, string.format(GetTips("DORM_MOULD_DEFAULT_NAME"), tostring(arg_23_1)), var_23_0, arg_23_1)
			end
		end
	end)
	arg_18_2:ReviseNameCallBack(function(arg_26_0, arg_26_1)
		if arg_26_0 < 0 then
			ShowTips(GetTips("DORM_MOULD_DATA_NULL"))

			return
		end

		self.pos = arg_26_1

		JumpTools.OpenPageByJump("dormChangeTemplateNameView", {
			callBack = function(arg_27_0)
				DormAction:ReviseFurTemplateName(arg_26_0, arg_27_0)
			end,
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
				self.pos = arg_28_1

				DormAction:DeleteFurTemplate(arg_28_0)
			end,
			CancelCallback = function()
				return
			end
		})
	end)
end

function DormTemplateView:SaveFurTemplet(arg_31_1, arg_31_2, arg_31_3, arg_31_4, arg_31_5, arg_31_6)
	DormFurnitureTemplateData:ConfirmUseTemplateInRoom(arg_31_1, arg_31_2, arg_31_3, arg_31_4, arg_31_6)
	ShowTips(GetTips("DORM_MOULD_SET_SUCCESS"))
	JumpTools.OpenPageByJump("/dorm")

	if arg_31_5 then
		DormHeroTools:GenerateHeroWhenEnterScene()
	end
end

function DormTemplateView:PreSaveShot(arg_32_1, arg_32_2, arg_32_3, arg_32_4, arg_32_5)
	SetForceShowQuanquan(true)

	self.tempShotCtx = {
		templateID = arg_32_1,
		curRoomID = arg_32_2,
		flag = arg_32_3,
		furInfo = arg_32_4,
		generateHero = arg_32_5
	}
	self.snapShot = UnityEngine.RenderTexture.New(math.floor(Screen.width / 4), math.floor(Screen.height / 4), 0, UnityEngine.RenderTextureFormat.ARGB32)

	local var_32_0 = manager.ui.mainCamera:GetComponent("CameraExtension")

	if not isNil(var_32_0) then
		var_32_0:CaptureSnapshot(self.snapShot)
	end

	local var_32_1 = FrameTimer.New(function()
		self.snapShot:Release()

		self.snapShot = nil

		SDKUploadImage("room_edit", (manager.share:SaveRenderTextureByModule("room_edit", self.snapShot)))
	end, 1, 1):Start()
end

function DormTemplateView:UploadImageSuccess(arg_34_1)
	if arg_34_1.code == 1 then
		self:SaveFurTemplet(self.tempShotCtx.templateID, self.tempShotCtx.curRoomID, self.tempShotCtx.flag, self.tempShotCtx.furInfo, self.tempShotCtx.generateHero, arg_34_1.url)

		self.tempShotCtx = nil
	else
		ShowTips("IMAGE_UPLOAD_FAIL")
	end

	SetForceShowQuanquan(false)
end

function DormTemplateView:RefreshDormFurTemplateList()
	local var_35_0 = BackHomeCfg[DormData:GetCurrectSceneID()].type

	if var_35_0 == DormConst.BACKHOME_TYPE.VISITPUBLICDORM then
		var_35_0 = DormConst.BACKHOME_TYPE.PublicDorm
	elseif var_35_0 == DormConst.BACKHOME_TYPE.VISITPRIVATEDORM then
		var_35_0 = DormConst.BACKHOME_TYPE.PrivateDorm
	end

	self.templateData = {}

	for iter_35_0 = 1, var_35_0 == DormConst.BACKHOME_TYPE.PublicDorm and DormConst.DORM_TEMPLATE_NUM_MAX or DormConst.DORM_TEMPLATE_PRIVATE_NUM_MAX do
		local var_35_2 = DormFurnitureTemplateData:GetDormTemplateInfoByPosID(iter_35_0, var_35_0)

		if var_35_2 then
			table.insert(self.templateData, var_35_2)
		else
			table.insert(self.templateData, -1)
		end
	end

	self.scrollHelper_:StartScroll(#self.templateData)

	if self.pos then
		self.scrollHelper_:ScrollToIndex(self.pos, true, false)
	end
end

function DormTemplateView:RefreshCanSaveView()
	self.tgl1.text = GetTips("DORM_TEMPLATE_CANNOT_SHAREABLE")
	self.tgl2.text = GetTips("DORM_TEMPLATE_SHAREABLE")
end

function DormTemplateView:RefreshCanSaveFlag()
	local var_37_0 = DormFurnitureTemplateData:GetOtherCanSave()

	self.saveText.text = var_37_0 and GetTips("DORM_TEMPLATE_SHAREABLE") or GetTips("DORM_TEMPLATE_CANNOT_SHAREABLE")

	if self.switchFlag then
		self.switchController:SetSelectedState("on")

		if var_37_0 then
			self["label_" .. 2 .. "Tgl_"].isOn = true
		else
			self["label_" .. 1 .. "Tgl_"].isOn = true
		end
	else
		self.switchController:SetSelectedState("off")
	end
end

function DormTemplateView:SelectSaveType(arg_38_1)
	local var_38_0 = DormFurnitureTemplateData:GetOtherCanSave()

	if arg_38_1 == 1 and var_38_0 then
		DormAction.SetFurnitureTemplatCanSave(false)
	elseif arg_38_1 == 2 and not var_38_0 then
		DormAction.SetFurnitureTemplatCanSave(true)
	end
end

function DormTemplateView:Dispose()
	if self.scrollHelper_ then
		self.scrollHelper_:Dispose()

		self.scrollHelper_ = nil
	end

	DormTemplateView.super.Dispose(self)
end

return DormTemplateView
