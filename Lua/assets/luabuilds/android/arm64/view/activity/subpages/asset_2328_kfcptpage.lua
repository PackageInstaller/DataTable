local KFCPTPage = class("KFCPTPage", import(".TemplatePage.PtTemplatePage"))

KFCPTPage.SpineCharName = {
	"lafei_11",
	"lingbo_14"
}
KFCPTPage.SpineCharActionName = "stand_normal"
KFCPTPage.SpineShopActionSpeed = {
	0.8,
	1,
	1.2
}

function KFCPTPage:OnFirstFlush()
	KFCPTPage.super.OnFirstFlush(self)
	onButton(self, self.bg:Find("sdBtn"), function()
		pg.m02:sendNotification(GAME.GO_SCENE, SCENE.SKINSHOP)

		return
	end, SFX_PANEL)
	onButton(self, self.battleBtn, function()
		self:emit(ActivityMediator.SPECIAL_BATTLE_OPERA)

		return
	end, SFX_PANEL)
	onButton(self, self.getBtn, function()
		local var_4_0 = {}
		local var_4_1 = self.ptData:GetAward()
		local var_4_2 = getProxy(PlayerProxy):getRawData()
		local var_4_3, var_4_4 = Task.StaticJudgeOverflow(var_4_2.gold, var_4_2.oil, LOCK_UR_SHIP and 0 or getProxy(BagProxy):GetLimitCntById(pg.gameset.urpt_chapter_max.description[1]), true, true, {
			{
				var_4_1.type,
				var_4_1.id,
				var_4_1.count
			}
		})

		if var_4_3 then
			table.insert(var_4_0, function(arg_5_0)
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					type = MSGBOX_TYPE_ITEM_BOX,
					content = i18n("award_max_warning"),
					items = var_4_4,
					onYes = arg_5_0
				})

				return
			end)
		end

		seriesAsync(var_4_0, function()
			local var_6_0, var_6_1 = self.ptData:GetResProgress()

			self:emit(ActivityMediator.EVENT_PT_OPERATION, {
				cmd = 1,
				activity_id = self.ptData:GetId(),
				arg1 = var_6_1
			})
			self:SetLocalData()

			return
		end)

		return
	end, SFX_PANEL)

	self.sdContainer = self.bg:Find("sdcontainer")
	self.sdSpine = nil
	self.sdName = self.GetRandomName()
	self.sdSpineLRQ = GetSpineRequestPackage.New(self.sdName, function(arg_7_0)
		SetParent(arg_7_0, self.sdContainer)

		self.sdSpine = arg_7_0
		self.sdSpine.transform.localScale = Vector3.one

		local var_7_0 = self.sdSpine:GetComponent("SpineAnimUI")

		if var_7_0 then
			var_7_0:SetAction(KFCPTPage.SpineCharActionName, 0)
		end

		self.sdSpineLRQ = nil

		return
	end):Start()
	self.shopSpine = self.bg:Find("shop/shop")
	self.shopAnim = self.shopSpine:GetComponent("SpineAnimUI")
	self.shopGraphic = self.shopSpine:GetComponent("SkeletonGraphic")

	self.shopAnim:SetAction("normal", 0)

	return
end

function KFCPTPage:OnUpdateFlush()
	KFCPTPage.super.OnUpdateFlush(self)

	local var_8_0, var_8_1, var_8_2 = self.ptData:GetResProgress()

	setText(self.progress, (var_8_2 >= 1 and setColorStr(var_8_0, "#ffc563") or var_8_0) .. "/" .. var_8_1)

	if self.ptData:CanGetMorePt() then
		self:GetLocalData()

		if self.finishCount == 0 then
			self.shopAnim:SetAction("normal", 0)
		else
			self.shopAnim:SetAction("action", 0)

			self.shopGraphic.timeScale = KFCPTPage.SpineShopActionSpeed[self.finishCount]
		end
	else
		self.shopAnim:SetAction("action", 0)

		self.shopGraphic.timeScale = KFCPTPage.SpineShopActionSpeed[#KFCPTPage.SpineShopActionSpeed]
	end

	return
end

function KFCPTPage:GetLocalData()
	self.playerId = getProxy(PlayerProxy):getData().id

	local var_9_0 = pg.TimeMgr.GetInstance()

	self.curDay = var_9_0:DiffDay(self.ptData.startTime, var_9_0:GetServerTime()) + 1
	self.finishCount = PlayerPrefs.GetInt("kfc_pt_" .. self.playerId .. "_day_" .. self.curDay)

	return
end

function KFCPTPage:SetLocalData()
	self.finishCount = self.finishCount + 1

	if #KFCPTPage.SpineShopActionSpeed > self.finishCount then
		self.finishCount = self.finishCount or #KFCPTPage.SpineShopActionSpeed
	end

	PlayerPrefs.SetInt("kfc_pt_" .. self.playerId .. "_day_" .. self.curDay, self.finishCount)
	PlayerPrefs.Save()

	return
end

function KFCPTPage.GetRandomName()
	return KFCPTPage.SpineCharName[math.random(#KFCPTPage.SpineCharName)]
end

function KFCPTPage:OnDestroy()
	if self.sdSpineLRQ then
		self.sdSpineLRQ:Stop()

		self.sdSpineLRQ = nil
	end

	if self.sdSpine then
		self.sdSpine.transform.localScale = Vector3.one

		pg.PoolMgr.GetInstance():ReturnSpineChar(self.sdName, self.sdSpine)

		self.sdSpine = nil
		self.sdName = nil
	end

	return
end

return KFCPTPage
