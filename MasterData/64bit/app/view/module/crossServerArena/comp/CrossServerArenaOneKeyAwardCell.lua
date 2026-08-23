local CrossServerArenaOneKeyAwardCell = class("CrossServerArenaOneKeyAwardCell", require("app.fairyGUI.crossServerArena.UI_CrossServerArenaOneKeyAwardCell"))

function CrossServerArenaOneKeyAwardCell:ctor()
	self._isAnim = true
	self._awardList = {}

	self:_initListView()
end

function CrossServerArenaOneKeyAwardCell:_initListView()
	self.m_awardList:setVirtual()
	self.m_awardList:setItemRenderer(handler(self, self._onRenderAwardList))
end

function CrossServerArenaOneKeyAwardCell:_onRenderAwardList(arg_3_1, arg_3_2)
	local var_3_0 = self._awardList[arg_3_1 + 1]

	var_3_0.scaleIndex = 2
	var_3_0.hideNum = false

	local var_3_1 = arg_3_2:getChild("icon")

	var_3_1:updateIcon(var_3_0)

	if self._isAnim then
		var_3_1:setOpacity(0)
		var_3_1:runFGAction(fgui.FSequence:create({
			fgui.FDelayTime:create(0.08 * arg_3_1 + 0.2),
			fgui.FFadeIn:create(0.12)
		}))
	end

	local var_3_2 = g.core.model.User.crossServerArenaData:getGuildRate()
	local var_3_3 = var_3_2 > 0 and self:_isGuildSkill(var_3_0)
	local var_3_4 = arg_3_2:getChild("additionGroup")

	var_3_4:setVisible(var_3_3)

	if var_3_3 then
		arg_3_2:getChild("additionTxt"):setText("+" .. var_3_2 / 10 .. "%")

		if self._isAnim then
			var_3_4:setOpacity(0)
			var_3_4:runFGAction(fgui.FSequence:create({
				fgui.FDelayTime:create(0.08 * arg_3_1 + 0.2),
				fgui.FFadeIn:create(0.12)
			}))
		end
	end
end

function CrossServerArenaOneKeyAwardCell:_isGuildSkill(arg_4_1)
	return arg_4_1.type == g.core.common.Goods.TYPE_RESOURCE and arg_4_1.value == g.core.common.Goods.RESOURCE.TYPE_CHIEF_ARENA_SKILL
end

function CrossServerArenaOneKeyAwardCell:updateCell(arg_5_1, arg_5_2)
	if not arg_5_1 then
		return
	end

	self._awardList = arg_5_1

	self.m_awardList:setNumItems(#self._awardList)
	self.m_timeText:setText(g.core.lang:get(302512, {
		rank = arg_5_2
	}))
end

return CrossServerArenaOneKeyAwardCell
