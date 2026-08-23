local var_0_0 = g.core.const.ConstMgr
local var_0_1 = g.core.const.ConstMgr.InfoConst.InheritType
local var_0_2 = g.core.config.treasure_info
local var_0_3 = g.core.config.treasure_purify_info
local var_0_4 = class("", require("app.fairyGUI.infoPop.UI_InheritFormationPop"), function()
	return fgui.GComponent:create({
		resName = "InheritFormationPop",
		pkgName = "infoPop",
		pkgPath = "ui/infoPop/infoPop"
	}, ...)
end)

function var_0_4:ctor(arg_2_1)
	self._params = arg_2_1
	self._inheritType = arg_2_1.type or var_0_1.KNIGHT

	self.m_confirmBtn:addClickListener(handler(self, self._onConfirm))
	self.m_cancelBtn:addClickListener(handler(self, self._onCancel))
	self:showAtCenter()
	self:_updateView()
end

function var_0_4:_updateView()
	self.m_inheritTypeController:setSelectedIndex(self._inheritType)

	if self._inheritType == var_0_1.KNIGHT then
		self.m_popPanel:setHelpId(var_0_0.HelpConst.HELP_TYPE.INHERIT_FORMATION)

		local var_3_0 = g.core.model.User.knightsData:getKnightByFormationIndex(self._params.pos)
		local var_3_1 = g.core.model.User.knightsData:getKnightById(self._params.id)

		self.m_knightIcon1:updateIcon({
			struct = var_3_0
		})
		self.m_knightIcon2:updateIcon({
			struct = var_3_1
		})
		self.m_levelTxt1:setText(g.core.lang:get(2052, {
			level = var_3_0:getLevel()
		}))
		self.m_levelTxt2:setText(g.core.lang:get(2052, {
			level = var_3_1:getLevel()
		}))

		local var_3_2 = var_3_0:getAdvStageAndLevel()
		local var_3_3 = var_3_1:getAdvStageAndLevel()

		self.m_advLevelBg1:setVisible(var_3_2 > 0)
		self.m_advLevelBg2:setVisible(var_3_3 > 0)
		self.m_advLevelTxt1:setVisible(var_3_2 > 0)
		self.m_advLevelTxt2:setVisible(var_3_3 > 0)

		if var_3_2 > 0 then
			self.m_advLevelTxt1:setText("+" .. var_3_2)
		end

		local var_3_4

		if var_3_3 > 0 then
			self.m_advLevelTxt2:setText("+" .. var_3_3)

			var_3_4 = {}
		end

		var_3_4.name1 = self:getRealName(var_3_0)
		var_3_4.name2 = self:getRealName(var_3_1)

		self.m_tipTxt:setText((g.core.lang:get(200012, var_3_4)))
	elseif self._inheritType == var_0_1.PET then
		self.m_popPanel:setHelpId(var_0_0.HelpConst.HELP_TYPE.INHERIT_PET)

		local var_3_5 = g.core.model.User.petsData:getPetByPos(self._params.pos)
		local var_3_6 = g.core.model.User.petsData:getPetBySid(self._params.id)

		self.m_petIcon_1:updateIcon({
			struct = var_3_5
		})
		self.m_petIcon_2:updateIcon({
			struct = var_3_6
		})
		self.m_petLvTxt_1:setText(g.core.lang:get(2052, {
			level = var_3_5:getLevel()
		}))
		self.m_petLvTxt_2:setText(g.core.lang:get(2052, {
			level = var_3_6:getLevel()
		}))

		local var_3_7 = var_3_5:getBigSmallStage()
		local var_3_8 = var_3_6:getBigSmallStage()

		if var_3_7 > 0 then
			self.m_petStageGroup_1:setVisible(true)
			self.m_petBigStageTxt_1:setText("+" .. var_3_7)
		else
			self.m_petStageGroup_1:setVisible(false)
		end

		local var_3_9

		if var_3_8 > 0 then
			self.m_petStageGroup_2:setVisible(true)
			self.m_petBigStageTxt_2:setText("+" .. var_3_8)
		else
			self.m_petStageGroup_2:setVisible(false)

			var_3_9 = {}
		end

		var_3_9.name1 = var_3_5:getCfg().name
		var_3_9.name2 = var_3_6:getCfg().name

		self.m_tipTxt:setText((g.core.lang:get(200012, var_3_9)))
	elseif self._inheritType == var_0_1.ARTIFACT then
		self.m_popPanel:setHelpId(var_0_0.HelpConst.HELP_TYPE.INHERIT_ARTIFACT)

		local var_3_10 = g.core.model.User.artifactData:getArtifactByFormationIndex(self._params.pos)
		local var_3_11 = g.core.model.User.artifactData:getArtifactBySid(self._params.id)

		self.m_oldArtifact:updateIcon(var_3_10)
		self.m_newArtifact:updateIcon(var_3_11)

		local var_3_12 = ""
		local var_3_13

		if var_3_10 then
			var_3_12 = var_3_10:getArtifactName()
		end

		if var_3_11 then
			var_3_13 = var_3_11:getArtifactName()
		end

		self.m_qualityController:setSelectedIndex(math.max(var_3_10:getQuality(), var_3_11:getQuality()) - 1)
		self.m_tipTxt:setText((g.core.lang:get(200012, {
			name1 = var_3_12,
			name2 = var_3_13
		})))
	elseif self._inheritType == var_0_1.EQUIP then
		self.m_popPanel:setHelpId(var_0_0.HelpConst.HELP_TYPE.INHERIT_EQUIP)

		local var_3_14 = ""
		local var_3_15
		local var_3_16 = g.core.model.User.equipmentData:getEquipDataByPos(self._params.pos)
		local var_3_17 = g.core.model.User.equipmentData:getEquipBySid(self._params.id)

		if var_3_16 then
			local var_3_18 = g.core.common.Goods:convert({
				type = g.core.common.Goods.TYPE_EQUIP,
				value = var_3_16:getCfg().id
			})

			if var_3_18 then
				var_3_14 = var_3_18.name
				var_3_18.info = var_3_16:getCfg()
				var_3_18.resonanceState = 1
				var_3_18.resonanceLevel = var_3_16:getResonanceLevel()

				self.m_ETIcon1:updateIcon(var_3_18)
				self.m_ETLvTxt1:setText(g.core.lang:get(2052, {
					level = var_3_16:getServerData().level
				}))

				if var_3_16:getServerData().refining_level > 0 then
					self.m_refineGroup1:setVisible(true)
					self.m_refineLvTxt1:setText("+" .. var_3_16:getServerData().refining_level)
				else
					self.m_refineGroup1:setVisible(false)
				end
			end
		end

		if var_3_17 then
			local var_3_19 = g.core.common.Goods:convert({
				type = g.core.common.Goods.TYPE_EQUIP,
				value = var_3_17:getCfg().id
			})

			if var_3_19 then
				var_3_15 = var_3_19.name
				var_3_19.info = var_3_17:getCfg()
				var_3_19.resonanceState = 1
				var_3_19.resonanceLevel = var_3_17:getResonanceLevel()

				self.m_ETIcon2:updateIcon(var_3_19)
				self.m_ETLvTxt2:setText(g.core.lang:get(2052, {
					level = var_3_17:getServerData().level
				}))
				self.m_refineLvTxt2:setText(var_3_17:getServerData().refining_level)

				if var_3_17:getServerData().refining_level > 0 then
					self.m_refineGroup2:setVisible(true)
					self.m_refineLvTxt2:setText("+" .. var_3_17:getServerData().refining_level)
				else
					self.m_refineGroup2:setVisible(false)
				end
			end
		end

		self.m_tipTxt:setText((g.core.lang:get(200012, {
			name1 = var_3_14,
			name2 = var_3_15
		})))
	elseif self._inheritType == var_0_1.TREASURE then
		self.m_popPanel:setHelpId(var_0_0.HelpConst.HELP_TYPE.INHERIT_TREASURE)

		local var_3_20 = ""
		local var_3_21
		local var_3_22 = g.core.model.User.treasureData:getTreasureDataByPos(self._params.pos)
		local var_3_23 = g.core.model.User.treasureData:getTreasureDataByOnlyId(self._params.id)

		if var_3_22 then
			local var_3_24 = g.core.common.Goods:convert({
				type = g.core.common.Goods.TYPE_TREASURE,
				value = var_3_22.base_id
			})

			if var_3_24 then
				var_3_20 = var_3_24.name

				self.m_ETIcon1:updateIcon({
					type = var_3_24.type,
					value = var_3_24.value
				})
				self.m_ETLvTxt1:setText(g.core.lang:get(2052, {
					level = var_3_22.level
				}))

				if var_3_22.refining_level > 0 then
					self.m_refineGroup1:setVisible(true)
					self.m_refineLvTxt1:setText("+" .. var_3_22.refining_level)
				else
					self.m_refineGroup1:setVisible(false)
				end
			end
		end

		local var_3_25 = var_0_3.fetch(var_0_2.get(var_3_22.base_id).purify_id)
		local var_3_26 = var_0_3.fetch(var_0_2.get(var_3_23.base_id).purify_id)

		if not var_3_25 or not var_3_26 or var_3_25.exchange_group ~= var_3_26.exchange_group then
			self._canExchange = false

			self.m_changeBtn:setSelected(false)
			self.m_treasurePurifyController:setSelectedIndex(1)
		else
			self.m_treasurePurifyController:setSelectedIndex(0)

			self._canExchange = true

			self.m_changeBtn:setSelected(true)
		end

		if var_3_23 then
			local var_3_27 = g.core.common.Goods:convert({
				type = g.core.common.Goods.TYPE_TREASURE,
				value = var_3_23.base_id
			})

			if var_3_27 then
				var_3_21 = var_3_27.name

				self.m_ETIcon2:updateIcon(var_3_27)
				self.m_ETLvTxt2:setText(g.core.lang:get(2052, {
					level = var_3_23.level
				}))
				self.m_refineLvTxt2:setText(var_3_23.level)

				if var_3_23.refining_level > 0 then
					self.m_refineGroup2:setVisible(true)
					self.m_refineLvTxt2:setText("+" .. var_3_23.refining_level)
				else
					self.m_refineGroup2:setVisible(false)
				end
			end
		end

		self.m_tipTxt:setText((g.core.lang:get(200012, {
			name1 = var_3_20,
			name2 = var_3_21
		})))
	end
end

function var_0_4:getRealName(arg_4_1)
	local var_4_0 = arg_4_1:getBaseInfo()

	if var_4_0.type == 1 then
		return g.core.model.User:getName()
	else
		return var_4_0.name
	end
end

function var_0_4:_onCancel()
	if self._onClose then
		return
	end

	self._onClose = true

	local var_5_0

	if self._inheritType == var_0_1.KNIGHT then
		var_5_0 = g.core.network.proto.TYPE_KNIGHT
	elseif self._inheritType == var_0_1.ARTIFACT then
		var_5_0 = g.core.network.proto.TYPE_ARTIFACT
	elseif self._inheritType == var_0_1.PET then
		var_5_0 = g.core.network.proto.TYPE_PET
	elseif self._inheritType == var_0_1.EQUIP then
		var_5_0 = g.core.network.proto.TYPE_EQUIPMENT
	elseif self._inheritType == var_0_1.TREASURE then
		var_5_0 = g.core.network.proto.TYPE_TREASURE
	else
		g.core.log:error("-----     Error! Invalide self._inheritType :", self._inheritType)
	end

	if var_5_0 then
		g.core.network.GameNetProxy:send_C2S_Formation_ChangeFormation({
			tp = var_5_0,
			pos = self._params.pos,
			id = self._params.id
		})
	end

	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function var_0_4:_onConfirm()
	if self._onClose then
		return
	end

	self._onClose = true

	local var_6_0 = {
		pos = self._params.pos,
		id = self._params.id
	}

	if self._inheritType == var_0_1.KNIGHT then
		g.core.network.GameNetProxy:send_C2S_Knight_InheritFormation(var_6_0)
	elseif self._inheritType == var_0_1.ARTIFACT then
		g.core.network.GameNetProxy:send_C2S_Artifact_InheritFormation(var_6_0)
	elseif self._inheritType == var_0_1.PET then
		g.core.network.GameNetProxy:send_C2S_Pet_InheritFormation(var_6_0)
	elseif self._inheritType == var_0_1.EQUIP then
		g.core.network.GameNetProxy:send_C2S_Equipment_InheritFormation(var_6_0)
	elseif self._inheritType == var_0_1.TREASURE then
		var_6_0.change_purify = self.m_changeBtn:isSelected()

		g.core.network.GameNetProxy:send_C2S_Treasure_InheritFormation(var_6_0)
	else
		g.core.log:error("-----     Error! Invalide self._inheritType :", self._inheritType)
	end

	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

return var_0_4
