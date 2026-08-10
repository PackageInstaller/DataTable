local var_0_0 = class("WeaponServantHeadItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.BuildContext(arg_2_0)
	local var_2_0 = arg_2_0.gameObject_:GetComponent("ControllerExCollection")

	arg_2_0.controller = {
		comps = var_2_0,
		state = {
			select = {
				False = "false",
				name = "select",
				True = "true",
				comps = var_2_0:GetController("select")
			},
			mask = {
				False = "false",
				name = "mask",
				True = "true",
				comps = var_2_0:GetController("mask")
			},
			star = {
				Star1 = "star1",
				name = "star",
				Star4 = "star4",
				Star5 = "star5",
				Star3 = "star3",
				Star2 = "star2",
				comps = var_2_0:GetController("star")
			}
		}
	}
	arg_2_0.data = {
		info = {}
	}
	arg_2_0.constVar = {
		isShowLock = true,
		lockImg = {
			unlocked = "com_white_icon_26",
			locked = "com_white_icon_25"
		}
	}
end

function var_0_0.InitContext(arg_3_0)
	arg_3_0.data.info = {}
end

function var_0_0.Init(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.roleIconImg_.immediate = true

	arg_4_0:BuildContext()
	arg_4_0:AddUIListener()
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.clickBtn_, nil, function()
		if arg_5_0.data.clickCallback then
			arg_5_0.data.clickCallback(arg_5_0)
		end
	end)
end

function var_0_0.OnEnter(arg_7_0)
	return
end

function var_0_0.OnExit(arg_8_0)
	return
end

function var_0_0.Dispose(arg_9_0)
	var_0_0.super.Dispose(arg_9_0)
end

function var_0_0.RegistCallBack(arg_10_0, arg_10_1)
	arg_10_0.data.clickCallback = arg_10_1
end

function var_0_0.OnRender(arg_11_0, arg_11_1)
	arg_11_0:InitContext()

	arg_11_0.data.info = arg_11_1

	local var_11_0 = arg_11_1.id
	local var_11_1 = ItemCfg[var_11_0]

	arg_11_0.roleIconImg_.spriteSync = "TextureConfig/WeaponServant/Icon438x238/" .. var_11_0
	arg_11_0.levelTxt_.text = arg_11_1.number

	local var_11_2 = var_11_1.rare

	arg_11_0.qualityImg_.sprite = getSprite("Atlas/Hero_servantAtlas", string.format("img_servantGrade_0%d", 6 - var_11_2))

	arg_11_0:SwitchControllerState(arg_11_0.controller.state.star.name, string.format("star%d", var_11_2))

	local var_11_3 = WeaponServantCfg[var_11_0].race

	arg_11_0.servantGroupImg_.sprite = getSprite("Atlas/Item", string.format("icon_group_%d_c", var_11_3))
end

function var_0_0.RenderEquipStatus(arg_12_0, arg_12_1, arg_12_2)
	SetActive(arg_12_0.avatarObj_, arg_12_1 or false)

	if arg_12_1 then
		arg_12_0.avatarIcon_.sprite = HeroTools.GetSmallHeadSprite(arg_12_2)
	end
end

function var_0_0.ShowSelect(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0.controller.state.select.False

	if arg_13_1 then
		var_13_0 = arg_13_0.controller.state.select.True
	end

	arg_13_0:SwitchControllerState(arg_13_0.controller.state.select.name, var_13_0)
end

function var_0_0.ShowMask(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0.controller.state.mask.False

	if arg_14_1 then
		var_14_0 = arg_14_0.controller.state.mask.True
	end

	arg_14_0:SwitchControllerState(arg_14_0.controller.state.mask.name, var_14_0)
end

function var_0_0.ShowLock(arg_15_0, arg_15_1)
	if arg_15_0.constVar.isShowLock then
		SetActive(arg_15_0.lockRootObj_, arg_15_1)
	end
end

function var_0_0.ShowLockObj(arg_16_0, arg_16_1)
	arg_16_0.constVar.isShowLock = arg_16_1

	SetActive(arg_16_0.lockRootObj_, arg_16_1 or false)
end

function var_0_0.ShowRecommendTag(arg_17_0, arg_17_1)
	SetActive(arg_17_0.recommendObj_, arg_17_1 or false)
end

function var_0_0.GetItemUid(arg_18_0)
	if arg_18_0.data.info then
		return arg_18_0.data.info.uid
	end

	return 0
end

function var_0_0.GetIndex(arg_19_0)
	if arg_19_0.data.info then
		return arg_19_0.data.info.index
	end

	return nil
end

function var_0_0.SwitchControllerState(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = arg_20_0.controller.state[arg_20_1]

	if var_20_0 then
		var_20_0.comps:SetSelectedState(arg_20_2)
	end
end

return var_0_0
