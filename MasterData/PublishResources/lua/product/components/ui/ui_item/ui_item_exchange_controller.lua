_class("UIItemExChangeController", UIController)
UIItemExChangeController = UIItemExChangeController

function UIItemExChangeController:OnShow(uiParams)
  self._item_a_id = uiParams[1]
  self._item_a_count = uiParams[2]
  self._item_b_id = uiParams[3]
  self._item_b_count = uiParams[4]
  self._enough = uiParams[5]
  self._btnTex = ""
  self._itemModule = GameGlobal.GetModule(ItemModule)
  if uiParams[6] then
    self._btnTex = uiParams[6]
  elseif self._enough then
    self._btnTex = StringTable.Get("str_item_public_exchange_btn_tex")
  else
    self._btnTex = StringTable.Get("str_item_public_exchange_not_enough")
  end
  local _uiitem1 = self:GetUIComponent("UISelectObjectPath", "uiitem1")
  local _uiitem2 = self:GetUIComponent("UISelectObjectPath", "uiitem2")
  self._uiitem1 = _uiitem1:SpawnObject("UIItem")
  self._uiitem1:SetForm(UIItemForm.Base, UIItemScale.Level1)
  self._uiitem1:SetClickCallBack(function(go)
  end)
  local cfga = Cfg.cfg_item[self._item_a_id]
  local icon1 = cfga.Icon
  local quality1 = cfga.Color
  local allCount1 = self._itemModule:GetItemCount(self._item_a_id)
  local text1
  if allCount1 >= self._item_a_count then
    text1 = self._item_a_count .. "/" .. allCount1
  else
    text1 = self._item_a_count .. "/<color=red>" .. allCount1 .. "</color>"
  end
  self._uiitem1:SetData({
    icon = icon1,
    quality = quality1,
    text1 = text1,
    itemId = self._item_a_id
  })
  self._uiitem2 = _uiitem2:SpawnObject("UIItem")
  self._uiitem2:SetForm(UIItemForm.Base, UIItemScale.Level1)
  self._uiitem2:SetClickCallBack(function(go)
  end)
  local cfgb = Cfg.cfg_item[self._item_b_id]
  local icon2 = cfgb.Icon
  local quality2 = cfgb.Color
  local text2 = self._item_b_count
  self._uiitem2:SetData({
    icon = icon2,
    quality = quality2,
    text1 = text2,
    itemId = self._item_b_id
  })
  local btnTex = self:GetUIComponent("UILocalizationText", "btnTex")
  btnTex:SetText(self._btnTex)
  self._itemA_name = cfga.Name
  local title = self:GetUIComponent("UILocalizationText", "title")
  title:SetText(StringTable.Get("str_item_public_exchange_title", StringTable.Get(cfga.Name), StringTable.Get(cfgb.Name)))
  self._atlas = self:GetAsset("UIItemExChange.spriteatlas", LoadType.SpriteAtlas)
  local sprite1 = self._atlas:GetSprite("items_zhuanhuan_di01")
  local sprite2 = self._atlas:GetSprite("items_zhuanhuan_di02")
  self._btnImg = self:GetUIComponent("Image", "Btn")
  if self._enough then
    self._btnImg.sprite = sprite1
  else
    self._btnImg.sprite = sprite2
  end
end

function UIItemExChangeController:BtnOnClick(go)
  if not self._enough then
    return
  end
  PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.OkCancel, "", StringTable.Get("str_item_public_exchange_btn_tips", StringTable.Get(self._itemA_name)), function(param)
    self:Lock("UIItemExChangeController:btnOnClick")
    GameGlobal.TaskManager():StartTask(self._Req, self)
  end, nil, function(param)
    Log.debug("###[UIItemExChangeController] 取消")
  end, nil)
end

function UIItemExChangeController:_Req(TT)
  local res = self._itemModule:ExchangeBreakThoughItem(TT, self._item_a_id, self._item_a_count, self._item_b_id, self._item_b_count)
  self:UnLock("UIItemExChangeController:btnOnClick")
  if res:GetSucc() then
    local roleAsset = RoleAsset:New()
    roleAsset.assetid = self._item_b_id
    roleAsset.count = self._item_b_count
    self:CloseDialog()
    self:ShowDialog("UIGetItemController", {roleAsset})
    GameGlobal.EventDispatcher():Dispatch(GameEventType.CloseUIBackPackBox)
  else
    local result = res:GetResult()
    Log.error("###[UIItemExChangeController] Req fail ! result --> ", result)
    ToastManager.ShowToast("Req fail ! result --> ", result)
  end
end

function UIItemExChangeController:BgOnClick(go)
  self:CloseDialog()
end
