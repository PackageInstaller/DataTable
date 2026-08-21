_class("UISkillScopeChainItem", UICustomWidget)
UISkillScopeChainItem = UISkillScopeChainItem

function UISkillScopeChainItem:OnShow()
  self.txtNum = self:GetUIComponent("UILocalizationText", "txtNum")
  self._imgHighlight = self:GetGameObject("imgHighlight")
end

function UISkillScopeChainItem:Flush(chainNum, id)
  self._id = id
  self.txtNum.text = chainNum .. StringTable.Get("str_discovery_grid_chain")
end

function UISkillScopeChainItem:Highlight(isHighlight)
  local color = isHighlight and Color.white or Color.gray
  self.txtNum.color = color
  self._imgHighlight:SetActive(isHighlight)
end

function UISkillScopeChainItem:BtnOnClick(go)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.FlushSkillScope, self._id)
end
