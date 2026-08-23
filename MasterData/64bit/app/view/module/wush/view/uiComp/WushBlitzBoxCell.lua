local WushBlitzBoxCell = class("WushBlitzBoxCell", require("app.fairyGUI.wush.UI_WushBlitzBoxCell"))

function WushBlitzBoxCell:ctor()
	self._award = {}

	self.m_awardList:setVirtual()
	self.m_awardList:setItemRenderer(handler(self, self._onListItemRenderer))
end

function WushBlitzBoxCell:_onListItemRenderer(arg_2_1, arg_2_2)
	arg_2_2:getChild("iconComp"):updateIcon(self._award[arg_2_1 + 1])
end

function WushBlitzBoxCell:update(arg_3_1)
	if arg_3_1 then
		self._award = arg_3_1.data or {}
	end

	local var_3_0, var_3_1, var_3_2

	if arg_3_1 then
		var_3_0 = arg_3_1.floorId or 1

		if arg_3_1 then
			var_3_1 = arg_3_1.star or 0

			if arg_3_1 then
				var_3_2 = arg_3_1.allAddstar or 0
			end
		end
	end

	self.m_awardList:setNumItems(#self._award)

	if var_3_2 and var_3_2 > 0 then
		self:setProperties("desLabel", {
			text = g.core.lang:get(303021, {
				floor = var_3_0,
				star1 = var_3_2,
				star2 = var_3_2 - var_3_1
			})
		})
	else
		self:setProperties("desLabel", {
			text = g.core.lang:get(303022, {
				floor = var_3_0,
				star = var_3_1
			})
		})
	end
end

return WushBlitzBoxCell
