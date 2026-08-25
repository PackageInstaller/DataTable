local AvgDialogType = cd.AvgDialogType
local Vector3 = CS.UnityEngine.Vector3
local Vector2 = CS.UnityEngine.Vector2
local POS_FAR = Vector3(9999, 9999, 0)
local T_UIAnimationController = typeof(CS.Z1Client.UIAnimationController)
local AvgActionAvgNovel, Super = System.NewClass("AvgActionAvgNovel", AvgActionBase)

function AvgActionAvgNovel:ctor(...)
  Super.ctor(self, ...)
  self.novelUI = nil
  self.textGameObjs = {}
  self.freeTextGameObjs = {}
  self.textGameObjComps = {}
  self.textHeight = 0
  self.textGap = 70
  self.textOffsetX = 0
  self.contentHeight = 0
end

function AvgActionAvgNovel:DoAction(_, content)
  if not self.avgModel:IsDialogType(AvgDialogType.Novel, AvgDialogType.NovelEnd) then
    self:ClearNovel()
    return
  end
  if not content or "" == content then
    self:FinishAction()
    return
  end
  if not self.novelUI then
    self:CreateUINode()
  end
  self.novelUI.uiNode:SetActive(true)
  self:InsertContent(content)
  self:PlayEnterAnim()
end

function AvgActionAvgNovel:PlayEnterAnim()
  if 1 == #self.textGameObjs then
    self.animCtr:PlayState("UI_Story_Popup_Novel_Open")
  end
end

function AvgActionAvgNovel:CreateUINode()
  local asset = self.binder:LoadAsset(CommonRes.AvgNovel)
  local gameObj = self.binder:Instantiate(asset, self.ui.Group_UI.transform)
  local sibling = self.ui.Group_Dialog.transform:GetSiblingIndex()
  gameObj.transform:SetSiblingIndex(sibling + 1)
  self.binder:UpdateLocalizedTextAndResouce(gameObj)
  self.novelUI = UI_Story_Popup_NovelResource(gameObj)
  self.animCtr = gameObj:GetComponent(T_UIAnimationController)
  local tf = self.novelUI.Text_Content.transform
  self.textOffsetX = tf.localPosition.x
  tf.localPosition = POS_FAR
  self.contentHeight = self.novelUI.Content.transform.sizeDelta.y
  self.binder:BindEvent(EventMgr.Instance.OnStoryClickNext, System.fn(self, self.OnStoryClickNext))
end

function AvgActionAvgNovel:InsertContent(content)
  for _, textGameObj in ipairs(self.textGameObjs) do
    self.binder:SetTextColorType(textGameObj, cd.ColorType.Dark)
  end
  self.novelUI.Image_Next_Icon:SetActive(self.avgModel:IsDialogType(cd.AvgDialogType.Novel))
  self.novelUI.Image_Turn:SetActive(self.avgModel:IsDialogType(cd.AvgDialogType.NovelEnd))
  local textGameObj = table.remove(self.freeTextGameObjs)
  if not textGameObj then
    textGameObj = GameObject.Instantiate(self.novelUI.Text_Content, self.novelUI.Content.transform)
    self.textGameObjComps[textGameObj] = AvgTextComp(self.binder, textGameObj)
  end
  local avgTextComp = self.textGameObjComps[textGameObj]
  textGameObj.transform.localPosition = Vector3(self.textOffsetX, -self.textHeight, 0)
  table.insert(self.textGameObjs, textGameObj)
  self.binder:SetTextColorType(textGameObj, cd.ColorType.Light)
  self.binder:SetText(textGameObj, content)
  local tmpComp = self.binder:GetTextComp(textGameObj)
  self.textHeight = self.textHeight + tmpComp.preferredHeight + self.textGap
  self.novelUI.Content.transform.sizeDelta = Vector2(0, self.textHeight)
  if self.textHeight > self.contentHeight then
    self.novelUI.Content.transform.localPosition = Vector3(0, self.textHeight - self.contentHeight, 0)
  end
  avgTextComp:SetDialogText(content, self.avgModel.isAddQuote)
end

function AvgActionAvgNovel:OnStoryClickNext()
  if self:IsWaiting() then
    if not self.avgPanel.isAuto.value then
      self:StopTyping()
    end
    return
  end
  if not self.avgModel:IsDialogType(AvgDialogType.Novel, AvgDialogType.NovelEnd) then
    return
  end
  if self.avgModel:IsDialogType(AvgDialogType.NovelEnd) then
    self.animCtr:PlayState("UI_Story_Popup_Novel_Close", function()
      self:ClearNovel()
    end)
  end
  self.avgModel:NextDialog()
end

function AvgActionAvgNovel:IsWaiting()
  for _, gameObj in ipairs(self.textGameObjs) do
    local avgTextComp = self.textGameObjComps[gameObj]
    if avgTextComp and avgTextComp:IsPrinting() then
      return true
    end
    if avgTextComp and avgTextComp:IsWaitToRead() then
      return true
    end
  end
end

function AvgActionAvgNovel:StopTyping()
  for _, gameObj in ipairs(self.textGameObjs) do
    local avgTextComp = self.textGameObjComps[gameObj]
    if avgTextComp and avgTextComp:IsPrinting() then
      avgTextComp:StopTyping()
    end
  end
end

function AvgActionAvgNovel:ClearNovel()
  self:FinishAction()
  if not self.novelUI then
    return
  end
  self.textHeight = 0
  self.novelUI.uiNode:SetActive(false)
  self.novelUI.Content.transform.sizeDelta = Vector2.zero
  for i = 1, #self.textGameObjs do
    local textGameObj = self.textGameObjs[i]
    textGameObj.transform.position = POS_FAR
    local avgTextComp = self.textGameObjComps[textGameObj]
    if avgTextComp then
      avgTextComp:ClearDialogText()
    end
    table.insert(self.freeTextGameObjs, textGameObj)
  end
  self.textGameObjs = {}
end

function AvgActionAvgNovel:TweenShowCaptionBg()
end

function AvgActionAvgNovel:TweenHideCaptionBg(onComplete)
end

function AvgActionAvgNovel:StopTween()
  if self.tween then
    self.tween:Kill()
    self.tween = nil
  end
end

return AvgActionAvgNovel
