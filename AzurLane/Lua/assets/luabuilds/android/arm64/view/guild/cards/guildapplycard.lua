local var_0_0 = class("GuildApplyCard")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0.tf = tf(arg_1_1)
	arg_1_0.nameTF = arg_1_0.tf:Find("bg/name_bg/Text"):GetComponent(typeof(Text))
	arg_1_0.lvTF = arg_1_0.tf:Find("bg/level/Text"):GetComponent(typeof(Text))
	arg_1_0.lvLabelTF = arg_1_0.tf:Find("bg/level"):GetComponent(typeof(Text))
	arg_1_0.countTF = arg_1_0.tf:Find("bg/count/Text"):GetComponent(typeof(Text))
	arg_1_0.applyBtn = arg_1_0.tf:Find("bg/apply_btn")
	arg_1_0.flagName = arg_1_0.tf:Find("bg/info/name"):GetComponent(typeof(Text))
	arg_1_0.flagLabel = arg_1_0.tf:Find("bg/info/label1"):GetComponent(typeof(Text))
	arg_1_0.policy = arg_1_0.tf:Find("bg/info/policy"):GetComponent(typeof(Text))
	arg_1_0.policyLabel = arg_1_0.tf:Find("bg/info/label2"):GetComponent(typeof(Text))
	arg_1_0.iconTF = arg_1_0.tf:Find("bg/icon"):GetComponent(typeof(Image))
	arg_1_0.nameBG = arg_1_0.tf:Find("bg/name_bg"):GetComponent(typeof(Image))
	arg_1_0.print = arg_1_0.tf:Find("bg/print"):GetComponent(typeof(Image))
	arg_1_0.bg = arg_1_0.tf:Find("bg"):GetComponent(typeof(Image))
	arg_1_0.applyBg = arg_1_0.applyBtn:GetComponent(typeof(Image))
	arg_1_0.colorRed = Color(0.7529411764705882, 0.4392156862745098, 0.4627450980392157)
	arg_1_0.colorBlue = Color(0.6274509803921569, 0.7058823529411765, 0.9764705882352941)

	return
end

function var_0_0.Update(arg_2_0, arg_2_1)
	if not arg_2_1 then
		return
	end

	local var_2_0
	local var_2_1 = arg_2_1:getFaction()

	if var_2_1 == GuildConst.FACTION_TYPE_BLHX then
		var_2_0 = "blue"
	elseif var_2_1 == GuildConst.FACTION_TYPE_CSZZ then
		var_2_0 = "red"
	end

	arg_2_0.bg.sprite = GetSpriteFromAtlas("ui/JoinGuildUI_atlas", "bar_" .. var_2_0)
	arg_2_0.applyBg.sprite = GetSpriteFromAtlas("ui/JoinGuildUI_atlas", "apply_" .. var_2_0)
	arg_2_0.iconTF.sprite = GetSpriteFromAtlas("ui/JoinGuildUI_atlas", "icon_" .. var_2_0)
	arg_2_0.nameBG.sprite = GetSpriteFromAtlas("ui/JoinGuildUI_atlas", "name_" .. var_2_0)
	arg_2_0.print.sprite = GetSpriteFromAtlas("ui/JoinGuildUI_atlas", "bar_bg_" .. var_2_0)

	if var_2_0 == "red" then
		local var_2_2 = arg_2_0.colorRed or arg_2_0.colorBlue

		arg_2_0.lvTF.color = var_2_2
		arg_2_0.lvLabelTF.color = var_2_2
		arg_2_0.flagLabel.color = var_2_2
		arg_2_0.policyLabel.color = var_2_2
		arg_2_0.guildVO = arg_2_1
		arg_2_0.nameTF.text = arg_2_1:getName()

		local var_2_3 = arg_2_0.lvTF

		if arg_2_1.level <= 9 then
			var_2_3.text = "0" .. arg_2_1.level or arg_2_1.level
			arg_2_0.countTF.text = arg_2_1.memberCount .. "/" .. arg_2_1:getMaxMember()
			arg_2_0.flagName.text = arg_2_1:getCommader().name
			arg_2_0.policy.text = arg_2_1:getPolicyName()

			return
		end
	end
end

function var_0_0.Dispose(arg_3_0)
	return
end

return var_0_0
