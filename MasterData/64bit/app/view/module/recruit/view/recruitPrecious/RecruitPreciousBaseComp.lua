local var_0_0 = g.core.const.ConstMgr.QUALITY_TYPE
local RecruitPreciousComp = class("RecruitPreciousComp", require("app.fairyGUI.recruitPrecious.UI_RecruitPreciousBaseComp"))

function RecruitPreciousComp:ctor()
	self:addClickListener(handler(self, self._onClick))

	self._cfg = nil
end

function RecruitPreciousComp:updatePreciousComp(arg_2_1)
	local var_2_0 = g.core.config.precious_info.get(arg_2_1)

	self.m_nameTxt:setText(var_2_0.name)
	self:setIcon(g.core.common.Path:getPreciousIconByResId(var_2_0.res_id))

	self._cfg = var_2_0

	if self._cfg.quality > var_0_0.SSR then
		self.m_nameBg:setURL("ui://base_new/pic_zm_gzp_yuan_zi" .. self._cfg.quality + 1)
	else
		self.m_nameBg:setURL("ui://base_new/pic_zm_gzp_yuan_zi4")
	end
end

function RecruitPreciousComp:_onClick()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.precious.view.PreciousInfoPop").new({
		preciousStruct = g.core.model.User.preciousData:getPreciousByAdvId(self._cfg.advance_id)
	}), {
		hideContinue = true,
		touchDisappear = true
	})
end

return RecruitPreciousComp
