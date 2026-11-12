local IceCreamBackPackCtrl = class("IceCreamBackPackCtrl", BaseCtrl)
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
IceCreamBackPackCtrl._mapNodeConfig = {
  txt_BagTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "IceCreamTruck_BagTitle"
  },
  btn_Close = {
    sComponentName = "NaviButton",
    callback = "OnBtn_Close",
    sAction = "Back"
  },
  txt_BuffItemInfo = {nCount = 2, sComponentName = "TMP_Text"},
  obj_BuffItemUnEmpty = {nCount = 2},
  obj_BuffItemEmpty = {nCount = 2},
  txt_BuffItemTitle = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "IceCreamTruck_EmptyTips"
  },
  txt_BuffItemEmpty = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "IceCreamTruck_Empty"
  }
}
IceCreamBackPackCtrl._mapEventConfig = {}

function IceCreamBackPackCtrl:Awake()
  self.tbGamepadUINode = self:GetGamepadUINode()
end

function IceCreamBackPackCtrl:OnEnable()
  self.gameObject:SetActive(false)
end

function IceCreamBackPackCtrl:OpenBackPack(tbCurrentItems)
  GamepadUIManager.EnableGamepadUI("IceCreamBackPackCtrl", self.tbGamepadUINode)
  if tbCurrentItems ~= nil then
    EventManager.Hit("Event_SetPause", true)
    self.gameObject:SetActive(true)
    self:InitBackPack(tbCurrentItems)
  end
end

function IceCreamBackPackCtrl:InitBackPack(tbCurrentItems)
  for i = 1, 2 do
    local value = tbCurrentItems[i] or 0
    if value ~= 0 then
      local txtItemName = self._mapNode.obj_BuffItemUnEmpty[i].transform:Find("txt_BuffItemName"):GetComponent("TMP_Text")
      local txtItemInfo = self._mapNode.txt_BuffItemInfo[i]
      local imgBuffIcon = self._mapNode.obj_BuffItemUnEmpty[i].transform:Find("ImgBuffIcon"):GetComponent("Image")
      local buffData = ConfigTable.GetData("IceCreamBuff", value)
      if buffData ~= nil then
        NovaAPI.SetTMPText(txtItemName, buffData.Name)
        NovaAPI.SetTMPText(txtItemInfo, buffData.Desc)
        local IconPath = buffData.Icon
        if IconPath == nil then
          imgBuffIcon.gameObject:SetActive(false)
          printError("道具资源路径为空,ID: " .. tostring(value))
        else
          self:SetActivityAtlasSprite_New(imgBuffIcon, "_400020/SpriteAtlas", IconPath)
        end
      end
    end
    self._mapNode.obj_BuffItemUnEmpty[i]:SetActive(value ~= 0)
    self._mapNode.obj_BuffItemEmpty[i]:SetActive(value == 0)
  end
end

function IceCreamBackPackCtrl:CloseBackPack()
  GamepadUIManager.DisableGamepadUI("IceCreamBackPackCtrl")
  EventManager.Hit("Event_SetPause", false)
  self.gameObject:SetActive(false)
end

function IceCreamBackPackCtrl:OnBtn_Close(btn)
  self:CloseBackPack()
end

return IceCreamBackPackCtrl
