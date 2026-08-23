local var_0_0 = g.core.const.ConstMgr.KNIGHT_CONST
local AritifactShowItem = class("AritifactShowItem", require("app.fairyGUI.infoPop.UI_AritifactShowItem"))
local var_0_4 = g.core.config.knight_base_info
local var_0_6 = g.core.common.Path
local var_0_7 = g.core.common.Color

function AritifactShowItem:ctor()
	return
end

function AritifactShowItem:updateComp(arg_2_1)
	local var_2_0 = g.core.config.artifact_info.get(arg_2_1.value)
	local var_2_1 = g.core.config.knight_info.get(var_2_0.knight_advance_code).group

	self.m_groupGLoader:setURL(self:_getGroupIconByTag(var_2_1))
	self.m_groupText:setText(g.core.lang:get(108100 + var_2_1))
	self.m_groupText:setColor(var_0_7.QualityColor[var_2_0.quality + 1])
	self.m_groupText1:setText(g.core.lang:get(108100 + var_2_1))
	self.m_groupText1:setColor(var_0_7.QualityColor[var_2_0.quality + 1])
	self.m_groupText2:setText(g.core.lang:get(108100 + var_2_1))
	self.m_groupText2:setColor(var_0_7.QualityColor[var_2_0.quality + 1])
	self.m_qualityBg:setURL(var_0_6:getArtifactRecruitBg(var_2_0.quality))
	self.m_nameTxt:setText(var_2_0.name)
	self.m_artifactIcon:setURL(var_0_6:getArtifactPic(var_2_0.res_id))
	self.m_shadowLoader:setURL(var_0_6:getArtifactPic(var_2_0.res_id))
	self.m_shadowLoader:setColor(cc.WHITE)
	self.m_shadowLoader:setColor(cc.BLACK)
	self.m_shadowLoader:setOpacity(0)
	self.m_shadowLoader:setOpacity(76.5)
	self.m_qualityGLoader:setURL(var_0_6:getQualityArtTxtURL(var_2_0.quality))
	self.m_newSignIcon:setVisible(arg_2_1.isNew)

	if not arg_2_1.isNew then
		self.m_autoFragmentTxt:setText("X" .. var_2_0.return_fragment_num)
		self.m_fragIcon:setURL((var_0_6:getIconByTypeValue(g.core.common.Goods.TYPE_ARTIFACT, arg_2_1.value, true)))
	end

	self.m_fragGroup:setVisible(not arg_2_1.isNew)
	self.m_qualityBg:setURL(var_0_6:getArtifactRecruitBg(var_2_0.quality))

	local var_2_2 = var_0_6:getArtifactRecruitWord(var_2_0.quality)

	self.m_bgRightLoader:setURL(var_2_2)
	self.m_bgRightLoader1:setURL(var_2_2)
	self.m_bgRightLoader2:setURL(var_2_2)
	self.m_bgRightLoader3:setURL(var_2_2)
	self.m_lineVer:setURL(var_0_6:getUserIconQualityStarBg(var_2_0.quality))
	self.m_lineHor:setURL(var_0_6:getInfoPopQualityLine(var_2_0.quality))
	self.m_bgTipText:setColor(var_0_7.QualityColor[var_2_0.quality + 1])

	if self.m_knightMask then
		local var_2_3 = var_2_0.knight_advance_code
		local var_2_4 = g.core.model.User.artifactData:getManRoleRelatedAdvId(var_2_0.knight_advance_code)
		local var_2_5, var_2_6

		if var_2_4 then
			var_2_3 = var_2_4
			var_2_5 = self.m_knightMask:getChild("icon")
			var_2_6 = {
				useMidKnight = true,
				scale = 1.3
			}
		end

		var_2_6.resId = tonumber(g.core.config.knight_info.get(var_2_3).res_id)

		var_2_5:setURL(var_0_6:getMiddleKnightPicById(var_0_4.get(var_2_6.resId).painted_id))
		var_2_5:setOpacity(0)
		var_2_5:setOpacity(76.5)
	end
end

function AritifactShowItem:_getGroupIconByTag(arg_3_1)
	return arg_3_1 == var_0_0.GROUP_TYPE.JIAO_GUO and "pic/base_new/bg_gmwz_jiaoguo_2" or arg_3_1 == var_0_0.GROUP_TYPE.LIN_DONG and "pic/base_new/bg_gmwz_lindong_2" or arg_3_1 == var_0_0.GROUP_TYPE.DONG_XI and "pic/base_new/bg_gmwz_dongxi_2" or "pic/base_new/bg_gmwz_lijin_2"
end

return AritifactShowItem
