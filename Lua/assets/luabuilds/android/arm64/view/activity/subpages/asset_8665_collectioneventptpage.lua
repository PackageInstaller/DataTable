local CollectionEventPtPage = class("CollectionEventPtPage", import("view.base.BaseActivityPage"))

function CollectionEventPtPage:OnInit()
	self.bg = self._tf:Find("AD")
	self.helpBtn = self.bg:Find("help")
	self.shopBtn = self.bg:Find("shop")
	self.eventBtn = self.bg:Find("event")
	self.resTF = self.bg:Find("res")
	self.resIcon = self.resTF:Find("icon"):GetComponent(typeof(Image))
	self.resNum = self.resTF:Find("num"):GetComponent(typeof(Text))

	return
end

function CollectionEventPtPage:OnDataSetting()
	self.shopId = self.activity:getConfig("config_client").shopActID

	return
end

function CollectionEventPtPage:OnFirstFlush()
	onButton(self, self.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.commission_event_tip.tip
		})

		return
	end)
	onButton(self, self.shopBtn, function()
		self:emit(ActivityMediator.GO_SHOPS_LAYER, {
			warp = NewShopsScene.TYPE_ACTIVITY,
			actId = self.shopId
		})

		return
	end)
	onButton(self, self.eventBtn, function()
		pg.m02:sendNotification(GAME.GO_SCENE, SCENE.EVENT)

		return
	end)

	local var_3_0 = getProxy(PlayerProxy):getData().id

	if PlayerPrefs.GetInt("ACTIVITY_TYPE_EVENT_" .. self.activity.id .. "_" .. var_3_0) == 0 then
		PlayerPrefs.SetInt("ACTIVITY_TYPE_EVENT_" .. self.activity.id .. "_" .. var_3_0, 1)
		getProxy(ActivityProxy):updateActivity(self.activity)
	end

	return
end

function CollectionEventPtPage:OnUpdateFlush()
	self.resNum.text = getProxy(PlayerProxy):getData():getResource(pg.activity_template[self.shopId].config_client.pt_id)

	return
end

return CollectionEventPtPage
