local AvgBubbleItem, Super = System.NewComponent("AvgBubbleItem")

function AvgBubbleItem:ctor(uiNode, speed, data)
  Super.ctor(self)
  self.ui = Group_AvgBubbleResource(uiNode)
  self.speed = speed
  self.data = data
end

function AvgBubbleItem:OnBind(binder)
  self.binder = binder
  self:InitTextComp()
  binder:BindToText(self.ui.Text_Name, function()
    return self.data.talkerName
  end)
  binder:BindToImage(self.ui.Image_Avatar, function()
    return self.data.talkerIcon
  end)
end

function AvgBubbleItem:ShowDialogText()
  self.textComp:SetDialogText()
end

function AvgBubbleItem:IsTextDone()
  return not self.textComp:IsPrinting() and not self.textComp:IsWaitToRead()
end

function AvgBubbleItem:InitTextComp()
  local textComp = DialogContextComp(self.ui, self.binder, self.data)
  textComp:SetFastModeAndPlaySpeed(false, self.speed)
  textComp:Awake()
  self.textComp = textComp
end

return AvgBubbleItem
