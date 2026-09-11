local GuelGameSeclectItem = class("GuelGameSeclectItem", ReduxView)

function GuelGameSeclectItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:AddListeners()

	self.stateControlller = self.characterControllerexcollection_:GetController("state")
	self.selControlller = self.characterControllerexcollection_:GetController("sel")
end

function GuelGameSeclectItem:AddListeners()
	self:AddBtnListener(self.btn_, nil, function()
		if self.callback then
			self.callback()
		end
	end)
end

function GuelGameSeclectItem:SetData(arg_4_1)
	self.data = arg_4_1

	if arg_4_1.color then
		self.colorControlller:SetSelectedState(arg_4_1.color)
	else
		self.colorControlller:SetSelectedState("none")
	end
end

function GuelGameSeclectItem:OnEnter()
	return
end

function GuelGameSeclectItem:SetClickCallback(arg_6_1)
	self.callback = arg_6_1
end

function GuelGameSeclectItem:UpdateSelect(arg_7_1)
	self.selControlller:SetSelectedState(arg_7_1 and "on" or "off")
end

function GuelGameSeclectItem:UpdateCamp(arg_8_1)
	local var_8_0 = {
		"normal",
		"selectD",
		"selectM"
	}

	self.stateControlller:SetSelectedState((var_8_0[arg_8_1] or nil) and (var_8_0[arg_8_1] or var_8_0[1]))

	if arg_8_1 ~= 1 then
		self.ani_:Play("characterSelect", 0, 0)
	end
end

function GuelGameSeclectItem:OnExit()
	GuelGameSeclectItem.super.OnExit(self)
end

function GuelGameSeclectItem:Dispose()
	GuelGameSeclectItem.super.Dispose(self)
end

return GuelGameSeclectItem
