local RectTransform = CS.UnityEngine.RectTransform
local TYPEOF_TMP_Text = typeof(CS.TMPro.TMP_Text)
local Vector2 = CS.UnityEngine.Vector2
local MAX_SCROLL_VIEW_HEIGHT = 600
local CELL_SPACING = 3
local DROP_ITEM_PREFAB = "Group_Item"
local Common_Font_Assets = "LangRes/COM/UI/UI_Font/UI_Text_SYSY_COM.asset"
local Common_THFont_Assets = "LangRes/TH/UI/UI_Font/UI_Text_SYSY_TH.asset"
local Common_KRFont_Assets = "LangRes/KR/UI/UI_Font/UI_Text_SYSY_KR.asset"
local Common_BNFont_Assets = "LangRes/BN/UI/UI_Font/UI_Text_NotoSansBengali.asset"
local langFontMap = {
  TH = Common_THFont_Assets,
  KR = Common_KRFont_Assets,
  BN = Common_BNFont_Assets
}
local SettingDropGroupView, Super = NewClass("SettingDropGroupView", BaseView)
SettingDropGroupView.uiResCls = UI_Setting_Dropdown_GroupResource

function SettingDropGroupView:ctor(data)
  Super.ctor(self)
  self._data = data or {}
  self._confirmFunc = self:_GetConfirmFunc(self._data.setUpUid)
  self._clickText = nil
  self._setVal = nil
  self._maskNode = nil
  self._panelPos = nil
end

function SettingDropGroupView:_GetConfirmFunc(setUpUid)
  if not setUpUid then
    return nil
  end
  do return SettingManager.Instance.GetConfirmFunc, SettingManager.Instance end
  return SettingManager.Instance.GetConfirmFunc, SettingManager.Instance, setUpUid
end

function SettingDropGroupView:OnBuildView()
  local dropList = self._data.dropList or {}
  local cellHeight = 56
  local template = self.ui[DROP_ITEM_PREFAB]
  if template then
    cellHeight = template.transform.sizeDelta.y
  end
  local count = #dropList
  local dropHeight = 0
  if count > 0 then
    dropHeight = math.min(count * (cellHeight + CELL_SPACING) - CELL_SPACING, MAX_SCROLL_VIEW_HEIGHT)
  end
  self._dropHeight = dropHeight
  self:_SetRectHeight(self.ui.ScrollView_Drop.transform, dropHeight)
  self:_SetContentAreaHeight(dropHeight)
  self:_BuildDropListView()
  self:_CreateClickMask()
  if self._data.parentNode then
    self:_AdjustPosition(self._data.parentNode, self.ui.uiNode)
  end
end

function SettingDropGroupView:OnExitView()
  Super.OnExitView(self)
  if self._maskNode then
    UIRootMgr.DestroyGameObject(self._maskNode)
    self._maskNode = nil
  end
end

function SettingDropGroupView:_SetRectHeight(rectTransform, height)
  if not rectTransform then
    return
  end
  local sizeDelta = rectTransform.sizeDelta
  rectTransform.sizeDelta = Vector2(sizeDelta.x, height)
end

function SettingDropGroupView:_SetContentAreaHeight(height)
  local viewportTf = self.ui.ScrollView_Drop.transform:Find("Viewport")
  if not viewportTf then
    return
  end
  self:_SetRectHeight(viewportTf:GetComponent(typeof(RectTransform)), height)
  local contentTf = viewportTf:Find("Content")
  if contentTf then
    self:_SetRectHeight(contentTf:GetComponent(typeof(RectTransform)), height)
  end
end

function SettingDropGroupView:_CreateClickMask()
  local maskAsset = self:LoadAsset("UI/UI_Common/UI_Common_Prefab/UI_Old_Public/UI_Common_Mask.prefab")
  if not maskAsset then
    return
  end
  local rootTf = self.ui.uiNode.transform
  local maskNode = CS.UnityEngine.GameObject.Instantiate(maskAsset, rootTf.parent)
  maskNode.transform:SetSiblingIndex(rootTf:GetSiblingIndex())
  self._maskNode = maskNode
  self:AddButtonClickListener(maskNode, System.fn(self, self._OnMaskClicked))
end

function SettingDropGroupView:_BuildDropListView()
  local template = self.ui[DROP_ITEM_PREFAB]
  local width, height = 0, 0
  if template then
    local sizeDelta = template.transform.sizeDelta
    width, height = sizeDelta.x, sizeDelta.y
  end
  self._dropTableView = self:CreateTableview(self.ui.ScrollView_Drop, function()
    return #(self._data.dropList or {})
  end, function(view, idx)
    do return self._OnDropCellAtIndex, self, view end
    return self._OnDropCellAtIndex, self, view, idx
  end, function()
    return width, height
  end)
  self._dropTableView:ReloadData()
end

function SettingDropGroupView:_GetShowVal(setVal)
  if self._data.setupTab == CommonDefine.SettingTab.Language then
    assert(DT.CommonID[setVal], string.format("新增语言 %s 未在CommonID中定义", setVal))
    do return SettingManager.Instance.GetLangNameByLangCode, SettingManager.Instance end
    return SettingManager.Instance.GetLangNameByLangCode, SettingManager.Instance, setVal, string.format("新增语言 %s 未在CommonID中定义", setVal)
  elseif DT.CommonID[setVal] then
    return DT.CommonID[setVal].Desc
  end
  return setVal
end

function SettingDropGroupView:_OnDropCellAtIndex(view, idx)
  local setVal = self._data.dropList[idx]
  local showVal = self:_GetShowVal(setVal)
  local template = self.ui[DROP_ITEM_PREFAB]
  local cell = self:DequeueCell(view, template)
  local itemRes = UI_Setting_Dropdown_ItemResource(cell.gameObject)
  self:SetText(itemRes.Text_Drop_Item_Tips, LT.Text(showVal))
  self:_TrySetLangFont(itemRes, setVal)
  local isSame = self:_IsSameVal(showVal)
  itemRes.Group_Nor.gameObject:SetActive(not isSame)
  itemRes.Group_Sel.gameObject:SetActive(isSame)
  self:SetTextColorByHtml(itemRes.Text_Drop_Item_Tips, isSame and "#FFFFFF" or "#B1B0A0")
  self:AddButtonClickListener(itemRes.Button_Click, function()
    local function onBtnClick()
      self._clickText = showVal
      
      self._setVal = setVal
      self:_OnMaskClicked()
    end
    
    if self._confirmFunc then
      self._confirmFunc(setVal, onBtnClick)
      return
    end
    onBtnClick()
  end)
  return cell
end

function SettingDropGroupView:_TrySetLangFont(itemRes, setVal)
  if self._data.setupTab ~= CommonDefine.SettingTab.Language then
    return
  end
  self:BindTimer(0, 0, nil, function()
    if IsNil(itemRes.Text_Drop_Item_Tips) then
      return
    end
    local textComp = itemRes.Text_Drop_Item_Tips:GetComponent(TYPEOF_TMP_Text)
    textComp.font = self:LoadAsset(langFontMap[setVal] or Common_Font_Assets)
  end)
end

function SettingDropGroupView:_IsSameVal(showVal)
  return LT.Text(tostring(self._data.curText)) == LT.Text(tostring(showVal))
end

function SettingDropGroupView:_AdjustPosition(rootGameObj, tipGameObj)
  local rootPosition = self:_GetLocalPosition(rootGameObj)
  local sizeDelta = self.ui.Group_Item:GetComponent(typeof(RectTransform)).sizeDelta
  local tipPerHeight = sizeDelta.y
  local tipsTotleHeight = self._dropHeight or 0
  local UISize = CS.UnityEngine.GameObject.Find("UIRoot"):GetComponent(typeof(RectTransform)).sizeDelta
  local bgHeight = UIRootMgr.GetBGImageHeight()
  local UIHeight = bgHeight < UISize.y and bgHeight or UISize.y
  rootPosition.y = rootPosition.y - 13
  rootPosition.x = rootPosition.x - 13
  local outVal = UIHeight / 2 + rootPosition.y - tipsTotleHeight
  if outVal < 0 then
    rootPosition.y = rootPosition.y + tipsTotleHeight + tipPerHeight - 8
  end
  self._panelPos = rootPosition
  tipGameObj.transform.anchoredPosition = rootPosition
end

function SettingDropGroupView:_GetLocalPosition(gameObj)
  local localPos = CS.Framework.UIUtilTool.ConvertUIWorldPosToLocalPos(gameObj.transform.position, CS.UnityEngine.GameObject.Find("UIRoot"):GetComponent(typeof(RectTransform)), CameraManager:GetUICamera())
  do return Vector2, localPos.x end
  return Vector2, localPos.x, localPos.y, CameraManager:GetUICamera()
end

function SettingDropGroupView:SetRendered(isRendering)
  Super.SetRendered(self, isRendering)
  if not isRendering or not self._panelPos then
    return
  end
  if not self.ui or IsNil(self.ui.uiNode) then
    return
  end
  self.ui.uiNode.transform.anchoredPosition = self._panelPos
end

function SettingDropGroupView:_OnMaskClicked()
  if self._data.clickFunc then
    self._data.clickFunc(self._clickText, self._setVal)
  end
  self:Close()
end

return SettingDropGroupView
