-------------------------------------------------------------------------------
-- 夜寻迷宫 - 主界面 - 层级单元节点
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2024-01-03 20:04:12
-------------------------------------------------------------------------------

local PatrolMazeUtils = import('Game.UI.PatrolMaze.PatrolMazeUtils')
local patrolMazeComp  = PatrolMazeUtils.GetComp()

local IconAnimName = 'PatrolMainDialog130201_Event_Icon%1'

local TextAnimName = {
    IDLE = 'PatrolMainDialog130201_TextType_Idle',
    LOOP = 'PatrolMainDialog130201_TextType_Loop',
}

local ScoreAnimTween = {
    stringId = 'PatrolMazeMainFloorLevelNode_ScoreAnimTween_stringId',
    duration = 0.4,
}

--- from: Assets/BundleResources/Prefabs/Patrol/PatrolMainDialog130201.prefab > name: EventDisplayNode
---@class PatrolMazeMainFloorLevelNode
---@field Env                           	PatrolMazeMainFloorLevelNode            
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field StatusLockNode                	UnityEngine.RectTransform               	@ 0    锁定状态节点
---@field BossMarkNode                  	UnityEngine.RectTransform               	@ 1    BOSS标记节点
---@field StatusFinishNode              	UnityEngine.RectTransform               	@ 2    完成状态节点
---@field StatusSelectNode              	UnityEngine.RectTransform               	@ 3    选中状态节点
---@field StatusActiveNode              	UnityEngine.RectTransform               	@ 4    激活状态节点
---@field TypeIconUIFX                  	UnityEngine.RectTransform               	@ 5    类型图标特效节点
---@field TypeIconNode                  	UnityEngine.RectTransform               	@ 6    类型图标节点
---@field TypeIconRoot                  	UnityEngine.RectTransform               	@ 7    类型图标父节点
---@field LevelNameTxt                  	UnityEngine.RectTransform               	@ 8    节点名字文本
---@field FloorNumberTxt                	UnityEngine.RectTransform               	@ 9    所属层数文本
---@field TypeText2Txt                  	UnityEngine.RectTransform               	@ 10   类型文字2文本
---@field TypeText1Txt                  	UnityEngine.RectTransform               	@ 11   类型文字1文本
---@field TypeTextRoot                  	UnityEngine.RectTransform               	@ 12   类型文字父节点
---@field CellFrameShadow               	UnityEngine.RectTransform               	@ 13   背景阴影
---@field CellFrameImg                  	UnityEngine.RectTransform               	@ 14   背景图
---@field CellNodeBtn                   	UnityEngine.RectTransform               	@ 15   节点点击按钮
---@field ClickArea                     	UnityEngine.RectTransform               	@ 16   点击区域
---@field RootNode                      	UnityEngine.RectTransform               	@ 17   根节点
---@field BoomMoveUIFX                  	UnityEngine.RectTransform               	@ 18   移动动效节点
---@field BoomShowUIFX                  	UnityEngine.RectTransform               	@ 19   闪烁动效节点
local PatrolMazeMainFloorLevelNode = Class('PatrolMazeMainFloorLevelNode')


function PatrolMazeMainFloorLevelNode:__init()
    ---@type PatrolMazeUtils.QuestState
    self.questState_ = nil

    ---@type boolean @ 是否 所在路径选中
    self.isFloorPathSelect_ = false

    ---@type boolean @ 是否 所在楼层选中
    self.isFloorLevelSelect_ = false
end


function PatrolMazeMainFloorLevelNode:__delete()
    self.questState_         = nil
    self.isFloorPathSelect_  = nil
    self.isFloorLevelSelect_ = nil
end


function PatrolMazeMainFloorLevelNode:Awake()
    SetButtonAction(self.ClickArea, Bind(self, self.OnClickFloorLevelNodeHandler_))
end


function PatrolMazeMainFloorLevelNode:Start()
end


function PatrolMazeMainFloorLevelNode:OnEnable()
    self.eventFloorSelect_ = Events.AddListener(PatrolMazeUtils.EventsName.MAZE_FLOOR_SELECT, Bind(self, self.OnMazeFloorSelectHandeler_))
end


function PatrolMazeMainFloorLevelNode:OnDisable()
    Events.RemoveListener(PatrolMazeUtils.EventsName.MAZE_FLOOR_SELECT, self.eventFloorSelect_)
end


function PatrolMazeMainFloorLevelNode:OnDestroy()
    CS.DG.Tweening.DOTween.Kill(ScoreAnimTween.stringId)
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


-------------------------------------------------
-- get / set

---@return integer
function PatrolMazeMainFloorLevelNode:GetLuaIndex()
    return checkInt(self.luaIndex_)
end
---@param luaIndex integer
function PatrolMazeMainFloorLevelNode:SetLuaIndex(luaIndex)
    self.luaIndex_ = checkInt(luaIndex)
end


---@return table
function PatrolMazeMainFloorLevelNode:GetCellData()
    return checkTable(self.cellData_)
end
---@param cellData table
function PatrolMazeMainFloorLevelNode:SetCellData(cellData)
    self.cellData_ = checkTable(cellData)
    self:UpdateCellInfo_()
    self:CheckQuestState()
end


---@return PatrolMazeAreaDojo
function PatrolMazeMainFloorLevelNode:GetAreaDojo()
    return self:GetCellData().areaDojo
end


---@return PatrolMazeFloorPathDojo
function PatrolMazeMainFloorLevelNode:GetPathDojo()
    return self:GetCellData().pathDojo
end


---@return PatrolMazeFloorLevelDojo
function PatrolMazeMainFloorLevelNode:GetLevelDojo()
    return self:GetCellData().levelDojo
end


---@return fun(levelNode:PatrolMazeMainFloorLevelNode):void
function PatrolMazeMainFloorLevelNode:GetClickCellCb()
    return self.clickCellCb_
end
---@param callback fun(levelNode:PatrolMazeMainFloorLevelNode):void
function PatrolMazeMainFloorLevelNode:SetClickCellCb(callback)
    self.clickCellCb_ = callback
end


---@return PatrolMazeUtils.QuestState
function PatrolMazeMainFloorLevelNode:GetQuestState()
    return self.questState_
end


-------------------------------------------------
-- public

function PatrolMazeMainFloorLevelNode:CheckQuestState()
    local cellData  = self:GetCellData()
    local areaDojo  = self:GetAreaDojo()
    local pathDojo  = self:GetPathDojo()
    local levelDojo = self:GetLevelDojo()
    local floorNum  = pathDojo.floorNum
    
    local questState = nil

    -- 是否 为无效层
    if not levelDojo:IsInvalidLevel() then
        questState = PatrolMazeUtils.QuestState.INVALID
    end

    -- 是否 已通关层
    if questState == nil and areaDojo.floorPassed >= floorNum then
        questState = PatrolMazeUtils.QuestState.PAASED
    end
    
    -- 是否 为当前层
    if questState == nil and areaDojo.floorPassed + 1 == floorNum then
        questState = PatrolMazeUtils.QuestState.CURRENT
    end

    -- 是否 为下一层
    if questState == nil and areaDojo.floorPassed + 2 == floorNum then
        questState = PatrolMazeUtils.QuestState.COMING_SOON
    end

    -- 是否 为锁定层
    if questState == nil and areaDojo.floorPassed + 2 < floorNum then
        questState = PatrolMazeUtils.QuestState.DISABLE
    end

    -- check state change
    if self.questState_ ~= questState then
        self.questState_ = questState
        self:UpdateNodeStatus_()
    end
end


---@param isPathSelect boolean
---@param isLevelSelect boolean
function PatrolMazeMainFloorLevelNode:SwitchSelectState(isPathSelect, isLevelSelect)
    self.isFloorPathSelect_  = checkBool(isPathSelect)
    self.isFloorLevelSelect_ = checkBool(isLevelSelect)
    self:UpdateNodeStatus_()
end


---@param targetNode UnityEngine.RectTransform
---@param endCallback fun():void
function PatrolMazeMainFloorLevelNode:PlayScoreBoomAnim(targetNode, endCallback)
    -- reset state
    CS.DG.Tweening.DOTween.Kill(ScoreAnimTween.stringId)
    self.BoomMoveUIFX.anchoredPosition = Vector3(0,0,0)
    CfUtils.SetActive(self.BoomShowUIFX, false)
    CfUtils.SetActive(self.BoomMoveUIFX, false)
    
    -- init state
    CfUtils.SetActive(self.BoomShowUIFX, true)
    CfUtils.SetActive(self.BoomMoveUIFX, true)

    -- play tween
    local moveTarget     = targetNode.transform.position
    local moveTweener    = self.BoomMoveUIFX.transform:DOMove(moveTarget, ScoreAnimTween.duration)
    moveTweener.stringId = ScoreAnimTween.stringId
    moveTweener:SetDelay(0.2)
    moveTweener:SetEase(CS.DG.Tweening.Ease.InOutQuad)
    moveTweener:OnComplete(function()
        CfUtils.SetActive(self.BoomShowUIFX, false)
        CfUtils.SetActive(self.BoomMoveUIFX, false)
        if endCallback then
            endCallback()
        end
    end)
end


-------------------------------------------------
-- private

function PatrolMazeMainFloorLevelNode:UpdateCellInfo_()
    local cellData  = self:GetCellData()
    local areaDojo  = self:GetAreaDojo()
    local pathDojo  = self:GetPathDojo()
    local levelDojo = self:GetLevelDojo()

    -- update floorNum
    local floorNum = checkInt(pathDojo.floorNum)
    CfUtils.FillText(self.FloorNumberTxt, string.format('%.2d', floorNum))
    
    ---@type PatrolMazeUtils.QuestType
    local questType = checkInt(levelDojo.questType)
    if questType == PatrolMazeUtils.QuestType.UNKNOWN then
        CfUtils.FillText(self.LevelNameTxt, '???')
    else
        local questTypeVo = PatrolMazeUtils.GetQuestTypeVo(questType)
        CfUtils.FillText(self.LevelNameTxt, tostring(questTypeVo.typeName))
        CfUtils.PlayAnimation(self.TypeIconRoot, string.fmt(IconAnimName, questType))
    end

    local isBossType = questType == PatrolMazeUtils.QuestType.BOSS
    CfUtils.SetActive(self.BossMarkNode, isBossType)
    CfUtils.SetUISwitchImage(self.CellFrameImg, questType)
    CfUtils.SetUISwitchText(self.TypeText1Txt, questType)
    CfUtils.SetUISwitchText(self.TypeText2Txt, questType)
    CfUtils.SetUISwitchText(self.FloorNumberTxt, questType)
    CfUtils.SetUISwitchText(self.LevelNameTxt, questType)
    CfUtils.SetUISwitchImage(self.TypeIconNode, questType)
end


function PatrolMazeMainFloorLevelNode:UpdateNodeStatus_()
    local cellData  = self:GetCellData()
    local areaDojo  = self:GetAreaDojo()
    local pathDojo  = self:GetPathDojo()
    local levelDojo = self:GetLevelDojo()

    local floorPathVo  = PatrolMazeUtils.GetFloorPathVo(pathDojo.floorPathId)
    local isMultiLevel = floorPathVo.childNum > 1
    local questState   = self:GetQuestState()

    -- 当前层
    if questState == PatrolMazeUtils.QuestState.CURRENT then
        local isDisable = false
        if isMultiLevel then
            if pathDojo.selectLevel == 0 then
                -- 未选择：点击的层，非自己级别，变透明
                isDisable = self.isFloorPathSelect_ and not self.isFloorLevelSelect_
            else
                -- 已选择：当前层，非选择的级别，变透明
                isDisable = pathDojo.selectLevel ~= self:GetLuaIndex()
            end
        end
        if isDisable then
            CfUtils.SetCanvasGroupAlpha(self.CellNodeBtn, 0.65)
            CfUtils.MarkGray(self.CellNodeBtn, false)
            CfUtils.SetActive(self.TypeIconUIFX, false)
            CfUtils.SetActive(self.CellFrameShadow, true)
            CfUtils.SetActive(self.StatusLockNode, false)
            CfUtils.SetActive(self.StatusActiveNode, false)
            CfUtils.SetActive(self.StatusFinishNode, false)
            CfUtils.PlayAnimation(self.TypeTextRoot, TextAnimName.IDLE)
        else
            CfUtils.SetCanvasGroupAlpha(self.CellNodeBtn, 1)
            CfUtils.MarkGray(self.CellNodeBtn, false)
            CfUtils.SetActive(self.TypeIconUIFX, true)
            CfUtils.SetActive(self.CellFrameShadow, true)
            CfUtils.SetActive(self.StatusLockNode, false)
            CfUtils.SetActive(self.StatusActiveNode, not self.isFloorLevelSelect_)
            CfUtils.SetActive(self.StatusFinishNode, false)
            CfUtils.PlayAnimation(self.TypeTextRoot, TextAnimName.LOOP)
        end

    -- 已通关
    elseif questState == PatrolMazeUtils.QuestState.PAASED then
        local isSelfPassed = not isMultiLevel or pathDojo.selectLevel == self:GetLuaIndex()
        CfUtils.SetCanvasGroupAlpha(self.CellNodeBtn, 0.65)
        CfUtils.MarkGray(self.CellNodeBtn, false)
        CfUtils.SetActive(self.TypeIconUIFX, false)
        CfUtils.SetActive(self.CellFrameShadow, true)
        CfUtils.SetActive(self.StatusLockNode, false)
        CfUtils.SetActive(self.StatusActiveNode, false)
        CfUtils.SetActive(self.StatusFinishNode, isSelfPassed)
        CfUtils.PlayAnimation(self.TypeTextRoot, TextAnimName.IDLE)

    -- 下一关
    elseif questState == PatrolMazeUtils.QuestState.COMING_SOON then
        local isEnableIconFX = false
        local isDisableState = false
        local parentFloorNum = pathDojo.floorNum - 1
        local parentPathDojo = areaDojo.floorPathDojoList[parentFloorNum]
        if parentPathDojo.selectLevel > 0 then
            isEnableIconFX = levelDojo:IsInvalidParentLevel(parentPathDojo.selectLevel)
        else
            if areaDojo.selectFloorIndex == parentFloorNum then
                isEnableIconFX = levelDojo:IsInvalidParentLevel(areaDojo.selectLevelIndex)
                isDisableState = not isEnableIconFX
            end
        end
        CfUtils.SetCanvasGroupAlpha(self.CellNodeBtn, 1)
        CfUtils.MarkGray(self.CellNodeBtn, isDisableState)
        -- CfUtils.SetActive(self.TypeIconUIFX, isEnableIconFX)
        CfUtils.SetActive(self.TypeIconUIFX, false)
        CfUtils.SetActive(self.CellFrameShadow, false)
        CfUtils.SetActive(self.StatusLockNode, isDisableState)
        CfUtils.SetActive(self.StatusActiveNode, false)
        CfUtils.SetActive(self.StatusFinishNode, false)
        CfUtils.PlayAnimation(self.TypeTextRoot, TextAnimName.IDLE)

    -- 未激活
    elseif questState == PatrolMazeUtils.QuestState.DISABLE or questState == PatrolMazeUtils.QuestState.INVALID then
        CfUtils.SetCanvasGroupAlpha(self.CellNodeBtn, 1)
        CfUtils.MarkGray(self.CellNodeBtn, true)
        CfUtils.SetActive(self.TypeIconUIFX, false)
        CfUtils.SetActive(self.CellFrameShadow, false)
        CfUtils.SetActive(self.StatusLockNode, true)
        CfUtils.SetActive(self.StatusActiveNode, false)
        CfUtils.SetActive(self.StatusFinishNode, false)
        CfUtils.PlayAnimation(self.TypeTextRoot, TextAnimName.IDLE)
        CfUtils.SetUISwitchText(self.FloorNumberTxt, 8)

    -- 未知的
    else
        CfUtils.SetCanvasGroupAlpha(self.CellNodeBtn, 0.3)
        CfUtils.MarkGray(self.CellNodeBtn, true)
        CfUtils.SetActive(self.TypeIconUIFX, false)
        CfUtils.SetActive(self.CellFrameShadow, false)
        CfUtils.SetActive(self.StatusLockNode, false)
        CfUtils.SetActive(self.StatusActiveNode, false)
        CfUtils.SetActive(self.StatusFinishNode, false)
        CfUtils.PlayAnimation(self.TypeTextRoot, TextAnimName.IDLE)
    end

    -- 点击的位置显示选中框
    if self.isFloorPathSelect_ and self.isFloorLevelSelect_ then
        CfUtils.SetActive(self.StatusSelectNode, true)
    else
        CfUtils.SetActive(self.StatusSelectNode, false)
    end
end


-------------------------------------------------
-- handler

function PatrolMazeMainFloorLevelNode:OnClickFloorLevelNodeHandler_()
    if self:GetClickCellCb() then
        self:GetClickCellCb()(self)
    end
end


function PatrolMazeMainFloorLevelNode:OnMazeFloorSelectHandeler_()
    local questState = self:GetQuestState()
    if questState == PatrolMazeUtils.QuestState.COMING_SOON then
        self:UpdateNodeStatus_()
    end
end


return PatrolMazeMainFloorLevelNode
