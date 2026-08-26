-- chunkname: @framework/mvc/view/ViewModalMaskMgr.lua

module("framework.mvc.view.ViewModalMaskMgr", package.seeall)

local ViewModalMaskMgr = class("ViewModalMaskMgr")

function ViewModalMaskMgr:ctor()
	self.DefaultMaskAlpha = 0
	self._maskGO = nil
	self._imgMask = nil
end

function ViewModalMaskMgr:init()
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, self._onOpenView, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, self._onOpenView, self)
	ViewMgr.instance:registerCallback(ViewEvent.ReOpenWhileOpen, self._onReOpenWhileOpen, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
end

function ViewModalMaskMgr:_onOpenView(viewName, viewParam)
	if ViewMgr.instance:isModal(viewName) then
		self:_adjustMask(viewName)
	elseif ViewMgr.instance:isFull(viewName) then
		self:_hideModalMask()
	end
end

function ViewModalMaskMgr:_onReOpenWhileOpen(viewName, viewParam)
	self:_onOpenView(viewName, viewParam)
end

function ViewModalMaskMgr:_onCloseViewFinish(viewName, viewParam)
	local isModal = ViewMgr.instance:isModal(viewName)

	if isModal then
		self:_hideModalMask()
	end

	if ViewMgr.instance:isFull(viewName) or isModal then
		local openViewNameList = ViewMgr.instance:getOpenViewNameList()

		for i = #openViewNameList, 1, -1 do
			local existViewName = openViewNameList[i]

			if ViewMgr.instance:isModal(existViewName) and ViewMgr.instance:isOpenFinish(existViewName) then
				self:_adjustMask(existViewName)

				break
			elseif ViewMgr.instance:isFull(existViewName) then
				break
			end
		end
	end
end

function ViewModalMaskMgr:_checkCreateMask()
	if gohelper.isNil(self._maskGO) then
		if self._isMaskCloneInit ~= true then
			self._isMaskCloneInit = true
			self._maskGO = gohelper.find("UIRoot/POPUP/ViewMask")
			self._maskCloneGO = gohelper.cloneInPlace(self._maskGO, "ViewMask_cloneGO")

			gohelper.setActive(self._maskCloneGO, false)
		else
			logError("ViewModalMaskMgr ViewMask 被销毁")

			self._maskGO = gohelper.cloneInPlace(self._maskCloneGO, "ViewMask")
		end

		self._imgMask = self._maskGO:GetComponent(gohelper.Type_Image)

		gohelper.setActive(self._maskGO, true)
		SLFramework.UGUI.UIClickListener.Get(self._maskGO):AddClickListener(self._onClickModalMask, self)

		self.DefaultMaskAlpha = self._imgMask.color.a
	end
end

function ViewModalMaskMgr:_adjustMask(viewName)
	self:_checkCreateMask()

	local viewContainer = ViewMgr.instance:getContainer(viewName)
	local setting = viewContainer:getSetting()
	local uiLayerGO = ViewMgr.instance:getUILayer(setting.layer)

	gohelper.addChild(uiLayerGO, self._maskGO)
	gohelper.setActive(self._maskGO, true)
	gohelper.setSiblingBefore(self._maskGO, viewContainer.viewGO)

	local customAlpha

	if not ((viewContainer.getCustomViewMaskAlpha or nil) and viewContainer:getCustomViewMaskAlpha()) then
		::label_7_0::

		local var_7_0 = setting.maskAlpha

		if not setting.maskAlpha then
			local color = self._imgMask.color

			color.a = self.DefaultMaskAlpha
			self._imgMask.color = color
		end
	end
end

function ViewModalMaskMgr:_hideModalMask()
	gohelper.setActive(self._maskGO, false)
end

function ViewModalMaskMgr:_onClickModalMask()
	local lastModalViewName
	local openViewNameList = ViewMgr.instance:getOpenViewNameList()

	for i = #openViewNameList, 1, -1 do
		local viewName = openViewNameList[i]

		if ViewMgr.instance:isModal(viewName) then
			lastModalViewName = viewName

			break
		elseif ViewMgr.instance:isFull(viewName) then
			break
		end
	end

	if lastModalViewName then
		if ViewMgr.instance:isOpenFinish(lastModalViewName) then
			local viewContainer = ViewMgr.instance:getContainer(lastModalViewName)

			viewContainer:onClickModalMaskInternal()
		else
			logNormal("modal view not open finish: " .. lastModalViewName)
		end
	else
		self:_hideModalMask()
		logError("no modal view belong to mask")
	end
end

ViewModalMaskMgr.instance = ViewModalMaskMgr.New()

return ViewModalMaskMgr
