local M = BaseClass("FreeChooseHeroSceneCtrl", Singleton)

--加载场景，实际上是一个独立的预制体
function M:LoadScene(path, loadComplete)
    if self._scene then
        if loadComplete then
            loadComplete()
        end
        return
    end
    self._loadComplete = loadComplete
    self._isLoading = false
    ResourceManager:GetInstance():InstanceCtrl(path, Bind(self, self._OnLoadComplete))
end

--切换英雄
function M:ChangeHero(heroId)
    if heroId ~= 0 and self._heroId == heroId then
        return
    end
    self._scene:SetHero(heroId)
    self._heroId = heroId
end

function M:_OnLoadComplete(ctrl)
    self._scene = ctrl
    --丢到一个看不到的地方，单独渲染
    self._scene:SetPos(2000, 0, 0)
    -- local cam = ICameraMgr:GetMainCamera()
    -- self._origailCamPos = cam.transform.position
    -- self._origailCamRot = cam.transform.rotation
    -- self._scene:SetCam(cam)
    RoleBehaviorCtrl:GetInstance():RemoveAllGirls()
    if self._loadComplete then
        self._loadComplete()
    end
    self._loadComplete = nil
end

function M:OnDispose()
    --还原相机
    -- local cam = ICameraMgr:GetMainCamera()
    -- if not IsNull(cam) and self._origailCamPos then
    --     local tran = cam.transform
    --     tran.position = self._origailCamPos
    --     tran.rotation = self._origailCamRot
    -- end

    if self._scene then
        self._scene:OnDestroy()
    end
    self._heroId = 0
    self._scene = nil
    self._loadComplete = nil
end

return M
