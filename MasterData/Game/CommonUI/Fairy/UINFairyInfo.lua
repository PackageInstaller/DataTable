local base = require("Game.CommonUI.FloatWin.UINFloatUINode")
local UINFairyInfo = class("UINFairyInfo", base)
local UINFairyAttrItem = require("Game.Fairy.UI.UINFairyAttrItem")
local UINFairySkillItem = require("Game.Fairy.UI.UINFairySkillItem")
local UINFairyQualityItem = require("Game.Fairy.UI.UINFairyQualityItem")
local UINFairySkillUpgradeItem = require("Game.Fairy.UI.UINFairySkillUpgradeItem")
local FloatAlignEnum = require("Game.CommonUI.FloatWin.FloatAlignEnum")
local HAType = FloatAlignEnum.HAType
local VAType = FloatAlignEnum.VAType
local CS_ResLoader = CS.ResLoader

function UINFairyInfo:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_collect, self, self._OnCliclCollect)
  UIUtil.AddButtonListener(self.ui.btn_closeSkillCard, self, self._OnClickCloseCardInfo)
  self.__onClickSkillCardItem = BindCallback(self, self.OnClickNormalSkillItem)
  self.skillItemPool = UIItemPool.New(UINFairySkillItem, self.ui.uINElfSkillItem, false)
  self.attrItemPool = UIItemPool.New(UINFairyAttrItem, self.ui.obj_attriItem)
  self.ui.obj_attriItem:SetActive(false)
  self.ui.img_star.gameObject:SetActive(false)
  self.starGoList = {}
  self.fairyQuality = UINFairyQualityItem.New()
  self.fairyQuality:Init(self.ui.img_Quality)
  self.resloader = CS_ResLoader.Create()
  self.skillCardItem = UINFairySkillUpgradeItem.New()
  self.skillCardItem:Init(self.ui.uINFairySkillCard)
  self.ui.btn_collect.gameObject:SetActive(false)
end

function UINFairyInfo:InitCommonFairyInfo(fairyData)
  self.ui.tex_ElfName.text = fairyData:GetFairyCurName()
  self.fairyQuality:InitFairyQualityItem(fairyData:GetCurFairyQuality())
  self.ui.tex_Lvl:SetIndex(0, tostring(fairyData:GetFairyCurLevel()))
  self:SetFairyStarUI(fairyData)
  self:RefreshFairyAttr(fairyData)
  self:RefreshFairySkill(fairyData)
  self:RefreshIsFavor(fairyData)
end

function UINFairyInfo:SetFairyStarUI(fairyData)
  if #self.starGoList == 0 then
    for i = 1, fairyData:GetMaxStar() do
      local go = self.ui.img_star.gameObject:Instantiate()
      go:SetActive(true)
      table.insert(self.starGoList, go)
    end
  end
  local count = fairyData:GetFairyCurStar()
  for i = 1, count do
    self.starGoList[i].gameObject:SetActive(true)
  end
  for i = count + 1, #self.starGoList do
    self.starGoList[i].gameObject:SetActive(false)
  end
end

function UINFairyInfo:RefreshFairyAttr(fairyData)
  local attrDic = fairyData:GetFairyAttrAdd()
  self.attrItemPool:HideAll()
  local attrAddList = {
    100,
    200,
    0
  }
  local totalAttrNum = 0
  for _, attrId in ipairs(ConfigData.attribute.baseAttrIds) do
    for _, add in ipairs(attrAddList) do
      local realAttrId = attrId + add
      local attrValue = attrDic[realAttrId]
      if attrValue ~= nil and 0 < attrValue then
        local attrItem = self.attrItemPool:GetOne()
        attrItem:InitHeroAttrItem(realAttrId, attrValue)
        totalAttrNum = totalAttrNum + 1
      end
      if 5 < totalAttrNum then
        warn("fairy attr above 5.")
        return
      end
    end
  end
end

function UINFairyInfo:RefreshFairySkill(fairyData)
  self.skillCardItem:Hide()
  self.skillItemPool:HideAll()
  local ultMaxSkillNum = fairyData:GetMaxStateSkillNum()
  for i = 1, ultMaxSkillNum do
    local skillData = fairyData:GetFairySkillBySlotIndex(i)
    if skillData ~= nil then
      local skillItem = self.skillItemPool:GetOne(true)
      skillItem:InitFairySkillItem(skillData, self.resloader, self.__onClickSkillCardItem)
    else
      local skillItem = self.skillItemPool:GetOne(true)
      skillItem:InitFairySkillItemEmpty(true)
    end
  end
end

function UINFairyInfo:OnClickNormalSkillItem(fairySkillData, isSelect, cardItem)
  self.skillCardItem:Show()
  self.skillCardItem:InitFairySkillUpgradeItem(fairySkillData, self.resloader)
  local parentTrans = cardItem.transform
  local vector3 = parentTrans:TransformPoint(Vector3.zero)
  local skillCardTrans = self.skillCardItem.transform
  skillCardTrans.position = vector3
  local xOffset = -skillCardTrans.sizeDelta.x / 2 - cardItem.transform.sizeDelta.x / 2
  skillCardTrans.anchoredPosition = Vector2.Temp(skillCardTrans.anchoredPosition.x - xOffset, skillCardTrans.anchoredPosition.y)
  self.ui.btn_closeSkillCard.gameObject:SetActive(true)
end

function UINFairyInfo:RefreshIsFavor(fairyData)
  if fairyData:GetIsFavouriteFairy() then
    self.ui.img_favorIcon.color = self.ui.color_favor
  else
    self.ui.img_favorIcon.color = self.ui.color_normal
  end
end

function UINFairyInfo:ShowCollectBtn(SetFavourFunc)
  self.ui.btn_collect.gameObject:SetActive(true)
  self.setFavourFunc = SetFavourFunc
end

function UINFairyInfo:_OnCliclCollect()
  if self.setFavourFunc ~= nil then
    self.setFavourFunc()
  end
end

function UINFairyInfo:SetCloseCardInfoSize(bgTransform)
  self.ui.btn_closeSkillCard.transform.pivot = bgTransform.pivot
  self.ui.btn_closeSkillCard.transform.position = bgTransform.position
  self.ui.btn_closeSkillCard.transform.sizeDelta = bgTransform.sizeDelta
end

function UINFairyInfo:_OnClickCloseCardInfo()
  if self.skillCardItem ~= nil then
    self.skillCardItem:Hide()
  end
  self.ui.btn_closeSkillCard.gameObject:SetActive(false)
end

function UINFairyInfo:OnDelete()
  self.skillItemPool:DeleteAll()
  self.attrItemPool:DeleteAll()
  self.starGoList = nil
  self.resloader:Put2Pool()
  self.resloader = nil
  base.OnDelete(self)
end

return UINFairyInfo
