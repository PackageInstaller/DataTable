---自动生成代码----start----
local BossWarEndView = BaseClass( 'BossWarEndView' , BaseView )
local M = BossWarEndView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.txt_name = self:AddBaseCom( GameUIText ,'txt_name')
  self.txt_blood = self:AddBaseCom( GameUIText ,'txt_blood')
  self.img_hpBar = self:AddBaseCom( GameUIImage ,'img_hpBar')
  self.img_hpFill = self:AddBaseCom( GameUIImage ,'img_hpFill')
  self.txt_lNum = self:AddBaseCom( GameUIText ,'txt_lNum')
  self.txt_rNum = self:AddBaseCom( GameUIText ,'txt_rNum')


end

return BossWarEndView
---自动生成代码----end----