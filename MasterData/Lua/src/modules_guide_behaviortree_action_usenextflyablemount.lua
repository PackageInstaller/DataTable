local this = L_BevTree:registClass("guide.useNextFlyableMount", L_BevTree.action)

function this:param()
end

function this:parse()
end

function this:onEnter()
end

function this:execute()
  L_GuideManager:setWorldPause(false, self.tree.param.guideId)
  AzurWorld.mountMgr:SwitchNextFlyableMount()
  return L_BevTree.taskResult.Success
end
