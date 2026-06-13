---自动生成代码----start----
local ResourceChapterSelectionView = BaseClass( 'ResourceChapterSelectionView' , BaseView )
local M = ResourceChapterSelectionView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.node_loop = self:AddBaseCom( CircularScrollView ,'node_loop')


end

return ResourceChapterSelectionView
---自动生成代码----end----