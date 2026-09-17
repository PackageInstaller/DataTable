local this = L_BevTree:registClass("guide.playAnimation", L_BevTree.action)

function this:param()
  self.pageName = ""
  self.targetPath = ""
  self.animationPrefabPath = ""
  self.animationName = ""
  self.stopAnimation = 0
end

function this:parse()
  self.pageName = self:getParam("pageName")
  self.targetPath = self:getParam("targetPath")
  self.animationPrefabPath = self:getParam("animationPrefabPath")
  self.animationName = self:getParam("animationName")
  self.stopAnimation = self:getParam("stopAnimation", true) ~= 0
end

function this:onEnter()
  local parentTrans = self:getParentTrans()
  if parentTrans == nil then
    self.result = L_BevTree.taskResult.Failure
    return self.result
  end
  if string.isEmpty(self.animationPrefabPath) then
    self.result = self:dealAnimation(parentTrans)
  else
    self.result = self:creatAnimation(parentTrans)
  end
end

function this:getParentTrans()
  if string.isEmpty(self.pageName) or string.isEmpty(self.targetPath) then
    self.result = L_BevTree.taskResult.Failure
    return nil
  end
  local page = L_UI:getPage(self.pageName)
  if page == nil then
    printf("guide提示", "没找到引导界面  ID: " .. self.id)
    return nil
  end
  local parentTrans = page.gameObject.transform:Find(self.targetPath).transform
  if parentTrans == nil then
    printf("guide提示", "没找到父节点  ID: " .. self.id)
    return nil
  end
  return parentTrans
end

function this:execute()
  if self.result == L_BevTree.taskResult.Running and self.animationNode ~= nil then
    local animation = self.animationNode:GetComponent(typeof(C_Animation))
    if not animation.isPlaying then
      animation:Play(self.animationName)
    end
  end
  return self.result
end

function this:onReset()
  if self.lastResult ~= L_BevTree.taskResult.Success and self.stopAnimation then
    local parentTrans = self:getParentTrans()
    if not parentTrans then
      return
    end
    if string.isEmpty(self.animationPrefabPath) then
      local animation = parentTrans:GetComponent(typeof(C_Animation))
      animation:Stop()
      if not string.isEmpty(self.animationName) then
        animation:Play(self.animationName)
      end
    else
      local animationNode = parentTrans:Find("guideAnimationPlay")
      if animationNode ~= nil then
        C_GameObject.DestroyImmediate(animationNode.gameObject)
      end
    end
  end
end

function this:playAnimation()
  local animation = self.animationNode:GetComponent(typeof(C_Animation))
  animation:Stop()
  if not string.isEmpty(self.animationName) then
    animation:Play(self.animationName)
  end
end

function this:dealAnimation(parentTrans)
  self.animationNode = parentTrans
  self:playAnimation()
  return L_BevTree.taskResult.Success
end

function this:creatAnimation(parentTrans)
  local animationNode = parentTrans:Find("guideAnimationPlay")
  if animationNode ~= nil then
    C_GameObject.DestroyImmediate(animationNode.gameObject)
    animationNode = nil
  end
  if self.stopAnimation then
    return L_BevTree.taskResult.Success
  end
  animationNode = L_ResPool:syncGameObject(self.animationPrefabPath)
  if animationNode == nil then
    return L_BevTree.taskResult.Failure
  end
  self.animationNode = animationNode
  self.animationNode.name = "guideAnimationPlay"
  self.animationNode.transform:SetParent(parentTrans)
  local rectTrans = self.animationNode:GetComponent(typeof(C_RectTransform))
  rectTrans.localScale = L_Vector3.one
  rectTrans.localPosition = L_Vector3.zero
  rectTrans.anchoredPosition = C_Vector2.zero
  self:playAnimation()
  return L_BevTree.taskResult.Success
end

return this
