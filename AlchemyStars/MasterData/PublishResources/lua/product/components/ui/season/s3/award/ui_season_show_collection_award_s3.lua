_class("UISeasonShowCollectionAwardS3", UIController)
UISeasonShowCollectionAwardS3 = UISeasonShowCollectionAwardS3

function UISeasonShowCollectionAwardS3:GetComponents()
  self._trans = self:GetGameObject()
  self._beforeTime = 200
  self._inited = false
  self._itemData = nil
  self._bg = self:GetUIComponent("RectTransform", "canvasGroup")
  self._iconBg = self:GetUIComponent("Image", "IconBg")
  self._imgIcon = self:GetUIComponent("RawImageLoader", "ImgIcon")
  self._bg.localScale = Vector3(1, 1, 1)
  self._titleText = self:GetUIComponent("UILocalizationText", "TitleText")
  self._titleTextGo = self:GetGameObject("TitleText")
  self._itemNameText = self:GetUIComponent("UILocalizationText", "ItemNameText")
  self._itemIntroText = self:GetUIComponent("UILocalizationText", "ItemIntroText")
  self._itemDetailText = self:GetUIComponent("UILocalizationText", "ItemDetailText")
  self.atlas = self:GetAsset("UISeasonMain.spriteatlas", LoadType.SpriteAtlas)
  self:AttachEvent(GameEventType.ShowItemTips, self.ShowTips)
  local s = self:GetUIComponent("UISelectObjectPath", "itemTips")
  self._tips = s:SpawnObject("UISelectInfo")
end

function UISeasonShowCollectionAwardS3:OnShow(uiParams)
  self._closeCallback = uiParams[2]
  self:GetComponents()
  local item_module = GameGlobal.GetModule(ItemModule)
  local roleAsset
  if not uiParams[1] then
    Log.fatal("###[UISeasonShowCollectionAwardS3] uiParams[1] is nil !")
  end
  roleAsset = uiParams[1]
  self:CreateData(roleAsset)
  self:FlushItem(self._itemData)
  self._inited = true
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundGetItem)
  self:DispatchEvent(GameEventType.OnSeasonCollectionObtained, roleAsset.assetid)
end

function UISeasonShowCollectionAwardS3:FlushItem(itemData)
  if not itemData then
    return
  end
  local icon = ""
  local color = 1
  local count = 0
  local name = ""
  local intro = ""
  local desc = ""
  if itemData.exp then
    icon = ""
    color = 6
    count = itemData.count
  else
    local cfg = Cfg.cfg_item[itemData.item_id]
    icon = cfg.Icon
    color = cfg.Color
    count = itemData.count
    name = itemData.item_name
    intro = itemData.simple_desc
    desc = itemData.item_des
  end
  self._imgIcon:LoadImage(icon)
  self._itemNameText:SetText(StringTable.Get(name))
  self._itemIntroText:SetText(StringTable.Get(intro))
  self._itemDetailText:SetText(StringTable.Get(desc))
end

function UISeasonShowCollectionAwardS3:CreateData(roleAsset)
  local itemTempleate = Cfg.cfg_item[roleAsset.assetid]
  if itemTempleate then
    self._itemData = {
      item_id = roleAsset.assetid,
      item_count = roleAsset.count,
      item_des = itemTempleate.RpIntro,
      icon = itemTempleate.Icon,
      item_name = itemTempleate.Name,
      simple_desc = itemTempleate.Intro,
      color = itemTempleate.Color
    }
  end
end

function UISeasonShowCollectionAwardS3:ClosePanel()
  self:CloseDialog()
end

function UISeasonShowCollectionAwardS3:OnHide()
  if self._closeCallback then
    self._closeCallback()
  end
end

function UISeasonShowCollectionAwardS3:IconBgOnClick(go)
end

function UISeasonShowCollectionAwardS3:BgOnClick(go)
  self:ClosePanel()
end

local modf = math.modf

function UISeasonShowCollectionAwardS3:_FormatItemCount(itemCount)
  return HelperProxy:GetInstance():FormatItemCount(itemCount)
end

function UISeasonShowCollectionAwardS3:CloseBtnOnClick(go)
  self:ClosePanel()
end

function UISeasonShowCollectionAwardS3:ShowTips(itemId, pos)
  self._tips:SetData(itemId, pos)
end
