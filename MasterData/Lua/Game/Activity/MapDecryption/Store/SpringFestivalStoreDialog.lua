---
--- Created by Eric.
--- DateTime: 2022/11/21 16:44
---

------------ import ------------
local util = require 'XLua.util'
local CoWait = CS.Engine.Lib.CoWait
local UIEventProxy = CS.Engine.UI.UIEventProxy
local KTool = CS.Engine.Lib.KTool
local UIModule = CS.Engine.UI.UIModule
local cs_coroutine = require 'XLua.cs_coroutine'
local ResourceModule = CS.Engine.Modules.ResourceModule
local Animator = CS.UnityEngine.Animator
local GameObject          = CS.UnityEngine.GameObject
local ActivityConstants = import("Game.Activity.ActivityConstants")
local StoreChestDojo = import('Game.Dojo.StoreChestDojo')
local StoreConstants = import('Game.UI.Store.StoreConstants')
local StoreUtils = import('Game.UI.Store.StoreUtils')
local TimerModule = CS.Engine.Modules.TimerModule
local CriWareUtils     =  import('Game.Entry.CriWareUtilsFix')
local LookAtControllerType = typeof(CS.RootMotion.FinalIK.LookAtController)
local LookAtIKType         = typeof(CS.RootMotion.FinalIK.LookAtIK)
local CinemachineVirtualCamera = CS.Cinemachine.CinemachineVirtualCamera
local Quaternion            = CS.UnityEngine.Quaternion
------------ import ------------

------------ define ------------

local RefreshSecond = 60

------------ define ------------



--- from: Assets/BundleResources/Prefabs/SpringFestival121401/SpringFestivalStoreDialog.prefab
---@class SpringFestivalStoreDialog
---@field Env                           	SpringFestivalStoreDialog
---@field controller                    	Engine.Modules.LuaBehaviour | Engine.UI.UILuaDialog
---@field ScrollView                    	SuperScrollView.LoopGridView
local SpringFestivalStoreDialog = Class("SpringFestivalStoreDialog")
function SpringFestivalStoreDialog:__init()
    self.ActivityStoreData = {}
    self.npcId = nil
    self.currencyList = {}
    
end

function SpringFestivalStoreDialog:__delete()
    self.ActivityStoreData = nil
    self.npcId = nil
    self.currencyList = nil

    self.controller = nil
end

function SpringFestivalStoreDialog:Awake()


end

function SpringFestivalStoreDialog:OnFocus(focus)
end

function SpringFestivalStoreDialog:FreshCurrency()
    CfUtils.RefreshTopGoods(self.currencyList)
end


function SpringFestivalStoreDialog:OnInitialize()
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        
        
    end))
    return coWait
end

function SpringFestivalStoreDialog:OnShow()
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        print("parameters----->>"..table.dump(self.controller.Argument.parameters, nil, 3))
        self.npcId = self.controller.Argument.parameters.dialogueData.npcId
        self:SetLines(MapDecryptionConstants.TalkSceneType.EnterStore)
        self.virtualCamera = MapDecryptionMgr:GetTargetVirtualCamera(MapDecryptionConstants.SceneDefine.StoreCamera)
        self._StoreCameraComp = KTool.GetComponent(self.virtualCamera.gameObject, typeof(CinemachineVirtualCamera))
        assert( not isNull(self._StoreCameraComp) )

        self._PrefixStoreCameraTF = MapDecryptionMgr:GetTargetVirtualCamera(MapDecryptionConstants.SceneDefine.PrefixStoreCamera)
        self._PrefixStoreCameraComp = KTool.GetComponent(self._PrefixStoreCameraTF.gameObject, typeof(CinemachineVirtualCamera))
        assert( not isNull(self._PrefixStoreCameraComp) )

        self.playerNode = MapDecryptionMgr:GetTargetPlayer(MapDecryptionConstants.SceneDefine.HumanPlayer)
        self.npcNode = MapDecryptionMgr:GetTargetPlayer(MapDecryptionConstants.SceneDefine.NonPlayerCharacters).transform:Find(MapDecryptionConstants.SceneDefine.NpcRoot..self.npcId..'/'..MapDecryptionConstants.SceneDefine.NpcName)
        self:SetVirtualCamera(true)
        self.activityUuid = MapDecryptionMgr:GetActivityUUId()
        self.activityType = ActivityConstants.ActivityType.MapDecryption
        GameUtils.Request(
                Interfaces.StoreActivityHome,
                {activityUuid = self.activityUuid, activityType = self.activityType},
                function(request, response)
                    if checkInt(response.errCode) == 0 then
                        self.ActivityStoreData = self:ConvertActivityStoreData(response.data)
                        self:GetStoreData()
                        --self:CalcRefreshTime()
                        --self:StartActivityTimer()
                        self:InitCurrencyList()

                        print("data---->>"..table.dump(response.data, nil, 3))
                        
                        self:FreshBaseUI()
                    end
                end
        )
    end))
    return coWait
end

function SpringFestivalStoreDialog:InitCurrencyList()
    self.currencyList = {}
    for i, v in pairs(self.ShownData.products) do
        local isFree = StoreUtils.ProductIsFree(v)
        if not isFree then
            if v.prices[1] and table.keyof(self.currencyList, v.prices[1].currency)==nil then
                table.insert(self.currencyList, v.prices[1].currency)
            end
        end
    end
end


function SpringFestivalStoreDialog:SetVirtualCamera(isActive)
    if isActive then
        --- 进入:
        MapDecryptionMgr.EnterVCameraWithPreAnim( self._PrefixStoreCameraTF, self._PrefixStoreCameraComp, self.virtualCamera, self._StoreCameraComp, 0.4,
            ---   
            function()
                KTool.SetActive(self.playerNode, not isActive)
                KTool.SetActive(self.virtualCamera, true)
                self.npcRotation = clone(self.npcNode.transform.localRotation)
                self.npcNode.transform.localRotation = Quaternion.Euler(0,0,0)
            end 
        )
    else
        --- 退出:
        MapDecryptionMgr:BlackEaseInAndOut(
            7.0, -- 变黑的速度
            4.0, -- 变淡的速度
            0.1, -- 黑色阶段的时长
            function() -- 进入黑色阶段后要调用的callback
                KTool.SetActive(self.playerNode, not isActive)
                KTool.SetActive(self.virtualCamera, false)
                self.npcNode.transform.localRotation = self.npcRotation
            end
        )
    end
end

function SpringFestivalStoreDialog:SetLines(type)
    local talkVo = MapDecryptionUtils.RandomInteractionTalk(self.npcId, type)
    print("talkVo----->>"..table.dump(talkVo, nil, 3))
    Events.Broadcast(MapDecryptionConstants.EventNames.PlayModelAction, self.npcId, talkVo.action, talkVo.face)
    --local mainSceneInteractionVo = cf
    local voiceId = self.controller.Argument.parameters.dialogueData.vo.sex == 1 and talkVo.voicecode or talkVo.voicecodeLady
    if not string.isEmpty(voiceId) then
        CriWareUtils.PlayVoiceById(voiceId, self.playerNode)
    end
    CfUtils.FillText(self.TxtState, talkVo.text)
end

---转换活动商店数据
function SpringFestivalStoreDialog:ConvertActivityStoreData(requestData)
    local listData = {}
    local products = requestData.products
    for i = 1, #products do
        products[i].nextRefreshLeftSeconds = requestData.nextRefreshLeftSeconds
        products[i].rewards = {
            {num = products[i].num, goodsId = products[i].goodsId}
        }
        local dojo = StoreChestDojo.New()
        dojo:Fill(products[i])
        table.insert(listData, dojo)
        requestData.products = listData
        requestData.activityTimeLeft = checkInt(requestData.remainingTimes)
    end
    return requestData
end

function SpringFestivalStoreDialog:GetStoreData()
    local storeData = self.ActivityStoreData
    self:SortStoreData(storeData)
    self.ShownData = storeData
end

function SpringFestivalStoreDialog:SortStoreData(storeData)
    table.sort(storeData.products, function(a, b)
        local isSoldOutA = StoreUtils.ProductIsSoldOut(a)
        local isSoldOutB = StoreUtils.ProductIsSoldOut(b)
        if isSoldOutA ~= isSoldOutB then
            return not isSoldOutA
        elseif a.activityUuid ~= b.activityUuid then
            return a.activityUuid > b.activityUuid
        elseif a.pos ~= b.pos then
            return a.pos < b.pos
        else
            return a.productId < b.productId
        end
    end)
end

function SpringFestivalStoreDialog:CalcRefreshTime()
    if self.ShownData.activityTimeLeft ~= -1 then
        self._trulyRefresh = math.min(RefreshSecond, self.ShownData.activityTimeLeft)
    else
        self._trulyRefresh = RefreshSecond
    end
end

---开启活动定时器
function SpringFestivalStoreDialog:StartActivityTimer()
    TimerModule.Instance:AddTimer("ActivityVarietyStore" .. self.activityUuid, 0, 1, Bind(self, self.OnTimeTick))
end

function SpringFestivalStoreDialog:OnTimeTick()
    if self._secondCount == nil then
        self._secondCount = 0
    end
    self._secondCount = self._secondCount + 1
    if self._secondCount > self._trulyRefresh then
        self._secondCount = self._secondCount - self._trulyRefresh
        --重新计算下次刷新时间
        self:CalcRefreshTime()
        self:RefreshStoreTime()
        if self.activityUuid then
            if self.ShownData.activityTimeLeft == 0 then
                GameUtils.Toast(localize("活动已结束"))
                UIModule.BackDialog()
            end
        end

    end
end

function SpringFestivalStoreDialog:RefreshStoreTime()
    --if self.ShownData.nextRefreshLeftSeconds >= 0 then
    --    KTool.SetActive(self.RefreshTimer.gameObject, true)
    --    local timeStr = StoreUtils.FormatTime(self.ShownData.nextRefreshLeftSeconds, true)
    --    self.RefreshTimer.text = timeStr
    --elseif self.ShownData.activityTimeLeft >= 0 then
    --    KTool.SetActive(self.RefreshTimer.gameObject, true)
    --    local timeStr = StoreUtils.FormatTime(self.ShownData.activityTimeLeft, true)
    --    self.RefreshTimer.text = timeStr
    --else
    --    KTool.SetActive(self.RefreshTimer.gameObject, false)
    --end
end

function SpringFestivalStoreDialog:FreshBaseUI()
    local cnt = #self.ShownData.products
    if not self.ScrollView.IsListViewInit then
        self.ScrollView:InitGridView(cnt, Bind(self, self.OnGetItemByIndex))
    else
        GameUtils.ReloadData(self.ScrollView, cnt)
    end
    self:FreshCurrency()
end

function SpringFestivalStoreDialog:OnGetItemByIndex(listView, index)
    if index < 0 then
        return nil
    end
    local luaIndex = index + 1
    local cell = listView:NewListViewItem("Cell")
    local nodeEnv = CfUtils.GetLuaScr(cell.gameObject, "Game.Activity.MapDecryption.Store.SpringFestivalStoreDialogCell")
    if nodeEnv then
        local data = self.ShownData.products[luaIndex]
        local isSoldOut = StoreUtils.ProductIsSoldOut(data)
        nodeEnv:FreshBaseUI(data)
        nodeEnv:SetBtnCallBack(function()
            if isSoldOut then
                GameUtils.Toast(localize("商品已售罄"))
                return
            end
            local isFree = StoreUtils.ProductIsFree(data)
            if isFree then
                GameUtils.Request(
                        Interfaces.ActivityMapDecryptionRedPacketReceive,
                        {activityUuid = self.activityUuid},
                        function(request, response)
                            if checkInt(response.errCode) == 0 then
                                ---@type MapDecryptionComponent
                                local component = MapDecryptionMgr:GetComponent()
                                component:ClearStoreRedPoint()
                                GoodsUtils.DrawRewards(response.data.rewards)
                                self:RefreshActivityStock(data.productId, 1)
                                local vo = CfUtils.GetCfVo(AutoIds.IdSetting2816, "MapDecryptionRedPacketVo", response.data.redPacketId)
                                UIModule.OpenDialog({ id = Constants.UITypeIds.MapDecryptionRedBagDialog, parameters = { 
                                    data = vo, 
                                    cb = function()
                                        UIModule.OpenDialog({ id = Constants.UITypeIds.UICommonRewardPop, parameters = { rewards = response.data.rewards, cb = function() 
                                            self:SetLines(MapDecryptionConstants.TalkSceneType.BuyGoods)
                                        end } })
                                    end
                                } })
                            end
                        end
                )
            else
                UIModule.OpenDialog({ id = Constants.UITypeIds.UICommonBuyItemDialog, parameters = {
                    goodsId        = data.icon,
                    goodsNum       = data.num,
                    prices         = data.prices,
                    maxBuyNum      = data.currentStock,
                    remainTime     = data.refreshTime,
                    endTime        = self.ShownData.nextRefreshLeftSeconds,
                    buyCb          = function (price, buyNum)
                        if self.activityUuid then
                            self:ActivityStoreBuyHandler(data.productId, price, buyNum)
                            self:SetLines(MapDecryptionConstants.TalkSceneType.BuyGoods)
                        end
                    end
                }})
            end

        end)
    end
    return cell
end

---活动商店购买处理
function SpringFestivalStoreDialog:ActivityStoreBuyHandler(productId, price, buyNum)
    local requestData = {
        productId    = productId,
        num          = buyNum,
        currency     = price.currency,
        activityUuid = self.activityUuid,
        activityType = self.activityType
    }
    GameUtils.Request(Interfaces.StoreActivityBuy, requestData, function(request, response)
        if checkNumber(response.errCode) == 0 then
            local responseData = checkTable(response.data)
            if #responseData.rewards > 0 then
                local consume = {}

                table.insert(consume, { ["num"] = -price.current * buyNum;
                                        ["goodsId"] = price.currency; })
                GoodsUtils.DrawRewards(consume)
                GoodsUtils.DrawRewards(responseData.rewards)

                CriWareUtils.PlaySe(UISheets.UI_Menu.path, UISheets.UI_Menu.ui_shop_buy)

                self:RefreshActivityStock(productId, buyNum)

                UIModule.OpenDialog({ id = Constants.UITypeIds.UICommonRewardPop, parameters = { rewards = responseData.rewards } })
            end
        end
    end)
end

---刷新活动商店数据
function SpringFestivalStoreDialog:RefreshActivityStock(productId, buyNum)
    for i, v in ipairs(self.ShownData.products) do
        if checkInt(v.productId) == checkInt(productId) then
            if checkInt(v.stock) == -1 then
                break
            else
                v.currentStock = math.max(0, v.currentStock - buyNum)
            end
        end
    end
    self:FreshBaseUI()
end

function SpringFestivalStoreDialog:OnFinalize()
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        self:SetVirtualCamera(false)
        self.controller = nil --删除lua层引用到的c#对象 否则不会产生c# gc回收到对象
        self:Delete()
        self = nil --lua层的gc需要
    end))
    return coWait
end

return SpringFestivalStoreDialog