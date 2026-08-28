
--region global define
local isNull    = isNull
local isNotNull = isNotNull

--endregion

--region import

--endregion

--region define

--endregion

--- from: Assets/BundleResources/Prefabs/Common/BossDrawingNode.prefab > name: BossDrawingNode
---@class DrawingNode
---@field Env                           	DrawingNode                             
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field DrawingNode                   	Game.Native.Common.DrawingNode          
local DrawingNode = Class('DrawingNode')

function DrawingNode:__init()
    self._isStart   = false

    --- 渲染皮肤所需参数
    self._skinId    = nil
    self._loc       = nil
    self._poolSize  = nil
    self._fieldName  = nil

    self._isChanged = false
end


function DrawingNode:__delete()

end


function DrawingNode:Awake()
    -- self.DrawingNode.childImage:CrossFadeAlpha(0, 0, false)
end


function DrawingNode:Start()
    --- 防止默认情况下节点被隐藏
    if not self._isEnableAlpha then
        return
    end
    self.DrawingNode.childImage:CrossFadeAlpha(0, 0, false)
    self._isStart = true
    self:ShowSkin()
end

function DrawingNode:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


--region init 


--endregion 


--region logic 

function DrawingNode:ShowSkin()
    if not self._isChanged then
        return
    end
    local childImage = self.DrawingNode.childImage
    --- 防止快速切换的时候闪动
    childImage:CrossFadeAlpha(0, 0, false)
    self.DrawingNode:Execute(self._skinId, self._loc, self._poolSize, self._fieldName)
    local isNullImage = isNull(childImage.texture)
    --- 由于Game.Native.Common.DrawingNode 中 针对非编辑器 是先LoadSprite 设置OnFinish 
    --- 如果在Start启用了CrossFadeAlpha 回导致图显示不出来（同步的情况：1. 有loader缓存 2.编辑器下）
    --- Execute前是空图 并且 Execute直接就有图的情况下 调用下显示图片
    local seconds = isNullImage and 0.2 or 0
    if isNotNull(childImage) then
        childImage:CrossFadeAlpha(1, seconds, false)
    end
end

--endregion 


--region get/set 

function DrawingNode:SetParams(skinId, loc, poolSize, fieldName)
    self._isEnableAlpha = true
    self._isChanged = skinId ~= self._skinId or not self._isStart
    self._skinId    = skinId
    self._loc       = loc or -1
    self._poolSize  = poolSize or -1
    self._fieldName  = fieldName or "hdCardDrawing"
    if self._isStart then
        self:ShowSkin()
    end
end

---endregion 


--region handler 


---endregion 


return DrawingNode
