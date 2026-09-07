local BlackFridayPage = class("BlackFridayPage", import("...base.BaseActivityPage"))
local var_0_1 = 1
local var_0_2 = 2
local var_0_3 = 3

function BlackFridayPage:OnInit()
	self.shopBtn = self._tf:Find("AD/shop_btn")
	self.uiList = UIItemList.New(self._tf:Find("AD/list"), self._tf:Find("AD/list/award"))
	self.finishCntTxt = self._tf:Find("AD/Text"):GetComponent(typeof(Text))
	self.helpBtn = self._tf:Find("AD/help")

	return
end

function BlackFridayPage:OnDataSetting()
	if self.ptData then
		self.ptData:Update(self.activity)
	else
		self.ptData = ActivityPtData.New(self.activity)
	end

	self.endTime = self.activity.stopTime

	local var_2_0 = self.activity:getConfig("config_client")

	if var_2_0 and var_2_0[1] and type(var_2_0[1]) == "table" then
		self.endTime = pg.TimeMgr.GetInstance():parseTimeFromConfig(var_2_0[1])
	end

	return
end

function BlackFridayPage:OnFirstFlush()
	if not IsNil(self.helpBtn) then
		onButton(self, self.helpBtn, function()
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				type = MSGBOX_TYPE_HELP,
				helps = pg.gametip.blackfriday_help.tip
			})

			return
		end, SFX_PANEL)
	end

	onButton(self, self.shopBtn, function()
		if pg.TimeMgr.GetInstance():GetServerTime() >= self.endTime then
			pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))
		else
			self:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.SKINSHOP, {
				page = NewSkinShopScene.PAGE_RETURN
			})
		end

		return
	end, SFX_PANEL)
	self.uiList:make(function(arg_6_0, arg_6_1, arg_6_2)
		if arg_6_0 == UIItemList.EventUpdate then
			self:UpdateAward(arg_6_1 + 1, arg_6_2)
		end

		return
	end)

	return
end

function BlackFridayPage:GetState(arg_7_1)
	local var_7_0 = arg_7_1 <= self.finishCnt
	local var_7_1 = table.contains(self.finishList, self.ptData.targets[arg_7_1])

	if var_7_1 then
		return var_0_3
	elseif not var_7_1 and var_7_0 then
		return var_0_2
	else
		return var_0_1
	end

	return
end

function BlackFridayPage:UpdateAward(arg_8_1, arg_8_2)
	local var_8_0 = {
		type = self.awards[arg_8_1][1],
		id = self.awards[arg_8_1][2],
		count = self.awards[arg_8_1][3]
	}

	updateDrop(arg_8_2, var_8_0)
	setActive(arg_8_2:Find("icon_bg/count"), var_8_0.count > 0)

	arg_8_2:Find("icon_bg/frame"):GetComponent(typeof(Image)).color = Color.New(0, 0, 0, 0)

	local var_8_1 = self:GetState(arg_8_1)

	setActive(arg_8_2:Find("got"), var_8_1 == var_0_3)
	setActive(arg_8_2:Find("get"), var_8_1 == var_0_2)
	setActive(arg_8_2:Find("lock"), var_8_1 == var_0_1)

	if var_8_1 == var_0_2 then
		onButton(self, arg_8_2, function()
			self:emit(ActivityMediator.EVENT_PT_OPERATION, {
				cmd = 1,
				activity_id = self.ptData:GetId(),
				arg1 = self.ptData.targets[arg_8_1]
			})

			return
		end, SFX_PANEL)
	else
		onButton(self, arg_8_2, function()
			self:emit(BaseUI.ON_DROP, var_8_0)

			return
		end, SFX_PANEL)
	end

	return
end

function BlackFridayPage:OnUpdateFlush()
	self.awards = self.ptData.dropList
	self.finishCnt = self.ptData.count
	self.finishList = self.ptData.activity.data1_list
	self.finishCntTxt.text = "X" .. self.finishCnt

	self.uiList:align(#self.awards)

	return
end

function BlackFridayPage:OnDestroy()
	return
end

return BlackFridayPage
