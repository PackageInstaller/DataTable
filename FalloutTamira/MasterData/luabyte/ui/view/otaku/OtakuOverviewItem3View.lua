---自动生成代码----start----
local OtakuOverviewItem3View = BaseClass( 'OtakuOverviewItem3View' , BaseView )
local M = OtakuOverviewItem3View 
--desc

function M:__init(go)
  local trans = go.transform 
  self.selectState =   self._binder:GetValue('selectState')  
  self.roleNumState =   self._binder:GetValue('roleNumState')  
  self.nameText = self:AddBaseCom( GameUIText ,'nameText')
  self.numText = self:AddBaseCom( GameUIText ,'numText')
  self.maxText = self:AddBaseCom( GameUIText ,'maxText')
  self.icon = self:AddBaseCom( GameUIImage ,'icon')
  self.item =   self:AddValue('UI.Ctrl.Otaku.OtakuOverviewItemHeroCtrl','UI.View.Otaku.OtakuOverviewItemHeroView','item')  
  self.clickBtn =   self._binder:GetValue('clickBtn')  
  self.OtakuemployeeOverviewItem1 =   self:AddValue('UI.Ctrl.Otaku.OtakuOverviewItemHeroCtrl','UI.View.Otaku.OtakuOverviewItemHeroView','OtakuemployeeOverviewItem1')  
  self.OtakuemployeeOverviewItem2 =   self:AddValue('UI.Ctrl.Otaku.OtakuOverviewItemHeroCtrl','UI.View.Otaku.OtakuOverviewItemHeroView','OtakuemployeeOverviewItem2')  


end

return OtakuOverviewItem3View
---自动生成代码----end----