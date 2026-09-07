local IslandShipStatusPanel = class("IslandShipStatusPanel")

function IslandShipStatusPanel:Ctor(arg_1_1, arg_1_2)
	self.tf = arg_1_1
	self.emptyTf = arg_1_2
	self.state1Tr = findTF(arg_1_1, "1")
	self.state2Tr = findTF(arg_1_1, "2")
	self.state3Tr = findTF(arg_1_1, "3")
	self.viewBtn = findTF(arg_1_1, "view")

	return
end

function IslandShipStatusPanel:Flush(arg_2_1)
	local var_2_0 = arg_2_1:GetDisplayStatus()

	self:UpdateLayout(#var_2_0)
	self:UpdateStatus(var_2_0)
	setActive(self.emptyTf, #var_2_0 <= 0)
	setActive(self.tf, #var_2_0 > 0)

	return
end

function IslandShipStatusPanel:UpdateStatus(arg_3_1)
	setActive(self.viewBtn, #arg_3_1 > 0)
	self:UpdateStatusTpl(self.state1Tr, arg_3_1[1])
	self:UpdateStatusTpl(self.state2Tr, arg_3_1[2])
	self:UpdateStatusTpl(self.state3Tr, arg_3_1[3])

	return
end

function IslandShipStatusPanel:UpdateStatusTpl(arg_4_1, arg_4_2)
	setActive(arg_4_1, arg_4_2 ~= nil)

	if arg_4_2 then
		setText(arg_4_1:Find("Text"), arg_4_2:GetName())

		arg_4_1:GetComponent(typeof(Image)).color = arg_4_2:IsRed() and Color.New(1, 0.5490196, 0.5490196, 1) or Color.New(0.3137255, 0.6745098, 0.9372549, 1)
	end

	return
end

function IslandShipStatusPanel:UpdateLayout(arg_5_1)
	if arg_5_1 == 1 then
		setAnchoredPosition3D(self.state1Tr, {
			x = -16.7,
			y = -4.7
		})
		setAnchoredPosition3D(self.viewBtn, {
			x = 123,
			y = -22
		})
	elseif arg_5_1 == 2 then
		setAnchoredPosition3D(self.state1Tr, {
			x = -90,
			y = 11
		})
		setAnchoredPosition3D(self.state2Tr, {
			x = 56.7,
			y = -32
		})
		setAnchoredPosition3D(self.viewBtn, {
			x = 165,
			y = 0
		})
	elseif arg_5_1 > 2 then
		setAnchoredPosition3D(self.state1Tr, {
			x = -118.6,
			y = 15
		})
		setAnchoredPosition3D(self.state2Tr, {
			x = 132,
			y = 5.1
		})
		setAnchoredPosition3D(self.state3Tr, {
			x = -20.6,
			y = -31.8
		})
		setAnchoredPosition3D(self.viewBtn, {
			x = 188,
			y = -31.8
		})
	end

	return
end

function IslandShipStatusPanel:Dispose()
	return
end

return IslandShipStatusPanel
