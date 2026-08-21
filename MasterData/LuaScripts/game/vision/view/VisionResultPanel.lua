--[[ 
-----------------------------------------------------
@filename       : VisionResultPanel
@Description    : 异象残境独立战斗结算面板（胜利/失败共用）
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]] module("vision.VisionResultPanel", Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("vision/VisionResultPanel.prefab")
panelType = -1 -- 窗口类型 1 全屏 2 弹窗 -1 无底图弹窗
destroyTime = 0 -- 自动销毁时间 0 即时销毁
isBlur = 0 -- 是否开启模糊背景（仅 2 弹窗面板有效，默认开启，0 关闭）

function ctor(self)
    super.ctor(self)
end

function configUI(self)
    super.configUI(self)

    self.mTxtCity = self:getChildGO("mTxtCity"):GetComponent(ty.Text)
    self.mTxtRound = self:getChildGO("mTxtRound"):GetComponent(ty.Text)
    self.mTxtDie = self:getChildGO("mTxtDie"):GetComponent(ty.Text)

    -- self.mTargetScroll = self:getChildGO("mTargetScroll"):GetComponent(ty.ScrollRect)
    -- self.mTargetItem = self:getChildGO("mTargetItem")
    self.mTxtAllPoint = self:getChildGO("mTxtAllPoint"):GetComponent(ty.Text)

    self.mPreviewBtn = self:getChildGO("mPreViewBtn")

    self.mBtnClose = self:getChildGO("mBtnClose")
    self.mBtnRes = self:getChildGO("mBtnRes")
    self.mBtnNext = self:getChildGO("mBtnNext")
    self.mLoseInfo = self:getChildGO("mLoseInfo")
    self.mWinInfo = self:getChildGO("mWinInfo")
end

function active(self, args)
    super.active(self, args)
    self.resultData = args.resultData
    self.battleType = args.battleType
    self.battleFieldID = args.battleFieldID
    self.isWin = args.resultData.result == 1
    self.mHasSentOver = false
    self.mIsClosing = false
    self.mIsReEnter = false

    self:setTimeout(1.5, function()
        self.isCanClose = true
    end)

    self:updateResultInfoState()
    self:updateBtnState()
    self:showPanel()

    self:sendFightOver()
end

function initViewText(self)
    self:getChildGO("mTxtRoundTips"):GetComponent(ty.Text).text = _TT(153201)
    self:getChildGO("mTxtDieTips"):GetComponent(ty.Text).text = _TT(153202)

    self:setBtnLabel(self.mBtnClose, 153213, "退出")
    self:setBtnLabel(self.mBtnRes, 153214, "重新挑战")
    self:setBtnLabel(self.mBtnNext, 153215, "下一层")
end

function updateResultInfoState(self)
    if self.mLoseInfo then
        self.mLoseInfo:SetActive(not self.isWin)
    end
    if self.mWinInfo then
        self.mWinInfo:SetActive(self.isWin)
    end
end

function updateBtnState(self)
    local argsState = self.resultData.args[1]
    self.mBtnNext:SetActive(argsState == 1) -- 多层且胜利：下一关
    self.mBtnClose:SetActive(argsState == 2 or argsState == 3) -- 其余情况均显示关闭
    self.mBtnRes:SetActive(true)
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mPreviewBtn, self.onPreviewClick)
    self:addUIEvent(self.mBtnClose, self.onClickClose)
    self:addUIEvent(self.mBtnRes, self.onClickRes)
    self:addUIEvent(self.mBtnNext, self.onClickNext)
end

function onPreviewClick(self)
    GameDispatcher:dispatchEvent(EventName.FIGHT_RESULT_PREVIEW_SHOW)
end

function deActive(self)
    super.deActive(self)
    -- self:clearTargetItemList()
    
   
end

function onClickClose(self)
    if self.mIsClosing then
        return
    end
    self.mIsClosing = true
    super.onClickClose(self)

    -- 手动关闭且为通关层结算状态(args[1]==3)：抛事件由 Controller 发送 19925 手动结算协议
    if self.resultData.args[1] == 3 then
        GameDispatcher:dispatchEvent(EventName.REQ_VISION_MIRROR_SETTLE)
    end

      GameDispatcher:dispatchEvent(EventName.FIGHT_RESULT_PANEL_OVER, {
                    isWin = self.isWin
                }
            )
end

-- 重试：重新进入同一层战斗
function onClickRes(self)
    if self.mIsClosing then
        return
    end
    self.mIsClosing = true
    self.mIsReEnter = true
    super.onClickClose(self)
    GameDispatcher:dispatchEvent(EventName.EXIT_FIGHT_END_RESET)
    map.MapLoader:resetMapCtrl()
    fight.FightManager:reqBattleEnter(PreFightBattleType.Vision, tostring(self.battleFieldID), 1, 4)
end

-- 续挑战同层下一关：胜利后直接重进该层战斗（参照巅峰pvp写法）
function onClickNext(self)
    if self.mIsClosing then
        return
    end
    self.mIsClosing = true
    self.mIsReEnter = true
    super.onClickClose(self)
    GameDispatcher:dispatchEvent(EventName.EXIT_FIGHT_END_RESET)
    -- 继续挑战
    map.MapLoader:resetMapCtrl()
    fight.FightManager:reqBattleEnter(PreFightBattleType.Vision, tostring(self.battleFieldID), 1, 3)
end

-- 关闭界面发送通知，复用通用胜利结算的奖励/升级流程
function sendFightOver(self)
    if self.mHasSentOver then
        return
    end
    self.mHasSentOver = true

    -- -- 重试/下一关：不派发结算结束，由点击处理直接再战/返回列表
    -- if self.mIsReEnter then
    --     return
    -- end

    if #self.resultData.award > 0 or #self.resultData.detail_item_award > 0 then
        local total = table.mergeAll(self.resultData.award, self.resultData.detail_item_award)
        ShowAwardPanel_New:showPropsAwardMsg(total, function()
            role.RoleController:onShowPlayerLvlUp(function()
            --     GameDispatcher:dispatchEvent(EventName.FIGHT_RESULT_PANEL_OVER, {
            --         isWin = self.isWin
            --     }
            -- )
            end)
        end, self.resultData.is_decompose == 1)
    else
        role.RoleController:onShowPlayerLvlUp(function()
            -- GameDispatcher:dispatchEvent(EventName.FIGHT_RESULT_PANEL_OVER, {
            --     isWin = self.isWin
            -- })
        end)
    end
end

function showPanel(self)
    -- self:clearTargetItemList()
    local fieldId = tonumber(fight.FightManager:getBattleFieldID())
    -- fieldId 为层数，level 为真实场数(args[5])：按服务器真实关卡列表取当前场对应的 stageData
    local level = self.resultData.args[5] or 1
    -- local stageData = vision.VisionManager:getVisionMirrorStageDataByLayerAndIndex(fieldId, level)
    -- if not stageData then
    --     stageData = vision.VisionManager:getVisionMirrorStageDataById(fieldId)
    -- end
    -- self.mTxtCity.text = stageData:getName()
    self.mTxtCity.text = _TT(153203, level)
    local score = self.resultData.args[2]
    local round = self.resultData.args[3]
    local dieNum = self.resultData.args[4]
    self.mTxtRound.text = round
    self.mTxtDie.text = dieNum
    -- for i = 1, 2 do
    --     local item = SimpleInsItem:create(self.mTargetItem, self.mTargetScroll.content, "mVisionTargetItem")

    --     item:getChildGO("mTxtDes"):GetComponent(ty.Text).text = i == 1 and _TT(153201) or _TT(153202)
    --     table.insert(self.mTargetItemList, item)
    -- end
    self.mTxtAllPoint.text = _TT(153212, score)
end

-- function clearTargetItemList(self)
--     for i = 1, #self.mTargetItemList do
--         self.mTargetItemList[i]:poolRecover()
--     end
--     self.mTargetItemList = {}
-- end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
