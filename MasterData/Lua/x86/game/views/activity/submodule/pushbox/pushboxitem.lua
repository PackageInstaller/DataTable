local PushBoxItem = class("PushBoxItem", ReduxView)

function PushBoxItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function PushBoxItem:Init()
	self:InitUI()
	self:AddUIListeners()
end

function PushBoxItem:InitUI()
	self:BindCfgUI()

	self.dirctMap_ = {
		"up",
		"right",
		"down",
		"left"
	}
	self.selectCon_ = ControllerUtil.GetController(self.transform_, "status")
end

function PushBoxItem:AddUIListeners()
	self:AddPressByTimeListener(self.gameObject_, 0.1, function()
		manager.notify:Invoke(PUSH_BOX_SELECT, self.index_)
	end, function(arg_6_0, arg_6_1, arg_6_2)
		manager.notify:Invoke(PUSH_BOX_SELECT, self.index_)

		self.pressPos_ = arg_6_1.position
	end, function(arg_7_0, arg_7_1, arg_7_2)
		self.endPos_ = arg_7_1.position

		if self.dragFunc_ then
			self.dragFunc_(self.pressPos_, self.endPos_)
		end
	end, self.index_)
end

function PushBoxItem:OnEnter()
	return
end

function PushBoxItem:SetData(arg_9_1)
	self.isLock_ = false
	self.index_ = arg_9_1

	self:StopAni()
end

function PushBoxItem:SetPos(arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	self.dirct_ = 0
	self.coordinateX_ = arg_10_1
	self.coordinateY_ = arg_10_2
	self.transform_.localPosition = Vector3.New(arg_10_3, arg_10_4, self.transform_.localPosition.z)
end

function PushBoxItem:GetCoordinate()
	return self.coordinateX_, self.coordinateY_
end

function PushBoxItem:SetSelect(arg_12_1)
	self.selectCon_:SetSelectedState(arg_12_1 and "click" or "normal")

	if arg_12_1 then
		local var_12_0, var_12_1, var_12_2, var_12_3 = PushBoxTool:GetCanPassDir(self.index_)

		SetActive(self.uGo_, var_12_0)
		SetActive(self.dGo_, var_12_1)
		SetActive(self.lGo_, var_12_2)
		SetActive(self.rGo_, var_12_3)
	end
end

function PushBoxItem:StopAni()
	self.dirct_ = 0

	self.ani_:Play("idle", -1, 0)
end

function PushBoxItem:PlayDirct(arg_14_1)
	self.selectCon_:SetSelectedState("normal")

	if arg_14_1[1] == 0 and arg_14_1[2] == 1 then
		-- block empty
	elseif arg_14_1[1] == 1 and arg_14_1[2] == 0 then
		-- block empty
	elseif arg_14_1[1] == 0 and arg_14_1[2] == -1 then
		-- block empty
	elseif arg_14_1[1] == -1 and arg_14_1[2] == 0 then
		-- block empty
	end
end

function PushBoxItem:SetLock(arg_15_1)
	self.isLock_ = arg_15_1
end

function PushBoxItem:IsLock()
	return self.isLock_
end

function PushBoxItem:GetCoordinate()
	return self.coordinateX_, self.coordinateY_
end

function PushBoxItem:SetSize(arg_18_1)
	self.rect_.localScale = Vector2.New(arg_18_1 / self.transform_.rect.width, arg_18_1 / self.transform_.rect.width)
end

function PushBoxItem:RegistDragFunc(arg_19_1)
	self.dragFunc_ = arg_19_1
end

function PushBoxItem:OnExit()
	return
end

function PushBoxItem:Dispose()
	self:RemoveAllListeners()
	self.super.Dispose(self)
end

return PushBoxItem
