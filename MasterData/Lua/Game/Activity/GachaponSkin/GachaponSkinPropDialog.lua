local ResourceModule = CS.Engine.Modules.ResourceModule
local cs_coroutine = import('XLua.cs_coroutine')
local Yielders = CS.Engine.Lib.Yielders
---@type ActivityMgr
local ActivityMgr = import('Game.Activity.ActivityMgr'):GetInstance()
---@type ActivityGachaponSkinMgr
local Mgr = import('Game.Activity.GachaponSkin.ActivityGachaponSkinMgr'):GetInstance()

local UIModule = CS.Engine.UI.UIModule

--- from: Assets/BundleResources/Prefabs/GachaponSkin/GachaponSkinPropDialog.prefab > name: GachaponSkinPropDialog
---@class GachaponSkinPropDialog
---@field Env                           	GachaponSkinPropDialog                  
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field TxtInstructions               	UnityEngine.UI.Text                     	@ 0    
---@field BtnTipsGroup                  	UnityEngine.RectTransform               	@ 1    
---@field BtnTenNode                    	UnityEngine.RectTransform               	@ 2    
---@field BtnTen_Image                  	UnityEngine.UI.Image                    	@ 3    
---@field BtnTen_Text2                  	TMPro.TextMeshProUGUI                   	@ 4    
---@field BtnOneNode                    	UnityEngine.RectTransform               	@ 5    
---@field BtnOne_Image                  	UnityEngine.UI.Image                    	@ 6    
---@field BtnOne_Text2                  	TMPro.TextMeshProUGUI                   	@ 7    
---@field ProgressFill                  	UnityEngine.UI.Slider                   	@ 8    
---@field GachaponSkinPropRewardNode1   	Engine.Modules.LuaOutlet                	@ 9    
---@field GachaponSkinPropRewardNode2   	Engine.Modules.LuaOutlet                	@ 10   
---@field GachaponSkinPropRewardNode3   	Engine.Modules.LuaOutlet                	@ 11   
---@field GachaponSkinPropRewardNode4   	UnityEngine.RectTransform               	@ 12   
---@field GachaponSkinPropRewardNode5   	Engine.Modules.LuaOutlet                	@ 13   
---@field ProgressNum                   	TMPro.TextMeshProUGUI                   	@ 14   
---@field DurationTime                  	UnityEngine.UI.Text                     	@ 15   
---@field BtnShop                       	UnityEngine.RectTransform               	@ 16   
---@field ImgShop                       	UnityEngine.UI.RawImage                 	@ 17   
---@field ShopLastTime                  	UnityEngine.UI.Text                     	@ 18   
---@field BtnInteractive                	UnityEngine.RectTransform               	@ 19   
---@field BtnTask                       	UnityEngine.RectTransform               	@ 20   
---@field BtnGiftbag                    	UnityEngine.RectTransform               	@ 21   
local GachaponSkinPropDialog = Class("GachaponSkinPropDialog")

function GachaponSkinPropDialog:__init()
    self.controller = nil
end

function GachaponSkinPropDialog:__delete()
    self.controller = nil
    for k,v in pairs(self.EventMap) do
        Events.RemoveListener(k, v)
    end
    GameUtils.RemoveRedPointCallBack(Constants.RedPointConst.OverseaEntryWelfare)
end

function GachaponSkinPropDialog:OnDestroy()
    self:Delete()
end

function GachaponSkinPropDialog:Awake()
    SetButtonAction(self.BtnOneNode, function() self:OnBtnGachaClick(1)  end)
    SetButtonAction(self.BtnTenNode, function() self:OnBtnGachaClick(2)  end)
    SetButtonAction(self.BtnShop, Bind(self, self.OnBtnShopClick))
    SetButtonAction(self.BtnInteractive,Bind(self, self.OnBtnInteractiveClick))
    SetButtonAction(self.BtnTask,Bind(self, self.OnBtnTaskClick))
    SetButtonAction(self.BtnGiftbag,Bind(self, self.OnBtnGiftbagClick))
    
    ---功能不上  暂时隐藏
    CfUtils.SetActive(self.BtnInteractive.gameObject, false)
    CfUtils.SetActive(self.BtnGiftbag.gameObject, false)
    
    SetButtonAction(self.BtnTipsGroup,Bind(self, self.OnBtnTipsGroupClick))

    ---@type GachaponSkinPropTaskDialog
    local taskDialog = import("Game.Activity.GachaponSkin.GachaponSkinPropTaskDialog")
    self.EventMap = {}
    self.EventMap[taskDialog.CloseEvent] = Events.AddListener(taskDialog.CloseEvent, Bind(self,self.OnTaskDialogClose))

    GameUtils.BindRedPoint(Constants.RedPointConst.MainCardSkinCardTask,self.BtnTask.gameObject, true)
end

function GachaponSkinPropDialog:OnInitialize() --LuaBehaviour 没有
end


function GachaponSkinPropDialog:RefreshData(data)
    ---@type ActivityCardSkinDojo
    self.activity = data
    self.skinPropVo = nil
    CfUtils.SetActive(self.controller.gameObject, false)
    Mgr.Sever:RequestSkinLotteryDetail(data.id,function()
        CfUtils.SetActive(self.controller.gameObject,true)
        self:RefreshUI()
    end)
end

function GachaponSkinPropDialog:RefreshUI()
    self.detail = Mgr.Sever.lotteryData.lotteryDetail
    self:RefreshExtraRewards()
    self:RefreshGacha()
    self:RefreshShop()

    if self.detail.taskRedDotHint >= 0 then
        GameUtils.SetRedPointNum(Constants.RedPointConst.MainCardSkinCardTask, 1)
    else
        GameUtils.SetRedPointNum(Constants.RedPointConst.MainCardSkinCardTask, 0)
    end
    
    
    local skinPropRow = self:GetSkinPropRow()
    if skinPropRow then
        CfUtils.FillText(self.TxtInstructions, parse_localizeText(skinPropRow, "poolDes", true, ""))
    end
    --进度条测试
    --self.detail.calledTimes = 0
    --cs_coroutine.start(function()
    --    while self.detail.calledTimes < 130 do
    --        cs_coroutine.yield_return(Yielders.GetWaitForSeconds(0.3))
    --        self.detail.calledTimes = self.detail.calledTimes + 1
    --        self:RefreshExtraRewards()
    --    end
    --    
    --end)
end

function GachaponSkinPropDialog:RefreshExtraRewards()
    
    ---@type LotteryExtraReward[]
    local extraRewards = self.detail.extraRewards
    local extraRewardsCount = #extraRewards
    local extraRewardsNode = {self.GachaponSkinPropRewardNode1, self.GachaponSkinPropRewardNode2, self.GachaponSkinPropRewardNode3, self.GachaponSkinPropRewardNode4, self.GachaponSkinPropRewardNode5}
    for i = 1, 5 do
        local node = extraRewardsNode[i]
        if i <= extraRewardsCount then
            local reward = extraRewards[i]
            ---@type GachaponSkinProgressNode
            local nodeEnv = CfUtils.GetLuaScr(node,'Game.Activity.GachaponSkin.GachaponSkinProgressNode')
            nodeEnv:RefreshData(reward,i,self)
            nodeEnv:SetClickNodeCB(Bind(self, self.OnClickExtraCall))
        else
            CfUtils.SetActive(node.gameObject, false)
        end
    end
    
    local pregresses = {0.09,0.31,0.54,0.77,1}
    local totalRequiredDrawCount = extraRewards[extraRewardsCount].num
    self.ProgressFill.value = self.detail.calledTimes/totalRequiredDrawCount
    self.ProgressNum.text = math.min(totalRequiredDrawCount,self.detail.calledTimes)
    if self.detail.calledTimes >= totalRequiredDrawCount then
        self.ProgressFill.value = 1
    else
        for i = extraRewardsCount -1 ,1,-1 do   --从倒数第二个找,避免最后一个超出
            if self.detail.calledTimes >= extraRewards[i].num then
                self.ProgressFill.value = pregresses[i] + (self.detail.calledTimes - extraRewards[i].num)/(extraRewards[i+1].num - extraRewards[i].num) * (pregresses[i+1] - pregresses[i])
                break
            end
        end
    end
    
    local ActivityUtils         = import("Game.Activity.ActivityUtils")
    CfUtils.FillText(self.DurationTime, ActivityUtils.ConventActivityDurationTime(self.activity.startTime, self.activity.closeTime))
end

function GachaponSkinPropDialog:RefreshGacha()
    local detail = Mgr.Sever.lotteryData.lotteryDetail
    --local pathS = GoodsConfMgr:GetPhotoPathSpecialById(detail.consume.oneConsume.goodsId)
    --local path = GoodsConfMgr:GetPhotoPathById(detail.consume.oneConsume.goodsId)
    CfUtils.FillImage(self.BtnOne_Image.gameObject,GoodsConfMgr:GetPhotoPathSpecialById(detail.consume.oneConsume.goodsId))
    CfUtils.FillImage(self.BtnTen_Image.gameObject,GoodsConfMgr:GetPhotoPathSpecialById(detail.consume.tenConsume.goodsId))
    
    local isEnough = self:ConsumeEnough(1)
    CfUtils.SetUISwitchText(self.BtnOne_Text2, isEnough and 1 or 3)
    self.BtnOne_Text2.text = detail.consume.oneConsume.num
    
    isEnough = self:ConsumeEnough(2)
    CfUtils.SetUISwitchText(self.BtnTen_Text2, isEnough and 1 or 3)
    self.BtnTen_Text2.text = detail.consume.tenConsume.num
    
end

function GachaponSkinPropDialog:RefreshShop()
    CfUtils.FillImage(self.ImgShop.gameObject,CfUtils.GetImageFullPath(self.activity.mallIcon))
    local closeTime = self:UntilCloseTime()
    CfUtils.FillText(self.ShopLastTime, CfUtils.GetTimeHMS(closeTime))
end

function GachaponSkinPropDialog:OnBtnGachaClick(type)
    local function LotteryCall()
        Mgr.Sever:RequestSkinLotteryCall(self.activity.id, type, function(rewards)
            ---@type GachaponSkinPropResultDialog.Data
            local data ={
                isBlack = true,
                gachaType = type,
                rewards = rewards
            }
            self:ShowGachaResultDialog(data)
            self:CheckRootRedPointChange()
            self:RefreshExtraRewards()
            self:RefreshGacha()
            Events.Broadcast(Constants.EventNames.ActivityCardSkinChangeEvent)
        end)
    end
    
    if self:ConsumeEnough(type) then
        LotteryCall()
    else
        local detail = Mgr.Sever.lotteryData.lotteryDetail
        local consume = type == 1 and detail.consume.oneConsume or detail.consume.tenConsume
        local vo = GoodsConfMgr:GetInstance():GetGoodsVoById(consume.goodsId)
        local ownNum = GoodsUtils.GetThingNo(consume.goodsId)
        if #checkTable(vo.jumpAway) > 0 then
            GoodsUtils.CheckConsumeDataCondition({{goodsId = vo.id, num = consume.num, gainNum = consume.num - ownNum}})
        else
            GameUtils.Toast(localize("_name_不足", {_name_ = vo.name}))
        end
        
        ----关闭猫眼石兑换
        --local detail = Mgr.Sever.lotteryData.lotteryDetail
        --local consume = type == 1 and detail.consume.oneConsume or detail.consume.tenConsume
        --local itemId, itemNum = ActivityMgr:GetGoodsPrice(consume.goodsId)
        --local youHave = GoodsUtils.GetThingNo(consume.goodsId)
        --local needNum = consume.num - youHave
        --local itemCount = itemNum * needNum
        --
        -----@type GachaponConstants
        --local GachaponConstants = import('Game.Gachapon.GachaponConstants')
        --CfUtils.DialogOpen(Constants.UITypeIds.GachaponConfirm, {
        --    type = GachaponConstants.ConfirmType.CARD_SKIN,
        --    poolType = GachaponConstants.PoolType.Regular,
        --    onConfirm = function()
        --        LotteryCall()
        --    end,
        --    leftParam = {
        --        goodsId = itemId,
        --        num = itemCount
        --    },
        --    rightParam = {
        --        goodsId = consume.goodsId,
        --        num = needNum
        --    }
        --})
    end
end

function GachaponSkinPropDialog:OnBtnShopClick()
    ---@type ActivityUtils
    local ActivityUtils = import("Game.Activity.ActivityUtils")
    local isActivityClose = ActivityUtils.IsActivityClosed(self.activity)
    if not isActivityClose then
        GameUtils.Toast(localize("活动已结束"))
        return
    end
    local consumeId = self.activity.consumeId
    local t = {}
    local exchangeId,_ = ActivityMgr:GetGoodsPrice(consumeId)
    if checkInt(exchangeId) > 0 then
        table.insert(t, exchangeId)
    end
    table.insert(t, consumeId)
    ---@type StoreGeneralVo
    local storeVo = CfUtils.GetCfVo(AutoIds.IdSetting601, "StoreGeneralVo", Constants.ShopIds.GachponSkinProp)
    local skinPropRow = self:GetSkinPropRow()
    local mallImage = ""
    if skinPropRow then
        mallImage = parse_string(skinPropRow, "shopBg")
    end
    local excludeIds = {}
    local dialogs = UIModule.CurrentScreen.dialogs
    local count = table.count(dialogs)
    table.insert(excludeIds, {id = dialogs[count -1 ].Argument.id})
    CfUtils.DialogOpen(Constants.UITypeIds.UIActivitySkinShopDialog, {activityUuid = self.activity.id , activityType = self.activity.type,topGoods = checkTable(storeVo.token),mallBgImage = mallImage},excludeIds,true)
end

---@param index number
function GachaponSkinPropDialog:OnClickExtraCall(index)
    ---@type ActivityUtils
    local ActivityUtils = import("Game.Activity.ActivityUtils")
    local isActivityClose = ActivityUtils.IsActivityClosed(self.activity)
    if not isActivityClose then
        GameUtils.Toast(localize("活动已结束"))
        return
    end
    local extraReward = self.detail.extraRewards[index]
    Mgr.Sever:RequestActivitySkinLotteryReceiveExtraRewards(self.activity.id, extraReward.rewardId, function(rewards)
        
        local oldExtraReward = nil
        if index == #self.detail.extraRewards then
            oldExtraReward = self.detail.extraRewards[index]
            oldExtraReward.rewardGroupIndex = 0
        else
            oldExtraReward = Mgr.Sever.lotteryData.lotteryDetail.extraRewards[index]
        end
        
        self.detail = Mgr.Sever.lotteryData.lotteryDetail
        ---@type GachaponSkinPropResultDialog.Data
        local data = {
            isBlack = false,
            extraReward = oldExtraReward,
            rewards = rewards
        }

        self:ShowGachaResultDialog(data)
        self:RefreshExtraRewards()
        self:CheckRootRedPointChange()
    end)
end

function GachaponSkinPropDialog:OnBtnTipsGroupClick()
    CfUtils.DialogOpen(Constants.UITypeIds.ActivityGachaponPropRuleDialog, {activityUuid = self.activity.id})
end

function GachaponSkinPropDialog:OnBtnInteractiveClick()
end

function GachaponSkinPropDialog:OnBtnTaskClick()
    ---@type ActivityUtils
    local ActivityUtils = import("Game.Activity.ActivityUtils")
    local isActivityClose = ActivityUtils.IsActivityClosed(self.activity)
    if not isActivityClose then
        GameUtils.Toast(localize("活动已结束"))
        return
    end
    CfUtils.DialogOpen(Constants.UITypeIds.ActivityGachaponSkinTaskDialog, {activityUuid = self.activity.id , type = self.activity.type})
end

function GachaponSkinPropDialog:OnBtnGiftbagClick()
end

---@private
function GachaponSkinPropDialog:GetSkinPropRow()
    if self.skinPropVo then
        return self.skinPropVo
    end

    self.skinPropVo = CfUtils.GetCfLine(AutoIds.IdSetting6180, self.activity.activityContentId or 1)
    return self.skinPropVo
end

---@private
function GachaponSkinPropDialog:CheckGachaResultDialog()
    if self.propResult == nil then
        ResourceModule.LoadGameObjectSync("Prefabs/GachaponSkin/GachaponSkinPropResultDialog.prefab",function(go)
            if go then
                ---@type GachaponSkinPropResultDialog
                self.propResult = CfUtils.GetLuaScr(go,"Game.Activity.GachaponSkin.GachaponSkinPropResultDialog")
            end
        end,true,self.controller.transform)
    end
end

function GachaponSkinPropDialog:ShowGachaResultDialog(data)
    self:CheckGachaResultDialog()
    self.propResult:Show(data)
end


---@private
---@param type number @1单抽 2十连
function GachaponSkinPropDialog:ConsumeEnough(type)
    local detail = Mgr.Sever.lotteryData.lotteryDetail
    local consume = type == 1 and detail.consume.oneConsume or detail.consume.tenConsume
    local ownNum = GoodsUtils.GetThingNo(consume.goodsId)
    return ownNum >= consume.num
end

---@private
function GachaponSkinPropDialog:UntilEndTime()
    local curTime = os.time()
    local endTime = self.activity.endTime
    return endTime - curTime
end

---@private
function GachaponSkinPropDialog:UntilCloseTime()
    local curTime = os.time()
    local closeTime = self.activity.closeTime
    return closeTime - curTime
end

--{{{ redPoint

function GachaponSkinPropDialog:OnTaskDialogClose(data)
    if checkInt(data.activityUuid) ~= checkInt(self.activity.id) then
        return
    end
    local redNum = data.redNum
    local detail = Mgr.Sever.lotteryData.lotteryDetail
    GameUtils.SetRedPointNum(Constants.RedPointConst.MainCardSkinCardTask, redNum)
    if redNum <= 0 then
        self.detail.taskRedDotHint = -1
    else
        self.detail.taskRedDotHint = 0
    end
    self:CheckRootRedPointChange()
    self:RefreshUI()
end

function GachaponSkinPropDialog:CheckHasRedPoint()
    local hasRedPoint = false
    local detail = Mgr.Sever.lotteryData.lotteryDetail

    if detail.taskRedDotHint == 0 then
        hasRedPoint = true
        return hasRedPoint
    end

    for i = 1, #detail.extraRewards do
        local extraReward = detail.extraRewards[i]
        if extraReward.status == Constants.GetStatus.Can then
            hasRedPoint = true
            return hasRedPoint
        end
    end
    
    return hasRedPoint
end

function GachaponSkinPropDialog:CheckRootRedPointChange()--红点改变时通知外部
    local hasRedPoint = self:CheckHasRedPoint()
    ---@type ActivityCardSkinComponent
    local ActivityCardSkinComponent =  GameUtils.GetEntityCompByType(ECSComponentType.Constants.ActivityCardSkinComponent)
    local activityData = ActivityCardSkinComponent:GetActivityDataById(self.activity.id)
    if hasRedPoint and activityData.redDotHint == -1 then
        activityData.redDotHint = 0
        Events.Broadcast(Constants.EventNames.ActivityCardSkinChangeEvent)
        return
    end

    if (not hasRedPoint) and activityData.redDotHint == 0 then
        activityData.redDotHint = -1
        Events.Broadcast(Constants.EventNames.ActivityCardSkinChangeEvent)
        return
    end
end
--}}}

return GachaponSkinPropDialog