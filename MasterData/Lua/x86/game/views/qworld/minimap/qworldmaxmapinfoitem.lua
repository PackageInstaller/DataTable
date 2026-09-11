local QWorldMaxMapInfoItem = class("QWorldMaxMapInfoItem", ReduxView)

function QWorldMaxMapInfoItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
	self:AddListeners()
end

function QWorldMaxMapInfoItem:Init()
	self:BindCfgUI()

	self.trackController = self.m_controller:GetController("tracking")
	self.BgController = self.m_controller:GetController("bgstate")
	self.IconTypeController = self.m_iconController:GetController("type")
end

function QWorldMaxMapInfoItem:AddListeners()
	self:AddBtnListener(self.m_clickBtn, nil, function()
		if self.callback_ then
			self.callback_(self.board)
		end
	end)
end

function QWorldMaxMapInfoItem:SetData(arg_5_1, arg_5_2)
	self.board = arg_5_2

	local var_5_1 = false

	self.trackController:SetSelectedIndex(var_5_1 and 0 or 1)

	if var_5_1 then
		self.BgController:SetSelectedIndex(0)
	elseif arg_5_1 % 2 == 1 then
		self.BgController:SetSelectedIndex(2)
	else
		self.BgController:SetSelectedIndex(1)
	end

	self.m_title.text = self.board:GetName()

	local var_5_2, var_5_3 = arg_5_2:GetIcon()

	self.IconTypeController:SetSelectedIndex(var_5_3)

	self.m_icon.sprite = pureGetSpriteWithoutAtlas(var_5_2)

	self:UpdateRedPoint()
end

function QWorldMaxMapInfoItem:UpdateRedPoint()
	local var_6_0 = false

	if self.board.tag == QWorldEntityMiniMapTag.Hud then
		local var_6_1 = nullable(SandplayTagCfg, self.board.param, "activityId")

		if var_6_1 then
			var_6_0 = manager.redPoint:getTipBoolean(ActivityTools.GetRedPointKey(var_6_1) .. var_6_1)
		end
	end

	manager.redPoint:SetRedPointIndependent(self.transform_, var_6_0)
end

function QWorldMaxMapInfoItem:RegistCallBack(arg_7_1)
	self.callback_ = arg_7_1
end

return QWorldMaxMapInfoItem
