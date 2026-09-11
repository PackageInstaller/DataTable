DormInfomationModuleBase = import("game.views.dorm.DormView.Information.Module.DormInfomationModuleBase")

local DormInfomationCanteenModule = class("DormInfomationCanteenModule", DormInfomationModuleBase)

function DormInfomationCanteenModule:ModuleName()
	return "Widget/BackHouseUI/Dorm/item/Infomation/CanteenWeekPanel"
end

function DormInfomationCanteenModule:InitUI()
	self:BindCfgUI()
	self:AddListener()
end

function DormInfomationCanteenModule:AddListener()
	return
end

function DormInfomationCanteenModule:Show(arg_4_1)
	DormInfomationCanteenModule.super.Show(self, arg_4_1)

	local var_4_0 = DormInfomationData:GetParams(arg_4_1)

	if var_4_0[1] and var_4_0[1] ~= -1 then
		SetActive(self.heroHeadBtn2_, true)
		SetActive(self.noneHead2_, false)

		self.heroHeadIcon2_.spriteSync = "TextureConfig/BackHouseUI/RoleHead/" .. var_4_0[1]
	else
		SetActive(self.heroHeadBtn2_, false)
		SetActive(self.noneHead2_, true)
	end

	self.mostSale_.text = var_4_0[2] and var_4_0[2] ~= -1 and BackHomeCanteenFoodCfg[var_4_0[2]].name or GetTips("NONE")
	self.varietyCnt_.text = var_4_0[3] and var_4_0[3] ~= -1 and var_4_0[3] or GetTips("NONE")
	self.entrustCnt_.text = var_4_0[4] and var_4_0[4] ~= -1 and var_4_0[4] or GetTips("NONE")
	self.income_.text = var_4_0[5] and var_4_0[5] ~= -1 and var_4_0[5] or GetTips("NONE")

	if var_4_0[6] and var_4_0[6] ~= -1 then
		SetActive(self.heroHeadBtn_, true)
		SetActive(self.noneHead_, false)

		self.heroHeadIcon_.spriteSync = "TextureConfig/BackHouseUI/RoleHead/" .. var_4_0[6]
	else
		SetActive(self.heroHeadBtn_, false)
		SetActive(self.noneHead_, true)
	end

	self.charEntrustCnt_.text = var_4_0[7] and var_4_0[7] ~= -1 and var_4_0[7] or GetTips("NONE")
end

function DormInfomationCanteenModule:CanShow(arg_5_1)
	local var_5_0 = false
	local var_5_1 = DormInfomationData:GetParams(arg_5_1)

	if var_5_1[1] and var_5_1[1] ~= -1 then
		var_5_0 = true
	end

	if var_5_1[2] and var_5_1[2] ~= -1 then
		var_5_0 = true
	end

	if var_5_1[3] and var_5_1[3] ~= -1 then
		var_5_0 = true
	end

	if var_5_1[4] and var_5_1[4] ~= -1 then
		var_5_0 = true
	end

	if var_5_1[5] and var_5_1[5] ~= -1 then
		var_5_0 = true
	end

	if var_5_1[6] and var_5_1[6] ~= -1 then
		var_5_0 = true
	end

	return (var_5_1[7] and var_5_1[7] ~= -1 or nil) and true
end

function DormInfomationCanteenModule:Dispose()
	DormInfomationCanteenModule.super.Dispose(self)
end

return DormInfomationCanteenModule
