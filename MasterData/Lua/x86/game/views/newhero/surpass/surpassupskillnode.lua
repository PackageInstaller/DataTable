local SurpassUpSkillNode = class("SurpassUpSkillNode", ReduxView)

function SurpassUpSkillNode:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitUI()
end

function SurpassUpSkillNode:InitUI()
	self:BindCfgUI()
end

function SurpassUpSkillNode:RefreshUi(arg_3_1, arg_3_2)
	self.texttittleText_.text = arg_3_2
	self.contentText_.text = arg_3_1[1]
end

function SurpassUpSkillNode:Dispose()
	SurpassUpSkillNode.super.Dispose(self)
end

return SurpassUpSkillNode
