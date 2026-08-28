

--- lua:
local CoWait = CS.Engine.Lib.CoWait
local util = require 'XLua.util'
local cs_coroutine = require 'XLua.cs_coroutine' -- 协程
local Yielders = CS.Engine.Lib.Yielders -- 协程
local UIModule = CS.Engine.UI.UIModule
---@type GameUtils
local GameUtils = import('Game.Utils.GameUtils')
local Object = CS.UnityEngine.Object
local GameObject = CS.UnityEngine.GameObject
local Vector2 = CS.UnityEngine.Vector2
local Vector3 = CS.UnityEngine.Vector3
local Mathf = CS.UnityEngine.Mathf
local Random = CS.UnityEngine.Random
local Canvas = CS.UnityEngine.Canvas
local Physics = CS.UnityEngine.Physics
local KTool = CS.Engine.Lib.KTool
local KCookie = CS.Engine.Lib.KCookie
local BehaviourAction = CS.Engine.Lib.BehaviourAction

---@type TimeLimitedMgr
local Mgr = import("Game.Activity.TimeLimitedRecruit.TimeLimitedMgr"):GetInstance()

---@type TimeLimitedRecruitUtil
local TimeLimitedRecruitUtil = import("Game.Activity.TimeLimitedRecruit.TimeLimitedRecruitUtil")

---@type GoodsConfMgr
local goodsConfMgr     = GoodsConfMgr:GetInstance()

---@type ActivityMgr
local ActivityMgr = import('Game.Activity.ActivityMgr'):GetInstance()

local CriWareUtils = import('Game.Entry.CriWareUtilsFix')

--[[
        限时招募玩法 主游戏 前置页面
]]


--- from: Assets/BundleResources/Prefabs/ActivityDK12003501/ActivityDKMainDialog.prefab > name: ActivityDKMainDialog
---@class UIActivityTimeLimitedMainDialog
---@field Env                           	UIActivityTimeLimitedMainDialog         
---@field controller                    	Engine.UI.UILuaDialog                   
---@field BtnDetails                    	UnityEngine.RectTransform               	@ 0    概率详情按钮
---@field TxtTime                       	UnityEngine.RectTransform               	@ 1    
---@field ScheduleGroup                 	UnityEngine.RectTransform               	@ 2    
---@field BtnTenNode                    	UnityEngine.RectTransform               	@ 3    
---@field BtnOneNode                    	UnityEngine.RectTransform               	@ 4    
---@field BtnTipsGroup                  	UnityEngine.RectTransform               	@ 5    
---@field BossDrawingNode               	UnityEngine.RectTransform               	@ 6    皮肤立绘
---@field BtnShop                       	UnityEngine.RectTransform               	@ 7    商店入口
---@field BtnGoodsNode                  	UnityEngine.RectTransform               	@ 8    
---@field GoodNode                      	UnityEngine.RectTransform               	@ 9    
---@field Finish                        	UnityEngine.RectTransform               	@ 10   
---@field redPoint                      	UnityEngine.RectTransform               	@ 11   
---@field BtnGet                        	UnityEngine.RectTransform               	@ 12   
---@field Text                          	UnityEngine.RectTransform               	@ 13   
---@field ImgIcon                       	UnityEngine.RectTransform               	@ 14   
local UIActivityTimeLimitedMainDialog = Class("UIActivityTimeLimitedMainDialog")
---------------------------------------------


---------------------------------------------
function UIActivityTimeLimitedMainDialog:__init()
    self.recruitmentDojo = nil
end


function UIActivityTimeLimitedMainDialog:__delete()
    self.recruitmentDojo = nil
end


function UIActivityTimeLimitedMainDialog:Awake()

    self.ScheduleGroups = 
    {
        ImgIcon = self.ScheduleGroup:Find("ImgIcon"),
        TxtNum = self.ScheduleGroup:Find("TxtSchedule/TxtNum"),
        Slider = self.ScheduleGroup:Find("Slider"),
        BtnCompound = self.ScheduleGroup:Find("BtnCompound"), -- 按钮本身
        BtnOpenNode = self.ScheduleGroup:Find("BtnCompound/Open"),
        BtnCloseNode = self.ScheduleGroup:Find("BtnCompound/Close"),
    }

    self.TxtProbability = self.BtnTipsGroup:Find("TxtProbability")
    self.timeTxtNum = self.TxtTime:Find("TxtNum")

    self.BtnOneNodes = 
    {
        AnimRoot = self.BtnOneNode:Find("AnimRoot"),
        Image = self.BtnOneNode:Find("AnimRoot/Source/BtnConsumePop/Image"),
        Text2 = self.BtnOneNode:Find("AnimRoot/Source/BtnConsumePop/Text2"),
    }

    self.BtnTenNodes = 
    {
        AnimRoot = self.BtnTenNode:Find("AnimRoot"),
        Image = self.BtnTenNode:Find("AnimRoot/Source/BtnConsumePop/Image"),
        Text2 = self.BtnTenNode:Find("AnimRoot/Source/BtnConsumePop/Text2"),
    }

    local isShowShop = TimeLimitedRecruitUtil.GetVoParamValue(TimeLimitedRecruitUtil.VoParamsId.IsShowShop) == 1
    CfUtils.SetActive( self.BtnShop, isShowShop )


    SetButtonAction(self.BtnDetails, Bind(self, self._OnClick_BtnDetails))
    SetButtonAction(self.BtnOneNodes.AnimRoot, Bind(self, self._OnClick_BtnOneNode))
    SetButtonAction(self.BtnTenNodes.AnimRoot, Bind(self, self._OnClick_BtnTenNode))
    SetButtonAction(self.BtnShop, Bind(self, self._OnClick_BtnShop))
    SetButtonAction(self.ScheduleGroups.BtnCompound, Bind(self, self._OnClick_BtnMerge))
    SetButtonAction(self.BtnGoodsNode, Bind(self, self._OnClick_BtnGoodsNode))
    SetButtonAction(self.BtnGet, Bind(self, self._OnClick_BtnGet))
    
    self._canClickBtnMerge = true
end



function UIActivityTimeLimitedMainDialog:OnInitialize()
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        
        local parameters = self.controller.Argument.parameters
        if isSet(parameters,"activityData") then
            Mgr.activityData = parameters.activityData
            Mgr.activityUuid = Mgr.activityData.id
        else
            ---@type ActivityConstants
            local ActivityConstants = import("Game.Activity.ActivityConstants")
            local activityId = ActivityMgr:GetActivityIdByActivityType(ActivityConstants.ActivityType.TimeLimitedRecruit)
            if activityId then
                local activityDojo = ActivityMgr:GetActivityComponent():GetDojoByActivityId(activityId)
                if isNull(activityDojo) then
                    printError("没找到 activityDojo, activityId="..tostring(activityId))
                    return
                end
                Mgr.activityData = activityDojo
                Mgr.activityUuid = Mgr.activityData.id
            end
        end
        
        Mgr:Clear()

        local success = false
        GameUtils.Request("Activity2/recruitment", { activityUuid = Mgr.activityUuid }, function(request, response)
            success = true
            if checkNumber(response.errCode) == 0 then
                self.recruitmentDojo = checkTable(response.data)
                self:_Refresh()
                
            end
        end)

        while not success do
            coroutine.yield()
        end

        
        CriWareUtils.StopAll()
        CriWareUtils.PlayMusic("Audio/bgm_story_activity_12003501", "bgm_story_activity_12003501" )


        Mgr.isIntoMainDialog = true
        
    end))
    return coWait
end


function UIActivityTimeLimitedMainDialog:OnFinalize()
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        Mgr.isIntoMainDialog = false
    end))
    return coWait
end



function UIActivityTimeLimitedMainDialog:OnTipsAction()
    if isNotNull(self.recruitmentDojo) then 
        CfUtils.ShowModuleToast(self.recruitmentDojo.ruleId)
    end 
end


-- =============================================================

function UIActivityTimeLimitedMainDialog:_Refresh()

    local cardId = Mgr:GetCardId()
    local skinId = TimeLimitedRecruitUtil.GetCardVo(cardId).defaultSkin
    local sameCardDustGoodsVO = TimeLimitedRecruitUtil.GetSameCardDustGoodsVO(cardId)
    local timeLimitedRecruitActivityScheduleVO = TimeLimitedRecruitUtil.GetTimeLimitedRecruitActivityScheduleVO( checkInt(Mgr.activityData.activityContentId) )


    --- Time:
    local startTime =  Mgr.activityData.startTime
    local closeTime =  Mgr.activityData.closeTime
    local ActivityUtils         = import("Game.Activity.ActivityUtils")
    CfUtils.FillText(self.timeTxtNum, ActivityUtils.ConventActivityDurationTime(startTime, closeTime))


    -- 立绘
    ---@type DrawingNode
    local env = CfUtils.GetLuaScr(self.BossDrawingNode, "Game.Behaviours.DrawingNode")
    if env then
        env:SetParams(skinId)
        env:ShowSkin()
    end

    -- 中部下方 概率说明:
    CfUtils.FillText( self.TxtProbability, localize("单次招募获得5个或以上的奖励时，可触发免费招募！")  )

    -- 进度条:
    self:_RefreshSchedule()


    -- 两个入口按钮:
    self.consumes = 
    {
        goodsId = timeLimitedRecruitActivityScheduleVO.recruitPropId, -- 本体道具
        goodsName = nil,    -- 待填,    本体道具名字
        hadNum = nil,       -- 待填,    本体道具 玩家持有量
        ---
        multiTimes = TimeLimitedRecruitUtil.GetVoParamValue(TimeLimitedRecruitUtil.VoParamsId.RecruitMultiple), -- 多倍的 倍数
        
        ---
        parentGoodsId = nil,        -- 待填    可兑换成 goodsId 的道具id
        parentGoodsCostNum = nil,   -- 待填    可兑换成 goodsId 的道具 交易数量, (消耗几个才能获得一个 self.consumes.goodsId)
        parentGoodsHadNum = nil,    -- 待填    兑换道具 持有量

        -- 一倍抽卡:
        one = 
        {
            costNum = checkInt(timeLimitedRecruitActivityScheduleVO.recruitPropNum), -- 需要消耗多少本体道具 才能进入
            isEnough = nil,             -- 待填;    本体道具 是否足够
            isParentGoodsEnough = nil,  -- 待填;    兑换道具 (配合残存的本体道具) 是否足够进入  -- isEnough == true 时本值为 nil;
            parentGoodsCostNum = nil,   -- 待填;    兑换道具 需消耗数量                        -- isEnough == true 时本值为 nil;
        },

        -- 多倍抽卡:
        multi = 
        {
            costNum = checkInt(timeLimitedRecruitActivityScheduleVO.recruitPropNum) * checkInt(TimeLimitedRecruitUtil.GetVoParamValue(TimeLimitedRecruitUtil.VoParamsId.RecruitMultiple)),-- 需要消耗多少本体道具 才能进入
            isEnough = nil,             -- 待填;    本体道具 是否足够
            isParentGoodsEnough = nil,  -- 待填;    兑换道具 (配合残存的本体道具) 是否足够进入      -- isEnough == true 时本值为 nil;
            parentGoodsCostNum = nil,   -- 待填;    兑换道具 需消耗数量                           -- isEnough == true 时本值为 nil;
        },    
    }


    self.consumes.goodsName = GoodsConfMgr:GetInstance():GetGoodsNameById(self.consumes.goodsId)
    self.consumes.hadNum = GoodsUtils.GetThingNo(self.consumes.goodsId)

    self.consumes.one.isEnough   = self.consumes.hadNum >= self.consumes.one.costNum
    self.consumes.multi.isEnough = self.consumes.hadNum >= self.consumes.multi.costNum

    local needGoodsId, needGoodsNum = ActivityMgr:GetGoodsPrice(self.consumes.goodsId) -- 活动消耗道具价格表, 看看谁能兑换这个目标道具 
    self.consumes.parentGoodsId = needGoodsId
    self.consumes.parentGoodsCostNum = needGoodsNum

    self.consumes.parentGoodsHadNum = GoodsUtils.GetThingNo(self.consumes.parentGoodsId) -- 玩家持有量


    if self.consumes.one.isEnough == false then 
        self.consumes.one.parentGoodsCostNum   = self.consumes.parentGoodsCostNum * (self.consumes.one.costNum   - self.consumes.hadNum)
        self.consumes.one.isParentGoodsEnough   = self.consumes.parentGoodsHadNum >= self.consumes.one.parentGoodsCostNum
    end 


    if self.consumes.multi.isEnough == false then 
        self.consumes.multi.parentGoodsCostNum = self.consumes.parentGoodsCostNum * (self.consumes.multi.costNum - self.consumes.hadNum)
        self.consumes.multi.isParentGoodsEnough = self.consumes.parentGoodsHadNum >= self.consumes.multi.parentGoodsCostNum
    end 


    -- ================================

    ---@type GoodsVo
    local goodsVo  = goodsConfMgr:GetGoodsVoById(self.consumes.goodsId)
    if isNull(goodsVo) then 
        printError("未在道具表找到 %s", self.consumes.goodsId)   
    else 
        CfUtils.FillImage( self.BtnOneNodes.Image, goodsVo.photoPath )
        CfUtils.FillImage( self.BtnTenNodes.Image, goodsVo.photoPath )
    end 

    CfUtils.FillText( self.BtnOneNodes.Text2, self.consumes.one.costNum )
    CfUtils.FillText( self.BtnTenNodes.Text2, self.consumes.multi.costNum )
    -- 不足时, 数字红色:
    CfUtils.SetUISwitchText( self.BtnOneNodes.Text2, (self.consumes.one.isEnough   or self.consumes.one.isParentGoodsEnough)   and 1 or 3 )
    CfUtils.SetUISwitchText( self.BtnTenNodes.Text2, (self.consumes.multi.isEnough or self.consumes.multi.isParentGoodsEnough) and 1 or 3 )


    --- 界面 顶部 右上角 道具:
    self.topGoods = { 4190007, self.consumes.goodsId } -- 9013001
    if self.topGoods then
        CfUtils.RefreshTopGoods(self.topGoods)
    end

    self:RefreshDailyGoodsShow()
end

function UIActivityTimeLimitedMainDialog:RefreshDailyGoodsShow()
    local goodsVo = GoodsConfMgr:GetInstance():GetGoodsVoById(checkNumber(self.recruitmentDojo.dailyRewardsGoodsId))
    if isNotNull(goodsVo) then
        ---@type GoodNodeMB
        local goodNodeMB = CfUtils.GetLuaScr(self.GoodNode,Constants.UILuaTablePath.GoodNodeMB)
        goodNodeMB:Reload({
            goodsId = self.recruitmentDojo.dailyRewardsGoodsId,
            text = string.format("x%d", self.recruitmentDojo.dailyRewardsGoodsNum),
            isShowNo = true
        })
    end
    
    ---@type GoodsVo
    local goodsVo  = goodsConfMgr:GetGoodsVoById(self.consumes.goodsId)
    if goodsVo then
        CfUtils.FillText(self.Text, localize("获取_name_",{_name_ = goodsVo.name}))
        CfUtils.FillImage(self.ImgIcon,goodsVo.photoPath)
    end
    
    local isFinish = checkNumber(self.recruitmentDojo.hasDrawnDailyRewards) == 1
    CfUtils.SetActive(self.Finish.gameObject,isFinish)
    CfUtils.SetActive(self.redPoint.gameObject,not isFinish)
end


function UIActivityTimeLimitedMainDialog:OnFocus(focus)

    --- 界面 顶部 右上角 道具:
    if focus then 
        if self.topGoods then
            CfUtils.RefreshTopGoods(self.topGoods)
        end
    else 
        local UINavigationBarRoot = CS.UINavigationBarRoot
        ---@type UINavigatorBar
        local navigatorScr = CfUtils.GetLuaScr(UINavigationBarRoot.Instance.gameObject, "Game.Main.UINavigatorBar")
        navigatorScr:SetRightShow(false, self.topGoods)
    end 
end



function UIActivityTimeLimitedMainDialog:_RefreshSchedule()

    local cardId = Mgr:GetCardId()
    local sameCardDustGoodsVO = TimeLimitedRecruitUtil.GetSameCardDustGoodsVO(cardId)


    local goodsId = sameCardDustGoodsVO.id

    local nowNum = GoodsUtils.GetThingNo( goodsId ) -- 背包 道具 实际拥有数
    local totalNum = checkInt(sameCardDustGoodsVO.needNum) -- 需要总数
    local pct = nowNum / totalNum
    local isFull = nowNum >= totalNum
    CfUtils.FillImage(self.ScheduleGroups.ImgIcon, sameCardDustGoodsVO.photoPath)
    CfUtils.FillText( self.ScheduleGroups.TxtNum,  string.format("<color=#00ffff>%d/</color>%d", nowNum , checkInt(sameCardDustGoodsVO.needNum) ) )
    CfUtils.SetSliderPercent( self.ScheduleGroups.Slider, pct )
    ---
    CfUtils.SetActive( self.ScheduleGroups.BtnOpenNode, isFull == true )
    CfUtils.SetActive( self.ScheduleGroups.BtnCloseNode, isFull == false )    
end



function UIActivityTimeLimitedMainDialog:_OnClick_BtnDetails()  

    CfUtils.DialogOpen(
        Constants.UITypeIds.UIActivityTimeLimitedProbabilityPanel, 
        {
            recruitmentDojo = self.recruitmentDojo,
        },
        {}
    )
end


function UIActivityTimeLimitedMainDialog:_OnClick_BtnOneNode()

    if self.consumes.one.isEnough == true then 
        print(string.format("基础道具充足: %d, (持有量:%d)", 
            checkInt(self.consumes.goodsId), checkInt(self.consumes.hadNum) 
        ))
        -- 消耗 基础道具:
        GoodsUtils.ConsumeGoods({
            { goodsId = self.consumes.goodsId, num = self.consumes.one.costNum }
        }, false)

    elseif self.consumes.one.isParentGoodsEnough == true then 
        print(string.format("基础道具不足: %d, (持有量:%d); 但兑换道具充足: %d, (持有量:%d)", 
            checkInt(self.consumes.goodsId),        checkInt(self.consumes.hadNum), 
            checkInt(self.consumes.parentGoodsId),  checkInt(self.consumes.parentGoodsHadNum)
        ))

        local goods = {}
        if self.consumes.hadNum > 0 then 
            table.insert( goods, {goodsId = self.consumes.goodsId, num = self.consumes.hadNum} )
        end 
        table.insert( goods, {goodsId = self.consumes.parentGoodsId, num = self.consumes.one.parentGoodsCostNum} )

        -- 消耗 基础道具 和 兑换道具:
        GoodsUtils.ConsumeGoods(goods, false)
    else 
        print(string.format("基础道具: %d, (持有量:%d); 兑换道具: %d (持有量:%d) 都不足", 
            checkInt(self.consumes.goodsId),        checkInt(self.consumes.hadNum), 
            checkInt(self.consumes.parentGoodsId),  checkInt(self.consumes.parentGoodsHadNum)
        ))
        
        GoodsUtils.CheckConsumeDataCondition({{goodsId = self.consumes.parentGoodsId , num = self.consumes.one.parentGoodsCostNum - self.consumes.parentGoodsHadNum}})
        return
    end 

    ---
    Mgr:InitRoundDatas()
    Mgr.times = 1

    CfUtils.DialogOpen(
        Constants.UITypeIds.UIActivityTimeLimitedMainGameDialog, 
        {
        },
        { { id = Constants.UITypeIds.UIActivityTimeLimitedMainDialog } }
    )
end


function UIActivityTimeLimitedMainDialog:_OnClick_BtnTenNode()

    if self.consumes.multi.isEnough == true then 
        print(string.format("基础道具充足: %d, (持有量:%d)", 
            checkInt(self.consumes.goodsId), checkInt(self.consumes.hadNum) 
        ))
        -- 消耗 基础道具:
        GoodsUtils.ConsumeGoods({
            { goodsId = self.consumes.goodsId, num = self.consumes.multi.costNum }
        }, false)

    elseif self.consumes.multi.isParentGoodsEnough == true then 
        print(string.format("基础道具不足: %d, (持有量:%d); 但兑换道具充足: %d, (持有量:%d)", 
            checkInt(self.consumes.goodsId),        checkInt(self.consumes.hadNum), 
            checkInt(self.consumes.parentGoodsId),  checkInt(self.consumes.parentGoodsHadNum)
        ))

        local goods = {}
        if self.consumes.hadNum > 0 then 
            table.insert( goods, {goodsId = self.consumes.goodsId, num = self.consumes.hadNum} )
        end 
        table.insert( goods, {goodsId = self.consumes.parentGoodsId, num = self.consumes.multi.parentGoodsCostNum} )

        -- 消耗 基础道具 和 兑换道具:
        GoodsUtils.ConsumeGoods(goods, false)
    else 
        print(string.format("基础道具: %d, (持有量:%d); 兑换道具: %d (持有量:%d) 都不足", 
            checkInt(self.consumes.goodsId),        checkInt(self.consumes.hadNum), 
            checkInt(self.consumes.parentGoodsId),  checkInt(self.consumes.parentGoodsHadNum)
        ))
        
        GoodsUtils.CheckConsumeDataCondition({{goodsId = self.consumes.parentGoodsId , num = checkInt(self.consumes.multi.parentGoodsCostNum) - checkInt(self.consumes.parentGoodsHadNum)}})
        return
    end 

    ---
    Mgr:InitRoundDatas()
    Mgr.times = self.consumes.multiTimes
    print("多倍倍数: "..tostring(Mgr.times))

    CfUtils.DialogOpen(
        Constants.UITypeIds.UIActivityTimeLimitedMainGameDialog, 
        {
        },
        { { id = Constants.UITypeIds.UIActivityTimeLimitedMainDialog } }
    )
end





function UIActivityTimeLimitedMainDialog:_OnClick_BtnShop()

    local timeLimitedRecruitActivityScheduleVO = TimeLimitedRecruitUtil.GetTimeLimitedRecruitActivityScheduleVO( checkInt(Mgr.activityData.activityContentId) )

    -- 商店:
    CfUtils.DialogOpen(Constants.UITypeIds.UIActivityCommonShopDialog, {
        activityUuid = Mgr.activityUuid,
        mallBgImage = string.isEmpty(timeLimitedRecruitActivityScheduleVO.mallBgImage) and 'Arts/Textures/UIBg/draw_celebration_shop_bg.png' or CfUtils.GetImageFullPath(timeLimitedRecruitActivityScheduleVO.mallBgImage),
        topGoods = { Mgr.activityData.currency }
    }, {
        UIArgs(Constants.UITypeIds.UIActivityTimeLimitedMainDialog)
    })
end


-- 集齐粉尘合成卡牌
function UIActivityTimeLimitedMainDialog:_OnClick_BtnMerge()
    -- 赠送卡牌:
    local cardId = Mgr:GetCardId()
    local sameCardDustGoodsVO = TimeLimitedRecruitUtil.GetSameCardDustGoodsVO(cardId)
    -- 消耗道具:
    local goodsId = sameCardDustGoodsVO.id -- 77道具
    local nowNum = GoodsUtils.GetThingNo( goodsId ) -- 背包 道具 实际拥有数
    local needNum = checkInt(sameCardDustGoodsVO.needNum) -- 需要总数
    if nowNum < needNum then 
        print("道具数量不足; 分子:"..tostring(nowNum) .. ", 分母:"..tostring(needNum))
        return
    end

    if self._canClickBtnMerge == false then 
        print("重复按 btnMerge 无效")
        return
    end 
    self._canClickBtnMerge = false


    -- 77同卡粉尘道具表
    GameUtils.Request(Interfaces.BackpackCardDustComposite, { id = goodsId, num = 1 }, function(request, response)
        
        if checkNumber(response.errCode) == 0 then
        
            local responseData = checkTable(response.data)
            local rewards = responseData.rewards

            -- 扣除道具:
            -- 消耗 基础道具:
            GoodsUtils.ConsumeGoods({
                { goodsId = goodsId, num = needNum }
            }, false)

            
            GoodsUtils.DrawRewards(rewards, true)
            UIModule.OpenDialog({ id = Constants.UITypeIds.UICommonRewardPop, parameters = { rewards = rewards } })

            self:_RefreshSchedule()
            self._canClickBtnMerge = true
        end
    end)
end

function UIActivityTimeLimitedMainDialog:_OnClick_BtnGoodsNode()
    if checkInt(self.recruitmentDojo.hasDrawnDailyRewards) == 1 then
        GameUtils.Toast(localize('今日奖励已领取'))
        return
    end
    GameUtils.Request("Activity2/recruitmentDrawDailyRewards", { activityUuid = Mgr.activityUuid }, function(request, response)
        if checkNumber(response.errCode) == 0 then
            self.recruitmentDojo.hasDrawnDailyRewards = 1
            local data = response.data
            if table.count(data.rewards) > 0 then
                GoodsUtils.DrawRewards(data.rewards, true)
                ---@type ActivityComponent
                local ActivityComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.ActivityComponent)
                local activityData = ActivityComponent:GetDojoByActivityId(Mgr.activityUuid)
                if activityData then
                    activityData.redDotHint = -1
                end
                UIModule.OpenDialog({ id = Constants.UITypeIds.UICommonRewardPop, parameters = { rewards = data.rewards } })
            end
            self:RefreshDailyGoodsShow()
        end
    end)
end

function UIActivityTimeLimitedMainDialog:_OnClick_BtnGet()
    if checkNumber(self.recruitmentDojo.openType) > 0 then
        local goodsConfMgr = GoodsConfMgr:GetInstance()
        local row = goodsConfMgr:GetJumpModuleRow(checkNumber(self.recruitmentDojo.openType))
        goodsConfMgr:ExecuteJump(row, {})
    end
end

return UIActivityTimeLimitedMainDialog
