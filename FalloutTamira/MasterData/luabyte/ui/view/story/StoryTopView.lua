---自动生成代码----start----
local StoryTopView = BaseClass( 'StoryTopView' , BaseView )
local M = StoryTopView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.stateAuto =   self._binder:GetValue('stateAuto')  
  self.stateFast =   self._binder:GetValue('stateFast')  
  self.rectSkip =   self._binder:GetValue('rectSkip')  
  self.rectTopBarPanel =   self._binder:GetValue('rectTopBarPanel')  
  self.txtFastSpeed = self:AddBaseCom( GameUIText ,'txtFastSpeed')
  self.rectFastMultipler =   self._binder:GetValue('rectFastMultipler')  
  self.rectReviewPanel =   self._binder:GetValue('rectReviewPanel')  
  self.rectReview =   self._binder:GetValue('rectReview')  
  self.rectReviewBack =   self._binder:GetValue('rectReviewBack')  
  self.rectHideUI =   self._binder:GetValue('rectHideUI')  
  self.scrollReview = self:AddBaseCom( LoopListView ,'scrollReview')
  self.tips =   self:AddValue('UI.Misc.KeyWordTipsCtrl','UI.View.KeywordTipsView','tips')  


end

return StoryTopView
---自动生成代码----end----