---自动生成代码----start----
local MainPreheatActivityUIView = BaseClass( 'MainPreheatActivityUIView' , BaseView )
local M = MainPreheatActivityUIView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.img_pic = self:AddBaseCom( GameUIImage ,'img_pic')
  self.looplist = self:AddBaseCom( CircularScrollView ,'looplist')
  self.txt_actTime = self:AddBaseCom( GameUIText ,'txt_actTime')
  self.rectRight =   self._binder:GetValue('rectRight')  
  self.rectDown =   self._binder:GetValue('rectDown')  
  self.txt_name = self:AddBaseCom( GameUIText ,'txt_name')
  self.itemPfb =   self._binder:GetValue('itemPfb')  
  self.btn_award =   self._binder:GetValue('btn_award')  
  self.btn_supply =   self._binder:GetValue('btn_supply')  
  self.videoPlayer =   self._binder:GetValue('videoPlayer')  
  self.playState =   self._binder:GetValue('playState')  
  self.img_icon = self:AddBaseCom( GameUIImage ,'img_icon')
  self.txt_label = self:AddBaseCom( GameUIText ,'txt_label')


end

return MainPreheatActivityUIView
---自动生成代码----end----