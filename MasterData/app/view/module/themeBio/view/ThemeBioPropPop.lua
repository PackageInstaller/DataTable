local ThemeBioPropPop = class("ThemeBioPropPop", require("app.fairyGUI.themeBio.UI_ThemeBioPropPop"), function()
	return fgui.GComponent:create({
		resName = "ThemeBioPropPop",
		pkgPath = "ui/themeBio/themeBio",
		pkgName = "themeBio"
	})
end)
local var_0_1 = g.core.config.theme_biography_item_info
local var_0_2 = g.core.common.Path
local var_0_3 = g.core.model.User.itemsData
local var_0_4 = g.core.common.Goods

function ThemeBioPropPop:ctor(arg_2_1)
	self._chapterId = arg_2_1
	self._selectItemIndex = 1

	self:showAtCenter()
	self.m_bagList:setVirtual()
	self.m_bagList:setItemRenderer(handler(self, self._onRenderItem))
	self.m_bagList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onClickItem))
end

function ThemeBioPropPop:_getData(arg_3_1)
	local var_3_0 = {}

	for iter_3_0, iter_3_1 in ipairs((var_0_3:getThemeBioPropData())) do
		if var_0_1.get(iter_3_1.id).chapter_id == arg_3_1 and iter_3_1.num > 0 then
			table.insert(var_3_0, iter_3_1)
		end
	end

	table.sort(var_3_0, function(arg_4_0, arg_4_1)
		local var_4_0 = var_0_1.get(arg_4_0.id)
		local var_4_1 = var_0_1.get(arg_4_1.id)

		if var_4_0.quality ~= var_4_1.quality then
			return var_4_0.quality > var_4_1.quality
		end

		return var_4_0.id > var_4_1.id
	end)

	return var_3_0
end

function ThemeBioPropPop:onLoad()
	self._data = self:_getData(self._chapterId)

	self.m_bagList:setNumItems1(#self._data, function()
		self.m_bagList:setSelectedIndex(self._selectItemIndex - 1)
	end)

	local var_5_0 = self._data[self._selectItemIndex]

	if self._data[self._selectItemIndex] then
		self:_showInfoGroup(var_5_0)
	end

	self.m_isEmptyController:setSelectedIndex(var_5_0 and 1 or 0)
	self.m_bagList:transitionShowCells("listIconUiScaleIn", 0.03, 1)
end

function ThemeBioPropPop:_onRenderItem(arg_7_1, arg_7_2)
	if self._data[arg_7_1 + 1] then
		arg_7_2:updateIcon({
			hideNum = false,
			type = var_0_4.TYPE_BIO,
			value = self._data[arg_7_1 + 1].id,
			size = self._data[arg_7_1 + 1].num
		})
	end
end

function ThemeBioPropPop:_onClickItem(arg_8_1)
	self._selectItemIndex = arg_8_1:getDataValue() + 1

	self:_showInfoGroup()
end

function ThemeBioPropPop:_showInfoGroup()
	if not self._data[self._selectItemIndex] then
		return
	end

	local var_9_0 = var_0_1.get(self._data[self._selectItemIndex].id)

	self.m_titleTxt:setText(var_9_0.name)
	self.m_decComp:getChild("textContent"):setText(var_9_0.description)
	self.m_iconLoader:setURL(var_0_2:getItemIconById(var_9_0.icon, false))
	self.m_picBgLoader:setURL(var_0_2:getBagNewQualityBgPath(var_9_0.quality))
	self.m_haveTxt:setText(self._data[self._selectItemIndex].num or 0)
end

return ThemeBioPropPop
