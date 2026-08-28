-------------------------------------------------------------------------------
-- Pass卡 - 奖励界面
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-12-03 17:03:41
-------------------------------------------------------------------------------

local DOTween           = CS.DG.Tweening.DOTween
local IdolLive3D_Utils  = import('Game.IdolLive3D.IdolLive3D_Utils')
local IdolLive3D_Loader = import('Game.IdolLive3D.IdolLive3D_Loader')
local PassCardUtils     = import('Game.UI.PassCard.PassCardUtils')
local passCardComp      = PassCardUtils.GetComp()
local goodsConfMgr      = GoodsConfMgr:GetInstance()
local KTool = CS.Engine.Lib.KTool

local RemindListTweenId   = 'UIBattlePassContractManualDialog_RemindListTweenId'
local RewardListCellPath1 = 'Game.UI.PassCard.BattlePassContractManual.UIBattlePassContractManualNode'
local RewardListCellPath2 = 'Game.UI.PassCard.BattlePassContractManual.UIBattlePassContractManualFinalNode'
local RewardListCellName1 = 'BattlePassContractManualCell1'
local RewardListCellName2 = 'BattlePassContractManualCell2'
local RemindListCellName  = 'Cell'

local ROOT_ANIM_NAME = {
    SHOW = 'BattlePassContractManual_Entry'
}

--- from: Assets/BundleResources/Prefabs/BattlePass/BattlePassContractManual.prefab > name: BattlePassContractManual
---@class UIBattlePassContractManualDialog         
---@field Env                           	UIBattlePassContractManualDialog        
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field PassAllUnlockUIFX             	UnityEngine.RectTransform               	@ 0    
---@field PassDeluxeLockIcon            	UnityEngine.RectTransform               	@ 1    豪华Pass卡 锁定图标
---@field PassNormalLockIcon            	UnityEngine.RectTransform               	@ 2    普通Pass卡 锁定图标
---@field PassDeluxeIconBtn             	UnityEngine.RectTransform               	@ 3    豪华Pass卡 图标按钮
---@field PassNormalIconBtn             	UnityEngine.RectTransform               	@ 4    普通Pass卡 图标按钮
---@field RewardsToRightBtn             	UnityEngine.RectTransform               	@ 5    奖励信息 置右按钮
---@field RewardsToLeftBtn              	UnityEngine.RectTransform               	@ 6    奖励信息 置左按钮
---@field RewardsStageNode              	UnityEngine.RectTransform               	@ 7    奖励信息 阶段奖励节点
---@field RewardsGoodsList              	SuperScrollView.LoopListView2           	@ 8    奖励信息 道具列表
---@field PassLevelMaxTxt               	UnityEngine.RectTransform               	@ 9    等级信息 满级文本
---@field PassLevelNumTxt               	UnityEngine.RectTransform               	@ 10   等级信息 等级文本
---@field PassLevelExpTxt               	UnityEngine.RectTransform               	@ 11   等级信息 经验文本
---@field PassLevelBuyBtn               	Game.Native.Common.FontStyleButton      	@ 12   等级信息 购买等级按钮
---@field PassLevelExpSlider            	UnityEngine.UI.Slider                   	@ 13   等级信息 经验进度条
---@field RewardsRemindList             	SuperScrollView.LoopListView2           	@ 14   奖励提醒 奖励列表
---@field RewardsRemindNode             	UnityEngine.RectTransform               	@ 15   奖励提醒 根节点
---@field PassCardUpgradeUIFX           	UnityEngine.RectTransform               	@ 16   购买节点 升级Pass特效
---@field PassCardBuyUIFX               	UnityEngine.RectTransform               	@ 17   购买节点 购买Pass特效
---@field PassCardHasNode               	UnityEngine.RectTransform               	@ 18   购买节点 已拥有节点
---@field PassCardBuyTxt                	UnityEngine.RectTransform               	@ 19   购买节点 购买文字
---@field PassCardBuyBtn                	UnityEngine.RectTransform               	@ 20   购买节点 购买按钮
---@field RewardsDrawAllRed             	UnityEngine.RectTransform               	@ 21   领取全部 红点
---@field RewardsDrawAllBtn             	Game.Native.Common.FontStyleButton      	@ 22   领取全部 按钮
---@field RewardsLeftTimeTxt            	UnityEngine.RectTransform               	@ 23   奖励信息 剩余时间文本
---@field RewardsRootNode               	UnityEngine.RectTransform               	@ 24   奖励信息 根节点
---@field BottomSloganTxt               	UnityEngine.RectTransform               	@ 25   底部提示 文本
---@field BottomSloganNode              	UnityEngine.RectTransform               	@ 26   底部提示 节点
---@field LobbyInteractiveGroup         	UnityEngine.RectTransform               	@ 27   展示角色 可交互标识
---@field LobbyRewardNameTxt            	UnityEngine.RectTransform               	@ 28   展示角色 奖励名字文本
---@field LobbyRoleNameNode             	UnityEngine.RectTransform               	@ 29   展示角色 名字节点
---@field LobbyDrawingNode              	Game.Native.Common.DrawingNode          	@ 30   展示角色 立绘节点
---@field LobbySpecialIcon              	UnityEngine.RectTransform               	@ 31   展示角色 开服限定图标
---@field LobbyRootNode                 	UnityEngine.RectTransform               	@ 32   展示角色 根节点
---@field GoodsRewardNameTxt            	UnityEngine.RectTransform               	@ 33   
---@field GoodsRootNode                 	UnityEngine.RectTransform               	@ 34   
---@field AnimRoot                      	UnityEngine.RectTransform               	@ 35   动画根节点
---@field  Discount                     	UnityEngine.RectTransform               	@ 36   
---@field DiscountTextDesc              	UnityEngine.RectTransform               	@ 37   
local UIBattlePassContractManualDialog = Class('UIBattlePassContractManualDialog')


function UIBattlePassContractManualDialog:__init() 
    ---@type Engine.Modules.CDTimerModule @ 刷新倒计时的计时器
    self.scheduleRefreshTimer_ = nil

    ---@type UIBattlePassContractManualNode
    self.rewardsStageNodeEnv_ = nil

    ---@type integer @ 当前显示的排期id
    self.currentScheduleId_ = nil

    ---@type integer @ Pass卡最大等级
    self.passCardLevelMax_ = 0

    ---@type UnityEngine.Coroutine
    self.coRewardsListInit_ = nil
    
    ---@type table[] @ 奖励列表数据
    self.rewardsDataList_ = {}

    ---@type table[] @ 展示的列表数据
    self.remindDataList_ = {}

    ---@type number @ 奖励列表节点宽度
    self.rewardListItemW_ = 0
    
    ---@type integer @ 奖励列表视图宽度
    self.rewardListVPortW_ = 0

    ---@type integer @ 奖励列表奖励总宽度
    self.rewardListTotalW_ = 0

    ---@type integer @ 最小可领取奖励位置
    self.canDrawIndexMin_ = 0

    ---@type integer @ 最大可领取奖励位置
    self.canDrawIndexMax_ = 0
    
    ---@type number @ 提醒列表滚动距离
    self.remindListItemW_ = 0

    ---@type UnityEngine.RectTransform @ 奖励列表容器
    self.rewardListCTrans_ = nil
    
    ---@type UnityEngine.RectTransform @ 提醒列表容器
    self.remindListCTrans_ = nil

    ---@type UnityEngine.Coroutine @ 禁用列表的滚动检测协程
    self.coDisableScrollCheck_ = nil
end


function UIBattlePassContractManualDialog:__delete()
    self.scheduleRefreshTimer_ = nil
    self.rewardsStageNodeEnv_  = nil
    self.currentScheduleId_    = nil
    self.passCardLevelMax_     = nil
    self.rewardsDataList_      = nil
    self.remindDataList_       = nil
    self.rewardListItemW_      = nil
    self.remindListItemW_      = nil
    self.rewardListCTrans_     = nil
    self.remindListCTrans_     = nil
    self.rewardListVPortW_     = nil
    self.rewardListTotalW_     = nil
    self.canDrawIndexMin_      = nil
    self.canDrawIndexMax_      = nil
    self.coDisableScrollCheck_ = nil
    self.coRewardsListInit_    = nil
end


function UIBattlePassContractManualDialog:Awake()
    self.rewardsStageNodeEnv_ = CfUtils.GetLuaScr(self.RewardsStageNode, RewardListCellPath1)
    CfUtils.SetCanvasGroupInteractable(self.RewardsRemindNode, false)
    
    SetButtonAction(self.PassCardBuyBtn, Bind(self, self.OnClickBuyPassButtonHandler_))
    SetButtonAction(self.PassLevelBuyBtn, Bind(self, self.OnClickPassLevelBuyButtonHandler_))
    SetButtonAction(self.RewardsDrawAllBtn, Bind(self, self.OnClickRewardsDrawAllButtonHandler_))
    SetButtonAction(self.PassNormalIconBtn, Bind(self, self.OnClickBuyPassButtonHandler_))
    SetButtonAction(self.PassDeluxeIconBtn, Bind(self, self.OnClickBuyPassButtonHandler_))
    SetButtonAction(self.LobbyInteractiveGroup, Bind(self, self.OnClickLobbyInteractiveHandler_))
end


function UIBattlePassContractManualDialog:OnInit()
    self.eventsDecorated_ = CfUtils.EventsDecorated({
        [PassCardUtils.EventName.PASS_CARD_EXP_CHANGE]  = Bind(self, self.OnPassExpChangeEventHandler_),
        [PassCardUtils.EventName.PASS_CARD_LOOP_TIMES]  = Bind(self, self.OnPassLoopTimesEventHandler_),
        [PassCardUtils.EventName.PASS_CARD_TYPE_CHANGE] = Bind(self, self.OnPassTypeChangeEventHandler_),
    })

    local rewardItemData  = self.RewardsGoodsList:GetItemPrefabConfData(RewardListCellName1)
    local rewardItemWidth = rewardItemData.mItemPrefab.transform.sizeDelta.x
    self.rewardListItemW_ = rewardItemWidth + rewardItemData.mPadding
    
    local remindItemData  = self.RewardsRemindList:GetItemPrefabConfData(RemindListCellName)
    local remindItemWidth = remindItemData.mItemPrefab.transform.sizeDelta.x
    self.remindListItemW_ = remindItemWidth + remindItemData.mPadding
    
    SetListViewAction(self.RewardsRemindList, Bind(self, self.OnUpdateRemindListCellHandler_))
    -- SetListViewAction(self.RewardsGoodsList, Bind(self, self.OnUpdateRewardsListCellHandler_), nil, {mItemDefaultWithPaddingSize = self.rewardListItemW_})
    -- self.RewardsGoodsList.ScrollRect.onValueChanged:AddListener(Bind(self, self.OnRewardsGoodsListScrollChangedHandler_))
    
    -- self.rewardListCTrans_ = self.RewardsGoodsList.ContainerTrans
    -- self.rewardListVPortW_ = self.RewardsGoodsList.ViewPortWidth
    self.remindListCTrans_ = self.RewardsRemindList.ContainerTrans
end


function UIBattlePassContractManualDialog:OnEnable()
    -- 入场动画有修改滚动列表尺寸的行为，所以这时候侦听列表滚动距离会无意义，要等动画做完了再开启滚动事件检测
    local showTime = CfUtils.GetAnimationTime(self.AnimRoot, ROOT_ANIM_NAME.SHOW)
    self.coDisableScrollCheck_ = CoStart(function()
        CoYield(showTime)
        self.coDisableScrollCheck_ = nil
    end)
end


function UIBattlePassContractManualDialog:OnDestroy()
    CfUtils.EventsUndecorated(self.eventsDecorated_)
    self:ScheduleRefreshCountdownClear_()
    if self.RewardsGoodsList.ScrollRect then  -- InitListView 之后 ScrollRect 才会有值
        self.RewardsGoodsList.ScrollRect.onValueChanged:RemoveAllListeners()
    end
    DOTween.Kill(RemindListTweenId)
    if self.coRewardsListInit_ then
        CoStop(self.coRewardsListInit_)
        self.coRewardsListInit_ = nil
    end
    if self.coDisableScrollCheck_ then
        CoStop(self.coDisableScrollCheck_)
        self.coDisableScrollCheck_ = nil
    end
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


-------------------------------------------------
-- get / set

---@return table[]
function UIBattlePassContractManualDialog:GetRewardsDataList()
    return checkTable(self.rewardsDataList_)
end


---@return table[]
function UIBattlePassContractManualDialog:GetRemindDataList()
    return checkTable(self.remindDataList_)
end
function UIBattlePassContractManualDialog:SetRemindDataList(dataList)
    self.remindDataList_ = checkTable(dataList)
    self:UpdateRemindList_()
end


---@return integer
function UIBattlePassContractManualDialog:GetStageDrawIndex()
    return checkInt(self.stageDrawIndex_)
end
function UIBattlePassContractManualDialog:SetStageDrawIndex(drawIndex)
    self.stageDrawIndex_ = checkInt(drawIndex)
    self:UpdateStageRewards_()
end


-------------------------------------------------
-- public

---@param initParams table
function UIBattlePassContractManualDialog:OnOpen(initParams)
    self:OnInit()
    self:OnDataRefresh(true)
end


---@param initParams table
function UIBattlePassContractManualDialog:OnClose(initParams)
end


function UIBattlePassContractManualDialog:OnDataRefresh(isDelayList)
    local oldScheduleId = self.currentScheduleId_
    local newScheduleId = passCardComp:GetHomeDojo().scheduleId
    if oldScheduleId ~= newScheduleId then

        -- update lobby
        local isLobbyCard = passCardComp:IsPassLobbyIsCard()
        CfUtils.SetActive(self.LobbyRootNode, isLobbyCard)
        CfUtils.SetActive(self.GoodsRootNode, not isLobbyCard)
        if isLobbyCard then
            self:UpdateLobbyCard_()
        else
            self:UpdateLobbyGoods_()
        end

        -- update rewardsData
        self.rewardsDataList_ = {}
        for drawIndex, drawData in ipairs(passCardComp:GetDrawDataList()) do
            self.rewardsDataList_[drawIndex] = drawData
        end
        if #self.rewardsDataList_ > 0 then
            table.insert(self.rewardsDataList_, {isChest = true})
        end

        -- update levelMax
        self.passCardLevelMax_ = passCardComp:GetPassLevelMax()
        self.rewardListTotalW_ = self.passCardLevelMax_ * self.rewardListItemW_

        -- save scheduleId
        self.currentScheduleId_ = newScheduleId
    end

    self:UpdatePassTypeState_()
    self:UpdatePassLevelInfo_()
    self:ScheduleRefreshCountdownStart_()
    self:UpdateDrawAllRewardsRed_()
    self:UpdateRedPoint_()
    self:CheckCanDrawIndex_()

    -- 优先定位 最靠前的可领取奖励位置
    local firstViewDrawIndex = 0
    for drawIndex, _ in ipairs(passCardComp:GetDrawDataList()) do
        if passCardComp:HasCanDrawRewardsAt(drawIndex) then
            firstViewDrawIndex = drawIndex
            break
        end
    end
    -- 其次定位 当前等级的解锁位置
    if firstViewDrawIndex == 0 then
        firstViewDrawIndex = passCardComp:GetHomeDojo().passCardLevel
    end
    local checkStageDrawIndex = function()
        if firstViewDrawIndex > 0 then
            local moveToListIndex = firstViewDrawIndex - 1
            self:CheckStageDrawIndex_(moveToListIndex * -self.rewardListItemW_)
        else
            self:CheckStageDrawIndex_(0)
        end
    end

    local initRewardList = function()
        self:UpdateRewardList_()
        if firstViewDrawIndex > 0 then
            local moveToListIndex = firstViewDrawIndex - 1
            self.RewardsGoodsList:MovePanelToItemIndex(moveToListIndex)
        end
    end
    -- 使用 ListView 的 InitCreateCount 属性来达到分帧创建，避免集中创建造成内存抖动问题
    -- if isDelayList then
    --     -- 由于首次打开界面时，奖励列表内容过多，会出现一瞬间的阻塞，等列表初始化结束后，动画会表现出一下子跳过好几帧的顿挫感，所以首次打开做个列表的延迟初始化
    --     self.coRewardsListInit_ = CoStart(function()
    --         for initIndex = 1, math.ceil(self.rewardListVPortW_ / self.rewardListItemW_) do
    --             self.RewardsGoodsList:ExpandPool(RewardListCellName1)
    --             CoYield(0.02)
    --         end
    --         self.coRewardsListInit_ = nil
    --         initRewardList()
    --     end)
    -- else
        initRewardList()
    -- end
    checkStageDrawIndex()
end


-------------------------------------------------
-- private

function UIBattlePassContractManualDialog:UpdateLobbyGoods_()
    local lobbyGodosId = passCardComp:GetPassLobbyCardId()
    if lobbyGodosId == 0 then return end

    local lobbyGodosName = GoodsUtils.GetGoodsNameById(lobbyGodosId)
    CfUtils.FillText(self.GoodsRewardNameTxt, lobbyGodosName)
end


--- 刷新 看板形象
function UIBattlePassContractManualDialog:UpdateLobbyCard_()
    local lobbyCardId = passCardComp:GetPassLobbyCardId()
    if lobbyCardId == 0 then return end

    local lobbyCardVo = CardConfMgr:GetInstance():GetCardByRefId(lobbyCardId)
    if not lobbyCardVo then return end

    -- update card name
    local roleNameEnv = CfUtils.GetLuaScr(self.LobbyRoleNameNode, Constants.UILuaTablePath.RoleNameNode)
    roleNameEnv:RefreshSelf(lobbyCardId, lobbyCardVo.rare, function(showCard)
        -- open preview
        local GachaponUtils = import('Game.Gachapon.GachaponUtils')
        GachaponUtils.OpenDetail(showCard, { UIArgs(Constants.UITypeIds.UIBattlePassEntryDialog) })
    end)

    -- update card draw
    self.LobbyDrawingNode:Execute(checkInt(lobbyCardVo.defaultSkin))

    -- update card name
    CfUtils.FillText(self.LobbyRewardNameTxt, lobbyCardVo.name)

    -- update live3d mark
    self:RefreshLive3DBtn_(checkInt(lobbyCardVo.defaultSkin))

    -- update special icon
    local passCardHomeDojo = passCardComp:GetHomeDojo()
    local passCardPlanVo   = PassCardUtils.GetPassCardPlanVo(passCardHomeDojo.scheduleId)
    CfUtils.SetActive(self.LobbySpecialIcon, passCardPlanVo.specialIcon == 1)
end


function UIBattlePassContractManualDialog:ScheduleRefreshCountdownClear_()
    if isNotNull(self.scheduleRefreshTimer_) then
        CfUtils.CDTimerRemove(self.scheduleRefreshTimer_)
        self.scheduleRefreshTimer_ = nil
    end
end


function UIBattlePassContractManualDialog:ScheduleRefreshCountdownStart_()
    self:ScheduleRefreshCountdownClear_()

    local passCardHomeDojo = passCardComp:GetHomeDojo()
    local countdownTimeNum = math.max(passCardHomeDojo.leftSeconds, 1)
    self.scheduleRefreshTimer_ = CfUtils.CDTimerAppend(1, countdownTimeNum, true, true, function(count, id, elapsed)

        -- update leftTime
        passCardHomeDojo.leftSeconds = passCardHomeDojo.leftSeconds - elapsed
        self:UpdateScheduleRefreshTime_()

        -- check timeover
        if count == 0 then
            passCardComp:SyncPassHomeData(function()
                self:OnDataRefresh()
            end)
        end
    end)
end


function UIBattlePassContractManualDialog:UpdateScheduleRefreshTime_()
    local leftSeconds = passCardComp:GetHomeDojo().leftSeconds
    local leftTimeTxt = CfUtils.GetTimeHMS3(math.max(leftSeconds, 0), 30)
    CfUtils.FillText(self.RewardsLeftTimeTxt, leftTimeTxt)
end


--- 刷新 Pass卡状态
function UIBattlePassContractManualDialog:UpdatePassTypeState_()
    local rewardDataList = {}
    local remindDataList = {}
    if passCardComp:IsUnlockDeluxePass() then
        CfUtils.SetActive(self.PassCardBuyBtn, false)
        CfUtils.SetActive(self.PassCardHasNode, true)
        CfUtils.SetActive(self.RewardsRemindNode, false)
        CfUtils.SetActive(self.PassCardUpgradeUIFX, false)
        CfUtils.SetActive(self.PassCardBuyUIFX, false)
        CfUtils.SetActive(self.PassNormalLockIcon, false)
        CfUtils.SetActive(self.PassDeluxeLockIcon, false)
        KTool.SetActive(self.Discount.gameObject , false)
    elseif passCardComp:IsUnlockNormalPass() then
        CfUtils.SetActive(self.PassCardBuyBtn, true)
        CfUtils.SetActive(self.PassCardHasNode, false)
        CfUtils.SetActive(self.RewardsRemindNode, true)
        CfUtils.SetActive(self.PassCardUpgradeUIFX, true)
        CfUtils.SetActive(self.PassCardBuyUIFX, false)
        CfUtils.SetUISwitchText(self.PassCardBuyTxt, 2)
        CfUtils.SetActive(self.PassNormalLockIcon, false)
        CfUtils.SetActive(self.PassDeluxeLockIcon, true)
        KTool.SetActive(self.Discount.gameObject , false)
        rewardDataList = passCardComp:GetAllDeluxeRewardDataList()
    else
        CfUtils.SetActive(self.PassCardBuyBtn, true)
        CfUtils.SetActive(self.PassCardHasNode, false)
        CfUtils.SetActive(self.RewardsRemindNode, true)
        CfUtils.SetActive(self.PassCardUpgradeUIFX, false)
        CfUtils.SetActive(self.PassCardBuyUIFX, true)
        CfUtils.SetUISwitchText(self.PassCardBuyTxt, 1)
        CfUtils.SetActive(self.PassNormalLockIcon, true)
        CfUtils.SetActive(self.PassDeluxeLockIcon, true)
        rewardDataList = passCardComp:GetAllNormalAndDeluxeRewardDataList()
        --- 可使用物品模块加载
        local usableGoodComponent = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.UsableGoodComponent)
        local good = usableGoodComponent:GetGoodShortestTimeByEffectType(504)
        if good and checkInt(good.remainTime) > 0 then
            KTool.SetActive(self.Discount.gameObject , true)
            if checkInt(good.remainTime) > 86400  then
                CfUtils.FillText(self.DiscountTextDesc , localize("限时折扣生效中"))
            else 
                CfUtils.FillText(self.DiscountTextDesc , localize("限时折扣剩余1天"))
            end
        end
    end

    -- 末尾额外追加一个第一个奖励，目的是滚动到最后一个时，再进行滚动可以看到假的第一个，最后再跳转到开头，以为无限循环的错觉
    local rewardDataCount = #rewardDataList
    if rewardDataCount > 0 then
        for rewardIndex = 1, rewardDataCount + 1 do
            local isLastData = rewardIndex > rewardDataCount
            local rewardData = rewardDataList[isLastData and 1 or rewardIndex]
            local goodsId    = rewardData.goodsId
            local goodsVo    = goodsConfMgr:GetGoodsVoById(goodsId)
            table.insert(remindDataList, {
                num     = rewardData.num,
                goodsId = goodsId,
                goodsVo = goodsVo,
            })
        end
    end
    self:SetRemindDataList(remindDataList)
end


--- 刷新 Pass卡等级
function UIBattlePassContractManualDialog:UpdatePassLevelInfo_()
    local isPassLevelMax  = passCardComp:IsPassLevelMax()
    local currentLevelNum = passCardComp:GetHomeDojo().passCardLevel

    -- update level text
    CfUtils.SetActive(self.PassLevelMaxTxt, isPassLevelMax)
    CfUtils.SetActive(self.PassLevelNumTxt, not isPassLevelMax)
    if not isPassLevelMax then
        CfUtils.FillText(self.PassLevelNumTxt, localize('Lv. <size=72>_num_</size>', {_num_ = currentLevelNum}))
    end
    
    -- update buy button
    if isPassLevelMax then
        self.PassLevelBuyBtn:ResetFontStyle('B18', localize('已满级'))
    else
        self.PassLevelBuyBtn:ResetFontStyle('B25', localize('购买等级'))
    end
    
    -- update exp value
    local currentExpNum = passCardComp:GetHomeDojo().passCardShowExp
    local upgradeLevExp = isPassLevelMax and passCardComp:GetLoopChestEachExp() or PassCardUtils.ConvertPassUpgradeExp()
    CfUtils.FillText(self.PassLevelExpTxt, localize('<size=40>_num1_</size>/_num2_', {_num1_ = currentExpNum, _num2_ = upgradeLevExp}))
    CfUtils.SetSliderPercent(self.PassLevelExpSlider, currentExpNum / upgradeLevExp)
end


--- 刷新 领取奖励列表
function UIBattlePassContractManualDialog:UpdateRewardList_()
    local listDataLength = #self:GetRewardsDataList()

    -- 复制 SetListViewAction 实现，目的是 InitListView 时才能使用 InitCreateCount 进行逐帧初始化
    local listView  = self.RewardsGoodsList
    local callback  = Bind(self, self.OnUpdateRewardsListCellHandler_)
    local initParam = {mItemDefaultWithPaddingSize = self.rewardListItemW_}
    if not listView.IsListViewInit then
        local LoopListViewInitParam = CS.SuperScrollView.LoopListViewInitParam
        ---@type SuperScrollView.LoopListViewInitParam
        local listInitParam = LoopListViewInitParam.CopyDefaultInitParam()
        for k, v in pairs(initParam) do
            listInitParam[k] = v
        end
        listView:InitListView(listDataLength, function(listView, listIndex)
            if listIndex < 0 then return nil end
            local luaIndex = listIndex + 1
            return callback(listView, luaIndex)
        end, listInitParam)

        self.RewardsGoodsList.ScrollRect.onValueChanged:AddListener(Bind(self, self.OnRewardsGoodsListScrollChangedHandler_))
        self.rewardListCTrans_ = self.RewardsGoodsList.ContainerTrans
        self.rewardListVPortW_ = self.RewardsGoodsList.ViewPortWidth

    else
        GameUtils.ReloadData(self.RewardsGoodsList, listDataLength)
    end
end


--- 刷新 提醒奖励列表
function UIBattlePassContractManualDialog:UpdateRemindList_()
    -- kill oldTween
    DOTween.Kill(RemindListTweenId)

    -- reload list
    local listDataLength = #self:GetRemindDataList()
    GameUtils.ReloadData(self.RewardsRemindList, listDataLength)
    
    -- auto turn tween
    if listDataLength > 0 then
        self.remindListTween_ = DOTween.Sequence()
        for listIndex = 1, listDataLength - 1 do
            self.remindListTween_:AppendInterval(0.5)
            self.remindListTween_:Append(self.remindListCTrans_:DOAnchorPosX(-self.remindListItemW_ * listIndex, 1))
        end
        self.remindListTween_:AppendInterval(0.2) -- 等待最后一个停稳，再重置到起始点，防止瞬间回去的抖动感
        self.remindListTween_:Append(self.remindListCTrans_:DOAnchorPosX(0, 0))
        self.remindListTween_:AppendCallback(function()
            self.RewardsRemindList:MovePanelToItemIndex(0)
        end)
        self.remindListTween_:SetLoops(-1)
        self.remindListTween_.stringId = RemindListTweenId
    end
end


--- 刷新 悬停奖励信息
function UIBattlePassContractManualDialog:UpdateStageRewards_()
    local stageDrawIndex  = self:GetStageDrawIndex()
    local drawRewardsData = checkTable(self:GetRewardsDataList()[stageDrawIndex])
    if stageDrawIndex == 0 then return end
    self.rewardsStageNodeEnv_:SetLuaIndex(stageDrawIndex)
    self.rewardsStageNodeEnv_:SetCellData(drawRewardsData)
    self.rewardsStageNodeEnv_:SetClickDrawCB(Bind(self, self.OnClickRewardCellDrawButtonCallback_))
end


--- 检测 悬停奖励位置
---@param scrollOffsetX number
function UIBattlePassContractManualDialog:CheckStageDrawIndex_(scrollOffsetX)
    if self.rewardListTotalW_ <= 0 then return end

    local firstRewardIndex = math.floor(-scrollOffsetX / self.rewardListItemW_) + 1
    CfUtils.SetActive(self.RewardsToLeftBtn, self.canDrawIndexMin_ > 0 and firstRewardIndex > self.canDrawIndexMin_)

    -- 是否滚动出奖励区域
    local scrollLimitX = self.rewardListVPortW_ - self.rewardListTotalW_
    if scrollOffsetX < scrollLimitX then
        CfUtils.SetActive(self.RewardsStageNode, false)
        CfUtils.SetActive(self.RewardsToRightBtn, false)

    else
        CfUtils.SetActive(self.RewardsStageNode, true)

        local lastRewardIndex = math.ceil((self.rewardListVPortW_ + -scrollOffsetX) / self.rewardListItemW_)
        local drawRewardsData = checkTable(self:GetRewardsDataList()[lastRewardIndex])
        local stageDrawIndex  = checkInt(drawRewardsData.stageDrawIndex)
        if stageDrawIndex > 0 and self:GetStageDrawIndex() ~= stageDrawIndex then
            self:SetStageDrawIndex(stageDrawIndex)
        end

        CfUtils.SetActive(self.RewardsToRightBtn, lastRewardIndex - 1 < self.canDrawIndexMax_)
    end
end


-- 检测 最左边和最右边的可领取奖励位置
function UIBattlePassContractManualDialog:CheckCanDrawIndex_()
    self.canDrawIndexMin_ = 0
    self.canDrawIndexMax_ = 0
    for drawIndex = 1, self.passCardLevelMax_ do
        if passCardComp:HasCanDrawRewardsAt(drawIndex) then
            if self.canDrawIndexMin_ == 0 then
                self.canDrawIndexMin_ = drawIndex
            end
            self.canDrawIndexMax_ = math.max(self.canDrawIndexMax_, drawIndex)
        end
    end
    self:OnRewardsGoodsListScrollChangedHandler_()
end


--- 刷新 领取全部按钮红点
function UIBattlePassContractManualDialog:UpdateDrawAllRewardsRed_()
    local hasCanDrawRewards = passCardComp:HasCanDrawRewards()
    local hasCanCircleTimes = passCardComp:GetHomeDojo().canDrawCircleTimes > 0
    CfUtils.SetActive(self.RewardsDrawAllRed, hasCanDrawRewards or hasCanCircleTimes)
end


function UIBattlePassContractManualDialog:UpdateRedPoint_()
    passCardComp:CheckPassRewardsRedPoint()
end


-------------------------------------------------
-- handler

--- Pass卡经验发生变化
function UIBattlePassContractManualDialog:OnPassExpChangeEventHandler_()
    self:UpdateDrawAllRewardsRed_()
    self:UpdatePassLevelInfo_()
    self:UpdateRewardList_()
    self:UpdateRedPoint_()
    self:CheckCanDrawIndex_()
end


--- Pass卡循环宝箱次数变化
function UIBattlePassContractManualDialog:OnPassLoopTimesEventHandler_()
    self:UpdatePassLevelInfo_()
    self:UpdateRedPoint_()
end


--- Pass卡类型发生变化
function UIBattlePassContractManualDialog:OnPassTypeChangeEventHandler_()
    self:UpdateDrawAllRewardsRed_()
    self:UpdatePassTypeState_()
    self:UpdateRewardList_()
    self:UpdateRedPoint_()
    self:CheckCanDrawIndex_()
    self:UpdateStageRewards_()
end


--- 奖励列表滚动变化
function UIBattlePassContractManualDialog:OnRewardsGoodsListScrollChangedHandler_()
    if self.coDisableScrollCheck_ then return end
    if not self.rewardListCTrans_ then return end
    self:CheckStageDrawIndex_(self.rewardListCTrans_.anchoredPosition3D.x)
end


--- 提示奖励列表刷新
---@param listView SuperScrollView.LoopListView2
---@param luaIndex integer
---@return SuperScrollView.LoopListViewItem2
function UIBattlePassContractManualDialog:OnUpdateRemindListCellHandler_(listView, luaIndex)
    local cellNode  = listView:NewListViewItem(RemindListCellName)
    local cellData  = self:GetRemindDataList()[luaIndex]
    local goodsId   = checkInt(cellData.goodsId)
    local goodsVo   = checkTable(cellData.goodsVo)
    local goodsType = GoodsUtils.GetIdType(goodsId)

    -- update cell
    local goodsIconImg = cellNode.transform:Find('ImgGoodsIcon')
    local cardHeadNode = cellNode.transform:Find('Head')
    local cardHeadIcon = cellNode.transform:Find('Head/ImgHead')

    if goodsType == Constants.IDType.CharacterCard then
        CfUtils.SetActive(goodsIconImg, false)
        CfUtils.SetActive(cardHeadNode, true)
        local cardVo = CardConfMgr:GetInstance():GetCardByRefId(goodsId)
        local skinVo = CardConfMgr:GetInstance():GetCardSkinBySkinId(cardVo.defaultSkin)
        CfUtils.FillImage(cardHeadIcon, skinVo.buffHead)
    else
        CfUtils.SetActive(goodsIconImg, true)
        CfUtils.SetActive(cardHeadNode, false)
        CfUtils.FillImage(goodsIconImg, goodsVo and goodsVo.photoPath or '')
    end
    return cellNode
end


--- 领取奖励列表刷新
---@param listView SuperScrollView.LoopListView2
---@param luaIndex integer
---@return SuperScrollView.LoopListViewItem2
function UIBattlePassContractManualDialog:OnUpdateRewardsListCellHandler_(listView, luaIndex)
    local cellData = self:GetRewardsDataList()[luaIndex]
    local isChest  = cellData.isChest == true
    local cellNode = listView:NewListViewItem(isChest and RewardListCellName2 or RewardListCellName1)
    ---@type UIBattlePassContractManualNode | UIBattlePassContractManualFinalNode
    local cellEnv = CfUtils.GetLuaScr(cellNode, isChest and RewardListCellPath2 or RewardListCellPath1)
    if isNotNull(cellEnv) then
        -- init cell
        cellEnv:SetLuaIndex(luaIndex)
        cellEnv:SetCellData(cellData)
        if isChest then
            cellEnv:SetClickDrawCB(Bind(self, self.OnClickChestCellDrawButtonCallback_))
        else
            cellEnv:SetClickDrawCB(Bind(self, self.OnClickRewardCellDrawButtonCallback_))
        end
    end
    return cellNode
end


--- 领取 指定位置的 Pass卡奖励
---@param luaIndex integer
---@param drawId integer
function UIBattlePassContractManualDialog:OnClickRewardCellDrawButtonCallback_(luaIndex, drawId)
    local cellData = self:GetRewardsDataList()[luaIndex]
    self:DoDrawPassCardLevelRewards_({drawId}, function()
        self.RewardsGoodsList:RefreshItemByItemIndex(luaIndex - 1)
        if self:GetStageDrawIndex() == luaIndex then
            self:UpdateStageRewards_()
        end
        self:CheckCanDrawIndex_()
    end)
end


--- 领取 全部的Pass卡奖励 + 循环宝箱奖励
function UIBattlePassContractManualDialog:OnClickRewardsDrawAllButtonHandler_()
    local hasCanDrawRewards = passCardComp:HasCanDrawRewards()
    local hasCanCircleTimes = passCardComp:GetHomeDojo().canDrawCircleTimes > 0
    if hasCanDrawRewards == false and hasCanCircleTimes == false then
        GameUtils.Toast(localize('没有可领取的奖励'))
        return
    end
    
    local drawIdList = passCardComp:GetAllCanDrawIdList()
    self:DoDrawPassCardLevelRewards_(drawIdList, function()
        self:UpdateRewardList_()
        self:CheckCanDrawIndex_()
        self:UpdateStageRewards_()
    end)
end


---@param drawIdList integer[]
---@param drawnCb fun():void
function UIBattlePassContractManualDialog:DoDrawPassCardLevelRewards_(drawIdList, drawnCb)
    --- 奖励ID，传0表示一键领取全部
    local requestData = {rewardId = #drawIdList > 1 and 0 or drawIdList[1]}
    GameUtils.Request(Interfaces.OverseaPassCardDrawLevelRewards, requestData, function(request, response)
        if checkInt(response.errCode) == 0 then
            local responseData = checkTable(response.data)

            -- draw rewards
            local rewardList = checkTable(responseData.rewards)
            GoodsUtils.DrawRewards(rewardList)
            CfUtils.DialogOpen(Constants.UITypeIds.UICommonRewardPop, {rewards = rewardList})

            -- save drawId
            for _, drawId in ipairs(drawIdList) do
                passCardComp:GetHomeDojo():SaveDrawnRewardsId(drawId)
            end

            -- check circleTimes
            if passCardComp:GetHomeDojo().canDrawCircleTimes > 0 then
                -- 能换几个一次性全兑换了
                local canDrawCount  = passCardComp:GetHomeDojo().canDrawCircleTimes
                local oldDrawnTimes = passCardComp:GetHomeDojo().drawnCircleTimes
                passCardComp:UpdateDrawnCircleTimes(oldDrawnTimes + canDrawCount)
            end

            -- update redPoint
            self:UpdateDrawAllRewardsRed_()
            self:UpdateRedPoint_()

            -- do callback
            if drawnCb then
                drawnCb()
            end
        end
    end)
end


--- 领取 循环宝箱奖励
function UIBattlePassContractManualDialog:OnClickChestCellDrawButtonCallback_()
    if passCardComp:GetHomeDojo().canDrawCircleTimes <= 0 then
        GameUtils.Toast(localize('奖励领取次数不足'))
        return
    end

    GameUtils.Request(Interfaces.OverseaPassCardDrawCircleRewards, {}, function(request, response)
        if checkInt(response.errCode) == 0 then
            local responseData = checkTable(response.data)

            -- draw rewards
            local rewardList = checkTable(responseData.rewards)
            GoodsUtils.DrawRewards(rewardList)
            CfUtils.DialogOpen(Constants.UITypeIds.UICommonRewardPop, {rewards = rewardList})

            -- 能换几个一次性全兑换了
            local canDrawCount  = passCardComp:GetHomeDojo().canDrawCircleTimes
            local oldDrawnTimes = passCardComp:GetHomeDojo().drawnCircleTimes
            passCardComp:UpdateDrawnCircleTimes(oldDrawnTimes + canDrawCount)

            -- update redPoint
            self:UpdateDrawAllRewardsRed_()
            self:UpdateRedPoint_()
        end
    end)
end


--- 购买Pass卡类型
function UIBattlePassContractManualDialog:OnClickBuyPassButtonHandler_()
    xRecord.record('3-017')
    Events.Broadcast(PassCardUtils.EventName.PASS_CARD_BUY_DIALOG, true)
end


--- 购买Pass卡等级
function UIBattlePassContractManualDialog:OnClickPassLevelBuyButtonHandler_()
    if passCardComp:IsPassLevelMax() then
        GameUtils.Toast(localize('等级已到达巅峰'))
        return
    end

    CfUtils.DialogOpen(Constants.UITypeIds.UIBattlePassBuyRatingDialog)
end


function UIBattlePassContractManualDialog:RefreshLive3DBtn_( skinID_ )
    local skinId = skinID_
    local btnTF = self.LobbyInteractiveGroup
    --local btnGray = btnTF:Find("ImgIcon")
    -- 目前没设置灰色

    if isNotNull(IdolLive3D_Utils.GetLive3DCardVoRow(skinId)) then -- 这个皮肤支持 深度互动
        --if IdolLive3D_Utils.IsBuyThisSkinsLive3D(skinId) == false then -- 没额外购买这个皮肤的 深度互动服务
            -- 置灰
        --end
        KTool.SetActive( btnTF.gameObject, true )
    else 
        KTool.SetActive( btnTF.gameObject, false )
    end 
end


--- 看板形象深度互动
function UIBattlePassContractManualDialog:OnClickLobbyInteractiveHandler_()
    local lobbyCardId = passCardComp:GetPassLobbyCardId()
    if lobbyCardId == 0 then
        return
    end

    local lobbyCardVo = CardConfMgr:GetInstance():GetCardByRefId(lobbyCardId)
    if not lobbyCardVo then
        return
    end

    local skinId = checkInt(lobbyCardVo.defaultSkin)
    IdolLive3D_Loader.TryOpenScene( skinId )            -- !! 目前(2024/08/08) 这个按钮似乎无法进入深度互动,  设计如此
end


return UIBattlePassContractManualDialog
