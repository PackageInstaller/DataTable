local NewNavalTacticsStudentsPage = class("NewNavalTacticsStudentsPage", import("....base.BaseSubView"))
local var_0_1 = 1
local var_0_2 = 2
local var_0_3 = 3

function NewNavalTacticsStudentsPage:getUIName()
	return "NewNavalTacticsStudentsPage"
end

function NewNavalTacticsStudentsPage:OnUnlockSlot()
	self:Flush()

	return
end

function NewNavalTacticsStudentsPage:OnAddStudent()
	self:Flush()

	return
end

function NewNavalTacticsStudentsPage:OnExitStudent()
	self:Flush()

	return
end

function NewNavalTacticsStudentsPage:OnLoaded()
	self.helpBtn = self._tf:Find("help_btn")
	self.cards = {
		{},
		{},
		{}
	}

	table.insert(self.cards[var_0_1], NewNavalTacticsShipCard.New(self._tf:Find("info"), self.event))
	table.insert(self.cards[var_0_2], NewNavalTacticsEmptyCard.New(self._tf:Find("add"), self.event))
	table.insert(self.cards[var_0_3], NewNavalTacticsLockCard.New(self._tf:Find("lock"), self.event))

	return
end

function NewNavalTacticsStudentsPage:OnInit()
	onButton(self, self.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.tactics_lesson_system_introduce.tip
		})

		return
	end, SFX_PANEL)

	return
end

function NewNavalTacticsStudentsPage:Show(arg_8_1)
	NewNavalTacticsStudentsPage.super.Show(self)

	self.students = arg_8_1

	self:Flush()

	return
end

function NewNavalTacticsStudentsPage:Flush()
	local var_9_0 = {
		0,
		0,
		0
	}
	local var_9_1 = getProxy(NavalAcademyProxy):getSkillClassNum()

	for iter_9_0 = 1, NavalAcademyProxy.MAX_SKILL_CLASS_NUM do
		local var_9_2 = self:GetCardType(iter_9_0, var_9_1)

		var_9_0[var_9_2] = var_9_0[var_9_2] + 1

		self:UpdateTypeCard(var_9_2, var_9_0[var_9_2], iter_9_0)
	end

	for iter_9_1, iter_9_2 in ipairs(var_9_0) do
		self:ClearDisableCards(iter_9_1, iter_9_2)
	end

	return
end

function NewNavalTacticsStudentsPage:GetCardType(arg_10_1, arg_10_2)
	if arg_10_2 < arg_10_1 then
		return var_0_3
	else
		return (self.students[arg_10_1] or nil) and (var_0_1 or var_0_2)
	end

	return
end

function NewNavalTacticsStudentsPage:UpdateTypeCard(arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = self.cards[arg_11_1][arg_11_2]

	if not self.cards[arg_11_1][arg_11_2] then
		var_11_0 = self.cards[arg_11_1][1]:Clone()
		self.cards[arg_11_1][arg_11_2] = var_11_0
	end

	var_11_0:Enable()
	var_11_0:Update(arg_11_3, self.students[arg_11_3])

	return
end

function NewNavalTacticsStudentsPage:ClearDisableCards(arg_12_1, arg_12_2)
	for iter_12_0 = #self.cards[arg_12_1], arg_12_2 + 1, -1 do
		self.cards[arg_12_1][iter_12_0]:Disable()
	end

	return
end

function NewNavalTacticsStudentsPage:GetCard(arg_13_1)
	return underscore.detect(self.cards[var_0_1], function(arg_14_0)
		return arg_14_0.index == arg_13_1
	end)
end

function NewNavalTacticsStudentsPage:OnDestroy()
	for iter_15_0, iter_15_1 in ipairs(self.cards) do
		for iter_15_2, iter_15_3 in ipairs(iter_15_1) do
			iter_15_3:Dispose()
		end
	end

	self.cards = nil

	return
end

return NewNavalTacticsStudentsPage
