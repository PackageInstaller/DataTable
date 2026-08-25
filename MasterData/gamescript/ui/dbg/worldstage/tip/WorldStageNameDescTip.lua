local WorldStageNameDescTip, Super = System.NewComponent("WorldStageNameDescTip")

function WorldStageNameDescTip:ctor(res, maskNode, name, desc, posX, posY, posZ)
  Super.ctor(self)
  self.ui = UI_Common_Popup_Key_TipResource(res)
  Logger.Info("Create WorldStageNameDescTip")
  self.maskNode = maskNode
  self.name = name
  self.desc = desc
  self.posX = posX
  self.posY = posY
  self.posZ = posZ
end

function WorldStageNameDescTip:OnBind(binder)
  self.binder = binder
  self.transform = self.ui.Group_Content.transform
  binder:BindToText(self.ui.Text_Title, function()
    return self.name
  end)
  binder:BindToText(self.ui.Text_Desc, function()
    return self.desc
  end)
  binder:BindButtonClick(self.ui.Btn_Mask, System.fn(self, self.OnClose))
  self:AdjustPosition()
end

function WorldStageNameDescTip:AdjustPosition()
  if self.posZ == nil then
    local newPosition = CS.UnityEngine.Vector2(-770 + self.posX * 130, -310 + self.posY * 130)
    self.transform.anchoredPosition = newPosition
  else
    local worldPos = CS.UnityEngine.Vector3(self.posX, self.posY, self.posZ)
    local uiRect = self.transform.rect
    local uiWidth = uiRect.width
    local uiHeight = uiRect.height
    local screenWidth = UIRootMgr.GetUIRootWidth()
    local screenHeight = UIRootMgr.GetUIRootHeight()
    local bgWidth = UIRootMgr.GetBGImageWidth()
    local bgHeight = UIRootMgr.GetBGImageHeight()
    screenWidth = screenWidth > bgWidth and bgWidth or screenWidth
    screenHeight = screenHeight > bgHeight and bgHeight or screenHeight
    local xMin, xMax = -screenWidth / 2 + uiWidth / 2, screenWidth / 2 - uiWidth / 2
    local yMin, yMax = -screenHeight / 2 + uiHeight / 2, screenHeight / 2 - uiHeight / 2
    local anchoredPos = CS.Framework.UIUtilTool.ConvertSceneToUIWorldPos(worldPos, self.transform.parent, UIRootMgr.GetMainCamera(), UIRootMgr.GetUICamera())
    anchoredPos.y = anchoredPos.y + 180
    if xMin > anchoredPos.x then
      anchoredPos.x = xMin
    elseif xMax < anchoredPos.x then
      anchoredPos.x = xMax
    end
    if yMin > anchoredPos.y then
      anchoredPos.y = yMin
    elseif yMax < anchoredPos.y then
      anchoredPos.y = yMax
    end
    self.transform.anchoredPosition = anchoredPos
  end
end

function WorldStageNameDescTip:OnClose()
  self.binder:teardown()
end

return WorldStageNameDescTip
