--[[ 
-----------------------------------------------------
@filename       : MiningDupInfoView
@Description    : 挖矿副本信息
@date           : 2023-12-08 17:42:09
@Author         : Jacob
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module('game.mining.view.MiningDupInfoView', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("mining/MiningDupInfoView.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = -1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isBlur = 0
isAddMask = 0 --窗口模式下是否需要添加mask (1 添加 0 不添加)

--构造函数
function ctor(self)
    super.ctor(self)
end

--析构
function dtor(self)
end

function initData(self)

end

-- 初始化
function configUI(self)
    self.mTxtTitle = self:getChildGO("mTxtTitle"):GetComponent(ty.Text)
    self.item_Score = self:getChildGO("item_Score")
    self.listGroup = self:getChildTrans("listGroup")

    self.mTxtTitle_1 = self:getChildGO("mTxtTitle_1"):GetComponent(ty.Text)
    self.mTxtTitle_2 = self:getChildGO("mTxtTitle_2"):GetComponent(ty.Text)
    self.mTextMaxScore = self:getChildGO("mTextMaxScore"):GetComponent(ty.Text)
    self.mTextMaxRecord = self:getChildGO("mTextMaxRecord"):GetComponent(ty.Text)

    self.mGorpLevelAward = self:getChildTrans("mGorpLevelAward")

    self.mBtnClose = self:getChildGO("mBtnClose")
    self.mBtnFight = self:getChildGO("mBtnFight")

    self.mBtnPrevent = self:getChildGO("mBtnPrevent")
    self.mBtnPrevent:GetComponent(ty.LongPressOrClickEventTrigger):SetIsPassEvent(true)

    self.mAnimator = self.UIObject:GetComponent(ty.Animator)
end



--激活
function active(self, args)
    super.active(self)
    self:updateView(args, true)
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    self.isUpdate = false
    self:clearItem()
end

function __playOpenAction(self)

end

function __closeOpenAction(self)
    local AniTime = AnimatorUtil.getAnimatorClipTime(self.mAnimator, "FieldExplorationDupPanel_Exit")
    self.mAnimator:SetTrigger("exit")
    self:setTimeout(AniTime, function()
        self:close()
    end)
end

function onClickClose(self)
    if self.isUpdate then
        self.isUpdate = false
        return
    end
    super.onClickClose(self)
    -- GameDispatcher:dispatchEvent(EventName.ONCLOSE_FIELDEXPLORATIONDUPPANEL)
end

function initViewText(self)
    self.mTxtTitle_1.text = _TT(99571)
    self.mTxtTitle_2.text = _TT(99570)
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnClose, self.onClickClose)
    self:addUIEvent(self.mBtnFight, self.onFight)
    self:addUIEvent(self.mBtnPrevent, self.onClickClose)

end

function updateView(self, dupVo, noShow)
    if not noShow then
        self.isUpdate = true
        self.mAnimator:SetTrigger("show")
    end

    self.mDupConfigVo = dupVo

    self.mTxtTitle.text = _TT(self.mDupConfigVo.dupName)

    local record = mining.MiningManager:getPlayerDupRecord(self.mDupConfigVo.id)
    local starCount = mining.MiningManager:getPlayerDupStar(self.mDupConfigVo.id, record)
    self.mTextMaxScore.text = record

    if self.mDupConfigVo.settlement_type == 1 then
        self.mTextMaxRecord.text = _TT(92025)
    elseif self.mDupConfigVo.settlement_type == 2 then
        self.mTextMaxRecord.text = _TT(92024)
    end

    self:clearItem()
    self.mStarItemList = {}
    for i = 1, #self.mDupConfigVo.starList do
        local starItem = SimpleInsItem:create(self.item_Score, self.listGroup, "MiningDupInfoViewStarItem")
        self.mStarItemList[i] = starItem

        local starConfigVo = mining.MiningManager:getStarConfigVo(self.mDupConfigVo.starList[i])

        local isMeet = starCount >= starConfigVo.star

        local color = isMeet and "202226" or "82898C"
        starItem:getChildGO("mTextDesc"):GetComponent(ty.Text).text = string.format("<color=#%s>%s</color>", color, _TT(starConfigVo.des))

        starItem:getChildGO("mImgStar_2"):SetActive(isMeet)
    end

    local isGet = record > 0

    self.mPropsGridList = {}
    local awardList = self.mDupConfigVo.firstAward
    for i = 1, #awardList do
        local propsGrid = PropsGrid:createByData({ tid = awardList[i].tid, num = awardList[i].num, parent = self.mGorpLevelAward })
        propsGrid:setHasRec(isGet)
        propsGrid:setIsFirstPass(true)
        table.insert(self.mPropsGridList, propsGrid)
    end
end



function clearItem(self)
    if self.mStarItemList then
        for k, v in pairs(self.mStarItemList) do
            v:poolRecover()
        end
        self.mStarItemList = nil
    end

    if self.mPropsGridList ~= nil then
        for i = 1, #self.mPropsGridList do
            self.mPropsGridList[i]:poolRecover()
        end
        self.mPropsGridList = {}
    end
end

function onFight(self)
    local activity_id = fieldExploration.FieldExplorationManager:getActivityId()
    local activityVo = mainActivity.MainActivityManager:getMainActivityVoById(activity_id)
    if activityVo and activityVo:getTimeRemaining() <= 0 then
        gs.Message.Show("活动已结束") --活动已结束
        return
    end
    self:close()
    -- fieldExploration.FieldExplorationManager:setDupId(self.mDupConfigVo.id)
    GameDispatcher:dispatchEvent(EventName.OPEN_MINING_SCENE, { dupId = self.mDupConfigVo.id })
end

return _M