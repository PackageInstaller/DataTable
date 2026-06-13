---自动生成代码----start----
local EncounterFriendHeroItemView = BaseClass( 'EncounterFriendHeroItemView' , BaseView )
local M = EncounterFriendHeroItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.heroItem =   self._binder:GetValue('heroItem')  
  self.select =   self._binder:GetValue('select')  
  self.numberText = self:AddBaseCom( GameUIText ,'numberText')
  self.same =   self._binder:GetValue('same')  
  self.friendName = self:AddBaseCom( GameUIText ,'friendName')
  self.btnFri = self:AddBaseCom( UIButton ,'btnFri')
  self.numBg = self:AddBaseCom( GameUIImage ,'numBg')
  self.lock =   self._binder:GetValue('lock')  


end

return EncounterFriendHeroItemView
---自动生成代码----end----