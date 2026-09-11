local TransitionSkillListTabModule = class("TransitionSkillListTabModule", ReduxView)

function TransitionSkillListTabModule:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function TransitionSkillListTabModule:Init()
	self:BindCfgUI()
	self:BuildContext()
	self:AddUIListener()
end

function TransitionSkillListTabModule:BuildContext()
	self.controller = {
		comps = self.tabController_,
		tab = {
			comps = self.tabController_:GetController("pos")
		}
	}
	self.constVar = {
		tabPrefix = "tab%dBtn_"
	}
	self.data = {
		tabIdx = -1
	}
end

function TransitionSkillListTabModule:AddUIListener()
	for iter_4_0 = 1, 6 do
		self:AddBtnListener(self[string.format(self.constVar.tabPrefix, iter_4_0)], nil, function()
			if self.data.tabIdx == iter_4_0 then
				return
			end

			self:OnTabClick(iter_4_0)
		end)
	end
end

function TransitionSkillListTabModule:RegisterClickCallback(arg_6_1)
	self.data.clickCallback = arg_6_1
end

function TransitionSkillListTabModule:OnTabClick(arg_7_1)
	self.data.tabIdx = arg_7_1

	self.controller.tab.comps:SetSelectedState(tostring(arg_7_1))

	if self.data.clickCallback then
		self.data.clickCallback(arg_7_1)
	end
end

function TransitionSkillListTabModule:OnDispose()
	self:RemoveAllListeners()
	TransitionSkillListTabModule.super.Dispose(self)
end

return TransitionSkillListTabModule
