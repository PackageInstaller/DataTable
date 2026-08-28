--[[
    luaide 模板位置位于 Template/FunTemplate/NewFileTemplate.lua 其中 Template 为配置路径 与luaide.luaTemplatesDir
    luaide.luaTemplatesDir 配置 https://www.showdoc.cc/web/#/luaide?page_id=713062580213505
    author:{jialei}
    time:2019-11-18 17:26:46
]]

local KTool = CS.Engine.Lib.KTool
local UIModule = CS.Engine.UI.UIModule
local UIEventProxy = CS.Engine.UI.UIEventProxy
local CanvasGroup = CS.UnityEngine.CanvasGroup
local UIEffectCapturedImage = CS.UGUI.Effects.UIEffectCapturedImage

local GainNodeEnvPath = 'Game.UI.Common.CommonRewardGainNode'
local GOODS_NUM_MAX = 14 --- 最大展示物品数量
local GainNodePrefab = "GainNode"
local util = require "XLua.util"
---@type CriWareUtils
local CriWareUtils = import('Game.Entry.CriWareUtilsFix')
local CatEggDojo = import("Game.Dojo.CatEggDojo")
local uiSheets = UISheets

--- from: Assets/BundleResources/Prefabs/Common/CommonRewardPopWinDialog.prefab > name: CommonRewardPopWinDialog
---@class CommonRewardPopWinDialog
---@field Env                           	CommonRewardPopWinDialog                
---@field controller                    	Engine.UI.UILuaDialog                   
---@field CommonAestheticsNode          	Engine.Modules.LuaBehaviour             	0    
---@field GridView                      	SuperScrollView.LoopGridView            	1    @ 多奖励容器
---@field GoodFatherRoot2               	UnityEngine.RectTransform               	2    @ 少奖励容器2 猫球用
---@field RewardNode                    	UnityEngine.RectTransform               	3    @ 奖励节点
---@field GoodFatherRoot                	UnityEngine.RectTransform               	4    @ 少奖励容器
---@field CloseBtn                      	UnityEngine.RectTransform               	5    @ 关闭区域
---@field ImgJumpOffBg                  	UnityEngine.RectTransform               	6    @ 是否是前置关卡奖励
local CommonRewardPopWinDialog = Class("CommonRewardPopWinDialog")
local CommonAestheticsNodePath = "Game.MaidCoffee.MaidCoffeeRenovaUIDialog.CommonAestheticsNode"
function CommonRewardPopWinDialog:__init()
    ---@type table[]
    self.goodsTable = nil  -- 奖励数据
    ---@type integer
    self.goodsCount = 0  -- 奖励数量
    ---@type UnityEngine.Coroutine
    self.curCoroutine = nil
    ---@type fun():void
    self.closeCallback = nil
    self.captureGo = nil
    self.active = false
    self.goodsMaxNum = GOODS_NUM_MAX
end

function CommonRewardPopWinDialog:__delete()
    self.goodsTable = nil
    self.goodsCount = nil
    self.curCoroutine = nil
    self.closeCallback = nil
    self.captureGo = nil
    self.controller = nil
    self.active = false
    self.orthographic = false
    self.commonAestheticsEnv = nil
    self.fieldOfView = 12
    self.ignoreUICameraProjection = false
end

function CommonRewardPopWinDialog:Awake()
    ---@type UnityEngine.Camera
    local cam = UIModule.RootCanvas.defaultCamera
    if  cam then
        self.orthographic = cam.orthographic
        self.fieldOfView = cam.fieldOfView
    end

    if self.CommonAestheticsNode then
        local env = CfUtils.GetLuaScr(self.CommonAestheticsNode,CommonAestheticsNodePath)
        if env then
            self.commonAestheticsEnv = env
        end
        KTool.SetActive(self.CommonAestheticsNode.gameObject,false)
    end

    UIEventProxy.Create(self.CloseBtn.gameObject).onPointerClick = Bind(self, self.OnCloseBtnClick)
end

function CommonRewardPopWinDialog:OnFocus(focus)
    if not focus then
        ---@type UnityEngine.Camera
        local cam = UIModule.RootCanvas.defaultCamera
        if  cam then
            CfUtils.SetUICameraProjection(self.orthographic, self.fieldOfView)
        end
    end
end

function CommonRewardPopWinDialog:OnInitialize()
    return CoWaitDo(function()
        self:DoInitialize()
        if not self.ignoreUICameraProjection then
            CfUtils.SetUICameraProjection(true)
        end
    end)
end
function CommonRewardPopWinDialog:DoInitialize()
    local initParams = self.controller.Argument.parameters or {}
    self.closeCallback = initParams.cb or initParams.closeCb
    self.ignoreUICameraProjection = checkBool(initParams.ignoreUICameraProjection)
    ---@type Constants.RewardShowType
    self._rewardShowType = initParams.rewardShowType or Constants.RewardShowType.GoodNode

    self._isDisableConversionYield = initParams.isDisableConversionYield
    self._isDisableSpecialRewards = initParams.isDisableSpecialRewards
    if initParams.customSortingOrder then
        CfUtils.SetAddSortingOrder(self.controller, initParams.customSortingOrder)
    end
    --- 少奖励节点容器
    self.RewardNodeContainer = self._rewardShowType == Constants.RewardShowType.GoodNode and self.GoodFatherRoot or self.GoodFatherRoot2

    local ignoreSort = checkBool(initParams.ignoreSort)
    local rewards = initParams.rewards

    if ignoreSort then
        return
    end

    -- 按照品质从高到低重组顺序
    if checkBool(initParams.forceIgnoreSort) == false then
        ignoreSort = false
        if isTable(rewards) and table.count(rewards) > 0 then
            local catRewards = {}
            for i, v in pairs(rewards) do
                if isSet(v, "catBall") and isTable(v.catBall) then
                    local convertGoods = v.catBall.convertGoods
                    if convertGoods then
                        v.convertGoods = convertGoods
                        table.insert(catRewards, convertGoods)
                    else
                        table.insert(catRewards, v)
                    end
                else
                    table.insert(catRewards, v)
                end
            end
            rewards = catRewards
            --- 剔除掉 61道具, 它不会被显示出来
            local not61Goods = {} 
            for i, dojo in pairs(rewards) do
                if dojo.goodsId then
                    local idType = GoodsUtils.GetIdType(dojo.goodsId)
                    if idType ~= Constants.IDType.Live3DHeXieGoods then 
                        table.insert( not61Goods, dojo )
                    end 
                end
            end
            rewards = not61Goods
            ---
            --if rewards is table handle sort logical
            local goods = {} ---all goods
            for i, dojo in pairs(rewards) do
                if dojo.goodsId then
                    local vo = GoodsConfMgr:GetInstance():GetGoodsVoById(dojo.goodsId)
                    if vo and vo.quality then
                        -- not null
                        dojo.quality = checkNumber(vo.quality)
                    else
                        dojo.quality = 0
                    end
                    if not goods[tostring(dojo.quality)] then
                        goods[tostring(dojo.quality)] = {}
                    end
                    if isSet(dojo, "playerEquipment") then
                        local goodsType = GoodsUtils.GetIdType(dojo.goodsId)
                        if goodsType == Constants.IDType.GoodsCommission then
                            dojo.goodsId = vo.effectId
                        end
                    end
                    table.insert(goods[tostring(dojo.quality)], dojo)
                elseif isSet(dojo, "catId") then
                    ignoreSort = true
                    if not goods['999'] then
                        goods['999'] = {}
                    end
                    table.insert(goods['999'], dojo)

                end
            end
            local keys = sortByKey(goods, true)
            local t = {}
            for i, quality in pairs(keys) do
                local tmp = goods[tostring(quality)]
                if not ignoreSort then
                    SortByMember(tmp, "goodsId")
                end
                for _, v in pairs(tmp) do
                    table.insert(t, v)
                end
            end
            if #t == 0 then
                t = rewards
            end
            initParams.rewards = t
        end
    end
end

function CommonRewardPopWinDialog:OnFinalize()
    return CoWaitDo(function()
        self:DoFinalize()
    end)
end
function CommonRewardPopWinDialog:DoFinalize()
    Events.Broadcast(Constants.EventNames.CloseExpChangeTips)
    if self.captureGo then
        KTool.SetActive(self.captureGo, self.active)
    end
    if not IsNull(self.curCoroutine) then
        CoStop(self.curCoroutine)
        self.curCoroutine = nil
    end

    if not IsNull(self.__mainCoroutine) then
        CoStop(self.__mainCoroutine)
        self.__mainCoroutine = nil
    end

    if self.closeCallback and type(self.closeCallback) == 'function' then
        self.closeCallback()
    else
        Events.Broadcast(Constants.EventNames.UICommonPopupWindowClose)
    end

    self.controller = nil --C#托管堆GC
    self:Delete()
    self = nil
end

function CommonRewardPopWinDialog:OnShow()
    return CoWaitDo(function()
        local initParams = self.controller.Argument.parameters or {}
        if isNull(initParams.rewards) then
            return
        end
        ---策划说这里不会同时出现2种类型的道具  如果出现了 就不用管
        local recipeData = {}
        local type
        for i, v in pairs(initParams.rewards) do
            local goodsType = GoodsUtils.GetIdType(v.goodsId)
            if goodsType == Constants.IDType.RestaurantRecipeGoods
            or goodsType == Constants.IDType.GoodsCD then
                table.insert(recipeData,v)
                type = Constants.IDType.RestaurantRecipeGoods
            elseif goodsType == Constants.IDType.RenovatedGoods then
                table.insert(recipeData,v)
                type = Constants.IDType.RenovatedGoods
            end
        end

        local isJumpOff = checkBool(initParams.isJumpOff) --是否是前置关卡
        CfUtils.SetActive(self.ImgJumpOffBg, isJumpOff)
        self:RefreshShow(recipeData,type)

        ---因为该窗口对屏幕进行截屏，所以显示时底下的窗口都可以关闭显示
        -- GameUtils.HidePreviousDialogs(self.controller) --如果弹出框之后又有新的弹出框出现，如果底下隐藏会有一帧穿帮，暂时去掉。
    end)
end

function CommonRewardPopWinDialog:OnHide()
    -- uiluadialog修改后允许不用新开协程
    -- return CoWaitDo(function()
        ---因为该窗口对屏幕进行截屏，所以显示时底下的窗口都可以关闭显示，关闭该窗口时，需要让底下窗口重新显示
        -- GameUtils.ShowPreviousDialogs()
    -- end)
end 

function CommonRewardPopWinDialog:RefreshShow(recipeData,goodsType)
    if goodsType == Constants.IDType.RestaurantRecipeGoods then     ---菜谱弹窗
        self:DoRecipeShow(recipeData,goodsType)
    elseif goodsType == Constants.IDType.RenovatedGoods then    ---家具弹窗
        self:DoRenovateShow(recipeData)
    else
        self:PlayShowSound()
        self.__mainCoroutine = CoStart(function()
            self:DoShow()
        end)
    end
end

function CommonRewardPopWinDialog:DoRecipeShow(recipeData,goodsType)
    if #recipeData > 0 then
        --- 进入升级成功界面
        UIModule.OpenDialog({ id = Constants.UITypeIds.CultivateLevelUpSecondConfirmPanel, parameters = {
            levelUpType = Constants.UICultivateLevelUpFinishType.GetRecipe,data = recipeData[1],callBack = function()
                table.remove(recipeData,1)
                self:RefreshShow(recipeData,goodsType)
            end
        } })
    else
        self:PlayShowSound()
        self.__mainCoroutine = CoStart(function()
            self:DoShow()
        end)
    end
end

function CommonRewardPopWinDialog:DoRenovateShow(recipeData)
    ---@type MaidCoffeePlayerComponent
    local maidCoffeePlayerComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.MaidCoffeePlayerComponent)
    local curIndex = maidCoffeePlayerComponent:GetCurEffectIndex()
    local curAestheticsNum = maidCoffeePlayerComponent:GetAestheticsNum()
    local MaidCoffeeUtils     = import("Game.MaidCoffee.MaidCoffeeUtils")
    local addAestheticsNum = MaidCoffeeUtils.CalculationAddAestheticsNum(recipeData)
    local nextIndex = maidCoffeePlayerComponent:GetCurEffectIndex(curAestheticsNum + addAestheticsNum)
    maidCoffeePlayerComponent:UpdateAestheticsNum(curAestheticsNum + addAestheticsNum)
    if nextIndex > curIndex then
        UIModule.OpenDialog({ id = Constants.UITypeIds.CultivateLevelUpSecondConfirmPanel, parameters = {
            levelUpType = Constants.UICultivateLevelUpFinishType.GetRenovate,data = {curIndex = curIndex,nextIndex = nextIndex,curNum = curAestheticsNum,nextNum = curAestheticsNum + addAestheticsNum},callBack = function()
                self.commonAestheticsEnv:RefreshShow(curAestheticsNum + addAestheticsNum,false,nil,true,curAestheticsNum)
                self:PlayShowSound()
                self.__mainCoroutine = CoStart(function()
                    self:DoShow()
                end)
            end
        } })
    else
        self.commonAestheticsEnv:RefreshShow(curAestheticsNum + addAestheticsNum,false,nil,true,curAestheticsNum)
        self:PlayShowSound()
        self.__mainCoroutine = CoStart(function()
            self:DoShow()
        end)
    end
end

function CommonRewardPopWinDialog:PlayShowSound()
    CriWareUtils.PlaySe(uiSheets.UI_Menu.path, uiSheets.UI_Menu.ui_award_get)
end

function CommonRewardPopWinDialog:DoShow()
    -- capture screen
    local effectBg = self.controller.gameObject:GetComponent(typeof(UIEffectCapturedImage))
    effectBg:Capture()

    -- check rewards data
    local initParams = self.controller.Argument.parameters or {}
    if isNull(initParams.rewards) then
        return
    end
    self.goodsTable = checkTable(initParams.rewards)
    self.goodsCount = table.count(self.goodsTable)

    ---@type PlayerComponent
    local playerComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.PlayerComponent)
    local isShowDisplay = next(playerComponent:GetRewardsDialogInfos())
    if isShowDisplay and self._isDisableSpecialRewards ~= true then
        CfUtils.SetActive(self.controller, false)
        local co = playerComponent:ShowRewardsSpecialDialog()
        if co then
            coroutine.yield(co)
        end
        CfUtils.SetActive(self.controller, true)
    end

    if self.goodsCount > self.goodsMaxNum then
        ---列表的形式展示
        CfUtils.SetActive(self.GridView, true)
        CfUtils.SetActive(self.RewardNodeContainer, false)
        self.GridView:InitGridView(self.goodsCount, Bind(self, self.OnGetItemByIndex))
        ---展示 Goods
        self.curCoroutine = CoStart(function()
            CoYield(1.2)
            -- 展示完成置空协程
            if not IsNull(self.curCoroutine) then
                CoStop(self.curCoroutine)
                self.curCoroutine = nil
            end
        end)
    else
        CfUtils.SetActive(self.GridView, false)
        CfUtils.SetActive(self.RewardNodeContainer, true)
        self:ShowFewGoods()
    end
end

---@param listView SuperScrollView.LoopGridView
---@param index integer
---@param row integer
---@param column integer
---@return SuperScrollView.LoopGridViewItem
function CommonRewardPopWinDialog:OnGetItemByIndex(listView, index, row, column)
    if index < 0 then
        return nil
    end
    if self.goodsTable == nil then
        return nil
    end
    if #self.goodsTable < (index + 1) then
        return nil
    end
    local cell = listView:NewListViewItem(GainNodePrefab)
    local dojo = self.goodsTable[index + 1]
    if not isNull(dojo) then
        local goodsId = dojo.goodsId
        local num     = dojo.num

        local isCatBallGoods = isSet(dojo, "catId")
        local realNum = (not isCatBallGoods) and self:CheckGoodsIdForSignNum(goodsId, num) or nil
        self:InitRewardNode(cell, dojo, realNum, true)
    end
    return cell
end


--[[
    展示 Goods
--]]
function CommonRewardPopWinDialog:ShowFewGoods()
    local goodsTable = self.goodsTable
    local goodsCount = self.goodsCount
    if goodsCount < 1 then
        printInfo("请检查参数Table")
        return
    end
    if goodsCount > self.goodsMaxNum then
        goodsCount = self.goodsMaxNum
        local t = {}
        for i = 1, self.goodsMaxNum do
            table.insert(t, goodsTable[i])
        end
        goodsTable = t
    end

    ---生成 GO
    for i = 1, goodsCount do
        local dojo = goodsTable[i]
        if not isSet(dojo, "catId") then
            self:LoadRewardNode(dojo, self:CheckGoodsIdForSignNum(goodsTable[i].goodsId, goodsTable[i].num))
        else
            self:LoadRewardNode(dojo, nil)
        end
    end

    ---展示 Goods
    self.curCoroutine = CoStart(function()
        CoYield(0.5)
        local RewardNodeContainer = self.RewardNodeContainer
        -- 逐个展示
        for i = 1, RewardNodeContainer.childCount do
            ---@type UnityEngine.Transform
            local rootTrans = RewardNodeContainer:GetChild(i - 1)
            CfUtils.SetActive(rootTrans, true)
            -- local goodTrans = rootTrans:Find("GoodNode")
            if not isSet(goodsTable[i], "catId") then
                self:ShowEffect(rootTrans, goodsTable[i].goodsId)
            end
            self:PlayShowFewGoodsCellSound(i)
            CoYield(0.1)
        end
        
        -- 显示转换的逻辑
        if not self._isDisableConversionYield then
            CoYield(0.45)
        end
        local RewardNodeContainer = self.RewardNodeContainer
        local isCatBallNode = self._rewardShowType == Constants.RewardShowType.CatBallNode
        for i = 1, RewardNodeContainer.childCount do
            local goodsTable = goodsTable[i]
            if isSet(goodsTable, "convertGoods") and isSet(goodsTable.convertGoods, "goodsId") or (isCatBallNode and goodsTable.isFragment) then
                ---@type UnityEngine.CanvasGroup
                local canvasGroup = KTool.GetOrAddComponent(RewardNodeContainer.gameObject, typeof(CanvasGroup))
                if canvasGroup then
                    coroutine.yield(canvasGroup:DOFade(0, 0.2))
                end
                ---@type UnityEngine.Transform
                local rootTrans = RewardNodeContainer:GetChild(i - 1)
                self:ShowCovertEffect(rootTrans, goodsTable)
                if canvasGroup then
                    coroutine.yield(canvasGroup:DOFade(1, 0.2))
                end
            end
        end
        -- 展示完成置空协程
        if not IsNull(self.curCoroutine) then
            CoStop(self.curCoroutine)
            self.curCoroutine = nil
        end
    end)
end

function CommonRewardPopWinDialog:ShowEffect(go, ...)
    ---@type CommonRewardGainNode
    local env = CfUtils.GetLuaScr(go, GainNodeEnvPath)    
    if isNull(env) then return end
    env:ShowEffect(...)
end

function CommonRewardPopWinDialog:ShowCovertEffect(go, ...)
    ---@type CommonRewardGainNode
    local env = CfUtils.GetLuaScr(go, GainNodeEnvPath)    
    if isNull(env) then return end
    env:ShowCovertEffect(...)
end

function CommonRewardPopWinDialog:PlayShowFewGoodsCellSound(goodsIndex)
end

--- 判断物品类型，是否需要返回数量
---@param goodsId integer @ 道具id
---@param goodsNum integer @ 道具数量
---@return integer | nil
function CommonRewardPopWinDialog:CheckGoodsIdForSignNum(goodsId, goodsNum)
    local goodsType = GoodsUtils.GetIdType(goodsId)
    local blockMap = {
        [Constants.IDType.Equipment] = true, -- 装备
        [Constants.IDType.CharacterCard] = true, -- 角色卡
    }
    if blockMap[goodsType] then
        return nil
    else
        return goodsNum
    end
end

--[[
    加载 GoodsGO
--]]
function CommonRewardPopWinDialog:LoadRewardNode(goodsTable, num)
    local go = KTool.Instantiate(self.RewardNodeContainer.gameObject, self.RewardNode.gameObject)

    self:InitRewardNode(go, goodsTable, num)

    CfUtils.SetActive(go, false)
end

function CommonRewardPopWinDialog:InitRewardNode(gainNodeGo, goodsTable, num, isResetScale)
    ---@type CommonRewardGainNode
    local env = CfUtils.GetLuaScr(gainNodeGo, GainNodeEnvPath)    
    if isNull(env) then return end
    env:OnShow(goodsTable, num, self._rewardShowType)

    if isResetScale then
        env:ResetScale()
    end
end

function CommonRewardPopWinDialog:OnCloseBtnClick()
    ---因为该窗口对屏幕进行截屏，所以显示时底下的窗口都可以关闭显示，关闭该窗口时，需要让底下窗口重新显示
    -- GameUtils.ShowPreviousDialogs()

    if not IsNull(self.__mainCoroutine) then
        CoStop(self.__mainCoroutine)
        self.__mainCoroutine = nil

        ---@type PlayerComponent
        local playerComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.PlayerComponent)
        playerComponent:StopRewardsSpecialDialogCo()

        if not IsNull(self.curCoroutine) then
            CoStop(self.curCoroutine)
            self.curCoroutine = nil

            local canvasGroup = KTool.GetOrAddComponent(self.RewardNodeContainer.gameObject, typeof(CanvasGroup))
            canvasGroup.enabled = false

            ---检测未完成展示Goods,立刻展示
            for i = 1, self.RewardNodeContainer.childCount do
                local dojo = self.goodsTable[i]
                local rootTrans = self.RewardNodeContainer:GetChild(i - 1)
                if not isNull(rootTrans) then
                    CfUtils.SetActive(rootTrans, true)
                    
                    self:ImmediateShowRewardNode(rootTrans, dojo)
                end
            end
        else
            UIModule.BackDialog()
        end

    elseif IsNull(self.curCoroutine) then
        UIModule.BackDialog()
    end
end


function CommonRewardPopWinDialog:ImmediateShowRewardNode(go, dojo)
    ---@type CommonRewardGainNode
    local env = CfUtils.GetLuaScr(go, GainNodeEnvPath)    
    if isNull(env) then return end
    env:ImmediateShow(dojo, self._rewardShowType)
end

return CommonRewardPopWinDialog