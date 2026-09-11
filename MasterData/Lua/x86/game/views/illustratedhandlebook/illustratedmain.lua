local IllustratedMain = class("IllustratedMain", ReduxView)

function IllustratedMain:UIName()
	return "Widget/System/IllustratedHandbook/IlluEntranceUI"
end

function IllustratedMain:UIParent()
	return manager.ui.uiMain.transform
end

function IllustratedMain:Init()
	self:InitUI()
	self:AddUIListener()
end

function IllustratedMain:InitUI()
	self:BindCfgUI()
end

function IllustratedMain:AddUIListener()
	self:AddBtnListener(self.enemybtnBtn_, nil, function()
		IllustratedAction.SetIlluRedPoint(RedPointConst.ILUU_ENEMY)
		self:Go("/illuEnemyFiles")
	end)
	self:AddBtnListener(self.equipbtnBtn_, nil, function()
		IllustratedAction.SetIlluRedPoint(RedPointConst.ILLU_EQUIP)
		self:Go("/illuEquipManual")
	end)
	self:AddBtnListener(self.servantbtnBtn_, nil, function()
		IllustratedAction.SetIlluRedPoint(RedPointConst.ILLU_SERVANT)
		self:Go("/illuServantManual")
	end)
	self:AddBtnListener(self.worldbtnBtn_, nil, function()
		IllustratedAction.SetIlluRedPoint(RedPointConst.ILLU_WORLDVIEW)
		self:Go("/illuWorldView")
	end)
	self:AddBtnListener(self.plotbtnBtn_, nil, function()
		self:Go("/illuPlot")
	end)
	self:AddBtnListener(self.illustrationbtnBtn_, nil, function()
		self:Go("/illuIllustration")
	end)
	self:AddBtnListener(self.heroBtn_, nil, function()
		JumpTools.OpenPageByJump("/heroPreviewChange")
	end)
	self:AddBtnListener(self.musicBtn_, nil, function()
		JumpTools.OpenPageByJump("/illuMusic", {
			isEnter = true
		})
	end)
end

function IllustratedMain:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	for iter_14_0 = 1, 7 do
		self:RefreshRate(iter_14_0)
	end

	manager.redPoint:bindUIandKey(self.servantbtnBtn_.transform, RedPointConst.ILLU_SERVANT)
	manager.redPoint:bindUIandKey(self.equipbtnBtn_.transform, RedPointConst.ILLU_EQUIP)
	manager.redPoint:bindUIandKey(self.enemybtnBtn_.transform, RedPointConst.ILUU_ENEMY)
	manager.redPoint:bindUIandKey(self.worldbtnBtn_.transform, RedPointConst.ILLU_WORLDVIEW)
	manager.redPoint:bindUIandKey(self.illustrationbtnBtn_.transform, RedPointConst.ILLU_ILLUSTRATION)
	manager.redPoint:bindUIandKey(self.heroBtn_.transform, RedPointConst.ILLU_HERO)
end

function IllustratedMain:GetStoryLen()
	local var_15_0 = 0

	for iter_15_0, iter_15_1 in pairs(StoryCfg) do
		if iter_15_1.trigger[2] then
			var_15_0 = var_15_0 + 1
		end
	end

	return var_15_0
end

function IllustratedMain:RefreshRate(arg_16_1)
	if arg_16_1 == 1 then
		self.informationrateImg_.fillAmount = 0.5
		self.informaiontextText_.text = 0.5 * 100 .. "%"
	elseif arg_16_1 == 2 then
		local var_16_2 = table.length(IllustratedData:GetEnemyInfo()) / #CollectMonsterCfg.all

		self.enemyrateImg_.fillAmount = var_16_2
		self.enemytextText_.text = string.format("%d%%", var_16_2 * 100)
	elseif arg_16_1 == 3 then
		local var_16_3 = 0
		local var_16_4 = 0
		local var_16_5 = IllustratedData:GetServantInfo()

		for iter_16_0, iter_16_1 in ipairs(WeaponServantCfg.all) do
			if not ServantTools.GetIsHide(iter_16_1) then
				if var_16_5[iter_16_1] then
					var_16_4 = var_16_4 + 1
				end

				var_16_3 = var_16_3 + 1
			end
		end

		self.servantrateImg_.fillAmount = var_16_4 / var_16_3
		self.servanttextText_.text = string.format("%d%%", var_16_4 / var_16_3 * 100)
	elseif arg_16_1 == 4 then
		local var_16_6 = IlluTools.GetEquipAll() / (EquipTools.GetSuitTotalNum() * 6)

		self.equiprateImg_.fillAmount = var_16_6
		self.equiptextText_.text = string.format("%d%%", var_16_6 * 100)
	elseif arg_16_1 == 5 then
		local var_16_7 = table.length(IllustratedData:GetPlotInfo()) / self:GetStoryLen()

		self.plotrateImg_.fillAmount = var_16_7
		self.plottextText_.text = string.format("%d%%", var_16_7 * 100)
	elseif arg_16_1 == 6 then
		local var_16_8 = table.length(IllustratedData:GetIllustrationInfo()) / #CollectPictureCfg.all

		self.illurateImg_.fillAmount = var_16_8
		self.illutextText_.text = string.format("%d%%", var_16_8 * 100)
	elseif arg_16_1 == 7 then
		local var_16_9 = table.length(IllustratedData:GetAffixInfo()) / #CollectWordCfg.all

		self.worldrateImg_.fillAmount = var_16_9
		self.worldtextText_.text = string.format("%d%%", var_16_9 * 100)
	end
end

function IllustratedMain:OnExit()
	manager.windowBar:HideBar()
	manager.redPoint:unbindUIandKey(self.servantbtnBtn_.transform, RedPointConst.ILLU_SERVANT)
	manager.redPoint:unbindUIandKey(self.equipbtnBtn_.transform, RedPointConst.ILLU_EQUIP)
	manager.redPoint:unbindUIandKey(self.enemybtnBtn_.transform, RedPointConst.ILUU_ENEMY)
	manager.redPoint:unbindUIandKey(self.worldbtnBtn_.transform, RedPointConst.ILLU_WORLDVIEW)
	manager.redPoint:unbindUIandKey(self.illustrationbtnBtn_.transform, RedPointConst.ILLU_ILLUSTRATION)
	manager.redPoint:unbindUIandKey(self.heroBtn_.transform, RedPointConst.ILLU_HERO)
	manager.gc:Collect()
	Resources.UnloadUnusedAssets()
end

function IllustratedMain:Dispose()
	IllustratedMain.super.Dispose(self)
end

return IllustratedMain
