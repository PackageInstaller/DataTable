local base = UIBaseNode
local UINLtrSpecialSelectHero = class("UINLtrSpecialSelectHero", base)
local UINLtrSpeSelectHeroItem = require("Game.Lottery.UI.SpecialSelectHero.UINLtrSpeSelectHeroItem")
local LotteryEnum = require("Game.Lottery.LotteryEnum")
local cs_ResLoader = CS.ResLoader

function UINLtrSpecialSelectHero:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_SelectHero, self, self._OnClickSelectHero)
  self._heroItemPool = UIItemPool.New(UINLtrSpeSelectHeroItem, self.ui.heroItem, false)
  for i = 1, LotteryEnum.SpecialSelectHeroNum do
    local heroItem = self._heroItemPool:GetOne()
    heroItem.transform:SetParent(self.ui.heroPosList[i])
    heroItem.transform.anchoredPosition = Vector2.zero
  end
end

function UINLtrSpecialSelectHero:InitLtrSpecialSelectHeroNode(ltrData)
  if self._ltrData ~= ltrData then
    if self._resloader then
      self._resloader:Put2Pool()
      self._resloader = nil
    end
    self._resloader = cs_ResLoader.Create()
  end
  self._ltrData = ltrData
  self:_UpdHero()
end

function UINLtrSpecialSelectHero:_UpdHero()
  local itemList = self._ltrData:GetLtrSpeSelectedList()
  self.ui.btn_SelectHero.gameObject:SetActive(itemList == nil)
  for k, heroItem in ipairs(self._heroItemPool.listItem) do
    local itemId = itemList and itemList[k]
    local heroId = itemId and ConfigData:GetHeroIdByItem(itemId)
    heroItem:InitLtrSpeSelectHeroItem(heroId, self._resloader)
  end
end

function UINLtrSpecialSelectHero:_OnClickSelectHero()
  local function completeFunc()
    self:_UpdHero()
  end
  
  UIManager:ShowWindowAsync(UIWindowTypeID.LotterySpecialSelect, function(win)
    if win == nil then
      return
    end
    win:InitLtrSpecialSelectHeroWin(self._ltrData, completeFunc)
  end)
end

function UINLtrSpecialSelectHero:OnDelete()
  if self._resloader then
    self._resloader:Put2Pool()
    self._resloader = nil
  end
  self._heroItemPool:DeleteAll()
  base.OnDelete(self)
end

return UINLtrSpecialSelectHero
