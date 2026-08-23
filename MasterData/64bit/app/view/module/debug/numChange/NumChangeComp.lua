local DebugConst = require("app.view.module.debug.const.DebugConst")
local NumChangeComp = class("NumChangeComp", require("app.fairyGUI.debug.UI_NumChangeComp"))

function NumChangeComp:ctor()
	self:_addUIListener()
	self:reset()
	self:_initData()
end

function NumChangeComp:_isPut(arg_2_1, arg_2_2)
	for iter_2_0, iter_2_1 in pairs(require("app.view.module.home.const.HomeConst").GM_UNPUT_INFO_LIST) do
		if iter_2_0 == self._targetTabName then
			for iter_2_2, iter_2_3 in pairs(iter_2_1) do
				if arg_2_2[iter_2_2] == 0 then
					return false
				end
			end

			break
		end
	end

	return true
end

function NumChangeComp:_initData()
	self._dataArr = {}

	local var_3_0 = {}

	for iter_3_0, iter_3_1 in ipairs(DebugConst.TOOL.SEND_DATA_LIST) do
		local var_3_1 = {
			type = iter_3_1[1],
			typeName = iter_3_1[2],
			subItems = {}
		}

		if iter_3_1[3] ~= nil then
			for iter_3_2 = 1, g.core.config[iter_3_1[3]].getLength() do
				local var_3_2 = g.core.config[iter_3_1[3]].indexOf(iter_3_2)

				if (not g.core.config[iter_3_1[3]].hasKey("gm") or var_3_2.gm == 1) and self:_isPut(iter_3_1[3], var_3_2) then
					local var_3_3 = {
						name = "",
						type = var_3_1.type,
						id = var_3_2.id
					}

					if var_3_1.type == 36 then
						var_3_3.id = var_3_2.advance_id
					end

					if g.core.config[iter_3_1[3]].hasKey("name") then
						var_3_3.name = var_3_2.name
					end

					var_3_1.subItems[#var_3_1.subItems + 1] = var_3_3
				end
			end
		else
			var_3_1.subItems = {
				{
					name = "异极石",
					id = 0,
					type = var_3_1.type
				},
				{
					name = "付费钻",
					id = 1,
					type = var_3_1.type
				}
			}
		end

		self._dataArr[#self._dataArr + 1] = var_3_1
		var_3_0[#var_3_0 + 1] = var_3_1.type .. "(" .. var_3_1.typeName .. ")"
	end

	self.m_typeDropBox:setItems(var_3_0)
end

function NumChangeComp:_addUIListener()
	self.m_list:setVirtual()
	self.m_list:setItemRenderer(handler(self, self._onSendListItemRender))
	self.m_typeDropBox:addEventListener(fgui.UIEventType.Changed, handler(self, self._onTypeDropChanged))
	self.m_valueDropBox:addEventListener(fgui.UIEventType.Changed, handler(self, self._onValueDropChanged))
	self.m_searchDropBox:addEventListener(fgui.UIEventType.Changed, handler(self, self._onSearchDropChanged))
	self.m_recordDropBox:addEventListener(fgui.UIEventType.Changed, handler(self, self._onRecordDropChanged))
	self.m_btnAdd:addClickListener(handler(self, self._onAddBtnClick))
	self.m_btnAddEach:addClickListener(handler(self, self._onAddEachBtnClick))
	self.m_inputAddBtn:addClickListener(handler(self, self._onInputAddBtnClick))
	self.m_searchBtn:addClickListener(handler(self, self._onSearchBtnClick))
	self.m_btnSave:addClickListener(handler(self, self._onSaveBtnClick))
	self.m_recordDeleteBtn:addClickListener(handler(self, self._onRecordDeleteBtnClick))
	self.m_btnAddSend:addClickListener(handler(self, self._onAddSendBtnClick))
	self.m_btnDeleteSend:addClickListener(handler(self, self._onDeleteSendBtnClick))
	self.m_btnClear:addClickListener(handler(self, self._onClearBtnClick))
	self.m_deleteBtn:addClickListener(handler(self, self._onDeleteBtnClick))
	self.m_btnClearBag:addClickListener(handler(self, self._onClearBagBtnClick))
end

function NumChangeComp:_resetOther()
	self._dataArr = nil
	self._typeIndex = -1
	self._valueIndex = -1
	self._lastSelectInfo = nil
	self._curData = nil
	self._searchDatas = nil
	self._searchData = nil
	self._recordList = nil
	self._sendList = {}
end

function NumChangeComp:_resetUI()
	self.m_list:setNumItems(0)
	self:_updateItem(self.m_titleItem, {
		"index",
		"type",
		"desc",
		"value",
		"desc",
		"size"
	})

	local var_6_0 = g.core.common.Storage:load("item_record.json", false) or {}
	local var_6_1 = self.m_recordDropBox:getSelectedIndex() + 1

	if not var_6_0.index then
		-- block empty
	end

	self._recordList = {}

	for iter_6_0, iter_6_1 in pairs(var_6_0) do
		local var_6_3 = tonumber(iter_6_0)

		if var_6_3 then
			self._recordList[var_6_3] = iter_6_1.name
		end
	end

	self.m_recordDropBox:setItems(self._recordList)
end

function NumChangeComp:reset()
	self:_resetOther()
	self:_resetUI()
end

function NumChangeComp:_onTypeDropChanged()
	self._typeIndex = self.m_typeDropBox:getSelectedIndex() + 1

	local var_8_0 = {}

	for iter_8_0, iter_8_1 in ipairs(self._dataArr[self._typeIndex].subItems) do
		var_8_0[#var_8_0 + 1] = iter_8_1.id .. "(" .. iter_8_1.name .. ")"
	end

	self.m_valueDropBox:setItems(var_8_0)
	self.m_valueDropBox:refresh()
	self:_onValueDropChanged()

	if #var_8_0 == 0 then
		self._curData = {
			name = "",
			id = 0,
			type = self._dataArr[self._typeIndex].type
		}

		return
	end
end

function NumChangeComp:_onValueDropChanged()
	if self._typeIndex < 1 then
		return
	end

	self._valueIndex = self.m_valueDropBox:getSelectedIndex() + 1
	self._curData = self._dataArr[self._typeIndex].subItems[self._valueIndex]
end

function NumChangeComp:_onSearchDropChanged()
	if not self._searchDatas then
		if self._lastSelectInfo then
			self.m_typeDropBox:setSelectedIndex(self._lastSelectInfo.type)
			self.m_valueDropBox:setSelectedIndex(self._lastSelectInfo.value)
		end

		self._searchData = nil
		self._lastSelectInfo = nil

		return
	end

	if not self._lastSelectInfo and self._typeIndex > 0 then
		self._lastSelectInfo = {
			type = self._typeIndex,
			value = self._valueIndex
		}
	end

	self._searchData = self._searchDatas[self.m_searchDropBox:getSelectedIndex() + 1]

	self.m_typeDropBox:setSelectedIndex(self._searchData.typeIdx)
	self:_onTypeDropChanged()
	self.m_valueDropBox:setSelectedIndex(self._searchData.valueIdx)
	self:_onValueDropChanged()
end

function NumChangeComp:_onRecordDropChanged()
	if not self._recordList then
		return
	end

	local var_11_0 = self.m_recordDropBox:getSelectedIndex()

	self:_clearSendList()

	for iter_11_0, iter_11_1 in pairs((g.core.common.Storage:load("item_record.json", false) or {})[tostring(var_11_0 + 1)]) do
		if tonumber(iter_11_0) then
			self:_addItemToListAndRefreshUI({
				type = tonumber(iter_11_1[2]),
				typeDes = iter_11_1[3],
				value = tonumber(iter_11_1[4]),
				name = iter_11_1[5],
				size = tonumber(iter_11_1[6])
			})
		end
	end
end

function NumChangeComp:_checkAndFixContent(arg_12_1)
	self._changeSchedule = nil

	local var_12_0 = {}

	for iter_12_0 = 1, #self._sendList do
		self._sendList[iter_12_0][1] = iter_12_0
		var_12_0[self._sendList[iter_12_0][2]] = (var_12_0[self._sendList[iter_12_0][2]] or 0) + tonumber(self._sendList[iter_12_0][6])
	end

	local var_12_1 = var_12_0[arg_12_1.type] or 0
	local var_12_2 = self:_checkAndFixNum(arg_12_1.type, arg_12_1.value, arg_12_1.size + var_12_1)

	if var_12_2 > 0 then
		var_12_2 = var_12_2 - var_12_1
	end

	return var_12_2
end

function NumChangeComp:_checkAndFixNum(arg_13_1, arg_13_2, arg_13_3)
	local var_13_1

	arg_13_3, var_13_1 = g.core.model.User.bagData:checkAndFixBagLeftNum(tonumber(arg_13_1), tonumber(arg_13_3))

	if arg_13_3 <= 0 then
		arg_13_3 = 0
	end

	return arg_13_3, var_13_1
end

function NumChangeComp:_onSendListItemRender(arg_14_1, arg_14_2)
	self:_updateItem(arg_14_2, self._sendList[arg_14_1 + 1])
end

function NumChangeComp:_updateItem(arg_15_1, arg_15_2)
	for iter_15_0 = 1, 6 do
		arg_15_1:getChild("n" .. iter_15_0):setText(arg_15_2[iter_15_0])
	end
end

function NumChangeComp:_addItemToList(arg_16_1)
	local var_16_0 = {
		#self._sendList + 1,
		arg_16_1.type
	}

	var_16_0[3] = arg_16_1.typeDes or self._dataArr[self._typeIndex + 1].typeName
	var_16_0[4] = arg_16_1.value
	var_16_0[5] = arg_16_1.name
	var_16_0[6] = arg_16_1.size
	self._sendList[#self._sendList + 1] = var_16_0
end

function NumChangeComp:_addItemToListAndRefreshUI(arg_17_1)
	if self:_checkAndFixContent(arg_17_1) == 0 then
		return
	end

	self:_addItemToList(arg_17_1)
	self.m_list:setNumItems(#self._sendList)
end

function NumChangeComp:_removeItemContentFormList(arg_18_1)
	table.remove(self._sendList, arg_18_1)
	self.m_list:setNumItems(#self._sendList)
end

function NumChangeComp:_clearSendList()
	self._sendList = {}

	self.m_list:setNumItems(0)
end

function NumChangeComp:_onAddBtnClick()
	local var_20_0 = self._curData or self._searchData
	local var_20_1

	for iter_20_0, iter_20_1 in ipairs(self._dataArr) do
		if iter_20_1.type == var_20_0.type then
			var_20_1 = iter_20_1.typeName
		end
	end

	self:_addItemToListAndRefreshUI({
		type = var_20_0.type,
		value = var_20_0.id,
		name = var_20_0.name,
		size = self.m_dropSizeInput:getText(),
		typeDes = var_20_1
	})
end

function NumChangeComp:_onAddEachBtnClick()
	if self._typeIndex < 1 then
		return
	end

	self._valueIndex = self.m_valueDropBox:getSelectedIndex() + 1

	local var_21_0

	if self._typeIndex == 5 then
		var_21_0 = g.core.config.knight_favorability_info
	end

	for iter_21_0 = 1, #self._dataArr[self._typeIndex].subItems do
		local var_21_1

		for iter_21_1, iter_21_2 in ipairs(self._dataArr) do
			if iter_21_2.type == self._dataArr[self._typeIndex].subItems[iter_21_0].type then
				var_21_1 = iter_21_2.typeName
			end
		end

		if not var_21_0 or var_21_0.fetch(self._dataArr[self._typeIndex].subItems[iter_21_0].id) then
			self:_addItemToListAndRefreshUI({
				type = self._dataArr[self._typeIndex].subItems[iter_21_0].type,
				value = self._dataArr[self._typeIndex].subItems[iter_21_0].id,
				name = self._dataArr[self._typeIndex].subItems[iter_21_0].name,
				size = self.m_dropSizeInput:getText(),
				typeDes = var_21_1
			})
		else
			print("not pass check------->")
			print(self._dataArr[self._typeIndex].subItems[iter_21_0].id)
		end
	end
end

function NumChangeComp:_onSearchBtnClick()
	local var_22_0 = self.m_searchInput:getText()

	if not var_22_0 or #var_22_0 < 1 then
		return
	end

	self._searchDatas = {}

	local var_22_1 = {}

	for iter_22_0, iter_22_1 in ipairs(self._dataArr) do
		for iter_22_2, iter_22_3 in ipairs(iter_22_1.subItems) do
			if string.find(iter_22_3.name, var_22_0) then
				self._searchDatas[#self._searchDatas + 1] = {
					type = iter_22_1.type,
					typeDes = iter_22_1.typeName,
					iter_22_3.id,
					name = iter_22_3.name,
					typeIdx = iter_22_0 - 1,
					valueIdx = iter_22_2 - 1
				}
				var_22_1[#var_22_1 + 1] = iter_22_3.name .. "|" .. iter_22_1.type .. "|" .. iter_22_3.id
			end
		end
	end

	self.m_searchDropBox:setItems(var_22_1)
end

function NumChangeComp:_onInputAddBtnClick()
	local var_23_0 = self.m_typeInput:getText()
	local var_23_1 = self.m_valueInput:getText()

	if not var_23_0 or not var_23_1 then
		return
	end

	for iter_23_0, iter_23_1 in ipairs(self._dataArr) do
		if iter_23_1.type == tonumber(var_23_0) then
			for iter_23_2, iter_23_3 in pairs(iter_23_1.subItems) do
				if iter_23_3.id == tonumber(var_23_1) then
					self:_addItemToListAndRefreshUI({
						type = tonumber(var_23_0),
						value = tonumber(var_23_1),
						name = iter_23_3.name,
						size = self.m_dropSizeInput:getText(),
						typeDes = iter_23_1.typeName
					})

					break
				end
			end
		end
	end
end

function NumChangeComp:_onSaveBtnClick()
	if #self._sendList == 0 then
		return
	end

	local var_24_0 = g.core.common.Storage:load("item_record.json", false) or {}
	local var_24_1 = var_24_0.index or 1

	self._sendList.name = "记录" .. var_24_1
	var_24_0[var_24_1] = self._sendList
	var_24_0.index = var_24_1 + 1

	g.core.common.Storage:save("item_record.json", var_24_0, false)

	self._recordList = {}

	for iter_24_0, iter_24_1 in pairs(var_24_0) do
		local var_24_3 = tonumber(iter_24_0)

		if var_24_3 then
			self._recordList[var_24_3] = iter_24_1.name
		end
	end

	self.m_recordDropBox:setItems(self._recordList)
	self.m_recordDropBox:refresh()
end

function NumChangeComp:_onRecordDeleteBtnClick()
	local var_25_0 = g.core.common.Storage:load("item_record.json", false) or {}
	local var_25_1 = self.m_recordDropBox:getSelectedIndex() + 1

	while var_25_0[tostring(var_25_1)] do
		var_25_0[tostring(var_25_1)] = var_25_0[tostring(var_25_1 + 1)]
		var_25_1 = var_25_1 + 1
	end

	var_25_0.index = (var_25_0.index or 1) - 1
	self._recordList = {}

	for iter_25_0, iter_25_1 in pairs(var_25_0) do
		local var_25_2 = tonumber(iter_25_0)

		if var_25_2 then
			self._recordList[var_25_2] = iter_25_1.name
		end
	end

	self.m_recordDropBox:setItems(self._recordList)
	self.m_recordDropBox:refresh()
	g.core.common.Storage:save("item_record.json", var_25_0, false)
end

function NumChangeComp:_getSendListDatas()
	local var_26_0 = {}

	for iter_26_0, iter_26_1 in ipairs(self._sendList) do
		var_26_0[iter_26_0] = {
			type = iter_26_1[2],
			value = iter_26_1[4],
			size = tonumber(iter_26_1[6])
		}
	end

	return var_26_0
end

function NumChangeComp:_onAddSendBtnClick()
	if #self._sendList < 1 then
		return
	end

	self:_onSendTest((self:_getSendListDatas()))
end

function NumChangeComp:_onDeleteSendBtnClick()
	if #self._sendList < 1 then
		return
	end

	self:_onSendTest(nil, (self:_getSendListDatas()))
end

function NumChangeComp:_onClearBtnClick()
	self:_clearSendList()
end

function NumChangeComp:_onDeleteBtnClick()
	local var_30_0 = self.m_list:getSelectedIndex()

	if not var_30_0 or var_30_0 < 0 then
		return
	end

	self:_removeItemContentFormList(var_30_0 + 1)
end

function NumChangeComp:_onClearBagBtnClick()
	self._sendList = {}

	for iter_31_0, iter_31_1 in ipairs({
		g.core.common.Goods.TYPE_ITEM,
		g.core.common.Goods.TYPE_EQUIP,
		g.core.common.Goods.TYPE_TREASURE
	}) do
		for iter_31_2, iter_31_3 in ipairs((g.core.model.User.bagData:getList(iter_31_1))) do
			local var_31_0 = {
				name = "",
				typeDes = "",
				type = iter_31_1
			}

			var_31_0.size = iter_31_3.num or 1
			var_31_0.value = iter_31_3.id

			if not iter_31_3.position or iter_31_3.position == 0 then
				self:_addItemToList(var_31_0)
			end
		end
	end

	self:_onSendTest(nil, (self:_getSendListDatas()))
	self:_clearSendList()
end

function NumChangeComp:_onSendTest(arg_32_1, arg_32_2)
	g.core.network.GameNetProxy:send_C2S_Test({
		awards = arg_32_1,
		consumes = arg_32_2
	})
end

function NumChangeComp:onLoad()
	return
end

function NumChangeComp:onShow()
	self:setVisible(true)
end

function NumChangeComp:onHide()
	self:setVisible(false)
end

return NumChangeComp
