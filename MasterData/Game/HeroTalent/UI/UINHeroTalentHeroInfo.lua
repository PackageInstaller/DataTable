local UINHeroTalentHeroInfo = class("UINHeroTalentHeroInfo", UIBaseNode)
local base = UIBaseNode
local CS_UnityEngine_GameObject = CS.UnityEngine.GameObject
local CS_LayoutRebuilder = CS.UnityEngine.UI.LayoutRebuilder
local UINStarUpAttrItem = require("Game.Hero.NewUI.UpgradeStar.UINStarUpAttrItem")
local UINHeroTalentNodeDetailEffect = require("Game.HeroTalent.UI.UINHeroTalentNodeDetailEffect")

function UINHeroTalentHeroInfo:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self._starList = {}
  table.insert(self._starList, self.ui.img_Star)
  self.ui.img_Star.gameObject:SetActive(false)
  self._effectPool = UIItemPool.New(UINHeroTalentNodeDetailEffect, self.ui.attItem)
  self.ui.attItem:SetActive(false)
  self.ui.total:SetActive(false)
  self.defalutAttriNodeHeight = self.ui.attriNode.minHeight
  self.defaultAddtionHeight = self.ui.attrititleRect.rect.height
end

function UINHeroTalentHeroInfo:UpdateHeroTalentHeroInfo(heroData)
  self._heroData = heroData
  self._talentNode = nil
  self._talent = nil
  self.ui.img_Career.sprite = CRH:GetSprite(heroData:GetCareerCfg().icon, CommonAtlasType.CareerCamp)
  self.ui.img_HeroPic.sprite = CRH:GetHeroSkinSprite(self._heroData.dataId, self._heroData.skinId)
  self.ui.tex_Name.text = self._heroData:GetName()
  self:RefreshHeroTalentHeroInfoUI()
end

function UINHeroTalentHeroInfo:SetHeroTalentNode(talentNode)
  self._talentNode = talentNode
  self._talent = nil
  self:__RefreshHeroTalentProcess()
  self:__RefreshTalentAddAttribute()
end

function UINHeroTalentHeroInfo:ShowHeroTalentAllAddtion(talentData)
  self._talent = talentData
  self._talentNode = nil
  self:__RefreshHeroTalentProcess()
  self:__RefreshTalentAddAttribute()
end

function UINHeroTalentHeroInfo:CancleHeroTalentShow()
  self._talentNode = nil
  self._talent = nil
  self:__RefreshHeroTalentProcess()
  self:__RefreshTalentAddAttribute()
end

function UINHeroTalentHeroInfo:RefreshHeroTalentHeroInfoUI()
  local starNum = self._heroData.rank // 2
  local half = self._heroData.rank % 2 == 1
  starNum = half and starNum + 1 or starNum
  for index, imgStar in ipairs(self._starList) do
    imgStar.gameObject:SetActive(0 < starNum)
    if 0 < starNum then
      imgStar:SetIndex(half and starNum == 1 and 1 or 0)
      starNum = starNum - 1
    end
  end
  for i = starNum, 1, -1 do
    local go = CS_UnityEngine_GameObject.Instantiate(self.ui.img_Star.gameObject, self.ui.img_Star.transform.parent)
    local img = go:GetComponent(typeof(CS.UiImageItemInfo))
    table.insert(self._starList, img)
    img:SetIndex(half and starNum == 1 and 1 or 0)
  end
  self.ui.tex_lv:SetIndex(0, tostring(self._heroData.level))
  self:__RefreshHeroTalentProcess()
  self:__RefreshTalentAddAttribute()
end

function UINHeroTalentHeroInfo:__RefreshHeroTalentProcess()
  self.ui.total:SetActive(self._talent ~= nil)
  if self._talent == nil then
    return
  end
  local curLv, totalLv = self._talent:GetHeroTalentTotalLevel()
  local stage, stageTex = ConfigData:GetTalentStage(curLv)
  local process = curLv / totalLv
  self.ui.total_Icon:SetIndex(stage - 1)
  self.ui.total_tex_curState.text = stageTex
  self.ui.total_tex_process:SetIndex(0, tostring(math.floor(process * 100)))
  self.ui.total_slider.value = process
end

function UINHeroTalentHeroInfo:__RefreshTalentAddAttribute()
  self.ui.attNode:SetActive(false)
  if self._talentNode ~= nil then
    self:__RefreshTalentNodeAttr()
  elseif self._talent ~= nil then
    self:__RefreshTalentAllAttr()
  end
  CS_LayoutRebuilder.ForceRebuildLayoutImmediate(self.ui.attriRect)
  local targetHeight = self.defaultAddtionHeight + self.ui.attriRect.rect.height
  targetHeight = math.min(targetHeight, self.defalutAttriNodeHeight)
  self.ui.attriNode.minHeight = targetHeight
end

function UINHeroTalentHeroInfo:__RefreshTalentNodeAttr()
  local attributeUpDic
  local flag, selctId = self._talentNode:GetHeroTalentNodeBranchId()
  if flag then
    attributeUpDic = self._talentNode:GetTalentNextLvBranchAttriDescrib()
    if attributeUpDic ~= nil then
      attributeUpDic = attributeUpDic[selctId]
    end
  else
    attributeUpDic = self._talentNode:GetTalentNextLvAttriDescrib()
  end
  if attributeUpDic == nil or table.count(attributeUpDic) == 0 then
    return
  end
  self.ui.tex_Tile:SetIndex(0)
  self.ui.attNode:SetActive(true)
  self._effectPool:HideAll()
  local talent = self._heroData:GetHeroDataTalent()
  if talent == nil then
    error("talent is nil")
    return
  end
  for attriId, info in pairs(attributeUpDic) do
    local attriCfg = ConfigData.attribute[attriId]
    local shoeAttriId = 0 < attriCfg.merge_attribute and attriCfg.merge_attribute or attriId
    local item = self._effectPool:GetOne()
    talent:SetSingleAttrBouns(attriId, -info.cur)
    local oriAttr = self._heroData:GetAttr(shoeAttriId, false, true)
    talent:SetSingleAttrBouns(attriId, info.cur)
    local nextAttr
    if info.next ~= nil then
      local diffVal = info.next - info.cur
      talent:SetSingleAttrBouns(attriId, diffVal)
      nextAttr = self._heroData:GetAttr(shoeAttriId, false, true)
      talent:SetSingleAttrBouns(attriId, -diffVal)
    else
      nextAttr = self._heroData:GetAttr(shoeAttriId, false, true)
    end
    item:RefreshDetailEffectByAttriId(shoeAttriId, oriAttr, nextAttr, false)
  end
end

function UINHeroTalentHeroInfo:__RefreshTalentAllAttr()
  local attributeUpDic = self._talent:GetAttributeAddtionAll()
  if attributeUpDic == nil or table.count(attributeUpDic) == 0 then
    return
  end
  self.ui.tex_Tile:SetIndex(1)
  self.ui.attNode:SetActive(true)
  self._effectPool:HideAll()
  local heroTalent = self._heroData:GetHeroDataTalent()
  self._heroData:BindHeroDataTalent(nil)
  local attriShowDic = {}
  for attriId, attriVal in pairs(attributeUpDic) do
    local attriCfg = ConfigData.attribute[attriId]
    local shoeAttriId = 0 < attriCfg.merge_attribute and attriCfg.merge_attribute or attriId
    if attriShowDic[shoeAttriId] == nil then
      attriShowDic[shoeAttriId] = self._heroData:GetAttr(attriId, false, true)
    end
  end
  self._heroData:BindHeroDataTalent(heroTalent)
  for attriId, attriVal in pairs(attriShowDic) do
    local item = self._effectPool:GetOne()
    local curAttr = self._heroData:GetAttr(attriId, false, true)
    local diffAttr = curAttr - attriVal
    item:RefreshDetailEffectByAttriId(attriId, diffAttr, nil, false)
  end
end

function UINHeroTalentHeroInfo:OnDelete()
  base.OnDelete(self)
end

return UINHeroTalentHeroInfo
