require("ui_n12_map_controller")
_class("UIN12MapStoryController", UIN12MapController)
UIN12MapStoryController = UIN12MapStoryController

function UIN12MapStoryController:GetComponents()
  self._descTex = self:GetUIComponent("UILocalizationText", "desc")
  self._btnTex = self:GetUIComponent("UILocalizedTMP", "btnTex")
  self._passGo = self:GetGameObject("pass")
  self._alpha = self:GetUIComponent("CanvasGroup", "btnTex")
  self._btnImg = self:GetUIComponent("Image", "btn")
  self._btn = self:GetUIComponent("Button", "btn")
  self._contentSizeFitter = self:GetUIComponent("ContentSizeFitter", "btnTex")
  self._btnTexRect = self:GetUIComponent("RectTransform", "btnTex")
  self._atlas = self:GetAsset("UIN12_Entrust.spriteatlas", LoadType.SpriteAtlas)
end

function UIN12MapStoryController:OnValue()
  local cfg = self:Cfg()
  local params = cfg.Params[1]
  self._storyID = params.StoryID
  self._desc = params.Desc
  self:SetPass()
  local title
  if self._pass then
    title = StringTable.Get("str_n12_map_story_look_again")
  else
    title = StringTable.Get("str_n12_map_story_look")
  end
  self:SetTextMat()
  self._btnTex:SetText(title)
  self:ChangeTextWidth(self._btnTex)
  self._descTex:SetText(StringTable.Get(self._desc))
end

function UIN12MapStoryController:btnOnClick(go)
  GameGlobal.UIStateManager():ShowDialog("UIStoryController", self._storyID, function()
    if not self._pass then
      self:RequestFinishEvent()
    else
      self:CloseDialog()
    end
  end)
end

function UIN12MapStoryController:OnFinishEvent(rewards)
  if rewards and table.count(rewards) > 0 then
    self:ShowDialog("UIN12MapGetRewardsController", StringTable.Get("str_activity_battlepass_buy_deluxe_claim"), rewards, function()
      self:CloseDialog()
    end)
  else
    self:CloseDialog()
  end
end
