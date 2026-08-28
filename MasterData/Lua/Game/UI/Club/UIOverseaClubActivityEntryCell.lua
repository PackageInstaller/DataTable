-------------------------------------------------------------------------------
-- 社团 - 社团活动界面 - 活动入口节点
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2024-03-13 20:19:43
-------------------------------------------------------------------------------

local RootAnimeName = {
    CLOSE = 'OverseaClubActivityDialog_EffectsDefault',
    OPEN  = 'OverseaClubActivityDialog_EffectsActivate',
}

local EntryCellState = {
    UNKONW      = 0,
    EMPTY       = 1, -- 空活动（敬请期待）
    CLOSING     = 2, -- 活动关闭中
    OPENING     = 3, -- 活动开启中
    GVG_NOTICE  = 4, -- GVG预告阶段
    GVG_APPLY   = 5, -- GVG报名阶段
    GVG_READY   = 6, -- GVG准备阶段
    GVG_PREVIEW = 7, -- GVG战前预览
    GVG_ABSENT  = 8, -- GVG未参加
}

--- from: Assets/BundleResources/Prefabs/OverClub/OverseaClubActivityDialog.prefab > name: Cell
---@class UIOverseaClubActivityEntryCell
---@field Env                           	UIOverseaClubActivityEntryCell          
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field RootNode                      	UnityEngine.RectTransform               	@ 0    根节点
---@field AnimRoot                      	UnityEngine.RectTransform               	@ 1    动画节点
---@field EmptyNode                     	UnityEngine.RectTransform               	@ 2    空内容节点
---@field ContentNode                   	UnityEngine.RectTransform               	@ 3    内容根节点
---@field BgLightImg                    	UnityEngine.RectTransform               	@ 4    背景-光图片
---@field BgText1Img                    	UnityEngine.RectTransform               	@ 5    背景-文字1图片
---@field BgText2Img                    	UnityEngine.RectTransform               	@ 6    背景-文字2图片
---@field UIFXRootNode                  	UnityEngine.RectTransform               	@ 7    特效-根节点
---@field EffectGlowFx                  	UnityEngine.RectTransform               	@ 8    特效 发光1
---@field EffectStar2Fx                 	UnityEngine.RectTransform               	@ 9    特效 发光2
---@field TitleIconImg                  	UnityEngine.RectTransform               	@ 10   标题-图标图片
---@field TitleNameTxt                  	UnityEngine.RectTransform               	@ 11   标题-名字文本呢
---@field TimeCloseNode                 	UnityEngine.RectTransform               	@ 12   时间-关闭根节点
---@field TimeCloseTxt                  	UnityEngine.RectTransform               	@ 13   时间 关闭时间文本
---@field TimeOpenNode                  	UnityEngine.RectTransform               	@ 14   时间-开启根节点
---@field TimeOpenTxt                   	UnityEngine.RectTransform               	@ 15   时间 开启时间文本
---@field TimeOpenLineImg               	UnityEngine.RectTransform               	@ 16   时间 开启时间线条
---@field TimeUnderwayNode              	UnityEngine.RectTransform               	@ 17   时间-进行中节点
---@field TimeCountdownNode             	UnityEngine.RectTransform               	@ 18   时间-倒计时节点
---@field TimeCountdownTextDesc         	UnityEngine.RectTransform               	@ 19   时间 左侧 倒计时文本
---@field TimeCountdonwTxt              	UnityEngine.RectTransform               	@ 20   时间 右侧 倒计时文本
---@field RemainTimesNode               	UnityEngine.RectTransform               	@ 21   剩余次数-根节点
---@field RemainTimesTxt                	UnityEngine.RectTransform               	@ 22   剩余次数-次数文本
---@field PortraitRootNode              	UnityEngine.RectTransform               	@ 23   立绘-根节点
---@field PortraitRoleImg               	UnityEngine.RectTransform               	@ 24   立绘 角色图片
---@field PortraitShadowImg             	UnityEngine.RectTransform               	@ 25   立绘 角色影子
---@field GVGRootNode                   	UnityEngine.RectTransform               	@ 26   GVG-根节点
---@field GVGApplyInfoNode              	UnityEngine.RectTransform               	@ 27   GVG 报名信息节点
---@field GVGApplyMemberNode            	UnityEngine.RectTransform               	@ 28   GVG 成员报名节点
---@field GVGApplyMasterNode            	UnityEngine.RectTransform               	@ 29   GVG 会长报名节点
---@field GVGApplyTimeTxt               	UnityEngine.RectTransform               	@ 30   GVG 报名时间文本
---@field GVGApplyFailureNode           	UnityEngine.RectTransform               	@ 31   GVG 报名失败节点
---@field GVGApplySuccessNode           	UnityEngine.RectTransform               	@ 32   GVG 报名成功节点
---@field BtnViewRanking                	UnityEngine.RectTransform               	@ 33   历史战绩的按钮
---@field RedPointNode                  	UnityEngine.RectTransform               	@ 34   红点节点
local UIOverseaClubActivityEntryCell = Class('UIOverseaClubActivityEntryCell')

UIOverseaClubActivityEntryCell.EntryCellState = EntryCellState


function UIOverseaClubActivityEntryCell:__init()
    self.entryCellState_ = EntryCellState.UNKONW
end


function UIOverseaClubActivityEntryCell:__delete()
    self.entryCellState_ = nil
end


function UIOverseaClubActivityEntryCell:Awake()
    self.eventsDecorated_ = CfUtils.EventsDecorated({
        [ClubUtils.EventName.ACTIVITY_ENTRY_COUNTDOWN] = Bind(self, self.OnActivityEntryCountdownHandler_),
        [ClubUtils.EventName.GVG_APPLY_SUCCESS]        = Bind(self, self.OnClubGvgApplySuccessHandler_),
    })
    SetButtonAction(self.AnimRoot, Bind(self, self.OnClickEntryCellHandler_))
    SetButtonAction(self.BtnViewRanking, Bind(self, self.OnClickBtnViewRankingHandler_))
end


function UIOverseaClubActivityEntryCell:Start()
end


function UIOverseaClubActivityEntryCell:OnDestroy()
    CfUtils.EventsUndecorated(self.eventsDecorated_)
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


-------------------------------------------------
-- get / set

---@return integer
function UIOverseaClubActivityEntryCell:GetLuaIndex()
    return checkInt(self.luaIndex_)
end
---@param luaIndex integer
function UIOverseaClubActivityEntryCell:SetLuaIndex(luaIndex)
    self.luaIndex_ = checkInt(luaIndex)
end


---@return table
function UIOverseaClubActivityEntryCell:GetCellData()
    return checkTable(self.cellData_)
end
---@param cellData table
function UIOverseaClubActivityEntryCell:SetCellData(cellData)
    self.cellData_ = checkTable(cellData)
    self:CheckCellState()
end


---@return fun(luaIndex:integer):void
function UIOverseaClubActivityEntryCell:GetClickEntryCB()
    return self.clickEntryCallback_
end
---@param callback fun(luaIndex:integer):void
function UIOverseaClubActivityEntryCell:SetClickEntryCB(callback)
    self.clickEntryCallback_ = callback
end


---@return boolean
function UIOverseaClubActivityEntryCell:IsShowRedPoint()
    return checkBool(self.isShowRedPoint_)
end
---@param isSelect boolean
function UIOverseaClubActivityEntryCell:SetShowRedPoint(isShow)
    self.isShowRedPoint_ = checkBool(isShow)
    self:UpdateRedPointState_()
end


-------------------------------------------------
-- public

function UIOverseaClubActivityEntryCell:CheckCellState()
    local cellData = self:GetCellData()
    local isEmpty  = checkBool(cellData.isEmpty)
    local oldState = self.entryCellState_
    local newState = EntryCellState.UNKONW

    if isEmpty then
        newState = EntryCellState.EMPTY

    else
        if checkBool(cellData.isOpening) then

            if cellData.gvgData then
                local clubGVGData     = checkTable(cellData.gvgData)
                local clubHomeDojo    = ClubUtils.GetClubComp():GetHomeDojo()
                local nowServerTime   = GameUtils.GetServerTime()
                local applyStartTime  = checkInt(clubGVGData.applyStartTime)
                local applyEndTime    = checkInt(clubGVGData.applyEndTime)
                local battleEnterTime = checkInt(clubGVGData.battleEnterTime)
                local battleStartTime = checkInt(clubGVGData.battleStartTime)
                if nowServerTime <= applyStartTime then
                    newState = EntryCellState.GVG_NOTICE
                elseif nowServerTime <= applyEndTime then
                    newState = EntryCellState.GVG_APPLY
                elseif nowServerTime <= battleEnterTime then
                    newState = clubHomeDojo:IsGvgApplied() and EntryCellState.GVG_READY or EntryCellState.GVG_ABSENT
                elseif nowServerTime <= battleStartTime then
                    newState = clubHomeDojo:IsGvgApplied() and EntryCellState.GVG_PREVIEW or EntryCellState.GVG_ABSENT
                else
                    newState = clubHomeDojo:IsGvgApplied() and EntryCellState.OPENING or EntryCellState.GVG_ABSENT
                end
            else
                newState = EntryCellState.OPENING
            end

        else
            if cellData.gvgData then
                newState = EntryCellState.GVG_NOTICE
            else
                newState = EntryCellState.CLOSING
            end
        end
    end

    if oldState ~= newState then
        self.entryCellState_ = newState
        self:UpdateCellInfo_()
    end
end


-------------------------------------------------
-- private

function UIOverseaClubActivityEntryCell:UpdateCellInfo_()
    local cellData = self:GetCellData()

    -- check isEmpty
    local isEmpty = self.entryCellState_ == EntryCellState.EMPTY
    CfUtils.SetActive(self.EmptyNode, isEmpty)
    CfUtils.SetActive(self.ContentNode, not isEmpty)
    if isEmpty then
        return
    end

    ---@type ClubUtils.ActivityEntryType
    local entryType = checkInt(cellData.entryType)
    local systemId  = checkInt(cellData.systemId)
    local isUnLock  = GameUtils.IsSwitchedBySystemTogId(systemId)

    -- check isOpening
    local isOpening = self.entryCellState_ == EntryCellState.OPENING
    CfUtils.SetActive(self.UIFXRootNode, isOpening)
    CfUtils.SetActive(self.TimeOpenNode, isOpening)
    CfUtils.SetActive(self.TimeCloseNode, not isOpening)
    CfUtils.PlayAnimation(self.AnimRoot, isOpening and RootAnimeName.OPEN or RootAnimeName.CLOSE)

    -- update portraits
    local portraitPath = string.fmt('Arts/Textures/OverseaClubLeisure/club_activity_img_role_%1.png', systemId)
    CfUtils.FillImage(self.PortraitRoleImg, portraitPath)
    CfUtils.FillImage(self.PortraitShadowImg, portraitPath)
    
    -- update infos
    local entryName = isUnLock and tostring(cellData.entryName) or localize('敬请期待')
    CfUtils.FillText(self.TitleNameTxt, entryName)
    CfUtils.SetUISwitchImage(self.TitleIconImg, entryType)
    
    -- update status
    local entryState = 1  -- 1：未开始，2：社团Boss，3：猫车活动，4：社团GVG
    if isOpening then
        entryState = entryType + 1
        CfUtils.SetActive(self.TimeOpenLineImg, true)
        CfUtils.SetUISwitchImage(self.TimeOpenLineImg, entryType)         -- parent: TimeOpenNode
        CfUtils.SetUISwitchParticleSystem(self.EffectGlowFx, entryType)   -- parent: UIFXRootNode
        CfUtils.SetUISwitchParticleSystem(self.EffectGlow2Fx, entryType)  -- parent: UIFXRootNode
    else
        CfUtils.SetActive(self.TimeOpenLineImg, false)
    end
    CfUtils.SetUISwitchImage(self.BgLightImg, entryState)
    CfUtils.SetUISwitchImage(self.BgText1Img, entryState)
    CfUtils.SetUISwitchImage(self.BgText2Img, entryState)

    -- update rank btn
    CfUtils.SetActive(self.BtnViewRanking, cellData.isShowRank == true)

    -------------------------------------------------
    -- 社团boss
    if entryType == ClubUtils.ActivityEntryType.BOSS then
        self:UpdateBossCellInfo_()
    else
        CfUtils.SetActive(self.RemainTimesNode, false)
    end

    -------------------------------------------------
    -- 社团GVG
    if entryType == ClubUtils.ActivityEntryType.GVG then
        self:UpdateGVGCellInfo_()
    else
        CfUtils.SetActive(self.GVGRootNode, false)
        CfUtils.SetActive(self.TimeUnderwayNode, false)
        self:FreshCountDownShowState(false)
    end

    -------------------------------------------------
    -- update views
    self:UpdateActivityTime_()
end


function UIOverseaClubActivityEntryCell:UpdateBossCellInfo_()
    local cellData  = self:GetCellData()
    local bossData  = checkTable(cellData.bossData)
    local isOpening = self.entryCellState_ == EntryCellState.OPENING
    CfUtils.SetActive(self.RemainTimesNode, isOpening)

    -- 剩余次数
    if isOpening then
        local leftTimes = checkInt(bossData.leftTimes)
        CfUtils.FillText(self.RemainTimesTxt, leftTimes)
    end
end


function UIOverseaClubActivityEntryCell:UpdateGVGCellInfo_()
    local cellData     = self:GetCellData()
    local gvgData      = checkTable(cellData.gvgData)
    local isOpening    = self.entryCellState_ == EntryCellState.OPENING
    local clubHomeDojo = ClubUtils.GetClubComp():GetHomeDojo()

    if isOpening then
        self:FreshCountDownShowState(false)
    else 
        CfUtils.SetActive(self.TimeCloseNode, false)
        self:FreshCountDownShowState(true)
    end
        
    ------------------------------------------------- [GVG预告]
    if self.entryCellState_ == EntryCellState.GVG_NOTICE then
        CfUtils.SetActive(self.GVGRootNode, false)

    ------------------------------------------------- [GVG报名]
    elseif self.entryCellState_ == EntryCellState.GVG_APPLY then
        CfUtils.SetActive(self.GVGRootNode, true)
        CfUtils.SetActive(self.GVGApplyFailureNode, false)
        
        if clubHomeDojo:IsGvgApplied() then
            CfUtils.SetActive(self.GVGApplyInfoNode, false)
            CfUtils.SetActive(self.GVGApplySuccessNode, true)
        else
            local isOperateApply = checkBool(gvgData.isOperateApply)
            CfUtils.SetActive(self.GVGApplyInfoNode, true)
            CfUtils.SetActive(self.GVGApplySuccessNode, false)
            CfUtils.SetActive(self.GVGApplyMasterNode, isOperateApply)
            CfUtils.SetActive(self.GVGApplyMemberNode, not isOperateApply)
        end

    ------------------------------------------------- [GVG准备]
    elseif self.entryCellState_ == EntryCellState.GVG_READY or self.entryCellState_ == EntryCellState.GVG_PREVIEW then
        CfUtils.SetActive(self.GVGRootNode, true)
        CfUtils.SetActive(self.GVGApplyInfoNode, false)

        if clubHomeDojo:IsGvgApplied() then
            CfUtils.SetActive(self.GVGApplySuccessNode, true)
            CfUtils.SetActive(self.GVGApplyFailureNode, false)
        else
            CfUtils.SetActive(self.GVGApplySuccessNode, false)
            CfUtils.SetActive(self.GVGApplyFailureNode, true)
        end

    ------------------------------------------------- [GVG战中：未参与]
    elseif self.entryCellState_ == EntryCellState.GVG_ABSENT then
        self:FreshCountDownShowState(false)
        CfUtils.SetActive(self.TimeOpenNode, true)
        CfUtils.SetActive(self.GVGRootNode, true)
        CfUtils.SetActive(self.GVGApplyInfoNode, false)
        CfUtils.SetActive(self.GVGApplySuccessNode, false)
        CfUtils.SetActive(self.GVGApplyFailureNode, true)
    end
end


function UIOverseaClubActivityEntryCell:UpdateActivityTime_()
    local cellData  = self:GetCellData()
    
    ------------------------------------------------- [活动开启中]
    if self.entryCellState_ == EntryCellState.OPENING then
        -- 进行中：距离结束的时间
        local leftSeconds = math.max(checkInt(cellData.endedTime) - GameUtils.GetServerTime(), 0)
        CfUtils.FillText(self.TimeOpenTxt, localize('_time_后结束', {_time_ = CfUtils.GetTimeHMS9(leftSeconds)}))

    ------------------------------------------------- [GVG预告]
    elseif self.entryCellState_ == EntryCellState.GVG_NOTICE then
        -- 预告模式：距离报名的时间
        local clubGVGData    = checkTable(cellData.gvgData)
        local applyStartTime = checkInt(clubGVGData.applyStartTime)
        local leftSeconds    = math.max(applyStartTime - GameUtils.GetServerTime(), 0)
        CfUtils.FillText(self.TimeCountdonwTxt, CfUtils.GetTimeHMS10(leftSeconds))
        
    ------------------------------------------------- [GVG报名]
    elseif self.entryCellState_ == EntryCellState.GVG_APPLY then
        -- 报名模式：距离战斗开始的时间
        local clubGVGData     = checkTable(cellData.gvgData)
        local battleStartTime = checkInt(clubGVGData.battleStartTime)
        local applyEndTime    = checkInt(clubGVGData.applyEndTime)
        local leftSeconds     = math.max(battleStartTime - GameUtils.GetServerTime(), 0)
        local clubHomeDojo    = ClubUtils.GetClubComp():GetHomeDojo()
        CfUtils.FillText(self.TimeCountdonwTxt, CfUtils.GetTimeHMS10(leftSeconds))
        -- 报名模式：距离报名结束的时间
        if not clubHomeDojo:IsGvgApplied() then
            local leftSeconds = math.max(applyEndTime - GameUtils.GetServerTime(), 0)
            CfUtils.FillText(self.GVGApplyTimeTxt, CfUtils.GetTimeHMS9(leftSeconds))
        end

    ------------------------------------------------- [GVG准备 | GVG战前预览]
    elseif self.entryCellState_ == EntryCellState.GVG_READY or self.entryCellState_ == EntryCellState.GVG_PREVIEW then
        -- 准备模式：战斗开始的时间
        local clubGVGData     = checkTable(cellData.gvgData)
        local battleStartTime = checkInt(clubGVGData.battleStartTime)
        local leftSeconds     = math.max(battleStartTime - GameUtils.GetServerTime(), 0)
        CfUtils.FillText(self.TimeCountdonwTxt, CfUtils.GetTimeHMS10(leftSeconds))

    ------------------------------------------------- [GVG战中：未参与]
    elseif self.entryCellState_ == EntryCellState.GVG_ABSENT then
        -- 进行中：距离结束的时间
        local leftSeconds = math.max(checkInt(cellData.endedTime) - GameUtils.GetServerTime(), 0)
        CfUtils.FillText(self.TimeOpenTxt, localize('_time_后结束', {_time_ = CfUtils.GetTimeHMS9(leftSeconds)}))
    
    ------------------------------------------------- [活动关闭中]
    else
        -- 预告模式：距离开始的时间
        local leftSeconds = math.max(checkInt(cellData.startTime) - GameUtils.GetServerTime(), 0)
        CfUtils.FillText(self.TimeCloseTxt, localize('（_time_后开启）', {_time_ = CfUtils.GetTimeHMS11(leftSeconds)}))
    end
end


function UIOverseaClubActivityEntryCell:UpdateRedPointState_()
    CfUtils.SetActive(self.RedPointNode, self:IsShowRedPoint())
end

function UIOverseaClubActivityEntryCell:FreshCountDownShowState(isShow)
    if isShow then
        -- local cellData = self:GetCellData()
        local text = self.entryCellState_ == EntryCellState.GVG_NOTICE and localize("报名开启倒计时 :") or localize("开启倒计时:")
        CfUtils.FillText(self.TimeCountdownTextDesc, text)
    end
    CfUtils.SetActive(self.TimeCountdownNode, isShow)
end


-------------------------------------------------
-- handler

function UIOverseaClubActivityEntryCell:OnClickEntryCellHandler_()
    local cellData = self:GetCellData()
    local systemId = checkInt(cellData.systemId)
    local isUnLock = GameUtils.IsSwitchedBySystemTogId(systemId)

    if systemId > 0 and isUnLock == false then
        GameUtils.Toast(localize('功能未解锁'))
    else
        if self:GetClickEntryCB() then
            self:GetClickEntryCB()(self:GetLuaIndex(), self.entryCellState_)
        end
    end
end

function UIOverseaClubActivityEntryCell:OnClickBtnViewRankingHandler_()
    local cellData = self:GetCellData()
    if cellData.entryType == ClubUtils.ActivityEntryType.GVG then
        CfUtils.DialogOpen(Constants.UITypeIds.CultivateLevelUpSecondConfirmPanel, {levelUpType = Constants.UICultivateLevelUpFinishType.ClubGVGEnd})
    end
end


function UIOverseaClubActivityEntryCell:OnActivityEntryCountdownHandler_()
    if self.entryCellState_ ~= EntryCellState.UNKONW and self.entryCellState_ ~= EntryCellState.EMPTY then
        self:CheckCellState()
        self:UpdateActivityTime_()
    end
end


function UIOverseaClubActivityEntryCell:OnClubGvgApplySuccessHandler_()
    self:UpdateCellInfo_()
end


return UIOverseaClubActivityEntryCell
