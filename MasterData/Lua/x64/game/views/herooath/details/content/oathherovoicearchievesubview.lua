local OathHeroVoiceArchieveSubView = class("OathHeroVoiceArchieveSubView", BaseView)

function OathHeroVoiceArchieveSubView:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.parent = nullable(arg_1_2, "parentView")
	self.items = {}

	self:BindCfgUI()
end

function OathHeroVoiceArchieveSubView:OnEnter()
	SetActive(self.gameObject_, true)
	self:UpdateVoicePlayStatus()
end

function OathHeroVoiceArchieveSubView:OnExit()
	SetActive(self.gameObject_, false)
end

function OathHeroVoiceArchieveSubView:Dispose()
	if self.items then
		for iter_4_0, iter_4_1 in pairs(self.items) do
			Object.Destroy(iter_4_1.gameObject_)
			iter_4_1:Dispose()
		end
	end

	self.items = nil

	OathHeroVoiceArchieveSubView.super.Dispose(self)
end

function OathHeroVoiceArchieveSubView:GetHeroID()
	return self.curHeroID
end

OathHeroVoiceArchieveSubView.Item = HeroFileVoiceItem

local function var_0_1(arg_6_0, arg_6_1)
	for iter_6_0 = arg_6_0.list_.childCount + 1, arg_6_1 do
		local var_6_0 = Object.Instantiate(arg_6_0.itemPrefab_, arg_6_0.list_)
	end

	for iter_6_1 = 1, arg_6_0.list_.childCount do
		arg_6_0.items[iter_6_1] = arg_6_0.items[iter_6_1] or OathHeroVoiceArchieveSubView.Item.New(arg_6_0.list_:GetChild(iter_6_1 - 1).gameObject)

		arg_6_0.items[iter_6_1]:SetIsShow(iter_6_1 <= arg_6_1)
	end
end

function OathHeroVoiceArchieveSubView:PlayVoice(arg_7_1)
	if self.parent then
		self.parent:PlayVoice(arg_7_1, function()
			self:UpdateVoicePlayStatus()
		end)
	end

	self:UpdateVoicePlayStatus()
end

function OathHeroVoiceArchieveSubView:StopVoice()
	if self.parent then
		self.parent:StopVoice(voiceID, callback)
	end
end

function OathHeroVoiceArchieveSubView:GetCurPlayingVoice()
	if self.parent then
		return self.parent:IsPlaying()
	end

	return nil
end

function OathHeroVoiceArchieveSubView:RefreshUI(arg_11_1)
	self.curHeroID = arg_11_1

	local var_11_0 = self:GetVoiceTag()
	local var_11_1 = self:GetAllCategory(arg_11_1)

	var_0_1(self, #var_11_1)

	local function var_11_2(arg_12_0)
		PlayerAction.CheckHeroVoice(self:GetHeroID(), function()
			if self:GetCurPlayingVoice() == arg_12_0 then
				self:StopVoice()
			else
				self:PlayVoice(arg_12_0)
			end
		end)
	end

	for iter_11_0, iter_11_1 in ipairs(var_11_1) do
		self.items[iter_11_0]:SetData(arg_11_1, iter_11_1, var_11_2)
		self.items[iter_11_0]:SetBgState("oath")
	end

	self:UpdateVoicePlayStatus()
end

function OathHeroVoiceArchieveSubView:GetVoiceTag()
	return {
		8
	}
end

local function var_0_2(arg_15_0, arg_15_1, arg_15_2)
	for iter_15_0, iter_15_1 in ipairs(HeroVoiceCfg.get_id_list_by_tag_id[arg_15_2] or {}) do
		if HeroVoiceDescCfg.get_id_list_by_subtitle_id_form_id[iter_15_1] then
			for iter_15_2, iter_15_3 in pairs(HeroVoiceDescCfg.get_id_list_by_subtitle_id_form_id[iter_15_1]) do
				if (HeroTools.GetHeroIDFromFormID(iter_15_2) or SkinCfg[iter_15_2].hero) == arg_15_1 then
					table.insert(arg_15_0, {
						id = iter_15_1,
						unlock = HeroTools.IsUnlockVoice(arg_15_1, iter_15_1)
					})
				end
			end
		end
	end
end

function OathHeroVoiceArchieveSubView:GetAllCategory(arg_16_1)
	local var_16_0 = {}

	for iter_16_0, iter_16_1 in ipairs((self:GetVoiceTag())) do
		var_0_2(var_16_0, arg_16_1, iter_16_1)
	end

	CommonTools.UniversalSortEx(var_16_0, {
		map = function(self)
			return self.unlock and 1 or 0
		end
	}, {
		ascend = true,
		map = function(self)
			return self.id
		end
	})

	return var_16_0
end

function OathHeroVoiceArchieveSubView:UpdateItemPlayState(arg_19_1)
	if self:GetCurPlayingVoice() == arg_19_1.id_ then
		arg_19_1:StartPlay()
	else
		arg_19_1:StopPlay()
	end
end

function OathHeroVoiceArchieveSubView:UpdateVoicePlayStatus()
	for iter_20_0, iter_20_1 in ipairs(self.items) do
		self:UpdateItemPlayState(iter_20_1)
	end
end

return OathHeroVoiceArchieveSubView
