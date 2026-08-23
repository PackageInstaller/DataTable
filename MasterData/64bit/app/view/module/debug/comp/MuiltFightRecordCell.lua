local MuiltFightRecordCell = class("MuiltFightRecordCell", require("app.fairyGUI.debug.UI_MuiltFightRecordCell"))
local var_0_2 = require("app.view.module.debug.model.TestFightUtils").MARK_TYPE

function MuiltFightRecordCell:ctor()
	self._record = {}

	self.m_nameText:addEventListener(fgui.UIEventType.Submit, handler(self, self._onNameChange))
	self.m_saveBtn:addClickListener(handler(self, self._onClickSave))
	self.m_replaceBtn:addClickListener(handler(self, self._onClickReplace))
	self.m_mark1Btn:addClickListener(handler(self, self._onClickMark1))
	self.m_mark2Btn:addClickListener(handler(self, self._onClickMark2))
	self.m_delBtn:addClickListener(handler(self, self._onClickDel))
	self.m_upBtn:addClickListener(handler(self, self._onClickUp))
	self.m_downBtn:addClickListener(handler(self, self._onClickDown))
end

function MuiltFightRecordCell:updateRecordData(arg_2_1)
	self._record = arg_2_1

	local var_2_0 = arg_2_1:getName() or "存档名字"
	local var_2_1 = arg_2_1:getMarkType() or var_0_2.NONE

	self.m_nameText:setText(var_2_0)
	self.m_mark_typeController:setSelectedIndex(var_2_1)

	if var_2_1 == var_0_2.BASE then
		self.m_typeText:setText("基础阵容")
	elseif var_2_1 == var_0_2.ITER then
		self.m_typeText:setText("迭代阵容" .. arg_2_1:getOrder())
	else
		self.m_typeText:setText("")
	end
end

function MuiltFightRecordCell:_onNameChange()
	self._record:setName((self.m_nameText:getText()))
	self:dispatchCompEvent("RecordCell_update", {
		record = self._record
	})
end

function MuiltFightRecordCell:_onClickSave()
	self:dispatchCompEvent("RecordCell_save", {
		record = self._record
	})
end

function MuiltFightRecordCell:_onClickReplace()
	local var_5_0 = self._record:getFormation()

	if var_5_0.formations then
		local function var_5_1(arg_6_0, arg_6_1, arg_6_2)
			local var_6_0 = 0

			for iter_6_0, iter_6_1 in ipairs(arg_6_0) do
				if iter_6_1 == arg_6_1 then
					var_6_0 = iter_6_0

					break
				end
			end

			if arg_6_2 == 0 then
				if var_6_0 > 0 then
					arg_6_0[var_6_0] = 0
				end
			elseif var_6_0 == 0 then
				arg_6_0[arg_6_2] = arg_6_1
			else
				arg_6_0[arg_6_2], arg_6_0[var_6_0] = arg_6_0[var_6_0], arg_6_0[arg_6_2]
			end
		end

		local var_5_2 = {}

		for iter_5_0, iter_5_1 in ipairs((g.core.model.User.knightsData:getLineUpList())) do
			var_5_2[iter_5_1:getServerId()] = iter_5_1:getInfo().silk_bag or {}
		end

		local var_5_3 = var_5_0.formations.knight_id or {}
		local var_5_4 = {}

		for iter_5_2 = 1, g.core.const.ConstMgr.KNIGHT_CONST.KNIGHT_BACKUP_MAX do
			local var_5_5 = g.core.model.User.knightsData:getKnight({
				pos = iter_5_2
			})

			var_5_4[iter_5_2] = var_5_5 and var_5_5:getServerId() or 0
		end

		for iter_5_3, iter_5_4 in ipairs(var_5_3) do
			local var_5_6 = var_5_4[iter_5_3]

			if iter_5_4 > 0 then
				if var_5_6 ~= iter_5_4 then
					g.core.network.GameNetProxy:send_C2S_Formation_ChangeFormation({
						tp = 1,
						pos = iter_5_3,
						id = iter_5_4
					})
					var_5_1(var_5_4, iter_5_4, iter_5_3)
				end
			elseif var_5_6 > 0 then
				g.core.network.GameNetProxy:send_C2S_Formation_ChangeFormation({
					tp = 1,
					pos = 0,
					id = var_5_6
				})
				var_5_1(var_5_4, var_5_6, 0)
			end

			for iter_5_5 = iter_5_3, 6 do
				local var_5_7 = true

				if var_5_4[iter_5_5] == var_5_6 then
					var_5_7 = false

					break
				end

				if var_5_7 then
					var_5_2[var_5_6] = {}
				end
			end
		end

		if var_5_0.formations.position then
			local var_5_8 = false

			for iter_5_6, iter_5_7 in ipairs((g.core.model.User.formationData:getPositionList())) do
				if iter_5_7 ~= var_5_0.formations.position[iter_5_6] then
					var_5_8 = true

					break
				end
			end

			if var_5_8 then
				g.core.network.GameNetProxy:send_C2S_Formation_ChangePosition({
					position = var_5_0.formations.position
				})
			end
		end

		local var_5_9 = var_5_0.formations.artifact_id or {}
		local var_5_10 = {}

		for iter_5_8 = 1, 6 do
			local var_5_11 = g.core.model.User.artifactData:getArtifactByPos(iter_5_8)

			var_5_10[iter_5_8] = var_5_11 and var_5_11:getServerData().id or 0
		end

		for iter_5_9, iter_5_10 in ipairs(var_5_9) do
			if iter_5_10 > 0 then
				if var_5_10[iter_5_9] ~= iter_5_10 then
					g.core.network.GameNetProxy:send_C2S_Formation_ChangeFormation({
						tp = 5,
						pos = iter_5_9,
						id = iter_5_10
					})
					var_5_1(var_5_10, iter_5_10, iter_5_9)
				end
			elseif var_5_10[iter_5_9] > 0 then
				g.core.network.GameNetProxy:send_C2S_Formation_ChangeFormation({
					tp = 5,
					pos = 0,
					id = var_5_10[iter_5_9]
				})
				var_5_1(var_5_10, var_5_10[iter_5_9], 0)
			end
		end

		if var_5_0.helpArtifact then
			for iter_5_11 = 1, 6 do
				if var_5_10[iter_5_11] > 0 then
					local var_5_12 = g.core.model.User.artifactData:getArtifactBySid(var_5_10[iter_5_11])

					if var_5_12 and var_5_12:getAssistParId() > 0 and var_5_12:getAssistParId() ~= var_5_0.helpArtifact[iter_5_11] then
						g.core.network.GameNetProxy:send_C2S_Artifact_HelpDown({
							artifact_id = var_5_10[iter_5_11]
						})
					end
				end
			end

			for iter_5_12 = 1, 6 do
				if var_5_10[iter_5_12] > 0 and var_5_0.helpArtifact[iter_5_12] > 0 then
					local var_5_13 = g.core.model.User.artifactData:getArtifactBySid(var_5_10[iter_5_12])

					if var_5_13 and var_5_13:getAssistParId() ~= var_5_0.helpArtifact[iter_5_12] then
						g.core.network.GameNetProxy:send_C2S_Artifact_HelpDown({
							artifact_id = var_5_10[iter_5_12]
						})
					end
				end
			end
		end

		local var_5_14 = var_5_0.formations.equipment_id or {}
		local var_5_15 = {}

		for iter_5_13 = 1, 24 do
			local var_5_16 = g.core.model.User.equipmentData:getEquipIdByPos(iter_5_13)

			var_5_15[iter_5_13] = var_5_16 and var_5_16 > 0 and var_5_16 or 0
		end

		for iter_5_14, iter_5_15 in ipairs(var_5_14) do
			if iter_5_15 > 0 then
				if var_5_15[iter_5_14] ~= iter_5_15 then
					g.core.network.GameNetProxy:send_C2S_Formation_ChangeFormation({
						tp = 3,
						pos = iter_5_14,
						id = iter_5_15
					})
					var_5_1(var_5_15, iter_5_15, iter_5_14)
				end
			elseif var_5_15[iter_5_14] and var_5_15[iter_5_14] > 0 then
				g.core.network.GameNetProxy:send_C2S_Formation_ChangeFormation({
					tp = 3,
					pos = 0,
					id = var_5_15[iter_5_14]
				})
				var_5_1(var_5_15, var_5_15[iter_5_14], 0)
			end
		end

		local var_5_17 = var_5_0.formations.treasure_id or {}
		local var_5_18 = {}

		for iter_5_16 = 1, 12 do
			var_5_18[iter_5_16] = 0
		end

		for iter_5_17, iter_5_18 in pairs(g.core.model.User.treasureData:getTreasureData() or {}) do
			var_5_18[iter_5_18.position] = iter_5_17
		end

		for iter_5_19, iter_5_20 in ipairs(var_5_17) do
			if iter_5_20 > 0 then
				if var_5_18[iter_5_19] ~= iter_5_20 then
					g.core.network.GameNetProxy:send_C2S_Formation_ChangeFormation({
						tp = 4,
						pos = iter_5_19,
						id = iter_5_20
					})
					var_5_1(var_5_18, iter_5_20, iter_5_19)
				end
			elseif var_5_18[iter_5_19] > 0 then
				g.core.network.GameNetProxy:send_C2S_Formation_ChangeFormation({
					tp = 4,
					pos = 0,
					id = var_5_18[iter_5_19]
				})
				var_5_1(var_5_18, var_5_18[iter_5_19], 0)
			end
		end

		local var_5_19 = var_5_0.formations.pet_id or {}
		local var_5_20 = {}

		for iter_5_21 = 1, 6 do
			local var_5_21 = g.core.model.User.petsData:getPetByPos(iter_5_21)

			var_5_20[iter_5_21] = var_5_21 and var_5_21:getSid() or 0
		end

		for iter_5_22, iter_5_23 in ipairs(var_5_19) do
			if iter_5_23 > 0 then
				if var_5_20[iter_5_22] ~= iter_5_23 then
					g.core.network.GameNetProxy:send_C2S_Formation_ChangeFormation({
						tp = 6,
						pos = iter_5_22,
						id = iter_5_23
					})
					var_5_1(var_5_20, iter_5_23, iter_5_22)
				end
			elseif var_5_20[iter_5_22] > 0 then
				g.core.network.GameNetProxy:send_C2S_Formation_ChangeFormation({
					tp = 6,
					pos = 0,
					id = var_5_20[iter_5_22]
				})
				var_5_1(var_5_20, var_5_20[iter_5_22], 0)
			end
		end

		if var_5_0.helpPets then
			for iter_5_24 = 1, 6 do
				if var_5_20[iter_5_24] > 0 then
					local var_5_22 = g.core.model.User.petsData:getPetBySid(var_5_20[iter_5_24])

					if var_5_22 and var_5_22:getAdjutantSid() ~= var_5_0.helpPets[iter_5_24] then
						g.core.network.GameNetProxy:send_C2S_Pet_Help({
							pos = 1,
							pet_id = var_5_20[iter_5_24],
							help_id = var_5_0.helpPets[iter_5_24]
						})
					end
				end
			end
		end

		local var_5_23 = var_5_0.formations.unite_token_id or {}
		local var_5_24 = {
			0,
			0,
			0,
			0
		}

		for iter_5_25 = 1, 4 do
			for iter_5_26, iter_5_27 in ipairs((g.core.model.User.uniteTokenData:getLineupTokenList())) do
				if iter_5_27.getPos then
					var_5_24[iter_5_27:getPos()] = iter_5_27:getServerId()
				end
			end
		end

		for iter_5_28, iter_5_29 in ipairs(var_5_23) do
			if iter_5_29 > 0 then
				if var_5_24[iter_5_28] ~= iter_5_29 then
					g.core.network.GameNetProxy:send_C2S_Formation_ChangeFormation({
						tp = 2,
						pos = iter_5_28,
						id = iter_5_29
					})
					var_5_1(var_5_24, iter_5_29, iter_5_28)
				end
			elseif var_5_24[iter_5_28] > 0 then
				g.core.network.GameNetProxy:send_C2S_Formation_ChangeFormation({
					tp = 2,
					pos = 0,
					id = var_5_24[iter_5_28]
				})
				var_5_1(var_5_24, var_5_24[iter_5_28], 0)
			end
		end

		local var_5_25 = var_5_0.silkBags or {}

		for iter_5_30 = 1, 6 do
			var_5_2[var_5_3[iter_5_30]] = var_5_2[var_5_3[iter_5_30]] or {}

			local var_5_26 = var_5_25[iter_5_30] or {}

			for iter_5_31, iter_5_32 in ipairs(var_5_2[var_5_3[iter_5_30]]) do
				if iter_5_32 > 0 and iter_5_32 ~= var_5_26[iter_5_31] then
					g.core.network.GameNetProxy:send_C2S_Knight_SilkBag_Wear({
						new_silk_bag_pos = 0,
						new_knight_id = 0,
						knight_id = var_5_3[iter_5_30],
						silk_bag_id = iter_5_32
					})

					var_5_2[var_5_3[iter_5_30]][iter_5_31] = 0
				end
			end
		end

		for iter_5_33 = 1, 6 do
			local var_5_27 = var_5_2[var_5_3[iter_5_33]] or {}

			for iter_5_34, iter_5_35 in ipairs(var_5_25[iter_5_33] or {}) do
				if iter_5_35 > 0 and var_5_27[iter_5_34] == 0 then
					g.core.network.GameNetProxy:send_C2S_Knight_SilkBag_Wear({
						knight_id = 0,
						silk_bag_id = iter_5_35,
						new_knight_id = var_5_3[iter_5_33],
						new_silk_bag_pos = iter_5_34
					})
				end
			end
		end
	end

	local var_5_28 = var_5_0.cardId

	if var_5_0.cardId and var_5_28 > 0 then
		local var_5_29 = g.core.model.User.incarnationData:getCardDressing()

		if not var_5_29 or var_5_29.id ~= var_5_28 then
			g.core.network.GameNetProxy:send_C2S_Card_Magically({
				op = 1,
				id = var_5_28
			})
		end
	else
		local var_5_30 = g.core.model.User.incarnationData:getCardDressing()

		if var_5_30 then
			g.core.network.GameNetProxy:send_C2S_Card_Magically({
				op = 2,
				id = var_5_30.id
			})
		end
	end

	local var_5_31 = var_5_0.dressId

	if var_5_0.dressId and var_5_31 > 0 then
		if g.core.model.User:getDressId() ~= var_5_31 then
			g.core.network.GameNetProxy:send_C2S_Dress_Wear({
				id = var_5_31
			})
		end
	elseif g.core.model.User:getDressId() > 0 then
		g.core.network.GameNetProxy:send_C2S_Dress_Wear({
			id = 0
		})
	end
end

function MuiltFightRecordCell:_onClickMark1()
	self:dispatchCompEvent("RecordCell_changeMarkType", {
		record = self._record,
		markType = (self._record:getMarkType() == var_0_2.BASE or nil) and var_0_2.NONE
	})
end

function MuiltFightRecordCell:_onClickMark2()
	self:dispatchCompEvent("RecordCell_changeMarkType", {
		record = self._record,
		markType = (self._record:getMarkType() == var_0_2.ITER or nil) and var_0_2.NONE
	})
end

function MuiltFightRecordCell:_onClickDel()
	g.core.module.ModuleManager:pushPopup((require("app.view.base.pop.BaseConfirmPop").new({
		title = "删除存档",
		desc = "确定要删除该存档吗？",
		onConfirm = handler(self, function(arg_10_0)
			arg_10_0:dispatchCompEvent("RecordCell_del", {
				record = arg_10_0._record
			})
		end)
	})))
end

function MuiltFightRecordCell:_onClickUp()
	self:dispatchCompEvent("RecordCell_up", {
		record = self._record
	})
end

function MuiltFightRecordCell:_onClickDown()
	self:dispatchCompEvent("RecordCell_down", {
		record = self._record
	})
end

return MuiltFightRecordCell
