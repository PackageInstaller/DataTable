---自动生成代码----start----
local RankItemView = BaseClass( 'RankItemView' , BaseView )
local M = RankItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.playerName = self:AddBaseCom( GameUIText ,'playerName')
  self.rank = self:AddBaseCom( GameUIText ,'rank')
  self.topBg =   self._binder:GetValue('topBg')  
  self.normalBg =   self._binder:GetValue('normalBg')  
  self.top1 =   self._binder:GetValue('top1')  
  self.top2 =   self._binder:GetValue('top2')  
  self.top3 =   self._binder:GetValue('top3')  
  self.odd = self:AddBaseCom( GameUIImage ,'odd')
  self.even = self:AddBaseCom( GameUIImage ,'even')
  self.Star1 = self:AddBaseCom( GameUIImage ,'Star1')
  self.Star2 = self:AddBaseCom( GameUIImage ,'Star2')
  self.Star3 = self:AddBaseCom( GameUIImage ,'Star3')
  self.Star4 = self:AddBaseCom( GameUIImage ,'Star4')
  self.Star5 = self:AddBaseCom( GameUIImage ,'Star5')
  self.Star6 = self:AddBaseCom( GameUIImage ,'Star6')
  self.Star7 = self:AddBaseCom( GameUIImage ,'Star7')
  self.Star8 = self:AddBaseCom( GameUIImage ,'Star8')
  self.Star9 = self:AddBaseCom( GameUIImage ,'Star9')
  self.Star10 = self:AddBaseCom( GameUIImage ,'Star10')


end

return RankItemView
---自动生成代码----end----