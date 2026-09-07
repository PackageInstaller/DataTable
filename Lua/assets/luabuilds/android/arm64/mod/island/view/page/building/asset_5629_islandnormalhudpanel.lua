local IslandNormalHudPanel = class("IslandNormalHudPanel", import("Mod.Island.Core.View.IslandBaseHudPanel"))

function IslandNormalHudPanel:GetUIName()
	return "IslandNormalNpcHud"
end

function IslandNormalHudPanel:Ctor(arg_2_1, arg_2_2, arg_2_3)
	IslandNormalHudPanel.super.Ctor(self, arg_2_1, arg_2_2, arg_2_3)

	self.hud_name_range = pg.island_set.hud_name_range.key_value_int
	self.currentTaskType = -1
	self.currentTaskId = -1

	return
end

function IslandNormalHudPanel:OnInit()
	self.npcId = tonumber(self.param1)
	self.hudImageTF = self._tf:Find("hud_bg/hudImage")
	self.hudImageBg = self._tf:Find("hud_bg")
	self.hudImageIcon = pg.island_npc_hud[self.npcId].icon
	self.hudTitle = self._tf:Find("title")
	self.hudName = self._tf:Find("name")

	setText(self.hudTitle, pg.island_npc_hud[self.npcId].title)
	setText(self.hudName, pg.island_npc_hud[self.npcId].name)

	self.tfDic = {
		hudImage = self.hudImageBg,
		title = self.hudTitle,
		name = self.hudName
	}
	self.activeTFDic = {}
	self.playerTF = self:GetPlayer()

	self:CheckPlayer()

	return
end

function IslandNormalHudPanel:CheckPlayer()
	self.isNear = self:CheckIsNear()

	setActive(self.hudTitle, self.isNear)
	setActive(self.hudName, self.isNear)
	self:UpdateTaskDisplay()

	return
end

function IslandNormalHudPanel:OnDispose()
	IslandNormalHudPanel.super.OnDispose(self)

	return
end

function IslandNormalHudPanel:GetPlayer()
	for iter_6_0, iter_6_1 in ipairs((GameObject.Find("Root"):GetComponentsInChildren(typeof(WorldObjectItem)):ToTable())) do
		if iter_6_1.isPlayer then
			self.hasPlayer = true

			return iter_6_1.gameObject.transform
		end
	end

	return nil
end

function IslandNormalHudPanel:CheckIsNear()
	local var_7_0 = self.view:GetUnitModuleWithType(self.unitType, self.unitId)

	if var_7_0 then
		local var_7_1 = var_7_0._go or nil

		if not var_7_0 or IsNil(var_7_1) or IsNil(var_7_1.transform) then
			return false
		end

		if IsNil(self.playerTF) then
			return false
		end

		if (self.playerTF.position - var_7_1.transform.position).magnitude < self.hud_name_range then
			return true
		end
	end

	return false
end

function IslandNormalHudPanel:OnUpdate()
	if not self.hasPlayer then
		self.playerTF = self:GetPlayer()

		self:CheckPlayer()
	else
		local var_8_0 = self:CheckIsNear()

		if var_8_0 == self.isNear then
			return
		end

		self.isNear = var_8_0

		for iter_8_0, iter_8_1 in ipairs({
			"title",
			"name"
		}) do
			self:SetTFActive(iter_8_1, self.isNear)
		end
	end

	return
end

function IslandNormalHudPanel:SetTFActive(arg_9_1, arg_9_2)
	local var_9_0 = self.tfDic[arg_9_1]

	if IsNil(self.tfDic[arg_9_1]) then
		return
	end

	if self.activeTFDic[arg_9_1] == arg_9_2 then
		return
	end

	self.activeTFDic[arg_9_1] = arg_9_2

	local var_9_1 = self.tfDic[arg_9_1]:GetComponent(typeof(Animation))

	if arg_9_2 then
		var_9_1:Play("anim_IslandNormalNpcHud_in")

		if arg_9_1 == "hudImage" then
			self:UpdateTaskDisplay()
		else
			setActive(self.tfDic[arg_9_1], true)
		end
	else
		var_9_1:Play("anim_IslandNormalNpcHud_out")
		self.tfDic[arg_9_1]:GetComponent("DftAniEvent"):SetEndEvent(function(arg_10_0)
			if arg_9_1 == "hudImage" then
				self:UpdateTaskDisplay()
			else
				setActive(var_9_0, false)
			end

			return
		end)
	end

	return
end

function IslandNormalHudPanel:RefreshHud()
	self:UpdateTaskDisplay()

	return
end

function IslandNormalHudPanel:UpdateTaskDisplay()
	if IsNil(self.hudImageBg) then
		return
	end

	local var_12_0, var_12_1 = IslandObjectTaskHudHelper.GetObjectTaskHud(self.unitId)

	if self.currentTaskId ~= var_12_1 then
		self.currentTaskId = var_12_1

		if var_12_1 then
			local var_12_2, var_12_3 = IslandObjectTaskHudHelper.GetHudDislayInfoByTaskId(var_12_1)

			setActive(self.hudImageBg, true)
			GetImageSpriteFromAtlasAsync("island/IslandHudIcon", var_12_2, self.hudImageBg)
			setImageColor(self.hudImageTF, Color.NewHex(var_12_3))
		else
			setActive(self.hudImageBg, self.hudImageIcon ~= "")
			GetImageSpriteFromAtlasAsync("island/IslandHudIcon", "hud_main", self.hudImageBg)
			setImageColor(self.hudImageTF, Color.NewHex("78787a"))
		end
	end

	if var_12_0 ~= self.currentTaskType then
		self.currentTaskType = var_12_0

		local var_12_4 = IslandObjectTaskHudHelper.TaskProcessToHudIcon[var_12_0] or self.hudImageIcon

		setActive(self.hudImageBg, var_12_4 ~= "")

		if var_12_4 ~= "" then
			GetImageSpriteFromAtlasAsync("island/IslandHudIcon", var_12_4, self.hudImageTF)
		end
	end

	return
end

function IslandNormalHudPanel:Show()
	if not self._tf or self.active == true then
		return
	end

	self.active = true

	setActive(self._tf, true)

	for iter_13_0, iter_13_1 in ipairs({
		"hudImage",
		"title",
		"name"
	}) do
		self:SetTFActive(iter_13_1, true)
	end

	return
end

function IslandNormalHudPanel:Hide()
	if not self._tf then
		return
	end

	self.active = false

	for iter_14_0, iter_14_1 in ipairs({
		"hudImage",
		"title",
		"name"
	}) do
		self:SetTFActive(iter_14_1, false)
	end

	return
end

return IslandNormalHudPanel
