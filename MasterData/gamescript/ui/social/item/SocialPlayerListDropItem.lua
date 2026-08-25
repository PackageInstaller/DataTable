local RectTransform = CS.UnityEngine.RectTransform
local typeof = _ENV.typeof
local Y_POS_DELTA = 153
local SocialPlayerListDropItem, Super = System.NewComponent("SocialPlayerListDropItem")

function SocialPlayerListDropItem:ctor(uiNode, maskNode, data)
  Super.ctor(self)
  self.ui = UIBaseResource(uiNode)
  self.maskNode = maskNode
  self.data = data
  self.dropList = data.dropList
  self.parentNode = data.parentNode
  self.maskClickFunc = data.maskClickFunc
end

function SocialPlayerListDropItem:OnBind(binder)
  self.binder = binder
  for index = 1, 4 do
    local obj = self.ui["UI_Social_Dropdown_Item" .. index]
    local itemRes = UIBaseResource(obj)
    local dropData = self.dropList[index]
    if not dropData then
      obj:SetActive(false)
    else
      self.binder:BindToText(itemRes.Text_Drop_Item_Tips, function()
        do return LT.Text end
        return LT.Text, dropData.text
      end)
      local checkUnlockFunc = dropData.checkUnlockFunc
      self.binder:BindButtonClick(itemRes.Btn_Click, function()
        if checkUnlockFunc then
          local isOk, tipsId = checkUnlockFunc()
          if not isOk and tipsId then
            Alert.Show(tipsId)
            return
          end
        end
        if dropData.callback then
          dropData.callback()
        end
        self:OnMaskClicked()
      end)
      if checkUnlockFunc then
        local isUnlock = checkUnlockFunc()
        itemRes.Group_Lock:SetActive(not isUnlock)
        self.binder:SetTextColorType(itemRes.Text_Drop_Item_Tips, isUnlock and cd.ColorType.Light or cd.ColorType.Dark)
      else
        itemRes.Group_Lock:SetActive(false)
        self.binder:SetTextColorType(itemRes.Text_Drop_Item_Tips, cd.ColorType.Light)
      end
    end
  end
  if self.parentNode then
    self:AdjustPosition(self.parentNode, self.ui.uiNode)
  end
end

function SocialPlayerListDropItem:AdjustPosition(rootGameObj, tipGameObj)
  local rootPosition = self:GetLocalPosition(rootGameObj)
  local sizeDelta = self.ui.UI_Social_Dropdown_Item1:GetComponent(typeof(RectTransform)).sizeDelta
  local tipPerHeight = sizeDelta.y
  local tipsTotleHeight = tipPerHeight * #self.dropList
  local UISize = CS.UnityEngine.GameObject.Find("UIRoot"):GetComponent(typeof(RectTransform)).sizeDelta
  local bgHeight = UIRootMgr.GetBGImageHeight()
  local UIHeight = bgHeight < UISize.y and bgHeight or UISize.y
  rootPosition.y = rootPosition.y - Y_POS_DELTA
  rootPosition.x = rootPosition.x
  local outVal = UIHeight / 2 + rootPosition.y - tipsTotleHeight
  if outVal < 0 then
    rootPosition.y = rootPosition.y + tipsTotleHeight + tipPerHeight
  end
  tipGameObj.transform.anchoredPosition = rootPosition
end

function SocialPlayerListDropItem:GetLocalPosition(gameObj)
  local localPos = CS.Framework.UIUtilTool.ConvertUIWorldPosToLocalPos(gameObj.transform.position, CS.UnityEngine.GameObject.Find("UIRoot"):GetComponent(typeof(RectTransform)), CameraManager:GetUICamera())
  do return CS.UnityEngine.Vector2, localPos.x end
  return CS.UnityEngine.Vector2, localPos.x, localPos.y, CameraManager:GetUICamera()
end

function SocialPlayerListDropItem:OnMaskClicked()
  if self.maskClickFunc then
    self.maskClickFunc()
  end
  self.binder:teardown()
end

return SocialPlayerListDropItem
