---自动生成代码----start----
local LimitBreakLimitSkillGroupItemView = BaseClass( 'LimitBreakLimitSkillGroupItemView' , BaseView )
local M = LimitBreakLimitSkillGroupItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.item1 =   self:AddValue('UI.Ctrl.Mission.limitChallge.LimitBreakLimitSkillItemCtrl','UI.View.Mission.LimitBreakLimitSkillItem','item1')  
  self.item2 =   self:AddValue('UI.Ctrl.Mission.limitChallge.LimitBreakLimitSkillItemCtrl','UI.View.Mission.LimitBreakLimitSkillItem','item2')  
  self.item3 =   self:AddValue('UI.Ctrl.Mission.limitChallge.LimitBreakLimitSkillItemCtrl','UI.View.Mission.LimitBreakLimitSkillItem','item3')  
  self.txt_select = self:AddBaseCom( GameUIText ,'txt_select')


end

return LimitBreakLimitSkillGroupItemView
---自动生成代码----end----