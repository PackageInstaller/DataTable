local DormVisitPictureItem = class("DormVisitPictureItem", ReduxView)

function DormVisitPictureItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function DormVisitPictureItem:Init()
	self:InitUI()
	self:AddUIListener()

	self.praiseController = self.controller_:GetController("praise")
end

function DormVisitPictureItem:InitUI()
	self:BindCfgUI()

	self.downloadHandler = handler(self, self.OnDownloadDone)
end

function DormVisitPictureItem:AddUIListener()
	self:AddBtnListener(self.roomBtn_, nil, function()
		self:OnGotoClick()
	end)
	manager.notify:RegistListener(SDK_DOWNLOAD_IMG, self.downloadHandler)
end

function DormVisitPictureItem:RefreshUI(arg_6_1, arg_6_2)
	SetActive(self.loading_, true)

	self.userID = arg_6_1
	self.type = arg_6_2

	local var_6_0 = DormVisitTools:GetTemplateExhibitList(self.type)[self.userID]

	if not var_6_0 then
		Debug.LogError("未获取到参观信息")

		return
	end

	self.localSavePath = manager.share:GetSavePathByModule("room_edit") .. SDKDonwloadUrlToLocalPath(var_6_0.picture_link) .. ".jpg"

	SDKDownloadImage(var_6_0.picture_link, self.localSavePath)

	self.viewNum_.text = var_6_0.visitNum
	self.praiseNum_.text = var_6_0.likeNum
	self.houseName_.text = var_6_0.nick

	if var_6_0.todayLikeNum then
		self.praiseController:SetSelectedState("off")
	else
		self.praiseController:SetSelectedState("on")
	end
end

function DormVisitPictureItem:OnDownloadDone(arg_7_1)
	if self.localSavePath and arg_7_1.code == 1 and arg_7_1.path == self.localSavePath and self.gameObject_.activeInHierarchy then
		BulletinBoardMgr.inst:GetFocalSpriteCustom(arg_7_1.path, function(arg_8_0)
			if not isNil(arg_8_0) then
				self.bgImg_.sprite = arg_8_0

				SetActive(self.loading_, false)
			end
		end)
	end
end

function DormVisitPictureItem:OnGotoClick()
	SDKTools.SendMessageToSDK("backhome_dorm_visit_jump", {
		backhome_source = 2
	})
	DormAction:AskSingleFurTemplateExhibit(self.userID)
end

function DormVisitPictureItem:Dispose()
	manager.notify:RemoveListener(SDK_DOWNLOAD_IMG, self.downloadHandler)
	DormVisitPictureItem.super.Dispose(self)
end

return DormVisitPictureItem
