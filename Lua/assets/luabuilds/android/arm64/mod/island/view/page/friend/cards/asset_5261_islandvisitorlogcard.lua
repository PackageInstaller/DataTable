local IslandVisitorLogCard = class("IslandVisitorLogCard")

function IslandVisitorLogCard:Ctor(arg_1_1)
	self.mainTr = arg_1_1.transform:Find("main")
	self.emptyTr = arg_1_1.transform:Find("empty")
	self.timeTxt = arg_1_1.transform:Find("main/time"):GetComponent(typeof(Text))
	self.nameTxt = arg_1_1.transform:Find("main/name"):GetComponent(typeof(Text))
	self.opTxt = arg_1_1.transform:Find("main/op"):GetComponent(typeof(Text))
	self.emptyTimeTxt = arg_1_1.transform:Find("empty/time"):GetComponent(typeof(Text))

	return
end

function IslandVisitorLogCard:Update(arg_2_1)
	local var_2_0 = arg_2_1.id == -1

	if arg_2_1.id == -1 then
		self:UpdateEmpty(arg_2_1)
	else
		self:UpdateMain(arg_2_1)
	end

	setActive(self.mainTr, not var_2_0)
	setActive(self.emptyTr, var_2_0)

	return
end

function IslandVisitorLogCard:UpdateEmpty(arg_3_1)
	self.emptyTimeTxt.text = arg_3_1:GetTimeWithoutHAndM()

	return
end

function IslandVisitorLogCard:UpdateMain(arg_4_1)
	self.timeTxt.text = arg_4_1:GetTime()
	self.nameTxt.text = arg_4_1:GetName()
	self.opTxt.text = arg_4_1:GetOpDesc()

	return
end

function IslandVisitorLogCard:Dispose()
	return
end

return IslandVisitorLogCard
