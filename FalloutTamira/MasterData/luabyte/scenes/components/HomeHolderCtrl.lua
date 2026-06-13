local HomeHolderCtrl = BaseClass("HomeHolderCtrl",UIBaseComponent)
local M = HomeHolderCtrl

function M:__init()
    self._allSceneNames = {"Home","FashionShow"}
    self._sceneName = nil
end

--按名字显示对应的模块
function M:ChangeDisplay(sceneName)
    self._view.lateState:SetState(sceneName)
    self._sceneName = sceneName
end

function M:GetCurSceneName()
    return self._sceneName
end

--获得对应场景的holder
function M:GetHolder(sceneName)
    return self._view[sceneName]
end

return M