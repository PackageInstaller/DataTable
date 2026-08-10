local var_0_0 = class("NickNameBubbleView", import("game.extend.BaseView"))

function var_0_0.UIName(arg_1_0)
	return "Widget/BackHouseUI/Dorm/item/NicknameBubbleView"
end

function var_0_0.Ctor(arg_2_0, arg_2_1)
	var_0_0.super.Ctor(arg_2_0)

	arg_2_0.gameObject_ = GameObject.Instantiate(Asset.Load(arg_2_0:UIName()), manager.ui.uiMain.transform)
	arg_2_0.needDisposeGo = true
	arg_2_0.transform_ = nullable(arg_2_0.gameObject_, "transform")

	arg_2_0.transform_:SetAsFirstSibling()

	arg_2_0.nicknameBubbles = {}

	arg_2_0:BindCfgUI()
end

function var_0_0.OnEnter(arg_3_0)
	arg_3_0:OnEnable()
end

function var_0_0.OnEnable(arg_4_0)
	arg_4_0:RegistEventListener(DORM_CHARACTER_DISPOSE, handler(arg_4_0, arg_4_0.OnEntityDispose))
	arg_4_0:RegistEventListener(DORM_VISIT_CHARACTER_NICKNAME, handler(arg_4_0, arg_4_0.OnPlayVisitNickName))
	DormHeroTools:ShowVisitName()
end

function var_0_0.OnExit(arg_5_0)
	arg_5_0:OnDisable()
end

function var_0_0.OnDisable(arg_6_0)
	for iter_6_0, iter_6_1 in pairs(arg_6_0.nicknameBubbles) do
		iter_6_1:Dispose()
	end

	arg_6_0.nicknameBubbles = {}

	arg_6_0:RemoveAllEventListener()
end

function var_0_0.Dispose(arg_7_0)
	GameObject.Destroy(arg_7_0.gameObject_)
end

function var_0_0.GetVisitBubble(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0.nicknameBubbles[arg_8_1]

	if not var_8_0 then
		local var_8_1 = GameObject.Instantiate(arg_8_0.visitNamePrefab, arg_8_0.bubbleRoot)

		var_8_0 = NicknameBubbleItem.New(var_8_1)

		var_8_0.content:SetActive(false)

		arg_8_0.nicknameBubbles[arg_8_1] = var_8_0

		var_8_1:SetActive(true)
	end

	return var_8_0
end

function var_0_0.OnPlayVisitNickName(arg_9_0, arg_9_1, arg_9_2)
	if DormHeroTools:CheckIsVisitHero(arg_9_1) then
		local var_9_0 = arg_9_0:GetVisitBubble(arg_9_1)

		if var_9_0 == nil then
			return
		end

		DormLuaBridge.SetUIFollow(var_9_0.transform_, arg_9_1, "gua_Hp")
		var_9_0:ShowSubtitle(arg_9_1)
		var_9_0:SetData(arg_9_2)
	end
end

function var_0_0.OnEntityDispose(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0.nicknameBubbles[arg_10_1]

	if var_10_0 then
		var_10_0:Dispose()

		arg_10_0.nicknameBubbles[arg_10_1] = nil
	end
end

return var_0_0
