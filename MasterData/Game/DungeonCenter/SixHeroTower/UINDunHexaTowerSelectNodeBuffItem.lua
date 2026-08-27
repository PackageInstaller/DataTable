local UINDunHexaTowerSelectNodeBuffItem = class("UINDunHexaTowerSelectNodeBuffItem", UIBaseNode)
local base = UIBaseNode
local OnPressScale = Vector3.New(0.9, 0.9, 1)
local FloatAlignEnum = require("Game.CommonUI.FloatWin.FloatAlignEnum")
local HAType = FloatAlignEnum.HAType
local VAType = FloatAlignEnum.VAType

function UINDunHexaTowerSelectNodeBuffItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.ui.btn.onPressDown:AddListener(BindCallback(self, self.__OnSkillLongPress))
  self.ui.btn.onPressUp:AddListener(BindCallback(self, self.__OnSkillPressUp))
end

function UINDunHexaTowerSelectNodeBuffItem:InitHeaxTowerBuffItem(dunBuffCfg)
  self.dunBuffCfg = dunBuffCfg
  self.ui.Img_ProtocolPic.sprite = CRH:GetSprite(dunBuffCfg.icon, CommonAtlasType.ExplorationIcon)
end

function UINDunHexaTowerSelectNodeBuffItem:__OnSkillLongPress()
  local win = UIManager:ShowWindow(UIWindowTypeID.FloatingFrame)
  local name = LanguageUtil.GetLocaleText(self.dunBuffCfg.name)
  local des = LanguageUtil.GetLocaleText(self.dunBuffCfg.describe)
  win:SetTitleAndContext(name, des)
  win:FloatTo(self.transform, HAType.autoCenter, VAType.up)
  self.transform.localScale = OnPressScale
end

function UINDunHexaTowerSelectNodeBuffItem:__OnSkillPressUp()
  local win = UIManager:GetWindow(UIWindowTypeID.FloatingFrame)
  if win ~= nil then
    win:Hide()
    win:Clean3DModifier()
  end
  self.transform.localScale = Vector3.one
end

return UINDunHexaTowerSelectNodeBuffItem
