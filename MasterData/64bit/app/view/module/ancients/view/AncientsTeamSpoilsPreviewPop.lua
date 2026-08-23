local AncientsTeamSpoilsPreviewPop = class("AncientsTeamSpoilsPreviewPop", require("app.fairyGUI.ancients.UI_AncientsTeamSpoilsPreviewPop"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/ancients/ancients",
		resName = "AncientsTeamSpoilsPreviewPop",
		pkgName = "ancients"
	}, ...)
end)

function var_0_0:ctor(arg_2_1)
	self:getView():center(true)

	self._awardGroupId = arg_2_1.groupId
	self._curQuality = 1
	self._showArr = {}

	self.m_List_award:setVirtual(self)
	self.m_List_award:setItemRenderer(handler(self, self._onRenderListAwardCell))
	self.m_tabController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onChangeTabCtrl))

	self._infoArr = {}

	for iter_2_0 = 1, g.core.config.ancients_award_info.getLength() do
		local var_2_0 = g.core.config.ancients_award_info.indexOf(iter_2_0)

		if var_2_0.award_group == self._awardGroupId then
			table.insert(self._infoArr, var_2_0)
		end
	end

	table.sort(self._infoArr, function(arg_3_0, arg_3_1)
		return arg_3_0.quality > arg_3_1.quality
	end)

	local var_2_1 = {
		self.m_Comp_tab1,
		self.m_Comp_tab2,
		self.m_Comp_tab3,
		self.m_Comp_tab4
	}

	for iter_2_1 = 1, #self._infoArr do
		var_2_1[iter_2_1]:setTitle(self._infoArr[iter_2_1].name)

		if self._infoArr[iter_2_1].quality == arg_2_1.quality then
			self.m_tabController:setSelectedIndex(iter_2_1 - 1)
		end
	end
end

function var_0_0:onLoad()
	self:_updateView()
end

function var_0_0:_onChangeTabCtrl()
	self._curQuality = self.m_tabController:getSelectedIndex() + 1

	self:_updateView()
end

function var_0_0:_updateView()
	self._showArr = g.core.model.User.ancientsData:getBoxGoodsArray(self._infoArr[self._curQuality].box)

	self.m_List_award:setNumItems(#self._showArr)
end

function var_0_0:_onRenderListAwardCell(arg_7_1, arg_7_2)
	arg_7_2:updateIcon({
		type = self._showArr[arg_7_1 + 1].type,
		value = self._showArr[arg_7_1 + 1].value,
		size = self._showArr[arg_7_1 + 1].size
	})
end

return var_0_0
