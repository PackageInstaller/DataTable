local QWorldBookletPhotoPopView = class("QWorldBookletPhotoPopView", ReduxView)

function QWorldBookletPhotoPopView:UIName()
	return "Widget/System/SandPlay_QuanZhou/QuanZhou_CollectBook/QuanZhou_CollectBookPopUI"
end

function QWorldBookletPhotoPopView:UIParent()
	return manager.ui.uiPop.transform
end

function QWorldBookletPhotoPopView:Init()
	self:InitUI()
	self:AddUIListener()
end

function QWorldBookletPhotoPopView:InitUI()
	self:BindCfgUI()

	self.lockController_ = self.mainControllerEx_:GetController("lock")
end

function QWorldBookletPhotoPopView:AddUIListener()
	self:AddBtnListener(self.exitBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.jumpBtn_, nil, function()
		SandPlayTakePhotoTools.TrackPhoto(QuanzhouPhotoCfg[self.params_.photoId].enity_id, QuanzhouPhotoCfg[self.params_.photoId].thing_id)

		if QWorldMgr:GetQWorldEntityMgr():IsTrack(QuanzhouPhotoCfg[self.params_.photoId].enity_id) then
			gameContext:SetUrlAndParams("/springPreheatBlank/qworldMainHome")
			JumpTools.GoToSystem("/qWorldMaxMapView", {
				selectEntity = QuanzhouPhotoCfg[self.params_.photoId].enity_id
			})
		end
	end)
end

function QWorldBookletPhotoPopView:OnEnter()
	local var_8_0 = QuanzhouPhotoCfg[self.params_.photoId]

	if QWorldBookletTools.CheckPhotoUnlock(self.params_.photoId) then
		self.lockController_:SetSelectedState("unlock")

		self.photoImg_.spriteAsync = var_8_0.id == 2005 and "TextureConfig/SandPlay_QuanZhou/QuanZhou_CollectBook/MainPlot_05" or var_8_0.pic
		self.descText_.text = var_8_0.desc
	else
		self.previewImg_.spriteAsync = var_8_0.pre_pic

		self.lockController_:SetSelectedState("lock")
	end
end

function QWorldBookletPhotoPopView:OnExit()
	return
end

function QWorldBookletPhotoPopView:Dispose()
	QWorldBookletPhotoPopView.super.Dispose(self)
end

return QWorldBookletPhotoPopView
