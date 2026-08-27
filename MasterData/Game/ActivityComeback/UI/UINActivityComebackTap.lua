local UINActivityCombackTap = class("UINActivityCombackTap", UIBaseNode)
local base = UIBaseNode

function UINActivityCombackTap:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_pageItem, self, self.__OnClickItem)
  self._defaultColorText = self.ui.tex_PageName.color
  self._defaultColorImg = self.ui.img_PageIcon.color
end

function UINActivityCombackTap:InitActivityCombackTap(activityFaramData, clickFunc, resloader)
  self._activityFaramData = activityFaramData
  self._clickFunc = clickFunc
  self.ui.tex_PageName.text = self._activityFaramData.name
  if self._activityFaramData.icon ~= nil then
    self.ui.img_PageIcon.enabled = false
    resloader:LoadABAssetAsync(PathConsts:GetAtlasAssetPath("UI_EventMain"), function(spriteAtlas)
      if spriteAtlas == nil then
        return
      end
      self.ui.img_PageIcon.sprite = AtlasUtil.GetResldSprite(spriteAtlas, self._activityFaramData.icon)
      self.ui.img_PageIcon.enabled = true
    end)
  end
end

function UINActivityCombackTap:RefreshCombackTapSelect(flag)
  self.ui.obj_Select:SetActive(flag)
  if flag then
    self.ui.tex_PageName.color = Color.white
    self.ui.img_PageIcon.color = Color.white
  else
    self.ui.tex_PageName.color = self._defaultColorText
    self.ui.img_PageIcon.color = self._defaultColorImg
  end
end

function UINActivityCombackTap:__OnClickItem()
  if self._clickFunc ~= nil then
    self._clickFunc(self._activityFaramData)
  end
end

function UINActivityCombackTap:GetActivityCombackData()
  return self._activityFaramData
end

function UINActivityCombackTap:SetComebackTabReddot(flag)
  self.ui.redDot:SetActive(flag)
end

return UINActivityCombackTap
