local WSPortTask = class("WSPortTask", import("...BaseEntity"))

WSPortTask.Fields = {
	btnOnGoing = "userdata",
	txDesc = "userdata",
	onDrop = "function",
	transform = "userdata",
	timer = "number",
	btnInactive = "userdata",
	btnFinished = "userdata",
	task = "table",
	rtRarity = "userdata",
	rtType = "userdata",
	progress = "userdata",
	txProgress = "userdata",
	onButton = "function",
	rtName = "userdata",
	rfAwardPanle = "userdata",
	rfItemTpl = "userdata"
}
WSPortTask.Listeners = {
	onTaskUpdate = "OnTaskUpdate"
}

function WSPortTask:Build(arg_1_1)
	pg.DelegateInfo.New(self)
	self:Init(arg_1_1)

	return
end

function WSPortTask:Dispose()
	pg.DelegateInfo.Dispose(self)
	self:Clear()

	return
end

function WSPortTask:Init(arg_3_1)
	self.transform = arg_3_1
	self.rtType = arg_3_1:Find("type")
	self.rtRarity = arg_3_1:Find("rarity")
	self.rtName = arg_3_1:Find("name")
	self.txDesc = arg_3_1:Find("desc")
	self.btnInactive = arg_3_1:Find("button/inactive")
	self.btnOnGoing = arg_3_1:Find("button/ongoing")
	self.btnFinished = arg_3_1:Find("button/finished")
	self.progress = arg_3_1:Find("name/slider")
	self.txProgress = arg_3_1:Find("name/slider_progress")
	self.rfAwardPanle = arg_3_1:Find("award_panel/content")
	self.rfItemTpl = arg_3_1:Find("item_tpl")

	return
end

function WSPortTask:Setup(arg_4_1)
	self.task = arg_4_1

	self:OnTaskUpdate()

	return
end

function WSPortTask:OnTaskUpdate()
	setImageColor(self.rtName, self.task.config.type == 5 and Color(0.058823529411764705, 0.0784313725490196, 0.10980392156862745, 0.3) or Color(0.5450980392156862, 0.596078431372549, 0.8196078431372549, 0.3))
	setText(self.rtName:Find("Text"), self.task.config.name)
	setText(self.txDesc, self.task.config.description)
	GetImageSpriteFromAtlasAsync("ui/worldportui_atlas", pg.WorldToastMgr.Type2PictrueName[self.task.config.type], self.rtType, true)
	GetImageSpriteFromAtlasAsync("ui/worldportui_atlas", "rarity_" .. self.task.config.rank, self.rtRarity, true)
	removeAllChildren(self.rfAwardPanle)

	for iter_5_0, iter_5_1 in ipairs(self.task.config.show) do
		local var_5_0 = cloneTplTo(self.rfItemTpl, self.rfAwardPanle)
		local var_5_1 = {
			type = iter_5_1[1],
			id = iter_5_1[2],
			count = iter_5_1[3]
		}

		updateDrop(var_5_0, var_5_1)
		onButton(self, var_5_0, function()
			self.onDrop(var_5_1)

			return
		end, SFX_PANEL)
		setActive(var_5_0, true)
	end

	setActive(self.rfItemTpl, false)

	local var_5_2 = self.task:getState()

	setActive(self.btnInactive, var_5_2 == WorldTask.STATE_INACTIVE)
	setActive(self.btnOnGoing, var_5_2 == WorldTask.STATE_ONGOING)
	setActive(self.btnFinished, var_5_2 == WorldTask.STATE_FINISHED)
	setActive(self.txProgress, false)
	setActive(self.progress, false)

	return
end

return WSPortTask
