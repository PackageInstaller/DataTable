local var_0_0 = g.core.config.unite_token_info
local var_0_1 = g.core.model.User.uniteTokenData
local var_0_2 = g.core.const.ConstMgr.UniteTokenConst

return {
	updateBaseInfo = function(self, arg_1_1)
		if not self or not arg_1_1 then
			return
		end

		local var_1_0 = var_0_1:getTokenBaseInfo((arg_1_1:getBaseId()))

		for iter_1_0 = 1, var_0_2.BASE_ATTR_NUM do
			local var_1_1 = not not var_1_0.attrList[iter_1_0]
			local var_1_2 = self["m_totalAttrComp" .. iter_1_0]

			self["m_totalAttrComp" .. iter_1_0]:setVisible(var_1_0.attrList[iter_1_0] and true or false)

			if var_1_1 then
				var_1_2:updateAttr(var_1_0.attrList[iter_1_0])
			end
		end

		self.m_skillIcon:updateIcon(var_1_0.skillInfo)
		self.m_skillNameText:setText(var_1_0.skillInfo.cfg.curtain_name)
		self.m_skillDescComp:getChild("title"):enableRich()
		self.m_skillDescComp:setTitle(var_1_0.skillInfo.desc)
	end,
	openUniteDevLayer = function(arg_2_0, arg_2_1)
		local var_2_0 = {
			tabIndex = arg_2_1 or var_0_2.DEV_TYPE.INFO
		}

		var_2_0.selIndex = arg_2_0 and var_0_1:getIndexById(arg_2_0) or 1

		g.core.module.ModuleManager:pushModule(g.view.entrance.UNITE_TOKEN_DEVELOP, var_2_0)
	end,
	openUniteInfoPop = function(arg_3_0)
		g.core.module.ModuleManager:pushPopup(require("app.view.module.uniteToken.view.UniteTokenInfoPop").new({
			tokenData = arg_3_0
		}))
	end,
	openPieceGetPop = function(self)
		if not self then
			return
		end

		local var_4_0 = var_0_0.get((self:getBaseId())).fragment_id
		local var_4_1, var_4_2 = self:getStarUpFragmentNum()

		g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
			type = g.core.common.Goods.TYPE_FRAGMENT,
			value = var_4_0,
			size = var_4_1
		})
	end,
	openSkillInfoPop = function(self, arg_5_1)
		local var_5_0

		if not self then
			do return end

			var_5_0 = require("app.view.module.uniteToken.view.UniteTokenSkillInfoPop").new
		end

		g.core.module.ModuleManager:pushPopup(require("app.view.module.uniteToken.view.UniteTokenSkillInfoPop").new({
			baseId = self:getBaseId(),
			dragId = self:getAdvanceId(),
			type = arg_5_1
		}))
	end,
	openSkillPreviewPop = function(arg_6_0)
		if not arg_6_0 then
			return
		end
	end
}
