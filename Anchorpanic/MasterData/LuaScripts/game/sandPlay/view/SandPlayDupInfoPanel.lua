-- @FileName:   SandPlayDupInfoPanel.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2024-01-17 11:40:13
-- @Copyright:   (LY) 2023 雷焰网络

module('game.sandPlay.view.SandPlayDupInfoPanel', Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("sandPlay/SandPlayDupInfoPanel.prefab")

panelType = -1 -- 窗口类型 1 全屏 2 弹窗
isBlur = 0 --是否开启模糊背景（仅2弹窗面板有效，默认开启，0关闭）

--构造函数
function ctor(self)
    super.ctor(self)
end

-- 初始化数据
function initData(self)
    super.initData(self)

    self.mWeaknessGrid = {}
    self.m_awardList = {}
end

--初始化UI
function configUI(self)
    self.mBtnClose = self:getChildGO("mBtnClose")
    self.mGroupStamina = self:getChildGO("TextCost")
    self.mTxtCost = self:getChildGO("TextCost"):GetComponent(ty.Text)
    self.mImgCost = self:getChildGO("ImgCost"):GetComponent(ty.AutoRefImage)
    self.mTxtStageDes = self:getChildGO("TextStageDes"):GetComponent(ty.Text)
    self.mTxtStageName = self:getChildGO("mTxtStageName"):GetComponent(ty.Text)
    self.mTxtAwardTitle = self:getChildGO("mTxtAwardTitle"):GetComponent(ty.Text)
    self.mImgEleBg = self:getChildGO("mImgEleBg")
    self.mMoneyItem = self:getChildTrans("mMoneyItem")

    self.mBtnAnemyFormation = self:getChildGO("mBtnAnemyFormation")

    self.mScrollContent = self:getChildTrans("AwardContent")

    self.mBtnFight = self:getChildGO("mBtnFight")
    self.mBtnCose = self:getChildGO("mBtnClose")
    self.mFormationIconNode = self:getChildTrans("mFormationIconNode")

    self.mAnimator = self.UIObject:GetComponent(ty.Animator)
end

function initViewText(self)
    self.mTxtAwardTitle.text = _TT(71311)
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnFight, self.onClickAbleHandler)
    self:addUIEvent(self.mBtnClose, self.close)

    self:addUIEvent(self.mBtnAnemyFormation, self.onOpenFormationPanel)
end

--激活
function active(self, args)
    self.mSandPlayStageConfig = args.dupConfigVo
    self.mNPC_id = args.npc_id
    self.mEvent_id = args.event_id

    self.mDupId = self.mSandPlayStageConfig.dupId

    self:updateView()
end

--非激活
function deActive(self)
    self:recoverEleGrid()
    self:removeItem()

    if self.mMoneyBatItem then
        self.mMoneyBatItem:poolRecover()
        self.mMoneyBatItem = nil
    end
end

function __playOpenAction(self)

end

function __closeOpenAction(self)
    self.mAnimator:SetTrigger("exit")
    self:setTimeout(AnimatorUtil.getAnimatorClipTime(self.mAnimator, "MainMapStageInfoPanel_Exit"), function()
        self:close()
    end)
end

function recoverEleGrid(self)
    for k, v in pairs(self.mWeaknessGrid) do
        v:poolRecover()
    end
    self.mWeaknessGrid = {}
end

function updateView(self)
    self.isPass = sandPlay.SandPlayManager:getMapEventIsPass(nil, self.mNPC_id, self.mEvent_id)

    if self.mSandPlayStageConfig then
        self.mTxtStageName.text = _TT(self.mSandPlayStageConfig.name)
        self.mTxtStageDes.text = self.mSandPlayStageConfig.describe

        local costTid = MoneyTid.ANTIEPIDEMIC_SERUM_TID
        local costCount = self.mSandPlayStageConfig.cost
        self.mImgCost:SetImg(MoneyUtil.getMoneyIconUrlByTid(costTid), true)
        self.mTxtCost.text = MoneyUtil.getMoneyCountByTid(MoneyTid.ANTIEPIDEMIC_SERUM_TID) >= costCount and HtmlUtil:color(costCount, "474C50ff") or HtmlUtil:color(costCount, "BD2A2AFF")

        self.mGroupStamina:SetActive((not self.isPass) and (costCount ~= 0))

        if not self.mMoneyBatItem then
            self.mMoneyBatItem = MoneyItem:poolGet()
            self.mMoneyBatItem:setData(self.mMoneyItem, {tid = costTid, frontType = 2})
            self.mMoneyBatItem:getAdaptaTrans().localPosition = gs.VEC3_ZERO
        end

        self:updateSuggest()
        self:updateItem()
    end
end

function onOpenFormationPanel(self)
    local callFun = function ()
        GameDispatcher:dispatchEvent(EventName.OPEN_SANDPLAY_DUPINFOPANEL, {dupConfigVo = self.mSandPlayStageConfig, npc_id = self.mNPC_id, event_id = self.mEvent_id})
    end
    GameDispatcher:dispatchEvent(EventName.OPEN_FORMATION_PREVIEW, {dupVo = self.mSandPlayStageConfig, closeCallBack = callFun})
    self:close()
end

function updateSuggest(self)
    self:recoverEleGrid()
    local suggestEle = self.mSandPlayStageConfig.suggestEle
    for i = 1, #suggestEle do
        local item = SimpleInsItem:create(self.mImgEleBg, self.mFormationIconNode, "SandPlayDupInfoPanelelegrid")
        local type = item:getChildGO("mImgEleType"):GetComponent(ty.AutoRefImage)
        type:SetImg(UrlManager:getHeroEleTypeIconUrl(suggestEle[i]), false)
        table.insert(self.mWeaknessGrid, item)
    end
end

function updateItem(self)
    self:removeItem()

    local awardList = AwardPackManager:getAwardListById(self.mSandPlayStageConfig.first_award)
    for i = 1, #awardList do
        local vo = awardList[i]
        local propsGrid = PropsGrid:create(self.mScrollContent, {vo.tid, vo.num}, 0.95, false)
        table.insert(self.m_awardList, propsGrid)

        propsGrid:setHasRec(self.isPass == true)
        propsGrid:setIconGray(self.isPass == true)
    end
end

function removeItem(self)
    if (self.m_awardList) then
        for i = #self.m_awardList, 1, -1 do
            local item = self.m_awardList[i]
            item:poolRecover()
        end
    end
    self.m_awardList = {}
end

function onClickAbleHandler(self)
    local callFun = function (callReason)
        if (callReason == formation.CALL_FUN_REASON.PLAYER_CLOSE) then
            GameDispatcher:dispatchEvent(EventName.OPEN_SANDPLAY_DUPINFOPANEL, {dupConfigVo = self.mSandPlayStageConfig, npc_id = self.mNPC_id, event_id = self.mEvent_id})
        end
    end
    formation.readyFormationFight(PreFightBattleType.SandPlay, DupType.SandPlay, self.mDupId, formation.TYPE.SANDPLAY, nil, nil, callFun)
    self:close()
end

function close(self)
    super.close(self)
    GameDispatcher:dispatchEvent(EventName.SANDPLAY_OVER_MAPEVENT_TRIGGER, {event_id = self.mEvent_id})
end

return _M
