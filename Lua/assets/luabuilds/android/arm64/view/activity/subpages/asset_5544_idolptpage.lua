local IdolPTPage = class("IdolPTPage", import(".TemplatePage.PtTemplatePage"))

IdolPTPage.RefreshTime = 300

function IdolPTPage:OnInit()
	IdolPTPage.super.OnInit(self)

	self.lableList = self.bg:Find("list")
	self.lableItems = {}

	for iter_1_0 = 0, self.lableList.childCount - 1 do
		table.insert(self.lableItems, self.lableList:GetChild(iter_1_0))
	end

	self.linkBtn = self.bg:Find("btn_link")

	return
end

function IdolPTPage:OnDataSetting()
	return (IdolPTPage.super.OnDataSetting(self))
end

function IdolPTPage:OnFirstFlush()
	onButton(self, self.displayBtn, function()
		self:emit(ActivityMediator.SHOW_AWARD_WINDOW, PtAwardWindow, {
			type = self.ptData.type,
			dropList = self.ptData.dropList,
			targets = self.ptData.targets,
			level = self.ptData.level,
			count = self.ptData.count,
			resId = self.ptData.resId
		})

		return
	end, SFX_PANEL)
	onButton(self, self.battleBtn, function()
		self:emit(ActivityMediator.BATTLE_OPERA)

		return
	end, SFX_PANEL)
	onButton(self, self.getBtn, function()
		local var_6_0, var_6_1 = self.ptData:GetResProgress()

		self:emit(ActivityMediator.EVENT_PT_OPERATION, {
			cmd = 1,
			activity_id = self.ptData:GetId(),
			arg1 = var_6_1
		})

		return
	end, SFX_PANEL)
	onButton(self, self.linkBtn, function()
		self:emit(ActivityMediator.OPEN_LAYER, Context.New({
			viewComponent = InstagramLayer,
			mediator = InstagramMediator,
			data = {
				id = ActivityConst.IDOL_INS_ID
			}
		}))

		return
	end)

	return
end

function IdolPTPage:OnUpdateFlush()
	IdolPTPage.super.OnUpdateFlush(self)

	if self.linkAct and not self.linkAct:isEnd() then
		local var_8_0 = {}

		for iter_8_0 = 1, math.floor(#self.linkAct.data1_list / 2) do
			var_8_0[self.linkAct.data1_list[2 * iter_8_0 - 1]] = (var_8_0[self.linkAct.data1_list[2 * iter_8_0 - 1]] or 0) + (self.linkAct.data1_list[2 * iter_8_0] or 0)
		end

		local var_8_2 = {}

		for iter_8_1, iter_8_2 in pairs(var_8_0) do
			table.insert(var_8_2, {
				name = iter_8_1,
				count = iter_8_2
			})
		end

		table.sort(var_8_2, function(arg_9_0, arg_9_1)
			if arg_9_0.count == arg_9_1.count then
				return arg_9_0.name < arg_9_1.name
			else
				return arg_9_0.count > arg_9_1.count
			end

			return
		end)

		local var_8_3 = math.min(#var_8_2, #self.lableItems)

		for iter_8_3 = 1, var_8_3 do
			setText(self.lableItems[iter_8_3]:Find("name"), "#" .. tostring(ShipGroup.getDefaultShipNameByGroupID(var_8_2[iter_8_3].name)) .. "#")
			setText(self.lableItems[iter_8_3]:Find("Text"), self:TransFormat(var_8_2[iter_8_3].count))
		end

		for iter_8_4 = var_8_3 + 1, #self.lableItems do
			setText(self.lableItems[iter_8_4]:Find("name"), "")
			setText(self.lableItems[iter_8_4]:Find("Text"), "0")
		end
	end

	self:GetWorldRank(self.RefreshTime)

	return
end

function IdolPTPage:TransFormat(arg_10_1)
	arg_10_1 = tonumber(arg_10_1) or 0

	local var_10_0 = math.floor(arg_10_1 / 1000)

	if var_10_0 >= 1 then
		return var_10_0 .. ((arg_10_1 % 10 > 0 or nil) and ("." .. arg_10_1 % 10 or "")) .. "K"
	else
		return arg_10_1
	end

	return
end

function IdolPTPage:GetWorldRank(arg_11_1)
	if not self.linkAct or self.linkAct:isEnd() then
		return
	end

	local var_11_0 = self.linkAct.id

	if arg_11_1 <= pg.TimeMgr.GetInstance():GetServerTime() - (getProxy(ActivityProxy).requestTime[self.linkAct.id] or 0) then
		self:emit(ActivityMediator.FETCH_INSTARGRAM, {
			activity_id = var_11_0
		})
	end

	return
end

function IdolPTPage.NeedTip()
	local var_12_0 = getProxy(ActivityProxy):getActivityById(ActivityConst.IDOL_PT_ID)

	if var_12_0 and not var_12_0:isEnd() then
		return var_12_0:readyToAchieve()
	end

	return
end

return IdolPTPage
