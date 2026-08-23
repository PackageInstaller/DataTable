local BaseConst = require("app.view.base.const.BaseConst")
local var_0_1 = g.core.model.User.warriorsOfFateData
local var_0_2 = g.core.model.User.bioData
local BaseMapComp = class("BaseMapComp", require("app.fairyGUI.base_new.UI_BaseMapComp"))

function BaseMapComp:ctor(arg_1_1)
	self._lastItemIndex = 0
	self._landNum = 0
	self._landInfos = nil
	self._isShow = false
	self._onfoucesIndex = nil

	self.m_chapteList:setVirtual(self)
	self.m_chapteList:setItemRenderer(handler(self, self._onChapterRenderer))
	self:_bindCommonEvents()
end

function BaseMapComp:_bindCommonEvents()
	self.m_chapterLable:addClickListener(handler(self, self._onLabelClick))
	self.m_chapteList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onItemClick))
end

function BaseMapComp:_onLabelClick()
	self._isShow = not self._isShow

	if self._isShow then
		self:_updateChapterList()
	end

	self.m_chapterGroup:setVisible(self._isShow)

	if self._isShow and self._onfoucesIndex then
		self.m_chapteList:scrollToView(self._onfoucesIndex)
	end

	self.m_switchTransition:play()
end

function BaseMapComp:_updateChapterList()
	assert(type(self._mapCompType) ~= nil, "self._mapCompType is nil,must init first")

	if self._mapCompType == BaseConst.mapCompConst.WARRIORS then
		self._landNum, self._lastItemIndex = var_0_1:getActLandNum(self._subType)
		self._landInfos = var_0_1:getLandInfos(self._subType)
	elseif self._mapCompType == BaseConst.mapCompConst.BIOGRAPHY then
		self._landNum, self._lastItemIndex = var_0_2:getActLandNum(self._subType)
		self._landInfos = var_0_2:getLands()
	end

	self.m_chapteList:setNumItems(self._lastItemIndex)
	self.m_chapteList:setHeight(display.height)
end

function BaseMapComp:_onChapterRenderer(arg_5_1, arg_5_2)
	local var_5_2 = {}

	if self._mapCompType == BaseConst.mapCompConst.WARRIORS then
		local var_5_6 = #var_0_1:getActChaptersByLand(self._subType, arg_5_1 + 1)
		local var_5_7 = #var_0_1:getChaptersByLand(self._subType, arg_5_1 + 1)
		local var_5_8 = g.core.lang:get(105012, {
			num1 = var_5_6,
			num2 = var_5_7
		})

		var_5_2 = {
			id = arg_5_1 + 1,
			unlock = var_5_0,
			onfocus = var_5_4,
			title = g.core.lang:get(105011, {
				num1 = self._landInfos[arg_5_1 + 1].number,
				num2 = self._landInfos[arg_5_1 + 1].name
			}),
			num = (self._secondType and self._secondType == 1 or nil) and g.core.lang:get(105029, {
				num1 = var_5_6,
				num2 = var_5_7
			})
		}
	elseif self._mapCompType == BaseConst.mapCompConst.BIOGRAPHY then
		var_5_2 = clone(self._landInfos[arg_5_1 + 1])
		var_5_2.onfocus = var_5_4
		var_5_2.unlock = var_5_0
	end

	arg_5_2:update(var_5_2, self._mapCompType)
end

function BaseMapComp:_onItemClick(arg_6_1)
	local var_6_0 = arg_6_1:getDataValue()

	if var_6_0 + 1 == self._lastItemIndex and self._landNum ~= self._lastItemIndex then
		return
	end

	self:close()

	local var_6_1 = self._onfoucesIndex or 0

	self:dispatchCompEvent("MapComp_select", {
		pageIndex = var_6_0,
		prePageIndex = var_6_1,
		length = self._landNum
	})

	self._onfoucesIndex = var_6_0

	self:_updateChapterList()
end

function BaseMapComp:setType(arg_7_1, arg_7_2)
	self._subType = arg_7_1
	self._secondType = arg_7_2

	self:_updateChapterList()
end

function BaseMapComp:close()
	self._isShow = false

	if self.m_chapterGroup:isVisible() then
		self.m_switchTransition:playReverse()
		self:newScheduleOnce(function()
			self.m_chapterGroup:setVisible(false)
		end, 0.4)
	end
end

function BaseMapComp:setOnfocus(arg_10_1, arg_10_2, arg_10_3)
	self._mapCompType = arg_10_2 or BaseConst.mapCompConst.WARRIORS

	if arg_10_3 then
		self._subType = arg_10_3
	end

	self._onfoucesIndex = arg_10_1 or 0

	self:_updateChapterList()
end

function BaseMapComp:getIsVisible()
	return self.m_chapterGroup:isVisible()
end

function BaseMapComp:setName(arg_12_1)
	return self.m_chapterLable:setTitle(arg_12_1 or "")
end

return BaseMapComp
