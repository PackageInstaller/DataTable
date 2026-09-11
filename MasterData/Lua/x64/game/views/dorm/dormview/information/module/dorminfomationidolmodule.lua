DormInfomationModuleBase = import("game.views.dorm.DormView.Information.Module.DormInfomationModuleBase")

local DormInfomationIdolModule = class("DormInfomationIdolModule", DormInfomationModuleBase)

function DormInfomationIdolModule:ModuleName()
	return "Widget/BackHouseUI/Dorm/item/Infomation/IdolPanel"
end

function DormInfomationIdolModule:InitUI()
	self:BindCfgUI()
	self:AddListener()
end

function DormInfomationIdolModule:AddListener()
	return
end

function DormInfomationIdolModule:Show(arg_4_1)
	DormInfomationIdolModule.super.Show(self, arg_4_1)

	local var_4_0 = DormInfomationData:GetParams(arg_4_1)

	if var_4_0[1] and var_4_0[1] ~= -1 then
		SetActive(self.heroHeadObj_, true)

		self.heroHeadImg_.spriteSync = "TextureConfig/BackHouseUI/RoleHead/" .. var_4_0[1]
		self.heroInfo_.text = var_4_0[2]
	else
		SetActive(self.heroHeadObj_, false)

		self.heroInfo_.text = GetTips("NONE")
	end

	self.maxProperty_.text = var_4_0[3] ~= -1 and var_4_0[3] or GetTips("NONE")
	self.battleCnt_.text = var_4_0[4] ~= -1 and var_4_0[4] or GetTips("NONE")
	self.winCnt_.text = var_4_0[5] ~= -1 and var_4_0[5] or GetTips("NONE")
end

function DormInfomationIdolModule:Dispose()
	DormInfomationIdolModule.super.Dispose(self)
end

return DormInfomationIdolModule
