_class("UIN0CookHelper", Object)
UIN0CookHelper = UIN0CookHelper

function UIN0CookHelper.CheckRedPoint(campaign)
  local compInfo = UIN0CookData.GetCompInfoByCampaingn(campaign)
  if not compInfo then
    return false
  end
  return UIN0CookData.CheckRed_MatRequire(compInfo) or UIN0CookData.CheckRed_Collect(compInfo) or UIN0CookData.CheckRed_CookBook(compInfo) or UIN0CookData.CheckNew_CookBook(compInfo) or UIN0CookData.CheckRed_EndStory(compInfo) or UIN0CookData.CheckRed_FirstStory(compInfo)
end
