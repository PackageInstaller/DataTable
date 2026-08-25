local RectTransform = CS.UnityEngine.RectTransform
local typeof = _ENV.typeof
local MAX_SCROLL_VIEW_HEIGHT = 600
local TYPEOF_TMP_Text = typeof(CS.TMPro.TMP_Text)
local Common_Font_Assets = "LangRes/COM/UI/UI_Font/UI_Text_SYSY_COM.asset"
local Common_THFont_Assets = "LangRes/TH/UI/UI_Font/UI_Text_SYSY_TH.asset"
local Common_KRFont_Assets = "LangRes/KR/UI/UI_Font/UI_Text_SYSY_KR.asset"
local Common_BNFont_Assets = "LangRes/BN/UI/UI_Font/UI_Text_NotoSansBengali.asset"
local SettingDropGroupItem, Super = System.NewComponent("SettingDropGroupItem")

function SettingDropGroupItem:ctor(uiNode, maskNode, data)
  Super.ctor(self)
  self.ui = UI_Setting_Dropdown_GroupResource(uiNode)
  self.maskNode = maskNode
  self.data = data
  self.clickText = nil
  self.setVal = nil
  self.confirmFunc = self:GetConfirmFunc(data.setUpUid)
end

function SettingDropGroupItem:GetConfirmFunc(setUpUid)
  if not setUpUid then
    return
  end
  do return SettingManager.Instance.GetConfirmFunc, SettingManager.Instance end
  return SettingManager.Instance.GetConfirmFunc, SettingManager.Instance, setUpUid
end

function SettingDropGroupItem:OnBind(binder)
  self.binder = binder
  binder:BindToRaw(function(_, itemCount)
    self.ui.ScrollView_Drop.transform.sizeDelta = CS.UnityEngine.Vector2(242, math.min(itemCount * 60, MAX_SCROLL_VIEW_HEIGHT))
  end, function()
    return #self.data.dropList
  end)
  binder:BindToCircularListView(self.ui.ScrollView_Drop, function()
    return self.data.dropList
  end, function(itemBinder, obj, index)
    local itemRes = UI_Setting_Dropdown_ItemResource(obj)
    local setVal = self.data.dropList[index]
    local showVal
    if self.data.setupTab == CommonDefine.SettingTab.Language then
      assert(DT.CommonID[setVal], string.format("新增语言 %s 未在CommonID中定义", setVal))
      showVal = SettingManager.Instance:GetLangNameByLangCode(setVal)
    elseif DT.CommonID[setVal] then
      showVal = DT.CommonID[setVal].Desc
    else
      showVal = setVal
    end
    if self.data.setupTab == CommonDefine.SettingTab.Language then
      itemBinder:BindTimer(0, 0, nil, function()
        if not IsNil(itemRes.Text_Drop_Item_Tips) then
          if "TH" == setVal then
            local textComp = itemRes.Text_Drop_Item_Tips:GetComponent(TYPEOF_TMP_Text)
            textComp.font = itemBinder:LoadAsset(Common_THFont_Assets)
          elseif "KR" == setVal then
            local textComp = itemRes.Text_Drop_Item_Tips:GetComponent(TYPEOF_TMP_Text)
            textComp.font = itemBinder:LoadAsset(Common_KRFont_Assets)
          elseif "BN" == setVal then
            local textComp = itemRes.Text_Drop_Item_Tips:GetComponent(TYPEOF_TMP_Text)
            textComp.font = itemBinder:LoadAsset(Common_BNFont_Assets)
          else
            local textComp = itemRes.Text_Drop_Item_Tips:GetComponent(TYPEOF_TMP_Text)
            textComp.font = itemBinder:LoadAsset(Common_Font_Assets)
          end
        end
      end)
    end
    itemBinder:BindToText(itemRes.Text_Drop_Item_Tips, function()
      do return LT.Text end
      return LT.Text, showVal
    end)
    itemBinder:BindToVisible(itemRes.Group_Nor, function()
      return not self:_IsSameVal(showVal)
    end)
    itemBinder:BindToVisible(itemRes.Group_Sel, function()
      do return self._IsSameVal, self end
      return self._IsSameVal, self, showVal
    end)
    itemBinder:BindToTextColorOld(itemRes.Text_Drop_Item_Tips, function()
      return self:_IsSameVal(showVal) and "#FFFFFF" or "#B1B0A0"
    end)
    
    local function OnBtnClick()
      self.clickText = showVal
      self.setVal = setVal
      self:OnMaskClicked()
    end
    
    itemBinder:BindButtonClick(itemRes.Button_Click, function()
      if self.confirmFunc then
        self.confirmFunc(setVal, OnBtnClick)
        return
      end
      OnBtnClick()
    end)
  end)
  if self.data.parentNode then
    self:AdjustPosition(self.data.parentNode, self.ui.uiNode)
  end
end

function SettingDropGroupItem:_IsSameVal(showVal)
  return LT.Text(tostring(self.data.curText)) == LT.Text(tostring(showVal))
end

function SettingDropGroupItem:AdjustPosition(rootGameObj, tipGameObj)
  local rootPosition = self:GetLocalPosition(rootGameObj)
  local sizeDelta = self.ui.Group_Item:GetComponent(typeof(RectTransform)).sizeDelta
  local tipPerHeight = sizeDelta.y
  local tipsTotleHeight = math.min(60 * (#self.data.dropList + 0), MAX_SCROLL_VIEW_HEIGHT)
  local UISize = CS.UnityEngine.GameObject.Find("UIRoot"):GetComponent(typeof(RectTransform)).sizeDelta
  local bgHeight = UIRootMgr.GetBGImageHeight()
  local UIHeight = bgHeight < UISize.y and bgHeight or UISize.y
  rootPosition.y = rootPosition.y - 13
  rootPosition.x = rootPosition.x - 13
  local outVal = UIHeight / 2 + rootPosition.y - tipsTotleHeight
  if outVal < 0 then
    rootPosition.y = rootPosition.y + tipsTotleHeight + tipPerHeight - 8
  end
  tipGameObj.transform.anchoredPosition = rootPosition
end

function SettingDropGroupItem:GetLocalPosition(gameObj)
  local localPos = CS.Framework.UIUtilTool.ConvertUIWorldPosToLocalPos(gameObj.transform.position, CS.UnityEngine.GameObject.Find("UIRoot"):GetComponent(typeof(RectTransform)), CameraManager:GetUICamera())
  do return CS.UnityEngine.Vector2, localPos.x end
  return CS.UnityEngine.Vector2, localPos.x, localPos.y, CameraManager:GetUICamera()
end

function SettingDropGroupItem:OnMaskClicked()
  if self.data.clickFunc then
    self.data.clickFunc(self.clickText, self.setVal)
  end
  self.binder:teardown()
end

return SettingDropGroupItem
