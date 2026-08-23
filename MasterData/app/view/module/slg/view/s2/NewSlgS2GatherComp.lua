local NewSlgS2GatherComp = class("NewSlgS2GatherComp")
local var_0_1 = g.core.event.EventManager
local var_0_2 = g.core.event.enum

function NewSlgS2GatherComp:ctor()
	self._imgBg = self:getChild("Img_bg")
	self._compScroll = self:getChild("Comp_scroll")

	self:addListen(self._compScroll)
end

function NewSlgS2GatherComp:onLoad()
	var_0_1:addEventListener(var_0_2.EVENT_NET_S2C_NEW_SLG_CITYBEDECLAREDNTF, handler(self, self._onGatherCompUpdateView), self)
	var_0_1:addEventListener(var_0_2.EVENT_NET_S2C_NEW_SLG_CITYDECLARENTF, handler(self, self._onGatherCompUpdateView), self)
	var_0_1:addEventListener(var_0_2.EVENT_NET_S2C_NEW_SLG_CITYMARCHNTF, handler(self, self._onGatherCompUpdateView), self)
	var_0_1:addEventListener(var_0_2.EVENT_NET_S2C_NEW_SLG_GETINFOONCITYBATTLEEND, handler(self, self._onGatherCompUpdateView), self)
	var_0_1:addEventListener(var_0_2.EVENT_NET_S2C_NEW_SLG_GETCITYSHOWDATA, handler(self, self._onGatherCompUpdateView), self)
	var_0_1:addEventListener(var_0_2.EVENT_NET_S2C_NEW_SLG_CITYOCCUPIERNTF, handler(self, self._onGatherCompUpdateView), self)
	var_0_1:addEventListener(var_0_2.EVENT_NET_S2C_NEW_SLG_FARMMAPSHOWNTF, handler(self, self._onGatherCompUpdateView), self)
end

function NewSlgS2GatherComp:receiveCompEvent(arg_3_1, arg_3_2)
	arg_3_2 = arg_3_2 or {}

	if arg_3_1 == "NewSlgS2GatherCompCell_updateComp" then
		self:_onGatherCompUpdateView()
	end
end

function NewSlgS2GatherComp:_onGatherCompUpdateView()
	if self:isVisible() then
		self:updateView()
	end
end

function NewSlgS2GatherComp:setVis(arg_5_1)
	self:setVisible(arg_5_1)
end

function NewSlgS2GatherComp:updateView()
	local var_6_0, var_6_1 = self._compScroll:updateView()

	if var_6_0 then
		-- block empty
	end
end

return NewSlgS2GatherComp
