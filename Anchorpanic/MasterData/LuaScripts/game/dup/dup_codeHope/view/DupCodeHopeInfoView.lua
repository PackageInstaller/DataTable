--[[-----------------------------------------------------
@filename       : DupCodeHopeInfoView
@Description    : 代号·希望副本详情
@date           : 2021年5月11日 15:59:35
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('game.dup.dup_codeHope.view.DupCodeHopeInfoView', Class.impl("lib.component.BaseContainer"))

UIRes = UrlManager:getUIPrefabPath("dupCodeHope/DupCodeHopeInfoView.prefab")
destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
-- 构造函数
function ctor(self)
    super.ctor(self)
end

-- 初始化数据
function initData(self)
    self.mItemList = {}
    --self.mSignList = {}
    self.mIsUpdateInfo = false
    self.mAniTime = 0
    self.mEletemList = {}
end

-- 初始化UI
function configUI(self)
    self.mAnimation = self.UIObject:GetComponent(ty.Animator)
    self.mTxtDescribe = self:getChildGO('mTxtDescribe'):GetComponent(ty.Text)
    self.mTxtName = self:getChildGO('mTxtName'):GetComponent(ty.Text)
    self.mTxtTitle = self:getChildGO('mTxtTitle'):GetComponent(ty.Text)
    self.mTxtDrop = self:getChildGO('mTxtDrop'):GetComponent(ty.Text)
    self.mTxtDropEn = self:getChildGO('mTxtDropEn'):GetComponent(ty.Text)
    self.mTxtLimit = self:getChildGO('mTxtLimit'):GetComponent(ty.Text)
    self.mTxtLimitEn = self:getChildGO('mTxtLimitEn'):GetComponent(ty.Text)
    self.mTxtHeroNum = self:getChildGO('mTxtHeroNum'):GetComponent(ty.Text)
    self.mTxtCost = self:getChildGO('mTxtCost'):GetComponent(ty.Text)
    -- self.mImgToucher = self:getChildGO('mImgToucher')
    self.mBtnFight = self:getChildGO('mBtnFight')
    self.mBtnPass = self:getChildGO('mBtnPass')
    self.mTxtRountTimeLab = self:getChildGO('mTxtRountTimeLab'):GetComponent(ty.Text)
    self.mTxtHistoryTimeLab = self:getChildGO('mTxtHistoryTimeLab'):GetComponent(ty.Text)
    self.mTxtHistoryTime = self:getChildGO('mTxtHistoryTime'):GetComponent(ty.Text)
    self.mTxtRountTime = self:getChildGO('mTxtRountTime'):GetComponent(ty.Text)
    -- self.mImgLineHistoryTime = self:getChildGO('mImgLineHistoryTime')
    -- self.mImgLineRountTime = self:getChildGO('mImgLineRountTime')
    self.mBtnCheckEnemy = self:getChildGO("mBtnCheckEnemy")
    -- self.mTxtFight = self:getChildGO("mTxtFight"):GetComponent(ty.Text)
    self.mScrollContent = self:getChildTrans("Content")

    self.mBtnInfoClose = self:getChildGO("mBtnInfoClose")
    -- self.mGroupBuffItem = self:getChildGO("mGroupBuffItem")

    self.mGroupType = self:getChildTrans("mGroupType")
    self.mTxtDesContent = self:getChildTrans("mTxtDesContent")

    self:setGuideTrans("funcTips_codeHope_Fight", self:getChildTrans("mBtnFight"))
    self:setGuideTrans("funcTips_codeHope_Tips1", self:getChildTrans("mGuideTips_1"))
end

-- 激活
function active(self)
    super.active(self)
    self.mIsUpdateInfo = true
    -- self:addOnClick(self.mImgToucher, self.onCloseHandler)
    self:addOnClick(self.mBtnFight, self.onFightHandler)
    self:addOnClick(self.mBtnPass, self.onFightHandler)
    self:addOnClick(self.mBtnInfoClose, self.onCloseHandler)
    self:addOnClick(self.mBtnCheckEnemy, self.checkEnemyFormation)

    self.mTxtHistoryTimeLab.text = _TT(29129) -- "历史最短通关时长"
    self.mTxtRountTimeLab.text = _TT(29130) -- "本轮通关时长"
    self.mAniTime = AnimatorUtil.getAnimatorClipTime(self.mAnimation, "DupCodeHopeInfoView_Exit01")
    self:setBtnLabel(self.mBtnFight, 27141, "进入备战")
    self:setBtnLabel(self.mBtnPass, 27142, "已通关")
end

-- 非激活
function deActive(self)
    super.deActive(self)
    self.mIsUpdateInfo = false
    -- self:removeOnClick(self.mImgToucher, self.onCloseHandler)
    self:removeOnClick(self.mBtnFight, self.onFightHandler)
    self:removeOnClick(self.mBtnPass, self.onFightHandler)
    self:removeOnClick(self.mBtnInfoClose, self.onCloseHandler)
    self:removeItem()
    self:removeBuff()
    self:clearEleitemList()
    self.mAniTime = 0
end

--查看敌人阵型
function checkEnemyFormation(self)
    if self.mDupVo then
        GameDispatcher:dispatchEvent(EventName.OPEN_FORMATION_PREVIEW, { dupVo = self.mDupVo })
    end
end

function show(self, parent, cusDupId)
    if self.mIsUpdateInfo == true and self.mId ~= cusDupId then
        self:selectDoTween(-1)
    end
    self:setParentTrans(parent)
    self:setData(cusDupId)
end

function setData(self, cusDupId)
    self.mId = cusDupId

    self.mDupVo = dup.DupCodeHopeManager:getDupVo(cusDupId)
    -- self.mDupData = dup.DupMainManager:getDupInfoData(self.mDupVo.type)
    self.mTxtName.text = self.mDupVo:getName()
    self.mTxtTitle.text = self.mDupVo:getStageName()
    self.mTxtDescribe.text = self.mDupVo:getDescribe()
    gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.mTxtDescribe.transform) --立即刷新
    gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.mTxtDesContent) --立即刷新

    -- self.mTxtHeroNum.text = string.format("·限制出战人数：%s人", self.mDupVo.limitNum)
    -- self.mTxtCost.text = string.format("·关卡扣除耐力：%s", self.mDupVo.needNum)

    self.mTxtHeroNum.gameObject:SetActive(false)
    self.mTxtCost.gameObject:SetActive(false)

    if self.mDupVo.limitNum == 0 and self.mDupVo.needNum then
        self.mTxtHeroNum.text = _TT(1358)
        self.mTxtHeroNum.gameObject:SetActive(true)
        self.mTxtCost.gameObject:SetActive(false)
    else
        self.mTxtHeroNum.text = _TT(29110, self.mDupVo.limitNum)
        self.mTxtCost.text = _TT(29111, self.mDupVo.needNum)
        self.mTxtHeroNum.gameObject:SetActive(true)
        self.mTxtCost.gameObject:SetActive(true)
    end

    self.mTxtDrop.text = _TT(116) -- 通关奖励
    self.mTxtDropEn.text = "REWARD PREVIEW"
    self:setBtnLabel(self.mBtnFight, 123, "开始挑战")

    if self.mDupVo:getHistroyPassTime() <= 0 then
        self.mTxtHistoryTime.text = "<color='#ffffffff'>--</color>"
        -- self.mImgLineHistoryTime:SetActive(true)
    else
        -- self.mImgLineHistoryTime:SetActive(false)
        self.mTxtHistoryTime.text = TimeUtil.getMSByTime(self.mDupVo:getHistroyPassTime())
    end

    if self.mDupVo:getRoundPassTime() == 0 then
        self.mTxtRountTime.text = "<color='#ffffffff'>--</color>"
        -- self.mImgLineRountTime:SetActive(true)
        self.mBtnFight:SetActive(true)
        self.mBtnPass:SetActive(false)
    else
        -- self.mImgLineRountTime:SetActive(false)
        self.mTxtRountTime.text = TimeUtil.getMSByTime(self.mDupVo:getRoundPassTime())
        self.mBtnFight:SetActive(false)
        self.mBtnPass:SetActive(true)
    end

    -- if self.mDupVo.stageType == 1 then
    self:removeBuff()
    self:updateItem()
    -- else
    --    self:removeItem()
    --    self:updateBuff()
    -- end
    if self.mDupVo.stageType == 3 then
        self:setBtnLabel(self.mBtnFight, 1357)
        -- self.mTxtFight.text = _TT(1357)
    else
        self:setBtnLabel(self.mBtnFight, 29115)
        -- self.mTxtFight.text = _TT(29115)
    end

    self:clearEleitemList()
    for _, type in ipairs(self.mDupVo:getSuggestEleList()) do
        local typeItem = SimpleInsItem:create(self:getChildGO("mImgType"), self.mGroupType, "DupCodeHopeInfoViewherofighttypeImg")
        typeItem:getGo():GetComponent(ty.AutoRefImage):SetImg(UrlManager:getHeroEleTypeIconUrl(type), false)
        table.insert(self.mEletemList, typeItem)
    end

end

-- 更新奖励
function updateItem(self)
    self:removeItem()
    for i = 1, #self.mDupVo.showDrop do
        local vo = self.mDupVo.showDrop[i]
        local propsGrid = PropsGrid:create(self.mScrollContent, { vo.tid, vo.num }, 1, false)
        -- propsGrid:setPosition(math.Vector3((i - 1) * 130 + 70, 0, 0))

        propsGrid:setHasRec(self.mDupVo:getFirstPassFlag() == 1)
        table.insert(self.mItemList, propsGrid)

        -- if dup.DupCodeHopeManager:getHadFirstPass(self.mDupVo.dupId) then
        -- if self.mDupVo:getFirstPassFlag() == 1 then
        --     local signItem = SimpleInsItem:create(self:getChildGO("ReceiveSign"), propsGrid:getTrans(), "DupCodeHopeInfoReceiveSign")
        --     table.insert(self.mSignList, signItem)
        -- end
    end
end

function removeItem(self)
    for i = #self.mItemList, 1, -1 do
        local item = self.mItemList[i]
        item:poolRecover()
    end
    self.mItemList = {}

    -- for i = 1, #self.mSignList do
    --     local item = self.mSignList[i]
    --     item:poolRecover()
    -- end
    -- self.mSignList = {}
end

--删除推荐战员类型
function clearEleitemList(self)
    if #self.mEletemList > 0 then
        for _, item in ipairs(self.mEletemList) do
            item:poolRecover()
        end
        self.mEletemList = {}
    end
end

function updateBuff(self)
    -- self.mGroupBuffItem:SetActive(true)
    self.mBuffItemIns = SimpleInsItem:create2(self:getChildGO("mGroupBuffItem"))
    self.mBuffItemIns.m_go:SetActive(true)

    local buffVo = dup.DupCodeHopeManager:getBuffData(self.mDupVo.buffId)
    if buffVo then
        local skillVo = fight.SkillManager:getSkillRo(buffVo.skillId)
        self.mBuffItemIns:getChildGO("mImgIcon"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getSkillIconPath(buffVo.icon), true)
        self.mBuffItemIns:setText("mTxtName", nil, skillVo:getName())
        self.mBuffItemIns:setText("mTxtDes", nil, skillVo:getDesc())
    end

end
-- 1 退出  -1 切换
function selectDoTween(self, type)
    if type == 1 then
        self.mAnimation:SetTrigger("show")
    elseif type == -1 then
        self.mAnimation:SetTrigger("exit")
    end
end

-- 退出动画播放
function actionExitAni(self)
    self.mAnimation:SetTrigger("show")
    self.showLoop = LoopManager:addTimer(self.mAniTime, 1, self, function()
        if self.showLoop then
            LoopManager:removeTimer(self, self.showLoop)
            self.showLoop = nil
        end
        self:destroy()
    end)
end

function removeBuff(self)
    if self.mBuffItemIns then
        self.mBuffItemIns.m_go:SetActive(false)
        self.mBuffItemIns = nil
    end
end

function onFightHandler(self)
    if self.mDupVo:getRoundPassTime() ~= 0 and self.mDupVo.stageType ~= 3 then
        gs.Message.Show(_TT(29145))
        return
    end

    if self.mDupVo.stageType == 3 then
        -- -- UIFactory:alertMessge("该类型通关不会增加该区域的探索率，是否继续挑战？\n<color='#26d5d3'><size=18>（所有战员耐力、关卡想和当前通关进度重置，关卡奖励和章节奖励不重置）</size></color>", true, function()
        -- UIFactory:alertMessge(_TT(28143), true, function()
        --     formation.checkFormationFight(PreFightBattleType.CodeHopeDup, nil, self.mId, formation.TYPE.CODE_HOPE, nil, nil)
        --     self:onCloseHandler()
        -- end, _TT(1), nil, true, nil, _TT(2), nil, false, RemindConst.DUP_CODE_HOPE_SPECIAL)
        -- return

        local finishCall = function(isSuccess, storyRo)
            if (isSuccess) then
                guide.GuideCondition:condition14()
                if self.mDupVo:getRoundPassTime() == 0 then
                    GameDispatcher:dispatchEvent(EventName.REQ_DUP_STORY_FINISH, { battleType = PreFightBattleType.CodeHopeDup, fieldId = self.mId })
                end
                self:onCloseHandler()
            else
                gs.Message.Show(_TT(49007))
            end
        end
        storyTalk.StoryTalkManager:justStoryNoFight(PreFightBattleType.CodeHopeDup, self.mId, finishCall)
        return
    end
    formation.checkFormationFight(PreFightBattleType.CodeHopeDup, nil, self.mId, formation.TYPE.CODE_HOPE, nil, nil)
    self:onCloseHandler()
end

function onCloseHandler(self)
    GameDispatcher:dispatchEvent(EventName.CLOSE_CODE_HOPE_INFO, self.mDupVo.type)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]