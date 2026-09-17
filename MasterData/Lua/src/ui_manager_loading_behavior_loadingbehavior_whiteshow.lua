local this = class("loadingBehavior_whiteShow", require("ui.manager.loading.behavior.loadingBehavior"))
local _tipTpl = L_GameTpl:getTipsTpl()
local _tipGroupTpl = L_GameTpl:getTipsGroupTpl()

function this:bind()
  return {
    imgScene = "",
    fillImg = 0,
    txtTip = "",
    colorBg = C_Color(1, 1, 1, 1)
  }
end

function this.methods()
  return {
    onClick_next = function(self)
    end
  }
end

function this:initConfig()
  local sceneId = AzurWorldInstance.CurWorldId
  local tpl = _tipTpl:getTplBySceneIdOrDefault(sceneId)
  self.gId = _tipTpl:getGroupId(tpl)
  self.index = 1
end

function this:refreshView(gId, index)
  local tpl = this.super.refreshView(self, gId, index)
  local bgType = _tipGroupTpl:getBgType(tpl)
  if bgType ~= L_Const.loadingBgType.none then
    local isMask = bgType == L_Const.loadingBgType.mask
    self.bind.imgScene = _tipGroupTpl:getBg(tpl)
    self.bindComponents.rTransMaskBottom.gameObject:ActiveTrans(not isMask)
    self.bindComponents.rTransMaskUpBottom.gameObject:ActiveTrans(isMask)
  end
  return tpl
end

function this:refreshColor()
  local color = this.super.refreshColor(self)
  self:refreshChildColor(self.bindComponents.rTransMaskBottom, color)
  self:refreshChildColor(self.bindComponents.rTransMaskUpBottom, color)
end

function this:refreshChildColor(trans, color)
  local imgs = trans:GetComponentsInChildren(typeof(C_LImage))
  if imgs.Length == 0 then
    return
  end
  for i = 0, imgs.Length - 1 do
    local img = imgs[i]
    img.color = color
  end
end

return this
