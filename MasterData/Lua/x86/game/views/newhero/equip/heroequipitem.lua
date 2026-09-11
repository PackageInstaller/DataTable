local HeroEquipItem = class("HeroEquipItem", ReduxView)

function HeroEquipItem:OnCtor(arg_1_1, arg_1_2, arg_1_3)
	self.data_ = arg_1_1
	self.gameObject_ = arg_1_2
	self.transform_ = arg_1_2.transform
	self.info_ = arg_1_3

	self:InitUI()
	self:Init()
end

function HeroEquipItem:RefreshData(arg_2_1, arg_2_2)
	self.data_ = arg_2_1
	self.info_ = arg_2_2

	self:Render()
end

function HeroEquipItem:InitUI()
	self:BindCfgUI()

	self.starS_ = {}

	for iter_3_0 = 1, 6 do
		self.starS_[iter_3_0] = self[string.format("star%dGo_", iter_3_0)]
	end

	self:AddBtnListener(nil, nil, "OnClick")
end

function HeroEquipItem:Init()
	return
end

function HeroEquipItem:Render()
	self:RefreshUI(self.info_)
end

function HeroEquipItem:IgnoreAdd()
	self.ignoreAdd_ = true
end

function HeroEquipItem:RefreshUI(arg_7_1)
	local var_7_0 = arg_7_1.equip_id ~= 0

	SetActive(self.activeGo_, arg_7_1.equip_id ~= 0)

	if not self.ignoreAdd_ then
		SetActive(self.addGo_, not var_7_0)
	end

	if var_7_0 then
		local var_7_1 = EquipCfg[arg_7_1.prefab_id]

		self.bgTrs_.localEulerAngles = Vector3.New(0, 0, 60 * (EquipCfg[arg_7_1.prefab_id].pos - 1))

		SetSpriteWithoutAtlasAsync(self.iconImg_, SpritePathCfg.EquipIcon_s.path .. ItemCfg[arg_7_1.prefab_id].icon)

		if self.lvlongText_ then
			self.lvlongText_.text = GetTips("LEVEL") .. string.format("<color=#FFFFFF>%d</color>", arg_7_1.GetLevel and arg_7_1:GetLevel() or 1)
		end

		self.lvText_.text = string.format("%d", arg_7_1.GetLevel and arg_7_1:GetLevel() or 1)

		local var_7_3 = arg_7_1.race or 0

		if var_7_3 ~= 0 then
			SetActive(self.raceImg_.transform.parent.gameObject, true)

			self.raceImg_.sprite = table.keyof(RaceEffectCfg.all, var_7_3) ~= nil and getSprite("Atlas/Item", string.format("icon_group_%d_c", arg_7_1.race)) or HeroTools.GetSmallHeadSprite(var_7_3)
		else
			SetActive(self.raceImg_.transform.parent.gameObject, false)
		end

		for iter_7_0 = 1, 6 do
			SetActive(self.starS_[iter_7_0], iter_7_0 <= var_7_1.starlevel)
		end
	else
		self.bgTrs_.localEulerAngles = Vector3.New(0, 0, 60 * (arg_7_1.pos - 1))
	end

	if self.layoutTimer_ == nil then
		self.layoutTimer_ = Timer.New(function()
			UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.racePanelGo_.transform)
			UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.racePanelGo_:GetComponent("RectTransform"))
			self.layoutTimer_:Stop()

			self.layoutTimer_ = nil
		end, 1.3)
	end

	self.layoutTimer_:Start()
end

function HeroEquipItem:ShowSelect(arg_9_1)
	SetActive(self.selectGo_, arg_9_1)
end

function HeroEquipItem:OnClick()
	if self.clickFunc then
		self.clickFunc(self.info_)
	end
end

function HeroEquipItem:RegistCallBack(arg_11_1)
	self.clickFunc = arg_11_1
end

function HeroEquipItem:GetItemInfo()
	return self.info_
end

function HeroEquipItem:Dispose()
	self.clickFunc = nil

	self:RemoveAllListeners()
	HeroEquipItem.super.Dispose(self)
end

return HeroEquipItem
