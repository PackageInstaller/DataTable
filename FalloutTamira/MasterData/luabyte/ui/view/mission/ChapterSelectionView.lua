---自动生成代码----start----
local ChapterSelectionView = BaseClass( 'ChapterSelectionView' , BaseView )
local M = ChapterSelectionView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.node_loopList = self:AddBaseCom( CircularScrollView ,'node_loopList')
  self.resPanelCtrl =   self:AddValue('UI.Ctrl.Mission.ResourceChapterSelectionCtrl','UI.View.Mission.ResourceChapterSelectionView','resPanelCtrl')  
  self.img_banner = self:AddBaseCom( GameRawImage ,'img_banner')
  self.txt_cnName = self:AddBaseCom( GameUIText ,'txt_cnName')
  self.txt_enName = self:AddBaseCom( GameUIText ,'txt_enName')
  self.txt_desc = self:AddBaseCom( GameUIText ,'txt_desc')
  self.percentage = self:AddBaseCom( GameUIText ,'percentage')
  self.progsSlider = self:AddBaseCom( UISlider ,'progsSlider')
  self.tgl_main = self:AddBaseCom( UIToggle ,'tgl_main')
  self.tgl_hard = self:AddBaseCom( UIToggle ,'tgl_hard')
  self.tgl_resType = self:AddBaseCom( UIToggle ,'tgl_resType')
  self.lockMask =   self._binder:GetValue('lockMask')  
  self.battlePanel =   self._binder:GetValue('battlePanel')  
  self.btn_cptRwd =   self._binder:GetValue('btn_cptRwd')  
  self.cptRwdTitle = self:AddBaseCom( GameUIText ,'cptRwdTitle')
  self.cptRwdDesc = self:AddBaseCom( GameUIText ,'cptRwdDesc')
  self.cptItemPfb =   self._binder:GetValue('cptItemPfb')  
  self.redPoint =   self._binder:GetValue('redPoint')  
  self.mainDbTag =   self._binder:GetValue('mainDbTag')  
  self.tgl_encounter = self:AddBaseCom( UIToggle ,'tgl_encounter')
  self.bannerPoint =   self._binder:GetValue('bannerPoint')  
  self.resDbTag =   self._binder:GetValue('resDbTag')  
  self.mainRemain = self:AddBaseCom( GameUIText ,'mainRemain')
  self.resRemain = self:AddBaseCom( GameUIText ,'resRemain')
  self.typeGroup =   self._binder:GetValue('typeGroup')  
  self.tgl_bossWar = self:AddBaseCom( UIToggle ,'tgl_bossWar')
  self.tgl_limitChallge = self:AddBaseCom( UIToggle ,'tgl_limitChallge')


end

return ChapterSelectionView
---自动生成代码----end----