--[[ 
-----------------------------------------------------
@filename       : EliminateThing
@Description    : 消消乐网格方格物件
@date           : 2022-3-2 
@Author         : zzz
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module("eliminate.EliminateThing", Class.impl())

function onRecover(self)
    if(self.mEffectIconSn)then
        gs.GOPoolMgr:CancelAsyc(self.mEffectIconSn)
    end
    if(self.mEffectIcon and not gs.GoUtil.IsGoNull(self.mEffectIcon))then
        gs.GameObject.Destroy(self.mEffectIcon)
    end
    self:removeEvents()
    self:stopMoveTweener()
    self:stopActionTweener()
    gs.GameObject.Destroy(self.mThingGo)
    self:initData()
end

function initData(self)
    self.mThingGo = nil
    self.mThingTrans = nil
    self.mChildGos = nil
    self.mChildTrans = nil

    self.mThingVo = nil
    self.mGoSelect = nil

    -- 物件icon图
    self.mImgIcon = nil
    self.mRectImgIcon = nil
    -- 物件icon图带动画
    self.mEffectIconSn = nil
    self.mEffectIcon = nil
    self.mRectEffectIcon = nil

    self.mIsMoveing = false
end

function create(self, thingVo, templateGo, parentTrans)
    self.mThingVo = thingVo
    self:configUI(templateGo, parentTrans)
    self:addEvents()
    self:updateView()
end

function configUI(self, templateGo, parentTrans)
    self.mThingGo = gs.GameObject.Instantiate(templateGo)
    self.mThingTrans = self.mThingGo:GetComponent(ty.RectTransform)
    self.mThingGo:SetActive(true)
    self.mThingTrans:SetParent(parentTrans, false)
    self.mChildGos, self.mChildTrans = GoUtil.GetChildHash(self.mThingGo)

    self.mGoSelect = self.mChildGos["mImgSelect"]
    self.mRectImgIcon = self.mChildGos["mIcon"]:GetComponent(ty.RectTransform)
    self.mImgIcon = self.mChildGos["mIcon"]:GetComponent(ty.AutoRefImage)
end

function getThingVo(self)
    return self.mThingVo
end

function addEvents(self)
    self.mThingVo:addEventListener(self.mThingVo.UPDATE_POS, self.onUpdatePosHandler, self)
    self.mThingVo:addEventListener(self.mThingVo.UPDATE_MOVE, self.onUpdateMoveHandler, self)
    self.mThingVo:addEventListener(self.mThingVo.UPDATE_SELECT, self.onUpdateSelectHandler, self)
end

function removeEvents(self)
    self.mThingVo:removeEventListener(self.mThingVo.UPDATE_POS, self.onUpdatePosHandler, self)
    self.mThingVo:removeEventListener(self.mThingVo.UPDATE_MOVE, self.onUpdateMoveHandler, self)
    self.mThingVo:removeEventListener(self.mThingVo.UPDATE_SELECT, self.onUpdateSelectHandler, self)
end

function onUpdatePosHandler(self)
    local localPosX, localPosY = eliminate.GetTileLocalPos(self.mThingVo.mapRow, self.mThingVo.mapCol, self.mThingVo.rowIndex, self.mThingVo.colIndex)
    gs.TransQuick:LPosXY(self.mThingTrans, localPosX, localPosY)
end

function onUpdateMoveHandler(self, args)
    self.mIsMoving = true
    local moveTime = args.moveTime
    local moveCall = args.moveCall
    local moveEaseTypeX = args.moveEaseTypeX
    local moveEaseTypeY = args.moveEaseTypeY
    self:stopMoveTweener()
    local localPosX, localPosY = eliminate.GetTileLocalPos(self.mThingVo.mapRow, self.mThingVo.mapCol, self.mThingVo.rowIndex, self.mThingVo.colIndex)
    self.mMoveTweener = self:moveToLocalPos(self.mThingTrans, localPosX, localPosY, moveTime, moveEaseTypeX, moveEaseTypeY, 
    function()
        self.mIsMoving = false
        if(moveCall)then
            moveCall()
        end
    end)
end

function moveToLocalPos(self, transform, lposX, lposY, duration, easeTypeX, easeTypeY, finishCall)
    local sequence = gs.DT.DOTween.Sequence()
    local tweenerX = transform:DOLocalMoveX(lposX, duration)
    local tweenerY = transform:DOLocalMoveY(lposY, duration)
    if easeTypeX then tweenerX:SetEase(easeTypeX) end
    if easeTypeY then tweenerY:SetEase(easeTypeY) end
    sequence:Join(tweenerX)
    sequence:Join(tweenerY)
    sequence:Play()

    if finishCall then
        sequence:OnComplete(finishCall)
    end
    return sequence
end

function onUpdateSelectHandler(self, args)
    self.mGoSelect:SetActive(args)
end

function updateView(self)
    self.mThingGo.name = eliminate.GetTileIdByRowCol(self.mThingVo.rowIndex, self.mThingVo.colIndex)

    if(eliminate.GetIsProp(self.mThingVo.thingType))then
        self.mImgIcon.gameObject:SetActive(false)
        local prefabName = nil
        if(self.mThingVo.thingType == eliminate.ThingType.ClearSame)then
            prefabName = "eliminate/EliminateThingClearSame.prefab"
        elseif(self.mThingVo.thingType == eliminate.ThingType.ClearRange)then
            prefabName = "eliminate/EliminateThingClearRange.prefab"
        elseif(self.mThingVo.thingType == eliminate.ThingType.ClearRow)then
            prefabName = "eliminate/EliminateThingClearRow.prefab"
        elseif(self.mThingVo.thingType == eliminate.ThingType.ClearCol)then
            prefabName = "eliminate/EliminateThingClearCol.prefab"
        elseif(self.mThingVo.thingType == eliminate.ThingType.ClearRowCol)then
            prefabName = "eliminate/EliminateThingClearRowCol.prefab"
        end
        if(prefabName)then
            local function _loadAysnCall(effectGo)
                if (effectGo) then
                    self.mEffectIcon = effectGo
                    self.mRectEffectIcon = effectGo:GetComponent(ty.RectTransform)
                    gs.TransQuick:SetParentOrg(self.mRectEffectIcon, self.mThingTrans)
                    gs.TransQuick:LPosXY(self.mRectEffectIcon, 0, 0)
                end
            end
            self.mEffectIconSn = gs.GOPoolMgr:GetAsyc(UrlManager:getUIPrefabPath(prefabName), _loadAysnCall)
        end
    else
        self.mImgIcon.gameObject:SetActive(true)
        self.mImgIcon:SetImg(self.mThingVo:getIcon(), false)
        gs.TransQuick:LPosXY(self.mRectImgIcon, 0, 0)
        gs.TransQuick:SizeDelta(self.mRectImgIcon, eliminate.GetTileSize(), eliminate.GetTileSize())
    end

    gs.TransQuick:SizeDelta(self.mThingTrans, eliminate.GetTileSize(), eliminate.GetTileSize())
    local localPosX, localPosY = eliminate.GetTileLocalPos(self.mThingVo.mapRow, self.mThingVo.mapCol, self.mThingVo.rowIndex, self.mThingVo.colIndex)
    gs.TransQuick:LPosXY(self.mThingTrans, localPosX, localPosY)
end

-- 播放下落动画
function playDropAction(self, finishCall, delayTime)
    -- if(not self.mThingGo or gs.GoUtil.IsGoNull(self.mThingGo))then return end
    -- self:stopActionTweener()

    -- self.mActionTweener = gs.DT.DOTween.Sequence()
    -- local widthTweener = self.mRectImgIcon:DOWidth(eliminate.GetTileSize() / 2, 0.1)
    -- local heightTweener = self.mRectImgIcon:DOHeight(eliminate.GetTileSize(), 0.1)

    -- if(delayTime and delayTime > 0)then
    --     self.mActionTweener:AppendInterval(delayTime)
    -- end
    
    -- self.mActionTweener:Append(widthTweener)
    -- self.mActionTweener:Join(heightTweener)
    -- self.mActionTweener:Play()
    -- if finishCall then
    --     self.mActionTweener:OnComplete(finishCall)
    -- end
end

-- 播放碰撞动画
function playCollideAction(self, finishCall, delayTime)
    -- if(not self.mThingGo or gs.GoUtil.IsGoNull(self.mThingGo))then return end
    -- self:stopActionTweener()

    -- self.mActionTweener = gs.DT.DOTween.Sequence()
    -- local widthTweener1 = self.mRectImgIcon:DOWidth(eliminate.GetTileSize() * 1.5, 0.04)
    -- local heightTweener1 = self.mRectImgIcon:DOHeight(eliminate.GetTileSize() * 0.85, 0.04)
    -- local posYTweener1 = self.mRectImgIcon:DOLocalMoveY(-eliminate.GetTileSize() * 0.15, 0.04)

    -- local widthTweener2 = self.mRectImgIcon:DOWidth(eliminate.GetTileSize(), 0.04)
    -- local heightTweener2 = self.mRectImgIcon:DOHeight(eliminate.GetTileSize(), 0.04)
    -- local posYTweener2 = self.mRectImgIcon:DOLocalMoveY(0, 0.04)

    -- if(delayTime and delayTime > 0)then
    --     self.mActionTweener:AppendInterval(delayTime)
    -- end

    -- self.mActionTweener:Append(widthTweener1)
    -- self.mActionTweener:Join(heightTweener1)
    -- self.mActionTweener:Join(posYTweener1)
    
    -- self.mActionTweener:Append(widthTweener2)
    -- self.mActionTweener:Join(heightTweener2)
    -- self.mActionTweener:Join(posYTweener2)
    -- self.mActionTweener:Play()
    -- if finishCall then
    --     self.mMoveTweener:OnComplete(finishCall)
    -- end
end

-- 恢复动画
function resumeAction(self, finishCall, delayTime)
    -- if(not self.mThingGo or gs.GoUtil.IsGoNull(self.mThingGo))then return end
    -- self:stopActionTweener()

    -- self.mActionTweener = gs.DT.DOTween.Sequence()
    -- local widthTweener = self.mRectImgIcon:DOWidth(eliminate.GetTileSize(), 0.2)
    -- local heightTweener = self.mRectImgIcon:DOHeight(eliminate.GetTileSize(), 0.2)
    -- local posYTweener = self.mRectImgIcon:DOLocalMoveY(0, 0.2)

    -- if(delayTime and delayTime > 0)then
    --     self.mActionTweener:AppendInterval(delayTime)
    -- end

    -- self.mActionTweener:Append(widthTweener)
    -- self.mActionTweener:Join(heightTweener)
    -- self.mActionTweener:Join(posYTweener)
    -- self.mActionTweener:Play()
    -- if finishCall then
    --     self.mMoveTweener:OnComplete(finishCall)
    -- end
end

function stopActionTweener(self)
    if (self.mActionTweener) then
        self.mActionTweener:Kill()
        self.mActionTweener = nil
    end
end

function stopMoveTweener(self)
    if (self.mMoveTweener) then
        self.mMoveTweener:Kill()
        self.mMoveTweener = nil
    end
end

function isMoving(self)
    return self.mIsMoving
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
