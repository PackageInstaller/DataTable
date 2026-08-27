local UIDormDetail = class("UIDormDetail", UIBaseWindow)
local base = UIBaseWindow
local DormDetailDataUtil = require("Game.Dorm.DUI.Detail.DormDetailDataUtil")
local cs_ResLoader = CS.ResLoader

function UIDormDetail:OnInit()
  UIUtil.SetTopStatus(self, self.Delete, nil, nil, nil, true)
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self.CloseDormDetail)
  UIUtil.AddButtonListener(self.ui.btn_background, self, self.CloseDormDetail)
  self.resloader = cs_ResLoader.Create()
end

function UIDormDetail:InitDormDetail(fntData, isTheme)
  self.fntData = fntData
  self.isTheme = isTheme
  DormDetailDataUtil:SetDataIsTheme(isTheme, fntData)
  self:RefreshDormDetailTag()
  local haveBigRoom = DormDetailDataUtil:GetIsBigRoom()
  self.ui.img_OnlyBig:SetActive(haveBigRoom)
  self:RefreshDormDetailIcon()
  local comfortNum = DormDetailDataUtil:GetFntComfort()
  self.ui.obj_comfortLv:SetActive(comfortNum ~= 0)
  self.ui.tex_Comfort.text = tostring(comfortNum)
  local name = DormDetailDataUtil:GetFntName()
  self.ui.tex_Name.text = name
  local des = DormDetailDataUtil:GetFntDes()
  self.ui.tex_Des.text = des
  local tagId, themeTagName = DormDetailDataUtil:GetThemeName()
  self.ui.tex_CatTag:SetIndex(tagId, themeTagName)
end

function UIDormDetail:RefreshDormDetailTag()
  local haveTag, tagId = DormDetailDataUtil:GetFntTag()
  self.ui.img_Tag.gameObject:SetActive(haveTag)
  if not haveTag then
    return
  end
  if tagId == 0 then
    self.ui.img_Tag.color = self.ui.tagColorList[1]
    self.ui.tex_Tag:SetIndex(0)
  else
    self.ui.img_Tag.color = self.ui.tagColorList[2]
    self.ui.tex_Tag:SetIndex(1)
  end
end

function UIDormDetail:RefreshDormDetailIcon()
  local iconPath = DormDetailDataUtil:GetFntIconPath()
  self.ui.furnitureThemeHolder:SetActive(self.isTheme)
  self.ui.furniturePicHolder:SetActive(not self.isTheme)
  if self.isTheme then
    self.ui.img_themeIcon.enabled = false
    self.resloader:LoadABAssetAsync(iconPath, function(texture)
      if IsNull(texture) then
        return
      end
      self.ui.img_themeIcon.texture = texture
      self.ui.img_themeIcon.enabled = true
    end)
  else
    self.ui.img_fntIcon.sprite = CRH:GetSprite(iconPath)
  end
end

function UIDormDetail:CloseDormDetail()
  UIUtil.OnClickBackByWinId(UIWindowTypeID.DormItemDetail)
end

function UIDormDetail:OnDelete()
  base.OnDelete(self)
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
end

return UIDormDetail
