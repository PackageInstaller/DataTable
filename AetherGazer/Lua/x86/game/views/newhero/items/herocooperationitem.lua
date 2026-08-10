local var_0_0 = class("HeroCooperationItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
	arg_1_0:InitUI()
	arg_1_0:AddUIListeners()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0.list = {}
	arg_2_0.ownController = arg_2_0.controller_:GetController("own")
	arg_2_0.showController = arg_2_0.controller_:GetController("show")
	arg_2_0.heroViewProxy_ = HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.DEFAULT)
end

function var_0_0.AddUIListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.selectBtn_, nil, function()
		arg_3_0.clickCallBack(arg_3_0.data.id)

		if arg_3_0.showController:GetSelectedState() == "true" then
			arg_3_0.showController:SetSelectedState("false")
			arg_3_0.animator_:Play("EsotericVideo_02")
		else
			SetActive(arg_3_0.emptyGo, true)
			AnimatorTools.PlayAnimatorWithCallback(arg_3_0.animator_, "EsotericVideo", function()
				SetActive(arg_3_0.emptyGo, false)
			end, false)
			arg_3_0.showController:SetSelectedState("true")
		end
	end)
	arg_3_0:AddBtnListener(arg_3_0.unSelectBtn_, nil, function()
		arg_3_0.clickCallBack(arg_3_0.data.id)

		if arg_3_0.showController:GetSelectedState() == "true" then
			arg_3_0.showController:SetSelectedState("false")
			arg_3_0.animator_:Play("EsotericVideo_02")
		else
			SetActive(arg_3_0.emptyGo, true)
			AnimatorTools.PlayAnimatorWithCallback(arg_3_0.animator_, "EsotericVideo", function()
				SetActive(arg_3_0.emptyGo, false)
			end, false)
			arg_3_0.showController:SetSelectedState("true")
		end
	end)
end

function var_0_0.indexItem(arg_8_0, arg_8_1, arg_8_2)
	arg_8_2:SetData(arg_8_0.comboSkillData[arg_8_1], arg_8_0.callBack, arg_8_0.data.id)
end

function var_0_0.SetData(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4, arg_9_5, arg_9_6)
	arg_9_0.data = arg_9_1
	arg_9_0.callBack = arg_9_2
	arg_9_0.selectHeroId = arg_9_3
	arg_9_0.clickCallBack = arg_9_4
	arg_9_0.index = arg_9_5
	arg_9_0.emptyGo = arg_9_6
	arg_9_0.heroInfo = arg_9_0.heroViewProxy_:GetHeroData(arg_9_0.data.id)
	arg_9_0.comboSkillData = ComboSkillTools.GetHeroComboSkill(arg_9_0.data.id)
	arg_9_0.skinID = arg_9_0.heroViewProxy_:GetHeroUsingSkinInfo(arg_9_0.data.id).id

	arg_9_0:UpdateView()
end

function var_0_0.UpdateView(arg_10_0)
	local var_10_0 = HeroCfg[arg_10_0.data.id]

	arg_10_0.unSelectImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Character/Icon/" .. arg_10_0.skinID)
	arg_10_0.selectImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Character/Icon/" .. arg_10_0.skinID)
	arg_10_0.unSelectName_.text = GetI18NText(var_10_0.name)
	arg_10_0.selectName_.text = GetI18NText(var_10_0.name)

	local var_10_1 = #(arg_10_0.comboSkillData or {})

	for iter_10_0 = 1, var_10_1 do
		if arg_10_0.list[iter_10_0] == nil then
			if arg_10_0["item" .. iter_10_0 .. "Go_"] == nil then
				local var_10_2 = GameObject.Instantiate(arg_10_0.item1Go_)

				var_10_2.transform:SetParent(arg_10_0.item1Go_.transform.parent, false)

				arg_10_0["item" .. iter_10_0 .. "Go_"] = var_10_2
			end

			arg_10_0.list[iter_10_0] = HeroCooperationItemItem.New(arg_10_0["item" .. iter_10_0 .. "Go_"])
		end

		arg_10_0.list[iter_10_0]:SetData(arg_10_0.comboSkillData[iter_10_0], arg_10_0.callBack, arg_10_0.data.id)
		SetActive(arg_10_0["item" .. iter_10_0 .. "Go_"], true)
	end

	local var_10_3 = math.max(#arg_10_0.list, 5)

	for iter_10_1 = var_10_1 + 1, var_10_3 do
		SetActive(arg_10_0["item" .. iter_10_1 .. "Go_"], false)
	end

	if arg_10_0.data.id == arg_10_0.selectHeroId then
		arg_10_0.animator_:Play("EsotericVideo")
	elseif arg_10_0.showController:GetSelectedState() == "true" then
		arg_10_0.animator_:Play("none")
	end

	arg_10_0.showController:SetSelectedState(tostring(arg_10_0.data.id == arg_10_0.selectHeroId))
	arg_10_0.ownController:SetSelectedState(tostring(arg_10_0.heroInfo.unlock == 1))

	arg_10_0.selectHeroId = nil
	arg_10_0.scroll_.movementType = var_10_1 <= 3 and ScrollRect.MovementType.Clamped or ScrollRect.MovementType.Elastic
end

function var_0_0.Dispose(arg_11_0)
	for iter_11_0, iter_11_1 in pairs(arg_11_0.list) do
		iter_11_1:Dispose()
	end

	var_0_0.super.Dispose(arg_11_0)
end

return var_0_0
