local var_0_0 = class("EquipNewSkillInfoView", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.gameObject_ = arg_1_1

	arg_1_0:InitUI()
	arg_1_0:AddUIListener()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.skillInfoList_ = {}
	arg_2_0.locationList = {}
	arg_2_0.infoScrollHelper_ = LuaList.New(handler(arg_2_0, arg_2_0.indexInfoItem), arg_2_0.skillListGo_, EquipSkillInfoItem)
	arg_2_0.locationScrollHelper_ = LuaList.New(handler(arg_2_0, arg_2_0.indexLocationItem), arg_2_0.locationListGo_, EquipSkillLocationItem)
	arg_2_0.stateController_ = arg_2_0.skillCon_:GetController("state")
	arg_2_0.tabController_ = arg_2_0.skillCon_:GetController("tab")
end

function var_0_0.AddUIListener(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.btnSkill_, nil, function()
		arg_3_0.tabController_:SetSelectedState("skill")
	end)
	arg_3_0:AddBtnListener(arg_3_0.btnLoacation_, nil, function()
		arg_3_0.tabController_:SetSelectedState("location")
	end)
end

function var_0_0.RefreshData(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	arg_6_0.handler_ = arg_6_1
	arg_6_0.info_ = arg_6_2
	arg_6_0.isShowLocate_ = arg_6_3

	arg_6_0:RefreshInfoList()
	arg_6_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_7_0)
	arg_7_0.icon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Equip/EquipSkillIcon/" .. arg_7_0.skillCfg_.icon)
	arg_7_0.name_.text = GetI18NText(arg_7_0.skillCfg_.name)

	local var_7_0 = arg_7_0.info_.num > arg_7_0.skillCfg_.lvmax and string.format("<color=#FF000B>%s</color>", arg_7_0.info_.num) or arg_7_0.info_.num

	arg_7_0.lv_.text = string.format("%s/%s", var_7_0, arg_7_0.skillCfg_.lvmax)

	arg_7_0.stateController_:SetSelectedState(arg_7_0.isShowLocate_ and "on" or "off")
	arg_7_0.tabController_:SetSelectedState("skill")
	arg_7_0.infoScrollHelper_:StartScroll(#arg_7_0.skillInfoList_)

	if arg_7_0.isShowLocate_ and arg_7_0.info_.location then
		arg_7_0.locationScrollHelper_:StartScroll(#arg_7_0.info_.location)
	end
end

function var_0_0.RefreshInfoList(arg_8_0)
	arg_8_0.skillInfoList_ = {}
	arg_8_0.skillCfg_ = EquipSkillCfg[arg_8_0.info_.id]

	for iter_8_0 = 1, arg_8_0.skillCfg_.lvmax do
		local var_8_0 = {
			level = GetTips("LEVEL") .. string.format("%d", iter_8_0)
		}
		local var_8_1 = arg_8_0.skillCfg_.upgrade / arg_8_0.skillCfg_.percent * iter_8_0

		var_8_0.desc = GetCfgDescriptionWithValue(arg_8_0.skillCfg_.desc[1], tostring(var_8_1))

		if arg_8_0.skillCfg_.desc_spec_value ~= nil and arg_8_0.skillCfg_.desc_spec_value ~= "" then
			var_8_0.desc = string.gsub(desc, tostring(var_8_1), arg_8_0.skillCfg_.desc_spec_value[iter_8_0])
		end

		var_8_0.alpha = iter_8_0 <= arg_8_0.info_.num and 1 or 0.5

		table.insert(arg_8_0.skillInfoList_, var_8_0)
	end
end

function var_0_0.indexInfoItem(arg_9_0, arg_9_1, arg_9_2)
	arg_9_2:RefreshData(arg_9_0, arg_9_0.skillInfoList_[arg_9_1])
end

function var_0_0.indexLocationItem(arg_10_0, arg_10_1, arg_10_2)
	arg_10_2:RefreshData(arg_10_0, arg_10_0.info_.location[arg_10_1])
end

function var_0_0.Dispose(arg_11_0)
	if arg_11_0.infoScrollHelper_ then
		arg_11_0.infoScrollHelper_:Dispose()

		arg_11_0.infoScrollHelper_ = nil
	end

	if arg_11_0.locationScrollHelper_ then
		arg_11_0.locationScrollHelper_:Dispose()

		arg_11_0.locationScrollHelper_ = nil
	end

	var_0_0.super.Dispose(arg_11_0)
end

return var_0_0
