-- @FileName:   FieldExplorationSettlementPanel_1.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-07-21 10:59:29
-- @Copyright:   (LY) 2023 雷焰网络

module('game.fieldExploration.view.FieldExplorationSettlementPanel_1', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("fieldExploration/FieldExplorationSettlementPanel_1.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = -1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isBlur = 0 --是否开启模糊背景（仅2弹窗面板有效，默认开启，0关闭）
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
    self.mBtnFight = self:getChildGO("mBtnFight")
    self.mBtnExit = self:getChildGO("mBtnExit")

    self.mTextLife = self:getChildGO("mTextLife"):GetComponent(ty.Text)
    self.mTexeMonet_a = self:getChildGO("mTexeMonet_a"):GetComponent(ty.Text)
    self.mTexeMonet_b = self:getChildGO("mTexeMonet_b"):GetComponent(ty.Text)
    self.mTextTime = self:getChildGO("mTextTime"):GetComponent(ty.Text)
    self.mTextFinalScore = self:getChildGO("mTextFinalScore"):GetComponent(ty.Text)
    self.mImgNewRecord = self:getChildGO("mImgNewRecord")
    self.props = self:getChildTrans("props")
end

function initViewText(self)

end

--激活
function active(self, args)
    super.active(self)

    local playerTing = fieldExploration.FieldExplorationSceneController:getPlayerThing()
    if playerTing then
        local attr = playerTing:getAttr()

        self.mTextLife.text = attr.life
        self.mTexeMonet_a.text = attr.money_gold
        self.mTexeMonet_b.text = attr.money_silver

        local time = fieldExploration.FieldExplorationSceneController:getDupTime()
        self.mTextTime.text = TimeUtil.getHMSByTime_1(time)
        self.mTextFinalScore.text = attr.score
    end

    local IsNew = args.newRecord > args.oldRecord
    self.mImgNewRecord:SetActive(IsNew)

    local starCount = fieldExploration.FieldExplorationManager:getPlayerDupStar(nil, args.newRecord)
    for i = 1, 3 do
        self:getChildGO("mImgStar_" .. i):SetActive(starCount >= i)
    end

    self:clearItem()
    --是否首通
    if args.oldRecord == 0 and args.newRecord > 0 then
        local dup_id = fieldExploration.FieldExplorationManager:getDupId()
        local dupConfigVo = fieldExploration.FieldExplorationManager:getDupConfigVO(dup_id)
        local awardList = AwardPackManager:getAwardListById(dupConfigVo.first_award)

        self.mPropsGridList = {}
        for i = 1, #awardList do
            local propsGrid = PropsGrid:createByData({tid = awardList[i].tid, num = awardList[i].num, parent = self.props})
            propsGrid:setHasRec(false)
            propsGrid:setIsFirstPass(true)
            table.insert(self.mPropsGridList, propsGrid)
        end
        self.props.gameObject:SetActive(true)
    else
        self.props.gameObject:SetActive(false)
    end
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnExit, self.onExit)
    self:addUIEvent(self.mBtnFight, self.onOver_Again)
end

function clearItem(self)
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

function onExit(self)
    self:close()

    mainui.MainUIManager:setWaitOpenUIcode(LinkCode.MainActivityGameplayMap)
    GameDispatcher:dispatchEvent(EventName.ENTER_NEW_MAP, MAP_TYPE.MAIN_CITY)
end

function onOver_Again(self)
    self:close()

    GameDispatcher:dispatchEvent(EventName.FIELDEXPLORATION_GAME_AGIN)
end

return _M
