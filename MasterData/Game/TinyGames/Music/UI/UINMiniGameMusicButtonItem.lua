local UINMiniGameMusicButtonItem = class("UINMiniGameMusicButtonItem", UIBaseNode)
local base = UIBaseNode
local MiniGameMusicEnum = require("Game.TinyGames.Music.MiniGameMusicEnum")

function UINMiniGameMusicButtonItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.ui.btn_ButtonItem.onPressDown:AddListener(BindCallback(self, self._OnMusicItemPressDown))
  self.ui.btn_ButtonItem.onPressUp:AddListener(BindCallback(self, self._OnMusicItemPressUp))
end

function UINMiniGameMusicButtonItem:InitMusicButtonItem(buttonDownCallback, buttonUpCallback, buttonId, controller)
  self.buttonDownCallback = buttonDownCallback
  self.buttonUpCallback = buttonUpCallback
  self.buttonId = buttonId
  self.mainController = controller
  local uiCfg = controller:GetMusicUiCfg(buttonId)
  self.ui.img_DotUp.gameObject:SetActive(false)
  self.ui.img_DotDown.gameObject:SetActive(false)
  if uiCfg ~= nil then
    self.ui.tex_GamutNum.gameObject:SetActive(false)
    self.ui.tex_GamutNum_1.gameObject:SetActive(false)
    if buttonId % 7 == 1 then
      self.ui.tex_GamutNum_1.gameObject:SetActive(true)
      self.ui.tex_GamutNum_1.text = LanguageUtil.GetLocaleText(uiCfg.char_icon)
    else
      self.ui.tex_GamutNum.gameObject:SetActive(true)
      self.ui.tex_GamutNum.text = LanguageUtil.GetLocaleText(uiCfg.char_icon)
    end
    self.ui.tex_GamutEN.text = LanguageUtil.GetLocaleText(uiCfg.char_note)
    if uiCfg.notation == MiniGameMusicEnum.EButtonDotType.Up then
      self.ui.img_DotUp.gameObject:SetActive(true)
    elseif uiCfg.notation == MiniGameMusicEnum.EButtonDotType.Down then
      self.ui.img_DotDown.gameObject:SetActive(true)
    end
  end
  self:_ChangeButtonItemUiState(false)
end

function UINMiniGameMusicButtonItem:_OnMusicItemPressDown()
  if self.buttonDownCallback ~= nil then
    self.buttonDownCallback(self.buttonId)
  end
  self:_ChangeButtonItemUiState(true)
end

function UINMiniGameMusicButtonItem:_OnMusicItemPressUp()
  if self.buttonUpCallback ~= nil then
    self.buttonUpCallback(self.buttonId)
  end
  self:_ChangeButtonItemUiState(false)
end

function UINMiniGameMusicButtonItem:_ChangeButtonItemUiState(isPress)
  if isPress then
    self.ui.img_ButtonItem:SetIndex(1)
    self.ui.tex_GamutNum.color = self.ui.color_Click
    self.ui.tex_GamutNum_1.color = self.ui.color_Click
    self.ui.tex_GamutEN.color = self.ui.color_Click
    self.ui.img_DotUp.color = self.ui.color_Click
    self.ui.img_DotDown.color = self.ui.color_Click
  else
    self.ui.img_ButtonItem:SetIndex(0)
    self.ui.tex_GamutNum.color = self.ui.color_NotClick
    self.ui.tex_GamutNum_1.color = self.ui.color_NotClick
    self.ui.tex_GamutEN.color = self.ui.color_NotClick
    self.ui.img_DotUp.color = self.ui.color_NotClick
    self.ui.img_DotDown.color = self.ui.color_NotClick
  end
end

return UINMiniGameMusicButtonItem
