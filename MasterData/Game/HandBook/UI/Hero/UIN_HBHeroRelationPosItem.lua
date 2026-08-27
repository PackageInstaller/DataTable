local UIN_HBHeroRelationPosItem = class("UIN_HBHeroRelationPosItem", UIBaseNode)
local base = UIBaseNode
local cs_DoTweenLoopType = CS.DG.Tweening.LoopType

function UIN_HBHeroRelationPosItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.__orgPos = self.transform.position
  self.__nearLine = self.ui.obj_relationship.transform:Find("Line_near").transform
  self.__farLine = self.ui.obj_relationship.transform:Find("Line_far").transform
  self.__relationship = self.ui.obj_relationship.transform:Find("Relationship").transform
  self.__end = self.ui.obj_line.transform:Find("End").transform
  self.__lineCG = self.ui.obj_line:GetComponent(typeof(CS.UnityEngine.CanvasGroup))
  self.__lineSmallSize = Vector2.New(0, self.ui.obj_line.transform.sizeDelta.y)
end

function UIN_HBHeroRelationPosItem:InitHBRHHead(index)
  self.index = index
  self.isRight = index <= 3
  self.isHorizontal = index == 2 or index == 5
  local flag = self.isRight and 1 or -1
  self.__farLine.anchoredPosition = Vector2.New(flag * 13, 0)
  self.__nearLine.anchoredPosition = Vector2.New(flag * -13, 0)
end

function UIN_HBHeroRelationPosItem:HideAll()
  self.ui.obj_ray:SetActive(false)
  self.ui.obj_line:SetActive(false)
  self.heroHeadItem = nil
end

function UIN_HBHeroRelationPosItem:SetHeroHead(heroHeadItem, cfg, mainHeroId)
  self.heroId = cfg.related_hero
  self.mainHeroId = mainHeroId
  self.heroHeadItem = heroHeadItem
  self.cfg = cfg
  self.ui.obj_ray:SetActive(true)
  self.ui.obj_line:SetActive(true)
  self:__AdjustRay()
  heroHeadItem.transform:SetParent(self.transform, false)
  heroHeadItem.transform.localPosition = Vector3.zero
end

function UIN_HBHeroRelationPosItem:__AdjustLine2Center()
  local fullSzie = self.ui.obj_line.transform.sizeDelta
  local relationSize = self.__relationship.sizeDelta
  local gap = 13
  local flag = self.isRight and 1 or -1
  if self.isHorizontal then
    self.__relationship.anchoredPosition = Vector2.New(flag * fullSzie.x / 2, 0)
    local lineLength = (fullSzie.x - relationSize.x) / 2 + gap
    local size = Vector2.New(lineLength, 32)
    self.__farLine.sizeDelta = size
    self.__nearLine.sizeDelta = size
  else
    self.__relationship.anchoredPosition = Vector2.New(flag * (fullSzie.x - 100), 0)
    self.__farLine.sizeDelta = Vector2.New(100 - relationSize.x / 2 + gap, 32)
    self.__nearLine.sizeDelta = Vector2.New(fullSzie.x - relationSize.x / 2 - 100 + gap, 32)
  end
end

function UIN_HBHeroRelationPosItem:__AdjustRay()
  local heroRelationDic = ConfigData.hero_relationship[self.heroId]
  if heroRelationDic == nil then
    self.ui.obj_ray:SetActive(false)
  end
  local isHaveOtherRelation = false
  for index, cfg in pairs(heroRelationDic) do
    if cfg.related_hero ~= self.mainHeroId then
      isHaveOtherRelation = true
      break
    end
  end
  self.ui.obj_ray:SetActive(isHaveOtherRelation)
end

function UIN_HBHeroRelationPosItem:PlayLineScale()
  self:__ClearTween()
  self.ui.obj_normal:SetActive(true)
  self.ui.obj_relationship:SetActive(false)
  self.ui.obj_line.transform:DOSizeDelta(self.__lineSmallSize, 0.5):From():OnComplete(function()
    local isHaveDes = self.cfg.line_des ~= nil and self.cfg.line_des ~= 0
    self.ui.obj_normal:SetActive(not isHaveDes)
    self.ui.obj_relationship:SetActive(isHaveDes)
    if isHaveDes then
      self.ui.tex_Relationship.text = LanguageUtil.GetLocaleText(self.cfg.line_des)
      CS.UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.__relationship)
      self:__AdjustLine2Center()
      self.ui.obj_relationship.transform:DOScaleY(0.2, 0.2):From()
    end
  end)
  self.__end:DOLocalMoveX(0, 0.2):From():SetDelay(0.3)
  self.__lineCG:DOFade(0, 0.1):From():SetLoops(3, cs_DoTweenLoopType.Restart)
  self.ui.obj_ray.transform:DOScale(0, 0.3):From():SetDelay(0.5)
end

function UIN_HBHeroRelationPosItem:__ClearTween()
  self.ui.obj_line.transform:DOComplete()
  self.ui.obj_relationship.transform:DOComplete()
  self.__end:DOComplete()
  self.__lineCG:DOComplete()
  self.ui.obj_ray.transform:DOComplete()
end

function UIN_HBHeroRelationPosItem:OnDelete()
  self:__ClearTween()
  base.OnDelete(self)
end

return UIN_HBHeroRelationPosItem
