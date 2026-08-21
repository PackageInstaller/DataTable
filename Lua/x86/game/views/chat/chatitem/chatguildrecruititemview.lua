local var_0_0 = import("game.views.chat.loopScrollView.LoopScrollViewBaseItem")
local var_0_1 = class("ChatGuildRecruitItemView", var_0_0)

function var_0_1.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()

	arg_1_0.commonPortrait_ = CommonHeadPortrait.New(arg_1_0.headItem_)

	arg_1_0:AddListeners()

	arg_1_0.guildItemView_ = ChatGuildInfoView.New(arg_1_0.guildRecruitGo_)

	arg_1_0:Show(true)
end

function var_0_1.Dispose(arg_2_0)
	arg_2_0.commonPortrait_:Dispose()

	arg_2_0.commonPortrait_ = nil

	arg_2_0.guildItemView_:Dispose()

	arg_2_0.guildItemView_ = nil

	var_0_1.super.Dispose(arg_2_0)
	Object.Destroy(arg_2_0.gameObject_)

	arg_2_0.gameObject_ = nil
	arg_2_0.transform_ = nil
end

function var_0_1.GetUserID(arg_3_0)
	return arg_3_0.itemData_.id
end

function var_0_1.AddListeners(arg_4_0)
	arg_4_0.commonPortrait_:RegisteClickCallback(function()
		if CooperationData:CheckInRoom() then
			return
		end

		ForeignInfoAction:TryToCheckForeignDetailInfo(arg_4_0:GetUserID())
	end)
end

function var_0_1.GetNick(arg_6_0)
	return arg_6_0.itemData_.nick
end

function var_0_1.SetText(arg_7_0, arg_7_1)
	if arg_7_1.id == USER_ID then
		local var_7_0 = PlayerData:GetPlayerInfo()

		arg_7_0.textName_.text = GetI18NText(var_7_0.nick)

		arg_7_0.commonPortrait_:RenderHead(var_7_0.portrait)
		arg_7_0.commonPortrait_:RenderFrame(var_7_0.icon_frame)
	else
		arg_7_0.textName_.text = GetI18NText(arg_7_1.nick)

		arg_7_0.commonPortrait_:RenderHead(arg_7_1.icon)
		arg_7_0.commonPortrait_:RenderFrame(arg_7_1.iconFrame)
	end

	if arg_7_1.content == "" then
		SetActive(arg_7_0.contentGo_, false)
	else
		SetActive(arg_7_0.contentGo_, true)

		arg_7_0.contentText_.text = GetI18NText(arg_7_1.content)
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_7_0.rectContent_)
	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_7_0.rectGo_)
end

function var_0_1.SetData(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0.itemData_ = arg_8_1
	arg_8_0.index_ = arg_8_2

	arg_8_0:Show(true)
	arg_8_0:SetText(arg_8_1)
	arg_8_0.guildItemView_:SetGuildID(arg_8_1.guildID)
end

function var_0_1.SetAsLastSibling(arg_9_0)
	arg_9_0.transform_:SetAsLastSibling()
end

function var_0_1.SetAsFirstSibling(arg_10_0)
	arg_10_0.transform_:SetAsFirstSibling()
end

function var_0_1.Show(arg_11_0, arg_11_1)
	SetActive(arg_11_0.gameObject_, arg_11_1)
end

return var_0_1
