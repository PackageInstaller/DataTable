---自动生成代码----start----
local BeforeFavorStory = BaseClass( 'BeforeFavorStory' , BaseView )
local M = BeforeFavorStory 
--desc

function M:__init(go)
  local trans = go.transform 
  self.Story =   self._binder:GetValue('Story')  


end

return BeforeFavorStory
---自动生成代码----end----