local var_0_0 = g.core.config.ksoul_info
local var_0_1 = g.core.model.User.bagData
local var_0_2 = g.core.const.ConstMgr.BAG_TYPE
local InfoKnightSoulPop = class("InfoKnightSoulPop", require("app.fairyGUI.infoPop.UI_InfoKnightSoulPop"), function()
	return fgui.GComponent:create({
		resName = "InfoKnightSoulPop",
		pkgPath = "ui/infoPop/infoPop",
		pkgName = "infoPop"
	}, ...)
end)

function InfoKnightSoulPop:ctor(arg_2_1)
	self:showAtCenter()
	self:_updateView(arg_2_1)
end

function InfoKnightSoulPop:_updateView(arg_3_1)
	if not arg_3_1 then
		return
	end

	local var_3_0 = var_0_0.fetch(arg_3_1.value)

	if var_3_0 then
		local var_3_1 = fgui.UIPackage:createObject("base_new", "BaseKnightSoulCardComp")

		var_3_1:updateCard({
			kSoulId = arg_3_1.value,
			num = arg_3_1.size
		})
		var_3_1:setPivot(0.8, 0.5, true)
		var_3_1:setScale(0.8)
		var_3_1:setTouchable(false)
		var_3_1:setCtrlState("isOwn", {
			index = 1
		})

		local var_3_2 = fgui.UIPackage:createObject("infoPop", "InfoKnightSoulNameComp")

		var_3_2:setTitle((var_0_1:getOwnNum(var_0_2.KSOUL, arg_3_1.value)))
		self.m_infoPopBase:setPopView({
			quality = var_3_0.quality,
			tabParam = {
				{
					package = "infoPop",
					compName = "InfoKnightSoulComp",
					title = g.core.lang:get(410614)
				}
			},
			itemComp = var_3_1,
			nameComp = var_3_2,
			commonParam = arg_3_1
		})
	end
end

return InfoKnightSoulPop
