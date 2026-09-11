local CultureGravureEquiptItem = class("CultureGravureEquiptItem", ReduxView)

function CultureGravureEquiptItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function CultureGravureEquiptItem:Init()
	self:InitUI()
	self:AddListeners()

	self.equiptList_ = LuaList.New(handler(self, self.IndexEquiptItem), self.equiptListGo_, CultureGravureRecommendEquipItem)
	self.infoNumController_ = self.equipCon_:GetController("infonum")
	self.equipController_ = self.equipCon_:GetController("state")
	self.infoItemList_ = {}

	for iter_2_0 = 1, 3 do
		table.insert(self.infoItemList_, (CultureGravureEquiptInfoItem.New(self["infoGo" .. iter_2_0 .. "_"])))
	end
end

function CultureGravureEquiptItem:SetData(arg_3_1, arg_3_2, arg_3_3)
	self.data_ = arg_3_2
	self.rate_ = arg_3_2.rate
	self.heroID_ = arg_3_3
	self.recommendIdList_ = arg_3_2.list

	table.sort(self.recommendIdList_, function(arg_4_0, arg_4_1)
		return EquipCfg[arg_4_0].pos < EquipCfg[arg_4_1].pos
	end)

	self.stateList_ = {}
	self.hasAllEquipt = true
	self.canAllEquipt = true

	self:RefreshUI()
end

function CultureGravureEquiptItem:AddListeners()
	self:AddBtnListener(self.equipBtn_, nil, function()
		if self.hasAllEquipt or not self.canAllEquipt then
			return
		end

		JumpTools.OpenPageByJump("cultureGravureEquipPopView", {
			index = 0,
			heroId = self.heroID_,
			recommendIdList = self.recommendIdList_,
			stateList = self.stateList_
		})
	end)
end

function CultureGravureEquiptItem:InitUI()
	self:BindCfgUI()
end

function CultureGravureEquiptItem:SetCallBack(arg_8_1)
	self.callback = arg_8_1
end

function CultureGravureEquiptItem:RefreshUI()
	self.rateText_.text = math.floor(self.rate_ / 100)

	self.equiptList_:StartScroll(#self.recommendIdList_)

	local var_9_0 = {}
	local var_9_1 = 0

	for iter_9_0, iter_9_1 in ipairs(self.recommendIdList_) do
		if not var_9_0[EquipCfg[iter_9_1].suit] then
			var_9_0[EquipCfg[iter_9_1].suit] = {}
			var_9_1 = var_9_1 + 1
		end

		table.insert(var_9_0[EquipCfg[iter_9_1].suit], iter_9_1)
	end

	self.infoNumController_:SetSelectedState(var_9_1)

	local var_9_2 = {}

	for iter_9_2, iter_9_3 in pairs(var_9_0) do
		table.insert(var_9_2, iter_9_3)
	end

	if #var_9_2 > 1 then
		table.sort(var_9_2, function(arg_10_0, arg_10_1)
			return EquipCfg[arg_10_0[1]].pos < EquipCfg[arg_10_1[1]].pos
		end)
	end

	for iter_9_4 = 1, #var_9_2 do
		self.infoItemList_[iter_9_4]:SetData(iter_9_4, var_9_2[iter_9_4])
	end
end

function CultureGravureEquiptItem:IndexEquiptItem(arg_11_1, arg_11_2)
	local var_11_0 = self.recommendIdList_[arg_11_1]
	local var_11_1 = CultureGravureData:GetHasEquipt(self.recommendIdList_[arg_11_1])
	local var_11_2 = CultureGravureData:GetEquiptIsEquipped(self.heroID_, self.recommendIdList_[arg_11_1])

	if not var_11_2 then
		self.hasAllEquipt = false
	end

	if not var_11_2 and not var_11_1 then
		self.canAllEquipt = false
	end

	self.stateList_[arg_11_1] = var_11_2 and "had" or var_11_1 and "equip" or "get"

	arg_11_2:SetData(arg_11_1, var_11_0, self.heroID_, var_11_2 and "had" or var_11_1 and "equip" or "get")

	if arg_11_1 == #self.recommendIdList_ then
		SetActive(self.btnGroup_, self.canAllEquipt)
		self.equipController_:SetSelectedState(tostring(self.hasAllEquipt))
	end
end

function CultureGravureEquiptItem:Dispose()
	if self.equiptList_ then
		self.equiptList_:Dispose()

		self.equiptList_ = nil
	end

	if self.infoItemList_ then
		for iter_12_0 = 1, #self.infoItemList_ do
			self.infoItemList_[iter_12_0]:Dispose()
		end

		self.infoItemList_ = nil
	end

	CultureGravureEquiptItem.super.Dispose(self)
end

return CultureGravureEquiptItem
