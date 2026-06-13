---自动生成代码----start----
local HeadIconItemView = BaseClass('HeadIconItemView', BaseView)
local M = HeadIconItemView
--desc

function M:__init(go)
  local trans = go.transform
  self.HeadState = self._binder:GetValue('HeadState')
  self.HeadIcon = self:AddBaseCom(GameUIImage, 'HeadIcon')
  self.Select = self:AddBaseCom(GameUIImage, 'Select')


end

return HeadIconItemView
---自动生成代码----end----
