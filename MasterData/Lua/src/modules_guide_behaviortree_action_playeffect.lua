local this = L_BevTree:registClass("guide.playEffect", L_BevTree.action)

function this:param()
  self.pageName = ""
  self.targetPath = ""
  self.effectPath = ""
  self.scaleX = 1
  self.scaleY = 1
  self.dimension = ""
  self.offset = ""
  self.isDestroy = 0
  self.outAnimationName = ""
  self.isListItem = 0
end

function this:parse()
  self.pageName = self:getParam("pageName")
  self.targetPath = self:getParam("targetPath")
  self.effectPath = self:getParam("effectPath")
  self.scaleX = self:getParam("scaleX", true)
  self.scaleY = self:getParam("scaleY", true)
  self.isDestroy = self:getParam("isDestroy", true) ~= 0
  self.isUseListItem = self:getParam("isListItem", true) ~= 0
  self.outAnimationName = self:getParam("outAnimationName")
  self.dimension = self:getParam("dimension")
  self.offset = self:getParam("offset")
end

function this:onEnter()
  self.result = L_BevTree.taskResult.Running
end

function this:execute()
  if string.isEmpty(self.effectPath) then
    printf("guide提示", "特效路径是空的  ID: " .. self.id)
    return L_BevTree.taskResult.Failure
  end
  local parentTrans
  if self.isUseListItem then
    parentTrans = self.tree.targetListItem.transform
  else
    local page = L_UI:getPage(self.pageName)
    if page ~= nil then
      if string.isEmpty(self.targetPath) then
        parentTrans = page.transform
      else
        if not L_CommonUtil.isValid(page.gameObject) then
          return L_BevTree.taskResult.Failure
        end
        local node = page.gameObject.transform:Find(self.targetPath)
        if node ~= nil then
          parentTrans = node
        end
      end
    end
  end
  if parentTrans == nil then
    if self.isDestroy then
      return L_BevTree.taskResult.Success
    end
    return L_BevTree.taskResult.Running
  end
  local pathSplit = string.split(self.effectPath, "/")
  local effectName = string.split(pathSplit[#pathSplit], ".")[1]
  local effect = parentTrans:Find(effectName)
  if L_CommonUtil.isValid(effect) and self.isDestroy then
    if string.isEmpty(self.outAnimationName) then
      C_GameObject.DestroyImmediate(effect.gameObject)
    else
      L_EffectUtil.playAnimation(effect, self.outAnimationName, function()
        C_GameObject.DestroyImmediate(effect.gameObject)
      end)
    end
    self.tree.targetListItem = nil
  end
  if not self.isDestroy then
    local scale = L_Vector3.new(self.scaleX, self.scaleY, 1)
    local dimension
    local offset = C_Vector2.zero
    if not string.isEmpty(self.dimension) then
      local dimensionSplit = string.split(self.dimension, "|")
      dimension = C_Vector2(tonumber(dimensionSplit[1]), tonumber(dimensionSplit[2]))
    end
    if not string.isEmpty(self.offset) then
      local offsetSplit = string.split(self.offset, "|")
      offset = C_Vector2(tonumber(offsetSplit[1]), tonumber(offsetSplit[2]))
    end
    self.effectGameObject = L_EffectUtil.playEffect(self.effectPath, parentTrans, scale, offset, dimension)
  end
  return L_BevTree.taskResult.Success
end

function this:onReset()
  if not self.isDestroy and self.lastResult == L_BevTree.taskResult.Success and L_CommonUtil.isValid(self.effectGameObject) then
    C_GameObject.DestroyImmediate(self.effectGameObject)
  end
end

return this
