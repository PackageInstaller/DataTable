local PileGameSignedLayer = class("PileGameSignedLayer", import("...base.BaseUI"))

function PileGameSignedLayer:getUIName()
	return "PileSignedUI"
end

function PileGameSignedLayer:SetData(arg_2_1)
	self.data = arg_2_1
	self.ultimate = arg_2_1.ultimate
	self.usedtime = arg_2_1.usedtime

	return
end

function PileGameSignedLayer:init()
	self.icons = {
		self._tf:Find("bg/icon/npc1"),
		self._tf:Find("bg/icon/npc2"),
		self._tf:Find("bg/icon/npc3"),
		self._tf:Find("bg/icon/npc4"),
		self._tf:Find("bg/icon/npc5"),
		self._tf:Find("bg/icon/npc6"),
		self._tf:Find("bg/icon/npc7")
	}
	self.helpBtn = self._tf:Find("bg/btn/pngbtn_help")
	self.getBtn = self._tf:Find("bg/btn/btn_djlq")
	self.gotBtn = self._tf:Find("bg/btn/btn_ylq")
	self.parent = self._tf.parent

	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	return
end

function PileGameSignedLayer:didEnter()
	onButton(self, self._tf, function()
		self:emit(PileGameSignedLayer.ON_CLOSE)

		return
	end, SFX_PANEL)
	onButton(self, self.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.help_chunjie_stamp.tip
		})

		return
	end, SFX_PANEL)
	onButton(self, self.getBtn, function()
		if self.data:getConfig("reward_need") > self.usedtime then
			return
		end

		self:emit(PileGameSignedMediator.ON_GET_AWARD)

		return
	end, SFX_PANEL)
	self:UpdateIconDesc()
	self:UpdateSigned()

	return
end

function PileGameSignedLayer:UpdateIconDesc()
	for iter_8_0, iter_8_1 in ipairs(self.icons) do
		onButton(self, iter_8_1, function()
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				content = i18n("special_animal" .. iter_8_0)
			})

			return
		end, SFX_PANEL)
	end

	return
end

function PileGameSignedLayer:UpdateSigned()
	local var_10_0 = self.data:getConfig("reward_need")
	local var_10_1 = self.usedtime
	local var_10_2 = self.ultimate == 0

	setActive(self.getBtn, self.ultimate == 0)
	setActive(self.gotBtn, not var_10_2)
	setGray(self.getBtn, var_10_2 and var_10_1 < var_10_0, true)

	for iter_10_0, iter_10_1 in ipairs(self.icons) do
		iter_10_1:GetComponent(typeof(Image)).color = iter_10_0 <= var_10_1 and Color.New(1, 1, 1, 1) or Color.New(1, 1, 1, 0.1)
	end

	return
end

function PileGameSignedLayer:willExit()
	self.icons = nil

	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self.parent)

	return
end

return PileGameSignedLayer
