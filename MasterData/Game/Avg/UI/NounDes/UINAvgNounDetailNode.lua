local UINAvgNounDetailNode = class("UINAvgNounDetailNode", UIBaseNode)
local base = UIBaseNode
local CS_ResLoader = CS.ResLoader

function UINAvgNounDetailNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_expand, self, self.ExpandAvgNoun)
  UIUtil.AddButtonListener(self.ui.btn_Unfold, self, self.OnBtnUnflodClick)
  UIUtil.AddButtonListener(self.ui.btn_Fold, self, self.OnBtnFlodClick)
  self.height = self.transform.sizeDelta.y
end

function UINAvgNounDetailNode:InitInfo(nounId)
  self.nounCfg = ConfigData.noun_des[nounId]
  self.ui.tex_Title.text = LanguageUtil.GetLocaleText(self.nounCfg.name)
  self.ui.tex_Content.text = LanguageUtil.GetLocaleText(self.nounCfg.des)
  if string.IsNullOrEmpty(self.nounCfg.picture) == false then
    self.ui.obj_pic:SetActive(true)
    if self.resloader ~= nil then
      self.resloader:Put2Pool()
      self.resloader = nil
    end
    if self.nounCfg.picture_type ~= nil and self.nounCfg.picture_type == 0 then
      self.ui.Layout_pic.minHeight = 524
    elseif self.nounCfg.picture_type == 1 then
      self.ui.Layout_pic.minHeight = 396
    end
    self.resloader = CS_ResLoader.Create()
    self.resloader:LoadABAssetAsync(PathConsts:GetAvgNounImgPath(self.nounCfg.picture), function(texture)
      self.ui.img_Pic.texture = texture
    end)
  else
    self.ui.obj_pic:SetActive(false)
  end
  self.ui.scroll:StopMovement()
  self.ui.scroll.content.anchoredPosition = Vector2.zero
end

function UINAvgNounDetailNode:ExpandAvgNoun()
  local avgnounwindow = UIManager:GetWindow(UIWindowTypeID.AvgNounDes)
  avgnounwindow:OnClickExpand()
  self.ui.btn_expand.gameObject:SetActive(false)
end

function UINAvgNounDetailNode:OnBtnUnflodClick()
  self.transform.sizeDelta = Vector2.New(self.ui.int_unFold, self.height)
  self:_ShowFlodBtnActive(true)
end

function UINAvgNounDetailNode:OnBtnFlodClick()
  self.transform.sizeDelta = Vector2.New(self.ui.int_fold, self.height)
  self:_ShowFlodBtnActive(false)
end

function UINAvgNounDetailNode:_ShowFlodBtnActive(isFlod)
  self.ui.btn_Unfold.gameObject:SetActive(not isFlod)
  self.ui.btn_Fold.gameObject:SetActive(isFlod)
end

function UINAvgNounDetailNode:OnDelete()
  base.OnDelete(self)
end

return UINAvgNounDetailNode
