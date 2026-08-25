local UI_Bag_Panel_OptionalAppearance, Super = System.NewClass("UI_Bag_Panel_OptionalAppearance", UI_Bag_Panel_AppearancePreview)
UI_Bag_Panel_OptionalAppearance.uiResCls = UI_Bag_Panel_OptionalAppearanceResource

function UI_Bag_Panel_OptionalAppearance:IsFilterOwned()
  return true
end

function UI_Bag_Panel_OptionalAppearance:GetCollectionProgressText(_)
  return ""
end

return UI_Bag_Panel_OptionalAppearance
