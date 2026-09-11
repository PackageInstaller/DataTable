local ReserveSequentialContDataTemplate = class("ReserveSequentialContDataTemplate", (import("game.reserve.ReserveContDataTemplate")))

function ReserveSequentialContDataTemplate:SetAffix(arg_1_1, arg_1_2, arg_1_3)
	if self.team_dic[arg_1_1] then
		self.team_dic[arg_1_1]:SetAffix(arg_1_2, arg_1_3)
	end
end

function ReserveSequentialContDataTemplate:SetAffixList(arg_2_1, arg_2_2)
	if self.team_dic[arg_2_1] then
		self.team_dic[arg_2_1]:SetAffixList(arg_2_2)
	end
end

function ReserveSequentialContDataTemplate:GetAffixList(arg_3_1)
	if self.team_dic[arg_3_1] then
		return self.team_dic[arg_3_1]:GetAffixList()
	else
		return {}
	end
end

return ReserveSequentialContDataTemplate
