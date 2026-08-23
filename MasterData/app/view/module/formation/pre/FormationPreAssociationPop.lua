local var_0_0 = g.core.model.User.knightsData
local FormationPreAssociationPop = class("FormationPreAssociationPop", require("app.fairyGUI.formation.UI_FormationPreAssociationPop"), function()
	return fgui.GComponent:create({
		resName = "FormationPreAssociationPop",
		pkgPath = "ui/formation/formation",
		pkgName = "formation"
	})
end)

function FormationPreAssociationPop:ctor(arg_2_1)
	self:showAtCenter()

	self._index = arg_2_1.index
	self._knightSid = arg_2_1.knightSid
	self._mainKnightSid = arg_2_1.mainKnightSid
	self._knight = var_0_0:getKnightByAdvanceId(self._knightSid)

	self.m_helpBtn:addClickListener(handler(self, self._onClickHelpBtn))
end

function FormationPreAssociationPop:_initView()
	local var_3_0 = {
		index = self._index,
		knightSid = self._knightSid,
		mainKnightSid = self._mainKnightSid
	}

	self.m_equipComp:updateComp(var_3_0)
	self.m_associationComp:updateComp(var_3_0)
end

function FormationPreAssociationPop:_onClickHelpBtn()
	if 301 > 0 then
		g.core.module.ModuleManager:pushPopup(require("app.view.base.component.HelpPop").new({
			id = 301
		}), {
			touchDisappear = true
		})
	end
end

function FormationPreAssociationPop:onLoad()
	self:_initView()
end

return FormationPreAssociationPop
