local UIShowCharacterSkin = class("UIShowCharacterSkin", UIBaseWindow)
local base = UIBaseWindow
local UINBtnCharacterAction = require("Game.ShowCharacterSkin.UI.UINBtnCharacterAction")

function UIShowCharacterSkin:OnShow()
end

function UIShowCharacterSkin:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self._itemPool = UIItemPool.New(UINBtnCharacterAction, self.ui.btn_House)
  self.ui.btn_House:SetActive(false)
  UIUtil.AddButtonListener(self.ui.btn_SwitchHouse, self, self.OnClickSwitch)
end

function UIShowCharacterSkin:InitShowCharacterSkin(showCharacterSkinController)
  self.showCharacterSkinController = showCharacterSkinController
  self.animationIdList = self.showCharacterSkinController:GetAnimationIdList()
  UIUtil.SetTopStatus(self, self.OnClickBack)
  UIUtil.SetTopOnlyShowReturn(true)
  self._itemPool:HideAll()
  for i, animationInfo in pairs(self.animationIdList) do
    local item = self._itemPool:GetOne()
    item:InitShowCharacterSkin(i, animationInfo.tipId, function(index)
      if not self.isPlayingId or self.isPlayingId ~= index then
        self.showCharacterSkinController:PlayAnimationByIndex(index)
      end
    end)
  end
end

function UIShowCharacterSkin:SetTopText(index)
  self.isPlayingId = index
  local tipId = self.animationIdList[index].tipId
  self.ui.topTex_Name.text = LanguageUtil.GetLocaleText(ConfigData:GetTipContent(tipId))
end

function UIShowCharacterSkin:OnClickBack()
  self.showCharacterSkinController:ExitShowCharacter()
  self:OnCloseWin()
end

function UIShowCharacterSkin:OnClickSwitch()
  self.ui.switchBtnList:SetActive(not self.ui.switchBtnList.activeSelf)
  self.ui.img_Arrow.localEulerAngles = self.ui.switchBtnList.activeSelf and Vector3.Temp(0, 0, 180) or Vector3.zero
end

function UIShowCharacterSkin:OnDelete()
end

return UIShowCharacterSkin
