local var_0_0 = g.core.config.unite_token_info
local var_0_1 = g.core.const.ConstMgr.SpineConst
local DrawUniteToken = require("app.view.common.DrawUniteToken")
local UniteTokenShowComp = class("UniteTokenShowComp", require("app.fairyGUI.uniteToken.UI_UniteTokenShowComp"))

function UniteTokenShowComp:ctor()
	return
end

function UniteTokenShowComp:updateView(arg_2_1)
	if not arg_2_1 then
		return
	end

	local var_2_0 = arg_2_1:getBaseId()
	local var_2_1 = var_0_0.get(var_2_0)

	self.m_nameComp:updateNameShow(var_2_1)
	self.m_spineDad:removeChildren()

	if DrawUniteToken:showSpineEnable(var_2_0) then
		local var_2_2 = var_0_1.UniteTokenAni.IDLE
		local var_2_3 = true

		if var_2_1.spine == 1 then
			var_2_2 = var_0_1.UniteTokenAni.PLAY
			var_2_3 = false
		end

		self.m_spineDad:addChild((DrawUniteToken.new({
			advId = var_2_1.advance_id,
			anim = var_2_2,
			loop = var_2_3
		})))
		self.m_icon:setVisible(false)
	else
		local var_2_4 = g.core.common.Path:getUniteTokenCardImg(var_2_1.res_id)

		if var_2_4 then
			self.m_icon:setURL(var_2_4)
			self.m_icon:setVisible(true)
		end
	end
end

function UniteTokenShowComp:playSwitchAnim()
	self.m_switchTransition:play()
end

return UniteTokenShowComp
