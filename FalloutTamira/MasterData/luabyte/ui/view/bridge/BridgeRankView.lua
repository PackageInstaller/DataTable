---自动生成代码----start----
local BridgeRankView = BaseClass( 'BridgeRankView' , BaseView )
local M = BridgeRankView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.playerName = self:AddBaseCom( GameUIText ,'playerName')
  self.playerID = self:AddBaseCom( GameUIText ,'playerID')
  self.myLv = self:AddBaseCom( GameUIText ,'myLv')
  self.pageContent =   self._binder:GetValue('pageContent')  
  self.rankContent =   self._binder:GetValue('rankContent')  
  self.rankItem =   self:AddValue('','UI.View.Bridge.RankItemView','rankItem')  
  self.lockMask =   self._binder:GetValue('lockMask')  
  self.noRank =   self._binder:GetValue('noRank')  
  self.rewardTip =   self._binder:GetValue('rewardTip')  
  self.tipPanel =   self._binder:GetValue('tipPanel')  
  self.tipCloseBtn =   self._binder:GetValue('tipCloseBtn')  
  self.tipsContent =   self._binder:GetValue('tipsContent')  
  self.circularScrollView = self:AddBaseCom( CircularScrollView ,'circularScrollView')
  self.scrollHelper =   self._binder:GetValue('scrollHelper')  
  self.rankTipItem =   self:AddValue('','UI.View.Bridge.RankTipItemView','rankTipItem')  
  self.Star1 =   self._binder:GetValue('Star1')  
  self.Star2 =   self._binder:GetValue('Star2')  
  self.Star3 =   self._binder:GetValue('Star3')  
  self.Star4 =   self._binder:GetValue('Star4')  
  self.Star5 =   self._binder:GetValue('Star5')  
  self.Star6 =   self._binder:GetValue('Star6')  
  self.Star7 =   self._binder:GetValue('Star7')  
  self.Star8 =   self._binder:GetValue('Star8')  
  self.Star9 =   self._binder:GetValue('Star9')  
  self.Star10 =   self._binder:GetValue('Star10')  


end

return BridgeRankView
---自动生成代码----end----