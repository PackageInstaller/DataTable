local var_0_0 = class("AreaBattleBuffItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddBtnListener(arg_3_0.btn_, nil, function()
		if arg_3_0.cfg.name == arg_3_0.nameTxt_.text and arg_3_0.tipsGo_.activeSelf == true then
			SetActive(arg_3_0.tipsGo_, false)
		else
			arg_3_0.nameTxt_.text = GetI18NText(arg_3_0.cfg.name)
			arg_3_0.descTxt_.text = GetI18NText(arg_3_0.cfg.desc)

			SetActive(arg_3_0.tipsGo_, true)

			arg_3_0.tipsGo_.transform.position = Vector3(arg_3_0.transform_.position.x, arg_3_0.transform_.position.y - 0.1, arg_3_0.transform_.position.z)
		end
	end)
end

function var_0_0.SetData(arg_5_0, arg_5_1)
	arg_5_0.affixID = arg_5_1
	arg_5_0.cfg = TalentTreeCfg[arg_5_1]

	local var_5_0 = PublicBuffCfg[arg_5_0.cfg.affix_id]

	arg_5_0.icon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/BuffIcon/" .. var_5_0.icon)
end

function var_0_0.OnExit(arg_6_0)
	return
end

function var_0_0.Dispose(arg_7_0)
	var_0_0.super.Dispose(arg_7_0)
	Object.Destroy(arg_7_0.gameObject_)
end

return var_0_0
