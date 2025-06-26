module("game.storyTalk.view.StoryTalkSpineView", Class.impl())

function dtor(self)
    gs.GameObject.Destroy(self.mRootGo)
end

function initData(self, sceneGo, backgroundGo, prefabPath)
    self.mRoot = sceneGo
    self.mRootGo = AssetLoader.GetGO(prefabPath)
    self.mRootGo.transform:SetParent(self.mRoot.transform)
    self.m_childGos, self.m2DViewChildTrans = GoUtil.GetChildHash(self.mRootGo)
    self.mBG                                = backgroundGo
    self.bgBounds                           = self.mBG:GetComponent(ty.MeshRenderer).bounds


    self:updateBG(prefabPath)
end

function destroy(self)
    self:dtor()
end

function updateBG(self, prefabPath)
    if prefabPath == self.prefabPath then
        return
    end
    self.prefabPath                   = prefabPath
    self.prefabName                   = string.match(prefabPath, ".*/([^/]+)%.prefab")
    local spineNode                   = self:getChildGO(self.prefabName)
    local spineBounds                 = spineNode:GetComponent(ty.MeshRenderer).bounds
    local spineNode                   = self:getChildGO(self.prefabName)

    -- 设置RootGo的layer为Role
    self.mRootGo.layer                = gs.LayerMask.NameToLayer("Role")
    spineNode.layer                   = gs.LayerMask.NameToLayer("Role")

    --设置宽高
    self.mRootGo.transform.position   = self.mBG.transform.position;
    -- 计算缩放比例，使Prefab的大小与背景图相同(以背景图的宽高中较大的一边为基准进行缩放)
    local scaleX                      = self.bgBounds.size.x / spineBounds.size.x;
    local scaleY                      = self.bgBounds.size.y / spineBounds.size.y;
    local uniformScale                = math.max(scaleX, scaleY)
    self.mRootGo.transform.localScale = gs.Vector3(uniformScale, uniformScale, 1);

    -- 关闭mGroup下不必要的节点
    local imgBg                       = self:getChildGO("mImgBg")
    if imgBg then imgBg:SetActive(false) end
    local mask = self:getChildGO("mask")
    if mask then mask:SetActive(false) end
end

function getChildTrans(self, transName)
    return self.m_childTrans[transName]
end

function getChildGO(self, name)
    if not name then
        error('name is nil', 2)
    end
    if self.m_childGos then
        return self.m_childGos[name]
    end
    logError("getChildGO 未包含名称为" .. name .. "的子物体")
    return nil
end

return _M
