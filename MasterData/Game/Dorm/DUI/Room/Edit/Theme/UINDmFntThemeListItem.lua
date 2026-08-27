local base = UIBaseNode
local UINDmFntThemeListItem = class("UINDmFntThemeListItem", base)

function UINDmFntThemeListItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Root, self, self._OnClickRoot)
  UIUtil.AddButtonListener(self.ui.btn_Tip, self, self._OnClickTip)
end

function UINDmFntThemeListItem:InitDmFntThemeListItem(themeData, editRoomData, resLoader, clickFunc)
  self.themeData = themeData
  local fntThemeCfg = themeData.dmFntThemeCfg
  self._fntThemeCfg = fntThemeCfg
  self._clickFunc = clickFunc
  local iconPath = PathConsts:GetDormFntThemeIconPath(fntThemeCfg.theme_pic)
  self.ui.img_Icon.enabled = false
  resLoader:LoadABAssetAsync(iconPath, function(texture)
    if IsNull(texture) then
      return
    end
    self.ui.img_Icon.texture = texture
    self.ui.img_Icon.enabled = true
  end)
  local comform = themeData:GetDmFntThemeComformt()
  local ownNum = themeData:GetDmFntThemeUseableNum()
  local totalNum = themeData:GetDmFntThemeTotalNum()
  self.ui.tex_Comfort.text = tostring(comform)
  self.ui.tex_Name.text = LanguageUtil.GetLocaleText(fntThemeCfg.theme_name)
  self.ui.tex_Num:SetIndex(0, tostring(ownNum), tostring(totalNum))
  self.ui.obj_img_OnlyBig:SetActive(fntThemeCfg.only_big)
  if themeData:IsDmFntThemeInSell() then
    self.ui.img_Tag.gameObject:SetActive(true)
    self.ui.img_Tag.color = self.ui.tagColorList[1]
    self.ui.tex_Tag:SetIndex(0)
  elseif fntThemeCfg.is_activity then
    self.ui.img_Tag.gameObject:SetActive(true)
    self.ui.img_Tag.color = self.ui.tagColorList[2]
    self.ui.tex_Tag:SetIndex(1)
  else
    self.ui.img_Tag.gameObject:SetActive(false)
  end
end

function UINDmFntThemeListItem:_OnClickRoot()
  if self._clickFunc ~= nil then
    self._clickFunc(self._fntThemeCfg)
  end
end

function UINDmFntThemeListItem:_OnClickTip()
  UIManager:ShowWindowAsync(UIWindowTypeID.DormItemDetail, function(win)
    if win == nil then
      return
    end
    win:InitDormDetail(self.themeData, true)
  end)
end

function UINDmFntThemeListItem:OnDelete()
  base.OnDelete(self)
end

return UINDmFntThemeListItem
