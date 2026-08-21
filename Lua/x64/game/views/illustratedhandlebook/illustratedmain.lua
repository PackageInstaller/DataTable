local var_0_0 = class("IllustratedMain", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/IllustratedHandbook/IlluEntranceUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.enemybtnBtn_, nil, function()
		IllustratedAction.SetIlluRedPoint(RedPointConst.ILUU_ENEMY)
		arg_5_0:Go("/illuEnemyFiles")
	end)
	arg_5_0:AddBtnListener(arg_5_0.equipbtnBtn_, nil, function()
		IllustratedAction.SetIlluRedPoint(RedPointConst.ILLU_EQUIP)
		arg_5_0:Go("/illuEquipManual")
	end)
	arg_5_0:AddBtnListener(arg_5_0.servantbtnBtn_, nil, function()
		IllustratedAction.SetIlluRedPoint(RedPointConst.ILLU_SERVANT)
		arg_5_0:Go("/illuServantManual")
	end)
	arg_5_0:AddBtnListener(arg_5_0.worldbtnBtn_, nil, function()
		IllustratedAction.SetIlluRedPoint(RedPointConst.ILLU_WORLDVIEW)
		arg_5_0:Go("/illuWorldView")
	end)
	arg_5_0:AddBtnListener(arg_5_0.plotbtnBtn_, nil, function()
		arg_5_0:Go("/illuPlot")
	end)
	arg_5_0:AddBtnListener(arg_5_0.illustrationbtnBtn_, nil, function()
		arg_5_0:Go("/illuIllustration")
	end)
	arg_5_0:AddBtnListener(arg_5_0.heroBtn_, nil, function()
		JumpTools.OpenPageByJump("/heroPreviewChange")
	end)
	arg_5_0:AddBtnListener(arg_5_0.musicBtn_, nil, function()
		JumpTools.OpenPageByJump("/illuMusic", {
			isEnter = true
		})
	end)
end

function var_0_0.OnEnter(arg_14_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	for iter_14_0 = 1, 7 do
		arg_14_0:RefreshRate(iter_14_0)
	end

	manager.redPoint:bindUIandKey(arg_14_0.servantbtnBtn_.transform, RedPointConst.ILLU_SERVANT)
	manager.redPoint:bindUIandKey(arg_14_0.equipbtnBtn_.transform, RedPointConst.ILLU_EQUIP)
	manager.redPoint:bindUIandKey(arg_14_0.enemybtnBtn_.transform, RedPointConst.ILUU_ENEMY)
	manager.redPoint:bindUIandKey(arg_14_0.worldbtnBtn_.transform, RedPointConst.ILLU_WORLDVIEW)
	manager.redPoint:bindUIandKey(arg_14_0.illustrationbtnBtn_.transform, RedPointConst.ILLU_ILLUSTRATION)
	manager.redPoint:bindUIandKey(arg_14_0.heroBtn_.transform, RedPointConst.ILLU_HERO)
end

function var_0_0.GetStoryLen(arg_15_0)
	local var_15_0 = 0

	for iter_15_0, iter_15_1 in pairs(StoryCfg) do
		if iter_15_1.trigger[2] then
			var_15_0 = var_15_0 + 1
		end
	end

	return var_15_0
end

function var_0_0.RefreshRate(arg_16_0, arg_16_1)
	local var_16_0 = 0.5
	local var_16_1
	local var_16_2

	if arg_16_1 == 1 then
		arg_16_0.informationrateImg_.fillAmount = var_16_0
		arg_16_0.informaiontextText_.text = var_16_0 * 100 .. "%"
	elseif arg_16_1 == 2 then
		local var_16_3 = #CollectMonsterCfg.all
		local var_16_4 = table.length(IllustratedData:GetEnemyInfo()) / var_16_3

		arg_16_0.enemyrateImg_.fillAmount = var_16_4
		arg_16_0.enemytextText_.text = string.format("%d%%", var_16_4 * 100)
	elseif arg_16_1 == 3 then
		local var_16_5, var_16_6 = 0, 0
		local var_16_7 = IllustratedData:GetServantInfo()

		for iter_16_0, iter_16_1 in ipairs(WeaponServantCfg.all) do
			local var_16_8 = var_16_7[iter_16_1]

			if not ServantTools.GetIsHide(iter_16_1) then
				if var_16_8 then
					var_16_5 = var_16_5 + 1
				end

				var_16_6 = var_16_6 + 1
			end
		end

		local var_16_9 = var_16_5 / var_16_6

		arg_16_0.servantrateImg_.fillAmount = var_16_9
		arg_16_0.servanttextText_.text = string.format("%d%%", var_16_9 * 100)
	elseif arg_16_1 == 4 then
		local var_16_10 = EquipTools.GetSuitTotalNum() * 6
		local var_16_11 = IlluTools.GetEquipAll() / var_16_10

		arg_16_0.equiprateImg_.fillAmount = var_16_11
		arg_16_0.equiptextText_.text = string.format("%d%%", var_16_11 * 100)
	elseif arg_16_1 == 5 then
		local var_16_12 = arg_16_0:GetStoryLen()
		local var_16_13 = table.length(IllustratedData:GetPlotInfo()) / var_16_12

		arg_16_0.plotrateImg_.fillAmount = var_16_13
		arg_16_0.plottextText_.text = string.format("%d%%", var_16_13 * 100)
	elseif arg_16_1 == 6 then
		local var_16_14 = #CollectPictureCfg.all
		local var_16_15 = table.length(IllustratedData:GetIllustrationInfo()) / var_16_14

		arg_16_0.illurateImg_.fillAmount = var_16_15
		arg_16_0.illutextText_.text = string.format("%d%%", var_16_15 * 100)
	elseif arg_16_1 == 7 then
		local var_16_16 = #CollectWordCfg.all
		local var_16_17 = table.length(IllustratedData:GetAffixInfo()) / var_16_16

		arg_16_0.worldrateImg_.fillAmount = var_16_17
		arg_16_0.worldtextText_.text = string.format("%d%%", var_16_17 * 100)
	end
end

function var_0_0.OnExit(arg_17_0)
	manager.windowBar:HideBar()
	manager.redPoint:unbindUIandKey(arg_17_0.servantbtnBtn_.transform, RedPointConst.ILLU_SERVANT)
	manager.redPoint:unbindUIandKey(arg_17_0.equipbtnBtn_.transform, RedPointConst.ILLU_EQUIP)
	manager.redPoint:unbindUIandKey(arg_17_0.enemybtnBtn_.transform, RedPointConst.ILUU_ENEMY)
	manager.redPoint:unbindUIandKey(arg_17_0.worldbtnBtn_.transform, RedPointConst.ILLU_WORLDVIEW)
	manager.redPoint:unbindUIandKey(arg_17_0.illustrationbtnBtn_.transform, RedPointConst.ILLU_ILLUSTRATION)
	manager.redPoint:unbindUIandKey(arg_17_0.heroBtn_.transform, RedPointConst.ILLU_HERO)
	manager.gc:Collect()
	Resources.UnloadUnusedAssets()
end

function var_0_0.Dispose(arg_18_0)
	var_0_0.super.Dispose(arg_18_0)
end

return var_0_0
