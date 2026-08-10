local var_0_0 = class("SectionRandomAttributeTipsView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:UpdateTips()

	arg_2_0.attributeItemList_ = {}
end

function var_0_0.OnExit(arg_3_0)
	SetActive(arg_3_0.gameObject_, false)
end

function var_0_0.SetData(arg_4_0, arg_4_1)
	arg_4_0.sectionProxy_ = arg_4_1

	SetActive(arg_4_0.gameObject_, true)
	arg_4_0:UpdateView()
end

function var_0_0.UpdateView(arg_5_0)
	arg_5_0:UpdateAttributeList()
end

function var_0_0.UpdateTips(arg_6_0)
	arg_6_0.titleText_.text = GetTips("RANDOM_ATTRIBUTE_DESC")
	arg_6_0.descText_.text = GetTips("RANDOM_ATTRIBUTE_DESC_1")
	arg_6_0.randomTitleText_.text = GetTips("RANDOM_ATTRUBUTE_TITLE")
end

function var_0_0.UpdateAttributeList(arg_7_0)
	local var_7_0 = arg_7_0:GetAttributeIDList()

	for iter_7_0, iter_7_1 in ipairs(var_7_0) do
		local var_7_1 = arg_7_0.attributeItemList_[iter_7_0]

		if not var_7_1 then
			var_7_1 = arg_7_0:CreateAttributeItem()
			arg_7_0.attributeItemList_[iter_7_0] = var_7_1
		end

		var_7_1:SetData(iter_7_1)
		var_7_1:Show(true)
	end

	for iter_7_2 = #var_7_0 + 1, #arg_7_0.attributeItemList_ do
		arg_7_0.attributeItemList_[iter_7_2]:Show(false)
	end
end

function var_0_0.GetAttributeIDList(arg_8_0)
	local var_8_0 = {}
	local var_8_1 = arg_8_0.sectionProxy_:GetHeroIDList()

	for iter_8_0, iter_8_1 in ipairs(var_8_1) do
		if iter_8_1 ~= 0 then
			local var_8_2 = HeroCfg[iter_8_1]

			if type(var_8_2.ATK_attribute) == "table" then
				for iter_8_2, iter_8_3 in ipairs(var_8_2.ATK_attribute) do
					if HeroTools.IsNormalAtkAttributeId(iter_8_3) then
						table.insert(var_8_0, iter_8_3)
					end
				end
			end
		end
	end

	if #var_8_0 == 0 then
		var_8_0 = CommonFilterConst.GetDefaultHeroAttributeIdList({
			HeroConst.HERO_ATTACK_TYPE.RANDOM
		})
	end

	return var_8_0
end

function var_0_0.CreateAttributeItem(arg_9_0)
	local var_9_0 = GameObject.Instantiate(arg_9_0.attributeItemPrefab_, arg_9_0.attributeItemParent_)

	return (HeroSkillAttributeItem.New(var_9_0))
end

function var_0_0.Dispose(arg_10_0)
	for iter_10_0, iter_10_1 in ipairs(arg_10_0.attributeItemList_) do
		iter_10_1:Dispose()
	end

	var_0_0.super.Dispose(arg_10_0)
end

function var_0_0.Show(arg_11_0, arg_11_1)
	SetActive(arg_11_0.gameObject_, arg_11_1)
end

return var_0_0
