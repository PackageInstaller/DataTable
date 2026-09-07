local LoveLetterSelectCharMediator = class("LoveLetterSelectCharMediator", import("..base.ContextMediator"))

function LoveLetterSelectCharMediator:register()
	self:bind(LoveLetterSelectCharLayer.SELECT_CHAR, function(arg_2_0, arg_2_1)
		if self.contextData.isRepair then
			self:addSubLayers(Context.New({
				viewComponent = LoveLetterSelectCharConfirmLayer,
				mediator = LoveLetterSelectCharConfirmMediator,
				data = {
					isRepair = true,
					groupId = arg_2_1,
					itemVO = self.contextData.itemVO
				}
			}))
		else
			if getProxy(ActivityProxy):getActivityById(self.contextData.actId):GetTargetGroupId() == arg_2_1 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("loveactivity_ui_18"))

				return
			end

			self:addSubLayers(Context.New({
				viewComponent = LoveLetterSelectCharConfirmLayer,
				mediator = LoveLetterSelectCharConfirmMediator,
				data = {
					groupId = arg_2_1,
					actId = self.contextData.actId
				}
			}))
		end

		return
	end)
	self:bind(LoveLetterSelectCharLayer.ON_INDEX, function(arg_3_0, arg_3_1)
		self:addSubLayers(Context.New({
			viewComponent = CustomIndexLayer,
			mediator = CustomIndexMediator,
			data = arg_3_1
		}))

		return
	end)
	self.viewComponent:setShipGroups(getProxy(CollectionProxy):getGroups())
	self.viewComponent:setProposeList(getProxy(BayProxy):getProposeGroupList())

	return
end

function LoveLetterSelectCharMediator:initNotificationHandleDic()
	self.handleDic = {
		[ActivityProxy.ACTIVITY_OPERATION_DONE] = function(arg_5_0, arg_5_1)
			if arg_5_1:getBody() == arg_5_0.contextData.actId then
				arg_5_0.viewComponent:closeView()
			end

			return
		end,
		[GAME.USE_ITEM_DONE] = function(arg_6_0, arg_6_1)
			arg_6_0.viewComponent:closeView()

			return
		end
	}

	return
end

return LoveLetterSelectCharMediator
