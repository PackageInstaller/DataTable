_class("UIHomelandStoryTaskActionPointDetail", UIController)
UIHomelandStoryTaskActionPointDetail = UIHomelandStoryTaskActionPointDetail

function UIHomelandStoryTaskActionPointDetail:Constructor()
end

function UIHomelandStoryTaskActionPointDetail:LoadDataOnEnter(TT, res, uiParams)
end

function UIHomelandStoryTaskActionPointDetail:OnShow(uiParams)
  self:_GetComponents()
  self:Refresh()
end

function UIHomelandStoryTaskActionPointDetail:_GetComponents()
end

function UIHomelandStoryTaskActionPointDetail:OnHide()
end

function UIHomelandStoryTaskActionPointDetail:Refresh()
end

function UIHomelandStoryTaskActionPointDetail:CloseBtnOnClick(go)
  self:CloseDialog()
end
