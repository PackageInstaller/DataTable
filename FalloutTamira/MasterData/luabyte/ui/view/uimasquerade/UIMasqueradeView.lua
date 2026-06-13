---自动生成代码----start----
local UIMasqueradeView = BaseClass( 'UIMasqueradeView' , BaseView )
local M = UIMasqueradeView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.btnBack = self:AddBaseCom( UINewButton ,'btnBack')
  self.btnShop = self:AddBaseCom( GameUIImage ,'btnShop')
  self.btnBattle1 = self:AddBaseCom( GameUIImage ,'btnBattle1')
  self.btnBattle2 = self:AddBaseCom( GameUIImage ,'btnBattle2')
  self.btnShow = self:AddBaseCom( GameUIImage ,'btnShow')
  self.btnGift = self:AddBaseCom( GameUIImage ,'btnGift')
  self.btnReward = self:AddBaseCom( GameUIImage ,'btnReward')
  self.labStartDay = self:AddBaseCom( GameUIText ,'labStartDay')
  self.labStartTimer = self:AddBaseCom( GameUIText ,'labStartTimer')
  self.labEndDay = self:AddBaseCom( GameUIText ,'labEndDay')
  self.labEndTimer = self:AddBaseCom( GameUIText ,'labEndTimer')
  self.labTips1 = self:AddBaseCom( GameUIText ,'labTips1')
  self.labTips2 = self:AddBaseCom( GameUIText ,'labTips2')
  self.battle2State =   self._binder:GetValue('battle2State')  
  self.redPoint =   self._binder:GetValue('redPoint')  
  self.rewardRedPoint =   self._binder:GetValue('rewardRedPoint')  
  self.VideoPlayerPlayFromStreamingAssets =   self._binder:GetValue('VideoPlayerPlayFromStreamingAssets')  
  self.btnSkip = self:AddBaseCom( UIButton ,'btnSkip')
  self.btnTips = self:AddBaseCom( GameUIImage ,'btnTips')


end

return UIMasqueradeView
---自动生成代码----end----