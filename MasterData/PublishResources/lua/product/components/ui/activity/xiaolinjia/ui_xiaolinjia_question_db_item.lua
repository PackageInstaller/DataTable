_class("UIXiaoLinJiaQuestionDBItem", UICustomWidget)
UIXiaoLinJiaQuestionDBItem = UIXiaoLinJiaQuestionDBItem

function UIXiaoLinJiaQuestionDBItem:OnShow()
  self.atlas = self:RootUIOwner():GetAsset("XiaoLinJia.spriteatlas", LoadType.SpriteAtlas)
  self.title = self:GetUIComponent("UILocalizationText", "title")
  self.textList = {
    [1] = self:GetUIComponent("UILocalizationText", "questionText1"),
    [2] = self:GetUIComponent("UILocalizationText", "questionText2")
  }
  self.rightObjList = {
    [1] = self:GetGameObject("right1"),
    [2] = self:GetGameObject("right2")
  }
  self.playerHeadObjList = {
    [1] = self:GetGameObject("player1"),
    [2] = self:GetGameObject("player2")
  }
  self.roleHeadList = {
    [1] = self:GetUIComponent("Image", "role1"),
    [2] = self:GetUIComponent("Image", "role2")
  }
end

function UIXiaoLinJiaQuestionDBItem:SetData(session, selectIdx, icon, isRight)
  local title = StringTable.Get(session.Topic)
  local options = session.Options
  self.title:SetText(title)
  self.textList[1]:SetText(StringTable.Get(options[1]))
  self.textList[2]:SetText(StringTable.Get(options[2]))
  if isRight then
    self.rightObjList[selectIdx]:SetActive(true)
    self.playerHeadObjList[selectIdx]:SetActive(true)
    self.roleHeadList[selectIdx].gameObject:SetActive(true)
    self.roleHeadList[selectIdx].sprite = self.atlas:GetSprite(icon)
    self.textList[selectIdx].color = Color(1, 1, 1, 1)
  else
    local wrongIndex = 3 - selectIdx
    self.rightObjList[selectIdx]:SetActive(true)
    self.playerHeadObjList[wrongIndex]:SetActive(true)
    self.roleHeadList[selectIdx].gameObject:SetActive(true)
    self.roleHeadList[selectIdx].sprite = self.atlas:GetSprite(icon)
    self.textList[selectIdx].color = Color(1, 1, 1, 1)
  end
end
