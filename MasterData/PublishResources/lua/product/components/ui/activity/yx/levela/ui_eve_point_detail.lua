_class("UIEvePointDetail", UIController)
UIEvePointDetail = UIEvePointDetail

function UIEvePointDetail:OnShow(uiParams)
  self:InitWidget()
end

function UIEvePointDetail:InitWidget()
end

function UIEvePointDetail:closeBtnOnClick(go)
  self:CloseDialog()
end
