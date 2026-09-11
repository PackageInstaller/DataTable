local AreaBattleSelectItem = class("AreaBattleSelectItem", ReduxView)

function AreaBattleSelectItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function AreaBattleSelectItem:Init()
	self:InitUI()

	for iter_2_0 = 1, 3 do
		self:AddBtnListener(self["btn" .. iter_2_0 .. "_"], nil, function()
			if self.parent.canUsePoint == 0 and self.parent.selectList[self.data[iter_2_0]] ~= true then
				ShowTips("ACTIVITY_AREA_BATTLE_GAIN_POINTS_LACK")

				return
			end

			if self.parent.selectList[self.data[iter_2_0]] then
				self.parent.selectList[self.data[iter_2_0]] = nil

				self["controller" .. iter_2_0]:SetSelectedState("false")
			else
				self.parent.selectList[self.data[iter_2_0]] = true

				self["controller" .. iter_2_0]:SetSelectedState("true")
			end

			self.callBack()
		end)
	end
end

function AreaBattleSelectItem:InitUI()
	self:BindCfgUI()

	self.controller1 = self.controller1_:GetController("select")
	self.controller2 = self.controller2_:GetController("select")
	self.controller3 = self.controller3_:GetController("select")
end

function AreaBattleSelectItem:SetData(arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5, arg_5_6)
	self.index = arg_5_2
	self.data = arg_5_1.data
	self.type = arg_5_1.type
	self.callBack = arg_5_3
	self.parent = arg_5_4
	self.titleIndex = arg_5_5
	self.gameObject_.transform.sizeDelta = Vector2(arg_5_6.width, self.gameObject_.transform.sizeDelta.y)

	LayoutRebuilder.ForceRebuildLayoutImmediate(self.gameObject_.transform)
	self:UpdateView()
end

function AreaBattleSelectItem:Clear()
	self:UpdateView()
end

function AreaBattleSelectItem:UpdateView()
	self.titleTxt_.text = GetTips("ACTIVITY_AREA_BATTLE_AFFIX_DESC_" .. self.titleIndex)

	for iter_7_0, iter_7_1 in pairs(GameSetting.activity_area_battle_attack_type_tag.value) do
		if iter_7_1[1] == self.titleIndex then
			self.titleImage_.sprite = getSprite(self.titleIndex > 8 and "Atlas/SystemGroupAtlas" or "Atlas/Hero_arrtAtlas", iter_7_1[2])
		end
	end

	for iter_7_2 = 1, 3 do
		if self.data[iter_7_2] then
			SetActive(self["item" .. iter_7_2 .. "Go_"], true)

			self["item" .. iter_7_2 .. "Txt_"].text = TalentTreeCfg[self.data[iter_7_2]].desc
			self["item" .. iter_7_2 .. "Image_"].sprite = pureGetSpriteWithoutAtlas("TextureConfig/BuffIcon/" .. PublicBuffCfg[TalentTreeCfg[self.data[iter_7_2]].affix_id].icon)
			self["item" .. iter_7_2 .. "1Txt_"].text = TalentTreeCfg[self.data[iter_7_2]].desc
			self["item" .. iter_7_2 .. "1Image_"].sprite = pureGetSpriteWithoutAtlas("TextureConfig/BuffIcon/" .. PublicBuffCfg[TalentTreeCfg[self.data[iter_7_2]].affix_id].icon)
		else
			SetActive(self["item" .. iter_7_2 .. "Go_"], false)
		end

		self["controller" .. iter_7_2]:SetSelectedState("false")

		if self.parent.selectList[self.data[iter_7_2]] then
			self["controller" .. iter_7_2]:SetSelectedState("true")
		end
	end
end

function AreaBattleSelectItem:OnEnter()
	self:UpdateView()
end

function AreaBattleSelectItem:Dispose()
	AreaBattleSelectItem.super.Dispose(self)
	Object.Destroy(self.gameObject_)
end

return AreaBattleSelectItem
