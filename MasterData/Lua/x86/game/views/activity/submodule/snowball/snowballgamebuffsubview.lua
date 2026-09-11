local SnowballGameBuffSubView = class("SnowballGameBuffSubView", BaseView)

function SnowballGameBuffSubView:Ctor(arg_1_1)
	SnowballGameBuffSubView.super.Ctor(self)

	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
end

function SnowballGameBuffSubView:OnEnter()
	self.buffs = {}
end

function SnowballGameBuffSubView:OnExit()
	self.buffs = nil

	self:RemoveAllEventListener()
end

function SnowballGameBuffSubView:AddBuff(arg_4_1, arg_4_2, arg_4_3)
	if self.buffs[arg_4_1] then
		self.buffs[arg_4_1].lastTime = math.max(self.buffs[arg_4_1].lastTime, arg_4_2)

		if self.OnBuffExtended then
			self:OnBuffExtended(arg_4_1)
		end
	else
		local var_4_0 = SnowballGameBuff.buff[arg_4_1]

		if SnowballGameBuff.buff[arg_4_1].WillOverride then
			for iter_4_0, iter_4_1 in pairs(self.buffs) do
				if var_4_0.WillOverride(iter_4_0) then
					self:RemoveBuff(iter_4_0)
				end
			end

			local var_4_1

			if var_4_0.IsDebuff then
				var_4_1 = self.debuff_ or self.buff_
			end
		end

		local var_4_2 = GameObject.Instantiate(var_4_1, self.buffRoot_)
		local var_4_3 = {}

		self:BindCfgUI(var_4_2, var_4_3)

		var_4_3.icon_.sprite = pureGetSpriteWithoutAtlas(GameDisplayCfg.activity_snowball_buff_icon.value[arg_4_1])
		self.buffs[arg_4_1] = {
			lastTime = arg_4_2,
			obj = var_4_2,
			com = var_4_3
		}

		if self.OnBuffAdded then
			self:OnBuffAdded(arg_4_1, arg_4_3)
		end

		self:SortBuffIcon()
	end
end

function SnowballGameBuffSubView:Update(arg_5_1)
	for iter_5_0, iter_5_1 in pairs(self.buffs) do
		iter_5_1.lastTime = iter_5_1.lastTime - arg_5_1

		if iter_5_1.lastTime <= 0 then
			self:RemoveBuff(iter_5_0)
		end
	end
end

function SnowballGameBuffSubView:RemoveBuff(arg_6_1)
	if self.buffs[arg_6_1] == nil then
		return
	end

	if self.buffs[arg_6_1].obj then
		GameObject.Destroy(self.buffs[arg_6_1].obj)
	end

	self.buffs[arg_6_1] = nil

	if self.OnBuffFinished then
		self:OnBuffFinished(arg_6_1)
	end
end

function SnowballGameBuffSubView:ClearAllBuff()
	for iter_7_0, iter_7_1 in ipairs(SnowballGameBuff.all) do
		self:RemoveBuff(iter_7_1)
	end
end

function SnowballGameBuffSubView:SortBuffIcon()
	for iter_8_0, iter_8_1 in ipairs(SnowballGameBuff.all) do
		if self.buffs[iter_8_1] then
			self.buffs[iter_8_1].obj.transform:SetSiblingIndex(0)
		end
	end
end

return SnowballGameBuffSubView
