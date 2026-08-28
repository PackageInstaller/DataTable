-------------------------------------------------------------------------------
-- 周年庆 - 庆典小铺（大转盘） - 入口界面
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-06-19 12:09:56
-------------------------------------------------------------------------------

local Random = CS.UnityEngine.Random
local Ease = CS.DG.Tweening.Ease
local RotateMode = CS.DG.Tweening.RotateMode
local ActivityUtils = import("Game.Activity.ActivityUtils")
local ActivityConstants = import("Game.Activity.ActivityConstants")
local KTool = CS.Engine.Lib.KTool
---@type ActivityMgr
local ActivityMgr = import("Game.Activity.ActivityMgr"):GetInstance()

local SINGLE_RADIUS     = 360 / 8
local MULTIPLE_COUNT    = 10  -- 多抽的数量
local ROLL_BLOCKER_NAME = 'ActivityRotaryTablePanel_RollTable'

--- from: Assets/BundleResources/Prefabs/Anniversary/AnniversaryTurntableDialog122501.prefab > name: AnniversaryTurntableDialog122501
---@class ActivityRotaryTablePanel
---@field Env                           	ActivityRotaryTablePanel                
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field ActivityDescrText             	UnityEngine.RectTransform               	@ 0    活动描述文本框
---@field ActivityTimeText              	UnityEngine.RectTransform               	@ 1    活动时间文本框
---@field TxtNumber2                    	UnityEngine.RectTransform               	@ 2    十抽消耗数量
---@field TxtMore                       	UnityEngine.RectTransform               	@ 3    
---@field ImgIcon2                      	UnityEngine.RectTransform               	@ 4    十抽消耗图标
---@field BtnMore                       	UnityEngine.RectTransform               	@ 5    十抽按钮
---@field TxtNumber1                    	UnityEngine.RectTransform               	@ 6    单抽消耗数量
---@field ImgIcon1                      	UnityEngine.RectTransform               	@ 7    单抽消耗图标
---@field BtnOne                        	UnityEngine.RectTransform               	@ 8    单抽按钮
---@field ContentGroupParent            	UnityEngine.RectTransform               	@ 9    转盘父节点
---@field ContentGroup                  	UnityEngine.RectTransform               	@ 10   转盘节点
---@field TxtOne                        	UnityEngine.RectTransform               	@ 11   
local ActivityRotaryTablePanel = Class('ActivityRotaryTablePanel')


function ActivityRotaryTablePanel:__init()
    ---@type number
    self._turntableId = 0
    ---@type GoodsVo
    self._rollPointVo = nil
    ---@type GoodsVo
    self._rollConsumeVo = nil
    ---@type integer
    self._rollConsumeNum = 0
    ---@type ActivityRotaryTableGroupNode
    self._groupNodeEnv = nil
    ---@type ActivityDojo
    self._annivDojo = nil
    ---@type UnityEngine.Coroutine
    self.turntableRollAnimCo_ = nil
end


function ActivityRotaryTablePanel:__delete()
    self._turntableId         = nil
    self._rollPointVo         = nil
    self._rollConsumeVo       = nil
    self._rollConsumeNum      = nil
    self._groupNodeEnv        = nil
    self._annivDojo           = nil
    self.turntableRollAnimCo_ = nil
end


function ActivityRotaryTablePanel:Awake()
    self._groupNodeEnv = CfUtils.GetLuaScr(self.ContentGroup, 'Game.Activity.RotaryTable.ActivityRotaryTableGroupNode')
end


function ActivityRotaryTablePanel:Start()
    SetButtonAction(self.BtnOne, function ()
        ---@type ActivityRotaryTableConfigVo
        local tableConfigVo = CfUtils.GetCfVo(AutoIds.IdSetting3099, "ActivityRotaryTableConfigVo",self._turntableId)
        local consumeId = tableConfigVo.consumeId
        local num =  GoodsUtils.GetThingNo(consumeId)
        local times = math.floor(num / self._rollConsumeNum) 
        times = (times  > 10 and 10) or (times < 1 and 1) or times
        self:OnClickRollTableHandler_(times)
    end )
    SetButtonAction(self.BtnMore, function ()
        ---@type ActivityRotaryTableConfigVo
        local tableConfigVo = CfUtils.GetCfVo(AutoIds.IdSetting3099, "ActivityRotaryTableConfigVo",self._turntableId)
        self:OnClickRollTableHandler_(tableConfigVo.drawNum)
    end )
--    Bind(self, self.OnClickRollTableHandler_, 1)
    -- SetButtonAction(self.BtnMore, Bind(self, self.OnClickRollTableHandler_, MULTIPLE_COUNT))
    -- SetButtonAction(self.BtnRank, Bind(self, self.OnClickRandHandler_))
    -- SetButtonAction(self.BtnStore, Bind(self, self.OnClickStoreHandler_))
    -- SetButtonAction(self.BtnRankReward, Bind(self, self.OnClickRankRewardHandler_))
    -- SetButtonAction(self.BtnPointNumber, Bind(self, self.OnClickRollPointHandler_))
    -- KTool.SetActive(self.BtnStore.gameObject, false)
    -- KTool.SetActive(self.BtnRank.gameObject,false)
    -- KTool.SetActive(self.BtnRankReward.gameObject,false)
    -- KTool.SetActive(self.BtnPointNumber.gameObject,false)
    self._everythingChangeHandler = Events.AddListener(Constants.EventNames.EveryThingChangeEventName, Bind(self, self.OnEveryThingChangeHandler_))
    self._annivRedPointChangeHandler = Events.AddListener(Constants.EventNames.ActivityRedPointChange, Bind(self, self.OnAnnivRedPointChangeHandler))
end


function ActivityRotaryTablePanel:OnDestroy()
    Events.RemoveListener(Constants.EventNames.EveryThingChangeEventName, self._everythingChangeHandler)
    Events.RemoveListener(Constants.EventNames.ActivityRedPointChange, self._annivRedPointChangeHandler)
    if self.turntableRollAnimCo_ then
        CoStop(self.turntableRollAnimCo_)
        self.turntableRollAnimCo_ = nil
    end
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


---@param annivDojo ActivityDojo
function ActivityRotaryTablePanel:Refresh(annivDojo)
    self._annivDojo   = annivDojo
    local webImage = self.controller.transform:Find("Root/Container/LeftPanel/TitleItem/ImgTitleName/ImgTitleNameBg")
    if not string.isEmpty(annivDojo.titleImage) then
        CfUtils.FillWebRawImage(webImage, annivDojo.titleImage)
    end
    GameUtils.Request(Interfaces.ActivityRotaryTable , {activityUuid = self._annivDojo.id} , function (request, response)
        if checkNumber(response.errCode) == 0 then
            
            self.ActivityRotaryData = response.data
            -- self._turntableId = ActivityConstants.LocalDefine.TurntableId
            ---@type ActivityRotaryTableConfigVo
            self._turntableId = self:GetTurnTableId()
            local tableConfigVo = CfUtils.GetCfVo(AutoIds.IdSetting3099, "ActivityRotaryTableConfigVo",self._turntableId)
            self._rollPointVo    = GoodsConfMgr:GetInstance():GetGoodsVoById(tableConfigVo.getId)
            self._rollConsumeVo  = GoodsConfMgr:GetInstance():GetGoodsVoById(tableConfigVo.consumeId)
            self._rollConsumeNum = checkInt(tableConfigVo.consumeNumSingle)
            local isHave = self:CheckRankRed()
            if not  isHave then
                self._annivDojo.redDotHint = -1    
            end
            -- KTool.SetActive(self.BtnStore, true)
            -- if checkInt(self.ActivityRotaryData.rankIsOpened) == 1 then
            --     KTool.SetActive(self.BtnRank.gameObject,true)
            --     KTool.SetActive(self.BtnRankReward.gameObject,true)
            --     KTool.SetActive(self.BtnPointNumber.gameObject,true)
            -- end
            self:UpdateActivityInfo_()
            self:UpdateTurntableInfo_()
            self:UpdateRollPointInfo_()
            self:UpdateRankRedPoint_()
            self:ResetGroupAllCellSelect()
            self:RefreshCurrencyBarInfo()
        end     
    end)
end
function ActivityRotaryTablePanel:GetTurnTableId()
    local activityContentId = checkInt(self._annivDojo.activityContentId)
    local turnId = 101
    ---@type ActivityRotaryTableConfigVo[]
    local tableConfigVos  = CfUtils.GetWholeVo(AutoIds.IdSetting3099, "ActivityRotaryTableConfigVo")
    for k, v in pairs(tableConfigVos) do
        if checkInt(v.group) == activityContentId then
            turnId = checkInt(v.id) 
        end
    end
    return turnId
end

function ActivityRotaryTablePanel:CheckRankRed()
    local rankRewardsConf = self.ActivityRotaryData.rankRewardsConf
    local isHaveRed = false
    for k, v in pairs(rankRewardsConf) do
        if checkInt(v.status) == 1 then
            isHaveRed = true 
            break
        end
    end
    return isHaveRed 
end


-------------------------------------------------
-- private

function ActivityRotaryTablePanel:UpdateActivityInfo_()
    local timeText  = ActivityUtils.ConventActivityDurationTime(self._annivDojo.startTime, self._annivDojo.endTime)
    local descrText = tostring(self._annivDojo.detail)
    CfUtils.FillText(self.ActivityTimeText, timeText)
    CfUtils.FillText(self.ActivityDescrText, descrText)
end


function ActivityRotaryTablePanel:UpdateTurntableInfo_()
    -- update turntable groupNode
    self._groupNodeEnv:UpdateTableGroup(self._turntableId)

    -- update one/ten consume
    CfUtils.FillImage(self.ImgIcon1, self._rollConsumeVo.photoPath)
    CfUtils.FillImage(self.ImgIcon2, self._rollConsumeVo.photoPath)
    ---@type ActivityRotaryTableConfigVo
    local tableConfigVo = CfUtils.GetCfVo(AutoIds.IdSetting3099, "ActivityRotaryTableConfigVo",self._turntableId)
    local consumeId = tableConfigVo.consumeId
    local num =  GoodsUtils.GetThingNo(consumeId)
    local times = math.floor(num / self._rollConsumeNum) 
    times = (times  > 10 and 10) or (times < 1 and 1) or times
    CfUtils.FillText(self.TxtNumber1,"x" ..  self._rollConsumeNum * times)
    CfUtils.FillText(self.TxtNumber2, "x" .. self._rollConsumeNum * tableConfigVo.drawNum)
    CfUtils.FillText(self.TxtOne , localize("转_times_次" , {_times_ = times}))
    CfUtils.FillText(self.TxtMore , localize("转_times_次" , {_times_ = tableConfigVo.drawNum}))
end


function ActivityRotaryTablePanel:UpdateRollPointInfo_()
    if isNull(self._rollPointVo) then
       return 
    end
    local haveGoodsNum = GoodsUtils.GetThingNo(self._rollPointVo.id)
    -- CfUtils.FillImage(self.PointNumberImg, self._rollPointVo.photoPath)
    -- CfUtils.FillText(self.PointNumberText, string.format('x%d', checkInt(haveGoodsNum)))
end


function ActivityRotaryTablePanel:UpdateRankRedPoint_()
    local closeRankRed = CfUtils.GetLocalData(Constants.PlayerPrefsType.ActivityRotaryTableRankRed, '0')
    CfUtils.SetActive(self.BtnRankRedPoint, checkInt(closeRankRed) ~= 1)
    
    local hasRedPoint = ActivityMgr:HasActivityDojoRedDotHint(self._annivDojo.id)
    CfUtils.SetActive(self.BtnRankRewardRedPoint, hasRedPoint)
end


function ActivityRotaryTablePanel:ResetGroupAllCellSelect()
    for _, rewardCell in pairs(self._groupNodeEnv:GetRewardCellMap()) do
        rewardCell:SetSelectLight(false)
    end
end


---@param seatIdList integer[]
---@param finishCb fun():void
function ActivityRotaryTablePanel:DoTurntableRollAnim_old(seatIdList, finishCb)
    local currentRotateNum = 1
    local actualRotateNum  = table.count(seatIdList)
    local singleRotateTime = (actualRotateNum > 1) and 2 or 3
    local secondRotateTime = 1
    if actualRotateNum < 1 then return end
    self:ResetGroupAllCellSelect()
    CfUtils.ConditionAppend(ROLL_BLOCKER_NAME)
    
    local circle  = self._groupNodeEnv:GetCirCle()
    local pointer = self._groupNodeEnv:GetPointer()
    local cellMap = self._groupNodeEnv:GetRewardCellMap()
    if actualRotateNum > 1 then
        singleRotateTime = self._groupNodeEnv:PlayRotationTenAnim()
    else
        singleRotateTime = self._groupNodeEnv:PlayRotationOneAnim()
    end

    local function doRotateAnim(seatId)
        local rotateTime    = currentRotateNum == 1 and singleRotateTime or secondRotateTime
        local radiusTurns   = 360 * (currentRotateNum == 1 and math.random(10,20)  or 1)-- * Random.Range(10, 20)  -- 随机转的圈数角度
        local radiusCircle  = Random.Range(SINGLE_RADIUS * (seatId-1), SINGLE_RADIUS * seatId)
        local radiusPointer = -(360 - radiusCircle)
        -- 转盘旋转
        circle:DOLocalRotate(Vector3.New(0, 0, radiusTurns + radiusCircle), rotateTime, RotateMode.FastBeyond360):SetEase(Ease.InOutCirc).onComplete = (function()
            currentRotateNum = currentRotateNum + 1
            -- cell select
            local rewardCell = cellMap[seatId]
            rewardCell:SetSelectLight(true)
            -- check over
            if currentRotateNum > actualRotateNum then--完成
                CfUtils.ConditionRemove(ROLL_BLOCKER_NAME)
                if finishCb then
                    finishCb()
                end
            else
                -- secondRotateTime = self._groupNodeEnv:PlayRotationTenAnim()
                doRotateAnim(seatIdList[currentRotateNum])
            end
        end)
        -- 指针旋转
        pointer:DOLocalRotate(Vector3.New(0, 0, radiusTurns + radiusPointer), rotateTime, RotateMode.FastBeyond360):SetEase(Ease.InOutCirc)
    end
    doRotateAnim(seatIdList[currentRotateNum])
end


---@param seatIdList integer[]
---@param finishCb fun():void
function ActivityRotaryTablePanel:DoTurntableRollAnim_(seatIdList, finishCb)
    self:ResetGroupAllCellSelect()

    self.turntableRollAnimCo_ = CoStart(function()
        CfUtils.ConditionAppend(ROLL_BLOCKER_NAME)

        local singleRotateTime = 1
        local actualRotateNum  = table.count(seatIdList)
        if actualRotateNum > 1 then
            singleRotateTime = self._groupNodeEnv:PlayRotationTenAnim()
        else
            singleRotateTime = self._groupNodeEnv:PlayRotationOneAnim()
        end
        CoYield(singleRotateTime)

        CfUtils.ConditionRemove(ROLL_BLOCKER_NAME)
        self.turntableRollAnimCo_ = nil

        if finishCb then
            finishCb()
        end
    end)
end


-------------------------------------------------
-- handler

function ActivityRotaryTablePanel:OnAnnivRedPointChangeHandler()
    self:UpdateRankRedPoint_()
end


function ActivityRotaryTablePanel:OnEveryThingChangeHandler_()
    -- self:UpdateRollPointInfo_()
end


-- function ActivityRotaryTablePanel:OnClickRollPointHandler_()
--     if isNull(self._rollPointVo) then
--         return 
--      end
--     local tipsGoodsVo = self._rollPointVo
--     GameUtils.ShowCommonTipsBoard(self.BtnPointNumber, tipsGoodsVo.name, tipsGoodsVo.desc, tipsGoodsVo.quality, tipsGoodsVo.id)
-- end



---@param rollTimes integer @ 1 or 10
function ActivityRotaryTablePanel:OnClickRollTableHandler_(rollTimes)
    -- debug use
    -- if true then
    --     local seatIdList = {}
    --     for i = 1, rollTimes do
    --         table.insert(seatIdList, math.random(1,8))
    --     end
    --     self:DoTurntableRollAnim_(seatIdList, function()
    --         GameUtils.Toast(table.serialize(seatIdList))
    --         print(table.serialize(seatIdList))
    --     end)
    --     return
    -- end
    local consumeGoodsId  = self._rollConsumeVo.id
    local consumeGoodsNum = self._rollConsumeNum * rollTimes
    local haveGoodsNum    = GoodsUtils.GetThingNo(consumeGoodsId)
    local callInface = function()
        local requestData = {
            num = rollTimes,
            activityUuid = self._annivDojo.id
        }
        GameUtils.Request(Interfaces.ActivityRotaryLuckyDraw, requestData, function(request, response)
            if checkInt(response.errCode) == 0 then
                local responseData = checkTable(response.data)
                local seatIdList   = checkTable(responseData.rewardIds)
                local rewardList   = checkTable(responseData.rewards)
    
                -- 消耗道具
                GoodsUtils.ConsumeGoods(responseData.consume, true)
                Events.Broadcast(Constants.EventNames.ActivityRedPointChange,{})
    
                -- 开始转盘动画
                self:DoTurntableRollAnim_(seatIdList, function()
                    GoodsUtils.DrawRewards(rewardList, true)
                    CfUtils.DialogOpen(Constants.UITypeIds.UICommonRewardPop, { rewards = rewardList  , cb = function()
                        self:UpdateTurntableInfo_()
                        self:RefreshCurrencyBarInfo()
                    end })
                end)
            end
        end)
    end
    
    if haveGoodsNum < consumeGoodsNum then
        local itemId, itemNum = ActivityMgr:GetGoodsPrice(consumeGoodsId)
        local needNum =  consumeGoodsNum - haveGoodsNum 
        local youHave = GoodsUtils.GetThingNo(itemId)
        local consumeCount = needNum * itemNum
        local ServerDifferenceMgr = import('Game.Setting.ServerDifferenceMgr'):GetInstance()
        if ServerDifferenceMgr:IsSecondaryCurrencyEnable() or youHave >= consumeCount then
            ---@type CommonCurrencyExchangePopup.InputData
            local data = {
                leftId = itemId,
                leftNum = consumeCount,
                rightId = consumeGoodsId,
                rightNum = needNum,
                onConfirmClick = callInface,
            }
            ServerDifferenceMgr:OpenCurrencyExchangePopup(data)
        else 
            GoodsUtils.CheckConsumeDataCondition({{goodsId = consumeGoodsId , num = consumeGoodsNum}})
        end
    else 
        callInface()
    end
end
function ActivityRotaryTablePanel:RefreshCurrencyBarInfo()
      ---@type ActivityRotaryTableConfigVo
      local tableConfigVo = CfUtils.GetCfVo(AutoIds.IdSetting3099, "ActivityRotaryTableConfigVo",self._turntableId)
      local consumeId = tableConfigVo.consumeId
    ActivityUtils.RefreshNavigatorGoods({consumeId})
end


function ActivityRotaryTablePanel:OnClickRandHandler_()
    CfUtils.DialogOpen(Constants.UITypeIds.UIActivityRotaryTableRankingsDialog, {annivDojo = self._annivDojo})
end


-- function ActivityRotaryTablePanel:OnClickRankRewardHandler_()
--     CfUtils.DialogOpen(Constants.UITypeIds.UIActivityRotaryTableExchangeDialog, {annivDojo = self._annivDojo})
-- end


function ActivityRotaryTablePanel:OnClickStoreHandler_()
    local storeUtils     = import('Game.UI.Store.StoreUtils')
    local StoreConstants = import('Game.UI.Store.StoreConstants')
    local tableConfigVo = CfUtils.GetCfVo(AutoIds.IdSetting3099, "ActivityRotaryTableConfigVo",self._turntableId)
    CfUtils.DialogOpen(Constants.UITypeIds.UIActivityCommonShopDialog, {activityUuid = self._annivDojo.id , activityType = self._annivDojo.type , topGoods = { tableConfigVo.getId}})
end


return ActivityRotaryTablePanel
