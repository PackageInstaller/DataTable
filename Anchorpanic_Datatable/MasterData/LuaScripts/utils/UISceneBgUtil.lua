--[[ 
-----------------------------------------------------
@filename       : UISceneBgUtil
@Description    : UI界面3D背景管理
@date           : 2023-06-15 14:04:09
@Author         : Jacob
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module('UISceneBgUtil', Class.impl())


--构造函数
function ctor(self)
    super.ctor(self)
end
--析构  
function dtor(self)
end

function create3DBg(self, sceneUrl)
    Perset3dHandler:toNormalShowData()
    Perset3dHandler:reset()
    Perset3dHandler:showMazeFog(false)
    self.mSCameraTrans = gs.CameraMgr:GetSceneCameraTrans()
    self.mDefCameraTrans = gs.CameraMgr:GetDefSceneCameraTrans()
    if self.mSCameraTrans and not gs.GoUtil.IsTransNull(self.mSCameraTrans) then
        self.mSCameraTrans.gameObject:SetActive(false)
    end
    if self.mDefCameraTrans and not gs.GoUtil.IsTransNull(self.mDefCameraTrans) then
        gs.CameraMgr:SetCameraBack(self.mDefCameraTrans)
        self.mDefCameraTrans.gameObject:SetActive(true)
        gs.TransQuick:LPos(self.mDefCameraTrans, gs.Vector3(0, 1000, 0))
        gs.TransQuick:SetLRotation(self.mDefCameraTrans, gs.VEC3_ZERO)
    end

    if self.mUI3DBgScene then
        logError("=========请检查是否上一个使用3D背景的UI没有调用reset======")
        gs.GameObject.Destroy(self.mUI3DBgScene)
        self.mUI3DBgScene = nil
    end

    if not self.mUI3DBgScene then
        self.mUI3DBgScene = gs.ResMgr:LoadGO(sceneUrl)
        gs.TransQuick:Pos(self.mUI3DBgScene.transform, gs.Vector3(0, 1000, 0))
    end

    return self.mUI3DBgScene
end

function reset(self)
    if self.mSCameraTrans and not gs.GoUtil.IsTransNull(self.mSCameraTrans) then
        self.mSCameraTrans.gameObject:SetActive(true)
    end
    if self.mDefCameraTrans and not gs.GoUtil.IsTransNull(self.mDefCameraTrans) then
        gs.TransQuick:LPos(self.mDefCameraTrans, gs.VEC3_ZERO)
        gs.TransQuick:SetLRotation(self.mDefCameraTrans, gs.VEC3_ZERO)
        self.mDefCameraTrans.gameObject:SetActive(false)
    end

    if self.mUI3DBgScene then
        gs.GameObject.Destroy(self.mUI3DBgScene)
        self.mUI3DBgScene = nil
    end
end


return _M