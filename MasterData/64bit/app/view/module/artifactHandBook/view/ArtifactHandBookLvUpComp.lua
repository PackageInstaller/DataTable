local var_0_0 = g.core.model.User.artifactHandBookData
local ArtifactHandBookLvUpComp = class("ArtifactHandBookLvUpComp", require("app.fairyGUI.artifactHandbook.UI_ArtifactHandBookLvUpComp"))

function ArtifactHandBookLvUpComp:ctor()
	self._attrList = {}

	self.m_attrList:setVirtual()
	self.m_attrList:setItemRenderer(handler(self, self._onAttrRenderer))
end

function ArtifactHandBookLvUpComp:update(arg_2_1)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_FEEDBACK_SHOW, false, {
		baseShowPop = {
			type = g.core.const.ConstMgr.BaseShowTypeConst.ARTIFACT_SPIRIT_HAND_BOOK
		}
	})

	local var_2_0 = var_0_0:getArtifactCurScoreInfo(arg_2_1.data.oldScore) or {
		id = 0
	}
	local var_2_1 = var_0_0:getArtifactCurScoreInfo()

	self._attrList = {}

	for iter_2_0, iter_2_1 in pairs((var_0_0:getArtifactChangeAttrs(var_2_0.id, var_2_1.id))) do
		table.insert(self._attrList, {
			type = iter_2_0,
			value = iter_2_1
		})
	end

	self.m_lvTxt1:setText(var_2_0.id)
	self.m_lvTxt2:setText(var_2_1.id)
	self.m_attrList:setNumItems(#self._attrList)
end

function ArtifactHandBookLvUpComp:_onAttrRenderer(arg_3_1, arg_3_2)
	arg_3_2:updateAttr({
		withoutPlus1 = false,
		isAll = true,
		type = self._attrList[arg_3_1 + 1].type,
		value = self._attrList[arg_3_1 + 1].value
	})
end

function ArtifactHandBookLvUpComp:onUnload()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_CHECK_SHOW_READY)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_CHECK_FIGHT_VALUE_CHANGE)
end

return ArtifactHandBookLvUpComp
