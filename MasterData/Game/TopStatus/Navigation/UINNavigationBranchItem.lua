local UINNavigationBranchItem = class("UINNavigationBranchItem", UIBaseNode)
local base = UIBaseNode
local UINNavigationBranchBtn = require("Game.TopStatus.Navigation.UINNavigationBranchBtn")

function UINNavigationBranchItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.branchBtnItemDic = {}
end

function UINNavigationBranchItem:InitNavigationBranchItem(navigation_mainCfg, resloader)
  self.navigation_mainCfg = navigation_mainCfg
  self.resloader = resloader
  self:GenAllButtons(navigation_mainCfg)
  self.ui.tex_Name.text = LanguageUtil.GetLocaleText(navigation_mainCfg.name)
  self.ui.tex_NameEn.text = navigation_mainCfg.name_en
  self.transform.gameObject.name = navigation_mainCfg.name_en
  self.ui.img_Icon.enabled = false
  self.resloader:LoadABAssetAsync(PathConsts:GetAtlasAssetPath("UI_NavigationBar"), function(spriteAtlas)
    if spriteAtlas == nil then
      return
    end
    self.ui.img_Icon.sprite = AtlasUtil.GetResldSprite(spriteAtlas, navigation_mainCfg.img)
    self.ui.img_Icon.enabled = true
  end)
end

function UINNavigationBranchItem:GenAllButtons(navigation_mainCfg)
  local isFirst = true
  for index, sub_id in ipairs(navigation_mainCfg.sub_id) do
    local navigation_subCfg = ConfigData.navigation_sub[sub_id]
    if navigation_subCfg == nil then
      error("can't get navigation_subCfg with sub_id" .. tostring(sub_id))
    else
      if self.branchBtnItemDic[sub_id] == nil then
        local item = UINNavigationBranchBtn.New()
        if isFirst then
          item:Init(self.ui.obj_subNavBranchItem)
          isFirst = false
        else
          local go = self.ui.obj_subNavBranchItem:Instantiate()
          item:Init(go)
        end
        self.branchBtnItemDic[sub_id] = item
      end
      self.branchBtnItemDic[sub_id]:InitNavigationBranchBtn(navigation_subCfg, self.resloader, index)
    end
  end
end

function UINNavigationBranchItem:RefreshAllNBB()
  for sub_id, NBB in pairs(self.branchBtnItemDic) do
    NBB:RefreshNBBIsUnlock()
  end
end

function UINNavigationBranchItem:OnDelete()
  for sub_id, NBB in pairs(self.branchBtnItemDic) do
    NBB:Delete()
  end
  base.OnDelete(self)
end

function UINNavigationBranchItem:SetIconParent(parent)
  self.ui.img_Icon.transform:SetParent(parent, true)
end

return UINNavigationBranchItem
