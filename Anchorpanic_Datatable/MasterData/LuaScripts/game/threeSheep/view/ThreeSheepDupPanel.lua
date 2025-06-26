-- @FileName:   ThreeSheepDupPanel.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-07-21 10:59:29
-- @Copyright:   (LY) 2023 雷焰网络

module('game.threeSheep.view.ThreeSheepDupPanel', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("threeSheep/ThreeSheepDupPanel.prefab")

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

    self.mGorpLevelAward = self:getChildTrans("mGorpLevelAward")

    self.mBtnClose = self:getChildGO("mBtnClose")
    self.mBtnFight = self:getChildGO("mBtnFight")

    self.mAnimator = self.UIObject:GetComponent(ty.Animator)
end

function initViewText(self)
    self.mTxtTitle_1.text = _TT(101015)
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

    self.m_DupConfigVo = args

    self.mTxtTitle.text = self.m_DupConfigVo:getName()

    local starCount = threeSheep.ThreeSheepManager:getDupPassStar(self.m_DupConfigVo.tid)
    self:clearItem()
    self.mStarItemList = {}
    for i = 1, #self.m_DupConfigVo.star_list do
        local starItem = SimpleInsItem:create(self.item_Score, self.listGroup, "ThreeSheepDupPanel_StarItem")
        self.mStarItemList[i] = starItem

        local starConfigVo = threeSheep.ThreeSheepManager:getStarConfigVo(self.m_DupConfigVo.star_list[i])

        local isMeet = starCount >= starConfigVo.star

        starItem:getChildGO("mImgStar_2"):SetActive(isMeet)

        local color = isMeet and "202226" or "82898C"
        starItem:getChildGO("mTextDesc"):GetComponent(ty.Text).text = string.format("<color=#%s>%s</color>", color, _TT(starConfigVo.des))
    end

    local isGet = starCount > 0

    self.mPropsGridList = {}
    local awardList = AwardPackManager:getAwardListById(self.m_DupConfigVo.first_award)
    for i = 1, #awardList do
        local propsGrid = PropsGrid:createByData({tid = awardList[i].tid, num = awardList[i].num, parent = self.mGorpLevelAward})
        propsGrid:setHasRec(isGet)
        propsGrid:setIsFirstPass(true)
        table.insert(self.mPropsGridList, propsGrid)
    end
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
    self.mAnimator:SetTrigger("exit")
    local AniTime = AnimatorUtil.getAnimatorClipTime(self.mAnimator, "ThreeSheepDupPanel_Exit")

    self:setTimeout(AniTime, function()
        self:close()
    end)
end

function onClickClose(self)
    super.onClickClose(self)
    GameDispatcher:dispatchEvent(EventName.ONCLOSE_THREESHEEP_DUPPANEL)
end

function onFight(self)
    local activity_id = activity.ActivityId.ThreeSheep
    local activityVo = mainActivity.MainActivityManager:getMainActivityVoById(activity_id)
    if activityVo:getTimeRemaining() <= 0 then
        gs.Message.Show("活动已结束") --活动已结束
        return
    end

    GameDispatcher:dispatchEvent(EventName.THREESHEEP_OPEN_SCENEUI, self.m_DupConfigVo)
    self:close()
end

return _M
