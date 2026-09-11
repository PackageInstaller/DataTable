local AbyssMonsterItemView = class("AbyssMonsterItemView", ReduxView)

function AbyssMonsterItemView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function AbyssMonsterItemView:Init()
	self:InitUI()
	self:AddUIListener()
end

function AbyssMonsterItemView:InitUI()
	self:BindCfgUI()
end

function AbyssMonsterItemView:AddUIListener()
	self:AddBtnListener(self.btn_, nil, function()
		if self.clickListener_ ~= nil then
			self.clickListener_()
		end
	end)
end

function AbyssMonsterItemView:AddEventListeners()
	return
end

function AbyssMonsterItemView:SetData(arg_7_1, arg_7_2)
	self.index_ = arg_7_1
	self.monsterId_ = arg_7_2
	self.abyssUICfg_ = AbyssUICfg[arg_7_2]

	self:UpdateView()
end

function AbyssMonsterItemView:UpdateView()
	self.bossImg_.sprite = pureGetSpriteWithoutAtlas(SpritePathCfg.CollectBoss.path .. self.abyssUICfg_.enemy_id)

	if self.abyssUICfg_ ~= nil then
		if self.abyssUICfg_.icon_pos ~= nil and self.abyssUICfg_.icon_pos ~= "" and #self.abyssUICfg_.icon_pos > 0 then
			self.bossImg_.transform.anchoredPosition = Vector3(self.abyssUICfg_.icon_pos[1], self.abyssUICfg_.icon_pos[2], self.abyssUICfg_.icon_pos[3])
		end

		if self.abyssUICfg_.icon_scale ~= nil and self.abyssUICfg_.icon_scale ~= "" and #self.abyssUICfg_.icon_scale > 0 then
			self.bossImg_.transform.localScale = Vector3(self.abyssUICfg_.icon_scale[1], self.abyssUICfg_.icon_scale[2], self.abyssUICfg_.icon_scale[3])
		end

		if self.abyssUICfg_.icon_rot ~= nil and self.abyssUICfg_.icon_rot ~= "" and #self.abyssUICfg_.icon_rot > 0 then
			self.bossImg_.transform.localEulerAngles = Vector3(self.abyssUICfg_.icon_rot[1], self.abyssUICfg_.icon_rot[2], self.abyssUICfg_.icon_rot[3])
		end
	end
end

function AbyssMonsterItemView:RegisterClickListener(arg_9_1)
	self.clickListener_ = arg_9_1
end

function AbyssMonsterItemView:OnEnter()
	self:AddEventListeners()
end

function AbyssMonsterItemView:OnExit()
	self:RemoveAllEventListener()
end

function AbyssMonsterItemView:OnMainHomeViewTop()
	return
end

function AbyssMonsterItemView:Dispose()
	self.data_ = nil
	self.clickListener_ = nil

	AbyssMonsterItemView.super.Dispose(self)
end

return AbyssMonsterItemView
