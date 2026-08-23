local ArtifactConst = require("app.view.module.artifact.const.ArtifactConst")
local var_0_1 = g.core.model.User.artifactHandBookData
local ArtifactHandBookURCell = class("ArtifactHandBookURCell", require("app.fairyGUI.artifactHandbook.UI_ArtifactHandBookURCell"))

function ArtifactHandBookURCell:ctor()
	self.m_attrList:setVirtual()
	self.m_attrList:setItemRenderer(handler(self, self._onAttrListRenderer))
	self.m_activeBtn:addClickListener(handler(self, self._onClickActiveBtn))
	self.m_lvUpBtn:addClickListener(handler(self, self._onLvUpBtnClick))
end

function ArtifactHandBookURCell:updateURArtifactHandBook(arg_2_1, arg_2_2)
	self._handBookData = arg_2_1
	self._artifactStruct = arg_2_1.struct

	local var_2_0 = arg_2_1.info

	self.m_nameText:setText(arg_2_1.info.name)
	self.m_openController:setSelectedIndex(arg_2_2 and 1 or 0)

	local var_2_1 = arg_2_1.struct:getCfg()

	self.m_artifactLoader:setGloaderColor(not arg_2_1.isActive, cc.vec3(0.49, 0.49, 0.49))
	self.m_artifactLoader:setURL(g.core.common.Path:getArtifactImg(var_2_1.res_id))
	self.m_qualityLoader:setURL("ui://base_new/pic_tujian_" .. var_2_1.quality + 1 .. "_di_1")

	self._isMax = false

	local var_2_2 = self._artifactStruct:getMaxStar()

	self.m_starComp:initStar({
		gap = -4,
		style = 2,
		index = 3,
		max = var_2_2,
		num = var_0_1:getURArtifactActiveLv(var_2_0.advance_code) - 1
	})

	local var_2_3 = var_0_1:getURArtifactActiveLv(var_2_0.advance_code)

	self.m_stateController:setSelectedIndex(0)

	if arg_2_1.isActive then
		if var_2_2 <= var_2_3 - 1 then
			self._isMax = true

			self.m_stateController:setSelectedIndex(2)
		else
			local var_2_4 = var_0_1:getTargetURLvCfg(var_2_0.advance_code, var_2_3 + 1)

			self.m_lvUpDescTxt:setText(g.core.lang:get(205557, {
				num = var_2_4.need
			}))

			if var_2_4.num == 0 then
				self.m_costComp:setVisible(false)
				self.m_costBg:setVisible(false)
			else
				self.m_costBg:setVisible(true)
				self.m_costComp:setVisible(true)
				self.m_costComp:updateByTVS({
					type = var_2_4.cost_type,
					value = var_2_4.cost_value,
					size = var_2_4.num
				})
			end

			self.m_stateController:setSelectedIndex(1)
		end
	end

	local var_2_5 = var_0_1:getTargetURHandBookLvAttr(var_2_0.advance_code, true)

	self._attrList = var_2_5

	self.m_attrList:setNumItems(#var_2_5)

	local var_2_6 = false

	if not self._handBookData.isActive then
		var_2_6 = self._artifactStruct:isOwn()
	elseif var_2_2 > var_2_3 - 1 then
		local var_2_7 = var_0_1:getTargetURLvCfg(self._handBookData.info.advance_code, var_0_1:getURArtifactActiveLv(self._handBookData.info.advance_code) + 1)

		if self._handBookData.isActive and self._artifactStruct:getStar() >= var_2_7.need and self._artifactStruct:getStar() >= var_2_7.need and g.core.model.User.bagData:getOwnNum(var_2_7.cost_type, var_2_7.cost_value) >= var_2_7.num then
			var_2_6 = true
		end
	end

	self.m_redPointComp:setShow(var_2_6)
end

function ArtifactHandBookURCell:_onClickActiveBtn()
	if self._artifactStruct then
		if not self._handBookData.isActive and self._artifactStruct:isOwn() then
			g.core.network.GameNetProxy:send_C2S_Artifact_URHandbook_Active({
				id = self._handBookData.info.id
			})
		else
			g.core.module.ModuleManager:tip(g.core.lang:get(205572))
		end
	end
end

function ArtifactHandBookURCell:_onLvUpBtnClick()
	if self._artifactStruct then
		local var_4_0 = var_0_1:getTargetURLvCfg(self._handBookData.info.advance_code, var_0_1:getURArtifactActiveLv(self._handBookData.info.advance_code) + 1)

		if self._handBookData.isActive then
			if self._artifactStruct:getStar() < var_4_0.need then
				g.core.module.ModuleManager:tip(g.core.lang:get(205557, {
					num = var_4_0.need
				}))

				return
			end

			if g.core.model.User.bagData:getOwnNum(var_4_0.cost_type, var_4_0.cost_value) < var_4_0.num then
				g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
					type = var_4_0.cost_type,
					value = var_4_0.cost_value
				})

				return
			end

			g.core.network.GameNetProxy:send_C2S_Artifact_URHandbook_Upgrade({
				id = self._handBookData.info.id
			})
		end
	end
end

function ArtifactHandBookURCell:_onAttrListRenderer(arg_5_1, arg_5_2)
	arg_5_2:updateArtifactURBookAttr(self._attrList[arg_5_1 + 1], self._isMax)
end

return ArtifactHandBookURCell
