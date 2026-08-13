class = var_0_10000

local var_0_0 = var_0_10000("GuildApplyCard")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	tf = var_1_10002
	arg_1_0.tf = var_1_10002(arg_1_1)

	local var_1_0 = arg_1_0.tf
	local var_1_1 = var_2.Find(var_1_0, "bg/name_bg/Text")
	local var_1_2 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	arg_1_0.nameTF = var_1_2(var_1_1, var_5(var_1_10007))

	local var_1_3 = arg_1_0.tf
	local var_1_4 = var_2.Find(var_1_3, "bg/level/Text")
	local var_1_5 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	arg_1_0.lvTF = var_1_5(var_1_4, var_5(var_1_10007))

	local var_1_6 = arg_1_0.tf
	local var_1_7 = var_2.Find(var_1_6, "bg/level")
	local var_1_8 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	arg_1_0.lvLabelTF = var_1_8(var_1_7, var_5(var_1_10007))

	local var_1_9 = arg_1_0.tf
	local var_1_10 = var_2.Find(var_1_9, "bg/count/Text")
	local var_1_11 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	arg_1_0.countTF = var_1_11(var_1_10, var_5(var_1_10007))

	local var_1_12 = arg_1_0.tf

	arg_1_0.applyBtn = var_2.Find(var_1_12, "bg/apply_btn")

	local var_1_13 = arg_1_0.tf
	local var_1_14 = var_2.Find(var_1_13, "bg/info/name")
	local var_1_15 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	arg_1_0.flagName = var_1_15(var_1_14, var_5(var_1_10007))

	local var_1_16 = arg_1_0.tf
	local var_1_17 = var_2.Find(var_1_16, "bg/info/label1")
	local var_1_18 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	arg_1_0.flagLabel = var_1_18(var_1_17, var_5(var_1_10007))

	local var_1_19 = arg_1_0.tf
	local var_1_20 = var_2.Find(var_1_19, "bg/info/policy")
	local var_1_21 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	arg_1_0.policy = var_1_21(var_1_20, var_5(var_1_10007))

	local var_1_22 = arg_1_0.tf
	local var_1_23 = var_2.Find(var_1_22, "bg/info/label2")
	local var_1_24 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	arg_1_0.policyLabel = var_1_24(var_1_23, var_5(var_1_10007))

	local var_1_25 = arg_1_0.tf
	local var_1_26 = var_2.Find(var_1_25, "bg/icon")
	local var_1_27 = var_2.GetComponent

	typeof = var_5
	Image = var_1_10007
	arg_1_0.iconTF = var_1_27(var_1_26, var_5(var_1_10007))

	local var_1_28 = arg_1_0.tf
	local var_1_29 = var_2.Find(var_1_28, "bg/name_bg")
	local var_1_30 = var_2.GetComponent

	typeof = var_5
	Image = var_1_10007
	arg_1_0.nameBG = var_1_30(var_1_29, var_5(var_1_10007))

	local var_1_31 = arg_1_0.tf
	local var_1_32 = var_2.Find(var_1_31, "bg/print")
	local var_1_33 = var_2.GetComponent

	typeof = var_5
	Image = var_1_10007
	arg_1_0.print = var_1_33(var_1_32, var_5(var_1_10007))

	local var_1_34 = arg_1_0.tf
	local var_1_35 = var_2.Find(var_1_34, "bg")
	local var_1_36 = var_2.GetComponent

	typeof = var_5
	Image = var_1_10007
	arg_1_0.bg = var_1_36(var_1_35, var_5(var_1_10007))

	local var_1_37 = arg_1_0.applyBtn
	local var_1_38 = var_2.GetComponent

	typeof = var_5
	Image = var_1_10007
	arg_1_0.applyBg = var_1_38(var_1_37, var_5(var_1_10007))
	Color = var_2
	arg_1_0.colorRed = var_2(0.7529411764705882, 0.4392156862745098, 0.4627450980392157)
	Color = var_2
	arg_1_0.colorBlue = var_2(0.6274509803921569, 0.7058823529411765, 0.9764705882352941)

	return
end

function var_0_0.Update(arg_2_0, arg_2_1)
	if not arg_2_1 then
		return
	end

	local var_2_0
	local var_2_1 = arg_2_1
	local var_2_2 = arg_2_1.getFaction(var_2_1)

	GuildConst = var_1_10004

	if var_2_2 == var_1_10004.FACTION_TYPE_BLHX then
		var_2_0 = "blue"
	else
		GuildConst = var_4

		if var_2_2 == var_4.FACTION_TYPE_CSZZ then
			var_2_0 = "red"
		end
	end

	local var_2_3 = arg_2_0.bg

	GetSpriteFromAtlas = var_2_1
	var_2_3.sprite = var_2_1("ui/JoinGuildUI_atlas", "bar_" .. var_2_0)

	local var_2_4 = arg_2_0.applyBg

	GetSpriteFromAtlas = var_5
	var_2_4.sprite = var_5("ui/JoinGuildUI_atlas", "apply_" .. var_2_0)

	local var_2_5 = arg_2_0.iconTF

	GetSpriteFromAtlas = var_5
	var_2_5.sprite = var_5("ui/JoinGuildUI_atlas", "icon_" .. var_2_0)

	local var_2_6 = arg_2_0.nameBG

	GetSpriteFromAtlas = var_5
	var_2_6.sprite = var_5("ui/JoinGuildUI_atlas", "name_" .. var_2_0)

	local var_2_7 = arg_2_0.print

	GetSpriteFromAtlas = var_5
	var_2_7.sprite = var_5("ui/JoinGuildUI_atlas", "bar_bg_" .. var_2_0)

	local var_2_8

	if var_2_0 ~= "red" or not arg_2_0.colorRed then
		var_2_8 = arg_2_0.colorBlue
	end

	arg_2_0.lvTF.color = var_2_8
	arg_2_0.lvLabelTF.color = var_2_8
	arg_2_0.flagLabel.color = var_2_8
	arg_2_0.policyLabel.color = var_2_8
	arg_2_0.guildVO = arg_2_1
	arg_2_0.nameTF.text = arg_2_1:getName()

	local var_2_9 = arg_2_0.lvTF
	local var_2_10

	if not (arg_2_1.level <= 9) or not ("0" .. arg_2_1.level) then
		var_2_10 = arg_2_1.level
	end

	var_2_9.text = var_2_10
	arg_2_0.countTF.text = arg_2_1.memberCount .. "/" .. arg_2_1:getMaxMember()
	arg_2_0.flagName.text = arg_2_1:getCommader().name
	arg_2_0.policy.text = arg_2_1:getPolicyName()

	return
end

function var_0_0.Dispose(arg_3_0)
	return
end

return var_0_0
