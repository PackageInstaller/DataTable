local WSPortTaskDetail = class("WSPortTaskDetail", import("...BaseEntity"))

WSPortTaskDetail.Fields = {
	onCancel = "function",
	task = "table",
	transform = "userdata"
}

function WSPortTaskDetail:Setup()
	pg.DelegateInfo.New(self)
	self:Init()

	return
end

function WSPortTaskDetail:Dispose()
	pg.DelegateInfo.Dispose(self)
	self:Clear()

	return
end

function WSPortTaskDetail:Init()
	onButton(self, self.transform, function()
		self.onCancel()

		return
	end, SFX_CANCEL)
	onButton(self, self.transform:Find("top/btnBack"), function()
		self.onCancel()

		return
	end, SFX_CANCEL)

	return
end

function WSPortTaskDetail:UpdateTask(arg_6_1)
	self.task = arg_6_1

	setText(self.transform:Find("window/desc"), arg_6_1.config.description)

	local var_6_0 = arg_6_1:GetDisplayDrops()
	local var_6_1 = UIItemList.New(self.transform:Find("window/scrollview/list"), (self.transform:Find("window/scrollview/item")))

	var_6_1:make(function(arg_7_0, arg_7_1, arg_7_2)
		if arg_7_0 == UIItemList.EventUpdate then
			updateDrop(arg_7_2, var_6_0[arg_7_1 + 1])
			setScrollText(arg_7_2:Find("name_mask/name"), var_6_0[arg_7_1 + 1]:getConfig("name"))
		end

		return
	end)
	var_6_1:align(#var_6_0)

	return
end

return WSPortTaskDetail
