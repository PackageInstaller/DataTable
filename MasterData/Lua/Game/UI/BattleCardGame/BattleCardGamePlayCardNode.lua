-------------------------------------------------------------------------------
-- 和风战牌 - 游戏卡牌节点
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2024-08-13 16:20:25
-------------------------------------------------------------------------------

local DOTween              = CS.DG.Tweening.DOTween
local TweenEase            = CS.DG.Tweening.Ease
local UnityTime            = CS.UnityEngine.Time
local RectTransformUtility = CS.UnityEngine.RectTransformUtility
local LuaParametersReader  = import('Game.Utils.LuaParametersReader')
local BattleCardGameUtils  = import('Game.UI.BattleCardGame.BattleCardGameUtils')
local battleCardGameComp   = BattleCardGameUtils.GetComp()

local StatusDefine = {
    StandbyScale       = 0.45, -- 在手牌区的缩放
    PickUpScale        = 0.65, -- 手牌区拿起的缩放
    OnBoardScale       = 0.55, -- 在棋盘上的缩放
    PitchAngleMax      = 25,   -- 拖动的最大摆动幅度
    PitchAngleMin      = -25,  -- 拖动的最小摆动幅度
    PitchSmoothness    = 5,    -- 拖动的变化缓动度
    DragVelocityFactor = 10,   -- 拖动的灵敏度（距离变化的放大系数）
    ShadowOffset       = 120,  -- 影子偏移距离
}

local AnimatorTrigger = {
    Flip      = 'Flip',      -- 翻牌
    Select    = 'Select',    -- 选中
    Unselect  = 'Cancel',    -- 取消选中
    Drop      = 'Drop',      -- 落牌
    ToEating  = 'Defeat',    -- 吃牌
    BeEaten   = 'Reversal',  -- 被吃
    OnBoard   = 'OnBoard',   -- 落盘上
    OrderWait = 'OrderWait', -- 等待排序
    OrderPlay = 'OrderPlay', -- 开始排序
    AttrPlay  = 'AttrPlay',  -- 属性变化
}

local AnimatorState = {
    OnFront = 'Front',
    OnBoard = 'Front_OnBoard',
}

local AnimationName = {
    FlipFold     = 'PokerCardNode_Flip_BackToSide',
    FlipUnfold   = 'PokerCardNode_Flip_SideToFront',
    OrderWait    = 'PokerCardNode_Order_Wait',
    OrderPlay    = 'PokerCardNode_Order',
    CardSelect   = 'PokerCardNode_Front_Slected',
    CardUnselect = 'PokerCardNode_Front_UnSlected',
    DropBoard    = 'PokerCardNode_Front_DropDown',
    ToEating     = 'PokerCardNode_Front_OnCheckerboard_Defeat',
    BeEaten      = 'PokerCardNode_Front_OnCheckerboard_Reversal',
    AttrPlay     = 'PokerCardNode_Attr_Play',
}

--- from: Assets/BundleResources/Prefabs/ActivityJapaneseLevel/PokerBattle/ActivityJapanesePokerCardNode.prefab > name: ActivityJapanesePokerCardNode
---@class BattleCardGamePlayCardNode
---@field Env                           	BattleCardGamePlayCardNode              
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field RootNode                      	UnityEngine.RectTransform               	@ 0    
---@field PokerCardNode                 	UnityEngine.RectTransform               	@ 1    卡牌基础节点
---@field DepthLayerDown                	UnityEngine.RectTransform               	@ 2    深度图层-下
---@field DepthLayerMid2                	UnityEngine.RectTransform               	@ 3    深度图层-中2
---@field DepthLayerMid1                	UnityEngine.RectTransform               	@ 4    深度图层-中1
---@field DepthLayerUp                  	UnityEngine.RectTransform               	@ 5    深度图层-上
---@field CardShadow                    	UnityEngine.RectTransform               	@ 6    卡牌影子
local BattleCardGamePlayCardNode = Class('BattleCardGamePlayCardNode')


function BattleCardGamePlayCardNode:__init()
    ---@type BattleCardGameCardNode @ 战牌本体
    self.battleCardNode_ = nil

    ---@type UnityEngine.RectTransform @ 父级的RectTransform
    self.cardNodeParentRT_ = nil

    ---@type UnityEngine.Animator @ 自身动画状态机
    self.cardNodeAnimator_ = nil

    ---@type integer @ 初始层级位置
    self.initSiblingIndex_ = 0

    ---@type boolean @ 是否拖拽中
    self.isPointerDragging_ = false

    ---@type Vector3 @ 拖拽前的原始坐标
    self.dragOriginVector_ = Vector3(0, 0, 0)

    ---@type Vector3 @ 拖拽中的偏移坐标
    self.dragOffsetVector_ = Vector3(0, 0, 0)

    ---@type Vector2 @ 距离上次移动的距离
    self.deltaPosition_ = Vector2(0, 0)

    ---@type table[] @ 景深层级数据
    self.pitchViewDatas_ = {}

    ---@type UnityEngine.Transform[] @ 特效切换节点集合
    self.uifxSwitchNodes_ = {}
end


function BattleCardGamePlayCardNode:__delete()
    self.battleCardNode_    = nil
    self.cardNodeParentRT_  = nil
    self.cardNodeAnimator_  = nil
    self.initSiblingIndex_  = nil
    self.isPointerDragging_ = nil
    self.dragOriginVector_  = nil
    self.dragOffsetVector_  = nil
    self.deltaPosition_     = nil
    self.pitchViewDatas_    = nil
    self.uifxSwitchNodes_   = nil
end


function BattleCardGamePlayCardNode:Awake()
    self.battleCardNode_ = CfUtils.GetLuaScr(self.PokerCardNode, BattleCardGameUtils.LuaSrcPath.BaseCardNode)

    local luaParams = CfUtils.GetOrAddComponent(self.controller, CS.Engine.Modules.LuaParameters)
    local paramType = LuaParametersReader.Type.Float
    self.pitchViewDatas_ = {
        {
            transform = self.DepthLayerUp,
            distance  = LuaParametersReader.Read(luaParams, 'DepthLayerUp', paramType),
        },
        {
            transform = self.DepthLayerMid2,
            distance  = LuaParametersReader.Read(luaParams, 'DepthLayerMid2', paramType),
        },
        {
            transform = self.DepthLayerMid1,
            distance  = LuaParametersReader.Read(luaParams, 'DepthLayerMid1', paramType),
        },
        {
            transform = self.DepthLayerDown,
            distance  = LuaParametersReader.Read(luaParams, 'DepthLayerDown', paramType),
        }
    }

    -- 卡牌响应拖动事件
    local dragEventProxy = CS.Engine.UI.EventDragProxy.Create(self.controller.gameObject)
    dragEventProxy.onPointerBeginDrag = Bind(self, self.OnNodeDragBeginHandler_)
    dragEventProxy.onPointerDrag = Bind(self, self.OnNodeDragMovedHandler_)
    dragEventProxy.onPointerEndDrag = Bind(self, self.OnNodeDragEndedHandler_)

    SetButtonAction(self.PokerCardNode, Bind(self, self.OnClickCardNodeHandler_))
    
    self.cardUpdateAction_ = CfUtils.BehaviourActionAdd(self.controller, Bind(self, self.OnCardUpdateBehaviourHandler_))
    self.cardNodeAnimator_ = CfUtils.GetOrAddComponent(self.controller, CS.UnityEngine.Animator)
    self.cardNodeParentRT_ = CfUtils.GetRectTransform(self.controller.transform.parent)
    self.initSiblingIndex_ = self.cardNodeParentRT_:GetSiblingIndex()
    self.uifxSwitchNodes_  = {
        -- 吃牌特效
        self.controller.transform:Find('UIFX_ActivityJapanesePokerPlayerBattleDialog_Defeat/Root/UIFX_Frame'),
        self.controller.transform:Find('UIFX_ActivityJapanesePokerPlayerBattleDialog_Defeat/Root/UIFX_Line1'),
        self.controller.transform:Find('UIFX_ActivityJapanesePokerPlayerBattleDialog_Defeat/Root/UIFX_Line2'),
        self.controller.transform:Find('UIFX_ActivityJapanesePokerPlayerBattleDialog_Defeat/Root/UIFX_Lizi'),
        self.controller.transform:Find('UIFX_ActivityJapanesePokerPlayerBattleDialog_Defeat/Root/UIFX_Glow'),
        self.controller.transform:Find('UIFX_ActivityJapanesePokerPlayerBattleDialog_Defeat/Root/UIFX_Glow2'),
        -- 被吃特效
        self.controller.transform:Find('UIFX_ActivityJapanesePokerPlayerBattleDialog_Reversal/Root/UIFX_Smoke'),
        self.controller.transform:Find('UIFX_ActivityJapanesePokerPlayerBattleDialog_Reversal/Root/UIFX_Frame'),
        self.controller.transform:Find('UIFX_ActivityJapanesePokerPlayerBattleDialog_Reversal/Root/UIFX_Lizi'),
        self.controller.transform:Find('UIFX_ActivityJapanesePokerPlayerBattleDialog_Reversal/Root/UIFX_Glow'),
        self.controller.transform:Find('UIFX_ActivityJapanesePokerPlayerBattleDialog_Reversal/Root/UIFX_Glow2'),
        self.controller.transform:Find('UIFX_ActivityJapanesePokerPlayerBattleDialog_Reversal/Root/UIFX_Glow3'),
    }
end


function BattleCardGamePlayCardNode:Start()
end


function BattleCardGamePlayCardNode:OnDestroy()
    CfUtils.BehaviourActionDel(self.cardUpdateAction_)
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


-------------------------------------------------
-- get / set

---@return BattleCardGameCardNode
function BattleCardGamePlayCardNode:GetCardNode()
    return self.battleCardNode_
end


--- 手牌的索引顺序
---@return integer
function BattleCardGamePlayCardNode:GetCardIndex()
    return checkInt(self.cardIndex_)
end
function BattleCardGamePlayCardNode:SetCardIndex(cardIndex)
    self.cardIndex_ = checkInt(cardIndex)
end


--- 是否启用 拖拽事件
---@return boolean
function BattleCardGamePlayCardNode:IsDraggable()
    return self.isDraggable_
end
function BattleCardGamePlayCardNode:SetDraggable(isDraggable)
    self.isDraggable_ = checkBool(isDraggable)
end


--- 是否启用 点击事件
---@return boolean
function BattleCardGamePlayCardNode:IsClickable()
    return self.isClickable_
end
function BattleCardGamePlayCardNode:SetClickable(isClickable)
    self.isClickable_ = checkBool(isClickable)
end


--- 是否启用 图层景深效果
---@return boolean
function BattleCardGamePlayCardNode:IsLayerDepth()
    return self.isLayerDepth_
end
function BattleCardGamePlayCardNode:SetLayerDepth(isEnabled)
    self.isLayerDepth_ = checkBool(isEnabled)
    -- 关闭的话，重置一下状态
    if not self:IsLayerDepth() then
        self:ResetCardOnVelocity_()
        self:ResetChildPositions_()
    end
end


---@return fun(sender:BattleCardGamePlayCardNode):void
function BattleCardGamePlayCardNode:GetClickCardCb()
    return self.clickCardCb_
end
function BattleCardGamePlayCardNode:SetClickCardCb(callback)
    self.clickCardCb_ = callback
end


---@return fun(sender:BattleCardGamePlayCardNode):boolean
function BattleCardGamePlayCardNode:GetDragBeginCb()
    return self.dragBeginCb_
end
function BattleCardGamePlayCardNode:SetDragBeginCb(callback)
    self.dragBeginCb_ = callback
end


---@return fun(sender:BattleCardGamePlayCardNode, checkCollisionCb:fun(target:UnityEngine.GameObject):boolean):void
function BattleCardGamePlayCardNode:GetDragMovedCb()
    return self.dragMovedCb_
end
function BattleCardGamePlayCardNode:SetDragMovedCb(callback)
    self.dragMovedCb_ = callback
end


---@return fun(sender:BattleCardGamePlayCardNode, checkCollisionCb:fun(target:UnityEngine.GameObject):boolean):boolean
function BattleCardGamePlayCardNode:GetDragEndedCb()
    return self.dragEndedCb_
end
function BattleCardGamePlayCardNode:SetDragEndedCb(callback)
    self.dragEndedCb_ = callback
end


-------------------------------------------------
-- public

--- 调整层级深度置顶
function BattleCardGamePlayCardNode:AdjustOrderToTop()
    local topSiblingIndex = self.cardNodeParentRT_.childCount
    self:UpdateNodOrderIndex_(topSiblingIndex)
end


--- 移动到目标节点位置
---@param siteNode UnityEngine.RectTransform
function BattleCardGamePlayCardNode:MoveToSiteNode(siteNode)
    if isNull(siteNode) then return end
    self.controller.transform.anchoredPosition = CfUtils.UIWorldToScreenPos(siteNode, self.controller.transform.parent)
end


--- 打断拖拽动作
function BattleCardGamePlayCardNode:BreakDragAction()
    self.isPointerDragging_ = false
end


--- 标记灰色禁用效果
---@param isGray boolean
function BattleCardGamePlayCardNode:MarkCardGrayEffect(isGray)
    CfUtils.MarkGray(self.PokerCardNode, isGray)
end


--- 合并额外的类型属性加成map
---@param extAttrMap table<integer, integer>
---@return boolean @ 是否有属性发生变化
function BattleCardGamePlayCardNode:MergerExtAttrMap(extAttrMap)
    local extCardAttrNum   = checkInt(extAttrMap[self:GetCardNode():GetBattleCardType()])
    local oldCustomAttrMap = self:GetCardNode():GetCustomAttrMap()
    local newCustomAttrMap = {}
    for attrIndex, attrValue in pairs(self:GetCardNode():GetBaseAttrMap()) do
        newCustomAttrMap[attrIndex] = attrValue + extCardAttrNum
    end
    self:GetCardNode():SetCustomAttrMap(newCustomAttrMap)

    local hasAttrChanged = false
    for attrIndex, attrValue in pairs(newCustomAttrMap) do
        if oldCustomAttrMap[attrIndex] ~= attrValue then
            hasAttrChanged = true
            break
        end
    end
    return hasAttrChanged
end


--- 播放: 高亮提示
function BattleCardGamePlayCardNode:PlayHightlightTips()
    CfUtils.PlayAlphaAnimator(self.controller.gameObject, 0.2, 0.5, 1)
end


--- 切状态：手牌区待机
function BattleCardGamePlayCardNode:StatusToStandby()
    self:ResetAnimatorTriggers_()
    CfUtils.PlayAnimator(self.controller, AnimatorState.OnFront)
end


--- 切状态：手牌区拿起
function BattleCardGamePlayCardNode:StatusToPickUp()
    local actionTime = CfUtils.GetAnimatorTime(self.controller, AnimationName.CardSelect)
    self.cardNodeAnimator_:SetTrigger(AnimatorTrigger.Select)
    return actionTime
end


--- 切状态：手牌区放下
function BattleCardGamePlayCardNode:StatusToPutDown()
    local actionTime = CfUtils.GetAnimatorTime(self.controller, AnimationName.CardUnselect)
    self.cardNodeAnimator_:SetTrigger(AnimatorTrigger.Unselect)
    return actionTime
end


--- 切状态：棋盘区待机
function BattleCardGamePlayCardNode:StatusToBoard()
    self:ResetAnimatorTriggers_()
    CfUtils.PlayAnimator(self.controller, AnimatorState.OnBoard)
end


--- 切状态：棋盘区放下
---@return number @ 动画时长
function BattleCardGamePlayCardNode:PlayStatusToDropBoard(siteNode, isSelect)
    local sequence    = DOTween.Sequence()
    local anchoredPos = CfUtils.UIWorldToScreenPos(siteNode, self.controller.transform.parent)
    local sizeWidth   = self.RootNode.sizeDelta.x
    local currentX    = checkInt(self.controller.transform.localPosition.x)
    local targetX     = checkInt(anchoredPos.x)
    local moveTime    = math.floor(math.abs(targetX - currentX) / sizeWidth) * 0.1
    local selectTime  = CfUtils.GetAnimatorTime(self.controller, AnimationName.CardSelect)
    local dropTime    = CfUtils.GetAnimatorTime(self.controller, AnimationName.DropBoard)
    if isSelect then
        self.cardNodeAnimator_:SetTrigger(AnimatorTrigger.Select)
        moveTime = math.max(moveTime, selectTime)
    end
    -- 先移动到棋盘格中心，再落下
    local actionTime = moveTime + dropTime
    self.controller.transform:DOLocalMove(Vector3(anchoredPos.x, anchoredPos.y, 0), moveTime):SetEase(TweenEase.OutQuad)
    sequence:AppendInterval(moveTime)
    sequence:AppendCallback(function()
        self.cardNodeAnimator_:SetTrigger(AnimatorTrigger.Drop)
    end)
    sequence:AppendInterval(dropTime)
    sequence:PlayForward()
    return actionTime
end


--- 切状态：放回手牌区
---@return number @ 动画时长
function BattleCardGamePlayCardNode:PlayStatusToRevert(siteNode, isPickUp)
    local actionTime  = CfUtils.GetAnimatorTime(self.controller, AnimationName.CardUnselect)
    local anchoredPos = CfUtils.UIWorldToScreenPos(siteNode, self.controller.transform.parent)
    self.controller.transform:DOLocalMove(Vector3(anchoredPos.x, anchoredPos.y, 0), actionTime):SetEase(TweenEase.OutQuad)
    if not isPickUp then
        self.cardNodeAnimator_:SetTrigger(AnimatorTrigger.Unselect)
    end
    return actionTime
end


--- 播放翻牌动画
---@param invisibleCb fun():void | nil @ 翻转到中间时的回调
---@return number @ 动画时长
function BattleCardGamePlayCardNode:PlayFlipAnim(invisibleCb)
    local sequence       = DOTween.Sequence()
    local flipFoldTime   = CfUtils.GetAnimatorTime(self.controller, AnimationName.FlipFold)
    local flipUnfoldTime = CfUtils.GetAnimatorTime(self.controller, AnimationName.FlipUnfold)
    local actionTime     = flipFoldTime + flipUnfoldTime
    sequence:AppendInterval(flipFoldTime)
    sequence:AppendCallback(function()
        if invisibleCb then invisibleCb() end
    end)
    sequence:AppendInterval(flipUnfoldTime)
    sequence:PlayForward()
    self.cardNodeAnimator_:SetTrigger(AnimatorTrigger.Flip)
    return actionTime
end


--- 播放属性变化动画
---@return number @ 动画时长
function BattleCardGamePlayCardNode:PlayAttrAnim()
    local actionTime = CfUtils.GetAnimatorTime(self.controller, AnimationName.AttrPlay)
    self.cardNodeAnimator_:SetTrigger(AnimatorTrigger.AttrPlay)
    return actionTime
end


---@return number @ 动画时长
function BattleCardGamePlayCardNode:PlayToEatAnim(isRedPlayMode)
    self:SwitchUifxNodesStyle_(isRedPlayMode)
    local actionTime = CfUtils.GetAnimatorTime(self.controller, AnimationName.ToEating)
    self.cardNodeAnimator_:SetTrigger(AnimatorTrigger.ToEating)
    return actionTime
end


---@return number @ 动画时长
function BattleCardGamePlayCardNode:PlayBeEatenAnim(isRedPlayMode, swallowDir, invisibleCb)
    self:SwitchUifxNodesStyle_(isRedPlayMode)
    local sequence       = DOTween.Sequence()
    local beEatenTime    = CfUtils.GetAnimatorTime(self.controller, AnimationName.BeEaten)
    local flipFoldTime   = CfUtils.GetAnimatorTime(self.controller, AnimationName.FlipFold)
    local flipUnfoldTime = CfUtils.GetAnimatorTime(self.controller, AnimationName.FlipUnfold)
    local actionTime     = beEatenTime + flipFoldTime + flipUnfoldTime
    sequence:AppendInterval(beEatenTime)
    sequence:AppendCallback(function()
        self.cardNodeAnimator_:SetTrigger(AnimatorTrigger.Flip)
    end)
    sequence:AppendInterval(flipFoldTime)
    sequence:AppendCallback(function()
        if invisibleCb then invisibleCb() end
    end)
    sequence:AppendInterval(flipUnfoldTime)
    sequence:PlayForward()
    self.cardNodeAnimator_:SetTrigger(AnimatorTrigger.BeEaten)
    return actionTime
end


---@return number @ 动画时长
function BattleCardGamePlayCardNode:PlayRuleAnimByPublic(publicIndex, invisibleCb)
    local sequence       = DOTween.Sequence()
    local flipWaitTime   = CfUtils.GetAnimatorTime(self.controller, AnimationName.OrderWait) * publicIndex
    local flipFoldTime   = CfUtils.GetAnimatorTime(self.controller, AnimationName.FlipFold)
    local flipUnfoldTime = CfUtils.GetAnimatorTime(self.controller, AnimationName.FlipUnfold)
    local actionTime     = flipWaitTime + flipFoldTime + flipUnfoldTime
    sequence:AppendInterval(flipWaitTime)
    sequence:AppendCallback(function()
        if self:GetCardNode():IsBackState() then
            self.cardNodeAnimator_:SetTrigger(AnimatorTrigger.Flip)
        end
    end)
    sequence:AppendInterval(flipFoldTime)
    sequence:AppendCallback(function()
        if invisibleCb then invisibleCb() end
    end)
    sequence:AppendInterval(flipUnfoldTime)
    sequence:PlayForward()
    return actionTime
end


---@return number @ 动画时长
function BattleCardGamePlayCardNode:PlayRuleAnimByOrder(orderIndex, orderPlayCb)
    local sequence      = DOTween.Sequence()
    local orderWaitTime = CfUtils.GetAnimatorTime(self.controller, AnimationName.OrderWait) * orderIndex
    local orderPlayTime = CfUtils.GetAnimatorTime(self.controller, AnimationName.OrderPlay)
    local actionTime    = orderWaitTime + orderPlayTime
    sequence:AppendInterval(orderWaitTime)
    sequence:AppendCallback(function()
        if orderPlayCb then orderPlayCb() end
        self.cardNodeAnimator_:SetTrigger(AnimatorTrigger.OrderPlay)
    end)
    sequence:AppendInterval(orderPlayTime)
    sequence:PlayForward()
    self.cardNodeAnimator_:SetTrigger(AnimatorTrigger.OrderWait)
    return actionTime
end


---@return number @ 动画时长
function BattleCardGamePlayCardNode:PlayRuleAnimBySwap(targetNode)
    local sequence     = DOTween.Sequence()
    local anchoredPos  = CfUtils.UIWorldToScreenPos(targetNode, self.controller.transform.parent)
    local selectTime   = CfUtils.GetAnimatorTime(self.controller, AnimationName.CardSelect)
    local unselectTime = CfUtils.GetAnimatorTime(self.controller, AnimationName.CardUnselect)
    local actionTime   = selectTime + unselectTime
    sequence:AppendInterval(selectTime)
    sequence:AppendCallback(function()
        self.cardNodeAnimator_:SetTrigger(AnimatorTrigger.Unselect)
    end)
    sequence:AppendInterval(unselectTime)
    sequence:PlayForward()
    self.cardNodeAnimator_:SetTrigger(AnimatorTrigger.Select)
    self.controller.transform:DOLocalMove(Vector3(anchoredPos.x, anchoredPos.y, 0), actionTime):SetEase(TweenEase.OutQuad)
    self:AdjustOrderToTop()
    return actionTime
end


-------------------------------------------------
-- private

--- 更改层级位置
---@param orderIndex integer | nil
function BattleCardGamePlayCardNode:UpdateNodOrderIndex_(orderIndex)
    local nodeOrderIndex = orderIndex or self.initSiblingIndex_
    self.controller.transform:SetSiblingIndex(nodeOrderIndex)
end


--- 转换卡牌的倾斜角度
function BattleCardGamePlayCardNode:TransformCardOnVelocity_()
    local pitchAngleMin      = StatusDefine.PitchAngleMin
    local pitchAngleMax      = StatusDefine.PitchAngleMax
    local pitchSmoothness    = StatusDefine.PitchSmoothness
    local dragVelocityFactor = StatusDefine.DragVelocityFactor
    local originalRotation   = Vector3.zero

    local pitchPositionX = Mathf.Clamp(self.deltaPosition_.y * dragVelocityFactor, pitchAngleMin, pitchAngleMax)
    local pitchPositionY = Mathf.Clamp(-self.deltaPosition_.x * dragVelocityFactor, pitchAngleMin, pitchAngleMax)

    -- Apply pitch rotation gradually
    local targetRotation = Quaternion.Euler(originalRotation.x + pitchPositionX, originalRotation.y + pitchPositionY, originalRotation.z)

    -- Smoothly interpolate the card's rotation based on pitch while restricting the Z-axis rotation
    local currentRotation = self.controller.transform.rotation
    currentRotation.eulerAngles = Vector3(currentRotation.eulerAngles.x, currentRotation.eulerAngles.y, originalRotation.z)

    self.controller.transform.rotation = Quaternion.Slerp(currentRotation, targetRotation, UnityTime.deltaTime * pitchSmoothness)
end


--- 重置卡牌的倾斜角度
function BattleCardGamePlayCardNode:ResetCardOnVelocity_()
    self.controller.transform.rotation = Quaternion.identity
end


--- 调整子级的景深效果
function BattleCardGamePlayCardNode:AdjustChildPositions_()
    local cardRotationAngleY = self.controller.transform.rotation.eulerAngles.y
    local cardRotationAngleX = -self.controller.transform.localRotation.eulerAngles.x

    for _, pitchViewData in ipairs(self.pitchViewDatas_) do
        local spriteTargetDistanceX = Mathf.Sin(Mathf.Deg2Rad * cardRotationAngleY) * -1 * pitchViewData.distance
        local spriteTargetDistanceY = Mathf.Sin(Mathf.Deg2Rad * cardRotationAngleX) * -1 * pitchViewData.distance
        pitchViewData.transform.localPosition = Vector3(spriteTargetDistanceX * 100, spriteTargetDistanceY * 100, 0)
    end
end


--- 重置子级的景深效果
function BattleCardGamePlayCardNode:ResetChildPositions_()
    for _, pitchViewData in ipairs(self.pitchViewDatas_) do
        pitchViewData.transform.localPosition = Vector3(0, 0, 0)
    end
end


--- 切换特效节点颜色样式
---@param isRedPlayMode boolean @ 是否为红色模式
function BattleCardGamePlayCardNode:SwitchUifxNodesStyle_(isRedPlayMode)
    for _, uifxNode in ipairs(self.uifxSwitchNodes_) do
        CfUtils.SetUISwitchParticleSystem(uifxNode, isRedPlayMode and 2 or 1)
    end
end


function BattleCardGamePlayCardNode:ResetAnimatorTriggers_()
    for _, triggerName in pairs(AnimatorTrigger) do
        self.cardNodeAnimator_:ResetTrigger(triggerName)
    end
end


-------------------------------------------------
-- handler

--- 主循环更新
function BattleCardGamePlayCardNode:OnCardUpdateBehaviourHandler_()
    if self.isPointerDragging_ then
        self:TransformCardOnVelocity_()
    end

    -- 因为主界面的动画需要摆动效果，所以更新坐标和拖动检测分离出来
    if self:IsLayerDepth() then
        self:AdjustChildPositions_()
    end
end


function BattleCardGamePlayCardNode:OnClickCardNodeHandler_()
    if self:IsClickable() and self:GetClickCardCb() then
        self:GetClickCardCb()(self)
    end
end


---@param eventData UnityEngine.EventSystems.PointerEventData
function BattleCardGamePlayCardNode:OnNodeDragBeginHandler_(eventData)
    if isNull(eventData) or not self:IsDraggable() then
        return
    end
    if self:GetDragBeginCb() then
        self.isPointerDragging_ = self:GetDragBeginCb()(self)
    end

    if self.isPointerDragging_ then
        -- 计算点击位置距离中心点的偏移量
        local nowVec2 = CfUtils.ScreenPosition2UIPosition(eventData.position, self.cardNodeParentRT_)

        -- save drag info
        self.dragOriginVector_.x = self.controller.transform.localPosition.x
        self.dragOriginVector_.y = self.controller.transform.localPosition.y
        self.dragOffsetVector_.x = self.dragOriginVector_.x - nowVec2.x
        self.dragOffsetVector_.y = self.dragOriginVector_.y - nowVec2.y

        -- order to top
        self:AdjustOrderToTop()
    end
end


---@param eventData UnityEngine.EventSystems.PointerEventData
function BattleCardGamePlayCardNode:OnNodeDragMovedHandler_(eventData)
    if isNull(eventData) or not self:IsDraggable() then
        return
    end
    if not self.isPointerDragging_ then
        return
    end

    -- update position
    local nowVec2 = CfUtils.ScreenPosition2UIPosition(eventData.position, self.cardNodeParentRT_)
    self.controller.transform.localPosition = Vector3(
        nowVec2.x + self.dragOffsetVector_.x,
        nowVec2.y + self.dragOffsetVector_.y,
        0
    )

    -- save delta position
    self.deltaPosition_.x = eventData.delta.x
    self.deltaPosition_.y = eventData.delta.y

    -- check collision
    if self:GetDragMovedCb() then
        local nodePosition  = self.controller.transform.position
        local nodeScreenPos = Vector2(nodePosition.x, nodePosition.y)
        local checkCollisionCb = function(target)
            local otherRtComp = CfUtils.GetRectTransform(target)
            return RectTransformUtility.RectangleContainsScreenPoint(otherRtComp, nodeScreenPos)
        end
        self:GetDragMovedCb()(self, checkCollisionCb)
    end
end


---@param eventData UnityEngine.EventSystems.PointerEventData
function BattleCardGamePlayCardNode:OnNodeDragEndedHandler_(eventData)
    if isNull(eventData) or not self:IsDraggable() then
        return
    end
    if not self.isPointerDragging_ then
        return
    end

    -- check collision
    local isCollision = false
    if self:GetDragEndedCb() then
        local nodePosition  = self.controller.transform.position
        local nodeScreenPos = Vector2(nodePosition.x, nodePosition.y)
        local checkCollisionCb = function(target)
            local otherRtComp = CfUtils.GetRectTransform(target)
            return RectTransformUtility.RectangleContainsScreenPoint(otherRtComp, nodeScreenPos)
        end
        isCollision = self:GetDragEndedCb()(self, checkCollisionCb)
    else
        isCollision = false
    end

    -- reset state
    if not isCollision then
        -- reset position
        -- self.controller.transform.localPosition = self.dragOriginVector_
    end

    -- reset delta position
    self.deltaPosition_.x = 0
    self.deltaPosition_.y = 0
    self:ResetCardOnVelocity_()

    self.isPointerDragging_ = false
end


return BattleCardGamePlayCardNode
