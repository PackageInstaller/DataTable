local UINCommonPropItem = class("UINCommonPropItem", UIBaseNode)
local base = UIBaseNode

function UINCommonPropItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.commonPropItem, self, self.OnPropItemClicked)
end

function UINCommonPropItem:InitPropItem(resloader, itemCfg, itemCount)
  self.itemCfg = itemCfg
  self.ui.tex_PropName.text = LanguageUtil.GetLocaleText(itemCfg.name)
  if itemCount == nil then
  end
  self.ui.propNum:SetActive(itemCount ~= nil)
  if itemCount ~= nil then
    self.ui.tex_PropNumber.text = tostring(itemCount)
  end
  local action_type = itemCfg.action_type
  if action_type == eItemActionType.HeroCard or action_type == eItemActionType.HeroCardFrag then
    local heroId = itemCfg.arg[1]
    self.ui.propItem:SetActive(false)
    self.ui.heroItem:SetActive(true)
    self.ui.img_Frag:SetActive(action_type == eItemActionType.HeroCardFrag)
    local heroCfg = ConfigData.hero_data[heroId]
    if heroCfg == nil then
      return
    end
    local heroResCfg = ConfigData.resource_model[heroCfg.src_id]
    if heroResCfg ~= nil then
      resloader:LoadABAssetAsync(PathConsts:GetCharacterPicPath(heroResCfg.res_Name), function(texture)
        if IsNull(self.transform) then
          return
        end
        if self.itemCfg ~= itemCfg then
          return
        end
        self.ui.img_HeroPic.texture = texture
      end)
    end
  else
    self.ui.img_HeroPic.texture = nil
    self.ui.propItem:SetActive(true)
    self.ui.heroItem:SetActive(false)
    self.ui.img_ItemPic.sprite = CRH:GetSpriteByItemConfig(itemCfg)
  end
end

function UINCommonPropItem:BindClickedEvent(action)
  self.onClickEvent = action
end

function UINCommonPropItem:OnPropItemClicked()
  if self.onClickEvent ~= nil then
    self.onClickEvent(self)
  end
end

function UINCommonPropItem:OnDelete()
  base.OnDelete(self)
end

return UINCommonPropItem
