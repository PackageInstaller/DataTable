_class("UIXH1PointDetail", UIController)
UIXH1PointDetail = UIXH1PointDetail

function UIXH1PointDetail:OnShow(uiParams)
  self:InitWidget()
end

function UIXH1PointDetail:InitWidget()
end

function UIXH1PointDetail:blankOnClick(go)
  self:CloseDialog()
end
