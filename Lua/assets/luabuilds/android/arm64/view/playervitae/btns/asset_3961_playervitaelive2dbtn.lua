local PlayerVitaeLive2dBtn = class("PlayerVitaeLive2dBtn", import(".PlayerVitaeBaseBtn"))

function PlayerVitaeLive2dBtn:Ctor(arg_1_1, arg_1_2)
	PlayerVitaeLive2dBtn.super.Ctor(self, arg_1_1, arg_1_2)
	self:Load(self.tf)
	setActive(self.tf, true)

	return
end

function PlayerVitaeLive2dBtn:InitBtn()
	return
end

function PlayerVitaeLive2dBtn:GetBgName()
	return self:IsHrzType() and "share/btn_l2d_atlas" or "admiralui_atlas", self.ship and self.ship:GetSkinConfig().spine_use_live2d == 1 and (self:IsHrzType() and "spine_painting_bg" or "sp") or self:IsHrzType() and "live2d_bg" or "l2d"
end

function PlayerVitaeLive2dBtn:IsActive()
	return true
end

function PlayerVitaeLive2dBtn:Update(arg_5_1, arg_5_2, arg_5_3)
	PlayerVitaeLive2dBtn.super.Update(self, arg_5_1, arg_5_2, arg_5_3)
	self:NewGo()
	self:RequesetLive2dRes()

	return
end

function PlayerVitaeLive2dBtn:RequesetLive2dRes()
	self:StartCheckUpdate((HXSet.autoHxShiftPath("live2d/" .. string.lower(self.ship:getPainting()), nil, true)))

	return
end

function PlayerVitaeLive2dBtn:StartCheckUpdate(arg_7_1)
	local var_7_0 = BundleWizard.Inst:GetGroupMgr("L2D"):CheckF(arg_7_1)

	if var_7_0 == DownloadState.CheckToUpdate or var_7_0 == DownloadState.UpdateFailure then
		self:ShowOrHide(true)
		self:UpdateBtnState(false, false)
		onButton(self, self.tf, function()
			if self.isDownloading then
				return
			end

			local var_8_0 = "L2D"
			local var_8_1 = {
				arg_7_1
			}
			local var_8_2 = "L2D" .. arg_7_1

			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				type = MSGBOX_TYPE_NORMAL,
				content = string.format(i18n("group_download_tip", (HashUtil.BytesToString((GroupHelper.CalcSizeWithFileArr("L2D", var_8_1)))))),
				onYes = function()
					BundleWizardUpdater.Inst:StartUpdate((BundleWizardUpdater.Inst:CreateListInfo(var_8_2, BundleWizardUpdater.Inst:GetFileList(var_8_0, var_8_1), nil, function(arg_10_0, arg_10_1)
						if not self.isDisposed then
							local var_10_0 = checkABExist(arg_7_1)

							self:ShowOrHide(var_10_0)

							if var_10_0 then
								self:UpdateBtnState(false, false)
								PlayerVitaeLive2dBtn.super.InitBtn(self)
							end
						end

						self.isDownloading = false

						return
					end, nil)))

					self.isDownloading = true

					return
				end
			})

			return
		end, SFX_PANEL)
	else
		local var_7_1 = checkABExist(arg_7_1)

		self:ShowOrHide(var_7_1)

		if var_7_1 then
			self:UpdateBtnState(false, false)
			PlayerVitaeLive2dBtn.super.InitBtn(self)
		end
	end

	return
end

function PlayerVitaeLive2dBtn:GetDefaultValue()
	if Live2dConst.GetLive2DArm32MatchAble() then
		if getProxy(SettingsProxy):getCharacterSetting(self.ship.id, SHIP_FLAG_L2D) then
			self:OnSwitch(false)
		end

		return false
	end

	return getProxy(SettingsProxy):getCharacterSetting(self.ship.id, SHIP_FLAG_L2D)
end

function PlayerVitaeLive2dBtn:OnSwitch(arg_12_1)
	if Live2dConst.GetLive2DArm32MatchAble() and arg_12_1 then
		Live2dConst.ShowLive2DArm32Tips()

		return false
	end

	if not not ShipSkin.GetChangeSkinData(self.ship:getSkinId()) then
		getProxy(SettingsProxy):setCharacterSetting(self.ship.id, SHIP_FLAG_SP, arg_12_1)
	end

	getProxy(SettingsProxy):setCharacterSetting(self.ship.id, SHIP_FLAG_L2D, arg_12_1)

	return true
end

function PlayerVitaeLive2dBtn:OnDispose()
	self.isDisposed = true

	return
end

function PlayerVitaeLive2dBtn:Load(arg_14_1)
	PlayerVitaeLive2dBtn.super.Load(self, arg_14_1)

	if self:IsHrzType() then
		arg_14_1.gameObject.name = "live2d"
	end

	self.tf:GetComponent(typeof(Image)):SetNativeSize()

	return
end

return PlayerVitaeLive2dBtn
