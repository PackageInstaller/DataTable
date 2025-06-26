--[[ 
-----------------------------------------------------
@filename       : EliminateResultPanel
@Description    : 挖矿结算
@date           : 2023-12-11 14:37:04
@Author         : Jacob
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module('eliminate.EliminateResultPanel', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("eliminate/EliminateResultPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = -1-- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
escapeClose = 0 -- 是否能通过esc关闭窗口
isAddMask = 0

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(750, 600)
    self:initData()
end
--析构  
function dtor(self)
end

function initData(self)
end

-- 初始化
function configUI(self)
    self.mGroupWin = self:getChildGO("GroupWin")
    self.mRectImgWinTop = self:getChildGO("mImgWinTop"):GetComponent(ty.RectTransform)
    self.mGroupAward = self:getChildTrans("mGroupAward")
    self.mGroupFail = self:getChildGO("GroupFail")

    self.mBtnReplay = self:getChildGO("mBtnFight")
    self.mBtnExit = self:getChildGO("mBtnExit")
end

--激活
function active(self, args)
    super.active(self, args)
    self:updateView(args)
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    self:setBtnLabel(self.mBtnExit, 101013, "退出挑战")
    self:setBtnLabel(self.mBtnReplay, 101014, "再次挑战")
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnExit, self.onClickExitHandler)
    self:addUIEvent(self.mBtnReplay, self.onClickReplayHandler)
end

function onClickExitHandler(self)
    self:close()
    GameDispatcher:dispatchEvent(EventName.CLOSE_ELIMINATE_PANEL)
end

function onClickReplayHandler(self)
    self:close()
    GameDispatcher:dispatchEvent(EventName.REPLAY_ELIMINATE_PANEL)
end

function updateView(self, isWin)
    if(isWin)then
        self.mGroupWin:SetActive(true)
        self.mGroupFail:SetActive(false)
        local stageConfigVo = eliminate.EliminateManager:getRunStageConfigVo()
        if(not eliminate.EliminateManager:isStagePass(stageConfigVo.mapId))then
            self:updateAward()
            gs.TransQuick:UIPosY(self.mRectImgWinTop, 223)
        else
            gs.TransQuick:UIPosY(self.mRectImgWinTop, 111)
        end
    else
        self.mGroupWin:SetActive(false)
        self.mGroupFail:SetActive(true)
    end
end

function updateAward(self)
    self:clearItem()
    local stageConfigVo = eliminate.EliminateManager:getRunStageConfigVo()
    local awardPackId = stageConfigVo.mapAwardId
    local awardList = AwardPackManager:getAwardListById(awardPackId)
    for i = 1, #awardList do
        local propsGrid = PropsGrid:createByData({ tid = awardList[i].tid, num = awardList[i].num, parent = self.mGroupAward })
        propsGrid:setHasRec(false)
        propsGrid:setIsFirstPass(false)
        table.insert(self.mPropsGridList, propsGrid)
    end
    self.mGroupAward.gameObject:SetActive(#awardList > 0)
    -- gs.TransQuick:UIPosY(self.mRectImgWinTop, #awardList > 0 and 223 or 111)
end

function clearItem(self)
    if self.mPropsGridList ~= nil then
        for i = 1, #self.mPropsGridList do
            self.mPropsGridList[i]:poolRecover()
        end
    end
    self.mPropsGridList = {}
end

return _M