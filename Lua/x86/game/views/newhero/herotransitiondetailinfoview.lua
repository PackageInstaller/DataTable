local var_0_0 = class("HeroTransitionDetailInfoView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

var_0_0.asciiMap = {
	"Ⅰ",
	"Ⅱ",
	"Ⅲ",
	"Ⅳ",
	"Ⅴ",
	"Ⅵ"
}

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.jumpNumController_ = arg_3_0.barController_:GetController("num")
	arg_3_0.jumpPosController_ = arg_3_0.posController_:GetController("pos")
	arg_3_0.lockController_ = arg_3_0.contentController_:GetController("lock")
	arg_3_0.emptyController_ = arg_3_0.contentController_:GetController("empty")
	arg_3_0.isSelfController_ = arg_3_0.contentController_:GetController("isSelf")
	arg_3_0.transitionItemList_ = {}
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.goBtn_, nil, function()
		JumpTools.OpenPageByJump("/transitionSkill", {
			index = arg_4_0.info_.slotIdx,
			heroID = arg_4_0.heroID_,
			type_ = arg_4_0.heroViewProxy_:GetViewDataType()
		})
	end)
end

function var_0_0.SetSlotInfo(arg_6_0, arg_6_1)
	arg_6_0.info_ = arg_6_1

	arg_6_0:UpdateView()
end

function var_0_0.SetHeroInfo(arg_7_0, arg_7_1)
	arg_7_0.heroInfo_ = arg_7_1
	arg_7_0.heroID_ = arg_7_1.id
end

function var_0_0.UpdateView(arg_8_0)
	if not arg_8_0.info_ then
		return
	end

	arg_8_0.jumpPosController_:SetSelectedState(arg_8_0.info_.slotIdx)
	arg_8_0.lockController_:SetSelectedState(arg_8_0.info_.isLock and "true" or "false")
	arg_8_0.emptyController_:SetSelectedState(#arg_8_0.info_.skills == 0 and "true" or "false")
	arg_8_0.isSelfController_:SetSelectedState(arg_8_0.heroViewProxy_.isSelf and "true" or "false")
	SetActive(arg_8_0.lockRootObj_, arg_8_0.heroViewProxy_.isSelf)

	local var_8_0 = arg_8_0.info_.totalPoint
	local var_8_1 = 0

	for iter_8_0, iter_8_1 in ipairs(arg_8_0.info_.skills) do
		var_8_1 = var_8_1 + iter_8_1.level
	end

	arg_8_0.jumpNumController_:SetSelectedState(var_8_1)

	arg_8_0.numText_.text = table.concat({
		var_8_1,
		"/",
		var_8_0
	})
	arg_8_0.nameText_.text = string.format(GetTips("EXCLUSIVE_CORE"), arg_8_0.asciiMap[arg_8_0.info_.slotIdx])

	for iter_8_2, iter_8_3 in ipairs(arg_8_0.transitionItemList_) do
		SetActive(iter_8_3.gameObject_, false)
	end

	local var_8_2 = 1

	for iter_8_4, iter_8_5 in ipairs(arg_8_0.info_.skills) do
		if not arg_8_0.transitionItemList_[var_8_2] then
			local var_8_3 = Object.Instantiate(arg_8_0.jumpItemGo_, arg_8_0.jumpItemListTrs_, false)
			local var_8_4 = HeroTransitionItem.New(var_8_3)

			var_8_4:SetData(iter_8_5)
			table.insert(arg_8_0.transitionItemList_, var_8_4)
		else
			arg_8_0.transitionItemList_[var_8_2]:SetData(iter_8_5)
		end

		SetActive(arg_8_0.transitionItemList_[var_8_2].gameObject_, true)

		var_8_2 = var_8_2 + 1
	end
end

function var_0_0.OnEnter(arg_9_0, arg_9_1)
	arg_9_0.heroViewProxy_ = arg_9_1

	arg_9_0:RegistEventListener(HERO_TRANSITION_CHANGE, handler(arg_9_0, arg_9_0.OnHeroModify))
end

function var_0_0.OnExit(arg_10_0)
	arg_10_0:RemoveAllEventListener()
end

function var_0_0.OnHeroModify(arg_11_0, arg_11_1)
	if arg_11_1 == arg_11_0.heroInfo_.id then
		arg_11_0:UpdateView()
	end
end

function var_0_0.Dispose(arg_12_0)
	arg_12_0:RemoveAllListeners()

	for iter_12_0, iter_12_1 in ipairs(arg_12_0.transitionItemList_) do
		if iter_12_1 then
			iter_12_1:Dispose()
		end
	end

	var_0_0.super.Dispose(arg_12_0)
end

return var_0_0
