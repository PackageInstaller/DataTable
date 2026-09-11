local CustomStickerSnapPanel = class("CustomStickerSnapPanel", ReduxView)

function CustomStickerSnapPanel:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
end

function CustomStickerSnapPanel:Snap(arg_2_1, arg_2_2)
	SetActive(self.gameObject_, true)

	local var_2_0 = PlayerData:GetPlayerInfo()

	self.textNick_.text = GetI18NText(var_2_0.nick)
	self.textLv_.text = GetTips("LEVEL") .. var_2_0.userLevel
	self.textUID_.text = "UID：" .. USER_ID

	manager.ui:ShowScreenTap(false)
	WaitRenderFrameUtil.inst.StartScreenShot(function()
		manager.ui:ShowScreenTap(true)
		SetActive(self.gameObject_, false)
		arg_2_1()
	end)
end

function CustomStickerSnapPanel:OnExit()
	return
end

function CustomStickerSnapPanel:Dispose()
	CustomStickerSnapPanel.super.Dispose(self)
end

return CustomStickerSnapPanel
