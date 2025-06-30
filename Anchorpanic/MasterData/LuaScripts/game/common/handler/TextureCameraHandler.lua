local TextureCameraHandler = Class.class('TextureCameraHandler')
function TextureCameraHandler:ctor()
end

--设置3D纹理显示的摄像机GO
function TextureCameraHandler:setTextureCameraGO(go)
    self.m_textureCameraGO = go
end

--开启3D纹理显示的摄像机GO
function TextureCameraHandler:open()
    if(self.m_textureCameraGO)then
        self.m_textureCameraGO:SetActive(true)
        gs.CameraMgr:GetTextureCamera().enabled = true
    end
end

--关闭3D纹理显示的摄像机GO
function TextureCameraHandler:close()
    if(self.m_textureCameraGO)then
        self.m_textureCameraGO:SetActive(false)
        gs.CameraMgr:GetTextureCamera().enabled = false
    end
end

--获取3D纹理摄像机的渲染纹理
function TextureCameraHandler:getTexture()
    return gs.CameraMgr:GetTextureCamera().targetTexture
end

function TextureCameraHandler:set2Orthographic(beOrthographic)
    local ca = gs.CameraMgr:GetTextureCamera()
    ca.orthographic = beOrthographic
end

function TextureCameraHandler:getOrthographic()
    local ca = gs.CameraMgr:GetTextureCamera()
    return ca.orthographic
end

function TextureCameraHandler:setOrthographicSize(orthSize)
    local ca = gs.CameraMgr:GetTextureCamera()
    ca.orthographicSize = orthSize
end

function TextureCameraHandler:getOrthographicSize()
    local ca = gs.CameraMgr:GetTextureCamera()
    return ca.orthographicSize
end

return TextureCameraHandler
 
--[[ 替换语言包自动生成，请勿修改！
]]
