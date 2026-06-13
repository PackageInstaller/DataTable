local MainHolderCtrl = BaseClass("MainHolderCtrl",UIBaseComponent)
local M = MainHolderCtrl

function M:__init()
    self._allSceneNames = {"Display02","CharacterShow","ShopBg","Lottery","Otaku","LuckDraw","FashionShow"}
    self._sceneName = nil
end

--按名字显示对应的模块
function M:ChangeDisplay(sceneName)
    self._view.lateState:SetState(sceneName)
    self._sceneName = sceneName
    -- for _,v in ipairs(self._allSceneNames) do 
    --     if self._view[v] then 
    --         self._view[v]:SetActive(v == sceneName)
    --     end
    -- end
end

function M:GetCurSceneName()
    return self._sceneName
end

--获得对应场景的holder
function M:GetHolder(sceneName)
    return self._view[sceneName]
end

return M