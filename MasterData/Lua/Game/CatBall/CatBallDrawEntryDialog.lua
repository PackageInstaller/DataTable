
--region global define
local require         = require
local import          = import
local isNull          = isNull
local isNotNull       = isNotNull
local checkNumber     = checkNumber
local SetButtonAction = SetButtonAction
local Bind            = Bind
local CoStart         = CoStart
local CoYield         = CoYield
--endregion

--region import
local util             = require 'XLua.util'
local cs_coroutine     = require "XLua.cs_coroutine"
local CoWait           = CS.Engine.Lib.CoWait
---@type CatBallUtils
local CatBallUtils     = import("Game.CatBall.CatBallUtils")
local CatEggDojo       = import("Game.Dojo.CatEggDojo")
---@type Engine.Lib.KTool
local KTool            = CS.Engine.Lib.KTool
local Physics          = CS.UnityEngine.Physics
local AnimatorType     = typeof(CS.UnityEngine.Animator)
---@type Engine.Lib.KCookie
local KCookie          = CS.Engine.Lib.KCookie
local CriWareUtils        = import('Game.Entry.CriWareUtilsFix')
--endregion

--region define

local ListType = {
    All      = 1, --- 所有猫种
    Battle   = 2, --- 战斗
    Operates = 3, --- 经营
}

local CallBallType2ListType = {
    [Constants.CatBallType.Active]   = ListType.Battle,
    [Constants.CatBallType.Passive]  = ListType.Battle,
    [Constants.CatBallType.Operates] = ListType.Operates,
}

local DrawType = {
    One   = 1, --- 单抽
    Multi = 3, --- 多抽
}

local UICommonFilterMBEnvPath     = "Game.Behaviours.UICommonFilterMB"
local CommonTabToggleUpEnvPath    = "Game.Behaviours.CommonTabToggleUp"
local CellEnvPath                 = "Game.CatBall.CatBallDrawEntryCell"

local StoreKey                    = "CatBallDrawEntryDialog"
local SortType                    = Constants.UISortType.CatBallChoose
local FilterClass                 = Constants.UIFilterType.CatBallCultivate

local DrawScenePath               = "Prefabs/Runtime/CatBall_Scene.prefab"

local RequestComplete = "OverseaCatBallFragmentFusion.RequestComplete"
--endregion

--- from: Assets/BundleResources/Prefabs/OverseaManage/OverseaManageCatballDrawEntryDialog.prefab > name: OverseaManageCatballDrawEntryDialog
---@class CatBallDrawEntryDialog
---@field Env                           	CatBallDrawEntryDialog                  
---@field controller                    	Engine.UI.UILuaDialog                   
---@field CommonFilterNode              	UnityEngine.RectTransform               	@ 0    
---@field CommonTabToggleUp             	UnityEngine.RectTransform               	@ 1    
---@field ScrollView                    	Engine.UI.AutoFixSizeListView           	@ 2    
---@field EmptyNode                     	UnityEngine.RectTransform               	@ 3    
---@field redPoint                      	UnityEngine.RectTransform               	@ 4    
---@field BtnConsumePopMultiChargeText  	UnityEngine.UI.Text                     	@ 5    
---@field BtnConsumePopMultiText        	Game.Native.Common.UISwitchTextMeshPro  	@ 6    
---@field BtnConsumePopMultiImage       	Engine.UI.ImageAlterable                	@ 7    
---@field BtnConsumePopMulti            	UnityEngine.RectTransform               	@ 8    
---@field BtnConsumePopOneChargeText    	UnityEngine.UI.Text                     	@ 9    
---@field BtnConsumePopOneText          	Game.Native.Common.UISwitchTextMeshPro  	@ 10   
---@field BtnConsumePopOneImage         	Engine.UI.ImageAlterable                	@ 11   
---@field BtnConsumePopOne              	UnityEngine.RectTransform               	@ 12   
---@field BtnTenNode                    	UnityEngine.RectTransform               	@ 13   
---@field BtnOneNode                    	UnityEngine.RectTransform               	@ 14   
---@field BtnConvert                    	UnityEngine.RectTransform               	@ 15   
---@field BtnDetails                    	UnityEngine.RectTransform               	@ 16   
---@field BtnJump                       	UnityEngine.RectTransform               	@ 17   
---@field BtnJumpImgIcon                	UnityEngine.RectTransform               	@ 18   
---@field BtnJumpRedPoint               	UnityEngine.RectTransform               	@ 19   
local CatBallDrawEntryDialog = Class('CatBallDrawEntryDialog')


function CatBallDrawEntryDialog:__init()
    self._isInitList = nil
    self._playerCatId2RedPoint = {}
end


function CatBallDrawEntryDialog:__delete()
    self.controller = nil
end

function CatBallDrawEntryDialog:OnInitialize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        self.Root   = self.controller.transform:Find("Root")
        self.BgNode = self.controller.transform:Find("BgNode")
        if self.Root then
            KTool.SetActive(self.Root.gameObject, false)
        end
        self:OnInit()
    end))
    return coWait
end

function CatBallDrawEntryDialog:OnFocus(focus)
    if focus then
        CfUtils.RefreshTopGoods(self._currency)
        if self._isReload then
            self._isReload = false
            self:InitCatBallEntityList()
            self:FreshCommonFilterNode(true)
        end
    end
end

function CatBallDrawEntryDialog:OnShow()
    ---@type Engine.Lib.CoWait
    -- local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        -- local CoYield = CoYield
        -- while not self._isFinishRequest do
        --     CoYield()
        -- end
        self._isShowDialog = true
        KTool.SetActive(self.Root.gameObject, true)
        if not self._isDisableEnter then
            CfUtils.PlayAnimation(self.Root, "OverseaManageCatballDrawEntryDialog")
            CfUtils.PlayAnimation(self.BgNode, "OverseaManageCatballDrawEntryDialog_Bg_Entry")
        else
            CfUtils.PlayAnimation(self.Root, "OverseaManageCatballDrawEntryDialog_Idle")
            CfUtils.PlayAnimation(self.BgNode, "OverseaManageCatballDrawEntryDialog_Bg_Idle")
        end
        self:FreshUI(true)
        KTool.SetActive(self.redPoint.gameObject, CatBallUtils.GetGoodsTipsRedPointNum())

    -- end))
    -- return coWait
end


function CatBallDrawEntryDialog:OnHide()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        if isNotNull(self._drawScene) then
            KTool.SafeDelete(self._drawScene)
        end

        ---离开列表 清理NewFlag
        ---@type CatEggComponent
        local catEggComponent    = GameUtils.GetEntityCompByType(ECSComponentType.Constants.CatEggComponent)
        catEggComponent:ClearCatBallNewFlag()
        
    end))
    return coWait
end


function CatBallDrawEntryDialog:OnFinalize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        
        if self.__EventRequestComplete then
            Events.RemoveListener(RequestComplete, self.__EventRequestComplete)
            self.__EventRequestComplete = nil
        end
        self.controller = nil --删除lua层引⽤用到的c#对象
        self:Delete()
        self = nil
    end))
    return coWait
end


--region init 

function CatBallDrawEntryDialog:OnInit()
    self:RequestHome()
    self:InitData()
    self:InitAction()
    self:InitNodeConfig()
    self:InitToggleList()

    -- Events.Broadcast(Constants.EventNames.UIMainHomeSceneFocusShowEventName, false)
    -- Events.Broadcast(Constants.EventNames.MainHomeRoleActive, { isShow = false })
end

function CatBallDrawEntryDialog:RequestHome()
    GameUtils.Request(Interfaces.OverseaCatBallHome, {}, function(request, response)
        if checkNumber(response.errCode) == 0 then
            local data = checkTable(response.data)
            self:InitPoolData(data.catPools)
            self._activityData = checkTable(data.activity)
            self._isFinishRequest = true

            ---如果收到消息后，界面已经onshow，则这里应该负责刷新右边panel
            if self._isShowDialog then
                self:FreshRightPanel()
            end
        end
    end)
end

function CatBallDrawEntryDialog:InitData()
    self:InitParameters()
    self:InitCurrency()
    self:InitCatBallEntityList()
    self:InitToggleData()
    
end

function CatBallDrawEntryDialog:InitParameters()
    local parameters = self.controller.Argument.parameters
    local isFromHome = parameters.isFromHome
    if isFromHome then
        parameters.isFromHome = false
        KCookie.Set(StoreKey)
    end
    self._listType = parameters.listType or ListType.All
    self._isDisableEnter = not isFromHome
    -- parameters.isDisableEnter = false

    
end

function CatBallDrawEntryDialog:InitCurrency()
    local t = {
        ---养成列表显示的抽卡券
        checkNumber(CatBallUtils.GetCatBallParams(5)),
        ---养成列表显示的猫眼石
        -- checkNumber(CatBallUtils.GetCatBallParams(6)),
    }
    self._currency = t
end

function CatBallDrawEntryDialog:InitCatBallEntityList()
    local catBallEntityList  = {}
    local tInsert            = table.insert
    ---@type CatEggComponent
    local catEggComponent    = GameUtils.GetEntityCompByType(ECSComponentType.Constants.CatEggComponent)
    ---@type table<number, CatEggDojo>
    local goodsId2Dojo       = catEggComponent:GetCatId2Dojo()
    for goodsId, dojo in pairs(goodsId2Dojo) do
        local entity = CatBallUtils.GeneratedCatBallEntity(dojo)
        tInsert(catBallEntityList, entity)
    end
    
    local catId2FragmentEntity = {}
    local convertBackpack = catEggComponent:GetConvertBackpack()
    for goodsId, goodsNum in pairs(convertBackpack) do
        ---@type CatBallGoodsVo
        local goodsVo = GoodsConfMgr:GetInstance():GetGoodsVoById(goodsId)
        local catId = goodsVo.cardId
        if not goodsId2Dojo[catId] then
            goodsNum = checkNumber(goodsNum)
            if goodsNum > 0 then
                local entity = CatBallUtils.GeneratedCatBallGoodsEntity(goodsId, goodsNum, goodsVo)
                catId2FragmentEntity[catId] = entity
                tInsert(catBallEntityList, entity)
                
            end
        end
    end
    
    self._originCatBallEntityList = catBallEntityList
    self._catId2FragmentEntity = catId2FragmentEntity

end

function CatBallDrawEntryDialog:InitListDatByType(data)
    local listType = self._listType
    local dataList = {}
    for index, value in ipairs(data or self._originCatBallEntityList) do
        ---@type CatBallVo
        local vo = value.vo
        local tempListType = CallBallType2ListType[vo.types]
        if listType == ListType.All or tempListType == listType then
            table.insert(dataList, value)
        end
    end
    self._catBallEntityList = dataList
end

function CatBallDrawEntryDialog:InitNodeConfig()
    local nodeConfig = {
    --       道具消耗图标                道具消耗数量                       抽卡次数文本
        [DrawType.One] = {self.BtnConsumePopOneImage,   self.BtnConsumePopOneText,   self.BtnConsumePopOneChargeText},
        [DrawType.Multi] = {self.BtnConsumePopMultiImage, self.BtnConsumePopMultiText, self.BtnConsumePopMultiChargeText},
    }
    local CfUtils = CfUtils
    for key, nodes in pairs(nodeConfig) do
        for key, node in pairs(nodes) do
            CfUtils.SetActive(node, false)
        end
    end
    
    self._nodeConfig = nodeConfig
end

function CatBallDrawEntryDialog:InitToggleData()
    local toggleData = {
        [ListType.All] = {
            text = localize("所有"),
            func = function()
                self._listType = ListType.All
                self:FreshListByListType()

            end
        },
        [ListType.Battle] = {
            text = localize("战斗"),
            func = function()
                self._listType = ListType.Battle
                self:FreshListByListType()

            end
        },
        [ListType.Operates] = {
            text = localize("经营"),
            func = function()
                self._listType = ListType.Operates
                self:FreshListByListType()

            end
        },
        
    }
    self._toggleData = toggleData

end

function CatBallDrawEntryDialog:InitAction()
    SetButtonAction(self.BtnTenNode, Bind(self, self.OnClickBtnTenNodeAction))
    SetButtonAction(self.BtnOneNode, Bind(self, self.OnClickBtnOneNodeAction))
    SetButtonAction(self.BtnConvert, Bind(self, self.OnClickBtnConvertAction))
    SetButtonAction(self.BtnDetails, Bind(self, self.OnClickBtnDetailsAction))
    SetButtonAction(self.BtnJump, Bind(self, self.OnClickBtnJumpActivityAction))

    self.__EventRequestComplete = Events.AddListener(RequestComplete, Bind(self, self.OnEventRequestComplete))

end

function CatBallDrawEntryDialog:InitToggleList()
    ---@type CommonTabToggleUp
    local env = self:GetToggleListEnv()
    if isNull(env) then return end
    env:FillToggles(self._toggleData, self._listType)

end

function CatBallDrawEntryDialog:InitPoolData(catPools)
    self._catPools   = catPools
    local pool       = table.takeFirst(self._catPools)
    if pool == nil then return end
    local dataConfig = {
        --  道具消耗             道具其他消耗        抽卡次数   
        [DrawType.One] = {pool.oneConsume,   pool.oneConsumeOther,   1},
        [DrawType.Multi] = {pool.multiConsume, pool.multiConsumeOther, 5},
    }
    
    self._poolId     = pool.poolId
    self._dataConfig = dataConfig
end

--endregion 


--region logic 

function CatBallDrawEntryDialog:FreshUI(isInit)
    self:FreshCommonFilterNode(isInit)

    ---如果未收到消息，先不刷新右边panel
    if self._isFinishRequest then 
        self:FreshRightPanel()
    end 
end


function CatBallDrawEntryDialog:FreshCommonFilterNode(isInit)
    ---@type UICommonFilterMB
    local filterNodeEnv = self:GetFilterNodeEnv()
    if isNull(filterNodeEnv) then return end
    filterNodeEnv:SetCallback(self._originCatBallEntityList, function(data)
        self._catBallEntityList = data
        self._listType = ListType.All
        --- 切换标签到全部
        self:FreshToggleListSelectState(1)
        self:FreshList()

    end, SortType)
    filterNodeEnv:SetStyleType(2)
    filterNodeEnv:SetFilterClass(FilterClass)
    filterNodeEnv:RestoreState(StoreKey, function(data)
        if isInit and self._listType ~= ListType.All then
            self:FreshListByListType(data)
        else
            self._catBallEntityList = data
            self:FreshList()
        end

    end)
end

---StoreFilterState
---记录筛选状态
function CatBallDrawEntryDialog:StoreFilterState()
    self.controller.Argument.parameters.listType = self._listType
    ---@type UICommonFilterMB
    local filterNodeEnv = self:GetFilterNodeEnv()
    if isNull(filterNodeEnv) then return end
    return filterNodeEnv:SaveState(StoreKey)
end

function CatBallDrawEntryDialog:FreshList()
    local count      = #self._catBallEntityList
    local isShowList = count > 0
    local ScrollView = self.ScrollView

    KTool.SetActive(ScrollView.gameObject, isShowList)
    KTool.SetActive(self.EmptyNode.gameObject, not isShowList)

    if not isShowList then
        return
    end
    if self._isInitList then
        GameUtils.ReloadData(ScrollView, count, true)
        -- ScrollView:MovePanelToItemIndex(0)
        
    else
        self._isInitList = true
        ScrollView:InitListView(count, Bind(self, self.OnGetItemByIndex))
    end
end


function CatBallDrawEntryDialog:OnGetItemByIndex(cell, idx)
    if idx < 0 then return nil end

    ---@type CatBallDrawEntryCell
    local nodeEnv = CfUtils.GetLuaScr(cell, CellEnvPath)
    if isNull(nodeEnv) then
        return nil
    end

    local index = idx + 1
    ---@type CatBallEntity
    local catBallEntity = self._catBallEntityList[index]
    nodeEnv:FreshUI(catBallEntity, Bind(self, self.OnClickCellAction))
    nodeEnv:FreshRedPoint(self:GetRedPointByEntity(catBallEntity))
    return cell

end

function CatBallDrawEntryDialog:FreshListByListType(data)
    self:InitListDatByType(data)

    --- 清空通用筛选里的选项
    self:ClearFilterNodeGroup()

    self:FreshList()
end

function CatBallDrawEntryDialog:ClearFilterNodeGroup()
    ---@type UICommonFilterMB
    local env = self:GetFilterNodeEnv()
    if isNull(env) then return end
    env:SetDefGroups({})

end

function CatBallDrawEntryDialog:FreshToggleListSelectState(selectIndex)
    ---@type CommonTabToggleUp
    local env = self:GetToggleListEnv()
    if isNull(env) then return end
    env:SetSelectState(selectIndex)

end

function CatBallDrawEntryDialog:FreshRightPanel()
    if not self._dataConfig then
        return
    end

    for index, value in pairs(self._dataConfig) do
        local consume, consumeOther, times = SafeUnpack(value)
        local goodsIcon, consumeText, chargeText = SafeUnpack(self._nodeConfig[index])
        CfUtils.SetActive(goodsIcon, true)
        CfUtils.SetActive(consumeText, true)
        CfUtils.SetActive(chargeText, true)
        local num     = checkNumber(consume.num)
        local goodsId = consume.goodsId
        local havNo   = GoodsUtils.GetThingNo(goodsId)
        local status
        if havNo < num then
            if consumeOther then
                goodsId = checkNumber(consumeOther.goodsId)
                num     = checkNumber(consumeOther.num)
                status  = (goodsId == 0 or GoodsUtils.GetThingNo(goodsId) < num) and 3 or 1
            else
                status = 3
            end
            
        else
            ---第一种道具充足
            status = 1

        end

        local goodsVo = GoodsConfMgr:GetInstance():GetGoodsVoById(goodsId)
        goodsIcon:LoadSprite(goodsVo.photoPath)
        consumeText.text = num
        consumeText.Status = status
        chargeText.text = localize("召唤_num_次", {_num_ = times})

    end

    -- 是否有猫球活动
    local activityData = checkTable(self._activityData)
    local catBallId    = checkInt(self._activityData.catBallId)
    CfUtils.SetActive(self.BtnJump, catBallId > 0)
    if catBallId > 0 then
        local catBallVo = CatBallUtils.GetCatBallVo(catBallId)
        CfUtils.FillImage(self.BtnJumpImgIcon, catBallVo.picture)
        
        local hasRedPoint = checkInt(self._activityData.redDotHint) == 0
        CfUtils.SetActive(self.BtnJumpRedPoint, hasRedPoint)
    end
end

---CheckDrawCat
---检查能否抽猫
---@param drawType number 抽卡类型
function CatBallDrawEntryDialog:CheckDrawCat(drawType)
    if not self._isFinishRequest then
        return
    end
    local config   = self._dataConfig[drawType]
    local consume, consumeOther = SafeUnpack(config)
    local goodsId = consume.goodsId
    local num     = checkNumber(consume.num)
    local havNo   = GoodsUtils.GetThingNo(goodsId)
    if havNo < num then
        if consumeOther then
            goodsId = consumeOther.goodsId
            num = checkNumber(consumeOther.num)
            havNo = GoodsUtils.GetThingNo(goodsId)
        end
        if havNo < num then
            local vo = GoodsConfMgr:GetInstance():GetGoodsVoById(goodsId)
            if #checkTable(vo.jumpAway) > 0 then
                GoodsUtils.ShowCommonLackMaterialDialog({{goodsId = goodsId, num = num, gainNum = num - havNo}})
            else
                GameUtils.Toast(localize('当前所需的_name_不足，不能抽猫球', { _name_ = vo.name }))
            end
            return
        else
            self:OnDrawCatsAction(self._poolId, drawType, goodsId, num)
        end
    else
        self:OnDrawCatsAction(self._poolId, drawType, goodsId, num)
    end
end

---OnDrawCatsAction
---@param poolId number
---@param type number
function CatBallDrawEntryDialog:OnDrawCatsAction(poolId, type, goodsId, num)
    CfUtils.SetTopActive(false)
    CfUtils.StartCoroutineWithBlocker(function() 
        return CoStart(function() 
            local CoYield = CoYield
            self:LoadDrawScene()
            self:RequestCatBallCall(poolId, type, goodsId)
            while self._responseData == nil do
                CoYield()
            end
            ---处理数据
            local rewards, isChangeList = self:HandleDrawCatBallData(goodsId, num)
            
            KTool.SetActive(self.redPoint.gameObject, CatBallUtils.GetGoodsTipsRedPointNum())
            
            while isNull(self._drawScene) do
                CoYield()
            end

            CriWareUtils.PlaySe(UISheets.SFX_UI_CAT.path, UISheets.SFX_UI_CAT.sfx_ui_cat_gachapon)

            self:HandleDrawCatBallAni(rewards)
    
            CfUtils.SetTopActive(true)
            --- 更新猫列表节点
            self:ReloadListByFilterNode()
            
            self._activityData = checkTable(self._responseData.activity)
            self:FreshRightPanel()
            -- if isChangeList then
            -- end
    
            ---播放交互动画
            self._responseData = nil
        end)
    end)

end

function CatBallDrawEntryDialog:LoadDrawScene()
    if isNotNull(self._drawScene) then
        return
    end
    return CoStart(function() 
        self._drawScene = GameUtils.LoadBundleAsync(DrawScenePath)
        KTool.SetActive(self._drawScene, false)
    end)
end

function CatBallDrawEntryDialog:RequestCatBallCall(poolId, type, goodsId)
    GameUtils.Request(Interfaces.OverseaCatBallCall, { poolId = poolId, type = type, consumeId = goodsId }, function(request, response)
        if checkNumber(response.errCode) == 0 then
            local data = checkTable(response.data)
            self._responseData = data
        end
    end)
end


function CatBallDrawEntryDialog:HandleDrawCatBallData(goodsId, num)
    local goods = {{ goodsId = goodsId, num = -num }} ---goods
    local data = self._responseData
    ----先加入数据
    ---@type CatEggComponent
    local eggComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.CatEggComponent)
    local rewards = {}
    local isChangeList = false
    for i, v in pairs(data.catBalls) do
        ---@type CatEggDojo
        local dojo = CatEggDojo.New()
        dojo:FillData(v)
        if v.convertGoods == nil then
            eggComponent:DrawCatDrawReward(dojo)
            -- dojo.isNew = true
            ---@type CatBallEntity
            local entity = CatBallUtils.GeneratedCatBallEntity(dojo)
            entity.isNew = true
            table.insert(rewards, entity)

            ---@type CatBallEntity
            local fragmentEntity = self._catId2FragmentEntity[dojo.catId]
            if fragmentEntity then
                fragmentEntity:CompositeFragment(dojo)
                self._catId2FragmentEntity[dojo.catId] = nil
            else
                table.insert(self._originCatBallEntityList, entity)
            end

            isChangeList = true

        else
            local convertGoods                     = v.convertGoods
            local convertGoodsId,  convertGoodsNum = checkNumber(convertGoods.goodsId), checkNumber(convertGoods.num)
            ---@type CatBallEntity
            local entity = CatBallUtils.GeneratedCatBallGoodsEntity(convertGoodsId,  convertGoodsNum)
            local goodsId = entity.goodsId
            table.insert(rewards, entity)
            table.insert(goods, {
                goodsId = convertGoodsId,
                num     = convertGoodsNum,
            })

            ---@type CatBallEntity
            local entity = self._catId2FragmentEntity[goodsId]
            if entity then
                entity:UpdateFragmentNum(convertGoodsNum)
                isChangeList = true
            
            end
            
        end
    end
    
    GoodsUtils.DrawRewards(goods, true)
    --- 处理 红点
    for key, value in pairs(self._playerCatId2RedPoint) do
        if value ~= true then
            self._playerCatId2RedPoint[key] = nil
        end
    end

    return rewards, isChangeList
end

function CatBallDrawEntryDialog:HandleDrawCatBallAni(rewards)
    --- 开启物理
    Physics.autoSimulation = true
    KTool.SetActive(self._drawScene, true)
    
    self.controller.CacheCanvas.enabled = false
    local camera = self._drawScene.transform:Find("Main Camera")
    --- 等待相机动画播放完成
    if isNotNull(camera) then
        local cameraComp = camera:GetComponentInChildren(typeof(CS.UnityEngine.Camera))
        local URPCameraController      = CS.Game.Native.URP.URPCameraController
        URPCameraController.Instance:InitCameraStack(cameraComp)
        ---@type UnityEngine.Animator
        local animatorComp = camera.gameObject:GetComponent(AnimatorType)
        cs_coroutine.yield_return(animatorComp:WaitUntilAniCompleted()) 
    end
    local parameters = self.controller.Argument.parameters
    parameters.isDisableEnter = true

    --- 弹出结果界面
    local parameters = {rewards = rewards, rewardShowType = Constants.RewardShowType.CatBallNode}
    cs_coroutine.yield_return(CfUtils.DialogOpen(Constants.UITypeIds.CatBallDrawResultDialog, parameters, nil, true))
    self.controller.CacheCanvas.enabled = true
    KTool.SetActive(self._drawScene, false)
    Physics.autoSimulation = false
    -- CoYield(2)
    -- CfUtils.DialogClose(Constants.UITypeIds.CatBallDrawResultDialog)
    --- 关闭物理
    --- 弹出通用奖励界面
    -- CfUtils.DialogOpen(Constants.UITypeIds.UICommonRewardPop, parameters, nil, true)

end


function CatBallDrawEntryDialog:ReloadListByFilterNode()
    ---@type UICommonFilterMB
    local env = self:GetFilterNodeEnv()
    if isNull(env) then return end
    env:RefreshUI()

end

---RequestComposite
---@param catBallEntity CatBallEntity
function CatBallDrawEntryDialog:RequestComposite(catBallEntity, env)
    GameUtils.Request(Interfaces.OverseaCatBallComposite, { catBallId = catBallEntity.goodsId }, function(request, response)
        if checkNumber(response.errCode) ~= 0 then return end

        local responseData = checkTable(response.data)
        self:HandelRequestCompose(responseData, catBallEntity, env)
        -- local catBall = data.catBall
        -- ---@type CatEggComponent
        -- local eggComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.CatEggComponent)
        -- ---@type CatEggDojo
        -- local dojo = CatBallUtils.GeneratedCatEggDojo(catBall)
        -- eggComponent:DrawCatDrawReward(dojo)

        -- catBallEntity:CompositeFragment(dojo)

        -- if isNotNull(env) then
        --     env:FreshUI(catBallEntity, Bind(self, self.OnClickCellAction))
        -- end

    end)

end

---HandelRequestCompose
---@param responseData table
---@param catBallEntity CatBallEntity
---@param env CatBallDrawEntryCell
function CatBallDrawEntryDialog:HandelRequestCompose(responseData, catBallEntity, env)
    -- local str = [[{"data":{"catBalls":[{"id":11,"catBallId":104006,"star":0,"convertGoods":{"goodsId":670104006,"num":18}}],"questGradeTaskProgress":[]},"timestamp":1691462046,"errCode":0,"errMsg":""}]]
    local catBall = responseData.catBall
    ---@type CatEggComponent
    local eggComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.CatEggComponent)
    ---@type CatEggDojo
    local dojo = CatBallUtils.GeneratedCatEggDojo(catBall)
    eggComponent:DrawCatDrawReward(dojo)

    GoodsUtils.DrawRewards({{goodsId = catBallEntity.goodsVo.id, num = -catBallEntity.needNum}})

    catBallEntity:CompositeFragment(dojo)

    env:FreshRedPoint(self:GetRedPointByEntity(catBallEntity))

    if isNotNull(env) then
        env:FreshUI(catBallEntity, Bind(self, self.OnClickCellAction))
        env:PlayAnimationCompose()
    end
end



--endregion 


--region get/set 

---GetFilterNodeEnv
---@return UICommonFilterMB
function CatBallDrawEntryDialog:GetFilterNodeEnv()
    if isNull(self._filterNodeEnv) then
        self._filterNodeEnv = CfUtils.GetLuaScr(self.CommonFilterNode.gameObject, UICommonFilterMBEnvPath)
    end
    return self._filterNodeEnv
end

---GetToggleListEnv
---@return CommonTabToggleUp
function CatBallDrawEntryDialog:GetToggleListEnv()
    if isNull(self._toggleListEnv) then
        ---@type CommonTabToggleUp
        self._toggleListEnv = CfUtils.GetLuaScr(self.CommonTabToggleUp.gameObject, CommonTabToggleUpEnvPath)
    end
    return self._toggleListEnv
end

---GetRedPointByEntity
---@param dojo CatBallEntity
function CatBallDrawEntryDialog:GetRedPointByEntity(catBallEntity)
    if catBallEntity.dojo == nil then
        return false
    end
    local id = catBallEntity.dojo.id
    if self._playerCatId2RedPoint[id] == nil then
        self._playerCatId2RedPoint[id] = CatBallUtils.GetRedPointShowState(catBallEntity)
    end
    return self._playerCatId2RedPoint[id]
end

---endregion 


--region handler 

function CatBallDrawEntryDialog:OnClickBtnOneNodeAction()
    self:CheckDrawCat(DrawType.One)
end

function CatBallDrawEntryDialog:OnClickBtnTenNodeAction()
    self:CheckDrawCat(DrawType.Multi)
end

function CatBallDrawEntryDialog:OnClickBtnConvertAction()
    self:StoreFilterState()
    CfUtils.DialogOpen(Constants.UITypeIds.CatBallExchangePopup, nil, nil, true)
end

function CatBallDrawEntryDialog:OnClickBtnDetailsAction()
    if not self._isFinishRequest then
        return
    end
    CfUtils.DialogOpen(Constants.UITypeIds.CatBallDrawMember, {pool = table.takeFirst(self._catPools)}, nil, true)
end

function CatBallDrawEntryDialog:OnClickBtnJumpActivityAction()
    if not self._isFinishRequest then
        return
    end

    local activityUuid  = checkInt(self._activityData.activityUuid)
    local ActivityUtils = import('Game.Activity.ActivityUtils')
    ActivityUtils.OpenActivityView(activityUuid, CfUtils.DialogGetAllArgs())
end

---OnClickCellAction
---@param catBallEntity CatBallEntity
---@param env CatBallDrawEntryCell
function CatBallDrawEntryDialog:OnClickCellAction(catBallEntity, env)
    if catBallEntity.isFragment then
        if catBallEntity.isCanMerge then
            self:RequestComposite(catBallEntity, env)
        else
            GameUtils.Toast(localize("请先收集基因合成猫球"))    
        end
    else

        local ids = {}
        ---@type CatBallEntity[]
        local catBallEntityList = self._catBallEntityList
        for index, value in ipairs(catBallEntityList) do
            if not value.isFragment then
                table.insert(ids, value.dojo.id)
            end
        end

        self:StoreFilterState()
        local playerCatId = catBallEntity.dojo.id
        
        CfUtils.DialogOpen(Constants.UITypeIds.CatBallCultivateDialog, {playerCatId = playerCatId, ids = ids}, {UIArgs(Constants.UITypeIds.CatBallDrawEntryDialog)}, true)
    end
end

function CatBallDrawEntryDialog:OnEventRequestComplete()
    self._isReload = true
    
end

---endregion 


return CatBallDrawEntryDialog
