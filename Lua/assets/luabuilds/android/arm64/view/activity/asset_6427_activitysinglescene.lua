local ActivitySingleScene = class("ActivitySingleScene", import("..base.BaseUI"))

ActivitySingleScene.EXIT = "exit"

function ActivitySingleScene:preload(arg_1_1)
	arg_1_1()

	return
end

function ActivitySingleScene:getUIName()
	return "ActivitySingleUI"
end

function ActivitySingleScene:init()
	self.shareData = ActivityShareData.New()
	self.pageContainer = self._tf

	pg.UIMgr.GetInstance():OverlayPanel(self._tf)

	return
end

function ActivitySingleScene:didEnter()
	self:bind(ActivitySingleScene.EXIT, function(arg_5_0)
		self:emit(ActivitySingleScene.ON_BACK)

		return
	end)

	return
end

function ActivitySingleScene:setPlayer(arg_6_1)
	self.shareData:SetPlayer(arg_6_1)

	return
end

function ActivitySingleScene:setFlagShip(arg_7_1)
	self.shareData:SetFlagShip(arg_7_1)

	return
end

function ActivitySingleScene:updateTaskLayers()
	if not self.activity then
		return
	end

	self:updateActivity(self.activity)

	return
end

function ActivitySingleScene:selectActivity(arg_9_1)
	self.activity = arg_9_1

	local var_9_0 = arg_9_1:getConfig("page_info")

	if var_9_0.class_name and not arg_9_1:isEnd() then
		self.actPage = import("view.activity.subPages." .. var_9_0.class_name).New(self.pageContainer, self.event, self.contextData)

		if self.actPage:UseSecondPage(arg_9_1) then
			self.actPage:SetUIName(var_9_0.ui_name2)
		else
			self.actPage:SetUIName(var_9_0.ui_name)
		end

		self.actPage:SetShareData(self.shareData)
		self.actPage:Load()
		self.actPage:ActionInvoke("Flush", self.activity)
		self.actPage:ActionInvoke("ShowOrHide", true)
	end

	return
end

function ActivitySingleScene:updateActivity(arg_10_1)
	if ActivityConst.PageIdLink[arg_10_1.id] then
		arg_10_1 = getProxy(ActivityProxy):getActivityById(ActivityConst.PageIdLink[arg_10_1.id])
	end

	if arg_10_1:isShow() then
		if arg_10_1:isCorePage(self.contextData.coreName or "") and not arg_10_1:isEnd() and self.activity and self.activity.id == arg_10_1.id then
			self.activity = arg_10_1

			self.actPage:ActionInvoke("Flush", arg_10_1)
		end
	end

	return
end

function ActivitySingleScene:onBackPressed()
	self.actPage:ActionInvoke("onBackPressed")
	self:emit(ActivitySingleScene.ON_BACK_PRESSED)

	return
end

function ActivitySingleScene:willExit()
	self.shareData = nil

	if self.actPage then
		self.actPage:Destroy()
	end

	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	return
end

return ActivitySingleScene
