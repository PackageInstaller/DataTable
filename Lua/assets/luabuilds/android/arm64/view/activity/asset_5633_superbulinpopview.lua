local SuperBulinPopView = class("SuperBulinPopView", import("view.base.BaseUI"))

function SuperBulinPopView:getUIName()
	return "SuperBulinPopView"
end

function SuperBulinPopView:didEnter()
	self.bulinAnim = self._tf:Find("Bulin"):GetComponent("SpineAnimUI")

	self.bulinAnim:SetActionCallBack(nil)
	onButton(self, self._tf, function()
		seriesAsync({
			function(arg_4_0)
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					content = i18n("super_bulin"),
					onYes = arg_4_0,
					onNo = function()
						self:closeView()

						return
					end
				})

				return
			end,
			function(arg_6_0)
				local var_6_0 = self.contextData.actId

				self:closeView()
				pg.m02:sendNotification(GAME.BEGIN_STAGE, {
					warnMsg = "bulin_tip_other3",
					system = SYSTEM_SIMULATION,
					stageId = self.contextData.stageId,
					exitCallback = function()
						local var_7_0 = getProxy(ActivityProxy)
						local var_7_1 = var_7_0:getActivityById(var_6_0)

						if var_7_1.data1 == 2 then
							return
						end

						var_7_1.data3 = 1

						var_7_0:updateActivity(var_7_1)

						return
					end
				})

				return
			end
		})

		return
	end)
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	return
end

function SuperBulinPopView:willExit()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	return
end

return SuperBulinPopView
