local SkillComboSubItem = class("SkillComboSubItem", ReduxView)

function SkillComboSubItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function SkillComboSubItem:Init()
	self:InitUI()
end

function SkillComboSubItem:InitUI()
	self:BindCfgUI()
end

function SkillComboSubItem:Show(arg_4_1)
	SetActive(self.gameObject_, arg_4_1)
end

function SkillComboSubItem:RefreshData(arg_5_1, arg_5_2, arg_5_3)
	self.icon_.sprite = getSprite("Atlas/" .. arg_5_2, arg_5_1.list_icon[arg_5_3])
	self.nameText_.text = GetI18NText(arg_5_1.list_name[arg_5_3])

	if #arg_5_1.list_icon ~= arg_5_3 then
		if arg_5_1.combine_char[arg_5_3] == "或" then
			self.signImg_.enabled = false
			self.signText_.text = GetTips("TIP_OR")

			SetActive(self.signText_.gameObject, true)
		else
			self.signImg_.enabled = true
			self.signImg_.sprite = getSprite("Atlas/SettingAtlas", arg_5_1.combine_char[arg_5_3])
			self.signText_.text = ""

			SetActive(self.signText_.gameObject, false)
		end
	else
		self.signImg_.enabled = false
		self.signText_.text = ""

		SetActive(self.signText_.gameObject, false)
	end
end

function SkillComboSubItem:Dispose()
	SkillComboSubItem.super.Dispose(self)
end

return SkillComboSubItem
