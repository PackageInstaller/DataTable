local UICommonItem = class("UINChipItem", UIBaseNode)
local base = UIBaseNode

function UICommonItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_commonItem, self, self.OnClick)
  self.canClick = true
end

function UICommonItem:OnClick()
  if not self.canClick then
    return
  end
  if self.clickEvent ~= nil then
    self:clickEvent(self.itemCfg)
  else
    self:DefaultOnClick(self.itemCfg)
  end
end

function UICommonItem:InitItem(itemCfg, num, resloader)
  self.itemCfg = itemCfg
  if num == nil then
    self.ui.Obj_numImage:SetActive(false)
  else
    self.ui.Obj_numImage:SetActive(true)
    self.ui.text_numText.text = num
  end
  local action_type = itemCfg.action_type
  if action_type == eItemActionType.HeroCard or action_type == eItemActionType.HeroCardFrag then
    local heroId = itemCfg.arg[1]
    self.ui.img_itemImage.gameObject:SetActive(false)
    self.ui.img_HeroRawImage.gameObject:SetActive(true)
    local heroCfg = ConfigData.hero_data[heroId]
    if heroCfg == nil then
      return
    end
    local heroResCfg = ConfigData.resource_model[heroCfg.src_id]
    if heroResCfg ~= nil then
      if resloader == nil then
        return
      end
      resloader:LoadABAssetAsync(PathConsts:GetCharacterPicPath(heroResCfg.res_Name), function(texture)
        if IsNull(self.transform) then
          return
        end
        self.ui.img_HeroRawImage.texture = texture
      end)
    end
  else
    self.ui.img_itemImage.sprite = CRH:GetSpriteByItemConfig(self.itemCfg)
    self.ui.qualityImage.color = ItemQualityColor[itemCfg.quality]
  end
end

function UICommonItem:SetClickable(canClick)
  self.canClick = canClick
end

function UICommonItem:SetJumpable(canJump)
  self.canJump = canJump
end

function UICommonItem:DefaultOnClick(itemCfg)
  local window = UIManager:ShowWindow(UIWindowTypeID.GlobalItemDetail)
  if self.parentWindowType ~= nil then
    window:ParentWindowType(self.parentWindowType)
  end
  if self.canJump ~= nil then
    window:SetJumpable(self.canJump)
  else
    window:SetJumpable(true)
  end
  window:InitCommonItemDetail(itemCfg)
end

function UICommonItem:ParentWindowType(type)
  self.parentWindowType = type
end

return UICommonItem
