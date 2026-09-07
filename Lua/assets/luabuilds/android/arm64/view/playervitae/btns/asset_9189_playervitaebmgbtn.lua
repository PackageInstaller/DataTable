local PlayerVitaeBMGBtn = class("PlayerVitaeBMGBtn", import(".PlayerVitaeBaseBtn"))

function PlayerVitaeBMGBtn:GetBgName()
	return "AdmiralUI_atlas", "bgm"
end

function PlayerVitaeBMGBtn:IsActive(arg_2_1)
	return arg_2_1:IsBgmSkin()
end

function PlayerVitaeBMGBtn:GetDefaultValue()
	return getProxy(SettingsProxy):IsBGMEnable()
end

function PlayerVitaeBMGBtn:OnSwitch(arg_4_1)
	getProxy(SettingsProxy):SetBgmFlag(arg_4_1)
	pg.BgmMgr.GetInstance():Push(PlayerVitaeScene.__cname, arg_4_1 and self.ship:GetSkinBgm() or "main")

	return true
end

function PlayerVitaeBMGBtn:Load(arg_5_1)
	PlayerVitaeBMGBtn.super.Load(self, arg_5_1)

	if self:IsHrzType() then
		arg_5_1.gameObject.name = "bmg"
	end

	return
end

return PlayerVitaeBMGBtn
