local SixthAnniversaryJPHotSpringMediator = class("SixthAnniversaryJPHotSpringMediator", import("view.activity.BackHills.NewYearFestival.NewYearHotSpringMediator"))

function SixthAnniversaryJPHotSpringMediator:register()
	self:bind(SixthAnniversaryJPHotSpringMediator.UNLOCK_SLOT, function(arg_2_0, arg_2_1)
		local var_2_0, var_2_1 = self.activity:GetUpgradeCost()

		MsgboxMediator.ShowMsgBox({
			type = MSGBOX_TYPE_NORMAL,
			content = i18n("jp6th_spring_tip1", var_2_1),
			contextSprites = {
				{
					path = "props/wenquanshoupai",
					name = "wenquanshoupai"
				}
			},
			onYes = function()
				if self.activity:GetCoins() < var_2_1 then
					pg.TipsMgr.GetInstance():ShowTips(i18n("jp6th_spring_tip2"))

					return
				end

				self:sendNotification(GAME.ACTIVITY_OPERATION, {
					activity_id = arg_2_1,
					cmd = SpringActivity.OPERATION_UNLOCK
				})

				return
			end
		})

		return
	end)
	self:bind(SixthAnniversaryJPHotSpringMediator.OPEN_CHUANWU, function(arg_4_0, arg_4_1, arg_4_2)
		self:OnSelShips(arg_4_1, arg_4_2)

		return
	end)

	local var_1_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_HOTSPRING)

	self.activity = var_1_0

	self.viewComponent:SetActivity(var_1_0)
	self:bind(SixthAnniversaryJPHotSpringMediator.OPEN_INFO, function()
		self:addSubLayers(Context.New({
			mediator = NewYearHotSpringShipSelectMediator,
			viewComponent = NewYearHotSpringShipSelectLayer,
			data = {
				actId = var_1_0.id
			}
		}))

		return
	end)

	return
end

return SixthAnniversaryJPHotSpringMediator
