--[[ 
-----------------------------------------------------
@filename       : EliminateStagePanel
@Description    : 消消乐关卡界面
@date           : 2022-3-2 
@Author         : zzz
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module("eliminate.EliminateStagePanel", Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("eliminate/EliminateStagePanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = -1
isBlur = 0
isAddMask = 0

--构造函数
function ctor(self)
    super.ctor(self)
end

--析构  
function dtor(self)
end

-- 初始化数据
function initData(self)
    self.mTargetItemList = {}
    self.mAwardItemList = {}

    self.mStageConfigVo = nil
end

--初始化UI
function configUI(self)
    self.mBtnClose = self:getChildGO("mBtnClose")
    self.TargetItem = self:getChildGO("TargetItem")
    self.mBtnPrevent = self:getChildGO("mBtnPrevent")
    self.mBtnChallenge = self:getChildGO("mBtnChallenge")
    self.TargetContent = self:getChildTrans("TargetContent")
    self.mAnimator = self.UIObject:GetComponent(ty.Animator)
    self.mTxtTitle = self:getChildGO("mTxtTitle"):GetComponent(ty.Text)
    self.mTxtTargetDes = self:getChildGO("mTxtTargetDes"):GetComponent(ty.Text)
    self.mTextAwardTitle = self:getChildGO("mTextAwardTitle"):GetComponent(ty.Text)
    self.mTextTargetTitle = self:getChildGO("mTextTargetTitle"):GetComponent(ty.Text)
    self.mAwardContent = self:getChildGO("AwardScroller"):GetComponent(ty.ScrollRect).content
    self.mBtnPrevent:GetComponent(ty.LongPressOrClickEventTrigger):SetIsPassEvent(true)
    self:setAdapta()
end

function getAdaptaTrans(self)
    return self:getChildTrans("mGroupTop")
end

function initViewText(self)
    self.mTextTargetTitle.text = _TT(101015) --"通关目标"
    self.mTextAwardTitle.text = _TT(116) --"通关奖励"
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnChallenge, self.onClickChallengeHandler)
    self:addUIEvent(self.mBtnClose, self.onClickCloseHandler)
    self:addUIEvent(self.mBtnPrevent, self.onClickCloseHandler)
end

--激活
function active(self)
    super.active(self)
    MoneyManager:setMoneyTidList()
end

--非激活
function deActive(self)
    super.deActive(self)
    MoneyManager:setMoneyTidList()
    self:removeTargetItemList()
    self:removeAwardItemList()
end

function setData(self, stageConfigVo)
    self.mStageConfigVo = stageConfigVo
    self.mTxtTitle.text = stageConfigVo.mapName
    self.mTxtTargetDes.text = string.format(_TT(101007), stageConfigVo.maxRound) -- "%s回合内消除以下:"

    self:removeAwardItemList()
    local awardPackId = stageConfigVo.mapAwardId
    local awardList = AwardPackManager:getAwardListById(awardPackId)
    gs.TransQuick:SizeDelta01(self.mAwardContent, (#awardList - 1) * 114 + 55 * 2)
    for i = 1, #awardList do
        local vo = awardList[i]
        local propsGrid = PropsGrid:create(self.mAwardContent, { vo.tid, vo.num }, 1, false)
        propsGrid:setPosition(math.Vector3((i - 1) * 114 + 55, 0, 0))
        propsGrid:setHasRec(eliminate.EliminateManager:isStagePass(stageConfigVo.mapId))
        table.insert(self.mAwardItemList, propsGrid)
    end
    gs.TransQuick:UIPosX(self.mAwardContent, 0)

    self:removeTargetItemList()
    local targetList = stageConfigVo.targetList
    for i = 1, #targetList do
        local targetThingType = targetList[i][1]
        local targetThingCount = targetList[i][2]
        local thingConfigVo = eliminate.EliminateManager:getThingConfigVo(targetThingType)
        local item = SimpleInsItem:create(self.TargetItem, self.TargetContent, "EliminateStageInfoTargetItem")
        item:getChildGO("mTxtTargetIcon"):GetComponent(ty.AutoRefImage):SetImg(thingConfigVo.icon, false)
        item:getChildGO("mTxtTargetCount"):GetComponent(ty.Text).text = "x" .. targetThingCount
        table.insert(self.mTargetItemList, item)
    end
end

function removeAwardItemList(self)
    for i = #self.mAwardItemList, 1, -1 do
        local item = self.mAwardItemList[i]
        item:poolRecover()
    end
    self.mAwardItemList = {}
end

function removeTargetItemList(self)
    for i = #self.mTargetItemList, 1, -1 do
        local item = self.mTargetItemList[i]
        item:poolRecover()
    end
    self.mTargetItemList = {}
end

function onClickChallengeHandler(self)
    self:exit()
    GameDispatcher:dispatchEvent(EventName.OPEN_ELIMINATE_PANEL, self.mStageConfigVo)
end

function onClickCloseHandler(self)
    self:exit()
end

function exit(self)
    self.mAnimator:SetTrigger("exit")
    self:setTimeout(AnimatorUtil.getAnimatorClipTime(self.mAnimator, "EliminateStagePanel_Exit"), function()
        self:close()
    end)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]