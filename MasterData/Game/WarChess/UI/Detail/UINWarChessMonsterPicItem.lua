local UINWarChessMonsterPicItem = class("UINWarChessMonsterPicItem", UIBaseNode)
local base = UIBaseNode

function UINWarChessMonsterPicItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Select, self, self.OnBtnSelected)
  self.originTexture = self.ui.img_EnemyPic.texture
end

function UINWarChessMonsterPicItem:InitItem(monsterCfg, resloader, onClickCallback)
  if monsterCfg == nil then
    return
  end
  self.monsterCfg = monsterCfg
  self._onClickCallback = onClickCallback
  local resId = monsterCfg.src_id
  if resId == self.__cacheResId then
    return
  end
  local resCfg = ConfigData.resource_model[resId]
  self.__cacheResId = resId
  if resCfg ~= nil then
    local path = PathConsts:GetCharacterSmallPicPath(resCfg.res_Name)
    resloader:LoadABAssetAsync(path, function(texture)
      if texture ~= nil and not IsNull(self.gameObject) then
        self.ui.img_EnemyPic.texture = texture
      end
    end)
  end
end

function UINWarChessMonsterPicItem:InitMapItem(onClickCallback)
  self._onClickCallback = onClickCallback
  self.ui.img_EnemyPic.texture = self.originTexture
end

function UINWarChessMonsterPicItem:SetItemSelect(selected)
  if selected then
    self.ui.img_Select.transform:SetParent(self.transform)
    self.ui.img_Select.transform.anchoredPosition = Vector2.zero
  end
end

function UINWarChessMonsterPicItem:OnBtnSelected()
  if self._onClickCallback ~= nil then
    self._onClickCallback(self)
  end
end

function UINWarChessMonsterPicItem:SetRefreshSelectUI(isOn)
  local index = isOn and 1 or 0
  self.ui.Img_Select:SetIndex(index)
  local nameCol = isOn and Color.white or Color.black
  self.ui.tex_SkillName.color = nameCol
  local descCol = isOn and self.ui.col_DescWhite or self.ui.col_DescBlack
  self.ui.tex_SkillDesc.color = descCol
end

function UINWarChessMonsterPicItem:OnDelete()
  self.originTexture = nil
  base.OnDelete(self)
end

return UINWarChessMonsterPicItem
