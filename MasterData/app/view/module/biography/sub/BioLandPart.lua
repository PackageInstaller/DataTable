local var_0_0 = g.core.model.User.bioData
local BioLandPart = class("BioLandPart", require("app.fairyGUI.biography.UI_BioLandPart"))

function BioLandPart:ctor()
	self._ownerStage = nil
	self._landOpenArr = nil
	self._curSelectIndex = 0
	self.m_openBtnState = self.m_openBtn:getController("state")

	self:_initDefaultData()
	self:_initRegisterUI()
end

function BioLandPart:onLoad()
	return
end

function BioLandPart:onUnload()
	self._ownerStage = nil
end

function BioLandPart:startUp(arg_4_1)
	self._ownerStage = arg_4_1
end

function BioLandPart:changeToLand(arg_5_1)
	for iter_5_0, iter_5_1 in ipairs(self._landOpenArr) do
		if iter_5_1.name == arg_5_1.name then
			self._curSelectIndex = iter_5_0 - 1

			self.m_landList:setSelectedIndex(self._curSelectIndex)
			self.m_landList:scrollToView(self._curSelectIndex)

			break
		end
	end
end

function BioLandPart:_initDefaultData()
	self._landOpenArr = {}

	for iter_6_0, iter_6_1 in ipairs((var_0_0:getLands())) do
		table.insert(self._landOpenArr, iter_6_1)

		if not iter_6_1.finish and not iter_6_1.fighting then
			break
		end
	end
end

function BioLandPart:_initRegisterUI()
	self.m_openBtn:addClickListener(handler(self, self._onOpenListClick))
	self.m_switchController:setSelectedIndex(1)
	self.m_openTransition:playReverse()
	self.m_landList:setVirtual()
	self.m_landList:setItemRenderer(handler(self, self._onRenderLandList))
	self.m_landList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onLandItemClick))
end

function BioLandPart:_onOpenListClick()
	if self.m_openBtnState:getSelectedIndex() == 0 then
		self.m_openBtnState:setSelectedIndex(1)
		self.m_openTransition:play()
		self.m_landList:setNumItems(#self._landOpenArr)
		self.m_landList:animateShowCells()
	else
		self.m_openTransition:playReverse()
		self.m_openBtnState:setSelectedIndex(0)
	end
end

function BioLandPart:_onRenderLandList(arg_9_1, arg_9_2)
	arg_9_2:updateData(self._landOpenArr[arg_9_1 + 1])
end

function BioLandPart:_onLandItemClick(arg_10_1)
	local var_10_0 = arg_10_1:getDataValue()

	if self._curSelectIndex == var_10_0 then
		return
	end

	local var_10_1 = var_0_0:getCurLandIndex()

	if var_10_1 < var_10_0 + 1 then
		g.core.module.ModuleManager:tip((g.core.lang:get(302008, {
			name = self._landOpenArr[var_10_1].name
		})))
		self.m_landList:setSelectedIndex(self._curSelectIndex)
	else
		self._curSelectIndex = var_10_0

		if self._ownerStage then
			self._ownerStage:changeToPage(self._curSelectIndex)
		end
	end
end

return BioLandPart
