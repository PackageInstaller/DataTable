local var_0_0 = {
	COMP = 3,
	KNIGHT = 2,
	IMAGE = 1,
	PET = 4
}
local var_0_1 = g.core.const.ConstMgr.SpineConst
local BaseCommonBreakUpPop = class("BaseCommonBreakUpPop", require("app.fairyGUI.base_new.UI_BaseCommonBreakUpPop"))

function BaseCommonBreakUpPop:ctor()
	self.m_enter_0Transition:setHook("upGrade", handler(self, self.playIdleAnim))
	self.m_enter_1Transition:setHook("titlePlay", handler(self, self.playTitleAnim))
end

function BaseCommonBreakUpPop:initData(arg_2_1)
	self._param = arg_2_1

	self.m_title:setText((arg_2_1 or nil) and (arg_2_1.title or ""))
	self.m_englishTitle:setText((arg_2_1 or nil) and (arg_2_1.englishTitle or ""))

	self._quality = arg_2_1.quality

	if arg_2_1.item then
		self:createItem(arg_2_1.item)
	end
end

function BaseCommonBreakUpPop:playIdleAnim()
	local var_3_0 = "eff_ui_knight_idleEff"
	local var_3_1 = "play_" .. self._quality + 1

	if self._param and self._param.idleEff then
		var_3_0 = self._param.idleEff.name or var_3_0
		var_3_1 = self._param.idleEff.anim or var_3_1
	end

	self.m_effPlaceHolder:addEffectSpine({
		isLoop = true,
		name = var_3_0,
		anim = var_3_1
	})
end

function BaseCommonBreakUpPop:playTitleAnim()
	self.m_effTitle:addEffectSpine({
		remove = true,
		name = "eff_ui_knight_uptitle",
		anim = "play",
		isLoop = false
	})
end

function BaseCommonBreakUpPop:createItem(arg_5_1)
	if arg_5_1.type == var_0_0.IMAGE then
		self._item = fgui.GLoader:create()

		self._item:setAutoSize(true)
		self._item:setURL(arg_5_1.res)
	elseif arg_5_1.type == var_0_0.KNIGHT then
		self._item = fgui.UIPackage:createObject("base_new", "BaseKnightPicComp")

		self._item:updateKnight(arg_5_1.res)
		self._item:setAlphaRect(var_0_1.MASK_TYPE.HORIZON, cc.rect(-300, 0, 500, 0), 200)
	elseif arg_5_1.type == var_0_0.COMP then
		self._item = fgui.UIPackage:createObject(arg_5_1.package, arg_5_1.resName)
	elseif arg_5_1.type == var_0_0.PET then
		self._item = fgui.UIPackage:createObject("base_new", "BasePetPicComp")

		self._item:updatePic(arg_5_1.res)
	end

	if self._item then
		self._item:setPivot(0.5, 0.5, true)
		self.m_itemPlaceHolder:addChild(self._item)
	end

	return self._item
end

function BaseCommonBreakUpPop:getItemTarget()
	return self._item
end

return BaseCommonBreakUpPop
