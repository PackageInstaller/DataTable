local this = L_BevTree:registClass("guide.showComponentTips", L_BevTree.action)
local _guideWordsTpl = L_GameTpl:getGuideWordsTpl()

function this:param()
  self.pageName = ""
  self.targetPath = ""
  self.tipsKey = ""
  self.isFlipX = 0
  self.offsetX = 0
  self.offsetY = 0
  self.isDestroy = 0
end

function this:parse()
  self.pageName = self:getParam("pageName")
  self.targetPath = self:getParam("targetPath")
  self.tipsKey = self:getParam("tipsKey", true) or 0
  self.offsetX = self:getParam("offsetX", true) or 0
  self.offsetY = self:getParam("offsetY", true) or 0
  self.isFlipX = self:getParam("isFlipX", true) ~= 0
  self.isDestroy = self:getParam("isDestroy", true) ~= 0
end

function this:onEnter()
  self.result = L_BevTree.taskResult.Running
end

function this:execute()
  local page = L_UI:getPage(self.pageName)
  local parentTrans
  if page ~= nil then
    if string.isEmpty(self.targetPath) then
      parentTrans = page.transform
    else
      local node = page.gameObject.transform:Find(self.targetPath)
      if node ~= nil then
        parentTrans = node
      end
    end
  end
  if parentTrans == nil then
    if self.isDestroy then
      return L_BevTree.taskResult.Success
    end
    printf("guide提示: ", "没找到父节点" .. self.id)
    return L_BevTree.taskResult.Failure
  end
  local tipsPanel = L_CommonUtil.findTranByName("guideComponentTips", parentTrans)
  if L_CommonUtil.isValid(tipsPanel) then
    tipsPanel = tipsPanel.gameObject
  end
  if tipsPanel ~= nil and self.isDestroy then
    local animation = tipsPanel:GetComponent(typeof(C_Animation))
    if animation then
      animation:Play("anim_guide_tipout")
      local clip = animation:GetClip("anim_guide_tipout")
      Timer.once(clip.length, function()
        if tipsPanel then
          C_BoundGameObject.DestroyImmediate(tipsPanel)
        end
      end, self, tipsPanel)
    else
      C_BoundGameObject.DestroyImmediate(tipsPanel)
    end
  end
  if not self.isDestroy then
    self:creatTips(parentTrans)
  end
  return L_BevTree.taskResult.Success
end

function this:onReset()
  if not self.isDestroy and self.lastResult == L_BevTree.taskResult.Success and L_CommonUtil.isValid(self.tipsPanel) then
    C_BoundGameObject.DestroyImmediate(self.tipsPanel)
  end
end

function this:creatTips(parentTrans)
  local tipsPanel = L_ResPool:syncGameObject("UI/Pages/Guide/guideComponentTips.prefab")
  tipsPanel.name = "guideComponentTips"
  tipsPanel.transform:SetParent(parentTrans)
  local rectTrans = tipsPanel:GetComponent(typeof(C_RectTransform))
  local scaleX = self.isFlipX and -1 or 1
  rectTrans.localScale = L_Vector3.new(scaleX, 1, 1)
  rectTrans.localPosition = L_Vector3.zero
  rectTrans.anchoredPosition = C_Vector2(self.offsetX, self.offsetY)
  local tipText = tipsPanel:GetComponentInChildren(typeof(C_LTextMeshProUGUI))
  tipText.text = _guideWordsTpl:getWords(self.tipsKey)
  if self.isFlipX then
    local textRectTrans = tipText:GetComponent(typeof(C_RectTransform))
    textRectTrans.localScale = L_Vector3.new(-1, 1, 1)
  end
  self.tipsPanel = tipsPanel
end

return this
