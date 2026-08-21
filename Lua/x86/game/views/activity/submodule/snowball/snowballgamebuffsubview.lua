local var_0_0 = class("SnowballGameBuffSubView", BaseView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0)

	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
end

function var_0_0.OnEnter(arg_2_0)
	arg_2_0.buffs = {}
end

function var_0_0.OnExit(arg_3_0)
	arg_3_0.buffs = nil

	arg_3_0:RemoveAllEventListener()
end

function var_0_0.AddBuff(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	local var_4_0 = arg_4_0.buffs[arg_4_1]

	if var_4_0 then
		var_4_0.lastTime = math.max(var_4_0.lastTime, arg_4_2)

		if arg_4_0.OnBuffExtended then
			arg_4_0:OnBuffExtended(arg_4_1)
		end
	else
		local var_4_1 = SnowballGameBuff.buff[arg_4_1]

		if var_4_1.WillOverride then
			for iter_4_0, iter_4_1 in pairs(arg_4_0.buffs) do
				if var_4_1.WillOverride(iter_4_0) then
					arg_4_0:RemoveBuff(iter_4_0)
				end
			end
		end

		local var_4_2 = GameObject.Instantiate(var_4_1.IsDebuff and arg_4_0.debuff_ or arg_4_0.buff_, arg_4_0.buffRoot_)
		local var_4_3 = {}

		arg_4_0:BindCfgUI(var_4_2, var_4_3)

		var_4_3.icon_.sprite = pureGetSpriteWithoutAtlas(GameDisplayCfg.activity_snowball_buff_icon.value[arg_4_1])
		arg_4_0.buffs[arg_4_1] = {
			lastTime = arg_4_2,
			obj = var_4_2,
			com = var_4_3
		}

		if arg_4_0.OnBuffAdded then
			arg_4_0:OnBuffAdded(arg_4_1, arg_4_3)
		end

		arg_4_0:SortBuffIcon()
	end
end

function var_0_0.Update(arg_5_0, arg_5_1)
	for iter_5_0, iter_5_1 in pairs(arg_5_0.buffs) do
		iter_5_1.lastTime = iter_5_1.lastTime - arg_5_1

		if iter_5_1.lastTime <= 0 then
			arg_5_0:RemoveBuff(iter_5_0)
		end
	end
end

function var_0_0.RemoveBuff(arg_6_0, arg_6_1)
	if arg_6_0.buffs[arg_6_1] == nil then
		return
	end

	local var_6_0 = arg_6_0.buffs[arg_6_1].obj

	if var_6_0 then
		GameObject.Destroy(var_6_0)
	end

	arg_6_0.buffs[arg_6_1] = nil

	if arg_6_0.OnBuffFinished then
		arg_6_0:OnBuffFinished(arg_6_1)
	end
end

function var_0_0.ClearAllBuff(arg_7_0)
	for iter_7_0, iter_7_1 in ipairs(SnowballGameBuff.all) do
		arg_7_0:RemoveBuff(iter_7_1)
	end
end

function var_0_0.SortBuffIcon(arg_8_0)
	local var_8_0 = 0

	for iter_8_0, iter_8_1 in ipairs(SnowballGameBuff.all) do
		if arg_8_0.buffs[iter_8_1] then
			arg_8_0.buffs[iter_8_1].obj.transform:SetSiblingIndex(var_8_0)

			var_8_0 = var_8_0 + 1
		end
	end
end

return var_0_0
