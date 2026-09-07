local WorldbossPtBtn = class("WorldbossPtBtn")

function WorldbossPtBtn:Ctor(arg_1_1)
	pg.DelegateInfo.New(self)

	self.ptTF = arg_1_1
	self.pt = arg_1_1:Find("Text"):GetComponent(typeof(Text))
	self.ptRecoveTF = arg_1_1:Find("time")
	self.ptRecove = arg_1_1:Find("time/Text"):GetComponent(typeof(Text))

	self:Init()

	return
end

function WorldbossPtBtn:Init()
	self.ptRecoveTFFlag = false

	onButton(self, self.ptTF, function()
		self.ptRecoveTFFlag = not self.ptRecoveTFFlag

		setActive(self.ptRecoveTF, self.ptRecoveTFFlag)

		return
	end, SFX_PANEL)
	setActive(self.ptRecoveTF, self.ptRecoveTFFlag)
	self:Update()

	return
end

function WorldbossPtBtn:Update()
	local var_4_0 = nowWorld():GetBossProxy()

	self.pt.text = (var_4_0.pt or 0) .. "/" .. var_4_0:GetMaxPt()
	self.ptRecove.text = i18n("world_boss_pt_recove_desc", pg.gameset.joint_boss_ap_recove_cnt_pre_day.key_value)

	return
end

function WorldbossPtBtn:Dispose()
	pg.DelegateInfo.Dispose(self)

	return
end

return WorldbossPtBtn
