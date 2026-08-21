local var_0_0 = class("PublicGuildResPage", import("..subPages.main.GuildResPage"))

function var_0_0.OnInit(arg_1_0)
	arg_1_0.contributionBg.sprite = GetSpriteFromAtlas("ui/GuildMainUI_atlas", "res_" .. "blue")
	arg_1_0.captailBg.sprite = GetSpriteFromAtlas("ui/GuildMainUI_atlas", "res_" .. "blue")

	setActive(arg_1_0.captailBg.gameObject, false)

	return
end

function var_0_0.Update(arg_2_0, arg_2_1)
	arg_2_0.resContributionTxt.text = arg_2_1:getResource(8)

	return
end

return var_0_0
