-- @FileName:   FieldExplorationDupPanel.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-07-21 10:59:29
-- @Copyright:   (LY) 2023 雷焰网络

module('game.fieldExploration.view.FieldExplorationDupPanel', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("fieldExploration/FieldExplorationDupPanel.prefab")

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

    self.mTxtTitle_2 = self:getChildGO("mTxtTitle_2"):GetComponent(ty.Text)
    self.mTextMaxScore = self:getChildGO("mTextMaxScore"):GetComponent(ty.Text)
    self.mTextMaxRecord = self:getChildGO("mTextMaxRecord"):GetComponent(ty.Text)

    self.mGorpLevelAward = self:getChildTrans("mGorpLevelAward")

    self.mBtnClose = self:getChildGO("mBtnClose")
    self.mBtnFight = self:getChildGO("mBtnFight")
    self.mMaxRecord = self:getChildGO("mMaxRecord")

    self.mAnimator = self.UIObject:GetComponent(ty.Animator)
end

function initViewText(self)
    self.mTxtTitle_2.text = _TT(71311)
end

--激活
function active(self, args)
    super.active(self)
    self:updateView(args, true)
end

function updateView(self, args, noShow)
    if not noShow then
        self.mAnimator:SetTrigger("show")
    end

    self.mDupConfigVo = fieldExploration.FieldExplorationManager:getDupConfigVO(args.dup_id)

    self.mTxtTitle.text = self.mDupConfigVo.name

    local record = fieldExploration.FieldExplorationManager:getPlayerDupRecord(args.dup_id)
    local starCount = fieldExploration.FieldExplorationManager:getPlayerDupStar(args.dup_id, record)

    if args.isShowRecord == true then
        self.mTextMaxScore.text = record

        if self.mDupConfigVo.settlement_type == FieldExplorationConst.Settlement_Type.Time_Over then
            self.mTextMaxRecord.text = _TT(92025)
        elseif self.mDupConfigVo.settlement_type == FieldExplorationConst.Settlement_Type.Push_Box then
            self.mTextMaxRecord.text = _TT(92024)
        end
    end

    self.mMaxRecord:SetActive(args.isShowRecord == true)

    self:clearItem()
    self.mStarItemList = {}
    for i = 1, #self.mDupConfigVo.star_list do
        local starItem = SimpleInsItem:create(self.item_Score, self.listGroup, "FieldExplorationDupPanel_StarItem")
        self.mStarItemList[i] = starItem

        local starConfigVo = fieldExploration.FieldExplorationManager:getStarConfigVO(self.mDupConfigVo.star_list[i])

        if args.isShowStar == true then
            local isMeet = starCount >= starConfigVo.star

            starItem:getChildGO("mImgStar_2"):SetActive(isMeet)

            local color = isMeet and "202226" or "82898C"
            starItem:getChildGO("mTextDesc"):GetComponent(ty.Text).text = string.format("<color=#%s>%s</color>", color, _TT(starConfigVo.des))
        else
            starItem:getChildGO("mTextDesc"):GetComponent(ty.Text).text = string.format("<color=#202226>%s</color>", _TT(starConfigVo.des))
        end

        starItem:getChildGO("mStarGroup"):SetActive(args.isShowStar == true)
    end

    local isGet = record > 0

    self.mPropsGridList = {}
    local awardList = AwardPackManager:getAwardListById(self.mDupConfigVo.first_award)
    for i = 1, #awardList do
        local propsGrid = PropsGrid:createByData({tid = awardList[i].tid, num = awardList[i].num, parent = self.mGorpLevelAward})
        propsGrid:setHasRec(isGet)
        propsGrid:setIsFirstPass(true)
        table.insert(self.mPropsGridList, propsGrid)
    end
end

function initViewText(self)
    -- self:setBtnLabel(self.aa, 10001, "按钮")
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnClose, self.onClickClose)
    self:addUIEvent(self.mBtnFight, self.onFight)

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

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)

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
    super.onClickClose(self)
    GameDispatcher:dispatchEvent(EventName.ONCLOSE_FIELDEXPLORATIONDUPPANEL)
end

function onFight(self)
    local activity_id = fieldExploration.FieldExplorationManager:getActivityId()
    local activityVo = mainActivity.MainActivityManager:getMainActivityVoById(activity_id)
    if activityVo:getTimeRemaining() <= 0 then
        gs.Message.Show("活动已结束") --活动已结束
        return
    end

    fieldExploration.FieldExplorationManager:setDupId(self.mDupConfigVo.dup_id)
    GameDispatcher:dispatchEvent(EventName.ENTER_NEW_MAP, MAP_TYPE.FIELD_EXPLORATION)
end

return _M
