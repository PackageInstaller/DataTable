---自动生成代码----start----
local ComRoomUIView = BaseClass( 'ComRoomUIView' , BaseView )
local M = ComRoomUIView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.imgCom = self:AddBaseCom( GameUIImage ,'imgCom')
  self.imgChiefNote = self:AddBaseCom( GameUIImage ,'imgChiefNote')
  self.imgSurveyTask = self:AddBaseCom( GameUIImage ,'imgSurveyTask')
  self.imgStoryAtlas = self:AddBaseCom( GameUIImage ,'imgStoryAtlas')
  self.imgEncycAtlas = self:AddBaseCom( GameUIImage ,'imgEncycAtlas')
  self.imgHeroAtlas = self:AddBaseCom( GameUIImage ,'imgHeroAtlas')


end

return ComRoomUIView
---自动生成代码----end----