local ShipProfileLive2dBtn = class("ShipProfileLive2dBtn")

function ShipProfileLive2dBtn:Ctor(arg_1_1)
	pg.DelegateInfo.New(self)

	self._tf = arg_1_1
	self.live2dBtn = arg_1_1
	self.live2dToggle = self.live2dBtn:Find("toggle")
	self.live2dState = self.live2dBtn:Find("state")
	self.live2dOn = self.live2dToggle:Find("on")
	self.live2dOff = self.live2dToggle:Find("off")

	return
end

function ShipProfileLive2dBtn:Update(arg_2_1, arg_2_2)
	if Live2dConst.GetLive2DArm32MatchAble() then
		arg_2_2 = false
	end

	self.paintingName = arg_2_1
	self.isOn = arg_2_2

	local var_2_0 = HXSet.autoHxShiftPath("live2d/" .. string.lower(arg_2_1), nil, true)
	local var_2_1 = BundleWizard.Inst:GetGroupMgr("L2D"):CheckF(var_2_0)

	warning("OnCheckToUpdate state = " .. tostring(var_2_1))

	if var_2_1 == DownloadState.CheckToUpdate or var_2_1 == DownloadState.UpdateFailure then
		self:OnCheckToUpdate(var_2_0)
	else
		self:OnUpdated(var_2_0, arg_2_2)
	end

	return
end

function ShipProfileLive2dBtn:OnCheckToUpdate(arg_3_1)
	setActive(self.live2dBtn, true)
	setActive(self.live2dState, false)
	setActive(self.live2dToggle, true)
	setActive(self.live2dOn, false)
	setActive(self.live2dOff, true)
	onButton(self, self.live2dBtn, function()
		local var_4_0 = "L2D"
		local var_4_1 = {
			arg_3_1
		}
		local var_4_2 = "L2D" .. arg_3_1

		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_NORMAL,
			content = string.format(i18n("group_download_tip", (HashUtil.BytesToString((GroupHelper.CalcSizeWithFileArr("L2D", var_4_1)))))),
			onYes = function()
				BundleWizardUpdater.Inst:StartUpdate((BundleWizardUpdater.Inst:CreateListInfo(var_4_2, BundleWizardUpdater.Inst:GetFileList(var_4_0, var_4_1), nil, function(arg_6_0, arg_6_1)
					if not self.isDisposed then
						self.isOn = arg_6_0

						self:OnUpdated(arg_3_1, self.isOn)
					end

					return
				end, nil)))

				return
			end
		})

		return
	end, SFX_PANEL)

	return
end

function ShipProfileLive2dBtn:OnUpdated(arg_7_1, arg_7_2)
	local var_7_0 = checkABExist(arg_7_1)

	warning("fileExist = " .. tostring(var_7_0))
	setActive(self.live2dBtn, var_7_0)
	setActive(self.live2dState, false)
	setActive(self.live2dToggle, true)
	setActive(self.live2dOn, arg_7_2)
	setActive(self.live2dOff, not arg_7_2)
	onButton(self, self.live2dBtn, function()
		if Live2dConst.GetLive2DArm32MatchAble() then
			Live2dConst.ShowLive2DArm32Tips()
		end

		self:Update(self.paintingName, not self.isOn)

		return
	end, SFX_PANEL)

	if self.callback then
		self.callback(self.isOn)
	end

	return
end

function ShipProfileLive2dBtn:Disable()
	if self.isOn then
		triggerButton(self.live2dBtn)
	end

	return
end

function ShipProfileLive2dBtn:SetEnable(arg_10_1)
	setButtonEnabled(self.live2dBtn, arg_10_1)

	return
end

function ShipProfileLive2dBtn:AddListener(arg_11_1)
	self.callback = arg_11_1

	return
end

function ShipProfileLive2dBtn:Dispose()
	self.callback = nil
	self.isDisposed = true

	pg.DelegateInfo.Dispose(self)

	return
end

return ShipProfileLive2dBtn
