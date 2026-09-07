local NewBackYardThemeTemplateMediator = class("NewBackYardThemeTemplateMediator", import("...base.ContextMediator"))

NewBackYardThemeTemplateMediator.FETCH_ALL_THEME = "NewBackYardThemeTemplateMediator:FETCH_ALL_THEME"
NewBackYardThemeTemplateMediator.ON_CHARGE = "NewBackYardThemeTemplateMediator:ON_CHARGE"
NewBackYardThemeTemplateMediator.ON_SHOPPING = "NewBackYardShopMediator:ON_SHOPPING"
NewBackYardThemeTemplateMediator.ON_LIKE_THEME = "NewBackYardThemeTemplateMediator:ON_LIKE_THEME"
NewBackYardThemeTemplateMediator.ON_COLECT_THEME = "NewBackYardThemeTemplateMediator:ON_COLECT_THEME"
NewBackYardThemeTemplateMediator.ON_APPLY_TEMPLATE = "NewBackYardThemeTemplateMediator:ON_APPLY_TEMPLATE"
NewBackYardThemeTemplateMediator.ON_UPLOAD_TEMPLATE = "NewBackYardThemeTemplateMediator:ON_UPLOAD_TEMPLATE"
NewBackYardThemeTemplateMediator.ON_CANCEL_UPLOAD_TEMPLATE = "NewBackYardThemeTemplateMediator:ON_CANCEL_UPLOAD_TEMPLATE"
NewBackYardThemeTemplateMediator.ON_DELETE_TEMPLATE = "NewBackYardThemeTemplateMediator:ON_DELETE_TEMPLATE"
NewBackYardThemeTemplateMediator.GET_TEMPLATE_PLAYERINFO = "NewBackYardThemeTemplateMediator:GET_TEMPLATE_PLAYERINFO"
NewBackYardThemeTemplateMediator.ON_DISPLAY_PLAYER_INFO = "NewBackYardThemeTemplateMediator:ON_DISPLAY_PLAYER_INFO"
NewBackYardThemeTemplateMediator.ON_SEARCH = "NewBackYardThemeTemplateMediator:ON_SEARCH"
NewBackYardThemeTemplateMediator.ON_REFRESH = "NewBackYardThemeTemplateMediator:ON_REFRESH"
NewBackYardThemeTemplateMediator.ON_GET_THEMPLATE_DATA = "NewBackYardThemeTemplateMediator:ON_GET_THEMPLATE_DATA"
NewBackYardThemeTemplateMediator.ON_GET_SPCAIL_TYPE_TEMPLATE = "NewBackYardThemeTemplateMediator:ON_GET_SPCAIL_TYPE_TEMPLATE"
NewBackYardThemeTemplateMediator.GO_DECORATION = "NewBackYardThemeTemplateMediator:GO_DECORATION"

function NewBackYardThemeTemplateMediator:register()
	self:bind(NewBackYardThemeTemplateMediator.GO_DECORATION, function(arg_2_0)
		self:sendNotification(GAME.GO_SCENE, SCENE.COURTYARD, {
			openDecoration = true
		})

		return
	end)
	self:bind(NewBackYardThemeTemplateMediator.ON_GET_SPCAIL_TYPE_TEMPLATE, function(arg_3_0, arg_3_1)
		self:sendNotification(GAME.BACKYARD_GET_SPECIFIED_TYPE_TEMPLATE, {
			type = arg_3_1
		})

		return
	end)
	self:bind(NewBackYardThemeTemplateMediator.ON_GET_THEMPLATE_DATA, function(arg_4_0, arg_4_1, arg_4_2)
		self:sendNotification(GAME.BACKYARD_GET_THEME_TEMPLATE_DATA, {
			templateId = arg_4_1,
			callback = arg_4_2
		})

		return
	end)
	self:bind(NewBackYardThemeTemplateMediator.ON_REFRESH, function(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
		self:sendNotification(GAME.BACKYARD_REFRESH_SHOP_TEMPLATE, {
			timeType = arg_5_3,
			type = arg_5_1,
			page = arg_5_2,
			force = arg_5_4
		})

		return
	end)
	self:bind(NewBackYardThemeTemplateMediator.ON_SEARCH, function(arg_6_0, arg_6_1, arg_6_2)
		if arg_6_1 == BackYardConst.THEME_TEMPLATE_TYPE_CUSTOM or arg_6_1 == BackYardConst.THEME_TEMPLATE_TYPE_COLLECTION then
			self.viewComponent:SearchKeyChange(arg_6_2)
		elseif arg_6_1 == BackYardConst.THEME_TEMPLATE_TYPE_SHOP then
			self:sendNotification(GAME.BACKYARD_SEARCH_THEME_TEMPLATE, {
				str = arg_6_2
			})
		end

		return
	end)
	self:bind(NewBackYardThemeTemplateMediator.ON_SHOPPING, function(arg_7_0, arg_7_1, arg_7_2)
		self:sendNotification(GAME.BUY_FURNITURE, {
			furnitureIds = arg_7_1,
			type = arg_7_2
		})

		return
	end)
	self:bind(NewBackYardThemeTemplateMediator.ON_DISPLAY_PLAYER_INFO, function(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
		self.contextData.pos = arg_8_2
		self.contextData.themeName = arg_8_3

		self:sendNotification(GAME.FRIEND_SEARCH, {
			type = SearchFriendCommand.SEARCH_TYPE_RESUME,
			keyword = arg_8_1
		})

		return
	end)
	self:bind(NewBackYardThemeTemplateMediator.GET_TEMPLATE_PLAYERINFO, function(arg_9_0, arg_9_1, arg_9_2)
		self:sendNotification(GAME.BACKYARD_GET_THEME_TEMPLATE_PLAYE_INFO, {
			type = arg_9_1,
			templateId = arg_9_2.id,
			userId = arg_9_2:GetUserId()
		})

		return
	end)
	self:bind(NewBackYardThemeTemplateMediator.ON_UPLOAD_TEMPLATE, function(arg_10_0, arg_10_1)
		local var_10_0 = getProxy(PlayerProxy):getData()

		if not var_10_0:CanUploadBackYardThemeTemplate() then
			self.contextData.msgBox:ExecuteAction("SetUp", {
				hideNo = true,
				content = i18n("backyard_theme_ban_upload_tip", (var_10_0:GetBanUploadBackYardThemeTemplateTime()))
			})

			return
		end

		if getProxy(DormProxy):GetUploadThemeTemplateCnt() >= BackYardConst.MAX_UPLOAD_THEME_CNT then
			self.contextData.msgBox:ExecuteAction("SetUp", {
				hideNo = true,
				content = i18n("backyard_theme_upload_over_maxcnt")
			})

			return
		end

		self:sendNotification(GAME.BACKYARD_UPLOAD_THEME_TEMPLATE, {
			templateId = arg_10_1.id
		})

		return
	end)
	self:bind(NewBackYardThemeTemplateMediator.ON_CANCEL_UPLOAD_TEMPLATE, function(arg_11_0, arg_11_1)
		self.contextData.msgBox:ExecuteAction("SetUp", {
			content = i18n("backyard_theme_cancel_template_upload_tip"),
			onYes = function()
				self:sendNotification(GAME.BACKYARD_UNLOAD_THEME_TEMPLATE, {
					templateId = arg_11_1.id
				})

				return
			end
		})

		return
	end)
	self:bind(NewBackYardThemeTemplateMediator.ON_DELETE_TEMPLATE, function(arg_13_0, arg_13_1)
		self.contextData.msgBox:ExecuteAction("SetUp", {
			content = i18n("backyard_theme_delete_themplate_tip"),
			onYes = function()
				self:sendNotification(GAME.BACKYARD_DELETE_THEME_TEMPLATE, {
					templateId = arg_13_1.id
				})

				return
			end
		})

		return
	end)
	self:bind(NewBackYardThemeTemplateMediator.ON_APPLY_TEMPLATE, function(arg_15_0, arg_15_1, arg_15_2)
		local function var_15_0()
			self:sendNotification(GAME.BACKYARD_APPLY_THEME_TEMPLATE, {
				template = arg_15_1
			})

			return
		end

		if not arg_15_1:OwnThemeTemplateFurniture() then
			self.contextData.msgBox:ExecuteAction("SetUp", {
				type = BackYardThemeTemplateMsgBox.TYPE_IMAGE,
				content = i18n("backyard_theme_apply_tip1"),
				srpiteName = arg_15_1:GetTextureIconName(),
				md5 = arg_15_1:GetIconMd5(),
				confirmTxt = i18n("backyard_theme_word_buy"),
				cancelTxt = i18n("backyard_theme_word_apply"),
				onYes = arg_15_2,
				onCancel = var_15_0
			})

			return
		end

		var_15_0()

		return
	end)
	self:bind(NewBackYardThemeTemplateMediator.ON_LIKE_THEME, function(arg_17_0, arg_17_1, arg_17_2)
		self:sendNotification(GAME.BACKYARD_LIKE_THEME_TEMPLATE, {
			templateId = arg_17_1.id,
			uploadTime = arg_17_2
		})

		return
	end)
	self:bind(NewBackYardThemeTemplateMediator.ON_COLECT_THEME, function(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
		self:sendNotification(GAME.BACKYARD_COLLECT_THEME_TEMPLATE, {
			templateId = arg_18_1.id,
			isCancel = arg_18_2,
			uploadTime = arg_18_3
		})

		return
	end)
	self:bind(NewBackYardThemeTemplateMediator.ON_CHARGE, function(arg_19_0, arg_19_1)
		if arg_19_1 == PlayerConst.ResDiamond then
			pg.m02:sendNotification(GAME.GO_SCENE, SCENE.CHARGE, {
				wrap = ChargeScene.TYPE_DIAMOND
			})
		elseif arg_19_1 == PlayerConst.ResDormMoney then
			pg.m02:sendNotification(GAME.GO_SCENE, SCENE.EVENT)
		end

		return
	end)
	self:bind(NewBackYardThemeTemplateMediator.FETCH_ALL_THEME, function(arg_20_0, arg_20_1)
		self:sendNotification(GAME.GET_ALL_BACKYARD_THEME_TEMPLATE, {
			callback = function(arg_21_0, arg_21_1, arg_21_2)
				self.viewComponent:SetShopThemeTemplate(arg_21_0)
				self.viewComponent:SetCustomThemeTemplate(arg_21_1)
				self.viewComponent:SetCollectionThemeTemplate(arg_21_2)
				arg_20_1()

				return
			end
		})

		return
	end)
	self.viewComponent:SetDorm(getProxy(DormProxy):getData())
	self.viewComponent:SetPlayer(getProxy(PlayerProxy):getData())

	return
end

function NewBackYardThemeTemplateMediator:listNotificationInterests()
	return {
		PlayerProxy.UPDATED,
		GAME.FRIEND_SEARCH_DONE,
		GAME.BACKYARD_REFRESH_SHOP_TEMPLATE_DONE,
		GAME.BACKYARD_GET_SPECIFIED_TYPE_TEMPLATE_DONE,
		GAME.BUY_FURNITURE_DONE,
		GAME.BACKYARD_APPLY_THEME_TEMPLATE_DONE,
		GAME.BACKYARD_SEARCH_THEME_TEMPLATE_DONE,
		GAME.BACKYARD_SEARCH_THEME_TEMPLATE_ERRO,
		GAME.BACKYARD_UNLOAD_THEME_TEMPLATE_DONE,
		GAME.BACKYARD_DELETE_THEME_TEMPLATE_DONE,
		GAME.BACKYARD_UPLOAD_THEME_TEMPLATE_DONE,
		DormProxy.THEME_TEMPLATE_UPDATED,
		DormProxy.DORM_UPDATEED,
		DormProxy.THEME_TEMPLATE_DELTETED,
		DormProxy.COLLECTION_THEME_TEMPLATE_ADDED,
		DormProxy.COLLECTION_THEME_TEMPLATE_DELETED,
		DormProxy.SHOP_THEME_TEMPLATE_DELETED,
		GAME.BACKYARD_REFRESH_SHOP_TEMPLATE_ERRO
	}
end

function NewBackYardThemeTemplateMediator:handleNotification(arg_23_1)
	local var_23_0 = arg_23_1:getName()
	local var_23_1 = arg_23_1:getBody()

	if var_23_0 == PlayerProxy.UPDATED then
		self.viewComponent:PlayerUpdated(var_23_1)
	elseif var_23_0 == DormProxy.THEME_TEMPLATE_UPDATED then
		local var_23_2 = getProxy(DormProxy)

		if var_23_1.type == BackYardConst.THEME_TEMPLATE_TYPE_SHOP then
			self.viewComponent:ShopThemeTemplateUpdate(var_23_1.template)
		elseif var_23_1.type == BackYardConst.THEME_TEMPLATE_TYPE_COLLECTION then
			self.viewComponent:CollectionThemeTemplateUpdate(var_23_1.template)
		elseif var_23_1.type == BackYardConst.THEME_TEMPLATE_TYPE_CUSTOM then
			self.viewComponent:CustomThemeTemplateUpdate(var_23_1.template)
		end
	elseif var_23_0 == GAME.FRIEND_SEARCH_DONE then
		if var_23_1.list[1] then
			self:addSubLayers(Context.New({
				viewComponent = FriendInfoLayer,
				mediator = FriendInfoMediator,
				data = {
					backyardView = true,
					friend = var_23_1.list[1],
					pos = self.contextData.pos,
					msg = self.contextData.themeName,
					groupName = self.viewComponent:getGroupName()
				}
			}))

			self.contextData.pos = nil
			self.contextData.themeName = nil
		end
	elseif var_23_0 == GAME.BACKYARD_REFRESH_SHOP_TEMPLATE_DONE then
		if var_23_1.existNew then
			BackYardThemeTempalteUtil.ClearAllCacheAsyn()
		end

		self.viewComponent:OnShopTemplatesUpdated((getProxy(DormProxy):GetShopThemeTemplates()))
	elseif var_23_0 == DormProxy.DORM_UPDATEED then
		self.viewComponent:UpdateDorm(getProxy(DormProxy):getData())
	elseif var_23_0 == GAME.BUY_FURNITURE_DONE then
		self.viewComponent:FurnituresUpdated((arg_23_1:getType()))
	elseif var_23_0 == GAME.BACKYARD_APPLY_THEME_TEMPLATE_DONE then
		self:sendNotification(GAME.GO_SCENE, SCENE.COURTYARD)
		pg.TipsMgr.GetInstance():ShowTips(i18n("backyard_theme_apply_success"))
	elseif var_23_0 == GAME.BACKYARD_SEARCH_THEME_TEMPLATE_DONE then
		self.viewComponent:ShopSearchKeyChange(var_23_1.template)
	elseif var_23_0 == GAME.BACKYARD_SEARCH_THEME_TEMPLATE_ERRO then
		self.viewComponent:ClearShopSearchKey()
	elseif var_23_0 == GAME.BACKYARD_UNLOAD_THEME_TEMPLATE_DONE then
		pg.TipsMgr.GetInstance():ShowTips(i18n("backyard_theme_unload_success"))
	elseif var_23_0 == DormProxy.THEME_TEMPLATE_DELTETED then
		self.viewComponent:DeleteCustomThemeTemplate(var_23_1.templateId)
	elseif var_23_0 == GAME.BACKYARD_DELETE_THEME_TEMPLATE_DONE then
		pg.TipsMgr.GetInstance():ShowTips(i18n("backyard_theme_delete_success"))
	elseif var_23_0 == GAME.BACKYARD_UPLOAD_THEME_TEMPLATE_DONE then
		pg.TipsMgr.GetInstance():ShowTips(i18n("backyard_theme_upload_success"))
	elseif var_23_0 == DormProxy.COLLECTION_THEME_TEMPLATE_ADDED then
		self.viewComponent:AddCollectionThemeTemplate(var_23_1.template)
	elseif var_23_0 == DormProxy.COLLECTION_THEME_TEMPLATE_DELETED then
		self.viewComponent:DeleteCollectionThemeTemplate(var_23_1.id)
	elseif var_23_0 == DormProxy.SHOP_THEME_TEMPLATE_DELETED then
		self.viewComponent:DeleteShopThemeTemplate(var_23_1.id)
	elseif var_23_0 == GAME.BACKYARD_REFRESH_SHOP_TEMPLATE_ERRO then
		self.viewComponent:OnShopTemplatesErro()
	end

	return
end

return NewBackYardThemeTemplateMediator
