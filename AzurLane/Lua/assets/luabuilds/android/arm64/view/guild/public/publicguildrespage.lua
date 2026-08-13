class = var_0_10000

local var_0_0 = "PublicGuildResPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..subPages.main.GuildResPage"))

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = "blue"
	local var_1_1 = arg_1_0.contributionBg

	GetSpriteFromAtlas = var_1_10003
	var_1_1.sprite = var_1_10003("ui/GuildMainUI_atlas", "res_" .. var_1_0)

	local var_1_2 = arg_1_0.captailBg

	GetSpriteFromAtlas = var_3
	var_1_2.sprite = var_3("ui/GuildMainUI_atlas", "res_" .. var_1_0)
	setActive = var_1_2

	var_1_2(arg_1_0.captailBg.gameObject, false)

	return
end

function var_0_1.Update(arg_2_0, arg_2_1)
	arg_2_0.resContributionTxt.text = arg_2_1:getResource(8)

	return
end

return var_0_1
