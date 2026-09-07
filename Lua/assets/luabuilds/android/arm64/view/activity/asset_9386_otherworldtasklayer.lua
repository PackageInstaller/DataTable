local OtherWorldTaskLayer = class("OtherWorldTaskLayer", import("..base.BaseUI"))

OtherWorldTaskLayer.sub_item_warning = "sub_item_warning"

local var_0_1 = "other_world_task_title"

function OtherWorldTaskLayer:getUIName()
	return "OtherWorldTaskUI"
end

function OtherWorldTaskLayer:init()
	self.activityId = ActivityConst.OTHER_WORLD_TASK_ID

	local var_2_0 = findTF(self._tf, "ad")

	self.btnBack = findTF(var_2_0, "btnBack")
	self.taskPage = OtherWorldTaskPage.New(findTF(var_2_0, "pages/taskPage"), self.contextData, findTF(var_2_0, "tpl"), self)

	pg.UIMgr.GetInstance():BlurPanel(self._tf)
	self.taskPage:setActive(true)

	return
end

function OtherWorldTaskLayer:didEnter()
	setText(findTF(self._tf, "ad/title/text"), i18n(var_0_1))
	onButton(self, self.btnBack, function()
		self:closeView()

		return
	end, SOUND_BACK)
	onButton(self, findTF(self._tf, "ad/pages/taskPage/clickClose"), function()
		self:closeView()

		return
	end, SFX_CANCEL)

	return
end

function OtherWorldTaskLayer:updateTask(arg_6_1)
	self.taskPage:updateTask(arg_6_1)

	return
end

function OtherWorldTaskLayer:willExit()
	self.taskPage:dispose()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	return
end

return OtherWorldTaskLayer
