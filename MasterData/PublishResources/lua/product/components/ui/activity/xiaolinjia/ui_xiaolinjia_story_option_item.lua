_class("UIXiaoLinJiaStoryOptionItem", UICustomWidget)
UIXiaoLinJiaStoryOptionItem = UIXiaoLinJiaStoryOptionItem

function UIXiaoLinJiaStoryOptionItem:OnShow()
  self.atlas = self:RootUIOwner():GetAsset("XiaoLinJia.spriteatlas", LoadType.SpriteAtlas)
  self.bgList = {
    self:GetGameObject("bg1"),
    self:GetGameObject("bg2")
  }
  self.headObjList = {
    self:GetGameObject("Head1"),
    self:GetGameObject("Head2"),
    self:GetGameObject("Head3"),
    self:GetGameObject("Head4")
  }
  self.headList = {
    self:GetUIComponent("Image", "Head2"),
    self:GetUIComponent("Image", "Head3"),
    self:GetUIComponent("Image", "Head4")
  }
  self.root = self:GetGameObject("root")
  self.headRoot = self:GetGameObject("headRoot")
  self.content = self:GetUIComponent("UILocalizationText", "content")
  self.anim = self:GetUIComponent("Animation", "anim")
  self.animTime = {
    [1] = 150,
    [2] = 225
  }
end

function UIXiaoLinJiaStoryOptionItem:SetData(index, data, otherPlayerAnswer, missionCfg, callback)
  self.index = index
  self.data = data
  self.callback = callback
  self.bgList[index]:SetActive(true)
  self.content:SetText(StringTable.Get(data))
  for _, v in pairs(self.headObjList) do
    v:SetActive(false)
  end
  self.headRoot:SetActive(false)
  for i = 1, #otherPlayerAnswer do
    local head = self.headObjList[i + 1]
    head:SetActive(self.index == otherPlayerAnswer[i])
  end
  self.headList[1].sprite = self.atlas:GetSprite(missionCfg.ClosingHeadIcon)
  self.headList[2].sprite = self.atlas:GetSprite(missionCfg.OtherPlayerHeads[1])
  self.headList[3].sprite = self.atlas:GetSprite(missionCfg.OtherPlayerHeads[2])
  self:PlayInAnim()
end

function UIXiaoLinJiaStoryOptionItem:PlayInAnim()
  self.root:SetActive(false)
  self.optionItemAnimTask = self:StartTask(function(TT)
    self:Lock("UIXiaoLinJiaStoryOptionItem_PlayInAnim")
    YIELD(TT, self.animTime[self.index])
    if not tolua.isnull(self.root) and not tolua.isnull(self.anim) then
      self.root:SetActive(true)
      self.anim:Play("uieffanim_UIXiaoLinJiaStoryOptionItem_in")
    end
    self:UnLock("UIXiaoLinJiaStoryOptionItem_PlayInAnim")
    self.optionItemAnimTask = nil
  end)
end

function UIXiaoLinJiaStoryOptionItem:ShowAllSelectResult()
  self.headRoot:SetActive(true)
  self.anim:Play("uieffanim_UIXiaoLinJiaStoryOptionItem_select")
end

function UIXiaoLinJiaStoryOptionItem:SelectBtnOnClick()
  self.headObjList[1]:SetActive(true)
  self.callback(self.index)
end

function UIXiaoLinJiaStoryOptionItem:OnHide()
  if self.optionItemAnimTask then
    self:UnLock("UIXiaoLinJiaStoryOptionItem_PlayInAnim")
    GameGlobal.TaskManager():KillTask(self.optionItemAnimTask)
    self.optionItemAnimTask = nil
  end
end
