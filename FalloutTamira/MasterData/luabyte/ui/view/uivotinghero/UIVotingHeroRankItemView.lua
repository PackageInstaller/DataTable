---自动生成代码----start----
local UIVotingHeroRankItemView = BaseClass( 'UIVotingHeroRankItemView' , BaseView )
local M = UIVotingHeroRankItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.tfBg1 =   self._binder:GetValue('tfBg1')  
  self.tfBg2 =   self._binder:GetValue('tfBg2')  
  self.tfBg =   self._binder:GetValue('tfBg')  
  self.imageBg = self:AddBaseCom( GameUIImage ,'imageBg')
  self.imageNum = self:AddBaseCom( GameUIImage ,'imageNum')
  self.textName = self:AddBaseCom( GameUIText ,'textName')
  self.textIndex = self:AddBaseCom( GameUIText ,'textIndex')
  self.textNum = self:AddBaseCom( GameUIText ,'textNum')
  self.btnTips = self:AddBaseCom( UIButton ,'btnTips')


end

return UIVotingHeroRankItemView
---自动生成代码----end----