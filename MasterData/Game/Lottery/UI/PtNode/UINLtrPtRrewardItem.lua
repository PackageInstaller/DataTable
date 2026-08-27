local UINLtrPtRrewardItem = class("UINLtrPtRrewardItem", UIBaseNode)
local base = UIBaseNode
local cs_MessageCommon = CS.MessageCommon
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")

function UINLtrPtRrewardItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Exchange, self, self._OnClickExchange)
  self.ui.img_Star.gameObject:SetActive(false)
  self.starList = {}
end

function UINLtrPtRrewardItem:InitLtrPtRrewardItem(itemId, costNum, resLoader, exchangeFunc, ptNum, firstAwardId, firstAwardNum)
  local itemCfg = ConfigData.item[itemId]
  if itemCfg == nil then
    error("Can't find item, id = " .. tostring(itemId))
    return
  end
  local heroId
  if itemCfg.action_type == eItemActionType.HeroCard then
    heroId = itemCfg.arg[1]
  else
    error("Item is not hero, itemId = " .. tostring(itemId))
    return
  end
  self.itemId = itemId
  self.costNum = costNum
  self.firstAwardId = firstAwardId
  self.firstAwardNum = firstAwardNum
  self.enableExcange = costNum <= ptNum
  self.ui.img_ExchangeBtn.color = self.enableExcange and Color.white or Color.gray
  self.exchangeFunc = exchangeFunc
  self.ui.tex_Count.text = tostring(costNum)
  self.ui.has:SetActive(PlayerDataCenter.heroDic[heroId] ~= nil)
  local heroCfg = ConfigData.hero_data[heroId]
  self.heroCfg = heroCfg
  self.ui.tex_HeroName.text = LanguageUtil.GetLocaleText(heroCfg.name)
  local careerCfg = ConfigData.career[heroCfg.career]
  self.ui.img_Career.sprite = CRH:GetSprite(careerCfg.icon, CommonAtlasType.CareerCamp)
  local resCfg = ConfigData.resource_model[heroCfg.src_id]
  if resCfg == nil then
    error("resource model Cfg is null,id:" .. tostring(heroCfg.src_id))
    return
  end
  self.ui.img_Hero.enabled = false
  resLoader:LoadABAssetAsync(PathConsts:GetCharacterPicPath(resCfg.res_Name), function(texture)
    if IsNull(texture) then
      return
    end
    self.ui.img_Hero.texture = texture
    self.ui.img_Hero.enabled = true
  end)
  local rankCfg = ConfigData.hero_rank[heroCfg.rank]
  if rankCfg == nil then
    error("Can't find rankCfg, id = " .. tostring(heroCfg.rank))
  end
  self:__RefreshStar(rankCfg.star)
  self:__RefreshFirstAward()
end

function UINLtrPtRrewardItem:__RefreshStar(heroStar)
  for k, v in ipairs(self.starList) do
    v.gameObject:SetActive(false)
    v:SetIndex(0)
  end
  local count = math.ceil(heroStar / 2)
  local isHalf = heroStar % 2 == 1
  for i = 1, count do
    local star = self.starList[i]
    if star == nil then
      star = self.ui.img_Star:Instantiate()
      table.insert(self.starList, star)
    end
    star.gameObject:SetActive(true)
    if isHalf and i == count then
      star:SetIndex(1)
    end
  end
end

function UINLtrPtRrewardItem:__RefreshFirstAward()
  if self.firstAwardId == nil then
    self.ui.firstAward:SetActive(false)
    return
  end
  self.ui.firstAward:SetActive(true)
  if self.firstAwardItem == nil then
    self.firstAwardItem = UINBaseItemWithCount.New()
    self.firstAwardItem:Init(self.ui.uINBaseItemWithCount)
  end
  local firstAwardCfg = ConfigData.item[self.firstAwardId]
  self.firstAwardItem:InitItemWithCount(firstAwardCfg, self.firstAwardNum)
end

function UINLtrPtRrewardItem:_OnClickExchange()
  if not self.enableExcange then
    cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(10010))
    return
  end
  if self.exchangeFunc ~= nil then
    self.exchangeFunc(self.itemId, self.costNum, self.heroCfg, self.firstAwardId, self.firstAwardNum)
  end
end

function UINLtrPtRrewardItem:OnDelete()
  base.OnDelete(self)
end

return UINLtrPtRrewardItem
