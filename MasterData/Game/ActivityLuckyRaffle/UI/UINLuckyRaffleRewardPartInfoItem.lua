local UINLuckyRaffleRewardPartInfoItem = class("UINLuckyRaffleRewardPartInfoItem", UIBaseNode)
local base = UIBaseNode

function UINLuckyRaffleRewardPartInfoItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINLuckyRaffleRewardPartInfoItem:InitLuckyRaffleRewardPartInfoItem(rewardPartData, resloader)
  self.rewardPartData = rewardPartData
  self.resloader = resloader
  self:RefreshRaffleRewardPartInfo()
end

function UINLuckyRaffleRewardPartInfoItem:RefreshRaffleRewardPartInfo()
  self.resloader:LoadABAssetAsync(PathConsts:GetLuckyRafflePicPath(self.rewardPartData.bgImage), function(texture)
    if IsNull(self.transform) then
      return
    end
    self.ui.img_Gift.texture = texture
  end)
  self.ui.tex_raffle_level.text = LanguageUtil.GetLocaleText(self.rewardPartData.level)
  self.ui.tex_raffle_title.text = LanguageUtil.GetLocaleText(self.rewardPartData.title)
  self.ui.tex_raffle_des.text = LanguageUtil.GetLocaleText(self.rewardPartData.des)
  self.ui.tex_raffle_num.text = LanguageUtil.GetLocaleText(self.rewardPartData.num)
end

return UINLuckyRaffleRewardPartInfoItem
