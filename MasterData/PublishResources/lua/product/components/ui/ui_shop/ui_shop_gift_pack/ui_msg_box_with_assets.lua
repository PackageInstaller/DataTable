_class("UIMsgBoxWithAssets", UIController)
UIMsgBoxWithAssets = UIMsgBoxWithAssets

function UIMsgBoxWithAssets:LoadDataOnEnter(TT, res)
  res:SetSucc(true)
end

function UIMsgBoxWithAssets:OnShow(uiParams)
  self:InitWidget()
  self.title:SetText(uiParams[1])
  self.content:SetText(uiParams[2])
  local assets = uiParams[3]
  local items = self.assets:SpawnObjects("UIItem", #assets)
  for i = 1, #assets do
    local item = items[i]
    local asset = assets[i]
    item:SetForm(UIItemForm.Base)
    local itemCfg = Cfg.cfg_item[asset.assetid]
    local itenName = StringTable.Get(itemCfg.Name)
    item:SetData({
      icon = itemCfg.Icon,
      text1 = asset.count,
      text2 = itenName,
      quality = itemCfg.Color,
      itemId = asset.assetid
    })
    item:SetClickCallBack(function(go)
      if not self._tipInfo then
        self._tipInfo = self.selectInfo:SpawnObject("UISelectInfo")
      end
      self._tipInfo:SetData(asset.assetid, go.transform.position)
    end)
  end
  self._onConfirm = uiParams[4]
end

function UIMsgBoxWithAssets:InitWidget()
  self.title = self:GetUIComponent("UILocalizationText", "Title")
  self.content = self:GetUIComponent("UILocalizationText", "Content")
  self.assets = self:GetUIComponent("UISelectObjectPath", "Assets")
  self.selectInfo = self:GetUIComponent("UISelectObjectPath", "SelectInfo")
end

function UIMsgBoxWithAssets:ButtonOKOnClick(go)
  self:CloseDialog()
  if self._onConfirm then
    self._onConfirm()
  end
end
