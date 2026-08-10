local var_0_0 = class("MythicFinalRankHeroItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:initUI()
	arg_1_0:AddUIListeners()
end

function var_0_0.AddUIListeners(arg_2_0)
	for iter_2_0 = 1, 3 do
		arg_2_0:AddBtnListener(arg_2_0["heroBtn_" .. iter_2_0], nil, function()
			ForeignInfoAction:TryToCheckForeignHeroInfo(arg_2_0.userID_, _, 3, function()
				JumpTools.OpenPageByJump("/newHero", {
					isEnter = true,
					notShowBar = true,
					hid = arg_2_0.herolist_[iter_2_0].id,
					type = HeroConst.HERO_DATA_TYPE.FOREIGN
				}, ViewConst.SYSTEM_ID.PLAYER_INFO)
			end)
		end)
	end
end

function var_0_0.initUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.countcontroller_ = arg_5_0.conExCollection_:GetController("heroCount")
end

function var_0_0.SetData(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	arg_6_0.userID_ = arg_6_3
	arg_6_0.herolist_ = arg_6_2
	arg_6_0.teamText_.text = GetTips("TEAM_" .. arg_6_1)

	arg_6_0.countcontroller_:SetSelectedState(#arg_6_2)

	for iter_6_0, iter_6_1 in pairs(arg_6_2) do
		local var_6_0 = iter_6_1.skin_id

		if var_6_0 == 0 then
			var_6_0 = iter_6_1.id
		end

		arg_6_0["heroImg_" .. iter_6_0].sprite = ItemTools.getItemSprite(var_6_0)
	end
end

return var_0_0
