local var_0_0 = class("DormVisitItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()

	arg_2_0.commonPortrait_ = CommonHeadPortrait.New(arg_2_0.headItem_)

	arg_2_0:AddUIListener()

	arg_2_0.praiseController = arg_2_0.controller_:GetController("praise")
	arg_2_0.cardBgCon_ = arg_2_0.controller_:GetController("bgType")
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.visitBtn_, nil, function()
		if arg_4_0.visitFunc then
			arg_4_0.visitFunc(arg_4_0.userID)
		end
	end)
	arg_4_0.commonPortrait_:RegisteClickCallback(function()
		if BackHomeDataManager:GetCurSystem() == DormEnum.DormSystemType.Main then
			ForeignInfoAction:TryToCheckForeignDetailInfo(arg_4_0.userID)
		else
			ForeignInfoAction:TryToCheckForeignDetailInfo(arg_4_0.userID, true)
		end
	end)
end

function var_0_0.RegisterEnterCallBack(arg_7_0, arg_7_1)
	if arg_7_1 then
		arg_7_0.visitFunc = arg_7_1
	end
end

function var_0_0.RefreshUI(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0.userID = arg_8_1
	arg_8_0.type = arg_8_2

	local var_8_0 = DormVisitTools:GetTemplateExhibitList(arg_8_0.type)[arg_8_0.userID]

	if not var_8_0 then
		Debug.LogError("未获取到参观信息")

		return
	end

	local var_8_1 = ProfileDecorateItemCfg[var_8_0.info_background]

	if var_8_1 then
		arg_8_0.cardBgCon_:SetSelectedState("image")

		local var_8_2 = var_8_1.resource

		arg_8_0.cardBgCon_:SetSelectedState("image")

		if var_8_1.type == 1 then
			arg_8_0.bg_.spriteSync = pureGetSpriteWithoutAtlas("TextureConfig/Friends/" .. var_8_2 .. "_s")
		elseif var_8_1.type == 2 then
			arg_8_0.cardBgCon_:SetSelectedState("prefab")

			local var_8_3 = Asset.Load("Widget/System/PlayerProfileBg/profileBg_s/PPBCode_s_" .. var_8_2)

			if var_8_3 then
				local var_8_4 = Object.Instantiate(var_8_3, arg_8_0.cardBgPrefabRoot_)

				if var_8_4 then
					var_8_4.transform:SetParent(arg_8_0.cardBgPrefabRoot_)

					var_8_4.transform.localScale = Vector3.New(1, 1, 1)
					var_8_4.transform.localPosition = Vector3.New(0, 0, 0)

					var_8_4:SetActive(true)
				end
			end
		elseif cfg.type == 3 then
			-- block empty
		end
	end

	arg_8_0.commonPortrait_:RenderHead(var_8_0.icon)
	arg_8_0.commonPortrait_:RenderFrame(var_8_0.iconFrame)

	arg_8_0.nickName.text = var_8_0.nick
	arg_8_0.likeNum.text = var_8_0.likeNum

	local var_8_5 = var_8_0.architecture_id

	if BackHomeCfg[var_8_5].type == DormConst.BACKHOME_TYPE.PublicDorm then
		arg_8_0.dormName.text = GetTips("DORM_LOBBY_NAME")
	else
		local var_8_6 = BackHomeHeroSkinCfg[var_8_0.heroIDList[1]].hero_id
		local var_8_7 = HeroRecordCfg.get_id_list_by_hero_id[var_8_6][1]

		arg_8_0.dormName.text = GetTipsF("DORM_HERO_ROOM_NAME", GetI18NText(HeroRecordCfg[var_8_7].name))
	end

	arg_8_0.chatText_.text = ""
	arg_8_0.viewNum.text = math.max(var_8_0.furniture_num, 0)
	arg_8_0.furnitureNum.text = var_8_0.sign

	if var_8_0.todayLikeNum then
		arg_8_0.praiseController:SetSelectedState("on")
	else
		arg_8_0.praiseController:SetSelectedState("off")
	end
end

function var_0_0.Dispose(arg_9_0)
	arg_9_0.commonPortrait_:Dispose()
	var_0_0.super.Dispose(arg_9_0)
end

return var_0_0
