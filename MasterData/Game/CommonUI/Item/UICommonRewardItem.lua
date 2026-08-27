local UICommonRewardItem = class("UICommonRewardItem", UIBaseNode)
local base = UIBaseNode
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")
local cs_DoTween = CS.DG.Tweening.DOTween
local cs_LoopTypeYoyo = CS.DG.Tweening.LoopType.Yoyo
local CS_CanvasGroup = CS.UnityEngine.CanvasGroup

function UICommonRewardItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.baseItem = UINBaseItemWithCount.New()
  self.baseItem:Init(self.ui.obj_BaseItemWithCount)
  local obj = self.ui.obj_BaseItemWithCount:Instantiate(self.ui.obj_BaseItemWithCount.transform.parent)
  self.convertItemPool = UIItemPool.New(UINBaseItemWithCount, obj, false)
end

function UICommonRewardItem:SetIsConvertHeroFrag()
  self._isConvertHeroFrag = true
end

function UICommonRewardItem:SetItemTranNum(num)
  self._itemTransNum = num
end

function UICommonRewardItem:SetCommonRewardItemCustomTrans(extraIds, extraNums)
  self.__extraIds = extraIds
  self.__extraNums = extraNums
end

function UICommonRewardItem:SetItemNameShow(isShow)
  self.ui.tex_ItemName.gameObject:SetActive(isShow)
end

function UICommonRewardItem:LoopRecycleInit()
  if self.tweenSeq ~= nil then
    self.tweenSeq:Kill()
    self.tweenSeq = nil
  end
  local component = self.baseItem.gameObject:GetComponent(typeof(CS_CanvasGroup))
  if not IsNull(component) then
    component.alpha = 1
  end
  self.convertItemPool:HideAll()
end

function UICommonRewardItem:InitCommonRewardItem(itemCfg, rewardNum, heroIdSnapshoot, clickEvent)
  self:LoopRecycleInit()
  if itemCfg == nil then
    return
  end
  self.itemCfg = itemCfg
  self.baseItem:InitItemWithCount(itemCfg, rewardNum, clickEvent)
  self.baseItem:SetNotNeedAnyJump(true)
  self.ui.tex_ItemName.gameObject:SetActive(true)
  self.ui.tex_ItemName.text = tostring(LanguageUtil.GetLocaleText(itemCfg.name))
  local hasHero = false
  local heroId = itemCfg.heroId
  if heroId ~= nil and heroIdSnapshoot ~= nil then
    hasHero = heroIdSnapshoot[heroId] and true or false
  end
  local canTrans, extraIds
  local extraNums = false
  if self.__extraIds ~= nil then
    canTrans = true
    extraIds = self.__extraIds
    extraNums = self.__extraNums
  end
  if not canTrans then
    canTrans, extraIds, extraNums = self:__HeroTrans(itemCfg, hasHero, heroId)
  end
  if not canTrans then
    canTrans, extraIds, extraNums = self:__ItemTrans(itemCfg)
  end
  if not canTrans then
    return
  end
  local itemList = {
    self.baseItem
  }
  for k, id in ipairs(extraIds) do
    local num = extraNums[k]
    local itemCfg = ConfigData.item[id]
    if itemCfg == nil then
      error("Cant get itemCfg, id = " .. tostring(id))
    else
      local item = self.convertItemPool:GetOne(true)
      item:InitItemWithCount(itemCfg, num)
      item.transform:SetAsFirstSibling()
      table.insert(itemList, item)
      self.ui.tex_ItemName.text = tostring(LanguageUtil.GetLocaleText(itemCfg.name))
    end
  end
  self:_PlayTween(itemList)
end

function UICommonRewardItem:__HeroTrans(itemCfg, hasHero, heroId)
  if itemCfg.type ~= eItemType.HeroCard or not hasHero then
    return false
  end
  local heroData = PlayerDataCenter:GetHeroData(heroId)
  local rankCfg = ConfigData.hero_rank[heroData.heroCfg.rank]
  if rankCfg == nil then
    error("Can't find rankCfg, id = " .. tostring(heroId))
    return false
  end
  if self._isConvertHeroFrag then
    return true, {
      heroData.fragId
    }, {
      rankCfg.repeat_frag_trans
    }
  end
  return true, rankCfg.repeat_extra_trans_id, rankCfg.repeat_extra_trans_num
end

function UICommonRewardItem:__ItemTrans(itemCfg)
  if self._itemTransNum then
    local trans_id = {}
    local trans_num = {}
    local transPara = {}
    if itemCfg.overflow_type == eItemTransType.actItemOverFlow then
      for index, value in ipairs(itemCfg.overflow_para) do
        if index % 3 ~= 1 then
          table.insert(transPara, value)
        end
      end
    else
      transPara = itemCfg.overflow_para
    end
    if not (#transPara % 2) == 0 then
      error("this overflow type has error para")
    end
    for i, v in ipairs(transPara) do
      if i % 2 == 1 then
        table.insert(trans_id, v)
      else
        table.insert(trans_num, v * self._itemTransNum)
      end
    end
    return true, trans_id, trans_num
  end
  return false
end

function UICommonRewardItem:BindRewardItemAthUid(uid)
  self.baseItem:BindAthItemUid(uid)
end

function UICommonRewardItem:BindRewardClickCustomArg(arg)
  self.baseItem:BindClickCustomArg(arg)
end

function UICommonRewardItem:BindRewardResloader(resloader)
  self.baseItem:BindBaseItemResloader(resloader)
end

function UICommonRewardItem:_PlayTween(itemList)
  if self.tweenSeq ~= nil then
    self.tweenSeq:Kill()
    self.tweenSeq = nil
  end
  local tweenSeq = cs_DoTween.Sequence()
  for index, item in ipairs(itemList) do
    if item.fade == nil then
      item.fade = item.gameObject:AddComponent(typeof(CS_CanvasGroup))
      item.fade.alpha = 1
    else
      item.fade.alpha = 1
    end
    if index == 1 then
      tweenSeq:Append(item.fade:DOFade(0, 0.9):SetDelay(0.9))
    else
      tweenSeq:Join(item.fade:DOFade(0, 0.9):From():SetDelay(index * 0.35))
    end
  end
  tweenSeq:SetLoops(-1, cs_LoopTypeYoyo)
  self.tweenSeq = tweenSeq
end

function UICommonRewardItem:OnDelete()
  if self.tweenSeq ~= nil then
    self.tweenSeq:Kill()
    self.tweenSeq = nil
  end
  base.OnDelete(self)
end

return UICommonRewardItem
