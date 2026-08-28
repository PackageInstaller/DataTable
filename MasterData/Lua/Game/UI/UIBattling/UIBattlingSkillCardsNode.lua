------------ import ------------
local cs_coroutine = require("XLua.cs_coroutine")
local KTool = CS.Engine.Lib.KTool
local DOTween = CS.DG.Tweening
local CanvasGroup = CS.UnityEngine.CanvasGroup
local RectTransform = CS.UnityEngine.RectTransform
local RectTransformUtility = CS.UnityEngine.RectTransformUtility
local Animation = CS.UnityEngine.Animation
local Canvas = CS.UnityEngine.Canvas
local GraphicRaycaster = CS.UnityEngine.UI.GraphicRaycaster
local ParticleOrderController = CS.ParticleOrderController
local Yielders = CS.Engine.Lib.Yielders
local UIEventProxy = CS.Engine.UI.UIEventProxy
local EventDragProxy = CS.Engine.UI.EventDragProxy
local GameObject = CS.UnityEngine.GameObject
local Renderer = CS.UnityEngine.Renderer
local ParticleSystem = CS.UnityEngine.ParticleSystem
local UISwitchParticleSystem = CS.Game.Native.Common.UISwitchParticleSystem
local UIBattlingCtrlMgr = import("Game.UI.UIBattling.UIBattlingCtrlMgr")
------------ import ------------

------------ define ------------
local TIME_OF_TO_AIM = 0.2 -- 到达目标点时间
local TIME_OF_ARRANGE = 0.12 -- 卡牌规整时间
local TIME_OF_ALPHA_TO_FULL = 0.06 -- Alpha 0 -> 1 时间
local ORDER_IN_LAYER_INDRAG_GO = 5 -- 在卡牌拖拽时技能卡 GO 的 Layer
local ORDER_IN_LAYER_INDRAG_PTC = 6 -- 在卡牌拖拽时技能卡 PTC 的 Layer
local ANIMATION_BEUNIT_HOR = "Card_Combine_R_to_L" -- 被合成卡牌动画 水平向
local ANIMATION_UPGRADE_HOR1 = "Card_Combine_L_to_R" -- 晋升卡牌动画1 水平向
local ANIMATION_UPGRADE_HOR2 = "Card_Combine_VH" -- 晋升卡牌动画2 水平向
local ANIMATION_BEUNIT_VER = "Card_Combine_T_to_B" -- 晋升卡牌动画 竖直向
local ANIMATION_UPGRADE_VER1 = "Card_Combine_B_to_T" -- 晋升卡牌动画1 竖直向
local ANIMATION_UPGRADE_VER2 = "Card_Combine_VH_Vertical" -- 晋升卡牌动画2 竖直向
local ANIMATION_BEOVERBYSELECTCARD = "Card_Enlarge" --卡池中技能牌被玩家所选技能牌覆盖时动画
local ANIMATION_BEOVERSTATEBACKDEFAUT = "Card_Narrow" -- 被覆盖还原到原始状态动画
local ANIMATION_REPAIR = "Card_Repair" -- 补拍动画
local Type_Interaction = { Click = 1, Press = 2, None = 3, Drag = 4, } -- 技能卡交互类型
local Click_Fault_Tolerance = 40
local TIME_LENGTH_2_PRESS = 0.2
local RESTRAINT_GROUP = "RestraintGroup"
local IMG_RESTRAINT_RED = "ImgRestraintRed"
local IMG_RESTRAINT_GREEN = "ImgRestraintGreen"
------------ define ------------

---@type UIBattlingSkillCardsNodeBase
local base = import("Game.UI.UIBattling.UIBattlingSkillCardsNodeBase")

---@class UIBattlingSkillCardsNode
---@field ParticalRoot                    UnityEngine.RectTransform
---@field EventReceiver                    Engine.UI.GraphicRaycastReceiver
local UIBattlingSkillCardsNode = Class("UIBattlingSkillCardsNode", base)

------------ lifeCycle ------------

function UIBattlingSkillCardsNode:__init()
    base.__init(self)
    self:CleanField()
end

function UIBattlingSkillCardsNode:__delete()
    base.__delete(self)
    self:CleanField()
    self.controller = nil --删除lua层引用到的c#对象 否则不会产生c# gc回收到对象
    self = nil --lua层的gc需要
end

function UIBattlingSkillCardsNode:CleanField()
    self.curTransArrLine = nil -- 当前行
    self.curTransArrLinePos = nil -- 当前行位置
    ---@type UnityEngine.Transform
    self.curFatherTrans = nil -- SkillCard 当前 FatherTrans
    ---@type UnityEngine.GameObject
    self.skillCardsPoolGO = nil -- SkillCardPoolGO
    ---@type UnityEngine.Transform
    self.skillCardAimTrans = nil -- cardNode生成 位移目标点
    self.skillCardCreatRootTrans = nil -- skillCard创建点
    self.skillCardCurvesArr = nil -- 技能卡使用的曲线集合
    self.curGOCanvasGroup = nil
    self.coPlayAnim = nil -- 播放动画 协程
    self.coShowSpCard = nil -- sp 技能卡出现协程
    ------ 特效
    self.ptcSkillCardLocked = nil
    self.ptcSkillCardUnitShow = nil
    self.ptcSkillCardSP = nil
    self.ptcSkillCardUnitLine = nil
    self.ptcElementRestraint = nil
    ------ 卡牌 Canvas 和 Raycaster
    self.canvasWillUnit = nil
    self.canvasSkillCardTouch = nil
    self.raycasterSkillCardTouch = nil
    ------ Animation
    self.curAnimation = nil -- 动画播放器
    self.tweenDoFade = nil -- tween卡牌使用
    self.tweenDoMove = nil -- tween卡牌移动
    ------ Interaction
    self.typeInteractive = nil
    self.coInteractive = nil
    self.posPointerD = nil
    self.isLocked = nil
    ------ Icon
    ---@type UnityEngine.GameObject
    self.restraintIcon = nil
    ---@type UnityEngine.GameObject
    self.beRestraintIcon = nil

    ---@type UnityEngine.RectTransform
    self.restraintGroup = nil

    self.defaultScale = nil
end

function UIBattlingSkillCardsNode:Awake()
    base.Awake(self)
    self.curTransArrLine = 0
    self.curTransArrLinePos = 0
    self.typeInteractive = Type_Interaction.None
    self.isLocked = false
    self.defaultScale = 1
    self:Init()
end

function UIBattlingSkillCardsNode:Init()
    self:InitComponent()
    self:InitListener()
end  

function UIBattlingSkillCardsNode:InitComponent()
    self.curGOCanvasGroup = self.controller:GetComponent(typeof(CanvasGroup))
    self.curAnimation = self.controller:GetComponent(typeof(Animation))
    self.skillCardCurvesArr = self.controller:GetComponent("SkillCardCurvesArr")

    self.restraintGroup = self.controller.gameObject.transform:Find(RESTRAINT_GROUP)
    self.restraintIcon = self.restraintGroup:Find(IMG_RESTRAINT_GREEN).gameObject
    self.beRestraintIcon = self.restraintGroup:Find(IMG_RESTRAINT_RED).gameObject
end

function UIBattlingSkillCardsNode:OnDestroy()
    self:RemoveListener()
    self:CleanCoInteraction()
    if not IsNull(self.coPlayAnim) then
        cs_coroutine.stop(self.coPlayAnim)
    end
    if not IsNull(self.coShowSpCard) then
        cs_coroutine.stop(self.coShowSpCard)
    end
    base.OnDestroy(self)
    self.controller = nil --luabehaviour 中CSharp对象
    self:Delete()
    self = nil
end

------------ lifeCycle ------------

------------ Event ------------

function UIBattlingSkillCardsNode:InitListener()
    UIEventProxy.Create(self.controller.gameObject).onPointerDown = Bind(self, self.ActionOnPointerDown)
    -- EventDragProxy.Create(self.controller.gameObject).onPointerDrag = Bind(self, self.OnDragFun)
    UIEventProxy.Create(self.controller.gameObject).onPointerUp = Bind(self, self.ActionOnPointerUp)
end

function UIBattlingSkillCardsNode:RemoveListener()
    UIEventProxy.Create(self.controller.gameObject).onPointerDown = nil
    -- EventDragProxy.Create(self.controller.gameObject).onPointerDrag = nil
    UIEventProxy.Create(self.controller.gameObject).onPointerUp = nil
end

--- 设置属性克制图标状态
---@param show any
---@param status any
function UIBattlingSkillCardsNode:SetImgRestraint(show, status)
    KTool.SetActive(self.beRestraintIcon, show and status == 1 or false)
    KTool.SetActive(self.restraintIcon, show and status == 2 or false)
end

---@param pointerData UnityEngine.Vector2
function UIBattlingSkillCardsNode:ActionOnPointerDown(pointerData)
    if self.coInteractive then return end
    self.posPointerD = pointerData.position
    self.coInteractive = cs_coroutine.start(function()
        self.typeInteractive = Type_Interaction.Click
        cs_coroutine.yield_return(CS.UnityEngine.WaitForSecondsRealtime(TIME_LENGTH_2_PRESS))
        self.typeInteractive = Type_Interaction.Press
        self:OnSkillCardPress()
        --self:OnDragStartFun(pointerData)
    end)
end

function UIBattlingSkillCardsNode:ActionOnPointerUp(pointerData)
    --UIBattlingTools.StopAudio(UISheets.UI_Battle.ui_skill_card_move)
    if not IsNull(pointerData) then
        -- print("-->PointRC:", pointerData.pointerEnter, pointerData.pointerPressRaycast.gameObject, pointerData.pointerEnter == pointerData.pointerPressRaycast.gameObject)
    end
    if self.coInteractive then
        cs_coroutine.stop(self.coInteractive)
        self.coInteractive = nil
    end
    -- print("-->D/U_Dis:", pointerData and Vector2.Distance(pointerData.position, self.posPointerD))
    if self.typeInteractive == Type_Interaction.Click and (not IsNull(pointerData)) and Vector2.Distance(pointerData.position, self.posPointerD) > Click_Fault_Tolerance then
        self.typeInteractive = Type_Interaction.None
    end
    self:SwitchInteraction(self.typeInteractive)
    --- Remove Canvas and Raycaster
    if not IsNull(self.raycasterSkillCardTouch) then
        KTool.SafeDelete(self.raycasterSkillCardTouch)
        self.raycasterSkillCardTouch = nil
    end
    if not IsNull(self.canvasSkillCardTouch) then
        KTool.SafeDelete(self.canvasSkillCardTouch)
        self.canvasSkillCardTouch = nil
    end
    --- 还原 PTC 的 OIL
    if not IsNull(self.ptcSkillCardUnitShow) then
        self:SetPTCOrderInLayer(self.ptcSkillCardUnitShow, 1)
    end
    if not IsNull(self.ptcSkillCardSP) then
        self:SetPTCOrderInLayer(self.ptcSkillCardSP, 1)
    end
    if not IsNull(self.ptcSkillCardLocked) then
        self:SetPTCOrderInLayer(self.ptcSkillCardLocked, 1)
    end
    self.typeInteractive = Type_Interaction.None
end

function UIBattlingSkillCardsNode:SwitchInteraction(type)
    -- print("-->UIBattlingSkillCardsNode:SwitchInteraction", type)
    if type == Type_Interaction.Click then
        self:OnSkillCardClick()
    elseif type == Type_Interaction.Press then
        self:OnInteractiveInvalid()
    elseif type == Type_Interaction.Drag then
        self:OnDragEndFun()
    else
        self:OnInteractiveInvalid()
    end
end

------------ Event ------------

------------ Property ------------

---GetSkillCardData
---获取 当前技能牌的 CardData
function UIBattlingSkillCardsNode:GetSkillCardData()
    return self.skillCardData
end

---GetSkillCardStarLevel
---获取当前技能卡的星级
function UIBattlingSkillCardsNode:GetSkillCardStarLevel()
    return self.skillCardStarLevel
end

---GetSkillCardSkillId
---获取当前技能卡的技能ID
function UIBattlingSkillCardsNode:GetSkillCardSkillId()
    return self.skillCardSkillId
end

---GetSkillCardPosInfo
---获取 技能卡当前 行位置 信息
function UIBattlingSkillCardsNode:GetSkillCardPosInfo()
    return self.curTransArrLinePos
end

---GetSkillCardLineInfo
---获取 技能卡 当前 行 信息
function UIBattlingSkillCardsNode:GetSkillCardLineInfo()
    return self.curTransArrLine
end

---SetSkillCardPosInfo
---设置 技能卡位置信息
---@param line number 行
---@param pos number 位置[从右向左]
function UIBattlingSkillCardsNode:SetSkillCardPosInfo(line, pos)
    self.curTransArrLine = line
    self.curTransArrLinePos = pos
end

function UIBattlingSkillCardsNode:SetSkillCardPos(pos)
    self.curTransArrLinePos = pos
end

---GetSkillCardPos
---获取卡牌的位置信息
function UIBattlingSkillCardsNode:GetSkillCardPos()
    return self.curTransArrLinePos
end

---GetSkillCardRoleId
---获取技能卡持有者 Id
function UIBattlingSkillCardsNode:GetSkillCardRoleId()
    return self.skillCardRoleId
end

------------ Property ------------

---ShowPTCOfWillBeUnit
---展示 预览合成卡牌特效
---@param Boolean boolean 是否在范围中
---@param posData table 位置信息
function UIBattlingSkillCardsNode:ShowPTCOfWillBeUnit(Boolean, posData)
    if Boolean then
        --- 设置卡牌之间的连线
        if not IsNull(posData) then
            self:SetPTCLine(posData)
        end
        if not IsNull(self.ptcSkillCardUnitShow) then return end
        if self:GetSkillCardStarLevel() == 1 then
            self.ptcSkillCardUnitShow = UIBattlingTools.ReloadPTCOfBattling(Constants.UIBattlingObjPoolPTC.PTC_CARD_SKILLCARD_UNITSHOW_STAR1, self.ParticalRoot.gameObject, 9999, true)
        elseif self:GetSkillCardStarLevel() == 2 then
            self.ptcSkillCardUnitShow = UIBattlingTools.ReloadPTCOfBattling(Constants.UIBattlingObjPoolPTC.PTC_CARD_SKILLCARD_UNITSHOW_STAR2, self.ParticalRoot.gameObject, 9999, true)
        end
        ---当前技能卡为玩家选择技能卡，需要显示卡牌合成引导特效时，改变PTC的OIL
        if (not IsNull(self.typeInteractive)) and self.typeInteractive == Type_Interaction.Press then
            if not IsNull(self.ptcSkillCardUnitShow) then
                self:SetPTCOrderInLayer(self.ptcSkillCardUnitShow, ORDER_IN_LAYER_INDRAG_PTC)
            end
        end
    else
        if not IsNull(self.ptcSkillCardUnitShow) then
            UIBattlingTools.RecyclePoolObj(self.ptcSkillCardUnitShow)
            self.ptcSkillCardUnitShow = nil
        end
        if not IsNull(self.ptcSkillCardUnitLine) then
            UIBattlingTools.RecyclePoolObj(self.ptcSkillCardUnitLine)
            self.ptcSkillCardUnitLine = nil
        end
    end
end

---SetPTCLine
---设置 PTCLine
---@param posData UnityEngine.RectTransform 玩家选择卡牌的 RectTrans
function UIBattlingSkillCardsNode:SetPTCLine(posData)
    local selectedCardPos = posData
    local cardPos = self.curFatherTrans.anchoredPosition
    local angle = CfUtils.AnglePos(cardPos, selectedCardPos)
    if IsNull(self.ptcSkillCardUnitLine) then
        self.ptcSkillCardUnitLine = UIBattlingTools.ReloadPTCOfBattling(Constants.UIBattlingObjPoolPTC.PTC_CARD_SKILLCARD_UNITSHOW_LINE, self.ParticalRoot.gameObject, 9999, true)
    end
    self.ptcSkillCardUnitLine.transform.localRotation = Quaternion.Euler(0, 0, angle)
end

---SkillCardLocked
---技能牌锁定
function UIBattlingSkillCardsNode:SkillCardLocked()
    if IsNull(self.ptcSkillCardLocked) then
        self.ptcSkillCardLocked = UIBattlingTools.ReloadPTCOfBattling(Constants.UIBattlingObjPoolPTC.PTC_CARD_SKILLCARD_LOCKED, self.ParticalRoot.gameObject, 9999, true)
    end
    self.isLocked = true
end

---UnSkillCardLocked
---技能牌解锁
function UIBattlingSkillCardsNode:UnSkillCardLocked()
    if not IsNull(self.ptcSkillCardLocked) then
        UIBattlingTools.RecyclePoolObj(self.ptcSkillCardLocked)
        self.ptcSkillCardLocked = nil
    end
    self.isLocked = false
end

function UIBattlingSkillCardsNode:CleanSkillCardElementRestraint()
    if not IsNull(self.ptcElementRestraint) then
        UIBattlingTools.RecyclePoolObj(self.ptcElementRestraint)
        self.ptcElementRestraint = nil
    end
end

---UpgradeSkillCard
---技能卡升级 逻辑
function UIBattlingSkillCardsNode:UpgradeSkillCard()
    self.skillCardData.star = self.skillCardStarLevel + 1
    base.SetSkillCardInfo(self, self.skillCardData)
    base.ReloadCardInfo(self)
    KTool.SetActive(self.levelRoot, false)
end

---CleanAllEffect
---清除节点动效
function UIBattlingSkillCardsNode:CleanAllEffect()
    if self.curAnimation then
        self.curAnimation:Stop()
    end
    if self.coPlayAnim then
        cs_coroutine.stop(self.coPlayAnim)
        self.coPlayAnim = nil
    end
end

---SetSkillCardDefault
---设置技能牌为初始状态
function UIBattlingSkillCardsNode:SetSkillCardDefault()
    self.controller.transform.anchoredPosition3D = Vector3.zero
    self.controller.transform.localRotation = Quaternion.Euler(0, 0, 0)
    self.controller.transform.localScale = Vector3.one * self.defaultScale
    self:SetSkillCardAlphaZero()
    self:SetSkillCardPtcDefault()
    self.isLocked = false
    --- 回收 技能卡 游戏物体
    UIBattlingTools.RecyclePoolObj(self.controller.gameObject, true)
end

---SetSkillCardPtcDefaut
---设置技能卡特效为默认 
function UIBattlingSkillCardsNode:SetSkillCardPtcDefault()
    if not isNull(self.ParticalRoot) then
        if self.ParticalRoot.childCount <= 0 then return end
        ---倒序移除节点下子节点
        for i = self.ParticalRoot.childCount - 1, 0, -1 do
            UIBattlingTools.RecyclePoolObj(self.ParticalRoot:GetChild(i).gameObject)
        end
    end
    self.ptcSkillCardLocked = nil
    self.ptcSkillCardUnitShow = nil
    self.ptcSkillCardSP = nil
end

---SetSkillCardPTCRootActiveState
---设置技能牌PTCRoot状态
---@param boolean boolean
function UIBattlingSkillCardsNode:SetSkillCardPTCRootActiveState(boolean)
    if not IsNull(self.ParticalRoot) then
        KTool.SetActive(self.ParticalRoot.gameObject, boolean)
    end
    --- 约束标记也是特效，只是没在ParticalRoot下面
    if not isNull(self.restraintGroup) then
        KTool.SetActive(self.restraintGroup.gameObject, boolean)
    end
end

---OnSkillCardPress
---长安显示 技能说明
---@param gesture HedgehogTeam.EasyTouch.Gesture
function UIBattlingSkillCardsNode:OnSkillCardPress()
    Events.Broadcast(Constants.EventNames.UIBattleSkillCardOnPress, true, self.controller)
end

--- 设置卡牌的层级
---@param layer any
function UIBattlingSkillCardsNode:SetCanvasLayer(layer)
    if layer > 0 then
        local canvas = self.controller.gameObject:EnsureComponent(typeof(Canvas))
        canvas.overrideSorting = true
        canvas.sortingOrder = layer
        -- 同时修改特效的层级
        -- local psList = self.controller.transform:GetComponentsInChildren(typeof(ParticleSystem))
        -- for i = 0, psList.Length - 1, 1 do
        --     local renderer = psList[i]:GetComponent(typeof(Renderer))
        --     renderer.sortingOrder = layer
        -- end
    else
        local canvas = self.controller.gameObject:GetComponent(typeof(Canvas))
        if not isNull(canvas) then
            GameObject.Destroy(canvas)
        end
        -- 同时修改特效的层级
        -- local psList = self.controller.transform:GetComponentsInChildren(typeof(ParticleSystem))
        -- for i = 0, psList.Length - 1, 1 do
        --     local renderer = psList[i]:GetComponent(typeof(Renderer))
        --     renderer.sortingOrder = 2   -- 特效默认层级为2
        -- end
    end
end

---SetSkillCardInfo
---设置 技能卡 数据
---@param cardData table 技能卡数据
function UIBattlingSkillCardsNode:SetSkillCardInfo(cardData)
    base.SetSkillCardInfo(self, cardData)
    base.ReloadCardInfo(self)
    KTool.SetActive(self.levelRoot, false)
    --// TODO 待删除
    if not IsNull(self.curGOCanvasGroup) then
        self.curGOCanvasGroup.blocksRaycasts = true
    end
    self:SetSkillCardPTCRootActiveState(true)
end

function UIBattlingSkillCardsNode:SetSkillCardData(cardData)
    base.SetSkillCardInfo(self, cardData)
end

---CheckSPSkillCardShow
---检查 是否显示 SP 特效 
---@param skillId number
---@param skillStar number
function UIBattlingSkillCardsNode:CheckSPSkillCardShow(skillId, skillStar)
    local skillType = UIBattlingTools.GetSkillCardInfoByTwoParam(skillId, skillStar).skillType
    if skillType == 3 then
        --- PTC_SP_Appear
        UIBattlingTools.ReloadPTCOfBattling(Constants.UIBattlingObjPoolPTC.PTC_CARD_SPAPPEAR_NAME, self.ParticalRoot.gameObject, 5, true)
        --- PTC_SP_Show_Duration
        self.coShowSpCard = cs_coroutine.start(function()
            cs_coroutine.yield_return(Yielders.GetWaitForSeconds(0.3))
            self.ptcSkillCardSP = UIBattlingTools.ReloadPTCOfBattling(Constants.UIBattlingObjPoolPTC.PTC_SP_NAME, self.ParticalRoot.gameObject, 9999,true)
            self.coShowSpCard = nil
        end)
    end
end

--- 检查技能循环特效的显示状态
function UIBattlingSkillCardsNode:CheckSkillCardLoopPTCShow()
    local skillType = UIBattlingTools.GetSkillCardInfoByTwoParam(self.skillCardSkillId, self.skillCardStarLevel).skillType
    if skillType == 3 then
        -- 大招（现在大招也有星级，会和2,3星混在一起，所以用类型判断一下）
        self:CheckSPSkillCardShow(self.skillCardSkillId, self.skillCardStarLevel)
    else
        if self.skillCardStarLevel == 2 then
            UIBattlingTools.ReloadPTCOfBattling(Constants.UIBattlingObjPoolPTC.PTC_STAR2_Name, self.ParticalRoot.gameObject, 9999, true)
        elseif self.skillCardStarLevel == 3 then
            UIBattlingTools.ReloadPTCOfBattling(Constants.UIBattlingObjPoolPTC.PTC_STAR3_Name, self.ParticalRoot.gameObject, 9999, true)
        end
    end
end

---OnSkillCardClick
---技能卡点击使用
---@param gesture HedgehogTeam.EasyTouch.Gesture
function UIBattlingSkillCardsNode:OnSkillCardClick()
    --if self.isLocked then return end
    self:SkillCardUse()
    self:SkillCardBackCurArea()
    self:SetEventReceiverEnableState(false)
end

---SkillCardUse
---卡牌使用
function UIBattlingSkillCardsNode:SkillCardUse()
    local skillCardPosData = { pos = { self.curTransArrLinePos, self.curTransArrLine }, targetId = nil }
    Events.Broadcast(Constants.EventNames.UIBattlingDialogGetAndSetFakeSkillCard, nil)
    Events.Broadcast(Constants.EventNames.UIBattlingDialogSetSequenceSkillCard, self, skillCardPosData)   
end

---SetSkillUsed
---设置卡牌已使用
function UIBattlingSkillCardsNode:SetSkillUsed()
    --- 拥有吞噬效果的卡牌的效果展示
    -- print("->UIBattlingSkillCardsNode:SetSkillUsed", self.skillCardSkillId)
    local skillCardVo = UIBattlingTools.GetSkillCardInfoByTwoParam(self.skillCardSkillId) -- 技能卡配表数据
    local cardBehavior = skillCardVo.cardBehavior
    if cardBehavior
    and ((cardBehavior == Constants.CardBehavior.Swallow) or (cardBehavior == Constants.CardBehavior.Upgrade)) then
        cs_coroutine.yield_return(SkillPoolOperationMgr:OriginCardEatCardShow(self))
    end
    --- 常规使用
    --self.tweenDoFade = self.controller.transform:DOScale(Vector3.New(0, 0, 0), 0.3):OnComplete(function()
    --    self.controller.transform.localScale = Vector3.New(1, 1, 1)
    --    self:SetSkillCardDefault()
    --    self.tweenDoFade = nil
    --end)
    self.controller.transform.localScale = Vector3.one * self.defaultScale
    self:SetSkillCardDefault()
    --cs_coroutine.yield_return(Yielders.GetWaitForSeconds(0.3))
    return true
end

---SetSkillCardAlphaZero
---设置 skillCard 的 Alpha 为 0
function UIBattlingSkillCardsNode:SetSkillCardAlphaZero()
    if self.curGOCanvasGroup.alpha > 0 then
        self.curGOCanvasGroup.alpha = 0
    end
end

---SetCardAimTrans
---设置 SkillCard 位移位置的目标点
---@param trans UnityEngine.Transform
function UIBattlingSkillCardsNode:SetCardAimTrans(trans)
    self.skillCardAimTrans = trans
    --self.curFatherTrans = self.skillCardAimTrans
    --self:SkillCardPosReset()
    --self:SetSkillCardAlphaZero()
end

---GetFatherTrans
---获取卡牌的父节点
---@return UnityEngine.Transform
function UIBattlingSkillCardsNode:GetFatherTrans()
    return self.curFatherTrans
end

---SetFatherTrans
---设置 SkillCard 当前父节点坐标
---@param trans UnityEngine.Transform
function UIBattlingSkillCardsNode:SetFatherTrans(trans)
    self.curFatherTrans = trans
    self.controller.transform.anchoredPosition3D = Vector3.zero
end

---SetSkillCardsPoolGO
---设置 SkillCardsPoolGO
---@param gameObject UnityEngine.GameObject
function UIBattlingSkillCardsNode:SetSkillCardsPoolGO(gameObject)
    self.skillCardsPoolGO = gameObject
end

---SetPTCOrderInLayer
---设置 UIPTC 的 OIL
---@param go UnityEngine.GameObject @ 粒子GO
---@param numOrderInLayer number @ OIL值
function UIBattlingSkillCardsNode:SetPTCOrderInLayer(go, numOrderInLayer)
    local orderInLayerCtrl = go:GetComponent(typeof(ParticleOrderController))
    if not IsNull(orderInLayerCtrl) then
        orderInLayerCtrl:SetOrder(numOrderInLayer)
    end
end

---OnDragFun
---@param pointerData UnityEngine.EventSystems.PointerEventData
function UIBattlingSkillCardsNode:OnDragFun(pointerData)
    if self.typeInteractive ~= Type_Interaction.Drag then
        local dis = Vector2.Distance(pointerData.position, self.posPointerD)
        if dis >= Click_Fault_Tolerance then
            self.typeInteractive = Type_Interaction.Drag
            if self.coInteractive then
                cs_coroutine.stop(self.coInteractive)
                self.coInteractive = nil
            end
            self:OnDragStartFun(pointerData.position)
        end
    end
    if not (self.typeInteractive == Type_Interaction.Drag) then return end
    self:SyncCard2Finger(pointerData.position)
end

function UIBattlingSkillCardsNode:SyncCard2Finger(position)
    local uiCamera = UIBattlingCtrlMgr:GetInstance():GetUICamera()
    local fatherTransform = self.controller.transform.parent:GetComponent(typeof(RectTransform))
    local vec2
    local bool, vecNow = RectTransformUtility.ScreenPointToLocalPointInRectangle(fatherTransform, position, uiCamera, vec2)
    if UIBattlingTools.GetSkillCardPosOutOfRange(vecNow) then
        self.typeInteractive = Type_Interaction.None
        self:ActionOnPointerUp()
        return
    end
    self:FuncSkillCardOnDrag(vecNow)
end

---FuncSkillCardOnDrag
---卡牌在拖动中的执行函数
---@param vecNow Vector2 当前技能卡的屏幕坐标
function UIBattlingSkillCardsNode:FuncSkillCardOnDrag(vecNow)
    self.controller.transform.anchoredPosition = vecNow
    Events.Broadcast(Constants.EventNames.UIBattlingDialogGetSelectSkillCardPos, vecNow, self.controller)
end

---OnDragStartFun
---@param position UnityEngine.Vector2
function UIBattlingSkillCardsNode:OnDragStartFun(position)
    --- Add Canvas and Raycaster
    self.canvasSkillCardTouch = self.controller.gameObject:EnsureComponent(typeof(Canvas))
    self.canvasSkillCardTouch.overrideSorting = true
    self.canvasSkillCardTouch.sortingOrder = ORDER_IN_LAYER_INDRAG_GO
    self.raycasterSkillCardTouch = self.controller.gameObject:EnsureComponent(typeof(GraphicRaycaster))
    --- 当前技能卡为 SP 技能时，调节 PTC 的 OIL
    if not IsNull(self.ptcSkillCardSP) then
        self:SetPTCOrderInLayer(self.ptcSkillCardSP, ORDER_IN_LAYER_INDRAG_PTC)
    end
    --- 当前技能卡为 锁定状态时, 调节 PTC 的 OIL
    if not IsNull(self.ptcSkillCardLocked) then
        self:SetPTCOrderInLayer(self.ptcSkillCardLocked, ORDER_IN_LAYER_INDRAG_PTC)
    end
    --- 设置 层级，避免被遮挡
    KTool.SetParent(self.controller.gameObject, self.skillCardsPoolGO, true)
    --- 设置残影牌事件
    Events.Broadcast(Constants.EventNames.UIBattlingDialogGetAndSetFakeSkillCard, self.curFatherTrans, self.skillCardData)
    self.controller.transform.localScale = Vector3.New(1.2, 1.2, 1.2)
    self:SyncCard2Finger(position)
    --self:OnDragFun(pointerData) -- 同步手指位置
    --UIBattlingTools.PlayAudio(UISheets.UI_Battle.ui_skill_card_move)
end

---OnDragEndFun
---技能牌 TouchEnd 事件
function UIBattlingSkillCardsNode:OnDragEndFun()
    Events.Broadcast(Constants.EventNames.UIBattlingDialogOnCurSkillCardDragEnd, self.controller.gameObject)
    self:OnInteractiveInvalid()
end

---SkillCardArrange
---预制体向右移动
---@param aimTrans UnityEngine.Transform
function UIBattlingSkillCardsNode:SkillCardArrange(aimTrans)
    --- 判断 位置是否改变
    if aimTrans == self.curFatherTrans then return end
    --- 从曲线集合获取相应曲线
    local curCurve = self.skillCardCurvesArr._animaCure
    self.curFatherTrans = aimTrans
    self.tweenDoMove = self.controller.transform:DOMove(aimTrans.position, TIME_OF_ARRANGE):SetEase(curCurve):OnComplete(function()
        KTool.SetParent(self.controller.gameObject, aimTrans.gameObject, false)
        self.controller.transform.anchoredPosition3D = Vector3.zero
        self.tweenDoMove = nil
    end)
end

---OnBeOverStateOfSelectSkillCard
---在技能卡被 选择卡略过时的状态 
function UIBattlingSkillCardsNode:OnBeOverStateOfSelectSkillCard()
    if IsNull(self.curAnimation) then return end
    self.curAnimation:Play(ANIMATION_BEOVERBYSELECTCARD)
end

---SkillCardDefautState
---技能卡 默认位置
function UIBattlingSkillCardsNode:SkillCardDefautState()
    if IsNull(self.curAnimation) then return end
    self.curAnimation:Play(ANIMATION_BEOVERSTATEBACKDEFAUT)
end

---AnimationSkillCardBeUnit
---被合成卡牌 动画
---@param type number  1:水平 2:竖直
function UIBattlingSkillCardsNode:AnimationSkillCardBeUnit(type)
    if IsNull(self.curAnimation) then return end
    local animaName
    if type == 1 then
        animaName = ANIMATION_BEUNIT_HOR
    elseif type == 2 then
        animaName = ANIMATION_BEUNIT_VER
    end
    if IsNull(animaName) then return end
    --- 重置父节点 坐标
    self:SkillCardPosReset()
    --- PTC_Unit_Rotation
    -- UIBattlingTools.ReloadPTCOfBattling(Constants.UIBattlingObjPoolPTC.PTC_CARD_UNIT_ROTATION_NAME, self.ParticalRoot.gameObject, 5, true)
    self.curAnimation:Play(animaName)
    self.coPlayAnim = cs_coroutine.start(
            function()
                while self.curAnimation.isPlaying do
                    cs_coroutine.yield_return()
                end
                self:SetSkillCardDefault()
            end)
end

---AnimationSkillCardUpgrade
---晋升卡牌动画
---@param type number  1:水平 2:竖直
function UIBattlingSkillCardsNode:AnimationSkillCardUpgrade(type)
    if IsNull(self.curAnimation) then return end
    local animaPart_1_Name
    local animaPart_2_Name
    if type == 1 then
        animaPart_1_Name = ANIMATION_UPGRADE_HOR1
        animaPart_2_Name = ANIMATION_UPGRADE_HOR2
    elseif type == 2 then
        animaPart_1_Name = ANIMATION_UPGRADE_VER1
        animaPart_2_Name = ANIMATION_UPGRADE_VER2
    end
    if IsNull(animaPart_1_Name) or IsNull(animaPart_2_Name) then return end
    --- 重置父节点 坐标
    self:SkillCardPosReset()
    local starEX = self.skillCardData.star
    if starEX > 1 then
        -- 二星合成的时候，移除二星的常驻特效
        if not isNull(self.ParticalRoot) then
            for i = self.ParticalRoot.childCount - 1, 0, -1 do
                if string.contains(self.ParticalRoot:GetChild(i).gameObject.name, "ui_9_ka_texiao_TwoStars") then
                    UIBattlingTools.RecyclePoolObj(self.ParticalRoot:GetChild(i).gameObject)
                end
            end
        end
    end
    ---PTC_Unit_Rota
    local PTC_Part1 = UIBattlingTools.ReloadPTCOfBattling(Constants.UIBattlingObjPoolPTC.PTC_CARD_UNIT_ROTATION_NAME, self.ParticalRoot.gameObject, 5, true)
    self:SetUnitPTCStar(PTC_Part1, starEX)
    self.curAnimation:Play(animaPart_1_Name)
    while not IsNull(self.curAnimation) and self.curAnimation.isPlaying do
        cs_coroutine.yield_return()
    end
    ---PTC_Unit_p2
    local PTC_Part2 = UIBattlingTools.ReloadPTCOfBattling(Constants.UIBattlingObjPoolPTC.PTC_CARD_UNIT_PART2_NAME, self.ParticalRoot.gameObject, 5, true)
    self:SetUnitPTCStar(PTC_Part2, starEX)
    self.curAnimation:Play(animaPart_2_Name)
    self:UpgradeSkillCard() -- 卡牌升级表现(加星)
    while not IsNull(self.curAnimation) and self.curAnimation.isPlaying do
        cs_coroutine.yield_return()
    end
    ---PTC_Unit_Upg
    local name = starEX < 2 and Constants.UIBattlingObjPoolPTC.PTC_STAR2_Name or Constants.UIBattlingObjPoolPTC.PTC_STAR3_Name
    UIBattlingTools.ReloadPTCOfBattling(name, self.ParticalRoot.gameObject, 9999, true)
end

--- 根据星级切换特效上面switch组件的Status
---@param ptc any
---@param star any
function UIBattlingSkillCardsNode:SetUnitPTCStar(ptc, star)
    local switchs = ptc.transform:GetComponentsInChildren(typeof(UISwitchParticleSystem))
    if switchs.Length > 0 then
        for i = 0, switchs.Length - 1, 1 do
            switchs[i].Status = star < 2 and 2 or 1
        end
    end
end

function UIBattlingSkillCardsNode:OnInteractiveInvalid()
    self:SkillCardBackCurPos()
    self.controller.transform.localScale = Vector3.one * self.defaultScale
    Events.Broadcast(Constants.EventNames.UIBattleSkillCardOnPress, false, self.controller)
end

---ShowEffectSequence
---技能卡 展示表现
function UIBattlingSkillCardsNode:ShowEffectSequence()
    --KTool.SetParent(self.controller.gameObject, self.skillCardsPoolGO, true)
    --local curCurve = self.skillCardCurvesArr._animaCure -- 从曲线集合获取相应曲线
    --self.curFatherTrans = self.skillCardAimTrans
    --self.controller.transform:DOAnchorPos(Vector2(self.skillCardAimTrans.anchoredPosition.x, self.skillCardAimTrans.anchoredPosition.y), TIME_OF_TO_AIM, false):SetEase(curCurve):OnComplete(
    --        function()
    --            KTool.SetParent(self.controller.gameObject, self.skillCardAimTrans.gameObject, true)
    --            self.controller.transform.anchoredPosition = Vector2.zero
    --            self:CheckSPSkillCardShow(self.skillCardSkillId, self.skillCardStarLevel)
    --            --- 开启交互节点
    --            self:SetEventReceiverEnableState(true)
    --        end)
    --self.curGOCanvasGroup.alpha = 0
    --self.curGOCanvasGroup:DOFade(1, TIME_OF_ALPHA_TO_FULL):SetEase(DOTween.Ease.InOutQuad)
    
    self.curFatherTrans = self.skillCardAimTrans
    self:SkillCardPosReset()
    --self:SetSkillCardAlphaZero()
    self.curAnimation:Play(ANIMATION_REPAIR)
    self:CheckSkillCardLoopPTCShow()
    self:SetEventReceiverEnableState(true)
    self:SetSkillCardCG2Show()
end


function UIBattlingSkillCardsNode:SetSkillCardCG2Show()
    if not IsNull(self.curGOCanvasGroup) then
        self.curGOCanvasGroup.alpha = 1
    end
end

---SkillCardBackCurPos
---卡牌回归原位 (交互结束)
function UIBattlingSkillCardsNode:SkillCardBackCurPos()
    self:SkillCardPosReset()
end

---SkillCardPosReset
---技能卡位置重置
function UIBattlingSkillCardsNode:SkillCardPosReset()
    if IsNull(self.curFatherTrans) then
        -- print("self.curFatherTrans is nil", debug.traceback)
        return
    end
    KTool.SetParent(self.controller.gameObject, self.curFatherTrans.gameObject)
    self.controller.transform.anchoredPosition3D = Vector3.zero
    self.controller.transform.localRotation = Quaternion.Euler(0, 0, 0)
end

---SkillCardBackCurArea
---卡牌回归原位并重置状态
function UIBattlingSkillCardsNode:SkillCardBackCurArea()
    self.typeInteractive = Type_Interaction.None
    self:SkillCardBackCurPos()
    --- Remove Canvas and Raycaster
    if not IsNull(self.raycasterSkillCardTouch) then
        KTool.SafeDelete(self.raycasterSkillCardTouch)
        self.raycasterSkillCardTouch = nil
    end
    if not IsNull(self.canvasSkillCardTouch) then
        KTool.SafeDelete(self.canvasSkillCardTouch)
        self.canvasSkillCardTouch = nil
    end
    self.controller.transform.localScale = Vector3.one * self.defaultScale
end

---SetEventReceiverEnableState
---@param boolean boolean
function UIBattlingSkillCardsNode:SetEventReceiverEnableState(boolean)
    if self.EventReceiver then
        self.EventReceiver.enabled = boolean
    end
end

---ResetCardAttributeType
---重新设置技能卡技能属性类型
function UIBattlingSkillCardsNode:ResetCardAttributeType(attributeType)
    base.GetSkillTypeImg(self, attributeType)
    base.SetSkillCardTypeIcon(self)
end

function UIBattlingSkillCardsNode:CleanCoInteraction()
    if self.coInteractive then
        cs_coroutine.stop(self.coInteractive)
        self.coInteractive = nil
    end
end

--- 获取卡牌星级icon的世界坐标
function UIBattlingSkillCardsNode:GetCardIndexWorldPos()
    return self.cardFrame.gameObject.transform.position
end

--- 播放改变卡牌星级的特效
---@param from integer
---@param to integer
function UIBattlingSkillCardsNode:PlayChangeCardStarEffect(from, to)
    self:SetSkillCardPtcDefault()
    local isUpgrad = from < to
    if isUpgrad then
        if to == 2 then
            UIBattlingTools.ReloadPTCOfBattling(Constants.UIBattlingObjPoolPTC.PTC_CARD_UPGRADE_NAME_122, self.ParticalRoot.gameObject, 3, true)
        elseif to == 3 then
            UIBattlingTools.ReloadPTCOfBattling(Constants.UIBattlingObjPoolPTC.PTC_CARD_UPGRADE_NAME_223, self.ParticalRoot.gameObject, 3, true)
        end
    else
        if to == 2 then
            UIBattlingTools.ReloadPTCOfBattling(Constants.UIBattlingObjPoolPTC.PTC_CARD_DOWNGRADE_NAME_322, self.ParticalRoot.gameObject, 3, true)
        elseif to == 1 then
            UIBattlingTools.ReloadPTCOfBattling(Constants.UIBattlingObjPoolPTC.PTC_CARD_DOWNGRADE_NAME_221, self.ParticalRoot.gameObject, 3, true)
        end
    end
end

return UIBattlingSkillCardsNode