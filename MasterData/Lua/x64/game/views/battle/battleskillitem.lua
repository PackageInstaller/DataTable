local BattleSkillItem = class("BattleSkillItem", ReduxView)
local HeroConst = import("game.const.HeroConst")

function BattleSkillItem:OnCtor(arg_1_1, arg_1_2, arg_1_3)
	self.gameObject_ = arg_1_2
	self.transform_ = arg_1_2.transform
	self.info_ = arg_1_3

	SetActive(self.gameObject_, true)
	self:InitUI()
	self:Init()
end

function BattleSkillItem:RefreshData(arg_2_1, arg_2_2)
	self.data_ = arg_2_1
	self.info_ = arg_2_2

	self:Render()
end

function BattleSkillItem:InitUI()
	self.typeIcon_ = self:FindCom(typeof(Image), "type")
	self.lvText_ = self:FindCom(typeof(Text), "level")
	self.nameText_ = self:FindCom(typeof(Text), "name")
	self.desText_ = self:FindCom(typeof(Text), "des")
end

function BattleSkillItem:Init()
	self:RefreshUI(self.info_)
end

function BattleSkillItem:Dispose()
	BattleSkillItem.super.Dispose(self)
end

function BattleSkillItem:Render()
	self:RefreshUI(self.info_)
end

function BattleSkillItem:RefreshUI(arg_7_1)
	self.lvText_.text = "LEVEL " .. (arg_7_1.lv or 1)
end

return BattleSkillItem
