local var_0_0 = g.core.model.User.gveDataMgr
local var_0_1 = g.core.model.User.gveDataMgr:getGveData()
local GveMySitePop = class("GveMySitePop", require("app.fairyGUI.gve.UI_GveMySitePop"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/gve/gve",
		resName = "GveMySitePop",
		pkgName = "gve"
	}, ...)
end)

function GveMySitePop:ctor()
	var_0_1 = var_0_0:getGveData()
	self._bubbleComp = nil

	self:showAtCenter()
	self.m_mySiteList:setVirtual()
	self.m_mySiteList:setItemRenderer(handler(self, self._onSiteListRenderer))
	self.m_mySiteList:setItemProvider(handler(self, self._setListProvider))
	self.m_touchComp:addClickListener(handler(self, self._touchCompClick))
	self:addListen(self.m_mySiteList)
	self:showTouchMask(false)
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Page_Open_02)
end

function GveMySitePop:onLoad()
	self:updateShowListData()
	self:newSchedule(handler(self, self._scheduleUpdateCellTime), 1)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_G_VE_WORLDGIVEUPCELL, handler(self, self.updateShowListData), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_G_VE_WORLDCANCALGIVEUPCELL, handler(self, self.updateShowListData), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_G_VE_WORLDUSERDATAFLUSH, handler(self, self.updateShowListData), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_GVE_MY_GRID_CHANGE, handler(self, self.updateShowListData), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_G_VE_WORLDSETCELLKNIGHT, handler(self, self.updateShowListData), self)
end

function GveMySitePop:updateShowListData()
	local var_4_0 = {}
	local var_4_1 = var_0_1:getMySiteCtrlData()

	if var_4_1 then
		if var_4_1.small then
			table.insert(var_4_0, {
				title = g.core.lang:get(309113)
			})

			if #var_4_1.small == 0 then
				table.insert(var_4_0, {
					empty = true
				})
			else
				for iter_4_0, iter_4_1 in ipairs(var_4_1.small) do
					table.insert(var_4_0, {
						gridData = iter_4_1
					})
				end
			end
		end

		if var_4_1.middle then
			table.insert(var_4_0, {
				title = g.core.lang:get(309114)
			})

			if #var_4_1.middle == 0 then
				table.insert(var_4_0, {
					empty = true
				})
			else
				for iter_4_2, iter_4_3 in ipairs(var_4_1.middle) do
					table.insert(var_4_0, {
						gridData = iter_4_3
					})
				end
			end
		end

		if var_4_1.big then
			table.insert(var_4_0, {
				title = g.core.lang:get(309115)
			})

			if #var_4_1.big == 0 then
				table.insert(var_4_0, {
					empty = true
				})
			else
				for iter_4_4, iter_4_5 in ipairs(var_4_1.big) do
					table.insert(var_4_0, {
						gridData = iter_4_5
					})
				end
			end
		end
	end

	self._listData = var_4_0

	self.m_mySiteList:setNumItems(#self._listData)
end

function GveMySitePop:_setListProvider(arg_5_1)
	if not self:isIndexNotIsTitle(arg_5_1) then
		return "ui://gve/GveMySiteCell"
	else
		return "ui://gve/GveMySiteCell2"
	end
end

function GveMySitePop:isIndexNotIsTitle(arg_6_1)
	return self._listData[arg_6_1 + 1].title
end

function GveMySitePop:receiveCompEvent(arg_7_1, arg_7_2)
	if arg_7_1 == "GveOperateClick" or arg_7_1 == "GveGiveUpClick" or arg_7_1 == "GveDetailClick" then
		if not self._bubbleComp then
			self._bubbleComp = fgui.UIPackage:createObject("gve", "GveMySiteBubbleComp")

			self:addChild(self._bubbleComp)
			self:addListen(self._bubbleComp)
		else
			self._bubbleComp:setVisible(true)
		end

		self:showTouchMask(true)

		local var_7_0 = arg_7_2.confirmFunc
		local var_7_1 = self:globalToLocal(arg_7_2.comp:localToGlobal(cc.p(0, 0)))

		self._bubbleComp:setPosition(display.cx + var_7_1.x + arg_7_2.comp:getWidth(), display.cy + var_7_1.y + arg_7_2.comp:getHeight() / 2)

		local var_7_2 = {
			cancelCF = function()
				self:_touchCompClick()
			end,
			confirmCF = function()
				if var_7_0 then
					var_7_0()
				end

				self:_touchCompClick()
			end
		}

		var_7_2.confirmTitle = arg_7_2.confirmTitle or g.core.lang:get(300033)
		var_7_2.cancelTitle = g.core.lang:get(1037)

		self._bubbleComp:updateBtnState(var_7_2)
	end
end

function GveMySitePop:showTouchMask(arg_10_1)
	self.m_touchComp:setVisible(arg_10_1)
end

function GveMySitePop:_touchCompClick()
	self:showTouchMask(false)

	if self._bubbleComp then
		self._bubbleComp:setVisible(false)
	end
end

function GveMySitePop:_onSiteListRenderer(arg_12_1, arg_12_2)
	if not self:isIndexNotIsTitle(arg_12_1) then
		arg_12_2:updateGveSiteCell(self._listData[arg_12_1 + 1])
	else
		arg_12_2:setTitle(self._listData[arg_12_1 + 1].title)
	end
end

function GveMySitePop:_scheduleUpdateCellTime()
	for iter_13_0, iter_13_1 in ipairs((self.m_mySiteList:getChildren())) do
		if iter_13_1.updateGiveUpTsShow then
			iter_13_1:updateGiveUpTsShow()
		end
	end
end

function GveMySitePop:onUnload()
	self:cancelAllSchedule()
end

return GveMySitePop
