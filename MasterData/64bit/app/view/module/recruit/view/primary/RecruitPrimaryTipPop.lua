local RecruitPrimaryTipPop = class("RecruitPrimaryTipPop", require("app.fairyGUI.recruitKnight.UI_RecruitPrimaryTipPop"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/recruitKnight/recruitKnight",
		resName = "RecruitPrimaryTipPop",
		pkgName = "recruitKnight"
	})
end)

function RecruitPrimaryTipPop:ctor()
	self:_addListeners()
	self:getView():center(true)
end

function RecruitPrimaryTipPop:_addListeners()
	self.m_list:setVirtual(self)
	self.m_list:setItemRenderer(handler(self, self._onItemRender))
end

function RecruitPrimaryTipPop:_onItemRender(arg_4_1, arg_4_2)
	arg_4_2:updateItem(self._datas[arg_4_1 + 1], arg_4_1)
end

function RecruitPrimaryTipPop:onLoad()
	self:_updateView()
end

function RecruitPrimaryTipPop:_updateView()
	self._datas = g.core.model.User.recruitData:getAllRoundDatas()

	self.m_list:setNumItems(#self._datas)
end

return RecruitPrimaryTipPop
