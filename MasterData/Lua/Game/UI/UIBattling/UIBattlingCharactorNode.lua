------------ import ------------
local KTool = CS.Engine.Lib.KTool
local cs_coroutine = require("XLua.cs_coroutine")
local Yielders = CS.Engine.Lib.Yielders
local GameUtils = CS.GameUtils
local CDTimerModule = CS.Engine.Modules.CDTimerModule
local CDTimer = CDTimerModule.GetInstance()
local UIBattlingCtrlMgr = import("Game.UI.UIBattling.UIBattlingCtrlMgr")
local Time = CS.UnityEngine.Time
local RectTransform = CS.UnityEngine.RectTransform
local UISwitchImage = CS.Game.Native.Common.UISwitchImage
local CanvasGroup = CS.UnityEngine.CanvasGroup
local Image = CS.UnityEngine.UI.Image
local XLuaUtils = CS.Engine.Lib.XLuaUtils
local Animation = CS.UnityEngine.Animation
local UIModule = CS.Engine.UI.UIModule
local SettingMgr = import("Game.Setting.SettingMgr")
------------ import ------------

------------ define ------------
local BUFF_SEQUENCE_START_X = 13
local BUFF_SEQUENCE_START_Y = -27
local BUFF_SEQUENCE_PADDING = 30
local NUM_SHOW_BUFF_MAX = 99 --- 显示
--- 伤害跳字 X 位置
local POS_X = {
    [1] = -25,
    [2] = 0,
    [3] = 25,
}
--- Sp 点数类型
local TYPE_SP = {
    SpPoint = 1,
    SpTemp = 2,
}
--- New
local JUMP_NODE_DISTANCE_Y = 40
local JUMP_NODE_DISTANCE_X = 10
local JUMP_NODE_INTERVAL_RESET_POS = 0.2
local JUMP_NODE_INIT_POS = Vector2.New(0,100)
---
local IMG_HP_ORIGIN_WIDTH = 121.305 -- 血条初始长度
local IMG_HP_ORIGIN_WIDTH_BOSS = 151.894    -- boss血条初始长度
--- sp点动画列表
local LIST_SP_ANIMATION = {
    Bright = 1,
    Dark = 2,
}
-- 护盾罩子动画
local AnimationShowShield = "UIFX_ImgShieldEntryGlow"
local AnimationBreakShield = "UIFX_ImgShieldBrokenGlow"

-- SP值变化飘字偏移
local SP_CHANGE_JUMP_NODE_OFFSET = Vector2.New(-150, 100)

-- 开场被动buff的间隔
local PassiveBuffIntervalTime = 0.5
--------------- define ------------

---@class BuffDesVo
---@field type integer  buff类型（0：普通buff，1：羁绊，2：觉醒，3：猫球）
---@field buffDes string
---@field buffValue string
local BuffDesVo = {}
function BuffDesVo.New(type, buffDes, buffValue, buffType, buffId)
    ---@type BuffDesVo
    local this = {}
    setmetatable(this, { __index = BuffDesVo })
    this.type = type
    this.buffDes = buffDes
    this.buffValue = buffValue
    this.buffType = buffType
    this.buffId = buffId    -- 可能为空（有的跳字是手动构造的，没有buffId）
    return this
end

--- from: Assets/BundleResources/Prefabs/UIBattling/CharactorBossInfoNode.prefab
---@class UIBattlingCharactorNode
---@field Env                           	UIBattlingCharactorNode                 
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field RT_CharactorHpMultilayer      	UnityEngine.RectTransform               
---@field Animation_ShieldCover         	UnityEngine.Animation                   
---@field CG_ShieldCover                	UnityEngine.CanvasGroup                 
---@field Root_SelectTargetTeam         	UnityEngine.RectTransform               
---@field Root_SelectTargetEnemy        	UnityEngine.RectTransform               
---@field TapReceiver                   	UnityEngine.UI.Extensions.NonDrawingGraphic
---@field HpSwitchRoot                  	UnityEngine.RectTransform               
---@field Txt_SPPreview                 	TMPro.TextMeshProUGUI                   
---@field SpPoint                       	UnityEngine.RectTransform               
---@field Root_SpPoint                  	UnityEngine.RectTransform               
---@field AttributeIcon                 	Engine.UI.ImageAlterable                
---@field CharactorInfoRoot             	UnityEngine.RectTransform               
---@field CharactorUseCardRoot          	UnityEngine.RectTransform               
---@field HitJumpNumRoot                	UnityEngine.RectTransform               
---@field CharactorBuffRoot             	UnityEngine.RectTransform               
---@field CharactorShield               	UnityEngine.RectTransform               
---@field CharactorShieldDy             	UnityEngine.RectTransform               
---@field CharactorInfoShieldBg         	UnityEngine.CanvasGroup                 
---@field CharactorHpDy                 	UnityEngine.RectTransform               
---@field CharactorHp                   	UnityEngine.RectTransform               
---@field CharactorHpBlock              	UnityEngine.UI.Image                    
local UIBattlingCharactorNode = Class("UIBattlingCharactorNode")

------------ lifeCycle ------------

function UIBattlingCharactorNode:__init()
    self.roleId = 0 -- 角色信息对应的角色唯一 Id
    self.charactorHpMax = 0 -- 角色 血量上限
    self.charactorAlive = true -- 角色是否存活
    self.charactorBuffShowList = {} -- 角色 buff 描述展示 List
    self.coWaittingAnima = nil -- 等待动画协程
    self.curCharactorHaveSPPoint = 0 -- 角色当前已得到的能量点
    self.curCharactorHadSPPointInRountStart = 0 -- 角色在回合开始时已有的Sp点
    self.booleanIsBoss = false -- 是否是Boss
    self.booleanIsHideInfo = false
    self._roleView = nil --对应的角色
    self.numMaxSP = nil --角色的SP点数上限
    self.coShowNodeInAnimation = nil -- 技能展示阶段 血条展示 协程
    self.numJumpNodeXValue = 1 -- 伤害跳字 X 坐标
    self.listSPNodes = nil -- 角色 SP 点集合
    self.coShowHpChange = nil -- 血条变化协程
    self.coDelayShow = nil  -- 血条变化延迟携程
    self.timer = nil -- 伤害飘字 位置重置计时器
    self.compTest = nil
    self.rectHpBlink = nil
    self.hpMaxNow = 1 -- 当前角色的血量上限
    self.timeProcess = 999
    self.hpPreChange = 0
    self.cgHPDy = nil
    self.cgShieldDy = nil
    self.cgHPBlock = nil
    self.rectTransform = nil
    self.rootFather = nil
    self.rootHitAPosition = nil
    self.Img_HpTop = nil    -- 上层血条的图片
    self.realNum = 0
    self.tempNum = 0
    self.hpImgLength = 100
    self.selectBuffIcon = nil   -- 选择buff目标的UI
    self.isMultiMode = nil          -- 多血条模式
    self.multiNum = nil             -- 多血条模式下，血条数量
    self.curHPProgress = nil        -- 当前血量百分比
    self.curShieldProgress = nil    -- 当前护盾百分比
    self.Txt_MultiNum = nil
    self.SImg_HpTop = nil
    self.SImg_HpMid = nil
    self.coChangeSPJumpNode = nil   -- 改变sp的跳字协程
end

function UIBattlingCharactorNode:__delete()
    self.roleId = nil
    self.charactorHpMax = nil
    self.charactorAlive = nil
    self.charactorBuffShowList = nil
    self.curCharactorHaveSPPoint = nil
    self.curCharactorHadSPPointInRountStart = nil
    self.coWaittingAnima = nil
    self.booleanIsBoss = nil
    self.booleanIsHideInfo = nil
    self._roleView = nil
    self.coShowNodeInAnimation = nil
    self.numJumpNodeXValue = nil
    self.numMaxSP = nil
    self.coShowHpChange = nil
    self.coDelayShow = nil
    self.timer = nil
    self.compTest = nil
    self.hpMaxNow = nil
    self.timeProcess = nil
    self.hpPreChange = nil
    self.listSPNodes = nil
    self.cgRootUseCard = nil
    self.cgHPBlock = nil
    self.rectTransform = nil
    self.rootFather = nil
    self.rootHitAPosition = nil
    self.Img_HpTop = nil    -- 上层血条的图片
    self.realNum = nil
    self.tempNum = nil
    self.hpImgLength = nil
    self.selectBuffIcon = nil   -- 选择buff目标的UI
    self.isMultiMode = nil          -- 多血条模式
    self.multiNum = nil             -- 多血条模式下，血条数量
    self.curHPProgress = nil
    self.curShieldProgress = nil
    self.Txt_MultiNum = nil
    self.SImg_HpTop = nil
    self.SImg_HpMid = nil
    self.coChangeSPJumpNode = nil   -- 改变sp的跳字协程
    self.controller = nil
    self = nil
end

function UIBattlingCharactorNode:Awake()
    --self.rectHpBlink = self.CharactorHpBlink.transform:GetComponent(typeof(RectTransform))
    --self.cgHPDy = self.CharactorHpDy.gameObject:GetComponent(typeof(CanvasGroup))
    --self.cgShieldDy = self.CharactorShieldDy.gameObject:GetComponent(typeof(CanvasGroup))
    --UIEventProxy.Create(self.TapReceiver.gameObject).onPointerClick = function()
    --    UIModule.OpenDialog({id = Constants.UITypeIds.UIBattlingBuffInfoListDialog, parameters = {roleId = self.roleId } })
    --end
    self.cgRootUseCard = self.CharactorUseCardRoot.gameObject:GetComponent(typeof(CanvasGroup))
    self.cgHPBlock = self.CharactorHpBlock.gameObject:GetComponent(typeof(CanvasGroup))
    self.rectTransform = KTool.GetComponent(self.controller.gameObject, typeof(RectTransform))
    self:SetCharactorShield(0)
    self:SetCGUseCardShow(false)
    self.rootHitAPosition = JUMP_NODE_INIT_POS

    self.SImg_HpTop = self.CharactorHp:GetComponent(typeof(UISwitchImage))
    self.SImg_HpMid = self.CharactorHpDy:GetComponent(typeof(UISwitchImage))

    local RT_TxtTimes = self.HpSwitchRoot:Find("TxtTimes")
    if not isNull(RT_TxtTimes) then
        self.Txt_MultiNum = RT_TxtTimes:GetComponent(typeof(CS.TMPro.TextMeshProUGUI))
    end

    self.Anim_Root = self.CharactorInfoRoot.gameObject:GetComponent(typeof(Animation))

    -- 读表获取被动buff的间隔时间
    local tableFile = SettingMgr:GetInstance():Get(AutoIds.IdSetting267)
    local row = tableFile:GetByPrimaryKey("passiveBuffIntervalTime")
    PassiveBuffIntervalTime = parse_number(row,"para", 0.5)
end

function UIBattlingCharactorNode:OnDestroy()
    if not isNull(self.selectBuffIcon) then
        UIBattlingTools.RecyclePoolObj(self.selectBuffIcon)
    end
    if not IsNull(self.coWaittingAnima) then
        cs_coroutine.stop(self.coWaittingAnima)
    end
    self:StopJumpNumTimer()
    self:StopCoShowNodeInSkillShow()
    if self.coShowHpChange then
        cs_coroutine.stop(self.coShowHpChange)
    end
    if not isNull(self.coDelayShow) then
        cs_coroutine.stop(self.coDelayShow)
        self.coDelayShow = nil
    end

    if not IsNull(self.coShowShieldChange) then
        cs_coroutine.stop(self.coShowShieldChange)
    end
    if isNotNull(self.coChangeSPJumpNode) then
        cs_coroutine.stop(self.coChangeSPJumpNode)
    end
    self.controller = nil
    --luabehaviour 中CSharp对象
    self:Delete()
    self = nil
end

------------ lifeCycle ------------

------------ NodeData ------------

function UIBattlingCharactorNode:SetRootFather(obj)
    self.rootFather = obj
end

---SetCharactorId
---设置 角色 Id
---@param id number 角色Id
function UIBattlingCharactorNode:SetCharactorId(id)
    self.roleId = id
    if not isNull(BattleViewMgr) then
        self._roleView = BattleViewMgr:FindRoleView(id)
    end
end

---GetBuffRoot
---获取 buff 生成位置点
function UIBattlingCharactorNode:GetBuffRoot()
    return self.CharactorBuffRoot
end

---GetRoleId
---获取 角色 Id
function UIBattlingCharactorNode:GetRoleId()
    return self.roleId
end

---GetCharactorInfoRootShowState
---获取角色信息面板节点 显示 状态
function UIBattlingCharactorNode:GetCharactorInfoRootShowState()
    return self.CharactorInfoRoot.gameObject.activeSelf
end

---GetCharactorAliveState
---获取角色存活状态
function UIBattlingCharactorNode:GetCharactorAliveState()
    return self.charactorAlive
end

function UIBattlingCharactorNode:SetCharacterInfoRootScale(vScale)
    if not IsNull(self.CharactorInfoRoot)  then
        self.CharactorInfoRoot.localScale = vScale
    end
end

------------ NodeData ------------

------------ function ------------

---GetHitJumpNodeRoot
---获取跳字初始位置
function UIBattlingCharactorNode:GetHitJumpNodeRoot()
    return self.HitJumpNumRoot and { root = self.HitJumpNumRoot,
                                     posX = POS_X[self.numJumpNodeXValue + 1 > 3 and 1 or self.numJumpNodeXValue + 1] } or nil
end

---CharacterNodeFollowingFun
--- 血条跟随功能函数
function UIBattlingCharactorNode:CharacterNodeFollowingFun()
    if not IsNull(self._roleView) then
        if self.controller.transform and self._roleView.transform then
            local scale = self._roleView.transform.localScale
            local vPosY = self._roleView.centerY * scale.y * 2 + 0.3
            return GameUtils.IsFinishSetFollow(self.rectTransform, self._roleView.transform, self.rootFather, vPosY)
        end
    end
end


---SetGameObjectState
---设置游戏物体显示状态
---@param boolean boolean @ 显示状态
function UIBattlingCharactorNode:SetGameObjectState(boolean)
    if isNotNull(self.Anim_Root) then
        -- 这个动画组件在self.CharactorInfoRoot上面，播放震动动画的时候，可能导致血条又从9999又回来了
        self.Anim_Root.enabled = boolean
    end
    xTry(function() 
        if not checkBool(self.charactorAlive) then
            self.CharactorInfoRoot.anchoredPosition = Vector2.New(-9999, -9999)
            return 
        end
    end)
    
    if not self.booleanIsHideInfo then
        self:SetBuffNodeTxtGOActive(boolean) -- 所属 BuffNode 状态
        self.CharactorInfoRoot.anchoredPosition = boolean
                and Vector2.New(0, 0)
                or Vector2.New(-9999, -9999)
        if isNotNull(UIBattleBuffMgr) then
            UIBattleBuffMgr:ListBuffNodesSyncTxtPos(self.roleId)
        end
        if not IsNull(self.TapReceiver) then
            self.TapReceiver.enabled = boolean
        end
    end
end

---SetNodeShowState
---设置 人物信息条显示状态
---@param type number 显示状态
function UIBattlingCharactorNode:SetNodeShowState(type)
    if type == 1 then
        KTool.SetActive(self.CharactorInfoRoot.gameObject, true)
        --self.booleanIsBoss = false
        self.booleanIsHideInfo = false
    elseif type == 2 then
        KTool.SetActive(self.CharactorInfoRoot.gameObject, false)
        if not IsNull(self.TapReceiver) then
            self.TapReceiver.enabled = false
        end
        self.booleanIsHideInfo = true
        --self.booleanIsBoss = true
    end
end

---RecycleCharactorNode
---回收 CharactorNode
function UIBattlingCharactorNode:RecycleCharactorNode()
    self:CleanSPNode()
    UIBattleBuffMgr:CleanListBuffNode(self.roleId)
    --- 回收 Node
    UIBattlingTools.RecyclePoolObj(self.controller.gameObject)
end

---SetCharactorInfo
--- 设置人物默认状态
---@param charactorData table
function UIBattlingCharactorNode:SetCharactorInfo(charactorData)
    self.hpImgLength = self.booleanIsBoss == true and IMG_HP_ORIGIN_WIDTH_BOSS or IMG_HP_ORIGIN_WIDTH
    self:SetCharactorId(charactorData.battleFieldId)
    --- 设置角色 血量上限
    local charactorAttrHpValue = UIBattlingDataMgr:GetCharactorHpMaxValueByBattleFieldId(self.roleId)
    if not IsNull(charactorAttrHpValue) then
        self.charactorHpMax = charactorAttrHpValue
    end
    self.charactorAlive = true
    --- 血条
    self.Img_HpTop = KTool.GetComponent(self.CharactorHp.gameObject, typeof(Image))
    self.hpMaxNow = 1 -- 初始化人物血量上限
    self.curHPProgress = 1
    self.curShieldProgress = 0
    -- 初始血量
    local initProgress = charactorData.HpPreInBattleStart
    if not isNull(charactorData.multiNum) and charactorData.multiNum > 1 then
        self.isMultiMode = true
        self.multiNum = charactorData.multiNum
        if not isNull(self.Txt_MultiNum) then
            KTool.SetActive(self.Txt_MultiNum, true)

            -- 多条血需要把百分比做一个转换
            local newShowNum, newShowProgress = UIBattlingTools.HP2MultiMode(initProgress, self.multiNum)
            initProgress = newShowProgress
            self.Txt_MultiNum.text = string.format("x%d", newShowNum)
        end
    end
    --- 血条初始进度
    self:SetCharacterHpProcess(initProgress)
    --- 设置角色 Sp 信息
    self.numMaxSP = charactorData.SpMax
    self:CleanSPNode()
    self:CreateSPNode(self.numMaxSP)
    --- 设置人物属性 Icon
    if not IsNull(charactorData.AttrType) then
        self:SetCharactorAttriType(charactorData.AttrType)
    end
    --- 设置人物阵营
    if charactorData.isPlayer then
        KTool.SetActive(self.RT_RaceMonster, false)
        KTool.SetActive(self.ImgAlt_RaceRole, true)
        local roleDataUI = UIBattlingDataMgr:GetCharactorDataById(self.roleId)
        local cardId = roleDataUI.cardId -- 角色卡牌Id
        local cardVo = CardConfMgr:GetCardByRefId(cardId)
        self.ImgAlt_RaceRole:LoadSprite(UIBattlingTools.GetCareerIconCommon(cardVo.career, true))
    end
    -- 根据阵营调整血条颜色
    local camp = UIBattlingDataMgr:GetRoleCampByRoleId(charactorData.battleFieldId)
    if not isNull(self.SImg_HpTop) then
        self.SImg_HpTop.Status = BattleInfo:IsUserCamp(camp) and 1 or 2
    end
    if not isNull(self.SImg_HpMid) then
        self.SImg_HpMid.Status = BattleInfo:IsUserCamp(camp) and 1 or 2
    end
    -- print("[血条] data", table.dump(charactorData, nil, 3))
    --self.HpSwitchRoot.localScale = charactorData.roleType == Constants.TargetCamp.Friend and Vector3.one or Vector3.New(0.8, 0.8, 1)
    self:SetGameObjectState(true)
end

---SetCharacterHpProcess
---直接设置 血量进度
---@param pre number
function UIBattlingCharactorNode:SetCharacterHpProcess(pre)
    local processHp = pre * self.hpImgLength
    self:SetHpTopProgress(pre)
    -- self.CharactorHp.sizeDelta = Vector2.New(processHp, self.CharactorHp.sizeDelta.y)
    --self.rectHpBlink.sizeDelta = Vector2.New(processHp, self.rectHpBlink.sizeDelta.y)
    self.CharactorHpDy.sizeDelta = Vector2.New(processHp, self.CharactorHpDy.sizeDelta.y)
end

function UIBattlingCharactorNode:SetHpTopProgress(progress)
    local processHp = progress * self.hpImgLength
    self.CharactorHp.sizeDelta = Vector2.New(processHp, self.CharactorHp.sizeDelta.y)
    -- 根据血线修改血条颜色
    -- if progress > 0.7 then
    --     self.Img_HpTop.color = XLuaUtils.HexToColor(Constants.HPSliderColor.Green)
    -- elseif progress > 0.4 then
    --     self.Img_HpTop.color = XLuaUtils.HexToColor(Constants.HPSliderColor.Yellow)
    -- else
    --     self.Img_HpTop.color = XLuaUtils.HexToColor(Constants.HPSliderColor.Red)
    -- end
end

---SetCharactorAttriType
---设置角色的 属性类型
---@param attriType number 属性类型
function UIBattlingCharactorNode:SetCharactorAttriType(attriType)
    if not IsNull(self.AttributeIcon) then
        local attriTypeIconPath = UIBattlingTools.GetAttriTypeIcon(attriType, true)
        if not IsNull(attriTypeIconPath) then
            self.AttributeIcon:LoadSprite(attriTypeIconPath) 
        end
    end
end

---SetNodeInSkillShow
---技能表现阶段 展示 血条
function UIBattlingCharactorNode:SetNodeInSkillShow()
    if (not self.charactorAlive) or self.booleanIsHideInfo then return end
    self:StopCoShowNodeInSkillShow()
    self:SetGameObjectState(true)
    self.coShowNodeInAnimation = cs_coroutine.start(function()
        cs_coroutine.yield_return(Yielders.GetWaitForSeconds(2.5))
        self:SetGameObjectState(UIBattlingCtrlMgr:GetInstance():GetBooleanPlayerInput())
        self.coShowNodeInAnimation = nil
    end)
end

---StopCoShowNodeInSkillShow
---停止血条自动隐藏协程
function UIBattlingCharactorNode:StopCoShowNodeInSkillShow()
    if not IsNull(self.coShowNodeInAnimation) then
        cs_coroutine.stop(self.coShowNodeInAnimation)
        self.coShowNodeInAnimation = nil
    end
end

function UIBattlingCharactorNode:ShieldShellAnimation(value, valueMax, isDisappear)
    local oldProgress = self.curShieldProgress
    local newProgress = value / valueMax
    if newProgress > 0 then
        if oldProgress <= 0 then
            -- 加盾动画
            -- print("[护盾] 加盾")
            self.CG_ShieldCover.alpha = 1
            self.Animation_ShieldCover:Play(AnimationShowShield)
        else
            -- 受击动画
            -- print("[护盾] 受击")
            KTool.SetActive(self.RT_FXShieldGlow, false)
            self.RT_FXShieldGlow.sizeDelta = Vector2.New(oldProgress * self.hpImgLength, self.RT_FXShieldGlow.sizeDelta.y)
            self.RT_FXShieldHit.localPosition = Vector3.New(newProgress * self.hpImgLength, 0, 0)
            KTool.SetActive(self.RT_FXShieldGlow, true)
        end
    else
        if not isDisappear then
            -- 碎盾动画
            -- print("[护盾] 碎盾")
            self.Animation_ShieldCover:Play(AnimationBreakShield)
        else
            -- 消失动画
            -- print("[护盾] 消失")
            self.CG_ShieldCover:DOFade(0, 0.3)
        end
    end
end

---SetCharactorShield
---设置角色 护盾
---@param value number 护盾值
function UIBattlingCharactorNode:SetCharactorShield(value, valueMax)
    if isNull(self.shieldValueEX) then self.shieldValueEX = 0 end
    if self.charactorHpMax <= 0 then return end

    local isDisappear = false
    if valueMax == 0 then
        valueMax = 1
        isDisappear = true
    end

    self:ShieldShellAnimation(value, valueMax, isDisappear)  -- 护盾罩子的动画

    local shieldPre = value / valueMax
    self.curShieldProgress = shieldPre
    shieldPre = math.floor(shieldPre * 100 + 0.5) * 0.01
    if shieldPre <= 0 then
        shieldPre = 0
    elseif shieldPre >= 1 then
        shieldPre = 1
    end
    self.CharactorInfoShieldBg.alpha = shieldPre > 0 and 1 or 0
    if shieldPre <= 0 then return shieldPre end
    local roleView = UIBattlingTools.GetRoleViewData(self.roleId)
    if roleView then
        local isSkillPerforming = roleView.isSkillPerforming
        if not isSkillPerforming then
            self:SetNodeInSkillShow()
        end
    end
    if self.coShowShieldChange then
        cs_coroutine.stop(self.coShowShieldChange)
        self.coShowShieldChange = nil
    end
    self.CharactorShield.sizeDelta = Vector2.New(shieldPre * self.hpImgLength, self.CharactorShield.sizeDelta.y)
    -- self.coShowShieldChange = cs_coroutine.start(function()
    --     --self.cgShieldDy.alpha = 1
    --     local PreChange = self.CharactorShieldDy.sizeDelta.x -  shieldPre * self.hpImgLength
    --     local timeProcess = 0
    --     while timeProcess <= Constants.TIME_HP_CHANGE do
    --         timeProcess = timeProcess + Time.deltaTime
    --         local hpChangePre = timeProcess / Constants.TIME_HP_CHANGE
    --         local valueX = self.CharactorShieldDy.sizeDelta.x - hpChangePre * PreChange
    --         self.CharactorShieldDy.sizeDelta = Vector2.New(valueX, self.CharactorShieldDy.sizeDelta.y)
    --         cs_coroutine.yield_return(Yielders.GetWaitForSeconds(Time.deltaTime))
    --     end
    --     self.CharactorShieldDy.sizeDelta = Vector2.New(shieldPre * self.hpImgLength, self.CharactorShieldDy.sizeDelta.y)
    --     --self.cgShieldDy.alpha = 0
    --     self.coShowShieldChange = nil
    -- end)
    self.shieldValueEX = shieldPre
    return shieldPre
end

---SetCharactorHp
---设置角色血量
---@param pre number 角色血量百分比
function UIBattlingCharactorNode:SetCharactorHp(data)
    local pre = data.per
    -- if isSet(data, "maxPer") then
    --     xTry(function()
    --         self.hpMaxNow = data.maxPer
    --         local preLocked = 1 - self.hpMaxNow
    --         preLocked = preLocked < 0 and 0 or preLocked
    --         preLocked = preLocked > 1 and 1 or preLocked
    --         self.CharactorHpBlock.fillAmount = 1 - self.hpMaxNow
    --     end)
    -- end
    -- self.cgHPBlock.alpha = (self.hpMaxNow and self.hpMaxNow < 1) and 1 or 0
    if pre <= 0 then
        --- 设置角色存活状态
        self.charactorAlive = false
        UIBattlingDataMgr:SetCharactorAliveState(self.roleId, false)
        self:SetGameObjectState(false)
        --- 角色死亡以后肯定是不显示血条了，取消这个协程，防止再把血条显示出来
        self:StopCoShowNodeInSkillShow()
        --- 广播事件检查 玩家队伍人物存活状态
        Events.Broadcast(Constants.EventNames.UIBattlingUpdateCharacterAliveState, self.roleId)
        self:SetCharacterHpProcess(0)
        UIBattleBuffMgr:CleanListBuffNode(self.roleId)
    else
        local value = pre >= 1 and 1 or pre
        -- value = value * self.hpMaxNow -- 当前血量(结合当前总血量)
        self:CharacterHPChange(value)
    end
    local roleView = UIBattlingTools.GetRoleViewData(self.roleId)
    if roleView then
        local isSkillPerforming = roleView.isSkillPerforming
        if not isSkillPerforming then
            self:SetNodeInSkillShow()
        end
    end
end

---CharacterHPChange
---人物血条变化
---@param newProgress number 血量百分比
function UIBattlingCharactorNode:CharacterHPChange(newProgress)
    xTry(function()
        local oldProgress = self.curHPProgress
        self.curHPProgress = newProgress

        if self.isMultiMode then
            -- 多条模式
            local oldShowNum, oldShowProgress = UIBattlingTools.HP2MultiMode(oldProgress, self.multiNum)
            local newShowNum, newShowProgress = UIBattlingTools.HP2MultiMode(newProgress, self.multiNum)

            if newProgress > oldProgress then
                -- 加血
                self:SetHpMidProgress(newShowProgress)
                self:SetHpTopProgress(newShowProgress)
            else
                -- 扣血
                if oldShowNum == newShowNum then
                    self:SetHpTopProgress(newShowProgress)
                    self:LerpHpMidProgress(newShowProgress)
                else
                    self:SetHpTopProgress(newShowProgress)
                    self:SetHpMidProgress(1)      -- 把条重置到满的，并停掉之前的lerp
                    self:LerpHpMidProgress(newShowProgress)

                    -- 条数发生变化时，播放震动动画
                    if isNotNull(self.Anim_Root) then
                        self.Anim_Root:Play("CharactorBossInfoNode_HpShake")
                    end
                end
            end
            -- 设置数量
            if not isNull(self.Txt_MultiNum) then
                self.Txt_MultiNum.text = string.format("x%d", newShowNum)
            end
            KTool.SetActive(self.Txt_MultiNum, newShowNum > 1)  -- 最后一条血不显示数字了
            if isNotNull(self.RT_CharactorHpMultilayer) then
                KTool.SetActive(self.RT_CharactorHpMultilayer, newShowNum > 1)  -- 除了最后一条血，都显示灰色的底色
            end
        else
            -- 单条模式
            if newProgress > oldProgress then
                -- 加血
                self:SetHpMidProgress(newProgress)
                self:SetHpTopProgress(newProgress)
            else
                -- 扣血
                self:SetHpTopProgress(newProgress)
                self:LerpHpMidProgress(newProgress)
            end
        end
        
    end)
end

function UIBattlingCharactorNode:SetHpMidProgress(newProgress)
    self:StopLerpHpCo()
    local processHp = newProgress * self.hpImgLength
    self.CharactorHpDy.sizeDelta = Vector2.New(processHp, self.CharactorHpDy.sizeDelta.y)
end

function UIBattlingCharactorNode:LerpHpMidProgress(newProgress)
    if self.coDelayShow then
        cs_coroutine.stop(self.coDelayShow)
        self.coDelayShow = nil
    end
    local y = self.CharactorHpDy.sizeDelta.y
    local fromProgress = self.CharactorHpDy.sizeDelta.x / self.hpImgLength
    local toProgress = newProgress
    self.coDelayShow = cs_coroutine.start(function()
        -- 延迟1s
        cs_coroutine.yield_return(Yielders.GetWaitForSeconds(1.2))
        --- 内层血条缩进开始 过程 0.12s
        local timer = 0
        while timer <= Constants.TIME_HP_CHANGE do
            timer = timer + Time.deltaTime
            local t = timer / Constants.TIME_HP_CHANGE
            local p = Mathf.Lerp(fromProgress, toProgress, t)
            self.CharactorHpDy.sizeDelta = Vector2.New(p * self.hpImgLength, y)
            cs_coroutine.yield_return(Yielders.GetWaitForSeconds(Time.deltaTime))
        end
        self.CharactorHpDy.sizeDelta = Vector2.New(toProgress * self.hpImgLength, y)
        self.coDelayShow = nil
    end)
end

function UIBattlingCharactorNode:StopLerpHpCo()
    if not isNull(self.coDelayShow) then
        cs_coroutine.stop(self.coDelayShow)
        self.coDelayShow = nil
    end
    if not isNull(self.coShowHpChange) then
        cs_coroutine.stop(self.coShowHpChange)
        self.coShowHpChange = nil
    end
end

--@region 新SP点

--- 修改sp点的最大值
---@param newMax any
function UIBattlingCharactorNode:ChangeSpMax(newMax)
    self.numMaxSP = newMax
    self.realNum = math.min(self.realNum, self.numMaxSP)
    self.tempNum = math.min(self.tempNum, self.numMaxSP)
end

--- 根据当前的点数，刷新sp点的显示
function UIBattlingCharactorNode:RefreshSpView()
    if self.realNum > 0 then
        for i = 1, self.realNum, 1 do
            self:SpNodeBeReal(self.listSPNodes[i], true)
        end
    end
    if self.tempNum > 0 then
        for i = 1, self.tempNum, 1 do
            self:SpNodeBeTemp(self.listSPNodes[i + self.realNum], true)
        end
    end
end

--- 判断sp点是否满了
function UIBattlingCharactorNode:IsSpFull()
    return self.realNum >= self.numMaxSP
end

--- 直接设置真实的sp点，不使用动画时会去掉所有临时点
---@param num any
function UIBattlingCharactorNode:SetRealSpNum(num, animChange)
    if animChange then
        if num > self.realNum then
            self:FillTempSpNum(num - self.realNum)
        else
            self:SubRealSpNum(self.realNum - num)
        end
    else
        for i = 1, #self.listSPNodes, 1 do
            local spNode = self.listSPNodes[i]
            if i <= num then
                -- 打开
                self:SpNodeBeReal(spNode, false)
            else
                -- 关闭
                self:SpNodeBeEmpty(spNode, false)
            end
        end
        self.realNum = num
        self.tempNum = 0
        if self.realNum == self.numMaxSP then
            self:AllSpNodeFull()
        end
    end
end

--- 增加sp点，有一个增加动画（不会填充临时点，临时点往后串）
---@param num any
function UIBattlingCharactorNode:AddRealSpNum(num)
    if self.realNum >= self.numMaxSP then return end

    local fromIndex = math.min(self.realNum + 1, self.numMaxSP)
    local toIndex = math.min(self.realNum + num, self.numMaxSP)
    for i = fromIndex, toIndex, 1 do
        local spNode = self.listSPNodes[i]
        self:SpNodeBeReal(spNode, true)
    end
    self.realNum = math.min(self.realNum + num, self.numMaxSP)
    self.tempNum = math.min(self.numMaxSP - self.realNum, self.tempNum)
    if self.realNum == self.numMaxSP then
        self:AllSpNodeFull()
    else
        self:RefreshTempSp()
    end
end

--- 填充临时点变成真实点，有一个增加动画（即便没有临时点，也会增加一个真实点）
---@param num any
function UIBattlingCharactorNode:FillTempSpNum(num)
    if self.realNum >= self.numMaxSP then return end

    local fromIndex = math.min(self.realNum + 1, self.numMaxSP)
    local toIndex = math.min(self.realNum + num, self.numMaxSP)
    for i = fromIndex, toIndex, 1 do
        local spNode = self.listSPNodes[i]
        self:SpNodeBeReal(spNode, true)
    end
    self.realNum = math.min(self.realNum + num, self.numMaxSP)
    self.tempNum = math.max(self.tempNum - num, 0)
    if self.realNum == self.numMaxSP then
        self:AllSpNodeFull()
    end
end

--- 减少sp点，有一个减少动画（不影响临时点）
---@param num any
function UIBattlingCharactorNode:SubRealSpNum(num)
    if self.realNum <= 0 then return end
    if num == 0 then return end

    local fromIndex = self.realNum
    local toIndex = self.realNum - num
    for i = fromIndex, (toIndex + 1), -1 do
        local spNode = self.listSPNodes[i]
        self:SpNodeBeEmpty(spNode, true)
    end
    -- 因为有可能原来是满的，所以这里要real一下
    if toIndex > 0 then
        for i = toIndex, 1, -1 do
            local spNode = self.listSPNodes[i]
            self:SpNodeBeReal(spNode, false)
        end
    end
    self.realNum = math.max(self.realNum - num, 0)
    -- self:RefreshTempSp()     -- 如果在减少sp点的时候刷新临时点，会导致减少动画播不出来（因为现在出牌阶段也不对减少sp点，所以就先不刷新了）
end

--- 增加临时点
---@param num any
function UIBattlingCharactorNode:AddTempSpNum(num)
    if self.realNum >= self.numMaxSP then return end
    if self.realNum + self.tempNum >= self.numMaxSP then return end

    self.tempNum = math.min(self.tempNum + num, self.numMaxSP - self.realNum)
    self:RefreshTempSp()

    -- 新增加的临时点要播放一个获得sp的特效
    local newTempSpIndex = self.realNum + self.tempNum
    local spNode = self.listSPNodes[newTempSpIndex]
    self:SpNodeBeTemp(spNode, true)
end

--- 刷新临时点的位置（增加真实点的时候，临时点往后串）
function UIBattlingCharactorNode:RefreshTempSp()
    if self.realNum >= self.numMaxSP then return end

    local fromIndex = self.realNum + 1
    local toIndex = self.realNum + self.tempNum
    for i = fromIndex, toIndex, 1 do
        local spNode = self.listSPNodes[i]
        self:SpNodeBeTemp(spNode)
    end
    if toIndex < self.numMaxSP then
        for i = toIndex + 1, self.numMaxSP, 1 do
            local spNode = self.listSPNodes[i]
            self:SpNodeBeEmpty(spNode, false)
        end
    end
end

function UIBattlingCharactorNode:SubTempSpNum(num)
    if self.tempNum <= 0 then return end

    local fromIndex = self.realNum + self.tempNum
    local toIndex = self.realNum + self.tempNum - num
    for i = fromIndex, (toIndex + 1), -1 do
        local spNode = self.listSPNodes[i]
        self:SpNodeBeEmpty(spNode, true)
    end
    self.tempNum = math.max(self.tempNum - num, 0)
end

--- 清理临时点
function UIBattlingCharactorNode:ClearTempSp()
    if self.realNum >= self.numMaxSP then return end
    self.tempNum = 0
    self:RefreshTempSp()
end

--- 所有sp点全部变高亮
function UIBattlingCharactorNode:AllSpNodeFull()
    if self:GetRoleSpPointType() == 2 then
        return
    end
    for i = 1, #self.listSPNodes, 1 do
        local spNode = self.listSPNodes[i]
        self:SpNodeBeFull(spNode)
    end
end

--- 把sp点变成实心的
---@param spNode any
---@param showAnim any
function UIBattlingCharactorNode:SpNodeBeReal(spNode, showAnim)
    if not IsNull(spNode.Animation_Root) then
        spNode.Animation_Root:Stop()
    end
    local color = spNode.Img_1.color
    color.a = 1
    spNode.Img_1.color = color
    spNode.SImg_1.Status = self:GetRoleSpPointType() == 1 and 1 or 3
    KTool.SetActive(spNode.RT_2, false)
    KTool.SetActive(spNode.Fx_Get, false)
    KTool.SetActive(spNode.Fx_Loss, false)
    if showAnim then
        KTool.SetActive(spNode.Fx_Get, true)
    end
end

--- 把sp点变成临时的
---@param spNode any
function UIBattlingCharactorNode:SpNodeBeTemp(spNode, showGetFx)
    if not IsNull(spNode.Animation_Root) then
        spNode.Animation_Root:get_Item("CharactorSpPointSelect").time = 0
        spNode.Animation_Root:Play("CharactorSpPointSelect")
    end
    spNode.SImg_1.Status = self:GetRoleSpPointType() == 1 and 1 or 3
    KTool.SetActive(spNode.RT_2, false)
    if showGetFx then
        KTool.SetActive(spNode.Fx_Get, true)
    else
        KTool.SetActive(spNode.Fx_Get, false)
    end
    KTool.SetActive(spNode.Fx_Loss, false)
end

--- 把sp点变成空的
---@param spNode any
---@param showAnim any
function UIBattlingCharactorNode:SpNodeBeEmpty(spNode, showAnim)
    if not IsNull(spNode.Animation_Root) then
        spNode.Animation_Root:Stop()
    end
    local color = spNode.Img_1.color
    color.a = 1
    spNode.Img_1.color = color
    spNode.SImg_1.Status = 2
    KTool.SetActive(spNode.RT_2, false)
    KTool.SetActive(spNode.Fx_Get, false)
    KTool.SetActive(spNode.Fx_Loss, false)
    if showAnim then
        KTool.SetActive(spNode.Fx_Loss, true)
    end
end

--- 把sp点变成满的
---@param spNode any
function UIBattlingCharactorNode:SpNodeBeFull(spNode)
    if not IsNull(spNode.Animation_Root) then
        spNode.Animation_Root:Stop()
    end
    spNode.SImg_1.Status = 2
    KTool.SetActive(spNode.RT_2, true)
    KTool.SetActive(spNode.Fx_Get, false)
    KTool.SetActive(spNode.Fx_Loss, false)
end

--@endregion

function UIBattlingCharactorNode:SetAnimatorPlay(animator, name)
    xTry(function()
        if checkBool(self.booleanIsHideInfo) then return end
        animator:Play(name)
    end)
end

function UIBattlingCharactorNode:CreateSPNode(max)
    self.listSPNodes = {}
    if not IsNull(self.Root_SpPoint) and not IsNull(self.SpPoint) then
        for i = 1, max do
            local spNode = CS.UnityEngine.GameObject.Instantiate(self.SpPoint.gameObject, self.Root_SpPoint)
            KTool.SetActive(spNode,true)
            local Animation_Root, Img_1, SImg_1, RT_2, Fx_Get, Fx_Loss
            Animation_Root = KTool.GetComponent(spNode, typeof(Animation))
            local RT_1 = spNode.transform:Find("Img1")
            if not IsNull(RT_1) then
                Img_1 = KTool.GetComponent(RT_1.gameObject, typeof(Image))
                SImg_1 = KTool.GetComponent(RT_1.gameObject, typeof(UISwitchImage))
            end
            RT_2 = spNode.transform:Find("Img2")
            Fx_Get = spNode.transform:Find("UIFX_SpPointDotGet")
            Fx_Loss = spNode.transform:Find("UIFX_SpPointDotloss")
            local tableSPNode = { Animation_Root = Animation_Root, Img_1 = Img_1, SImg_1 = SImg_1, 
            RT_2 = RT_2, Fx_Get = Fx_Get, Fx_Loss = Fx_Loss, gameObject = spNode}
            table.insert(self.listSPNodes, tableSPNode)
        end
    end
end

function UIBattlingCharactorNode:CleanSPNode()
    if self.listSPNodes then
        for i = #self.listSPNodes, 1, -1 do
            KTool.SafeDelete(self.listSPNodes[i].gameObject)
        end
        self.listSPNodes = nil
    end
end

function UIBattlingCharactorNode:RefreshSPNode()
    self:CleanSPNode()
    self:CreateSPNode(self.numMaxSP)
    self:RefreshSpView()
end

function UIBattlingCharactorNode:ChangeSPPointType()
    self:RefreshSPNode()
end

--- func desc
--- 获取角色sp点显示类型 1：蓝色 3：红色
function UIBattlingCharactorNode:GetRoleSpPointType()
    local roleView = BattleViewMgr:FindRoleView(self.roleId)
    if roleView then
        return roleView.ultraPointType
    end
    return 1
end

function UIBattlingCharactorNode:GetCharacterSpInfo()
    return self.realNum, self.tempNum
end

---GetCharactorUseCardRoot
---获取 UseCard Root
function UIBattlingCharactorNode:GetCharactorUseCardRoot()
    return self.CharactorUseCardRoot
end

------------ function ------------

------------ JumpNum ------------

---UpdateJumpNodePos
---更新跳字位置
function UIBattlingCharactorNode:UpdateJumpNodePos()
    self.compTest = self.controller:GetComponent("ScriptToTestJumpNode")
    --- 判断计时器状态
    if not IsNull(self.timer) then
        --- 计时器未结束
        --- 更新跳字位置
        local aPosRoot = self.rootHitAPosition
        if self.compTest and self.compTest.distance_Y then
            JUMP_NODE_DISTANCE_Y = self.compTest.distance_Y
            JUMP_NODE_DISTANCE_X = self.compTest.distance_x
        end
        self.rootHitAPosition = Vector2.New(aPosRoot.x + JUMP_NODE_DISTANCE_X, aPosRoot.y + JUMP_NODE_DISTANCE_Y)
        --self.HitJumpNumRoot.anchoredPosition = Vector2.New(aPosRoot.x + JUMP_NODE_DISTANCE_X, aPosRoot.y + JUMP_NODE_DISTANCE_Y)
        --print("->self.HitJumpNumRoot.anchoredPosition:", self.HitJumpNumRoot.anchoredPosition)
    else
        --- 计时器已结束
        self:SetJumpNumTimer()
    end
end

---SetTimerState
---设置跳字位置重置计时器
function UIBattlingCharactorNode:SetJumpNumTimer()
    if self.compTest and self.compTest.intervalResetPos then
        JUMP_NODE_INTERVAL_RESET_POS = self.compTest.intervalResetPos
        self.rootHitAPosition = self.compTest.v2OriginPos
    end
    self.timer = CDTimer:AddCD(JUMP_NODE_INTERVAL_RESET_POS,
            function()
                self:StopJumpNumTimer()
                self.rootHitAPosition = JUMP_NODE_INIT_POS
            end,
            1, false, false, true)
end

---StopJumpNumTimer
---删除计时器
function UIBattlingCharactorNode:StopJumpNumTimer()
    if not IsNull(self.timer) then
        CDTimer:RemoveCD(self.timer)
    end
    self.timer = nil
end

------------ JumpNum ------------

------------ Buff ------------

---SetBuffNodeTxtGOActive
---隐藏所属 BuffNode 的 Txt 节点
---@param boolean boolean @ 显示状态
function UIBattlingCharactorNode:SetBuffNodeTxtGOActive(boolean)
    if UIBattleBuffMgr then
        local roleBuffsList = checkTable(UIBattleBuffMgr:GetRoleBuffList(self.roleId))
        for i, buffData in ipairs(roleBuffsList) do
            local ltBuffNode = buffData.luaBehaviour.Env
            if ltBuffNode then
                ltBuffNode:SetRoundTxtActiveState(boolean)
                ltBuffNode:SetLayerTxtActiveState(boolean)
            end
        end
    end
end

function UIBattlingCharactorNode:SetBuffIconSequence(listBuffs)
    if isNull(listBuffs) or #listBuffs <= 0 then return end
    for i = 1, #listBuffs do
        --local curX = BUFF_SEQUENCE_START_X + (i - 1) * BUFF_SEQUENCE_PADDING
        --local curAnchoredPosition = Vector3.New(curX, BUFF_SEQUENCE_START_Y, 0)
        local buffNodeLB = listBuffs[i].luaBehaviour
        --local buffNodeRect = buffNodeLB.Env:GetNodeRect()
        --buffNodeRect.anchoredPosition = curAnchoredPosition --Node位置更新
        buffNodeLB.Env:SynBuffTxtPos() --NodeTxt位置同步
        buffNodeLB.Env:SetBuffNodeInShowList(i <= NUM_SHOW_BUFF_MAX)
    end
    self:SetNodeInSkillShow()
end

---FillShowBuffDesSequene
---填充 展示队列
---@param buffDes string
---@param buffValue string
function UIBattlingCharactorNode:FillShowBuffDesSequene(buffDes, buffValue, buffType, buffId)
    table.insert(self.charactorBuffShowList, BuffDesVo.New(0, buffDes, buffValue, buffType, buffId))
    self:CheckShowBuffSequene()
end

--- 填充 展示队列（参数重载）
---@param buffDescVo BuffDesVo
function UIBattlingCharactorNode:FillShowBuffSequence(buffDescVo)
    table.insert(self.charactorBuffShowList, buffDescVo)
    self:CheckShowBuffSequene()
end

---CheckShowBuffSequene
--- 检查开始 展示队列
function UIBattlingCharactorNode:CheckShowBuffSequene()
    if table.count(self.charactorBuffShowList) > 0 then
        self:ShowBuff(self.charactorBuffShowList[1])
    end
end

---ShowBuff
---展示 Buff
---@param data BuffDesVo
function UIBattlingCharactorNode:ShowBuff(data)
    if not IsNull(self.coWaittingAnima) then return end
    self.coWaittingAnima = cs_coroutine.start(
            function()
                self:ReloadBuffDes(data)
                -- cs_coroutine.yield_return(self:ReloadBuffDes(data))
                table.remove(self.charactorBuffShowList, 1)
                local waitTime = table.isContain(Constants.PassiveBuffWithHeadTopIcon, data.type) and PassiveBuffIntervalTime or 0.2
                cs_coroutine.yield_return(Yielders.GetWaitForSeconds(waitTime))
                self.coWaittingAnima = nil
                self:CheckShowBuffSequene()
            end)
end

---ReloadBuffDes
---显示 Buff 描述
---@param buffDes string 描述
---@param buffValue number 数值
function UIBattlingCharactorNode:ReloadBuffDes(data)
    local type = data.type
    local buffDes = data.buffDes
    local buffValue = data.buffValue
    local buffType = data.buffType
    local buffId = data.buffId  -- 可能为空（有的跳字是手动构造的，没有buffId）

    -- buffView表现（特效啥的）
    if table.isContain(Constants.PassiveBuffWithEffect, type) then
        -- 这里是播放光环buff的特效
        -- 其实光环buff在刚一进入场景就播放完了，但是那时候是看不见的
        -- 这里是延迟播放光环buff的位置，在这里强行找到对应的buffView，再播放一次特效
        local roleView = BattleViewMgr:FindRoleView(self.roleId)
        local buffView = roleView.buffViewMgr:FindSpecifyBuff(buffId)
        if isNotNull(buffView) then
            buffView:OnAdd()
        end
    end

    -- 跳字表现
    if table.isContain(Constants.PassiveBuffWithHeadTopIcon, data.type) then
        -- 开场被动buff
        local jumpBuffInfoTextNode = self:GetPassiveTextNode()
        if not IsNull(jumpBuffInfoTextNode) then
            jumpBuffInfoTextNode.Env:ShowValue(type, buffDes, nil)
            -- cs_coroutine.yield_return(jumpBuffInfoTextNode.Env:ShowValue(type, buffDes, nil))
        end
    else
        local jumpNode = UIBattlingCtrlMgr:GetInstance():GetJumpNumNode()
        if not IsNull(jumpNode.controller) then
            local jumpNodeGO = jumpNode.controller.gameObject
            KTool.SetParent(jumpNodeGO, self.HitJumpNumRoot.gameObject, false)
            --local jumpNodeGO = jumpNode.controller.gameObject
            --UIBattlingTools.ReloadPoolObjGO(Constants.UIBattlingObjPoolPrefabs.PATH_JUMPNODE_GO, self:GetHitJumpNodeRoot().root)
            --local jumpNodeLB = GetLuaBehaviour(jumpNodeGO, JumpNumNodePath)
            if not IsNull(jumpNode) then
                ---@type JumpNumNode
                --local jumpNode = jumpNodeLB.Env
                jumpNode:ShowBuffDes(buffDes, buffValue, buffType, buffId)
                -- cs_coroutine.yield_return(jumpNode:ShowBuffDes(buffDes, buffValue, buffType, buffId))
            end
        end
    end
end

--- 被动buff头顶Icon
---@param type integer @ 被动来源类型
---@param offset table @ 偏移
function UIBattlingCharactorNode:ShowPassiveBuffIcon(type, offset)
    local jumpNodeGO = UIBattlingTools.ReloadPoolObjGO(Constants.UIBattlingObjPoolPrefabs.PATH_JUMP_PASSIVE_ICON_GO)
    local jumpNode = GetLuaBehaviour(jumpNodeGO, Constants.UIBattlingLuaTablePath.JumpPassiveIconPath)
    KTool.SetParent(jumpNodeGO, self.HitJumpNumRoot.parent.gameObject, false)
    if not IsNull(jumpNode) then
        jumpNode.Env:ShowValue(type, offset)
    end
end

--- 被动buff说明文字跳字
function UIBattlingCharactorNode:GetPassiveTextNode()
    local jumpNodeGO = UIBattlingTools.ReloadPoolObjGO(Constants.UIBattlingObjPoolPrefabs.PATH_JUMP_TEXT_GO)
    local jumpNode = GetLuaBehaviour(jumpNodeGO, Constants.UIBattlingLuaTablePath.JumpPassiveTextNodePath)
    KTool.SetParent(jumpNodeGO, self.HitJumpNumRoot.gameObject, false)
    if not IsNull(jumpNode) then
        jumpNode:Init()
    end
    return jumpNode
end

------------ Buff ------------

------------ MeshText ------------

function UIBattlingCharactorNode:StringSPFull()
    return string.format("<sprite=11><sprite=12>")
end

function UIBattlingCharactorNode:StringSPNum(num)
    return string.format("<sprite=11><sprite=10><sprite=%d>", num)
end

------------ MeshText ------------

function UIBattlingCharactorNode:SetCGUseCardShow(bool)
    if not IsNull(self.cgRootUseCard) then
        self.cgRootUseCard.alpha = bool and 1 or 0
    end
end

function UIBattlingCharactorNode:GetRootSelectTargetTeam()
    return self.Root_SelectTargetTeam
end

function UIBattlingCharactorNode:RootSelectTargetEnemy()
    return self.Root_SelectTargetEnemy
end

--- 设置选择buff图标的显示状态
---@param state any
function UIBattlingCharactorNode:SetSelectBuffIconState(state, callback)
    if state then
        local LB_Icon
        if isNull(self.selectBuffIcon) then
            self.selectBuffIcon = UIBattlingTools.ReloadPoolObjGO(Constants.UIBattlingObjPoolPrefabs.PATH_ADDBUFF_SIGN)
            KTool.SetParent(self.selectBuffIcon, self.HitJumpNumRoot.gameObject, false)
            LB_Icon = GetLuaBehaviour(self.selectBuffIcon, Constants.UIBattlingLuaTablePath.UIBattlingAddBuffSign)
        else
            LB_Icon = GetLuaBehaviour(self.selectBuffIcon, Constants.UIBattlingLuaTablePath.UIBattlingAddBuffSign)
        end
        LB_Icon.Env:SetData(self.roleId, callback)
        LB_Icon.Env:PlayEnterAnimation()
    else
        if not isNull(self.selectBuffIcon) then
            local lb_icon = GetLuaBehaviour(self.selectBuffIcon, Constants.UIBattlingLuaTablePath.UIBattlingAddBuffSign)
            lb_icon.Env:PlayExitAnimation()
        end
    end
end

function UIBattlingCharactorNode:ShowSPChangeDesc(spPoint)
    --- 更新跳字出现位置
    self:UpdateJumpNodePos()
    ---找到 对应显示 的 人物，返回对应显示位置
    local rootHit = self.HitJumpNumRoot
    xTry(function() 
        local jumpNode = UIBattlingCtrlMgr:GetInstance():GetJumpNumNode()
        if (not isNull(jumpNode)) and (not isNull(jumpNode.controller.gameObject)) then
            local jumpNodeGO = jumpNode.controller.gameObject
            KTool.SetParent(jumpNodeGO, rootHit.gameObject, false)
            if not IsNull(jumpNode) then
                self.coChangeSPJumpNode = cs_coroutine.start(function()
                    cs_coroutine.yield_return(jumpNode:ShowSPChangeDes(spPoint - self.realNum, SP_CHANGE_JUMP_NODE_OFFSET))
                    self.coChangeSPJumpNode = nil
                end)
            end
        end
    end)
end

return UIBattlingCharactorNode
