local ShipProfileMediator = class("ShipProfileMediator", import("...base.ContextMediator"))

ShipProfileMediator.CLICK_ROTATE_BTN = "ShipProfileMediator:CLICK_ROTATE_BTN"
ShipProfileMediator.OPEN_CRYPTOLALIA = "ShipProfileMediator:OPEN_CRYPTOLALIA"
ShipProfileMediator.OPEN_EQUIP_CODE_SHARE = "ShipProfileMediator.OPEN_EQUIP_CODE_SHARE"
ShipProfileMediator.OPEN_PAINTING_SHOW = "ShipProfileMediator.OPEN_PAINTING_SHOW"

function ShipProfileMediator:register()
	self.showTrans = self.contextData.showTrans
	self.groupId = self.contextData.groupId

	self.viewComponent:setShipGroup((getProxy(CollectionProxy):getShipGroup(self.groupId)))
	self.viewComponent:setShowTrans(self.showTrans)
	self.viewComponent:setOwnedSkinList(getProxy(ShipSkinProxy):getSkinList())
	self:bind(ShipProfileMediator.OPEN_CRYPTOLALIA, function(arg_2_0, arg_2_1)
		self:sendNotification(GAME.GO_SCENE, SCENE.CRYPTOLALIA, {
			groupId = arg_2_1
		})

		return
	end)
	self:bind(ShipProfileMediator.CLICK_ROTATE_BTN, function(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
		self:addSubLayers(Context.New({
			mediator = ShipRotateMediator,
			viewComponent = ShipRotateLayer,
			data = {
				shipGroup = arg_3_1,
				showTrans = arg_3_2,
				skin = arg_3_3
			},
			onRemoved = function()
				setActive(self.viewComponent.blurPanel, true)
				setActive(self.viewComponent._tf, true)

				return
			end
		}))

		return
	end)
	self:bind(ShipProfileScene.SHOW_SKILL_INFO, function(arg_5_0, arg_5_1, arg_5_2)
		self:addSubLayers(Context.New({
			mediator = SkillInfoMediator,
			viewComponent = SkillInfoLayer,
			data = {
				skillOnShip = arg_5_2,
				skillId = arg_5_1
			}
		}))

		return
	end)
	self:bind(ShipProfileScene.SHOW_EVALUATION, function(arg_6_0, arg_6_1, arg_6_2)
		if arg_6_2 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("npc_evaluation_tip"))

			return
		end

		self:sendNotification(GAME.FETCH_EVALUATION, arg_6_1)

		return
	end)
	self:bind(ShipProfileScene.WEDDING_REVIEW, function(arg_7_0, arg_7_1)
		self.viewComponent:onWeddingReview(true)
		self:addSubLayers(Context.New({
			mediator = ProposeMediator,
			viewComponent = ProposeUI,
			data = {
				review = true,
				group = arg_7_1.group,
				skinID = arg_7_1.skinID,
				finishCallback = function()
					self.viewComponent:onWeddingReview(false)

					return
				end
			}
		}))

		return
	end)
	self:bind(ShipProfileMediator.OPEN_EQUIP_CODE_SHARE, function(arg_9_0, arg_9_1)
		self:addSubLayers(Context.New({
			mediator = EquipCodeShareMediator,
			viewComponent = EquipCodeShareLayer,
			data = {
				shipGroupId = arg_9_1
			}
		}))

		return
	end)
	self:bind(ShipProfileMediator.OPEN_PAINTING_SHOW, function(arg_10_0, arg_10_1, arg_10_2)
		self:addSubLayers(Context.New({
			mediator = PaintingShowMediator,
			viewComponent = PaintingShowScene,
			data = {
				skinId = arg_10_1,
				callback = arg_10_2
			}
		}))

		return
	end)

	return
end

function ShipProfileMediator:listNotificationInterests()
	return {
		GAME.FETCH_EVALUATION_DONE,
		CollectionProxy.GROUP_INFO_UPDATE,
		ShipSkinProxy.SHIP_SKINS_UPDATE
	}
end

function ShipProfileMediator:handleNotification(arg_12_1)
	local var_12_0 = arg_12_1:getName()
	local var_12_1 = arg_12_1:getBody()

	if var_12_0 == GAME.FETCH_EVALUATION_DONE then
		self:addSubLayers(Context.New({
			mediator = ShipEvaluationMediator,
			viewComponent = ShipEvaluationLayer,
			data = {
				groupId = var_12_1,
				showTrans = self.showTrans
			}
		}))
	elseif var_12_0 == CollectionProxy.GROUP_INFO_UPDATE then
		if self.groupId == var_12_1 then
			self.viewComponent:setShipGroup((getProxy(CollectionProxy):getShipGroup(var_12_1)))
			self.viewComponent:FlushHearts()
		end
	elseif var_12_0 == ShipSkinProxy.SHIP_SKINS_UPDATE then
		self.viewComponent:setOwnedSkinList(getProxy(ShipSkinProxy):getSkinList())
	end

	return
end

return ShipProfileMediator
