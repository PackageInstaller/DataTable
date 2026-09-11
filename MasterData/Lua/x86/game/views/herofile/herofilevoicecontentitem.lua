local HeroFileVoiceContentItem = class("HeroFileVoiceContentItem", ReduxView)

function HeroFileVoiceContentItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function HeroFileVoiceContentItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function HeroFileVoiceContentItem:InitUI()
	self:BindCfgUI()

	self.typeID_ = -1
	self.itemList_ = {}
	self.curHeroID_ = -1
	self.showController_ = self.mainControllerEx_:GetController("show")
	self.bgController = self.mainControllerEx_:GetController("bg")
	self.expand = false
end

function HeroFileVoiceContentItem:SetData(arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5)
	self.curHeroID_ = arg_4_1
	self.typeID_ = arg_4_2
	self.formID_ = arg_4_3 or nil
	self.onClick_ = arg_4_4
	self.showClick_ = arg_4_5

	self:RefreshUI()
end

function HeroFileVoiceContentItem:RefreshUI()
	self.typeText_.text = HeroVoiceTagCfg[self.typeID_].tag_name

	self:InitItemList()
	self:RefreshActive()
end

function HeroFileVoiceContentItem:RefreshActive()
	SetActive(self.gameObject_, not self:IsEmpty())
end

function HeroFileVoiceContentItem:AddUIListener()
	self:AddBtnListener(self.showBtn_, nil, function()
		self:ChangeShow(not self.expand)
		self.showClick_()
	end)
end

function HeroFileVoiceContentItem:ChangeShow(arg_9_1)
	if self.expand == arg_9_1 then
		return
	end

	self.expand = arg_9_1

	self.showController_:SetSelectedIndex(self.expand and 1 or 0)
end

function HeroFileVoiceContentItem:InitItemList()
	self:UpdateVoiceData()

	for iter_10_0, iter_10_1 in ipairs(self.voiceList_) do
		local var_10_0 = self.itemList_[iter_10_0]

		if not self.itemList_[iter_10_0] then
			var_10_0 = HeroFileVoiceItem.New((Object.Instantiate(self.itemGo_, self.content_)))
			self.itemList_[iter_10_0] = var_10_0
		end

		var_10_0:SetIsShow(true)
		var_10_0:SetData((HeroVoiceCfg[iter_10_1.id].use_skin_id == 0 or nil) and self.curHeroID_, iter_10_1, self.onClick_)
	end

	for iter_10_2 = #self.voiceList_ + 1, #self.itemList_ do
		self.itemList_[iter_10_2]:SetIsShow(false)
	end
end

function HeroFileVoiceContentItem:SetIsShow(arg_11_1)
	SetActive(self.gameObject_, arg_11_1)
end

local function var_0_2(arg_12_0)
	return nullable(SkinCfg, arg_12_0, "hero")
end

local var_0_3 = 8

local function var_0_4(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_2 == var_0_3 and not OathTools.IsOath(arg_13_1) then
		return
	end

	for iter_13_0, iter_13_1 in ipairs(HeroVoiceCfg.get_id_list_by_tag_id[arg_13_2]) do
		local var_13_0 = nullable(HeroVoiceDescCfg.get_id_list_by_subtitle_id_form_id, iter_13_1)

		if var_13_0 then
			for iter_13_2, iter_13_3 in pairs(var_13_0) do
				if var_0_2(iter_13_2) == arg_13_1 then
					table.insert(arg_13_0, iter_13_1)

					break
				end
			end
		end
	end
end

function HeroFileVoiceContentItem:UpdateVoiceData()
	self.voiceList_ = {}

	local var_14_0 = {}

	if self.formID_ then
		var_0_4(var_14_0, var_0_2(self.formID_), self.typeID_)
	else
		var_0_4(var_14_0, self.curHeroID_, self.typeID_)
	end

	for iter_14_0, iter_14_1 in ipairs(var_14_0) do
		local var_14_1 = HeroTools.IsUnlockVoice(self.curHeroID_, iter_14_1)
		local var_14_2 = HeroVoiceCfg[iter_14_1].use_skin_id

		if HeroVoiceCfg[iter_14_1].use_skin_id == 0 then
			var_14_2 = self.curHeroID_
		end

		local var_14_3 = (HeroVoiceCfg[iter_14_1].hide or 0) ~= 0
		local var_14_4 = HeroVoiceDescCfg.Get(var_14_2, iter_14_1)

		if var_14_4 ~= nil and var_14_4 ~= "" and not var_14_3 then
			table.insert(self.voiceList_, {
				id = iter_14_1,
				unlock = var_14_1
			})
		end
	end

	table.sort(self.voiceList_, function(arg_15_0, arg_15_1)
		if (arg_15_0.unlock or arg_15_1.unlock) and arg_15_0.unlock ~= arg_15_1.unlock then
			return arg_15_0.unlock
		end

		return arg_15_0.id < arg_15_1.id
	end)
end

function HeroFileVoiceContentItem:IsEmpty()
	if self.voiceList_ and #self.voiceList_ == 0 then
		return true
	else
		return false
	end
end

function HeroFileVoiceContentItem:Dispose()
	for iter_17_0, iter_17_1 in pairs(self.itemList_) do
		iter_17_1:Dispose()
	end

	self.itemList_ = {}

	HeroFileVoiceContentItem.super.Dispose(self)
end

function HeroFileVoiceContentItem:StartPlay(arg_18_1)
	for iter_18_0, iter_18_1 in ipairs(self.voiceList_) do
		if self.itemList_[iter_18_0] then
			if arg_18_1 == iter_18_1.id then
				self.itemList_[iter_18_0]:StartPlay()
			else
				self.itemList_[iter_18_0]:StopPlay()
			end
		end
	end
end

function HeroFileVoiceContentItem:StopPlay()
	for iter_19_0, iter_19_1 in ipairs(self.itemList_) do
		iter_19_1:StopPlay()
	end
end

function HeroFileVoiceContentItem:GetItemByID(arg_20_1)
	for iter_20_0, iter_20_1 in pairs(self.itemList_) do
		if iter_20_1:GetID() == arg_20_1 then
			return iter_20_1
		end
	end

	return nil
end

function HeroFileVoiceContentItem:SetBgState(arg_21_1)
	self.bgController:SetSelectedState(arg_21_1)
end

return HeroFileVoiceContentItem
