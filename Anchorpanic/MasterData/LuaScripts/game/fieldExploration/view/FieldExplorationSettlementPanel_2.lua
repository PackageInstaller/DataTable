-- @FileName:   FieldExplorationSettlementPanel_2.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-07-21 10:59:29
-- @Copyright:   (LY) 2023 雷焰网络

module('game.fieldExploration.view.FieldExplorationSettlementPanel_2', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("fieldExploration/FieldExplorationSettlementPanel_2.prefab")

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
    self.props = self:getChildTrans("props")
    self.mDescItem = self:getChildGO("mDescItem")
    self.descLayer = self:getChildTrans("descLayer")
    self.mImgFail = self:getChildGO("mImgFail")
    self.mImgWin = self:getChildGO("mImgWin")

end

function initViewText(self)

end

--激活
function active(self, args)
    super.active(self)

    self:clearStarItem()
    self.mStarItemList = {}

    local starCount = fieldExploration.FieldExplorationManager:getPlayerDupStar(args.dup_id, args.newRecord)

    self.mImgFail:SetActive(starCount <= 0)
    self.mImgWin:SetActive(starCount > 0)

    local dupConfigVo = fieldExploration.FieldExplorationManager:getDupConfigVO(args.dup_id)
    for i = 1, #dupConfigVo.star_list do
        local starConfigVo = fieldExploration.FieldExplorationManager:getStarConfigVO(dupConfigVo.star_list[i])

        local isMeet = starCount >= starConfigVo.star
        self:getChildGO("mImgStar_" .. i):SetActive(isMeet)

        local starItem = SimpleInsItem:create(self.mDescItem, self.descLayer, "FieldExplorationSettlementPanel_descItem")
        self.mStarItemList[i] = starItem

        starItem:getChildGO("mImgStar"):SetActive(isMeet)

        local color = "82898c"
        if isMeet then
            color = "ffffff"
        end

        starItem:getChildGO("mTextDesc"):GetComponent(ty.Text).text = string.format("<color=#%s>%s</color>", color, _TT(starConfigVo.des))
    end

    self:clearItem()
    --是否首通
    if args.oldRecord == 0 and args.newRecord > 0 then
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

function clearStarItem(self)
    if self.mStarItemList ~= nil then
        for i = 1, #self.mStarItemList do
            self.mStarItemList[i]:poolRecover()
        end
        self.mStarItemList = {}
    end
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
    self:clearStarItem()
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
