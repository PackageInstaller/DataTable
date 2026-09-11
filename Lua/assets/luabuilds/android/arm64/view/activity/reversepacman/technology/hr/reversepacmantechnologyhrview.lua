local ReversePacmanTechnologyHrView = class("ReversePacmanTechnologyHrView", import("view.base.BasePanel"))

ReversePacmanTechnologyHrView.GIFT_SUCCESS = "ReversePacmanTechnologyHrView::GIFT_SUCCESS"
ReversePacmanTechnologyHrView.STORY_SELECTED_OPTIONAL = "ReversePacmanTechnologyHrView::STORY_SELECTED_OPTIONAL"
ReversePacmanTechnologyHrView.STORY_ADD_FAVORABILITY = "ReversePacmanTechnologyHrView::STORY_ADD_FAVORABILITY"

function ReversePacmanTechnologyHrView:Ctor(arg_1_1, arg_1_2)
	self._go = arg_1_1.gameObject

	ReversePacmanTechnologyHrView.super.Ctor(self, self._go)

	self._parentClass = arg_1_2

	self:attach(arg_1_2)
	self:Init()
	self:didEnter()

	return
end

function ReversePacmanTechnologyHrView:Init()
	setText(self.uiFrontText, i18n("reverse_pacman_owned"))

	local var_2_0 = ReversePacmanTools.GetGiftItemID()

	setImageSprite(self.uiIconImage, GetSpriteFromAtlas(Drop.New({
		type = DROP_TYPE_VITEM,
		id = var_2_0
	}):getIcon(), ""))
	onButton(self, self.uiCurrencyBtn, function()
		local var_3_0 = Drop.New({
			type = DROP_TYPE_VITEM,
			id = var_2_0
		})
		local var_3_1 = {
			viewComponent = ReversePacmanItemPopScene,
			mediator = ReversePacmanItemPopMediator
		}
		local var_3_2 = {
			dropType = var_3_0.type,
			dropID = var_3_0.id,
			count = ReversePacmanTools.GetItemCnt(var_2_0)
		}
		local var_3_3 = ReversePacmanTools.GetActivity():getConfig("config_client").gift_link

		var_3_3 = var_3_3 or 239
		var_3_2.limitItemGuideID = var_3_3
		var_3_1.data = var_3_2

		self:emit(BaseUI.ON_ADD_SUBLAYER, Context.New(var_3_1))

		return
	end, SFX_PANEL)

	self.uiScrollView = LuaList.New(self, handler(self, self.IndexItem), self.uiListTf, ReversePacmanTechnologyHrItem)

	return
end

function ReversePacmanTechnologyHrView:didEnter()
	local var_4_0 = ReversePacmanTools.GetActivity()
	local var_4_1 = var_4_0:getConfig("config_client").chasing_char

	self.roleIDList = Clone(var_4_1)

	local var_4_2 = var_4_0:GetFavorabilityList()

	table.sort(self.roleIDList, function(arg_5_0, arg_5_1)
		local var_5_0 = ReversePacmanTools.IsUnlockRole(arg_5_0)

		if var_5_0 ~= ReversePacmanTools.IsUnlockRole(arg_5_1) then
			return var_5_0 == true
		else
			return table.keyof(var_4_1, arg_5_0) < table.keyof(var_4_1, arg_5_1)
		end

		return
	end)
	self.uiScrollView:StartScroll(#self.roleIDList)

	self.eventIDList = {
		self:bind(ReversePacmanTechnologyHrView.GIFT_SUCCESS, handler(self, self.OnGiftSuccess)),
		self:bind(ReversePacmanTechnologyHrView.STORY_SELECTED_OPTIONAL, handler(self, self.OnStorySelectedOptional)),
		self:bind(ReversePacmanTechnologyHrView.STORY_ADD_FAVORABILITY, handler(self, self.OnSotryAddFavorablity))
	}

	local var_4_3 = ReversePacmanTools.GetFavorabilityUnreadyStory()

	if #var_4_3 > 0 then
		local var_4_4 = {}

		for iter_4_0, iter_4_1 in ipairs(var_4_3) do
			table.insert(var_4_4, function(arg_6_0)
				self:PlayFavorabilityStory(iter_4_1, arg_6_0)

				return
			end)
		end

		seriesAsync(var_4_4, function()
			return
		end)
	end

	return
end

function ReversePacmanTechnologyHrView:Show()
	self:RefreshCurrency()
	self.uiScrollView:Refresh()

	return
end

function ReversePacmanTechnologyHrView:RefreshCurrency()
	setText(self.uiGiftCntText, i18n("reverse_pacman_count", ReversePacmanTools.GetItemCnt((ReversePacmanTools.GetGiftItemID()))))

	return
end

function ReversePacmanTechnologyHrView:IndexItem(arg_10_1, arg_10_2)
	arg_10_2:didEnter(self.roleIDList[arg_10_1])

	return
end

function ReversePacmanTechnologyHrView:OnGiftSuccess(arg_11_1, arg_11_2)
	self.uiScrollView:Refresh()
	pg.TipsMgr.GetInstance():ShowTips(i18n("reverse_pacman_favourite_increased", HXSet.hxLan(pg.activity_chasing_character[arg_11_2].name)))
	self:PlayFavorabilityStory(arg_11_2)

	return
end

function ReversePacmanTechnologyHrView:PlayFavorabilityStory(arg_12_1, arg_12_2)
	self:RefreshCurrency()

	local var_12_0 = ReversePacmanTools.GetUpgradeFavorability(arg_12_1)

	if var_12_0 ~= 0 then
		self.storyRoleID = arg_12_1
		self.storyOptionalFlag = pg.activity_chasing_character[arg_12_1].love_level_show[var_12_0][2]

		pg.NewStoryMgr.GetInstance():Play(pg.activity_chasing_character[arg_12_1].love_level_show[var_12_0][1], function()
			existCall(arg_12_2)

			return
		end)
	end

	return
end

function ReversePacmanTechnologyHrView:OnStorySelectedOptional(arg_14_1, arg_14_2)
	if arg_14_2.optionalFlag == self.storyOptionalFlag then
		self:emit(ReversePacmanTechnologyMediator.CMD_SELECTED_OPTIONAL, {
			roleID = self.storyRoleID
		})
	end

	return
end

function ReversePacmanTechnologyHrView:OnSotryAddFavorablity(arg_15_1, arg_15_2)
	pg.TipsMgr.GetInstance():ShowTips(i18n("reverse_pacman_favourite_increased", HXSet.hxLan(pg.activity_chasing_character[arg_15_2].name)))
	self.uiScrollView:Refresh()

	return
end

function ReversePacmanTechnologyHrView:willExit()
	for iter_16_0, iter_16_1 in ipairs(self.eventIDList) do
		self:disconnect(iter_16_1)
	end

	self.eventIDList = nil

	self:detach()
	self.uiScrollView:Dispose()

	self.uiScrollView = nil

	return
end

return ReversePacmanTechnologyHrView
