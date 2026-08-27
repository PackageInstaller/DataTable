local UICustomHeroSelect = class("UICustomHeroSelect", UIBaseWindow)
local base = UIBaseWindow
local UINCustomHeroSelectItem = require("Game.PayGift.UINCustomHeroSelectItem")
local cs_ResLoader = CS.ResLoader
local eSelfSelectGift = require("Game.PayGift.eSelfSelectGift")

function UICustomHeroSelect:OnInit()
  UIUtil.CreateNewTopStatusData(self):SetTopStatusBackAction(self.Delete):PushTopStatusDataToBackStack()
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self.OnClickBack)
  UIUtil.AddButtonListener(self.ui.btn_Cancle, self, self.OnClickBack)
  UIUtil.AddButtonListener(self.ui.btn_Confirm, self, self.OnClickConfirmSelect)
  self.__OnSelectHeroCallback = BindCallback(self, self.__OnSelectHero)
  self._resloader = cs_ResLoader.Create()
  self._itemDic = {}
  self.ui.scrollRect.onInstantiateItem = BindCallback(self, self.OnInstantiateItem)
  self.ui.scrollRect.onChangeItem = BindCallback(self, self.OnChangeItem)
  self.ui.tex_SkillName.text = ConfigData:GetTipContent(410)
  local itemInfos = ConfigData.game_config.customHeroGiftConvert
  self.ui.tex_HeadAttri.text = string.format(ConfigData:GetTipContent(411), tostring(itemInfos[2]), ConfigData:GetItemName(itemInfos[1]))
end

function UICustomHeroSelect:InitCustomHeroSelect(selfSelectCfg, selectHeroId, callback)
  self._callback = callback
  self._selectHeroId = selectHeroId
  self._heroCfgList = {}
  for _, id in ipairs(selfSelectCfg.param1) do
    local heroCfg = ConfigData.hero_data[id]
    if not heroCfg.is_locked then
      table.insert(self._heroCfgList, heroCfg)
    end
  end
  table.sort(self._heroCfgList, function(a, b)
    local aHas = PlayerDataCenter:ContainsHeroData(a.id)
    local bHas = PlayerDataCenter:ContainsHeroData(b.id)
    if aHas ~= bHas then
      return not aHas
    end
    if a.rank ~= b.rank then
      return a.rank > b.rank
    end
    return a.id > b.id
  end)
  self.ui.scrollRect.totalCount = #self._heroCfgList
  self.ui.scrollRect:RefillCells()
end

function UICustomHeroSelect:OnInstantiateItem(go)
  local item = UINCustomHeroSelectItem.New()
  item:Init(go)
  self._itemDic[go] = item
end

function UICustomHeroSelect:OnChangeItem(go, index)
  local item = self._itemDic[go]
  local heroCfg = self._heroCfgList[index + 1]
  item:InitCustomHeroItem(heroCfg, self.__OnSelectHeroCallback, self._resloader)
  item:RefreshCustomHeroState(self._selectHeroId)
end

function UICustomHeroSelect:__OnSelectHero(heroId)
  self._selectHeroId = heroId
  for k, v in pairs(self._itemDic) do
    v:RefreshCustomHeroState(heroId)
  end
end

function UICustomHeroSelect:OnClickConfirmSelect()
  if self._selectHeroId == nil then
    return
  end
  UIUtil.OnClickBackByUiTab(self)
  if self._callback ~= nil then
    self._callback(self._selectHeroId)
  end
end

function UICustomHeroSelect:OnClickBack()
  UIUtil.OnClickBackByUiTab(self)
end

function UICustomHeroSelect:OnDelete()
  base.OnDelete(self)
end

return UICustomHeroSelect
