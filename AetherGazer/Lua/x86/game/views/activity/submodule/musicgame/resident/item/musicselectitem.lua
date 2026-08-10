local var_0_0 = class("MusicSelectItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()

	arg_2_0.music_item_list = {}
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.selectController_ = ControllerUtil.GetController(arg_3_0.transform_, "toggle")
	arg_3_0.linkTagController_ = arg_3_0.controller_:GetController("linkTag")
	arg_3_0.newTagController_ = arg_3_0.controller_:GetController("newTag")
	arg_3_0.finishController_ = arg_3_0.controller_:GetController("finishbg")
	arg_3_0.isSelect = false
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		arg_4_0:OnClickBtn()
	end)
end

function var_0_0.OnClickBtn(arg_6_0)
	if arg_6_0.isSelect then
		return
	end

	manager.notify:Invoke(MUSIC_TREE_CLICK_ITEM, arg_6_0.mainActivityID, arg_6_0.musicActivityID)
end

function var_0_0.GetMusicActivityID(arg_7_0)
	return arg_7_0.musicActivityID
end

function var_0_0.SetData(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0.mainActivityID = arg_8_1
	arg_8_0.musicActivityID = arg_8_2

	arg_8_0:RefreshUI()
	arg_8_0:RefreshSelectInfo()
end

function var_0_0.RefreshUI(arg_9_0)
	local var_9_0 = ActivityMusicCfg.get_id_list_by_activity_id[arg_9_0.musicActivityID]
	local var_9_1 = ActivityMusicCfg[var_9_0[1]]
	local var_9_2 = MusicData:GetTagImagePath(var_9_1.id)

	if var_9_2 then
		arg_9_0.linkTagController_:SetSelectedState("show")

		arg_9_0.linkImage_.sprite = getSpriteWithoutAtlas(var_9_2)
	else
		arg_9_0.linkTagController_:SetSelectedState("hide")
	end

	arg_9_0.authorText_.text = GetI18NText(var_9_1.creator_name)
	arg_9_0.nameText_.text = GetI18NText(var_9_1.name)

	arg_9_0:BindRed(true)
	arg_9_0:UpdateFinishState()
end

function var_0_0.UpdateFinishState(arg_10_0)
	local var_10_0 = ActivityMusicCfg.get_id_list_by_activity_id[arg_10_0.musicActivityID]
	local var_10_1 = false

	for iter_10_0, iter_10_1 in ipairs(var_10_0) do
		local var_10_2 = ActivityMusicCfg[iter_10_1]

		if MusicData:GetIsComplete(iter_10_1) ~= 0 then
			var_10_1 = true

			break
		end
	end

	arg_10_0.finishController_:SetSelectedState(var_10_1 and "finish" or "normal")
end

function var_0_0.RefreshSelectInfo(arg_11_0)
	arg_11_0.selectController_:SetSelectedState(arg_11_0.isSelect and "on" or "off")
end

function var_0_0.ChangeSelectState(arg_12_0, arg_12_1)
	arg_12_0.isSelect = arg_12_1

	arg_12_0:RefreshSelectInfo()
end

function var_0_0.Show(arg_13_0, arg_13_1)
	SetActive(arg_13_0.gameObject_, arg_13_1)
end

function var_0_0.BindRed(arg_14_0, arg_14_1)
	if arg_14_1 then
		manager.redPoint:bindUIandKey(arg_14_0.transform_, string.format("%s_%s", RedPointConst.MUSIC_OPEN, arg_14_0.musicActivityID))
	else
		manager.redPoint:unbindUIandKey(arg_14_0.transform_, string.format("%s_%s", RedPointConst.MUSIC_OPEN, arg_14_0.musicActivityID))
	end
end

function var_0_0.Dispose(arg_15_0)
	var_0_0.super.Dispose(arg_15_0)
end

return var_0_0
