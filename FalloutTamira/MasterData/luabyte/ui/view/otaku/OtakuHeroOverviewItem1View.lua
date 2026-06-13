---自动生成代码----start----
local OtakuHeroOverviewItem1View = BaseClass( 'OtakuHeroOverviewItem1View' , BaseView )
local M = OtakuHeroOverviewItem1View 
--desc

function M:__init(go)
  local trans = go.transform 
  self.selectState =   self._binder:GetValue('selectState')  
  self.roleNumState =   self._binder:GetValue('roleNumState')  
  self.nameText = self:AddBaseCom( GameUIText ,'nameText')
  self.numText = self:AddBaseCom( GameUIText ,'numText')
  self.maxText = self:AddBaseCom( GameUIText ,'maxText')
  self.icon = self:AddBaseCom( GameUIImage ,'icon')
  self.liveSpace =   self:AddValue('','UI.View.Otaku.OtakuemployeeOverviewItemView','liveSpace')  


end

return OtakuHeroOverviewItem1View
---自动生成代码----end----