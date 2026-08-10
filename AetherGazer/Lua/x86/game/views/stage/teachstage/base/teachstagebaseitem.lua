local var_0_0 = class("TeachStageBaseItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
	arg_1_0.transform_.name = arg_1_3
	arg_1_0.stageID_ = arg_1_3

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddListeners()
	arg_2_0:SetData(arg_2_0.stageID_)
end

function var_0_0.InitUI(arg_3_0)
	SetActive(arg_3_0.gameObject_, true)
	arg_3_0:BindCfgUI()

	arg_3_0.selectcontroller_ = ControllerUtil.GetController(arg_3_0.transform_, "select")
end

function var_0_0.AddListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.itemBtn_, nil, function()
		if arg_4_0.isLock_ then
			ShowTips(arg_4_0.lockStr_)

			return
		end

		local var_5_0 = getChapterAndSectionID(arg_4_0.stageID_)

		BattleFieldData:SetCacheStage(var_5_0, arg_4_0.stageID_)
		manager.redPoint:setTip(RedPointConst.TEACH_BASE_TEACHING .. "_" .. arg_4_0.stageID_, 0)
		saveData("redPoint", "BattleBaseTeachStageViewed_" .. arg_4_0.stageID_, true)
		arg_4_0:Go("teachSectionInfo", {
			section = arg_4_0.stageID_,
			sectionType = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BASE_TEACHING
		})
	end)
end

function var_0_0.RefreshSelect(arg_6_0, arg_6_1)
	arg_6_0.selectcontroller_:SetSelectedState(arg_6_1 == arg_6_0.stageID_ and "choice" or "normal")
end

function var_0_0.Dispose(arg_7_0)
	arg_7_0.icon_ = nil
	arg_7_0.itemBtn_ = nil
	arg_7_0.text_ = nil
	arg_7_0.clear_ = nil

	Object.Destroy(arg_7_0.gameObject_)

	arg_7_0.gameObject_ = nil
	arg_7_0.transform_ = nil

	var_0_0.super.Dispose(arg_7_0)
end

function var_0_0.SetData(arg_8_0, arg_8_1)
	if arg_8_0.stageID_ then
		manager.redPoint:unbindUIandKey(arg_8_0.transform_, RedPointConst.TEACH_BASE_TEACHING .. "_" .. arg_8_0.stageID_)
	end

	arg_8_0.stageID_ = arg_8_1

	manager.redPoint:bindUIandKey(arg_8_0.transform_, RedPointConst.TEACH_BASE_TEACHING .. "_" .. arg_8_0.stageID_)

	for iter_8_0, iter_8_1 in ipairs(GameSetting.new_player_study_stage_unlock.value) do
		if iter_8_1[1] == arg_8_1 then
			arg_8_0.isLock_ = false
		end
	end

	arg_8_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_9_0)
	if arg_9_0.oldStageID_ ~= arg_9_0.stageID_ then
		arg_9_0.oldStageID_ = arg_9_0.stageID_

		local var_9_0 = BattleBaseTeachStageCfg[arg_9_0.stageID_]

		arg_9_0.transform_.localPosition = Vector3(var_9_0.position[1], var_9_0.position[2], 0)
		arg_9_0.icon_.sprite = pureGetSpriteWithoutAtlas(string.format("%s%s", SpritePathCfg.StageHDPaint.path, var_9_0.hd_image))
		arg_9_0.text_.text = GetI18NText(var_9_0.name)
	end

	local var_9_1 = BattleTeachData:GetBaseTeachList()[arg_9_0.stageID_]

	SetActive(arg_9_0.gameObject_, true)

	local var_9_2 = var_9_1 and var_9_1 > 0 or false

	SetActive(arg_9_0.clear_, var_9_2)
	SetActive(arg_9_0.lockGo_, arg_9_0.isLock_)
end

function var_0_0.GetLocalPosition(arg_10_0)
	return arg_10_0.transform_.localPosition
end

function var_0_0.Show(arg_11_0, arg_11_1)
	SetActive(arg_11_0.gameObject_, arg_11_1)
end

function var_0_0.IsOpenSectionInfo(arg_12_0)
	return arg_12_0:IsOpenRoute("teachSectionInfo")
end

return var_0_0
